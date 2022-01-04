
package com.inkombizz.purchasing.model;

import com.inkombizz.common.BaseEntity;
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

import com.inkombizz.master.model.ItemMaterial;
import javax.persistence.Transient;

@Entity 
@Table(name = "pur_purchase_order_item_material_detail")
public class PurchaseOrderDetail extends BaseEntity implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode = "";
    
    @Column(name = "PurchaseRequestCode")
    private String purchaseRequestCode="";
    
    @Column(name = "PurchaseRequestDetailCode")
    private String purchaseRequestDetailCode="";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @Column(name = "ItemAlias")
    private String itemAlias = "";
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "Quantity")
    private BigDecimal quantity = new BigDecimal("0.00");
    
    @Column(name = "Price")
    private BigDecimal price = new BigDecimal("0.00");
    
    @Column(name = "DiscountPercent")
    private BigDecimal discountPercent = new BigDecimal("0.00");
    
    @Column(name = "DiscountAmount")
    private BigDecimal discountAmount = new BigDecimal("0.00");
    
    @Column(name = "NettPrice")
    private BigDecimal nettPrice = new BigDecimal("0.00");
    
    @Column(name = "TotalAmount")
    private BigDecimal totalAmount = new BigDecimal("0.00");
    
    private @Transient String unitOfMeasureCode="";
    private @Transient String unitOfMeasureName="";
    private @Transient String itemMaterialCode="";
    private @Transient String itemMaterialName="";
    private @Transient String itemMaterialSerialStatus="";
    private @Transient BigDecimal total=new BigDecimal("0.00");
    private @Transient BigDecimal receivedQuantity=new BigDecimal("0.0000");
    private @Transient BigDecimal grnQuantity=new BigDecimal("0.0000");
    private @Transient BigDecimal balanceQuantity=new BigDecimal("0.0000");

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

    public String getPurchaseRequestCode() {
        return purchaseRequestCode;
    }

    public void setPurchaseRequestCode(String purchaseRequestCode) {
        this.purchaseRequestCode = purchaseRequestCode;
    }

    public String getPurchaseRequestDetailCode() {
        return purchaseRequestDetailCode;
    }

    public void setPurchaseRequestDetailCode(String purchaseRequestDetailCode) {
        this.purchaseRequestDetailCode = purchaseRequestDetailCode;
    }

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getNettPrice() {
        return nettPrice;
    }

    public void setNettPrice(BigDecimal nettPrice) {
        this.nettPrice = nettPrice;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
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

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public BigDecimal getReceivedQuantity() {
        return receivedQuantity;
    }

    public void setReceivedQuantity(BigDecimal receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
    }

    public BigDecimal getGrnQuantity() {
        return grnQuantity;
    }

    public void setGrnQuantity(BigDecimal grnQuantity) {
        this.grnQuantity = grnQuantity;
    }

    public BigDecimal getBalanceQuantity() {
        return balanceQuantity;
    }

    public void setBalanceQuantity(BigDecimal balanceQuantity) {
        this.balanceQuantity = balanceQuantity;
    }

    public String getItemMaterialSerialStatus() {
        return itemMaterialSerialStatus;
    }

    public void setItemMaterialSerialStatus(String itemMaterialSerialStatus) {
        this.itemMaterialSerialStatus = itemMaterialSerialStatus;
    }

    
    
}
