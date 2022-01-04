/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;

import com.inkombizz.finance.model.VendorDownPayment;
import com.inkombizz.finance.model.VendorDownPaymentTemp;
import com.inkombizz.finance.dao.VendorDownPaymentDAO;
import com.inkombizz.finance.model.VendorDownPaymentField;
import java.util.Date;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class VendorDownPaymentBLL {
    
    public static final String MODULECODE="004_FIN_VENDOR_DOWN_PAYMENT";
    
    private VendorDownPaymentDAO vendorDownPaymentDAO;
    
    public VendorDownPaymentBLL (HBMSession hbmSession) {
        this.vendorDownPaymentDAO = new VendorDownPaymentDAO(hbmSession);
    }
    
    
    public ListPaging<VendorDownPaymentTemp> findData(Paging paging,String code,String vendorCode,String vendorName,String currencyCode,Date firstDate,Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(vendorDownPaymentDAO.countData(code,vendorCode,vendorName,currencyCode,firstDate,lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorDownPaymentTemp> listVendorDownPaymentTemp = vendorDownPaymentDAO.findData(code,vendorCode,vendorName,currencyCode,firstDate,lastDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<VendorDownPaymentTemp> listPaging = new ListPaging<VendorDownPaymentTemp>();
            
            listPaging.setList(listVendorDownPaymentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
     public List<VendorDownPaymentTemp> findByPurchaseOrder(String vendorCode) throws Exception {
        try {
              return vendorDownPaymentDAO.findByPurchaseOrder(vendorCode);
        } catch (Exception ex) {
            throw ex;
        }
    }
     
    public List<VendorDownPaymentTemp> findByVendorInvoice(String vendorCode) throws Exception {
        try {
              return vendorDownPaymentDAO.findByVendorInvoice(vendorCode);
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public void save(VendorDownPayment vendorDownPayment) throws Exception {
        try {
            vendorDownPaymentDAO.save(vendorDownPayment, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    
    public void update(VendorDownPayment vendorDownPayment) throws Exception {
        try {
            vendorDownPaymentDAO.update(vendorDownPayment, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
//    public ListPaging<VendorDownPaymentTemp> search(Paging paging,String code,String vendorCode,String vendorName,String currencyCode) throws Exception{
//        try{
//
//            paging.setRecords(vendorDownPaymentDAO.countData(code,vendorCode,vendorName,currencyCode));
//            
//            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
//            
//            List<VendorDownPaymentTemp> listVendorDownPaymentTemp = vendorDownPaymentDAO.findByCriteria(code,vendorCode,vendorName,currencyCode,paging.getFromRow(),paging.getToRow());
//            
//            ListPaging<VendorDownPaymentTemp> listPaging = new ListPaging<VendorDownPaymentTemp>();
//            
//            listPaging.setList(listVendorDownPaymentTemp);
//            listPaging.setPaging(paging);
//            
//            return listPaging;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return null;
//        }
//    }
    
    public List<VendorDownPaymentTemp> listDataHeaderByVendorInvoiceUpdate(String sinNo,String customerCode,String currencyCode) throws Exception{
        try{
            
            List<VendorDownPaymentTemp> listVendorDownPaymentTemp = vendorDownPaymentDAO.listDataHeaderByVendorInvoiceUpdate(sinNo,customerCode,currencyCode);
            
            return listVendorDownPaymentTemp;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public Boolean checkExistInUsedPaidAmount(String code) throws Exception{
        try {
            
            boolean isExist=vendorDownPaymentDAO.checkExistInUsedPaidAmount(code);
            
            return isExist;
        } catch (Exception ex) {
            ex.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void delete(String code) throws Exception{
        vendorDownPaymentDAO.delete(code, MODULECODE);
    }
    
//    public VendorDownPaymentTemp getHeader(String code) throws Exception{
//        try{
//            return vendorDownPaymentDAO.getHeader(code);
//        }
//        catch(Exception ex){
//            throw ex;
//        }
//    }
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorDownPayment.class)
                            .add(Restrictions.eq(VendorDownPaymentField.CODE, code));
             
            if(vendorDownPaymentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
