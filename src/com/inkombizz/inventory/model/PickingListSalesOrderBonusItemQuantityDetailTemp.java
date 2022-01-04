
package com.inkombizz.inventory.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class PickingListSalesOrderBonusItemQuantityDetailTemp {
    
    private String code = "";
    private String headerCode = "";
    private String itemCode = "";
    private String itemName = "";
    private String itemAlias = "";
    private String itemUnitOfMeasureCode = "";
    private String packingListSalesOrderBonusItemDetailCode = "";
    private BigDecimal quantity = new BigDecimal ("0.0000");
    private BigDecimal conversion = new BigDecimal ("0.0000");
    private BigDecimal cogsIdr = new BigDecimal ("0.0000");
    private String itemBrandCode = "";
    private String itemBrandName = "";
    private String lotNo = "";
    private String batchNo = "";
    private String rackCode = "";
    private String rackName = "";
    private Date itemDate = DateUtils.newDate(1900, 1, 1);
    private Date expiredDate = DateUtils.newDate(1900, 1, 1);
    private String inDocumentType = "";
    private String inTransactionNo = "";
    private String createdBy = "";
    private String updatedBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

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

    public String getPackingListSalesOrderBonusItemDetailCode() {
        return packingListSalesOrderBonusItemDetailCode;
    }

    public void setPackingListSalesOrderBonusItemDetailCode(String packingListSalesOrderBonusItemDetailCode) {
        this.packingListSalesOrderBonusItemDetailCode = packingListSalesOrderBonusItemDetailCode;
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

    public String getLotNo() {
        return lotNo;
    }

    public void setLotNo(String lotNo) {
        this.lotNo = lotNo;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
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

    public Date getItemDate() {
        return itemDate;
    }

    public void setItemDate(Date itemDate) {
        this.itemDate = itemDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public String getInDocumentType() {
        return inDocumentType;
    }

    public void setInDocumentType(String inDocumentType) {
        this.inDocumentType = inDocumentType;
    }

    public String getInTransactionNo() {
        return inTransactionNo;
    }

    public void setInTransactionNo(String inTransactionNo) {
        this.inTransactionNo = inTransactionNo;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
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

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
    }

    public String getItemUnitOfMeasureCode() {
        return itemUnitOfMeasureCode;
    }

    public void setItemUnitOfMeasureCode(String itemUnitOfMeasureCode) {
        this.itemUnitOfMeasureCode = itemUnitOfMeasureCode;
    }

    public BigDecimal getConversion() {
        return conversion;
    }

    public void setConversion(BigDecimal conversion) {
        this.conversion = conversion;
    }
    
}
