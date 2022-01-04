
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasFireSafeByDesignDAO;
import com.inkombizz.master.model.DcasFireSafeByDesign;
import com.inkombizz.master.model.DcasFireSafeByDesignField;
import com.inkombizz.master.model.DcasFireSafeByDesignTemp;


public class DcasFireSafeByDesignBLL {
    
    public final String MODULECODE = "006_MST_DCAS_FIRE_SAFE_BY_DESIGN";
    
    private DcasFireSafeByDesignDAO dcasFireSafeByDesignDAO;
    
    public DcasFireSafeByDesignBLL(HBMSession hbmSession){
        this.dcasFireSafeByDesignDAO=new DcasFireSafeByDesignDAO(hbmSession);
    }
    
    public ListPaging<DcasFireSafeByDesignTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasFireSafeByDesign.class);           
    
            paging.setRecords(dcasFireSafeByDesignDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasFireSafeByDesignTemp> listDcasFireSafeByDesignTemp = dcasFireSafeByDesignDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasFireSafeByDesignTemp> listPaging = new ListPaging<DcasFireSafeByDesignTemp>();
            
            listPaging.setList(listDcasFireSafeByDesignTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasFireSafeByDesignTemp findData(String code) throws Exception {
        try {
            return (DcasFireSafeByDesignTemp) dcasFireSafeByDesignDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasFireSafeByDesignTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasFireSafeByDesignTemp) dcasFireSafeByDesignDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasFireSafeByDesign dcasFireSafeByDesign) throws Exception {
        try {
            dcasFireSafeByDesignDAO.save(dcasFireSafeByDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasFireSafeByDesign dcasFireSafeByDesign) throws Exception {
        try {
            dcasFireSafeByDesignDAO.update(dcasFireSafeByDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasFireSafeByDesignDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasFireSafeByDesign.class)
                            .add(Restrictions.eq(DcasFireSafeByDesignField.CODE, code));
             
            if(dcasFireSafeByDesignDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
