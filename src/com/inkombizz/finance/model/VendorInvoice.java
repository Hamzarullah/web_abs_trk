/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.PaymentTerm;
import com.inkombizz.master.model.Vendor;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
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

/**
 *
 * @author jason
 */
@Entity
@Table(name = "fin_vendor_invoice")
public class VendorInvoice implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch = null;
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate = DateUtils.newDate(1900, 01, 01);
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PurchaseOrderCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private PurchaseOrder purchaseOrder = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Currency currency = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Vendor vendor = null;
    
    @Column(name = "exchangeRate")
    private BigDecimal exchangeRate = new BigDecimal(BigInteger.ZERO);
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PaymentTermCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private PaymentTerm paymentTerm = null;
    
    @Column(name = "DueDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date dueDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "RefNo")
    private String refNo = "";
    
    @Column(name = "Remark")
    private String remark = "";
    
    @Column(name = "TotalTransactionAmount")
    private BigDecimal totalTransactionAmount = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "DiscountPercent")
    private BigDecimal discountPercent = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "DiscountAmount")
    private BigDecimal discountAmount = new BigDecimal(BigInteger.ZERO);
   
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DiscountChartOfAccountCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private ChartOfAccount discountChartOfAccount = null;
    
    @Column(name = "DiscountDescription")
    private String discountDescription = "";
    
    @Column(name = "DownPaymentAmount")
    private BigDecimal downPaymentAmount = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "VatPercent")
    private BigDecimal vatPercent = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "VatAmount")
    private BigDecimal vatAmount = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "GrandTotalAmount")
    private BigDecimal grandTotalAmount = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "PaidAmount")
    private BigDecimal paidAmount=new BigDecimal("0.00");
    
    @Column(name = "OtherFeeAmount")
    private BigDecimal otherFeeAmount = new BigDecimal("0.0000");
 
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "OtherFeeChartOfAccountCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private ChartOfAccount otherFeeChartOfAccount = null;
    
    @Column(name = "OtherFeeDescription")
    private String otherFeeDescription = "";
    
    @Column(name = "SettlementDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date settlementDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "SettlementDocumentNo")
    private String settlementDocumentNo="";
    
    @Column (name="TaxBaseSubTotalAmount")
    private BigDecimal subTotalAmount = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "VendorInvoiceNo")
    private String vendorInvoiceNo = "";
    
    @Column(name = "VendorInvoiceDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date vendorInvoiceDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "VendorTaxInvoiceNo")
    private String vendorTaxInvoiceNo = "";
    
    @Column(name = "VendorTaxInvoiceDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date vendorTaxInvoiceDate = DateUtils.newDate(1900, 01, 01);
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public PaymentTerm getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(PaymentTerm paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getVendorTaxInvoiceNo() {
        return vendorTaxInvoiceNo;
    }

    public void setVendorTaxInvoiceNo(String vendorTaxInvoiceNo) {
        this.vendorTaxInvoiceNo = vendorTaxInvoiceNo;
    }

    public Date getVendorTaxInvoiceDate() {
        return vendorTaxInvoiceDate;
    }

    public void setVendorTaxInvoiceDate(Date vendorTaxInvoiceDate) {
        this.vendorTaxInvoiceDate = vendorTaxInvoiceDate;
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

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getDownPaymentAmount() {
        return downPaymentAmount;
    }

    public void setDownPaymentAmount(BigDecimal downPaymentAmount) {
        this.downPaymentAmount = downPaymentAmount;
    }

    public BigDecimal getVatPercent() {
        return vatPercent;
    }

    public void setVatPercent(BigDecimal vatPercent) {
        this.vatPercent = vatPercent;
    }

    public BigDecimal getVatAmount() {
        return vatAmount;
    }

    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }

    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
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

    public String getVendorInvoiceNo() {
        return vendorInvoiceNo;
    }

    public void setVendorInvoiceNo(String vendorInvoiceNo) {
        this.vendorInvoiceNo = vendorInvoiceNo;
    }

    public Date getVendorInvoiceDate() {
        return vendorInvoiceDate;
    }

    public void setVendorInvoiceDate(Date vendorInvoiceDate) {
        this.vendorInvoiceDate = vendorInvoiceDate;
    }

    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Date getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(Date settlementDate) {
        this.settlementDate = settlementDate;
    }

    public String getSettlementDocumentNo() {
        return settlementDocumentNo;
    }

    public void setSettlementDocumentNo(String settlementDocumentNo) {
        this.settlementDocumentNo = settlementDocumentNo;
    }

    public BigDecimal getSubTotalAmount() {
        return subTotalAmount;
    }

    public void setSubTotalAmount(BigDecimal subTotalAmount) {
        this.subTotalAmount = subTotalAmount;
    }
    
    public ChartOfAccount getDiscountChartOfAccount() {
        return discountChartOfAccount;
    }

    public void setDiscountChartOfAccount(ChartOfAccount discountChartOfAccount) {
        this.discountChartOfAccount = discountChartOfAccount;
    }

    public String getDiscountDescription() {
        return discountDescription;
    }

    public void setDiscountDescription(String discountDescription) {
        this.discountDescription = discountDescription;
    }

    public BigDecimal getOtherFeeAmount() {
        return otherFeeAmount;
    }

    public void setOtherFeeAmount(BigDecimal otherFeeAmount) {
        this.otherFeeAmount = otherFeeAmount;
    }

    public ChartOfAccount getOtherFeeChartOfAccount() {
        return otherFeeChartOfAccount;
    }

    public void setOtherFeeChartOfAccount(ChartOfAccount otherFeeChartOfAccount) {
        this.otherFeeChartOfAccount = otherFeeChartOfAccount;
    }

    public String getOtherFeeDescription() {
        return otherFeeDescription;
    }

    public void setOtherFeeDescription(String otherFeeDescription) {
        this.otherFeeDescription = otherFeeDescription;
    }

    
}
