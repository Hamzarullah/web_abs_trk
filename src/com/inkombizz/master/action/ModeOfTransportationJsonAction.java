
package com.inkombizz.master.action;

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

import com.inkombizz.master.bll.ModeOfTransportationBLL;
import com.inkombizz.master.model.ModeOfTransportationTemp;
import com.inkombizz.master.model.ModeOfTransportation;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ModeOfTransportationJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ModeOfTransportation modeOfTransportation;
    private ModeOfTransportationTemp modeOfTransportationTemp;
    private List <ModeOfTransportationTemp> listModeOfTransportationTemp;
    private ModeOfTransportation searchModeOfTransportation = new ModeOfTransportation();
    private List <ModeOfTransportation> listModeOfTransportation;
    private String modeOfTransportationSearchCode = "";
    private String modeOfTransportationSearchName = "";
    private String modeOfTransportationSearchActiveStatus="true";
    private String actionAuthority="";
     private EnumTriState.Enum_TriState searchModeOfTransportationActiveStatus = EnumTriState.Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("mode-of-transportation-data")
    public String findData() {
        try {
            ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            ListPaging <ModeOfTransportationTemp> listPaging = modeOfTransportationBLL.findData(modeOfTransportationSearchCode,modeOfTransportationSearchName,modeOfTransportationSearchActiveStatus,paging);
            
            listModeOfTransportationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("mode-of-transportation-get-data")
    public String findData1() {
        try {
            ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            this.modeOfTransportationTemp = modeOfTransportationBLL.findData(this.modeOfTransportation.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("mode-of-transportation-get")
    public String findData2() {
        try {
            ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            this.modeOfTransportationTemp = modeOfTransportationBLL.findData(this.modeOfTransportation.getCode(),this.modeOfTransportation.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("mode-of-transportation-authority")
    public String modeOfTransportationAuthority(){
        try{
            
            ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(modeOfTransportationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(modeOfTransportationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(modeOfTransportationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    @Action("mode-of-transportation-search")
    public String search() {
        try {
            ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            
            ListPaging <ModeOfTransportation> listPaging = modeOfTransportationBLL.search(paging, searchModeOfTransportation.getCode(), searchModeOfTransportation.getName(), searchModeOfTransportationActiveStatus);
            
            listModeOfTransportation = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("mode-of-transportation-save")
    public String save() {
        try {
            ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            
          modeOfTransportation.setInActiveDate(commonFunction.setDateTime(modeOfTransportationTemp.getInActiveDateTemp()));
         modeOfTransportation.setCreatedDate(commonFunction.setDateTime(modeOfTransportationTemp.getCreatedDateTemp()));
            
            if(modeOfTransportationBLL.isExist(this.modeOfTransportation.getCode())){
                this.errorMessage = "CODE "+this.modeOfTransportation.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                modeOfTransportationBLL.save(this.modeOfTransportation);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.modeOfTransportation.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("mode-of-transportation-update")
    public String update() {
        try {
            ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            modeOfTransportation.setInActiveDate(commonFunction.setDateTime(modeOfTransportationTemp.getInActiveDateTemp()));
            modeOfTransportation.setCreatedDate(commonFunction.setDateTime(modeOfTransportationTemp.getCreatedDateTemp()));
            modeOfTransportationBLL.update(this.modeOfTransportation);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.modeOfTransportation.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("mode-of-transportation-delete")
    public String delete() {
        try {
           ModeOfTransportationBLL modeOfTransportationBLL = new ModeOfTransportationBLL(hbmSession);
            modeOfTransportationBLL.delete(this.modeOfTransportation.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.modeOfTransportation.getCode();
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

    public ModeOfTransportation getModeOfTransportation() {
        return modeOfTransportation;
    }

    public void setModeOfTransportation(ModeOfTransportation modeOfTransportation) {
        this.modeOfTransportation = modeOfTransportation;
    }

    public ModeOfTransportationTemp getModeOfTransportationTemp() {
        return modeOfTransportationTemp;
    }

    public void setModeOfTransportationTemp(ModeOfTransportationTemp modeOfTransportationTemp) {
        this.modeOfTransportationTemp = modeOfTransportationTemp;
    }

    public List<ModeOfTransportationTemp> getListModeOfTransportationTemp() {
        return listModeOfTransportationTemp;
    }

    public void setListModeOfTransportationTemp(List<ModeOfTransportationTemp> listModeOfTransportationTemp) {
        this.listModeOfTransportationTemp = listModeOfTransportationTemp;
    }

    public String getModeOfTransportationSearchCode() {
        return modeOfTransportationSearchCode;
    }

    public void setModeOfTransportationSearchCode(String modeOfTransportationSearchCode) {
        this.modeOfTransportationSearchCode = modeOfTransportationSearchCode;
    }

    public String getModeOfTransportationSearchName() {
        return modeOfTransportationSearchName;
    }

    public void setModeOfTransportationSearchName(String modeOfTransportationSearchName) {
        this.modeOfTransportationSearchName = modeOfTransportationSearchName;
    }

    public String getModeOfTransportationSearchActiveStatus() {
        return modeOfTransportationSearchActiveStatus;
    }

    public void setModeOfTransportationSearchActiveStatus(String modeOfTransportationSearchActiveStatus) {
        this.modeOfTransportationSearchActiveStatus = modeOfTransportationSearchActiveStatus;
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

    public ModeOfTransportation getSearchModeOfTransportation() {
        return searchModeOfTransportation;
    }

    public void setSearchModeOfTransportation(ModeOfTransportation searchModeOfTransportation) {
        this.searchModeOfTransportation = searchModeOfTransportation;
    }

    public EnumTriState.Enum_TriState getSearchModeOfTransportationActiveStatus() {
        return searchModeOfTransportationActiveStatus;
    }

    public void setSearchModeOfTransportationActiveStatus(EnumTriState.Enum_TriState searchModeOfTransportationActiveStatus) {
        this.searchModeOfTransportationActiveStatus = searchModeOfTransportationActiveStatus;
    }

    public List<ModeOfTransportation> getListModeOfTransportation() {
        return listModeOfTransportation;
    }

    public void setListModeOfTransportation(List<ModeOfTransportation> listModeOfTransportation) {
        this.listModeOfTransportation = listModeOfTransportation;
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
