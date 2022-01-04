package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CustomerCategoryDAO;
import com.inkombizz.master.model.CustomerCategory;
import com.inkombizz.master.model.CustomerCategoryField;
import com.inkombizz.master.model.CustomerCategoryTemp;


public class CustomerCategoryBLL {
    
    public final String MODULECODE = "006_MST_CUSTOMER_CATEGORY";
    
    private CustomerCategoryDAO customerCategoryDAO;
    
    public CustomerCategoryBLL(HBMSession hbmSession){
        this.customerCategoryDAO=new CustomerCategoryDAO(hbmSession);
    }
    
    public ListPaging<CustomerCategoryTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerCategory.class);           
    
            paging.setRecords(customerCategoryDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerCategoryTemp> listCustomerCategoryTemp = customerCategoryDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerCategoryTemp> listPaging = new ListPaging<CustomerCategoryTemp>();
            
            listPaging.setList(listCustomerCategoryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public CustomerCategoryTemp findData(String code) throws Exception {
        try {
            return (CustomerCategoryTemp) customerCategoryDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerCategoryTemp findData(String code,boolean active) throws Exception {
        try {
            return (CustomerCategoryTemp) customerCategoryDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(CustomerCategory customerCategory) throws Exception {
        try {
            customerCategoryDAO.save(customerCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerCategory customerCategory) throws Exception {
        try {
            customerCategoryDAO.update(customerCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            customerCategoryDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerCategory.class)
                            .add(Restrictions.eq(CustomerCategoryField.CODE, code));
             
            if(customerCategoryDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
