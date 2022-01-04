/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.BusinessEntityBLL;
import com.inkombizz.master.model.BusinessEntity;
import com.inkombizz.master.model.BusinessEntityTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author jason
 */
@Result(type = "json")
public class BusinessEntityJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private BusinessEntity businessEntity;
    private BusinessEntityTemp businessEntityTemp;
    private List <BusinessEntityTemp> listBusinessEntityTemp;
    private String businessEntitySearchCode = "";
    private String businessEntitySearchName = "";
    private String businessEntitySearchActiveStatus = "true";
    private String actionAuthority="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("business-entity-data")
    public String findData() {
        try {
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
            ListPaging<BusinessEntityTemp> listPaging = businessEntityBLL.findData(paging,businessEntitySearchCode,businessEntitySearchName,businessEntitySearchActiveStatus);
            
            listBusinessEntityTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("business-entity-find-one-data")
    public String findOneData() {
        try {
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
            businessEntity = businessEntityBLL.get(this.businessEntity.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("business-entity-get")
    public String findOneDataByActiveStatus() {
        try {
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
            businessEntityTemp = businessEntityBLL.get(this.businessEntity.getCode(),this.businessEntity.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("business-entity-get-data")
    public String findData1() {
        try {
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
            this.businessEntityTemp = businessEntityBLL.findData(this.businessEntity.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("business-entity-authority")
    public String businessEntityAuthority(){
        try{
            
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(businessEntityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(businessEntityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(businessEntityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("business-entity-save")
    public String save() {
        try {
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
           
            if(businessEntityBLL.isExist(this.businessEntity.getCode())){
                this.errorMessage = "Code "+this.businessEntity.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                businessEntityBLL.save(this.businessEntity);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.businessEntity.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("business-entity-update")
    public String update() {
        try {
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
            
            businessEntityBLL.update(this.businessEntity);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.businessEntity.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("business-entity-delete")
    public String delete() {
        try {
            BusinessEntityBLL businessEntityBLL = new BusinessEntityBLL(hbmSession);
            businessEntityBLL.delete(this.businessEntity.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.businessEntity.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public BusinessEntity getBusinessEntity() {
        return businessEntity;
    }

    public void setBusinessEntity(BusinessEntity businessEntity) {
        this.businessEntity = businessEntity;
    }

    public BusinessEntityTemp getBusinessEntityTemp() {
        return businessEntityTemp;
    }

    public void setBusinessEntityTemp(BusinessEntityTemp businessEntityTemp) {
        this.businessEntityTemp = businessEntityTemp;
    }

    public List<BusinessEntityTemp> getListBusinessEntityTemp() {
        return listBusinessEntityTemp;
    }

    public void setListBusinessEntityTemp(List<BusinessEntityTemp> listBusinessEntityTemp) {
        this.listBusinessEntityTemp = listBusinessEntityTemp;
    }

    public String getBusinessEntitySearchCode() {
        return businessEntitySearchCode;
    }

    public void setBusinessEntitySearchCode(String businessEntitySearchCode) {
        this.businessEntitySearchCode = businessEntitySearchCode;
    }

    public String getBusinessEntitySearchName() {
        return businessEntitySearchName;
    }

    public void setBusinessEntitySearchName(String businessEntitySearchName) {
        this.businessEntitySearchName = businessEntitySearchName;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getBusinessEntitySearchActiveStatus() {
        return businessEntitySearchActiveStatus;
    }

    public void setBusinessEntitySearchActiveStatus(String businessEntitySearchActiveStatus) {
        this.businessEntitySearchActiveStatus = businessEntitySearchActiveStatus;
    }
}
