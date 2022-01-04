/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;

/**
 *
 * @author egie
 */
public class WarehouseTransferOutTemp {
    
    private String code = "";
    private String branchCode = "";
    private String branchName = "";
    private Date transactionDate = DateUtils.newDate(1990, 01, 01);
    private String sourceWarehouseCode = "";
    private String sourceWarehouseName = "";
    private String destinationWarehouseCode = "";
    private String destinationWarehouseName = "";
    private String refNo = "";
    private String remark = "";
    private String rackCode = "";
    private String rackName = "";
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

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getSourceWarehouseCode() {
        return sourceWarehouseCode;
    }

    public void setSourceWarehouseCode(String sourceWarehouseCode) {
        this.sourceWarehouseCode = sourceWarehouseCode;
    }

    public String getSourceWarehouseName() {
        return sourceWarehouseName;
    }

    public void setSourceWarehouseName(String sourceWarehouseName) {
        this.sourceWarehouseName = sourceWarehouseName;
    }

    public String getDestinationWarehouseCode() {
        return destinationWarehouseCode;
    }

    public void setDestinationWarehouseCode(String destinationWarehouseCode) {
        this.destinationWarehouseCode = destinationWarehouseCode;
    }

    public String getDestinationWarehouseName() {
        return destinationWarehouseName;
    }

    public void setDestinationWarehouseName(String destinationWarehouseName) {
        this.destinationWarehouseName = destinationWarehouseName;
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

    
}
