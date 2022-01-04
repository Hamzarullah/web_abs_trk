
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemBoltDAO;
import com.inkombizz.master.model.ItemBolt;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.master.model.ItemBoltTemp;


public class ItemBoltBLL {
    
    public final String MODULECODE = "006_MST_ITEM_BOLT";
    
    private ItemBoltDAO itemBoltDAO;
    
    public ItemBoltBLL(HBMSession hbmSession){
        this.itemBoltDAO=new ItemBoltDAO(hbmSession);
    }
    
    public ListPaging<ItemBoltTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBolt.class);           
    
            paging.setRecords(itemBoltDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBoltTemp> listItemBoltTemp = itemBoltDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBoltTemp> listPaging = new ListPaging<ItemBoltTemp>();
            
            listPaging.setList(listItemBoltTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemBoltTemp findData(String code) throws Exception {
        try {
            return (ItemBoltTemp) itemBoltDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemBoltTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemBoltTemp) itemBoltDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemBolt itemBolt) throws Exception {
        try {
            itemBoltDAO.save(itemBolt, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemBolt itemBolt) throws Exception {
        try {
            itemBoltDAO.update(itemBolt, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemBoltDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBolt.class)
                            .add(Restrictions.eq(ItemBoltField.CODE, code));
             
            if(itemBoltDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
