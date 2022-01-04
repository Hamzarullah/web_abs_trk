
package com.inkombizz.finance.model;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.CashAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Customer;
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
@Table(name = "fin_cash_received")
public class CashReceived implements Serializable{
    
    private String code="";
    private Branch branch=null;
    private Date transactionDate = DateUtils.newDate(1900, 1, 1);
    private Currency currency=null;
    private BigDecimal exchangeRate=new BigDecimal("0.00");
    private CashAccount cashAccount=null;
    private String transactionType="Regular";
    private String receivedFrom="";
//    private Customer customer=null;
    private BigDecimal totalTransactionAmount=new BigDecimal("0.00");
    private String refNo="";
    private String remark="";
//    private String accStatus="Open";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);   

    @Id
    @Column(name = "code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
//    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
//    @JoinColumn (name = "CustomerCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
//    public Customer getCustomer() {
//        return customer;
//    }
//
//    public void setCustomer(Customer customer) {
//        this.customer = customer;
//    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getTransactionDate() {
        return transactionDate;
    }

   

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
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
    @JoinColumn (name = "CashAccountCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public CashAccount getCashAccount() {
        return cashAccount;
    }

    public void setCashAccount(CashAccount cashAccount) {
        this.cashAccount = cashAccount;
    }
    
    @Column(name = "TransactionType")
    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    
    @Column(name = "ReceivedFrom")
    public String getReceivedFrom() {
        return receivedFrom;
    }

    public void setReceivedFrom(String receivedFrom) {
        this.receivedFrom = receivedFrom;
    }

    @Column(name = "TotalTransactionAmount")
    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    @Column(name = "RefNo")
    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
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
//    @Column(name = "AccStatus")
//    public String getAccStatus() {
//        return accStatus;
//    }
//
//    public void setAccStatus(String accStatus) {
//        this.accStatus = accStatus;
//    }

    
    
    

}
