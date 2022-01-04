
package com.inkombizz.finance.model;
import com.inkombizz.master.model.AssetRegistration;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.PaymentTerm;
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
@Table(name = "fin_vendor_credit_note")
public class VendorCreditNote implements Serializable{
    
    private String code="";
    private Branch branch=null;
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private Date dueDate= DateUtils.newDate(1900, 1, 1);
    private Currency currency=null;
    private BigDecimal exchangeRate=new BigDecimal("0.00");
    private Vendor vendor=null;
    private String taxInvoiceNo="";
    private Date taxInvoiceDate= DateUtils.newDate(1900, 1, 1);
    private String vendorInvoiceNo="";
    private Date vendorInvoiceDate= DateUtils.newDate(1900, 1, 1);
    private String refNo="";
    private String remark="";
    private PaymentTerm paymentTerm = null;
    private BigDecimal totalTransactionAmount=new BigDecimal("0.00");
    private BigDecimal discountPercent=new BigDecimal("0.00");
    private BigDecimal discountAmount=new BigDecimal("0.00");
    private ChartOfAccount discountAccount = null;
    private BigDecimal vatPercent=new BigDecimal("0.00");
    private BigDecimal vatAmount=new BigDecimal("0.00");
    private BigDecimal grandTotalAmount=new BigDecimal("0.00");
    private BigDecimal paidAmount=new BigDecimal("0.00");
    private Date settlementDate= DateUtils.newDate(1900, 1, 1);
    private String settlementDocumentNo="";
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
    @JoinColumn (name = "VendorCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    @Column(name = "TaxInvoiceNo")
    public String getTaxInvoiceNo() {
        return taxInvoiceNo;
    }

    public void setTaxInvoiceNo(String taxInvoiceNo) {
        this.taxInvoiceNo = taxInvoiceNo;
    }

    @Column(name = "TaxInvoiceDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getTaxInvoiceDate() {
        return taxInvoiceDate;
    }

    public void setTaxInvoiceDate(Date taxInvoiceDate) {
        this.taxInvoiceDate = taxInvoiceDate;
    }

    @Column(name = "VendorInvoiceNo")
    public String getVendorInvoiceNo() {
        return vendorInvoiceNo;
    }

    public void setVendorInvoiceNo(String vendorInvoiceNo) {
        this.vendorInvoiceNo = vendorInvoiceNo;
    }

    @Column(name = "VendorInvoiceDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getVendorInvoiceDate() {
        return vendorInvoiceDate;
    }

    public void setVendorInvoiceDate(Date vendorInvoiceDate) {
        this.vendorInvoiceDate = vendorInvoiceDate;
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

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PaymentTermCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public PaymentTerm getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(PaymentTerm paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    @Column(name = "TotalTransactionAmount")
    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    @Column(name = "DiscountPercent")
    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    @Column(name = "DiscountAmount")
    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DiscountAccountCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public ChartOfAccount getDiscountAccount() {
        return discountAccount;
    }

    public void setDiscountAccount(ChartOfAccount discountAccount) {
        this.discountAccount = discountAccount;
    }

    @Column(name = "VATPercent")
    public BigDecimal getVatPercent() {
        return vatPercent;
    }

    public void setVatPercent(BigDecimal vatPercent) {
        this.vatPercent = vatPercent;
    }

    @Column(name = "VATAmount")
    public BigDecimal getVatAmount() {
        return vatAmount;
    }

    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }
    

    @Column(name = "GrandTotalAmount")
    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
    }

    @Column(name = "PaidAmount")
    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    @Column(name = "SettlementDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(Date settlementDate) {
        this.settlementDate = settlementDate;
    }

    @Column(name = "SettlementDocumentNo")
    public String getSettlementDocumentNo() {
        return settlementDocumentNo;
    }

    public void setSettlementDocumentNo(String settlementDocumentNo) {
        this.settlementDocumentNo = settlementDocumentNo;
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
    
    @Column(name = "DueDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    
}
