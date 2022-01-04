
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ValveTypeDAO;
import com.inkombizz.master.model.ValveType;
import com.inkombizz.master.model.ValveTypeField;
import com.inkombizz.master.model.ValveTypeTemp;


public class ValveTypeBLL {
    
    public final String MODULECODE = "006_MST_VALVE_TYPE";
    
    private ValveTypeDAO valveTypeDAO;
    
    public ValveTypeBLL(HBMSession hbmSession){
        this.valveTypeDAO=new ValveTypeDAO(hbmSession);
    }
    
    public ListPaging<ValveTypeTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ValveType.class);           
    
            paging.setRecords(valveTypeDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ValveTypeTemp> listValveTypeTemp = valveTypeDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ValveTypeTemp> listPaging = new ListPaging<ValveTypeTemp>();
            
            listPaging.setList(listValveTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ValveTypeTemp findData(String code) throws Exception {
        try {
            return (ValveTypeTemp) valveTypeDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ValveTypeTemp findData(String code,boolean active) throws Exception {
        try {
            return (ValveTypeTemp) valveTypeDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ValveType valveType) throws Exception {
        try {
            valveTypeDAO.save(valveType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ValveType valveType) throws Exception {
        try {
            valveTypeDAO.update(valveType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            valveTypeDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ValveType.class)
                            .add(Restrictions.eq(ValveTypeField.CODE, code));
             
            if(valveTypeDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
