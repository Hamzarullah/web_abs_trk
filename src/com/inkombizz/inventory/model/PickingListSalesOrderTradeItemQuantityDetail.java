
package com.inkombizz.inventory.model;

import com.inkombizz.master.model.Item;
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

import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.Rack;

@Entity 
@Table(name = "ivt_picking_list_so_trade_item_quantity_detail")
public class PickingListSalesOrderTradeItemQuantityDetail implements Serializable{
    
    private String code = "";
    private String headerCode = "";
    private String salesOrderTradeItemDetailCode = "";
    private String itemAlias = "";
    private BigDecimal quantity = new BigDecimal ("0.00");
    private BigDecimal cogsIdr = new BigDecimal ("0.00");
    private BigDecimal totalAmount = new BigDecimal ("0.00");
    private Rack rack = null;
    private Item item = null;
    private String createdBy = "";
    private String updatedBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    @Id
    @Column (name="Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column (name="HeaderCode")
    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    @Column (name="salesOrderTradeItemDetailCode")
    public String getSalesOrderTradeItemDetailCode() {
        return salesOrderTradeItemDetailCode;
    }

    public void setSalesOrderTradeItemDetailCode(String salesOrderTradeItemDetailCode) {
        this.salesOrderTradeItemDetailCode = salesOrderTradeItemDetailCode;
    }

    @Column (name="ItemAlias")
    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
    }
    
    @Column (name="Quantity")
    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    @Column (name="COGSIDR")
    public BigDecimal getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(BigDecimal cogsIdr) {
        this.cogsIdr = cogsIdr;
    }

    @Column (name="totalAmount")
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RackCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    @Column (name="CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column (name="CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column (name="UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column (name="UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
}
