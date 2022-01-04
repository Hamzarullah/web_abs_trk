
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemStemDAO;
import com.inkombizz.master.model.ItemStem;
import com.inkombizz.master.model.ItemStemField;
import com.inkombizz.master.model.ItemStemTemp;


public class ItemStemBLL {
    
    public final String MODULECODE = "006_MST_ITEM_STEM";
    
    private ItemStemDAO itemStemDAO;
    
    public ItemStemBLL(HBMSession hbmSession){
        this.itemStemDAO=new ItemStemDAO(hbmSession);
    }
    
    public ListPaging<ItemStemTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemStem.class);           
    
            paging.setRecords(itemStemDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemStemTemp> listItemStemTemp = itemStemDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemStemTemp> listPaging = new ListPaging<ItemStemTemp>();
            
            listPaging.setList(listItemStemTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemStemTemp findData(String code) throws Exception {
        try {
            return (ItemStemTemp) itemStemDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemStemTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemStemTemp) itemStemDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemStem itemStem) throws Exception {
        try {
            itemStemDAO.save(itemStem, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemStem itemStem) throws Exception {
        try {
            itemStemDAO.update(itemStem, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemStemDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemStem.class)
                            .add(Restrictions.eq(ItemStemField.CODE, code));
             
            if(itemStemDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
