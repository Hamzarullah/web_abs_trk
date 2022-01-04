
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemBodyConstructionDAO;
import com.inkombizz.master.model.ItemBodyConstructionTemp;
import com.inkombizz.master.model.ItemBodyConstruction;
import com.inkombizz.master.model.ItemBodyConstructionField;


public class ItemBodyConstructionBLL {
    
    public final String MODULECODE = "006_MST_ITEM_BODY_CONSTRUCTION";
    
    private ItemBodyConstructionDAO itemBodyConstructionDAO;
    
    public ItemBodyConstructionBLL(HBMSession hbmSession){
        this.itemBodyConstructionDAO=new ItemBodyConstructionDAO(hbmSession);
    }
    
    public ListPaging<ItemBodyConstructionTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBodyConstruction.class);           
    
            paging.setRecords(itemBodyConstructionDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBodyConstructionTemp> listItemBodyConstructionTemp = itemBodyConstructionDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBodyConstructionTemp> listPaging = new ListPaging<ItemBodyConstructionTemp>();
            
            listPaging.setList(listItemBodyConstructionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemBodyConstruction> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBodyConstruction.class)
                    .add(Restrictions.like(ItemBodyConstructionField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemBodyConstructionField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemBodyConstructionField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemBodyConstructionField.ACTIVESTATUS, false));
            
            paging.setRecords(itemBodyConstructionDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBodyConstruction> listItemBodyConstruction = itemBodyConstructionDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBodyConstruction> listPaging = new ListPaging<ItemBodyConstruction>();
            
            listPaging.setList(listItemBodyConstruction);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemBodyConstructionTemp findData(String code) throws Exception {
        try {
            return (ItemBodyConstructionTemp) itemBodyConstructionDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemBodyConstructionTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemBodyConstructionTemp) itemBodyConstructionDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemBodyConstruction itemBodyConstruction) throws Exception {
        try {
            itemBodyConstructionDAO.save(itemBodyConstruction, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemBodyConstruction itemBodyConstruction) throws Exception {
        try {
            itemBodyConstructionDAO.update(itemBodyConstruction, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemBodyConstructionDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBodyConstruction.class)
                            .add(Restrictions.eq(ItemBodyConstructionField.CODE, code));
             
            if(itemBodyConstructionDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
