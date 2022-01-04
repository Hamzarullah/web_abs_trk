
package com.inkombizz.sales.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemFinishGoods;
import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.inkombizz.utils.DateUtils;
import java.util.Date;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.Transient;


@Entity
@Table(name = "sal_customer_blanket_order_item_delivery_date")
public class CustomerBlanketOrderItemDeliveryDate extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemFinishGoodsCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemFinishGoods itemFinishGoods=null;
    
    @Column(name = "Quantity")
    private BigDecimal quantity=new BigDecimal("0.00");
    
    @Column(name = "DeliveryDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date deliveryDate= DateUtils.newDate(1900, 1, 1);

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesQuotationCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private SalesQuotation salesQuotation=null;
    
    private @Transient String itemFinishGoodsCode="";
    private @Transient String itemFinishGoodsRemark="";
    private @Transient String salesQuotationCode="";
    private @Transient BigDecimal customerPurchaseOrderSortNo=new BigDecimal("0");
    private @Transient String refNo="";

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

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public SalesQuotation getSalesQuotation() {
        return salesQuotation;
    }

    public void setSalesQuotation(SalesQuotation salesQuotation) {
        this.salesQuotation = salesQuotation;
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

    public String getSalesQuotationCode() {
        return salesQuotationCode;
    }

    public void setSalesQuotationCode(String salesQuotationCode) {
        this.salesQuotationCode = salesQuotationCode;
    }

    public BigDecimal getCustomerPurchaseOrderSortNo() {
        return customerPurchaseOrderSortNo;
    }

    public void setCustomerPurchaseOrderSortNo(BigDecimal customerPurchaseOrderSortNo) {
        this.customerPurchaseOrderSortNo = customerPurchaseOrderSortNo;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    
    
    
}
