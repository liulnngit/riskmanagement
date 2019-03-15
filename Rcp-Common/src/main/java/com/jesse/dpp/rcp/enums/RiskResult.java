package com.jesse.dpp.rcp.enums;

public enum RiskResult {
	ACCEPT("ACCEPT","通过"),
	REJECT("REJECT","拒绝"),
	REVIEW("REVIEW","人工审核"),
	;
	private String code;
	private String msg;
	
	private RiskResult(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	public String getCode() {
		return code;
	}
	public String getMsg() {
		return msg;
	}
	
}
