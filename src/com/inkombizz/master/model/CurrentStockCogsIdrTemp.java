
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;


public class CurrentStockCogsIdrTemp {
    
    
    private String code = "";
    private String branchCode="";
    private String branchName="";
    private String warehouseCode="";
    private String warehouseName="";
    private String itemCode="";
    private String itemName="";
    private String inTransactionNo = "";
    private String inDocumentType = "";
    private Date itemDate = DateUtils.newDate(1900, 1, 1);
    private BigDecimal cogsIdr = new BigDecimal(0.00);
    private BigDecimal total = new BigDecimal(0.00);
    private BigDecimal inQuantity = new BigDecimal(0.00);
    private String inUnitOfMeasureCode = "";
    private String uom = "";
    private BigDecimal actualStock = new BigDecimal(0.00);
    private BigDecimal currentStock = new BigDecimal(0.00);
    private BigDecimal bookedStock = new BigDecimal(0.00);
    private BigDecimal usedStock = new BigDecimal(0.00);
    private BigDecimal sortNo = new BigDecimal(0.00);
    private String itemBrandCode = "";
    private String lotNo = "";
    private Date productionDate = DateUtils.newDate(1900, 1, 1);
    private String batchNo = "";
    private Date expireDate = DateUtils.newDate(1900, 1, 1);
    private String rackCode = "";

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

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getInTransactionNo() {
        return inTransactionNo;
    }

    public void setInTransactionNo(String inTransactionNo) {
        this.inTransactionNo = inTransactionNo;
    }

    public String getInDocumentType() {
        return inDocumentType;
    }

    public void setInDocumentType(String inDocumentType) {
        this.inDocumentType = inDocumentType;
    }

    public Date getItemDate() {
        return itemDate;
    }

    public void setItemDate(Date itemDate) {
        this.itemDate = itemDate;
    }

    public BigDecimal getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(BigDecimal cogsIdr) {
        this.cogsIdr = cogsIdr;
    }

    public BigDecimal getInQuantity() {
        return inQuantity;
    }

    public void setInQuantity(BigDecimal inQuantity) {
        this.inQuantity = inQuantity;
    }

    public String getInUnitOfMeasureCode() {
        return inUnitOfMeasureCode;
    }

    public void setInUnitOfMeasureCode(String inUnitOfMeasureCode) {
        this.inUnitOfMeasureCode = inUnitOfMeasureCode;
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

    public BigDecimal getUsedStock() {
        return usedStock;
    }

    public void setUsedStock(BigDecimal usedStock) {
        this.usedStock = usedStock;
    }

    public BigDecimal getSortNo() {
        return sortNo;
    }

    public void setSortNo(BigDecimal sortNo) {
        this.sortNo = sortNo;
    }

    public String getItemBrandCode() {
        return itemBrandCode;
    }

    public void setItemBrandCode(String itemBrandCode) {
        this.itemBrandCode = itemBrandCode;
    }

    public String getLotNo() {
        return lotNo;
    }

    public void setLotNo(String lotNo) {
        this.lotNo = lotNo;
    }

    public Date getProductionDate() {
        return productionDate;
    }

    public void setProductionDate(Date productionDate) {
        this.productionDate = productionDate;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public String getRackCode() {
        return rackCode;
    }

    public void setRackCode(String rackCode) {
        this.rackCode = rackCode;
    }

    public BigDecimal getCurrentStock() {
        return currentStock;
    }

    public void setCurrentStock(BigDecimal currentStock) {
        this.currentStock = currentStock;
    }

    public String getUom() {
        return uom;
    }

    public void setUom(String uom) {
        this.uom = uom;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

}
