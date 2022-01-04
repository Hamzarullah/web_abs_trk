
package com.inkombizz.inventory.model;

import com.inkombizz.master.model.Branch;
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
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.CustomerAddress;
import com.inkombizz.master.model.Warehouse;
import com.inkombizz.sales.model.CustomerSalesOrder;

@Entity 
@Table(name = "ivt_picking_list_so")
public class PickingListSalesOrder implements Serializable{
    
    private static final long serialVersionUID = 1L;    
    private String code = "";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private CustomerSalesOrder salesOrderByCustomerPurchaseOrder = null;
    private Branch branch = null;
    private Currency currency = null;
    private BigDecimal exchangeRate = new BigDecimal("0.00");
    private CustomerAddress customerAddress= null;
    private Warehouse warehouse= null;
//    private String confirmationType="NEW";
    private String confirmationStatus="PENDING";
    private Date confirmationDate=DateUtils.newDate(1900, 1, 1);
    private String confirmationBy="";   
    private String refNo = "";
    private String remark = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    
    @Id
    @Column (name="Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column (name="TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesOrderCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public CustomerSalesOrder getSalesOrderByCustomerPurchaseOrder() {
        return salesOrderByCustomerPurchaseOrder;
    }

    public void setSalesOrderByCustomerPurchaseOrder(CustomerSalesOrder salesOrderByCustomerPurchaseOrder) {
        this.salesOrderByCustomerPurchaseOrder = salesOrderByCustomerPurchaseOrder;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Branch getBranch() {
        return branch;
    }
    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.LAZY)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    @Column (name="ExchangeRate")
    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ShipToCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public CustomerAddress getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(CustomerAddress customerAddress) {
        this.customerAddress = customerAddress;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "Warehousecode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    @Column (name="ConfirmationStatus")
    public String getConfirmationStatus() {
        return confirmationStatus;
    }

    public void setConfirmationStatus(String confirmationStatus) {
        this.confirmationStatus = confirmationStatus;
    }

    @Column (name="ConfirmationDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getConfirmationDate() {
        return confirmationDate;
    }

    public void setConfirmationDate(Date confirmationDate) {
        this.confirmationDate = confirmationDate;
    }

    @Column (name="ConfirmationBy")
    public String getConfirmationBy() {
        return confirmationBy;
    }

    public void setConfirmationBy(String confirmationBy) {
        this.confirmationBy = confirmationBy;
    }
        
    @Column (name="RefNo")
    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    @Column (name="Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

}
