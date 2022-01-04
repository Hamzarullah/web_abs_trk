/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.ItemFinishGoodsDAO;
import com.inkombizz.master.model.ItemFinishGoods;
import com.inkombizz.master.model.ItemFinishGoodsField;
import com.inkombizz.master.model.ItemFinishGoodsTemp;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author ikb
 */
public class ItemFinishGoodsBLL {
    
     public static final String MODULECODE = "006_MST_ITEM_FINISH_GOODS";
    
    private ItemFinishGoodsDAO itemFinishGoodsDAO;
    
    public ItemFinishGoodsBLL(HBMSession hbmSession) {
        this.itemFinishGoodsDAO = new ItemFinishGoodsDAO(hbmSession);
    }
    public ListPaging<ItemFinishGoodsTemp> findData(Paging paging,String code, String name,String active) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemFinishGoods.class);           
    
            paging.setRecords(itemFinishGoodsDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemFinishGoodsTemp> listItemFinishGoodsTemp = itemFinishGoodsDAO.findData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemFinishGoodsTemp> listPaging = new ListPaging<ItemFinishGoodsTemp>();
            
            listPaging.setList(listItemFinishGoodsTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }      
    
        
    public ItemFinishGoodsTemp findData(String code) throws Exception {
        try {
            return (ItemFinishGoodsTemp) itemFinishGoodsDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ListPaging<ItemFinishGoodsTemp> findDataSearch(Paging paging,String code, String customerCode,String active) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(ItemFinishGoods.class);
            
            paging.setRecords(itemFinishGoodsDAO.countDataSearch(code,customerCode,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ItemFinishGoodsTemp> listItemFinishGoodsTemp=itemFinishGoodsDAO.findDataSearch(code,customerCode, active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemFinishGoodsTemp> listPaging=new ListPaging<ItemFinishGoodsTemp>();
            
            listPaging.setList(listItemFinishGoodsTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(ItemFinishGoods itemFinishGoods) throws Exception {
        try {
            itemFinishGoodsDAO.save(itemFinishGoods, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemFinishGoods itemFinishGoods) throws Exception {
        try {
            itemFinishGoodsDAO.update(itemFinishGoods, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemFinishGoodsDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
      
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemFinishGoods.class)
                            .add(Restrictions.eq(ItemFinishGoodsField.CODE, code));
             
            if(itemFinishGoodsDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
