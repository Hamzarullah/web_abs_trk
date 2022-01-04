
package com.inkombizz.master.model;

import java.util.Date;


public class BankAccountTemp {
    private String code = "";
    private String name = "";
    private String acNo = "";
    private String acName = "";
    private String bankCode = "";
    private String bankName = "";
    private String bankBranch = "";
    private String bbmVoucherNo = "";
    private String bbkVoucherNo = "";
    private String chartOfAccountCode="";
    private String chartOfAccountName="";
//    private String bbmGiroChartOfAccountCode = "";
//    private String bbmGiroChartOfAccountName = "";
//    private String bbkGiroChartOfAccountCode = "";
//    private String bbkGiroChartOfAccountName = "";
    private String remark="";
    private String inActiveBy = "";
    private Date inActiveDate;
    private boolean activeStatus=false;
    private String createdBy = "";
    private Date createdDate;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAcNo() {
        return acNo;
    }

    public void setAcNo(String acNo) {
        this.acNo = acNo;
    }

    public String getAcName() {
        return acName;
    }

    public void setAcName(String acName) {
        this.acName = acName;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankBranch() {
        return bankBranch;
    }

    public void setBankBranch(String bankBranch) {
        this.bankBranch = bankBranch;
    }

    public String getBbmVoucherNo() {
        return bbmVoucherNo;
    }

    public void setBbmVoucherNo(String bbmVoucherNo) {
        this.bbmVoucherNo = bbmVoucherNo;
    }

    public String getBbkVoucherNo() {
        return bbkVoucherNo;
    }

    public void setBbkVoucherNo(String bbkVoucherNo) {
        this.bbkVoucherNo = bbkVoucherNo;
    }

    public String getChartOfAccountCode() {
        return chartOfAccountCode;
    }

    public void setChartOfAccountCode(String chartOfAccountCode) {
        this.chartOfAccountCode = chartOfAccountCode;
    }

    public String getChartOfAccountName() {
        return chartOfAccountName;
    }

    public void setChartOfAccountName(String chartOfAccountName) {
        this.chartOfAccountName = chartOfAccountName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }

    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
    }

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
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

    
    
    
}
