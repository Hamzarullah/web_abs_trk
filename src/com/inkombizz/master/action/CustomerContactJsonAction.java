package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.CustomerContactBLL;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.CustomerContact;
import com.inkombizz.master.model.CustomerContactTemp;
import com.inkombizz.master.model.CustomerTemp;
import static com.opensymphony.xwork2.Action.ERROR;
import static com.opensymphony.xwork2.Action.INPUT;
import static com.opensymphony.xwork2.Action.LOGIN;
import static com.opensymphony.xwork2.Action.NONE;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.logging.Logger;


@Result(type = "json")
public class CustomerContactJsonAction extends ActionSupport {
    
    private static final long serialVersionUID=1L;
    private CommonFunction commonFunction=new CommonFunction();
    protected HBMSession hbmSession=new HBMSession();
    private Customer customer;
    private CustomerContact customerContact;
    private CustomerContactTemp customerContactTemp;
    private List <CustomerTemp> listCustomerTemp;
    private List <CustomerContactTemp> listCustomerContactTemp;
    private String customerContactSearchCustomerCode = "";
    private String customerContactSearchCustomerName = "";
    private String customerContactSearchCustomerActiveStatus="true";
    private String customerContactSearchCode = "";
    private String customerContactSearchName = "";
    private String customerContactSearchActiveStatus="true";
    private String actionAuthority="";
    private String code = "";
    
    @Override
    public String execute() {
        try {
            return findDataCustomer();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    @Action("customer-contact-data-customer")
    public String findDataCustomer() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            ListPaging<CustomerTemp> listPaging = customerContactBLL.findDataCustomer(paging,customerContactSearchCustomerCode,customerContactSearchCustomerName,customerContactSearchCustomerActiveStatus);
            
            listCustomerTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-data")
    public String findData() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            ListPaging <CustomerContactTemp> listPaging = customerContactBLL.findData(customerContactSearchCustomerCode,customerContactSearchCustomerName,customerContactSearchCustomerActiveStatus,paging);
            
            listCustomerContactTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-get-data")
    public String findData1() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            this.customerContactTemp = customerContactBLL.findData(this.customerContact.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-get")
    public String findData2() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            this.customerContactTemp = customerContactBLL.findData(this.customerContact.getCode(),this.customerContact.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-find-one-data")
    public String findOneData() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            this.customerContact = customerContactBLL.get(code);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
     @Action("customer-contact-reload")
    public String findDataCustomerContact() {
        try{
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);            
            List<CustomerContactTemp> list = customerContactBLL.findDataCustomerContactTemp(this.customer.getCode());
            
            listCustomerContactTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-search-data")
    public String Search() {
        try{
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);            
            ListPaging<CustomerContactTemp> listPaging = customerContactBLL.findData(customerContactSearchCode,customerContactSearchName,customerContactSearchActiveStatus,paging);
            
            listCustomerContactTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-authority")
    public String customerContactAuthority(){
        try{
            
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerContactBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerContactBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerContactBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("customer-contact-save")
    public String save() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
//            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss", Locale.ENGLISH);
//
//            Date BirthDateTemp = sdf.parse(customerContactTemp.getBirthDateTemp());
//            customerContact.setBirthDate(BirthDateTemp);

            customerContact.setBirthDate(commonFunction.setDateTime(customerContactTemp.getBirthDateTemp()));
            
            
            if(customerContactBLL.isExist(this.customerContact.getCode())){
                this.errorMessage = "CODE "+this.customerContact.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                customerContactBLL.save(this.customerContact);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.customerContact.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-update")
    public String update() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
            
            customerContactBLL.update(this.customerContact);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.customerContact.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-contact-delete")
    public String delete() {
        try {
            CustomerContactBLL customerContactBLL = new CustomerContactBLL(hbmSession);
//            boolean check=false;// = customerContactBLL.isExistToDelete(this.customer.getCode());
//            if(check == true){
//                this.message = "CODE "+this.customer.getCode() + " : IS READY BE USE...!!!  ";
//            }else{
                customerContactBLL.delete(this.customerContact.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.customerContact.getCode();
//            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

        
    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">
    
    Paging paging=new Paging();
    
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
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CustomerContact getCustomerContact() {
        return customerContact;
    }

    public void setCustomerContact(CustomerContact customerContact) {
        this.customerContact = customerContact;
    }

    public CustomerContactTemp getCustomerContactTemp() {
        return customerContactTemp;
    }

    public void setCustomerContactTemp(CustomerContactTemp customerContactTemp) {
        this.customerContactTemp = customerContactTemp;
    }

    public List<CustomerContactTemp> getListCustomerContactTemp() {
        return listCustomerContactTemp;
    }

    public void setListCustomerContactTemp(List<CustomerContactTemp> listCustomerContactTemp) {
        this.listCustomerContactTemp = listCustomerContactTemp;
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

    public String getCustomerContactSearchCustomerActiveStatus() {
        return customerContactSearchCustomerActiveStatus;
    }

    public void setCustomerContactSearchCustomerActiveStatus(String customerContactSearchCustomerActiveStatus) {
        this.customerContactSearchCustomerActiveStatus = customerContactSearchCustomerActiveStatus;
    }

    public String getCustomerContactSearchCode() {
        return customerContactSearchCode;
    }

    public void setCustomerContactSearchCode(String customerContactSearchCode) {
        this.customerContactSearchCode = customerContactSearchCode;
    }

    public String getCustomerContactSearchName() {
        return customerContactSearchName;
    }

    public void setCustomerContactSearchName(String customerContactSearchName) {
        this.customerContactSearchName = customerContactSearchName;
    }

    public String getCustomerContactSearchActiveStatus() {
        return customerContactSearchActiveStatus;
    }

    public void setCustomerContactSearchActiveStatus(String customerContactSearchActiveStatus) {
        this.customerContactSearchActiveStatus = customerContactSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public static Logger getLOG() {
        return LOG;
    }

    public static void setLOG(Logger LOG) {
        ActionSupport.LOG = LOG;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public List<CustomerTemp> getListCustomerTemp() {
        return listCustomerTemp;
    }

    public void setListCustomerTemp(List<CustomerTemp> listCustomerTemp) {
        this.listCustomerTemp = listCustomerTemp;
    }

    public static String getSUCCESS() {
        return SUCCESS;
    }

    public static String getNONE() {
        return NONE;
    }

    public static String getERROR() {
        return ERROR;
    }

    public static String getINPUT() {
        return INPUT;
    }

    public static String getLOGIN() {
        return LOGIN;
    }

    

  

  
}