package com.jesse.dpp.rcp.params;

import java.io.Serializable;

/**
 * @author tsx-t171
 * @version 1.0.0
 * @date 2017/11/14 15:11
 * @description
 */
public class UnpaidOrderReqParam  implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    private String merchantId;

    private String orderIp;

    private String payerTelephone;

    private String fingerId;

    private String payerCardno;

    private String startOrderDate;

    private String endOrderDate;
    
    private String paymentStatus;

    public String getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(String merchantId) {
        this.merchantId = merchantId;
    }

    public String getOrderIp() {
        return orderIp;
    }

    public void setOrderIp(String orderIp) {
        this.orderIp = orderIp;
    }

    public String getPayerTelephone() {
        return payerTelephone;
    }

    public void setPayerTelephone(String payerTelephone) {
        this.payerTelephone = payerTelephone;
    }

    public String getFingerId() {
        return fingerId;
    }

    public void setFingerId(String fingerId) {
        this.fingerId = fingerId;
    }

    public String getPayerCardno() {
        return payerCardno;
    }

    public void setPayerCardno(String payerCardno) {
        this.payerCardno = payerCardno;
    }

    public String getStartOrderDate() {
        return startOrderDate;
    }

    public void setStartOrderDate(String startOrderDate) {
        this.startOrderDate = startOrderDate;
    }

    public String getEndOrderDate() {
        return endOrderDate;
    }

    public void setEndOrderDate(String endOrderDate) {
        this.endOrderDate = endOrderDate;
    }

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
}
