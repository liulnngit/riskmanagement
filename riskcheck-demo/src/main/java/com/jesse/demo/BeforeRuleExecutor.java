package com.jesse.demo;

/**
 * 前置风控执行
* @author ll
* @date 2018年10月26日 上午9:58:09
 */
public class BeforeRuleExecutor implements IRuleExecutor {

    @Override
    public boolean support(String ruleType) {
        return RuleTypeEnum.BEFORE.getType().equals(ruleType);
    }

    @Override
    public RiskResponse ruleExecute(String orderInfo,Rule rule) {
        System.out.println(rule.getRuleCode()+" 前置风控 go go");
        RiskResponse response = new RiskResponse();
        response.setRuleCode(rule.getRuleCode());
        response.setRemark(rule.getRuleName());
        response.setRiskLevel(rule.getRiskLevel());
        response.setHasRisk("1");
        return response;

    }

}