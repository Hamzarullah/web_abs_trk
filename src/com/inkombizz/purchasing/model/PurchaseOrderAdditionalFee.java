/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.AdditionalFee;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.UnitOfMeasure;
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
@Table(name = "pur_purchase_order_additional_fee")
public class PurchaseOrderAdditionalFee extends BaseEntity implements Serializable {
    
    @Id
    @Column(name="Code")
    private String code="";
  
    @Column(name="HeaderCode")
    private String headerCode="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "AdditionalFeeCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private AdditionalFee additionalFee=null;
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "Quantity")
    private BigDecimal quantity=new BigDecimal("0.00");
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "UnitCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private UnitOfMeasure unitOfMeasure=null;
    
    @Column(name = "Price")
    private BigDecimal price=new BigDecimal("0.00");
    
    @Column(name = "Total")
    private BigDecimal total=new BigDecimal("0.00");
    
    @Transient private String unitOfMeasureCode="";
    @Transient private String unitOfMeasureName="";
    @Transient private String additionalFeeCode="";
    @Transient private String additionalFeeName="";
    @Transient private String purchaseChartOfAccountCode="";
    @Transient private String purchaseChartOfAccountName="";

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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public UnitOfMeasure getUnitOfMeasure() {
        return unitOfMeasure;
    }

    public void setUnitOfMeasure(UnitOfMeasure unitOfMeasure) {
        this.unitOfMeasure = unitOfMeasure;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    public String getPurchaseChartOfAccountCode() {
        return purchaseChartOfAccountCode;
    }

    public void setPurchaseChartOfAccountCode(String purchaseChartOfAccountCode) {
        this.purchaseChartOfAccountCode = purchaseChartOfAccountCode;
    }

    public String getPurchaseChartOfAccountName() {
        return purchaseChartOfAccountName;
    }

    public void setPurchaseChartOfAccountName(String purchaseChartOfAccountName) {
        this.purchaseChartOfAccountName = purchaseChartOfAccountName;
    }

    public AdditionalFee getAdditionalFee() {
        return additionalFee;
    }

    public void setAdditionalFee(AdditionalFee additionalFee) {
        this.additionalFee = additionalFee;
    }

    public String getAdditionalFeeCode() {
        return additionalFeeCode;
    }

    public void setAdditionalFeeCode(String additionalFeeCode) {
        this.additionalFeeCode = additionalFeeCode;
    }

    public String getAdditionalFeeName() {
        return additionalFeeName;
    }

    public void setAdditionalFeeName(String additionalFeeName) {
        this.additionalFeeName = additionalFeeName;
    }

    public String getUnitOfMeasureName() {
        return unitOfMeasureName;
    }

    public void setUnitOfMeasureName(String unitOfMeasureName) {
        this.unitOfMeasureName = unitOfMeasureName;
    }
    
    
    
}
