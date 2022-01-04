/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class VendorDownPaymentTemp {
    
    private String code="";
    private String vdpNo="";
    private String itemDivisionCode="";
    private String itemDivisionName="";
    private Date transactionDate;
    private String transactionDateTemp="";
    private String vendorCode="";
    private String vendorName="";
    private String taxInvoiceNo="";
    private String refNo="";
    private String remark="";
    private String currencyCode="";
    private BigDecimal exchangeRate;
     private BigDecimal vatPercent;
    private BigDecimal vatAmount;
    private BigDecimal grandTotalAmount;
    private BigDecimal PaidAmount;
    private BigDecimal totalTransactionAmount;
    private BigDecimal usedAmount;
    private BigDecimal balance;
    private BigDecimal appliedAmount;
    private String createdBy="";
    private Date createdDate;
    private String createdDateTemp="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public BigDecimal getVatPercent() {
        return vatPercent;
    }

    public void setVatPercent(BigDecimal vatPercent) {
        this.vatPercent = vatPercent;
    }

    public BigDecimal getVatAmount() {
        return vatAmount;
    }

    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }

    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
    }

    public BigDecimal getPaidAmount() {
        return PaidAmount;
    }

    public void setPaidAmount(BigDecimal PaidAmount) {
        this.PaidAmount = PaidAmount;
    }

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    public BigDecimal getUsedAmount() {
        return usedAmount;
    }

    public void setUsedAmount(BigDecimal usedAmount) {
        this.usedAmount = usedAmount;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public BigDecimal getAppliedAmount() {
        return appliedAmount;
    }

    public void setAppliedAmount(BigDecimal appliedAmount) {
        this.appliedAmount = appliedAmount;
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

    public String getVdpNo() {
        return vdpNo;
    }

    public void setVdpNo(String vdpNo) {
        this.vdpNo = vdpNo;
    }

    public String getItemDivisionCode() {
        return itemDivisionCode;
    }

    public void setItemDivisionCode(String itemDivisionCode) {
        this.itemDivisionCode = itemDivisionCode;
    }

    public String getItemDivisionName() {
        return itemDivisionName;
    }

    public void setItemDivisionName(String itemDivisionName) {
        this.itemDivisionName = itemDivisionName;
    }

    public String getTaxInvoiceNo() {
        return taxInvoiceNo;
    }

    public void setTaxInvoiceNo(String taxInvoiceNo) {
        this.taxInvoiceNo = taxInvoiceNo;
    }
    
    
    
}