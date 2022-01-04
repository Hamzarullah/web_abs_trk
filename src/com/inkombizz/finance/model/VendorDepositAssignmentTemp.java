
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;


public class VendorDepositAssignmentTemp {
    
    private String depositNo="";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private String transType ="";
    private String transactionDateTemp;
    private String branchCode = "";
    private String documentNo = "";
    private String docType = "";
    private String receivedFrom = "";
    private String currencyCode="";
    private String currencyName="";
    private String vendorCode="";
    private String vendorName="";
    private BigDecimal exchangeRate=new BigDecimal(0.0000);
    private BigDecimal grandTotalAmount=new BigDecimal(0.0000);
    private String refNo="";
    private String remark="";
    private String updatedBy="";
    private Date updatedDate;
    private String createdDateTemp;
    
    private Date assignmentDate= DateUtils.newDate(1900, 1, 1);
    private String transactionDateDaysName = "";
    private String assignmentDateDaysName = "";

    public String getDepositNo() {
        return depositNo;
    }

    public void setDepositNo(String depositNo) {
        this.depositNo = depositNo;
    }

    public String getTransType() {
        return transType;
    }

    public void setTransType(String transType) {
        this.transType = transType;
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

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    public String getVendorName() {
        return vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
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

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getDocumentNo() {
        return documentNo;
    }

    public void setDocumentNo(String documentNo) {
        this.documentNo = documentNo;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }

    public Date getAssignmentDate() {
        return assignmentDate;
    }

    public void setAssignmentDate(Date assignmentDate) {
        this.assignmentDate = assignmentDate;
    }

    public String getTransactionDateDaysName() {
        return transactionDateDaysName;
    }

    public void setTransactionDateDaysName(String transactionDateDaysName) {
        this.transactionDateDaysName = transactionDateDaysName;
    }

    public String getAssignmentDateDaysName() {
        return assignmentDateDaysName;
    }

    public void setAssignmentDateDaysName(String assignmentDateDaysName) {
        this.assignmentDateDaysName = assignmentDateDaysName;
    }

    public String getReceivedFrom() {
        return receivedFrom;
    }

    public void setReceivedFrom(String receivedFrom) {
        this.receivedFrom = receivedFrom;
    }

    
}
