
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;


public class PaymentRequestTemp {
    
    private String code="";
    private String branchCode="";
    private String branchName="";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private String transactionDateTemp="";
    private Date scheduleDate= DateUtils.newDate(1900, 1, 1);
    private String scheduleDateTemp="";
    private String transactionType="";
    private String paymentTo="";
    private String currencyCode="";
    private String currencyName="";
    private BigDecimal totalTransactionAmount=new BigDecimal("0.0000");
    private String approvalBy="";
    private String approvalStatus="PENDING";
    private Date approvalDate= DateUtils.newDate(1900, 1, 1);
    private String approvalDateTemp="";
    private String refNo="";
    private String remark="";
    private String createdBy="";
    private String updatedDateTemp="";
    private String createdDateTemp="";
    private String releasedStatus = "PENDING";
    private String paymentCode="";
    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getTransactionDateTemp() {
        return transactionDateTemp;
    }

    public void setTransactionDateTemp(String transactionDateTemp) {
        this.transactionDateTemp = transactionDateTemp;
    }

    public Date getScheduleDate() {
        return scheduleDate;
    }

    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    public String getScheduleDateTemp() {
        return scheduleDateTemp;
    }

    public void setScheduleDateTemp(String scheduleDateTemp) {
        this.scheduleDateTemp = scheduleDateTemp;
    }
    
    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getPaymentTo() {
        return paymentTo;
    }

    public void setPaymentTo(String paymentTo) {
        this.paymentTo = paymentTo;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getCurrencyName() {
        return currencyName;
    }

    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    public String getApprovalBy() {
        return approvalBy;
    }

    public void setApprovalBy(String approvalBy) {
        this.approvalBy = approvalBy;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getApprovalDateTemp() {
        return approvalDateTemp;
    }

    public void setApprovalDateTemp(String approvalDateTemp) {
        this.approvalDateTemp = approvalDateTemp;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUpdatedDateTemp() {
        return updatedDateTemp;
    }

    public void setUpdatedDateTemp(String updatedDateTemp) {
        this.updatedDateTemp = updatedDateTemp;
    }
    
    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }

    public String getPaymentCode() {
        return paymentCode;
    }

    public void setPaymentCode(String paymentCode) {
        this.paymentCode = paymentCode;
    }

    public String getReleasedStatus() {
        return releasedStatus;
    }

    public void setReleasedStatus(String releasedStatus) {
        this.releasedStatus = releasedStatus;
    }    

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    
}
