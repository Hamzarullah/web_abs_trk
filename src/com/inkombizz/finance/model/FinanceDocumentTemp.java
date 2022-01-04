
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class FinanceDocumentTemp {
    
    private String financeDocumentID="";
    private String headerCode="";
    private String branchCode="";
    private String documentType="";
    private String documentNo="";
    private String documentRefNo="";
    private Date transactionDate = DateUtils.newDate(1900, 1, 1);
    private Date dueDate = DateUtils.newDate(1900, 1, 1);
    private String transactionDateTemp="";
//    private String dueDate="";
    private String customerVendorCode="";
    private String customerVendorName="";
    private String currencyCode="";
    private String currencyName="";
    private BigDecimal exchangeRate=new BigDecimal(0.0000);
    private String chartOfAccountCode="";
    private String chartOfAccountName="";
    private BigDecimal grandTotalAmount=new BigDecimal(0.0000);
    private BigDecimal paidAmount=new BigDecimal(0.0000);
    private BigDecimal balance=new BigDecimal(0.0000);
    private BigDecimal debit=new BigDecimal(0.0000);
    private BigDecimal credit=new BigDecimal(0.0000);
    private Date periodFirstDate = DateUtils.newDate(1900, 1, 1);
    private Date periodLastDate = DateUtils.newDate(1900, 1, 1);
    
    private String shipToCode = "";
    private String shipToName = "";
    private String billToCode = "";
    private String billToName = "";
    private String sortByFinanceDocument="documentNo";
    private String orderByFinanceDocument="ASC";
    private String vendorInvoiceNo = "";
    
    public String getFinanceDocumentID() {
        return financeDocumentID;
    }

    public void setFinanceDocumentID(String financeDocumentID) {
        this.financeDocumentID = financeDocumentID;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
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

    public String getDocumentRefNo() {
        return documentRefNo;
    }

    public void setDocumentRefNo(String documentRefNo) {
        this.documentRefNo = documentRefNo;
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

    public String getCustomerVendorCode() {
        return customerVendorCode;
    }

    public void setCustomerVendorCode(String customerVendorCode) {
        this.customerVendorCode = customerVendorCode;
    }

    public String getCustomerVendorName() {
        return customerVendorName;
    }

    public void setCustomerVendorName(String customerVendorName) {
        this.customerVendorName = customerVendorName;
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

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public BigDecimal getDebit() {
        return debit;
    }

    public void setDebit(BigDecimal debit) {
        this.debit = debit;
    }

    public BigDecimal getCredit() {
        return credit;
    }

    public void setCredit(BigDecimal credit) {
        this.credit = credit;
    }

    public Date getPeriodFirstDate() {
        return periodFirstDate;
    }

    public void setPeriodFirstDate(Date periodFirstDate) {
        this.periodFirstDate = periodFirstDate;
    }

    public Date getPeriodLastDate() {
        return periodLastDate;
    }

    public void setPeriodLastDate(Date periodLastDate) {
        this.periodLastDate = periodLastDate;
    }
    
    public String getShipToCode() {
        return shipToCode;
    }

    public void setShipToCode(String shipToCode) {
        this.shipToCode = shipToCode;
    }

    public String getShipToName() {
        return shipToName;
    }

    public void setShipToName(String shipToName) {
        this.shipToName = shipToName;
    }

    public String getBillToCode() {
        return billToCode;
    }

    public void setBillToCode(String billToCode) {
        this.billToCode = billToCode;
    }

    public String getBillToName() {
        return billToName;
    }

    public void setBillToName(String billToName) {
        this.billToName = billToName;
    }

    public String getSortByFinanceDocument() {
        return sortByFinanceDocument;
    }

    public void setSortByFinanceDocument(String sortByFinanceDocument) {
        this.sortByFinanceDocument = sortByFinanceDocument;
    }

    public String getOrderByFinanceDocument() {
        return orderByFinanceDocument;
    }

    public void setOrderByFinanceDocument(String orderByFinanceDocument) {
        this.orderByFinanceDocument = orderByFinanceDocument;
    }

    public String getVendorInvoiceNo() {
        return vendorInvoiceNo;
    }

    public void setVendorInvoiceNo(String vendorInvoiceNo) {
        this.vendorInvoiceNo = vendorInvoiceNo;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    
}
