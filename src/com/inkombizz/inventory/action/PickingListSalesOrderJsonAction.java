
package com.inkombizz.inventory.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.PickingListSalesOrderBLL;
import com.inkombizz.inventory.model.PickingListSalesOrder;
import com.inkombizz.inventory.model.PickingListSalesOrderBonusItemDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderBonusItemDetailTemp;
//import com.inkombizz.inventory.model.PickingListSalesOrderBonusItemQuantityDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderBonusItemQuantityDetailTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemDetailTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemQuantityDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemQuantityDetailTemp;
import com.inkombizz.master.model.ItemCurrentStockTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", type = "json"),
    @Result(name="pageHTML", location="inventory/picking-list-customer-order.jsp")
})
public class PickingListSalesOrderJsonAction extends ActionSupport{
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private List<ItemCurrentStockTemp> listItemCurrentStockTemp;
    
    private PickingListSalesOrder pickingListSalesOrder;
    private PickingListSalesOrder pickingListSalesOrderConfirmation;
    private PickingListSalesOrder pickingListSalesOrderConfirmationSupervisor;
    
    private PickingListSalesOrderTemp pickingListSalesOrderTemp;
    private PickingListSalesOrderTemp pickingListSalesOrderConfirmationTemp;
    private PickingListSalesOrderTemp pickingListSalesOrderConfirmationSupervisorTemp;
    private List<PickingListSalesOrderTemp> listPickingListSalesOrderTemp;
    
    private List<PickingListSalesOrderTradeItemDetail> listPickingListSalesOrderTradeItemDetail;
    private List<PickingListSalesOrderTradeItemDetailTemp> listPickingListSalesOrderTradeItemDetailTemp;
    private String listPickingListSalesOrderTradeItemDetailJSON="";
//    
    private List<PickingListSalesOrderBonusItemDetail> listPickingListSalesOrderBonusItemDetail;
    private List<PickingListSalesOrderBonusItemDetailTemp> listPickingListSalesOrderBonusItemDetailTemp;
    private String listPickingListSalesOrderBonusItemDetailJSON="";
    
    private List<PickingListSalesOrderTradeItemQuantityDetail> listPickingListSalesOrderTradeItemQuantityDetail;
    private List<PickingListSalesOrderTradeItemQuantityDetailTemp> listPickingListSalesOrderTradeItemQuantityDetailTemp;
    private String listPickingListSalesOrderTradeItemQuantityDetailJSON="";
//    
//    private List<PickingListSalesOrderBonusItemQuantityDetail> listPickingListSalesOrderBonusItemQuantityDetail;
    private List<PickingListSalesOrderBonusItemQuantityDetailTemp> listPickingListSalesOrderBonusItemQuantityDetailTemp;
    private String listPickingListSalesOrderBonusItemQuantityDetailJSON="";
        
    private String pickingListSalesOrderSearchCode="";
    private String pickingListSalesOrderSearchSalesOrderCode="";
    private String pickingListSalesOrderSearchCustomerCode="";
    private String pickingListSalesOrderSearchCustomerName="";
    private String pickingListSalesOrderSearchRefNo="";
    private String pickingListSalesOrderSearchRemark="";
    private Date pickingListSalesOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date pickingListSalesOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String pickingListSalesOrderConfirmationSearchCode="";
    private String pickingListSalesOrderConfirmationSearchSalesOrderCode="";
    private String pickingListSalesOrderConfirmationSearchCustomerCode="";
    private String pickingListSalesOrderConfirmationSearchCustomerName="";
    private String pickingListSalesOrderConfirmationSearchRefNo="";
    private String pickingListSalesOrderConfirmationSearchRemark="";
    private String pickingListSalesOrderConfirmationSearchStatus="PENDING";
    private Date pickingListSalesOrderConfirmationSearchFirstDate;
    private Date pickingListSalesOrderConfirmationSearchLastDate;
    
