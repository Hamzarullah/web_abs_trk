
package com.inkombizz.master.action;


import com.inkombizz.action.BaseSession;
import com.inkombizz.action.ProgramSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ExpeditionBLL;
import com.inkombizz.master.bll.GlobalBLL;
import com.inkombizz.master.model.Expedition;
import com.inkombizz.master.model.ExpeditionTemp;
import com.inkombizz.master.model.Global;
import static com.opensymphony.xwork2.Action.SUCCESS;

@Result(type="json")
public class ExpeditionJsonAction extends ActionSupport{
    
    private static final long serialVersionUID=1L;
    
    protected HBMSession hbmSession=new HBMSession();
    
    private ProgramSession prgSession = new ProgramSession();
    
    private Expedition expedition;
    private ExpeditionTemp expeditionTemp;
    private List <ExpeditionTemp> listExpeditionTemp;
    private String expeditionSearchCode = "";
    private String expeditionSearchName = "";
    private String expeditionSearchActiveStatus = "true";
    private String actionAuthority="";
    private List<Global> lstGlobal;
    
    @Override
    public String execute(){
        try{
            return findData();
        }
        catch(Exception Ex){
            return SUCCESS;
        }
    }
    
    @Action("expedition-data")
    public String findData() {
        try {
            ExpeditionBLL expeditionBLL = new ExpeditionBLL(hbmSession);
            ListPaging <ExpeditionTemp> listPaging = expeditionBLL.findData(paging,expeditionSearchCode,expeditionSearchName,expeditionSearchActiveStatus);
            
            listExpeditionTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("expedition-get-data")
    public String findData1() {
        try {
            ExpeditionBLL expeditionBLL = new ExpeditionBLL(hbmSession);
            this.expeditionTemp = expeditionBLL.findData(this.expedition.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("expedition-get")
    public String findData2() {
        try {
            ExpeditionBLL expeditionBLL = new ExpeditionBLL(hbmSession);
            this.expeditionTemp = expeditionBLL.findData(this.expedition.getCode(),this.expedition.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("expedition-authority")
    public String expeditionAuthority(){
        try{
            
            ExpeditionBLL expeditionBLL = new ExpeditionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(expeditionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(expeditionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(expeditionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("expedition-save")
    public String save() {
        try {
            ExpeditionBLL expeditionBLL = new ExpeditionBLL(hbmSession);
           
            if(expeditionBLL.isExist(this.expedition.getCode())){
                this.errorMessage = "Code "+this.expedition.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                expeditionBLL.save(this.expedition);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.expedition.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("expedition-update")
    public String update() {
        try {
            ExpeditionBLL expeditionBLL = new ExpeditionBLL(hbmSession);
            
            expeditionBLL.update(this.expedition);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.expedition.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("expedition-delete")
    public String delete() {
        try {
            ExpeditionBLL expeditionBLL = new ExpeditionBLL(hbmSession);
//            GlobalBLL globalBLL=new GlobalBLL(hbmSession);
            
//            lstGlobal=globalBLL.usedExpedition(this.expedition.getCode());
//            
//            if(lstGlobal.isEmpty()){
//                expeditionBLL.delete(this.expedition.getCode());
//                this.message = "DELETE DATA SUCCESS. \n Code : " + this.expedition.getCode();
//            }else{
//                this.message = "Code: "+this.expedition.getCode() + " Is Used By "+lstGlobal.get(0).getUsedName()+" [ Code: "+ lstGlobal.get(0).getUsedCode() +" ]!";
//            }
      
            expeditionBLL.delete(this.expedition.getCode());
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.expedition.getCode();
                
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("expedition-get-min")
    public String populateDataSupplierMin() {
        try {
            ExpeditionBLL expeditionBLL=new ExpeditionBLL(hbmSession);
            this.expeditionTemp = expeditionBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("expedition-get-max")
    public String populateDataSupplierMax() {
        try {
            ExpeditionBLL expeditionBLL=new ExpeditionBLL(hbmSession);
            this.expeditionTemp = expeditionBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ProgramSession getPrgSession() {
        return prgSession;
    }

    public void setPrgSession(ProgramSession prgSession) {
        this.prgSession = prgSession;
    }

    public Expedition getExpedition() {
        return expedition;
    }

    public void setExpedition(Expedition expedition) {
        this.expedition = expedition;
    }

    public ExpeditionTemp getExpeditionTemp() {
        return expeditionTemp;
    }

    public void setExpeditionTemp(ExpeditionTemp expeditionTemp) {
        this.expeditionTemp = expeditionTemp;
    }

    public List<ExpeditionTemp> getListExpeditionTemp() {
        return listExpeditionTemp;
    }

    public void setListExpeditionTemp(List<ExpeditionTemp> listExpeditionTemp) {
        this.listExpeditionTemp = listExpeditionTemp;
    }

    public String getExpeditionSearchCode() {
        return expeditionSearchCode;
    }

    public void setExpeditionSearchCode(String expeditionSearchCode) {
        this.expeditionSearchCode = expeditionSearchCode;
    }

    public String getExpeditionSearchName() {
        return expeditionSearchName;
    }

    public void setExpeditionSearchName(String expeditionSearchName) {
        this.expeditionSearchName = expeditionSearchName;
    }

    public String getExpeditionSearchActiveStatus() {
        return expeditionSearchActiveStatus;
    }

    public void setExpeditionSearchActiveStatus(String expeditionSearchActiveStatus) {
        this.expeditionSearchActiveStatus = expeditionSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<Global> getLstGlobal() {
        return lstGlobal;
    }

    public void setLstGlobal(List<Global> lstGlobal) {
        this.lstGlobal = lstGlobal;
    }
    
    
    
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
    
}
