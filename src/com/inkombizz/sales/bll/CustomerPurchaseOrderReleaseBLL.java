/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.CustomerPurchaseOrderReleaseDAO;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerPurchaseOrderField;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetail;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotation;
import com.inkombizz.sales.model.CustomerSalesOrder;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class CustomerPurchaseOrderReleaseBLL {
     public static final String MODULECODE = "002_SAL_CUSTOMER_PURCHASE_ORDER_RELEASE";
    
    private CustomerPurchaseOrderReleaseDAO customerPurchaseOrderReleaseDAO;
    
    public CustomerPurchaseOrderReleaseBLL (HBMSession hbmSession){
        this.customerPurchaseOrderReleaseDAO = new CustomerPurchaseOrderReleaseDAO(hbmSession);
    }
    
     public ListPaging<CustomerPurchaseOrder> findData(Paging paging,CustomerPurchaseOrder customerPurchaseOrderRelease, String closingStatus, String validStatus) throws Exception {
        try {
                     
            paging.setRecords(customerPurchaseOrderReleaseDAO.countData(customerPurchaseOrderRelease,closingStatus, validStatus));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerPurchaseOrder> listCustomerPurchaseOrderRelease = customerPurchaseOrderReleaseDAO.findData(customerPurchaseOrderRelease,closingStatus ,validStatus, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerPurchaseOrder> listPaging = new ListPaging<CustomerPurchaseOrder>();
            
            listPaging.setList(listCustomerPurchaseOrderRelease);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
     public CustomerPurchaseOrder findData(String code) throws Exception {
        try {
            return (CustomerPurchaseOrder) customerPurchaseOrderReleaseDAO.findDataGet(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerPurchaseOrder.class)
                            .add(Restrictions.eq(CustomerPurchaseOrderField.CODE, headerCode));
             
            if(customerPurchaseOrderReleaseDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderSalesQuotation> findDataSalesQuotation(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderReleaseSalesQuotation = customerPurchaseOrderReleaseDAO.findDataSalesQuotation(headerCode);
            
            return listCustomerPurchaseOrderReleaseSalesQuotation;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(ArrayList arrSalesQuotationNo) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderReleaseItemDetail = customerPurchaseOrderReleaseDAO.findDataItemDetail(arrSalesQuotationNo);
            
            return listCustomerPurchaseOrderReleaseItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataUpdateItemDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderReleaseItemDetail = customerPurchaseOrderReleaseDAO.findDataUpdateItemDetail(headerCode);
            
            return listCustomerPurchaseOrderReleaseItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderReleaseItemDetail = customerPurchaseOrderReleaseDAO.findDataItemDetail(arrSalesQuotationNo,customerPurchaseOrderItemDetail);
            
            return listCustomerPurchaseOrderReleaseItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode, String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderReleaseItemDetail = customerPurchaseOrderReleaseDAO.findDataItemDetailArray(arrSalesQuotationCode, headerCode);
            
            return listCustomerPurchaseOrderReleaseItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataSyncItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrder customerPurchaseOrder) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderReleaseItemDetail = customerPurchaseOrderReleaseDAO.findDataSyncItemDetail(arrSalesQuotationNo,customerPurchaseOrder);
            
            return listCustomerPurchaseOrderReleaseItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderAdditionalFee> findDataAdditionalFee(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderReleaseAdditionalFee = customerPurchaseOrderReleaseDAO.findDataAdditionalFee(headerCode);
            
            return listCustomerPurchaseOrderReleaseAdditionalFee;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderPaymentTerm> findDataPaymentTerm(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderReleasePaymentTerm = customerPurchaseOrderReleaseDAO.findDataPaymentTerm(headerCode);
            
            return listCustomerPurchaseOrderReleasePaymentTerm;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderReleaseItemDeliveryDate = customerPurchaseOrderReleaseDAO.findDataItemDeliveryDate(headerCode);
            
            return listCustomerPurchaseOrderReleaseItemDeliveryDate;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CustomerPurchaseOrder totalAdditionalFeeAmount(String headerCode) throws Exception {
        try {
            return (CustomerPurchaseOrder) customerPurchaseOrderReleaseDAO.totalAdditionalFeeAmount(headerCode);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrderRelease,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderReleaseDAO.save(enumActivity,customerPurchaseOrderRelease, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerPurchaseOrder customerPurchaseOrderRelease,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderReleaseDAO.update(customerPurchaseOrderRelease, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void revise(CustomerPurchaseOrder customerPurchaseOrderRelease,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderReleaseDAO.revise(customerPurchaseOrderRelease, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(CustomerPurchaseOrder customerPurchaseOrderRelease) throws Exception{
        customerPurchaseOrderReleaseDAO.delete(customerPurchaseOrderRelease,MODULECODE);
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrderRelease) throws Exception {
        try {
            return customerPurchaseOrderReleaseDAO.createCode(enumActivity,customerPurchaseOrderRelease);
        }
        catch (Exception e) {
            throw e;
        }
    }
}
