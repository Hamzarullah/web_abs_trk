
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class CustomerCreditNoteTemp {
    
    private String code="";
    private String branchCode="";
    private String branchName="";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private Date dueDate= DateUtils.newDate(1900, 1, 1);
    private String transactionDateTemp="";
    private String customerCreditNoteType="";
    private String currencyCode="";
    private String currencyName="";
    private BigDecimal exchangeRate=new BigDecimal("0.00");
    private String customerCode="";
    private String customerName="";
    private String taxInvoiceNo="";
    private Date taxInvoiceDate= DateUtils.newDate(1900, 1, 1);
    private String taxInvoiceDateTemp="";
    private String refNo="";
    private String remark="";
    private String createdDateTemp="";
    private String paymentTermCode = "";
    private String paymentTermName = "";
    private BigDecimal totalTransactionAmount=new BigDecimal("0.00");
    private BigDecimal discountPercent=new BigDecimal("0.00");
    private BigDecimal discountAmount=new BigDecimal("0.00");
    private String discountAccountCode="";
    private String discountAccountName="";
    private BigDecimal vatPercent=new BigDecimal("0.00");
    private BigDecimal vatAmount=new BigDecimal("0.00");
    private BigDecimal grandTotalAmount=new BigDecimal("0.00");
    private BigDecimal paidAmount=new BigDecimal("0.00");
    private Date settlementDate= DateUtils.newDate(1900, 1, 1);
    private String settlementDateTemp;
    private String settlementDocumentNo="";

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

    public String getCustomerCreditNoteType() {
        return customerCreditNoteType;
    }

    public void setCustomerCreditNoteType(String customerCreditNoteType) {
        this.customerCreditNoteType = customerCreditNoteType;
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

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getTaxInvoiceNo() {
        return taxInvoiceNo;
    }

    public void setTaxInvoiceNo(String taxInvoiceNo) {
        this.taxInvoiceNo = taxInvoiceNo;
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

    public String getPaymentTermCode() {
        return paymentTermCode;
    }

    public void setPaymentTermCode(String paymentTermCode) {
        this.paymentTermCode = paymentTermCode;
    }

    public String getPaymentTermName() {
        return paymentTermName;
    }

    public void setPaymentTermName(String paymentTermName) {
        this.paymentTermName = paymentTermName;
    }

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getDiscountAccountCode() {
        return discountAccountCode;
    }

    public void setDiscountAccountCode(String discountAccountCode) {
        this.discountAccountCode = discountAccountCode;
    }

    public String getDiscountAccountName() {
        return discountAccountName;
    }

    public void setDiscountAccountName(String discountAccountName) {
        this.discountAccountName = discountAccountName;
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
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Date getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(Date settlementDate) {
        this.settlementDate = settlementDate;
    }

    public String getSettlementDateTemp() {
        return settlementDateTemp;
    }

    public void setSettlementDateTemp(String settlementDateTemp) {
        this.settlementDateTemp = settlementDateTemp;
    }

    public String getSettlementDocumentNo() {
        return settlementDocumentNo;
    }

    public void setSettlementDocumentNo(String settlementDocumentNo) {
        this.settlementDocumentNo = settlementDocumentNo;
    }

    public Date getTaxInvoiceDate() {
        return taxInvoiceDate;
    }

    public void setTaxInvoiceDate(Date taxInvoiceDate) {
        this.taxInvoiceDate = taxInvoiceDate;
    }

    public String getTaxInvoiceDateTemp() {
        return taxInvoiceDateTemp;
    }

    public void setTaxInvoiceDateTemp(String taxInvoiceDateTemp) {
        this.taxInvoiceDateTemp = taxInvoiceDateTemp;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    
}

