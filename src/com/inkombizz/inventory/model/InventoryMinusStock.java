/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Warehouse;
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
@Table(name = "mst_minus_stock")
public class InventoryMinusStock implements Serializable  {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "code", length = 50, unique = true)
    private String code = "";
    
    @Column(name = "branchcode", length = 50)
    private String branchCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "warehousecode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "itemMaterialCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @Column(name = "minusquantity")
    private BigDecimal minusQuantity;    
    
    @Column(name = "createdby")
    private String createdBy = "";
    
    @Column(name = "createddate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "updatedby")
    private String updatedBy = "";
    
    @Column(name = "updateddate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
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

    public BigDecimal getMinusQuantity() {
        return minusQuantity;
    }

    public void setMinusQuantity(BigDecimal minusQuantity) {
        this.minusQuantity = minusQuantity;
    }
    
    
}