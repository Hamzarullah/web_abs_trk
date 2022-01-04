
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemPlatesDAO;
import com.inkombizz.master.model.ItemPlatesTemp;
import com.inkombizz.master.model.ItemPlates;
import com.inkombizz.master.model.ItemPlatesField;


public class ItemPlatesBLL {
    
    public final String MODULECODE = "006_MST_ITEM_PLATES";
    
    private ItemPlatesDAO itemPlatesDAO;
    
    public ItemPlatesBLL(HBMSession hbmSession){
        this.itemPlatesDAO=new ItemPlatesDAO(hbmSession);
    }
    
    public ListPaging<ItemPlatesTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemPlates.class);           
    
            paging.setRecords(itemPlatesDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemPlatesTemp> listItemPlatesTemp = itemPlatesDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemPlatesTemp> listPaging = new ListPaging<ItemPlatesTemp>();
            
            listPaging.setList(listItemPlatesTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemPlates> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemPlates.class)
                    .add(Restrictions.like(ItemPlatesField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemPlatesField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemPlatesField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemPlatesField.ACTIVESTATUS, false));
            
            paging.setRecords(itemPlatesDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemPlates> listItemPlates = itemPlatesDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemPlates> listPaging = new ListPaging<ItemPlates>();
            
            listPaging.setList(listItemPlates);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemPlatesTemp findData(String code) throws Exception {
        try {
            return (ItemPlatesTemp) itemPlatesDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemPlatesTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemPlatesTemp) itemPlatesDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemPlates itemPlates) throws Exception {
        try {
            itemPlatesDAO.save(itemPlates, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemPlates itemPlates) throws Exception {
        try {
            itemPlatesDAO.update(itemPlates, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemPlatesDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemPlates.class)
                            .add(Restrictions.eq(ItemPlatesField.CODE, code));
             
            if(itemPlatesDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
