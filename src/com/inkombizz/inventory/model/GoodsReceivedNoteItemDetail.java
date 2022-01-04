/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Rack;
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
@Table(name="ivt_goods_received_note_item_detail")
/**
 *
 * @author Sukha
 */
public class GoodsReceivedNoteItemDetail extends BaseEntity implements Serializable{
    
    @Id
    @Column (name="Code")
    private String code="";
    
    @Column (name="HeaderCode")
    private String headerCode="";
    
    @Column (name="PurchaseOrderDetailCode")
    private String purchaseOrderDetailCode="";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial=null;
    
    @Column (name="ItemAlias")
    private String itemAlias="";
    
    @Column (name="HeatNo")
    private String heatNo="";
    
    @Column (name="Quantity")
    private BigDecimal quantity=new BigDecimal("0.0000");
    
    @Column (name="Price")
    private BigDecimal price=new BigDecimal("0.0000");
    
    @Column (name="DiscountPercent")
    private BigDecimal discountPercent=new BigDecimal("0.0000");
    
    @Column (name="DiscountAmount")
    private BigDecimal discountAmount=new BigDecimal("0.0000");
    
    @Column (name="NettPrice")
    private BigDecimal nettPrice=new BigDecimal("0.0000");
    
    @Column (name="TotalAmount")
    private BigDecimal totalAmount=new BigDecimal("0.0000");
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RackCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private Rack rack = null;
    
    @Column (name="Remark")
    private String remark="";
    
    private @Transient BigDecimal poQuantity=new BigDecimal("0.0000");
    private @Transient BigDecimal receivedQuantity=new BigDecimal("0.0000");
    private @Transient BigDecimal balanceQuantity=new BigDecimal("0.0000");
    private @Transient BigDecimal total=new BigDecimal("0.0000");
    private @Transient String itemMaterialCode="";
    private @Transient String itemMaterialName="";
    private @Transient String itemMaterialUnitOfMeasureCode="";
    private @Transient String rackCode="";
    private @Transient String rackName="";
    private @Transient String inventoryType="INVENTORY";
    private @Transient String unitOfMeasureCode="";
    private @Transient String serialStatus="";
    
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

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
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

    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getItemMaterialUnitOfMeasureCode() {
        return itemMaterialUnitOfMeasureCode;
    }

    public void setItemMaterialUnitOfMeasureCode(String itemMaterialUnitOfMeasureCode) {
        this.itemMaterialUnitOfMeasureCode = itemMaterialUnitOfMeasureCode;
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

    public BigDecimal getPoQuantity() {
        return poQuantity;
    }

    public void setPoQuantity(BigDecimal poQuantity) {
        this.poQuantity = poQuantity;
    }

    public BigDecimal getReceivedQuantity() {
        return receivedQuantity;
    }

    public void setReceivedQuantity(BigDecimal receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
    }

    public BigDecimal getBalanceQuantity() {
        return balanceQuantity;
    }

    public void setBalanceQuantity(BigDecimal balanceQuantity) {
        this.balanceQuantity = balanceQuantity;
    }

    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getPurchaseOrderDetailCode() {
        return purchaseOrderDetailCode;
    }

    public void setPurchaseOrderDetailCode(String purchaseOrderDetailCode) {
        this.purchaseOrderDetailCode = purchaseOrderDetailCode;
    }

    public String getUnitOfMeasureCode() {
        return unitOfMeasureCode;
    }

    public void setUnitOfMeasureCode(String unitOfMeasureCode) {
        this.unitOfMeasureCode = unitOfMeasureCode;
    }

    public String getHeatNo() {
        return heatNo;
    }

    public void setHeatNo(String heatNo) {
        this.heatNo = heatNo;
    }

    public String getSerialStatus() {
        return serialStatus;
    }

    public void setSerialStatus(String serialStatus) {
        this.serialStatus = serialStatus;
    }
}
