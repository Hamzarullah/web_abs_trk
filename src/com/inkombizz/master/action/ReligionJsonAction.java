
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.ReligionBLL;
import com.inkombizz.master.model.Religion;
import com.inkombizz.master.model.ReligionTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.Date;

@Result (type="json")
public class ReligionJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private Religion religion;
    private Religion searchReligion = new Religion();
    private ReligionTemp religionTemp;
    private List <ReligionTemp> listReligionTemp;
    private List <Religion> listReligion;
    private String actionAuthority="";
    private Enum_TriState searchReligionActiveStatus = Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("religion-search")
    public String search() {
        try {
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            
            ListPaging <Religion> listPaging = religionBLL.search(paging, searchReligion.getCode(), searchReligion.getName(), searchReligionActiveStatus);
            
            listReligion = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("religion-data")
    public String populateData() {
        try {
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            ListPaging<Religion> listPaging = religionBLL.get(paging);
            listReligion = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("religion-get")
    public String populateDataForUpdate() {
        try {
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            this.religion = religionBLL.get(this.religion.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("religion-get-data")
    public String findData2() {
        try {
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            this.religionTemp = religionBLL.findData(this.religion.getCode(),this.religion.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("religion-save")
    public String save() {
        try {
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ReligionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }                
            
            if(religion.isActiveStatus() == false){
                religion.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                religion.setInActiveDate(new Date());
            }else{
                religion.setInActiveBy("");
                religion.setInActiveDate(DateUtils.newDate(1900, 1, 1));
            }
            religionBLL.save(this.religion);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.religion.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("religion-update")
    public String update() {
        try {
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ReligionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }     
            
            if(religion.isActiveStatus() == false){
                religion.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                religion.setInActiveDate(new Date());
            }else{
                religion.setInActiveBy("");
                religion.setInActiveDate(DateUtils.newDate(1900, 1, 1));
            }
            
            religionBLL.update(this.religion);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.religion.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("religion-delete")
    public String delete() {
        try {
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(ReligionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            religionBLL.delete(this.religion.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.religion.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("religion-get-min")
    public String populateDataSupplierMin() {
        try {
            ReligionBLL religionBLL=new ReligionBLL(hbmSession);
            this.religionTemp = religionBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("religion-get-max")
    public String populateDataSupplierMax() {
        try {
            ReligionBLL religionBLL=new ReligionBLL(hbmSession);
            this.religionTemp = religionBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("religion-authority")
    public String religionAuthority(){
        try{
            
            ReligionBLL religionBLL = new ReligionBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(religionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(religionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(religionBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET INCLUUDE">

        public HBMSession getHbmSession() {
            return hbmSession;
        }

        public void setHbmSession(HBMSession hbmSession) {
            this.hbmSession = hbmSession;
        }

        public Religion getReligion() {
            return religion;
        }

        public void setReligion(Religion religion) {
            this.religion = religion;
        }

        public ReligionTemp getReligionTemp() {
            return religionTemp;
        }

        public void setReligionTemp(ReligionTemp religionTemp) {
            this.religionTemp = religionTemp;
        }

        public List<ReligionTemp> getListReligionTemp() {
            return listReligionTemp;
        }

        public void setListReligionTemp(List<ReligionTemp> listReligionTemp) {
            this.listReligionTemp = listReligionTemp;
        }

        public String getActionAuthority() {
            return actionAuthority;
        }

        public void setActionAuthority(String actionAuthority) {
            this.actionAuthority = actionAuthority;
        }

        public Religion getSearchReligion() {
            return searchReligion;
        }

        public void setSearchReligion(Religion searchReligion) {
            this.searchReligion = searchReligion;
        }

        public List<Religion> getListReligion() {
            return listReligion;
        }

        public void setListReligion(List<Religion> listReligion) {
            this.listReligion = listReligion;
        }

        public Enum_TriState getSearchReligionActiveStatus() {
            return searchReligionActiveStatus;
        }

        public void setSearchReligionActiveStatus(Enum_TriState searchReligionActiveStatus) {
            this.searchReligionActiveStatus = searchReligionActiveStatus;
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">

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
