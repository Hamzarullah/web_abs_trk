
package com.inkombizz.inventory.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class PickingListSalesOrderTemp {
    
    private String code = "";
    private String pickingListCode = "";
    private Date transactionDate = DateUtils.newDate(1900, 1, 1);
    private Date deliveryDate = DateUtils.newDate(1900, 1, 1);
    private String transactionDateTemp="";   
    private String salesOrderCode = "";
    private String salesOrderCustomerCode = "";
    private String salesOrderCustomerName = "";
    private String branchCode = "";
    private String branchName = "";
    private String currencyCode = "";
    private String currencyName = "";
    private BigDecimal exchangeRate = new BigDecimal("0.00");
    private String customerAddressCode= "";
    private String customerAddressName= "";
    private String customerAddressAddress= "";
    private String warehouseCode= "";
    private String warehouseName= "";
    private String confirmationStatus="PENDING";
    private Date confirmationDate=DateUtils.newDate(1900, 1, 1);
    private String confirmationDateTemp="";   
    private String confirmationBy="";   
    private String refNo = "";
    private String remark = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String createdDateTemp="";
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    private String updatedDateTemp="";
    
    private String deliveryNoteCode = "";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getTransactionDateTemp() {
        return transactionDateTemp;
    }

    public void setTransactionDateTemp(String transactionDateTemp) {
        this.transactionDateTemp = transactionDateTemp;
    }

    public String getSalesOrderCode() {
        return salesOrderCode;
    }

    public void setSalesOrderCode(String salesOrderCode) {
        this.salesOrderCode = salesOrderCode;
    }

    public String getSalesOrderCustomerCode() {
        return salesOrderCustomerCode;
    }

    public void setSalesOrderCustomerCode(String salesOrderCustomerCode) {
        this.salesOrderCustomerCode = salesOrderCustomerCode;
    }

    public String getSalesOrderCustomerName() {
        return salesOrderCustomerName;
    }

    public void setSalesOrderCustomerName(String salesOrderCustomerName) {
        this.salesOrderCustomerName = salesOrderCustomerName;
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

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getCurrencyName() {
        return currencyName;
    }

    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public String getCustomerAddressCode() {
        return customerAddressCode;
    }

    public void setCustomerAddressCode(String customerAddressCode) {
        this.customerAddressCode = customerAddressCode;
    }

    public String getCustomerAddressName() {
        return customerAddressName;
    }

    public void setCustomerAddressName(String customerAddressName) {
        this.customerAddressName = customerAddressName;
    }

    public String getCustomerAddressAddress() {
        return customerAddressAddress;
    }

    public void setCustomerAddressAddress(String customerAddressAddress) {
        this.customerAddressAddress = customerAddressAddress;
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

    public String getConfirmationStatus() {
        return confirmationStatus;
    }

    public void setConfirmationStatus(String confirmationStatus) {
        this.confirmationStatus = confirmationStatus;
    }

    public Date getConfirmationDate() {
        return confirmationDate;
    }

    public void setConfirmationDate(Date confirmationDate) {
        this.confirmationDate = confirmationDate;
    }

    public String getConfirmationDateTemp() {
        return confirmationDateTemp;
    }

    public void setConfirmationDateTemp(String confirmationDateTemp) {
        this.confirmationDateTemp = confirmationDateTemp;
    }

    public String getConfirmationBy() {
        return confirmationBy;
    }

    public void setConfirmationBy(String confirmationBy) {
        this.confirmationBy = confirmationBy;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
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

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
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

    public String getUpdatedDateTemp() {
        return updatedDateTemp;
    }

    public void setUpdatedDateTemp(String updatedDateTemp) {
        this.updatedDateTemp = updatedDateTemp;
    }

    public String getPickingListCode() {
        return pickingListCode;
    }

    public void setPickingListCode(String pickingListCode) {
        this.pickingListCode = pickingListCode;
    }

    public String getDeliveryNoteCode() {
        return deliveryNoteCode;
    }

    public void setDeliveryNoteCode(String deliveryNoteCode) {
        this.deliveryNoteCode = deliveryNoteCode;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

}
