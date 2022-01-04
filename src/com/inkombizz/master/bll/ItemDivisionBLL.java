
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemDivisionDAO;
import com.inkombizz.master.model.ItemDivision;
import com.inkombizz.master.model.ItemDivisionField;
import com.inkombizz.master.model.ItemDivisionTemp;


public class ItemDivisionBLL {
    
    public final String MODULECODE = "006_MST_ITEM_DIVISION";
    
    private ItemDivisionDAO itemDivisionDAO;
    
    public ItemDivisionBLL(HBMSession hbmSession){
        this.itemDivisionDAO=new ItemDivisionDAO(hbmSession);
    }
    
    public ListPaging<ItemDivisionTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemDivision.class);           
    
            paging.setRecords(itemDivisionDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemDivisionTemp> listItemDivisionTemp = itemDivisionDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemDivisionTemp> listPaging = new ListPaging<ItemDivisionTemp>();
            
            listPaging.setList(listItemDivisionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemDivisionTemp findData(String code) throws Exception {
        try {
            return (ItemDivisionTemp) itemDivisionDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemDivisionTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemDivisionTemp) itemDivisionDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemDivision itemDivision) throws Exception {
        try {
            itemDivisionDAO.save(itemDivision, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemDivision itemDivision) throws Exception {
        try {
            itemDivisionDAO.update(itemDivision, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemDivisionDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemDivision.class)
                            .add(Restrictions.eq(ItemDivisionField.CODE, code));
             
            if(itemDivisionDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
