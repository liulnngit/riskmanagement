package com.jesse.demo;

/**
 * 规则类型
* @author ll
* @date 2018年10月26日 上午9:51:49
 */
public enum RuleTypeEnum {
    
    BEFORE("1","前置风控"),
    DURING("2","事中风控");
    
    private String type;
    private String desc;
    
    private RuleTypeEnum(String type, String desc) {
        this.type = type;
        this.desc = desc;
    }
    
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public String getDesc() {
        return desc;
    }
    public void setDesc(String desc) {
        this.desc = desc;
    }  
}