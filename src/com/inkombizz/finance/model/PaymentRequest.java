
package com.inkombizz.finance.model;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.VendorDepositType;
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
@Table(name = "fin_payment_request")
public class PaymentRequest implements Serializable{
    
    private String code = "";
    private Branch branch = null;
    private Date transactionDate = DateUtils.newDate(1990, 1, 1);
    private Date scheduleDate = DateUtils.newDate(1990, 1, 1);
    private String transactionType = "";
    private String paymentTo = "";
    private Currency currency = null;
    private BigDecimal totalTransactionAmount = new BigDecimal("0.0000");
    private String approvalStatus = "PENDING";
    private String approvalBy = "";
    private Date approvalDate = DateUtils.newDate(1900, 1, 1);
    private String refNo = "";
    private String remark = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    private VendorDepositType vendorDepositType=null;

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

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    @Column(name = "ScheduleDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getScheduleDate() {
        return scheduleDate;
    }

    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }
    
    @Column(name = "TransactionType")
     public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    @Column(name = "PaymentTo")
    public String getPaymentTo() {
        return paymentTo;
    }

    public void setPaymentTo(String paymentTo) {
        this.paymentTo = paymentTo;
    }
    
    @Column(name = "TotalTransactionAmount")
    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }
    
    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }
    
    @Column(name = "ApprovalStatus")
    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    @Column(name = "ApprovalBy")
    public String getApprovalBy() {
        return approvalBy;
    }

    public void setApprovalBy(String approvalBy) {
        this.approvalBy = approvalBy;
    }

    @Column(name = "ApprovalDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getApprovalDate() {
        return approvalDate;
    }
    
    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
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
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorDepositTypeCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public VendorDepositType getVendorDepositType() {
        return vendorDepositType;
    }

    public void setVendorDepositType(VendorDepositType vendorDepositType) {
        this.vendorDepositType = vendorDepositType;
    }
}
