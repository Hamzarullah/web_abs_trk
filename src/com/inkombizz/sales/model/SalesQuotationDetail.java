
package com.inkombizz.sales.model;

import com.inkombizz.master.model.Item;
import com.inkombizz.master.model.ValveType;
//import com.inkombizz.master.model.ChartOfAccount;
//import com.inkombizz.master.model.UnitOfMeasure;
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
@Table(name = "sal_sales_quotation_detail")
public class SalesQuotationDetail implements Serializable{
    
    private String code="";
    private String headerCode="";
    private ValveType valveType=null;
    private String valveTag ="";
    private String dataSheet ="";
    private String description ="";
    private String bodyConstruction ="";
    private String bore ="";
    private String typeDesign ="";
    private String size ="";
    private String rating ="";
    private String endCon ="";
    private String body ="";
    private String seat="";
    private String stem="";
    private String ball="";
    private String seatInsert="";
    private String seal="";
    private String bolt="";
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
    private BigDecimal quantity=new BigDecimal("0.00");
    private BigDecimal unitPrice=new BigDecimal("0.00");
    private BigDecimal totalAmount=new BigDecimal("0.00");
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

@Id
@Column(name = "Code")
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
@Column(name = "TotalAmount")
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
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
@Column(name = "Description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
@Column(name = "TypeDesign")
    public String getTypeDesign() {
        return typeDesign;
    }

    public void setTypeDesign(String typeDesign) {
        this.typeDesign = typeDesign;
    }
@Column(name = "Size")
    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }
@Column(name = "Rating")
    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }
@Column(name = "EndCon")
    public String getEndCon() {
        return endCon;
    }

    public void setEndCon(String endCon) {
        this.endCon = endCon;
    }
@Column(name = "Body")
    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
@Column(name = "Seat")
    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }
@Column(name = "Stem")
    public String getStem() {
        return stem;
    }

    public void setStem(String stem) {
        this.stem = stem;
    }
@Column(name = "SeatInsert")
    public String getSeatInsert() {
        return seatInsert;
    }

    public void setSeatInsert(String seatInsert) {
        this.seatInsert = seatInsert;
    }
@Column(name = "Seal")
    public String getSeal() {
        return seal;
    }

    public void setSeal(String seal) {
        this.seal = seal;
    }
@Column(name = "Bolting")
    public String getBolt() {
        return bolt;
    }

    public void setBolt(String bolt) {
        this.bolt = bolt;
    }
    
@Column(name = "SeatDesign")
    public String getSeatDesign() {
        return seatDesign;
    }

    public void setSeatDesign(String seatDesign) {
        this.seatDesign = seatDesign;
    }
@Column(name = "Oper")
    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
    }
@Column(name = "Note")
    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
@Column(name = "UnitPrice")
    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    @Column(name = "Ball")
    public String getBall() {
        return ball;
    }

    public void setBall(String ball) {
        this.ball = ball;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ValveTypeCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public ValveType getValveType() {
        return valveType;
    }

    public void setValveType(ValveType valveType) {
        this.valveType = valveType;
    }

    @Column(name = "BodyConstruction")
    public String getBodyConstruction() {
        return bodyConstruction;
    }

    public void setBodyConstruction(String bodyConstruction) {
        this.bodyConstruction = bodyConstruction;
    }

    @Column(name = "Bore")
    public String getBore() {
        return bore;
    }

    public void setBore(String bore) {
        this.bore = bore;
    }

    @Column(name = "Disc")
    public String getDisc() {
        return disc;
    }

    public void setDisc(String disc) {
        this.disc = disc;
    }
    
    @Column(name = "Plates")
    public String getPlates() {
        return plates;
    }

    public void setPlates(String plates) {
        this.plates = plates;
    }

    @Column(name = "Shaft")
    public String getShaft() {
        return shaft;
    }

    public void setShaft(String shaft) {
        this.shaft = shaft;
    }

    @Column(name = "Spring")
    public String getSpring() {
        return spring;
    }

    public void setSpring(String spring) {
        this.spring = spring;
    }

    @Column(name = "ArmPin")
    public String getArmPin() {
        return armPin;
    }

    public void setArmPin(String armPin) {
        this.armPin = armPin;
    }

    @Column(name = "Backseat")
    public String getBackseat() {
        return backseat;
    }

    public void setBackseat(String backseat) {
        this.backseat = backseat;
    }

    @Column(name = "Arm")
    public String getArm() {
        return arm;
    }

    public void setArm(String arm) {
        this.arm = arm;
    }

    @Column(name = "HingePin")
    public String getHingePin() {
        return hingePin;
    }

    public void setHingePin(String hingePin) {
        this.hingePin = hingePin;
    }

    @Column(name = "StopPin")
    public String getStopPin() {
        return stopPin;
    }

    public void setStopPin(String stopPin) {
        this.stopPin = stopPin;
    }
    
    

}
