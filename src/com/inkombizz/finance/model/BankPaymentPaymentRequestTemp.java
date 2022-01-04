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

public class BankPaymentPaymentRequestTemp implements Serializable{
    
    private String code;
    private String headerCode;
    private String paymentRequestCode;
    private Date paymentRequestTransactionDate = DateUtils.newDate(1900, 1, 1);
    private String paymentRequestTransactionType;
    private String paymentRequestCurrencyCode;
    private String paymentRequestCurrencyName;
    private BigDecimal paymentRequestTotalTransactionAmount;
    private String paymentRequestRefNo;
    private String paymentRequestRemark;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    //Getter Setter
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }    

    public String getPaymentRequestCode() {
        return paymentRequestCode;
    }

    public void setPaymentRequestCode(String paymentRequestCode) {
        this.paymentRequestCode = paymentRequestCode;
    }

    public Date getPaymentRequestTransactionDate() {
        return paymentRequestTransactionDate;
    }

    public void setPaymentRequestTransactionDate(Date paymentRequestTransactionDate) {
        this.paymentRequestTransactionDate = paymentRequestTransactionDate;
    }

    public String getPaymentRequestTransactionType() {
        return paymentRequestTransactionType;
    }

    public void setPaymentRequestTransactionType(String paymentRequestTransactionType) {
        this.paymentRequestTransactionType = paymentRequestTransactionType;
    }

    public String getPaymentRequestCurrencyCode() {
        return paymentRequestCurrencyCode;
    }

    public void setPaymentRequestCurrencyCode(String paymentRequestCurrencyCode) {
        this.paymentRequestCurrencyCode = paymentRequestCurrencyCode;
    }

    public String getPaymentRequestCurrencyName() {
        return paymentRequestCurrencyName;
    }

    public void setPaymentRequestCurrencyName(String paymentRequestCurrencyName) {
        this.paymentRequestCurrencyName = paymentRequestCurrencyName;
    }

    public BigDecimal getPaymentRequestTotalTransactionAmount() {
        return paymentRequestTotalTransactionAmount;
    }

    public void setPaymentRequestTotalTransactionAmount(BigDecimal paymentRequestTotalTransactionAmount) {
        this.paymentRequestTotalTransactionAmount = paymentRequestTotalTransactionAmount;
    }

    public String getPaymentRequestRefNo() {
        return paymentRequestRefNo;
    }

    public void setPaymentRequestRefNo(String paymentRequestRefNo) {
        this.paymentRequestRefNo = paymentRequestRefNo;
    }

    public String getPaymentRequestRemark() {
        return paymentRequestRemark;
    }

    public void setPaymentRequestRemark(String paymentRequestRemark) {
        this.paymentRequestRemark = paymentRequestRemark;
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
    
}
