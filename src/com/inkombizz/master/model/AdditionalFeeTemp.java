
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;


public class AdditionalFeeTemp {
    
    private String code="";
    private String name="";
    private String purchaseChartOfAccountCode = "";
    private String purchaseChartOfAccountName = "";
    private String salesChartOfAccountCode = "";
    private String salesChartOfAccountName = "";
    private boolean purchaseStatus =false;
    private boolean salesStatus =false;
    private Boolean activeStatus=false;
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private String inActiveDateTemp="";
    private String createdBy="";
    private Date createdDate=DateUtils.newDate(1900, 1, 1);;
    private String createdDateTemp="";

    
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

    public String getPurchaseChartOfAccountCode() {
        return purchaseChartOfAccountCode;
    }

    public void setPurchaseChartOfAccountCode(String purchaseChartOfAccountCode) {
        this.purchaseChartOfAccountCode = purchaseChartOfAccountCode;
    }

    public String getPurchaseChartOfAccountName() {
        return purchaseChartOfAccountName;
    }

    public void setPurchaseChartOfAccountName(String purchaseChartOfAccountName) {
        this.purchaseChartOfAccountName = purchaseChartOfAccountName;
    }

    public String getSalesChartOfAccountCode() {
        return salesChartOfAccountCode;
    }

    public void setSalesChartOfAccountCode(String salesChartOfAccountCode) {
        this.salesChartOfAccountCode = salesChartOfAccountCode;
    }

    public String getSalesChartOfAccountName() {
        return salesChartOfAccountName;
    }

    public void setSalesChartOfAccountName(String salesChartOfAccountName) {
        this.salesChartOfAccountName = salesChartOfAccountName;
    }

    public boolean isPurchaseStatus() {
        return purchaseStatus;
    }

    public void setPurchaseStatus(boolean purchaseStatus) {
        this.purchaseStatus = purchaseStatus;
    }

    public boolean isSalesStatus() {
        return salesStatus;
    }

    public void setSalesStatus(boolean salesStatus) {
        this.salesStatus = salesStatus;
    }

    public Boolean getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(Boolean activeStatus) {
        this.activeStatus = activeStatus;
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

    public String getInActiveDateTemp() {
        return inActiveDateTemp;
    }

    public void setInActiveDateTemp(String inActiveDateTemp) {
        this.inActiveDateTemp = inActiveDateTemp;
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

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }

    
}
