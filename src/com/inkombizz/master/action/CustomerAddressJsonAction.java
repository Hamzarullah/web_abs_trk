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
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.CustomerAddressBLL;
import com.inkombizz.master.bll.CustomerBLL;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.CustomerAddress;
import com.inkombizz.master.model.CustomerAddressTemp;
import com.inkombizz.master.model.CustomerTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.Date;

/**
 *
 * @author De4RagiL
 */

@Result (type="json")
public class CustomerAddressJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private Customer customer;
    private CustomerAddress customerAddress;
    private CustomerAddress salesPersonCustomerAddress;
    private CustomerAddress priceListCustomerAddress;
    private CustomerAddress searchCustomerAddress = new CustomerAddress();
    private CustomerAddressTemp customerAddressTemp;
    private List <CustomerAddressTemp> listCustomerAddressTemp;
    private List <CustomerAddress> listCustomerAddress;
    private String actionAuthority="";
    private String searchCustomerAddressStatus ="YES";
    private String customerAddressSearchCustomerCode = "";
    private String code = "";
    private String searchSalesPersonCustomerAddressCustomerCode = "";
    private String searchSalesPersonCustomerAddressCustomerName ="";
    private String searchSalesPersonCustomerAddressSalesPersonCode = "";
    private String searchSalesPersonCustomerAddressSalesPersonName ="";
    private String searchPriceListCustomerAddressCustomerCode = "";
    private String searchPriceListCustomerAddressCustomerName ="";
    private String searchPriceListCustomerAddressPriceTypeCode = "";
    private String searchPriceListCustomerAddressPriceTypeName ="";
    private String priceTypeCode="";
    private String customerAddressCode="";
    private String customerAddressName="";
    private String customerSearchCustomerSubTypeCode="";    
    private String customerSearchCustomerCategoryCode="";
    private String customerSearchIslandCode="";
    private String searchCustomerAddressDetailCode="";
    private String searchCustomerAddressDetailName="";
    private String searchCustomerAddresDetailStatus="";
    
    private List <CustomerTemp> listCustomerTemp;
    private String searchCustomerAddressActiveStatusRAD = "";
    private String searchParentPriceType = "YES";
    private String customerAddressSearchCodeConcat="";
    private String salesOrderCode = "";
    private String customerSearchCode = "";
    private String searchCustomerAddressCode = "";
    private String customerSearchName = "";
    private String customerSearchActiveStatus = "true";
    private String billToCode="";
    private String shipToCode="";
    private String customerCode="";
    private String activeStatus="";
    private String statusBillShip="";
    
    @Override
    public String execute() {
        try {
            return populate();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
        
    @Action("customer-address-search")
    public String search() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
            ListPaging <CustomerAddressTemp> listPaging = customerAddressBLL.findData(this.searchCustomerAddress.getCustomer().getCode() ,this.searchCustomerAddress.getCode(), this.searchCustomerAddress.getName(), searchCustomerAddressStatus, this.paging);
            listCustomerAddressTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-search-customer")
    public String searchCustomer() {
        try {
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
            ListPaging <CustomerTemp> listPaging = customerBLL.findData(customerSearchCode,customerSearchName,customerSearchActiveStatus,paging);
            
            listCustomerTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-search-customer-detail")
    public String searchCustomerDetail() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            ListPaging<CustomerAddressTemp> listPaging = customerAddressBLL.findDataCustomerAddressDetail(paging,searchCustomerAddressDetailCode,searchCustomerAddressDetailName,searchCustomerAddresDetailStatus);
            
            listCustomerAddressTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-search-sales-order")
    public String search2() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
            ListPaging <CustomerAddressTemp> listPaging = customerAddressBLL.findData2(this.searchCustomerAddress.getCustomer().getCode() ,this.searchCustomerAddress.getCode(), this.searchCustomerAddress.getName(), searchCustomerAddressStatus, this.paging);
            listCustomerAddressTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("customer-address-search-by-warehouse")
//    public String searchByWarehouse() {
//        try {
//            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
//            
//            ListPaging <CustomerAddressTemp> listPaging = customerAddressBLL.findDataByWarehouse(this.searchCustomerAddress.getCode(), this.searchCustomerAddress.getName(), searchCustomerAddressStatus, this.paging);
//            listCustomerAddressTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("customer-address-search-data-with-array")
    public String polulateSearchDataWithArray(){
        try{
            
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            ListPaging<CustomerAddressTemp> listPaging = customerAddressBLL.polulateSearchDataWithArray(this.searchCustomerAddress.getCode(), this.searchCustomerAddress.getName(), customerAddressSearchCodeConcat, paging); 
            
            listCustomerAddressTemp=listPaging.getList();
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-data")
    public String populate() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
            ListPaging <CustomerAddressTemp> listPaging = customerAddressBLL.findData(this.searchCustomerAddress.getCode(), this.searchCustomerAddress.getName(), customerAddressSearchCustomerCode, searchCustomerAddressStatus);
            listCustomerAddressTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
//    
//    @Action("sales-person-customer-address-data")
//    public String populateCustomerAddress() {
//        try {
//            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
//            
//            ListPaging <CustomerAddressTemp> listPaging = customerAddressBLL.findDataSalesPersonCustomerAddress(paging,searchSalesPersonCustomerAddressCustomerCode, searchSalesPersonCustomerAddressCustomerName,searchSalesPersonCustomerAddressSalesPersonCode,searchSalesPersonCustomerAddressSalesPersonName, searchCustomerAddressStatus);
//            listCustomerAddressTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {         
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
//    @Action("price-list-customer-address-data")
//    public String populatePriceListCustomerAddress() {
//        try {
//            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
//            
//            ListPaging <CustomerAddressTemp> listPaging = customerAddressBLL.findDataPriceListCustomerAddress(searchPriceListCustomerAddressCustomerCode, 
//                    searchPriceListCustomerAddressCustomerName,searchPriceListCustomerAddressPriceTypeCode,searchPriceListCustomerAddressPriceTypeName, 
//                    searchCustomerAddressStatus, searchParentPriceType,paging);
//            listCustomerAddressTemp = listPaging.getList();
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {         
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("customer-address-get-bill-and-ship")
    public String findDataBillAndShip() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);

            this.customerAddressTemp = customerAddressBLL.findDataBillAndShip(code, activeStatus, statusBillShip);
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-get")
    public String populateGetData() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);

            this.customerAddressTemp = customerAddressBLL.populateGetData(code, customerCode, activeStatus);
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("customer-address-get-sales-order")
    public String populateGetData3() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);

            this.customerAddressTemp = customerAddressBLL.populateGetData3(this.customerAddress.getCode(),this.searchCustomerAddressStatus);
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-reload")
    public String findDataCustomerAddress() {
        try{
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);            
            List<CustomerAddressTemp> list = customerAddressBLL.findDataCustomerAddressTemp(this.customer.getCode());
            
            listCustomerAddressTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    @Action("customer-address-search-by-dln")
    public String findDataCustomerAddressByDln() {
        try{
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);            
            List<CustomerAddressTemp> list = customerAddressBLL.findDataCustomerAddressByDln(this.salesOrderCode, customerAddressCode,customerAddressName);
            
            listCustomerAddressTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
   
    
    @Action("customer-address-find-one-data")
    public String findOneForUpdate() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            customerAddressTemp = customerAddressBLL.findDataForUpdate(code);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-address-save")
    public String save() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
//            if (!BaseSession.loadProgramSession().hasAuthority(CustomerAddressBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
//            }                
            
            if(customerAddress.isActiveStatus() == false){
                customerAddress.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                customerAddress.setInActiveDate(new Date());
            }else{
                customerAddress.setInActiveBy("");
                customerAddress.setInActiveDate(DateUtils.newDate(1900, 1, 1));
            } 
            
//            if(customerAddress.getPriceType().getCode().equalsIgnoreCase("")){
//                customerAddress.setPriceType(null);
//            }
//            if(customerAddressBLL.isExistRegistrationId(this.customerAddress.getCustomerRegistrationId())){
//                this.errorMessage = "REGISTRATION ID "+this.customerAddress.getCustomerRegistrationId()+" HAS BEEN EXISTS IN DATABASE!";
//            }else{
                customerAddressBLL.save(this.customerAddress);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.customerAddress.getCode();
//            }
            
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-update")
    public String update() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(CustomerAddressBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }
            
            if(customerAddress.isActiveStatus() == false){
                customerAddress.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                customerAddress.setInActiveDate(new Date());
            }else{
                customerAddress.setInActiveBy("");
                customerAddress.setInActiveDate(DateUtils.newDate(1900, 1, 1));
            }
            customerAddressBLL.update(this.customerAddress);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.customerAddress.getCode();
          
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("sales-person-customer-address-update")
    public String updateSalesPersonCustomerAddress() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(CustomerAddressBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }
            
            
            customerAddressBLL.updateSalesPerson(this.salesPersonCustomerAddress);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.salesPersonCustomerAddress.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-delete")
    public String delete() {
        try {
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(CustomerAddressBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
                customerAddressBLL.delete(this.customerAddress.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.customerAddress.getCode();
            
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-get-min")
    public String populateDataSupplierMin() {
        try {
            CustomerAddressBLL customerAddressBLL=new CustomerAddressBLL(hbmSession);
            this.customerAddressTemp = customerAddressBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-address-get-max")
    public String populateDataSupplierMax() {
        try {
            CustomerAddressBLL customerAddressBLL=new CustomerAddressBLL(hbmSession);
            this.customerAddressTemp = customerAddressBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("customer-address-authority")
    public String customerAddressAuthority(){
        try{
            
            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerAddressBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerAddressBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerAddressBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
//    @Action("sales-person-customer-address-authority")
//    public String salesPersonCustomerAddressAuthority(){
//        try{
//            
//            CustomerAddressBLL customerAddressBLL = new CustomerAddressBLL(hbmSession);
//            
//            switch(actionAuthority){
//                case "INSERT":
//                    if (!BaseSession.loadProgramSession().hasAuthority(customerAddressBLL.MODULECODE_SALES, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
//                        this.error = true;
//                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
//                        return SUCCESS;
//                    }
//                    break;
//                case "UPDATE":
//                    if (!BaseSession.loadProgramSession().hasAuthority(customerAddressBLL.MODULECODE_SALES, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
//                        this.error = true;
//                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
//                        return SUCCESS;
//                    }
//                    break;
//                case "DELETE":
//                    if (!BaseSession.loadProgramSession().hasAuthority(customerAddressBLL.MODULECODE_SALES, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
//                        this.error = true;
//                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
//                        return SUCCESS;
//                    }
//                    break;
//                
//            }
//            
//            
//            return SUCCESS;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return SUCCESS;
//        }
//    }
  

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

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public CustomerAddress getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(CustomerAddress customerAddress) {
        this.customerAddress = customerAddress;
    }

    public CustomerAddress getSalesPersonCustomerAddress() {
        return salesPersonCustomerAddress;
    }

    public void setSalesPersonCustomerAddress(CustomerAddress salesPersonCustomerAddress) {
        this.salesPersonCustomerAddress = salesPersonCustomerAddress;
    }

    public CustomerAddress getPriceListCustomerAddress() {
        return priceListCustomerAddress;
    }

    public void setPriceListCustomerAddress(CustomerAddress priceListCustomerAddress) {
        this.priceListCustomerAddress = priceListCustomerAddress;
    }

    public CustomerAddress getSearchCustomerAddress() {
        return searchCustomerAddress;
    }

    public void setSearchCustomerAddress(CustomerAddress searchCustomerAddress) {
        this.searchCustomerAddress = searchCustomerAddress;
    }

    public CustomerAddressTemp getCustomerAddressTemp() {
        return customerAddressTemp;
    }

    public void setCustomerAddressTemp(CustomerAddressTemp customerAddressTemp) {
        this.customerAddressTemp = customerAddressTemp;
    }

    public List<CustomerAddressTemp> getListCustomerAddressTemp() {
        return listCustomerAddressTemp;
    }

    public void setListCustomerAddressTemp(List<CustomerAddressTemp> listCustomerAddressTemp) {
        this.listCustomerAddressTemp = listCustomerAddressTemp;
    }

    public List<CustomerAddress> getListCustomerAddress() {
        return listCustomerAddress;
    }

    public void setListCustomerAddress(List<CustomerAddress> listCustomerAddress) {
        this.listCustomerAddress = listCustomerAddress;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getSearchCustomerAddressStatus() {
        return searchCustomerAddressStatus;
    }

    public void setSearchCustomerAddressStatus(String searchCustomerAddressStatus) {
        this.searchCustomerAddressStatus = searchCustomerAddressStatus;
    }

    public String getCustomerAddressSearchCustomerCode() {
        return customerAddressSearchCustomerCode;
    }

    public void setCustomerAddressSearchCustomerCode(String customerAddressSearchCustomerCode) {
        this.customerAddressSearchCustomerCode = customerAddressSearchCustomerCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getSearchSalesPersonCustomerAddressCustomerCode() {
        return searchSalesPersonCustomerAddressCustomerCode;
    }

    public void setSearchSalesPersonCustomerAddressCustomerCode(String searchSalesPersonCustomerAddressCustomerCode) {
        this.searchSalesPersonCustomerAddressCustomerCode = searchSalesPersonCustomerAddressCustomerCode;
    }

    public String getSearchSalesPersonCustomerAddressCustomerName() {
        return searchSalesPersonCustomerAddressCustomerName;
    }

    public void setSearchSalesPersonCustomerAddressCustomerName(String searchSalesPersonCustomerAddressCustomerName) {
        this.searchSalesPersonCustomerAddressCustomerName = searchSalesPersonCustomerAddressCustomerName;
    }

    public String getSearchSalesPersonCustomerAddressSalesPersonCode() {
        return searchSalesPersonCustomerAddressSalesPersonCode;
    }

    public void setSearchSalesPersonCustomerAddressSalesPersonCode(String searchSalesPersonCustomerAddressSalesPersonCode) {
        this.searchSalesPersonCustomerAddressSalesPersonCode = searchSalesPersonCustomerAddressSalesPersonCode;
    }

    public String getSearchSalesPersonCustomerAddressSalesPersonName() {
        return searchSalesPersonCustomerAddressSalesPersonName;
    }

    public void setSearchSalesPersonCustomerAddressSalesPersonName(String searchSalesPersonCustomerAddressSalesPersonName) {
        this.searchSalesPersonCustomerAddressSalesPersonName = searchSalesPersonCustomerAddressSalesPersonName;
    }

    public String getSearchPriceListCustomerAddressCustomerCode() {
        return searchPriceListCustomerAddressCustomerCode;
    }

    public void setSearchPriceListCustomerAddressCustomerCode(String searchPriceListCustomerAddressCustomerCode) {
        this.searchPriceListCustomerAddressCustomerCode = searchPriceListCustomerAddressCustomerCode;
    }

    public String getSearchPriceListCustomerAddressCustomerName() {
        return searchPriceListCustomerAddressCustomerName;
    }

    public void setSearchPriceListCustomerAddressCustomerName(String searchPriceListCustomerAddressCustomerName) {
        this.searchPriceListCustomerAddressCustomerName = searchPriceListCustomerAddressCustomerName;
    }

    public String getSearchPriceListCustomerAddressPriceTypeCode() {
        return searchPriceListCustomerAddressPriceTypeCode;
    }

    public void setSearchPriceListCustomerAddressPriceTypeCode(String searchPriceListCustomerAddressPriceTypeCode) {
        this.searchPriceListCustomerAddressPriceTypeCode = searchPriceListCustomerAddressPriceTypeCode;
    }

    public String getSearchPriceListCustomerAddressPriceTypeName() {
        return searchPriceListCustomerAddressPriceTypeName;
    }

    public void setSearchPriceListCustomerAddressPriceTypeName(String searchPriceListCustomerAddressPriceTypeName) {
        this.searchPriceListCustomerAddressPriceTypeName = searchPriceListCustomerAddressPriceTypeName;
    }

    public String getPriceTypeCode() {
        return priceTypeCode;
    }

    public void setPriceTypeCode(String priceTypeCode) {
        this.priceTypeCode = priceTypeCode;
    }

    public String getCustomerAddressCode() {
        return customerAddressCode;
    }

    public void setCustomerAddressCode(String customerAddressCode) {
        this.customerAddressCode = customerAddressCode;
    }

    public String getCustomerAddressName() {
        return customerAddressName;
    }

    public void setCustomerAddressName(String customerAddressName) {
        this.customerAddressName = customerAddressName;
    }

    public String getCustomerSearchCustomerSubTypeCode() {
        return customerSearchCustomerSubTypeCode;
    }

    public void setCustomerSearchCustomerSubTypeCode(String customerSearchCustomerSubTypeCode) {
        this.customerSearchCustomerSubTypeCode = customerSearchCustomerSubTypeCode;
    }

    public String getCustomerSearchCustomerCategoryCode() {
        return customerSearchCustomerCategoryCode;
    }

    public void setCustomerSearchCustomerCategoryCode(String customerSearchCustomerCategoryCode) {
        this.customerSearchCustomerCategoryCode = customerSearchCustomerCategoryCode;
    }

    public String getCustomerSearchIslandCode() {
        return customerSearchIslandCode;
    }

    public void setCustomerSearchIslandCode(String customerSearchIslandCode) {
        this.customerSearchIslandCode = customerSearchIslandCode;
    }

    public String getSearchCustomerAddressDetailCode() {
        return searchCustomerAddressDetailCode;
    }

    public void setSearchCustomerAddressDetailCode(String searchCustomerAddressDetailCode) {
        this.searchCustomerAddressDetailCode = searchCustomerAddressDetailCode;
    }

    public String getSearchCustomerAddressDetailName() {
        return searchCustomerAddressDetailName;
    }

    public void setSearchCustomerAddressDetailName(String searchCustomerAddressDetailName) {
        this.searchCustomerAddressDetailName = searchCustomerAddressDetailName;
    }

    public String getSearchCustomerAddresDetailStatus() {
        return searchCustomerAddresDetailStatus;
    }

    public void setSearchCustomerAddresDetailStatus(String searchCustomerAddresDetailStatus) {
        this.searchCustomerAddresDetailStatus = searchCustomerAddresDetailStatus;
    }

    public List<CustomerTemp> getListCustomerTemp() {
        return listCustomerTemp;
    }

    public void setListCustomerTemp(List<CustomerTemp> listCustomerTemp) {
        this.listCustomerTemp = listCustomerTemp;
    }

    public String getSearchCustomerAddressActiveStatusRAD() {
        return searchCustomerAddressActiveStatusRAD;
    }

    public void setSearchCustomerAddressActiveStatusRAD(String searchCustomerAddressActiveStatusRAD) {
        this.searchCustomerAddressActiveStatusRAD = searchCustomerAddressActiveStatusRAD;
    }

    public String getSearchParentPriceType() {
        return searchParentPriceType;
    }

    public void setSearchParentPriceType(String searchParentPriceType) {
        this.searchParentPriceType = searchParentPriceType;
    }

    public String getCustomerAddressSearchCodeConcat() {
        return customerAddressSearchCodeConcat;
    }

    public void setCustomerAddressSearchCodeConcat(String customerAddressSearchCodeConcat) {
        this.customerAddressSearchCodeConcat = customerAddressSearchCodeConcat;
    }

    public String getSalesOrderCode() {
        return salesOrderCode;
    }

    public void setSalesOrderCode(String salesOrderCode) {
        this.salesOrderCode = salesOrderCode;
    }

    public String getCustomerSearchCode() {
        return customerSearchCode;
    }

    public void setCustomerSearchCode(String customerSearchCode) {
        this.customerSearchCode = customerSearchCode;
    }

    public String getSearchCustomerAddressCode() {
        return searchCustomerAddressCode;
    }

    public void setSearchCustomerAddressCode(String searchCustomerAddressCode) {
        this.searchCustomerAddressCode = searchCustomerAddressCode;
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

    public String getBillToCode() {
        return billToCode;
    }

    public void setBillToCode(String billToCode) {
        this.billToCode = billToCode;
    }

    public String getShipToCode() {
        return shipToCode;
    }

    public void setShipToCode(String shipToCode) {
        this.shipToCode = shipToCode;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(String activeStatus) {
        this.activeStatus = activeStatus;
    }

    public String getStatusBillShip() {
        return statusBillShip;
    }

    public void setStatusBillShip(String statusBillShip) {
        this.statusBillShip = statusBillShip;
    }
    
    
}
