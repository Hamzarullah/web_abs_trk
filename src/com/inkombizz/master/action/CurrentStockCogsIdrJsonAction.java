
package com.inkombizz.master.action;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.CurrentStockCogsIdrBLL;
import com.inkombizz.master.model.CurrentStockCogsIdr;
import com.inkombizz.master.model.CurrentStockCogsIdrTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;

@Result (type="json")
public class CurrentStockCogsIdrJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CurrentStockCogsIdr currentStockCogsIdr;
    private CurrentStockCogsIdr searchCurrentStockCogsIdr = new CurrentStockCogsIdr();
    private CurrentStockCogsIdrTemp currentStockCogsIdrTemp;
    private List <CurrentStockCogsIdrTemp> listCurrentStockCogsIdrTemp;
    private List <CurrentStockCogsIdr> listCurrentStockCogsIdr;
    private String actionAuthority="";
    private String currentStockCogsIdrSearchWarehouseCode = "";
    private String currentStockCogsIdrSearchWarehouseName = "";
    private String currentStockCogsIdrSearchItemCode = "";
    private String currentStockCogsIdrSearchItemName = "";
    
    @Override
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
     @Action("current-stock-cogs-idr-search")
    public String search() {
        try {
            CurrentStockCogsIdrBLL currentStockCogsIdrBLL = new CurrentStockCogsIdrBLL(hbmSession);
            
            ListPaging <CurrentStockCogsIdrTemp> listPaging = currentStockCogsIdrBLL.searchData(currentStockCogsIdrSearchWarehouseCode,currentStockCogsIdrSearchWarehouseName,currentStockCogsIdrSearchItemCode,currentStockCogsIdrSearchItemName,paging);
            
            listCurrentStockCogsIdrTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("current-stock-cogs-idr-data")
    public String populateData(){
        try {
            CurrentStockCogsIdrBLL currentStockCogsIdrBLL = new CurrentStockCogsIdrBLL(hbmSession);
            ListPaging <CurrentStockCogsIdrTemp> listPaging = currentStockCogsIdrBLL.findData(paging);
            
            listCurrentStockCogsIdrTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("current-stock-cogs-idr-get")
    public String populateDataForUpdate() {
        try {
            CurrentStockCogsIdrBLL currentStockCogsIdrBLL = new CurrentStockCogsIdrBLL(hbmSession);
            this.currentStockCogsIdr = currentStockCogsIdrBLL.get(this.currentStockCogsIdr.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("current-stock-cogs-idr-save")
//    public String save() {
//        try {
//            CurrentStockCogsIdrBLL currentStockCogsIdrBLL = new CurrentStockCogsIdrBLL(hbmSession);
//            
//            if (!BaseSession.loadProgramSession().hasAuthority(CurrentStockCogsIdrBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
//            }                
//            
//            if(currentStockCogsIdr.isActiveStatus() == false){
//                currentStockCogsIdr.setInActiveBy(BaseSession.loadProgramSession().getUserName());
//                currentStockCogsIdr.setInActiveDate(new Date());
//            }
//            currentStockCogsIdrBLL.save(this.currentStockCogsIdr);
//            
//            this.message = "SAVE DATA SUCCESS. \n Code : " + this.currentStockCogsIdr.getCode();
//            return SUCCESS;
//        }
//        catch(Exception ex) {           
//            this.error = true;
//            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
//	
//    @Action("current-stock-cogs-idr-update")
//    public String update() {
//        try {
//            CurrentStockCogsIdrBLL currentStockCogsIdrBLL = new CurrentStockCogsIdrBLL(hbmSession);
//            
//            if (!BaseSession.loadProgramSession().hasAuthority(CurrentStockCogsIdrBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
//            }
//            
//            if(currentStockCogsIdr.isActiveStatus() == false){
//                currentStockCogsIdr.setInActiveBy(BaseSession.loadProgramSession().getUserName());
//                currentStockCogsIdr.setInActiveDate(new Date());
//            }
//            currentStockCogsIdrBLL.update(this.currentStockCogsIdr);
//           
//            
//            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.currentStockCogsIdr.getCode();
//            return SUCCESS;
//        }
//        catch(Exception ex) {   
//            this.error = true;
//            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
//	
//    @Action("current-stock-cogs-idr-delete")
//    public String delete() {
//        try {
//            CurrentStockCogsIdrBLL currentStockCogsIdrBLL = new CurrentStockCogsIdrBLL(hbmSession);
//            
//            if (!BaseSession.loadProgramSession().hasAuthority(CurrentStockCogsIdrBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
//            }            
//            
//            currentStockCogsIdrBLL.delete(this.currentStockCogsIdr.getCode());
//            
//            this.message = "DELETE DATA SUCCESS. \n Code : " + this.currentStockCogsIdr.getCode();
//            return SUCCESS;
//        }
//        catch(Exception ex) {           
//            this.error = true;
//            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
	
    @Action("current-stock-cogs-idr-get-min")
    public String populateDataSupplierMin() {
        try {
            CurrentStockCogsIdrBLL currentStockCogsIdrBLL=new CurrentStockCogsIdrBLL(hbmSession);
            this.currentStockCogsIdrTemp = currentStockCogsIdrBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("current-stock-cogs-idr-get-max")
    public String populateDataSupplierMax() {
        try {
            CurrentStockCogsIdrBLL currentStockCogsIdrBLL=new CurrentStockCogsIdrBLL(hbmSession);
            this.currentStockCogsIdrTemp = currentStockCogsIdrBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public String getCurrentStockCogsIdrSearchWarehouseCode() {
        return currentStockCogsIdrSearchWarehouseCode;
    }

    public void setCurrentStockCogsIdrSearchWarehouseCode(String currentStockCogsIdrSearchWarehouseCode) {
        this.currentStockCogsIdrSearchWarehouseCode = currentStockCogsIdrSearchWarehouseCode;
    }

    public String getCurrentStockCogsIdrSearchWarehouseName() {
        return currentStockCogsIdrSearchWarehouseName;
    }

    public void setCurrentStockCogsIdrSearchWarehouseName(String currentStockCogsIdrSearchWarehouseName) {
        this.currentStockCogsIdrSearchWarehouseName = currentStockCogsIdrSearchWarehouseName;
    }

    public String getCurrentStockCogsIdrSearchItemCode() {
        return currentStockCogsIdrSearchItemCode;
    }

    public void setCurrentStockCogsIdrSearchItemCode(String currentStockCogsIdrSearchItemCode) {
        this.currentStockCogsIdrSearchItemCode = currentStockCogsIdrSearchItemCode;
    }

    public String getCurrentStockCogsIdrSearchItemName() {
        return currentStockCogsIdrSearchItemName;
    }

    public void setCurrentStockCogsIdrSearchItemName(String currentStockCogsIdrSearchItemName) {
        this.currentStockCogsIdrSearchItemName = currentStockCogsIdrSearchItemName;
    }

    
    // <editor-fold defaultstate="collapsed" desc="SET N GET INCLUUDE">

        public HBMSession getHbmSession() {
            return hbmSession;
        }

        public void setHbmSession(HBMSession hbmSession) {
            this.hbmSession = hbmSession;
        }

        public CurrentStockCogsIdr getCurrentStockCogsIdr() {
            return currentStockCogsIdr;
        }

        public void setCurrentStockCogsIdr(CurrentStockCogsIdr currentStockCogsIdr) {
            this.currentStockCogsIdr = currentStockCogsIdr;
        }

        public CurrentStockCogsIdrTemp getCurrentStockCogsIdrTemp() {
            return currentStockCogsIdrTemp;
        }

        public void setCurrentStockCogsIdrTemp(CurrentStockCogsIdrTemp currentStockCogsIdrTemp) {
            this.currentStockCogsIdrTemp = currentStockCogsIdrTemp;
        }

        public List<CurrentStockCogsIdrTemp> getListCurrentStockCogsIdrTemp() {
            return listCurrentStockCogsIdrTemp;
        }

        public void setListCurrentStockCogsIdrTemp(List<CurrentStockCogsIdrTemp> listCurrentStockCogsIdrTemp) {
            this.listCurrentStockCogsIdrTemp = listCurrentStockCogsIdrTemp;
        }

        public String getActionAuthority() {
            return actionAuthority;
        }

        public void setActionAuthority(String actionAuthority) {
            this.actionAuthority = actionAuthority;
        }

        public CurrentStockCogsIdr getSearchCurrentStockCogsIdr() {
            return searchCurrentStockCogsIdr;
        }

        public void setSearchCurrentStockCogsIdr(CurrentStockCogsIdr searchCurrentStockCogsIdr) {
            this.searchCurrentStockCogsIdr = searchCurrentStockCogsIdr;
        }

        public List<CurrentStockCogsIdr> getListCurrentStockCogsIdr() {
            return listCurrentStockCogsIdr;
        }

        public void setListCurrentStockCogsIdr(List<CurrentStockCogsIdr> listCurrentStockCogsIdr) {
            this.listCurrentStockCogsIdr = listCurrentStockCogsIdr;
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
