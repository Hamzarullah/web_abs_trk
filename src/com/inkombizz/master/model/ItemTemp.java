
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;


public class ItemTemp {
    
    private String code="";
    private String name="";
    private String itemProductSubCategoryCode = "";
    private String itemProductSubCategoryName = "";
    private String itemDivisionCode = "";
    private String itemDivisionName = "";
    private String unitOfMeasureCode = "";
    private String unitOfMeasureName = "";
    private String size = "";
    private String inventoryType = "";
    private String inventoryCategory = "";
    private BigDecimal minStock = new BigDecimal("0");
    private BigDecimal maxStock = new BigDecimal("0");
    private BigDecimal onHandStock = new BigDecimal("0");
    private BigDecimal standardWeight = new BigDecimal("0");
    private BigDecimal actualWeight = new BigDecimal("0");
    private BigDecimal cogsIDR = new BigDecimal("0");
    private String remark = "";
    private boolean activeStatus = false;
    private boolean packageStatus = false;
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1990, 01, 01);
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

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

    public String getItemProductSubCategoryCode() {
        return itemProductSubCategoryCode;
    }

    public void setItemProductSubCategoryCode(String itemProductSubCategoryCode) {
        this.itemProductSubCategoryCode = itemProductSubCategoryCode;
    }

    public String getItemProductSubCategoryName() {
        return itemProductSubCategoryName;
    }

    public void setItemProductSubCategoryName(String itemProductSubCategoryName) {
        this.itemProductSubCategoryName = itemProductSubCategoryName;
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

//    public String getItemBrandName() {
//        return itemBrandName;
//    }
//
//    public void setItemBrandName(String itemBrandName) {
//        this.itemBrandName = itemBrandName;
//    }

    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
    }

    public String getInventoryCategory() {
        return inventoryCategory;
    }

    public void setInventoryCategory(String inventoryCategory) {
        this.inventoryCategory = inventoryCategory;
    }
    
    public BigDecimal getMinStock() {
        return minStock;
    }

    public void setMinStock(BigDecimal minStock) {
        this.minStock = minStock;
    }

    public BigDecimal getMaxStock() {
        return maxStock;
    }

    public void setMaxStock(BigDecimal maxStock) {
        this.maxStock = maxStock;
    }

    public BigDecimal getOnHandStock() {
        return onHandStock;
    }

    public void setOnHandStock(BigDecimal onHandStock) {
        this.onHandStock = onHandStock;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public BigDecimal getStandardWeight() {
        return standardWeight;
    }

    public void setStandardWeight(BigDecimal standardWeight) {
        this.standardWeight = standardWeight;
    }

    public BigDecimal getActualWeight() {
        return actualWeight;
    }

    public void setActualWeight(BigDecimal actualWeight) {
        this.actualWeight = actualWeight;
    }

    public BigDecimal getCogsIDR() {
        return cogsIDR;
    }

    public void setCogsIDR(BigDecimal cogsIDR) {
        this.cogsIDR = cogsIDR;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }
    
    public boolean isPackageStatus() {
        return packageStatus;
    }

    public void setPackageStatus(boolean packageStatus) {
        this.packageStatus = packageStatus;
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
    
    
}