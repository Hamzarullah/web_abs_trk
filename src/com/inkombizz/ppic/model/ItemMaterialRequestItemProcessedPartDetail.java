/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.ppic.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemFinishGoods;
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
 * @author Siswanto
 */

@Entity
@Table(name = "ppic_item_material_request_item_processed_part_detail")
public class ItemMaterialRequestItemProcessedPartDetail extends BaseEntity implements Serializable{
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @Column(name = "HeaderCode")
    private String headerCode = "";
    
    @Column(name = "DocumentSortNo")
    private BigDecimal documentSortNo = new BigDecimal("0.00");
    
    @Column(name = "DocumentDetailCode")
    private String documentDetailCode = "";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemFinishGoodsCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemFinishGoods itemFinishGoods=null;
    
    @Column(name = "ItemProductionPlanningOrderNo")
    private BigDecimal itemProductionPlanningOrderNo = new BigDecimal("0.00"); 
    
    private @Transient BigDecimal partNo = new BigDecimal("0.00"); 
    private @Transient String bomDetailCode = "";
    private @Transient String itemFinishGoodsCode = "";
    private @Transient String itemFinishGoodsRemark = "";
    private @Transient String partCode = "";
    private @Transient String partName = "";
    private @Transient String drawingCode = "";
    private @Transient String dimension = "";
    private @Transient String requiredLength = "";
    private @Transient String material = "";
    private @Transient String requirement = "";
    private @Transient String processedStatus = "";
    private @Transient String remark = "";
    private @Transient String x = "";
    private @Transient String revNo = "";
    private @Transient BigDecimal quantityBom = new BigDecimal("0.00"); 

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

    public BigDecimal getDocumentSortNo() {
        return documentSortNo;
    }

    public void setDocumentSortNo(BigDecimal documentSortNo) {
        this.documentSortNo = documentSortNo;
    }

    public String getDocumentDetailCode() {
        return documentDetailCode;
    }

    public void setDocumentDetailCode(String documentDetailCode) {
        this.documentDetailCode = documentDetailCode;
    }

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public BigDecimal getItemProductionPlanningOrderNo() {
        return itemProductionPlanningOrderNo;
    }

    public void setItemProductionPlanningOrderNo(BigDecimal itemProductionPlanningOrderNo) {
        this.itemProductionPlanningOrderNo = itemProductionPlanningOrderNo;
    }

    public String getPartCode() {
        return partCode;
    }

    public void setPartCode(String partCode) {
        this.partCode = partCode;
    }

    public BigDecimal getPartNo() {
        return partNo;
    }

    public void setPartNo(BigDecimal partNo) {
        this.partNo = partNo;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public String getDrawingCode() {
        return drawingCode;
    }

    public void setDrawingCode(String drawingCode) {
        this.drawingCode = drawingCode;
    }

    public String getDimension() {
        return dimension;
    }

    public void setDimension(String dimension) {
        this.dimension = dimension;
    }

    public String getRequiredLength() {
        return requiredLength;
    }

    public void setRequiredLength(String requiredLength) {
        this.requiredLength = requiredLength;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getProcessedStatus() {
        return processedStatus;
    }

    public void setProcessedStatus(String processedStatus) {
        this.processedStatus = processedStatus;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getX() {
        return x;
    }

    public void setX(String x) {
        this.x = x;
    }

    public String getRevNo() {
        return revNo;
    }

    public void setRevNo(String revNo) {
        this.revNo = revNo;
    }

    public String getItemFinishGoodsCode() {
        return itemFinishGoodsCode;
    }

    public void setItemFinishGoodsCode(String itemFinishGoodsCode) {
        this.itemFinishGoodsCode = itemFinishGoodsCode;
    }

    public String getItemFinishGoodsRemark() {
        return itemFinishGoodsRemark;
    }

    public void setItemFinishGoodsRemark(String itemFinishGoodsRemark) {
        this.itemFinishGoodsRemark = itemFinishGoodsRemark;
    }

    public BigDecimal getQuantityBom() {
        return quantityBom;
    }

    public void setQuantityBom(BigDecimal quantityBom) {
        this.quantityBom = quantityBom;
    }

    public String getBomDetailCode() {
        return bomDetailCode;
    }

    public void setBomDetailCode(String bomDetailCode) {
        this.bomDetailCode = bomDetailCode;
    }

    
    
}
