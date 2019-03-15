package com.jesse.dpp.rcp.util;

/**
 * 动态生成输入框字段
 * 
 * @author wzs-t178
 *
 */
public class Config {
	

	String id;
	String name;
	String tipName;
	
	public Config(String id, String name, String tipName) {
		super();
		this.id = id;
		this.name = name;
		this.tipName = tipName;
	}
	

	public Config() {
		
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTipName() {
		return tipName;
	}
	public void setTipName(String tipName) {
		this.tipName = tipName;
	}


	@Override
	public String toString() {
		return "Config [id=" + id + ", name=" + name + ", tipName=" + tipName + "]";
	}
		
}
