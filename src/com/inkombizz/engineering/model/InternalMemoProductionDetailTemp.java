
package com.inkombizz.engineering.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class InternalMemoProductionDetailTemp {
    
    private String code="";
    private String headerCode="";
    private String description="";
    private String valveTag="";
    private String dataSheet="";
    private BigDecimal internalMemoSortNo= new BigDecimal("0");
    private String itemFinishGoodsCode = "";
    private String itemFinishGoodName = "";
    private String itemFinishGoodsRemark = "";
//    private String itemBodyConstructionCode = "";
//    private String itemBodyConstructionName = "";
    private String itemTypeDesignCode = "";
    private String itemTypeDesignName = "";
    private String itemSeatDesignCode = "";
    private String itemSeatDesignName = "";
    private String itemSizeCode = "";
    private String itemSizeName = "";
    private String itemRatingCode = "";
    private String itemRatingName = "";
    private String itemBoreCode = "";
    private String itemBoreName = "";
    private String itemEndConCode = "";
    private String itemEndConName = "";
    private String itemBodyCode = "";
    private String itemBodyName = "";
    private String itemBallCode = "";
    private String itemBallName = "";
    private String itemSeatCode = "";
    private String itemSeatName = "";
    private String itemSeatInsertCode = "";
    private String itemSeatInsertName = "";
    private String itemStemCode = "";
    private String itemStemName = "";
    private String itemSealCode = "";
    private String itemSealName = "";
    private String itemBoltCode = "";
    private String itemBoltName = "";
    private String itemDiscCode = "";
    private String itemDiscName = "";
    private String itemPlatesCode = "";
    private String itemPlatesName = "";
    private String itemShaftCode = "";
    private String itemShaftName = "";
    private String itemSpringCode = "";
    private String itemSpringName = "";
    private String itemArmPinCode = "";
    private String itemArmPinName = "";
    private String itemBackseatCode = "";
    private String itemBackseatName = "";
    private String itemArmCode = "";
    private String itemArmName = "";
    private String itemHingePinCode = "";
    private String itemHingePinName = "";
    private String itemStopPinCode = "";
    private String itemStopPinName = "";
    private String itemOperatorCode = "";
    private String itemOperatorName = "";
    private BigDecimal quantity=new BigDecimal("0.00");
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1990, 01, 01);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1990, 01, 01);

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

    public String getItemFinishGoodsCode() {
        return itemFinishGoodsCode;
    }

    public void setItemFinishGoodsCode(String itemFinishGoodsCode) {
        this.itemFinishGoodsCode = itemFinishGoodsCode;
    }

    public String getItemFinishGoodName() {
        return itemFinishGoodName;
    }

    public void setItemFinishGoodName(String itemFinishGoodName) {
        this.itemFinishGoodName = itemFinishGoodName;
    }    

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getValveTag() {
        return valveTag;
    }

    public void setValveTag(String valveTag) {
        this.valveTag = valveTag;
    }

    public String getDataSheet() {
        return dataSheet;
    }

    public void setDataSheet(String dataSheet) {
        this.dataSheet = dataSheet;
    }

    public String getItemFinishGoodsRemark() {
        return itemFinishGoodsRemark;
    }

    public void setItemFinishGoodsRemark(String itemFinishGoodsRemark) {
        this.itemFinishGoodsRemark = itemFinishGoodsRemark;
    }

//    public String getItemBodyConstructionCode() {
//        return itemBodyConstructionCode;
//    }
//
//    public void setItemBodyConstructionCode(String itemBodyConstructionCode) {
//        this.itemBodyConstructionCode = itemBodyConstructionCode;
//    }
//
//    public String getItemBodyConstructionName() {
//        return itemBodyConstructionName;
//    }
//
//    public void setItemBodyConstructionName(String itemBodyConstructionName) {
//        this.itemBodyConstructionName = itemBodyConstructionName;
//    }

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

    public String getItemBackseatCode() {
        return itemBackseatCode;
    }

    public void setItemBackseatCode(String itemBackseatCode) {
        this.itemBackseatCode = itemBackseatCode;
    }

    public String getItemBackseatName() {
        return itemBackseatName;
    }

    public void setItemBackseatName(String itemBackseatName) {
        this.itemBackseatName = itemBackseatName;
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

    public BigDecimal getInternalMemoSortNo() {
        return internalMemoSortNo;
    }

    public void setInternalMemoSortNo(BigDecimal internalMemoSortNo) {
        this.internalMemoSortNo = internalMemoSortNo;
    }

    
    
    
}
