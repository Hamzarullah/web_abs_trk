package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.CustomerSalesOrderDAO;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerSalesOrderField;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetail;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotation;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class CustomerSalesOrderBLL {
    
    public static final String MODULECODE = "002_SAL_CUSTOMER_SALES_ORDER";
    public static final String MODULECODE_CLOSING = "002_SAL_CUSTOMER_SALES_ORDER_CLOSING";
    public static final String MODULECODE_UNPRICE = "002_SAL_CUSTOMER_SALES_ORDER_UNPRICE";
    
    private CustomerSalesOrderDAO customerSalesOrderDAO;
    
    public CustomerSalesOrderBLL (HBMSession hbmSession){
        this.customerSalesOrderDAO = new CustomerSalesOrderDAO(hbmSession);
    }
    
    public ListPaging<CustomerSalesOrder> findData(Paging paging,CustomerSalesOrder customerSalesOrder, String validStatus) throws Exception {
        try {
                     
            paging.setRecords(customerSalesOrderDAO.countData(customerSalesOrder, validStatus));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerSalesOrder> listCustomerSalesOrder = customerSalesOrderDAO.findData(customerSalesOrder,validStatus,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerSalesOrder> listPaging = new ListPaging<CustomerSalesOrder>();
            
            listPaging.setList(listCustomerSalesOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerSalesOrder> findDataClosing(Paging paging,CustomerSalesOrder customerSalesOrder) throws Exception {
        try {
                     
            paging.setRecords(customerSalesOrderDAO.countDataClosing(customerSalesOrder));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerSalesOrder> listCustomerSalesOrder = customerSalesOrderDAO.findDataClosing(customerSalesOrder,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerSalesOrder> listPaging = new ListPaging<CustomerSalesOrder>();
            
            listPaging.setList(listCustomerSalesOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerSalesOrder> findDataUnprice(Paging paging,CustomerSalesOrder customerSalesOrder, String validStatus) throws Exception {
        try {
                     
            paging.setRecords(customerSalesOrderDAO.countDataUnprice(customerSalesOrder, validStatus));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerSalesOrder> listCustomerSalesOrder = customerSalesOrderDAO.findDataUnprice(customerSalesOrder,validStatus, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerSalesOrder> listPaging = new ListPaging<CustomerSalesOrder>();
            
            listPaging.setList(listCustomerSalesOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerSalesOrder> findSearchData(Paging paging,CustomerSalesOrder customerSalesOrder, Date fromDate,Date upToDate) throws Exception {
        try {
                     
            paging.setRecords(customerSalesOrderDAO.countSearchData(customerSalesOrder, fromDate, upToDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerSalesOrder> listCustomerSalesOrder = customerSalesOrderDAO.findSearchData(customerSalesOrder,fromDate, upToDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerSalesOrder> listPaging = new ListPaging<CustomerSalesOrder>();
            
            listPaging.setList(listCustomerSalesOrder);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerSalesOrder> findSearchDataLAD(Paging paging,CustomerSalesOrder customerSalesOrder, Date fromDate,Date upToDate) throws Exception {
        try {
                     
            paging.setRecords(customerSalesOrderDAO.countSearchDataLAD(customerSalesOrder, fromDate, upToDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerSalesOrder> listCustomerSalesOrder = customerSalesOrderDAO.findSearchDataLAD(customerSalesOrder,fromDate, upToDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerSalesOrder> listPaging = new ListPaging<CustomerSalesOrder>();
            
            listPaging.setList(listCustomerSalesOrder);
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
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerSalesOrder.class)
                            .add(Restrictions.eq(CustomerSalesOrderField.CODE, headerCode));
             
            if(customerSalesOrderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderSalesQuotation> findDataSalesQuotation(String headerCode) throws Exception {
        try {
            
            List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation = customerSalesOrderDAO.findDataSalesQuotation(headerCode);
            
            return listCustomerSalesOrderSalesQuotation;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode, String headerCode) throws Exception {
        try {
            
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail = customerSalesOrderDAO.findDataItemDetailArray(arrSalesQuotationCode, headerCode);
            
            return listCustomerSalesOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderItemDetail> findDataItemDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail = customerSalesOrderDAO.findDataItemDetail(headerCode);
            
            return listCustomerSalesOrderItemDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderAdditionalFee> findDataAdditionalFee(String headerCode) throws Exception {
        try {
            
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee = customerSalesOrderDAO.findDataAdditionalFee(headerCode);
            
            return listCustomerSalesOrderAdditionalFee;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderPaymentTerm> findDataPaymentTerm(String headerCode) throws Exception {
        try {
            
            List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm = customerSalesOrderDAO.findDataPaymentTerm(headerCode);
            
            return listCustomerSalesOrderPaymentTerm;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) throws Exception {
        try {
            
            List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate = customerSalesOrderDAO.findDataItemDeliveryDate(headerCode);
            
            return listCustomerSalesOrderItemDeliveryDate;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public CustomerSalesOrder totalAdditionalFeeAmount(String headerCode) throws Exception {
        try {
            return (CustomerSalesOrder) customerSalesOrderDAO.totalAdditionalFeeAmount(headerCode);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ListPaging<CustomerSalesOrderItemDetail> findDataforProductionPlanning(Paging paging, String code, String headerCode, String documentType) throws Exception {
        try {
            
            paging.setRecords(customerSalesOrderDAO.countDataforPp(code,headerCode,documentType));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail = customerSalesOrderDAO.findDataforPp(code,headerCode, documentType, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerSalesOrderItemDetail> listPaging = new ListPaging<CustomerSalesOrderItemDetail>();
            
            listPaging.setList(listCustomerSalesOrderItemDetail);
            listPaging.setPaging(paging);
            
            return listPaging;    
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerSalesOrder salesOrder,List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation, List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee,List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm,List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate) throws Exception {
        try {
            customerSalesOrderDAO.save(enumActivity,salesOrder, listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerSalesOrder salesOrder,List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation, List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee,List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm,List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate) throws Exception {
        try {
            customerSalesOrderDAO.update(salesOrder, listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void revise(CustomerSalesOrder salesOrder,List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation, List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee,List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm,List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate) throws Exception {
        try {
            customerSalesOrderDAO.revise(salesOrder, listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(CustomerSalesOrder salesOrder) throws Exception{
        customerSalesOrderDAO.delete(salesOrder,MODULECODE);
    }
    
    public void closing(CustomerSalesOrder salesOrderClosing) throws Exception {
        try {
            customerSalesOrderDAO.closing(salesOrderClosing, MODULECODE_CLOSING);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public String createCodeRevise(EnumActivity.ENUM_Activity enumActivity,CustomerSalesOrder salesOrder) throws Exception {
        try {
            return customerSalesOrderDAO.createCodeRevise(enumActivity,salesOrder);
        }
        catch (Exception e) {
            throw e;
        }
    }
}