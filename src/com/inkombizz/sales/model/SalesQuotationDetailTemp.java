
package com.inkombizz.sales.model;
import java.math.BigDecimal;
import java.util.List;

public class SalesQuotationDetailTemp {

    private String code="";
    private String headerCode="";
    private String item = "";
    private String valveTypeCode = "";
    private String valveTypeName = "";
    private String remark ="";
    private String bodyConstruction ="";
    private String bore ="";
    private String valveTag ="";
    private String dataSheet ="";
    private String description ="";
    private String typeDesign ="";
    private String size ="";
    private String rating ="";
    private String endCon ="";
    private String body ="";
    private String seat="";
    private String stem="";
    private String seatInsert="";
    private String seal="";
    private String bolt="";
    private String ball="";
    private String seatDesign="";
    private String oper="";
    private String disc="";
    private String plates="";
    private String shaft="";
    private String spring="";
    private String armPin="";
    private String backseat="";
    private String arm="";
    private String hingePin="";
    private String stopPin="";
    private String note="";
    private String itemFinishGoodsCode="";
    private String itemFinishGoodsRemark="";
    private List<String> list_msg = null;
    private BigDecimal quantity=new BigDecimal("0.00");
    private BigDecimal unitPrice=new BigDecimal("0.00");
    private BigDecimal total=new BigDecimal("0.00");
    private BigDecimal customerPurchaseOrderSortNo=new BigDecimal("0.00");
    private String refNo="";

    public List<String> getList_msg() {
        return list_msg;
    }

    public void setList_msg(List<String> list_msg) {
        this.list_msg = list_msg;
    }
    
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

    public String getBolt() {
        return bolt;
    }

    public void setBolt(String bolt) {
        this.bolt = bolt;
    }
    
    public String getSeatDesign() {
        return seatDesign;
    }

    public void setSeatDesign(String seatDesign) {
        this.seatDesign = seatDesign;
    }

    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
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

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getBall() {
        return ball;
    }

    public void setBall(String ball) {
        this.ball = ball;
    }

    public BigDecimal getCustomerPurchaseOrderSortNo() {
        return customerPurchaseOrderSortNo;
    }

    public void setCustomerPurchaseOrderSortNo(BigDecimal customerPurchaseOrderSortNo) {
        this.customerPurchaseOrderSortNo = customerPurchaseOrderSortNo;
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

    public String getBackseat() {
        return backseat;
    }

    public void setBackseat(String backseat) {
        this.backseat = backseat;
    }

    public String getTypeDesign() {
        return typeDesign;
    }

    public void setTypeDesign(String typeDesign) {
        this.typeDesign = typeDesign;
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
        return stopPin;
    }

    public void setStopPin(String stopPin) {
        this.stopPin = stopPin;
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

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }
    
    
    
}
