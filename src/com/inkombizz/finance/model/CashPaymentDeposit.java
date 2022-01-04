/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Vendor;
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
@Table(name = "fin_cash_payment_deposit")
public class CashPaymentDeposit implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PaymentRequestCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private PaymentRequest paymentRequest=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CashPaymentCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private CashPayment cashPayment=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Currency currency=null;
    
    @Column(name = "ExchangeRate")
    private BigDecimal exchangeRate=new BigDecimal("0.00");
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Vendor vendor=null;
    
    @Column(name = "GrandTotalAmount")
    private BigDecimal grandTotalAmount=new BigDecimal("0.00");
    
    @Column(name = "PaidAmount")
    private BigDecimal paidAmount=new BigDecimal("0.00");
    
    @Column(name = "SettlementDocumentNo")
    private String settlementDocumentNo = "";
    
    @Column(name = "RefNo")
    private String refNo = "";
    
    @Column(name = "Remark")
    private String remark = "";
    
    @Column(name = "SettlementDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date settlementDate = DateUtils.newDate(1900, 1, 1);
    
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

    public PaymentRequest getPaymentRequest() {
        return paymentRequest;
    }

    public void setPaymentRequest(PaymentRequest paymentRequest) {
        this.paymentRequest = paymentRequest;
    }

    public CashPayment getCashPayment() {
        return cashPayment;
    }

    public void setCashPayment(CashPayment cashPayment) {
        this.cashPayment = cashPayment;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
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

    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
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

    public String getSettlementDocumentNo() {
        return settlementDocumentNo;
    }

    public void setSettlementDocumentNo(String settlementDocumentNo) {
        this.settlementDocumentNo = settlementDocumentNo;
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

    public Date getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(Date settlementDate) {
        this.settlementDate = settlementDate;
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
