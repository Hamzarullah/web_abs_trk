
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemStopPinDAO;
import com.inkombizz.master.model.ItemStopPinTemp;
import com.inkombizz.master.model.ItemStopPin;
import com.inkombizz.master.model.ItemStopPinField;


public class ItemStopPinBLL {
    
    public final String MODULECODE = "006_MST_ITEM_STOP_PIN";
    
    private ItemStopPinDAO itemStopPinDAO;
    
    public ItemStopPinBLL(HBMSession hbmSession){
        this.itemStopPinDAO=new ItemStopPinDAO(hbmSession);
    }
    
    public ListPaging<ItemStopPinTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemStopPin.class);           
    
            paging.setRecords(itemStopPinDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemStopPinTemp> listItemStopPinTemp = itemStopPinDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemStopPinTemp> listPaging = new ListPaging<ItemStopPinTemp>();
            
            listPaging.setList(listItemStopPinTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemStopPin> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemStopPin.class)
                    .add(Restrictions.like(ItemStopPinField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemStopPinField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemStopPinField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemStopPinField.ACTIVESTATUS, false));
            
            paging.setRecords(itemStopPinDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemStopPin> listItemStopPin = itemStopPinDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemStopPin> listPaging = new ListPaging<ItemStopPin>();
            
            listPaging.setList(listItemStopPin);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemStopPinTemp findData(String code) throws Exception {
        try {
            return (ItemStopPinTemp) itemStopPinDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemStopPinTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemStopPinTemp) itemStopPinDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemStopPin itemStopPin) throws Exception {
        try {
            itemStopPinDAO.save(itemStopPin, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemStopPin itemStopPin) throws Exception {
        try {
            itemStopPinDAO.update(itemStopPin, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemStopPinDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemStopPin.class)
                            .add(Restrictions.eq(ItemStopPinField.CODE, code));
             
            if(itemStopPinDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
