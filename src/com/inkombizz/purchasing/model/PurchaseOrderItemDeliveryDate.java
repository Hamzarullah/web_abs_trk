/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.ItemMaterial;
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
import javax.persistence.Transient;

@Entity 
@Table(name = "pur_purchase_order_item_delivery_date")
public class PurchaseOrderItemDeliveryDate extends BaseEntity implements Serializable{
    
    @Id
    @Column(name="Code")
    private String code="";
  
    @Column(name="HeaderCode")
    private String headerCode="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial=null;
    
    @Column(name = "Quantity")
    private BigDecimal quantity=new BigDecimal("0.00");
    
    @Column(name = "DeliveryDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date deliveryDate = DateUtils.newDate(1900, 1, 1);
    
    @Transient private String itemMaterialCode="";
    @Transient private String itemMaterialName="";

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

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
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
    
    
}
