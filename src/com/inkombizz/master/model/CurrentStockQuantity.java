package com.inkombizz.master.model;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "mst_item_jn_current_stock")
public class CurrentStockQuantity implements Serializable {
             
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "WarehouseCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse=null;
    
    @Column(name = "ItemCode")
    private String itemCode = "";
    
    @Column(name = "RackCode")
    private String rackCode = "";
    
    @Column(name = "ActualStock")
    private BigDecimal actualStock = new BigDecimal(0.00);

    @Column(name = "UsedStock")
    private BigDecimal usedStock = new BigDecimal(0.00);
    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public BigDecimal getActualStock() {
        return actualStock;
    }

    public void setActualStock(BigDecimal actualStock) {
        this.actualStock = actualStock;
    }
    
    public BigDecimal getUsedStock() {
        return usedStock;
    }

    public void setUsedStock(BigDecimal usedStock) {
        this.usedStock = usedStock;
    }

    public String getRackCode() {
        return rackCode;
    }

    public void setRackCode(String rackCode) {
        this.rackCode = rackCode;
    }




    
       
}