    private String pickingListSalesOrderConfirmationSupervisorSearchCode="";
    private String pickingListSalesOrderConfirmationSupervisorSearchSalesOrderCode="";
    private String pickingListSalesOrderConfirmationSupervisorSearchCustomerCode="";
    private String pickingListSalesOrderConfirmationSupervisorSearchCustomerName="";
    private String pickingListSalesOrderConfirmationSupervisorSearchRefNo="";
    private String pickingListSalesOrderConfirmationSupervisorSearchRemark="";
    private String pickingListSalesOrderConfirmationSupervisorSearchStatus="PENDING";
    private Date pickingListSalesOrderConfirmationSupervisorSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date pickingListSalesOrderConfirmationSupervisorSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String salesOrderCustomerCode="";
    private String salesOrderCode="";
    private String usedModule = "";
    private String actionAuthority="";
    private String headerCode = "";
    private String shipToCode = "";
    private String userCodeTemp=BaseSession.loadProgramSession().getUserCode();
    
    private String searchWarehouseCode = "";
    private String searchItemCode = "";
    
    private String warehouseCode;
    private String itemCode;
    private int quantity;
    
    @Override 
    public String execute(){
        try{
            return findata();
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
    
    @Action("picking-list-sales-order-authority")
    public String pickingListAuthority(){
        try{
            
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);
            PickingListSalesOrder pltSO = (PickingListSalesOrder)hbmSession.hSession.get(PickingListSalesOrder.class, this.headerCode);
            
            String modCode = "";
            switch (this.usedModule) {
                case "MAIN":
                    modCode = pickingListSalesOrderBLL.MODULECODE;
                    break;
                case "CONFIRMATION":
                    modCode = pickingListSalesOrderBLL.MODULECODE_CONFIRMATION;
                    break;
            }
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE SAVE AUTHORITY";
                        return SUCCESS;
                    }
                    
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE UPDATE AUTHORITY";
                        return SUCCESS;
                    }
                    
                    // cek sudah ditarik DLN atau belum
                    if(pickingListSalesOrderBLL.pickingListSOUsedInDLN(this.headerCode)>0){
                        this.error = true;
                        this.errorMessage = "Code : " + this.headerCode + "/n Has Been Used In DLN";
                        return SUCCESS;
                    }
                    
                    break;
                    
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE DELETE AUTHORITY";
                        return SUCCESS;
                    }
                    
                    // cek sudah di Confirm atau belum
                    if("A".equals(pickingListSalesOrderBLL.pickingListSOConfirmed(this.headerCode))){
                        this.error = true;
                        this.errorMessage = "Code : " + this.headerCode + "/n Has Been CONFIRMED";
                        return SUCCESS;
                    }
                    
                    break;
                    
