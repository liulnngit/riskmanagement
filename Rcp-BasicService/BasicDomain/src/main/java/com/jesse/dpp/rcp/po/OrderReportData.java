package com.jesse.dpp.rcp.po;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderReportData implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    // 订单交易日期
    private String orderDate;

    // 交易日期发生交易总次数
    private Integer totalCnt;

    // 交易日期发生交易总金额
    private BigDecimal totalAmt;
    
    // 维度数据
    private String dimensionParameter;

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalCnt() {
        return totalCnt;
    }

    public BigDecimal getTotalAmt() {
        return totalAmt;
    }

    public void setTotalAmt(BigDecimal totalAmt) {
        this.totalAmt = totalAmt;
    }

    public void setTotalCnt(Integer totalCnt) {
        this.totalCnt = totalCnt;
    }

	public String getDimensionParameter() {
		return dimensionParameter;
	}

	public void setDimensionParameter(String dimensionParameter) {
		this.dimensionParameter = dimensionParameter;
	}

}
