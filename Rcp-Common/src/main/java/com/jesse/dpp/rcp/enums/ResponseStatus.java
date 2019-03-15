package com.jesse.dpp.rcp.enums;

/**
 * 页面响应状态
 * @author dyq-t176
 *
 */
public enum ResponseStatus {

	RESPONSE_STATUS_SUCCESS("success"),
	RESPONSE_STATUS_FAIL("fail"),
	RESPONSE_STATUS_REPEAT("repeat"),
	RESPONSE_STATUS_EMPTY("empty");
	
	private String status;

	private ResponseStatus(String status) {
		this.status = status;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
