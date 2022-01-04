
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemTypeDesignDAO;
import com.inkombizz.master.model.ItemTypeDesign;
import com.inkombizz.master.model.ItemTypeDesignField;
import com.inkombizz.master.model.ItemTypeDesignTemp;


public class ItemTypeDesignBLL {
    
    public final String MODULECODE = "006_MST_ITEM_TYPE_DESIGN";
    
    private ItemTypeDesignDAO itemTypeDesignDAO;
    
    public ItemTypeDesignBLL(HBMSession hbmSession){
        this.itemTypeDesignDAO=new ItemTypeDesignDAO(hbmSession);
    }
    
    public ListPaging<ItemTypeDesignTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemTypeDesign.class);           
    
            paging.setRecords(itemTypeDesignDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemTypeDesignTemp> listItemTypeDesignTemp = itemTypeDesignDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemTypeDesignTemp> listPaging = new ListPaging<ItemTypeDesignTemp>();
            
            listPaging.setList(listItemTypeDesignTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemTypeDesignTemp findData(String code) throws Exception {
        try {
            return (ItemTypeDesignTemp) itemTypeDesignDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemTypeDesignTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemTypeDesignTemp) itemTypeDesignDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemTypeDesign itemTypeDesign) throws Exception {
        try {
            itemTypeDesignDAO.save(itemTypeDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemTypeDesign itemTypeDesign) throws Exception {
        try {
            itemTypeDesignDAO.update(itemTypeDesign, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemTypeDesignDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemTypeDesign.class)
                            .add(Restrictions.eq(ItemTypeDesignField.CODE, code));
             
            if(itemTypeDesignDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
