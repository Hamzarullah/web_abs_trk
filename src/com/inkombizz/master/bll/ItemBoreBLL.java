
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemBoreDAO;
import com.inkombizz.master.model.ItemBore;
import com.inkombizz.master.model.ItemBoreField;
import com.inkombizz.master.model.ItemBoreTemp;


public class ItemBoreBLL {
    
    public final String MODULECODE = "006_MST_ITEM_BORE";
    
    private ItemBoreDAO itemBoreDAO;
    
    public ItemBoreBLL(HBMSession hbmSession){
        this.itemBoreDAO=new ItemBoreDAO(hbmSession);
    }
    
    public ListPaging<ItemBoreTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBore.class);           
    
            paging.setRecords(itemBoreDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBoreTemp> listItemBoreTemp = itemBoreDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBoreTemp> listPaging = new ListPaging<ItemBoreTemp>();
            
            listPaging.setList(listItemBoreTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemBoreTemp findData(String code) throws Exception {
        try {
            return (ItemBoreTemp) itemBoreDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemBoreTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemBoreTemp) itemBoreDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemBore itemBore) throws Exception {
        try {
            itemBoreDAO.save(itemBore, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemBore itemBore) throws Exception {
        try {
            itemBoreDAO.update(itemBore, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemBoreDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBore.class)
                            .add(Restrictions.eq(ItemBoreField.CODE, code));
             
            if(itemBoreDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
