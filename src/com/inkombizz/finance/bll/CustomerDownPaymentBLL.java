/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

/**
 *
 * @author Rayis
 */

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;

import com.inkombizz.finance.model.CustomerDownPayment;
import com.inkombizz.finance.model.CustomerDownPaymentTemp;
import com.inkombizz.finance.dao.CustomerDownPaymentDAO;
import com.inkombizz.finance.model.CustomerDownPaymentField;
import java.util.Date;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class CustomerDownPaymentBLL {
    
    public static final String MODULECODE="004_FIN_CUSTOMER_DOWN_PAYMENT";
    
    private CustomerDownPaymentDAO customerDownPaymentDAO;
    
    public CustomerDownPaymentBLL (HBMSession hbmSession) {
        this.customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
    }
    
    
    public ListPaging<CustomerDownPaymentTemp> findData(Paging paging,String code,String customerCode,String customerName,String currencyCode,Date firstDate,Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(customerDownPaymentDAO.countData(code,customerCode,customerName,currencyCode,firstDate,lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerDownPaymentTemp> listCustomerDownPaymentTemp = customerDownPaymentDAO.findData(code,customerCode,customerName,currencyCode,firstDate,lastDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<CustomerDownPaymentTemp> listPaging = new ListPaging<CustomerDownPaymentTemp>();
            
            listPaging.setList(listCustomerDownPaymentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(CustomerDownPayment customerDownPayment) throws Exception {
        try {
            customerDownPaymentDAO.save(customerDownPayment, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    
    public void update(CustomerDownPayment customerDownPayment) throws Exception {
        try {
            customerDownPaymentDAO.update(customerDownPayment, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
//    public ListPaging<CustomerDownPaymentTemp> search(Paging paging,String code,String customerCode,String customerName,String currencyCode) throws Exception{
//        try{
//
//            paging.setRecords(customerDownPaymentDAO.countData(code,customerCode,customerName,currencyCode));
//            
//            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
//            
//            List<CustomerDownPaymentTemp> listCustomerDownPaymentTemp = customerDownPaymentDAO.findByCriteria(code,customerCode,customerName,currencyCode,paging.getFromRow(),paging.getToRow());
//            
//            ListPaging<CustomerDownPaymentTemp> listPaging = new ListPaging<CustomerDownPaymentTemp>();
//            
//            listPaging.setList(listCustomerDownPaymentTemp);
//            listPaging.setPaging(paging);
//            
//            return listPaging;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return null;
//        }
//    }
    
    public List<CustomerDownPaymentTemp> listDataHeaderByCustomerInvoiceUpdate(String sinNo,String customerCode,String currencyCode) throws Exception{
        try{
            
            List<CustomerDownPaymentTemp> listCustomerDownPaymentTemp = customerDownPaymentDAO.listDataHeaderByCustomerInvoiceUpdate(sinNo,customerCode,currencyCode);
            
            return listCustomerDownPaymentTemp;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public Boolean checkExistInUsedPaidAmount(String code) throws Exception{
        try {
            
            boolean isExist=customerDownPaymentDAO.checkExistInUsedPaidAmount(code);
            
            return isExist;
        } catch (Exception ex) {
            ex.printStackTrace();
            return Boolean.FALSE;
        }
    }
    public List<CustomerDownPaymentTemp> findByCustomerInvoice(String customerCode) throws Exception {
        try {
              return customerDownPaymentDAO.findByCustomerInvoice(customerCode);
        } catch (Exception ex) {
            throw ex;
        }
    }
    public void delete(String code) throws Exception{
        customerDownPaymentDAO.delete(code, MODULECODE);
    }
    
//    public CustomerDownPaymentTemp getHeader(String code) throws Exception{
//        try{
//            return customerDownPaymentDAO.getHeader(code);
//        }
//        catch(Exception ex){
//            throw ex;
//        }
//    }
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerDownPayment.class)
                            .add(Restrictions.eq(CustomerDownPaymentField.CODE, code));
             
            if(customerDownPaymentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
