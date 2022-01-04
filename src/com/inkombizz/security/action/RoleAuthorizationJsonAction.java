/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.RoleAuthorizationBLL;
import com.inkombizz.security.bll.RoleBLL;
import com.inkombizz.security.model.Role;
import com.inkombizz.security.model.RoleAuthorization;
import com.inkombizz.security.model.RoleAuthorizationTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;

/**
 *
 * @author niko
 */

@Result(type = "json")
public class RoleAuthorizationJsonAction  extends ActionSupport {
    
    private static final long serialVersionUID = 1L;    
    protected HBMSession hbmSession = new HBMSession();
    
    private Paging paging = new Paging();
    
    private Role role = new Role();
    private RoleAuthorization roleAuthorization = new RoleAuthorization();
    private List<Role> listRole;
    private List<RoleAuthorization> listRoleAuthorization;
    private List<RoleAuthorizationTemp> listRoleAuthorizationTemp;
    private String listRoleJSON = "";
    private String listRoleAuthorizationJSON = "";    
    private String headerCode = "";    
    
    @Override 
    public String execute(){
        try{
            return populateListHeader();
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
    
    @Action("role-authorization-data")
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
        
    @Action("role-authorization-update-data")
    public String populateHeaderForUpdate(){
        try{
            RoleBLL roleBLL = new RoleBLL(hbmSession);
            role = roleBLL.getHeader(getHeaderCode());
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("role-authorization-detail-data")
    public String populateListDetail(){
        try{

            RoleAuthorizationBLL roleAuthorizationBLL = new RoleAuthorizationBLL(hbmSession);
            ListPaging<RoleAuthorization> listPaging = roleAuthorizationBLL.getListDetail(paging, getHeaderCode());
                        
            listRoleAuthorization = listPaging.getList();
 
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "GET DATA DETAIL FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("role-authorization-update-detail-data")
    public String populateListDetailForUpdate(){
        try{
            RoleAuthorizationBLL roleAuthorizationBLL = new RoleAuthorizationBLL(hbmSession);
            listRoleAuthorizationTemp = roleAuthorizationBLL.getListDetailForupdate(getHeaderCode());

            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("role-authorization-save")
    public String save(){
        try{
            if (!BaseSession.loadProgramSession().hasAuthority(RoleAuthorizationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }

            RoleAuthorizationBLL roleAuthorizationBLL = new RoleAuthorizationBLL(hbmSession);  

            Gson gson = new Gson();
            this.listRoleAuthorization = gson.fromJson(this.listRoleAuthorizationJSON, new TypeToken<List<RoleAuthorization>>(){}.getType());

            roleAuthorizationBLL.update(this.getHeaderCode(), this.listRoleAuthorization);

            this.message = "SAVED DATA SUCCESS. \n Role No : " + this.getHeaderCode();
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "SAVED DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("role-authorization-delete")
    public String delete(){
        try{
            if (!BaseSession.loadProgramSession().hasAuthority(RoleAuthorizationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
                        
            RoleAuthorizationBLL roleAuthorizationBLL = new RoleAuthorizationBLL(hbmSession); 
            
            roleAuthorizationBLL.delete(this.getHeaderCode());
            
            this.message = "DELETE DATA SUCCESS. \n Role No : " + this.role.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
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
        
    public Role getRole(){
        return this.role;
    }    
    public void setRole(Role role){
        this.role = role;
    }
        
    public List<Role> getListRole(){
        return this.listRole;
    }    
    public void setListRole(List<Role> listRole){
        this.listRole = listRole;
    }
        
    public RoleAuthorization getRoleAuthorization(){
        return this.roleAuthorization;
    }    
    public void setRoleAuthorization(RoleAuthorization roleAuthorization){
        this.roleAuthorization = roleAuthorization;
    }
    
    public List<RoleAuthorization> getListRoleAuthorization(){
        return this.listRoleAuthorization;
    }    
    public void setListRoleAuthorization(List<RoleAuthorization> listRoleAuthorization){
        this.listRoleAuthorization = listRoleAuthorization;
    }
    
    public String getListRoleJSON() {
        return listRoleJSON;
    }
    public void setListRoleJSON(String listRoleJSON) {
        this.listRoleJSON = listRoleJSON;
    }
    
    public String getListRoleAuthorizationJSON() {
        return listRoleAuthorizationJSON;
    }
    public void setListRoleAuthorizationJSON(String listRoleAuthorizationJSON) {
        this.listRoleAuthorizationJSON = listRoleAuthorizationJSON;
    }

    public String getHeaderCode() {
        return this.headerCode;
    }
    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
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

    public List<RoleAuthorizationTemp> getListRoleAuthorizationTemp() {
        return listRoleAuthorizationTemp;
    }

    public void setListRoleAuthorizationTemp(List<RoleAuthorizationTemp> listRoleAuthorizationTemp) {
        this.listRoleAuthorizationTemp = listRoleAuthorizationTemp;
    }

    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
}
