/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class BankPaymentTemp implements Serializable{
    
    private String code="";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private String transactionDateTemp;
    private String branchCode;
    private String branchName;
    private String transactionType;
    private String paymentTo;
    private String currencyCode;
    private String currencyName;
    private BigDecimal exchangeRate;
    private String bankAccountCode;
    private String bankAccountName;
    private String paymentType;
    private String giroPaymentCode;
    private String giroPaymentNo;
    private String transferPaymentNo;
    private Date transferPaymentDate= DateUtils.newDate(1900, 1, 1);
    private String transferPaymentDateTemp;
    private String transferBankName;
    private BigDecimal totalTransactionAmount;
    private String refNo="";
    private String remark="";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String createdDateTemp;
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    private String AccStatus="";
    //Temporary Date Session
    private Date firstDate;
    private Date lastDate;
    
    //Getter Setter
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getAccStatus() {
        return AccStatus;
    }

    public void setAccStatus(String AccStatus) {
        this.AccStatus = AccStatus;
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

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public String getBankAccountCode() {
        return bankAccountCode;
    }

    public void setBankAccountCode(String bankAccountCode) {
        this.bankAccountCode = bankAccountCode;
    }

    public String getBankAccountName() {
        return bankAccountName;
    }

    public void setBankAccountName(String bankAccountName) {
        this.bankAccountName = bankAccountName;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getGiroPaymentCode() {
        return giroPaymentCode;
    }

    public void setGiroPaymentCode(String giroPaymentCode) {
        this.giroPaymentCode = giroPaymentCode;
    }

    public String getGiroPaymentNo() {
        return giroPaymentNo;
    }

    public void setGiroPaymentNo(String giroPaymentNo) {
        this.giroPaymentNo = giroPaymentNo;
    }

    public String getTransferPaymentNo() {
        return transferPaymentNo;
    }

    public void setTransferPaymentNo(String transferPaymentNo) {
        this.transferPaymentNo = transferPaymentNo;
    }

    public Date getTransferPaymentDate() {
        return transferPaymentDate;
    }

    public void setTransferPaymentDate(Date transferPaymentDate) {
        this.transferPaymentDate = transferPaymentDate;
    }

    public String getTransferPaymentDateTemp() {
        return transferPaymentDateTemp;
    }

    public void setTransferPaymentDateTemp(String transferPaymentDateTemp) {
        this.transferPaymentDateTemp = transferPaymentDateTemp;
    }

    public String getTransferBankName() {
        return transferBankName;
    }

    public void setTransferBankName(String transferBankName) {
        this.transferBankName = transferBankName;
    }

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
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

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
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

    public Date getFirstDate() {
        return firstDate;
    }

    public void setFirstDate(Date firstDate) {
        this.firstDate = firstDate;
    }

    public Date getLastDate() {
        return lastDate;
    }

    public void setLastDate(Date lastDate) {
        this.lastDate = lastDate;
    }
    
}
