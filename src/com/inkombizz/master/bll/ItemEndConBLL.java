
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemEndConDAO;
import com.inkombizz.master.model.ItemEndCon;
import com.inkombizz.master.model.ItemEndConField;
import com.inkombizz.master.model.ItemEndConTemp;


public class ItemEndConBLL {
    
    public final String MODULECODE = "006_MST_ITEM_END_CON";
    
    private ItemEndConDAO itemEndConDAO;
    
    public ItemEndConBLL(HBMSession hbmSession){
        this.itemEndConDAO=new ItemEndConDAO(hbmSession);
    }
    
    public ListPaging<ItemEndConTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemEndCon.class);           
    
            paging.setRecords(itemEndConDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemEndConTemp> listItemEndConTemp = itemEndConDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemEndConTemp> listPaging = new ListPaging<ItemEndConTemp>();
            
            listPaging.setList(listItemEndConTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemEndConTemp findData(String code) throws Exception {
        try {
            return (ItemEndConTemp) itemEndConDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemEndConTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemEndConTemp) itemEndConDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemEndCon itemEndCon) throws Exception {
        try {
            itemEndConDAO.save(itemEndCon, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemEndCon itemEndCon) throws Exception {
        try {
            itemEndConDAO.update(itemEndCon, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemEndConDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemEndCon.class)
                            .add(Restrictions.eq(ItemEndConField.CODE, code));
             
            if(itemEndConDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
