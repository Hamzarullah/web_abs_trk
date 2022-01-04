
package com.inkombizz.purchasing.model;

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

@Entity
@Table(name = "pur_purchase_request_detail")
public class PurchaseRequestDetail extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial=null;
   
    @Column(name = "DocumentDetailCode")
    private String DocumentDetailCode = "";
    
    @Column(name = "Quantity")
    private BigDecimal quantity=new BigDecimal("0.00");
    
    @Column(name = "Remark")
    private String remark="";
    
    
    //Transient
    private @Transient String itemMaterialCode="";
    private @Transient String itemMaterialName="";
    private @Transient String unitOfMeasureCode="";
    private @Transient String unitOfMeasureName="";
    private @Transient BigDecimal onHandStock = new BigDecimal("0");

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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUnitOfMeasureCode() {
        return unitOfMeasureCode;
    }

    public void setUnitOfMeasureCode(String unitOfMeasureCode) {
        this.unitOfMeasureCode = unitOfMeasureCode;
    }

    public String getUnitOfMeasureName() {
        return unitOfMeasureName;
    }

    public void setUnitOfMeasureName(String unitOfMeasureName) {
        this.unitOfMeasureName = unitOfMeasureName;
    }

    public String getDocumentDetailCode() {
        return DocumentDetailCode;
    }

    public void setDocumentDetailCode(String DocumentDetailCode) {
        this.DocumentDetailCode = DocumentDetailCode;
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

    public BigDecimal getOnHandStock() {
        return onHandStock;
    }

    public void setOnHandStock(BigDecimal onHandStock) {
        this.onHandStock = onHandStock;
    }

    
    
}
