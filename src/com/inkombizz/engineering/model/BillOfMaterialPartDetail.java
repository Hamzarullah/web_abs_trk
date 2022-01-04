/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.Part;
import com.inkombizz.master.model.Reason;
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
import javax.persistence.Transient;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 *
 * @author CHRIST
 */
 
@Entity
@Table(name = "eng_bill_of_material_part_detail")
public class BillOfMaterialPartDetail implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @Column(name = "HeaderCode")
    private String headerCode = "";
    
    @Column(name = "SortNo")
    private BigDecimal sortNo = new BigDecimal("0.00");
    
    @Column(name = "PartNo")
    private BigDecimal partNo = new BigDecimal("0.00");
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PartCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Part part = null;
    
    @Column(name = "DocumentDetailCode")
    private String documentDetailCode = "";
    
    @Column(name = "DrawingCode")
    private String drawingCode = "";
    
    @Column(name = "DrawingCodePath")
    private String drawingCodePath = "";
    
    @Column(name = "Dimension")
    private String dimension = "";
    
    @Column(name = "RequiredLength")
    private BigDecimal requiredLength = new BigDecimal("0.00");
    
    @Column(name = "Material")
    private String material = "";
    
    @Column(name = "Quantity")
    private BigDecimal quantity = new BigDecimal("0.00");
    
    @Column(name = "Requirement")
    private String requirement = "";
    
    @Column(name = "ProcessedStatus")
    private String processedStatus = "";
    
    @Column(name = "Remark")
    private String remark = "";
    
    @Column(name = "X")
    private String x = "";
    
    @Column(name = "RevNo")
    private BigDecimal revNo = new BigDecimal("0.00");
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    private Date createdDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    private Date updatedDate= DateUtils.newDate(1900, 1, 1);
    
    private @Transient String bomCode= "";
    private @Transient String documentOrderDetailCode= "";
    private @Transient String itemFinishGoodsCode= "";
    private @Transient String itemFinishGoodsRemark= "";
    private @Transient String ppoDetailCode= "";
    private @Transient BigDecimal itemPPONo= new BigDecimal("0.00");
    private @Transient BigDecimal documentSortNo= new BigDecimal("0.00");
    private @Transient String imrNo= "";
    private @Transient Date imrDate;
    private @Transient String bomStatusNew= "";
    private @Transient String approvalStatus= "";
    private @Transient String partCode= "";
    private @Transient String partName= "";
    private @Transient String valveTag = "";
    private @Transient String dataSheet = "";
    private @Transient String description = "";
    
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
    @Transient private BigDecimal quantityIfg=new BigDecimal("0.00");
    
    
    //Default Set and Get

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

    public BigDecimal getSortNo() {
        return sortNo;
    }

    public void setSortNo(BigDecimal sortNo) {
        this.sortNo = sortNo;
    }

    public BigDecimal getPartNo() {
        return partNo;
    }

    public void setPartNo(BigDecimal partNo) {
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

    public String getDrawingCodePath() {
        return drawingCodePath;
    }

    public void setDrawingCodePath(String drawingCodePath) {
        this.drawingCodePath = drawingCodePath;
    }

    public BigDecimal getRevNo() {
        return revNo;
    }

    public void setRevNo(BigDecimal revNo) {
        this.revNo = revNo;
    }

    public String getDocumentOrderDetailCode() {
        return documentOrderDetailCode;
    }

    public void setDocumentOrderDetailCode(String documentOrderDetailCode) {
        this.documentOrderDetailCode = documentOrderDetailCode;
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

    public BigDecimal getQuantityIfg() {
        return quantityIfg;
    }

    public void setQuantityIfg(BigDecimal quantityIfg) {
        this.quantityIfg = quantityIfg;
    }

    public String getBomStatusNew() {
        return bomStatusNew;
    }

    public void setBomStatusNew(String bomStatusNew) {
        this.bomStatusNew = bomStatusNew;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getDocumentDetailCode() {
        return documentDetailCode;
    }

    public void setDocumentDetailCode(String documentDetailCode) {
        this.documentDetailCode = documentDetailCode;
    }

    public String getBomCode() {
        return bomCode;
    }

    public void setBomCode(String bomCode) {
        this.bomCode = bomCode;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public String getPartCode() {
        return partCode;
    }

    public void setPartCode(String partCode) {
        this.partCode = partCode;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPpoDetailCode() {
        return ppoDetailCode;
    }

    public void setPpoDetailCode(String ppoDetailCode) {
        this.ppoDetailCode = ppoDetailCode;
    }

    public BigDecimal getItemPPONo() {
        return itemPPONo;
    }

    public void setItemPPONo(BigDecimal itemPPONo) {
        this.itemPPONo = itemPPONo;
    }

    public String getImrNo() {
        return imrNo;
    }

    public void setImrNo(String imrNo) {
        this.imrNo = imrNo;
    }

    public Date getImrDate() {
        return imrDate;
    }

    public void setImrDate(Date imrDate) {
        this.imrDate = imrDate;
    }

    public BigDecimal getRequiredLength() {
        return requiredLength;
    }

    public void setRequiredLength(BigDecimal requiredLength) {
        this.requiredLength = requiredLength;
    }

    public BigDecimal getDocumentSortNo() {
        return documentSortNo;
    }

    public void setDocumentSortNo(BigDecimal documentSortNo) {
        this.documentSortNo = documentSortNo;
    }
    
    
}
