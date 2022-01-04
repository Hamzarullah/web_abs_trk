
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ReasonBLL;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.ReasonModuleDetail;
import com.inkombizz.master.model.ReasonModuleDetailTemp;
import com.inkombizz.master.model.ReasonTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ReasonJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Reason reason;
    private ReasonTemp reasonTemp;
    private List <ReasonTemp> listReasonTemp;
    private String reasonSearchCode = "";
    private String reasonSearchName = "";
    private String reasonSearchActiveStatus="true";
    private String actionAuthority="";
    private List<ReasonModuleDetail> listReasonModuleCoa;
    private List<ReasonModuleDetailTemp> listReasonModuleCoaTemp;
    private String listReasonModuleCoaJSON = "";  
    private int count=0;
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("reason-data")
    public String findData() {
        try {
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);
            ListPaging <ReasonTemp> listPaging = reasonBLL.findData(reasonSearchCode,reasonSearchName,reasonSearchActiveStatus,paging);
            
            listReasonTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("reason-module-coa-reload-grid-update")
    public String findDataReasonModuleCoaUpdate() {
        try{
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);            
            List<ReasonModuleDetailTemp> list = reasonBLL.findDataReasonModuleCoaTempUpdate(this.reason.getCode());
            
            listReasonModuleCoaTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    @Action("reason-get-data")
    public String findData1() {
        try {
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);
            this.reasonTemp = reasonBLL.findData(this.reason.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("reason-module-coa-reload-grid-new")
    public String findDataReasonModuleCoaNew() {
        try{
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);            
            List<ReasonModuleDetailTemp> list = reasonBLL.findDataReasonModuleCoaTempNew();
            
            listReasonModuleCoaTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
     @Action("reason-detail-count")
    public String goodsReceivedDetailCount(){
        try{
            
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);          
            
            this.count= reasonBLL.countDetail(this.reason.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    @Action("reason-get")
    public String findData2() {
        try {
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);
            this.reasonTemp = reasonBLL.findData(this.reason.getCode(),this.reason.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("reason-module-coa-reload-grid")
    public String findDataReasonModuleCoa() {
        try{
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);            
            List<ReasonModuleDetailTemp> list = reasonBLL.findDataReasonModuleCoaTemp(this.reason.getCode());
            
            listReasonModuleCoaTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("reason-authority")
    public String reasonAuthority(){
        try{
            
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(reasonBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(reasonBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(reasonBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("reason-save")
    public String save() {
        try {
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);
            Gson gson = new Gson();
            this.listReasonModuleCoa = gson.fromJson(this.listReasonModuleCoaJSON, new TypeToken<List<ReasonModuleDetail>>(){}.getType());
            if(reasonBLL.isExist(this.reason.getCode())){
                this.errorMessage = "CODE "+this.reason.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                reasonBLL.save(this.reason,this.listReasonModuleCoa);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.reason.getCode();
            }
            
            return SUCCESS;
            
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("reason-update")
    public String update() {
        try {
            ReasonBLL reasonBLL = new ReasonBLL(hbmSession);
             Gson gson = new Gson();
            this.listReasonModuleCoa = gson.fromJson(this.listReasonModuleCoaJSON, new TypeToken<List<ReasonModuleDetail>>(){}.getType());
            reasonBLL.update(this.reason,this.listReasonModuleCoa);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.reason.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("reason-delete")
    public String delete() {
        try {
           ReasonBLL reasonBLL = new ReasonBLL(hbmSession);
            reasonBLL.delete(this.reason.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.reason.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Reason getReason() {
        return reason;
    }

    public void setReason(Reason reason) {
        this.reason = reason;
    }

    public ReasonTemp getReasonTemp() {
        return reasonTemp;
    }

    public void setReasonTemp(ReasonTemp reasonTemp) {
        this.reasonTemp = reasonTemp;
    }

    public List<ReasonTemp> getListReasonTemp() {
        return listReasonTemp;
    }

    public void setListReasonTemp(List<ReasonTemp> listReasonTemp) {
        this.listReasonTemp = listReasonTemp;
    }

    public String getReasonSearchCode() {
        return reasonSearchCode;
    }

    public void setReasonSearchCode(String reasonSearchCode) {
        this.reasonSearchCode = reasonSearchCode;
    }

    public String getReasonSearchName() {
        return reasonSearchName;
    }

    public void setReasonSearchName(String reasonSearchName) {
        this.reasonSearchName = reasonSearchName;
    }

    public String getReasonSearchActiveStatus() {
        return reasonSearchActiveStatus;
    }

    public void setReasonSearchActiveStatus(String reasonSearchActiveStatus) {
        this.reasonSearchActiveStatus = reasonSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public List<ReasonModuleDetailTemp> getListReasonModuleCoaTemp() {
        return listReasonModuleCoaTemp;
    }

    public void setListReasonModuleCoaTemp(List<ReasonModuleDetailTemp> listReasonModuleCoaTemp) {
        this.listReasonModuleCoaTemp = listReasonModuleCoaTemp;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public List<ReasonModuleDetail> getListReasonModuleCoa() {
        return listReasonModuleCoa;
    }

    public void setListReasonModuleCoa(List<ReasonModuleDetail> listReasonModuleCoa) {
        this.listReasonModuleCoa = listReasonModuleCoa;
    }

    public String getListReasonModuleCoaJSON() {
        return listReasonModuleCoaJSON;
    }

    public void setListReasonModuleCoaJSON(String listReasonModuleCoaJSON) {
        this.listReasonModuleCoaJSON = listReasonModuleCoaJSON;
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
