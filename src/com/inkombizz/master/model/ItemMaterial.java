package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;


@Entity
@Table(name="mst_item_material")
public class ItemMaterial implements Serializable {
	
    private String code="";
    private String name="";
    private ItemSubCategory itemSubCategory = null;
    private UnitOfMeasure unitOfMeasure = null;
    private ItemBrand itemBrand = null;
//    private BigDecimal partConversion = new BigDecimal("0");
//    private BigDecimal tolerance = new BigDecimal("0");
//    private boolean conversionStatus=false;
//    private boolean serialNoStatus=false;
//    private BigDecimal conversion =new BigDecimal("0");
    private String inventoryType="INVENTORY";
    private BigDecimal minStock =new BigDecimal("0");
    private BigDecimal maxStock =new BigDecimal("0");
    private BigDecimal cogsIDR =new BigDecimal("0");
//    private String remark = "";
    private boolean activeStatus=false;
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1990, 01, 01);
    private String createdBy="";
    private Date createdDate=DateUtils.newDate(1900, 1, 1);
    private String updatedBy="";
    private Date updatedDate=DateUtils.newDate(1900, 1, 1);
    
    @Id
    @Column(name = "code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemSubCategoryCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public ItemSubCategory getItemSubCategory() {
        return itemSubCategory;
    }

    public void setItemSubCategory(ItemSubCategory itemSubCategory) {
        this.itemSubCategory = itemSubCategory;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "UnitOfMeasureCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public UnitOfMeasure getUnitOfMeasure() {
        return unitOfMeasure;
    }

    public void setUnitOfMeasure(UnitOfMeasure unitOfMeasure) {
        this.unitOfMeasure = unitOfMeasure;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemBrandCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public ItemBrand getItemBrand() {
        return itemBrand;
    }

    public void setItemBrand(ItemBrand itemBrand) {
        this.itemBrand = itemBrand;
    }

//    @Column(name = "PartConversion")
//    public BigDecimal getPartConversion() {
//        return partConversion;
//    }
//
//    public void setPartConversion(BigDecimal partConversion) {
//        this.partConversion = partConversion;
//    }
//    
//    @Column(name = "Tolerance")
//    public BigDecimal getTolerance() {
//        return tolerance;
//    }
//
//    public void setTolerance(BigDecimal tolerance) {
//        this.tolerance = tolerance;
//    }
//    
//    @Column(name = "ConversionStatus")
//    public boolean isConversionStatus() {
//        return conversionStatus;
//    }
//
//    public void setConversionStatus(boolean conversionStatus) {
//        this.conversionStatus = conversionStatus;
//    }
//    
//    @Column(name = "Conversion")
//    public BigDecimal getConversion() {
//        return conversion;
//    }
//
//    public void setConversion(BigDecimal conversion) {
//        this.conversion = conversion;
//    }
    
    @Column(name = "InventoryType")
    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
    }
    
    @Column(name = "MinStock")
    public BigDecimal getMinStock() {
        return minStock;
    }

    public void setMinStock(BigDecimal minStock) {
        this.minStock = minStock;
    }

    @Column(name = "MaxStock")
    public BigDecimal getMaxStock() {
        return maxStock;
    }

    public void setMaxStock(BigDecimal maxStock) {
        this.maxStock = maxStock;
    }

//    @Column(name = "Remark")
//    public String getRemark() {
//        return remark;
//    }
//
//    public void setRemark(String remark) {
//        this.remark = remark;
//    }
        
    @Column(name = "ActiveStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    @Column(name = "InActiveBy")
    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }

    @Column(name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
    }
    
    @Column(name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column(name = "UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    @Column(name = "COGSIDR")
    public BigDecimal getCogsIDR() {
        return cogsIDR;
    }

    public void setCogsIDR(BigDecimal cogsIDR) {
        this.cogsIDR = cogsIDR;
    }

//    @Column(name = "SerialNoStatus")
//    public boolean isSerialNoStatus() {
//        return serialNoStatus;
//    }
//
//    public void setSerialNoStatus(boolean serialNoStatus) {
//        this.serialNoStatus = serialNoStatus;
//    }
    
}
