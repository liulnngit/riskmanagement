package com.jesse.demo;

/**
 * 根据不同的规则类型，走不同的规则执行执行器
* @author ll
* @date 2018年10月26日 上午9:43:49
 */
public interface IRuleExecutor {
     
     boolean support(String ruleType);
     
     RiskResponse ruleExecute(String orderInfo,Rule rule);
     
}