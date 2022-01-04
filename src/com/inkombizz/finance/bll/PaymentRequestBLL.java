
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.finance.dao.PaymentRequestDAO;
import com.inkombizz.finance.model.PaymentRequest;
import com.inkombizz.finance.model.PaymentRequestDetail;
import com.inkombizz.finance.model.PaymentRequestDetailTemp;
import com.inkombizz.finance.model.PaymentRequestField;
import com.inkombizz.finance.model.PaymentRequestTemp;
//import com.inkombizz.purchasing.model.PurchaseOrder;
import java.math.BigDecimal;
import org.hibernate.HibernateException;

public class PaymentRequestBLL {

    public static final String MODULECODE = "004_FIN_PAYMENT_REQUEST";
    public static final String MODULECODE_PAYMENT_APPROVAL = "004_FIN_PAYMENT_REQUEST_APPROVAL";
    public final String MODULECODE_RELEASE = "004_FIN_PAYMENT_REQUEST_RELEASE";
    private PaymentRequestDAO paymentRequestDAO;
    
    public PaymentRequestBLL(HBMSession hbmSession){
        this.paymentRequestDAO = new PaymentRequestDAO(hbmSession);
    }
    
    
    public ListPaging<PaymentRequestTemp> findData(Paging paging, String code,String refNo,String remark,Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(paymentRequestDAO.countData(code,refNo,remark,firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PaymentRequestTemp> listPaymentRequestTemp = paymentRequestDAO.findData(code,refNo,remark,firstDate, lastDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentRequestTemp> listPaging = new ListPaging<PaymentRequestTemp>();
            
            listPaging.setList(listPaymentRequestTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PaymentRequestTemp> findDatapayment(Paging paging, String code, String transactionType, String requestType, String currencyCode) throws Exception {
        try {
                     
            paging.setRecords(paymentRequestDAO.countDataPayment(code, transactionType, requestType, currencyCode));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PaymentRequestTemp> listPaymentRequestTemp = paymentRequestDAO.findDataPayment(code, transactionType, requestType, currencyCode, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentRequestTemp> listPaging = new ListPaging<PaymentRequestTemp>();
            
            listPaging.setList(listPaymentRequestTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PaymentRequestDetailTemp> findDatapaymentDetail(String code) throws Exception {
        try {
            List<PaymentRequestDetailTemp> listPaymentRequestDetailTemp = paymentRequestDAO.findDataPaymentDetail(code);
            
            return listPaymentRequestDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PaymentRequestTemp> findDataApproval(Paging paging, String code,String paymentTo, String refNo,String remark,String createdBy,String status,Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(paymentRequestDAO.countDataApproval(code,paymentTo,refNo,remark,status,firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PaymentRequestTemp> listPaymentRequestTemp = paymentRequestDAO.findDataApproval(code,paymentTo,refNo,remark,createdBy,status,firstDate, lastDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentRequestTemp> listPaging = new ListPaging<PaymentRequestTemp>();
            
            listPaging.setList(listPaymentRequestTemp);
            listPaging.setPaging(paging);
             
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public ListPaging<PaymentRequestTemp> findDataSearch(Paging paging, String code,String paymentTo,Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(paymentRequestDAO.countDataSearch(code,paymentTo,firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PaymentRequestTemp> listPaymentRequestTemp = paymentRequestDAO.findDataSearch(code,paymentTo,firstDate, lastDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentRequestTemp> listPaging = new ListPaging<PaymentRequestTemp>();
            
            listPaging.setList(listPaymentRequestTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ListPaging<PaymentRequestTemp> findDataRelease(Paging paging,String code,String releasedStatus,Date fromDate,Date upToDate) throws Exception{
        try{

            paging.setRecords(paymentRequestDAO.countDataRelease(code,releasedStatus,fromDate,upToDate));
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<PaymentRequestTemp> listPaymentRequestTemp = paymentRequestDAO.findDataRelease(code,releasedStatus,fromDate,upToDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentRequestTemp> listPaging = new ListPaging<PaymentRequestTemp>();
            
            listPaging.setList(listPaymentRequestTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    public PaymentRequestTemp findData(String code) throws Exception {
        try {
                                 
            PaymentRequestTemp paymentRequestTemp = paymentRequestDAO.findData(code);
            
            return paymentRequestTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public List<PaymentRequestDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<PaymentRequestDetailTemp> listPaymentRequestDetailTemp = paymentRequestDAO.findDataDetail(headerCode);
            
            return listPaymentRequestDetailTemp;  
        }
        catch(Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }
    
    //check code dah ada di DB?
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(PaymentRequest.class)
                            .add(Restrictions.eq(PaymentRequestField.CODE, headerCode));
             
            if(paymentRequestDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(PaymentRequest paymentRequest, List<PaymentRequestDetail> listPaymentRequestDetail) throws Exception {
        try {
            paymentRequestDAO.save(paymentRequest, listPaymentRequestDetail, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void update(PaymentRequest paymentRequest,List<PaymentRequestDetail> listPaymentRequestDetail) throws Exception {
        try {
            paymentRequestDAO.update(paymentRequest,listPaymentRequestDetail,MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void delete(String headerCode) throws Exception{
        paymentRequestDAO.delete(headerCode, MODULECODE);
    }
    
    public void approval(PaymentRequest paymentRequest) throws Exception {
        try {
            paymentRequestDAO.approval(paymentRequest,MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
//    public void paid(PaymentRequest paymentRequest) throws Exception {
//        try {
//            paymentRequestDAO.paid(paymentRequest,MODULECODE);
//        }
//        catch (Exception e) {
//            e.printStackTrace();
//            throw e;
//        }
//    }
        
    public Boolean isApproved(String code) throws Exception{
        try {
            return paymentRequestDAO.isApproved(code);
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    

    public void isReleasedStatus(String code) throws Exception{
        try {
            paymentRequestDAO.isReleasedStatus(code);
        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    public PaymentRequest get(String code) throws Exception {
        try {
            return (PaymentRequest) paymentRequestDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public PaymentRequestDAO getPaymentRequestDAO() {
        return paymentRequestDAO;
    }

    public void setPaymentRequestDAO(PaymentRequestDAO paymentRequestDAO) {
        this.paymentRequestDAO = paymentRequestDAO;
    }

    public static String getMODULECODE() {
        return MODULECODE;
    }

    public static String getMODULECODE_PAYMENT_APPROVAL() {
        return MODULECODE_PAYMENT_APPROVAL;
    }

    public String getMODULECODE_RELEASE() {
        return MODULECODE_RELEASE;
    }
    
}
