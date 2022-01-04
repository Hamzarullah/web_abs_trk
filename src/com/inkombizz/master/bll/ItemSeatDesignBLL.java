
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemSeatDesignDAO;
import com.inkombizz.master.model.ItemSeatDesign;
import com.inkombizz.master.model.ItemSeatDesignField;
import com.inkombizz.master.model.ItemSeatDesignTemp;


public class ItemSeatDesignBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SEAT_DESIGN";
    
    private ItemSeatDesignDAO itemSeatDesignDAO;
    
    public ItemSeatDesignBLL(HBMSession hbmSession){
        this.itemSeatDesignDAO=new ItemSeatDesignDAO(hbmSession);
    }
    
    public ListPaging<ItemSeatDesignTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeatDesign.class);           
    
            paging.setRecords(itemSeatDesignDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSeatDesignTemp> listItemSeatDesignTemp = itemSeatDesignDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSeatDesignTemp> listPaging = new ListPaging<ItemSeatDesignTemp>();
            
            listPaging.setList(listItemSeatDesignTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemSeatDesignTemp findData(String code) throws Exception {
        try {
            return (ItemSeatDesignTemp) itemSeatDesignDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemSeatDesignTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemSeatDesignTemp) itemSeatDesignDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemSeatDesign itemSeatDesign) throws Exception {
        try {
            itemSeatDesignDAO.save(itemSeatDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemSeatDesign itemSeatDesign) throws Exception {
        try {
            itemSeatDesignDAO.update(itemSeatDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemSeatDesignDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeatDesign.class)
                            .add(Restrictions.eq(ItemSeatDesignField.CODE, code));
             
            if(itemSeatDesignDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
