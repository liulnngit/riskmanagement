package com.jesse.dpp.rcp.vo;

import java.util.LinkedList;
/**
 * @author wzs-t178
 * 
 * 首页报表汇总
 */
import java.util.List;

import com.jesse.dpp.rcp.po.OrderReportData;

public class AdminReportVo {

	String systemId;
	//系统名称
	String systemName;
	//订单趋势 、交易中金额趋势
	LinkedList<OrderReportData> orderReportDatas;
	//当月关注量
	long attenCount;
	//当月订单数
	long orderCount;
	//当月风险事件数
	long riskEventCount;
	//当月投诉事件数
	long complaintCount;
	//商家总数
	long merchantCount;
	
	
	public String getSystemId() {
		return systemId;
	}
	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	public LinkedList<OrderReportData> getOrderReportDatas() {
		return orderReportDatas;
	}
	public void setOrderReportDatas(LinkedList<OrderReportData> orderReportDatas) {
		this.orderReportDatas = orderReportDatas;
	}
	public long getAttenCount() {
		return attenCount;
	}
	public void setAttenCount(long attenCount) {
		this.attenCount = attenCount;
	}
	public long getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(long orderCount) {
		this.orderCount = orderCount;
	}
	public long getRiskEventCount() {
		return riskEventCount;
	}
	public void setRiskEventCount(long riskEventCount) {
		this.riskEventCount = riskEventCount;
	}
	public long getComplaintCount() {
		return complaintCount;
	}
	public void setComplaintCount(long complaintCount) {
		this.complaintCount = complaintCount;
	}
	public long getMerchantCount() {
		return merchantCount;
	}
	public void setMerchantCount(long merchantCount) {
		this.merchantCount = merchantCount;
	}
}
