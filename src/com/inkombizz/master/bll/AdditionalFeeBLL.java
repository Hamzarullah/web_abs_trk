
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.AdditionalFeeDAO;
import com.inkombizz.master.model.AdditionalFee;
import com.inkombizz.master.model.AdditionalFeeField;
import com.inkombizz.master.model.AdditionalFeeTemp;


public class AdditionalFeeBLL {
    
    public final String MODULECODE = "006_MST_ADDITIONAL_FEE";
    
    private AdditionalFeeDAO additionalFeeDAO;
    
    public AdditionalFeeBLL(HBMSession hbmSession){
        this.additionalFeeDAO=new AdditionalFeeDAO(hbmSession);
    }
    
    public ListPaging<AdditionalFeeTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(AdditionalFee.class);           
    
            paging.setRecords(additionalFeeDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<AdditionalFeeTemp> listAdditionalFeeTemp = additionalFeeDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdditionalFeeTemp> listPaging = new ListPaging<AdditionalFeeTemp>();
            
            listPaging.setList(listAdditionalFeeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ListPaging<AdditionalFeeTemp> findDataFeePurchase(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(AdditionalFee.class);           
    
            paging.setRecords(additionalFeeDAO.countDataFeePurchase(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<AdditionalFeeTemp> listAdditionalFeeTemp = additionalFeeDAO.findDataPurchase(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdditionalFeeTemp> listPaging = new ListPaging<AdditionalFeeTemp>();
            
            listPaging.setList(listAdditionalFeeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ListPaging<AdditionalFeeTemp> findDataFeeSales(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(AdditionalFee.class);           
    
            paging.setRecords(additionalFeeDAO.countDataFeeSales(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<AdditionalFeeTemp> listAdditionalFeeTemp = additionalFeeDAO.findDataSales(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdditionalFeeTemp> listPaging = new ListPaging<AdditionalFeeTemp>();
            
            listPaging.setList(listAdditionalFeeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public AdditionalFeeTemp findData(String code) throws Exception {
        try {
            return (AdditionalFeeTemp) additionalFeeDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public AdditionalFeeTemp findData(String code,boolean active) throws Exception {
        try {
            return (AdditionalFeeTemp) additionalFeeDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    
    public AdditionalFeeTemp findData(String code,boolean active, boolean status) throws Exception {
        try {
            return (AdditionalFeeTemp) additionalFeeDAO.findData(code,active,status);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(AdditionalFee additionalFee) throws Exception {
        try {
            additionalFeeDAO.save(additionalFee, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(AdditionalFee additionalFee) throws Exception {
        try {
            additionalFeeDAO.update(additionalFee, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            additionalFeeDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(AdditionalFee.class)
                            .add(Restrictions.eq(AdditionalFeeField.CODE, code));
             
            if(additionalFeeDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
