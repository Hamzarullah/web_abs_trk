/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;
import java.math.BigDecimal;

/**
 *
 * @author Sukha
 */
public class VendorInvoiceItemDetailTemp {
    
    private String code = "";
    private String headerCode = "";
    private String goodsReceivedNoteDetailCode = "";
    private String vinNo = "";
    private String itemMaterialCode = "";
    private String itemMaterialName = "";
    private String itemAlias = "";
    private BigDecimal price = new BigDecimal("0.00");
    private BigDecimal quantity = new BigDecimal("0.00");
    private BigDecimal balancedQuantity = new BigDecimal("0.00");
    private BigDecimal postedQuantity = new BigDecimal("0.00");
    private BigDecimal grnQuantity = new BigDecimal("0.00");
    private BigDecimal prtQuantity = new BigDecimal("0.00");
    private BigDecimal discountPercent = new BigDecimal("0.00");
    private BigDecimal discountAmount = new BigDecimal("0.00");
    private BigDecimal discount1Percent = new BigDecimal("0.00");
    private BigDecimal discount1Amount = new BigDecimal("0.00");
    private BigDecimal discount2Percent = new BigDecimal("0.00");
    private BigDecimal discount2Amount = new BigDecimal("0.00");
    private BigDecimal discount3Percent = new BigDecimal("0.00");
    private BigDecimal discount3Amount = new BigDecimal("0.00");
    private BigDecimal nettPrice = new BigDecimal("0.00");
    private BigDecimal total = new BigDecimal("0.00");
    private BigDecimal totalBalanced = new BigDecimal("0.00");
    private String unitOfMeasureCode = "";
    private String itemBrandName = "";
    private String inventoryType = "";
    private String cogsIdr = "";
    private String remark = "";
    
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getVinNo() {
        return vinNo;
    }

    public void setVinNo(String vinNo) {
        this.vinNo = vinNo;
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

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getUnitOfMeasureCode() {
        return unitOfMeasureCode;
    }

    public void setUnitOfMeasureCode(String unitOfMeasureCode) {
        this.unitOfMeasureCode = unitOfMeasureCode;
    }

    public String getItemBrandName() {
        return itemBrandName;
    }

    public void setItemBrandName(String itemBrandName) {
        this.itemBrandName = itemBrandName;
    }

    public String getGoodsReceivedNoteDetailCode() {
        return goodsReceivedNoteDetailCode;
    }

    public void setGoodsReceivedNoteDetailCode(String goodsReceivedNoteDetailCode) {
        this.goodsReceivedNoteDetailCode = goodsReceivedNoteDetailCode;
    }

    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
    }

    public BigDecimal getBalancedQuantity() {
        return balancedQuantity;
    }

    public void setBalancedQuantity(BigDecimal balancedQuantity) {
        this.balancedQuantity = balancedQuantity;
    }

    public BigDecimal getPostedQuantity() {
        return postedQuantity;
    }

    public void setPostedQuantity(BigDecimal postedQuantity) {
        this.postedQuantity = postedQuantity;
    }

    public BigDecimal getGrnQuantity() {
        return grnQuantity;
    }

    public void setGrnQuantity(BigDecimal grnQuantity) {
        this.grnQuantity = grnQuantity;
    }

    public BigDecimal getTotalBalanced() {
        return totalBalanced;
    }

    public void setTotalBalanced(BigDecimal totalBalanced) {
        this.totalBalanced = totalBalanced;
    }

    public String getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(String cogsIdr) {
        this.cogsIdr = cogsIdr;
    }

    public BigDecimal getPrtQuantity() {
        return prtQuantity;
    }

    public void setPrtQuantity(BigDecimal prtQuantity) {
        this.prtQuantity = prtQuantity;
    }

    public BigDecimal getDiscount1Percent() {
        return discount1Percent;
    }

    public void setDiscount1Percent(BigDecimal discount1Percent) {
        this.discount1Percent = discount1Percent;
    }

    public BigDecimal getDiscount1Amount() {
        return discount1Amount;
    }

    public void setDiscount1Amount(BigDecimal discount1Amount) {
        this.discount1Amount = discount1Amount;
    }

    public BigDecimal getDiscount2Percent() {
        return discount2Percent;
    }

    public void setDiscount2Percent(BigDecimal discount2Percent) {
        this.discount2Percent = discount2Percent;
    }

    public BigDecimal getDiscount2Amount() {
        return discount2Amount;
    }

    public void setDiscount2Amount(BigDecimal discount2Amount) {
        this.discount2Amount = discount2Amount;
    }

    public BigDecimal getDiscount3Percent() {
        return discount3Percent;
    }

    public void setDiscount3Percent(BigDecimal discount3Percent) {
        this.discount3Percent = discount3Percent;
    }

    public BigDecimal getDiscount3Amount() {
        return discount3Amount;
    }

    public void setDiscount3Amount(BigDecimal discount3Amount) {
        this.discount3Amount = discount3Amount;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    
    
}
