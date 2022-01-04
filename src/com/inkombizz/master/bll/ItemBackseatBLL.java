
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemBackseatDAO;
import com.inkombizz.master.model.ItemBackseatTemp;
import com.inkombizz.master.model.ItemBackseat;
import com.inkombizz.master.model.ItemBackseatField;


public class ItemBackseatBLL {
    
    public final String MODULECODE = "006_MST_ITEM_BACKSEAT";
    
    private ItemBackseatDAO itemBackseatDAO;
    
    public ItemBackseatBLL(HBMSession hbmSession){
        this.itemBackseatDAO=new ItemBackseatDAO(hbmSession);
    }
    
    public ListPaging<ItemBackseatTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBackseat.class);           
    
            paging.setRecords(itemBackseatDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBackseatTemp> listItemBackseatTemp = itemBackseatDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBackseatTemp> listPaging = new ListPaging<ItemBackseatTemp>();
            
            listPaging.setList(listItemBackseatTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemBackseat> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBackseat.class)
                    .add(Restrictions.like(ItemBackseatField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemBackseatField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemBackseatField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemBackseatField.ACTIVESTATUS, false));
            
            paging.setRecords(itemBackseatDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBackseat> listItemBackseat = itemBackseatDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBackseat> listPaging = new ListPaging<ItemBackseat>();
            
            listPaging.setList(listItemBackseat);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemBackseatTemp findData(String code) throws Exception {
        try {
            return (ItemBackseatTemp) itemBackseatDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemBackseatTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemBackseatTemp) itemBackseatDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemBackseat itemBackseat) throws Exception {
        try {
            itemBackseatDAO.save(itemBackseat, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemBackseat itemBackseat) throws Exception {
        try {
            itemBackseatDAO.update(itemBackseat, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemBackseatDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBackseat.class)
                            .add(Restrictions.eq(ItemBackseatField.CODE, code));
             
            if(itemBackseatDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
