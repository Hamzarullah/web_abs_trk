package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.CustomerContactDAO;
import com.inkombizz.master.dao.CustomerDAO;
import com.inkombizz.master.model.Customer;
//import com.inkombizz.master.model.CustomerBranchTemp;
import com.inkombizz.master.model.CustomerContact;
import com.inkombizz.master.model.CustomerContactField;
import com.inkombizz.master.model.CustomerContactTemp;
import com.inkombizz.master.model.CustomerField;
import com.inkombizz.master.model.CustomerTemp;
import org.hibernate.criterion.Restrictions;

public class CustomerContactBLL {
    public static final String MODULECODE = "006_MST_CUSTOMER_CONTACT";
    
    private CustomerContactDAO customerContactDAO;

    public CustomerContactBLL(HBMSession hbmSession) {
        this.customerContactDAO = new CustomerContactDAO(hbmSession);
    }
	
     public ListPaging<CustomerContactTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Customer.class);           
    
            paging.setRecords(customerContactDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerContactTemp> listCustomerContactTemp = customerContactDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerContactTemp> listPaging = new ListPaging<CustomerContactTemp>();
            
            listPaging.setList(listCustomerContactTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<CustomerTemp> findDataCustomer(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(customerContactDAO.countDataCustomer(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerTemp> listCustomerTemp = customerContactDAO.findDataCustomer(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerTemp> listPaging = new ListPaging<CustomerTemp>();
            
            listPaging.setList(listCustomerTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }          
    public ListPaging<CustomerContactTemp> findDataContact(Paging paging,String customerCode,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(customerContactDAO.countDataContact(customerCode,code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerContactTemp> listCustomerContactTemp = customerContactDAO.findData(customerCode,code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerContactTemp> listPaging = new ListPaging<CustomerContactTemp>();
            
            listPaging.setList(listCustomerContactTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }     
    
    public CustomerContactTemp findData(String code) throws Exception {
        try {
            return (CustomerContactTemp) customerContactDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerContactTemp findData(String code,boolean active) throws Exception {
        try {
            return (CustomerContactTemp) customerContactDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerContact get(String code){
        try{
            return (CustomerContact) customerContactDAO.get(code);
        }catch(Exception e){
            throw e;
        }
    }
     public List<CustomerContactTemp> findDataCustomerContactTemp(String headerCode) throws Exception {
        try {

            List<CustomerContactTemp> listCustomerContactTemp = customerContactDAO.findDataCustomerContactTemp(headerCode);

            return listCustomerContactTemp;
        } catch (Exception e) {
            throw e;
        }
    }
     
    public void save(CustomerContact customerContact) throws Exception {
        try {
            customerContactDAO.save(customerContact, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerContact customerContact) throws Exception {
        try {
            customerContactDAO.update(customerContact, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            customerContactDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerContact.class)
                            .add(Restrictions.eq(CustomerContactField.CODE, code));
             
            if(customerContactDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public CustomerContactDAO getCustomerContactDAO() {
        return customerContactDAO;
    }

    public void setCustomerContactDAO(CustomerContactDAO customerContactDAO) {
        this.customerContactDAO = customerContactDAO;
    }

    public static String getMODULECODE() {
        return MODULECODE;
    }
    
}
