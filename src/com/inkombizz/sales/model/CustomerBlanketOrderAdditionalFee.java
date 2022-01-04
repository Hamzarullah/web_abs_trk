
package com.inkombizz.sales.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.AdditionalFee;
import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.inkombizz.master.model.UnitOfMeasure;
import javax.persistence.Transient;


@Entity
@Table(name = "sal_customer_blanket_order_additional_fee")
public class CustomerBlanketOrderAdditionalFee extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
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
    @Transient private String coaCode="";
    @Transient private String coaName="";
    @Transient private String additionalFeeCode="";
    @Transient private String additionalFeeName="";

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

    public String getCoaCode() {
        return coaCode;
    }

    public void setCoaCode(String coaCode) {
        this.coaCode = coaCode;
    }

    public String getCoaName() {
        return coaName;
    }

    public void setCoaName(String coaName) {
        this.coaName = coaName;
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
    
    
}
