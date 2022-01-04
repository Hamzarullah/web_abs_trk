
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemDiscDAO;
import com.inkombizz.master.model.ItemDiscTemp;
import com.inkombizz.master.model.ItemDisc;
import com.inkombizz.master.model.ItemDiscField;


public class ItemDiscBLL {
    
    public final String MODULECODE = "006_MST_ITEM_DISC";
    
    private ItemDiscDAO itemDiscDAO;
    
    public ItemDiscBLL(HBMSession hbmSession){
        this.itemDiscDAO=new ItemDiscDAO(hbmSession);
    }
    
    public ListPaging<ItemDiscTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemDisc.class);           
    
            paging.setRecords(itemDiscDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemDiscTemp> listItemDiscTemp = itemDiscDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemDiscTemp> listPaging = new ListPaging<ItemDiscTemp>();
            
            listPaging.setList(listItemDiscTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemDisc> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemDisc.class)
                    .add(Restrictions.like(ItemDiscField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemDiscField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemDiscField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemDiscField.ACTIVESTATUS, false));
            
            paging.setRecords(itemDiscDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemDisc> listItemDisc = itemDiscDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemDisc> listPaging = new ListPaging<ItemDisc>();
            
            listPaging.setList(listItemDisc);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemDiscTemp findData(String code) throws Exception {
        try {
            return (ItemDiscTemp) itemDiscDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemDiscTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemDiscTemp) itemDiscDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemDisc itemDisc) throws Exception {
        try {
            itemDiscDAO.save(itemDisc, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemDisc itemDisc) throws Exception {
        try {
            itemDiscDAO.update(itemDisc, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemDiscDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemDisc.class)
                            .add(Restrictions.eq(ItemDiscField.CODE, code));
             
            if(itemDiscDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
