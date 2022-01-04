
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CustomerDAO;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.CustomerContact;
import com.inkombizz.master.model.CustomerContactTemp;
import com.inkombizz.master.model.CustomerField;
import com.inkombizz.master.model.CustomerTemp;
import org.hibernate.HibernateException;

public class CustomerBLL {
 
    public static final String MODULECODE = "006_MST_CUSTOMER";
    
    private CustomerDAO customerDAO;
    
    public CustomerBLL (HBMSession hbmSession) {
        this.customerDAO = new CustomerDAO(hbmSession);
    }
    
    public ListPaging<CustomerTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Customer.class);           
    
            paging.setRecords(customerDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerTemp> listCustomerTemp = customerDAO.findData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerTemp> listPaging = new ListPaging<CustomerTemp>();
            
            listPaging.setList(listCustomerTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerTemp> findDataEndUser(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Customer.class);           
    
            paging.setRecords(customerDAO.countDataEndUser(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerTemp> listCustomerTemp = customerDAO.findDataEndUser(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerTemp> listPaging = new ListPaging<CustomerTemp>();
            
            listPaging.setList(listCustomerTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerTemp> findDataCust(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Customer.class);           
    
            paging.setRecords(customerDAO.countDataCust(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerTemp> listCustomerTemp = customerDAO.findDataCust(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerTemp> listPaging = new ListPaging<CustomerTemp>();
            
            listPaging.setList(listCustomerTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerTemp> findDataForCustomerOrder(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Customer.class);           
    
            paging.setRecords(customerDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerTemp> listCustomerTemp = customerDAO.findDataForCustomerOrder(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerTemp> listPaging = new ListPaging<CustomerTemp>();
            
            listPaging.setList(listCustomerTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    public ListPaging<CustomerContactTemp> findDataComponentDetail(String code, String active) throws Exception {
        try {
            List<CustomerContactTemp> listCustomerContactTemp = customerDAO.findDataComponentDetail(code,active);
            ListPaging<CustomerContactTemp> listPaging = new ListPaging<CustomerContactTemp>();
            
            listPaging.setList(listCustomerContactTemp);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CustomerTemp findData(String code) throws Exception {
        try {
            return (CustomerTemp) customerDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerTemp findData(String code,boolean active, boolean status) throws Exception {
        try {
            return (CustomerTemp) customerDAO.findData(code,active, status);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerTemp findDataEnd(String code,boolean active) throws Exception {
        try {
            return (CustomerTemp) customerDAO.findDataEnd(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public Customer get(String code) throws Exception {
        try {
            return (Customer) customerDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Customer customer) throws Exception {
        try {
            customerDAO.save(customer, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Customer customer, List<CustomerContact> listCustomerContactComponent) throws Exception {
        try {
            customerDAO.update(customer, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            customerDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Customer.class)
                            .add(Restrictions.eq(CustomerField.CODE, code));
             
            if(customerDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    public CustomerTemp getMin() throws Exception {
        try {
            return customerDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerTemp getMax() throws Exception {
        try {
            return customerDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }

    public CustomerDAO getCustomerDAO() {
        return customerDAO;
    }

    
    public void setCustomerDAO(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }
    
     public ListPaging<CustomerTemp> findDataCustomerSortName(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(customerDAO.countDataCustomerSortName(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerTemp> listContactCategoryTemp = customerDAO.findDataCustomerSortName(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerTemp> listPaging = new ListPaging<CustomerTemp>();
            
            listPaging.setList(listContactCategoryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
}
