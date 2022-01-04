
package com.inkombizz.purchasing.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemMaterial;
import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "pur_purchase_request_non_imr_detail")
public class PurchaseRequestNonItemMaterialRequestDetail extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial=null; 
    
    @Column(name = "Quantity")
    private BigDecimal quantity=new BigDecimal("0.00");
    
    @Column(name = "Remark")
    private String remark="";
    
    
    //Transient
    private @Transient String itemMaterialCode="";
    private @Transient String itemMaterialName="";
    private @Transient String unitOfMeasureCode="";
    private @Transient String unitOfMeasureName="";
    private @Transient String poCode="";
    private @Transient String itemMaterialJnVendor="";
    private @Transient String vendorCode="";
    
    //Transient PO
    private @Transient String purchaseOrderSubItemPurchaseRequestNo="";
    private @Transient String purchaseOrderSubItemPurchaseOrderItemMaterialCode="";
    private @Transient String purchaseOrderSubItemPurchaseOrderItemMaterialName="";

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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getItemMaterialCode() {
        return itemMaterialCode;
    }

    public void setItemMaterialCode(String itemMaterialCode) {
        this.itemMaterialCode = itemMaterialCode;
    }

    public String getItemMaterialName() {
        return itemMaterialName;
    }

    public void setItemMaterialName(String itemMaterialName) {
        this.itemMaterialName = itemMaterialName;
    }

    public String getPurchaseOrderSubItemPurchaseRequestNo() {
        return purchaseOrderSubItemPurchaseRequestNo;
    }

    public void setPurchaseOrderSubItemPurchaseRequestNo(String purchaseOrderSubItemPurchaseRequestNo) {
        this.purchaseOrderSubItemPurchaseRequestNo = purchaseOrderSubItemPurchaseRequestNo;
    }

    public String getPurchaseOrderSubItemPurchaseOrderItemMaterialCode() {
        return purchaseOrderSubItemPurchaseOrderItemMaterialCode;
    }

    public void setPurchaseOrderSubItemPurchaseOrderItemMaterialCode(String purchaseOrderSubItemPurchaseOrderItemMaterialCode) {
        this.purchaseOrderSubItemPurchaseOrderItemMaterialCode = purchaseOrderSubItemPurchaseOrderItemMaterialCode;
    }

    public String getPurchaseOrderSubItemPurchaseOrderItemMaterialName() {
        return purchaseOrderSubItemPurchaseOrderItemMaterialName;
    }

    public void setPurchaseOrderSubItemPurchaseOrderItemMaterialName(String purchaseOrderSubItemPurchaseOrderItemMaterialName) {
        this.purchaseOrderSubItemPurchaseOrderItemMaterialName = purchaseOrderSubItemPurchaseOrderItemMaterialName;
    }

    public String getPoCode() {
        return poCode;
    }

    public void setPoCode(String poCode) {
        this.poCode = poCode;
    }

    public String getItemMaterialJnVendor() {
        return itemMaterialJnVendor;
    }

    public void setItemMaterialJnVendor(String itemMaterialJnVendor) {
        this.itemMaterialJnVendor = itemMaterialJnVendor;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    
    
}
