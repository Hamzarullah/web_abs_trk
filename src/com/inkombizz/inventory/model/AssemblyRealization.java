/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

/**
 *
 * @author Rayis
 */

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.Transient;

@Entity
@Table(name = "ivt_assembly_realization")
public class AssemblyRealization extends ActionSupport{
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch= null;
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate = DateUtils.newDate(1990, 01, 01);
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "AssemblyJobOrderCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private AssemblyJobOrder assemblyJobOrder= null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "WarehouseCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse= null;
    
    @Column(name = "RealizationQuantity")
    private BigDecimal realizationQuantity = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "Refno")
    private String refNo = "";
    
    @Column(name = "Remark")
    private String remark = "";
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    /* TRANSIEN FIELD */
    
    @Transient private String branchCode= "";
    @Transient private String branchName= "";
    @Transient private String warehouseCode= "";
    @Transient private String warehouseName= "";
    @Transient private String assemblyJobOrderCode= "";
    @Transient private String lastStatus= "";
    @Transient private Date assemblyJobOrderDate = DateUtils.newDate(1990, 01, 01);
    @Transient private String finishGoodsCode= "";
    @Transient private String finishGoodsName= "";
    @Transient private String billOfMaterialCode= "";
    @Transient private String billOfMaterialName= "";
    @Transient private String defaultUnitOfMeasureCode= "";
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getLastStatus() {
        return lastStatus;
    }

    public void setLastStatus(String lastStatus) {
        this.lastStatus = lastStatus;
    }
    
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public AssemblyJobOrder getAssemblyJobOrder() {
        return assemblyJobOrder;
    }

    public void setAssemblyJobOrder(AssemblyJobOrder assemblyJobOrder) {
        this.assemblyJobOrder = assemblyJobOrder;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public BigDecimal getRealizationQuantity() {
        return realizationQuantity;
    }

    public void setRealizationQuantity(BigDecimal realizationQuantity) {
        this.realizationQuantity = realizationQuantity;
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

    public String getAssemblyJobOrderCode() {
        return assemblyJobOrderCode;
    }

    public void setAssemblyJobOrderCode(String assemblyJobOrderCode) {
        this.assemblyJobOrderCode = assemblyJobOrderCode;
    }

    public String getFinishGoodsCode() {
        return finishGoodsCode;
    }

    public void setFinishGoodsCode(String finishGoodsCode) {
        this.finishGoodsCode = finishGoodsCode;
    }

    public String getFinishGoodsName() {
        return finishGoodsName;
    }

    public void setFinishGoodsName(String finishGoodsName) {
        this.finishGoodsName = finishGoodsName;
    }
    
    
    public String getBillOfMaterialCode() {
        return billOfMaterialCode;
    }

    public void setBillOfMaterialCode(String billOfMaterialCode) {
        this.billOfMaterialCode = billOfMaterialCode;
    }

    public String getBillOfMaterialName() {
        return billOfMaterialName;
    }

    public void setBillOfMaterialName(String billOfMaterialName) {
        this.billOfMaterialName = billOfMaterialName;
    }

    public Date getAssemblyJobOrderDate() {
        return assemblyJobOrderDate;
    }

    public void setAssemblyJobOrderDate(Date assemblyJobOrderDate) {
        this.assemblyJobOrderDate = assemblyJobOrderDate;
    }

    public String getDefaultUnitOfMeasureCode() {
        return defaultUnitOfMeasureCode;
    }

    public void setDefaultUnitOfMeasureCode(String defaultUnitOfMeasureCode) {
        this.defaultUnitOfMeasureCode = defaultUnitOfMeasureCode;
    }
}
