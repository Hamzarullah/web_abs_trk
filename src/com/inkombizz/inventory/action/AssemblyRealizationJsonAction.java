/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

/**
 *
 * @author Rayis
 */

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AssemblyRealizationBLL;
import com.inkombizz.inventory.model.AssemblyRealization;
import com.inkombizz.inventory.model.AssemblyRealizationCOGS;
import com.inkombizz.inventory.model.AssemblyRealizationItemDetail;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import static com.opensymphony.xwork2.Action.SUCCESS;

@Result(type = "json")
public class AssemblyRealizationJsonAction extends ActionSupport{
    
    protected HBMSession hbmSession = new HBMSession();
    
    private AssemblyRealization assemblyRealization;

    private List<AssemblyRealization> listAssemblyRealization;
    private List<AssemblyRealizationItemDetail> listAssemblyRealizationItemDetail;
    private List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS;
    
    private String listAssemblyRealizationItemDetailJSON;
    private String listAssemblyRealizationCOGSJSON;
       
    private String assemblyRealizationSearchCode="";
    private String assemblyRealizationSearchAssemblyJobOrderCode="";
    private String assemblyRealizationSearchFinishGoodsCode="";
    private String assemblyRealizationSearchFinishGoodsName="";
    private String assemblyRealizationSearchRemark="";
    private String assemblyRealizationSearchRefNo="";
    Date assemblyRealizationSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date assemblyRealizationSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String actionAuthority = "";
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("assembly-realization-data")
    public String findData() {
        try {
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);
            
            ListPaging<AssemblyRealization> listPaging = assemblyRealizationBLL.findData(paging,assemblyRealizationSearchFirstDate,
                    assemblyRealizationSearchLastDate,assemblyRealizationSearchCode,assemblyRealizationSearchAssemblyJobOrderCode,assemblyRealizationSearchFinishGoodsCode,
                    assemblyRealizationSearchFinishGoodsName,assemblyRealizationSearchRefNo,assemblyRealizationSearchRemark);

            listAssemblyRealization = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-realization-search-data")
    public String searchData() {
        try {
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);
            
            ListPaging<AssemblyRealization> listPaging = assemblyRealizationBLL.searchData(paging,assemblyRealizationSearchFirstDate,
                    assemblyRealizationSearchLastDate,assemblyRealizationSearchCode,assemblyRealizationSearchAssemblyJobOrderCode,assemblyRealizationSearchFinishGoodsCode,
                    assemblyRealizationSearchFinishGoodsName,assemblyRealizationSearchRefNo,assemblyRealizationSearchRemark);

            listAssemblyRealization = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-realization-item-detail-data")
    public String findDataAssemblyRealizationItemDetail(){
        try {
            
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);
            List<AssemblyRealizationItemDetail> list = assemblyRealizationBLL.findDataItemDetail(this.assemblyRealization.getCode());

            listAssemblyRealizationItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    @Action("assembly-realization-authority")
    public String financeRequestApAuthority(){
        try{
            
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);
            String modCode = assemblyRealizationBLL.MODULECODE;
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE SAVE AUTHORITY";
                        return SUCCESS;
                    }
                    
                    break;
                    
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE UPDATE AUTHORITY";
                        return SUCCESS;
                    }
                    if (assemblyRealizationBLL.isUsed(assemblyRealization.getCode())){
                        this.error=true;
                        this.errorMessage ="THIS ASSEMBLY WORK ORDER HAS BEEN USED IN OTHER TRANSACTION";
                        return SUCCESS;
                    }
                    break;

                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE DELETE AUTHORITY";
                         return SUCCESS;                       
                    }
                    if (assemblyRealizationBLL.isUsed(assemblyRealization.getCode())){
                        this.error=true;
                        this.errorMessage ="THIS ASSEMBLY WORK ORDER HAS BEEN USED IN OTHER TRANSACTION";
                        return SUCCESS;
                    }
                   
                    break;
                    
                case "PRINT":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE PRINT AUTHORITY";
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
    @Action("assembly-realization-cogs-data")
    public String findDataAssemblyRealizationCOGS(){
        try {
            
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);
            List<AssemblyRealizationCOGS> list = assemblyRealizationBLL.findDataCOGS(this.assemblyRealization.getCode());

            listAssemblyRealizationCOGS = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-realization-save")
    public String save() {
        try {
                AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);

                Gson gson = new Gson();
                Gson gson1 = new Gson();
                     gson1 =  new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
                    
                this.listAssemblyRealizationItemDetail = gson.fromJson(this.listAssemblyRealizationItemDetailJSON, new TypeToken<List<AssemblyRealizationItemDetail>>(){}.getType());
                this.listAssemblyRealizationCOGS = gson1.fromJson(this.listAssemblyRealizationCOGSJSON, new TypeToken<List<AssemblyRealizationCOGS>>(){}.getType());
    
                assemblyRealization.setTransactionDate(DateUtils.newDateTime(assemblyRealization.getTransactionDate(),true));
    
                if(assemblyRealizationBLL.isExist(this.assemblyRealization.getCode())) {
                    assemblyRealizationBLL.update(assemblyRealization, listAssemblyRealizationItemDetail,listAssemblyRealizationCOGS);
                    this.message = "UPDATE DATA SUCCESS.<br/> Code : " + this.assemblyRealization.getCode(); 
                }else{
                    assemblyRealizationBLL.save(assemblyRealization, listAssemblyRealizationItemDetail,listAssemblyRealizationCOGS);
                    this.message = "SAVE DATA SUCCESS.<br/> Code : " + this.assemblyRealization.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-realization-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            AssemblyRealizationBLL assemblyRealizationBLL = new AssemblyRealizationBLL(hbmSession);
             
            assemblyRealizationBLL.delete(this.assemblyRealization.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/> Code : " + this.assemblyRealization.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public AssemblyRealization getAssemblyRealization() {
        return assemblyRealization;
    }

    public void setAssemblyRealization(AssemblyRealization assemblyRealization) {
        this.assemblyRealization = assemblyRealization;
    }

    public List<AssemblyRealization> getListAssemblyRealization() {
        return listAssemblyRealization;
    }

    public void setListAssemblyRealization(List<AssemblyRealization> listAssemblyRealization) {
        this.listAssemblyRealization = listAssemblyRealization;
    }

    public List<AssemblyRealizationItemDetail> getListAssemblyRealizationItemDetail() {
        return listAssemblyRealizationItemDetail;
    }

    public void setListAssemblyRealizationItemDetail(List<AssemblyRealizationItemDetail> listAssemblyRealizationItemDetail) {
        this.listAssemblyRealizationItemDetail = listAssemblyRealizationItemDetail;
    }

    public List<AssemblyRealizationCOGS> getListAssemblyRealizationCOGS() {
        return listAssemblyRealizationCOGS;
    }

    public void setListAssemblyRealizationCOGS(List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS) {
        this.listAssemblyRealizationCOGS = listAssemblyRealizationCOGS;
    }

    public String getListAssemblyRealizationItemDetailJSON() {
        return listAssemblyRealizationItemDetailJSON;
    }

    public void setListAssemblyRealizationItemDetailJSON(String listAssemblyRealizationItemDetailJSON) {
        this.listAssemblyRealizationItemDetailJSON = listAssemblyRealizationItemDetailJSON;
    }

    public String getListAssemblyRealizationCOGSJSON() {
        return listAssemblyRealizationCOGSJSON;
    }

    public void setListAssemblyRealizationCOGSJSON(String listAssemblyRealizationCOGSJSON) {
        this.listAssemblyRealizationCOGSJSON = listAssemblyRealizationCOGSJSON;
    }

    public String getAssemblyRealizationSearchCode() {
        return assemblyRealizationSearchCode;
    }

    public void setAssemblyRealizationSearchCode(String assemblyRealizationSearchCode) {
        this.assemblyRealizationSearchCode = assemblyRealizationSearchCode;
    }

    public String getAssemblyRealizationSearchAssemblyJobOrderCode() {
        return assemblyRealizationSearchAssemblyJobOrderCode;
    }

    public void setAssemblyRealizationSearchAssemblyJobOrderCode(String assemblyRealizationSearchAssemblyJobOrderCode) {
        this.assemblyRealizationSearchAssemblyJobOrderCode = assemblyRealizationSearchAssemblyJobOrderCode;
    }

    public String getAssemblyRealizationSearchFinishGoodsCode() {
        return assemblyRealizationSearchFinishGoodsCode;
    }

    public void setAssemblyRealizationSearchFinishGoodsCode(String assemblyRealizationSearchFinishGoodsCode) {
        this.assemblyRealizationSearchFinishGoodsCode = assemblyRealizationSearchFinishGoodsCode;
    }

    public String getAssemblyRealizationSearchFinishGoodsName() {
        return assemblyRealizationSearchFinishGoodsName;
    }

    public void setAssemblyRealizationSearchFinishGoodsName(String assemblyRealizationSearchFinishGoodsName) {
        this.assemblyRealizationSearchFinishGoodsName = assemblyRealizationSearchFinishGoodsName;
    }

    public String getAssemblyRealizationSearchRemark() {
        return assemblyRealizationSearchRemark;
    }

    public void setAssemblyRealizationSearchRemark(String assemblyRealizationSearchRemark) {
        this.assemblyRealizationSearchRemark = assemblyRealizationSearchRemark;
    }

    public String getAssemblyRealizationSearchRefNo() {
        return assemblyRealizationSearchRefNo;
    }

    public void setAssemblyRealizationSearchRefNo(String assemblyRealizationSearchRefNo) {
        this.assemblyRealizationSearchRefNo = assemblyRealizationSearchRefNo;
    }

    public Date getAssemblyRealizationSearchFirstDate() {
        return assemblyRealizationSearchFirstDate;
    }

    public void setAssemblyRealizationSearchFirstDate(Date assemblyRealizationSearchFirstDate) {
        this.assemblyRealizationSearchFirstDate = assemblyRealizationSearchFirstDate;
    }

    public Date getAssemblyRealizationSearchLastDate() {
        return assemblyRealizationSearchLastDate;
    }

    public void setAssemblyRealizationSearchLastDate(Date assemblyRealizationSearchLastDate) {
        this.assemblyRealizationSearchLastDate = assemblyRealizationSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    
}
