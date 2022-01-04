
package com.inkombizz.sales.model;

import com.inkombizz.action.BaseSession;
import com.inkombizz.utils.DateUtils;
import java.util.Date;

public class CustomerSalesOrderMiss {
    
    private String salesOrderCode="";
    private Date salesOrderDate= DateUtils.newDate(1900, 1, 1);
    private String salesOrderSource="";
    private String salesOrderBranchCode="";
    private String salesOrderBranchName="";
    private String salesOrderBlanketPurchaseOrderCode="";//Dari Blanket/ Customer Purchase
    private String salesOrderCustomerCode="";
    private String salesOrderCustomerName="";
    private String salesOrderSalesPersonCode="";
    private String salesOrderSalesPersonName="";
    private Date transactionFirstDate= DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date transactionLastDate= DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

    public String getSalesOrderCode() {
        return salesOrderCode;
    }

    public void setSalesOrderCode(String salesOrderCode) {
        this.salesOrderCode = salesOrderCode;
    }

    public Date getSalesOrderDate() {
        return salesOrderDate;
    }

    public void setSalesOrderDate(Date salesOrderDate) {
        this.salesOrderDate = salesOrderDate;
    }

    public String getSalesOrderSource() {
        return salesOrderSource;
    }

    public void setSalesOrderSource(String salesOrderSource) {
        this.salesOrderSource = salesOrderSource;
    }

    public String getSalesOrderBranchCode() {
        return salesOrderBranchCode;
    }

    public void setSalesOrderBranchCode(String salesOrderBranchCode) {
        this.salesOrderBranchCode = salesOrderBranchCode;
    }

    public String getSalesOrderBranchName() {
        return salesOrderBranchName;
    }

    public void setSalesOrderBranchName(String salesOrderBranchName) {
        this.salesOrderBranchName = salesOrderBranchName;
    }

    public String getSalesOrderBlanketPurchaseOrderCode() {
        return salesOrderBlanketPurchaseOrderCode;
    }

    public void setSalesOrderBlanketPurchaseOrderCode(String salesOrderBlanketPurchaseOrderCode) {
        this.salesOrderBlanketPurchaseOrderCode = salesOrderBlanketPurchaseOrderCode;
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
    
    
}
