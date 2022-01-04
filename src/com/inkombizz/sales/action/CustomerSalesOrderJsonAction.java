
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
import com.inkombizz.sales.bll.CustomerSalesOrderBLL;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetail;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotation;
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
public class CustomerSalesOrderJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private EnumActivity.ENUM_Activity enumSalesOrderActivity;
    
    private CustomerSalesOrder salesOrder=new CustomerSalesOrder();
    private CustomerSalesOrder salesOrderClosing=new CustomerSalesOrder();
    private CustomerSalesOrder salesOrderUnprice=new CustomerSalesOrder();
    private List<CustomerSalesOrder> listCustomerSalesOrder;
    private List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation;
    private List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail;
    private List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee;
    private List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm;
    private List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate;
    
    private String listCustomerSalesOrderSalesQuotationJSON;
    private String listCustomerSalesOrderItemDetailJSON;
    private String listCustomerSalesOrderAdditionalFeeJSON;
    private String listCustomerSalesOrderPaymentTermJSON;
    private String listCustomerSalesOrderItemDeliveryJSON;
        
    private Date salesOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date salesOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private ArrayList arrSalesQuotationSoNo;
    private String headerCode="";
    private String documentType="";
    private String code = "";
    
    private String salesOrderSearchValidStatus = "TRUE";
    private String salesOrderUnpriceSearchValidStatus = "TRUE";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }  
    
    @Action("customer-sales-order-data")
    public String findData() {
        try {
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            
            ListPaging <CustomerSalesOrder> listPaging = salesOrderBLL.findData(paging,salesOrder,salesOrderSearchValidStatus);
            
            listCustomerSalesOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("customer-sales-order-search-data")
    public String findSearchData() {
        try {
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            
            ListPaging <CustomerSalesOrder> listPaging = salesOrderBLL.findSearchData(paging,salesOrder, salesOrderSearchFirstDate, salesOrderSearchLastDate);
            
            listCustomerSalesOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("customer-sales-order-search-data-lad")
    public String findSearchDataLAD() {
        try {
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            
            ListPaging <CustomerSalesOrder> listPaging = salesOrderBLL.findSearchDataLAD(paging,salesOrder, salesOrderSearchFirstDate, salesOrderSearchLastDate);
            
            listCustomerSalesOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-closing-data")
    public String findDataClosing() {
        try {
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            
            ListPaging <CustomerSalesOrder> listPaging = salesOrderBLL.findDataClosing(paging,salesOrderClosing);
            
            listCustomerSalesOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-unprice-data")
    public String findDataUnprice() {
        try {
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            
            ListPaging <CustomerSalesOrder> listPaging = salesOrderBLL.findDataUnprice(paging,salesOrderUnprice,salesOrderUnpriceSearchValidStatus);
            
            listCustomerSalesOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-sales-quotation-data")
    public String findDataSalesQuotation(){
        try {
            
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            List<CustomerSalesOrderSalesQuotation> list = salesOrderBLL.findDataSalesQuotation(salesOrder.getCode());
            
            listCustomerSalesOrderSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
//    //buat load detail untuk beberapa nomer Sales Quotation
//    //digunakan di modul CustomerSalesOrder: Syncronisasi Data Item Detail
//    @Action("customer-sales-order-item-detail-sync-data")
//    public String findDataSyncItemDetail(){
//        try {
//            
//            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
//            List<CustomerSalesOrderItemDetail> list = salesOrderBLL.findDataSyncItemDetail(arrSalesQuotationSoNo,salesOrder);
//            
//            listCustomerSalesOrderItemDetail = list;
//            return SUCCESS;
//        } catch (Exception e) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("customer-sales-order-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            List<CustomerSalesOrderItemDetail> list = salesOrderBLL.findDataItemDetail(salesOrder.getCode());
            
            listCustomerSalesOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-item-detail-data-array-data")
    public String findDataItemDetailArray(){
        try {
            
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            List<CustomerSalesOrderItemDetail> list = salesOrderBLL.findDataItemDetailArray(arrSalesQuotationSoNo,salesOrder.getCode());
            
            listCustomerSalesOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-additional-fee-data")
    public String findDataAdditionalFee(){
        try {
            
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            List<CustomerSalesOrderAdditionalFee> list = salesOrderBLL.findDataAdditionalFee(salesOrder.getCode());
            
            listCustomerSalesOrderAdditionalFee = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-payment-term-data")
    public String findDataPaymentTerm(){
        try {
            
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            List<CustomerSalesOrderPaymentTerm> list = salesOrderBLL.findDataPaymentTerm(salesOrder.getCode());
            
            listCustomerSalesOrderPaymentTerm = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-item-delivery-data")
    public String findDataItemDeliveryDate(){
        try {
            
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            List<CustomerSalesOrderItemDeliveryDate> list = salesOrderBLL.findDataItemDeliveryDate(salesOrder.getCode());
            
            listCustomerSalesOrderItemDeliveryDate = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("customer-sales-order-get-additional-fee-amount")
    public String totalAdditionalFeeAmount() {
        try {
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            this.salesOrder = salesOrderBLL.totalAdditionalFeeAmount(this.salesOrder.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    //sukha ini di pakai di ppo
    @Action("customer-sales-order-search-item-for-production-planning-order")
    public String findDataforProductionPlanning(){
        try {
            
            CustomerSalesOrderBLL customerSalesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            ListPaging<CustomerSalesOrderItemDetail> listPaging = customerSalesOrderBLL.findDataforProductionPlanning(paging,code,headerCode,documentType);
            
            listCustomerSalesOrderItemDetail = listPaging.getList();
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-save")
    public String save(){
        String _Messg = "";
        try {
                        
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            Gson qson = new Gson();
            Gson ison = new Gson();
            Gson fson = new Gson();
            Gson pson = new Gson();
            Gson dson = new Gson();
            dson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            this.listCustomerSalesOrderSalesQuotation = qson.fromJson(this.listCustomerSalesOrderSalesQuotationJSON, new TypeToken<List<CustomerSalesOrderSalesQuotation>>(){}.getType());
            this.listCustomerSalesOrderItemDetail = ison.fromJson(this.listCustomerSalesOrderItemDetailJSON, new TypeToken<List<CustomerSalesOrderItemDetail>>(){}.getType());
            this.listCustomerSalesOrderAdditionalFee = fson.fromJson(this.listCustomerSalesOrderAdditionalFeeJSON, new TypeToken<List<CustomerSalesOrderAdditionalFee>>(){}.getType());
            this.listCustomerSalesOrderPaymentTerm = pson.fromJson(this.listCustomerSalesOrderPaymentTermJSON, new TypeToken<List<CustomerSalesOrderPaymentTerm>>(){}.getType());
            this.listCustomerSalesOrderItemDeliveryDate = dson.fromJson(this.listCustomerSalesOrderItemDeliveryJSON, new TypeToken<List<CustomerSalesOrderItemDeliveryDate>>(){}.getType());
            
            salesOrder.setTransactionDate(DateUtils.newDateTime(salesOrder.getTransactionDate(),true));
            
            Date createdDate = sdf.parse(salesOrder.getCreatedDateTemp());
            Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
            salesOrder.setCreatedDate(createdDatetime);
            
//            if(salesOrderBLL.isExist(this.salesOrder.getCode())){
//                               
//                if(enumSalesOrderActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
//                    _Messg="UPDATE ";
//                    salesOrderBLL.update(salesOrder, listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,
//                        listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate);
//                }
//                
//                if(enumSalesOrderActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
//                    _Messg = "REVISE";
//                    
//                }
//                
//            }else{
//                
//                if(enumSalesOrderActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
//                    _Messg = "CLONE";
//                }
//                
//                if(enumSalesOrderActivity.equals(EnumActivity.ENUM_Activity.NEW)){
//                    _Messg = "SAVE";
//                }
//                
//                salesOrderBLL.save(enumSalesOrderActivity,salesOrder, listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,
//                        listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate);
//                 
//            }
                if(salesOrderBLL.isExist(this.salesOrder.getCode())){
                   throw new Exception("Code "+this.salesOrder.getCode()+" has been existing in Database!");
                }else{
                    salesOrderBLL.revise(salesOrder, listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,
                    listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate);
                }
            this.message = _Messg + " DATA SUCCESS.<br/>SOD No : " + this.salesOrder.getCustSONo();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-delete")
    public String delete(){
        String _messg = "";
        try{
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(salesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
              
                
            salesOrderBLL.delete(salesOrder);
            
            this.message = _messg + "DATA SUCCESS.<br/> SOD No : " + this.salesOrder.getCustSONo();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED. <br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-sales-order-closing-save")
    public String saveClosing(){
        try {
                        
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            
            salesOrderBLL.closing(salesOrderClosing);
            
            this.message = "PROCESS DATA SUCCESS.<br/>SOD No : " + this.salesOrderClosing.getCustSONo();

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

    public EnumActivity.ENUM_Activity getEnumSalesOrderActivity() {
        return enumSalesOrderActivity;
    }

    public void setEnumSalesOrderActivity(EnumActivity.ENUM_Activity enumSalesOrderActivity) {
        this.enumSalesOrderActivity = enumSalesOrderActivity;
    }
    
    public CustomerSalesOrder getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(CustomerSalesOrder salesOrder) {
        this.salesOrder = salesOrder;
    }

    public CustomerSalesOrder getSalesOrderClosing() {
        return salesOrderClosing;
    }

    public void setSalesOrderClosing(CustomerSalesOrder salesOrderClosing) {
        this.salesOrderClosing = salesOrderClosing;
    }

    public List<CustomerSalesOrder> getListCustomerSalesOrder() {
        return listCustomerSalesOrder;
    }

    public void setListCustomerSalesOrder(List<CustomerSalesOrder> listCustomerSalesOrder) {
        this.listCustomerSalesOrder = listCustomerSalesOrder;
    }

    public List<CustomerSalesOrderSalesQuotation> getListCustomerSalesOrderSalesQuotation() {
        return listCustomerSalesOrderSalesQuotation;
    }

    public void setListCustomerSalesOrderSalesQuotation(List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation) {
        this.listCustomerSalesOrderSalesQuotation = listCustomerSalesOrderSalesQuotation;
    }

    public List<CustomerSalesOrderItemDetail> getListCustomerSalesOrderItemDetail() {
        return listCustomerSalesOrderItemDetail;
    }

    public void setListCustomerSalesOrderItemDetail(List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail) {
        this.listCustomerSalesOrderItemDetail = listCustomerSalesOrderItemDetail;
    }

    public List<CustomerSalesOrderAdditionalFee> getListCustomerSalesOrderAdditionalFee() {
        return listCustomerSalesOrderAdditionalFee;
    }

    public void setListCustomerSalesOrderAdditionalFee(List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee) {
        this.listCustomerSalesOrderAdditionalFee = listCustomerSalesOrderAdditionalFee;
    }

    public List<CustomerSalesOrderPaymentTerm> getListCustomerSalesOrderPaymentTerm() {
        return listCustomerSalesOrderPaymentTerm;
    }

    public void setListCustomerSalesOrderPaymentTerm(List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm) {
        this.listCustomerSalesOrderPaymentTerm = listCustomerSalesOrderPaymentTerm;
    }

    public List<CustomerSalesOrderItemDeliveryDate> getListCustomerSalesOrderItemDeliveryDate() {
        return listCustomerSalesOrderItemDeliveryDate;
    }

    public void setListCustomerSalesOrderItemDeliveryDate(List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate) {
        this.listCustomerSalesOrderItemDeliveryDate = listCustomerSalesOrderItemDeliveryDate;
    }

    public String getListCustomerSalesOrderSalesQuotationJSON() {
        return listCustomerSalesOrderSalesQuotationJSON;
    }

    public void setListCustomerSalesOrderSalesQuotationJSON(String listCustomerSalesOrderSalesQuotationJSON) {
        this.listCustomerSalesOrderSalesQuotationJSON = listCustomerSalesOrderSalesQuotationJSON;
    }

    public String getListCustomerSalesOrderItemDetailJSON() {
        return listCustomerSalesOrderItemDetailJSON;
    }

    public void setListCustomerSalesOrderItemDetailJSON(String listCustomerSalesOrderItemDetailJSON) {
        this.listCustomerSalesOrderItemDetailJSON = listCustomerSalesOrderItemDetailJSON;
    }

    public String getListCustomerSalesOrderAdditionalFeeJSON() {
        return listCustomerSalesOrderAdditionalFeeJSON;
    }

    public void setListCustomerSalesOrderAdditionalFeeJSON(String listCustomerSalesOrderAdditionalFeeJSON) {
        this.listCustomerSalesOrderAdditionalFeeJSON = listCustomerSalesOrderAdditionalFeeJSON;
    }

    public String getListCustomerSalesOrderPaymentTermJSON() {
        return listCustomerSalesOrderPaymentTermJSON;
    }

    public void setListCustomerSalesOrderPaymentTermJSON(String listCustomerSalesOrderPaymentTermJSON) {
        this.listCustomerSalesOrderPaymentTermJSON = listCustomerSalesOrderPaymentTermJSON;
    }

    public String getListCustomerSalesOrderItemDeliveryJSON() {
        return listCustomerSalesOrderItemDeliveryJSON;
    }

    public void setListCustomerSalesOrderItemDeliveryJSON(String listCustomerSalesOrderItemDeliveryJSON) {
        this.listCustomerSalesOrderItemDeliveryJSON = listCustomerSalesOrderItemDeliveryJSON;
    }

    public Date getSalesOrderSearchFirstDate() {
        return salesOrderSearchFirstDate;
    }

    public void setSalesOrderSearchFirstDate(Date salesOrderSearchFirstDate) {
        this.salesOrderSearchFirstDate = salesOrderSearchFirstDate;
    }

    public Date getSalesOrderSearchLastDate() {
        return salesOrderSearchLastDate;
    }

    public void setSalesOrderSearchLastDate(Date salesOrderSearchLastDate) {
        this.salesOrderSearchLastDate = salesOrderSearchLastDate;
    }

    public ArrayList getArrSalesQuotationSoNo() {
        return arrSalesQuotationSoNo;
    }

    public void setArrSalesQuotationSoNo(ArrayList arrSalesQuotationSoNo) {
        this.arrSalesQuotationSoNo = arrSalesQuotationSoNo;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public CustomerSalesOrder getSalesOrderUnprice() {
        return salesOrderUnprice;
    }

    public void setSalesOrderUnprice(CustomerSalesOrder salesOrderUnprice) {
        this.salesOrderUnprice = salesOrderUnprice;
    }

    public String getSalesOrderSearchValidStatus() {
        return salesOrderSearchValidStatus;
    }

    public void setSalesOrderSearchValidStatus(String salesOrderSearchValidStatus) {
        this.salesOrderSearchValidStatus = salesOrderSearchValidStatus;
    }

    public String getSalesOrderUnpriceSearchValidStatus() {
        return salesOrderUnpriceSearchValidStatus;
    }

    public void setSalesOrderUnpriceSearchValidStatus(String salesOrderUnpriceSearchValidStatus) {
        this.salesOrderUnpriceSearchValidStatus = salesOrderUnpriceSearchValidStatus;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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
