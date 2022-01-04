
package com.inkombizz.purchasing.model;


import com.inkombizz.action.BaseSession;
import com.inkombizz.common.BaseEntity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumClosingStatus;
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

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.PaymentTerm;
import com.inkombizz.master.model.PurchaseDestination;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.Vendor;
import javax.persistence.Transient;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity 
@Table(name = "pur_purchase_order")
public class PurchaseOrder extends BaseEntity implements Serializable{
    
    @Id
    @Column(name = "code")
    private String code="";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch = null;
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate;
    
    @Column(name = "DeliveryDateStart")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date deliveryDateStart;
    
    @Column(name = "DeliveryDateEnd")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date deliveryDateEnd;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PaymentTermCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private PaymentTerm paymentTerm = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Currency currency = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Vendor vendor = null;   
    
    @Column(name="PenaltyStatus")
    private boolean penaltyStatus = false;   
    
    @Column(name="PenaltyPercent")
    private BigDecimal penaltyPercent = new BigDecimal("0.00");
    
    @Column(name="MaximumPenaltyPercent")
    private BigDecimal maximumPenaltyPercent = new BigDecimal("0.00"); 
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BillToCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private PurchaseDestination billTo = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ShipToCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private PurchaseDestination shipTo = null;
    
    @Column(name = "RefNo")
    private String refNo = "";
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "TotalTransactionAmount")
    private BigDecimal totalTransactionAmount = new BigDecimal("0.00");
    
    @Column(name = "DiscountPercent")
    private BigDecimal discountPercent = new BigDecimal("0.00");
    
    @Column(name = "DiscountAmount")
    private BigDecimal discountAmount = new BigDecimal("0.00");
    
    @Column(name = "DiscountDescription")
    private String discountDescription = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DiscountChartOfAccountCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private ChartOfAccount discountChartOfAccount=null;
    
    @Column(name = "TaxBaseSubTotalAmount")
    private BigDecimal taxBaseSubTotalAmount=new BigDecimal("0.00");
    
    @Column(name = "VatPercent")
    private BigDecimal vatPercent = new BigDecimal("0.00");
    
    @Column(name = "VatAmount")
    private BigDecimal vatAmount = new BigDecimal("0.00");
    
    @Column(name = "OtherFeeAmount")
    private BigDecimal otherFeeAmount = new BigDecimal("0.00");
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "OtherFeeChartOfAccountCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private ChartOfAccount otherFeeChartOfAccount=null;
    
    @Column(name = "OtherFeeDescription")
    private String otherFeeDescription = "";
    
    @Column(name = "GrandTotalAmount")
    private BigDecimal grandTotalAmount = new BigDecimal("0.00");
    
    @Column(name = "ApprovalStatus")
    private String approvalStatus=EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.PENDING);
    
    @Column(name = "ApprovalDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date approvalDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "ApprovalBy")
    private String approvalBy="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ApprovalReasonCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private Reason approvalReason=null;
    
    @Column(name = "ApprovalRemark")
    private String approvalRemark="";
    
    @Column(name = "ClosingStatus")
    private String closingStatus=EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.OPEN);
    
    @Column(name = "ClosingDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date closingDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "ClosingBy")
    private String closingBy="";
    
//    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
//    @JoinColumn (name = "ClosingReasonCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
//    private Reason closingReason=null;
    
    @Column(name = "ClosingRemark")
    private String closingRemark="";
    
    
    private @Transient String grnNo="";
    private @Transient String grnConfirmation="";
    private @Transient String branchCode="";
    private @Transient String branchName="";
    private @Transient String vendorCode="";
    private @Transient String vendorName="";
    private @Transient String vendorDefaultContactPersonCode="";
    private @Transient String vendorDefaultContactPersonName="";
    private @Transient String vendorLocalImport="";
    private @Transient String vendorAddress="";
    private @Transient String vendorPhone1="";
    private @Transient String vendorPhone2="";
    private @Transient String currencyCode="";
    private @Transient String currencyName="";
    private @Transient String paymentTermCode="";
    private @Transient String paymentTermName="";
    private @Transient String paymentTermDays="";
    private @Transient String npwp="";
    private @Transient String billToCode="";
    private @Transient String billToName="";
    private @Transient String billToAddress="";
    private @Transient String billToContactPerson="";
    private @Transient String billToPhone="";
    private @Transient String shipToCode="";
    private @Transient String shipToName="";
    private @Transient String shipToAddress="";
    private @Transient String shipToContactPerson="";
    private @Transient String shipToPhone="";
    private @Transient String deliveryDateStartTemp="";
    private @Transient String deliveryDateEndTemp="";
    private @Transient String approvalReasonCode="";
    private @Transient String approvalReasonName="";
    private @Transient String discountChartOfAccountCode="";
    private @Transient String discountChartOfAccountName="";
    private @Transient String otherFeeChartOfAccountCode="";
    private @Transient String otherFeeChartOfAccountName="";
    private @Transient Date transactionFirstDate= DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private @Transient Date transactionLastDate= DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);

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

    public Date getDeliveryDateStart() {
        return deliveryDateStart;
    }

    public void setDeliveryDateStart(Date deliveryDateStart) {
        this.deliveryDateStart = deliveryDateStart;
    }

    public Date getDeliveryDateEnd() {
        return deliveryDateEnd;
    }

    public void setDeliveryDateEnd(Date deliveryDateEnd) {
        this.deliveryDateEnd = deliveryDateEnd;
    }

    public PaymentTerm getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(PaymentTerm paymentTerm) {
        this.paymentTerm = paymentTerm;
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

    public boolean isPenaltyStatus() {
        return penaltyStatus;
    }

    public void setPenaltyStatus(boolean penaltyStatus) {
        this.penaltyStatus = penaltyStatus;
    }

    public BigDecimal getPenaltyPercent() {
        return penaltyPercent;
    }

    public void setPenaltyPercent(BigDecimal penaltyPercent) {
        this.penaltyPercent = penaltyPercent;
    }

    public BigDecimal getMaximumPenaltyPercent() {
        return maximumPenaltyPercent;
    }

    public void setMaximumPenaltyPercent(BigDecimal maximumPenaltyPercent) {
        this.maximumPenaltyPercent = maximumPenaltyPercent;
    }

    public PurchaseDestination getBillTo() {
        return billTo;
    }

    public void setBillTo(PurchaseDestination billTo) {
        this.billTo = billTo;
    }

    public PurchaseDestination getShipTo() {
        return shipTo;
    }

    public void setShipTo(PurchaseDestination shipTo) {
        this.shipTo = shipTo;
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

    public String getDiscountDescription() {
        return discountDescription;
    }

    public void setDiscountDescription(String discountDescription) {
        this.discountDescription = discountDescription;
    }

    public ChartOfAccount getDiscountChartOfAccount() {
        return discountChartOfAccount;
    }

    public void setDiscountChartOfAccount(ChartOfAccount discountChartOfAccount) {
        this.discountChartOfAccount = discountChartOfAccount;
    }

    public BigDecimal getTaxBaseSubTotalAmount() {
        return taxBaseSubTotalAmount;
    }

    public void setTaxBaseSubTotalAmount(BigDecimal taxBaseSubTotalAmount) {
        this.taxBaseSubTotalAmount = taxBaseSubTotalAmount;
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

    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getApprovalBy() {
        return approvalBy;
    }

    public void setApprovalBy(String approvalBy) {
        this.approvalBy = approvalBy;
    }

    public Reason getApprovalReason() {
        return approvalReason;
    }

    public void setApprovalReason(Reason approvalReason) {
        this.approvalReason = approvalReason;
    }

    public String getApprovalRemark() {
        return approvalRemark;
    }

    public void setApprovalRemark(String approvalRemark) {
        this.approvalRemark = approvalRemark;
    }

    public String getClosingStatus() {
        return closingStatus;
    }

    public void setClosingStatus(String closingStatus) {
        this.closingStatus = closingStatus;
    }

    public Date getClosingDate() {
        return closingDate;
    }

    public void setClosingDate(Date closingDate) {
        this.closingDate = closingDate;
    }

    public String getClosingBy() {
        return closingBy;
    }

    public void setClosingBy(String closingBy) {
        this.closingBy = closingBy;
    }

//    public Reason getClosingReason() {
//        return closingReason;
//    }
//
//    public void setClosingReason(Reason closingReason) {
//        this.closingReason = closingReason;
//    }

    public String getClosingRemark() {
        return closingRemark;
    }

    public void setClosingRemark(String closingRemark) {
        this.closingRemark = closingRemark;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getPaymentTermCode() {
        return paymentTermCode;
    }

    public void setPaymentTermCode(String paymentTermCode) {
        this.paymentTermCode = paymentTermCode;
    }

    public String getPaymentTermName() {
        return paymentTermName;
    }

    public void setPaymentTermName(String paymentTermName) {
        this.paymentTermName = paymentTermName;
    }

    public Date getTransactionFirstDate() {
        return transactionFirstDate;
    }

    public void setTransactionFirstDate(Date transactionFirstDate) {
        this.transactionFirstDate = transactionFirstDate;
    }

    public Date getTransactionLastDate() {
        return transactionLastDate;
    }

    public void setTransactionLastDate(Date transactionLastDate) {
        this.transactionLastDate = transactionLastDate;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    public String getVendorName() {
        return vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
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

    public String getVendorDefaultContactPersonName() {
        return vendorDefaultContactPersonName;
    }

    public void setVendorDefaultContactPersonName(String vendorDefaultContactPersonName) {
        this.vendorDefaultContactPersonName = vendorDefaultContactPersonName;
    }

    public String getVendorLocalImport() {
        return vendorLocalImport;
    }

    public void setVendorLocalImport(String vendorLocalImport) {
        this.vendorLocalImport = vendorLocalImport;
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

    public String getBillToAddress() {
        return billToAddress;
    }

    public void setBillToAddress(String billToAddress) {
        this.billToAddress = billToAddress;
    }

    public String getBillToContactPerson() {
        return billToContactPerson;
    }

    public void setBillToContactPerson(String billToContactPerson) {
        this.billToContactPerson = billToContactPerson;
    }

    public String getBillToPhone() {
        return billToPhone;
    }

    public void setBillToPhone(String billToPhone) {
        this.billToPhone = billToPhone;
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

    public String getShipToAddress() {
        return shipToAddress;
    }

    public void setShipToAddress(String shipToAddress) {
        this.shipToAddress = shipToAddress;
    }

    public String getShipToContactPerson() {
        return shipToContactPerson;
    }

    public void setShipToContactPerson(String shipToContactPerson) {
        this.shipToContactPerson = shipToContactPerson;
    }

    public String getShipToPhone() {
        return shipToPhone;
    }

    public void setShipToPhone(String shipToPhone) {
        this.shipToPhone = shipToPhone;
    }

    public String getDiscountChartOfAccountCode() {
        return discountChartOfAccountCode;
    }

    public void setDiscountChartOfAccountCode(String discountChartOfAccountCode) {
        this.discountChartOfAccountCode = discountChartOfAccountCode;
    }

    public String getDiscountChartOfAccountName() {
        return discountChartOfAccountName;
    }

    public void setDiscountChartOfAccountName(String discountChartOfAccountName) {
        this.discountChartOfAccountName = discountChartOfAccountName;
    }

    public String getOtherFeeChartOfAccountCode() {
        return otherFeeChartOfAccountCode;
    }

    public void setOtherFeeChartOfAccountCode(String otherFeeChartOfAccountCode) {
        this.otherFeeChartOfAccountCode = otherFeeChartOfAccountCode;
    }

    public String getOtherFeeChartOfAccountName() {
        return otherFeeChartOfAccountName;
    }

    public void setOtherFeeChartOfAccountName(String otherFeeChartOfAccountName) {
        this.otherFeeChartOfAccountName = otherFeeChartOfAccountName;
    }

    public String getDeliveryDateStartTemp() {
        return deliveryDateStartTemp;
    }

    public void setDeliveryDateStartTemp(String deliveryDateStartTemp) {
        this.deliveryDateStartTemp = deliveryDateStartTemp;
    }

    public String getDeliveryDateEndTemp() {
        return deliveryDateEndTemp;
    }

    public void setDeliveryDateEndTemp(String deliveryDateEndTemp) {
        this.deliveryDateEndTemp = deliveryDateEndTemp;
    }

    public String getApprovalReasonCode() {
        return approvalReasonCode;
    }

    public void setApprovalReasonCode(String approvalReasonCode) {
        this.approvalReasonCode = approvalReasonCode;
    }

    public String getApprovalReasonName() {
        return approvalReasonName;
    }

    public void setApprovalReasonName(String approvalReasonName) {
        this.approvalReasonName = approvalReasonName;
    }

    public String getVendorAddress() {
        return vendorAddress;
    }

    public void setVendorAddress(String vendorAddress) {
        this.vendorAddress = vendorAddress;
    }

    public String getVendorPhone1() {
        return vendorPhone1;
    }

    public void setVendorPhone1(String vendorPhone1) {
        this.vendorPhone1 = vendorPhone1;
    }

    public String getVendorPhone2() {
        return vendorPhone2;
    }

    public void setVendorPhone2(String vendorPhone2) {
        this.vendorPhone2 = vendorPhone2;
    }

    public String getGrnNo() {
        return grnNo;
    }

    public void setGrnNo(String grnNo) {
        this.grnNo = grnNo;
    }

    public String getVendorDefaultContactPersonCode() {
        return vendorDefaultContactPersonCode;
    }

    public void setVendorDefaultContactPersonCode(String vendorDefaultContactPersonCode) {
        this.vendorDefaultContactPersonCode = vendorDefaultContactPersonCode;
    }

    public String getNpwp() {
        return npwp;
    }

    public void setNpwp(String npwp) {
        this.npwp = npwp;
    }

    public String getPaymentTermDays() {
        return paymentTermDays;
    }

    public void setPaymentTermDays(String paymentTermDays) {
        this.paymentTermDays = paymentTermDays;
    }

    public String getGrnConfirmation() {
        return grnConfirmation;
    }

    public void setGrnConfirmation(String grnConfirmation) {
        this.grnConfirmation = grnConfirmation;
    }
    
    
}
