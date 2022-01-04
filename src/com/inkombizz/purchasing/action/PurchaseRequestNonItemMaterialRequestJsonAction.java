
package com.inkombizz.purchasing.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.bll.PurchaseRequestNonItemMaterialRequestBLL;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequestDetail;
import com.inkombizz.utils.DateUtils;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type="json")
public class PurchaseRequestNonItemMaterialRequestJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest = new PurchaseRequestNonItemMaterialRequest();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval=new PurchaseRequestNonItemMaterialRequest();
    private PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosing=new PurchaseRequestNonItemMaterialRequest();
    private List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequest;
    private List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequest;
    private List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequestApproval;
    private List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequestClosing;
    
    private List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail;
   
    private ArrayList arrPurchaseOrderNo;
    private ArrayList arrPurchaseOrderPRQNo;
    private String listPurchaseRequestNonItemMaterialRequestDetailJSON;
    private String purchaseRequestNonStatus="";
    private String actionAuthority="";
    private String purchaseRequestSearchCode="";
    private Date purchaseRequestSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());;
    private Date purchaseRequestSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());;
    
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
//  LOOK UP PURCHASE REQUEST
    @Action("purchase-request-search-data")
    public String findDataSearch(){
        try{
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            ListPaging <PurchaseRequestNonItemMaterialRequest> listPaging = purchaseRequestNonItemMaterialRequestBLL.findDataLookUp(purchaseRequestSearchCode,purchaseRequestSearchFirstDate,purchaseRequestSearchLastDate,paging);
            
            listPurchaseRequest = listPaging.getList();
            
            return SUCCESS;
        }catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//   Purchase Request Non Item Material Request
    @Action("purchase-request-non-item-material-request-data")
    public String findData() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            ListPaging <PurchaseRequestNonItemMaterialRequest> listPaging = purchaseRequestNonItemMaterialRequestBLL.findData(purchaseRequestNonItemMaterialRequest,paging);
            
            listPurchaseRequestNonItemMaterialRequest = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-detail-data")
    public String findDataDetail(){
        try {
            
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            List<PurchaseRequestNonItemMaterialRequestDetail> list = purchaseRequestNonItemMaterialRequestBLL.findDataDetail(purchaseRequestNonItemMaterialRequest.getCode());
            
            listPurchaseRequestNonItemMaterialRequestDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-detail-data-no")
    public String findDataDetailPRQNo(){
        try {
            
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            List<PurchaseRequestNonItemMaterialRequestDetail> list = purchaseRequestNonItemMaterialRequestBLL.findDataDetailPRQNo(arrPurchaseOrderPRQNo,purchaseRequestNonStatus);
            
            listPurchaseRequestNonItemMaterialRequestDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-item-material-request-detail-data")
    public String findDataDetailSubItem(){
        try {
            
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            List<PurchaseRequestNonItemMaterialRequestDetail> list = purchaseRequestNonItemMaterialRequestBLL.findDataDetailSubItem(arrPurchaseOrderNo);
            
            listPurchaseRequestNonItemMaterialRequestDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-detail-data-sub-item-view")
    public String findDataSubItem(){
        try {
            
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            List<PurchaseRequestNonItemMaterialRequestDetail> list = purchaseRequestNonItemMaterialRequestBLL.findDataSubItem(purchaseRequestNonItemMaterialRequest.getCode());
            
            listPurchaseRequestNonItemMaterialRequestDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-approval-data")
    public String findDataApproval() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            ListPaging <PurchaseRequestNonItemMaterialRequest> listPaging = purchaseRequestNonItemMaterialRequestBLL.findDataApproval(purchaseRequestNonItemMaterialRequestApproval,paging);
            
            listPurchaseRequestNonItemMaterialRequestApproval = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-closing-data")
    public String findDataClosing() {
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            ListPaging <PurchaseRequestNonItemMaterialRequest> listPaging = purchaseRequestNonItemMaterialRequestBLL.findDataClosing(purchaseRequestNonItemMaterialRequestClosing,paging);
            
            listPurchaseRequestNonItemMaterialRequestClosing = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-authority")
    public String purchaseRequestNonItemMaterialRequestAuthority(){
        try{
            
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("purchase-request-non-item-material-request-save")
    public String save() {
        String _messg = "";
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            Gson gson = new Gson();
            this.listPurchaseRequestNonItemMaterialRequestDetail = gson.fromJson(this.listPurchaseRequestNonItemMaterialRequestDetailJSON, new TypeToken<List<PurchaseRequestNonItemMaterialRequestDetail>>(){}.getType());
                        
            if(purchaseRequestNonItemMaterialRequestBLL.isExist(purchaseRequestNonItemMaterialRequest.getCode())){
                _messg = "UPDATED ";
                purchaseRequestNonItemMaterialRequestBLL.update(purchaseRequestNonItemMaterialRequest,listPurchaseRequestNonItemMaterialRequestDetail);
            }else{
                _messg = "SAVED ";
                purchaseRequestNonItemMaterialRequestBLL.save(purchaseRequestNonItemMaterialRequest,listPurchaseRequestNonItemMaterialRequestDetail);
                
            }
            
            this.message = _messg + " DATA SUCCESS. \n PRQ-NSO : " + this.purchaseRequestNonItemMaterialRequest.getCode();  
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-delete")
    public String delete(){
        
        String _Messg = "DELETE";
        
        try {
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(purchaseRequestNonItemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            
            purchaseRequestNonItemMaterialRequestBLL.delete(purchaseRequestNonItemMaterialRequest.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>PRQ-NSO No : " + this.purchaseRequestNonItemMaterialRequest.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
        
    }
    
    @Action("purchase-request-non-item-material-request-approval-save")
    public String saveApproval(){
        String _Messg = "";
        try {
            
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            
            Gson gson = new Gson();
            this.listPurchaseRequestNonItemMaterialRequestDetail = gson.fromJson(this.listPurchaseRequestNonItemMaterialRequestDetailJSON, new TypeToken<List<PurchaseRequestNonItemMaterialRequestDetail>>(){}.getType());
            
            purchaseRequestNonItemMaterialRequestBLL.approval(purchaseRequestNonItemMaterialRequestApproval,listPurchaseRequestNonItemMaterialRequestDetail);
            _Messg=purchaseRequestNonItemMaterialRequestApproval.getApprovalStatus();
            this.message = _Messg + " DATA SUCCESS.<br/>PRQ-NSO No : " + this.purchaseRequestNonItemMaterialRequestApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-request-non-item-material-request-closing-save")
    public String saveClosing(){
        String _Messg = "CLOSE";
        try {
            
            PurchaseRequestNonItemMaterialRequestBLL purchaseRequestNonItemMaterialRequestBLL = new PurchaseRequestNonItemMaterialRequestBLL(hbmSession);
            purchaseRequestNonItemMaterialRequestClosing.setClosingStatus(EnumClosingStatus.ENUM_ClosingStatus.CLOSED.toString());
            purchaseRequestNonItemMaterialRequestBLL.closing(purchaseRequestNonItemMaterialRequestClosing);

            this.message = _Messg + " DATA SUCCESS.<br/>PRQ-NSO No : " + this.purchaseRequestNonItemMaterialRequestClosing.getCode();

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

    public PurchaseRequestNonItemMaterialRequest getPurchaseRequestNonItemMaterialRequest() {
        return purchaseRequestNonItemMaterialRequest;
    }

    public void setPurchaseRequestNonItemMaterialRequest(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest) {
        this.purchaseRequestNonItemMaterialRequest = purchaseRequestNonItemMaterialRequest;
    }

    public PurchaseRequestNonItemMaterialRequest getPurchaseRequestNonItemMaterialRequestApproval() {
        return purchaseRequestNonItemMaterialRequestApproval;
    }

    public void setPurchaseRequestNonItemMaterialRequestApproval(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval) {
        this.purchaseRequestNonItemMaterialRequestApproval = purchaseRequestNonItemMaterialRequestApproval;
    }

    public PurchaseRequestNonItemMaterialRequest getPurchaseRequestNonItemMaterialRequestClosing() {
        return purchaseRequestNonItemMaterialRequestClosing;
    }

    public void setPurchaseRequestNonItemMaterialRequestClosing(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosing) {
        this.purchaseRequestNonItemMaterialRequestClosing = purchaseRequestNonItemMaterialRequestClosing;
    }

    public List<PurchaseRequestNonItemMaterialRequest> getListPurchaseRequest() {
        return listPurchaseRequest;
    }

    public void setListPurchaseRequest(List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequest) {
        this.listPurchaseRequest = listPurchaseRequest;
    }

    public List<PurchaseRequestNonItemMaterialRequest> getListPurchaseRequestNonItemMaterialRequest() {
        return listPurchaseRequestNonItemMaterialRequest;
    }

    public void setListPurchaseRequestNonItemMaterialRequest(List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequest) {
        this.listPurchaseRequestNonItemMaterialRequest = listPurchaseRequestNonItemMaterialRequest;
    }

    public List<PurchaseRequestNonItemMaterialRequest> getListPurchaseRequestNonItemMaterialRequestApproval() {
        return listPurchaseRequestNonItemMaterialRequestApproval;
    }

    public void setListPurchaseRequestNonItemMaterialRequestApproval(List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequestApproval) {
        this.listPurchaseRequestNonItemMaterialRequestApproval = listPurchaseRequestNonItemMaterialRequestApproval;
    }

    public List<PurchaseRequestNonItemMaterialRequest> getListPurchaseRequestNonItemMaterialRequestClosing() {
        return listPurchaseRequestNonItemMaterialRequestClosing;
    }

    public void setListPurchaseRequestNonItemMaterialRequestClosing(List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequestClosing) {
        this.listPurchaseRequestNonItemMaterialRequestClosing = listPurchaseRequestNonItemMaterialRequestClosing;
    }

    public List<PurchaseRequestNonItemMaterialRequestDetail> getListPurchaseRequestNonItemMaterialRequestDetail() {
        return listPurchaseRequestNonItemMaterialRequestDetail;
    }

    public void setListPurchaseRequestNonItemMaterialRequestDetail(List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail) {
        this.listPurchaseRequestNonItemMaterialRequestDetail = listPurchaseRequestNonItemMaterialRequestDetail;
    }

    public String getListPurchaseRequestNonItemMaterialRequestDetailJSON() {
        return listPurchaseRequestNonItemMaterialRequestDetailJSON;
    }

    public void setListPurchaseRequestNonItemMaterialRequestDetailJSON(String listPurchaseRequestNonItemMaterialRequestDetailJSON) {
        this.listPurchaseRequestNonItemMaterialRequestDetailJSON = listPurchaseRequestNonItemMaterialRequestDetailJSON;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public ArrayList getArrPurchaseOrderNo() {
        return arrPurchaseOrderNo;
    }

    public void setArrPurchaseOrderNo(ArrayList arrPurchaseOrderNo) {
        this.arrPurchaseOrderNo = arrPurchaseOrderNo;
    }

    public ArrayList getArrPurchaseOrderPRQNo() {
        return arrPurchaseOrderPRQNo;
    }

    public void setArrPurchaseOrderPRQNo(ArrayList arrPurchaseOrderPRQNo) {
        this.arrPurchaseOrderPRQNo = arrPurchaseOrderPRQNo;
    }

    public String getPurchaseRequestNonStatus() {
        return purchaseRequestNonStatus;
    }

    public void setPurchaseRequestNonStatus(String purchaseRequestNonStatus) {
        this.purchaseRequestNonStatus = purchaseRequestNonStatus;
    }

    public String getPurchaseRequestSearchCode() {
        return purchaseRequestSearchCode;
    }

    public void setPurchaseRequestSearchCode(String purchaseRequestSearchCode) {
        this.purchaseRequestSearchCode = purchaseRequestSearchCode;
    }

    public Date getPurchaseRequestSearchFirstDate() {
        return purchaseRequestSearchFirstDate;
    }

    public void setPurchaseRequestSearchFirstDate(Date purchaseRequestSearchFirstDate) {
        this.purchaseRequestSearchFirstDate = purchaseRequestSearchFirstDate;
    }

    public Date getPurchaseRequestSearchLastDate() {
        return purchaseRequestSearchLastDate;
    }

    public void setPurchaseRequestSearchLastDate(Date purchaseRequestSearchLastDate) {
        this.purchaseRequestSearchLastDate = purchaseRequestSearchLastDate;
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
