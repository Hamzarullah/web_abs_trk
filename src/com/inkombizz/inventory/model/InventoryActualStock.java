/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.Warehouse;
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
@Table(name = "mst_item_material_jn_current_stock")
public class InventoryActualStock implements Serializable  {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "code", length = 50, unique = true)
    private String code = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "warehousecode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "itemMaterialcode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RackCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Rack rack = null;
    
    @Column(name = "Actualstock")
    private BigDecimal actualStock; 
    
    @Column(name="HeatNo")
    private String heatNo;
    
    
    /* TRANSIENT FIELD */
    
    @Transient
    private Reason reason = null;
    
    @Transient
    private String remark = "";
    
    @Transient
    private String transactionCode = "";
    
    /* SET GET METHOD */
    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public BigDecimal getActualStock() {
        return actualStock;
    }

    public void setActualStock(BigDecimal actualStock) {
        this.actualStock = actualStock;
    }
    
    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }

    public Reason getReason() {
        return reason;
    }

    public void setReason(Reason reason) {
        this.reason = reason;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getHeatNo() {
        return heatNo;
    }

    public void setHeatNo(String heatNo) {
        this.heatNo = heatNo;
    }



    
}