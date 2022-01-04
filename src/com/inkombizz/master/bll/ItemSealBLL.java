
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemSealDAO;
import com.inkombizz.master.model.ItemSeal;
import com.inkombizz.master.model.ItemSealField;
import com.inkombizz.master.model.ItemSealTemp;


public class ItemSealBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SEAL";
    
    private ItemSealDAO itemSealDAO;
    
    public ItemSealBLL(HBMSession hbmSession){
        this.itemSealDAO=new ItemSealDAO(hbmSession);
    }
    
    public ListPaging<ItemSealTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeal.class);           
    
            paging.setRecords(itemSealDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSealTemp> listItemSealTemp = itemSealDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSealTemp> listPaging = new ListPaging<ItemSealTemp>();
            
            listPaging.setList(listItemSealTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemSealTemp findData(String code) throws Exception {
        try {
            return (ItemSealTemp) itemSealDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemSealTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemSealTemp) itemSealDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemSeal itemSeal) throws Exception {
        try {
            itemSealDAO.save(itemSeal, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemSeal itemSeal) throws Exception {
        try {
            itemSealDAO.update(itemSeal, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemSealDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeal.class)
                            .add(Restrictions.eq(ItemSealField.CODE, code));
             
            if(itemSealDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
