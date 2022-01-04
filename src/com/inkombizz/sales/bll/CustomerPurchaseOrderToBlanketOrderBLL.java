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
import com.inkombizz.sales.dao.CustomerPurchaseOrderToBlanketOrderDAO;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerPurchaseOrderField;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetail;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotation;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author ikb
 */
public class CustomerPurchaseOrderToBlanketOrderBLL {
     public static final String MODULECODE = "002_SAL_CUSTOMER_PURCHASE_ORDER_TO_BLANKET_ORDER";
    
    private CustomerPurchaseOrderToBlanketOrderDAO customerPurchaseOrderBlanketOrderDAO;
    
    public CustomerPurchaseOrderToBlanketOrderBLL (HBMSession hbmSession){
        this.customerPurchaseOrderBlanketOrderDAO = new CustomerPurchaseOrderToBlanketOrderDAO(hbmSession);
    }
    
    public ListPaging<CustomerPurchaseOrder> findData(Paging paging,CustomerPurchaseOrder customerPurchaseOrder, String validStatus) throws Exception {
        try {
                     
            paging.setRecords(customerPurchaseOrderBlanketOrderDAO.countData(customerPurchaseOrder, validStatus));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerPurchaseOrder> listCustomerPurchaseOrder = customerPurchaseOrderBlanketOrderDAO.findData(customerPurchaseOrder, validStatus, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerPurchaseOrder> listPaging = new ListPaging<CustomerPurchaseOrder>();
            
            listPaging.setList(listCustomerPurchaseOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
     public CustomerPurchaseOrder findData(String code) throws Exception {
        try {
            return (CustomerPurchaseOrder) customerPurchaseOrderBlanketOrderDAO.findDataGet(code);
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
             
            if(customerPurchaseOrderBlanketOrderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderSalesQuotation> findDataSalesQuotation(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation = customerPurchaseOrderBlanketOrderDAO.findDataSalesQuotation(headerCode);
            
            return listCustomerPurchaseOrderSalesQuotation;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderBlanketOrderDAO.findDataItemDetail(headerCode);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderBlanketOrderDAO.findDataItemDetailArray(arrSalesQuotationCode);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetailArray2(ArrayList arrSalesQuotationCode, String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderBlanketOrderDAO.findDataItemDetailArray2(arrSalesQuotationCode, headerCode);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderBlanketOrderDAO.findDataItemDetail(arrSalesQuotationNo,customerPurchaseOrderItemDetail);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataSyncItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrder customerPurchaseOrder) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderBlanketOrderDAO.findDataSyncItemDetail(arrSalesQuotationNo,customerPurchaseOrder);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderAdditionalFee> findDataAdditionalFee(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee = customerPurchaseOrderBlanketOrderDAO.findDataAdditionalFee(headerCode);
            
            return listCustomerPurchaseOrderAdditionalFee;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderPaymentTerm> findDataPaymentTerm(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm = customerPurchaseOrderBlanketOrderDAO.findDataPaymentTerm(headerCode);
            
            return listCustomerPurchaseOrderPaymentTerm;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate = customerPurchaseOrderBlanketOrderDAO.findDataItemDeliveryDate(headerCode);
            
            return listCustomerPurchaseOrderItemDeliveryDate;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CustomerPurchaseOrder totalAdditionalFeeAmount(String headerCode) throws Exception {
        try {
            return (CustomerPurchaseOrder) customerPurchaseOrderBlanketOrderDAO.totalAdditionalFeeAmount(headerCode);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrder,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderBlanketOrderDAO.save(enumActivity,customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerPurchaseOrder customerPurchaseOrder,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderBlanketOrderDAO.update(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void revise(CustomerPurchaseOrder customerPurchaseOrder,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderBlanketOrderDAO.revise(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(CustomerPurchaseOrder customerPurchaseOrder) throws Exception{
        customerPurchaseOrderBlanketOrderDAO.delete(customerPurchaseOrder, MODULECODE);
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrder) throws Exception {
        try {
            return customerPurchaseOrderBlanketOrderDAO.createCode(enumActivity,customerPurchaseOrder);
        }
        catch (Exception e) {
            throw e;
        }
    }
}
