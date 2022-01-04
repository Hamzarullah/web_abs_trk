
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasDesignDAO;
import com.inkombizz.master.model.DcasDesign;
import com.inkombizz.master.model.DcasDesignField;
import com.inkombizz.master.model.DcasDesignTemp;


public class DcasDesignBLL {
    
    public final String MODULECODE = "006_MST_DCAS_DESIGN";
    
    private DcasDesignDAO dcasDesignDAO;
    
    public DcasDesignBLL(HBMSession hbmSession){
        this.dcasDesignDAO=new DcasDesignDAO(hbmSession);
    }
    
    public ListPaging<DcasDesignTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasDesign.class);           
    
            paging.setRecords(dcasDesignDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasDesignTemp> listDcasDesignTemp = dcasDesignDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasDesignTemp> listPaging = new ListPaging<DcasDesignTemp>();
            
            listPaging.setList(listDcasDesignTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasDesignTemp findData(String code) throws Exception {
        try {
            return (DcasDesignTemp) dcasDesignDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasDesignTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasDesignTemp) dcasDesignDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasDesign dcasDesign) throws Exception {
        try {
            dcasDesignDAO.save(dcasDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasDesign dcasDesign) throws Exception {
        try {
            dcasDesignDAO.update(dcasDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasDesignDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasDesign.class)
                            .add(Restrictions.eq(DcasDesignField.CODE, code));
             
            if(dcasDesignDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
