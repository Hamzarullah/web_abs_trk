
package com.inkombizz.purchasing.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.purchasing.dao.PurchaseRequestBySalesOrderDAO;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrderDetail;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrderField;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class PurchaseRequestBySalesOrderBLL {
    public static final String MODULECODE = "001_PUR_PURCHASE_REQUEST";
    public static final String MODULECODE_APPROVAL = "001_PUR_PURCHASE_REQUEST_APPROVAL";
    public static final String MODULECODE_CLOSING = "001_PUR_PURCHASE_REQUEST_CLOSING";
    
    private PurchaseRequestBySalesOrderDAO purchaseRequestDAO;
    
    public PurchaseRequestBySalesOrderBLL (HBMSession hbmSession) {
        this.purchaseRequestDAO = new PurchaseRequestBySalesOrderDAO(hbmSession);
    }
    
    public ListPaging<PurchaseRequestBySalesOrder> findData(PurchaseRequestBySalesOrder purchaseRequest,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestBySalesOrder.class);           
    
            paging.setRecords(purchaseRequestDAO.countData(purchaseRequest));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseRequestBySalesOrder> listPurchaseRequest = purchaseRequestDAO.findData(purchaseRequest, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseRequestBySalesOrder> listPaging = new ListPaging<PurchaseRequestBySalesOrder>();
            
            listPaging.setList(listPurchaseRequest);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestBySalesOrder.class)
                            .add(Restrictions.eq(PurchaseRequestBySalesOrderField.CODE, code));
             
            if(purchaseRequestDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public ListPaging<PurchaseRequestBySalesOrder> findDataApproval(PurchaseRequestBySalesOrder purchaseRequestApproval,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestBySalesOrder.class);           
    
            paging.setRecords(purchaseRequestDAO.countData(purchaseRequestApproval));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseRequestBySalesOrder> listPurchaseRequestApproval = purchaseRequestDAO.findDataApproval(purchaseRequestApproval, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseRequestBySalesOrder> listPaging = new ListPaging<PurchaseRequestBySalesOrder>();
            
            listPaging.setList(listPurchaseRequestApproval);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PurchaseRequestBySalesOrderDetail> findDataDetail(String code) throws Exception {
        try {
            
            List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestDetail = purchaseRequestDAO.findDataDetail(code);
            
            return listPurchaseRequestDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PurchaseRequestBySalesOrder> findDataClosing(PurchaseRequestBySalesOrder purchaseRequestClosing,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PurchaseRequestBySalesOrder.class);           
    
            paging.setRecords(purchaseRequestDAO.countData(purchaseRequestClosing));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PurchaseRequestBySalesOrder> listPurchaseRequestTemp = purchaseRequestDAO.findDataClosing(purchaseRequestClosing, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PurchaseRequestBySalesOrder> listPaging = new ListPaging<PurchaseRequestBySalesOrder>();
            
            listPaging.setList(listPurchaseRequestTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(PurchaseRequestBySalesOrder purchaseRequest,List<PurchaseRequestBySalesOrderDetail> listPurchaseRequest) throws Exception {
        try {
            purchaseRequestDAO.save(purchaseRequest,listPurchaseRequest, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(PurchaseRequestBySalesOrder purchaseRequest,List<PurchaseRequestBySalesOrderDetail> listPurchaseRequest) throws Exception {
        try {
            purchaseRequestDAO.update(purchaseRequest,listPurchaseRequest, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void approval(PurchaseRequestBySalesOrder purchaseRequestApproval) throws Exception {
        try {
            purchaseRequestDAO.approval(purchaseRequestApproval,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void closing(PurchaseRequestBySalesOrder purchaseRequestClosing) throws Exception {
        try {
            purchaseRequestDAO.closing(purchaseRequestClosing,MODULECODE_CLOSING);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            purchaseRequestDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
}
