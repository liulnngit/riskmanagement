package com.jesse.demo;

import java.util.ArrayList;
import java.util.List;

public class RiskCheckClient {
	
	 public static void main(String[] args) {
	        //初始化规则列表
	        List<Rule> ruleList = new ArrayList<Rule>();
	        Rule rule1 = new Rule("001","同卡单笔最大交易金额","2","1");//规则类别2，风险级别1
	        Rule rule2 = new Rule("002","商家单笔最大交易金额","2","2");//规则类别2，风险级别2
	        Rule rule3 = new Rule("003","商家单笔最小交易金额","2","1");//规则类别2，风险级别1
	        Rule rule4 = new Rule("004","该卡号在黑名单中","1","3");//规则类别1，风险级别3
	        ruleList.add(rule1);
	        ruleList.add(rule2);
	        ruleList.add(rule3);
	        ruleList.add(rule4);
	        RiskCheckService riskCheckService = new RiskCheckService();
	        String orderInfoVo = "";
	        String response = riskCheckService.riskCheck(orderInfoVo, ruleList);
	        System.err.println(response);
	    }
}
