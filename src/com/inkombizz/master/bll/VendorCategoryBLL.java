
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.VendorCategoryDAO;
import com.inkombizz.master.model.VendorCategory;
import com.inkombizz.master.model.VendorCategoryField;
import com.inkombizz.master.model.VendorCategoryTemp;


public class VendorCategoryBLL {
    
    public final String MODULECODE = "006_MST_VENDOR_CATEGORY";
    
    private VendorCategoryDAO vendorCategoryDAO;
    
    public VendorCategoryBLL(HBMSession hbmSession){
        this.vendorCategoryDAO=new VendorCategoryDAO(hbmSession);
    }
    
    public ListPaging<VendorCategoryTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorCategory.class);           
    
            paging.setRecords(vendorCategoryDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorCategoryTemp> listVendorCategoryTemp = vendorCategoryDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorCategoryTemp> listPaging = new ListPaging<VendorCategoryTemp>();
            
            listPaging.setList(listVendorCategoryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public VendorCategoryTemp findData(String code) throws Exception {
        try {
            return (VendorCategoryTemp) vendorCategoryDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public VendorCategoryTemp findData(String code,boolean active) throws Exception {
        try {
            return (VendorCategoryTemp) vendorCategoryDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(VendorCategory vendorCategory) throws Exception {
        try {
            vendorCategoryDAO.save(vendorCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(VendorCategory vendorCategory) throws Exception {
        try {
            vendorCategoryDAO.update(vendorCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            vendorCategoryDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorCategory.class)
                            .add(Restrictions.eq(VendorCategoryField.CODE, code));
             
            if(vendorCategoryDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
