
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
import com.inkombizz.sales.bll.CustomerPurchaseOrderToBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerBlanketOrder;
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
public class CustomerPurchaseOrderToBlanketOrderJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private EnumActivity.ENUM_Activity enumCustomerPurchaseOrderToBlanketOrderActivity;
    
    private CustomerPurchaseOrder customerPurchaseOrderToBlanketOrder=new CustomerPurchaseOrder();
    private CustomerBlanketOrder blanketOrder=new CustomerBlanketOrder();
    private List<CustomerPurchaseOrder> listCustomerPurchaseOrderToBlanketOrder;
    private List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderToBlanketOrderSalesQuotation;
    private CustomerPurchaseOrderItemDetail customerPurchaseOrderToBlanketOrderItemDetail;
    private List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderToBlanketOrderItemDetail;
    private List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderToBlanketOrderAdditionalFee;
    private List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderToBlanketOrderPaymentTerm;
    private List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate;
    
    private String listCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON;
    private String listCustomerPurchaseOrderToBlanketOrderItemDetailJSON;
    private String listCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON;
    private String listCustomerPurchaseOrderToBlanketOrderPaymentTermJSON;
    private String listCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON;
    private ArrayList arrSalesQuotationNo;
    private ArrayList arrSalesQuotationCode;
    private Date customerPurchaseOrderToBlanketOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date customerPurchaseOrderToBlanketOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
        
    private String customerPurchaseOrderToBlanketOrderSearchValidStatus="TRUE";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("customer-purchase-order-to-blanket-order-data")
    public String findData() {
        try {
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            ListPaging <CustomerPurchaseOrder> listPaging = customerPurchaseOrdeToBlanketOrderBLL.findData(paging,customerPurchaseOrderToBlanketOrder, customerPurchaseOrderToBlanketOrderSearchValidStatus);
            
            listCustomerPurchaseOrderToBlanketOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-get")
    public String findData2() {
        try {
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            this.customerPurchaseOrderToBlanketOrder = customerPurchaseOrdeToBlanketOrderBLL.findData(this.customerPurchaseOrderToBlanketOrder.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("customer-purchase-order-to-blanket-order-sales-quotation-data")
    public String findDataSalesQuotation(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderSalesQuotation> list = customerPurchaseOrdeToBlanketOrderBLL.findDataSalesQuotation(customerPurchaseOrderToBlanketOrder.getCode());
            
            listCustomerPurchaseOrderToBlanketOrderSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrdeToBlanketOrderBLL.findDataItemDetail(customerPurchaseOrderToBlanketOrder.getCode());
            
            listCustomerPurchaseOrderToBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-item-detail-data-array-data")
    public String findDataDetailGetGroupBySalesQuotationArray(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrdeToBlanketOrderBLL.findDataItemDetailArray(arrSalesQuotationCode);
            
            listCustomerPurchaseOrderToBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-item-detail-data-array-data-lastest")
    public String findDataDetailGetGroupBySalesQuotationArray2(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrdeToBlanketOrderBLL.findDataItemDetailArray2(arrSalesQuotationCode,customerPurchaseOrderToBlanketOrder.getCode());
            
            listCustomerPurchaseOrderToBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul BlanketOrder: Look up Di Item Detail
    @Action("customer-purchase-order-to-blanket-order-item-detail-getgroupby-sales-quotation-data")
    public String findDataDetailGetGroupBySalesQuotation(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrdeToBlanketOrderBLL.findDataItemDetail(arrSalesQuotationNo,customerPurchaseOrderToBlanketOrderItemDetail);
            
            listCustomerPurchaseOrderToBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul BlanketOrder: Syncronisasi Data Item Detail
    @Action("customer-purchase-order-to-blanket-order-item-detail-sync-data")
    public String findDataSyncItemDetail(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDetail> list = customerPurchaseOrdeToBlanketOrderBLL.findDataSyncItemDetail(arrSalesQuotationNo,customerPurchaseOrderToBlanketOrder);
            
            listCustomerPurchaseOrderToBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-additional-fee-data")
    public String findDataAdditionalFee(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderAdditionalFee> list = customerPurchaseOrdeToBlanketOrderBLL.findDataAdditionalFee(customerPurchaseOrderToBlanketOrder.getCode());
            
            listCustomerPurchaseOrderToBlanketOrderAdditionalFee = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-get-additional-fee-amount")
    public String totalAdditionalFeeAmount() {
        try {
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            this.customerPurchaseOrderToBlanketOrder = customerPurchaseOrdeToBlanketOrderBLL.totalAdditionalFeeAmount(this.customerPurchaseOrderToBlanketOrder.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-payment-term-data")
    public String findDataPaymentTerm(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderPaymentTerm> list = customerPurchaseOrdeToBlanketOrderBLL.findDataPaymentTerm(customerPurchaseOrderToBlanketOrder.getCode());
            
            listCustomerPurchaseOrderToBlanketOrderPaymentTerm = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-item-delivery-data")
    public String findDataItemDeliveryDate(){
        try {
            
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            List<CustomerPurchaseOrderItemDeliveryDate> list = customerPurchaseOrdeToBlanketOrderBLL.findDataItemDeliveryDate(customerPurchaseOrderToBlanketOrder.getCode());
            
            listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("customer-purchase-order-to-blanket-order-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            Gson qson = new Gson();
            Gson ison = new Gson();
            Gson fson = new Gson();
            Gson pson = new Gson();
            Gson dson = new Gson();
            dson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            this.listCustomerPurchaseOrderToBlanketOrderSalesQuotation = qson.fromJson(this.listCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON, new TypeToken<List<CustomerPurchaseOrderSalesQuotation>>(){}.getType());
            this.listCustomerPurchaseOrderToBlanketOrderItemDetail = ison.fromJson(this.listCustomerPurchaseOrderToBlanketOrderItemDetailJSON, new TypeToken<List<CustomerPurchaseOrderItemDetail>>(){}.getType());
            this.listCustomerPurchaseOrderToBlanketOrderAdditionalFee = fson.fromJson(this.listCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON, new TypeToken<List<CustomerPurchaseOrderAdditionalFee>>(){}.getType());
            this.listCustomerPurchaseOrderToBlanketOrderPaymentTerm = pson.fromJson(this.listCustomerPurchaseOrderToBlanketOrderPaymentTermJSON, new TypeToken<List<CustomerPurchaseOrderPaymentTerm>>(){}.getType());
            this.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate = dson.fromJson(this.listCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON, new TypeToken<List<CustomerPurchaseOrderItemDeliveryDate>>(){}.getType());
            
            customerPurchaseOrderToBlanketOrder.setTransactionDate(DateUtils.newDateTime(customerPurchaseOrderToBlanketOrder.getTransactionDate(),true));
            
            Date createdDate = sdf.parse(customerPurchaseOrderToBlanketOrder.getCreatedDateTemp());
            Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
            customerPurchaseOrderToBlanketOrder.setCreatedDate(createdDatetime);
            
            
            if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
                _Messg="UPDATE ";
                customerPurchaseOrdeToBlanketOrderBLL.update(customerPurchaseOrderToBlanketOrder, listCustomerPurchaseOrderToBlanketOrderSalesQuotation,listCustomerPurchaseOrderToBlanketOrderItemDetail,
                    listCustomerPurchaseOrderToBlanketOrderAdditionalFee,listCustomerPurchaseOrderToBlanketOrderPaymentTerm,listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);
            }

            if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                _Messg = "REVISE";
                if(customerPurchaseOrdeToBlanketOrderBLL.isExist(this.customerPurchaseOrderToBlanketOrder.getCode())){
                    throw new Exception("Code "+this.customerPurchaseOrderToBlanketOrder.getCode()+" has been existing in Database!");
                }else{
                    customerPurchaseOrdeToBlanketOrderBLL.revise(customerPurchaseOrderToBlanketOrder, listCustomerPurchaseOrderToBlanketOrderSalesQuotation,listCustomerPurchaseOrderToBlanketOrderItemDetail,
                        listCustomerPurchaseOrderToBlanketOrderAdditionalFee,listCustomerPurchaseOrderToBlanketOrderPaymentTerm,listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);
                }
                
            }
            
            if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                _Messg = "CLONE";
                customerPurchaseOrdeToBlanketOrderBLL.save(enumCustomerPurchaseOrderToBlanketOrderActivity,customerPurchaseOrderToBlanketOrder, listCustomerPurchaseOrderToBlanketOrderSalesQuotation,listCustomerPurchaseOrderToBlanketOrderItemDetail,
                    listCustomerPurchaseOrderToBlanketOrderAdditionalFee,listCustomerPurchaseOrderToBlanketOrderPaymentTerm,listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);
            }

            if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                _Messg = "SAVE";
                customerPurchaseOrdeToBlanketOrderBLL.save(enumCustomerPurchaseOrderToBlanketOrderActivity,customerPurchaseOrderToBlanketOrder, listCustomerPurchaseOrderToBlanketOrderSalesQuotation,listCustomerPurchaseOrderToBlanketOrderItemDetail,
                    listCustomerPurchaseOrderToBlanketOrderAdditionalFee,listCustomerPurchaseOrderToBlanketOrderPaymentTerm,listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);
            }

            

//            if(customerPurchaseOrdeToBlanketOrderBLL.isExist(this.customerPurchaseOrderToBlanketOrder.getCode())){
//                               
//                if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
//                    _Messg="UPDATE ";
//                    customerPurchaseOrdeToBlanketOrderBLL.update(customerPurchaseOrderToBlanketOrder, listCustomerPurchaseOrderToBlanketOrderSalesQuotation,listCustomerPurchaseOrderToBlanketOrderItemDetail,
//                        listCustomerPurchaseOrderToBlanketOrderAdditionalFee,listCustomerPurchaseOrderToBlanketOrderPaymentTerm,listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);
//                }
//                
//                if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
//                    _Messg = "REVISE";
//                    customerPurchaseOrdeToBlanketOrderBLL.revise(customerPurchaseOrderToBlanketOrder, listCustomerPurchaseOrderToBlanketOrderSalesQuotation,listCustomerPurchaseOrderToBlanketOrderItemDetail,
//                        listCustomerPurchaseOrderToBlanketOrderAdditionalFee,listCustomerPurchaseOrderToBlanketOrderPaymentTerm,listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);
//                }
//                
//            }else{
//                
//                if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
//                    _Messg = "CLONE";
//                }
//                
//                if(enumCustomerPurchaseOrderToBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.NEW)){
//                    _Messg = "SAVE";
//                }
//                
//                customerPurchaseOrdeToBlanketOrderBLL.save(enumCustomerPurchaseOrderToBlanketOrderActivity,customerPurchaseOrderToBlanketOrder, listCustomerPurchaseOrderToBlanketOrderSalesQuotation,listCustomerPurchaseOrderToBlanketOrderItemDetail,
//                        listCustomerPurchaseOrderToBlanketOrderAdditionalFee,listCustomerPurchaseOrderToBlanketOrderPaymentTerm,listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);
//                 
//            }
            
            this.message = _Messg + " DATA SUCCESS.<br/>POC No : " + this.customerPurchaseOrderToBlanketOrder.getCustPONo();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-purchase-order-to-blanket-order-delete")
    public String delete(){
        String _messg = "";
        try{
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrdeToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrdeToBlanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
              
            customerPurchaseOrdeToBlanketOrderBLL.delete(customerPurchaseOrderToBlanketOrder);
            
            this.message = _messg + "DATA SUCCESS.<br/> POC No : " + this.customerPurchaseOrderToBlanketOrder.getCode();
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

    public EnumActivity.ENUM_Activity getEnumCustomerPurchaseOrderToBlanketOrderActivity() {
        return enumCustomerPurchaseOrderToBlanketOrderActivity;
    }

    public void setEnumCustomerPurchaseOrderToBlanketOrderActivity(EnumActivity.ENUM_Activity enumCustomerPurchaseOrderToBlanketOrderActivity) {
        this.enumCustomerPurchaseOrderToBlanketOrderActivity = enumCustomerPurchaseOrderToBlanketOrderActivity;
    }

    public CustomerPurchaseOrder getCustomerPurchaseOrderToBlanketOrder() {
        return customerPurchaseOrderToBlanketOrder;
    }

    public void setCustomerPurchaseOrderToBlanketOrder(CustomerPurchaseOrder customerPurchaseOrderToBlanketOrder) {
        this.customerPurchaseOrderToBlanketOrder = customerPurchaseOrderToBlanketOrder;
    }

    public List<CustomerPurchaseOrder> getListCustomerPurchaseOrderToBlanketOrder() {
        return listCustomerPurchaseOrderToBlanketOrder;
    }

    public void setListCustomerPurchaseOrderToBlanketOrder(List<CustomerPurchaseOrder> listCustomerPurchaseOrderToBlanketOrder) {
        this.listCustomerPurchaseOrderToBlanketOrder = listCustomerPurchaseOrderToBlanketOrder;
    }

    public List<CustomerPurchaseOrderSalesQuotation> getListCustomerPurchaseOrderToBlanketOrderSalesQuotation() {
        return listCustomerPurchaseOrderToBlanketOrderSalesQuotation;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderSalesQuotation(List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderToBlanketOrderSalesQuotation) {
        this.listCustomerPurchaseOrderToBlanketOrderSalesQuotation = listCustomerPurchaseOrderToBlanketOrderSalesQuotation;
    }

    public CustomerPurchaseOrderItemDetail getCustomerPurchaseOrderToBlanketOrderItemDetail() {
        return customerPurchaseOrderToBlanketOrderItemDetail;
    }

    public void setCustomerPurchaseOrderToBlanketOrderItemDetail(CustomerPurchaseOrderItemDetail customerPurchaseOrderToBlanketOrderItemDetail) {
        this.customerPurchaseOrderToBlanketOrderItemDetail = customerPurchaseOrderToBlanketOrderItemDetail;
    }

    public List<CustomerPurchaseOrderItemDetail> getListCustomerPurchaseOrderToBlanketOrderItemDetail() {
        return listCustomerPurchaseOrderToBlanketOrderItemDetail;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderItemDetail(List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderToBlanketOrderItemDetail) {
        this.listCustomerPurchaseOrderToBlanketOrderItemDetail = listCustomerPurchaseOrderToBlanketOrderItemDetail;
    }

    public List<CustomerPurchaseOrderAdditionalFee> getListCustomerPurchaseOrderToBlanketOrderAdditionalFee() {
        return listCustomerPurchaseOrderToBlanketOrderAdditionalFee;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderAdditionalFee(List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderToBlanketOrderAdditionalFee) {
        this.listCustomerPurchaseOrderToBlanketOrderAdditionalFee = listCustomerPurchaseOrderToBlanketOrderAdditionalFee;
    }

    public List<CustomerPurchaseOrderPaymentTerm> getListCustomerPurchaseOrderToBlanketOrderPaymentTerm() {
        return listCustomerPurchaseOrderToBlanketOrderPaymentTerm;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderPaymentTerm(List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderToBlanketOrderPaymentTerm) {
        this.listCustomerPurchaseOrderToBlanketOrderPaymentTerm = listCustomerPurchaseOrderToBlanketOrderPaymentTerm;
    }

    public List<CustomerPurchaseOrderItemDeliveryDate> getListCustomerPurchaseOrderToBlanketOrderItemDeliveryDate() {
        return listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderItemDeliveryDate(List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate) {
        this.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate = listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate;
    }

    public String getListCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON() {
        return listCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON(String listCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON) {
        this.listCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON = listCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON;
    }

    public String getListCustomerPurchaseOrderToBlanketOrderItemDetailJSON() {
        return listCustomerPurchaseOrderToBlanketOrderItemDetailJSON;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderItemDetailJSON(String listCustomerPurchaseOrderToBlanketOrderItemDetailJSON) {
        this.listCustomerPurchaseOrderToBlanketOrderItemDetailJSON = listCustomerPurchaseOrderToBlanketOrderItemDetailJSON;
    }

    public String getListCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON() {
        return listCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON(String listCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON) {
        this.listCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON = listCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON;
    }

    public String getListCustomerPurchaseOrderToBlanketOrderPaymentTermJSON() {
        return listCustomerPurchaseOrderToBlanketOrderPaymentTermJSON;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderPaymentTermJSON(String listCustomerPurchaseOrderToBlanketOrderPaymentTermJSON) {
        this.listCustomerPurchaseOrderToBlanketOrderPaymentTermJSON = listCustomerPurchaseOrderToBlanketOrderPaymentTermJSON;
    }

    public String getListCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON() {
        return listCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON;
    }

    public void setListCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON(String listCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON) {
        this.listCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON = listCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON;
    }

    public ArrayList getArrSalesQuotationNo() {
        return arrSalesQuotationNo;
    }

    public void setArrSalesQuotationNo(ArrayList arrSalesQuotationNo) {
        this.arrSalesQuotationNo = arrSalesQuotationNo;
    }

    public Date getCustomerPurchaseOrderToBlanketOrderSearchFirstDate() {
        return customerPurchaseOrderToBlanketOrderSearchFirstDate;
    }

    public void setCustomerPurchaseOrderToBlanketOrderSearchFirstDate(Date customerPurchaseOrderToBlanketOrderSearchFirstDate) {
        this.customerPurchaseOrderToBlanketOrderSearchFirstDate = customerPurchaseOrderToBlanketOrderSearchFirstDate;
    }

    public Date getCustomerPurchaseOrderToBlanketOrderSearchLastDate() {
        return customerPurchaseOrderToBlanketOrderSearchLastDate;
    }

    public void setCustomerPurchaseOrderToBlanketOrderSearchLastDate(Date customerPurchaseOrderToBlanketOrderSearchLastDate) {
        this.customerPurchaseOrderToBlanketOrderSearchLastDate = customerPurchaseOrderToBlanketOrderSearchLastDate;
    }

    public ArrayList getArrSalesQuotationCode() {
        return arrSalesQuotationCode;
    }

    public void setArrSalesQuotationCode(ArrayList arrSalesQuotationCode) {
        this.arrSalesQuotationCode = arrSalesQuotationCode;
    }

    public CustomerBlanketOrder getBlanketOrder() {
        return blanketOrder;
    }

    public void setBlanketOrder(CustomerBlanketOrder blanketOrder) {
        this.blanketOrder = blanketOrder;
    }

    public String getCustomerPurchaseOrderToBlanketOrderSearchValidStatus() {
        return customerPurchaseOrderToBlanketOrderSearchValidStatus;
    }

    public void setCustomerPurchaseOrderToBlanketOrderSearchValidStatus(String customerPurchaseOrderToBlanketOrderSearchValidStatus) {
        this.customerPurchaseOrderToBlanketOrderSearchValidStatus = customerPurchaseOrderToBlanketOrderSearchValidStatus;
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
