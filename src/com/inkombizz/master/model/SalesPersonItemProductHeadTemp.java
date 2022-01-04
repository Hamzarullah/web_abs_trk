package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;

public class SalesPersonItemProductHeadTemp {
    
    private String code = "";
    private String name = "";
    private String salesPersonCode = "";
    private String salesPersonName = "";
    private String itemProductHeadCode = "";
    private String itemProductHeadName = "";
    private String itemDivisionCode = "";
    private String itemDivisionName = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
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

    public String getItemProductHeadCode() {
        return itemProductHeadCode;
    }

    public void setItemProductHeadCode(String itemProductHeadCode) {
        this.itemProductHeadCode = itemProductHeadCode;
    }

    public String getItemProductHeadName() {
        return itemProductHeadName;
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

    public void setItemProductHeadName(String itemProductHeadName) {
        this.itemProductHeadName = itemProductHeadName;
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

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }

}