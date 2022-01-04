
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemSeatDAO;
import com.inkombizz.master.model.ItemSeat;
import com.inkombizz.master.model.ItemSeatField;
import com.inkombizz.master.model.ItemSeatTemp;


public class ItemSeatBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SEAT";
    
    private ItemSeatDAO itemSeatDAO;
    
    public ItemSeatBLL(HBMSession hbmSession){
        this.itemSeatDAO=new ItemSeatDAO(hbmSession);
    }
    
    public ListPaging<ItemSeatTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeat.class);           
    
            paging.setRecords(itemSeatDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSeatTemp> listItemSeatTemp = itemSeatDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSeatTemp> listPaging = new ListPaging<ItemSeatTemp>();
            
            listPaging.setList(listItemSeatTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemSeatTemp findData(String code) throws Exception {
        try {
            return (ItemSeatTemp) itemSeatDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemSeatTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemSeatTemp) itemSeatDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemSeat itemSeat) throws Exception {
        try {
            itemSeatDAO.save(itemSeat, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemSeat itemSeat) throws Exception {
        try {
            itemSeatDAO.update(itemSeat, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemSeatDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSeat.class)
                            .add(Restrictions.eq(ItemSeatField.CODE, code));
             
            if(itemSeatDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
