
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.ItemDAO;
import com.inkombizz.master.model.Item;
import com.inkombizz.master.model.ItemField;
import com.inkombizz.master.model.ItemTemp;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class ItemBLL {
    
    public static final String MODULECODE = "006_MST_ITEM";
    
    private ItemDAO itemDAO;
    
    public ItemBLL(HBMSession hbmSession) {
        this.itemDAO = new ItemDAO(hbmSession);
    }
    
    public ListPaging<ItemTemp> findData(String code, String name,String inventoryType,String inventoryCategory,String active, String packageStatus,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Item.class);           
    
            paging.setRecords(itemDAO.countData(code,name,inventoryType,inventoryCategory,active, packageStatus));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemTemp> listItemTemp = itemDAO.findData(code,name,inventoryType,inventoryCategory,packageStatus,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemTemp> listPaging = new ListPaging<ItemTemp>();
            
            listPaging.setList(listItemTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<ItemTemp> findDataSearch(String code, String name,String inventoryType,String inventoryCategory,String active, String packageStatus,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Item.class);           
    
            paging.setRecords(itemDAO.countData(code,name,inventoryType,inventoryCategory,active, packageStatus));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemTemp> listItemTemp = itemDAO.findDataSearch(code,name,inventoryType,inventoryCategory,packageStatus,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemTemp> listPaging = new ListPaging<ItemTemp>();
            
            listPaging.setList(listItemTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemTemp> findData(String code, String name,String warehouseCode,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Item.class);           
    
            paging.setRecords(itemDAO.countData(code,name,warehouseCode));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemTemp> listItemTemp = itemDAO.findData(code,name,warehouseCode,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemTemp> listPaging = new ListPaging<ItemTemp>();
            
            listPaging.setList(listItemTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemTemp findData(String code) throws Exception {
        try {
            return (ItemTemp) itemDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemTemp findData(String code,boolean active,String inventoryType, String inventoryCategory, boolean packageStatus) throws Exception {
        try {
            return (ItemTemp) itemDAO.findData(code,active,inventoryType,inventoryCategory, packageStatus);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemTemp findData(String code,String warehouseCode) throws Exception {
        try {
            return (ItemTemp) itemDAO.findData(code,warehouseCode);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Item item) throws Exception {
        try {
            itemDAO.save(item, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Item item) throws Exception {
        try {
            itemDAO.update(item, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Item.class)
                            .add(Restrictions.eq(ItemField.CODE, code));
             
            if(itemDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }  
    
    public ItemTemp getMin() throws Exception {
        try {
            return itemDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemTemp getMax() throws Exception {
        try {
            return itemDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }

    public ItemDAO getItemDAO() {
        return itemDAO;
    }

    public void setItemDAO(ItemDAO itemDAO) {
        this.itemDAO = itemDAO;
    }
}