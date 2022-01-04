
package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.model.InternalMemoMaterial;
import com.inkombizz.sales.model.InternalMemoMaterialDetail;
import com.inkombizz.sales.model.InternalMemoMaterialField;
import com.inkombizz.sales.dao.InternalMemoMaterialDAO;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class InternalMemoMaterialBLL {
    public static final String MODULECODE = "002_SAL_INTERNAL_MEMO_MATERIAL";
    public static final String MODULECODE_APPROVAL = "002_SAL_INTERNAL_MEMO_MATERIAL_APPROVAL";
    public static final String MODULECODE_CLOSING = "002_SAL_INTERNAL_MEMO_MATERIAL_CLOSING";
    
    private InternalMemoMaterialDAO internalMemoMaterialDAO;
    
    public InternalMemoMaterialBLL (HBMSession hbmSession) {
        this.internalMemoMaterialDAO = new InternalMemoMaterialDAO(hbmSession);
    }
    
   // Look Up Purchase Request
//    public ListPaging<InternalMemoMaterial> findDataLookUp(String code, Date fromDate,Date upToDate,Paging paging) throws Exception {
//        try {
//            DetachedCriteria criteria = DetachedCriteria.forClass(InternalMemoMaterial.class);           
//    
//            paging.setRecords(internalMemoMaterialDAO.countDataLookUp(code, fromDate, upToDate));
//            
//            criteria.setProjection(null);
//            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
//            
//            criteria = paging.addOrderCriteria(criteria);          
//            
//            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
//            
//            List<InternalMemoMaterial> listInternalMemoMaterial = internalMemoMaterialDAO.findDataLookUp(code, fromDate, upToDate, paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<InternalMemoMaterial> listPaging = new ListPaging<InternalMemoMaterial>();
//            
//            listPaging.setList(listInternalMemoMaterial);
//            listPaging.setPaging(paging);
//            
//            return listPaging;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
   //    Purchase Request Non Item Material Request 
    public ListPaging<InternalMemoMaterial> findData(InternalMemoMaterial purchaseRequestNonItemMaterialRequest,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(InternalMemoMaterial.class);           
    
            paging.setRecords(internalMemoMaterialDAO.countData(purchaseRequestNonItemMaterialRequest));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<InternalMemoMaterial> listInternalMemoMaterial = internalMemoMaterialDAO.findData(purchaseRequestNonItemMaterialRequest, paging.getFromRow(), paging.getToRow());
            
            ListPaging<InternalMemoMaterial> listPaging = new ListPaging<InternalMemoMaterial>();
            
            listPaging.setList(listInternalMemoMaterial);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    //NO PRQ IMR
    public List<InternalMemoMaterialDetail> findDataDetailIMMNo(ArrayList arrPurchaseOrderPRQNo) throws Exception {
        try {
            
            List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail = internalMemoMaterialDAO.findDataDetailIMMNo(arrPurchaseOrderPRQNo);
            
            return listInternalMemoMaterialDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    //Sub Item
    public List<InternalMemoMaterialDetail> findDataDetailSubItem(ArrayList arrPurchaseOrderNo) throws Exception {
        try {
            
            List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail = internalMemoMaterialDAO.findDataDetailSubItem(arrPurchaseOrderNo);
            
            return listInternalMemoMaterialDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataSubItem(String code) throws Exception {
        try {
            
            List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail = internalMemoMaterialDAO.findDataSubItem(code);
            
            return listInternalMemoMaterialDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(InternalMemoMaterial.class)
                            .add(Restrictions.eq(InternalMemoMaterialField.CODE, code));
             
            if(internalMemoMaterialDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public ListPaging<InternalMemoMaterial> findDataApproval(InternalMemoMaterial purchaseRequestNonItemMaterialRequestApproval,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(InternalMemoMaterial.class);           
    
            paging.setRecords(internalMemoMaterialDAO.countDataApproval(purchaseRequestNonItemMaterialRequestApproval));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<InternalMemoMaterial> listInternalMemoMaterial = internalMemoMaterialDAO.findDataApproval(purchaseRequestNonItemMaterialRequestApproval, paging.getFromRow(), paging.getToRow());
            
            ListPaging<InternalMemoMaterial> listPaging = new ListPaging<InternalMemoMaterial>();
            
            listPaging.setList(listInternalMemoMaterial);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataDetail(String code) throws Exception {
        try {
            
            List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail = internalMemoMaterialDAO.findDataDetail(code);
            
            return listInternalMemoMaterialDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<InternalMemoMaterial> findDataClosing(InternalMemoMaterial purchaseRequestNonItemMaterialRequestClosing,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(InternalMemoMaterial.class);           
    
            paging.setRecords(internalMemoMaterialDAO.countDataClosing(purchaseRequestNonItemMaterialRequestClosing));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<InternalMemoMaterial> listInternalMemoMaterial = internalMemoMaterialDAO.findDataClosing(purchaseRequestNonItemMaterialRequestClosing, paging.getFromRow(), paging.getToRow());
            
            ListPaging<InternalMemoMaterial> listPaging = new ListPaging<InternalMemoMaterial>();
            
            listPaging.setList(listInternalMemoMaterial);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(InternalMemoMaterial purchaseRequestNonItemMaterialRequest,List<InternalMemoMaterialDetail> listInternalMemoMaterial) throws Exception {
        try {
            internalMemoMaterialDAO.save(purchaseRequestNonItemMaterialRequest,listInternalMemoMaterial, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(InternalMemoMaterial purchaseRequestNonItemMaterialRequest,List<InternalMemoMaterialDetail> listInternalMemoMaterial) throws Exception {
        try {
            internalMemoMaterialDAO.update(purchaseRequestNonItemMaterialRequest,listInternalMemoMaterial, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void approval(InternalMemoMaterial internalMemoMaterialApporval) throws Exception {
        try {
            internalMemoMaterialDAO.approval(internalMemoMaterialApporval,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void closing(InternalMemoMaterial purchaseRequestNonItemMaterialRequestClosing) throws Exception {
        try {
            internalMemoMaterialDAO.closing(purchaseRequestNonItemMaterialRequestClosing,MODULECODE_CLOSING);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            internalMemoMaterialDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
}
