
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemRatingDAO;
import com.inkombizz.master.model.ItemRating;
import com.inkombizz.master.model.ItemRatingField;
import com.inkombizz.master.model.ItemRatingTemp;


public class ItemRatingBLL {
    
    public final String MODULECODE = "006_MST_ITEM_RATING";
    
    private ItemRatingDAO itemRatingDAO;
    
    public ItemRatingBLL(HBMSession hbmSession){
        this.itemRatingDAO=new ItemRatingDAO(hbmSession);
    }
    
    public ListPaging<ItemRatingTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemRating.class);           
    
            paging.setRecords(itemRatingDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemRatingTemp> listItemRatingTemp = itemRatingDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemRatingTemp> listPaging = new ListPaging<ItemRatingTemp>();
            
            listPaging.setList(listItemRatingTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemRatingTemp findData(String code) throws Exception {
        try {
            return (ItemRatingTemp) itemRatingDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemRatingTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemRatingTemp) itemRatingDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemRating itemRating) throws Exception {
        try {
            itemRatingDAO.save(itemRating, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemRating itemRating) throws Exception {
        try {
            itemRatingDAO.update(itemRating, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemRatingDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemRating.class)
                            .add(Restrictions.eq(ItemRatingField.CODE, code));
             
            if(itemRatingDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
