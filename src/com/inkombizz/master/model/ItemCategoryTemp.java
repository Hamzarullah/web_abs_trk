
package com.inkombizz.master.model;

import java.util.Date;


public class ItemCategoryTemp {
    
    private String code;
    private String name;
    private String remark;
    private String itemDivisionCode;
    private String itemDivisionName;
    private String inactiveBy;
    private Date inactiveDate;
    private Boolean activeStatus=false;
    private String createdBy;
    private Date createdDate;
    private String updatedBy;
    private Date updatedDate;

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

    public String getInactiveBy() {
        return inactiveBy;
    }

    public void setInactiveBy(String inactiveBy) {
        this.inactiveBy = inactiveBy;
    }

    public Date getInactiveDate() {
        return inactiveDate;
    }

    public void setInactiveDate(Date inactiveDate) {
        this.inactiveDate = inactiveDate;
    }

    public Boolean getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(Boolean activeStatus) {
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

    public String getItemDivisionCode() {
        return itemDivisionCode;
    }

    public void setItemDivisionCode(String itemDivisionCode) {
        this.itemDivisionCode = itemDivisionCode;
    }

    public String getItemDivisionName() {
        return itemDivisionName;
    }

    public void setItemDivisionName(String itemDivisionName) {
        this.itemDivisionName = itemDivisionName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    

}
