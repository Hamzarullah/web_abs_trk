
package com.inkombizz.master.bll;


import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.master.dao.ExpeditionDAO;
import com.inkombizz.master.model.ExpeditionTemp;
import com.inkombizz.master.model.Expedition;
import com.inkombizz.master.model.ExpeditionField;
import org.hibernate.criterion.Restrictions;


public class ExpeditionBLL {
    
    public static final String MODULECODE="006_MST_EXPEDITION";
    
    private ExpeditionDAO expeditionDAO;
    
    public ExpeditionBLL(HBMSession hbmSession){
        this.expeditionDAO=new ExpeditionDAO(hbmSession);
    }
    
    public ListPaging<ExpeditionTemp> findData(Paging paging,String code, String name,String active) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(Expedition.class);
            
            paging.setRecords(expeditionDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ExpeditionTemp> listExpeditionTemp=expeditionDAO.findData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ExpeditionTemp> listPaging=new ListPaging<ExpeditionTemp>();
            
            listPaging.setList(listExpeditionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public ExpeditionTemp findData(String code) throws Exception {
        try {
            return (ExpeditionTemp) expeditionDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ExpeditionTemp findData(String code,boolean active) throws Exception {
        try {
            return (ExpeditionTemp) expeditionDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Expedition expedition) throws Exception {
        try {
            expeditionDAO.save(expedition, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Expedition expedition) throws Exception {
        try {
            expeditionDAO.update(expedition, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            expeditionDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Expedition.class)
                            .add(Restrictions.eq(ExpeditionField.CODE, code));
             
            if(expeditionDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    public ExpeditionTemp getMin() throws Exception {
        try {
            return expeditionDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ExpeditionTemp getMax() throws Exception {
        try {
            return expeditionDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
}
