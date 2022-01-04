
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.PaymentTermDAO;
import com.inkombizz.master.model.PaymentTerm;
import com.inkombizz.master.model.PaymentTermField;
import com.inkombizz.master.model.PaymentTermTemp;


public class PaymentTermBLL {
    
    public final String MODULECODE = "006_MST_PAYMENT_TERM";
    
    private PaymentTermDAO paymentTermDAO;
    
    public PaymentTermBLL(HBMSession hbmSession){
        this.paymentTermDAO=new PaymentTermDAO(hbmSession);
    }
    
    public ListPaging<PaymentTermTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PaymentTerm.class);           
    
            paging.setRecords(paymentTermDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PaymentTermTemp> listPaymentTermTemp = paymentTermDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentTermTemp> listPaging = new ListPaging<PaymentTermTemp>();
            
            listPaging.setList(listPaymentTermTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PaymentTermTemp> findDataByVendor(String vendorCode ,String code, String name,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PaymentTerm.class);           
    
            paging.setRecords(paymentTermDAO.countDataByVendor(vendorCode, code,name));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PaymentTermTemp> listPaymentTermTemp = paymentTermDAO.findDataByVendor(vendorCode, code,name, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentTermTemp> listPaging = new ListPaging<PaymentTermTemp>();
            
            listPaging.setList(listPaymentTermTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public PaymentTermTemp findData(String code) throws Exception {
        try {
            return (PaymentTermTemp) paymentTermDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public PaymentTermTemp findData(String code,boolean active) throws Exception {
        try {
            return (PaymentTermTemp) paymentTermDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public PaymentTermTemp findDataByVendor(String vendorCode, String code) throws Exception {
        try {
            return (PaymentTermTemp) paymentTermDAO.findDataByVendor(vendorCode,code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(PaymentTerm paymentTerm) throws Exception {
        try {
            paymentTermDAO.save(paymentTerm, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(PaymentTerm paymentTerm) throws Exception {
        try {
            paymentTermDAO.update(paymentTerm, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            paymentTermDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(PaymentTerm.class)
                            .add(Restrictions.eq(PaymentTermField.CODE, code));
             
            if(paymentTermDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
