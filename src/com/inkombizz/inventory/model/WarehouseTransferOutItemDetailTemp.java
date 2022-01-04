/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;

/**
 *
 * @author egie
 */
public class WarehouseTransferOutItemDetailTemp {
    
    private String code = "";
    private String headerCode = "";
    private String itemMaterialCode = "";
    private String itemMaterialName = "";
    private String itemMaterialUnitOfMeasureCode = "";
    private String itemMaterialInventoryType = "";
    private String itemBrandCode = "";
    private String itemBrandName = "";
    private BigDecimal quantity = new BigDecimal(BigInteger.ZERO);
    private BigDecimal actualStock = new BigDecimal(BigInteger.ZERO);
    private BigDecimal cogsIdr = new BigDecimal(BigInteger.ZERO);
    private BigDecimal totalAmount = new BigDecimal(BigInteger.ZERO);
    private String reasonCode = "";
    private String reasonName = "";
    private String destinationRackCode = "";
    private String destinationRackName = "";
    private String rackCode = "";
    private String rackName = "";
    private String remark = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getItemMaterialCode() {
        return itemMaterialCode;
    }

    public void setItemMaterialCode(String itemMaterialCode) {
        this.itemMaterialCode = itemMaterialCode;
    }

    public String getItemMaterialName() {
        return itemMaterialName;
    }

    public void setItemMaterialName(String itemMaterialName) {
        this.itemMaterialName = itemMaterialName;
    }

    public String getItemMaterialUnitOfMeasureCode() {
        return itemMaterialUnitOfMeasureCode;
    }

    public void setItemMaterialUnitOfMeasureCode(String itemMaterialUnitOfMeasureCode) {
        this.itemMaterialUnitOfMeasureCode = itemMaterialUnitOfMeasureCode;
    }

    public String getItemMaterialInventoryType() {
        return itemMaterialInventoryType;
    }

    public void setItemMaterialInventoryType(String itemMaterialInventoryType) {
        this.itemMaterialInventoryType = itemMaterialInventoryType;
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

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(BigDecimal cogsIdr) {
        this.cogsIdr = cogsIdr;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getReasonCode() {
        return reasonCode;
    }

    public void setReasonCode(String reasonCode) {
        this.reasonCode = reasonCode;
    }

    public String getReasonName() {
        return reasonName;
    }

    public void setReasonName(String reasonName) {
        this.reasonName = reasonName;
    }

    public String getRackCode() {
        return rackCode;
    }

    public void setRackCode(String rackCode) {
        this.rackCode = rackCode;
    }

    public String getRackName() {
        return rackName;
    }

    public void setRackName(String rackName) {
        this.rackName = rackName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public BigDecimal getActualStock() {
        return actualStock;
    }

    public void setActualStock(BigDecimal actualStock) {
        this.actualStock = actualStock;
    }

    public String getDestinationRackCode() {
        return destinationRackCode;
    }

    public void setDestinationRackCode(String destinationRackCode) {
        this.destinationRackCode = destinationRackCode;
    }

    public String getDestinationRackName() {
        return destinationRackName;
    }

    public void setDestinationRackName(String destinationRackName) {
        this.destinationRackName = destinationRackName;
    }
    
}
