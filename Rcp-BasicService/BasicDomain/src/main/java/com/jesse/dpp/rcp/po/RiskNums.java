package com.jesse.dpp.rcp.po;

import java.io.Serializable;

public class RiskNums implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    // 风控事件日期
    private String riskDate;

    // 风控事件数量
    private int riskNums;

    public String getRiskDate() {
        return riskDate;
    }

    public void setRiskDate(String riskDate) {
        this.riskDate = riskDate;
    }

    public int getRiskNums() {
        return riskNums;
    }

    public void setRiskNums(int riskNums) {
        this.riskNums = riskNums;
    }

}
