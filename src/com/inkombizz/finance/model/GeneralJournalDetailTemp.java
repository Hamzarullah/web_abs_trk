
package com.inkombizz.finance.model;

import java.math.BigDecimal;

public class GeneralJournalDetailTemp {
 
    private String code; 
    private String headerCode;
    private String documentBranchCode;
    private String documentType;
    private String documentNo;
    private String currencyCode;
    private String currencyName;
    private BigDecimal exchangeRate;
    private BigDecimal documentAmount;
    private BigDecimal documentAmountIDR;
    private BigDecimal documentBalanceAmount;
    private BigDecimal documentBalanceAmountIDR;
    private String transactionStatus;
    private BigDecimal debit;
    private BigDecimal debitIDR;
    private BigDecimal credit;
    private BigDecimal creditIDR;
    private String chartOfAccountCode;
    private String chartOfAccountName;
    private String divisionStructureCode;
    private String divisionStructureName; 
    private String remark;

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

    public String getDocumentBranchCode() {
        return documentBranchCode;
    }

    public void setDocumentBranchCode(String documentBranchCode) {
        this.documentBranchCode = documentBranchCode;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public String getDocumentNo() {
        return documentNo;
    }

    public void setDocumentNo(String documentNo) {
        this.documentNo = documentNo;
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

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
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
