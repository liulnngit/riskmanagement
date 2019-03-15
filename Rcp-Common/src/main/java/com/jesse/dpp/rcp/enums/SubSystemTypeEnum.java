package com.jesse.dpp.rcp.enums;

/**
 * 子系统
 * 
 * @author llg
 * 
 */
public enum SubSystemTypeEnum {
	MS("ms", "总后台"), 
	AMS("ams", "代理商后台"), 
	MMS("mms", "商家后台"), 
	PMS("pms", "会员钱包");

	private String name;
	private String desc;
	public static final SubSystemTypeEnum[] subSystems = SubSystemTypeEnum.values();

	SubSystemTypeEnum(String name, String desc) {
		this.name = name;
		this.desc = desc;
	}

	public String getName() {
		return name;
	}

	public String getDesc() {
		return desc;
	}

	public static String getSubSystemName(String name) {
		String result = null;
		for (int i = 0; i < subSystems.length; i++) {
			if (subSystems[i].name.equals(name)) {
				result = subSystems[i].name;
				break;
			}
		}
		return result;
	}

	public static String getSubSystemDesc(String name) {
		String result = null;
		for (int i = 0; i < subSystems.length; i++) {
			if (subSystems[i].name.equals(name)) {
				result = subSystems[i].desc;
				break;
			}
		}
		return result;
	}

	public static SubSystemTypeEnum[] getSystems() {
		return subSystems;
	}
}
