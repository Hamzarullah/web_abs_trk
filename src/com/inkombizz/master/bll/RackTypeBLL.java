
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.RackTypeDAO;
import com.inkombizz.master.model.RackType;
import com.inkombizz.master.model.RackTypeField;
import com.inkombizz.master.model.RackTypeTemp;


public class RackTypeBLL {
    
    public final String MODULECODE = "006_MST_RACK_TYPE";
    
    private RackTypeDAO rackTypeDAO;
    
    public RackTypeBLL(HBMSession hbmSession){
        this.rackTypeDAO=new RackTypeDAO(hbmSession);
    }
    
    public ListPaging<RackTypeTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(RackType.class);           
    
            paging.setRecords(rackTypeDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RackTypeTemp> listRackTypeTemp = rackTypeDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<RackTypeTemp> listPaging = new ListPaging<RackTypeTemp>();
            
            listPaging.setList(listRackTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public RackTypeTemp findData(String code) throws Exception {
        try {
            return (RackTypeTemp) rackTypeDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public RackTypeTemp findData(String code,boolean active) throws Exception {
        try {
            return (RackTypeTemp) rackTypeDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(RackType rackType) throws Exception {
        try {
            rackTypeDAO.save(rackType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(RackType rackType) throws Exception {
        try {
            rackTypeDAO.update(rackType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            rackTypeDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(RackType.class)
                            .add(Restrictions.eq(RackTypeField.CODE, code));
             
            if(rackTypeDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
