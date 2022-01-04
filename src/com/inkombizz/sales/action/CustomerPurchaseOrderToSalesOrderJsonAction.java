
package com.inkombizz.sales.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerPurchaseOrderToSalesOrderBLL;
//import com.inkombizz.sales.bll.SalesQuotationBLL;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetail;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotation;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class CustomerPurchaseOrderToSalesOrderJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private EnumActivity.ENUM_Activity enumCustomerPurchaseOrderActivity;
    
    private CustomerPurchaseOrder customerPurchaseOrder=new CustomerPurchaseOrder();
    private List<CustomerPurchaseOrder> listCustomerPurchaseOrder;
    private List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation;
    private CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail;
    private List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail;
    private List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee;
    private List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm;
    private List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate;
    
    private String listCustomerPurchaseOrderSalesQuotationJSON;
    private String listCustomerPurchaseOrderItemDetailJSON;
    private String listCustomerPurchaseOrderAdditionalFeeJSON;
    private String listCustomerPurchaseOrderPaymentTermJSON;
    private String listCustomerPurchaseOrderItemDeliveryJSON;
    private ArrayList arrSalesQuotationNo;
    private Date customerPurchaseOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date customerPurchaseOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private Date customerPurchaseOrderSearchLookUpFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date customerPurchaseOrderSearchLookUpLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private String customerPurchaseOrderReleasSearchValidStatus="TRUE";
        
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("customer-purchase-order-data")
    public String findData() {
        try {
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            
            ListPaging <CustomerPurchaseOrder> listPaging = customerPurchaseOrderBLL.findData(paging,customerPurchaseOrder,customerPurchaseOrderReleasSearchValidStatus);
            
            listCustomerPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-data-lookup")
    public String findDataLookup() {
        try {
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            
            ListPaging <CustomerPurchaseOrder> listPaging = customerPurchaseOrderBLL.findDataLookUp(paging,customerPurchaseOrder,customerPurchaseOrderSearchLookUpFirstDate,customerPurchaseOrderSearchLookUpLastDate);
            
            listCustomerPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-get")
    public String findData2() {
        try {
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            this.customerPurchaseOrder = customerPurchaseOrderBLL.findData(this.customerPurchaseOrder.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("customer-purchase-order-sales-quotation-data")
    public String findDataSalesQuotation(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderSalesQuotation> list = customerPurchaseOrderBLL.findDataSalesQuotation(customerPurchaseOrder.getCode());
            
            listCustomerPurchaseOrderSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataItemDetail(customerPurchaseOrder.getCode());
            
            listCustomerPurchaseOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-item-detail-get-data")
    public String findDataUpdateItemDetail(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataUpdateItemDetail(customerPurchaseOrder.getCode());
            
            listCustomerPurchaseOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul BlanketOrder: Look up Di Item Detail
    @Action("customer-purchase-order-item-detail-getgroupby-sales-quotation-data")
    public String findDataDetailGetGroupBySalesQuotation(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataItemDetail(arrSalesQuotationNo,customerPurchaseOrderItemDetail);
            
            listCustomerPurchaseOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul BlanketOrder: Syncronisasi Data Item Detail
    @Action("customer-purchase-order-item-detail-sync-data")
    public String findDataSyncItemDetail(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataSyncItemDetail(arrSalesQuotationNo,customerPurchaseOrder);
            
            listCustomerPurchaseOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-additional-fee-data")
    public String findDataAdditionalFee(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderAdditionalFee> list = customerPurchaseOrderBLL.findDataAdditionalFee(customerPurchaseOrder.getCode());
            
            listCustomerPurchaseOrderAdditionalFee = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-get-additional-fee-amount")
    public String totalAdditionalFeeAmount() {
        try {
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            this.customerPurchaseOrder = customerPurchaseOrderBLL.totalAdditionalFeeAmount(this.customerPurchaseOrder.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-payment-term-data")
    public String findDataPaymentTerm(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderPaymentTerm> list = customerPurchaseOrderBLL.findDataPaymentTerm(customerPurchaseOrder.getCode());
            
            listCustomerPurchaseOrderPaymentTerm = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-item-delivery-data")
    public String findDataItemDeliveryDate(){
        try {
            
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDeliveryDate> list = customerPurchaseOrderBLL.findDataItemDeliveryDate(customerPurchaseOrder.getCode());
            
            listCustomerPurchaseOrderItemDeliveryDate = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("customer-purchase-order-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            Gson qson = new Gson();
            Gson ison = new Gson();
            Gson fson = new Gson();
            Gson pson = new Gson();
            Gson dson = new Gson();
            dson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            this.listCustomerPurchaseOrderSalesQuotation = qson.fromJson(this.listCustomerPurchaseOrderSalesQuotationJSON, new TypeToken<List<CustomerPurchaseOrderSalesQuotation>>(){}.getType());
            this.listCustomerPurchaseOrderItemDetail = ison.fromJson(this.listCustomerPurchaseOrderItemDetailJSON, new TypeToken<List<CustomerPurchaseOrderItemDetail>>(){}.getType());
            this.listCustomerPurchaseOrderAdditionalFee = fson.fromJson(this.listCustomerPurchaseOrderAdditionalFeeJSON, new TypeToken<List<CustomerPurchaseOrderAdditionalFee>>(){}.getType());
            this.listCustomerPurchaseOrderPaymentTerm = pson.fromJson(this.listCustomerPurchaseOrderPaymentTermJSON, new TypeToken<List<CustomerPurchaseOrderPaymentTerm>>(){}.getType());
            this.listCustomerPurchaseOrderItemDeliveryDate = dson.fromJson(this.listCustomerPurchaseOrderItemDeliveryJSON, new TypeToken<List<CustomerPurchaseOrderItemDeliveryDate>>(){}.getType());
            
            customerPurchaseOrder.setTransactionDate(DateUtils.newDateTime(customerPurchaseOrder.getTransactionDate(),true));
            
            Date createdDate = sdf.parse(customerPurchaseOrder.getCreatedDateTemp());
            Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
            customerPurchaseOrder.setCreatedDate(createdDatetime);
            
            
            if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
                _Messg="UPDATE ";
                customerPurchaseOrderBLL.update(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
            }

            if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                _Messg = "REVISE";
                if(customerPurchaseOrderBLL.isExist(this.customerPurchaseOrder.getCode())){
                    throw new Exception("Code "+this.customerPurchaseOrder.getCode()+" has been existing in Database!");
                }else{
                    customerPurchaseOrderBLL.revise(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                        listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
                }
                
            }
            
            if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                _Messg = "CLONE";
                customerPurchaseOrderBLL.save(enumCustomerPurchaseOrderActivity,customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
            }

            if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                _Messg = "SAVE";
                customerPurchaseOrderBLL.save(enumCustomerPurchaseOrderActivity,customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
            }

            

//            if(customerPurchaseOrderBLL.isExist(this.customerPurchaseOrder.getCode())){
//                               
//                if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
//                    _Messg="UPDATE ";
//                    customerPurchaseOrderBLL.update(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
//                        listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
//                }
//                
//                if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
//                    _Messg = "REVISE";
//                    customerPurchaseOrderBLL.revise(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
//                        listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
//                }
//                
//            }else{
//                
//                if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
//                    _Messg = "CLONE";
//                }
//                
//                if(enumCustomerPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.NEW)){
//                    _Messg = "SAVE";
//                }
//                
//                customerPurchaseOrderBLL.save(enumCustomerPurchaseOrderActivity,customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
//                        listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
//                 
//            }
            
            this.message = _Messg + " DATA SUCCESS.<br/>POC No : " + this.customerPurchaseOrder.getCustPONo();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-delete")
    public String delete(){
        String _messg = "";
        try{
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
              
                
            customerPurchaseOrderBLL.delete(customerPurchaseOrder);
            
            this.message = _messg + "DATA SUCCESS.<br/> POC No : " + this.customerPurchaseOrder.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED. <br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerPurchaseOrder getCustomerPurchaseOrder() {
        return customerPurchaseOrder;
    }

    public void setCustomerPurchaseOrder(CustomerPurchaseOrder customerPurchaseOrder) {
        this.customerPurchaseOrder = customerPurchaseOrder;
    }

    public List<CustomerPurchaseOrderSalesQuotation> getListCustomerPurchaseOrderSalesQuotation() {
        return listCustomerPurchaseOrderSalesQuotation;
    }

    public void setListCustomerPurchaseOrderSalesQuotation(List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation) {
        this.listCustomerPurchaseOrderSalesQuotation = listCustomerPurchaseOrderSalesQuotation;
    }

    public List<CustomerPurchaseOrderItemDetail> getListCustomerPurchaseOrderItemDetail() {
        return listCustomerPurchaseOrderItemDetail;
    }

    public void setListCustomerPurchaseOrderItemDetail(List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail) {
        this.listCustomerPurchaseOrderItemDetail = listCustomerPurchaseOrderItemDetail;
    }

    public List<CustomerPurchaseOrderAdditionalFee> getListCustomerPurchaseOrderAdditionalFee() {
        return listCustomerPurchaseOrderAdditionalFee;
    }

    public void setListCustomerPurchaseOrderAdditionalFee(List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee) {
        this.listCustomerPurchaseOrderAdditionalFee = listCustomerPurchaseOrderAdditionalFee;
    }

    public List<CustomerPurchaseOrderPaymentTerm> getListCustomerPurchaseOrderPaymentTerm() {
        return listCustomerPurchaseOrderPaymentTerm;
    }

    public void setListCustomerPurchaseOrderPaymentTerm(List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm) {
        this.listCustomerPurchaseOrderPaymentTerm = listCustomerPurchaseOrderPaymentTerm;
    }

    public List<CustomerPurchaseOrderItemDeliveryDate> getListCustomerPurchaseOrderItemDeliveryDate() {
        return listCustomerPurchaseOrderItemDeliveryDate;
    }

    public void setListCustomerPurchaseOrderItemDeliveryDate(List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) {
        this.listCustomerPurchaseOrderItemDeliveryDate = listCustomerPurchaseOrderItemDeliveryDate;
    }

    public String getListCustomerPurchaseOrderSalesQuotationJSON() {
        return listCustomerPurchaseOrderSalesQuotationJSON;
    }

    public void setListCustomerPurchaseOrderSalesQuotationJSON(String listCustomerPurchaseOrderSalesQuotationJSON) {
        this.listCustomerPurchaseOrderSalesQuotationJSON = listCustomerPurchaseOrderSalesQuotationJSON;
    }

    public String getListCustomerPurchaseOrderItemDetailJSON() {
        return listCustomerPurchaseOrderItemDetailJSON;
    }

    public void setListCustomerPurchaseOrderItemDetailJSON(String listCustomerPurchaseOrderItemDetailJSON) {
        this.listCustomerPurchaseOrderItemDetailJSON = listCustomerPurchaseOrderItemDetailJSON;
    }

    public String getListCustomerPurchaseOrderAdditionalFeeJSON() {
        return listCustomerPurchaseOrderAdditionalFeeJSON;
    }

    public void setListCustomerPurchaseOrderAdditionalFeeJSON(String listCustomerPurchaseOrderAdditionalFeeJSON) {
        this.listCustomerPurchaseOrderAdditionalFeeJSON = listCustomerPurchaseOrderAdditionalFeeJSON;
    }

    public String getListCustomerPurchaseOrderPaymentTermJSON() {
        return listCustomerPurchaseOrderPaymentTermJSON;
    }

    public void setListCustomerPurchaseOrderPaymentTermJSON(String listCustomerPurchaseOrderPaymentTermJSON) {
        this.listCustomerPurchaseOrderPaymentTermJSON = listCustomerPurchaseOrderPaymentTermJSON;
    }

    public String getListCustomerPurchaseOrderItemDeliveryJSON() {
        return listCustomerPurchaseOrderItemDeliveryJSON;
    }

    public void setListCustomerPurchaseOrderItemDeliveryJSON(String listCustomerPurchaseOrderItemDeliveryJSON) {
        this.listCustomerPurchaseOrderItemDeliveryJSON = listCustomerPurchaseOrderItemDeliveryJSON;
    }

    public Date getCustomerPurchaseOrderSearchFirstDate() {
        return customerPurchaseOrderSearchFirstDate;
    }

    public void setCustomerPurchaseOrderSearchFirstDate(Date customerPurchaseOrderSearchFirstDate) {
        this.customerPurchaseOrderSearchFirstDate = customerPurchaseOrderSearchFirstDate;
    }

    public Date getCustomerPurchaseOrderSearchLastDate() {
        return customerPurchaseOrderSearchLastDate;
    }

    public void setCustomerPurchaseOrderSearchLastDate(Date customerPurchaseOrderSearchLastDate) {
        this.customerPurchaseOrderSearchLastDate = customerPurchaseOrderSearchLastDate;
    }

    public List<CustomerPurchaseOrder> getListCustomerPurchaseOrder() {
        return listCustomerPurchaseOrder;
    }

    public void setListCustomerPurchaseOrder(List<CustomerPurchaseOrder> listCustomerPurchaseOrder) {
        this.listCustomerPurchaseOrder = listCustomerPurchaseOrder;
    }

    public EnumActivity.ENUM_Activity getEnumCustomerPurchaseOrderActivity() {
        return enumCustomerPurchaseOrderActivity;
    }

    public void setEnumCustomerPurchaseOrderActivity(EnumActivity.ENUM_Activity enumCustomerPurchaseOrderActivity) {
        this.enumCustomerPurchaseOrderActivity = enumCustomerPurchaseOrderActivity;
    }

    public ArrayList getArrSalesQuotationNo() {
        return arrSalesQuotationNo;
    }

    public void setArrSalesQuotationNo(ArrayList arrSalesQuotationNo) {
        this.arrSalesQuotationNo = arrSalesQuotationNo;
    }

    public CustomerPurchaseOrderItemDetail getCustomerPurchaseOrderItemDetail() {
        return customerPurchaseOrderItemDetail;
    }

    public void setCustomerPurchaseOrderItemDetail(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail) {
        this.customerPurchaseOrderItemDetail = customerPurchaseOrderItemDetail;
    }

    public String getCustomerPurchaseOrderReleasSearchValidStatus() {
        return customerPurchaseOrderReleasSearchValidStatus;
    }

    public void setCustomerPurchaseOrderReleasSearchValidStatus(String customerPurchaseOrderReleasSearchValidStatus) {
        this.customerPurchaseOrderReleasSearchValidStatus = customerPurchaseOrderReleasSearchValidStatus;
    }

    public Date getCustomerPurchaseOrderSearchLookUpFirstDate() {
        return customerPurchaseOrderSearchLookUpFirstDate;
    }

    public void setCustomerPurchaseOrderSearchLookUpFirstDate(Date customerPurchaseOrderSearchLookUpFirstDate) {
        this.customerPurchaseOrderSearchLookUpFirstDate = customerPurchaseOrderSearchLookUpFirstDate;
    }

    public Date getCustomerPurchaseOrderSearchLookUpLastDate() {
        return customerPurchaseOrderSearchLookUpLastDate;
    }

    public void setCustomerPurchaseOrderSearchLookUpLastDate(Date customerPurchaseOrderSearchLookUpLastDate) {
        this.customerPurchaseOrderSearchLookUpLastDate = customerPurchaseOrderSearchLookUpLastDate;
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
