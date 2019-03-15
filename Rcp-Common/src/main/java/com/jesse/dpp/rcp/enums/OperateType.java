package com.jesse.dpp.rcp.enums;

import org.apache.commons.lang.StringUtils;


public enum OperateType {
	//OperateType_UPDATE_PAY_RESULT("01","更新付款"),
	//OperateType_SUPPLY_NOTIFY("02","补发通知"),
	OperateType_REFUND_APPLY("03","申请退款","Refund application"),
	OperateType_REFUND_CANCEL("04","取消退款","Cancel refund "),
	OperateType_REFUND_SUCCESS("05","退款成功","Refund Successful"),
	OperateType_ORDER_FROZEN("06","订单冻结","Freeze order"),
	OperateType_ORDER_RECOVER("07","订单解冻","Unfreeze order"),
	OperateType_ORDER_complaintStatus0("08", "被投诉","Received complaint"),
	OperateType_ORDER_complaintStatus1("09", "取消投诉","Cancel complaint"),
	OperateType_ORDER_complaintStatus2("10","投诉解决","Resolve compliant"),
	OperateType_HAND_REFUND("11","手工退款","Manual refund"),
	OperateType_HAND_REFUND_SUCCESS("12","手工付款成功","Manual payment successful"),
	OperateType_SYSDIRECT_REFUND("13","系统直连退款","System direct refund"),
	OperateType_UPDATE_REFUND_STATUS("14","修改退款状态","Modify refund status");
	
	
	private String status;
	private String title = null;
	private String titleEn = null;
	
	OperateType(String status, String title, String titleEn) {
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
	
	public static String getTitleName(String status) {
		OperateType[] types = OperateType.values();
		for (OperateType s : types) {
			if (s.getStatus().equals(status)) {
				return s.getTitle();
			}
		}
		return StringUtils.EMPTY;
	}
	
	public static String getTitleEnName(String status) {
		OperateType[] types = OperateType.values();
		for (OperateType s : types) {
			if (s.getStatus().equals(status)) {
				return s.getTitleEn();
			}
		}
		return StringUtils.EMPTY;
	}
	public String toString() {
		StringBuilder strBuilder = new StringBuilder();
		strBuilder.append("OperateType[status=").append(this.status)
		.append(",title=").append(this.title).append("]");
		return strBuilder.toString();
	}
}
