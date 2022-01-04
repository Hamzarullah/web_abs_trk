
package com.inkombizz.sales.model;

import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.Project;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.SalesPerson;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
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
@Table(name = "sal_request_for_quotation")
public class RequestForQuotation implements Serializable {
    
    private String code = "";
    private String rfqNo = "";
    private String revision ="";
    private String refRfqCode= "";
    private String tenderNo = "";
    private String OrderStatus = "BLANKET_ORDER";
    private Branch branch = null;
    private Date transactionDate = DateUtils.newDate(1990, 01, 01);
    private Date registeredDate = DateUtils.newDate(1990, 01, 01);
    private boolean reviewedStatus = false;
    private Date preBidMeeting;
    private Date sendToFactoryDate = DateUtils.newDate(1990, 01, 01);
    private Date submittedDateToCustomer = DateUtils.newDate(1990, 01, 01);
    private String scopeOfSupply = "";
    private Currency currency = null;
    private Customer customer = null;
    private Customer endUser = null;
    private String attn = "";
    private SalesPerson salesPerson = null;
    private Project project = null;
    private String subject = "";
    private String refNo = "";
    private String remark = "";
    private boolean validStatus = true;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1990, 01, 01);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1990, 01, 01);
    private String approvalStatus = "PENDING";
    private Date approvalDate = DateUtils.newDate(1990, 01, 01);
    private String approvalBy = "";
    private Reason approvalReason = null;
    private String approvalRemark = "";
    private String closingStatus="OPEN";
    private String closingBy = "";
    private Date closingDate= DateUtils.newDate(1900, 1, 1);
    private String preventiveAction = "";
    
    @Id
    @Column(name = "Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "RFQNo")
    public String getRfqNo() {
        return rfqNo;
    }

    public void setRfqNo(String rfqNo) {
        this.rfqNo = rfqNo;
    }

    @Column(name = "Revision")
    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    @Column(name = "RefRFQCode")
    public String getRefRfqCode() {
        return refRfqCode;
    }

    public void setRefRfqCode(String refRfqCode) {
        this.refRfqCode = refRfqCode;
    }

    @Column(name = "TenderNo")
    public String getTenderNo() {
        return tenderNo;
    }

    public void setTenderNo(String tenderNo) {
        this.tenderNo = tenderNo;
    }

    @Column(name = "OrderStatus")
    public String getOrderStatus() {
        return OrderStatus;
    }

    public void setOrderStatus(String OrderStatus) {
        this.OrderStatus = OrderStatus;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
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

    @Column(name = "RegisteredDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getRegisteredDate() {
        return registeredDate;
    }

    public void setRegisteredDate(Date registeredDate) {
        this.registeredDate = registeredDate;
    }

    @Column(name = "ReviewedStatus")
    public boolean isReviewedStatus() {
        return reviewedStatus;
    }

    public void setReviewedStatus(boolean reviewedStatus) {
        this.reviewedStatus = reviewedStatus;
    }

    @Column(name = "PreBidMeetingDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getPreBidMeeting() {
        return preBidMeeting;
    }

    public void setPreBidMeeting(Date preBidMeeting) {
        this.preBidMeeting = preBidMeeting;
    }

    @Column(name = "SendToFactoryDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getSendToFactoryDate() {
        return sendToFactoryDate;
    }

    public void setSendToFactoryDate(Date sendToFactoryDate) {
        this.sendToFactoryDate = sendToFactoryDate;
    }

    @Column(name = "SubmittedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getSubmittedDateToCustomer() {
        return submittedDateToCustomer;
    }

    public void setSubmittedDateToCustomer(Date submittedDateToCustomer) {
        this.submittedDateToCustomer = submittedDateToCustomer;
    }

    @Column(name = "ScopeOfSupply")
    public String getScopeOfSupply() {
        return scopeOfSupply;
    }

    public void setScopeOfSupply(String scopeOfSupply) {
        this.scopeOfSupply = scopeOfSupply;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CustomerCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "EndUserCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Customer getEndUser() {
        return endUser;
    }

    public void setEndUser(Customer endUser) {
        this.endUser = endUser;
    }

    @Column(name = "Attn")
    public String getAttn() {
        return attn;
    }

    public void setAttn(String attn) {
        this.attn = attn;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesPersonCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public SalesPerson getSalesPerson() {
        return salesPerson;
    }

    public void setSalesPerson(SalesPerson salesPerson) {
        this.salesPerson = salesPerson;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ProjectCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Column(name = "Subject")
    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
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

    @Column(name = "ValidStatus")
    public boolean isValidStatus() {
        return validStatus;
    }

    public void setValidStatus(boolean validStatus) {
        this.validStatus = validStatus;
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
    
    @Column(name = "ApprovalStatus")
    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    @Column(name = "ApprovalDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    @Column(name = "ApprovalBy")
    public String getApprovalBy() {
        return approvalBy;
    }

    public void setApprovalBy(String approvalBy) {
        this.approvalBy = approvalBy;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ApprovalReasonCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public Reason getApprovalReason() {
        return approvalReason;
    }

    public void setApprovalReason(Reason approvalReason) {
        this.approvalReason = approvalReason;
    }

    @Column(name = "ApprovalRemark")
    public String getApprovalRemark() {
        return approvalRemark;
    }

    public void setApprovalRemark(String approvalRemark) {
        this.approvalRemark = approvalRemark;
    }

    @Column(name = "ClosingStatus")
    public String getClosingStatus() {
        return closingStatus;
    }

    public void setClosingStatus(String closingStatus) {
        this.closingStatus = closingStatus;
    }

    @Column(name = "ClosingBy")
    public String getClosingBy() {
        return closingBy;
    }

    public void setClosingBy(String closingBy) {
        this.closingBy = closingBy;
    }

    @Column(name = "ClosingDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)    
    public Date getClosingDate() {
        return closingDate;
    }

    public void setClosingDate(Date closingDate) {
        this.closingDate = closingDate;
    }

    @Column(name = "PreventiveAction")
    public String getPreventiveAction() {
        return preventiveAction;
    }

    public void setPreventiveAction(String preventiveAction) {
        this.preventiveAction = preventiveAction;
    }
    
    
   
}
