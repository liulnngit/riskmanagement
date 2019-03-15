package com.jesse.dpp.rcp.enums;

/**
 * 风控场景
 * 
 * @author llg
 * 
 */
public enum RiskSceneEnum {
	LOGIN("login", "登录"),
	REG("reg", "注册"),

	;

	
	private String name;
	private String desc;

	RiskSceneEnum(String name, String desc) {
		this.name = name;
		this.desc = desc;
	}

	public String getName() {
		return name;
	}

	public String getDesc() {
		return desc;
	}

}
