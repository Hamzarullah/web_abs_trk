
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemSeatInsertDAO;
import com.inkombizz.master.model.ItemSeatInsert;
import com.inkombizz.master.model.ItemSeatInsertField;
import com.inkombizz.master.model.ItemSeatInsertTemp;


public class ItemSeatInsertBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SEAT_INSERT";
    
    private ItemSeatInsertDAO itemSeatInsertDAO;
    
    public ItemSeatInsertBLL(HBMSession hbmSession){
        this.itemSeatInsertDAO=new ItemSeatInsertDAO(hbmSession);
    }
    
    public ListPaging<ItemSeatInsertTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeatInsert.class);           
    
            paging.setRecords(itemSeatInsertDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSeatInsertTemp> listItemSeatInsertTemp = itemSeatInsertDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSeatInsertTemp> listPaging = new ListPaging<ItemSeatInsertTemp>();
            
            listPaging.setList(listItemSeatInsertTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemSeatInsertTemp findData(String code) throws Exception {
        try {
            return (ItemSeatInsertTemp) itemSeatInsertDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemSeatInsertTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemSeatInsertTemp) itemSeatInsertDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemSeatInsert itemSeatInsert) throws Exception {
        try {
            itemSeatInsertDAO.save(itemSeatInsert, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemSeatInsert itemSeatInsert) throws Exception {
        try {
            itemSeatInsertDAO.update(itemSeatInsert, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemSeatInsertDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeatInsert.class)
                            .add(Restrictions.eq(ItemSeatInsertField.CODE, code));
             
            if(itemSeatInsertDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
