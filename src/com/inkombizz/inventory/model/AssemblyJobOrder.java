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

//import com.inkombizz.master.model.BillOfMaterial;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ItemFinishGoods;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
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
@Table(name = "ivt_assembly_job_order")
public class AssemblyJobOrder implements Serializable{
    
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
    @JoinColumn (name = "FinishGoodsCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial finishGoods= null;
    
//    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
//    @JoinColumn (name = "BillOfMaterialCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
//    private BillOfMaterial billOfMaterial= null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "WarehouseCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse= null;
    
    @Column(name = "FinishGoodsQuantity")
    private BigDecimal finishGoodsQuantity = new BigDecimal(BigInteger.ZERO);
    
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
    @Transient private String unitOfMeasureCode= "";
    @Transient private String finishGoodsCode= "";
    @Transient private String finishGoodsName= "";
    @Transient private String billOfMaterialCode= "";
    @Transient private String billOfMaterialName= "";
    @Transient private BigDecimal finishGoodsQuantityProcess = new BigDecimal(BigInteger.ZERO);
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public ItemMaterial getFinishGoods() {
        return finishGoods;
    }

    public void setFinishGoods(ItemMaterial finishGoods) {
        this.finishGoods = finishGoods;
    }

    public BigDecimal getFinishGoodsQuantity() {
        return finishGoodsQuantity;
    }

    public void setFinishGoodsQuantity(BigDecimal finishGoodsQuantity) {
        this.finishGoodsQuantity = finishGoodsQuantity;
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

    public BigDecimal getFinishGoodsQuantityProcess() {
        return finishGoodsQuantityProcess;
    }

    public void setFinishGoodsQuantityProcess(BigDecimal finishGoodsQuantityProcess) {
        this.finishGoodsQuantityProcess = finishGoodsQuantityProcess;
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

    public BigDecimal getResultGoodsQuantityProcess() {
        return finishGoodsQuantityProcess;
    }

    public void setResultGoodsQuantityProcess(BigDecimal finishGoodsQuantityProcess) {
        this.finishGoodsQuantityProcess = finishGoodsQuantityProcess;
    }

    public String getUnitOfMeasureCode() {
        return unitOfMeasureCode;
    }

    public void setUnitOfMeasureCode(String unitOfMeasureCode) {
        this.unitOfMeasureCode = unitOfMeasureCode;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }
    
}
