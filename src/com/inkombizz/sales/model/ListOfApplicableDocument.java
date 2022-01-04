
package com.inkombizz.sales.model;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.Branch;
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

import javax.persistence.Transient;

@Entity
@Table(name = "sal_list_of_applicable_document")
public class ListOfApplicableDocument extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesOrderCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private CustomerSalesOrder salesOrder=null;

    @Column(name = "RefNo")
    private String refNo="";
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "PreparedBy")
    private String preparedBy="";
    
    @Column(name = "ApprovedBy")
    private String approvedBy="";
        
    private @Transient String createdDateTemp="";
    private @Transient String codeLAD="";
    private @Transient String branchCode="";
    private @Transient String branchName="";
    private @Transient String salesOrderCode="";
    private @Transient String salesOrderName="";
    private @Transient String salesOrderCustomerCode="";
    private @Transient String salesOrderCustomerName="";
    private @Transient String salesOrderSalesPersonCode="";
    private @Transient String salesOrderSalesPersonName="";
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

    public CustomerSalesOrder getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(CustomerSalesOrder salesOrder) {
        this.salesOrder = salesOrder;
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

    public String getPreparedBy() {
        return preparedBy;
    }

    public void setPreparedBy(String preparedBy) {
        this.preparedBy = preparedBy;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
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

    public String getSalesOrderCustomerCode() {
        return salesOrderCustomerCode;
    }

    public void setSalesOrderCustomerCode(String salesOrderCustomerCode) {
        this.salesOrderCustomerCode = salesOrderCustomerCode;
    }

    public String getSalesOrderCustomerName() {
        return salesOrderCustomerName;
    }

    public void setSalesOrderCustomerName(String salesOrderCustomerName) {
        this.salesOrderCustomerName = salesOrderCustomerName;
    }

    public String getSalesOrderSalesPersonCode() {
        return salesOrderSalesPersonCode;
    }

    public void setSalesOrderSalesPersonCode(String salesOrderSalesPersonCode) {
        this.salesOrderSalesPersonCode = salesOrderSalesPersonCode;
    }

    public String getSalesOrderSalesPersonName() {
        return salesOrderSalesPersonName;
    }

    public void setSalesOrderSalesPersonName(String salesOrderSalesPersonName) {
        this.salesOrderSalesPersonName = salesOrderSalesPersonName;
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

    public String getSalesOrderCode() {
        return salesOrderCode;
    }

    public void setSalesOrderCode(String salesOrderCode) {
        this.salesOrderCode = salesOrderCode;
    }

    public String getSalesOrderName() {
        return salesOrderName;
    }

    public void setSalesOrderName(String salesOrderName) {
        this.salesOrderName = salesOrderName;
    }

    public String getCodeLAD() {
        return codeLAD;
    }

    public void setCodeLAD(String codeLAD) {
        this.codeLAD = codeLAD;
    }

    
}
