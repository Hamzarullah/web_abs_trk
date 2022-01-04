
package com.inkombizz.master.model;

import java.io.Serializable;
import com.inkombizz.utils.DateUtils;
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
@Table(name = "mst_bank_account")
public class BankAccount implements Serializable{
    
    private String code = "";
    private String name = "";
    private String acNo = "";
    private String acName = "";
    private Bank bank =null;
    private String bankBranch = "";
    private String bbmVoucherNo = "";
    private String bbkVoucherNo = "";
    private ChartOfAccount chartOfAccount=null;
    private String remark="";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private boolean activeStatus=false;
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

    
    @Column(name = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
    @Column(name = "ACNo")
    public String getAcNo() {
        return acNo;
    }

    public void setAcNo(String acNo) {
        this.acNo = acNo;
    }

    
    @Column(name = "ACName")
    public String getAcName() {
        return acName;
    }

    public void setAcName(String acName) {
        this.acName = acName;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BankCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Bank getBank() {
        return bank;
    }

    public void setBank(Bank bank) {
        this.bank = bank;
    }

    
    @Column(name = "BankBranch")
    public String getBankBranch() {
        return bankBranch;
    }

    public void setBankBranch(String bankBranch) {
        this.bankBranch = bankBranch;
    }


    @Column(name = "BBMVoucherNo")
    public String getBbmVoucherNo() {
        return bbmVoucherNo;
    }

    public void setBbmVoucherNo(String bbmVoucherNo) {
        this.bbmVoucherNo = bbmVoucherNo;
    }

    
    @Column(name = "BBKVoucherNo")
    public String getBbkVoucherNo() {
        return bbkVoucherNo;
    }

    public void setBbkVoucherNo(String bbkVoucherNo) {
        this.bbkVoucherNo = bbkVoucherNo;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ChartOfAccountCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public ChartOfAccount getChartOfAccount() {
        return chartOfAccount;
    }

    public void setChartOfAccount(ChartOfAccount chartOfAccount) {
        this.chartOfAccount = chartOfAccount;
    }

     @Column(name = "Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

     @Column(name = "InActiveBy")
    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }

    @Column (name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
    }
    
    
    @Column (name = "ActiveStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }


    @Column (name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    
    @Column (name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    
    @Column (name = "UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    
    @Column (name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    
 
    
    
}
