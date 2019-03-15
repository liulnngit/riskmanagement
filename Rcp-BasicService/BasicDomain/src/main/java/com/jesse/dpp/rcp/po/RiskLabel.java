package com.jesse.dpp.rcp.po;

import java.math.BigDecimal;

public class RiskLabel extends BasicLabel{
    private static final long serialVersionUID = -7159142956743974495L;
    
    private String systemId;
    private String merchantId;
    private BigDecimal txnAmt1d;
    private Long txnCnt1d;
    private BigDecimal txnAmt1m;
    private Long txnCnt1m;
    private BigDecimal txnAmt3m;
    private Long txnCnt3m;
    private Long retCnt1d;
    private Long retCnt1m;
    private Long retCnt3m;
    private Long cptCntDay; 
    private String atnFlagNow; // '1' 关注 '0' 未被关注
    private Long atnCntBf;
    private Long blkCntNow;
    private Long blkCntBf;
    private Long whtCntNow;
    private Long whtCntBf;
    public String getSystemId() {
        return systemId;
    }
    public void setSystemId(String systemId) {
        this.systemId = systemId;
    }
    public String getMerchantId() {
        return merchantId;
    }
    public void setMerchantId(String merchantId) {
        this.merchantId = merchantId;
    }
    public BigDecimal getTxnAmt1d() {
        return txnAmt1d;
    }
    public void setTxnAmt1d(BigDecimal txnAmt1d) {
        this.txnAmt1d = txnAmt1d;
    }
    public Long getTxnCnt1d() {
        return txnCnt1d;
    }
    public void setTxnCnt1d(Long txnCnt1d) {
        this.txnCnt1d = txnCnt1d;
    }
    public BigDecimal getTxnAmt1m() {
        return txnAmt1m;
    }
    public void setTxnAmt1m(BigDecimal txnAmt1m) {
        this.txnAmt1m = txnAmt1m;
    }
    public Long getTxnCnt1m() {
        return txnCnt1m;
    }
    public void setTxnCnt1m(Long txnCnt1m) {
        this.txnCnt1m = txnCnt1m;
    }
    public BigDecimal getTxnAmt3m() {
        return txnAmt3m;
    }
    public void setTxnAmt3m(BigDecimal txnAmt3m) {
        this.txnAmt3m = txnAmt3m;
    }
    public Long getTxnCnt3m() {
        return txnCnt3m;
    }
    public void setTxnCnt3m(Long txnCnt3m) {
        this.txnCnt3m = txnCnt3m;
    }
    public Long getRetCnt1d() {
        return retCnt1d;
    }
    public void setRetCnt1d(Long retCnt1d) {
        this.retCnt1d = retCnt1d;
    }
    public Long getRetCnt1m() {
        return retCnt1m;
    }
    public void setRetCnt1m(Long retCnt1m) {
        this.retCnt1m = retCnt1m;
    }
    public Long getRetCnt3m() {
        return retCnt3m;
    }
    public void setRetCnt3m(Long retCnt3m) {
        this.retCnt3m = retCnt3m;
    }
    public Long getCptCntDay() {
        return cptCntDay;
    }
    public void setCptCntDay(Long cptCntDay) {
        this.cptCntDay = cptCntDay;
    }
    public String getAtnFlagNow() {
        return atnFlagNow;
    }
    public void setAtnFlagNow(String atnFlagNow) {
        this.atnFlagNow = atnFlagNow;
    }
    public Long getAtnCntBf() {
        return atnCntBf;
    }
    public void setAtnCntBf(Long atnCntBf) {
        this.atnCntBf = atnCntBf;
    }
    public Long getBlkCntNow() {
        return blkCntNow;
    }
    public void setBlkCntNow(Long blkCntNow) {
        this.blkCntNow = blkCntNow;
    }
    public Long getBlkCntBf() {
        return blkCntBf;
    }
    public void setBlkCntBf(Long blkCntBf) {
        this.blkCntBf = blkCntBf;
    }
    public Long getWhtCntNow() {
        return whtCntNow;
    }
    public void setWhtCntNow(Long whtCntNow) {
        this.whtCntNow = whtCntNow;
    }
    public Long getWhtCntBf() {
        return whtCntBf;
    }
    public void setWhtCntBf(Long whtCntBf) {
        this.whtCntBf = whtCntBf;
    }
    @Override
    public String toString() {
        return "RiskLabelVo [systemId=" + systemId + ", merchantId=" + merchantId + ", txnAmt1d=" + txnAmt1d
                + ", txnCnt1d=" + txnCnt1d + ", txnAmt1m=" + txnAmt1m + ", txnCnt1m=" + txnCnt1m + ", txnAmt3m="
                + txnAmt3m + ", txnCnt3m=" + txnCnt3m + ", retCnt1d=" + retCnt1d + ", retCnt1m=" + retCnt1m
                + ", retCnt3m=" + retCnt3m + ", cptCntDay=" + cptCntDay + ", atnFlagNow=" + atnFlagNow + ", atnCntBf="
                + atnCntBf + ", blkCntNow=" + blkCntNow + ", blkCntBf=" + blkCntBf + ", whtCntNow=" + whtCntNow
                + ", whtCntBf=" + whtCntBf + "]";
    }
    
}