                case "PRINT":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE PRINT AUTHORITY";
                        return SUCCESS;
                    }
                    
                    break;
            }

            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
        
    @Action("picking-list-sales-order-data")
    public String findata(){
        try{
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            

            if (pickingListSalesOrderConfirmationSearchFirstDate == null){
                pickingListSalesOrderConfirmationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            }
            
            if (pickingListSalesOrderConfirmationSearchLastDate == null){
                pickingListSalesOrderConfirmationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            }
            
            ListPaging<PickingListSalesOrderTemp> listPaging = pickingListSalesOrderBLL.findData(paging,userCodeTemp,pickingListSalesOrderSearchCode,pickingListSalesOrderSearchSalesOrderCode,pickingListSalesOrderSearchCustomerCode,pickingListSalesOrderSearchCustomerName,pickingListSalesOrderSearchRefNo,pickingListSalesOrderSearchRemark,pickingListSalesOrderSearchFirstDate,pickingListSalesOrderSearchLastDate);
            
            listPickingListSalesOrderTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("picking-list-sales-order-data-for-dln")
    public String findataPickingList(){
        try{
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            

            List<PickingListSalesOrderTemp> list = pickingListSalesOrderBLL.findDataPickingList(salesOrderCode);
            listPickingListSalesOrderTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("picking-list-sales-order-trade-item-detail-data")
    public String findDataTradeItemDetail() {
        try{
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            
            
            List<PickingListSalesOrderTradeItemDetailTemp> list = pickingListSalesOrderBLL.findDataTradeItemDetail(pickingListSalesOrder.getCode());
            
            listPickingListSalesOrderTradeItemDetailTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("picking-list-sales-order-trade-item-quantity-detail-data")
    public String findDataTradeItemQuantityDetail() {
        try{
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            
            
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> list = pickingListSalesOrderBLL.findDataTradeItemQuantityDetail(pickingListSalesOrder.getCode());
            
            listPickingListSalesOrderTradeItemQuantityDetailTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
//    @Action("picking-list-sales-order-trade-item-detail-confirmation-data")
//    public String findDataTradeItemDetailConfirmation() {
//        try{
//            hbmSession.hSession.beginTransaction();
//            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            
//            
//            List<PickingListSalesOrderTradeItemDetailTemp> list = pickingListSalesOrderBLL.findDataTradeItemDetailConfirmation(pickingListSalesOrder.getCode());
//            
//            listPickingListSalesOrderTradeItemDetailTemp = list;
//            
//            return SUCCESS;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return SUCCESS;
//        }
//    }
    
        @Action("picking-list-sales-order-trade-item-detail-by-return-picking-list-data")
    public String findDataTradeItemDetailByReturnPickingList() {
        try{
            hbmSession.hSession.beginTransaction();
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            
            
            listPickingListSalesOrderTradeItemQuantityDetailTemp = pickingListSalesOrderBLL.findDataTradeItemDetailByReturnPickingList(salesOrderCode);
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("picking-list-sales-order-bonus-item-detail-by-return-picking-list-data")
    public String findDataBonusItemDetailByReturnPickingList() {
        try{
            hbmSession.hSession.beginTransaction();
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            
            
            listPickingListSalesOrderBonusItemQuantityDetailTemp = pickingListSalesOrderBLL.findDataBonusItemDetailByReturnPickingList(salesOrderCode);
          
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("item-stock-data")
    public String itemStockGetData(){
        try{
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);            

            ListPaging<ItemCurrentStockTemp> listPaging = pickingListSalesOrderBLL.ItemStock(paging, searchWarehouseCode, searchItemCode);
            
            listItemCurrentStockTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("picking-list-sales-order-confirmation-data")
    public String findataConfirmation(){
        try{
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);
            
            if (pickingListSalesOrderConfirmationSearchFirstDate == null){
                pickingListSalesOrderConfirmationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            }
            
            if (pickingListSalesOrderConfirmationSearchLastDate == null){
                pickingListSalesOrderConfirmationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            }
            ListPaging<PickingListSalesOrderTemp> listPaging = pickingListSalesOrderBLL.findDataConfirmation(paging,userCodeTemp,pickingListSalesOrderConfirmationSearchCode,pickingListSalesOrderConfirmationSearchSalesOrderCode,pickingListSalesOrderConfirmationSearchCustomerCode,pickingListSalesOrderConfirmationSearchCustomerName,pickingListSalesOrderConfirmationSearchRefNo,pickingListSalesOrderConfirmationSearchRemark,pickingListSalesOrderConfirmationSearchStatus,pickingListSalesOrderConfirmationSearchFirstDate,pickingListSalesOrderConfirmationSearchLastDate);
            
            listPickingListSalesOrderTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
            
    @Action("picking-list-sales-order-save")
    public String save(){
        String _Messg = "";
        try {
                        
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);
            
            Gson gson = new Gson();
            gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
            this.listPickingListSalesOrderTradeItemDetail = gson.fromJson(this.listPickingListSalesOrderTradeItemDetailJSON, new TypeToken<List<PickingListSalesOrderTradeItemDetail>>(){}.getType());           
            this.listPickingListSalesOrderTradeItemQuantityDetail = gson.fromJson(this.listPickingListSalesOrderTradeItemQuantityDetailJSON, new TypeToken<List<PickingListSalesOrderTradeItemQuantityDetail>>(){}.getType());           
                                    
            if(pickingListSalesOrderBLL.isExist(this.pickingListSalesOrder.getCode())){
                _Messg="UPDATED ";
                                
            }else{
                _Messg="SAVED ";
                pickingListSalesOrder.setTransactionDate(DateUtils.newDateTime(pickingListSalesOrder.getTransactionDate(),true));
                                
                pickingListSalesOrderBLL.save(pickingListSalesOrder, listPickingListSalesOrderTradeItemDetail, listPickingListSalesOrderTradeItemQuantityDetail);
            }

            this.message = _Messg + " DATA SUCCESS.<br/>PLT-SO No : " + this.pickingListSalesOrder.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("picking-list-sales-order-confirmation-save")
    public String saveConfirmation(){
        String _Messg = "CONFIRMATION";
        try {
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession);
            Gson gson = new Gson();
            this.listPickingListSalesOrderTradeItemQuantityDetail = gson.fromJson(this.listPickingListSalesOrderTradeItemQuantityDetailJSON, new TypeToken<List<PickingListSalesOrderTradeItemQuantityDetail>>(){}.getType());   
            this.listPickingListSalesOrderTradeItemDetail = gson.fromJson(this.listPickingListSalesOrderTradeItemDetailJSON, new TypeToken<List<PickingListSalesOrderTradeItemDetail>>(){}.getType());                     
            pickingListSalesOrderBLL.confirmation(pickingListSalesOrderConfirmation, listPickingListSalesOrderTradeItemDetail, listPickingListSalesOrderTradeItemQuantityDetail);
            this.message = _Messg + " DATA SUCCESS.<br/>PLT-SO No : " + this.pickingListSalesOrderConfirmation.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("picking-list-sales-order-delete")
    public String delete(){
        String _messg = "";
        try{
            PickingListSalesOrderBLL pickingListSalesOrderBLL = new PickingListSalesOrderBLL(hbmSession); 

            _messg = "DELETE ";
            pickingListSalesOrderBLL.delete(pickingListSalesOrder.getCode());
            
            this.message = _messg + "DATA SUCCESS.<br/> SO No : " + this.pickingListSalesOrder.getCode();
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

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public PickingListSalesOrder getPickingListSalesOrder() {
        return pickingListSalesOrder;
    }

    public void setPickingListSalesOrder(PickingListSalesOrder pickingListSalesOrder) {
        this.pickingListSalesOrder = pickingListSalesOrder;
    }

    public PickingListSalesOrder getPickingListSalesOrderConfirmation() {
        return pickingListSalesOrderConfirmation;
    }

    public void setPickingListSalesOrderConfirmation(PickingListSalesOrder pickingListSalesOrderConfirmation) {
        this.pickingListSalesOrderConfirmation = pickingListSalesOrderConfirmation;
    }

    public PickingListSalesOrder getPickingListSalesOrderConfirmationSupervisor() {
        return pickingListSalesOrderConfirmationSupervisor;
    }

    public void setPickingListSalesOrderConfirmationSupervisor(PickingListSalesOrder pickingListSalesOrderConfirmationSupervisor) {
        this.pickingListSalesOrderConfirmationSupervisor = pickingListSalesOrderConfirmationSupervisor;
    }

    public PickingListSalesOrderTemp getPickingListSalesOrderTemp() {
        return pickingListSalesOrderTemp;
    }

    public void setPickingListSalesOrderTemp(PickingListSalesOrderTemp pickingListSalesOrderTemp) {
        this.pickingListSalesOrderTemp = pickingListSalesOrderTemp;
    }

    public PickingListSalesOrderTemp getPickingListSalesOrderConfirmationTemp() {
        return pickingListSalesOrderConfirmationTemp;
    }

    public void setPickingListSalesOrderConfirmationTemp(PickingListSalesOrderTemp pickingListSalesOrderConfirmationTemp) {
        this.pickingListSalesOrderConfirmationTemp = pickingListSalesOrderConfirmationTemp;
    }

    public PickingListSalesOrderTemp getPickingListSalesOrderConfirmationSupervisorTemp() {
        return pickingListSalesOrderConfirmationSupervisorTemp;
    }

    public void setPickingListSalesOrderConfirmationSupervisorTemp(PickingListSalesOrderTemp pickingListSalesOrderConfirmationSupervisorTemp) {
        this.pickingListSalesOrderConfirmationSupervisorTemp = pickingListSalesOrderConfirmationSupervisorTemp;
    }

    public List<PickingListSalesOrderTemp> getListPickingListSalesOrderTemp() {
        return listPickingListSalesOrderTemp;
    }

    public void setListPickingListSalesOrderTemp(List<PickingListSalesOrderTemp> listPickingListSalesOrderTemp) {
        this.listPickingListSalesOrderTemp = listPickingListSalesOrderTemp;
    }
    
    public String getPickingListSalesOrderSearchCode() {
        return pickingListSalesOrderSearchCode;
    }

    public void setPickingListSalesOrderSearchCode(String pickingListSalesOrderSearchCode) {
        this.pickingListSalesOrderSearchCode = pickingListSalesOrderSearchCode;
    }

    public String getPickingListSalesOrderSearchSalesOrderCode() {
        return pickingListSalesOrderSearchSalesOrderCode;
    }

    public void setPickingListSalesOrderSearchSalesOrderCode(String pickingListSalesOrderSearchSalesOrderCode) {
        this.pickingListSalesOrderSearchSalesOrderCode = pickingListSalesOrderSearchSalesOrderCode;
    }

    public String getPickingListSalesOrderSearchCustomerCode() {
        return pickingListSalesOrderSearchCustomerCode;
    }

    public void setPickingListSalesOrderSearchCustomerCode(String pickingListSalesOrderSearchCustomerCode) {
        this.pickingListSalesOrderSearchCustomerCode = pickingListSalesOrderSearchCustomerCode;
    }

    public String getPickingListSalesOrderSearchCustomerName() {
        return pickingListSalesOrderSearchCustomerName;
    }

    public void setPickingListSalesOrderSearchCustomerName(String pickingListSalesOrderSearchCustomerName) {
        this.pickingListSalesOrderSearchCustomerName = pickingListSalesOrderSearchCustomerName;
    }

    public String getPickingListSalesOrderSearchRefNo() {
        return pickingListSalesOrderSearchRefNo;
    }

    public void setPickingListSalesOrderSearchRefNo(String pickingListSalesOrderSearchRefNo) {
        this.pickingListSalesOrderSearchRefNo = pickingListSalesOrderSearchRefNo;
    }

    public String getPickingListSalesOrderSearchRemark() {
        return pickingListSalesOrderSearchRemark;
    }

    public void setPickingListSalesOrderSearchRemark(String pickingListSalesOrderSearchRemark) {
        this.pickingListSalesOrderSearchRemark = pickingListSalesOrderSearchRemark;
    }

    public Date getPickingListSalesOrderSearchFirstDate() {
        return pickingListSalesOrderSearchFirstDate;
    }

    public void setPickingListSalesOrderSearchFirstDate(Date pickingListSalesOrderSearchFirstDate) {
        this.pickingListSalesOrderSearchFirstDate = pickingListSalesOrderSearchFirstDate;
    }

    public Date getPickingListSalesOrderSearchLastDate() {
        return pickingListSalesOrderSearchLastDate;
    }

    public void setPickingListSalesOrderSearchLastDate(Date pickingListSalesOrderSearchLastDate) {
        this.pickingListSalesOrderSearchLastDate = pickingListSalesOrderSearchLastDate;
    }

    public String getPickingListSalesOrderConfirmationSearchCode() {
        return pickingListSalesOrderConfirmationSearchCode;
    }

    public void setPickingListSalesOrderConfirmationSearchCode(String pickingListSalesOrderConfirmationSearchCode) {
        this.pickingListSalesOrderConfirmationSearchCode = pickingListSalesOrderConfirmationSearchCode;
    }

    public String getPickingListSalesOrderConfirmationSearchSalesOrderCode() {
        return pickingListSalesOrderConfirmationSearchSalesOrderCode;
    }

    public void setPickingListSalesOrderConfirmationSearchSalesOrderCode(String pickingListSalesOrderConfirmationSearchSalesOrderCode) {
        this.pickingListSalesOrderConfirmationSearchSalesOrderCode = pickingListSalesOrderConfirmationSearchSalesOrderCode;
    }

    public String getPickingListSalesOrderConfirmationSearchCustomerCode() {
        return pickingListSalesOrderConfirmationSearchCustomerCode;
    }

    public void setPickingListSalesOrderConfirmationSearchCustomerCode(String pickingListSalesOrderConfirmationSearchCustomerCode) {
        this.pickingListSalesOrderConfirmationSearchCustomerCode = pickingListSalesOrderConfirmationSearchCustomerCode;
    }

    public String getPickingListSalesOrderConfirmationSearchCustomerName() {
        return pickingListSalesOrderConfirmationSearchCustomerName;
    }

    public void setPickingListSalesOrderConfirmationSearchCustomerName(String pickingListSalesOrderConfirmationSearchCustomerName) {
        this.pickingListSalesOrderConfirmationSearchCustomerName = pickingListSalesOrderConfirmationSearchCustomerName;
    }

    public String getPickingListSalesOrderConfirmationSearchRefNo() {
        return pickingListSalesOrderConfirmationSearchRefNo;
    }

    public void setPickingListSalesOrderConfirmationSearchRefNo(String pickingListSalesOrderConfirmationSearchRefNo) {
        this.pickingListSalesOrderConfirmationSearchRefNo = pickingListSalesOrderConfirmationSearchRefNo;
    }

    public String getPickingListSalesOrderConfirmationSearchRemark() {
        return pickingListSalesOrderConfirmationSearchRemark;
    }

    public void setPickingListSalesOrderConfirmationSearchRemark(String pickingListSalesOrderConfirmationSearchRemark) {
        this.pickingListSalesOrderConfirmationSearchRemark = pickingListSalesOrderConfirmationSearchRemark;
    }

    public String getPickingListSalesOrderConfirmationSearchStatus() {
        return pickingListSalesOrderConfirmationSearchStatus;
    }

    public void setPickingListSalesOrderConfirmationSearchStatus(String pickingListSalesOrderConfirmationSearchStatus) {
        this.pickingListSalesOrderConfirmationSearchStatus = pickingListSalesOrderConfirmationSearchStatus;
    }

    public Date getPickingListSalesOrderConfirmationSearchFirstDate() {
        return pickingListSalesOrderConfirmationSearchFirstDate;
    }

    public void setPickingListSalesOrderConfirmationSearchFirstDate(Date pickingListSalesOrderConfirmationSearchFirstDate) {
        this.pickingListSalesOrderConfirmationSearchFirstDate = pickingListSalesOrderConfirmationSearchFirstDate;
    }

    public Date getPickingListSalesOrderConfirmationSearchLastDate() {
        return pickingListSalesOrderConfirmationSearchLastDate;
    }

    public void setPickingListSalesOrderConfirmationSearchLastDate(Date pickingListSalesOrderConfirmationSearchLastDate) {
        this.pickingListSalesOrderConfirmationSearchLastDate = pickingListSalesOrderConfirmationSearchLastDate;
    }

    public String getSalesOrderCustomerCode() {
        return salesOrderCustomerCode;
    }

    public void setSalesOrderCustomerCode(String salesOrderCustomerCode) {
        this.salesOrderCustomerCode = salesOrderCustomerCode;
    }

    public String getSalesOrderCode() {
        return salesOrderCode;
    }

    public void setSalesOrderCode(String salesOrderCode) {
        this.salesOrderCode = salesOrderCode;
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
    
    // <editor-fold defaultstate="collapsed" desc="Paging">
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

    public String getUsedModule() {
        return usedModule;
    }

    public void setUsedModule(String usedModule) {
        this.usedModule = usedModule;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getPickingListSalesOrderConfirmationSupervisorSearchCode() {
        return pickingListSalesOrderConfirmationSupervisorSearchCode;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchCode(String pickingListSalesOrderConfirmationSupervisorSearchCode) {
        this.pickingListSalesOrderConfirmationSupervisorSearchCode = pickingListSalesOrderConfirmationSupervisorSearchCode;
    }

    public String getPickingListSalesOrderConfirmationSupervisorSearchSalesOrderCode() {
        return pickingListSalesOrderConfirmationSupervisorSearchSalesOrderCode;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchSalesOrderCode(String pickingListSalesOrderConfirmationSupervisorSearchSalesOrderCode) {
        this.pickingListSalesOrderConfirmationSupervisorSearchSalesOrderCode = pickingListSalesOrderConfirmationSupervisorSearchSalesOrderCode;
    }

    public String getPickingListSalesOrderConfirmationSupervisorSearchCustomerCode() {
        return pickingListSalesOrderConfirmationSupervisorSearchCustomerCode;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchCustomerCode(String pickingListSalesOrderConfirmationSupervisorSearchCustomerCode) {
        this.pickingListSalesOrderConfirmationSupervisorSearchCustomerCode = pickingListSalesOrderConfirmationSupervisorSearchCustomerCode;
    }

    public String getPickingListSalesOrderConfirmationSupervisorSearchCustomerName() {
        return pickingListSalesOrderConfirmationSupervisorSearchCustomerName;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchCustomerName(String pickingListSalesOrderConfirmationSupervisorSearchCustomerName) {
        this.pickingListSalesOrderConfirmationSupervisorSearchCustomerName = pickingListSalesOrderConfirmationSupervisorSearchCustomerName;
    }

    public String getPickingListSalesOrderConfirmationSupervisorSearchRefNo() {
        return pickingListSalesOrderConfirmationSupervisorSearchRefNo;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchRefNo(String pickingListSalesOrderConfirmationSupervisorSearchRefNo) {
        this.pickingListSalesOrderConfirmationSupervisorSearchRefNo = pickingListSalesOrderConfirmationSupervisorSearchRefNo;
    }

    public String getPickingListSalesOrderConfirmationSupervisorSearchRemark() {
        return pickingListSalesOrderConfirmationSupervisorSearchRemark;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchRemark(String pickingListSalesOrderConfirmationSupervisorSearchRemark) {
        this.pickingListSalesOrderConfirmationSupervisorSearchRemark = pickingListSalesOrderConfirmationSupervisorSearchRemark;
    }

    public String getPickingListSalesOrderConfirmationSupervisorSearchStatus() {
        return pickingListSalesOrderConfirmationSupervisorSearchStatus;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchStatus(String pickingListSalesOrderConfirmationSupervisorSearchStatus) {
        this.pickingListSalesOrderConfirmationSupervisorSearchStatus = pickingListSalesOrderConfirmationSupervisorSearchStatus;
    }

    public Date getPickingListSalesOrderConfirmationSupervisorSearchFirstDate() {
        return pickingListSalesOrderConfirmationSupervisorSearchFirstDate;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchFirstDate(Date pickingListSalesOrderConfirmationSupervisorSearchFirstDate) {
        this.pickingListSalesOrderConfirmationSupervisorSearchFirstDate = pickingListSalesOrderConfirmationSupervisorSearchFirstDate;
    }

    public Date getPickingListSalesOrderConfirmationSupervisorSearchLastDate() {
        return pickingListSalesOrderConfirmationSupervisorSearchLastDate;
    }

    public void setPickingListSalesOrderConfirmationSupervisorSearchLastDate(Date pickingListSalesOrderConfirmationSupervisorSearchLastDate) {
        this.pickingListSalesOrderConfirmationSupervisorSearchLastDate = pickingListSalesOrderConfirmationSupervisorSearchLastDate;
    }

    public String getShipToCode() {
        return shipToCode;
    }

    public void setShipToCode(String shipToCode) {
        this.shipToCode = shipToCode;
    }

    public String getUserCodeTemp() {
        return userCodeTemp;
    }

    public void setUserCodeTemp(String userCodeTemp) {
        this.userCodeTemp = userCodeTemp;
    }

    public List<PickingListSalesOrderTradeItemDetail> getListPickingListSalesOrderTradeItemDetail() {
        return listPickingListSalesOrderTradeItemDetail;
    }

    public void setListPickingListSalesOrderTradeItemDetail(List<PickingListSalesOrderTradeItemDetail> listPickingListSalesOrderTradeItemDetail) {
        this.listPickingListSalesOrderTradeItemDetail = listPickingListSalesOrderTradeItemDetail;
    }

    public List<PickingListSalesOrderTradeItemDetailTemp> getListPickingListSalesOrderTradeItemDetailTemp() {
        return listPickingListSalesOrderTradeItemDetailTemp;
    }

    public void setListPickingListSalesOrderTradeItemDetailTemp(List<PickingListSalesOrderTradeItemDetailTemp> listPickingListSalesOrderTradeItemDetailTemp) {
        this.listPickingListSalesOrderTradeItemDetailTemp = listPickingListSalesOrderTradeItemDetailTemp;
    }

    public String getListPickingListSalesOrderTradeItemDetailJSON() {
        return listPickingListSalesOrderTradeItemDetailJSON;
    }

    public void setListPickingListSalesOrderTradeItemDetailJSON(String listPickingListSalesOrderTradeItemDetailJSON) {
        this.listPickingListSalesOrderTradeItemDetailJSON = listPickingListSalesOrderTradeItemDetailJSON;
    }

    public List<PickingListSalesOrderTradeItemQuantityDetail> getListPickingListSalesOrderTradeItemQuantityDetail() {
        return listPickingListSalesOrderTradeItemQuantityDetail;
    }

    public void setListPickingListSalesOrderTradeItemQuantityDetail(List<PickingListSalesOrderTradeItemQuantityDetail> listPickingListSalesOrderTradeItemQuantityDetail) {
        this.listPickingListSalesOrderTradeItemQuantityDetail = listPickingListSalesOrderTradeItemQuantityDetail;
    }

    public List<PickingListSalesOrderTradeItemQuantityDetailTemp> getListPickingListSalesOrderTradeItemQuantityDetailTemp() {
        return listPickingListSalesOrderTradeItemQuantityDetailTemp;
    }

    public void setListPickingListSalesOrderTradeItemQuantityDetailTemp(List<PickingListSalesOrderTradeItemQuantityDetailTemp> listPickingListSalesOrderTradeItemQuantityDetailTemp) {
        this.listPickingListSalesOrderTradeItemQuantityDetailTemp = listPickingListSalesOrderTradeItemQuantityDetailTemp;
    }

    public String getListPickingListSalesOrderTradeItemQuantityDetailJSON() {
        return listPickingListSalesOrderTradeItemQuantityDetailJSON;
    }

    public void setListPickingListSalesOrderTradeItemQuantityDetailJSON(String listPickingListSalesOrderTradeItemQuantityDetailJSON) {
        this.listPickingListSalesOrderTradeItemQuantityDetailJSON = listPickingListSalesOrderTradeItemQuantityDetailJSON;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public List<ItemCurrentStockTemp> getListItemCurrentStockTemp() {
        return listItemCurrentStockTemp;
    }

    public void setListItemCurrentStockTemp(List<ItemCurrentStockTemp> listItemCurrentStockTemp) {
        this.listItemCurrentStockTemp = listItemCurrentStockTemp;
    }

    public String getSearchWarehouseCode() {
        return searchWarehouseCode;
    }

    public void setSearchWarehouseCode(String searchWarehouseCode) {
        this.searchWarehouseCode = searchWarehouseCode;
    }

    public String getSearchItemCode() {
        return searchItemCode;
    }

    public void setSearchItemCode(String searchItemCode) {
        this.searchItemCode = searchItemCode;
    }

    public List<PickingListSalesOrderBonusItemDetail> getListPickingListSalesOrderBonusItemDetail() {
        return listPickingListSalesOrderBonusItemDetail;
    }

    public void setListPickingListSalesOrderBonusItemDetail(List<PickingListSalesOrderBonusItemDetail> listPickingListSalesOrderBonusItemDetail) {
        this.listPickingListSalesOrderBonusItemDetail = listPickingListSalesOrderBonusItemDetail;
    }

    public List<PickingListSalesOrderBonusItemDetailTemp> getListPickingListSalesOrderBonusItemDetailTemp() {
        return listPickingListSalesOrderBonusItemDetailTemp;
    }

    public void setListPickingListSalesOrderBonusItemDetailTemp(List<PickingListSalesOrderBonusItemDetailTemp> listPickingListSalesOrderBonusItemDetailTemp) {
        this.listPickingListSalesOrderBonusItemDetailTemp = listPickingListSalesOrderBonusItemDetailTemp;
    }

    public String getListPickingListSalesOrderBonusItemDetailJSON() {
        return listPickingListSalesOrderBonusItemDetailJSON;
    }

    public void setListPickingListSalesOrderBonusItemDetailJSON(String listPickingListSalesOrderBonusItemDetailJSON) {
        this.listPickingListSalesOrderBonusItemDetailJSON = listPickingListSalesOrderBonusItemDetailJSON;
    }

    public List<PickingListSalesOrderBonusItemQuantityDetailTemp> getListPickingListSalesOrderBonusItemQuantityDetailTemp() {
        return listPickingListSalesOrderBonusItemQuantityDetailTemp;
    }

    public void setListPickingListSalesOrderBonusItemQuantityDetailTemp(List<PickingListSalesOrderBonusItemQuantityDetailTemp> listPickingListSalesOrderBonusItemQuantityDetailTemp) {
        this.listPickingListSalesOrderBonusItemQuantityDetailTemp = listPickingListSalesOrderBonusItemQuantityDetailTemp;
    }

    public String getListPickingListSalesOrderBonusItemQuantityDetailJSON() {
        return listPickingListSalesOrderBonusItemQuantityDetailJSON;
    }

    public void setListPickingListSalesOrderBonusItemQuantityDetailJSON(String listPickingListSalesOrderBonusItemQuantityDetailJSON) {
        this.listPickingListSalesOrderBonusItemQuantityDetailJSON = listPickingListSalesOrderBonusItemQuantityDetailJSON;
    }
    
    
    
}
