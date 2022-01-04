
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ValveTypeComponentBLL;
import com.inkombizz.master.model.ValveType;
import com.inkombizz.master.model.ValveTypeComponentTemp;
import com.inkombizz.master.model.ValveTypeComponent;
import com.inkombizz.master.model.ValveTypeComponentDetail;
import com.inkombizz.master.model.ValveTypeComponentDetailTemp;
import com.inkombizz.master.model.ValveTypeTemp;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.UserBranch;
import com.inkombizz.utils.MD5Encrypt;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ValveTypeComponentJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ValveType valveType;
    private ValveTypeComponentDetailTemp valveTypeComponentDetailTemp;
    private ValveTypeComponent valveTypeComponent;
    private ValveTypeComponentTemp valveTypeComponentTemp;
    private List <ValveTypeComponentTemp> listValveTypeComponentTemp;
    private ValveTypeComponent searchValveTypeComponent = new ValveTypeComponent();
    private List <ValveTypeComponent> listValveTypeComponent;
    private List <ValveTypeComponentDetail> listValveTypeComponentDetail;
    private List <ValveTypeComponentDetailTemp> listValveTypeComponentDetailTemp;
    private String valveTypeComponentSearchCode = "";
    private String valveTypeComponentSearchName = "";
    private String valveTypeComponentSearchActiveStatus="true";
    private String actionAuthority="";
    private String listValveTypeComponentDetailJSON;
     private EnumTriState.Enum_TriState searchValveTypeComponentActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-data")
    public String findData() {
        try {
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            ListPaging <ValveTypeComponentTemp> listPaging = valveTypeComponentBLL.findData(valveTypeComponentSearchCode,valveTypeComponentSearchName,valveTypeComponentSearchActiveStatus,paging);
            
            listValveTypeComponentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-detail-data")
    public String findDataDetail(){
        try {
            
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            List<ValveTypeComponentDetailTemp> list = valveTypeComponentBLL.findDataDetail(valveType.getCode());

            listValveTypeComponentDetailTemp = list;
            return SUCCESS; 
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-get-data")
    public String findData1() {
        try {
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            this.valveTypeComponentTemp = valveTypeComponentBLL.findData(this.valveTypeComponent.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-detail")
    public String GetData1() {
        try {
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            List<ValveTypeComponentTemp> list = valveTypeComponentBLL.getDataDetail(valveTypeComponent.getCode());
            
            listValveTypeComponentTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-get")
    public String findData2() {
        try {
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            this.valveTypeComponentTemp = valveTypeComponentBLL.findData(this.valveTypeComponent.getCode(),this.valveTypeComponent.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-check")
    public String checkValveType() {
      
           try {
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            this.valveTypeComponentDetailTemp = valveTypeComponentBLL.checkValveType(this.valveType.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-authority")
    public String valveTypeComponentAuthority(){
        try{
            
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(valveTypeComponentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(valveTypeComponentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(valveTypeComponentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("valve-type-component-search")
    public String search() {
        try {
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            
            ListPaging <ValveTypeComponent> listPaging = valveTypeComponentBLL.search(paging, searchValveTypeComponent.getCode(), searchValveTypeComponent.getName(), searchValveTypeComponentActiveStatus);
            
            listValveTypeComponent = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("valve-type-component-update")
    public String update() {
        try {
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            
            valveTypeComponentBLL.update(this.valveTypeComponent);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.valveTypeComponent.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("valve-type-component-save")
    public String save() {
            String _messg = "";
        try{
            ValveTypeComponentBLL valveTypeComponentBLL = new ValveTypeComponentBLL(hbmSession);
            
            Gson gson1 = new Gson();
            this.listValveTypeComponentDetail = gson1.fromJson(this.listValveTypeComponentDetailJSON, new TypeToken<List<ValveTypeComponentDetail>>(){}.getType());
       
            if (!BaseSession.loadProgramSession().hasAuthority(valveTypeComponentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                this.error = true;
                this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                return SUCCESS;
            }   

            valveTypeComponentBLL.save(valveTypeComponent,listValveTypeComponentDetail);
            
            this.message = _messg + "UPDATE DATA SUCCESS. \n Valve Type Code : " + this.valveTypeComponent.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ValveTypeComponent getValveTypeComponent() {
        return valveTypeComponent;
    }

    public void setValveTypeComponent(ValveTypeComponent valveTypeComponent) {
        this.valveTypeComponent = valveTypeComponent;
    }

    public ValveTypeComponentTemp getValveTypeComponentTemp() {
        return valveTypeComponentTemp;
    }

    public void setValveTypeComponentTemp(ValveTypeComponentTemp valveTypeComponentTemp) {
        this.valveTypeComponentTemp = valveTypeComponentTemp;
    }

    public List<ValveTypeComponentTemp> getListValveTypeComponentTemp() {
        return listValveTypeComponentTemp;
    }

    public void setListValveTypeComponentTemp(List<ValveTypeComponentTemp> listValveTypeComponentTemp) {
        this.listValveTypeComponentTemp = listValveTypeComponentTemp;
    }

    public String getValveTypeComponentSearchCode() {
        return valveTypeComponentSearchCode;
    }

    public void setValveTypeComponentSearchCode(String valveTypeComponentSearchCode) {
        this.valveTypeComponentSearchCode = valveTypeComponentSearchCode;
    }

    public String getValveTypeComponentSearchName() {
        return valveTypeComponentSearchName;
    }

    public void setValveTypeComponentSearchName(String valveTypeComponentSearchName) {
        this.valveTypeComponentSearchName = valveTypeComponentSearchName;
    }

    public String getValveTypeComponentSearchActiveStatus() {
        return valveTypeComponentSearchActiveStatus;
    }

    public void setValveTypeComponentSearchActiveStatus(String valveTypeComponentSearchActiveStatus) {
        this.valveTypeComponentSearchActiveStatus = valveTypeComponentSearchActiveStatus;
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

    public ValveTypeComponent getSearchValveTypeComponent() {
        return searchValveTypeComponent;
    }

    public void setSearchValveTypeComponent(ValveTypeComponent searchValveTypeComponent) {
        this.searchValveTypeComponent = searchValveTypeComponent;
    }

    public EnumTriState.Enum_TriState getSearchValveTypeComponentActiveStatus() {
        return searchValveTypeComponentActiveStatus;
    }

    public void setSearchValveTypeComponentActiveStatus(EnumTriState.Enum_TriState searchValveTypeComponentActiveStatus) {
        this.searchValveTypeComponentActiveStatus = searchValveTypeComponentActiveStatus;
    }

    public List<ValveTypeComponent> getListValveTypeComponent() {
        return listValveTypeComponent;
    }

    public void setListValveTypeComponent(List<ValveTypeComponent> listValveTypeComponent) {
        this.listValveTypeComponent = listValveTypeComponent;
    }

    public List<ValveTypeComponentDetail> getListValveTypeComponentDetail() {
        return listValveTypeComponentDetail;
    }

    public void setListValveTypeComponentDetail(List<ValveTypeComponentDetail> listValveTypeComponentDetail) {
        this.listValveTypeComponentDetail = listValveTypeComponentDetail;
    }

    public String getListValveTypeComponentDetailJSON() {
        return listValveTypeComponentDetailJSON;
    }

    public void setListValveTypeComponentDetailJSON(String listValveTypeComponentDetailJSON) {
        this.listValveTypeComponentDetailJSON = listValveTypeComponentDetailJSON;
    }

    public List<ValveTypeComponentDetailTemp> getListValveTypeComponentDetailTemp() {
        return listValveTypeComponentDetailTemp;
    }

    public void setListValveTypeComponentDetailTemp(List<ValveTypeComponentDetailTemp> listValveTypeComponentDetailTemp) {
        this.listValveTypeComponentDetailTemp = listValveTypeComponentDetailTemp;
    }

    public ValveType getValveType() {
        return valveType;
    }

    public void setValveType(ValveType valveType) {
        this.valveType = valveType;
    }

    public ValveTypeComponentDetailTemp getValveTypeComponentDetailTemp() {
        return valveTypeComponentDetailTemp;
    }

    public void setValveTypeComponentDetailTemp(ValveTypeComponentDetailTemp valveTypeComponentDetailTemp) {
        this.valveTypeComponentDetailTemp = valveTypeComponentDetailTemp;
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
