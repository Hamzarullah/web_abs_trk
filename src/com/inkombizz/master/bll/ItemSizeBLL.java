
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemSizeDAO;
import com.inkombizz.master.model.ItemSize;
import com.inkombizz.master.model.ItemSizeField;
import com.inkombizz.master.model.ItemSizeTemp;


public class ItemSizeBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SIZE";
    
    private ItemSizeDAO itemSizeDAO;
    
    public ItemSizeBLL(HBMSession hbmSession){
        this.itemSizeDAO=new ItemSizeDAO(hbmSession);
    }
    
    public ListPaging<ItemSizeTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSize.class);           
    
            paging.setRecords(itemSizeDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSizeTemp> listItemSizeTemp = itemSizeDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSizeTemp> listPaging = new ListPaging<ItemSizeTemp>();
            
            listPaging.setList(listItemSizeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemSizeTemp findData(String code) throws Exception {
        try {
            return (ItemSizeTemp) itemSizeDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemSizeTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemSizeTemp) itemSizeDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemSize itemSize) throws Exception {
        try {
            itemSizeDAO.save(itemSize, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemSize itemSize) throws Exception {
        try {
            itemSizeDAO.update(itemSize, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemSizeDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSize.class)
                            .add(Restrictions.eq(ItemSizeField.CODE, code));
             
            if(itemSizeDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
