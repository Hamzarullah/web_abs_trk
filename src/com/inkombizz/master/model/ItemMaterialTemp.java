
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;


public class ItemMaterialTemp {
    private String code="";
    private String name="";
    private String itemSubCategoryCode="";
    private String itemSubCategoryName="";
    private String itemCategoryCode="";
    private String itemCategoryName="";
    private String itemDivisionCode="";
    private String itemDivisionName="";
    private String unitOfMeasureCode="";
    private String unitOfMeasureName="";
    private String itemBrandCode="";
    private String itemBrandName="";
    private BigDecimal onHandStock = new BigDecimal("0");
    private String inventoryType = "";
    private BigDecimal minStock = new BigDecimal("0");
    private BigDecimal maxStock = new BigDecimal("0");
//    private BigDecimal cogsIDR = new BigDecimal("0");
    private BigDecimal podQuantity = new BigDecimal("0");
    private BigDecimal bookingQuantity = new BigDecimal("0");
    private BigDecimal receivedQuantity = new BigDecimal("0");
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

    public String getItemSubCategoryCode() {
        return itemSubCategoryCode;
    }

    public void setItemSubCategoryCode(String itemSubCategoryCode) {
        this.itemSubCategoryCode = itemSubCategoryCode;
    }

    public String getItemSubCategoryName() {
        return itemSubCategoryName;
    }

    public void setItemSubCategoryName(String itemSubCategoryName) {
        this.itemSubCategoryName = itemSubCategoryName;
    }

    public String getItemCategoryCode() {
        return itemCategoryCode;
    }

    public void setItemCategoryCode(String itemCategoryCode) {
        this.itemCategoryCode = itemCategoryCode;
    }

    public String getItemCategoryName() {
        return itemCategoryName;
    }

    public void setItemCategoryName(String itemCategoryName) {
        this.itemCategoryName = itemCategoryName;
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

    public String getItemBrandCode() {
        return itemBrandCode;
    }

    public void setItemBrandCode(String itemBrandCode) {
        this.itemBrandCode = itemBrandCode;
    }

    public String getItemBrandName() {
        return itemBrandName;
    }

    public void setItemBrandName(String itemBrandName) {
        this.itemBrandName = itemBrandName;
    }

    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
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

    public BigDecimal getOnHandStock() {
        return onHandStock;
    }

    public void setOnHandStock(BigDecimal onHandStock) {
        this.onHandStock = onHandStock;
    }

//    public Boolean getSerialNoStatus() {
//        return serialNoStatus;
//    }
//
//    public void setSerialNoStatus(Boolean serialNoStatus) {
//        this.serialNoStatus = serialNoStatus;
//    }

    public BigDecimal getPodQuantity() {
        return podQuantity;
    }

    public void setPodQuantity(BigDecimal podQuantity) {
        this.podQuantity = podQuantity;
    }

    public BigDecimal getReceivedQuantity() {
        return receivedQuantity;
    }

    public void setReceivedQuantity(BigDecimal receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
    }

    public BigDecimal getBookingQuantity() {
        return bookingQuantity;
    }

    public void setBookingQuantity(BigDecimal bookingQuantity) {
        this.bookingQuantity = bookingQuantity;
    }
    
    
}
