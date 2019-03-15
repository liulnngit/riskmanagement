package com.jesse.dpp.rcp.vo;

/**
 * @author wzs-t178
 * 
 * 子系统首页报表
 */
import java.util.LinkedList;
import java.util.List;

import com.jesse.dpp.rcp.po.IndexView;
import com.jesse.dpp.rcp.po.OrderReportData;
import com.jesse.dpp.rcp.po.RiskNums;

public class SubAdminReportVo {

	String systemId;
	//系统名称
	String systemName;
	
	//订单趋势 、交易中金额趋势
	LinkedList<OrderReportData> reportDatas;
	
	//当月关注量
	IndexView attenInfo;
	
	//当月订单数
	IndexView orderInfo;
	
	//当月风险事件数
	IndexView riskInfo;
	
	//当月投诉事件数
	IndexView complaintInfo;

	//商家总数
	IndexView merchantInfo;

	//风险趋势
	List<RiskNums> riskDataInfo;
	
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

	public LinkedList<OrderReportData> getReportDatas() {
		return reportDatas;
	}

	public void setReportDatas(LinkedList<OrderReportData> reportDatas) {
		this.reportDatas = reportDatas;
	}

	public IndexView getAttenInfo() {
		return attenInfo;
	}

	public void setAttenInfo(IndexView attenInfo) {
		this.attenInfo = attenInfo;
	}

	public IndexView getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(IndexView orderInfo) {
		this.orderInfo = orderInfo;
	}

	public IndexView getRiskInfo() {
		return riskInfo;
	}

	public void setRiskInfo(IndexView riskInfo) {
		this.riskInfo = riskInfo;
	}

	public IndexView getComplaintInfo() {
		return complaintInfo;
	}

	public void setComplaintInfo(IndexView complaintInfo) {
		this.complaintInfo = complaintInfo;
	}

	public IndexView getMerchantInfo() {
		return merchantInfo;
	}

	public void setMerchantInfo(IndexView merchantInfo) {
		this.merchantInfo = merchantInfo;
	}

	public List<RiskNums> getRiskDataInfo() {
		return riskDataInfo;
	}

	public void setRiskDataInfo(List<RiskNums> riskDataInfo) {
		this.riskDataInfo = riskDataInfo;
	}
	
	
}
