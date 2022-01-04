/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

/**
 *
 * @author niko
 */

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class IvtCogsIdr implements Serializable  {
    
    private static final long serialVersionUID = 1L;
    
    private String branchCode = "";
    private String COGSNo = "";
    private String warehouseCode  = "";
    private String itemMaterialCode = "";
    private String rackCode = "";
    private Date usedStockDate = DateUtils.newDate(1900, 1, 1);
    private BigDecimal itemMaterialQuantity;
    private BigDecimal usedStockCOGS;

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getCOGSNo() {
        return COGSNo;
    }

    public void setCOGSNo(String COGSNo) {
        this.COGSNo = COGSNo;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getItemMaterialCode() {
        return itemMaterialCode;
    }

    public void setItemMaterialCode(String itemMaterialCode) {
        this.itemMaterialCode = itemMaterialCode;
    }
    
    public Date getUsedStockDate() {
        return usedStockDate;
    }

    public void setUsedStockDate(Date usedStockDate) {
        this.usedStockDate = usedStockDate;
    }

    public BigDecimal getUsedStockCOGS() {
        return usedStockCOGS;
    }

    public void setUsedStockCOGS(BigDecimal usedStockCOGS) {
        this.usedStockCOGS = usedStockCOGS;
    }

    public String getRackCode() {
        return rackCode;
    }

    public void setRackCode(String rackCode) {
        this.rackCode = rackCode;
    }

    public BigDecimal getItemMaterialQuantity() {
        return itemMaterialQuantity;
    }

    public void setItemMaterialQuantity(BigDecimal itemMaterialQuantity) {
        this.itemMaterialQuantity = itemMaterialQuantity;
    }

    
    
}
