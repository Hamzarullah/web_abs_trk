/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.BranchBLL;
import com.inkombizz.master.bll.CustomerAddressBLL;
import com.inkombizz.master.bll.CustomerDepositTypeBLL;
import com.inkombizz.master.model.BranchTemp;
import com.inkombizz.master.model.CustomerAddressTemp;
import com.inkombizz.master.model.CustomerDepositType;
import com.inkombizz.master.model.CustomerDepositTypeChartOfAccount;
import com.inkombizz.master.model.CustomerDepositTypeChartOfAccountTemp;
import com.inkombizz.master.model.CustomerDepositTypeTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author CHRIST
 */
@Result (type="json")
public class CustomerDepositTypeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerDepositTypeTemp customerDepositTypeTemp;
    private CustomerDepositType customerDepositType;
    private CustomerDepositType customerDepositTypeForReport;
    private List <CustomerDepositTypeTemp> listCustomerDepositTypeTemp;
    private List <CustomerDepositTypeChartOfAccountTemp> listCustomerDepositTypeChartOfAccountTemp;
    private List <CustomerDepositTypeChartOfAccount> listCustomerDepositTypeChartOfAccount;
    private String code="";
    private String customerDepositTypeSearchCode = "";
    private String customerDepositTypeSearchName = "";
    private String listCustomerDepositTypeChartOfAccountJSON="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("customer-deposit-type-data")
    public String findData() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            
            ListPaging <CustomerDepositTypeTemp> listPaging = customerDepositTypeBLL.findData(this.paging);
            listCustomerDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("customer-deposit-type-data-detail-coa")
    public String findDataCoaDetail() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            
            ListPaging <CustomerDepositTypeChartOfAccount> listPaging = customerDepositTypeBLL.findDataCoaDetail(this.paging,customerDepositType);
            listCustomerDepositTypeChartOfAccount = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-deposit-type-search-data")
    public String searchData() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            
            ListPaging <CustomerDepositTypeTemp> listPaging = customerDepositTypeBLL.searchData(this.paging,customerDepositType);
            listCustomerDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("search-customer-deposit-type-report-data-paging")
    public String findDataForReportPaging() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            ListPaging <CustomerDepositTypeTemp> listPaging = customerDepositTypeBLL.findDataReportPaging(paging,customerDepositTypeSearchCode,customerDepositTypeSearchName);
            
            listCustomerDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-deposit-type-search-data-for-report")
    public String searchDataReport() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            
            ListPaging <CustomerDepositTypeTemp> listPaging = customerDepositTypeBLL.searchDataForReport(this.paging,customerDepositTypeForReport);
            listCustomerDepositTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    //get
    @Action("customer-deposit-type-get")
    public String getData() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            
            this.customerDepositTypeTemp = customerDepositTypeBLL.findData(customerDepositType);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-deposit-type-get-report")
    public String getDataReport() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            
            this.customerDepositTypeTemp = customerDepositTypeBLL.findDataForReport(customerDepositType);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("customer-deposit-type-chart-of-account")
    public String findDataCOA(){
        try{
            
            CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);
            List<CustomerDepositTypeChartOfAccount> list = customerDepositTypeBLL.findDataChartOfAccount(code); 
            
            listCustomerDepositTypeChartOfAccount=list;
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-deposit-type-get-min")
    public String populateDataCustomerMin() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL=new CustomerDepositTypeBLL(hbmSession);
            this.customerDepositTypeTemp = customerDepositTypeBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-deposit-type-get-max")
    public String populateDataCustomerMax() {
        try {
            CustomerDepositTypeBLL customerDepositTypeBLL=new CustomerDepositTypeBLL(hbmSession);
            this.customerDepositTypeTemp = customerDepositTypeBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("customer-deposit-type-save")
    public String save() {
        String _Messg = "";
        try {
                CustomerDepositTypeBLL customerDepositTypeBLL = new CustomerDepositTypeBLL(hbmSession);

                Gson gson = new Gson();
                
                this.listCustomerDepositTypeChartOfAccount = gson.fromJson(this.listCustomerDepositTypeChartOfAccountJSON, new TypeToken<List<CustomerDepositTypeChartOfAccount>>(){}.getType());
                       
                customerDepositTypeBLL.save(customerDepositType, listCustomerDepositTypeChartOfAccount);
                
                this.message = "UPDATE DATA SUCCESS.<br/> Code : " + this.customerDepositType.getCode();

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerDepositTypeTemp getCustomerDepositTypeTemp() {
        return customerDepositTypeTemp;
    }

    public void setCustomerDepositTypeTemp(CustomerDepositTypeTemp customerDepositTypeTemp) {
        this.customerDepositTypeTemp = customerDepositTypeTemp;
    }

    public List<CustomerDepositTypeTemp> getListCustomerDepositTypeTemp() {
        return listCustomerDepositTypeTemp;
    }

    public void setListCustomerDepositTypeTemp(List<CustomerDepositTypeTemp> listCustomerDepositTypeTemp) {
        this.listCustomerDepositTypeTemp = listCustomerDepositTypeTemp;
    }

    public List<CustomerDepositTypeChartOfAccountTemp> getListCustomerDepositTypeChartOfAccountTemp() {
        return listCustomerDepositTypeChartOfAccountTemp;
    }

    public void setListCustomerDepositTypeChartOfAccountTemp(List<CustomerDepositTypeChartOfAccountTemp> listCustomerDepositTypeChartOfAccountTemp) {
        this.listCustomerDepositTypeChartOfAccountTemp = listCustomerDepositTypeChartOfAccountTemp;
    }

    public List<CustomerDepositTypeChartOfAccount> getListCustomerDepositTypeChartOfAccount() {
        return listCustomerDepositTypeChartOfAccount;
    }

    public void setListCustomerDepositTypeChartOfAccount(List<CustomerDepositTypeChartOfAccount> listCustomerDepositTypeChartOfAccount) {
        this.listCustomerDepositTypeChartOfAccount = listCustomerDepositTypeChartOfAccount;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public CustomerDepositType getCustomerDepositType() {
        return customerDepositType;
    }

    public void setCustomerDepositType(CustomerDepositType customerDepositType) {
        this.customerDepositType = customerDepositType;
    }

    public String getListCustomerDepositTypeChartOfAccountJSON() {
        return listCustomerDepositTypeChartOfAccountJSON;
    }

    public void setListCustomerDepositTypeChartOfAccountJSON(String listCustomerDepositTypeChartOfAccountJSON) {
        this.listCustomerDepositTypeChartOfAccountJSON = listCustomerDepositTypeChartOfAccountJSON;
    }

    public CustomerDepositType getCustomerDepositTypeForReport() {
        return customerDepositTypeForReport;
    }

    public void setCustomerDepositTypeForReport(CustomerDepositType customerDepositTypeForReport) {
        this.customerDepositTypeForReport = customerDepositTypeForReport;
    }

    public String getCustomerDepositTypeSearchCode() {
        return customerDepositTypeSearchCode;
    }

    public void setCustomerDepositTypeSearchCode(String customerDepositTypeSearchCode) {
        this.customerDepositTypeSearchCode = customerDepositTypeSearchCode;
    }

    public String getCustomerDepositTypeSearchName() {
        return customerDepositTypeSearchName;
    }

    public void setCustomerDepositTypeSearchName(String customerDepositTypeSearchName) {
        this.customerDepositTypeSearchName = customerDepositTypeSearchName;
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
}
