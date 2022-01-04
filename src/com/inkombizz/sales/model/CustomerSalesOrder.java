package com.inkombizz.sales.model;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.BaseEntity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.master.model.Branch;
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

import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.Project;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.SalesPerson;
import javax.persistence.Transient;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "sal_customer_sales_order")
public class CustomerSalesOrder extends BaseEntity implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "CUSTSONo")
    private String custSONo="";
    
    @Column(name = "Revision")
    private String revision="00";
    
    @Column(name = "RefCUSTSOCode")
    private String refCUSTSOCode="";
    
    @Column(name = "ValidStatus")
    private boolean validStatus=true;
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "OrderType")
    private String orderType="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BlanketOrderCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private CustomerBlanketOrder customerBlanketOrder=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CustomerPurchaseOrderCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private CustomerPurchaseOrder customerPurchaseOrder=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;
    
    @Column(name = "RequestDeliveryDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date requestDeliveryDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "ExpiredDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date expiredDate= DateUtils.newDate(1900, 1, 1);
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CustomerCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Customer customer=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "EndUserCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Customer endUser = null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Currency currency=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesPersonCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private SalesPerson salesPerson = null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ProjectCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private Project project = null;
    
    @Column(name = "RefNo")
    private String refNo="";
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "RevisionRemark")
    private String revisionRemark="";
    
    @Column(name = "TotalTransactionAmount")
    private BigDecimal totalTransactionAmount=new BigDecimal("0.00");
    
    @Column(name = "DiscountPercent")
    private BigDecimal discountPercent=new BigDecimal("0.00");
    
    @Column(name = "DiscountAmount")
    private BigDecimal discountAmount=new BigDecimal("0.00");
    
    @Column(name = "TaxBaseAmount")
    private BigDecimal taxBaseAmount=new BigDecimal("0.00");
    
    @Column(name = "VATPercent")
    private BigDecimal vatPercent=new BigDecimal("0.00");
    
    @Column(name = "VATAmount")
    private BigDecimal vatAmount=new BigDecimal("0.00");
    
    @Column(name = "GrandTotalAmount")
    private BigDecimal grandTotalAmount=new BigDecimal("0.00");
    
    @Column(name = "ApprovalStatus")
    private String approvalStatus=EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.PENDING);
    
    @Column(name = "ApprovalDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date approvalDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "ApprovalBy")
    private String approvalBy = "";
    
    @Column(name = "ApprovalRemark")
    private String approvalRemark = "";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ApprovalReasonCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private Reason approvalReason = null;
    
    @Column(name = "ClosingStatus")
    private String closingStatus=EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.OPEN);
    
    @Column(name = "ClosingBy")
    private String closingBy = "";
    
    @Column(name = "ClosingDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date closingDate= DateUtils.newDate(1900, 1, 1);
    
    
    private @Transient String createdDateTemp="";
    private @Transient String customerSalesOrderCode="";
    private @Transient String customerPurchaseOrderCode="";
    private @Transient String customerPurchaseOrderReleaseCode="";
    private @Transient String customerPurchaseOrderNo="";
    private @Transient String blanketOrderCode="";
    private @Transient String custPONo="";
    private @Transient String refCUSTPOCode="";
    private @Transient String branchCode="";
    private @Transient String branchName="";
    private @Transient String customerCode="";
    private @Transient String customerName="";
    private @Transient String endUserCode="";
    private @Transient String endUserName="";
    private @Transient String currencyCode="";
    private @Transient String currencyName="";
    private @Transient String salesPersonCode="";
    private @Transient String salesPersonName="";
    private @Transient String projectCode="";
    private @Transient String projectName="";
    private @Transient String approvalReasonCode="";
    private @Transient String approvalReasonName="";
    private @Transient String validStatusSo="";
    private @Transient String orderStatus="";
    private @Transient BigDecimal totalAdditionalFeeAmount=new BigDecimal("0.00");
    private @Transient Date transactionFirstDate= DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private @Transient Date transactionLastDate= DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private @Transient String partialShipmentStatus= "YES";
    private @Transient BigDecimal retentionPercent=new BigDecimal("0");         
    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCustSONo() {
        return custSONo;
    }

    public void setCustSONo(String custSONo) {
        this.custSONo = custSONo;
    }

    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    public String getRefCUSTSOCode() {
        return refCUSTSOCode;
    }

    public void setRefCUSTSOCode(String refCUSTSOCode) {
        this.refCUSTSOCode = refCUSTSOCode;
    }

    public boolean isValidStatus() {
        return validStatus;
    }

    public void setValidStatus(boolean validStatus) {
        this.validStatus = validStatus;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public CustomerBlanketOrder getCustomerBlanketOrder() {
        return customerBlanketOrder;
    }

    public void setCustomerBlanketOrder(CustomerBlanketOrder customerBlanketOrder) {
        this.customerBlanketOrder = customerBlanketOrder;
    }

    public CustomerPurchaseOrder getCustomerPurchaseOrder() {
        return customerPurchaseOrder;
    }

    public void setCustomerPurchaseOrder(CustomerPurchaseOrder customerPurchaseOrder) {
        this.customerPurchaseOrder = customerPurchaseOrder;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public Date getRequestDeliveryDate() {
        return requestDeliveryDate;
    }

    public void setRequestDeliveryDate(Date requestDeliveryDate) {
        this.requestDeliveryDate = requestDeliveryDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Customer getEndUser() {
        return endUser;
    }

    public void setEndUser(Customer endUser) {
        this.endUser = endUser;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public SalesPerson getSalesPerson() {
        return salesPerson;
    }

    public void setSalesPerson(SalesPerson salesPerson) {
        this.salesPerson = salesPerson;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
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

    public String getRevisionRemark() {
        return revisionRemark;
    }

    public void setRevisionRemark(String revisionRemark) {
        this.revisionRemark = revisionRemark;
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

    public BigDecimal getTaxBaseAmount() {
        return taxBaseAmount;
    }

    public void setTaxBaseAmount(BigDecimal taxBaseAmount) {
        this.taxBaseAmount = taxBaseAmount;
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

    public String getApprovalRemark() {
        return approvalRemark;
    }

    public void setApprovalRemark(String approvalRemark) {
        this.approvalRemark = approvalRemark;
    }

    public Reason getApprovalReason() {
        return approvalReason;
    }

    public void setApprovalReason(Reason approvalReason) {
        this.approvalReason = approvalReason;
    }

    public String getClosingStatus() {
        return closingStatus;
    }

    public void setClosingStatus(String closingStatus) {
        this.closingStatus = closingStatus;
    }

    public String getClosingBy() {
        return closingBy;
    }

    public void setClosingBy(String closingBy) {
        this.closingBy = closingBy;
    }

    public Date getClosingDate() {
        return closingDate;
    }

    public void setClosingDate(Date closingDate) {
        this.closingDate = closingDate;
    }

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
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

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEndUserCode() {
        return endUserCode;
    }

    public void setEndUserCode(String endUserCode) {
        this.endUserCode = endUserCode;
    }

    public String getEndUserName() {
        return endUserName;
    }

    public void setEndUserName(String endUserName) {
        this.endUserName = endUserName;
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

    public String getSalesPersonCode() {
        return salesPersonCode;
    }

    public void setSalesPersonCode(String salesPersonCode) {
        this.salesPersonCode = salesPersonCode;
    }

    public String getSalesPersonName() {
        return salesPersonName;
    }

    public void setSalesPersonName(String salesPersonName) {
        this.salesPersonName = salesPersonName;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
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

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public BigDecimal getTotalAdditionalFeeAmount() {
        return totalAdditionalFeeAmount;
    }

    public void setTotalAdditionalFeeAmount(BigDecimal totalAdditionalFeeAmount) {
        this.totalAdditionalFeeAmount = totalAdditionalFeeAmount;
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

    public String getCustomerSalesOrderCode() {
        return customerSalesOrderCode;
    }

    public void setCustomerSalesOrderCode(String customerSalesOrderCode) {
        this.customerSalesOrderCode = customerSalesOrderCode;
    }

    public String getCustomerPurchaseOrderCode() {
        return customerPurchaseOrderCode;
    }

    public void setCustomerPurchaseOrderCode(String customerPurchaseOrderCode) {
        this.customerPurchaseOrderCode = customerPurchaseOrderCode;
    }

    public String getCustomerPurchaseOrderNo() {
        return customerPurchaseOrderNo;
    }

    public void setCustomerPurchaseOrderNo(String customerPurchaseOrderNo) {
        this.customerPurchaseOrderNo = customerPurchaseOrderNo;
    }

    public String getPartialShipmentStatus() {
        return partialShipmentStatus;
    }

    public void setPartialShipmentStatus(String partialShipmentStatus) {
        this.partialShipmentStatus = partialShipmentStatus;
    }

    public BigDecimal getRetentionPercent() {
        return retentionPercent;
    }

    public void setRetentionPercent(BigDecimal retentionPercent) {
        this.retentionPercent = retentionPercent;
    }

    public String getCustomerPurchaseOrderReleaseCode() {
        return customerPurchaseOrderReleaseCode;
    }

    public void setCustomerPurchaseOrderReleaseCode(String customerPurchaseOrderReleaseCode) {
        this.customerPurchaseOrderReleaseCode = customerPurchaseOrderReleaseCode;
    }

    public String getCustPONo() {
        return custPONo;
    }

    public void setCustPONo(String custPONo) {
        this.custPONo = custPONo;
    }

    public String getRefCUSTPOCode() {
        return refCUSTPOCode;
    }

    public void setRefCUSTPOCode(String refCUSTPOCode) {
        this.refCUSTPOCode = refCUSTPOCode;
    }

    public String getBlanketOrderCode() {
        return blanketOrderCode;
    }

    public void setBlanketOrderCode(String blanketOrderCode) {
        this.blanketOrderCode = blanketOrderCode;
    }

    public String getValidStatusSo() {
        return validStatusSo;
    }

    public void setValidStatusSo(String validStatusSo) {
        this.validStatusSo = validStatusSo;
    }
    
    
}