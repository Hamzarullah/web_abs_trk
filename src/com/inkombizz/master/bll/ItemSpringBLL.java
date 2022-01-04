
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemSpringDAO;
import com.inkombizz.master.model.ItemSpringTemp;
import com.inkombizz.master.model.ItemSpring;
import com.inkombizz.master.model.ItemSpringField;


public class ItemSpringBLL {
    
    public final String MODULECODE = "006_MST_ITEM_SPRING";
    
    private ItemSpringDAO itemSpringDAO;
    
    public ItemSpringBLL(HBMSession hbmSession){
        this.itemSpringDAO=new ItemSpringDAO(hbmSession);
    }
    
    public ListPaging<ItemSpringTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSpring.class);           
    
            paging.setRecords(itemSpringDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSpringTemp> listItemSpringTemp = itemSpringDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSpringTemp> listPaging = new ListPaging<ItemSpringTemp>();
            
            listPaging.setList(listItemSpringTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemSpring> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSpring.class)
                    .add(Restrictions.like(ItemSpringField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemSpringField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemSpringField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemSpringField.ACTIVESTATUS, false));
            
            paging.setRecords(itemSpringDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemSpring> listItemSpring = itemSpringDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemSpring> listPaging = new ListPaging<ItemSpring>();
            
            listPaging.setList(listItemSpring);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemSpringTemp findData(String code) throws Exception {
        try {
            return (ItemSpringTemp) itemSpringDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemSpringTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemSpringTemp) itemSpringDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemSpring itemSpring) throws Exception {
        try {
            itemSpringDAO.save(itemSpring, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemSpring itemSpring) throws Exception {
        try {
            itemSpringDAO.update(itemSpring, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemSpringDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemSpring.class)
                            .add(Restrictions.eq(ItemSpringField.CODE, code));
             
            if(itemSpringDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
