/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

/**
 *
 * @author Ulla
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.finance.model.CustomerDownPayment;
import com.inkombizz.finance.model.CustomerDownPaymentTemp;
import com.inkombizz.finance.bll.CustomerDownPaymentBLL;
import com.inkombizz.utils.DateUtils;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Results({
    @Result(name="success", type = "json"),
    @Result(name="pageHTML", location="finance/customer-down-payment.jsp")
})
public class CustomerDownPaymentJsonAction extends ActionSupport{
    
     private static final long serialVersionUID = 1L;    
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerDownPayment customerDownPayment;
    private CustomerDownPaymentTemp customerDownPaymentTemp;
    private String customerDownPaymentSearchCode="";
    private String customerDownPaymentCustomerSearchCode="";
    private String customerDownPaymentCustomerSearchName="";
    private String customerDownPaymentCurrencySearchCode="";
    private Date customerDownPaymentSearchFirstDate=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date customerDownPaymentSearchLastDate=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());;
    private List<CustomerDownPaymentTemp> listCustomerDownPaymentTemp;
    private String sinNo="";
    private String actionAuthority="";
    private boolean isExisting;
    private String customerCode="";
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    
    @Action("customer-down-payment-data")
    public String findData(){
        try{
            
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
            ListPaging<CustomerDownPaymentTemp> listPaging = customerDownPaymentBLL.findData(paging, customerDownPaymentSearchCode,customerDownPaymentCustomerSearchCode,customerDownPaymentCustomerSearchName,customerDownPaymentCurrencySearchCode,customerDownPaymentSearchFirstDate,customerDownPaymentSearchLastDate); 
            
            listCustomerDownPaymentTemp=listPaging.getList();
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("customer-down-payment-save")
    public String save(){
        String _Messg = "";
        try{
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
         
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
                
                Date TransactionDateTemp = sdf.parse(customerDownPaymentTemp.getTransactionDateTemp());
                customerDownPayment.setTransactionDate(TransactionDateTemp);
                
                Date CreatedDateTemp = sdf.parse(customerDownPaymentTemp.getCreatedDateTemp());
                customerDownPayment.setCreatedDate(CreatedDateTemp);
                            
                if(customerDownPaymentBLL.isExist(this.customerDownPayment.getCode())){
                    _Messg="UPDATED ";
                    customerDownPaymentBLL.update(this.customerDownPayment);
                }else{
                    _Messg = "SAVED ";
                    customerDownPaymentBLL.save(this.customerDownPayment);
                }
            
                
            this.message = _Messg+ "DATA SUCCESED. \n CODE : " +customerDownPayment.getCode();
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = _Messg+"DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-down-payment-by-customer-invoice-data")
    public String searchDataByCustomerInvoice() {
        try {

            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
            listCustomerDownPaymentTemp =  customerDownPaymentBLL.findByCustomerInvoice(customerCode);

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-down-payment-update")
    public String update() {
        try {
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
            customerDownPaymentBLL.update(this.customerDownPayment);

            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.customerDownPayment.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
//    @Action("customer-down-payment-search-data")
//    public String searchData() {
//        try {
//            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
//            ListPaging <CustomerDownPaymentTemp> listPaging = customerDownPaymentBLL.search(paging, getCustomerDownPaymentSearchCode(),getCustomerDownPaymentCustomerSearchCode(),getCustomerDownPaymentCustomerSearchName(),getCustomerDownPaymentCurrencySearchCode());
//            
//            listCustomerDownPaymentTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }

    @Action("customer-down-payment-by-customer-invoice-update")
    public String searchSDPByCustomerInvoiceUpdate(){
        try{
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
           
            List<CustomerDownPaymentTemp> list = customerDownPaymentBLL.listDataHeaderByCustomerInvoiceUpdate(this.sinNo,this.customerDownPayment.getCustomer().getCode(),this.customerDownPayment.getCurrency().getCode());
            
            listCustomerDownPaymentTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("customer-down-payment-existing")
    public String existingCustomerInvoice(){
        try{
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);
            switch(actionAuthority){
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerDownPaymentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
            }
            isExisting=customerDownPaymentBLL.checkExistInUsedPaidAmount(this.customerDownPayment.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-down-payment-delete")
    public String deleteCustomerDownPayment(){
        try{
            CustomerDownPaymentBLL customerDownPaymentBLL = new CustomerDownPaymentBLL(hbmSession);

            customerDownPaymentBLL.delete(customerDownPayment.getCode());
            this.message ="DELETE DATA SUCCESS. \n SDP No : " + this.customerDownPayment.getCode();
            
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

    public CustomerDownPayment getCustomerDownPayment() {
        return customerDownPayment;
    }

    public void setCustomerDownPayment(CustomerDownPayment customerDownPayment) {
        this.customerDownPayment = customerDownPayment;
    }

    public CustomerDownPaymentTemp getCustomerDownPaymentTemp() {
        return customerDownPaymentTemp;
    }

    public void setCustomerDownPaymentTemp(CustomerDownPaymentTemp customerDownPaymentTemp) {
        this.customerDownPaymentTemp = customerDownPaymentTemp;
    }

    public String getCustomerDownPaymentSearchCode() {
        return customerDownPaymentSearchCode;
    }

    public void setCustomerDownPaymentSearchCode(String customerDownPaymentSearchCode) {
        this.customerDownPaymentSearchCode = customerDownPaymentSearchCode;
    }

    public String getCustomerDownPaymentCustomerSearchCode() {
        return customerDownPaymentCustomerSearchCode;
    }

    public void setCustomerDownPaymentCustomerSearchCode(String customerDownPaymentCustomerSearchCode) {
        this.customerDownPaymentCustomerSearchCode = customerDownPaymentCustomerSearchCode;
    }

    public String getCustomerDownPaymentCustomerSearchName() {
        return customerDownPaymentCustomerSearchName;
    }

    public void setCustomerDownPaymentCustomerSearchName(String customerDownPaymentCustomerSearchName) {
        this.customerDownPaymentCustomerSearchName = customerDownPaymentCustomerSearchName;
    }

    public String getCustomerDownPaymentCurrencySearchCode() {
        return customerDownPaymentCurrencySearchCode;
    }

    public void setCustomerDownPaymentCurrencySearchCode(String customerDownPaymentCurrencySearchCode) {
        this.customerDownPaymentCurrencySearchCode = customerDownPaymentCurrencySearchCode;
    }

    public Date getCustomerDownPaymentSearchFirstDate() {
        return customerDownPaymentSearchFirstDate;
    }

    public void setCustomerDownPaymentSearchFirstDate(Date customerDownPaymentSearchFirstDate) {
        this.customerDownPaymentSearchFirstDate = customerDownPaymentSearchFirstDate;
    }

    public Date getCustomerDownPaymentSearchLastDate() {
        return customerDownPaymentSearchLastDate;
    }

    public void setCustomerDownPaymentSearchLastDate(Date customerDownPaymentSearchLastDate) {
        this.customerDownPaymentSearchLastDate = customerDownPaymentSearchLastDate;
    }

    public List<CustomerDownPaymentTemp> getListCustomerDownPaymentTemp() {
        return listCustomerDownPaymentTemp;
    }

    public void setListCustomerDownPaymentTemp(List<CustomerDownPaymentTemp> listCustomerDownPaymentTemp) {
        this.listCustomerDownPaymentTemp = listCustomerDownPaymentTemp;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public boolean isIsExisting() {
        return isExisting;
    }

    public void setIsExisting(boolean isExisting) {
        this.isExisting = isExisting;
    }

    public String getSinNo() {
        return sinNo;
    }

    public void setSinNo(String sinNo) {
        this.sinNo = sinNo;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
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
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">\
    
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
