
package com.inkombizz.inventory.model;


import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.Reason;
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
@Table(name = "ivt_adjustment_out_serial_no_detail")
public class AdjustmentOutSerialNoDetail extends BaseEntity implements Serializable{
    
    @Id
    @Column (name="Code")
    private String code = "";
    
    @Column (name="HeaderCode")
    private String headerCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @Column (name="SerialNo")
    private String serialNo = "";
    
    @Column (name="SerialNoDetailCode")
    private String serialNoDetailCode = "";
    
    @Column (name="InTransactionCode")
    private String inTransactionCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ReasonCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    private Reason reason = null;
    
    @Column (name="Capacity") 
    private BigDecimal capacity = new BigDecimal ("0.00");
    
    @Column (name="COGSIDR") 
    private BigDecimal cogsIdr = new BigDecimal ("0.00");
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RackCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Rack rack = null;
    
    @Column (name="remark")
    private String remark = "";
    
    @Transient private String itemMaterialCode= "";
    @Transient private String itemMaterialName= "";
    @Transient private String itemMaterialSerialNoStatus;
    @Transient private String itemMaterialUnitOfMeasureCode= "";
    @Transient private String rackCode= "";
    @Transient private String rackName= "";
    @Transient private String reasonCode= "";
    @Transient private String reasonName= "";

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

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public String getSerialNoDetailCode() {
        return serialNoDetailCode;
    }

    public void setSerialNoDetailCode(String serialNoDetailCode) {
        this.serialNoDetailCode = serialNoDetailCode;
    }

    public String getInTransactionCode() {
        return inTransactionCode;
    }

    public void setInTransactionCode(String inTransactionCode) {
        this.inTransactionCode = inTransactionCode;
    }

    public Reason getReason() {
        return reason;
    }

    public void setReason(Reason reason) {
        this.reason = reason;
    }

    public BigDecimal getCapacity() {
        return capacity;
    }

    public void setCapacity(BigDecimal capacity) {
        this.capacity = capacity;
    }

    public BigDecimal getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(BigDecimal cogsIdr) {
        this.cogsIdr = cogsIdr;
    }

    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRackCode() {
        return rackCode;
    }

    public void setRackCode(String rackCode) {
        this.rackCode = rackCode;
    }

    public String getRackName() {
        return rackName;
    }

    public void setRackName(String rackName) {
        this.rackName = rackName;
    }

    public String getReasonCode() {
        return reasonCode;
    }

    public void setReasonCode(String reasonCode) {
        this.reasonCode = reasonCode;
    }

    public String getReasonName() {
        return reasonName;
    }

    public void setReasonName(String reasonName) {
        this.reasonName = reasonName;
    }

    public ItemMaterial getItemMaterial() {
        return itemMaterial;
    }

    public void setItemMaterial(ItemMaterial itemMaterial) {
        this.itemMaterial = itemMaterial;
    }

    public String getItemMaterialCode() {
        return itemMaterialCode;
    }

    public void setItemMaterialCode(String itemMaterialCode) {
        this.itemMaterialCode = itemMaterialCode;
    }

    public String getItemMaterialName() {
        return itemMaterialName;
    }

    public void setItemMaterialName(String itemMaterialName) {
        this.itemMaterialName = itemMaterialName;
    }

    public String getItemMaterialSerialNoStatus() {
        return itemMaterialSerialNoStatus;
    }

    public void setItemMaterialSerialNoStatus(String itemMaterialSerialNoStatus) {
        this.itemMaterialSerialNoStatus = itemMaterialSerialNoStatus;
    }

    public String getItemMaterialUnitOfMeasureCode() {
        return itemMaterialUnitOfMeasureCode;
    }

    public void setItemMaterialUnitOfMeasureCode(String itemMaterialUnitOfMeasureCode) {
        this.itemMaterialUnitOfMeasureCode = itemMaterialUnitOfMeasureCode;
    }
    
    
    
}
