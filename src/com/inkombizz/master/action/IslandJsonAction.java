
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

import com.inkombizz.master.bll.IslandBLL;
import com.inkombizz.master.model.Island;
import com.inkombizz.master.model.IslandTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.Date;

@Result (type="json")
public class IslandJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private Island island;
    private Island searchIsland = new Island();
    private IslandTemp islandTemp;
    private List <IslandTemp> listIslandTemp;
    private List <Island> listIsland;
    private String actionAuthority="";
    private Enum_TriState searchIslandActiveStatus = Enum_TriState.YES;
    
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("island-search")
    public String search() {
        try {
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            
            ListPaging <Island> listPaging = islandBLL.search(paging, searchIsland.getCode(), searchIsland.getName(), searchIslandActiveStatus);
            
            listIsland = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("island-data")
    public String populateData() {
        try {
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            ListPaging<Island> listPaging = islandBLL.get(paging);
            listIsland = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("island-get")
    public String populateDataForUpdate() {
        try {
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            this.island = islandBLL.get(this.island.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("island-get-data")
    public String findData2() {
        try {
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            this.islandTemp = islandBLL.findData(this.island.getCode(),this.island.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("island-save")
    public String save() {
        try {
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(IslandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }                
            
            if(island.isActiveStatus() == false){
                island.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                island.setInActiveDate(new Date());
            }
            islandBLL.save(this.island);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.island.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("island-update")
    public String update() {
        try {
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(IslandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }     
            
            if(island.isActiveStatus() == false){
                island.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                island.setInActiveDate(new Date());
            }
            islandBLL.update(this.island);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.island.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("island-delete")
    public String delete() {
        try {
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(IslandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            islandBLL.delete(this.island.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.island.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("island-get-min")
    public String populateDataSupplierMin() {
        try {
            IslandBLL islandBLL=new IslandBLL(hbmSession);
            this.islandTemp = islandBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("island-get-max")
    public String populateDataSupplierMax() {
        try {
            IslandBLL islandBLL=new IslandBLL(hbmSession);
            this.islandTemp = islandBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("island-authority")
    public String islandAuthority(){
        try{
            
            IslandBLL islandBLL = new IslandBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(islandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(islandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(islandBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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

        public Island getIsland() {
            return island;
        }

        public void setIsland(Island island) {
            this.island = island;
        }

        public IslandTemp getIslandTemp() {
            return islandTemp;
        }

        public void setIslandTemp(IslandTemp islandTemp) {
            this.islandTemp = islandTemp;
        }

        public List<IslandTemp> getListIslandTemp() {
            return listIslandTemp;
        }

        public void setListIslandTemp(List<IslandTemp> listIslandTemp) {
            this.listIslandTemp = listIslandTemp;
        }

        public String getActionAuthority() {
            return actionAuthority;
        }

        public void setActionAuthority(String actionAuthority) {
            this.actionAuthority = actionAuthority;
        }

        public Island getSearchIsland() {
            return searchIsland;
        }

        public void setSearchIsland(Island searchIsland) {
            this.searchIsland = searchIsland;
        }

        public List<Island> getListIsland() {
            return listIsland;
        }

        public void setListIsland(List<Island> listIsland) {
            this.listIsland = listIsland;
        }

        public Enum_TriState getSearchIslandActiveStatus() {
            return searchIslandActiveStatus;
        }

        public void setSearchIslandActiveStatus(Enum_TriState searchIslandActiveStatus) {
            this.searchIslandActiveStatus = searchIslandActiveStatus;
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
