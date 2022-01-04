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

import com.inkombizz.master.model.Item;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.UnitOfMeasure;
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
@Table(name = "ivt_assembly_realization_cogs")
public class AssemblyRealizationCOGS extends ActionSupport{
    
    @Id
    @Column(name = "Code")
    private String code = "";
   
    @Column(name = "HeaderCode")
    private String headerCode = "";
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "WarehouseCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse = null;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ItemCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Item item = null;
  
    @Column (name = "InDocumentType")
    private String inDocumentType = "";
    
    @Column(name = "Quantity")
    private BigDecimal quantity;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "RackCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Rack rack = null;
    
    @Column (name = "Itemdate")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date itemDate = DateUtils.newDate(1990,01,01);
    
    @Column (name = "Remark")
    private String remark = "";
    
    @Column (name = "createdby")
    private String createdBy = "";
    
    @Column (name = "createddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column (name = "updatedby")
    private String updatedBy = "";
    
    @Column (name = "updateddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

     /* TRANSIEN FIELD */
    
    @Transient private String warehouseCode= "";
    @Transient private String warehouseName= "";
    @Transient private String itemCode= "";
    @Transient private String itemName= "";
    @Transient private String itemAlias= "";
    @Transient private String itemBrandCode= "";
    @Transient private String itemBrandName= "";
    @Transient private String unitOfMeasureCode= "";
    @Transient private String unitOfMeasureName= "";
    @Transient private String rackCode= "";
    @Transient private String rackName= "";
    @Transient private BigDecimal conversion = new BigDecimal(BigInteger.ZERO);
    
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

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public String getInDocumentType() {
        return inDocumentType;
    }

    public void setInDocumentType(String inDocumentType) {
        this.inDocumentType = inDocumentType;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }

    public Date getItemDate() {
        return itemDate;
    }

    public void setItemDate(Date itemDate) {
        this.itemDate = itemDate;
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

    public String getUnitOfMeasureCode() {
        return unitOfMeasureCode;
    }

    public void setUnitOfMeasureCode(String unitOfMeasureCode) {
        this.unitOfMeasureCode = unitOfMeasureCode;
    }

    public String getUnitOfMeasureName() {
        return unitOfMeasureName;
    }

    public void setUnitOfMeasureName(String unitOfMeasureName) {
        this.unitOfMeasureName = unitOfMeasureName;
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

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
    }

    public BigDecimal getConversion() {
        return conversion;
    }

    public void setConversion(BigDecimal conversion) {
        this.conversion = conversion;
    }
}
