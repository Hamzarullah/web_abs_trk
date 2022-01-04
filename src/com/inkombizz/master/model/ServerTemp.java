
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;


public class ServerTemp {
    
    private String code="";
    private String name="";
    private String computerName = "";
    private String ipAddress = "";
    private String brand = "";
    private String type = "";
    private BigDecimal ramCapacity = new BigDecimal(0);
    private String ramUOM = "";
    private BigDecimal hardDriveCapacity = new BigDecimal(0);
    private String hardDriveUOM = "";
    private String processor = "";
    private BigDecimal acquisitionMonth = new BigDecimal(0);
    private BigDecimal acquisitionYear = new BigDecimal(0);
    private Boolean activeStatus=false;
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private String inActiveDateTemp="";
    private String createdBy="";
    private Date createdDate=DateUtils.newDate(1900, 1, 1);;
    private String createdDateTemp="";
    private String updatedBy="";
    private Date updatedDate=DateUtils.newDate(1900, 1, 1);;
    private String updatedDateTemp="";

    
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

    public String getComputerName() {
        return computerName;
    }

    public void setComputerName(String computerName) {
        this.computerName = computerName;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getRamCapacity() {
        return ramCapacity;
    }

    public void setRamCapacity(BigDecimal ramCapacity) {
        this.ramCapacity = ramCapacity;
    }

    public String getRamUOM() {
        return ramUOM;
    }

    public void setRamUOM(String ramUOM) {
        this.ramUOM = ramUOM;
    }

    public BigDecimal getHardDriveCapacity() {
        return hardDriveCapacity;
    }

    public void setHardDriveCapacity(BigDecimal hardDriveCapacity) {
        this.hardDriveCapacity = hardDriveCapacity;
    }

    public String getHardDriveUOM() {
        return hardDriveUOM;
    }

    public void setHardDriveUOM(String hardDriveUOM) {
        this.hardDriveUOM = hardDriveUOM;
    }

    public String getProcessor() {
        return processor;
    }

    public void setProcessor(String processor) {
        this.processor = processor;
    }

    public BigDecimal getAcquisitionMonth() {
        return acquisitionMonth;
    }

    public void setAcquisitionMonth(BigDecimal acquisitionMonth) {
        this.acquisitionMonth = acquisitionMonth;
    }

    public BigDecimal getAcquisitionYear() {
        return acquisitionYear;
    }

    public void setAcquisitionYear(BigDecimal acquisitionYear) {
        this.acquisitionYear = acquisitionYear;
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

    public String getUpdatedDateTemp() {
        return updatedDateTemp;
    }

    public void setUpdatedDateTemp(String updatedDateTemp) {
        this.updatedDateTemp = updatedDateTemp;
    }

    
}
