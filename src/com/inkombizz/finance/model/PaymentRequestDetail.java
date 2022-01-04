
package com.inkombizz.finance.model;

import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Department;
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
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "fin_payment_request_detail")
public class PaymentRequestDetail implements Serializable{
    
    private String code="";
    private String headerCode="";
    private ChartOfAccount chartOfAccount=null;
    private Department department=null;
    private BigDecimal debit=new BigDecimal("0.0000");
    private BigDecimal credit=new BigDecimal("0.0000");
    private String documentBranchCode="";
    private String  documentNo="";
    private Date documentDate = DateUtils.newDate(1900, 1, 1);
    private String documentType="";
    private String transactionStatus="Other";
    private Currency currency=null;
    private BigDecimal exchangeRate=new BigDecimal("0.0000");
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

    @Column(name = "DocumentDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getDocumentDate() {
        return documentDate;
    }

    public void setDocumentDate(Date documentDate) {
        this.documentDate = documentDate;
    }
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
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

    @Column(name = "Debit")
    public BigDecimal getDebit() {
        return debit;
    }

    public void setDebit(BigDecimal debit) {
        this.debit = debit;
    }
    
    @Column(name = "Credit")
    public BigDecimal getCredit() {
        return credit;
    }

    public void setCredit(BigDecimal credit) {
        this.credit = credit;
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

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DepartmentCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    
    
}
