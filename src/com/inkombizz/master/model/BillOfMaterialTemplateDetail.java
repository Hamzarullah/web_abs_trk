/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.model;

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
@Table(name = "mst_bill_of_material_template_detail")
public class BillOfMaterialTemplateDetail implements Serializable {
    
    @Id
    @Column(name="Code")
    private String code = "";
    
    @Column(name="HeaderCode")
    private String headerCode = "";
    
    @Column(name="SortNo")
    private BigDecimal sortNo = new BigDecimal("0.00");
    
    @Column(name="PartNo")
    private String partNo = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PartCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Part part = null;
    
    @Column(name="DrawingCode")
    private String drawingCode = "";
    
    @Column(name="Dimension")
    private String dimension = "";
    
    @Column(name = "RequiredLength")
    private BigDecimal requiredLength = new BigDecimal("0.00");
    
    @Column(name="Material")
    private String material = "";
    
    @Column(name="Quantity")
    private BigDecimal quantity = new BigDecimal("0.00");
    
    @Column(name="Requirement")
    private String requirement = "";
    
    @Column(name="ProcessedStatus")
    private String processedStatus = "";
    
    @Column(name="ActiveStatus")
    private boolean activeStatus =false;
    
    @Column(name="X")
    private String x = "";
    
    @Column(name="Remark")
    private String remark = "";
    
    private @Transient String partCode=""; 
    private @Transient String partName=""; 
    private @Transient String activeStatusDetail=""; 
    

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public BigDecimal getSortNo() {
        return sortNo;
    }

    public void setSortNo(BigDecimal sortNo) {
        this.sortNo = sortNo;
    }

    public String getPartNo() {
        return partNo;
    }

    public void setPartNo(String partNo) {
        this.partNo = partNo;
    }

    public Part getPart() {
        return part;
    }

    public void setPart(Part part) {
        this.part = part;
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

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
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

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    public String getX() {
        return x;
    }

    public void setX(String x) {
        this.x = x;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getPartCode() {
        return partCode;
    }

    public void setPartCode(String partCode) {
        this.partCode = partCode;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public String getActiveStatusDetail() {
        return activeStatusDetail;
    }

    public void setActiveStatusDetail(String activeStatusDetail) {
        this.activeStatusDetail = activeStatusDetail;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public BigDecimal getRequiredLength() {
        return requiredLength;
    }

    public void setRequiredLength(BigDecimal requiredLength) {
        this.requiredLength = requiredLength;
    }
    
    
}
