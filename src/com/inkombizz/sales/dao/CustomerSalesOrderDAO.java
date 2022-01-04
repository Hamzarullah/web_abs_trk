
package com.inkombizz.sales.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonConst;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFeeField;
import com.inkombizz.sales.model.CustomerSalesOrderField;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDateField;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetail;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetailField;
import com.inkombizz.sales.model.CustomerSalesOrderMiss;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTermField;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotation;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotationField;
import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.utils.DateUtils;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class CustomerSalesOrderDAO {
    private HBMSession hbmSession;
    
    public CustomerSalesOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(CustomerSalesOrderMiss customerSalesOrder) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_sales_order_search_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+customerSalesOrder.getSalesOrderCode()+"%")
                .setParameter("prmCustomerCode","%"+customerSalesOrder.getSalesOrderCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+customerSalesOrder.getSalesOrderCustomerName()+"%")
                .setParameter("prmFirstDate", customerSalesOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", customerSalesOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrderMiss> findData(CustomerSalesOrderMiss customerSalesOrder, int from, int to) {
        try {
            
            List<CustomerSalesOrderMiss> list = (List<CustomerSalesOrderMiss>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_customer_sales_order_search_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING) 
                .addScalar("custSONo", Hibernate.STRING) 
                .addScalar("revision", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP) 
                .addScalar("customerCode", Hibernate.STRING) 
                .addScalar("customerName", Hibernate.STRING) 
                .addScalar("salesPersonCode", Hibernate.STRING) 
                .addScalar("salesPersonName", Hibernate.STRING) 
                .addScalar("refNo", Hibernate.STRING) 
                .addScalar("remark", Hibernate.STRING) 
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+customerSalesOrder.getSalesOrderCode()+"%")
                .setParameter("prmCustomerCode","%"+customerSalesOrder.getSalesOrderCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+customerSalesOrder.getSalesOrderCustomerName()+"%")
                .setParameter("prmFirstDate", customerSalesOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", customerSalesOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataforPp(String code, String headerCode,String documentType) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_order_search_document_detail_list(:prmFlag,:prmCode,:prmHeaderCode,:prmDocumentType,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmHeaderCode", headerCode)
                .setParameter("prmDocumentType", documentType)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrderItemDetail> findDataforPp(String code, String headerCode,String documentType, int from, int to) {
        try {
            
            List<CustomerSalesOrderItemDetail> list = (List<CustomerSalesOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_order_search_document_detail_list(:prmFlag,:prmCode,:prmHeaderCode,:prmDocumentType,:prmLimitFrom,:prmLimitTo)"
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("billOfMaterialCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("processedQty", Hibernate.BIG_DECIMAL)
                .addScalar("balancedQty", Hibernate.BIG_DECIMAL)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmHeaderCode", headerCode)
                .setParameter("prmDocumentType", documentType)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)    
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderItemDetail.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    //INI BACKUP DARI SalesOrderDAO
    public int countData(CustomerSalesOrder salesOrderByCustomerPurchaseOrder, String validStatus) {
        try {
            String closingStatus=salesOrderByCustomerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+salesOrderByCustomerPurchaseOrder.getClosingStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_sales_order_by_customer_purchase_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+salesOrderByCustomerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderByCustomerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderByCustomerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderByCustomerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderByCustomerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmValidStatus", validStatus)
                .setParameter("prmFirstDate", salesOrderByCustomerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderByCustomerPurchaseOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrder> findData(CustomerSalesOrder salesOrderByCustomerPurchaseOrder, String validStatus, int from, int to) {
        try {
            String closingStatus=salesOrderByCustomerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+salesOrderByCustomerPurchaseOrder.getClosingStatus() +"%";
            List<CustomerSalesOrder> list = (List<CustomerSalesOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_sales_order_by_customer_purchase_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custSONo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("revisionRemark", Hibernate.STRING)
                .addScalar("refCUSTSOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                  
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
                .addScalar("projectName", Hibernate.STRING)     
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("validStatusSo", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingDate", Hibernate.TIMESTAMP)
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+salesOrderByCustomerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderByCustomerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderByCustomerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderByCustomerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderByCustomerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmValidStatus", validStatus)
                .setParameter("prmFirstDate", salesOrderByCustomerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderByCustomerPurchaseOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataClosing(CustomerSalesOrder salesOrderByCustomerPurchaseOrder) {
        try {
            String closingStatus=salesOrderByCustomerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+salesOrderByCustomerPurchaseOrder.getClosingStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_sales_order_by_customer_purchase_order_list_closing(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+salesOrderByCustomerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderByCustomerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderByCustomerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderByCustomerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderByCustomerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmFirstDate", salesOrderByCustomerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderByCustomerPurchaseOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrder> findDataClosing(CustomerSalesOrder salesOrderByCustomerPurchaseOrder, int from, int to) {
        try {
            String closingStatus=salesOrderByCustomerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+salesOrderByCustomerPurchaseOrder.getClosingStatus() +"%";
            List<CustomerSalesOrder> list = (List<CustomerSalesOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_sales_order_by_customer_purchase_order_list_closing(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custSONo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("revisionRemark", Hibernate.STRING)
                .addScalar("refCUSTSOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                  
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
                .addScalar("projectName", Hibernate.STRING)     
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("validStatusSo", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingDate", Hibernate.TIMESTAMP)
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+salesOrderByCustomerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderByCustomerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderByCustomerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderByCustomerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderByCustomerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmFirstDate", salesOrderByCustomerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderByCustomerPurchaseOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataUnprice(CustomerSalesOrder salesOrderByCustomerPurchaseOrder, String validStatus) {
        try {
            String closingStatus=salesOrderByCustomerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+salesOrderByCustomerPurchaseOrder.getClosingStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_sales_order_by_customer_purchase_order_list_unprice(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+salesOrderByCustomerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderByCustomerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderByCustomerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderByCustomerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderByCustomerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmValidStatus", validStatus)    
                .setParameter("prmFirstDate", salesOrderByCustomerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderByCustomerPurchaseOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrder> findDataUnprice(CustomerSalesOrder salesOrderByCustomerPurchaseOrder, String validStatus, int from, int to) {
        try {
            String closingStatus=salesOrderByCustomerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+salesOrderByCustomerPurchaseOrder.getClosingStatus() +"%";
            List<CustomerSalesOrder> list = (List<CustomerSalesOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_sales_order_by_customer_purchase_order_list_unprice(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custSONo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("revisionRemark", Hibernate.STRING)
                .addScalar("refCUSTSOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                  
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
                .addScalar("projectName", Hibernate.STRING)     
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("validStatusSo", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingDate", Hibernate.TIMESTAMP)
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+salesOrderByCustomerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderByCustomerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderByCustomerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderByCustomerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderByCustomerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmValidStatus", validStatus)   
                .setParameter("prmFirstDate", salesOrderByCustomerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderByCustomerPurchaseOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countSearchData(CustomerSalesOrder salesOrder, Date firstDate,Date lastDate) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_sales_order_search_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmEndUserCode,:prmEndUserName,:prmSalesPersonCode,:prmSalesPersonName,"
                    + ":prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+salesOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrder.getCustomerName()+"%")
                .setParameter("prmEndUserCode","%"+salesOrder.getEndUserCode() +"%")
                .setParameter("prmEndUserName","%"+salesOrder.getEndUserName()+"%")
                .setParameter("prmSalesPersonCode","%"+salesOrder.getSalesPersonCode() +"%")
                .setParameter("prmSalesPersonName","%"+salesOrder.getSalesPersonName()+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrder> findSearchData(CustomerSalesOrder salesOrder,Date firstDate,Date lastDate, int from, int to) {
        try {
            
            List<CustomerSalesOrder> list = (List<CustomerSalesOrder>)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_sales_order_search_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmEndUserCode,:prmEndUserName,:prmSalesPersonCode,:prmSalesPersonName,"
                    + ":prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("blanketOrderCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                  
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("refNo", Hibernate.STRING)    
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+salesOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrder.getCustomerName()+"%")
                .setParameter("prmEndUserCode","%"+salesOrder.getEndUserCode() +"%")
                .setParameter("prmEndUserName","%"+salesOrder.getEndUserName()+"%")
                .setParameter("prmSalesPersonCode","%"+salesOrder.getSalesPersonCode() +"%")
                .setParameter("prmSalesPersonName","%"+salesOrder.getSalesPersonName()+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    //LAD
    public int countSearchDataLAD(CustomerSalesOrder salesOrder, Date firstDate,Date lastDate) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_sales_order_search_lad(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmEndUserCode,:prmEndUserName,:prmSalesPersonCode,:prmSalesPersonName,"
                    + ":prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+salesOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrder.getCustomerName()+"%")
                .setParameter("prmEndUserCode","%"+salesOrder.getEndUserCode() +"%")
                .setParameter("prmEndUserName","%"+salesOrder.getEndUserName()+"%")
                .setParameter("prmSalesPersonCode","%"+salesOrder.getSalesPersonCode() +"%")
                .setParameter("prmSalesPersonName","%"+salesOrder.getSalesPersonName()+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrder> findSearchDataLAD(CustomerSalesOrder salesOrder,Date firstDate,Date lastDate, int from, int to) {
        try {
            
            List<CustomerSalesOrder> list = (List<CustomerSalesOrder>)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_sales_order_search_lad(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmEndUserCode,:prmEndUserName,:prmSalesPersonCode,:prmSalesPersonName,"
                    + ":prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("blanketOrderCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                  
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+salesOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrder.getCustomerName()+"%")
                .setParameter("prmEndUserCode","%"+salesOrder.getEndUserCode() +"%")
                .setParameter("prmEndUserName","%"+salesOrder.getEndUserName()+"%")
                .setParameter("prmSalesPersonCode","%"+salesOrder.getSalesPersonCode() +"%")
                .setParameter("prmSalesPersonName","%"+salesOrder.getSalesPersonName()+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderSalesQuotation> findDataSalesQuotation(String headerCode) {
        try {
            
            List<CustomerSalesOrderSalesQuotation> list = (List<CustomerSalesOrderSalesQuotation>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "sal_customer_sales_order_jn_sales_quotation.SalesQuotationCode AS SalesQuotationCode, "
                + "sal_sales_quotation.TransactionDate AS SalesQuotationTransactionDate, "
                + "mst_customer.Code AS salesQuotationCustomerCode, "
                + "mst_customer.Name AS salesQuotationCustomerName, "
                + "sal_sales_quotation.EndUserCode AS salesQuotationEndUserCode, "
                + "endUser.Name AS salesQuotationEndUserName, "
                + "sal_sales_quotation.subject AS salesQuotationSubject, "
                + "sal_sales_quotation.RFQCode AS salesQuotationRfqCode, "
                + "sal_sales_quotation.ProjectCode AS salesQuotationProject, "
                + "sal_sales_quotation.Attn AS salesQuotationAttn, "
                + "sal_sales_quotation.RefNo AS salesQuotationRefNo, "
                + "sal_sales_quotation.Remark AS salesQuotationRemark "
                    + "FROM sal_customer_sales_order_jn_sales_quotation "
                + "INNER JOIN "
                    + "sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_sales_order_jn_sales_quotation.SalesQuotationCode "
                + "INNER JOIN "
                    + "mst_customer ON mst_customer.Code = sal_sales_quotation.CustomerCode "
                + "INNER JOIN "
                    + "mst_customer endUser ON sal_sales_quotation.EndUserCode = endUser.Code "
                + "WHERE sal_customer_sales_order_jn_sales_quotation.HeaderCode=:prmHeaderCode"
            )
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("SalesQuotationTransactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesQuotationCustomerCode", Hibernate.STRING)
                .addScalar("salesQuotationCustomerName", Hibernate.STRING)
                .addScalar("salesQuotationRfqCode", Hibernate.STRING)
                .addScalar("salesQuotationProject", Hibernate.STRING)
                .addScalar("salesQuotationAttn", Hibernate.STRING)
                .addScalar("salesQuotationRefNo", Hibernate.STRING)
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationEndUserCode", Hibernate.STRING)
                .addScalar("salesQuotationEndUserName", Hibernate.STRING)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderSalesQuotation.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderItemDetail> findDataItemDetail(String headerCode) {
        try {
            
            List<CustomerSalesOrderItemDetail> list = (List<CustomerSalesOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_sales_order_item_detail.SalesQuotationCode, "
                + " sal_customer_sales_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_sales_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_sales_order_item_detail.Code,"
                + "'' AS customerSalesOrderItemDetailCode, "
                + " sal_customer_sales_order_item_detail.salesQuotationDetailCode,"
                + "'' AS salesQuotationDetailCode, "
                + " sal_customer_sales_order_item_detail.ItemAlias AS itemAlias, "
                
                + " sal_sales_quotation_detail.ValveTypeCode, "
                + " mst_valve_type.Name AS ValveTypeName, "
                + " sal_sales_quotation_detail.ValveTag, "
                + "sal_sales_quotation_detail.dataSheet, "
                + "sal_sales_quotation_detail.description, "
                
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.Size, "
                + "sal_sales_quotation_detail.Rating, "
                + "sal_sales_quotation_detail.Bore, "
                
                + "sal_sales_quotation_detail.EndCon, "
                + "sal_sales_quotation_detail.Body, "
                + "sal_sales_quotation_detail.Ball, "
                + "sal_sales_quotation_detail.Seat, "
                + "sal_sales_quotation_detail.SeatInsert, "
                + "sal_sales_quotation_detail.Stem, "
                        
                + "sal_sales_quotation_detail.Seal, "
                + "sal_sales_quotation_detail.Bolting, "
                + "sal_sales_quotation_detail.Disc, "
                + "sal_sales_quotation_detail.Plates, "
                + "sal_sales_quotation_detail.Shaft, "
                + "sal_sales_quotation_detail.Spring, "
                        
                + "sal_sales_quotation_detail.ArmPin, "
                + "sal_sales_quotation_detail.Backseat, "
                + "sal_sales_quotation_detail.Arm, "
                + "sal_sales_quotation_detail.HingePin, "
                + "sal_sales_quotation_detail.StopPin, "
                + "sal_sales_quotation_detail.Oper AS operator, "
                
                + " sal_sales_quotation_detail.Note, "
                + " sal_sales_quotation_detail.Quantity, "
                + " sal_sales_quotation_detail.UnitPrice, "
                + " sal_sales_quotation_detail.TotalAmount, "
                
                //FinishGoodQuotation
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode, "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName, "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode, "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode, "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName, "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, "
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName, "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode, "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, "
                
                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode, "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode, "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName, "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, "
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode, "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode, "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName, "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode, "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName, "
                
                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode, "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName, "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode, "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName, "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode, "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName, "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode, "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName, "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode, "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName, "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode, "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName, "
                
                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName, "

                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode, "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName, "

                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName, "

                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode, "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName, "

                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode, "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName, "

                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode, "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName "
                
                + " FROM "
                + " sal_customer_sales_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_sales_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_sales_order_item_detail.SalesQuotationDetailCode "
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_sales_quotation_detail.ValveTypeCode "
                //join Finish Goods
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode "
                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode "
                    
                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode "
                        
                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode "
                        
                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                
                + " WHERE sal_customer_sales_order_item_detail.HeaderCode =:prmHeaderCode "
            )

                .addScalar("customerSalesOrderItemDetailCode", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                    
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                    
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                    
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                    
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("backSeat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("StopPin", Hibernate.STRING)
                .addScalar("operator", Hibernate.STRING)
                    
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                    
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                    
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode, String headerCode) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationCode.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            List<CustomerSalesOrderItemDetail> list = (List<CustomerSalesOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_sales_order_item_detail.SalesQuotationCode, "
                + " sal_customer_sales_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_sales_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_sales_order_item_detail.Code, "
                + " sal_customer_sales_order_item_detail.salesQuotationDetailCode, "
                + " sal_customer_sales_order_item_detail.ItemAlias AS itemAlias, "
                + " sal_sales_quotation.refNo, "
                + " sal_customer_sales_order_item_detail.ValveTag, "
                + " sal_customer_sales_order_item_detail.dataSheet, "
                + " sal_customer_sales_order_item_detail.description, "        
                
                + " sal_sales_quotation_detail.ValveTypeCode, "
                + " mst_valve_type.Name AS ValveTypeName, "
                
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.Size, "
                + "sal_sales_quotation_detail.Rating, "
                + "sal_sales_quotation_detail.Bore, "
                
                + "sal_sales_quotation_detail.EndCon, "
                + "sal_sales_quotation_detail.Body, "
                + "sal_sales_quotation_detail.Ball, "
                + "sal_sales_quotation_detail.Seat, "
                + "sal_sales_quotation_detail.SeatInsert, "
                + "sal_sales_quotation_detail.Stem, "
                        
                + "sal_sales_quotation_detail.Seal, "
                + "sal_sales_quotation_detail.Bolting, "
                + "sal_sales_quotation_detail.Disc, "
                + "sal_sales_quotation_detail.Plates, "
                + "sal_sales_quotation_detail.Shaft, "
                + "sal_sales_quotation_detail.Spring, "
                        
                + "sal_sales_quotation_detail.ArmPin, "
                + "sal_sales_quotation_detail.Backseat, "
                + "sal_sales_quotation_detail.Arm, "
                + "sal_sales_quotation_detail.HingePin, "
                + "sal_sales_quotation_detail.StopPin, "
                + "sal_sales_quotation_detail.Oper AS operator, "
                
                + " sal_sales_quotation_detail.Note, "
                + " sal_sales_quotation_detail.Quantity, "
                + " sal_sales_quotation_detail.UnitPrice, "
                + " sal_sales_quotation_detail.TotalAmount, "
                
                //FinishGoodQuotation
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode, "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName, "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode, "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode, "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName, "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, "
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName, "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode, "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, "
                
                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode, "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode, "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName, "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, "
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode, "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode, "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName, "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode, "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName, "
                
                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode, "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName, "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode, "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName, "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode, "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName, "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode, "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName, "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode, "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName, "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode, "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName, "
                
                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName, "

                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode, "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName, "

                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName, "

                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode, "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName, "

                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode, "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName, "

                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode, "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName "
                
                + " FROM "
                + " sal_customer_sales_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_sales_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_sales_order_item_detail.SalesQuotationDetailCode "
                + " INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_sales_quotation_detail.HeaderCode "
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_sales_quotation_detail.ValveTypeCode "
                //join Finish Goods
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode "
                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode "
                    
                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode "
                        
                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode "
                        
                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                
                + " WHERE sal_customer_sales_order_item_detail.SalesQuotationCode IN ('"+strSalesQuotationNo+"')"
                + " AND sal_customer_sales_order_item_detail.HeaderCode =:prmHeaderCode"    
            )

                .addScalar("code", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                    
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                    
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                    
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                    
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("backSeat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("StopPin", Hibernate.STRING)
                .addScalar("operator", Hibernate.STRING)
                    
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                    
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)   
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderAdditionalFee> findDataAdditionalFee(String headerCode) {
        try {
            
            List<CustomerSalesOrderAdditionalFee> list = (List<CustomerSalesOrderAdditionalFee>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_additional_fee.Remark, " +
                "	sal_customer_sales_order_additional_fee.Quantity, " +
                "	sal_customer_sales_order_additional_fee.AdditionalFeeCode, " +
                "	mst_additional_fee.Name AS additionalFeeName, " +
                "	mst_additional_fee.SalesChartOfAccountCode AS coaCode, " +
                "	mst_chart_of_account.name AS coaName, " +
                "	sal_customer_sales_order_additional_fee.UnitCode AS unitOfMeasureCode, " +
                "	sal_customer_sales_order_additional_fee.Price, " +
                "	sal_customer_sales_order_additional_fee.Total " +
                "FROM sal_customer_sales_order_additional_fee " +
                "INNER JOIN  mst_additional_fee ON mst_additional_fee.Code = sal_customer_sales_order_additional_fee.AdditionalFeeCode " +        
                "INNER JOIN  mst_chart_of_account ON mst_chart_of_account.Code = mst_additional_fee.SalesChartOfAccountCode " +        
                "WHERE sal_customer_sales_order_additional_fee.HeaderCode=:prmHeaderCode")

                .addScalar("remark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("additionalFeeCode", Hibernate.STRING)
                .addScalar("additionalFeeName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("coaCode", Hibernate.STRING)
                .addScalar("coaName", Hibernate.STRING)    
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderAdditionalFee.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderPaymentTerm> findDataPaymentTerm(String headerCode) {
        try {
            
            List<CustomerSalesOrderPaymentTerm> list = (List<CustomerSalesOrderPaymentTerm>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_payment_term.SortNo, " +
                "	sal_customer_sales_order_payment_term.PaymentTermCode, " +
                        "mst_payment_term.Name AS paymentTermName, " +
                "	sal_customer_sales_order_payment_term.Percentage, " +
                "	sal_customer_sales_order_payment_term.Remark " +
                "FROM sal_customer_sales_order_payment_term " +
                "INNER JOIN mst_payment_term ON sal_customer_sales_order_payment_term.PaymentTermCode=mst_payment_term.Code " +
                "WHERE sal_customer_sales_order_payment_term.HeaderCode=:prmHeaderCode")

                .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("percentage", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderPaymentTerm.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) {
        try {
            
            List<CustomerSalesOrderItemDeliveryDate> list = (List<CustomerSalesOrderItemDeliveryDate>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_item_delivery_date.Code, " +
                "	sal_customer_sales_order_item_delivery_date.ItemFinishGoodsCode AS itemFinishGoodsCode, " +
                "	mst_item_finish_goods.Remark AS itemFinishGoodsRemark, " +
                "	sal_customer_sales_order_item_delivery_date.Quantity, " +
                "	sal_customer_sales_order_item_delivery_date.DeliveryDate, " +
                "	sal_customer_sales_order_item_delivery_date.SalesQuotationCode AS salesQuotationCode, " +
                "	sal_customer_sales_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, " +
                "	sal_sales_quotation.RefNo " +
                "FROM sal_customer_sales_order_item_delivery_date " +       
                "INNER JOIN sal_customer_sales_order_item_detail ON sal_customer_sales_order_item_delivery_date.Code = sal_customer_sales_order_item_detail.Code " +       
                "INNER JOIN mst_item_finish_goods ON sal_customer_sales_order_item_delivery_date.ItemFinishGoodsCode = mst_item_finish_goods.Code " +             
                "INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_sales_order_item_detail.SalesQuotationCode " +             
                "WHERE sal_customer_sales_order_item_delivery_date.HeaderCode=:prmHeaderCode "+
                "ORDER BY sal_customer_sales_order_item_delivery_date.Code")

                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("deliveryDate", Hibernate.DATE)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)    
                .setParameter("prmHeaderCode", headerCode)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderItemDeliveryDate.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerSalesOrder get(String code) {
        try {
               return (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
   
    public CustomerSalesOrder getFromWoForRevise(String code){
        try {
            CustomerSalesOrder salesOrder = (CustomerSalesOrder)hbmSession.hSession.createSQLQuery(
                "SELECT "
                    + " sal_customer_sales_order.Code, "
                    + " sal_customer_sales_order.CUSTSONo AS custSONo, "
                    + " sal_customer_sales_order.Revision, "
                    + " sal_customer_sales_order.RefCUSTSOCode, "
                    + " sal_customer_sales_order.ValidStatus, "
                    + " sal_customer_sales_order.TransactionDate, "
                    + " sal_customer_sales_order.CustomerPurchaseOrderCode, "
                    + " sal_customer_sales_order.BranchCode, "
                    + " sal_customer_sales_order.RequestDeliveryDate, "
                    + " sal_customer_sales_order.ExpiredDate, "
                    + " sal_customer_sales_order.CustomerCode, "
                    + " sal_customer_sales_order.EndUserCode, "
                    + " sal_customer_sales_order.CurrencyCode, "
                    + " sal_customer_sales_order.SalesPersonCode, "
                    + " sal_customer_sales_order.ProjectCode, "
                    + " sal_customer_sales_order.RefNo, "
                    + " sal_customer_sales_order.Remark, "
                    + " sal_customer_sales_order.RevisionRemark, "
                    + " sal_customer_sales_order.TotalTransactionAmount, "
                    + " sal_customer_sales_order.DiscountPercent, "
                    + " sal_customer_sales_order.DiscountAmount, "
                    + " sal_customer_sales_order.TaxBaseAmount, "
                    + " sal_customer_sales_order.Vatpercent, "
                    + " sal_customer_sales_order.Vatamount, "
                    + " sal_customer_sales_order.GrandTotalAmount, "
                    + " sal_customer_sales_order.ApprovalRemark "
                + " FROM "
                    + " sal_customer_sales_order "
                + " WHERE "
                    + " sal_customer_sales_order.CustomerPurchaseOrderCode = '"+ code +"' "
                    + " AND sal_customer_sales_order.ValidStatus = TRUE "
                    )
                .addScalar("code", Hibernate.STRING)
                .addScalar("custSONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .uniqueResult(); 
                 
                return salesOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerSalesOrder getFromWoForReviseNew(String code){
        try {
            CustomerSalesOrder salesOrder = (CustomerSalesOrder)hbmSession.hSession.createSQLQuery(
                "SELECT "
                    + " sal_customer_sales_order.Code, "
                    + " sal_customer_sales_order.CUSTSONo AS custSONo, "
                    + " sal_customer_sales_order.Revision, "
                    + " sal_customer_sales_order.RefCUSTSOCode, "
                    + " sal_customer_sales_order.ValidStatus, "
                    + " sal_customer_sales_order.TransactionDate, "
                    + " sal_customer_sales_order.CustomerPurchaseOrderCode, "
                    + " sal_customer_sales_order.BranchCode, "
                    + " sal_customer_sales_order.RequestDeliveryDate, "
                    + " sal_customer_sales_order.ExpiredDate, "
                    + " sal_customer_sales_order.CustomerCode, "
                    + " sal_customer_sales_order.EndUserCode, "
                    + " sal_customer_sales_order.CurrencyCode, "
                    + " sal_customer_sales_order.SalesPersonCode, "
                    + " sal_customer_sales_order.ProjectCode, "
                    + " sal_customer_sales_order.RefNo, "
                    + " sal_customer_sales_order.Remark, "
                    + " sal_customer_sales_order.RevisionRemark, "
                    + " sal_customer_sales_order.TotalTransactionAmount, "
                    + " sal_customer_sales_order.DiscountPercent, "
                    + " sal_customer_sales_order.DiscountAmount, "
                    + " sal_customer_sales_order.TaxBaseAmount, "
                    + " sal_customer_sales_order.Vatpercent, "
                    + " sal_customer_sales_order.Vatamount, "
                    + " sal_customer_sales_order.GrandTotalAmount, "
                    + " sal_customer_sales_order.ApprovalRemark "
                + " FROM "
                    + " sal_customer_sales_order "
                + " WHERE "
                    + " sal_customer_sales_order.CustomerPurchaseOrderCode = '"+ code +"' "
                    + " AND sal_customer_sales_order.ValidStatus = TRUE "
                    )
                .addScalar("code", Hibernate.STRING)
                .addScalar("refCUSTSOCode", Hibernate.STRING)
                .addScalar("custSONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .uniqueResult(); 
                 
                return salesOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerSalesOrder getSalesOrderUpdate(String code){
        try {
            CustomerSalesOrder salesOrder = (CustomerSalesOrder)hbmSession.hSession.createSQLQuery(
                "SELECT "
                    + " sal_customer_sales_order.Code, "
                    + " sal_customer_sales_order.CUSTSONo AS custSONo, "
                    + " sal_customer_sales_order.Revision, "
                    + " sal_customer_sales_order.RefCUSTSOCode, "
                    + " sal_customer_sales_order.ValidStatus, "
                    + " sal_customer_sales_order.TransactionDate, "
                    + " sal_customer_sales_order.CustomerPurchaseOrderCode, "
                    + " sal_customer_sales_order.BranchCode, "
                    + " sal_customer_sales_order.RequestDeliveryDate, "
                    + " sal_customer_sales_order.ExpiredDate, "
                    + " sal_customer_sales_order.CustomerCode, "
                    + " sal_customer_sales_order.EndUserCode, "
                    + " sal_customer_sales_order.CurrencyCode, "
                    + " sal_customer_sales_order.SalesPersonCode, "
                    + " sal_customer_sales_order.ProjectCode, "
                    + " sal_customer_sales_order.RefNo, "
                    + " sal_customer_sales_order.Remark, "
                    + " sal_customer_sales_order.RevisionRemark, "
                    + " sal_customer_sales_order.TotalTransactionAmount, "
                    + " sal_customer_sales_order.DiscountPercent, "
                    + " sal_customer_sales_order.DiscountAmount, "
                    + " sal_customer_sales_order.TaxBaseAmount, "
                    + " sal_customer_sales_order.Vatpercent, "
                    + " sal_customer_sales_order.Vatamount, "
                    + " sal_customer_sales_order.GrandTotalAmount, "
                    + " sal_customer_sales_order.ApprovalRemark "
                + " FROM "
                    + " sal_customer_sales_order "
                + " WHERE "
                    + " sal_customer_sales_order.Code = '"+ code +"' "
                    )
                .addScalar("code", Hibernate.STRING)
                .addScalar("custSONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .uniqueResult(); 
                 
                return salesOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerSalesOrder totalAdditionalFeeAmount(String headerCode){
       try {   
            CustomerSalesOrder salesOrderByCustomerPurchaseOrder = (CustomerSalesOrder)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_by_purchase_order.TotalTransactionAmount, " +
                "	sal_customer_sales_order_by_purchase_order.DiscountPercent, " +
                "	sal_customer_sales_order_by_purchase_order.DiscountAmount, " +
                "	fn_getAdditionalFee(sal_customer_sales_order_by_purchase_order.Code,'SODPOC') AS totalAdditionalFeeAmount, " +
                "	sal_customer_sales_order_by_purchase_order.TaxBaseAmount, " +
                "	sal_customer_sales_order_by_purchase_order.Vatpercent, " +
                "	sal_customer_sales_order_by_purchase_order.Vatamount, " +
                "	sal_customer_sales_order_by_purchase_order.GrandTotalAmount " +
                "FROM sal_customer_sales_order_by_purchase_order " +
                "WHERE sal_customer_sales_order_by_purchase_order.Code=:prmHeaderCode")
                    
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .uniqueResult(); 
                 
                return salesOrderByCustomerPurchaseOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity, CustomerSalesOrder salesOrder){
        try{           
            
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                acronim = "/SO/"+AutoNumber.getYear(salesOrder.getTransactionDate(), true);
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_4;
            }
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                acronim = salesOrder.getCustSONo() + splitter;
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_2;
            }

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerSalesOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%" + acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)|| enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                            oldID = list.get(0).toString().split("["+splitter+"]",2)[0];
                        }
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_revNew(enumActivity, transactionLength, acronim, oldID);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public String createCodeRevise(EnumActivity.ENUM_Activity enumActivity, CustomerSalesOrder salesOrder){
        try{           
            
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                acronim = salesOrder.getCode().split("[.]")[0]+".";
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_2;
            }

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerSalesOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%" + acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_rev(enumActivity, acronim, oldID, transactionLength);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public String createCodeSo(EnumActivity.ENUM_Activity enumActivity, CustomerPurchaseOrder customerPurchaseOrder){
        try{           
            
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                acronim = "/SO/"+AutoNumber.getYear(customerPurchaseOrder.getTransactionDate(), true);
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_4;
            }
           
            DetachedCriteria dc = DetachedCriteria.forClass(CustomerSalesOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%" +acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

           String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)|| enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                            oldID = list.get(0).toString().split("["+splitter+"]",2)[0];
                        }
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_revNew(enumActivity,transactionLength, acronim, oldID);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerSalesOrder salesOrderByCustomerPurchaseOrder,
            List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation, 
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee,
            List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm,
            List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(enumActivity,salesOrderByCustomerPurchaseOrder);
            
            hbmSession.hSession.beginTransaction();
            
            salesOrderByCustomerPurchaseOrder.setCode(headerCode);
            salesOrderByCustomerPurchaseOrder.setApprovalStatus("PENDING");
            salesOrderByCustomerPurchaseOrder.setClosingStatus("OPEN");
            salesOrderByCustomerPurchaseOrder.setCustSONo(salesOrderByCustomerPurchaseOrder.getCode().split("["+CommonConst.spliterNo+"]")[0]);
            salesOrderByCustomerPurchaseOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            salesOrderByCustomerPurchaseOrder.setCreatedDate(new Date());
            
            hbmSession.hSession.save(salesOrderByCustomerPurchaseOrder);
            
            
            if (!processDetail(EnumActivity.ENUM_Activity.NEW, 
                    salesOrderByCustomerPurchaseOrder,listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,
                    listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    salesOrderByCustomerPurchaseOrder.getCode(),EnumActivity.toString(enumActivity)));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();           
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
  
    public void update(CustomerSalesOrder salesOrderByCustomerPurchaseOrder,
            List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation, 
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee,
            List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm,
            List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            salesOrderByCustomerPurchaseOrder.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            salesOrderByCustomerPurchaseOrder.setUpdatedDate(new Date());
                        
            hbmSession.hSession.update(salesOrderByCustomerPurchaseOrder);
            
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    salesOrderByCustomerPurchaseOrder,listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,
                    listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
                        
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    salesOrderByCustomerPurchaseOrder.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.UPDATE)));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
    
    public void revise(CustomerSalesOrder customerSalesOrder,
            List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation, 
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee,
            List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm,
            List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.beginTransaction();
            
            Boolean validStatus = false;
            
            String customerSalesOrderCode= customerSalesOrder.getRefCUSTSOCode();
            CustomerSalesOrder customerSalesOrderOld = get(customerSalesOrderCode);
            customerSalesOrderOld.setValidStatus(validStatus);
            hbmSession.hSession.update(customerSalesOrderOld);
  
            hbmSession.hSession.flush();
            
            customerSalesOrder.setRefCUSTSOCode(customerSalesOrderOld.getCode());
            String headerCode=createCodeRevise(EnumActivity.ENUM_Activity.REVISE,customerSalesOrder);
            customerSalesOrder.setCode(headerCode);
            customerSalesOrder.setRevision(customerSalesOrder.getCode().substring(customerSalesOrder.getCode().length()-2));
            customerSalesOrder.setOrderType(customerSalesOrderOld.getOrderType());
            customerSalesOrder.setCustomerBlanketOrder(customerSalesOrderOld.getCustomerBlanketOrder());
            
            hbmSession.hSession.save(customerSalesOrder);
            
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    customerSalesOrder,listCustomerSalesOrderSalesQuotation,listCustomerSalesOrderItemDetail,
                    listCustomerSalesOrderAdditionalFee,listCustomerSalesOrderPaymentTerm,listCustomerSalesOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerSalesOrder.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.REVISE)));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();                      
        }
        catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }

    public void delete(CustomerSalesOrder salesOrderByCustomerPurchaseOrder, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            if (!processDetail(EnumActivity.ENUM_Activity.DELETE, salesOrderByCustomerPurchaseOrder,null,null,null,null,null)) {
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM " + CustomerSalesOrderField.BEAN_NAME
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", salesOrderByCustomerPurchaseOrder.getCode())
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    salesOrderByCustomerPurchaseOrder.getCode(), EnumActivity.toString(EnumActivity.ENUM_Activity.DELETE)));
            
            hbmSession.hTransaction.commit();
            
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
        finally{
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
        }
    }
       
    private boolean processDetail(EnumActivity.ENUM_Activity enumActivity, CustomerSalesOrder salesOrderByCustomerPurchaseOrder,
            List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderSalesQuotation, 
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderAdditionalFee,
            List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderPaymentTerm,
            List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderItemDeliveryDate){
        try{
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderSalesQuotationField.BEAN_NAME+" WHERE "+CustomerSalesOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", salesOrderByCustomerPurchaseOrder.getCode())    
                    .executeUpdate();
            
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderItemDetailField.BEAN_NAME+" WHERE "+CustomerSalesOrderItemDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrderByCustomerPurchaseOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderAdditionalFeeField.BEAN_NAME+" WHERE "+CustomerSalesOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrderByCustomerPurchaseOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderPaymentTermField.BEAN_NAME+" WHERE "+CustomerSalesOrderPaymentTermField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrderByCustomerPurchaseOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+CustomerSalesOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrderByCustomerPurchaseOrder.getCode())    
                        .executeUpdate();
            }
            
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int q = 1;
                for(CustomerSalesOrderSalesQuotation salesOrderByCustomerPurchaseOrderSalesQuotation : listCustomerSalesOrderSalesQuotation){

                    String detailCode = salesOrderByCustomerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderByCustomerPurchaseOrderSalesQuotation.setCode(detailCode);
                    salesOrderByCustomerPurchaseOrderSalesQuotation.setHeaderCode(salesOrderByCustomerPurchaseOrder.getCode());

                    salesOrderByCustomerPurchaseOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderByCustomerPurchaseOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderByCustomerPurchaseOrderSalesQuotation);

                    q++;
                }

                int i = 1;
                for(CustomerSalesOrderItemDetail salesOrderByCustomerPurchaseOrderItemDetail : listCustomerSalesOrderItemDetail){

                    String detailCode = salesOrderByCustomerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderByCustomerPurchaseOrderItemDetail.setCode(detailCode);
                    salesOrderByCustomerPurchaseOrderItemDetail.setHeaderCode(salesOrderByCustomerPurchaseOrder.getCode());

                    salesOrderByCustomerPurchaseOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderByCustomerPurchaseOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderByCustomerPurchaseOrderItemDetail);

                    i++;
                }

                int f = 1;
                for(CustomerSalesOrderAdditionalFee salesOrderByCustomerPurchaseOrderAdditionalFee : listCustomerSalesOrderAdditionalFee){

                    String detailCode = salesOrderByCustomerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderByCustomerPurchaseOrderAdditionalFee.setCode(detailCode);
                    salesOrderByCustomerPurchaseOrderAdditionalFee.setHeaderCode(salesOrderByCustomerPurchaseOrder.getCode());

                    salesOrderByCustomerPurchaseOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderByCustomerPurchaseOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderByCustomerPurchaseOrderAdditionalFee);

                    f++;
                }

                int p = 1;
                for(CustomerSalesOrderPaymentTerm salesOrderByCustomerPurchaseOrderPaymentTerm : listCustomerSalesOrderPaymentTerm){

                    String detailCode = salesOrderByCustomerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderByCustomerPurchaseOrderPaymentTerm.setCode(detailCode);
                    salesOrderByCustomerPurchaseOrderPaymentTerm.setHeaderCode(salesOrderByCustomerPurchaseOrder.getCode());

                    salesOrderByCustomerPurchaseOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderByCustomerPurchaseOrderPaymentTerm.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderByCustomerPurchaseOrderPaymentTerm);

                    p++;
                }

                int d = 1;
                for(CustomerSalesOrderItemDeliveryDate salesOrderByCustomerPurchaseOrderItemDeliveryDate : listCustomerSalesOrderItemDeliveryDate){

                    String detailCode = salesOrderByCustomerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderByCustomerPurchaseOrderItemDeliveryDate.setCode(detailCode);
                    salesOrderByCustomerPurchaseOrderItemDeliveryDate.setHeaderCode(salesOrderByCustomerPurchaseOrder.getCode());

                    salesOrderByCustomerPurchaseOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderByCustomerPurchaseOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderByCustomerPurchaseOrderItemDeliveryDate);

                    d++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void approval(CustomerSalesOrder salesOrderByCustomerPurchaseOrderApproval, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            CustomerSalesOrder salesOrderByCustomerPurchaseOrder=get(salesOrderByCustomerPurchaseOrderApproval.getCode());
            
            String approvalBy="";
            Date approvalDate=DateUtils.newDate(1900, 1, 1);
            
            if(salesOrderByCustomerPurchaseOrderApproval.getApprovalStatus().equalsIgnoreCase(EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED))){
                
                approvalBy=BaseSession.loadProgramSession().getUserName();
                approvalDate=new Date();
                salesOrderByCustomerPurchaseOrder.setApprovalReason(salesOrderByCustomerPurchaseOrderApproval.getApprovalReason());
                salesOrderByCustomerPurchaseOrder.setApprovalRemark(salesOrderByCustomerPurchaseOrderApproval.getApprovalRemark());
            }else{
                salesOrderByCustomerPurchaseOrder.setApprovalReason(null);
                salesOrderByCustomerPurchaseOrder.setApprovalRemark("");
            }
            
            salesOrderByCustomerPurchaseOrder.setApprovalStatus(salesOrderByCustomerPurchaseOrderApproval.getApprovalStatus());
            salesOrderByCustomerPurchaseOrder.setApprovalBy(approvalBy);
            salesOrderByCustomerPurchaseOrder.setApprovalDate(approvalDate);
                
            hbmSession.hSession.update(salesOrderByCustomerPurchaseOrder);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    salesOrderByCustomerPurchaseOrderApproval.getApprovalStatus() , 
                                                                    salesOrderByCustomerPurchaseOrderApproval.getCode(),""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();           
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
    
    public void closing(CustomerSalesOrder salesOrderByCustomerPurchaseOrderClosing, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            CustomerSalesOrder salesOrderByCustomerPurchaseOrder=get(salesOrderByCustomerPurchaseOrderClosing.getCode());
            
            salesOrderByCustomerPurchaseOrder.setClosingStatus("CLOSED");
            salesOrderByCustomerPurchaseOrder.setClosingBy(BaseSession.loadProgramSession().getUserName());
            salesOrderByCustomerPurchaseOrder.setClosingDate(new Date());
            
            hbmSession.hSession.createQuery("UPDATE CustomerPurchaseOrder SET "
                    + "ClosingStatus = :prmClosingStatus, "
                    + "ClosingDate = :prmClosingDate, "
                    + "ClosingBy = :prmClosingBy "
                    + "WHERE code = :prmCode")
                    .setParameter("prmClosingStatus",salesOrderByCustomerPurchaseOrder.getClosingStatus())
                    .setParameter("prmClosingDate", salesOrderByCustomerPurchaseOrder.getClosingDate())
                    .setParameter("prmClosingBy",salesOrderByCustomerPurchaseOrder.getClosingBy())
                    .setParameter("prmCode", salesOrderByCustomerPurchaseOrder.getCustomerPurchaseOrder().getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
                        
            hbmSession.hSession.update(salesOrderByCustomerPurchaseOrder);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    salesOrderByCustomerPurchaseOrderClosing.getApprovalStatus() , 
                                                                    salesOrderByCustomerPurchaseOrderClosing.getCode(),""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();           
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
    
    
}

    

