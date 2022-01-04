/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestBySalesOrderBLL;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrderDetail;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;


@Result (type="json")
public class PurchaseRequestBySalesOrderJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private List<PurchaseRequestBySalesOrder> listPurchaseRequest;
    private List<PurchaseRequestBySalesOrder> listPurchaseRequestApproval;
    private List<PurchaseRequestBySalesOrder> listPurchaseRequestClosing;
    
    private PurchaseRequestBySalesOrder purchaseRequest = new PurchaseRequestBySalesOrder();
    private PurchaseRequestBySalesOrder purchaseRequestApproval=new PurchaseRequestBySalesOrder();
    private PurchaseRequestBySalesOrder purchaseRequestClosing=new PurchaseRequestBySalesOrder();
    
    private List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestDetail;
    private List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestApprovalDetail;
    private List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestClosingDetail;
    
    private String listPurchaseRequestDetailJSON;
    private String actionAuthority="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-data")
    public String findData() {
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            ListPaging<PurchaseRequestBySalesOrder> listPaging = purchaseRequestBLL.findData(purchaseRequest,paging);
            
            listPurchaseRequest = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-detail-data")
    public String findDataDetail(){
        try {
            
            PurchaseRequestBySalesOrderBLL purchaseRequestNonSalesOrderBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            List<PurchaseRequestBySalesOrderDetail> list = purchaseRequestNonSalesOrderBLL.findDataDetail(purchaseRequest.getCode());
            
            listPurchaseRequestDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-approval-data")
    public String findDataApproval() {
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            ListPaging <PurchaseRequestBySalesOrder> listPaging = purchaseRequestBLL.findDataApproval(purchaseRequestApproval,paging);
            
            listPurchaseRequestApproval = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-closing-data")
    public String findDataClosing() {
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            ListPaging <PurchaseRequestBySalesOrder> listPaging = purchaseRequestBLL.findDataClosing(purchaseRequestClosing,paging);
            
            listPurchaseRequestClosing = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-authority")
    public String purchaseRequestAuthority(){
        try{
            
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
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
    
    @Action("purchase-request-save")
    public String save() {
        String _messg = "";
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            Gson gson = new Gson();
            this.listPurchaseRequestDetail = gson.fromJson(this.listPurchaseRequestDetailJSON, new TypeToken<List<PurchaseRequestBySalesOrderDetail>>(){}.getType());
            
            if(purchaseRequestBLL.isExist(purchaseRequest.getCode())){
                _messg = "UPDATED ";
                purchaseRequestBLL.update(purchaseRequest,listPurchaseRequestDetail);
                this.message = "UPDATE DATA SUCCESS. \n Code : " + this.purchaseRequest.getCode();
            }else{
                _messg = "SAVED ";
                purchaseRequestBLL.save(purchaseRequest,listPurchaseRequestDetail);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.purchaseRequest.getCode();  
            }
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-delete")
    public String delete(){
        
        String _Messg = "DELETE";
        
        try {
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            
            purchaseRequestBLL.delete(purchaseRequest.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>CCN No : " + this.purchaseRequest.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
        
    }
    
    @Action("purchase-request-approval-save")
    public String saveApproval(){
        String _Messg = "";
        try {
            
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
        
            purchaseRequestBLL.approval(purchaseRequestApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>PRQ No : " + this.purchaseRequestApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-closing-save")
    public String saveClosing(){
        String _Messg = "";
        try {
            
            PurchaseRequestBySalesOrderBLL purchaseRequestBLL = new PurchaseRequestBySalesOrderBLL(hbmSession);
        
            purchaseRequestBLL.closing(purchaseRequestClosing);

            this.message = _Messg + " DATA SUCCESS.<br/>PRQ No : " + this.purchaseRequestClosing.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
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

    public List<PurchaseRequestBySalesOrder> getListPurchaseRequest() {
        return listPurchaseRequest;
    }

    public void setListPurchaseRequest(List<PurchaseRequestBySalesOrder> listPurchaseRequest) {
        this.listPurchaseRequest = listPurchaseRequest;
    }

    public List<PurchaseRequestBySalesOrder> getListPurchaseRequestApproval() {
        return listPurchaseRequestApproval;
    }

    public void setListPurchaseRequestApproval(List<PurchaseRequestBySalesOrder> listPurchaseRequestApproval) {
        this.listPurchaseRequestApproval = listPurchaseRequestApproval;
    }

    public List<PurchaseRequestBySalesOrder> getListPurchaseRequestClosing() {
        return listPurchaseRequestClosing;
    }

    public void setListPurchaseRequestClosing(List<PurchaseRequestBySalesOrder> listPurchaseRequestClosing) {
        this.listPurchaseRequestClosing = listPurchaseRequestClosing;
    }

    public PurchaseRequestBySalesOrder getPurchaseRequest() {
        return purchaseRequest;
    }

    public void setPurchaseRequest(PurchaseRequestBySalesOrder purchaseRequest) {
        this.purchaseRequest = purchaseRequest;
    }

    public PurchaseRequestBySalesOrder getPurchaseRequestApproval() {
        return purchaseRequestApproval;
    }

    public void setPurchaseRequestApproval(PurchaseRequestBySalesOrder purchaseRequestApproval) {
        this.purchaseRequestApproval = purchaseRequestApproval;
    }

    public PurchaseRequestBySalesOrder getPurchaseRequestClosing() {
        return purchaseRequestClosing;
    }

    public void setPurchaseRequestClosing(PurchaseRequestBySalesOrder purchaseRequestClosing) {
        this.purchaseRequestClosing = purchaseRequestClosing;
    }

    public List<PurchaseRequestBySalesOrderDetail> getListPurchaseRequestDetail() {
        return listPurchaseRequestDetail;
    }

    public void setListPurchaseRequestDetail(List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestDetail) {
        this.listPurchaseRequestDetail = listPurchaseRequestDetail;
    }

    public List<PurchaseRequestBySalesOrderDetail> getListPurchaseRequestApprovalDetail() {
        return listPurchaseRequestApprovalDetail;
    }

    public void setListPurchaseRequestApprovalDetail(List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestApprovalDetail) {
        this.listPurchaseRequestApprovalDetail = listPurchaseRequestApprovalDetail;
    }

    public List<PurchaseRequestBySalesOrderDetail> getListPurchaseRequestClosingDetail() {
        return listPurchaseRequestClosingDetail;
    }

    public void setListPurchaseRequestClosingDetail(List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestClosingDetail) {
        this.listPurchaseRequestClosingDetail = listPurchaseRequestClosingDetail;
    }

    public String getListPurchaseRequestDetailJSON() {
        return listPurchaseRequestDetailJSON;
    }

    public void setListPurchaseRequestDetailJSON(String listPurchaseRequestDetailJSON) {
        this.listPurchaseRequestDetailJSON = listPurchaseRequestDetailJSON;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
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
    
    Paging paging=new Paging();
    
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
