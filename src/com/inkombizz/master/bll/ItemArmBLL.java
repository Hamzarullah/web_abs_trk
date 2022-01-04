
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemArmDAO;
import com.inkombizz.master.model.ItemArmTemp;
import com.inkombizz.master.model.ItemArm;
import com.inkombizz.master.model.ItemArmField;


public class ItemArmBLL {
    
    public final String MODULECODE = "006_MST_ITEM_ARM";
    
    private ItemArmDAO itemArmDAO;
    
    public ItemArmBLL(HBMSession hbmSession){
        this.itemArmDAO=new ItemArmDAO(hbmSession);
    }
    
    public ListPaging<ItemArmTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemArm.class);           
    
            paging.setRecords(itemArmDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemArmTemp> listItemArmTemp = itemArmDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemArmTemp> listPaging = new ListPaging<ItemArmTemp>();
            
            listPaging.setList(listItemArmTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemArm> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemArm.class)
                    .add(Restrictions.like(ItemArmField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemArmField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemArmField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemArmField.ACTIVESTATUS, false));
            
            paging.setRecords(itemArmDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemArm> listItemArm = itemArmDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemArm> listPaging = new ListPaging<ItemArm>();
            
            listPaging.setList(listItemArm);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemArmTemp findData(String code) throws Exception {
        try {
            return (ItemArmTemp) itemArmDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemArmTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemArmTemp) itemArmDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemArm itemArm) throws Exception {
        try {
            itemArmDAO.save(itemArm, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemArm itemArm) throws Exception {
        try {
            itemArmDAO.update(itemArm, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemArmDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemArm.class)
                            .add(Restrictions.eq(ItemArmField.CODE, code));
             
            if(itemArmDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
