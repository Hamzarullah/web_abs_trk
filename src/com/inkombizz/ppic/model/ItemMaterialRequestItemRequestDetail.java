/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.ppic.model;

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

/**
 *
 * @author Sukha Vaddhana
 */

@Entity
@Table(name="ppic_item_material_request_item_purchase_request_detail")
public class ItemMaterialRequestItemRequestDetail extends BaseEntity implements Serializable{
    
    @Id
    @Column(name="Code")
    private String code ="";
    
    @Column(name="HeaderCode")
    private String headerCode = "";
    
    @ManyToOne(cascade={}, fetch=FetchType.EAGER)
    @JoinColumn(name="ItemMaterialCode", referencedColumnName = "Code", unique=false, nullable=false, insertable=true, updatable=true)
    private ItemMaterial itemMaterial = null;
    
    @Column(name="Quantity")
    private BigDecimal quantity = new BigDecimal("0.0000");
    
    @Column(name="Remark")
    private String remark = "";
    
    private @Transient String itemMaterialCode="";
    private @Transient String itemMaterialName="";
    private @Transient String uomCode="";
    private @Transient String uomName="";

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

    public String getUomCode() {
        return uomCode;
    }

    public void setUomCode(String uomCode) {
        this.uomCode = uomCode;
    }

    public String getUomName() {
        return uomName;
    }

    public void setUomName(String uomName) {
        this.uomName = uomName;
    }
    
    
}
