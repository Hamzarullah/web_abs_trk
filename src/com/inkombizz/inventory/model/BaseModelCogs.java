/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;

/**
 *
 * @author jason
 */
@MappedSuperclass
public class BaseModelCogs {
    
    @Id
    @Column(name = "code", length = 50)
    private String code = "";
   
    @Column(name = "headercode", length = 50)
    private String headerCode = "";
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "branchcode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch = null;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "warehousecode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse = null;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "itemcode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "itembrandcode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemBrand itemBrand = null;
    
    @Column(name = "quantity")
    private BigDecimal quantity;
    
    @Column(name = "cogsidr")
    private BigDecimal cogsIdr;
    
    @Column (name = "itemdate")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date itemDate = DateUtils.newDate(1990,01,01);
    
    @Column (name = "inTransactionNo", length = 50)
    private String inTransactionNo = "";
    
    @Column (name = "inDocumentType", length = 50)
    private String inDocumentType = "";
    
    @Column (name = "lotNo", length = 50)
    private String lotNo = "";
    
    @Column (name = "batchNo", length = 50)
    private String batchNo = "";
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "RackCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Rack rack = null;
    
    @Column (name = "expiredDate", length = 50)
    private Date expiredDate = DateUtils.newDate(1900, 1, 1);
    
    @Column (name = "createdby", length = 50)
    private String createdBy = "";
    
    @Column (name = "createddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column (name = "updatedby", length = 50)
    private String updatedBy = "";
    
    @Column (name = "updateddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    /* SET GET METHOD */

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
    
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public ItemMaterial getItemMaterial() {
        return itemMaterial;
    }

    public void setItemMaterial(ItemMaterial itemMaterial) {
        this.itemMaterial = itemMaterial;
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

    public Date getItemDate() {
        return itemDate;
    }

    public void setItemDate(Date itemDate) {
        this.itemDate = itemDate;
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

    public ItemBrand getItemBrand() {
        return itemBrand;
    }

    public void setItemBrand(ItemBrand itemBrand) {
        this.itemBrand = itemBrand;
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

    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }
}
