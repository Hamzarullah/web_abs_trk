/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.VendorDepositAssignmentBLL;
import com.inkombizz.finance.model.VendorDepositAssignmentTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author egie
 */
@Result (type = "json")
public class VendorDepositAssignmentJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private List<VendorDepositAssignmentTemp> listVendorDepositAssignmentTemp;
    private String actionAuthority = "";
    private VendorDepositAssignmentTemp vendorDepositAssignment;
    private String transType = "";
    private String vendorCode ="";
    private String vendorDepositAssignmentSearchDepositNo ="";
    private String vendorDepositAssignmentSearchRemark="";
    private String vendorDepositAssignmentSearchRefNo="";
    
    private Date vendorDepositAssignmentSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private Date vendorDepositAssignmentSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private String vendorDepositAssignmentSearchCode = "";

    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("vendor-deposit-assignment-data")
    public String findData() {
        try {
            VendorDepositAssignmentBLL vendorDepositAssignmentBLL = new VendorDepositAssignmentBLL(hbmSession);

            ListPaging<VendorDepositAssignmentTemp> listPaging = vendorDepositAssignmentBLL.findData(paging,vendorDepositAssignmentSearchFirstDate,vendorDepositAssignmentSearchLastDate,
                    vendorDepositAssignmentSearchCode, vendorDepositAssignmentSearchDepositNo,vendorDepositAssignmentSearchRemark,vendorDepositAssignmentSearchRefNo);
            
            listVendorDepositAssignmentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-deposit-assignment-authority")
    public String vendorDepositAssignmentAuthority(){
        try{
            
            VendorDepositAssignmentBLL vendorDepositAssignmentBLL = new VendorDepositAssignmentBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("vendor-deposit-assignment-save")
    public String save() {
        try {
            VendorDepositAssignmentBLL vendorDepositAssignmentBLL = new VendorDepositAssignmentBLL(hbmSession);

            vendorDepositAssignmentBLL.save(vendorDepositAssignment);
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.vendorDepositAssignment.getDepositNo() ;
 
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
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

    public List<VendorDepositAssignmentTemp> getListVendorDepositAssignmentTemp() {
        return listVendorDepositAssignmentTemp;
    }

    public void setListVendorDepositAssignmentTemp(List<VendorDepositAssignmentTemp> listVendorDepositAssignmentTemp) {
        this.listVendorDepositAssignmentTemp = listVendorDepositAssignmentTemp;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public Date getVendorDepositAssignmentSearchFirstDate() {
        return vendorDepositAssignmentSearchFirstDate;
    }

    public void setVendorDepositAssignmentSearchFirstDate(Date vendorDepositAssignmentSearchFirstDate) {
        this.vendorDepositAssignmentSearchFirstDate = vendorDepositAssignmentSearchFirstDate;
    }

    public Date getVendorDepositAssignmentSearchLastDate() {
        return vendorDepositAssignmentSearchLastDate;
    }

    public void setVendorDepositAssignmentSearchLastDate(Date vendorDepositAssignmentSearchLastDate) {
        this.vendorDepositAssignmentSearchLastDate = vendorDepositAssignmentSearchLastDate;
    }

    public String getVendorDepositAssignmentSearchCode() {
        return vendorDepositAssignmentSearchCode;
    }

    public void setVendorDepositAssignmentSearchCode(String vendorDepositAssignmentSearchCode) {
        this.vendorDepositAssignmentSearchCode = vendorDepositAssignmentSearchCode;
    }

    public String getTransType() {
        return transType;
    }

    public void setTransType(String transType) {
        this.transType = transType;
    }

    public VendorDepositAssignmentTemp getVendorDepositAssignment() {
        return vendorDepositAssignment;
    }

    public void setVendorDepositAssignment(VendorDepositAssignmentTemp vendorDepositAssignment) {
        this.vendorDepositAssignment = vendorDepositAssignment;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    public String getVendorDepositAssignmentSearchDepositNo() {
        return vendorDepositAssignmentSearchDepositNo;
    }

    public void setVendorDepositAssignmentSearchDepositNo(String vendorDepositAssignmentSearchDepositNo) {
        this.vendorDepositAssignmentSearchDepositNo = vendorDepositAssignmentSearchDepositNo;
    }

    public String getVendorDepositAssignmentSearchRemark() {
        return vendorDepositAssignmentSearchRemark;
    }

    public void setVendorDepositAssignmentSearchRemark(String vendorDepositAssignmentSearchRemark) {
        this.vendorDepositAssignmentSearchRemark = vendorDepositAssignmentSearchRemark;
    }

    public String getVendorDepositAssignmentSearchRefNo() {
        return vendorDepositAssignmentSearchRefNo;
    }

    public void setVendorDepositAssignmentSearchRefNo(String vendorDepositAssignmentSearchRefNo) {
        this.vendorDepositAssignmentSearchRefNo = vendorDepositAssignmentSearchRefNo;
    }

}
