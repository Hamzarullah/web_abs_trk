
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemProductHeadDAO;
import com.inkombizz.master.model.ItemProductHead;
import com.inkombizz.master.model.ItemProductHeadField;
import com.inkombizz.master.model.ItemProductHeadTemp;

public class ItemProductHeadBLL {
 
    public static final String MODULECODE = "006_MST_ITEM_PRODUCT_CATEGORY";
    
    private ItemProductHeadDAO itemProductHeadDAO;
    
    public ItemProductHeadBLL (HBMSession hbmSession) {
        this.itemProductHeadDAO = new ItemProductHeadDAO(hbmSession);
    }
     
    
    public ListPaging<ItemProductHead> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemProductHead.class);

            paging.setRecords(itemProductHeadDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<ItemProductHead> listItemProductHead = itemProductHeadDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<ItemProductHead> listPaging = new ListPaging<ItemProductHead>();

            listPaging.setList(listItemProductHead);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ItemProductHeadTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemProductHeadTemp) itemProductHeadDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public ListPaging<ItemProductHead> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemProductHead.class)
                    .add(Restrictions.like(ItemProductHeadField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemProductHeadField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemProductHeadField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemProductHeadField.ACTIVESTATUS, false));
            
            paging.setRecords(itemProductHeadDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemProductHead> listItemProductHead = itemProductHeadDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemProductHead> listPaging = new ListPaging<ItemProductHead>();
            
            listPaging.setList(listItemProductHead);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<ItemProductHead> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemProductHead.class);
            List<ItemProductHead> listItemProductHead = itemProductHeadDAO.findByCriteria(criteria);
            return listItemProductHead;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ItemProductHead get(String id) throws Exception {
        try {
            return (ItemProductHead) itemProductHeadDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(ItemProductHead itemProductHead) throws Exception {
        try {
            itemProductHeadDAO.save(itemProductHead, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(ItemProductHead itemProductHead) throws Exception {
        try {
            itemProductHeadDAO.update(itemProductHead, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            itemProductHeadDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemProductHeadTemp getMin() throws Exception {
        try {
            return itemProductHeadDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemProductHeadTemp getMax() throws Exception {
        try {
            return itemProductHeadDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemProductHead.class)
                            .add(Restrictions.eq(ItemProductHeadField.CODE, code));
             
            if(itemProductHeadDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public ItemProductHeadDAO getItemProductHeadDAO() {
        return itemProductHeadDAO;
    }

    public void setItemProductHeadDAO(ItemProductHeadDAO itemProductHeadDAO) {
        this.itemProductHeadDAO = itemProductHeadDAO;
    }
    
}
