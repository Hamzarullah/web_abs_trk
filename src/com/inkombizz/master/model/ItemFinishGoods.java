
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
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "mst_item_finish_goods")
public class ItemFinishGoods implements Serializable{
    
    private String code = "";
    private String name = "";
    private Customer endUser = null;
    private ValveType valveType = null;
    private ItemBodyConstruction itemBodyConstruction = null;
    private ItemArmPin itemArmPin = null;
    private ItemArm itemArm = null;
    private ItemTypeDesign itemTypeDesign = null;
    private ItemDisc itemDisc = null;
    private ItemBackseat itemBackseat = null;
    private ItemBall itemBall = null;
    private ItemSpring itemSpring = null;
    private ItemPlates itemPlates = null;
    private ItemShaft itemShaft = null;
    private ItemSize itemSize = null;
    private ItemRating itemRating = null;
    private ItemBore itemBore = null;
    private ItemEndCon itemEndCon = null;
    private ItemBody itemBody = null;
    private ItemStem itemStem = null;
    private ItemSeal itemSeal = null;
    private ItemSeat itemSeat = null;
    private ItemSeatInsert itemSeatInsert = null;
    private ItemBolt itemBolt = null;
    private ItemSeatDesign itemSeatDesign = null;
    private ItemOperator itemOperator = null;
    private ItemHingePin itemHingePin = null;
    private ItemStopPin itemStopPin = null;
    private boolean activeStatus =false;
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
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

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "EndUserCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public Customer getEndUser() {
        return endUser;
    }

    public void setEndUser(Customer endUser) {
        this.endUser = endUser;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemTypeDesignCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemTypeDesign getItemTypeDesign() {
        return itemTypeDesign;
    }

    public void setItemTypeDesign(ItemTypeDesign itemTypeDesign) {
        this.itemTypeDesign = itemTypeDesign;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemBallCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemBall getItemBall() {
        return itemBall;
    }
    
    public void setItemBall(ItemBall itemBall) {
        this.itemBall = itemBall;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemSizeCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemSize getItemSize() {
        return itemSize;
    }

    public void setItemSize(ItemSize itemSize) {
        this.itemSize = itemSize;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemRatingCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemRating getItemRating() {
        return itemRating;
    }

    public void setItemRating(ItemRating itemRating) {
        this.itemRating = itemRating;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemBoreCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemBore getItemBore() {
        return itemBore;
    }

    public void setItemBore(ItemBore itemBore) {
        this.itemBore = itemBore;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemEndConCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemEndCon getItemEndCon() {
        return itemEndCon;
    }

    public void setItemEndCon(ItemEndCon itemEndCon) {
        this.itemEndCon = itemEndCon;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemBodyCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemBody getItemBody() {
        return itemBody;
    }

    public void setItemBody(ItemBody itemBody) {
        this.itemBody = itemBody;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemStemCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemStem getItemStem() {
        return itemStem;
    }

    public void setItemStem(ItemStem itemStem) {
        this.itemStem = itemStem;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemSealCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemSeal getItemSeal() {
        return itemSeal;
    }

    public void setItemSeal(ItemSeal itemSeal) {
        this.itemSeal = itemSeal;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemSeatCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemSeat getItemSeat() {
        return itemSeat;
    }

    public void setItemSeat(ItemSeat itemSeat) {
        this.itemSeat = itemSeat;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemSeatInsertCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemSeatInsert getItemSeatInsert() {
        return itemSeatInsert;
    }

    public void setItemSeatInsert(ItemSeatInsert itemSeatInsert) {
        this.itemSeatInsert = itemSeatInsert;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemBoltCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemBolt getItemBolt() {
        return itemBolt;
    }

    public void setItemBolt(ItemBolt itemBolt) {
        this.itemBolt = itemBolt;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemSeatDesignCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemSeatDesign getItemSeatDesign() {
        return itemSeatDesign;
    }

    public void setItemSeatDesign(ItemSeatDesign itemSeatDesign) {
        this.itemSeatDesign = itemSeatDesign;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemOperatorCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemOperator getItemOperator() {
        return itemOperator;
    }

    public void setItemOperator(ItemOperator itemOperator) {
        this.itemOperator = itemOperator;
    }
    
    @Column(name="ActiveStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }
    
    @Column(name="Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    @Column(name="InActiveBy")
    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }
    
    @Column(name="InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
    }
    
    @Column(name="CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name="CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    @Column(name="UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column(name="UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    @Column(name="Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemBodyConstructionCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemBodyConstruction getItemBodyConstruction() {
        return itemBodyConstruction;
    }

    public void setItemBodyConstruction(ItemBodyConstruction itemBodyConstruction) {
        this.itemBodyConstruction = itemBodyConstruction;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemArmPinCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemArmPin getItemArmPin() {
        return itemArmPin;
    }

    public void setItemArmPin(ItemArmPin itemArmPin) {
        this.itemArmPin = itemArmPin;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemDiscCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemDisc getItemDisc() {
        return itemDisc;
    }

    public void setItemDisc(ItemDisc itemDisc) {
        this.itemDisc = itemDisc;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemBackseatCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemBackseat getItemBackseat() {
        return itemBackseat;
    }

    public void setItemBackseat(ItemBackseat itemBackseat) {
        this.itemBackseat = itemBackseat;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemSpringCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemSpring getItemSpring() {
        return itemSpring;
    }

    public void setItemSpring(ItemSpring itemSpring) {
        this.itemSpring = itemSpring;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemPlatesCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemPlates getItemPlates() {
        return itemPlates;
    }

    public void setItemPlates(ItemPlates itemPlates) {
        this.itemPlates = itemPlates;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemShaftCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemShaft getItemShaft() {
        return itemShaft;
    }

    public void setItemShaft(ItemShaft itemShaft) {
        this.itemShaft = itemShaft;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ValveTypeCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public ValveType getValveType() {
        return valveType;
    }

    public void setValveType(ValveType valveType) {
        this.valveType = valveType;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemArmCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemArm getItemArm() {
        return itemArm;
    }

    public void setItemArm(ItemArm itemArm) {
        this.itemArm = itemArm;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemHingePinCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemHingePin getItemHingePin() {
        return itemHingePin;
    }

    public void setItemHingePin(ItemHingePin itemHingePin) {
        this.itemHingePin = itemHingePin;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemStopPinCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ItemStopPin getItemStopPin() {
        return itemStopPin;
    }

    public void setItemStopPin(ItemStopPin itemStopPin) {
        this.itemStopPin = itemStopPin;
    }
    
    
    
}
