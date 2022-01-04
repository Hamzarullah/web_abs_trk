package com.inkombizz.master.model;

import com.inkombizz.action.BaseSession;
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
@Table(name = "mst_item_jn_current_stock")
public class CurrentStockCogsIdr implements Serializable {
        
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "Code")
    private String code = "";

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "WarehouseCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse=null;
    
     @Column(name = "ItemCode")
    private String itemCode = "";

    
    @Column(name = "InTransactionNo")
    private String inTransactionNo = "";
    
    @Column(name = "InDocumentType")
    private String inDocumentType = "";
    
    @Column(name = "ItemDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date itemDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "COGSIDR")
    private BigDecimal cogsIdr = new BigDecimal(0.00);
    
     @Column(name = "InQuantity")
    private BigDecimal inQuantity = new BigDecimal(0.00);
    
    @Column(name = "InUnitOfMeasureCode")
    private String inUnitOfMeasureCode = "";
     
    @Column(name = "ActualStock")
    private BigDecimal actualStock = new BigDecimal(0.00);
    
    @Column(name = "BookedStock")
    private BigDecimal bookedStock = new BigDecimal(0.00);
    
    @Column(name = "UsedStock")
    private BigDecimal usedStock = new BigDecimal(0.00);
    
    @Column(name = "SortNo")
    private BigDecimal sortNo = new BigDecimal(0.00);
    
    @Column(name = "ItemBrandCode")
    private String itemBrandCode = "";
    
     @Column(name = "LotNo")
    private String lotNo = "";

    @Column(name = "ProductionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date productionDate = DateUtils.newDate(1900, 1, 1);
    
     @Column(name = "BatchNo")
    private String batchNo = "";
    
     @Column(name = "ExpireDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date expireDate = DateUtils.newDate(1900, 1, 1);
   
    @Column(name = "RackCode")
    private String rackCode = "";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

   

    public String getInTransactionNo() {
        return inTransactionNo;
    }

    public void setInTransactionNo(String inTransactionNo) {
        this.inTransactionNo = inTransactionNo;
    }

    public String getInDocumentType() {
        return inDocumentType;
    }

    public void setInDocumentType(String inDocumentType) {
        this.inDocumentType = inDocumentType;
    }

    public Date getItemDate() {
        return itemDate;
    }

    public void setItemDate(Date itemDate) {
        this.itemDate = itemDate;
    }

    public BigDecimal getCogsIdr() {
        return cogsIdr;
    }

    public void setCogsIdr(BigDecimal cogsIdr) {
        this.cogsIdr = cogsIdr;
    }

    public BigDecimal getInQuantity() {
        return inQuantity;
    }

    public void setInQuantity(BigDecimal inQuantity) {
        this.inQuantity = inQuantity;
    }

    public String getInUnitOfMeasureCode() {
        return inUnitOfMeasureCode;
    }

    public void setInUnitOfMeasureCode(String inUnitOfMeasureCode) {
        this.inUnitOfMeasureCode = inUnitOfMeasureCode;
    }

    public BigDecimal getActualStock() {
        return actualStock;
    }

    public void setActualStock(BigDecimal actualStock) {
        this.actualStock = actualStock;
    }

    public BigDecimal getBookedStock() {
        return bookedStock;
    }

    public void setBookedStock(BigDecimal bookedStock) {
        this.bookedStock = bookedStock;
    }

    public BigDecimal getUsedStock() {
        return usedStock;
    }

    public void setUsedStock(BigDecimal usedStock) {
        this.usedStock = usedStock;
    }

    public BigDecimal getSortNo() {
        return sortNo;
    }

    public void setSortNo(BigDecimal sortNo) {
        this.sortNo = sortNo;
    }

    public String getItemBrandCode() {
        return itemBrandCode;
    }

    public void setItemBrandCode(String itemBrandCode) {
        this.itemBrandCode = itemBrandCode;
    }

    public String getLotNo() {
        return lotNo;
    }

    public void setLotNo(String lotNo) {
        this.lotNo = lotNo;
    }

    public Date getProductionDate() {
        return productionDate;
    }

    public void setProductionDate(Date productionDate) {
        this.productionDate = productionDate;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public String getRackCode() {
        return rackCode;
    }

    public void setRackCode(String rackCode) {
        this.rackCode = rackCode;
    }
    
       
}