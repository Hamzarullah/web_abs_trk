
package com.inkombizz.purchasing.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.dao.PurchaseRequestNonItemMaterialRequestDAO;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequestDetail;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequestField;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class PurchaseRequestNonItemMaterialRequestBLL {
    public static final String MODULECODE = "001_PUR_PURCHASE_REQUEST_NON_IMR";
    public static final String MODULECODE_APPROVAL = "001_PUR_PURCHASE_REQUEST_NON_IMR_APPROVAL";
    public static final String MODULECODE_CLOSING = "001_PUR_PURCHASE_REQUEST_NON_IMR_CLOSING";
    
    private PurchaseRequestNonItemMaterialRequestDAO purchaseRequestNonItemMaterialRequestDAO;
    
    public PurchaseRequestNonItemMaterialRequestBLL (HBMSession hbmSession) {
        this.purchaseRequestNonItemMaterialRequestDAO = new PurchaseRequestNonItemMaterialRequestDAO(hbmSession);
    }
    
   // Look Up Purchase Request
    public ListPaging<PurchaseRequestNonItemMaterialRequest> findDataLookUp(String code, Date fromDate,Date upToDate,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestNonItemMaterialRequest.class);           
    
            paging.setRecords(purchaseRequestNonItemMaterialRequestDAO.countDataLookUp(code, fromDate, upToDate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequest = purchaseRequestNonItemMaterialRequestDAO.findDataLookUp(code, fromDate, upToDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseRequestNonItemMaterialRequest> listPaging = new ListPaging<PurchaseRequestNonItemMaterialRequest>();
            
            listPaging.setList(listPurchaseRequestNonItemMaterialRequest);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
   //    Purchase Request Non Item Material Request 
    public ListPaging<PurchaseRequestNonItemMaterialRequest> findData(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestNonItemMaterialRequest.class);           
    
            paging.setRecords(purchaseRequestNonItemMaterialRequestDAO.countData(purchaseRequestNonItemMaterialRequest));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequest = purchaseRequestNonItemMaterialRequestDAO.findData(purchaseRequestNonItemMaterialRequest, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseRequestNonItemMaterialRequest> listPaging = new ListPaging<PurchaseRequestNonItemMaterialRequest>();
            
            listPaging.setList(listPurchaseRequestNonItemMaterialRequest);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    //NO PRQ IMR
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataDetailPRQNo(ArrayList arrPurchaseOrderPRQNo, String purchaseRequestNonStatus) throws Exception {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail = purchaseRequestNonItemMaterialRequestDAO.findDataDetailPRQNo(arrPurchaseOrderPRQNo, purchaseRequestNonStatus);
            
            return listPurchaseRequestNonItemMaterialRequestDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    //Sub Item
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataDetailSubItem(ArrayList arrPurchaseOrderNo) throws Exception {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail = purchaseRequestNonItemMaterialRequestDAO.findDataDetailSubItem(arrPurchaseOrderNo);
            
            return listPurchaseRequestNonItemMaterialRequestDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataSubItem(String code) throws Exception {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail = purchaseRequestNonItemMaterialRequestDAO.findDataSubItem(code);
            
            return listPurchaseRequestNonItemMaterialRequestDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestNonItemMaterialRequest.class)
                            .add(Restrictions.eq(PurchaseRequestNonItemMaterialRequestField.CODE, code));
             
            if(purchaseRequestNonItemMaterialRequestDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public ListPaging<PurchaseRequestNonItemMaterialRequest> findDataApproval(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestNonItemMaterialRequest.class);           
    
            paging.setRecords(purchaseRequestNonItemMaterialRequestDAO.countDataApproval(purchaseRequestNonItemMaterialRequestApproval));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequest = purchaseRequestNonItemMaterialRequestDAO.findDataApproval(purchaseRequestNonItemMaterialRequestApproval, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseRequestNonItemMaterialRequest> listPaging = new ListPaging<PurchaseRequestNonItemMaterialRequest>();
            
            listPaging.setList(listPurchaseRequestNonItemMaterialRequest);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataDetail(String code) throws Exception {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail = purchaseRequestNonItemMaterialRequestDAO.findDataDetail(code);
            
            return listPurchaseRequestNonItemMaterialRequestDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PurchaseRequestNonItemMaterialRequest> findDataClosing(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosing,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestNonItemMaterialRequest.class);           
    
            paging.setRecords(purchaseRequestNonItemMaterialRequestDAO.countDataClosing(purchaseRequestNonItemMaterialRequestClosing));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseRequestNonItemMaterialRequest> listPurchaseRequestNonItemMaterialRequest = purchaseRequestNonItemMaterialRequestDAO.findDataClosing(purchaseRequestNonItemMaterialRequestClosing, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseRequestNonItemMaterialRequest> listPaging = new ListPaging<PurchaseRequestNonItemMaterialRequest>();
            
            listPaging.setList(listPurchaseRequestNonItemMaterialRequest);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest,List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequest) throws Exception {
        try {
            purchaseRequestNonItemMaterialRequestDAO.save(purchaseRequestNonItemMaterialRequest,listPurchaseRequestNonItemMaterialRequest, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest,List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequest) throws Exception {
        try {
            purchaseRequestNonItemMaterialRequestDAO.update(purchaseRequestNonItemMaterialRequest,listPurchaseRequestNonItemMaterialRequest, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void approval(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval,List<PurchaseRequestNonItemMaterialRequestDetail> listpurchaseRequestNonItemMaterialRequestApproval) throws Exception {
        try {
            purchaseRequestNonItemMaterialRequestDAO.approval(purchaseRequestNonItemMaterialRequestApproval,listpurchaseRequestNonItemMaterialRequestApproval,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void closing(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosing) throws Exception {
        try {
            purchaseRequestNonItemMaterialRequestDAO.closing(purchaseRequestNonItemMaterialRequestClosing,MODULECODE_CLOSING);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            purchaseRequestNonItemMaterialRequestDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
}
