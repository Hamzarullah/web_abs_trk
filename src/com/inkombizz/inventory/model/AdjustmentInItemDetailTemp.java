
package com.inkombizz.inventory.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class AdjustmentInItemDetailTemp {
    
    private String code = "";
    private String headerCode = "";
    private String itemMaterialCode = "";
    private String itemMaterialName = "";
    private String itemMaterialInventoryType = "";
    private String itemMaterialUnitOfMeasureCode = "";
    private BigDecimal quantity = new BigDecimal ("0.00");
    private BigDecimal price = new BigDecimal ("0.00");
    private BigDecimal totalAmount = new BigDecimal ("0.00");
    private String reasonCode = null;
    private String reasonName = null;
    private String rackCode = "";
    private String rackName = "";
    private String remark = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);

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

    public String getItemMaterialInventoryType() {
        return itemMaterialInventoryType;
    }

    public void setItemMaterialInventoryType(String itemMaterialInventoryType) {
        this.itemMaterialInventoryType = itemMaterialInventoryType;
    }

    public String getItemMaterialUnitOfMeasureCode() {
        return itemMaterialUnitOfMeasureCode;
    }

    public void setItemMaterialUnitOfMeasureCode(String itemMaterialUnitOfMeasureCode) {
        this.itemMaterialUnitOfMeasureCode = itemMaterialUnitOfMeasureCode;
    }
    
    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    
    
}
