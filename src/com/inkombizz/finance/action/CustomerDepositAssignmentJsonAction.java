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
import com.inkombizz.finance.bll.CustomerDepositAssignmentBLL;
//import com.inkombizz.finance.model.BankReceivedDeposit;
import com.inkombizz.finance.model.CustomerDepositAssignmentTemp;
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
public class CustomerDepositAssignmentJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private List<CustomerDepositAssignmentTemp> listCustomerDepositAssignmentTemp;
    private String actionAuthority = "";
    private CustomerDepositAssignmentTemp customerDepositAssignment;
    private String transType = "";
    private String customerCode ="";
    private String customerDepositAssignmentSearchDepositNo ="";
    private String customerDepositAssignmentSearchRemark="";
    private String customerDepositAssignmentSearchRefNo="";
    
    private Date customerDepositAssignmentSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private Date customerDepositAssignmentSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear()
                        , BaseSession.loadProgramSession().getPeriodMonth());
    private String customerDepositAssignmentSearchCode = "";

    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("customer-deposit-assignment-data")
    public String findData() {
        try {
            CustomerDepositAssignmentBLL customerDepositAssignmentBLL = new CustomerDepositAssignmentBLL(hbmSession);

            ListPaging<CustomerDepositAssignmentTemp> listPaging = customerDepositAssignmentBLL.findData(paging,customerDepositAssignmentSearchFirstDate,customerDepositAssignmentSearchLastDate,
                    customerDepositAssignmentSearchCode, customerDepositAssignmentSearchDepositNo,customerDepositAssignmentSearchRemark,customerDepositAssignmentSearchRefNo);
            
            listCustomerDepositAssignmentTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-deposit-assignment-authority")
    public String customerDepositAssignmentAuthority(){
        try{
            
            CustomerDepositAssignmentBLL customerDepositAssignmentBLL = new CustomerDepositAssignmentBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerDepositAssignmentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("customer-deposit-assignment-save")
    public String save() {
        try {
            CustomerDepositAssignmentBLL customerDepositAssignmentBLL = new CustomerDepositAssignmentBLL(hbmSession);

            customerDepositAssignmentBLL.save(customerDepositAssignment);
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.customerDepositAssignment.getDepositNo() ;
 
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

    public List<CustomerDepositAssignmentTemp> getListCustomerDepositAssignmentTemp() {
        return listCustomerDepositAssignmentTemp;
    }

    public void setListCustomerDepositAssignmentTemp(List<CustomerDepositAssignmentTemp> listCustomerDepositAssignmentTemp) {
        this.listCustomerDepositAssignmentTemp = listCustomerDepositAssignmentTemp;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public Date getCustomerDepositAssignmentSearchFirstDate() {
        return customerDepositAssignmentSearchFirstDate;
    }

    public void setCustomerDepositAssignmentSearchFirstDate(Date customerDepositAssignmentSearchFirstDate) {
        this.customerDepositAssignmentSearchFirstDate = customerDepositAssignmentSearchFirstDate;
    }

    public Date getCustomerDepositAssignmentSearchLastDate() {
        return customerDepositAssignmentSearchLastDate;
    }

    public void setCustomerDepositAssignmentSearchLastDate(Date customerDepositAssignmentSearchLastDate) {
        this.customerDepositAssignmentSearchLastDate = customerDepositAssignmentSearchLastDate;
    }

    public String getCustomerDepositAssignmentSearchCode() {
        return customerDepositAssignmentSearchCode;
    }

    public void setCustomerDepositAssignmentSearchCode(String customerDepositAssignmentSearchCode) {
        this.customerDepositAssignmentSearchCode = customerDepositAssignmentSearchCode;
    }

    public String getTransType() {
        return transType;
    }

    public void setTransType(String transType) {
        this.transType = transType;
    }

    public CustomerDepositAssignmentTemp getCustomerDepositAssignment() {
        return customerDepositAssignment;
    }

    public void setCustomerDepositAssignment(CustomerDepositAssignmentTemp customerDepositAssignment) {
        this.customerDepositAssignment = customerDepositAssignment;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerDepositAssignmentSearchDepositNo() {
        return customerDepositAssignmentSearchDepositNo;
    }

    public void setCustomerDepositAssignmentSearchDepositNo(String customerDepositAssignmentSearchDepositNo) {
        this.customerDepositAssignmentSearchDepositNo = customerDepositAssignmentSearchDepositNo;
    }

    public String getCustomerDepositAssignmentSearchRemark() {
        return customerDepositAssignmentSearchRemark;
    }

    public void setCustomerDepositAssignmentSearchRemark(String customerDepositAssignmentSearchRemark) {
        this.customerDepositAssignmentSearchRemark = customerDepositAssignmentSearchRemark;
    }

    public String getCustomerDepositAssignmentSearchRefNo() {
        return customerDepositAssignmentSearchRefNo;
    }

    public void setCustomerDepositAssignmentSearchRefNo(String customerDepositAssignmentSearchRefNo) {
        this.customerDepositAssignmentSearchRefNo = customerDepositAssignmentSearchRefNo;
    }

}
