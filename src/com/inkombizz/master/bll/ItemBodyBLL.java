
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemBodyDAO;
import com.inkombizz.master.model.ItemBody;
import com.inkombizz.master.model.ItemBodyField;
import com.inkombizz.master.model.ItemBodyTemp;


public class ItemBodyBLL {
    
    public final String MODULECODE = "006_MST_ITEM_BODY";
    
    private ItemBodyDAO itemBodyDAO;
    
    public ItemBodyBLL(HBMSession hbmSession){
        this.itemBodyDAO=new ItemBodyDAO(hbmSession);
    }
    
    public ListPaging<ItemBodyTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBody.class);           
    
            paging.setRecords(itemBodyDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBodyTemp> listItemBodyTemp = itemBodyDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBodyTemp> listPaging = new ListPaging<ItemBodyTemp>();
            
            listPaging.setList(listItemBodyTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemBodyTemp findData(String code) throws Exception {
        try {
            return (ItemBodyTemp) itemBodyDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemBodyTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemBodyTemp) itemBodyDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemBody itemBody) throws Exception {
        try {
            itemBodyDAO.save(itemBody, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemBody itemBody) throws Exception {
        try {
            itemBodyDAO.update(itemBody, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemBodyDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBody.class)
                            .add(Restrictions.eq(ItemBodyField.CODE, code));
             
            if(itemBodyDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
