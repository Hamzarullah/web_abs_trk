
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemHingePinDAO;
import com.inkombizz.master.model.ItemHingePinTemp;
import com.inkombizz.master.model.ItemHingePin;
import com.inkombizz.master.model.ItemHingePinField;


public class ItemHingePinBLL {
    
    public final String MODULECODE = "006_MST_ITEM_HINGE_PIN";
    
    private ItemHingePinDAO itemHingePinDAO;
    
    public ItemHingePinBLL(HBMSession hbmSession){
        this.itemHingePinDAO=new ItemHingePinDAO(hbmSession);
    }
    
    public ListPaging<ItemHingePinTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemHingePin.class);           
    
            paging.setRecords(itemHingePinDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemHingePinTemp> listItemHingePinTemp = itemHingePinDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemHingePinTemp> listPaging = new ListPaging<ItemHingePinTemp>();
            
            listPaging.setList(listItemHingePinTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemHingePin> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemHingePin.class)
                    .add(Restrictions.like(ItemHingePinField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemHingePinField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemHingePinField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemHingePinField.ACTIVESTATUS, false));
            
            paging.setRecords(itemHingePinDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemHingePin> listItemHingePin = itemHingePinDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemHingePin> listPaging = new ListPaging<ItemHingePin>();
            
            listPaging.setList(listItemHingePin);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemHingePinTemp findData(String code) throws Exception {
        try {
            return (ItemHingePinTemp) itemHingePinDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemHingePinTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemHingePinTemp) itemHingePinDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemHingePin itemHingePin) throws Exception {
        try {
            itemHingePinDAO.save(itemHingePin, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemHingePin itemHingePin) throws Exception {
        try {
            itemHingePinDAO.update(itemHingePin, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemHingePinDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemHingePin.class)
                            .add(Restrictions.eq(ItemHingePinField.CODE, code));
             
            if(itemHingePinDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
