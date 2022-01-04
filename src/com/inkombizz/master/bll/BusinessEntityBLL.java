
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.BusinessEntityDAO;
import com.inkombizz.master.model.BusinessEntity;
import com.inkombizz.master.model.BusinessEntityField;
import com.inkombizz.master.model.BusinessEntityTemp;


public class BusinessEntityBLL {
    
    public static final String MODULECODE = "006_MST_BUSINESS_ENTITY";
    
    private BusinessEntityDAO businessEntityDAO;
    
    public BusinessEntityBLL (HBMSession hbmSession) {
        this.businessEntityDAO = new BusinessEntityDAO(hbmSession);
    }
        
    public ListPaging<BusinessEntityTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(BusinessEntity.class); 
            
            paging.setRecords(businessEntityDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BusinessEntityTemp> listBusinessEntityTemp = businessEntityDAO.findData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BusinessEntityTemp> listPaging = new ListPaging<BusinessEntityTemp>();
            
            listPaging.setList(listBusinessEntityTemp);
            listPaging.setPaging(paging);
            
                return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<BusinessEntityTemp> findData(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(businessEntityDAO.countData(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BusinessEntityTemp> listBusinessEntityTemp = businessEntityDAO.findData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BusinessEntityTemp> listPaging = new ListPaging<BusinessEntityTemp>();
            
            listPaging.setList(listBusinessEntityTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    
    public BusinessEntityTemp findData(String code) throws Exception {
        try {
            return (BusinessEntityTemp) businessEntityDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BusinessEntityTemp findData(String code,boolean active) throws Exception {
        try {
            return (BusinessEntityTemp) businessEntityDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BusinessEntity get(String code) throws Exception {
        try {
            return (BusinessEntity) businessEntityDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BusinessEntityTemp get(String code,boolean active) throws Exception {
        try {
            return (BusinessEntityTemp) businessEntityDAO.findOneData(code, active);
        }
        catch (Exception e) {
            throw e;
        }
    }
//    
//    public List<ExchangerateTaxTemp> getForProcessing() throws Exception {
//        try {
//            return (List<ExchangerateTaxTemp>) businessEntityDAO.getForProcessing();
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
    
    public void save(BusinessEntity businessEntity) throws Exception {
        try {
            businessEntityDAO.save(businessEntity, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(BusinessEntity businessEntity) throws Exception {
        try {
            businessEntityDAO.update(businessEntity, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            businessEntityDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
        
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;

            DetachedCriteria criteria = DetachedCriteria.forClass(BusinessEntity.class)
                            .add(Restrictions.eq(BusinessEntityField.CODE, code));

            if(businessEntityDAO.countByCriteria(criteria) > 0)
                 exist = true;

            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
       
}
