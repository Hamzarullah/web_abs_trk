
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemCategoryDAO;
import com.inkombizz.master.model.ItemCategory;
import com.inkombizz.master.model.ItemCategoryField;
import com.inkombizz.master.model.ItemCategoryTemp;

public class ItemCategoryBLL {
 
    public static final String MODULECODE = "006_MST_ITEM_CATEGORY";
    
    private ItemCategoryDAO itemCategoryDAO;
    
    public ItemCategoryBLL (HBMSession hbmSession) {
        this.itemCategoryDAO = new ItemCategoryDAO(hbmSession);
    }
     
    
    public ListPaging<ItemCategory> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemCategory.class);

            paging.setRecords(itemCategoryDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<ItemCategory> listItemCategory = itemCategoryDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<ItemCategory> listPaging = new ListPaging<ItemCategory>();

            listPaging.setList(listItemCategory);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ItemCategoryTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemCategoryTemp) itemCategoryDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public ListPaging<ItemCategory> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemCategory.class)
                    .add(Restrictions.like(ItemCategoryField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemCategoryField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemCategoryField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemCategoryField.ACTIVESTATUS, false));
            
            paging.setRecords(itemCategoryDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemCategory> listItemCategory = itemCategoryDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCategory> listPaging = new ListPaging<ItemCategory>();
            
            listPaging.setList(listItemCategory);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<ItemCategory> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemCategory.class);
            List<ItemCategory> listItemCategory = itemCategoryDAO.findByCriteria(criteria);
            return listItemCategory;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ItemCategory get(String id) throws Exception {
        try {
            return (ItemCategory) itemCategoryDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(ItemCategory itemCategory) throws Exception {
        try {
            itemCategoryDAO.save(itemCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(ItemCategory itemCategory) throws Exception {
        try {
            itemCategoryDAO.update(itemCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            itemCategoryDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemCategoryTemp getMin() throws Exception {
        try {
            return itemCategoryDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemCategoryTemp getMax() throws Exception {
        try {
            return itemCategoryDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemCategory.class)
                            .add(Restrictions.eq(ItemCategoryField.CODE, code));
             
            if(itemCategoryDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public ItemCategoryDAO getItemCategoryDAO() {
        return itemCategoryDAO;
    }

    public void setItemCategoryDAO(ItemCategoryDAO itemCategoryDAO) {
        this.itemCategoryDAO = itemCategoryDAO;
    }
    
}
