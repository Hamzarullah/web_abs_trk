package com.inkombizz.master.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;


@Entity
@Table(name="mst_item_material_jn_vendor")
public class ItemMaterialVendor implements Serializable {
    
    private String code = "";
    private ItemMaterial itemMaterial = null;
    private Vendor vendor = null;
    
    private String itemMaterialCode ="";
    private String itemMaterialName ="";
    private String vendorCode ="";
    private String vendorName ="";
    private String vendorAddress ="";
    private String itemMaterialUnitOfMeasureCode ="";
    private String itemMaterialUnitOfMeasureName ="";

    @Id
    @Column(name="Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public ItemMaterial getItemMaterial() {
        return itemMaterial;
    }

    public void setItemMaterial(ItemMaterial itemMaterial) {
        this.itemMaterial = itemMaterial;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    @Transient
    public String getItemMaterialCode() {
        return itemMaterialCode;
    }

    public void setItemMaterialCode(String itemMaterialCode) {
        this.itemMaterialCode = itemMaterialCode;
    }

    @Transient
    public String getItemMaterialName() {
        return itemMaterialName;
    }

    public void setItemMaterialName(String itemMaterialName) {
        this.itemMaterialName = itemMaterialName;
    }

    @Transient
    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    @Transient
    public String getVendorName() {
        return vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
    }

    @Transient
    public String getVendorAddress() {
        return vendorAddress;
    }

    public void setVendorAddress(String vendorAddress) {
        this.vendorAddress = vendorAddress;
    }

    @Transient
    public String getItemMaterialUnitOfMeasureCode() {
        return itemMaterialUnitOfMeasureCode;
    }

    public void setItemMaterialUnitOfMeasureCode(String itemMaterialUnitOfMeasureCode) {
        this.itemMaterialUnitOfMeasureCode = itemMaterialUnitOfMeasureCode;
    }

    @Transient
    public String getItemMaterialUnitOfMeasureName() {
        return itemMaterialUnitOfMeasureName;
    }

    public void setItemMaterialUnitOfMeasureName(String itemMaterialUnitOfMeasureName) {
        this.itemMaterialUnitOfMeasureName = itemMaterialUnitOfMeasureName;
    }
    
    
    
}
