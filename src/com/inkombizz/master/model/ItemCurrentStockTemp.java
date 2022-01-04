
package com.inkombizz.master.model;

import java.math.BigDecimal;


public class ItemCurrentStockTemp {
    
    private String code;
    private String itemMaterialCode;
    private String itemMaterialName;
    private String itemAlias;
    private String itemMaterialInventoryType;
    private String itemMaterialUnitOfMeasureCode;
    private String itemMaterialUnitOfMeasureName;
    private BigDecimal itemMaterialCogsIdr=new BigDecimal("0.00");
    private String warehouseCode;
    private String warehouseName;
    private String rackCode;
    private String rackName;
    private BigDecimal actualStock=new BigDecimal("0.00");

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

    public BigDecimal getItemMaterialCogsIdr() {
        return itemMaterialCogsIdr;
    }

    public void setItemMaterialCogsIdr(BigDecimal itemMaterialCogsIdr) {
        this.itemMaterialCogsIdr = itemMaterialCogsIdr;
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

    public BigDecimal getActualStock() {
        return actualStock;
    }

    public void setActualStock(BigDecimal actualStock) {
        this.actualStock = actualStock;
    }

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
    }

    public String getItemMaterialUnitOfMeasureName() {
        return itemMaterialUnitOfMeasureName;
    }

    public void setItemMaterialUnitOfMeasureName(String itemMaterialUnitOfMeasureName) {
        this.itemMaterialUnitOfMeasureName = itemMaterialUnitOfMeasureName;
    }
    
}
