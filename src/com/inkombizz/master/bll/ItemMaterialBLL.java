
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.ItemMaterialDAO;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.ItemMaterialField;
import com.inkombizz.master.model.ItemMaterialTemp;
import com.inkombizz.master.model.ItemMaterialVendor;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class ItemMaterialBLL {
    
    public static final String MODULECODE = "006_MST_ITEM_MATERIAL";
    
    private ItemMaterialDAO itemMaterialDAO;
    
    public ItemMaterialBLL(HBMSession hbmSession) {
        this.itemMaterialDAO = new ItemMaterialDAO(hbmSession);
    }
    
    public ListPaging<ItemMaterialTemp> findData(String code, String name,String inventoryType,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countData(code,name,inventoryType,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialTemp> listItemMaterialTemp = itemMaterialDAO.findData(code,name,inventoryType,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialTemp> listPaging = new ListPaging<ItemMaterialTemp>();
            
            listPaging.setList(listItemMaterialTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialVendor> findDataMaterialVendor(String code, String vendorCode, Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countDataItemMaterialVendor(code, vendorCode));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialVendor> listItemMaterialVendor = itemMaterialDAO.findDataDetailMaterialVendor(code,vendorCode, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialVendor> listPaging = new ListPaging<ItemMaterialVendor>();
            
            listPaging.setList(listItemMaterialVendor);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialVendor> findDataMaterialJnVendor(String code, String vendorCode, Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countDataItemMaterialVendor(code, vendorCode));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialVendor> listItemMaterialVendor = itemMaterialDAO.findDataDetailMaterialVendor(code,vendorCode, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialVendor> listPaging = new ListPaging<ItemMaterialVendor>();
            
            listPaging.setList(listItemMaterialVendor);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialVendor> findDataDetailExisting(String code) throws Exception {
        try {
            List<ItemMaterialVendor> listItemMaterialVendorDetailExisting = itemMaterialDAO.findDataDetailExisting(code);
            
            ListPaging<ItemMaterialVendor> listPaging = new ListPaging<ItemMaterialVendor>();
            
            listPaging.setList(listItemMaterialVendorDetailExisting);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialTemp> findDataSo(String code, String name,String inventoryType,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countData(code,name,inventoryType,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialTemp> listItemMaterialTemp = itemMaterialDAO.findDataSo(code,name,inventoryType,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialTemp> listPaging = new ListPaging<ItemMaterialTemp>();
            
            listPaging.setList(listItemMaterialTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialTemp> findData(String code, String name,String warehouseCode,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countData(code,name,warehouseCode));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialTemp> listItemMaterialTemp = itemMaterialDAO.findData(code,name,warehouseCode,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialTemp> listPaging = new ListPaging<ItemMaterialTemp>();
            
            listPaging.setList(listItemMaterialTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialTemp> findDataNonSN(String code, String name,String active, String checkSerialNoStatus,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countDataCheckSN(code,name,active,checkSerialNoStatus));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialTemp> listItemTemp = itemMaterialDAO.findDataCheckSN(code,name,active,checkSerialNoStatus, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialTemp> listPaging = new ListPaging<ItemMaterialTemp>();
            
            listPaging.setList(listItemTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialTemp> findDataSN(String code, String name,String active,String checkSerialNoStatus,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countDataCheckSN(code,name,active,checkSerialNoStatus));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialTemp> listItemTemp = itemMaterialDAO.findDataCheckSN(code,name,active,checkSerialNoStatus, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialTemp> listPaging = new ListPaging<ItemMaterialTemp>();
            
            listPaging.setList(listItemTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ItemMaterialTemp findData(String code) throws Exception {
        try {
            return (ItemMaterialTemp) itemMaterialDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemMaterialTemp findData(String code,boolean active,String inventoryType) throws Exception {
        try {
            return (ItemMaterialTemp) itemMaterialDAO.findData(code,active,inventoryType);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemMaterialTemp findData(String code,String warehouseCode) throws Exception {
        try {
            return (ItemMaterialTemp) itemMaterialDAO.findData(code,warehouseCode);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    
    
    public ListPaging<ItemMaterialTemp> search(String code, String name,String active, Paging paging) throws Exception{
        try{
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countDataSearch(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialTemp> listItemMaterialTemp = itemMaterialDAO.search(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialTemp> listPaging=new ListPaging<ItemMaterialTemp>();
            
            listPaging.setList(listItemMaterialTemp);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public ListPaging<ItemMaterialTemp> searchBooked(String code, String name, String warehouseCode, Paging paging) throws Exception{
        try{
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class);           
    
            paging.setRecords(itemMaterialDAO.countDataSearchBooked(code,name,warehouseCode));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ItemMaterialTemp> listItemMaterialTemp = itemMaterialDAO.findDataSearchBooked(code,name,warehouseCode,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialTemp> listPaging=new ListPaging<ItemMaterialTemp>();
            
            listPaging.setList(listItemMaterialTemp);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(ItemMaterial itemMaterial) throws Exception {
        try {
            itemMaterialDAO.save(itemMaterial, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void vendorSave(List<ItemMaterialVendor> listItemMaterialVendorDetail) throws Exception {
        try {
            itemMaterialDAO.vendorSave(listItemMaterialVendorDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ItemMaterial itemMaterial) throws Exception {
        try {
            itemMaterialDAO.update(itemMaterial, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            itemMaterialDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ItemMaterial.class)
                            .add(Restrictions.eq(ItemMaterialField.CODE, code));
             
            if(itemMaterialDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }  
    
    public ItemMaterialTemp getMin() throws Exception {
        try {
            return itemMaterialDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ItemMaterialTemp getMax() throws Exception {
        try {
            return itemMaterialDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }

    public ItemMaterialDAO getItemMaterialDAO() {
        return itemMaterialDAO;
    }

    public void setItemMaterialDAO(ItemMaterialDAO itemMaterialDAO) {
        this.itemMaterialDAO = itemMaterialDAO;
    }

    public static String getMODULECODE() {
        return MODULECODE;
    }
    
}
