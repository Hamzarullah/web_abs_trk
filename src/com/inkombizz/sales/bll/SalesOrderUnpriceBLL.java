package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.CustomerSalesOrderDAO;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerSalesOrderField;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetail;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotation;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class SalesOrderUnpriceBLL {
    
    public static final String MODULECODE = "002_SAL_SALES_ORDER_UNPRICE";
    
    private CustomerSalesOrderDAO salesOrderUnpriceDAO;
    
    public SalesOrderUnpriceBLL (HBMSession hbmSession){
        this.salesOrderUnpriceDAO = new CustomerSalesOrderDAO(hbmSession);
    }
    
    public ListPaging<CustomerSalesOrder> findData(Paging paging,CustomerSalesOrder salesOrderByCustomerPurchaseOrder) throws Exception {
        try {
                     
            //paging.setRecords(salesOrderUnpriceDAO.countData(salesOrderByCustomerPurchaseOrder));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
//            List<CustomerSalesOrder> listSalesOrderByCustomerPurchaseOrder = salesOrderUnpriceDAO.findData(salesOrderByCustomerPurchaseOrder,paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<CustomerSalesOrder> listPaging = new ListPaging<CustomerSalesOrder>();
//            
//            listPaging.setList(listSalesOrderByCustomerPurchaseOrder);
//            listPaging.setPaging(paging);
//            
//            return listPaging;  
        return null;
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
             
            if(salesOrderUnpriceDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderSalesQuotation> findDataSalesQuotation(String headerCode) throws Exception {
        try {
            
            //List<CustomerSalesOrderSalesQuotation> listSalesOrderByCustomerPurchaseOrderSalesQuotation = salesOrderUnpriceDAO.findDataSalesQuotation(headerCode);
            
//            return listSalesOrderByCustomerPurchaseOrderSalesQuotation;  
            return null;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderItemDetail> findDataItemDetail(String headerCode) throws Exception {
        try {
            
//            List<CustomerSalesOrderItemDetail> listSalesOrderByCustomerPurchaseOrderItemDetail = salesOrderUnpriceDAO.findDataItemDetail(headerCode);
            
//            return listSalesOrderByCustomerPurchaseOrderItemDetail;  
            return null;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderAdditionalFee> findDataAdditionalFee(String headerCode) throws Exception {
        try {
            
//            List<CustomerSalesOrderAdditionalFee> listSalesOrderByCustomerPurchaseOrderAdditionalFee = salesOrderUnpriceDAO.findDataAdditionalFee(headerCode);
            
//            return listSalesOrderByCustomerPurchaseOrderAdditionalFee;  
            return null;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderPaymentTerm> findDataPaymentTerm(String headerCode) throws Exception {
        try {
            
//            List<CustomerSalesOrderPaymentTerm> listSalesOrderByCustomerPurchaseOrderPaymentTerm = salesOrderUnpriceDAO.findDataPaymentTerm(headerCode);
            
//            return listSalesOrderByCustomerPurchaseOrderPaymentTerm;  
            return null;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerSalesOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) throws Exception {
        try {
            
//            List<CustomerSalesOrderItemDeliveryDate> listSalesOrderByCustomerPurchaseOrderItemDeliveryDate = salesOrderUnpriceDAO.findDataItemDeliveryDate(headerCode);
            
//            return listSalesOrderByCustomerPurchaseOrderItemDeliveryDate;  
            return null;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
}