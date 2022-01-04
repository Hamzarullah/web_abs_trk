/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.RoleBLL;
import com.inkombizz.security.model.Role;
import com.inkombizz.security.model.RoleTemp;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;

/**
 *
 * @author niko
 */

@Result(type = "json")
public class RoleJsonAction  extends ActionSupport {
    
    private static final long serialVersionUID = 1L;    
    protected HBMSession hbmSession = new HBMSession();
     
    private Role role = new Role();
    private RoleTemp roleTemp;
    private Role searchRole;
    private List<Role> listRole;
    
    @Override 
    public String execute(){
        try{
            return populateListHeader();
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
    
    @Action("role-data")
    public String populateListHeader(){
        try{
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            
            ListPaging<Role> listPaging = roleBLL.getListHeader(paging);
            
            listRole = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
//    @Action("role-get")
//    public String get() {
//        try {
//            RoleBLL roleBLL = new RoleBLL(hbmSession);
//            this.role = roleBLL.getHeader(this.role.getCode());
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("role-get")
    public String findData2() {
        try {
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            this.roleTemp = roleBLL.findData(this.role.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("role-search")
    public String search() {
        try {
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            ListPaging <Role> listPaging = roleBLL.search(paging, searchRole.getCode(), searchRole.getName(), Enum_TriState.YES);
            
            listRole = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("role-save")
    public String save() {
        try {
            if (!BaseSession.loadProgramSession().hasAuthority(RoleBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }
            
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            roleBLL.save(this.role);

            this.message = "SAVE DATA SUCCESS. \n Code : " + this.role.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("role-update")
    public String update() {
        try {
            if (!BaseSession.loadProgramSession().hasAuthority(RoleBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }
            
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            
            roleBLL.update(this.role);

            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.role.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("role-delete")
    public String delete(){
        try{
            if (!BaseSession.loadProgramSession().hasAuthority(RoleBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            
            roleBLL.delete(this.role.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Role No : " + this.role.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
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

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public RoleTemp getRoleTemp() {
        return roleTemp;
    }

    public void setRoleTemp(RoleTemp roleTemp) {
        this.roleTemp = roleTemp;
    }

    public Role getSearchRole() {
        return searchRole;
    }

    public void setSearchRole(Role searchRole) {
        this.searchRole = searchRole;
    }

    public List<Role> getListRole() {
        return listRole;
    }

    public void setListRole(List<Role> listRole) {
        this.listRole = listRole;
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
