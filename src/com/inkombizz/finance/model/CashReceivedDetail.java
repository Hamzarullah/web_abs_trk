
package com.inkombizz.finance.model;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;


@Entity
@Table(name = "fin_cash_received_detail")
public class CashReceivedDetail implements Serializable{
    
    private String code="";
    private String headerCode="";
    private Branch branch=null;
    private String documentBranchCode="";
    private String documentType="";
    private String  documentNo="";
    private Currency currency=null;
    private BigDecimal exchangeRate=new BigDecimal("0.00");
    private String transactionStatus="Transaction";
    private BigDecimal debit=new BigDecimal("0.00");
    private BigDecimal debitIDR=new BigDecimal("0.00");
    private BigDecimal credit=new BigDecimal("0.00");
    private BigDecimal creditIDR=new BigDecimal("0.00");
    private ChartOfAccount chartOfAccount=null;
    private String remark="";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);   
    

    @Id
    @Column(name = "Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "HeaderCode")
    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    @Column(name = "DocumentBranchCode")
    public String getDocumentBranchCode() {
        return documentBranchCode;
    }

    public void setDocumentBranchCode(String documentBranchCode) {
        this.documentBranchCode = documentBranchCode;
    }

    @Column(name = "DocumentType")
    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    @Column(name = "DocumentNo")
    public String getDocumentNo() {
        return documentNo;
    }

    public void setDocumentNo(String documentNo) {
        this.documentNo = documentNo;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    

    @Column(name = "ExchangeRate")
    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ChartOfAccountCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public ChartOfAccount getChartOfAccount() {
        return chartOfAccount;
    }

    public void setChartOfAccount(ChartOfAccount chartOfAccount) {
        this.chartOfAccount = chartOfAccount;
    }

    @Column(name = "TransactionStatus")
    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }
    
    @Column(name = "Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Column(name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column(name = "UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    @Column(name = "Debit")
    public BigDecimal getDebit() {
        return debit;
    }

    public void setDebit(BigDecimal debit) {
        this.debit = debit;
    }

    @Column(name = "DebitIDR")
    public BigDecimal getDebitIDR() {
        return debitIDR;
    }

    public void setDebitIDR(BigDecimal debitIDR) {
        this.debitIDR = debitIDR;
    }

    @Column(name = "Credit")
    public BigDecimal getCredit() {
        return credit;
    }

    public void setCredit(BigDecimal credit) {
        this.credit = credit;
    }

    @Column(name = "CreditIDR")
    public BigDecimal getCreditIDR() {
        return creditIDR;
    }

    public void setCreditIDR(BigDecimal creditIDR) {
        this.creditIDR = creditIDR;
    }
}
