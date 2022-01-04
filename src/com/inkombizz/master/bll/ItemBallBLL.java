
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ItemBallDAO;
import com.inkombizz.master.model.ItemBallTemp;
import com.inkombizz.master.model.ItemBall;
import com.inkombizz.master.model.ItemBallField;


public class ItemBallBLL {
    
    public final String MODULECODE = "006_MST_ITEM_BALL";
    
    private ItemBallDAO itemBallDAO;
    
    public ItemBallBLL(HBMSession hbmSession){
        this.itemBallDAO=new ItemBallDAO(hbmSession);
    }
    
    public ListPaging<ItemBallTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBall.class);           
    
            paging.setRecords(itemBallDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBallTemp> listItemBallTemp = itemBallDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBallTemp> listPaging = new ListPaging<ItemBallTemp>();
            
            listPaging.setList(listItemBallTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemBall> search(Paging paging, String code, String name, EnumTriState.Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBall.class)
                    .add(Restrictions.like(ItemBallField.CODE, code + "%" ))
                    .add(Restrictions.like(ItemBallField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(ItemBallField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(ItemBallField.ACTIVESTATUS, false));
            
            paging.setRecords(itemBallDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemBall> listItemBall = itemBallDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemBall> listPaging = new ListPaging<ItemBall>();
            
            listPaging.setList(listItemBall);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ItemBallTemp findData(String code) throws Exception {
        try {
            return (ItemBallTemp) itemBallDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemBallTemp findData(String code,boolean active) throws Exception {
        try {
            return (ItemBallTemp) itemBallDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ItemBall itemBall) throws Exception {
        try {
            itemBallDAO.save(itemBall, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemBall itemBall) throws Exception {
        try {
            itemBallDAO.update(itemBall, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemBallDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemBall.class)
                            .add(Restrictions.eq(ItemBallField.CODE, code));
             
            if(itemBallDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
