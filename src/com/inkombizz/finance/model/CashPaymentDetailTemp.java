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

public class CashPaymentDetailTemp implements Serializable{
    
    private String code;
    private String headerCode;
    private String paymentRequestCode;
    private String documentNo;
    private String documentType;
    private Date documentDate = DateUtils.newDate(1900, 1, 1);
    private String documentBranchCode;
    private BigDecimal documentAmount;
    private BigDecimal documentAmountIDR;
    private BigDecimal documentBalanceAmount;
    private BigDecimal documentBalanceAmountIDR;
    private String currencyCode;
    private String currencyName;
    private BigDecimal exchangeRate;
    private String transactionStatus;
    private BigDecimal credit;
    private BigDecimal creditIDR;
    private BigDecimal debit;
    private BigDecimal debitIDR;
    private String chartOfAccountCode;
    private String chartOfAccountName;
    private String divisionStructureCode;
    private String divisionStructureName;        
    private String remark;
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

    public String getDocumentNo() {
        return documentNo;
    }

    public void setDocumentNo(String documentNo) {
        this.documentNo = documentNo;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public Date getDocumentDate() {
        return documentDate;
    }

    public void setDocumentDate(Date documentDate) {
        this.documentDate = documentDate;
    }

    public String getDocumentBranchCode() {
        return documentBranchCode;
    }

    public void setDocumentBranchCode(String documentBranchCode) {
        this.documentBranchCode = documentBranchCode;
    }

    public BigDecimal getDocumentAmount() {
        return documentAmount;
    }

    public void setDocumentAmount(BigDecimal documentAmount) {
        this.documentAmount = documentAmount;
    }

    public BigDecimal getDocumentAmountIDR() {
        return documentAmountIDR;
    }

    public void setDocumentAmountIDR(BigDecimal documentAmountIDR) {
        this.documentAmountIDR = documentAmountIDR;
    }

    public BigDecimal getDocumentBalanceAmount() {
        return documentBalanceAmount;
    }

    public void setDocumentBalanceAmount(BigDecimal documentBalanceAmount) {
        this.documentBalanceAmount = documentBalanceAmount;
    }

    public BigDecimal getDocumentBalanceAmountIDR() {
        return documentBalanceAmountIDR;
    }

    public void setDocumentBalanceAmountIDR(BigDecimal documentBalanceAmountIDR) {
        this.documentBalanceAmountIDR = documentBalanceAmountIDR;
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

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    public BigDecimal getCredit() {
        return credit;
    }

    public void setCredit(BigDecimal credit) {
        this.credit = credit;
    }

    public BigDecimal getCreditIDR() {
        return creditIDR;
    }

    public void setCreditIDR(BigDecimal creditIDR) {
        this.creditIDR = creditIDR;
    }

    public BigDecimal getDebit() {
        return debit;
    }

    public void setDebit(BigDecimal debit) {
        this.debit = debit;
    }

    public BigDecimal getDebitIDR() {
        return debitIDR;
    }

    public void setDebitIDR(BigDecimal debitIDR) {
        this.debitIDR = debitIDR;
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
    
    public String getDivisionStructureCode() {
        return divisionStructureCode;
    }

    public void setDivisionStructureCode(String divisionStructureCode) {
        this.divisionStructureCode = divisionStructureCode;
    }

    public String getDivisionStructureName() {
        return divisionStructureName;
    }

    public void setDivisionStructureName(String divisionStructureName) {
        this.divisionStructureName = divisionStructureName;
    }
    
}
