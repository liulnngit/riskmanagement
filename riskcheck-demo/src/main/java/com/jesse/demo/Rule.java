package com.jesse.demo;

/**
 * 规则
* @author ll
* @date 2018年10月25日 下午6:34:14
 */
public class Rule {
    
    //规则编码
    private String ruleCode;
    //规则名称
    private String ruleName;
    //规则类型
    private String ruleType;
    //风险级别
    private String riskLevel;
    
    public Rule(String ruleCode, String ruleName, String ruleType, String riskLevel) {
        super();
        this.ruleCode = ruleCode;
        this.ruleName = ruleName;
        this.ruleType = ruleType;
        this.riskLevel = riskLevel;
    }

    public String getRuleCode() {
        return ruleCode;
    }

    public void setRuleCode(String ruleCode) {
        this.ruleCode = ruleCode;
    }

    public String getRuleName() {
        return ruleName;
    }

    public void setRuleName(String ruleName) {
        this.ruleName = ruleName;
    }

    public String getRuleType() {
        return ruleType;
    }

    public void setRuleType(String ruleType) {
        this.ruleType = ruleType;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }
    
}