/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class PaymentHistoryTemp implements Serializable{
    private String transactionType = "INV";
    private String branchCode;
    private String documentNo = "";
    private String documentRefNo = "";
    private Date documentTransactionDate;
    private String documentCustomerVendorCode = "";
    private String documentCustomerVendorName = "";
    private String documentCurrencyCode;
    private BigDecimal documentExchangeRate;
    private BigDecimal documentTotalTransactionAmount;
    private BigDecimal documentDownPaymentAmount;
    private BigDecimal documentNettAmount;
    private BigDecimal documentPaidAmount;
    private BigDecimal documentBalanceAmount;
    
    //Getter Setter
    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
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

    public String getDocumentRefNo() {
        return documentRefNo;
    }

    public void setDocumentRefNo(String documentRefNo) {
        this.documentRefNo = documentRefNo;
    }

    public Date getDocumentTransactionDate() {
        return documentTransactionDate;
    }

    public void setDocumentTransactionDate(Date documentTransactionDate) {
        this.documentTransactionDate = documentTransactionDate;
    }

    public String getDocumentCustomerVendorCode() {
        return documentCustomerVendorCode;
    }

    public void setDocumentCustomerVendorCode(String documentCustomerVendorCode) {
        this.documentCustomerVendorCode = documentCustomerVendorCode;
    }

    public String getDocumentCustomerVendorName() {
        return documentCustomerVendorName;
    }

    public void setDocumentCustomerVendorName(String documentCustomerVendorName) {
        this.documentCustomerVendorName = documentCustomerVendorName;
    }

    public String getDocumentCurrencyCode() {
        return documentCurrencyCode;
    }

    public void setDocumentCurrencyCode(String documentCurrencyCode) {
        this.documentCurrencyCode = documentCurrencyCode;
    }

    public BigDecimal getDocumentExchangeRate() {
        return documentExchangeRate;
    }

    public void setDocumentExchangeRate(BigDecimal documentExchangeRate) {
        this.documentExchangeRate = documentExchangeRate;
    }

    public BigDecimal getDocumentTotalTransactionAmount() {
        return documentTotalTransactionAmount;
    }

    public void setDocumentTotalTransactionAmount(BigDecimal documentTotalTransactionAmount) {
        this.documentTotalTransactionAmount = documentTotalTransactionAmount;
    }

    public BigDecimal getDocumentDownPaymentAmount() {
        return documentDownPaymentAmount;
    }

    public void setDocumentDownPaymentAmount(BigDecimal documentDownPaymentAmount) {
        this.documentDownPaymentAmount = documentDownPaymentAmount;
    }

    public BigDecimal getDocumentNettAmount() {
        return documentNettAmount;
    }

    public void setDocumentNettAmount(BigDecimal documentNettAmount) {
        this.documentNettAmount = documentNettAmount;
    }

    public BigDecimal getDocumentPaidAmount() {
        return documentPaidAmount;
    }

    public void setDocumentPaidAmount(BigDecimal documentPaidAmount) {
        this.documentPaidAmount = documentPaidAmount;
    }

    public BigDecimal getDocumentBalanceAmount() {
        return documentBalanceAmount;
    }

    public void setDocumentBalanceAmount(BigDecimal documentBalanceAmount) {
        this.documentBalanceAmount = documentBalanceAmount;
    }
    
}
