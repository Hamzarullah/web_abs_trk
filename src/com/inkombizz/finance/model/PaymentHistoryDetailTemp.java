/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class PaymentHistoryDetailTemp implements Serializable{
    private String documentBranchCode;
    private String documentNo;
    private String bankCashAccountCode;
    private String bankCashAccountName;
    private String refNo;
    private String voucherNo;
    private Date transactionDate;
    private String paymentReceivedType;
    private String currencyCode;
    private BigDecimal exchangeRate;
    private BigDecimal amount;
    private BigDecimal amountIDR;
    private String chartOfAccountCode;
    private String chartOfAccountName;
    private String transactionStatus;
    
    //Getter Setter
    public String getDocumentBranchCode() {
        return documentBranchCode;
    }

    public void setDocumentBranchCode(String documentBranchCode) {
        this.documentBranchCode = documentBranchCode;
    }

    public String getDocumentNo() {
        return documentNo;
    }

    public void setDocumentNo(String documentNo) {
        this.documentNo = documentNo;
    }

    public String getBankCashAccountCode() {
        return bankCashAccountCode;
    }

    public void setBankCashAccountCode(String bankCashAccountCode) {
        this.bankCashAccountCode = bankCashAccountCode;
    }

    public String getBankCashAccountName() {
        return bankCashAccountName;
    }

    public void setBankCashAccountName(String bankCashAccountName) {
        this.bankCashAccountName = bankCashAccountName;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getVoucherNo() {
        return voucherNo;
    }

    public void setVoucherNo(String voucherNo) {
        this.voucherNo = voucherNo;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getPaymentReceivedType() {
        return paymentReceivedType;
    }

    public void setPaymentReceivedType(String paymentReceivedType) {
        this.paymentReceivedType = paymentReceivedType;
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

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getAmountIDR() {
        return amountIDR;
    }

    public void setAmountIDR(BigDecimal amountIDR) {
        this.amountIDR = amountIDR;
    }

    public String getChartOfAccountCode() {
        return chartOfAccountCode;
    }

    public void setChartOfAccountCode(String chartOfAccountCode) {
        this.chartOfAccountCode = chartOfAccountCode;
    }

    public String getChartOfAccountName() {
        return chartOfAccountName;
    }

    public void setChartOfAccountName(String chartOfAccountName) {
        this.chartOfAccountName = chartOfAccountName;
    }

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }
    
}
