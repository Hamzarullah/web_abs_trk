
package com.inkombizz.sales.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerPurchaseOrderReleaseBLL;
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
public class CustomerPurchaseOrderReleaseJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private EnumActivity.ENUM_Activity enumCustomerPurchaseOrderReleaseActivity;
    
    private CustomerPurchaseOrder customerPurchaseOrderRelease=new CustomerPurchaseOrder();
    private List<CustomerPurchaseOrder> listCustomerPurchaseOrderRelease;
    private List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderReleaseSalesQuotation;
    private CustomerPurchaseOrderItemDetail customerPurchaseOrderReleaseItemDetail;
    private List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderReleaseItemDetail;
    private List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderReleaseAdditionalFee;
    private List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderReleasePaymentTerm;
    private List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderReleaseItemDeliveryDate;
    
    private String listCustomerPurchaseOrderReleaseSalesQuotationJSON;
    private String listCustomerPurchaseOrderReleaseItemDetailJSON;
    private String listCustomerPurchaseOrderReleaseAdditionalFeeJSON;
    private String listCustomerPurchaseOrderReleasePaymentTermJSON;
    private String listCustomerPurchaseOrderReleaseItemDeliveryJSON;
    private ArrayList arrSalesQuotationNo;
    private Date customerPurchaseOrderReleaseSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date customerPurchaseOrderReleaseSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private String customerPurchaseOrderReleasSearchClosingStatus="OPEN";
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
    
    @Action("customer-purchase-order-release-data")
    public String findData() {
        try {
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            ListPaging <CustomerPurchaseOrder> listPaging = customerPurchaseOrderBLL.findData(paging,customerPurchaseOrderRelease,customerPurchaseOrderReleasSearchClosingStatus,customerPurchaseOrderReleasSearchValidStatus);
            
            listCustomerPurchaseOrderRelease = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-get")
    public String findData2() {
        try {
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            this.customerPurchaseOrderRelease = customerPurchaseOrderBLL.findData(this.customerPurchaseOrderRelease.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("customer-purchase-order-release-sales-quotation-data")
    public String findDataSalesQuotation(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderSalesQuotation> list = customerPurchaseOrderBLL.findDataSalesQuotation(customerPurchaseOrderRelease.getCode());
            
            listCustomerPurchaseOrderReleaseSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataItemDetail(arrSalesQuotationNo);
            
            listCustomerPurchaseOrderReleaseItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-item-detail-get-data")
    public String findDataUpdateItemDetail(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataUpdateItemDetail(customerPurchaseOrderRelease.getCode());
            
            listCustomerPurchaseOrderReleaseItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul BlanketOrder: Look up Di Item Detail
    @Action("customer-purchase-order-release-item-detail-getgroupby-sales-quotation-data")
    public String findDataDetailGetGroupBySalesQuotation(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataItemDetail(arrSalesQuotationNo,customerPurchaseOrderReleaseItemDetail);
            
            listCustomerPurchaseOrderReleaseItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-item-detail-data-array-data")
    public String findDataItemDetailArray(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataItemDetailArray(arrSalesQuotationNo,customerPurchaseOrderRelease.getCode());
            
            listCustomerPurchaseOrderReleaseItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul BlanketOrder: Syncronisasi Data Item Detail
    @Action("customer-purchase-order-release-item-detail-sync-data")
    public String findDataSyncItemDetail(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrderBLL.findDataSyncItemDetail(arrSalesQuotationNo,customerPurchaseOrderRelease);
            
            listCustomerPurchaseOrderReleaseItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-additional-fee-data")
    public String findDataAdditionalFee(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderAdditionalFee> list = customerPurchaseOrderBLL.findDataAdditionalFee(customerPurchaseOrderRelease.getCode());
            
            listCustomerPurchaseOrderReleaseAdditionalFee = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-get-additional-fee-amount")
    public String totalAdditionalFeeAmount() {
        try {
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            this.customerPurchaseOrderRelease = customerPurchaseOrderBLL.totalAdditionalFeeAmount(this.customerPurchaseOrderRelease.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-payment-term-data")
    public String findDataPaymentTerm(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderPaymentTerm> list = customerPurchaseOrderBLL.findDataPaymentTerm(customerPurchaseOrderRelease.getCode());
            
            listCustomerPurchaseOrderReleasePaymentTerm = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-item-delivery-data")
    public String findDataItemDeliveryDate(){
        try {
            
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            List<CustomerPurchaseOrderItemDeliveryDate> list = customerPurchaseOrderBLL.findDataItemDeliveryDate(customerPurchaseOrderRelease.getCode());
            
            listCustomerPurchaseOrderReleaseItemDeliveryDate = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("customer-purchase-order-release-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            Gson qson = new Gson();
            Gson ison = new Gson();
            Gson fson = new Gson();
            Gson pson = new Gson();
            Gson dson = new Gson();
            dson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            this.listCustomerPurchaseOrderReleaseSalesQuotation = qson.fromJson(this.listCustomerPurchaseOrderReleaseSalesQuotationJSON, new TypeToken<List<CustomerPurchaseOrderSalesQuotation>>(){}.getType());
            this.listCustomerPurchaseOrderReleaseItemDetail = ison.fromJson(this.listCustomerPurchaseOrderReleaseItemDetailJSON, new TypeToken<List<CustomerPurchaseOrderItemDetail>>(){}.getType());
            this.listCustomerPurchaseOrderReleaseAdditionalFee = fson.fromJson(this.listCustomerPurchaseOrderReleaseAdditionalFeeJSON, new TypeToken<List<CustomerPurchaseOrderAdditionalFee>>(){}.getType());
            this.listCustomerPurchaseOrderReleasePaymentTerm = pson.fromJson(this.listCustomerPurchaseOrderReleasePaymentTermJSON, new TypeToken<List<CustomerPurchaseOrderPaymentTerm>>(){}.getType());
            this.listCustomerPurchaseOrderReleaseItemDeliveryDate = dson.fromJson(this.listCustomerPurchaseOrderReleaseItemDeliveryJSON, new TypeToken<List<CustomerPurchaseOrderItemDeliveryDate>>(){}.getType());
            
            customerPurchaseOrderRelease.setTransactionDate(DateUtils.newDateTime(customerPurchaseOrderRelease.getTransactionDate(),true));
            
            Date createdDate = sdf.parse(customerPurchaseOrderRelease.getCreatedDateTemp());
            Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
            customerPurchaseOrderRelease.setCreatedDate(createdDatetime);
            
            if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
                _Messg="UPDATE ";
                customerPurchaseOrderBLL.update(customerPurchaseOrderRelease, listCustomerPurchaseOrderReleaseSalesQuotation,listCustomerPurchaseOrderReleaseItemDetail,
                    listCustomerPurchaseOrderReleaseAdditionalFee,listCustomerPurchaseOrderReleasePaymentTerm, listCustomerPurchaseOrderReleaseItemDeliveryDate);
            }

            if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                _Messg = "REVISE";
                if(customerPurchaseOrderBLL.isExist(this.customerPurchaseOrderRelease.getCode())){
                    throw new Exception("Code "+this.customerPurchaseOrderRelease.getCode()+" has been existing in Database!");
                }else{
                    customerPurchaseOrderBLL.revise(customerPurchaseOrderRelease, listCustomerPurchaseOrderReleaseSalesQuotation,listCustomerPurchaseOrderReleaseItemDetail,
                        listCustomerPurchaseOrderReleaseAdditionalFee,listCustomerPurchaseOrderReleasePaymentTerm, listCustomerPurchaseOrderReleaseItemDeliveryDate);
                }
                
            }
            
            if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                _Messg = "CLONE";
                customerPurchaseOrderBLL.save(enumCustomerPurchaseOrderReleaseActivity,customerPurchaseOrderRelease, listCustomerPurchaseOrderReleaseSalesQuotation,listCustomerPurchaseOrderReleaseItemDetail,
                        listCustomerPurchaseOrderReleaseAdditionalFee, listCustomerPurchaseOrderReleasePaymentTerm, listCustomerPurchaseOrderReleaseItemDeliveryDate);
            }

            if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                _Messg = "SAVE";
                customerPurchaseOrderBLL.save(enumCustomerPurchaseOrderReleaseActivity,customerPurchaseOrderRelease, listCustomerPurchaseOrderReleaseSalesQuotation,listCustomerPurchaseOrderReleaseItemDetail,
                        listCustomerPurchaseOrderReleaseAdditionalFee, listCustomerPurchaseOrderReleasePaymentTerm, listCustomerPurchaseOrderReleaseItemDeliveryDate);
            }

//            if(customerPurchaseOrderBLL.isExist(this.customerPurchaseOrder.getCode())){
//                               
//                if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
//                    _Messg="UPDATE ";
//                    customerPurchaseOrderBLL.update(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
//                        listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
//                }
//                
//                if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
//                    _Messg = "REVISE";
//                    customerPurchaseOrderBLL.revise(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
//                        listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
//                }
//                
//            }else{
//                
//                if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
//                    _Messg = "CLONE";
//                }
//                
//                if(enumCustomerPurchaseOrderReleaseActivity.equals(EnumActivity.ENUM_Activity.NEW)){
//                    _Messg = "SAVE";
//                }
//                
//                customerPurchaseOrderBLL.save(enumCustomerPurchaseOrderReleaseActivity,customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
//                        listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate);
//                 
//            }
            
            this.message = _Messg + " DATA SUCCESS.<br/>POC No : " + this.customerPurchaseOrderRelease.getCustPONo();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-release-delete")
    public String delete(){
        String _messg = "";
        try{
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
              
                
            customerPurchaseOrderBLL.delete(customerPurchaseOrderRelease);
            
            this.message = _messg + "DATA SUCCESS.<br/> POC No : " + this.customerPurchaseOrderRelease.getCode();
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

    public EnumActivity.ENUM_Activity getEnumCustomerPurchaseOrderReleaseActivity() {
        return enumCustomerPurchaseOrderReleaseActivity;
    }

    public void setEnumCustomerPurchaseOrderReleaseActivity(EnumActivity.ENUM_Activity enumCustomerPurchaseOrderReleaseActivity) {
        this.enumCustomerPurchaseOrderReleaseActivity = enumCustomerPurchaseOrderReleaseActivity;
    }

    public CustomerPurchaseOrder getCustomerPurchaseOrderRelease() {
        return customerPurchaseOrderRelease;
    }

    public void setCustomerPurchaseOrderRelease(CustomerPurchaseOrder customerPurchaseOrderRelease) {
        this.customerPurchaseOrderRelease = customerPurchaseOrderRelease;
    }

    public List<CustomerPurchaseOrder> getListCustomerPurchaseOrderRelease() {
        return listCustomerPurchaseOrderRelease;
    }

    public void setListCustomerPurchaseOrderRelease(List<CustomerPurchaseOrder> listCustomerPurchaseOrderRelease) {
        this.listCustomerPurchaseOrderRelease = listCustomerPurchaseOrderRelease;
    }

    public List<CustomerPurchaseOrderSalesQuotation> getListCustomerPurchaseOrderReleaseSalesQuotation() {
        return listCustomerPurchaseOrderReleaseSalesQuotation;
    }

    public void setListCustomerPurchaseOrderReleaseSalesQuotation(List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderReleaseSalesQuotation) {
        this.listCustomerPurchaseOrderReleaseSalesQuotation = listCustomerPurchaseOrderReleaseSalesQuotation;
    }

    public CustomerPurchaseOrderItemDetail getCustomerPurchaseOrderReleaseItemDetail() {
        return customerPurchaseOrderReleaseItemDetail;
    }

    public void setCustomerPurchaseOrderReleaseItemDetail(CustomerPurchaseOrderItemDetail customerPurchaseOrderReleaseItemDetail) {
        this.customerPurchaseOrderReleaseItemDetail = customerPurchaseOrderReleaseItemDetail;
    }

    public List<CustomerPurchaseOrderItemDetail> getListCustomerPurchaseOrderReleaseItemDetail() {
        return listCustomerPurchaseOrderReleaseItemDetail;
    }

    public void setListCustomerPurchaseOrderReleaseItemDetail(List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderReleaseItemDetail) {
        this.listCustomerPurchaseOrderReleaseItemDetail = listCustomerPurchaseOrderReleaseItemDetail;
    }

    public List<CustomerPurchaseOrderAdditionalFee> getListCustomerPurchaseOrderReleaseAdditionalFee() {
        return listCustomerPurchaseOrderReleaseAdditionalFee;
    }

    public void setListCustomerPurchaseOrderReleaseAdditionalFee(List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderReleaseAdditionalFee) {
        this.listCustomerPurchaseOrderReleaseAdditionalFee = listCustomerPurchaseOrderReleaseAdditionalFee;
    }

    public List<CustomerPurchaseOrderPaymentTerm> getListCustomerPurchaseOrderReleasePaymentTerm() {
        return listCustomerPurchaseOrderReleasePaymentTerm;
    }

    public void setListCustomerPurchaseOrderReleasePaymentTerm(List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderReleasePaymentTerm) {
        this.listCustomerPurchaseOrderReleasePaymentTerm = listCustomerPurchaseOrderReleasePaymentTerm;
    }

    public List<CustomerPurchaseOrderItemDeliveryDate> getListCustomerPurchaseOrderReleaseItemDeliveryDate() {
        return listCustomerPurchaseOrderReleaseItemDeliveryDate;
    }

    public void setListCustomerPurchaseOrderReleaseItemDeliveryDate(List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderReleaseItemDeliveryDate) {
        this.listCustomerPurchaseOrderReleaseItemDeliveryDate = listCustomerPurchaseOrderReleaseItemDeliveryDate;
    }

    public String getListCustomerPurchaseOrderReleaseSalesQuotationJSON() {
        return listCustomerPurchaseOrderReleaseSalesQuotationJSON;
    }

    public void setListCustomerPurchaseOrderReleaseSalesQuotationJSON(String listCustomerPurchaseOrderReleaseSalesQuotationJSON) {
        this.listCustomerPurchaseOrderReleaseSalesQuotationJSON = listCustomerPurchaseOrderReleaseSalesQuotationJSON;
    }

    public String getListCustomerPurchaseOrderReleaseItemDetailJSON() {
        return listCustomerPurchaseOrderReleaseItemDetailJSON;
    }

    public void setListCustomerPurchaseOrderReleaseItemDetailJSON(String listCustomerPurchaseOrderReleaseItemDetailJSON) {
        this.listCustomerPurchaseOrderReleaseItemDetailJSON = listCustomerPurchaseOrderReleaseItemDetailJSON;
    }

    public String getListCustomerPurchaseOrderReleaseAdditionalFeeJSON() {
        return listCustomerPurchaseOrderReleaseAdditionalFeeJSON;
    }

    public void setListCustomerPurchaseOrderReleaseAdditionalFeeJSON(String listCustomerPurchaseOrderReleaseAdditionalFeeJSON) {
        this.listCustomerPurchaseOrderReleaseAdditionalFeeJSON = listCustomerPurchaseOrderReleaseAdditionalFeeJSON;
    }

    public String getListCustomerPurchaseOrderReleasePaymentTermJSON() {
        return listCustomerPurchaseOrderReleasePaymentTermJSON;
    }

    public void setListCustomerPurchaseOrderReleasePaymentTermJSON(String listCustomerPurchaseOrderReleasePaymentTermJSON) {
        this.listCustomerPurchaseOrderReleasePaymentTermJSON = listCustomerPurchaseOrderReleasePaymentTermJSON;
    }

    public String getListCustomerPurchaseOrderReleaseItemDeliveryJSON() {
        return listCustomerPurchaseOrderReleaseItemDeliveryJSON;
    }

    public void setListCustomerPurchaseOrderReleaseItemDeliveryJSON(String listCustomerPurchaseOrderReleaseItemDeliveryJSON) {
        this.listCustomerPurchaseOrderReleaseItemDeliveryJSON = listCustomerPurchaseOrderReleaseItemDeliveryJSON;
    }

    public ArrayList getArrSalesQuotationNo() {
        return arrSalesQuotationNo;
    }

    public void setArrSalesQuotationNo(ArrayList arrSalesQuotationNo) {
        this.arrSalesQuotationNo = arrSalesQuotationNo;
    }

    public Date getCustomerPurchaseOrderReleaseSearchFirstDate() {
        return customerPurchaseOrderReleaseSearchFirstDate;
    }

    public void setCustomerPurchaseOrderReleaseSearchFirstDate(Date customerPurchaseOrderReleaseSearchFirstDate) {
        this.customerPurchaseOrderReleaseSearchFirstDate = customerPurchaseOrderReleaseSearchFirstDate;
    }

    public Date getCustomerPurchaseOrderReleaseSearchLastDate() {
        return customerPurchaseOrderReleaseSearchLastDate;
    }

    public void setCustomerPurchaseOrderReleaseSearchLastDate(Date customerPurchaseOrderReleaseSearchLastDate) {
        this.customerPurchaseOrderReleaseSearchLastDate = customerPurchaseOrderReleaseSearchLastDate;
    }

    public String getCustomerPurchaseOrderReleasSearchValidStatus() {
        return customerPurchaseOrderReleasSearchValidStatus;
    }

    public void setCustomerPurchaseOrderReleasSearchValidStatus(String customerPurchaseOrderReleasSearchValidStatus) {
        this.customerPurchaseOrderReleasSearchValidStatus = customerPurchaseOrderReleasSearchValidStatus;
    }

    public String getCustomerPurchaseOrderReleasSearchClosingStatus() {
        return customerPurchaseOrderReleasSearchClosingStatus;
    }

    public void setCustomerPurchaseOrderReleasSearchClosingStatus(String customerPurchaseOrderReleasSearchClosingStatus) {
        this.customerPurchaseOrderReleasSearchClosingStatus = customerPurchaseOrderReleasSearchClosingStatus;
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
