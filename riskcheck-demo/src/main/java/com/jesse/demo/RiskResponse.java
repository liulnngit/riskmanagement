package com.jesse.demo;

//实现Comparable用于比较风险级别用于最后输出
public class RiskResponse implements Comparable<RiskResponse>{
  
  private String orderId;
  private String ruleCode;
  private String riskLevel;
  private String remark;
  //0:无风险,1:有风险
  private String hasRisk;
  
  public String getOrderId() {
      return orderId;
  }
  public void setOrderId(String orderId) {
      this.orderId = orderId;
  }
  public String getRuleCode() {
      return ruleCode;
  }
  public void setRuleCode(String ruleCode) {
      this.ruleCode = ruleCode;
  }
  public String getRiskLevel() {
      return riskLevel;
  }
  public void setRiskLevel(String riskLevel) {
      this.riskLevel = riskLevel;
  }
  public String getRemark() {
      return remark;
  }
  public void setRemark(String remark) {
      this.remark = remark;
  }

  public String getHasRisk() {
      return hasRisk;
  }
  public void setHasRisk(String hasRisk) {
      this.hasRisk = hasRisk;
  }
  
  @Override
  public String toString() {
      return "RiskResponse [orderId=" + orderId + ", ruleCode=" + ruleCode + ", riskLevel=" + riskLevel + ", remark="
              + remark + ", hasRisk=" + hasRisk + "]";
  }
  @Override
  public int compareTo(RiskResponse rsp) {
      //返回风险级别高的，后面的要比前面大 才交换  
      return rsp.getRiskLevel().compareTo(this.getRiskLevel());
  }
  /**
   * this.compareTo(that)
   * 当前对象和后一个对象比较，如果比较结果为1 则交换 ，其他不交换
   */ 
}