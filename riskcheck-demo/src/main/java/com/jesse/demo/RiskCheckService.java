package com.jesse.demo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * 规则引擎的整体简单逻辑：
 *  接收到当前订单信息，和需要执行的规则信息，根据规则类型的不同，走不同的规则类别执行通道
 *  使用多线程，执行完成之后获取风险级别最高的进行返回
 *  这里根据规则的不同走不同的规则通道，使用了简单工厂模式，如果有多种会增加很多if-else判断
 *  最好使用工厂方法模式，可以将规则通道写好通过ApplicationContextAware进行加载，然后匹配
 *  自动找对应的通道，这里不需要修改原代码，增加新的规则执行通道而已
 */
public class RiskCheckService {
    
    public static final int threadNum = 12;
    
    public ExecutorService pool;
    
    /**
     * 风险检查
     * orderInfoVo  订单信息Vo
     * ruleListJson 规则列表json 
     */
    public String riskCheck(String orderInfoVo,List<Rule> ruleList){
        try {
            if (pool == null) {
                pool = Executors.newFixedThreadPool(threadNum);
            }
            long start = System.currentTimeMillis();
            String response = RuleEngineExecutor.execute(orderInfoVo, ruleList, pool);
            System.out.println("执行规则耗时:"+(System.currentTimeMillis() - start));
            return response;
        } finally {
            pool.shutdown();
        }
    }
    
   
}

//规则执行器
class RuleEngineExecutor{
    
    public static String execute(String orderInfoVo,List<Rule> ruleList,ExecutorService pool){
        
         //初始化返回
        RiskResponse defaultResponse = getDefaultResponse();
        
        if(ruleList!=null&&ruleList.size()>0){
            //结果集处理 Response
            List results = new ArrayList<RiskResponse>();
            //规则列表的个数
            CountDownLatch cdl = new CountDownLatch(ruleList.size());
            IRuleExecutor ruleExecutor = null;
            for (Rule rule : ruleList) {
                String ruleType = rule.getRuleType();
                //简单工厂模式
                if(ruleType.equals(RuleTypeEnum.BEFORE.getType())){
                      ruleExecutor = new BeforeRuleExecutor();
                }else if(ruleType.equals(RuleTypeEnum.DURING.getType())){
                      ruleExecutor = new DuringRuleExecutor();
                }
                String threadName = "rule-"+rule.getRuleCode();
                RuleEngineThread ruleEngine = new RuleEngineThread(orderInfoVo,rule,results,threadName,cdl,ruleExecutor);
                pool.execute(ruleEngine);
            }
            
            //等待全部线程执行完成
            try {
                cdl.await(200,TimeUnit.MILLISECONDS);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            
            //对结果集做处理
            if(results.size()>0){
                System.out.println("发生风控条数:"+results.size());
                System.out.println(results.toString());
                if(results.size()>1){
                    Collections.sort(results);
                }
                //排序，取风险最高返回
                return results.get(0).toString();
            }
            
        }else{
            System.out.println("没有规则要执行");
        }
        return defaultResponse.toString();
    }
    
    public static RiskResponse getDefaultResponse(){
        RiskResponse response = new RiskResponse();
        response.setRemark("正常");
        response.setHasRisk("0");
        return response;
    }
    
}

//worker 规则执行者
class RuleEngineThread implements Runnable{
    
    private String orderInfoVo;
    private Rule rule;
    private List<RiskResponse> results;
    private String threadName;
    private CountDownLatch cdl;
    private IRuleExecutor ruleExecutor;
    
    public RuleEngineThread(String orderInfoVo, Rule rule, List<RiskResponse> results, String threadName,CountDownLatch cdl,IRuleExecutor ruleExecutor) {
        super();
        this.orderInfoVo = orderInfoVo;
        this.rule = rule;
        this.results = results;
        this.threadName = threadName;
        this.cdl = cdl;
        this.ruleExecutor = ruleExecutor;
    }

    @Override
    public void run() {
        //System.out.println(threadName);
        RiskResponse response = ruleExecutor.ruleExecute(orderInfoVo,rule);
        //有风险将其放到放回结果集中
        if("1".equals(response.getHasRisk())){
            results.add(response);
        }
        cdl.countDown();
    }
    
}