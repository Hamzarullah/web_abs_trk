
package com.inkombizz.inventory.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class PickingListSalesOrderBonusItemDetailTemp {
    
    private String code = "";
    private String headerCode = "";
    private String itemCode = "";
    private String itemName = "";
    private String itemAlias = "";
    private String customerAddressCode = "";
    private String customerAddressName = "";
    private String customerAddressAddress = "";
    private String customerAddressCityCode = "";
    private String customerAddressCityName = "";
    private String itemUnitOfMeasureCode = "";
    private BigDecimal quantity = new BigDecimal ("0.00");
    private BigDecimal soQuantity = new BigDecimal ("0.00");
    private BigDecimal processedQuantity = new BigDecimal ("0.00");
    private BigDecimal pltQuantity = new BigDecimal ("0.00");
    private BigDecimal balanceQuantity = new BigDecimal ("0.00");
    private String createdBy = "";
    private String updatedBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    private String lotNo="";
    private String batchNo = "";
    private Date expiredDate = DateUtils.newDate(1900, 1, 1);
    private String rackCode = "";
    private String rackName = "";

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

    public String getCustomerAddressCode() {
        return customerAddressCode;
    }

    public void setCustomerAddressCode(String customerAddressCode) {
        this.customerAddressCode = customerAddressCode;
    }

    public String getCustomerAddressAddress() {
        return customerAddressAddress;
    }

    public void setCustomerAddressAddress(String customerAddressAddress) {
        this.customerAddressAddress = customerAddressAddress;
    }

    public String getCustomerAddressCityName() {
        return customerAddressCityName;
    }

    public void setCustomerAddressCityName(String customerAddressCityName) {
        this.customerAddressCityName = customerAddressCityName;
    }

    public String getItemUnitOfMeasureCode() {
        return itemUnitOfMeasureCode;
    }

    public void setItemUnitOfMeasureCode(String itemUnitOfMeasureCode) {
        this.itemUnitOfMeasureCode = itemUnitOfMeasureCode;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getSoQuantity() {
        return soQuantity;
    }

    public void setSoQuantity(BigDecimal soQuantity) {
        this.soQuantity = soQuantity;
    }

    public BigDecimal getPltQuantity() {
        return pltQuantity;
    }

    public void setPltQuantity(BigDecimal pltQuantity) {
        this.pltQuantity = pltQuantity;
    }

    public BigDecimal getBalanceQuantity() {
        return balanceQuantity;
    }

    public void setBalanceQuantity(BigDecimal balanceQuantity) {
        this.balanceQuantity = balanceQuantity;
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

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
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

    public String getCustomerAddressName() {
        return customerAddressName;
    }

    public void setCustomerAddressName(String customerAddressName) {
        this.customerAddressName = customerAddressName;
    }

    public String getCustomerAddressCityCode() {
        return customerAddressCityCode;
    }

    public void setCustomerAddressCityCode(String customerAddressCityCode) {
        this.customerAddressCityCode = customerAddressCityCode;
    }

    public BigDecimal getProcessedQuantity() {
        return processedQuantity;
    }

    public void setProcessedQuantity(BigDecimal processedQuantity) {
        this.processedQuantity = processedQuantity;
    }

}
