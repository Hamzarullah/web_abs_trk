package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.CustomerBlanketOrderDAO;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.sales.model.CustomerBlanketOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerBlanketOrderField;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDetail;
import com.inkombizz.sales.model.CustomerBlanketOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerBlanketOrderSalesQuotation;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class CustomerBlanketOrderBLL {
    
    public static final String MODULECODE = "002_SAL_CUSTOMER_BLANKET_ORDER";
    public static final String MODULECODE_CLOSING = "002_SAL_CUSTOMER_BLANKET_ORDER_CLOSING";
    
    private CustomerBlanketOrderDAO customerBlanketOrderDAO;
    
    public CustomerBlanketOrderBLL (HBMSession hbmSession){
        this.customerBlanketOrderDAO = new CustomerBlanketOrderDAO(hbmSession);
    }
    
    public ListPaging<CustomerBlanketOrder> findData(Paging paging,CustomerBlanketOrder customerBlanketOrder, String validStatus) throws Exception {
        try {
                     
            paging.setRecords(customerBlanketOrderDAO.countData(customerBlanketOrder, validStatus));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerBlanketOrder> listBlanketOrder = customerBlanketOrderDAO.findData(customerBlanketOrder, validStatus,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerBlanketOrder> listPaging = new ListPaging<CustomerBlanketOrder>();
            
            listPaging.setList(listBlanketOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerBlanketOrder> findDataClosing(Paging paging,CustomerBlanketOrder customerBlanketOrder) throws Exception {
        try {
                     
            paging.setRecords(customerBlanketOrderDAO.countDataClosing(customerBlanketOrder));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerBlanketOrder> listBlanketOrder = customerBlanketOrderDAO.findDataClosing(customerBlanketOrder,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerBlanketOrder> listPaging = new ListPaging<CustomerBlanketOrder>();
            
            listPaging.setList(listBlanketOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerBlanketOrder> findSearchData(Paging paging,CustomerBlanketOrder customerBlanketOrder, Date fromDate,Date upToDate) throws Exception {
        try {
                     
            paging.setRecords(customerBlanketOrderDAO.countSearchData(customerBlanketOrder, fromDate, upToDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerBlanketOrder> listBlanketOrder = customerBlanketOrderDAO.findSearchData(customerBlanketOrder, fromDate, upToDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerBlanketOrder> listPaging = new ListPaging<CustomerBlanketOrder>();
            
            listPaging.setList(listBlanketOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerBlanketOrder.class)
                            .add(Restrictions.eq(CustomerBlanketOrderField.CODE, headerCode));
             
            if(customerBlanketOrderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<CustomerBlanketOrderSalesQuotation> findDataSalesQuotation(String headerCode) throws Exception {
        try {
            
            List<CustomerBlanketOrderSalesQuotation> listBlanketOrderSalesQuotation = customerBlanketOrderDAO.findDataSalesQuotation(headerCode);
            
            return listBlanketOrderSalesQuotation;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerBlanketOrderItemDetail> findDataItemDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerBlanketOrderItemDetail> listBlanketOrderItemDetail = customerBlanketOrderDAO.findDataItemDetail(headerCode);
            
            return listBlanketOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerBlanketOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode, String headerCode) throws Exception {
        try {
            
            List<CustomerBlanketOrderItemDetail> listBlanketOrderItemDetail = customerBlanketOrderDAO.findDataItemDetailArray(arrSalesQuotationCode, headerCode);
            
            return listBlanketOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerBlanketOrderItemDetail> findDataSyncItemDetail(ArrayList arrSalesQuotationNo,CustomerBlanketOrder customerBlanketOrder) throws Exception {
        try {
            
            List<CustomerBlanketOrderItemDetail> listCustomerPurchaseOrderItemDetail = customerBlanketOrderDAO.findDataSyncItemDetail(arrSalesQuotationNo,customerBlanketOrder);
            
            return listCustomerPurchaseOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerBlanketOrderAdditionalFee> findDataAdditionalFee(String headerCode) throws Exception {
        try {
            
            List<CustomerBlanketOrderAdditionalFee> listBlanketOrderAdditionalFee = customerBlanketOrderDAO.findDataAdditionalFee(headerCode);
            
            return listBlanketOrderAdditionalFee;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerBlanketOrderPaymentTerm> findDataPaymentTerm(String headerCode) throws Exception {
        try {
            
            List<CustomerBlanketOrderPaymentTerm> listBlanketOrderPaymentTerm = customerBlanketOrderDAO.findDataPaymentTerm(headerCode);
            
            return listBlanketOrderPaymentTerm;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerBlanketOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) throws Exception {
        try {
            
            List<CustomerBlanketOrderItemDeliveryDate> listBlanketOrderItemDeliveryDate = customerBlanketOrderDAO.findDataItemDeliveryDate(headerCode);
            
            return listBlanketOrderItemDeliveryDate;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CustomerBlanketOrder totalAdditionalFeeAmount(String headerCode) throws Exception {
        try {
            return (CustomerBlanketOrder) customerBlanketOrderDAO.totalAdditionalFeeAmount(headerCode);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderItemDetail> findDataforProductionPlanning(String headerCode) throws Exception {
        try {
            
            List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail = customerBlanketOrderDAO.findDataforPp(headerCode);
            
            return listCustomerBlanketOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerBlanketOrder blanketOrder,List<CustomerBlanketOrderSalesQuotation> listBlanketOrderSalesQuotation, List<CustomerBlanketOrderItemDetail> listBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listBlanketOrderAdditionalFee,List<CustomerBlanketOrderPaymentTerm> listBlanketOrderPaymentTerm,List<CustomerBlanketOrderItemDeliveryDate> listBlanketOrderItemDeliveryDate) throws Exception {
        try {
            customerBlanketOrderDAO.save(enumActivity,blanketOrder, listBlanketOrderSalesQuotation,listBlanketOrderItemDetail,listBlanketOrderAdditionalFee,listBlanketOrderPaymentTerm,listBlanketOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerBlanketOrder blanketOrder,List<CustomerBlanketOrderSalesQuotation> listBlanketOrderSalesQuotation, List<CustomerBlanketOrderItemDetail> listBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listBlanketOrderAdditionalFee,List<CustomerBlanketOrderPaymentTerm> listBlanketOrderPaymentTerm,List<CustomerBlanketOrderItemDeliveryDate> listBlanketOrderItemDeliveryDate) throws Exception {
        try {
            customerBlanketOrderDAO.update(blanketOrder, listBlanketOrderSalesQuotation,listBlanketOrderItemDetail,listBlanketOrderAdditionalFee,listBlanketOrderPaymentTerm,listBlanketOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void revise(CustomerBlanketOrder blanketOrder,List<CustomerBlanketOrderSalesQuotation> listBlanketOrderSalesQuotation, List<CustomerBlanketOrderItemDetail> listBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listBlanketOrderAdditionalFee,List<CustomerBlanketOrderPaymentTerm> listBlanketOrderPaymentTerm,List<CustomerBlanketOrderItemDeliveryDate> listBlanketOrderItemDeliveryDate) throws Exception {
        try {
            customerBlanketOrderDAO.revise(blanketOrder, listBlanketOrderSalesQuotation,listBlanketOrderItemDetail,listBlanketOrderAdditionalFee,listBlanketOrderPaymentTerm,listBlanketOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(CustomerBlanketOrder blanketOrder) throws Exception{
        customerBlanketOrderDAO.delete(blanketOrder,MODULECODE);
    }
    
    public void closing(CustomerBlanketOrder blanketOrderClosing) throws Exception {
        try {
            customerBlanketOrderDAO.closing(blanketOrderClosing, MODULECODE_CLOSING);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public String createCodeRevise(EnumActivity.ENUM_Activity enumActivity,CustomerBlanketOrder blanketOrder) throws Exception {
        try {
            return customerBlanketOrderDAO.createCodeRevise(enumActivity,blanketOrder);
        }
        catch (Exception e) {
            throw e;
        }
    }
}