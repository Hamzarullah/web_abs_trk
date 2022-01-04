package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.PurchaseDestinationDAO;
import com.inkombizz.master.model.PurchaseDestination;
import com.inkombizz.master.model.PurchaseDestinationField;
import com.inkombizz.master.model.PurchaseDestinationTemp;



public class PurchaseDestinationBLL {
    
    public final String MODULECODE = "006_MST_PURCHASE_DESTINATION";
    
    private PurchaseDestinationDAO purchaseDestinationDAO;
    
    public PurchaseDestinationBLL (HBMSession hbmSession) {
        this.purchaseDestinationDAO = new PurchaseDestinationDAO(hbmSession);
    }
    
    public ListPaging<PurchaseDestinationTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseDestination.class);           
    
            paging.setRecords(purchaseDestinationDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseDestinationTemp> listPurchaseDestinationTemp = purchaseDestinationDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseDestinationTemp> listPaging = new ListPaging<PurchaseDestinationTemp>();
            
            listPaging.setList(listPurchaseDestinationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ListPaging<PurchaseDestinationTemp> findDataPD(String code, String name,String active, String billTo, String shipTo, Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseDestination.class);           
    
            paging.setRecords(purchaseDestinationDAO.countDataPD(code,name,active,billTo,shipTo));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseDestinationTemp> listPurchaseDestinationTemp = purchaseDestinationDAO.findDataPD(code,name,active,billTo,shipTo, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseDestinationTemp> listPaging = new ListPaging<PurchaseDestinationTemp>();
            
            listPaging.setList(listPurchaseDestinationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public PurchaseDestinationTemp findData(String code) throws Exception {
        try {
            return (PurchaseDestinationTemp) purchaseDestinationDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public PurchaseDestinationTemp findData(String code,boolean active) throws Exception {
        try {
            return (PurchaseDestinationTemp) purchaseDestinationDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public PurchaseDestinationTemp findDataBillAndShip(String code, String status, String statusBillShip) throws Exception {
        try {
            return (PurchaseDestinationTemp) purchaseDestinationDAO.findDataBillAndShip(code, status, statusBillShip);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void save(PurchaseDestination purchaseDestination, PurchaseDestinationTemp purchaseDestinationTemp) throws Exception {
        try {
            purchaseDestinationDAO.save(purchaseDestination, purchaseDestinationTemp, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void update(PurchaseDestination purchaseDestination,PurchaseDestinationTemp purchaseDestinationTemp) throws Exception {
        try {
            purchaseDestinationDAO.update(purchaseDestination,purchaseDestinationTemp, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    public void delete(String code) throws Exception {
        try {
            purchaseDestinationDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;

            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseDestination.class)
                            .add(Restrictions.eq(PurchaseDestinationField.CODE, code));

            if(purchaseDestinationDAO.countByCriteria(criteria) > 0)
                 exist = true;

            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
 
    
    public PurchaseDestinationTemp min() throws Exception {
        try {
            return purchaseDestinationDAO.min();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public PurchaseDestinationTemp max() throws Exception {
        try {
            return purchaseDestinationDAO.max();
        }
        catch (Exception e) {
            throw e;
        }
    }
        
}