
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
import com.inkombizz.sales.bll.CustomerBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.sales.model.CustomerBlanketOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDetail;
import com.inkombizz.sales.model.CustomerBlanketOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerBlanketOrderSalesQuotation;
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
public class CustomerBlanketOrderJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private EnumActivity.ENUM_Activity enumBlanketOrderActivity;
    
    private CustomerBlanketOrder blanketOrder=new CustomerBlanketOrder();
    private CustomerBlanketOrder blanketOrderClosing=new CustomerBlanketOrder();
    private List<CustomerBlanketOrder> listCustomerBlanketOrder;
    private List<CustomerBlanketOrderSalesQuotation> listCustomerBlanketOrderSalesQuotation;
    private List<CustomerBlanketOrderSalesQuotation> listCustomerPurchaseOrderReleaseSalesQuotation;
    private List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail;
    private List<CustomerBlanketOrderAdditionalFee> listCustomerBlanketOrderAdditionalFee;
    private List<CustomerBlanketOrderPaymentTerm> listCustomerBlanketOrderPaymentTerm;
    private List<CustomerBlanketOrderItemDeliveryDate> listCustomerBlanketOrderItemDeliveryDate;
    
    private String listCustomerBlanketOrderSalesQuotationJSON;
    private String listCustomerBlanketOrderItemDetailJSON;
    private String listCustomerBlanketOrderAdditionalFeeJSON;
    private String listCustomerBlanketOrderPaymentTermJSON;
    private String listCustomerBlanketOrderItemDeliveryJSON;
        
    private Date blanketOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
    private Date blanketOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);
    
    private ArrayList arrSalesQuotationBoNo;
    private String headerCode="";
    
    private String blanketOrderSearchValidStatus="TRUE";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("blanket-order-data")
    public String findData() {
        try {
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            
            ListPaging <CustomerBlanketOrder> listPaging = blanketOrderBLL.findData(paging,blanketOrder,blanketOrderSearchValidStatus);
            
            listCustomerBlanketOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("blanket-order-search-data")
    public String findSearchData() {
        try {
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            
            ListPaging <CustomerBlanketOrder> listPaging = blanketOrderBLL.findSearchData(paging, blanketOrder, blanketOrderSearchFirstDate, blanketOrderSearchLastDate);
            
            listCustomerBlanketOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("blanket-order-closing-data")
    public String findDataClosing() {
        try {
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            
            ListPaging <CustomerBlanketOrder> listPaging = blanketOrderBLL.findDataClosing(paging,blanketOrderClosing);
            
            listCustomerBlanketOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-sales-quotation-data")
    public String findDataSalesQuotation(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderSalesQuotation> list = blanketOrderBLL.findDataSalesQuotation(blanketOrder.getCode());
            
            listCustomerBlanketOrderSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-sales-quotation-data-release")
    public String findDataSalesQuotationRelease(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderSalesQuotation> list = blanketOrderBLL.findDataSalesQuotation(blanketOrder.getCode());
            
            listCustomerPurchaseOrderReleaseSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    //buat load detail untuk beberapa nomer Sales Quotation
    //digunakan di modul CustomerBlanketOrder: Syncronisasi Data Item Detail
    @Action("blanket-order-item-detail-sync-data")
    public String findDataSyncItemDetail(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderItemDetail> list = blanketOrderBLL.findDataSyncItemDetail(arrSalesQuotationBoNo,blanketOrder);
            
            listCustomerBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderItemDetail> list = blanketOrderBLL.findDataItemDetail(blanketOrder.getCode());
            
            listCustomerBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-item-detail-data-array-data")
    public String findDataItemDetailArray(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderItemDetail> list = blanketOrderBLL.findDataItemDetailArray(arrSalesQuotationBoNo,blanketOrder.getCode());
            
            listCustomerBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-additional-fee-data")
    public String findDataAdditionalFee(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderAdditionalFee> list = blanketOrderBLL.findDataAdditionalFee(blanketOrder.getCode());
            
            listCustomerBlanketOrderAdditionalFee = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-payment-term-data")
    public String findDataPaymentTerm(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderPaymentTerm> list = blanketOrderBLL.findDataPaymentTerm(blanketOrder.getCode());
            
            listCustomerBlanketOrderPaymentTerm = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-item-delivery-data")
    public String findDataItemDeliveryDate(){
        try {
            
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderItemDeliveryDate> list = blanketOrderBLL.findDataItemDeliveryDate(blanketOrder.getCode());
            
            listCustomerBlanketOrderItemDeliveryDate = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("blanket-order-get-additional-fee-amount")
    public String totalAdditionalFeeAmount() {
        try {
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            this.blanketOrder = blanketOrderBLL.totalAdditionalFeeAmount(this.blanketOrder.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    //sukha ini di pakai di ppo
    @Action("customer-blanket-order-search-item-for-production-planning-order")
    public String findDataforProductionPlanning(){
        try {
            
            CustomerBlanketOrderBLL customerBlanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            List<CustomerBlanketOrderItemDetail> list = customerBlanketOrderBLL.findDataforProductionPlanning(headerCode);
            
            listCustomerBlanketOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            Gson qson = new Gson();
            Gson ison = new Gson();
            Gson fson = new Gson();
            Gson pson = new Gson();
            Gson dson = new Gson();
            dson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            this.listCustomerBlanketOrderSalesQuotation = qson.fromJson(this.listCustomerBlanketOrderSalesQuotationJSON, new TypeToken<List<CustomerBlanketOrderSalesQuotation>>(){}.getType());
            this.listCustomerBlanketOrderItemDetail = ison.fromJson(this.listCustomerBlanketOrderItemDetailJSON, new TypeToken<List<CustomerBlanketOrderItemDetail>>(){}.getType());
            this.listCustomerBlanketOrderAdditionalFee = fson.fromJson(this.listCustomerBlanketOrderAdditionalFeeJSON, new TypeToken<List<CustomerBlanketOrderAdditionalFee>>(){}.getType());
            this.listCustomerBlanketOrderPaymentTerm = pson.fromJson(this.listCustomerBlanketOrderPaymentTermJSON, new TypeToken<List<CustomerBlanketOrderPaymentTerm>>(){}.getType());
            this.listCustomerBlanketOrderItemDeliveryDate = dson.fromJson(this.listCustomerBlanketOrderItemDeliveryJSON, new TypeToken<List<CustomerBlanketOrderItemDeliveryDate>>(){}.getType());
            
            blanketOrder.setTransactionDate(DateUtils.newDateTime(blanketOrder.getTransactionDate(),true));
            
            Date createdDate = sdf.parse(blanketOrder.getCreatedDateTemp());
            Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
            blanketOrder.setCreatedDate(createdDatetime);
            
//            if(blanketOrderBLL.isExist(this.blanketOrder.getCode())){
//                               
//                if(enumBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
//                    _Messg="UPDATE ";
//                    blanketOrderBLL.update(blanketOrder, listCustomerBlanketOrderSalesQuotation,listCustomerBlanketOrderItemDetail,
//                        listCustomerBlanketOrderAdditionalFee,listCustomerBlanketOrderPaymentTerm,listCustomerBlanketOrderItemDeliveryDate);
//                }
//                
//                if(enumBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
//                    _Messg = "REVISE";
//                   
//                }
//                
//            }else{
//                
//                if(enumBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
//                    _Messg = "CLONE";
//                }
//                
//                if(enumBlanketOrderActivity.equals(EnumActivity.ENUM_Activity.NEW)){
//                    _Messg = "SAVE";
//                }
//                
//                blanketOrderBLL.save(enumBlanketOrderActivity,blanketOrder, listCustomerBlanketOrderSalesQuotation,listCustomerBlanketOrderItemDetail,
//                        listCustomerBlanketOrderAdditionalFee,listCustomerBlanketOrderPaymentTerm,listCustomerBlanketOrderItemDeliveryDate);
//                 
//            }
                if(blanketOrderBLL.isExist(this.blanketOrder.getCode())){
                   throw new Exception("Code "+this.blanketOrder.getCode()+" has been existing in Database!");
                }else{blanketOrderBLL.revise(blanketOrder, listCustomerBlanketOrderSalesQuotation,listCustomerBlanketOrderItemDetail,
                    listCustomerBlanketOrderAdditionalFee,listCustomerBlanketOrderPaymentTerm,listCustomerBlanketOrderItemDeliveryDate);
                }
            
            this.message = _Messg + " DATA SUCCESS.<br/>BOD No : " + this.blanketOrder.getCustBONo();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-delete")
    public String delete(){
        String _messg = "";
        try{
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(blanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
              
                
            blanketOrderBLL.delete(blanketOrder);
            
            this.message = _messg + "DATA SUCCESS.<br/> BOD No : " + this.blanketOrder.getCustBONo();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED. <br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("blanket-order-closing-save")
    public String saveClosing(){
        try {
                        
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            
            blanketOrderBLL.closing(blanketOrderClosing);
            
            this.message = "PROCESS DATA SUCCESS.<br/>BOD No : " + this.blanketOrderClosing.getCustBONo();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "PROCESS DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public EnumActivity.ENUM_Activity getEnumBlanketOrderActivity() {
        return enumBlanketOrderActivity;
    }

    public void setEnumBlanketOrderActivity(EnumActivity.ENUM_Activity enumBlanketOrderActivity) {
        this.enumBlanketOrderActivity = enumBlanketOrderActivity;
    }

    public CustomerBlanketOrder getBlanketOrder() {
        return blanketOrder;
    }

    public void setBlanketOrder(CustomerBlanketOrder blanketOrder) {
        this.blanketOrder = blanketOrder;
    }

    public CustomerBlanketOrder getBlanketOrderClosing() {
        return blanketOrderClosing;
    }

    public void setBlanketOrderClosing(CustomerBlanketOrder blanketOrderClosing) {
        this.blanketOrderClosing = blanketOrderClosing;
    }

    public Date getBlanketOrderSearchFirstDate() {
        return blanketOrderSearchFirstDate;
    }

    public void setBlanketOrderSearchFirstDate(Date blanketOrderSearchFirstDate) {
        this.blanketOrderSearchFirstDate = blanketOrderSearchFirstDate;
    }

    public Date getBlanketOrderSearchLastDate() {
        return blanketOrderSearchLastDate;
    }

    public void setBlanketOrderSearchLastDate(Date blanketOrderSearchLastDate) {
        this.blanketOrderSearchLastDate = blanketOrderSearchLastDate;
    }
        
    public List<CustomerBlanketOrder> getListCustomerBlanketOrder() {
        return listCustomerBlanketOrder;
    }

    public void setListCustomerBlanketOrder(List<CustomerBlanketOrder> listCustomerBlanketOrder) {
        this.listCustomerBlanketOrder = listCustomerBlanketOrder;
    }

    public List<CustomerBlanketOrderSalesQuotation> getListCustomerBlanketOrderSalesQuotation() {
        return listCustomerBlanketOrderSalesQuotation;
    }

    public void setListCustomerBlanketOrderSalesQuotation(List<CustomerBlanketOrderSalesQuotation> listCustomerBlanketOrderSalesQuotation) {
        this.listCustomerBlanketOrderSalesQuotation = listCustomerBlanketOrderSalesQuotation;
    }

    public List<CustomerBlanketOrderItemDetail> getListCustomerBlanketOrderItemDetail() {
        return listCustomerBlanketOrderItemDetail;
    }

    public void setListCustomerBlanketOrderItemDetail(List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail) {
        this.listCustomerBlanketOrderItemDetail = listCustomerBlanketOrderItemDetail;
    }

    public List<CustomerBlanketOrderAdditionalFee> getListCustomerBlanketOrderAdditionalFee() {
        return listCustomerBlanketOrderAdditionalFee;
    }

    public void setListCustomerBlanketOrderAdditionalFee(List<CustomerBlanketOrderAdditionalFee> listCustomerBlanketOrderAdditionalFee) {
        this.listCustomerBlanketOrderAdditionalFee = listCustomerBlanketOrderAdditionalFee;
    }

    public List<CustomerBlanketOrderPaymentTerm> getListCustomerBlanketOrderPaymentTerm() {
        return listCustomerBlanketOrderPaymentTerm;
    }

    public void setListCustomerBlanketOrderPaymentTerm(List<CustomerBlanketOrderPaymentTerm> listCustomerBlanketOrderPaymentTerm) {
        this.listCustomerBlanketOrderPaymentTerm = listCustomerBlanketOrderPaymentTerm;
    }

    public List<CustomerBlanketOrderItemDeliveryDate> getListCustomerBlanketOrderItemDeliveryDate() {
        return listCustomerBlanketOrderItemDeliveryDate;
    }

    public void setListCustomerBlanketOrderItemDeliveryDate(List<CustomerBlanketOrderItemDeliveryDate> listCustomerBlanketOrderItemDeliveryDate) {
        this.listCustomerBlanketOrderItemDeliveryDate = listCustomerBlanketOrderItemDeliveryDate;
    }

    public String getListCustomerBlanketOrderSalesQuotationJSON() {
        return listCustomerBlanketOrderSalesQuotationJSON;
    }

    public void setListCustomerBlanketOrderSalesQuotationJSON(String listCustomerBlanketOrderSalesQuotationJSON) {
        this.listCustomerBlanketOrderSalesQuotationJSON = listCustomerBlanketOrderSalesQuotationJSON;
    }

    public String getListCustomerBlanketOrderItemDetailJSON() {
        return listCustomerBlanketOrderItemDetailJSON;
    }

    public void setListCustomerBlanketOrderItemDetailJSON(String listCustomerBlanketOrderItemDetailJSON) {
        this.listCustomerBlanketOrderItemDetailJSON = listCustomerBlanketOrderItemDetailJSON;
    }

    public String getListCustomerBlanketOrderAdditionalFeeJSON() {
        return listCustomerBlanketOrderAdditionalFeeJSON;
    }

    public void setListCustomerBlanketOrderAdditionalFeeJSON(String listCustomerBlanketOrderAdditionalFeeJSON) {
        this.listCustomerBlanketOrderAdditionalFeeJSON = listCustomerBlanketOrderAdditionalFeeJSON;
    }

    public String getListCustomerBlanketOrderPaymentTermJSON() {
        return listCustomerBlanketOrderPaymentTermJSON;
    }

    public void setListCustomerBlanketOrderPaymentTermJSON(String listCustomerBlanketOrderPaymentTermJSON) {
        this.listCustomerBlanketOrderPaymentTermJSON = listCustomerBlanketOrderPaymentTermJSON;
    }

    public String getListCustomerBlanketOrderItemDeliveryJSON() {
        return listCustomerBlanketOrderItemDeliveryJSON;
    }

    public void setListCustomerBlanketOrderItemDeliveryJSON(String listCustomerBlanketOrderItemDeliveryJSON) {
        this.listCustomerBlanketOrderItemDeliveryJSON = listCustomerBlanketOrderItemDeliveryJSON;
    }

    public Date getCustomerBlanketOrderSearchFirstDate() {
        return blanketOrderSearchFirstDate;
    }

    public void setCustomerBlanketOrderSearchFirstDate(Date blanketOrderSearchFirstDate) {
        this.blanketOrderSearchFirstDate = blanketOrderSearchFirstDate;
    }

    public Date getCustomerBlanketOrderSearchLastDate() {
        return blanketOrderSearchLastDate;
    }

    public void setCustomerBlanketOrderSearchLastDate(Date blanketOrderSearchLastDate) {
        this.blanketOrderSearchLastDate = blanketOrderSearchLastDate;
    }

    public ArrayList getArrSalesQuotationBoNo() {
        return arrSalesQuotationBoNo;
    }

    public void setArrSalesQuotationBoNo(ArrayList arrSalesQuotationBoNo) {
        this.arrSalesQuotationBoNo = arrSalesQuotationBoNo;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public List<CustomerBlanketOrderSalesQuotation> getListCustomerPurchaseOrderReleaseSalesQuotation() {
        return listCustomerPurchaseOrderReleaseSalesQuotation;
    }

    public void setListCustomerPurchaseOrderReleaseSalesQuotation(List<CustomerBlanketOrderSalesQuotation> listCustomerPurchaseOrderReleaseSalesQuotation) {
        this.listCustomerPurchaseOrderReleaseSalesQuotation = listCustomerPurchaseOrderReleaseSalesQuotation;
    }

    public String getBlanketOrderSearchValidStatus() {
        return blanketOrderSearchValidStatus;
    }

    public void setBlanketOrderSearchValidStatus(String blanketOrderSearchValidStatus) {
        this.blanketOrderSearchValidStatus = blanketOrderSearchValidStatus;
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
