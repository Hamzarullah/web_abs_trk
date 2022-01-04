
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class PaymentRequestDetailTemp {
    
    private String code="";
    private String headerCode="";
    private String branchCode="";
    private String documentBranchCode="";
    private String documentNo="";
    private Date documentDate= DateUtils.newDate(1900, 1, 1);
    private String documentType="";
    private BigDecimal documentAmount=new BigDecimal("0.0000");
    private BigDecimal documentBalanceAmount=new BigDecimal("0.0000");
    private String chartOfAccountCode="";
    private String chartOfAccountName="";
    private String transactionStatus="Other";
    private String currencyCode="";
    private String currencyName="";
    private BigDecimal exchangeRate=new BigDecimal("0.0000");
    private BigDecimal debit=new BigDecimal("0.0000");
    private BigDecimal debitIDR=new BigDecimal("0.0000");
    private BigDecimal credit=new BigDecimal("0.0000");
    private BigDecimal creditIDR=new BigDecimal("0.0000");
    private String remark="";
    private String departmentCode="";
    private String departmentName="";

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

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

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

    public Date getDocumentDate() {
        return documentDate;
    }

    public void setDocumentDate(Date documentDate) {
        this.documentDate = documentDate;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public BigDecimal getDocumentAmount() {
        return documentAmount;
    }

    public void setDocumentAmount(BigDecimal documentAmount) {
        this.documentAmount = documentAmount;
    }

    public BigDecimal getDocumentBalanceAmount() {
        return documentBalanceAmount;
    }

    public void setDocumentBalanceAmount(BigDecimal documentBalanceAmount) {
        this.documentBalanceAmount = documentBalanceAmount;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDepartmentCode() {
        return departmentCode;
    }

    public void setDepartmentCode(String departmentCode) {
        this.departmentCode = departmentCode;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }
    
    
}
