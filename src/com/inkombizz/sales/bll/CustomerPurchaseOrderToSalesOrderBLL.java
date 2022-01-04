package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.CustomerPurchaseOrderToSalesOrderDAO;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerPurchaseOrderField;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetail;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotation;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class CustomerPurchaseOrderToSalesOrderBLL {
    
    public static final String MODULECODE = "002_SAL_CUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER";
    
    private CustomerPurchaseOrderToSalesOrderDAO customerPurchaseOrderDAO;
    
    public CustomerPurchaseOrderToSalesOrderBLL (HBMSession hbmSession){
        this.customerPurchaseOrderDAO = new CustomerPurchaseOrderToSalesOrderDAO(hbmSession);
    }
    
    public ListPaging<CustomerPurchaseOrder> findData(Paging paging,CustomerPurchaseOrder customerPurchaseOrder, String validStatus) throws Exception {
        try {
                     
            paging.setRecords(customerPurchaseOrderDAO.countData(customerPurchaseOrder, validStatus));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerPurchaseOrder> listCustomerPurchaseOrder = customerPurchaseOrderDAO.findData(customerPurchaseOrder, validStatus, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerPurchaseOrder> listPaging = new ListPaging<CustomerPurchaseOrder>();
            
            listPaging.setList(listCustomerPurchaseOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerPurchaseOrder> findDataLookUp(Paging paging,CustomerPurchaseOrder customerPurchaseOrder, Date fromDate, Date upToDate) throws Exception {
        try {
                     
            paging.setRecords(customerPurchaseOrderDAO.countDataLookUp(customerPurchaseOrder, fromDate, upToDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerPurchaseOrder> listCustomerPurchaseOrder = customerPurchaseOrderDAO.findDataLookUp(customerPurchaseOrder, fromDate, upToDate, paging.getFromRow(), paging.getToRow());
            
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
            return (CustomerPurchaseOrder) customerPurchaseOrderDAO.findDataGet(code);
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
             
            if(customerPurchaseOrderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderSalesQuotation> findDataSalesQuotation(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation = customerPurchaseOrderDAO.findDataSalesQuotation(headerCode);
            
            return listCustomerPurchaseOrderSalesQuotation;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderDAO.findDataItemDetail(headerCode);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataUpdateItemDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderDAO.findDataUpdateItemDetail(headerCode);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderDAO.findDataItemDetail(arrSalesQuotationNo,customerPurchaseOrderItemDetail);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataSyncItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrder customerPurchaseOrder) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerPurchaseOrderDAO.findDataSyncItemDetail(arrSalesQuotationNo,customerPurchaseOrder);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderAdditionalFee> findDataAdditionalFee(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee = customerPurchaseOrderDAO.findDataAdditionalFee(headerCode);
            
            return listCustomerPurchaseOrderAdditionalFee;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderPaymentTerm> findDataPaymentTerm(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm = customerPurchaseOrderDAO.findDataPaymentTerm(headerCode);
            
            return listCustomerPurchaseOrderPaymentTerm;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerPurchaseOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) throws Exception {
        try {
            
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate = customerPurchaseOrderDAO.findDataItemDeliveryDate(headerCode);
            
            return listCustomerPurchaseOrderItemDeliveryDate;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CustomerPurchaseOrder totalAdditionalFeeAmount(String headerCode) throws Exception {
        try {
            return (CustomerPurchaseOrder) customerPurchaseOrderDAO.totalAdditionalFeeAmount(headerCode);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrder,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderDAO.save(enumActivity,customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerPurchaseOrder customerPurchaseOrder,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderDAO.update(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void revise(CustomerPurchaseOrder customerPurchaseOrder,List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate) throws Exception {
        try {
            customerPurchaseOrderDAO.revise(customerPurchaseOrder, listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(CustomerPurchaseOrder customerPurchaseOrder) throws Exception{
        customerPurchaseOrderDAO.delete(customerPurchaseOrder,MODULECODE);
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrder) throws Exception {
        try {
            return customerPurchaseOrderDAO.createCode(enumActivity,customerPurchaseOrder);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public CustomerPurchaseOrderToSalesOrderDAO getCustomerPurchaseOrderDAO() {
        return customerPurchaseOrderDAO;
    }

    public void setCustomerPurchaseOrderDAO(CustomerPurchaseOrderToSalesOrderDAO customerPurchaseOrderDAO) {
        this.customerPurchaseOrderDAO = customerPurchaseOrderDAO;
    }
    
}