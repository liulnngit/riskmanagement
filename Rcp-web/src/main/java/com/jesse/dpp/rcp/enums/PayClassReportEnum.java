package com.jesse.dpp.rcp.enums;

public enum PayClassReportEnum {

	HOUR("hour", "一小时"),
	MIN30("30min", "30分钟"),
	MIN1("min", "1分钟");
	
    private String code;
    private String desc;
     
    private PayClassReportEnum(String code , String desc ){
        this.code = code;
        this.desc = desc;
    }

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}
}
