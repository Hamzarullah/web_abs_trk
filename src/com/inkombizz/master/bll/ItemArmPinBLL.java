
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemArmPinDAO;
import com.inkombizz.master.model.ItemArmPinTemp;
import com.inkombizz.master.model.ItemArmPin;
import com.inkombizz.master.model.ItemArmPinField;


public class ItemArmPinBLL {
    
    public final String MODULECODE = "006_MST_ITEM_ARM_PIN";
    
    private ItemArmPinDAO itemArmPinDAO;
    
    public ItemArmPinBLL(HBMSession hbmSession){
        this.itemArmPinDAO=new ItemArmPinDAO(hbmSession);
    }
    
    public ListPaging<ItemArmPinTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemArmPin.class);           
    
            paging.setRecords(itemArmPinDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemArmPinTemp> listItemArmPinTemp = itemArmPinDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemArmPinTemp> listPaging = new ListPaging<ItemArmPinTemp>();
            
            listPaging.setList(listItemArmPinTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemArmPin> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemArmPin.class)
                    .add(Restrictions.like(ItemArmPinField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemArmPinField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemArmPinField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemArmPinField.ACTIVESTATUS, false));
            
            paging.setRecords(itemArmPinDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemArmPin> listItemArmPin = itemArmPinDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemArmPin> listPaging = new ListPaging<ItemArmPin>();
            
            listPaging.setList(listItemArmPin);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemArmPinTemp findData(String code) throws Exception {
        try {
            return (ItemArmPinTemp) itemArmPinDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemArmPinTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemArmPinTemp) itemArmPinDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemArmPin itemArmPin) throws Exception {
        try {
            itemArmPinDAO.save(itemArmPin, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemArmPin itemArmPin) throws Exception {
        try {
            itemArmPinDAO.update(itemArmPin, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemArmPinDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemArmPin.class)
                            .add(Restrictions.eq(ItemArmPinField.CODE, code));
             
            if(itemArmPinDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
