
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemBrandDAO;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.ItemBrandField;
import com.inkombizz.master.model.ItemBrandTemp;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.master.model.ItemBrandField;


public class ItemBrandBLL {
    
    public final String MODULECODE = "006_MST_ITEM_BRAND";
    
    private ItemBrandDAO itemBrandDAO;
    
    public ItemBrandBLL(HBMSession hbmSession){
        this.itemBrandDAO=new ItemBrandDAO(hbmSession);
    }
    
    public ListPaging<ItemBrandTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBrand.class);           
    
            paging.setRecords(itemBrandDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBrandTemp> listItemBrandTemp = itemBrandDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBrandTemp> listPaging = new ListPaging<ItemBrandTemp>();
            
            listPaging.setList(listItemBrandTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemBrand> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBrand.class)
                    .add(Restrictions.like(ItemBrandField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemBrandField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemBrandField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemBrandField.ACTIVESTATUS, false));
            
            paging.setRecords(itemBrandDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBrand> listItemBrand = itemBrandDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBrand> listPaging = new ListPaging<ItemBrand>();
            
            listPaging.setList(listItemBrand);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemBrandTemp findData(String code) throws Exception {
        try {
            return (ItemBrandTemp) itemBrandDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemBrandTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemBrandTemp) itemBrandDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemBrand itemBrand) throws Exception {
        try {
            itemBrandDAO.save(itemBrand, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemBrand itemBrand) throws Exception {
        try {
            itemBrandDAO.update(itemBrand, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemBrandDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBrand.class)
                            .add(Restrictions.eq(ItemBrandField.CODE, code));
             
            if(itemBrandDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
