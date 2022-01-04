
package com.inkombizz.sales.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemFinishGoods;
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
@Table(name = "sal_customer_sales_order_item_detail")
public class CustomerSalesOrderItemDetail extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode="";
    
    @Column(name = "ItemAlias")
    private String itemAlias="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesQuotationCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private SalesQuotation salesQuotation=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesQuotationDetailCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private SalesQuotationDetail salesQuotationDetail=null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemFinishGoodsCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemFinishGoods itemFinishGoods=null;
    
    @Column(name = "Quantity")
    private BigDecimal quantity=new BigDecimal("0.00");
    
    @Column(name = "CustomerPurchaseOrderSortNo")
    private BigDecimal customerPurchaseOrderSortNo=new BigDecimal("0");
    
    @Column(name = "ValveTag")
    private String valveTag="";
    
    @Column(name = "DataSheet")
    private String dataSheet="";
    
    @Column(name = "Description")
    private String description="";

    @Transient private String customerSalesOrderItemDetailCode="";    
    @Transient private String billOfMaterialCode="";    
    @Transient private String salesQuotationCode="";
    @Transient private String salesQuotationDetailCode="";
    @Transient private String itemFinishGoodsCode="";
    @Transient private String itemFinishGoodsName="";
    @Transient private String itemFinishGoodsRemark="";
    @Transient private String valveTypeCode="";
    @Transient private String valveTypeName="";
    @Transient private String refNo="";
    
    @Transient private String bodyConstruction="";
    @Transient private String typeDesign="";
    @Transient private String seatDesign="";
    @Transient private String size="";
    @Transient private String rating="";
    @Transient private String bore="";
    
    @Transient private String endCon="";
    @Transient private String body="";
    @Transient private String ball="";
    @Transient private String seat="";
    @Transient private String seatInsert="";
    @Transient private String stem="";

    @Transient private String seal="";
    @Transient private String bolting="";
    @Transient private String disc="";
    @Transient private String plates="";
    @Transient private String shaft="";
    @Transient private String spring="";
    
    @Transient private String armPin="";
    @Transient private String backSeat="";
    @Transient private String arm="";
    @Transient private String hingePin="";
    @Transient private String StopPin="";
    @Transient private String operator="";
    
    @Transient private String note="";
    @Transient private BigDecimal unitPrice=new BigDecimal("0.00");
    @Transient private BigDecimal totalAmount=new BigDecimal("0.00");
    @Transient private BigDecimal processedQty=new BigDecimal("0.00");
    @Transient private BigDecimal balancedQty=new BigDecimal("0.00");
    
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

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public SalesQuotation getSalesQuotation() {
        return salesQuotation;
    }

    public void setSalesQuotation(SalesQuotation salesQuotation) {
        this.salesQuotation = salesQuotation;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getCustomerPurchaseOrderSortNo() {
        return customerPurchaseOrderSortNo;
    }

    public void setCustomerPurchaseOrderSortNo(BigDecimal customerPurchaseOrderSortNo) {
        this.customerPurchaseOrderSortNo = customerPurchaseOrderSortNo;
    }

    public String getSalesQuotationCode() {
        return salesQuotationCode;
    }

    public void setSalesQuotationCode(String salesQuotationCode) {
        this.salesQuotationCode = salesQuotationCode;
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

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getEndCon() {
        return endCon;
    }

    public void setEndCon(String endCon) {
        this.endCon = endCon;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getBall() {
        return ball;
    }

    public void setBall(String ball) {
        this.ball = ball;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public String getStem() {
        return stem;
    }

    public void setStem(String stem) {
        this.stem = stem;
    }

    public String getSeatInsert() {
        return seatInsert;
    }

    public void setSeatInsert(String seatInsert) {
        this.seatInsert = seatInsert;
    }

    public String getSeal() {
        return seal;
    }

    public void setSeal(String seal) {
        this.seal = seal;
    }

    public String getBolting() {
        return bolting;
    }

    public void setBolting(String bolting) {
        this.bolting = bolting;
    }

    public String getSeatDesign() {
        return seatDesign;
    }

    public void setSeatDesign(String seatDesign) {
        this.seatDesign = seatDesign;
    }
    
    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public String getTypeDesign() {
        return typeDesign;
    }

    public void setTypeDesign(String typeDesign) {
        this.typeDesign = typeDesign;
    }

    public String getBodyConstruction() {
        return bodyConstruction;
    }

    public void setBodyConstruction(String bodyConstruction) {
        this.bodyConstruction = bodyConstruction;
    }

    public String getBore() {
        return bore;
    }

    public void setBore(String bore) {
        this.bore = bore;
    }

    public String getDisc() {
        return disc;
    }

    public void setDisc(String disc) {
        this.disc = disc;
    }

    public String getPlates() {
        return plates;
    }

    public void setPlates(String plates) {
        this.plates = plates;
    }

    public String getShaft() {
        return shaft;
    }

    public void setShaft(String shaft) {
        this.shaft = shaft;
    }

    public String getSpring() {
        return spring;
    }

    public void setSpring(String spring) {
        this.spring = spring;
    }

    public String getArmPin() {
        return armPin;
    }

    public void setArmPin(String armPin) {
        this.armPin = armPin;
    }

    public SalesQuotationDetail getSalesQuotationDetail() {
        return salesQuotationDetail;
    }

    public void setSalesQuotationDetail(SalesQuotationDetail salesQuotationDetail) {
        this.salesQuotationDetail = salesQuotationDetail;
    }

    public String getSalesQuotationDetailCode() {
        return salesQuotationDetailCode;
    }

    public void setSalesQuotationDetailCode(String salesQuotationDetailCode) {
        this.salesQuotationDetailCode = salesQuotationDetailCode;
    }

    public String getItemAlias() {
        return itemAlias;
    }

    public void setItemAlias(String itemAlias) {
        this.itemAlias = itemAlias;
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

    public String getItemFinishGoodsCode() {
        return itemFinishGoodsCode;
    }

    public void setItemFinishGoodsCode(String itemFinishGoodsCode) {
        this.itemFinishGoodsCode = itemFinishGoodsCode;
    }

    public String getCustomerSalesOrderItemDetailCode() {
        return customerSalesOrderItemDetailCode;
    }

    public void setCustomerSalesOrderItemDetailCode(String customerSalesOrderItemDetailCode) {
        this.customerSalesOrderItemDetailCode = customerSalesOrderItemDetailCode;
    }

    public String getItemFinishGoodsRemark() {
        return itemFinishGoodsRemark;
    }

    public void setItemFinishGoodsRemark(String itemFinishGoodsRemark) {
        this.itemFinishGoodsRemark = itemFinishGoodsRemark;
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

    public String getItemFinishGoodsName() {
        return itemFinishGoodsName;
    }

    public void setItemFinishGoodsName(String itemFinishGoodsName) {
        this.itemFinishGoodsName = itemFinishGoodsName;
    }

    public String getBackSeat() {
        return backSeat;
    }

    public void setBackSeat(String backSeat) {
        this.backSeat = backSeat;
    }

    public String getArm() {
        return arm;
    }

    public void setArm(String arm) {
        this.arm = arm;
    }

    public String getHingePin() {
        return hingePin;
    }

    public void setHingePin(String hingePin) {
        this.hingePin = hingePin;
    }

    public String getStopPin() {
        return StopPin;
    }

    public void setStopPin(String StopPin) {
        this.StopPin = StopPin;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public BigDecimal getProcessedQty() {
        return processedQty;
    }

    public void setProcessedQty(BigDecimal processedQty) {
        this.processedQty = processedQty;
    }

    public BigDecimal getBalancedQty() {
        return balancedQty;
    }

    public void setBalancedQty(BigDecimal balancedQty) {
        this.balancedQty = balancedQty;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getBillOfMaterialCode() {
        return billOfMaterialCode;
    }

    public void setBillOfMaterialCode(String billOfMaterialCode) {
        this.billOfMaterialCode = billOfMaterialCode;
    }
    
    
    
    
}
