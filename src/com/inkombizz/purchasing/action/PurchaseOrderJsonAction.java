
package com.inkombizz.purchasing.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseOrderBLL;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.inkombizz.purchasing.model.PurchaseOrderAdditionalFee;
import com.inkombizz.purchasing.model.PurchaseOrderDetail;
import com.inkombizz.purchasing.model.PurchaseOrderItemDeliveryDate;
import com.inkombizz.purchasing.model.PurchaseOrderPurchaseRequest;
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


@Result (type="json")
public class PurchaseOrderJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private EnumActivity.ENUM_Activity enumPurchaseOrderActivity;
    private PurchaseOrder purchaseOrder = new PurchaseOrder();
    private PurchaseOrder purchaseOrderApproval = new PurchaseOrder();
    private PurchaseOrder purchaseOrderClosing = new PurchaseOrder();
    private PurchaseOrder purchaseOrderUpdateInformation = new PurchaseOrder();
    private List<PurchaseOrder> listPurchaseOrder; 
    private List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequestDetail; 
    private List<PurchaseOrderDetail> listPurchaseOrderDetail; 
    private List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee; 
    private List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate; 
            
    private String listPurchaseOrderPurchaseRequestDetailJSON="";
    private String listPurchaseOrderSubItemJSON="";
    private String listPurchaseOrderDetailJSON="";
    private String listPurchaseOrderAdditionalFeeJSON="";
    private String listPurchaseOrderItemDeliveryDateJSON="";
    
    private List<PurchaseOrderDetail> listPurchaseOrderUpdateInformationDetailView; 
    private List<PurchaseOrderDetail> listPurchaseOrderUpdateInformationDetailInput; 
    private List<PurchaseOrderItemDeliveryDate> listPurchaseOrderUpdateInformationItemDeliveryDate; 
    
    private String listPurchaseOrderUpdateInformationDetailViewJSON="";
    private String listPurchaseOrderUpdateInformationDetailInputJSON="";
    private String listPurchaseOrderUpdateInformationItemDeliveryDateJSON="";
    
    private String purchaseOrderSearchCode = "";
    private String purchaseOrderSearchName = "";
    private String purchaseOrderSearchRefNo = "";
    private String purchaseOrderSearchRemark = "";
    private String purchaseOrderVendorSearchCode="";
    private String purchaseOrderVendorSearchName="";
    private String purchaseOrderClosedSearchStatus="OPEN";
    private Date purchaseOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date purchaseOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String enumPrm = null;
    private String prHeader = "";
    private String prDetail = "";
    
    private ArrayList arrayCode;
    private ArrayList arrayCodeDetail = new ArrayList();
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-data")
    public String findData() {
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            ListPaging <PurchaseOrder> listPaging = purchaseOrderBLL.findData(paging,purchaseOrder);
            
            listPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-approval-data")
    public String findDataApproval() {
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            ListPaging <PurchaseOrder> listPaging = purchaseOrderBLL.findDataApproval(paging,purchaseOrderApproval);
            
            listPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-update-information-data")
    public String findDataUpdateInformation() {
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            ListPaging <PurchaseOrder> listPaging = purchaseOrderBLL.findDataUpdateInformation(paging,purchaseOrderApproval);
            
            listPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-closing-data")
    public String findDataClosing() {
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            ListPaging <PurchaseOrder> listPaging = purchaseOrderBLL.findDataApproval(paging,purchaseOrderClosing);
            
            listPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-purchase-request-data")
    public String findDataPurchaseRequest(){
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            List<PurchaseOrderPurchaseRequest> list = purchaseOrderBLL.findDataPurchaseRequest(purchaseOrder.getCode());
            
            listPurchaseOrderPurchaseRequestDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("purchase-order-sub-item-data")
//    public String findDataPurchaseOrderSubItem(){
//        try {
//            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
//            List<PurchaseOrderSubItem> list = purchaseOrderBLL.findDataPurchaseOrderSubItem(purchaseOrder.getCode());
//            
//            listPurchaseOrderSubItem = list;
//            return SUCCESS;
//        } catch (Exception e) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("purchase-order-detail-data")
    public String findDataPurchaseOrder(){
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            List<PurchaseOrderDetail> list = purchaseOrderBLL.findDataPurchaseOrderDetail(purchaseOrder.getCode());
            
            listPurchaseOrderDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-detail-by-grn-data")
    public String findDataPurchaseOrderGrn(){
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            List<PurchaseOrderDetail> list = purchaseOrderBLL.findDataPurchaseOrderDetailGrn(purchaseOrder.getCode());
            
            listPurchaseOrderDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-additional-fee-data")
    public String findDataPurchaseOrderAdditionalFee(){
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            List<PurchaseOrderAdditionalFee> list = purchaseOrderBLL.findDataPurchaseOrderAdditionalFee(purchaseOrder.getCode());
            
            listPurchaseOrderAdditionalFee = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-item-delivery-date-data")
    public String findDataItemDeliveryDate(){
        try {
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            List<PurchaseOrderItemDeliveryDate> list = purchaseOrderBLL.findDataItemDeliveryDate(purchaseOrder.getCode());
            
            listPurchaseOrderItemDeliveryDate = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-search-data") 
    public String findataSearch(){
        try{
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);            

            ListPaging<PurchaseOrder> listPaging = purchaseOrderBLL.findataSearch(paging,purchaseOrderSearchCode,purchaseOrderVendorSearchCode,purchaseOrderVendorSearchName,purchaseOrderSearchFirstDate,purchaseOrderSearchLastDate);
            
            listPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-search-by-vendor-invoice-data")
    public String searchByVendorInvoicedata(){
        try{
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);            

            ListPaging<PurchaseOrder> listPaging = purchaseOrderBLL.searchByVendorInvoiceData(paging,purchaseOrderSearchFirstDate,purchaseOrderSearchLastDate,purchaseOrderSearchCode,purchaseOrderVendorSearchCode,purchaseOrderVendorSearchName);
            
            listPurchaseOrder = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-save")
    public String save() {
        String _messg = "";
        try {
            
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            Gson gson = new Gson();
            Gson bson = new Gson();
            Gson cson = new Gson();
            Gson dson = new Gson();
            
            dson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
            
            Date deliveryDateStart = sdf.parse(purchaseOrder.getDeliveryDateStartTemp());
            purchaseOrder.setDeliveryDateStart(deliveryDateStart);
            
            Date deliveryDateEnd = sdf.parse(purchaseOrder.getDeliveryDateEndTemp());
            purchaseOrder.setDeliveryDateEnd(deliveryDateEnd);
            
            this.listPurchaseOrderPurchaseRequestDetail = gson.fromJson(this.listPurchaseOrderPurchaseRequestDetailJSON, new TypeToken<List<PurchaseOrderPurchaseRequest>>(){}.getType());         
            this.listPurchaseOrderDetail = bson.fromJson(this.listPurchaseOrderDetailJSON, new TypeToken<List<PurchaseOrderDetail>>(){}.getType());
            this.listPurchaseOrderAdditionalFee = cson.fromJson(this.listPurchaseOrderAdditionalFeeJSON, new TypeToken<List<PurchaseOrderAdditionalFee>>(){}.getType());
            this.listPurchaseOrderItemDeliveryDate = dson.fromJson(this.listPurchaseOrderItemDeliveryDateJSON, new TypeToken<List<PurchaseOrderItemDeliveryDate>>(){}.getType());
            
            purchaseOrder.setTransactionDate(DateUtils.newDateTime(purchaseOrder.getTransactionDate(),true));

            if(enumPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.NEW)){    
                _messg = "SAVED ";
                purchaseOrderBLL.save(enumPurchaseOrderActivity, purchaseOrder, listPurchaseOrderPurchaseRequestDetail,listPurchaseOrderDetail,
                                      listPurchaseOrderAdditionalFee, listPurchaseOrderItemDeliveryDate);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.purchaseOrder.getCode();  
            }
            else if(enumPurchaseOrderActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){    
                _messg = "SAVED ";
                purchaseOrderBLL.update(enumPurchaseOrderActivity, purchaseOrder, listPurchaseOrderPurchaseRequestDetail,listPurchaseOrderDetail,
                                      listPurchaseOrderAdditionalFee, listPurchaseOrderItemDeliveryDate);
                this.message = "UPDATE DATA SUCCESS. \n Code : " + this.purchaseOrder.getCode();  
            } 
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-delete")
    public String delete(){
        String _Messg = "DELETE";
        try{
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            
            purchaseOrderBLL.delete(purchaseOrder);
            
            this.message = _Messg + " DATA SUCCESS.<br/>PO No : " + this.purchaseOrder.getCode();
            
            return SUCCESS;
            
        }catch(Exception ex){
            this.error=true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " +ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-approval-status")
    public String saveStatus(){
        String _Messg = "";
        try {
            
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
        
            purchaseOrderBLL.approval(purchaseOrderApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>PO No : " + this.purchaseOrderApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-closing-status")
    public String saveClosing(){
        try {
                        
           PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            
            purchaseOrderBLL.closing(purchaseOrderClosing);
            
            this.message = "PROCESS DATA SUCCESS.<br/>PO No : " + this.purchaseOrderClosing.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "PROCESS DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-order-update-information-save")
    public String saveUpdateInformation(){
        String _messg = "";
        try{
            PurchaseOrderBLL purchaseOrderBLL = new PurchaseOrderBLL(hbmSession);
            Gson gson = new Gson();
            Gson bson = new Gson();
            Gson cson = new Gson();
            cson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            
            this.listPurchaseOrderUpdateInformationDetailView = gson.fromJson(this.listPurchaseOrderUpdateInformationDetailViewJSON, new TypeToken<List<PurchaseOrderDetail>>(){}.getType());
            this.listPurchaseOrderUpdateInformationDetailInput = bson.fromJson(this.listPurchaseOrderUpdateInformationDetailInputJSON, new TypeToken<List<PurchaseOrderDetail>>(){}.getType());
            this.listPurchaseOrderUpdateInformationItemDeliveryDate = cson.fromJson(this.listPurchaseOrderUpdateInformationItemDeliveryDateJSON, new TypeToken<List<PurchaseOrderItemDeliveryDate>>(){}.getType());
            
            purchaseOrderBLL.updateInformation(purchaseOrderUpdateInformation, listPurchaseOrderUpdateInformationDetailView, listPurchaseOrderUpdateInformationDetailInput, listPurchaseOrderUpdateInformationItemDeliveryDate);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.purchaseOrderUpdateInformation.getCode();
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "UPDATE FAILED";
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    public List<PurchaseOrderPurchaseRequest> getListPurchaseOrderPurchaseRequestDetail() {
        return listPurchaseOrderPurchaseRequestDetail;
    }

    public void setListPurchaseOrderPurchaseRequestDetail(List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequestDetail) {
        this.listPurchaseOrderPurchaseRequestDetail = listPurchaseOrderPurchaseRequestDetail;
    }
    
    public String getListPurchaseOrderPurchaseRequestDetailJSON() {
        return listPurchaseOrderPurchaseRequestDetailJSON;
    }

    public void setListPurchaseOrderPurchaseRequestDetailJSON(String listPurchaseOrderPurchaseRequestDetailJSON) {
        this.listPurchaseOrderPurchaseRequestDetailJSON = listPurchaseOrderPurchaseRequestDetailJSON;
    }

    public EnumActivity.ENUM_Activity getEnumPurchaseOrderActivity() {
        return enumPurchaseOrderActivity;
    }

    public void setEnumPurchaseOrderActivity(EnumActivity.ENUM_Activity enumPurchaseOrderActivity) {
        this.enumPurchaseOrderActivity = enumPurchaseOrderActivity;
    }

    public List<PurchaseOrderDetail> getListPurchaseOrderDetail() {
        return listPurchaseOrderDetail;
    }

    public void setListPurchaseOrderDetail(List<PurchaseOrderDetail> listPurchaseOrderDetail) {
        this.listPurchaseOrderDetail = listPurchaseOrderDetail;
    }

    public String getListPurchaseOrderDetailJSON() {
        return listPurchaseOrderDetailJSON;
    }

    public void setListPurchaseOrderDetailJSON(String listPurchaseOrderDetailJSON) {
        this.listPurchaseOrderDetailJSON = listPurchaseOrderDetailJSON;
    }

    public List<PurchaseOrderAdditionalFee> getListPurchaseOrderAdditionalFee() {
        return listPurchaseOrderAdditionalFee;
    }

    public void setListPurchaseOrderAdditionalFee(List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee) {
        this.listPurchaseOrderAdditionalFee = listPurchaseOrderAdditionalFee;
    }

    public String getListPurchaseOrderAdditionalFeeJSON() {
        return listPurchaseOrderAdditionalFeeJSON;
    }

    public void setListPurchaseOrderAdditionalFeeJSON(String listPurchaseOrderAdditionalFeeJSON) {
        this.listPurchaseOrderAdditionalFeeJSON = listPurchaseOrderAdditionalFeeJSON;
    }

    public List<PurchaseOrderItemDeliveryDate> getListPurchaseOrderItemDeliveryDate() {
        return listPurchaseOrderItemDeliveryDate;
    }

    public void setListPurchaseOrderItemDeliveryDate(List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate) {
        this.listPurchaseOrderItemDeliveryDate = listPurchaseOrderItemDeliveryDate;
    }

    public String getListPurchaseOrderItemDeliveryDateJSON() {
        return listPurchaseOrderItemDeliveryDateJSON;
    }

    public void setListPurchaseOrderItemDeliveryDateJSON(String listPurchaseOrderItemDeliveryDateJSON) {
        this.listPurchaseOrderItemDeliveryDateJSON = listPurchaseOrderItemDeliveryDateJSON;
    }

    public List<PurchaseOrder> getListPurchaseOrder() {
        return listPurchaseOrder;
    }

    public void setListPurchaseOrder(List<PurchaseOrder> listPurchaseOrder) {
        this.listPurchaseOrder = listPurchaseOrder;
    }

    public PurchaseOrder getPurchaseOrderApproval() {
        return purchaseOrderApproval;
    }

    public void setPurchaseOrderApproval(PurchaseOrder purchaseOrderApproval) {
        this.purchaseOrderApproval = purchaseOrderApproval;
    }

    public String getListPurchaseOrderSubItemJSON() {
        return listPurchaseOrderSubItemJSON;
    }

    public void setListPurchaseOrderSubItemJSON(String listPurchaseOrderSubItemJSON) {
        this.listPurchaseOrderSubItemJSON = listPurchaseOrderSubItemJSON;
    }

    public PurchaseOrder getPurchaseOrderClosing() {
        return purchaseOrderClosing;
    }

    public void setPurchaseOrderClosing(PurchaseOrder purchaseOrderClosing) {
        this.purchaseOrderClosing = purchaseOrderClosing;
    }

    public String getPurchaseOrderSearchCode() {
        return purchaseOrderSearchCode;
    }

    public void setPurchaseOrderSearchCode(String purchaseOrderSearchCode) {
        this.purchaseOrderSearchCode = purchaseOrderSearchCode;
    }

    public String getPurchaseOrderSearchName() {
        return purchaseOrderSearchName;
    }

    public void setPurchaseOrderSearchName(String purchaseOrderSearchName) {
        this.purchaseOrderSearchName = purchaseOrderSearchName;
    }

    public String getPurchaseOrderSearchRefNo() {
        return purchaseOrderSearchRefNo;
    }

    public void setPurchaseOrderSearchRefNo(String purchaseOrderSearchRefNo) {
        this.purchaseOrderSearchRefNo = purchaseOrderSearchRefNo;
    }

    public String getPurchaseOrderSearchRemark() {
        return purchaseOrderSearchRemark;
    }

    public void setPurchaseOrderSearchRemark(String purchaseOrderSearchRemark) {
        this.purchaseOrderSearchRemark = purchaseOrderSearchRemark;
    }

    public String getPurchaseOrderVendorSearchCode() {
        return purchaseOrderVendorSearchCode;
    }

    public void setPurchaseOrderVendorSearchCode(String purchaseOrderVendorSearchCode) {
        this.purchaseOrderVendorSearchCode = purchaseOrderVendorSearchCode;
    }

    public String getPurchaseOrderVendorSearchName() {
        return purchaseOrderVendorSearchName;
    }

    public void setPurchaseOrderVendorSearchName(String purchaseOrderVendorSearchName) {
        this.purchaseOrderVendorSearchName = purchaseOrderVendorSearchName;
    }

    public String getPurchaseOrderClosedSearchStatus() {
        return purchaseOrderClosedSearchStatus;
    }

    public void setPurchaseOrderClosedSearchStatus(String purchaseOrderClosedSearchStatus) {
        this.purchaseOrderClosedSearchStatus = purchaseOrderClosedSearchStatus;
    }

    public Date getPurchaseOrderSearchFirstDate() {
        return purchaseOrderSearchFirstDate;
    }

    public void setPurchaseOrderSearchFirstDate(Date purchaseOrderSearchFirstDate) {
        this.purchaseOrderSearchFirstDate = purchaseOrderSearchFirstDate;
    }

    public Date getPurchaseOrderSearchLastDate() {
        return purchaseOrderSearchLastDate;
    }

    public void setPurchaseOrderSearchLastDate(Date purchaseOrderSearchLastDate) {
        this.purchaseOrderSearchLastDate = purchaseOrderSearchLastDate;
    }

    public String getEnumPrm() {
        return enumPrm;
    }

    public void setEnumPrm(String enumPrm) {
        this.enumPrm = enumPrm;
    }

    public String getPrHeader() {
        return prHeader;
    }

    public void setPrHeader(String prHeader) {
        this.prHeader = prHeader;
    }

    public String getPrDetail() {
        return prDetail;
    }

    public void setPrDetail(String prDetail) {
        this.prDetail = prDetail;
    }

    public ArrayList getArrayCode() {
        return arrayCode;
    }

    public void setArrayCode(ArrayList arrayCode) {
        this.arrayCode = arrayCode;
    }

    public ArrayList getArrayCodeDetail() {
        return arrayCodeDetail;
    }

    public void setArrayCodeDetail(ArrayList arrayCodeDetail) {
        this.arrayCodeDetail = arrayCodeDetail;
    }

    public PurchaseOrder getPurchaseOrderUpdateInformation() {
        return purchaseOrderUpdateInformation;
    }

    public void setPurchaseOrderUpdateInformation(PurchaseOrder purchaseOrderUpdateInformation) {
        this.purchaseOrderUpdateInformation = purchaseOrderUpdateInformation;
    }

    public List<PurchaseOrderDetail> getListPurchaseOrderUpdateInformationDetailView() {
        return listPurchaseOrderUpdateInformationDetailView;
    }

    public void setListPurchaseOrderUpdateInformationDetailView(List<PurchaseOrderDetail> listPurchaseOrderUpdateInformationDetailView) {
        this.listPurchaseOrderUpdateInformationDetailView = listPurchaseOrderUpdateInformationDetailView;
    }

    public List<PurchaseOrderDetail> getListPurchaseOrderUpdateInformationDetailInput() {
        return listPurchaseOrderUpdateInformationDetailInput;
    }

    public void setListPurchaseOrderUpdateInformationDetailInput(List<PurchaseOrderDetail> listPurchaseOrderUpdateInformationDetailInput) {
        this.listPurchaseOrderUpdateInformationDetailInput = listPurchaseOrderUpdateInformationDetailInput;
    }

    public List<PurchaseOrderItemDeliveryDate> getListPurchaseOrderUpdateInformationItemDeliveryDate() {
        return listPurchaseOrderUpdateInformationItemDeliveryDate;
    }

    public void setListPurchaseOrderUpdateInformationItemDeliveryDate(List<PurchaseOrderItemDeliveryDate> listPurchaseOrderUpdateInformationItemDeliveryDate) {
        this.listPurchaseOrderUpdateInformationItemDeliveryDate = listPurchaseOrderUpdateInformationItemDeliveryDate;
    }

    public String getListPurchaseOrderUpdateInformationDetailViewJSON() {
        return listPurchaseOrderUpdateInformationDetailViewJSON;
    }

    public void setListPurchaseOrderUpdateInformationDetailViewJSON(String listPurchaseOrderUpdateInformationDetailViewJSON) {
        this.listPurchaseOrderUpdateInformationDetailViewJSON = listPurchaseOrderUpdateInformationDetailViewJSON;
    }

    public String getListPurchaseOrderUpdateInformationDetailInputJSON() {
        return listPurchaseOrderUpdateInformationDetailInputJSON;
    }

    public void setListPurchaseOrderUpdateInformationDetailInputJSON(String listPurchaseOrderUpdateInformationDetailInputJSON) {
        this.listPurchaseOrderUpdateInformationDetailInputJSON = listPurchaseOrderUpdateInformationDetailInputJSON;
    }

    public String getListPurchaseOrderUpdateInformationItemDeliveryDateJSON() {
        return listPurchaseOrderUpdateInformationItemDeliveryDateJSON;
    }

    public void setListPurchaseOrderUpdateInformationItemDeliveryDateJSON(String listPurchaseOrderUpdateInformationItemDeliveryDateJSON) {
        this.listPurchaseOrderUpdateInformationItemDeliveryDateJSON = listPurchaseOrderUpdateInformationItemDeliveryDateJSON;
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
