
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;


public class CityTemp {
    
    private String code="";
    private String name="";
    private String provinceCode="";
    private String provinceName="";
    private String provinceIslandCode="";
    private String provinceIslandName="";
    private String provinceProvinceCode="";
    private String provinceProvinceName="";
    private String provinceCountryCode="";
    private String provinceCountryName="";
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

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getProvinceIslandCode() {
        return provinceIslandCode;
    }

    public void setProvinceIslandCode(String provinceIslandCode) {
        this.provinceIslandCode = provinceIslandCode;
    }

    public String getProvinceIslandName() {
        return provinceIslandName;
    }

    public void setProvinceIslandName(String provinceIslandName) {
        this.provinceIslandName = provinceIslandName;
    }

    public String getProvinceProvinceCode() {
        return provinceProvinceCode;
    }

    public void setProvinceProvinceCode(String provinceProvinceCode) {
        this.provinceProvinceCode = provinceProvinceCode;
    }

    public String getProvinceProvinceName() {
        return provinceProvinceName;
    }

    public void setProvinceProvinceName(String provinceProvinceName) {
        this.provinceProvinceName = provinceProvinceName;
    }

    public String getProvinceCountryCode() {
        return provinceCountryCode;
    }

    public void setProvinceCountryCode(String provinceCountryCode) {
        this.provinceCountryCode = provinceCountryCode;
    }

    public String getProvinceCountryName() {
        return provinceCountryName;
    }

    public void setProvinceCountryName(String provinceCountryName) {
        this.provinceCountryName = provinceCountryName;
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
