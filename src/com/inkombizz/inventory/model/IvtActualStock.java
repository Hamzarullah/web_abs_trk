
package com.inkombizz.inventory.model;

import java.math.BigDecimal;
import java.util.Date;

public class IvtActualStock {
    
    private String branchCode;
    private String code;
    private String itemAlias;
    private String warehouseCode;
    private String warehouseName;
    private Date itemMaterialDate;
    private BigDecimal COGSIDR;
    private BigDecimal actualStock;
    private BigDecimal quantity;
    private BigDecimal newQuantity;
    private BigDecimal oldQuantity;
    private String unitOfMeasureCode="";
    private String rackCode="";
    private String rackName="";
    private String itemMaterialCode = "";
    private String itemMaterialName;
    private String itemMaterialInventoryType;
    private String heatNo = "";
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getUnitOfMeasureCode() {
        return unitOfMeasureCode;
    }

    public void setUnitOfMeasureCode(String unitOfMeasureCode) {
        this.unitOfMeasureCode = unitOfMeasureCode;
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

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getItemMaterialInventoryType() {
        return itemMaterialInventoryType;
    }

    public void setItemMaterialInventoryType(String itemMaterialInventoryType) {
        this.itemMaterialInventoryType = itemMaterialInventoryType;
    }

    public Date getItemMaterialDate() {
        return itemMaterialDate;
    }

    public void setItemMaterialDate(Date itemMaterialDate) {
        this.itemMaterialDate = itemMaterialDate;
    }

    public void setUsedStock(double doubleValue) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public BigDecimal getCOGSIDR() {
        return COGSIDR;
    }

    public void setCOGSIDR(BigDecimal COGSIDR) {
        this.COGSIDR = COGSIDR;
    }

    public BigDecimal getActualStock() {
        return actualStock;
    }

    public void setActualStock(BigDecimal actualStock) {
        this.actualStock = actualStock;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getNewQuantity() {
        return newQuantity;
    }

    public void setNewQuantity(BigDecimal newQuantity) {
        this.newQuantity = newQuantity;
    }

    public BigDecimal getOldQuantity() {
        return oldQuantity;
    }

    public void setOldQuantity(BigDecimal oldQuantity) {
        this.oldQuantity = oldQuantity;
    }

    public String getHeatNo() {
        return heatNo;
    }

    public void setHeatNo(String heatNo) {
        this.heatNo = heatNo;
    }
    
    
    
    

}
