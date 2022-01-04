/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.Transient;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "mst_bill_of_material_template")
public class BillOfMaterialTemplate implements Serializable {
    
    @Id
    @Column(name="Code")
    private String code = "";
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate = DateUtils.newDate(1990, 01, 01);
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemFinishGoodsCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private ItemFinishGoods itemFinishGoods = null;
    
    @Column(name="RefNo")
    private String refNo = "";
    
    @Column(name="Remark")
    private String remark = "";
    
    @Column(name="CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1990, 01, 01);
    
    @Column(name="UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1990, 01, 01);
    
    //Transient
    private @Transient String itemFinishGoodsCode="";
    private @Transient String valveTypeCode="";
    private @Transient String valveTypeName="";
    private @Transient String copyFrom="";
    //finishGoods
    @Transient private String itemBodyConstructionCode="";
    @Transient private String itemBodyConstructionName="";
    @Transient private String itemTypeDesignCode="";
    @Transient private String itemTypeDesignName="";
    @Transient private String itemSeatDesignCode="";
    @Transient private String itemSeatDesignName="";
    @Transient private String itemSizeCode="";
    @Transient private String itemSizeName="";
    @Transient private String itemRatingCode="";
    @Transient private String itemRatingName="";
    @Transient private String itemBoreCode="";
    @Transient private String itemBoreName="";
    
    @Transient private String itemEndConCode="";
    @Transient private String itemEndConName="";
    @Transient private String itemBodyCode="";
    @Transient private String itemBodyName="";
    @Transient private String itemBallCode="";
    @Transient private String itemBallName="";
    @Transient private String itemSeatCode="";
    @Transient private String itemSeatName="";
    @Transient private String itemSeatInsertCode="";
    @Transient private String itemSeatInsertName="";
    @Transient private String itemStemCode="";
    @Transient private String itemStemName="";
    
    @Transient private String itemSealCode="";
    @Transient private String itemSealName="";
    @Transient private String itemBoltCode="";
    @Transient private String itemBoltName="";
    @Transient private String itemDiscCode="";
    @Transient private String itemDiscName="";
    @Transient private String itemPlatesCode="";
    @Transient private String itemPlatesName="";
    @Transient private String itemShaftCode="";
    @Transient private String itemShaftName="";
    @Transient private String itemSpringCode="";
    @Transient private String itemSpringName="";
    
    @Transient private String itemArmPinCode="";
    @Transient private String itemArmPinName="";
    @Transient private String itemBackSeatCode="";
    @Transient private String itemBackSeatName="";
    @Transient private String itemArmCode="";
    @Transient private String itemArmName="";
    @Transient private String itemHingePinCode="";
    @Transient private String itemHingePinName="";
    @Transient private String itemStopPinCode="";
    @Transient private String itemStopPinName="";
    @Transient private String itemOperatorCode="";
    @Transient private String itemOperatorName="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getItemFinishGoodsCode() {
        return itemFinishGoodsCode;
    }

    public void setItemFinishGoodsCode(String itemFinishGoodsCode) {
        this.itemFinishGoodsCode = itemFinishGoodsCode;
    }

    public String getValveTypeCode() {
        return valveTypeCode;
    }

    public void setValveTypeCode(String valveTypeCode) {
        this.valveTypeCode = valveTypeCode;
    }

    public String getValveTypeName() {
        return valveTypeName;
    }

    public void setValveTypeName(String valveTypeName) {
        this.valveTypeName = valveTypeName;
    }

    public String getItemBodyConstructionCode() {
        return itemBodyConstructionCode;
    }

    public void setItemBodyConstructionCode(String itemBodyConstructionCode) {
        this.itemBodyConstructionCode = itemBodyConstructionCode;
    }

    public String getItemBodyConstructionName() {
        return itemBodyConstructionName;
    }

    public void setItemBodyConstructionName(String itemBodyConstructionName) {
        this.itemBodyConstructionName = itemBodyConstructionName;
    }

    public String getItemTypeDesignCode() {
        return itemTypeDesignCode;
    }

    public void setItemTypeDesignCode(String itemTypeDesignCode) {
        this.itemTypeDesignCode = itemTypeDesignCode;
    }

    public String getItemTypeDesignName() {
        return itemTypeDesignName;
    }

    public void setItemTypeDesignName(String itemTypeDesignName) {
        this.itemTypeDesignName = itemTypeDesignName;
    }

    public String getItemSeatDesignCode() {
        return itemSeatDesignCode;
    }

    public void setItemSeatDesignCode(String itemSeatDesignCode) {
        this.itemSeatDesignCode = itemSeatDesignCode;
    }

    public String getItemSeatDesignName() {
        return itemSeatDesignName;
    }

    public void setItemSeatDesignName(String itemSeatDesignName) {
        this.itemSeatDesignName = itemSeatDesignName;
    }

    public String getItemSizeCode() {
        return itemSizeCode;
    }

    public void setItemSizeCode(String itemSizeCode) {
        this.itemSizeCode = itemSizeCode;
    }

    public String getItemSizeName() {
        return itemSizeName;
    }

    public void setItemSizeName(String itemSizeName) {
        this.itemSizeName = itemSizeName;
    }

    public String getItemRatingCode() {
        return itemRatingCode;
    }

    public void setItemRatingCode(String itemRatingCode) {
        this.itemRatingCode = itemRatingCode;
    }

    public String getItemRatingName() {
        return itemRatingName;
    }

    public void setItemRatingName(String itemRatingName) {
        this.itemRatingName = itemRatingName;
    }

    public String getItemBoreCode() {
        return itemBoreCode;
    }

    public void setItemBoreCode(String itemBoreCode) {
        this.itemBoreCode = itemBoreCode;
    }

    public String getItemBoreName() {
        return itemBoreName;
    }

    public void setItemBoreName(String itemBoreName) {
        this.itemBoreName = itemBoreName;
    }

    public String getItemEndConCode() {
        return itemEndConCode;
    }

    public void setItemEndConCode(String itemEndConCode) {
        this.itemEndConCode = itemEndConCode;
    }

    public String getItemEndConName() {
        return itemEndConName;
    }

    public void setItemEndConName(String itemEndConName) {
        this.itemEndConName = itemEndConName;
    }

    public String getItemBodyCode() {
        return itemBodyCode;
    }

    public void setItemBodyCode(String itemBodyCode) {
        this.itemBodyCode = itemBodyCode;
    }

    public String getItemBodyName() {
        return itemBodyName;
    }

    public void setItemBodyName(String itemBodyName) {
        this.itemBodyName = itemBodyName;
    }

    public String getItemBallCode() {
        return itemBallCode;
    }

    public void setItemBallCode(String itemBallCode) {
        this.itemBallCode = itemBallCode;
    }

    public String getItemBallName() {
        return itemBallName;
    }

    public void setItemBallName(String itemBallName) {
        this.itemBallName = itemBallName;
    }

    public String getItemSeatCode() {
        return itemSeatCode;
    }

    public void setItemSeatCode(String itemSeatCode) {
        this.itemSeatCode = itemSeatCode;
    }

    public String getItemSeatName() {
        return itemSeatName;
    }

    public void setItemSeatName(String itemSeatName) {
        this.itemSeatName = itemSeatName;
    }

    public String getItemSeatInsertCode() {
        return itemSeatInsertCode;
    }

    public void setItemSeatInsertCode(String itemSeatInsertCode) {
        this.itemSeatInsertCode = itemSeatInsertCode;
    }

    public String getItemSeatInsertName() {
        return itemSeatInsertName;
    }

    public void setItemSeatInsertName(String itemSeatInsertName) {
        this.itemSeatInsertName = itemSeatInsertName;
    }

    public String getItemStemCode() {
        return itemStemCode;
    }

    public void setItemStemCode(String itemStemCode) {
        this.itemStemCode = itemStemCode;
    }

    public String getItemStemName() {
        return itemStemName;
    }

    public void setItemStemName(String itemStemName) {
        this.itemStemName = itemStemName;
    }

    public String getItemSealCode() {
        return itemSealCode;
    }

    public void setItemSealCode(String itemSealCode) {
        this.itemSealCode = itemSealCode;
    }

    public String getItemSealName() {
        return itemSealName;
    }

    public void setItemSealName(String itemSealName) {
        this.itemSealName = itemSealName;
    }

    public String getItemBoltCode() {
        return itemBoltCode;
    }

    public void setItemBoltCode(String itemBoltCode) {
        this.itemBoltCode = itemBoltCode;
    }

    public String getItemBoltName() {
        return itemBoltName;
    }

    public void setItemBoltName(String itemBoltName) {
        this.itemBoltName = itemBoltName;
    }

    public String getItemDiscCode() {
        return itemDiscCode;
    }

    public void setItemDiscCode(String itemDiscCode) {
        this.itemDiscCode = itemDiscCode;
    }

    public String getItemDiscName() {
        return itemDiscName;
    }

    public void setItemDiscName(String itemDiscName) {
        this.itemDiscName = itemDiscName;
    }

    public String getItemPlatesCode() {
        return itemPlatesCode;
    }

    public void setItemPlatesCode(String itemPlatesCode) {
        this.itemPlatesCode = itemPlatesCode;
    }

    public String getItemPlatesName() {
        return itemPlatesName;
    }

    public void setItemPlatesName(String itemPlatesName) {
        this.itemPlatesName = itemPlatesName;
    }

    public String getItemShaftCode() {
        return itemShaftCode;
    }

    public void setItemShaftCode(String itemShaftCode) {
        this.itemShaftCode = itemShaftCode;
    }

    public String getItemShaftName() {
        return itemShaftName;
    }

    public void setItemShaftName(String itemShaftName) {
        this.itemShaftName = itemShaftName;
    }

    public String getItemSpringCode() {
        return itemSpringCode;
    }

    public void setItemSpringCode(String itemSpringCode) {
        this.itemSpringCode = itemSpringCode;
    }

    public String getItemSpringName() {
        return itemSpringName;
    }

    public void setItemSpringName(String itemSpringName) {
        this.itemSpringName = itemSpringName;
    }

    public String getItemArmPinCode() {
        return itemArmPinCode;
    }

    public void setItemArmPinCode(String itemArmPinCode) {
        this.itemArmPinCode = itemArmPinCode;
    }

    public String getItemArmPinName() {
        return itemArmPinName;
    }

    public void setItemArmPinName(String itemArmPinName) {
        this.itemArmPinName = itemArmPinName;
    }

    public String getItemBackSeatCode() {
        return itemBackSeatCode;
    }

    public void setItemBackSeatCode(String itemBackSeatCode) {
        this.itemBackSeatCode = itemBackSeatCode;
    }

    public String getItemBackSeatName() {
        return itemBackSeatName;
    }

    public void setItemBackSeatName(String itemBackSeatName) {
        this.itemBackSeatName = itemBackSeatName;
    }

    public String getItemArmCode() {
        return itemArmCode;
    }

    public void setItemArmCode(String itemArmCode) {
        this.itemArmCode = itemArmCode;
    }

    public String getItemArmName() {
        return itemArmName;
    }

    public void setItemArmName(String itemArmName) {
        this.itemArmName = itemArmName;
    }

    public String getItemHingePinCode() {
        return itemHingePinCode;
    }

    public void setItemHingePinCode(String itemHingePinCode) {
        this.itemHingePinCode = itemHingePinCode;
    }

    public String getItemHingePinName() {
        return itemHingePinName;
    }

    public void setItemHingePinName(String itemHingePinName) {
        this.itemHingePinName = itemHingePinName;
    }

    public String getItemStopPinCode() {
        return itemStopPinCode;
    }

    public void setItemStopPinCode(String itemStopPinCode) {
        this.itemStopPinCode = itemStopPinCode;
    }

    public String getItemStopPinName() {
        return itemStopPinName;
    }

    public void setItemStopPinName(String itemStopPinName) {
        this.itemStopPinName = itemStopPinName;
    }

    public String getItemOperatorCode() {
        return itemOperatorCode;
    }

    public void setItemOperatorCode(String itemOperatorCode) {
        this.itemOperatorCode = itemOperatorCode;
    }

    public String getItemOperatorName() {
        return itemOperatorName;
    }

    public void setItemOperatorName(String itemOperatorName) {
        this.itemOperatorName = itemOperatorName;
    }

    public String getCopyFrom() {
        return copyFrom;
    }

    public void setCopyFrom(String copyFrom) {
        this.copyFrom = copyFrom;
    }
    
    
    
    
}
