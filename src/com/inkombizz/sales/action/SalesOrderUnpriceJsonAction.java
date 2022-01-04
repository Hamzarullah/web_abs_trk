
package com.inkombizz.sales.action;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerSalesOrderBLL;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetail;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotation;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class SalesOrderUnpriceJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerSalesOrder salesOrderUnprice=new CustomerSalesOrder();
    private List<CustomerSalesOrder> listSalesOrderUnprice;
    private List<CustomerSalesOrderSalesQuotation> listSalesOrderByCustomerPurchaseOrderSalesQuotation;
    private List<CustomerSalesOrderItemDetail> listSalesOrderByCustomerPurchaseOrderItemDetail;
    private List<CustomerSalesOrderAdditionalFee> listSalesOrderByCustomerPurchaseOrderAdditionalFee;
    private List<CustomerSalesOrderPaymentTerm> listSalesOrderByCustomerPurchaseOrderPaymentTerm;
    private List<CustomerSalesOrderItemDeliveryDate> listSalesOrderByCustomerPurchaseOrderItemDeliveryDate;
            
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("sales-order-unprice-data")
    public String findData() {
        try {
//            CustomerSalesOrderBLL salesOrderByCustomerPurchaseOrderBLL = new CustomerSalesOrderBLL(hbmSession);
                        
//            ListPaging <CustomerSalesOrder> listPaging = salesOrderByCustomerPurchaseOrderBLL.findData(paging,salesOrderUnprice);
            
//            listSalesOrderUnprice = listPaging.getList();
//            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("sales-order-unprice-sales-quotation-data")
    public String findDataSalesQuotation(){
        try {
            
            CustomerSalesOrderBLL salesOrderByCustomerPurchaseOrderBLL = new CustomerSalesOrderBLL(hbmSession);
//            List<CustomerSalesOrderSalesQuotation> list = salesOrderByCustomerPurchaseOrderBLL.findDataSalesQuotation(salesOrderUnprice.getCode());
            
//            listSalesOrderByCustomerPurchaseOrderSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-order-unprice-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            CustomerSalesOrderBLL salesOrderByCustomerPurchaseOrderBLL = new CustomerSalesOrderBLL(hbmSession);
//            List<CustomerSalesOrderItemDetail> list = salesOrderByCustomerPurchaseOrderBLL.findDataItemDetail(salesOrderUnprice.getCode());
            
//            listSalesOrderByCustomerPurchaseOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-order-unprice-additional-fee-data")
    public String findDataAdditionalFee(){
        try {
            
            CustomerSalesOrderBLL salesOrderByCustomerPurchaseOrderBLL = new CustomerSalesOrderBLL(hbmSession);
//            List<CustomerSalesOrderAdditionalFee> list = salesOrderByCustomerPurchaseOrderBLL.findDataAdditionalFee(salesOrderUnprice.getCode());
            
//            listSalesOrderByCustomerPurchaseOrderAdditionalFee = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-order-unprice-payment-term-data")
    public String findDataPaymentTerm(){
        try {
            
            CustomerSalesOrderBLL salesOrderByCustomerPurchaseOrderBLL = new CustomerSalesOrderBLL(hbmSession);
//            List<CustomerSalesOrderPaymentTerm> list = salesOrderByCustomerPurchaseOrderBLL.findDataPaymentTerm(salesOrderUnprice.getCode());
            
//            listSalesOrderByCustomerPurchaseOrderPaymentTerm = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-order-unprice-item-delivery-data")
    public String findDataItemDeliveryDate(){
        try {
            
            CustomerSalesOrderBLL salesOrderByCustomerPurchaseOrderBLL = new CustomerSalesOrderBLL(hbmSession);
//            List<CustomerSalesOrderItemDeliveryDate> list = salesOrderByCustomerPurchaseOrderBLL.findDataItemDeliveryDate(salesOrderUnprice.getCode());
            
//            listSalesOrderByCustomerPurchaseOrderItemDeliveryDate = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerSalesOrder getSalesOrderUnprice() {
        return salesOrderUnprice;
    }

    public void setSalesOrderUnprice(CustomerSalesOrder salesOrderUnprice) {
        this.salesOrderUnprice = salesOrderUnprice;
    }

    public List<CustomerSalesOrder> getListSalesOrderUnprice() {
        return listSalesOrderUnprice;
    }

    public void setListSalesOrderUnprice(List<CustomerSalesOrder> listSalesOrderUnprice) {
        this.listSalesOrderUnprice = listSalesOrderUnprice;
    }

    public List<CustomerSalesOrderSalesQuotation> getListSalesOrderByCustomerPurchaseOrderSalesQuotation() {
        return listSalesOrderByCustomerPurchaseOrderSalesQuotation;
    }

    public void setListSalesOrderByCustomerPurchaseOrderSalesQuotation(List<CustomerSalesOrderSalesQuotation> listSalesOrderByCustomerPurchaseOrderSalesQuotation) {
        this.listSalesOrderByCustomerPurchaseOrderSalesQuotation = listSalesOrderByCustomerPurchaseOrderSalesQuotation;
    }

    public List<CustomerSalesOrderItemDetail> getListSalesOrderByCustomerPurchaseOrderItemDetail() {
        return listSalesOrderByCustomerPurchaseOrderItemDetail;
    }

    public void setListSalesOrderByCustomerPurchaseOrderItemDetail(List<CustomerSalesOrderItemDetail> listSalesOrderByCustomerPurchaseOrderItemDetail) {
        this.listSalesOrderByCustomerPurchaseOrderItemDetail = listSalesOrderByCustomerPurchaseOrderItemDetail;
    }

    public List<CustomerSalesOrderAdditionalFee> getListSalesOrderByCustomerPurchaseOrderAdditionalFee() {
        return listSalesOrderByCustomerPurchaseOrderAdditionalFee;
    }

    public void setListSalesOrderByCustomerPurchaseOrderAdditionalFee(List<CustomerSalesOrderAdditionalFee> listSalesOrderByCustomerPurchaseOrderAdditionalFee) {
        this.listSalesOrderByCustomerPurchaseOrderAdditionalFee = listSalesOrderByCustomerPurchaseOrderAdditionalFee;
    }

    public List<CustomerSalesOrderPaymentTerm> getListSalesOrderByCustomerPurchaseOrderPaymentTerm() {
        return listSalesOrderByCustomerPurchaseOrderPaymentTerm;
    }

    public void setListSalesOrderByCustomerPurchaseOrderPaymentTerm(List<CustomerSalesOrderPaymentTerm> listSalesOrderByCustomerPurchaseOrderPaymentTerm) {
        this.listSalesOrderByCustomerPurchaseOrderPaymentTerm = listSalesOrderByCustomerPurchaseOrderPaymentTerm;
    }

    public List<CustomerSalesOrderItemDeliveryDate> getListSalesOrderByCustomerPurchaseOrderItemDeliveryDate() {
        return listSalesOrderByCustomerPurchaseOrderItemDeliveryDate;
    }

    public void setListSalesOrderByCustomerPurchaseOrderItemDeliveryDate(List<CustomerSalesOrderItemDeliveryDate> listSalesOrderByCustomerPurchaseOrderItemDeliveryDate) {
        this.listSalesOrderByCustomerPurchaseOrderItemDeliveryDate = listSalesOrderByCustomerPurchaseOrderItemDeliveryDate;
    }
    
    
    
    // <editor-fold defaultstate="collapsed" desc="Message Info">
    private boolean error = false;
    private String errorMessage = "";
    private String message = "";

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">
    
    Paging paging = new Paging();
    
    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
    
    public Integer getRows() {
        return paging.getRows();
    }
    public void setRows(Integer rows) {
        paging.setRows(rows);
    }
    
    public Integer getPage() {
        return paging.getPage();
    }
    public void setPage(Integer page) {
        paging.setPage(page);
    }
    
    public Integer getTotal() {
        return paging.getTotal();
    }
    public void setTotal(Integer total) {
        paging.setTotal(total);
    }
    
    public Integer getRecords() {
        return paging.getRecords();
    }
    public void setRecords(Integer records) {
        paging.setRecords(records);
        
        if (paging.getRecords() > 0 && paging.getRows() > 0)
            paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
        else
            paging.setTotal(0);
    }
    
    public String getSord() {
        return paging.getSord();
    }
    public void setSord(String sord) {
        paging.setSord(sord);
    }
    
    public String getSidx() {
        return paging.getSidx();
    }
    public void setSidx(String sidx) {
        paging.setSidx(sidx);
    }
    
    public void setSearchField(String searchField) {
        paging.setSearchField(searchField);
    }
    public void setSearchString(String searchString) {
        paging.setSearchString(searchString);
    }
    public void setSearchOper(String searchOper) {
        paging.setSearchOper(searchOper);
    }

    
    // </editor-fold>
    
}
