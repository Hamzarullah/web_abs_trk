
package com.inkombizz.sales.model;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Division;
import com.inkombizz.master.model.Reason;
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
import javax.persistence.Transient;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 *
 * @author ikb
 */

@Entity
@Table(name = "sal_internal_memo_material")
public class InternalMemoMaterial extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;
        
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DivisionCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
//    @NotFound(action=NotFoundAction.IGNORE)
    private Division division=null;
        
    @Column(name = "RequestBy")
    private String requestBy="";
    
    @Column(name = "RefNo")
    private String refNo="";
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "ApprovalStatus")
    private String approvalStatus="PENDING";
    
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
    private String closingStatus="OPEN";
    
    @Column(name = "ClosingDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date closingDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "ClosingBy")
    private String closingBy="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ClosingReasonCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private Reason closingReason=null;
    
    @Column(name = "ClosingRemark")
    private String closingRemark="";
    
    private @Transient String branchCode="";
    private @Transient String branchName="";
    private @Transient String divisionCode="";
    private @Transient String divisionName="";
    private @Transient String departmentCode="";
    private @Transient String departmentName="";
    private @Transient Date transactionFirstDate= DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private @Transient Date transactionLastDate= DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);

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

//    public String getDocumentType() {
//        return documentType;
//    }
//
//    public void setDocumentType(String documentType) {
//        this.documentType = documentType;
//    }

    public String getRequestBy() {
        return requestBy;
    }

    public void setRequestBy(String requestBy) {
        this.requestBy = requestBy;
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

    public Reason getClosingReason() {
        return closingReason;
    }

    public void setClosingReason(Reason closingReason) {
        this.closingReason = closingReason;
    }

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

    public Division getDivision() {
        return division;
    }

    public void setDivision(Division division) {
        this.division = division;
    }

    public String getDivisionCode() {
        return divisionCode;
    }

    public void setDivisionCode(String divisionCode) {
        this.divisionCode = divisionCode;
    }

    public String getDivisionName() {
        return divisionName;
    }

    public void setDivisionName(String divisionName) {
        this.divisionName = divisionName;
    }

    public String getDepartmentCode() {
        return departmentCode;
    }

    public void setDepartmentCode(String departmentCode) {
        this.departmentCode = departmentCode;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }
    
    
}
