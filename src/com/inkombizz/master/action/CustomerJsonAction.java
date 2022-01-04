
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.CustomerBLL;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.CustomerContact;
import com.inkombizz.master.model.CustomerContactTemp;
import com.inkombizz.master.model.CustomerTemp;

import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.Date;

@Result (type="json")
public class CustomerJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Customer customer;
    private CustomerTemp customerTemp;
    private List <CustomerTemp> listCustomerTemp;
    private List <CustomerTemp> listEndUserTemp;
    private List <CustomerContactTemp> listCustomerContactTemp;
    private List <Customer> listCustomer;
    private List <CustomerContact> listCustomerContactComponent;
    
    private String customerSearchBranch = "";
    private String customerSearchCode = "";
    private String customerSearchName = "";
    private String customerSearchActiveStatus = "true";
    private String customerContactSearchCustomerCode = "";
    private String customerContactSearchCustomerName = "";
    private String customerContactSearchActiveStatus = "true";
    private String actionAuthority="";
    private String customerStatus ="";
    private String listCustomerJSON="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("customer-data")
    public String findData() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            ListPaging <CustomerTemp> listPaging = customerBLL.findData(customerSearchCode,customerSearchName,customerSearchActiveStatus,paging);
            
            listCustomerTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-search-data")
    public String findDataCust() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            ListPaging <CustomerTemp> listPaging = customerBLL.findDataCust(customerSearchCode,customerSearchName,customerSearchActiveStatus,paging);
            
            listCustomerTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-end-user-data")
    public String findDataEndUser() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            ListPaging <CustomerTemp> listPaging = customerBLL.findDataEndUser(customerSearchCode,customerSearchName,customerSearchActiveStatus,paging);
            
            listEndUserTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-data")
    public String findDataContact() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            ListPaging <CustomerTemp> listPaging = customerBLL.findData(customerContactSearchCustomerCode,customerContactSearchCustomerName,customerContactSearchActiveStatus,paging);
            
            listCustomerTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("customer-get-data")
    public String findDatadetail() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            this.customerTemp = customerBLL.findData(this.customer.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-get")
    public String findData2() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            this.customerTemp = customerBLL.findData(this.customer.getCode(),this.customer.isActiveStatus(),this.customer.isCustomerStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-get-end-user")
    public String findData3() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            this.customerTemp = customerBLL.findDataEnd(this.customer.getCode(),this.customer.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-data-customer-order")
    public String findDataForCustomerOrder() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            ListPaging<CustomerTemp> listPaging = customerBLL.findDataForCustomerOrder(customerSearchCode,customerSearchName,customerSearchActiveStatus,paging);
            
            listCustomerTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-authority")
    public String customerAuthority(){
        try{
            
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("customer-save")
    public String save() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
           
            if(customerBLL.isExist(this.customer.getCode())){
                this.errorMessage = "CODE "+this.customer.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                customerBLL.save(this.customer);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.customer.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-update")
    public String update() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(CustomerBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }
            
            if(customer.isActiveStatus() == false){
                customer.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                customer.setInActiveDate(new Date());
            }else{
                customer.setInActiveBy("");
                customer.setInActiveDate(DateUtils.newDate(1900, 1, 1));
            } 
            
            Gson gson = new Gson();
            this.listCustomer = gson.fromJson(this.listCustomerJSON, new TypeToken<List<CustomerContact>>(){}.getType());
            
            customerBLL.update(this.customer, this.listCustomerContactComponent);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.customer.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-delete")
    public String delete() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            
            boolean check=false;// = customerBLL.isExistToDelete(this.customer.getCode());
            if(check == true){
                this.message = "CODE "+this.customer.getCode() + " : IS READY BE USE...!!!  ";
            }else{
                customerBLL.delete(this.customer.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.customer.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

     @Action("customer-get-min")
    public String populateDataVendorMin() {
        try {
            CustomerBLL customerBLL=new CustomerBLL(hbmSession);
            this.customerTemp = customerBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-get-max")
    public String populateDataVendorMax() {
        try {
            CustomerBLL customerBLL=new CustomerBLL(hbmSession);
            this.customerTemp = customerBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public CustomerTemp getCustomerTemp() {
        return customerTemp;
    }

    public void setCustomerTemp(CustomerTemp customerTemp) {
        this.customerTemp = customerTemp;
    }

    public List<CustomerTemp> getListCustomerTemp() {
        return listCustomerTemp;
    }

    public void setListCustomerTemp(List<CustomerTemp> listCustomerTemp) {
        this.listCustomerTemp = listCustomerTemp;
    }

    public String getCustomerSearchBranch() {
        return customerSearchBranch;
    }

    public void setCustomerSearchBranch(String customerSearchBranch) {
        this.customerSearchBranch = customerSearchBranch;
    }

    
    public String getCustomerSearchCode() {
        return customerSearchCode;
    }

    public void setCustomerSearchCode(String customerSearchCode) {
        this.customerSearchCode = customerSearchCode;
    }

    public String getCustomerSearchName() {
        return customerSearchName;
    }

    public void setCustomerSearchName(String customerSearchName) {
        this.customerSearchName = customerSearchName;
    }

    public String getCustomerSearchActiveStatus() {
        return customerSearchActiveStatus;
    }

    public void setCustomerSearchActiveStatus(String customerSearchActiveStatus) {
        this.customerSearchActiveStatus = customerSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public String getCustomerContactSearchCustomerCode() {
        return customerContactSearchCustomerCode;
    }

    public void setCustomerContactSearchCustomerCode(String customerContactSearchCustomerCode) {
        this.customerContactSearchCustomerCode = customerContactSearchCustomerCode;
    }

    public String getCustomerContactSearchCustomerName() {
        return customerContactSearchCustomerName;
    }

    public void setCustomerContactSearchCustomerName(String customerContactSearchCustomerName) {
        this.customerContactSearchCustomerName = customerContactSearchCustomerName;
    }

    public String getCustomerContactSearchActiveStatus() {
        return customerContactSearchActiveStatus;
    }

    public void setCustomerContactSearchActiveStatus(String customerContactSearchActiveStatus) {
        this.customerContactSearchActiveStatus = customerContactSearchActiveStatus;
    }

    public List<CustomerContactTemp> getListCustomerContactTemp() {
        return listCustomerContactTemp;
    }

    public void setListCustomerContactTemp(List<CustomerContactTemp> listCustomerContactTemp) {
        this.listCustomerContactTemp = listCustomerContactTemp;
    }

    public List<Customer> getListCustomer() {
        return listCustomer;
    }

    public void setListCustomer(List<Customer> listCustomer) {
        this.listCustomer = listCustomer;
    }

    public List<CustomerContact> getListCustomerContactComponent() {
        return listCustomerContactComponent;
    }

    public void setListCustomerContactComponent(List<CustomerContact> listCustomerContactComponent) {
        this.listCustomerContactComponent = listCustomerContactComponent;
    }

    public String getListCustomerJSON() {
        return listCustomerJSON;
    }

    public void setListCustomerJSON(String listCustomerJSON) {
        this.listCustomerJSON = listCustomerJSON;
    }

    public String getCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(String customerStatus) {
        this.customerStatus = customerStatus;
    }

    public List<CustomerTemp> getListEndUserTemp() {
        return listEndUserTemp;
    }

    public void setListEndUserTemp(List<CustomerTemp> listEndUserTemp) {
        this.listEndUserTemp = listEndUserTemp;
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
