package com.jesse.dpp.rcp.bo;

import java.io.Serializable;
import java.math.BigDecimal;

public class BigOrderConfiguration implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;
    
    private BigDecimal bigOrderTxMoney;
    
    private String bigOrderRemark;

    public BigDecimal getBigOrderTxMoney() {
        return bigOrderTxMoney;
    }

    public void setBigOrderTxMoney(BigDecimal bigOrderTxMoney) {
        this.bigOrderTxMoney = bigOrderTxMoney;
    }

    public String getBigOrderRemark() {
        return bigOrderRemark;
    }

    public void setBigOrderRemark(String bigOrderRemark) {
        this.bigOrderRemark = bigOrderRemark;
    }
}
