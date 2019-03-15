package com.jesse.dpp.rcp.enums;

public enum RiskCheckType {
	CyberSource("Cybersouce","第三方Cybersouce风控"),
//	jesse_BIGDATA_RISK("jesse_BIGDATA_RISK","智付大数据风控"),
	;
	private String code;
	private String msg;
	
	private RiskCheckType(String code, String msg) {
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
