package com.jesse.dpp.rcp.bo;

import java.io.Serializable;

public class SystemTypeBo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	String systemName;
	String systemCode;
	String systemId;
	
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	public String getSystemCode() {
		return systemCode;
	}
	public void setSystemCode(String systemCode) {
		this.systemCode = systemCode;
	}

	public String getSystemId() {
		return systemId;
	}

	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}

	@Override
	public String toString() {
		return "SystemTypeBo [systemId=" + systemId + ", systemName=" + systemName + ", systemCode=" + systemCode + "]";
	}

}
