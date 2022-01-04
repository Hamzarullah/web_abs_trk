
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemSubCategoryDAO;
import com.inkombizz.master.model.ItemSubCategory;
import com.inkombizz.master.model.ItemSubCategoryField;
import com.inkombizz.master.model.ItemSubCategoryTemp;


public class ItemSubCategoryBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SUB_CATEGORY";
    
    private ItemSubCategoryDAO itemSubCategoryDAO;
    
    public ItemSubCategoryBLL(HBMSession hbmSession){
        this.itemSubCategoryDAO=new ItemSubCategoryDAO(hbmSession);
    }
    
    public ListPaging<ItemSubCategoryTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSubCategory.class);           
    
            paging.setRecords(itemSubCategoryDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSubCategoryTemp> listItemSubCategoryTemp = itemSubCategoryDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSubCategoryTemp> listPaging = new ListPaging<ItemSubCategoryTemp>();
            
            listPaging.setList(listItemSubCategoryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemSubCategoryTemp findData(String code) throws Exception {
        try {
            return (ItemSubCategoryTemp) itemSubCategoryDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemSubCategoryTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemSubCategoryTemp) itemSubCategoryDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemSubCategory itemSubCategory) throws Exception {
        try {
            itemSubCategoryDAO.save(itemSubCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemSubCategory itemSubCategory) throws Exception {
        try {
            itemSubCategoryDAO.update(itemSubCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemSubCategoryDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSubCategory.class)
                            .add(Restrictions.eq(ItemSubCategoryField.CODE, code));
             
            if(itemSubCategoryDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
