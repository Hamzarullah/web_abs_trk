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
@Table(name="mst_item")
public class Item implements Serializable {
	
    private String code="";
    private String name="";
    private boolean packageStatus = false;
//    private ProductType productType = null;
//    private ItemProductSubCategory itemProductSubCategory = null;
    private UnitOfMeasure unitOfMeasure = null;
//    private String size = "";
    private String inventoryType="INVENTORY";
//    private String inventoryCategory="RAW_MATERIAL";
    private BigDecimal minStock =new BigDecimal("0");
    private BigDecimal maxStock =new BigDecimal("0");
//    private BigDecimal standardWeight =new BigDecimal("0");
    private BigDecimal cogsIDR =new BigDecimal("0");
    private String remark = "";
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
    @JoinColumn (name = "UnitOfMeasureCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public UnitOfMeasure getUnitOfMeasure() {
        return unitOfMeasure;
    }

    public void setUnitOfMeasure(UnitOfMeasure unitOfMeasure) {
        this.unitOfMeasure = unitOfMeasure;
    }

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

//    @Column(name = "Size")
//    public String getSize() {
//        return size;
//    }
//
//    public void setSize(String size) {
//        this.size = size;
//    }

//    @Column(name = "StandardWeight")
//    public BigDecimal getStandardWeight() {
//        return standardWeight;
//    }
//
//    public void setStandardWeight(BigDecimal standardWeight) {
//        this.standardWeight = standardWeight;
//    }

    @Column(name = "cogsIDR")
    public BigDecimal getCogsIDR() {
        return cogsIDR;
    }

    public void setCogsIDR(BigDecimal cogsIDR) {
        this.cogsIDR = cogsIDR;
    }

    @Column(name = "Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
        
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

//    @Column(name = "PackageStatus")
//    public boolean isPackageStatus() {
//        return packageStatus;
//    }
//
//    public void setPackageStatus(boolean packageStatus) {
//        this.packageStatus = packageStatus;
//    }

//    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
//    @JoinColumn (name = "ProductTypeCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
//    public ProductType getProductType() {
//        return productType;
//    }
//
//    public void setProductType(ProductType productType) {
//        this.productType = productType;
//    }

//    @Column(name = "InventoryCategory")
//    public String getInventoryCategory() {
//        return inventoryCategory;
//    }
//
//    public void setInventoryCategory(String inventoryCategory) {
//        this.inventoryCategory = inventoryCategory;
//    }

//    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
//    @JoinColumn (name = "ItemProductSubCategoryCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
//    public ItemProductSubCategory getItemProductSubCategory() {
//        return itemProductSubCategory;
//    }

//    public void setItemProductSubCategory(ItemProductSubCategory itemProductSubCategory) {
//        this.itemProductSubCategory = itemProductSubCategory;
//    }
	
    
}
