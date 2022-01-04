/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.model;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.BaseEntity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Expedition;
import com.inkombizz.master.model.Vendor;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.purchasing.model.PurchaseOrder;
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

@Entity
@Table(name="ivt_goods_received_note")
/**
 *
 * @author Sukha
 */
public class GoodsReceivedNote extends BaseEntity implements Serializable{
    
    @Id
    @Column (name="Code")
    private String code="";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;
    
    @Column (name="TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate = DateUtils.newDate(1900, 1, 1);
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PurchaseOrderCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private PurchaseOrder purchaseOrder=null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private Currency currency = null;
    
    @Column (name="ExchangeRate")
    private BigDecimal exchangeRate = new BigDecimal("0.00");
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private Vendor vendor = null;
    
    @Column (name="VendorDeliveryNoteNo")
    private String vendorDeliveryNoteNo = "";
    
    @Column (name="ReceivedBy")
    private String receivedBy="";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "WarehouseCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Warehouse warehouse=null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ExpeditionCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private Expedition expedition=null;
    
    @Column (name="TotalTransactionAmount")
    private BigDecimal totalTransactionAmount = new BigDecimal("0.00");
    
    @Column (name="DiscountPercent")
    private BigDecimal discountPercent = new BigDecimal("0.00");
    
    @Column (name="DiscountAmount")
    private BigDecimal discountAmount = new BigDecimal("0.00");
    
    @Column (name="VATPercent")
    private BigDecimal vatPercent = new BigDecimal("0.00");
    
    @Column (name="VATAmount")
    private BigDecimal vatAmount = new BigDecimal("0.00");
    
    @Column (name="GrandTotalAmount")
    private BigDecimal grandTotalAmount = new BigDecimal("0.00");
    
    @Column (name="PoliceNo")
    private String policeNo="";
    
    @Column (name="ContainerNo")
    private String containerNo="";
    
    @Column (name="RefNo")
    private String refNo="";
    
    @Column (name="Remark")
    private String remark="";
    
    @Column(name = "ConfirmationStatus")
    private String confirmationStatus=EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.PENDING);
    
    @Column(name = "ConfirmationDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date confirmationDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "ConfirmationBy")
    private String confirmationBy="";
    
    private @Transient String purchaseOrderCode="";
    private @Transient String branchCode="";
    private @Transient String branchName="";
    private @Transient String currencyCode="";
    private @Transient String currencyName="";
    private @Transient String vendorCode="";
    private @Transient String vendorName="";
    private @Transient String warehouseCode="";
    private @Transient String warehouseName="";
    private @Transient String expeditionCode="";
    private @Transient String expeditionName="";
    private @Transient BigDecimal taxBaseAmount = new BigDecimal("0.00");
    private @Transient String createdDateTemp="";
    private @Transient String transactionDateTemp="";
    private @Transient String purchaseOrderDetailCode="";
    private @Transient String itemMaterialCode="";
    private @Transient Date transactionFirstDate= DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private @Transient Date transactionLastDate= DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

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

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    public String getReceivedBy() {
        return receivedBy;
    }

    public void setReceivedBy(String receivedBy) {
        this.receivedBy = receivedBy;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Expedition getExpedition() {
        return expedition;
    }

    public void setExpedition(Expedition expedition) {
        this.expedition = expedition;
    }

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getVatPercent() {
        return vatPercent;
    }

    public void setVatPercent(BigDecimal vatPercent) {
        this.vatPercent = vatPercent;
    }

    public BigDecimal getVatAmount() {
        return vatAmount;
    }

    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }

    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
    }

    public String getPoliceNo() {
        return policeNo;
    }

    public void setPoliceNo(String policeNo) {
        this.policeNo = policeNo;
    }

    public String getContainerNo() {
        return containerNo;
    }

    public void setContainerNo(String containerNo) {
        this.containerNo = containerNo;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getConfirmationStatus() {
        return confirmationStatus;
    }

    public void setConfirmationStatus(String confirmationStatus) {
        this.confirmationStatus = confirmationStatus;
    }

        
    public Date getConfirmationDate() {
        return confirmationDate;
    }

    public void setConfirmationDate(Date confirmationDate) {
        this.confirmationDate = confirmationDate;
    }

    public String getConfirmationBy() {
        return confirmationBy;
    }

    public void setConfirmationBy(String confirmationBy) {
        this.confirmationBy = confirmationBy;
    }

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }

    public Date getTransactionFirstDate() {
        return transactionFirstDate;
    }

    public void setTransactionFirstDate(Date transactionFirstDate) {
        this.transactionFirstDate = transactionFirstDate;
    }

    public Date getTransactionLastDate() {
        return transactionLastDate;
    }

    public void setTransactionLastDate(Date transactionLastDate) {
        this.transactionLastDate = transactionLastDate;
    }

    public String getPurchaseOrderCode() {
        return purchaseOrderCode;
    }

    public void setPurchaseOrderCode(String purchaseOrderCode) {
        this.purchaseOrderCode = purchaseOrderCode;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    public String getVendorName() {
        return vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
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

    public String getExpeditionCode() {
        return expeditionCode;
    }

    public void setExpeditionCode(String expeditionCode) {
        this.expeditionCode = expeditionCode;
    }

    public String getExpeditionName() {
        return expeditionName;
    }

    public void setExpeditionName(String expeditionName) {
        this.expeditionName = expeditionName;
    }

    public BigDecimal getTaxBaseAmount() {
        return taxBaseAmount;
    }

    public void setTaxBaseAmount(BigDecimal taxBaseAmount) {
        this.taxBaseAmount = taxBaseAmount;
    }

   

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getCurrencyName() {
        return currencyName;
    }

    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }

    public String getTransactionDateTemp() {
        return transactionDateTemp;
    }

    public void setTransactionDateTemp(String transactionDateTemp) {
        this.transactionDateTemp = transactionDateTemp;
    }

    public String getVendorDeliveryNoteNo() {
        return vendorDeliveryNoteNo;
    }

    public void setVendorDeliveryNoteNo(String vendorDeliveryNoteNo) {
        this.vendorDeliveryNoteNo = vendorDeliveryNoteNo;
    }

    public String getPurchaseOrderDetailCode() {
        return purchaseOrderDetailCode;
    }

    public void setPurchaseOrderDetailCode(String purchaseOrderDetailCode) {
        this.purchaseOrderDetailCode = purchaseOrderDetailCode;
    }

    public String getItemMaterialCode() {
        return itemMaterialCode;
    }

    public void setItemMaterialCode(String itemMaterialCode) {
        this.itemMaterialCode = itemMaterialCode;
    }
    
    
}
