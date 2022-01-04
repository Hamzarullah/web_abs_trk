/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import java.math.BigDecimal;

public class InventoryActualStockTemp {
    
    private String code = "";
    private String warehouseCode = "";
    private String warehouseName = "";
    private String itemMaterialCode = "";
    private String itemMaterialName = "";
    private String rackCode = "";
    private String rackName = "";
    private BigDecimal actualStock;   
    private BigDecimal bookedStock ;    

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public BigDecimal getBookedStock() {
        return bookedStock;
    }

    public void setBookedStock(BigDecimal bookedStock) {
        this.bookedStock = bookedStock;
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

    
}
