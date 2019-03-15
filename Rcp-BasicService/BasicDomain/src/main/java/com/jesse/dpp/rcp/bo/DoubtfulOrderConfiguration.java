package com.jesse.dpp.rcp.bo;

import java.io.Serializable;
import java.math.BigDecimal;

public class DoubtfulOrderConfiguration implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;
    
    private BigDecimal doubtfulOrderTxMoney;
    
    private String floatingRate;
    
    private String doubtfulOrderRemark;

    public BigDecimal getDoubtfulOrderTxMoney() {
        return doubtfulOrderTxMoney;
    }

    public void setDoubtfulOrderTxMoney(BigDecimal doubtfulOrderTxMoney) {
        this.doubtfulOrderTxMoney = doubtfulOrderTxMoney;
    }

    public String getFloatingRate() {
        return floatingRate;
    }

    public void setFloatingRate(String floatingRate) {
        this.floatingRate = floatingRate;
    }

    public String getDoubtfulOrderRemark() {
        return doubtfulOrderRemark;
    }

    public void setDoubtfulOrderRemark(String doubtfulOrderRemark) {
        this.doubtfulOrderRemark = doubtfulOrderRemark;
    }
}
