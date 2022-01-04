/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.master.model.ItemMaterial;
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
 * @author jason
 */
@Entity
@Table(name = "fin_vendor_invoice_item_detail")
public class VendorInvoiceItemDetail implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @Column(name = "HeaderCode")
    private String headerCode = "";
    
    @Column(name = "GoodsReceivedNoteDetailCode")
    private String goodsReceivedNoteDetailCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @Column(name = "Quantity")
    private BigDecimal quantity = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "Price")
    private BigDecimal price = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "DiscountPercent")
    private BigDecimal discountPercent = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "DiscountAmount")
    private BigDecimal discountAmount = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "NettPrice")
    private BigDecimal nettPrice = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "TotalAmount")
    private BigDecimal totalAmount = new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "Remark")
    private String remark = "";
    
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    public String getGoodsReceivedNoteDetailCode() {
        return goodsReceivedNoteDetailCode;
    }

    public void setGoodsReceivedNoteDetailCode(String goodsReceivedNoteDetailCode) {
        this.goodsReceivedNoteDetailCode = goodsReceivedNoteDetailCode;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
 
    
    
}
