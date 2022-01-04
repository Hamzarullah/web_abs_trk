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
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AssemblyJobOrderBLL;
import com.inkombizz.inventory.model.AssemblyJobOrder;
import com.inkombizz.inventory.model.AssemblyJobOrderItemDetail;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result(type = "json")
public class AssemblyJobOrderJsonAction extends ActionSupport{
    
    protected HBMSession hbmSession = new HBMSession();
    
    private AssemblyJobOrder assemblyJobOrder;

    private List<AssemblyJobOrder> listAssemblyJobOrder;
    private List<AssemblyJobOrderItemDetail> listAssemblyJobOrderItemDetail;
    
    private String listAssemblyJobOrderItemDetailJSON;
       
    private String assemblyJobOrderSearchCode="";
    private String assemblyJobOrderSearchFinishGoodsCode="";
    private String assemblyJobOrderSearchFinishGoodsName="";
    private String assemblyJobOrderSearchRemark="";
    private String assemblyJobOrderSearchRefNo="";
    Date assemblyJobOrderSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date assemblyJobOrderSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
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
    
    @Action("assembly-job-order-data")
    public String findData() {
        try {
            AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);
            
            ListPaging<AssemblyJobOrder> listPaging = assemblyJobOrderBLL.findData(paging,assemblyJobOrderSearchFirstDate,
                    assemblyJobOrderSearchLastDate,assemblyJobOrderSearchCode,assemblyJobOrderSearchFinishGoodsCode,
                    assemblyJobOrderSearchFinishGoodsName,assemblyJobOrderSearchRefNo,assemblyJobOrderSearchRemark);

            listAssemblyJobOrder = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-job-order-search-data")
    public String searchData() {
        try {
            AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);
            
            ListPaging<AssemblyJobOrder> listPaging = assemblyJobOrderBLL.searchData(paging,assemblyJobOrderSearchFirstDate,
                    assemblyJobOrderSearchLastDate,assemblyJobOrderSearchCode,assemblyJobOrderSearchFinishGoodsCode,
                    assemblyJobOrderSearchFinishGoodsName,assemblyJobOrderSearchRefNo,assemblyJobOrderSearchRemark);

            listAssemblyJobOrder = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-job-order-item-detail-data")
    public String findDataAssemblyJobOrderItemDetail(){
        try {
            
            AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);
            List<AssemblyJobOrderItemDetail> list = assemblyJobOrderBLL.findDataItemDetail(this.assemblyJobOrder.getCode());

            listAssemblyJobOrderItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-job-order-save")
    public String save() {
        try {
                AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);

                Gson gson = new Gson();
                this.listAssemblyJobOrderItemDetail = gson.fromJson(this.listAssemblyJobOrderItemDetailJSON, new TypeToken<List<AssemblyJobOrderItemDetail>>(){}.getType());

                assemblyJobOrder.setTransactionDate(DateUtils.newDateTime(assemblyJobOrder.getTransactionDate(),true));
    
                if(assemblyJobOrderBLL.isExist(this.assemblyJobOrder.getCode())) {
                    assemblyJobOrderBLL.update(assemblyJobOrder, listAssemblyJobOrderItemDetail);
                    this.message = "UPDATE DATA SUCCESS.<br/> Code : " + this.assemblyJobOrder.getCode(); 
                }else{
                    assemblyJobOrderBLL.save(assemblyJobOrder, listAssemblyJobOrderItemDetail);
                    this.message = "SAVE DATA SUCCESS.<br/> Code : " + this.assemblyJobOrder.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("assembly-job-order-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);
             
            assemblyJobOrderBLL.delete(this.assemblyJobOrder.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/> Code : " + this.assemblyJobOrder.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
     @Action("assembly-job-order-authority")
    public String financeRequestApAuthority(){
        try{
            
            AssemblyJobOrderBLL assemblyJobOrderBLL = new AssemblyJobOrderBLL(hbmSession);
            String modCode = assemblyJobOrderBLL.MODULECODE_JOB_ORDER;
            
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
                    if (assemblyJobOrderBLL.isUsed(assemblyJobOrder.getCode())){
                        this.error=true;
                        this.errorMessage ="THIS ASSEMBLY JOB ORDER HAS BEEN USED IN OTHER TRANSACTION";
                        return SUCCESS;
                    }
                    break;

                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(modCode, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE DELETE AUTHORITY";
                         return SUCCESS;                       
                    }
                    if (assemblyJobOrderBLL.isUsed(assemblyJobOrder.getCode())){
                        this.error=true;
                        this.errorMessage ="THIS ASSEMBLY JOB ORDER HAS BEEN USED IN OTHER TRANSACTION";
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

    public AssemblyJobOrder getAssemblyJobOrder() {
        return assemblyJobOrder;
    }

    public void setAssemblyJobOrder(AssemblyJobOrder assemblyJobOrder) {
        this.assemblyJobOrder = assemblyJobOrder;
    }

    public List<AssemblyJobOrder> getListAssemblyJobOrder() {
        return listAssemblyJobOrder;
    }

    public void setListAssemblyJobOrder(List<AssemblyJobOrder> listAssemblyJobOrder) {
        this.listAssemblyJobOrder = listAssemblyJobOrder;
    }

    public List<AssemblyJobOrderItemDetail> getListAssemblyJobOrderItemDetail() {
        return listAssemblyJobOrderItemDetail;
    }

    public void setListAssemblyJobOrderItemDetail(List<AssemblyJobOrderItemDetail> listAssemblyJobOrderItemDetail) {
        this.listAssemblyJobOrderItemDetail = listAssemblyJobOrderItemDetail;
    }

    public String getListAssemblyJobOrderItemDetailJSON() {
        return listAssemblyJobOrderItemDetailJSON;
    }

    public void setListAssemblyJobOrderItemDetailJSON(String listAssemblyJobOrderItemDetailJSON) {
        this.listAssemblyJobOrderItemDetailJSON = listAssemblyJobOrderItemDetailJSON;
    }

    public String getAssemblyJobOrderSearchCode() {
        return assemblyJobOrderSearchCode;
    }

    public void setAssemblyJobOrderSearchCode(String assemblyJobOrderSearchCode) {
        this.assemblyJobOrderSearchCode = assemblyJobOrderSearchCode;
    }

    public String getAssemblyJobOrderSearchFinishGoodsCode() {
        return assemblyJobOrderSearchFinishGoodsCode;
    }

    public void setAssemblyJobOrderSearchFinishGoodsCode(String assemblyJobOrderSearchFinishGoodsCode) {
        this.assemblyJobOrderSearchFinishGoodsCode = assemblyJobOrderSearchFinishGoodsCode;
    }

    public String getAssemblyJobOrderSearchFinishGoodsName() {
        return assemblyJobOrderSearchFinishGoodsName;
    }

    public void setAssemblyJobOrderSearchFinishGoodsName(String assemblyJobOrderSearchFinishGoodsName) {
        this.assemblyJobOrderSearchFinishGoodsName = assemblyJobOrderSearchFinishGoodsName;
    }

    public String getAssemblyJobOrderSearchRemark() {
        return assemblyJobOrderSearchRemark;
    }

    public void setAssemblyJobOrderSearchRemark(String assemblyJobOrderSearchRemark) {
        this.assemblyJobOrderSearchRemark = assemblyJobOrderSearchRemark;
    }

    public String getAssemblyJobOrderSearchRefNo() {
        return assemblyJobOrderSearchRefNo;
    }

    public void setAssemblyJobOrderSearchRefNo(String assemblyJobOrderSearchRefNo) {
        this.assemblyJobOrderSearchRefNo = assemblyJobOrderSearchRefNo;
    }

    public Date getAssemblyJobOrderSearchFirstDate() {
        return assemblyJobOrderSearchFirstDate;
    }

    public void setAssemblyJobOrderSearchFirstDate(Date assemblyJobOrderSearchFirstDate) {
        this.assemblyJobOrderSearchFirstDate = assemblyJobOrderSearchFirstDate;
    }

    public Date getAssemblyJobOrderSearchLastDate() {
        return assemblyJobOrderSearchLastDate;
    }

    public void setAssemblyJobOrderSearchLastDate(Date assemblyJobOrderSearchLastDate) {
        this.assemblyJobOrderSearchLastDate = assemblyJobOrderSearchLastDate;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    
}
