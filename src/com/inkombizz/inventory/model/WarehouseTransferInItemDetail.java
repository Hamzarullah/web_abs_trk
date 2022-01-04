/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.master.model.Item;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Rack;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;

/**
 *
 * @author egie
 */
@Entity 
@Table(name = "ivt_warehouse_transfer_in_item_detail")
public class WarehouseTransferInItemDetail implements Serializable{
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column (name="Code")
    private String code = "";
    
    @Column (name="HeaderCode")
    private String headerCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @Column (name="Quantity")
    private BigDecimal quantity = new BigDecimal(BigInteger.ZERO);
        
    @Column (name="COGSIDR")
    private BigDecimal cogsIdr = new BigDecimal(BigInteger.ZERO);
    
    @Column (name="TotalAmount")
    private BigDecimal totalAmount = new BigDecimal(BigInteger.ZERO);
        
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RackCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Rack rack = null;
        
    @Column (name="Remark")
    private String remark = "";
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    /* SET GET METHOD */

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

    public BigDecimal getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(BigDecimal cogsIdr) {
        this.cogsIdr = cogsIdr;
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

    
}
