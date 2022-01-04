
package com.inkombizz.sales.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.InternalMemoMaterialBLL;
import com.inkombizz.sales.model.InternalMemoMaterial;
import com.inkombizz.sales.model.InternalMemoMaterialDetail;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type="json")
public class InternalMemoMaterialJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private InternalMemoMaterial internalMemoMaterial = new InternalMemoMaterial();
    private InternalMemoMaterial internalMemoMaterialApproval=new InternalMemoMaterial();
    private InternalMemoMaterial internalMemoMaterialClosing=new InternalMemoMaterial();
    private List<InternalMemoMaterial> listPurchaseRequest;
    private List<InternalMemoMaterial> listInternalMemoMaterial;
    private List<InternalMemoMaterial> listInternalMemoMaterialApproval;
    private List<InternalMemoMaterial> listInternalMemoMaterialClosing;
    
    private List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail;
    private List<InternalMemoMaterialDetail> listInternalMemoMaterialApprovalDetail;
    private List<InternalMemoMaterialDetail> listInternalMemoMaterialClosingDetail;
   
    private ArrayList arrIMMNo;
    private ArrayList arrPurchaseOrderIMMNo;
    private String listInternalMemoMaterialDetailJSON;
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
    
//  LOOK UP PURCHASE REQUEST
//    @Action("purchase-request-search-data")
//    public String findDataSearch(){
//        try{
//            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
//            
//            ListPaging <InternalMemoMaterial> listPaging = internalMemoMaterialBLL.findDataLookUp(purchaseRequestSearchCode,purchaseRequestSearchFirstDate,purchaseRequestSearchLastDate,paging);
//            
//            listPurchaseRequest = listPaging.getList();
//            
//            return SUCCESS;
//        }catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
//   Purchase Request Non Item Material Request
    @Action("internal-memo-material-data")
    public String findData() {
        try {
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            
            ListPaging <InternalMemoMaterial> listPaging = internalMemoMaterialBLL.findData(internalMemoMaterial,paging);
            
            listInternalMemoMaterial = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-detail-data")
    public String findDataDetail(){
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            List<InternalMemoMaterialDetail> list = internalMemoMaterialBLL.findDataDetail(internalMemoMaterial.getCode());
            
            listInternalMemoMaterialDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-detail-data-no")
    public String findDataDetailIMMNo(){
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            List<InternalMemoMaterialDetail> list = internalMemoMaterialBLL.findDataDetailIMMNo(arrPurchaseOrderIMMNo);
            
            listInternalMemoMaterialDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-detail-data-sub-item")
    public String findDataDetailSubItem(){
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            List<InternalMemoMaterialDetail> list = internalMemoMaterialBLL.findDataDetailSubItem(arrIMMNo);
            
            listInternalMemoMaterialDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-detail-data-sub-item-view")
    public String findDataSubItem(){
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            List<InternalMemoMaterialDetail> list = internalMemoMaterialBLL.findDataSubItem(internalMemoMaterial.getCode());
            
            listInternalMemoMaterialDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-approval-data")
    public String findDataApproval() {
        try {
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            
            ListPaging <InternalMemoMaterial> listPaging = internalMemoMaterialBLL.findDataApproval(internalMemoMaterialApproval,paging);
            
            listInternalMemoMaterialApproval = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-detail-approval-data")
    public String findDataDetailApproval(){
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            List<InternalMemoMaterialDetail> list = internalMemoMaterialBLL.findDataDetail(internalMemoMaterialApproval.getCode());
            
            listInternalMemoMaterialApprovalDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-closing-data")
    public String findDataClosing() {
        try {
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            
            ListPaging <InternalMemoMaterial> listPaging = internalMemoMaterialBLL.findDataClosing(internalMemoMaterialClosing,paging);
            
            listInternalMemoMaterialClosing = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-detail-closing-data")
    public String findDataDetailClosing(){
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            List<InternalMemoMaterialDetail> list = internalMemoMaterialBLL.findDataDetail(internalMemoMaterialClosing.getCode());
            
            listInternalMemoMaterialClosingDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-authority")
    public String internalMemoMaterialAuthority(){
        try{
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(internalMemoMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("internal-memo-material-save")
    public String save() {
        String _messg = "";
        try {
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            
            Gson gson = new Gson();
            this.listInternalMemoMaterialDetail = gson.fromJson(this.listInternalMemoMaterialDetailJSON, new TypeToken<List<InternalMemoMaterialDetail>>(){}.getType());
                        
            if(internalMemoMaterialBLL.isExist(internalMemoMaterial.getCode())){
                _messg = "UPDATED ";
                internalMemoMaterialBLL.update(internalMemoMaterial,listInternalMemoMaterialDetail);
            }else{
                _messg = "SAVED ";
                internalMemoMaterialBLL.save(internalMemoMaterial,listInternalMemoMaterialDetail);
                
            }
            
            this.message = _messg + " DATA SUCCESS. \n IMM : " + this.internalMemoMaterial.getCode();  
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-delete")
    public String delete(){
        
        String _Messg = "DELETE";
        
        try {
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(internalMemoMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            
            internalMemoMaterialBLL.delete(internalMemoMaterial.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>IMM No : " + this.internalMemoMaterial.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
        
    }
    
    @Action("internal-memo-material-approval-save")
    public String saveApproval(){
        String _Messg = "";
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            
            Gson gson = new Gson();
            
            internalMemoMaterialBLL.approval(internalMemoMaterialApproval);
            _Messg=internalMemoMaterialApproval.getApprovalStatus();
            this.message = _Messg + " DATA SUCCESS.<br/>IMM No : " + this.internalMemoMaterialApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("internal-memo-material-closing-save")
    public String saveClosing(){
        String _Messg = "CLOSE";
        try {
            
            InternalMemoMaterialBLL internalMemoMaterialBLL = new InternalMemoMaterialBLL(hbmSession);
            internalMemoMaterialClosing.setClosingStatus(EnumClosingStatus.ENUM_ClosingStatus.CLOSED.toString());
            internalMemoMaterialBLL.closing(internalMemoMaterialClosing);

            this.message = _Messg + " DATA SUCCESS.<br/>IMM No : " + this.internalMemoMaterialClosing.getCode();

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

    public InternalMemoMaterial getInternalMemoMaterial() {
        return internalMemoMaterial;
    }

    public void setInternalMemoMaterial(InternalMemoMaterial internalMemoMaterial) {
        this.internalMemoMaterial = internalMemoMaterial;
    }

    public InternalMemoMaterial getInternalMemoMaterialApproval() {
        return internalMemoMaterialApproval;
    }

    public void setInternalMemoMaterialApproval(InternalMemoMaterial internalMemoMaterialApproval) {
        this.internalMemoMaterialApproval = internalMemoMaterialApproval;
    }

    public InternalMemoMaterial getInternalMemoMaterialClosing() {
        return internalMemoMaterialClosing;
    }

    public void setInternalMemoMaterialClosing(InternalMemoMaterial internalMemoMaterialClosing) {
        this.internalMemoMaterialClosing = internalMemoMaterialClosing;
    }

    public List<InternalMemoMaterial> getListPurchaseRequest() {
        return listPurchaseRequest;
    }

    public void setListPurchaseRequest(List<InternalMemoMaterial> listPurchaseRequest) {
        this.listPurchaseRequest = listPurchaseRequest;
    }

    public List<InternalMemoMaterial> getListInternalMemoMaterial() {
        return listInternalMemoMaterial;
    }

    public void setListInternalMemoMaterial(List<InternalMemoMaterial> listInternalMemoMaterial) {
        this.listInternalMemoMaterial = listInternalMemoMaterial;
    }

    public List<InternalMemoMaterial> getListInternalMemoMaterialApproval() {
        return listInternalMemoMaterialApproval;
    }

    public void setListInternalMemoMaterialApproval(List<InternalMemoMaterial> listInternalMemoMaterialApproval) {
        this.listInternalMemoMaterialApproval = listInternalMemoMaterialApproval;
    }

    public List<InternalMemoMaterial> getListInternalMemoMaterialClosing() {
        return listInternalMemoMaterialClosing;
    }

    public void setListInternalMemoMaterialClosing(List<InternalMemoMaterial> listInternalMemoMaterialClosing) {
        this.listInternalMemoMaterialClosing = listInternalMemoMaterialClosing;
    }

    public List<InternalMemoMaterialDetail> getListInternalMemoMaterialDetail() {
        return listInternalMemoMaterialDetail;
    }

    public void setListInternalMemoMaterialDetail(List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail) {
        this.listInternalMemoMaterialDetail = listInternalMemoMaterialDetail;
    }

    public String getListInternalMemoMaterialDetailJSON() {
        return listInternalMemoMaterialDetailJSON;
    }

    public void setListInternalMemoMaterialDetailJSON(String listInternalMemoMaterialDetailJSON) {
        this.listInternalMemoMaterialDetailJSON = listInternalMemoMaterialDetailJSON;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<InternalMemoMaterialDetail> getListInternalMemoMaterialApprovalDetail() {
        return listInternalMemoMaterialApprovalDetail;
    }

    public void setListInternalMemoMaterialApprovalDetail(List<InternalMemoMaterialDetail> listInternalMemoMaterialApprovalDetail) {
        this.listInternalMemoMaterialApprovalDetail = listInternalMemoMaterialApprovalDetail;
    }

    public ArrayList getArrIMMNo() {
        return arrIMMNo;
    }

    public void setArrIMMNo(ArrayList arrIMMNo) {
        this.arrIMMNo = arrIMMNo;
    }

    public ArrayList getArrPurchaseOrderIMMNo() {
        return arrPurchaseOrderIMMNo;
    }

    public void setArrPurchaseOrderIMMNo(ArrayList arrPurchaseOrderIMMNo) {
        this.arrPurchaseOrderIMMNo = arrPurchaseOrderIMMNo;
    }

    public List<InternalMemoMaterialDetail> getListInternalMemoMaterialClosingDetail() {
        return listInternalMemoMaterialClosingDetail;
    }

    public void setListInternalMemoMaterialClosingDetail(List<InternalMemoMaterialDetail> listInternalMemoMaterialClosingDetail) {
        this.listInternalMemoMaterialClosingDetail = listInternalMemoMaterialClosingDetail;
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
