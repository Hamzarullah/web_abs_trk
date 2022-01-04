
package com.inkombizz.inventory.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.Warehouse;
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

@Entity 
@Table(name = "ivt_item_material_stock_location")
public class ItemMaterialStockLocation extends BaseEntity implements Serializable  {
        
    @Id
    @Column(name = "code", length = 50, unique = true)
    private String code = "";
    
    @Column(name = "CustomerVendorCode")
    private String customerVendorCode = "";
    
    @Column(name = "CustomerVendorStatus")
    private String customerVendorStatus = "";
    
    @Column(name = "Capacity")
    private BigDecimal capacity =new BigDecimal("0.00");  
    
    @Column (name="TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "TransactionCode")
    private String transactionCode = "";
    
    @Column(name = "TransactionType")
    private String transactionType = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "itemMaterialCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemMaterial itemMaterial = null;
    
    @Column(name = "SerialNo")
    private String serialNo = "";
    
    @Column(name = "HeatNo")
    private String heatNo = "";
    
    @Column(name = "BatchNo")
    private String batchNo = "";
    
    @Column(name = "COGSIDR")
    private BigDecimal cogsIdr =new BigDecimal("0.00");

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "warehouseCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RackCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private Rack rack = null;
    
    @Transient private String itemMaterialCode= "";
    @Transient private String itemMaterialName= "";
    @Transient private String warehouseCode= "";
    @Transient private String warehouseName= "";
    @Transient private String rackCode= "";
    @Transient private String rackName= "";
    @Transient private boolean isOut=false;
    @Transient private BigDecimal usedCapacity =new BigDecimal("0.00");
    @Transient private BigDecimal balanceCapacity =new BigDecimal("0.00");
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCustomerVendorCode() {
        return customerVendorCode;
    }

    public void setCustomerVendorCode(String customerVendorCode) {
        this.customerVendorCode = customerVendorCode;
    }

    public String getCustomerVendorStatus() {
        return customerVendorStatus;
    }

    public void setCustomerVendorStatus(String customerVendorStatus) {
        this.customerVendorStatus = customerVendorStatus;
    }

    public BigDecimal getCapacity() {
        return capacity;
    }

    public void setCapacity(BigDecimal capacity) {
        this.capacity = capacity;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
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

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
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

    public boolean isIsOut() {
        return isOut;
    }

    public void setIsOut(boolean isOut) {
        this.isOut = isOut;
    }

    public BigDecimal getUsedCapacity() {
        return usedCapacity;
    }

    public void setUsedCapacity(BigDecimal usedCapacity) {
        this.usedCapacity = usedCapacity;
    }

    public BigDecimal getBalanceCapacity() {
        return balanceCapacity;
    }

    public void setBalanceCapacity(BigDecimal balanceCapacity) {
        this.balanceCapacity = balanceCapacity;
    }

    public String getHeatNo() {
        return heatNo;
    }

    public void setHeatNo(String heatNo) {
        this.heatNo = heatNo;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public BigDecimal getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(BigDecimal cogsIdr) {
        this.cogsIdr = cogsIdr;
    }
    
}