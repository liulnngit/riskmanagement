package com.jesse.dpp.rcp.enums;

public enum OrderStatus {
	OrderStatus_NOT_PAY("0","未支付","Unpaid"),
	OrderStatus_PAY_SUCCESS("2","支付成功","Success"),
	OrderStatus_PAY_FAILS("3","支付失败","Failed"),
	OrderStatus_REFUND_APPLY("4","申请退款","Request Refund"),
	OrderStatus_REFUNDING("5","退款处理中","Refund Processing"),
	OrderStatus_REFUND_SUCCESS("6","退款成功","Refunded");
	
	private String status;
	private String title = null;
	private String titleEn = null;
	
	public static final OrderStatus[] orderStatus = OrderStatus.values();
	
	OrderStatus(String status, String title,String titleEn) {
		this.status = status;
		this.title = title;
		this.titleEn = titleEn;
	}
	
	public String getStatus() {
		return status;
	}

	public String getTitle() {
		return title;
	}
	
	public String getTitleEn() {
		return titleEn;
	}

	/**
	 * 根据状态获取title
	 * 
	 * @param statusVal 状态	
	 */
	public static String getTitle(String statusVal) {	
		String retunStr = null;
		for(int i = 0; i < orderStatus.length; i ++) {
			if(orderStatus[i].status.equals(statusVal)) {
				retunStr = orderStatus[i].title;
				break;
			}			
		}
		return retunStr;
	}
	
	/**
	 * 根据状态获取titleEn
	 * 
	 * @param statusVal 状态	
	 */
	public static String getTitleEn(String statusVal) {
		String retunStr = null;
		for(int i = 0; i < orderStatus.length; i ++) {
			if(orderStatus[i].status.equals(statusVal)) {
				retunStr = orderStatus[i].titleEn;
				break;
			}			
		}
		return retunStr;
	}
	
	/**
	 * 根据title获取status
	 * 
	 * @param titleVal 标题
	 */
	public static String getStatus(String titleVal) {
		String retunStr = null;
		for(int i = 0; i < orderStatus.length; i ++) {
			if(orderStatus[i].title.equals(titleVal)) {
				retunStr = orderStatus[i].status;
				break;
			}			
		}
		return retunStr;
	}
	
	public String toString() {
		return this.status;
	}

	public static OrderStatus[] getOrderstatus() {
		return orderStatus;
	}



	public void setTitleEn(String titleEn) {
		this.titleEn = titleEn;
	}	
	
	
}
