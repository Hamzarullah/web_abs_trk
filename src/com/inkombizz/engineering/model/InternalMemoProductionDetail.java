/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.model;

import com.inkombizz.master.model.ItemFinishGoods;
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


@Entity
@Table(name = "eng_internal_memo_production_detail")
public class InternalMemoProductionDetail implements Serializable{
    
    private String code="";
    private String headerCode="";
    private String description="";
    private String valveTag="";
    private String dataSheet="";
    private ItemFinishGoods itemFinishGood= null;
    private BigDecimal internalMemoSortNo= new BigDecimal("0");
    private BigDecimal quantity=new BigDecimal("0.00");
    private String createdBy="";
    private Date createdDate=DateUtils.newDate(1900, 1, 1);
    private String updatedBy="";
    private Date updatedDate=DateUtils.newDate(1900, 1, 1);

    @Id
    @Column(name="Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "HeaderCode")
    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    @Column(name = "Description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "ValveTag")
    public String getValveTag() {
        return valveTag;
    }

    public void setValveTag(String valveTag) {
        this.valveTag = valveTag;
    }

    @Column(name = "DataSheet")
    public String getDataSheet() {
        return dataSheet;
    }

    public void setDataSheet(String dataSheet) {
        this.dataSheet = dataSheet;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemFinishGoodsCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public ItemFinishGoods getItemFinishGood() {
        return itemFinishGood;
    }

    public void setItemFinishGood(ItemFinishGoods itemFinishGood) {
        this.itemFinishGood = itemFinishGood;
    }
    
    @Column(name = "Quantity")
    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }
    
    @Column(name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column(name = "UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    @Column(name = "InternalMemoSortNo")

    public BigDecimal getInternalMemoSortNo() {
        return internalMemoSortNo;
    }

    public void setInternalMemoSortNo(BigDecimal internalMemoSortNo) {
        this.internalMemoSortNo = internalMemoSortNo;
    }
    
    
    
    
}
