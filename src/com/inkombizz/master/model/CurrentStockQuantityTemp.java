
package com.inkombizz.master.model;

import java.math.BigDecimal;


public class CurrentStockQuantityTemp {
    
    private String code = "";
    private String branchCode="";
    private String branchName="";
    private String warehouseCode="";
    private String warehouseName="";
    private String itemCode="";
    private String itemName="";
    private BigDecimal actualStock = new BigDecimal(0.00);
    private BigDecimal usedStock = new BigDecimal(0.00);
    private String rackCode = "";
    private String rackName = "";
    private String uom = "";


    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
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

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getItemName() {
        return itemName;
    }

    public BigDecimal getActualStock() {
        return actualStock;
    }

    public void setActualStock(BigDecimal actualStock) {
        this.actualStock = actualStock;
    }

    public BigDecimal getUsedStock() {
        return usedStock;
    }

    public void setUsedStock(BigDecimal usedStock) {
        this.usedStock = usedStock;
    }

    
    public void setItemName(String itemName) {
        this.itemName = itemName;
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

    public String getUom() {
        return uom;
    }

    public void setUom(String uom) {
        this.uom = uom;
    }
    
}
