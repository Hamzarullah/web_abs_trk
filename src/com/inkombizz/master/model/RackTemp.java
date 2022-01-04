
package com.inkombizz.master.model;

//import java.math.BigDecimal;
//import java.math.BigInteger;
import java.util.Date;


public class RackTemp {
    
    private String code;
    private String name;
    private String warehouseCode;
    private String warehouseName;
    private String rackCategory;
    private String remark;
    private String unitOfMeasureCode;
    private String unitOfMeasureName;
    private String inActiveBy;
    private Date inActiveDate;
    private Boolean activeStatus=false;
    private String createdBy;
    private Date createdDate;
    private String updatedBy;
    private Date updatedDate;
    private String dockInCode="";
    private String dockDlnCode="";

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

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getUnitOfMeasureCode() {
        return unitOfMeasureCode;
    }

    public void setUnitOfMeasureCode(String unitOfMeasureCode) {
        this.unitOfMeasureCode = unitOfMeasureCode;
    }

    public String getUnitOfMeasureName() {
        return unitOfMeasureName;
    }

    public void setUnitOfMeasureName(String unitOfMeasureName) {
        this.unitOfMeasureName = unitOfMeasureName;
    }

//    public BigDecimal getRackCapacity() {
//        return rackCapacity;
//    }
//
//    public void setRackCapacity(BigDecimal rackCapacity) {
//        this.rackCapacity = rackCapacity;
//    }

    public String getRackCategory() {
        return rackCategory;
    }

    public void setRackCategory(String rackCategory) {
        this.rackCategory = rackCategory;
    }

    public String getDockInCode() {
        return dockInCode;
    }

    public void setDockInCode(String dockInCode) {
        this.dockInCode = dockInCode;
    }

    public String getDockDlnCode() {
        return dockDlnCode;
    }

    public void setDockDlnCode(String dockDlnCode) {
        this.dockDlnCode = dockDlnCode;
    }
    

}
