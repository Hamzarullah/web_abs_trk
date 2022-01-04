package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.RequestForQuotationDAO;
import com.inkombizz.sales.model.RequestForQuotation;
import com.inkombizz.sales.model.RequestForQuotationField;
import com.inkombizz.sales.model.RequestForQuotationTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class RequestForQuotationBLL {
    
    public static final String MODULECODE = "002_SAL_REQUEST_FOR_QUOTATION";
    public static final String MODULECODE_APPROVAL = "002_SAL_REQUEST_FOR_QUOTATION_APPROVAL";
    public static final String MODULECODE_CLOSING = "002_SAL_REQUEST_FOR_QUOTATION_CLOSING";
    
    private RequestForQuotationDAO requestForQuotationDAO;
    
    public RequestForQuotationBLL(HBMSession hbmSession){
        this.requestForQuotationDAO = new RequestForQuotationDAO(hbmSession);
    }
    
     public ListPaging<RequestForQuotationTemp> findData(Paging paging,String rfqNoCode, String tenderNo, String customerCode,
                                                         String customerName,String subject, String projectCode, String active, 
                                                         String endUserCode, String endUserName, String refNo, String remark,
                                                         String approvalStatus, Date firstDate,Date lastDate) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(RequestForQuotation.class);           
    
            paging.setRecords(requestForQuotationDAO.countData(rfqNoCode, tenderNo, customerCode, customerName, subject,
                                                               projectCode, active, endUserCode, endUserName, refNo, remark, 
                                                               approvalStatus, firstDate,lastDate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
 
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RequestForQuotationTemp> listRequestForQuotationTemp = requestForQuotationDAO.findByCriteria(rfqNoCode, tenderNo, customerCode, customerName,
                                                                                                              subject, projectCode, active, endUserCode, endUserName,
                                                                                                              refNo, remark, approvalStatus, firstDate, lastDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<RequestForQuotationTemp> listPaging = new ListPaging<RequestForQuotationTemp>();
            
            listPaging.setList(listRequestForQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
     public ListPaging<RequestForQuotationTemp> findApprovalData(Paging paging,String code,String tenderNo,String customerCode,String customerName,
                                                                 String projectCode, String subject, String approvalStatus, String validStatus,
                                                                 String endUserCode, String endUserName, String refNo, String remark,
                                                                 Date fromDate,Date upToDate) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(RequestForQuotation.class);           
    
            paging.setRecords(requestForQuotationDAO.countDataApproval(code, tenderNo,customerCode,customerName,
                                                                       subject, projectCode, approvalStatus, validStatus,
                                                                       endUserCode, endUserName, refNo, remark, fromDate,upToDate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
 
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RequestForQuotationTemp> listRequestForQuotationTemp = requestForQuotationDAO.findDataApproval(code,tenderNo,customerCode,customerName,
                                                                                                                subject,projectCode, approvalStatus, validStatus,endUserCode, endUserName,
                                                                                                                refNo, remark, fromDate,upToDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<RequestForQuotationTemp> listPaging = new ListPaging<RequestForQuotationTemp>();
            
            listPaging.setList(listRequestForQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
     public ListPaging<RequestForQuotationTemp> findClosingData(Paging paging,String code,String tenderNo,String customerCode,String customerName, String subject, String projectCode,String closingStatus, String endUserCode, String endUserName,Date fromDate,Date upToDate) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(RequestForQuotation.class);           
    
            paging.setRecords(requestForQuotationDAO.countDataClosing(code, tenderNo,customerCode,customerName,subject, projectCode, closingStatus, endUserCode, endUserName, fromDate,upToDate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
 
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RequestForQuotationTemp> listRequestForQuotationTemp = requestForQuotationDAO.findDataClosing(code,tenderNo,customerCode,customerName,subject,projectCode, closingStatus,endUserCode, endUserName, fromDate,upToDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<RequestForQuotationTemp> listPaging = new ListPaging<RequestForQuotationTemp>();
            
            listPaging.setList(listRequestForQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
     public ListPaging<RequestForQuotationTemp> findDataRequestForQuotation(Paging paging,String code,Date fromDate,Date upToDate) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(RequestForQuotation.class);           
    
            paging.setRecords(requestForQuotationDAO.countRFQData(code,fromDate,upToDate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
 
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<RequestForQuotationTemp> listRequestForQuotationTemp = requestForQuotationDAO.findRFQ(code, fromDate,upToDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<RequestForQuotationTemp> listPaging = new ListPaging<RequestForQuotationTemp>();
            
            listPaging.setList(listRequestForQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
      public String createRevise(RequestForQuotation requestForQuotation) throws Exception {
        try {
            return requestForQuotationDAO.createReviseCode(requestForQuotation);
        }
        catch (Exception e) {
            throw e;
        }
    }
      
      public void save(RequestForQuotation requestForQuotation) throws Exception {
        try {
            requestForQuotationDAO.save(requestForQuotation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
      
      public void saveRevise(RequestForQuotation requestForQuotation) throws Exception {
        try {
            requestForQuotationDAO.saveRevise(requestForQuotation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
      
      public void update(RequestForQuotation requestForQuotation) throws Exception {
        try {
            requestForQuotationDAO.update(requestForQuotation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
      
    public RequestForQuotationTemp check(String code) throws Exception {
        try {
            return (RequestForQuotationTemp) requestForQuotationDAO.check(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
      
      public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(RequestForQuotation.class)
                            .add(Restrictions.eq(RequestForQuotationField.CODE, code));
             
            if(requestForQuotationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
      
      public void delete(String code) throws Exception {
        try {
            requestForQuotationDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
      
      public void approval(RequestForQuotation requestForQuotation) throws Exception {
        try {
            requestForQuotationDAO.approval(requestForQuotation,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
      
     public RequestForQuotation get(String code) throws Exception {
        try {
            return (RequestForQuotation) requestForQuotationDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
     public void closing(RequestForQuotation requestForQuotationClosing) throws Exception {
        try {
            requestForQuotationDAO.closing(requestForQuotationClosing, MODULECODE_CLOSING);
        }
        catch (Exception e) {
            throw e;
        }
    }
}