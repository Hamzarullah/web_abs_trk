
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemShaftDAO;
import com.inkombizz.master.model.ItemShaftTemp;
import com.inkombizz.master.model.ItemShaft;
import com.inkombizz.master.model.ItemShaftField;


public class ItemShaftBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SHAFT";
    
    private ItemShaftDAO itemShaftDAO;
    
    public ItemShaftBLL(HBMSession hbmSession){
        this.itemShaftDAO=new ItemShaftDAO(hbmSession);
    }
    
    public ListPaging<ItemShaftTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemShaft.class);           
    
            paging.setRecords(itemShaftDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemShaftTemp> listItemShaftTemp = itemShaftDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemShaftTemp> listPaging = new ListPaging<ItemShaftTemp>();
            
            listPaging.setList(listItemShaftTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemShaft> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemShaft.class)
                    .add(Restrictions.like(ItemShaftField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemShaftField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemShaftField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemShaftField.ACTIVESTATUS, false));
            
            paging.setRecords(itemShaftDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemShaft> listItemShaft = itemShaftDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemShaft> listPaging = new ListPaging<ItemShaft>();
            
            listPaging.setList(listItemShaft);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemShaftTemp findData(String code) throws Exception {
        try {
            return (ItemShaftTemp) itemShaftDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemShaftTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemShaftTemp) itemShaftDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemShaft itemShaft) throws Exception {
        try {
            itemShaftDAO.save(itemShaft, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemShaft itemShaft) throws Exception {
        try {
            itemShaftDAO.update(itemShaft, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemShaftDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemShaft.class)
                            .add(Restrictions.eq(ItemShaftField.CODE, code));
             
            if(itemShaftDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
