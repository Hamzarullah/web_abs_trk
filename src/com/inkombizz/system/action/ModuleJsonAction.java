package com.inkombizz.system.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Result;
import static com.opensymphony.xwork2.Action.SUCCESS;
import org.apache.struts2.convention.annotation.Action;

import com.inkombizz.system.model.Module;
import com.inkombizz.system.bll.ModuleBLL;
import com.inkombizz.system.model.ModuleTemp;

@Result(type = "json")
public class ModuleJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private Module module;
    private List<Module> listModule;
    private List<ModuleTemp> listModuleTemp;
    private String moduleSearchName="";
    private String listModuleJSON;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    

    @Action("module-data")
    public String findData() {
        try {
            ModuleBLL moduleBLL = new ModuleBLL(hbmSession);
            
            ListPaging<ModuleTemp> listPaging = moduleBLL.findData(paging,moduleSearchName);

            listModuleTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. <br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("module-for-update-data")
    public String findDataForUpdate(){
        try{
            ModuleBLL moduleBLL = new ModuleBLL(hbmSession);
            listModuleTemp = moduleBLL.findDataForUpdate();

            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("module-update")
    public String update(){
        try {
                        
            ModuleBLL moduleBLL = new ModuleBLL(hbmSession);
            Gson gson = new Gson();
            this.listModule = gson.fromJson(this.listModuleJSON, new TypeToken<List<Module>>(){}.getType());
            
            moduleBLL.update(listModule);

            this.message ="UPDATE DATA SUCCESS!";

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage ="UPDATE DATA FAILED!";
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public List<Module> getListModule() {
        return listModule;
    }

    public void setListModule(List<Module> listModule) {
        this.listModule = listModule;
    }

    public List<ModuleTemp> getListModuleTemp() {
        return listModuleTemp;
    }

    public void setListModuleTemp(List<ModuleTemp> listModuleTemp) {
        this.listModuleTemp = listModuleTemp;
    }

    public String getModuleSearchName() {
        return moduleSearchName;
    }

    public void setModuleSearchName(String moduleSearchName) {
        this.moduleSearchName = moduleSearchName;
    }

    public String getListModuleJSON() {
        return listModuleJSON;
    }

    public void setListModuleJSON(String listModuleJSON) {
        this.listModuleJSON = listModuleJSON;
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