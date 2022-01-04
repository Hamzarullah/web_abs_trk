/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.master.model.BankAccount;
import com.inkombizz.master.model.Branch;
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
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "fin_bank_payment")
public class BankPayment implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= new Date();
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;
    
    @Column(name = "TransactionType")
    private String transactionType="Regular";
    
    @Column(name = "PaymentTo")
    private String paymentTo="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Currency currency=null;
    
    @Column(name = "ExchangeRate")
    private BigDecimal exchangeRate=new BigDecimal("0.00");
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BankAccountCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private BankAccount bankAccount=null;
    
    @Column(name = "PaymentType")
    private String paymentType="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @NotFound(action=NotFoundAction.IGNORE)
    @JoinColumn (name = "GiroPaymentNo", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private GiroPayment giroPayment = null;
    
    @Column(name = "TransferPaymentNo")
    private String transferPaymentNo="";
    
    @Column(name = "TransferPaymentDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transferPaymentDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "TransferBankName")
    private String transferBankName="";
    
    @Column(name = "TotalTransactionAmount")
    private BigDecimal totalTransactionAmount=new BigDecimal("0.00");
    
    @Column(name = "RefNo")
    private String refNo="";
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    //Getter Setter
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
    
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getPaymentTo() {
        return paymentTo;
    }

    public void setPaymentTo(String paymentTo) {
        this.paymentTo = paymentTo;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public BankAccount getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(BankAccount bankAccount) {
        this.bankAccount = bankAccount;
    }
    
    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public GiroPayment getGiroPayment() {
        return giroPayment;
    }

    public void setGiroPayment(GiroPayment giroPayment) {
        this.giroPayment = giroPayment;
    }

    public String getTransferPaymentNo() {
        return transferPaymentNo;
    }

    public void setTransferPaymentNo(String transferPaymentNo) {
        this.transferPaymentNo = transferPaymentNo;
    }

    public Date getTransferPaymentDate() {
        return transferPaymentDate;
    }

    public void setTransferPaymentDate(Date transferPaymentDate) {
        this.transferPaymentDate = transferPaymentDate;
    }

    public String getTransferBankName() {
        return transferBankName;
    }

    public void setTransferBankName(String transferBankName) {
        this.transferBankName = transferBankName;
    }

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
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
    
}
