/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.inkombizz.purchasing.model.PurchaseOrderAdditionalFee;
import com.inkombizz.purchasing.model.PurchaseOrderAdditionalFeeField;
import com.inkombizz.purchasing.model.PurchaseOrderDetail;
import com.inkombizz.purchasing.model.PurchaseOrderDetailField;
import com.inkombizz.purchasing.model.PurchaseOrderItemDeliveryDate;
import com.inkombizz.purchasing.model.PurchaseOrderItemDeliveryDateField;
import com.inkombizz.purchasing.model.PurchaseOrderPurchaseRequest;
import com.inkombizz.purchasing.model.PurchaseOrderPurchaseRequestField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
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

/**
 *
 * @author ikb
 */
public class PurchaseOrderDAO {
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();
    
    public PurchaseOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(PurchaseOrder purchaseOrder) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_purchase_order(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,"
                        + ":prmCurrencyCode,:prmCurrencyName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+purchaseOrder.getCode()+"%")
                .setParameter("prmVendorCode","%"+purchaseOrder.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+purchaseOrder.getVendorName()+"%")
                .setParameter("prmCurrencyCode", "%"+purchaseOrder.getCurrencyCode()+"%")
                .setParameter("prmCurrencyName", "%"+purchaseOrder.getCurrencyName()+"%")
                .setParameter("prmRefNo", "%"+purchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+purchaseOrder.getRemark()+"%")
                .setParameter("prmFirstDate", purchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", purchaseOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseOrder> findData(PurchaseOrder purchaseOrder, int from, int to) {
        try {
            
            List<PurchaseOrder> list = (List<PurchaseOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_purchase_order(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,"
                        + ":prmCurrencyCode,:prmCurrencyName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("grnNo", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateStart", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateEnd", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)                               
                .addScalar("vendorDefaultContactPersonName", Hibernate.STRING)                               
                .addScalar("vendorLocalImport", Hibernate.STRING) 
                .addScalar("penaltyStatus", Hibernate.BOOLEAN) 
                .addScalar("penaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("maximumPenaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("billToCode", Hibernate.STRING)
                .addScalar("billToName", Hibernate.STRING)
                .addScalar("billToAddress", Hibernate.STRING)
                .addScalar("billToContactPerson", Hibernate.STRING)
                .addScalar("billToPhone", Hibernate.STRING)
                .addScalar("shipToCode", Hibernate.STRING)   
                .addScalar("shipToName", Hibernate.STRING)
                .addScalar("shipToAddress", Hibernate.STRING)
                .addScalar("shipToContactPerson", Hibernate.STRING)
                .addScalar("shipToPhone", Hibernate.STRING)      
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountChartOfAccountCode", Hibernate.STRING)    
                .addScalar("discountChartOfAccountName", Hibernate.STRING)    
                .addScalar("discountDescription", Hibernate.STRING)
                .addScalar("taxBaseSubTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeChartOfAccountCode", Hibernate.STRING)    
                .addScalar("otherFeeChartOfAccountName", Hibernate.STRING)    
                .addScalar("otherFeeDescription", Hibernate.STRING)    
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+purchaseOrder.getCode()+"%")
                .setParameter("prmVendorCode","%"+purchaseOrder.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+purchaseOrder.getVendorName()+"%")
                .setParameter("prmCurrencyCode", "%"+purchaseOrder.getCurrencyCode()+"%")
                .setParameter("prmCurrencyName", "%"+purchaseOrder.getCurrencyName()+"%")
                .setParameter("prmRefNo", "%"+purchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+purchaseOrder.getRemark()+"%")  
                .setParameter("prmFirstDate", purchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", purchaseOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataApproval(PurchaseOrder purchaseOrder) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_purchase_order_approval(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,"
                        + ":prmCurrencyCode,:prmCurrencyName,:prmRefNo,:prmRemark,:prmApproval,:prmClosing,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+purchaseOrder.getCode()+"%")
                .setParameter("prmVendorCode","%"+purchaseOrder.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+purchaseOrder.getVendorName()+"%")
                .setParameter("prmCurrencyCode", "%"+purchaseOrder.getCurrencyCode()+"%")
                .setParameter("prmCurrencyName", "%"+purchaseOrder.getCurrencyName()+"%")
                .setParameter("prmRefNo", "%"+purchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+purchaseOrder.getRemark()+"%")
                .setParameter("prmApproval", "%"+purchaseOrder.getApprovalStatus()+"%")
                .setParameter("prmClosing", "%"+purchaseOrder.getClosingStatus()+"%")
                .setParameter("prmFirstDate", purchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", purchaseOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseOrder> findDataApproval(PurchaseOrder purchaseOrder, int from, int to) {
        try {
            
            List<PurchaseOrder> list = (List<PurchaseOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_purchase_order_approval(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,"
                        + ":prmCurrencyCode,:prmCurrencyName,:prmRefNo,:prmRemark,:prmApproval,:prmClosing,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateStart", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateEnd", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)                               
                .addScalar("vendorDefaultContactPersonName", Hibernate.STRING)                               
                .addScalar("vendorLocalImport", Hibernate.STRING) 
                .addScalar("penaltyStatus", Hibernate.BOOLEAN) 
                .addScalar("penaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("maximumPenaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("billToCode", Hibernate.STRING)
                .addScalar("billToName", Hibernate.STRING)
                .addScalar("billToAddress", Hibernate.STRING)
                .addScalar("billToContactPerson", Hibernate.STRING)
                .addScalar("billToPhone", Hibernate.STRING)
                .addScalar("shipToCode", Hibernate.STRING)   
                .addScalar("shipToName", Hibernate.STRING)
                .addScalar("shipToAddress", Hibernate.STRING)
                .addScalar("shipToContactPerson", Hibernate.STRING)
                .addScalar("shipToPhone", Hibernate.STRING)      
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountChartOfAccountCode", Hibernate.STRING)    
                .addScalar("discountChartOfAccountName", Hibernate.STRING)    
                .addScalar("discountDescription", Hibernate.STRING)
                .addScalar("taxBaseSubTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeChartOfAccountCode", Hibernate.STRING)    
                .addScalar("otherFeeChartOfAccountName", Hibernate.STRING)    
                .addScalar("otherFeeDescription", Hibernate.STRING)    
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+purchaseOrder.getCode()+"%")
                .setParameter("prmVendorCode","%"+purchaseOrder.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+purchaseOrder.getVendorName()+"%")
                .setParameter("prmCurrencyCode", "%"+purchaseOrder.getCurrencyCode()+"%")
                .setParameter("prmCurrencyName", "%"+purchaseOrder.getCurrencyName()+"%")
                .setParameter("prmRefNo", "%"+purchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+purchaseOrder.getRemark()+"%")
                .setParameter("prmApproval", "%"+purchaseOrder.getApprovalStatus()+"%")
                .setParameter("prmClosing", "%"+purchaseOrder.getClosingStatus()+"%")    
                .setParameter("prmFirstDate", purchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", purchaseOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataUpdateInformation(PurchaseOrder purchaseOrder) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_purchase_order_update_information(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,"
                        + ":prmCurrencyCode,:prmCurrencyName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+purchaseOrder.getCode()+"%")
                .setParameter("prmVendorCode","%"+purchaseOrder.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+purchaseOrder.getVendorName()+"%")
                .setParameter("prmCurrencyCode", "%"+purchaseOrder.getCurrencyCode()+"%")
                .setParameter("prmCurrencyName", "%"+purchaseOrder.getCurrencyName()+"%")
                .setParameter("prmRefNo", "%"+purchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+purchaseOrder.getRemark()+"%")
                .setParameter("prmFirstDate", purchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", purchaseOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseOrder> findDataUpdateInformation(PurchaseOrder purchaseOrder, int from, int to) {
        try {
            
            List<PurchaseOrder> list = (List<PurchaseOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_purchase_order_update_information(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,"
                        + ":prmCurrencyCode,:prmCurrencyName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("grnNo", Hibernate.STRING)
                .addScalar("grnConfirmation", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateStart", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateEnd", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)                               
                .addScalar("vendorDefaultContactPersonName", Hibernate.STRING)                               
                .addScalar("vendorLocalImport", Hibernate.STRING) 
                .addScalar("penaltyStatus", Hibernate.BOOLEAN) 
                .addScalar("penaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("maximumPenaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("billToCode", Hibernate.STRING)
                .addScalar("billToName", Hibernate.STRING)
                .addScalar("billToAddress", Hibernate.STRING)
                .addScalar("billToContactPerson", Hibernate.STRING)
                .addScalar("billToPhone", Hibernate.STRING)
                .addScalar("shipToCode", Hibernate.STRING)   
                .addScalar("shipToName", Hibernate.STRING)
                .addScalar("shipToAddress", Hibernate.STRING)
                .addScalar("shipToContactPerson", Hibernate.STRING)
                .addScalar("shipToPhone", Hibernate.STRING)      
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountChartOfAccountCode", Hibernate.STRING)    
                .addScalar("discountChartOfAccountName", Hibernate.STRING)    
                .addScalar("discountDescription", Hibernate.STRING)
                .addScalar("taxBaseSubTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeChartOfAccountCode", Hibernate.STRING)    
                .addScalar("otherFeeChartOfAccountName", Hibernate.STRING)    
                .addScalar("otherFeeDescription", Hibernate.STRING)    
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+purchaseOrder.getCode()+"%")
                .setParameter("prmVendorCode","%"+purchaseOrder.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+purchaseOrder.getVendorName()+"%")
                .setParameter("prmCurrencyCode", "%"+purchaseOrder.getCurrencyCode()+"%")
                .setParameter("prmCurrencyName", "%"+purchaseOrder.getCurrencyName()+"%")
                .setParameter("prmRefNo", "%"+purchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+purchaseOrder.getRemark()+"%")  
                .setParameter("prmFirstDate", purchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", purchaseOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
//    public List<PurchaseOrderSubItem> findDataPurchaseOrderSubItem(String headerCode) {
//        try {
//            
//            List<PurchaseOrderSubItem> list = (List<PurchaseOrderSubItem>)hbmSession.hSession.createSQLQuery(
//                    "CALL usp_purchase_order_sub_item_list(:prmHeaderCode)")                       
//                .addScalar("code", Hibernate.STRING)
//                .addScalar("headerCode", Hibernate.STRING)
//                .addScalar("documentDetailCode", Hibernate.STRING)
//                .addScalar("imrNo", Hibernate.STRING)
//                .addScalar("purchaseRequestCode", Hibernate.STRING)
//                .addScalar("purchaseOrderItemMaterialCode", Hibernate.STRING)
//                .addScalar("purchaseOrderItemMaterialName", Hibernate.STRING)
//                .addScalar("partCode", Hibernate.STRING)
//                .addScalar("drawingCode", Hibernate.STRING)
//                .setParameter("prmHeaderCode", ""+headerCode+"")
//                .setResultTransformer(Transformers.aliasToBean(PurchaseOrderSubItem.class))
//                .list(); 
//                 
//                return list;
//        } catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public List<PurchaseOrderPurchaseRequest> findDataPurchaseRequest(String headerCode) {
        try {
            
            List<PurchaseOrderPurchaseRequest> list = (List<PurchaseOrderPurchaseRequest>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_purchase_order_purchase_request_list(:prmHeaderCode)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("purchaseRequestCode", Hibernate.STRING)
                .addScalar("purchaseRequestTransactionDate", Hibernate.TIMESTAMP)  
                .addScalar("purchaseRequestRefNo", Hibernate.STRING)
                .addScalar("purchaseRequestRemark", Hibernate.STRING)
                .addScalar("purchaseRequestRequestBy", Hibernate.STRING)
                .addScalar("purchaseRequestType", Hibernate.STRING)
                .addScalar("ppoCode", Hibernate.STRING)
                .setParameter("prmHeaderCode", ""+headerCode+"")
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrderPurchaseRequest.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseOrderDetail> findDataPurchaseOrderDetail(String headerCode) {
        try {
            
            List<PurchaseOrderDetail> list = (List<PurchaseOrderDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT  " +
                    "pur_purchase_order_item_material_detail.code, " +
                    "pur_purchase_order_item_material_detail.headerCode, " +
                    "pur_purchase_order_item_material_detail.purchaseRequestCode, " +
                    "pur_purchase_order_item_material_detail.purchaseRequestDetailCode, " +
                    "pur_purchase_order_item_material_detail.itemMaterialCode, " +
                    "mst_item_material.name AS itemMaterialName, " +
                    "mst_item_material.UnitOfMeasureCode, " +
                    "mst_unit_of_measure.name AS UnitOfMeasureName, " +
                    "pur_purchase_order_item_material_detail.itemAlias, " +
                    "pur_purchase_order_item_material_detail.remark, " +
                    "pur_purchase_order_item_material_detail.quantity, " +
                    "pur_purchase_order_item_material_detail.price, " +
                    "pur_purchase_order_item_material_detail.discountPercent, " +
                    "pur_purchase_order_item_material_detail.discountAmount, " +
                    "pur_purchase_order_item_material_detail.nettPrice, " +
                    "pur_purchase_order_item_material_detail.totalAmount " +
                    "FROM pur_purchase_order_item_material_detail " +
                    "INNER JOIN pur_purchase_order ON pur_purchase_order.Code = pur_purchase_order_item_material_detail.HeaderCode " +
                    "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_order_item_material_detail.ItemMaterialCode " +
                    "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.code = mst_item_material.UnitOfMeasureCode " +
                    "WHERE pur_purchase_order_item_material_detail.HeaderCode = '"+headerCode+"' "
                )                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("purchaseRequestCode", Hibernate.STRING) 
                .addScalar("purchaseRequestDetailCode", Hibernate.STRING) 
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("nettPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrderDetail.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseOrderAdditionalFee> findDataAdditonalFee(String headerCode) {
        try {
            
            List<PurchaseOrderAdditionalFee> list = (List<PurchaseOrderAdditionalFee>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_purchase_order_additional_fee_list(:prmHeaderCode)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("additionalFeeCode", Hibernate.STRING)
                .addScalar("additionalFeeName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountCode", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", ""+headerCode+"")
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrderAdditionalFee.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) {
        try {
            
            List<PurchaseOrderItemDeliveryDate> list = (List<PurchaseOrderItemDeliveryDate>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_purchase_order_item_delivery_date_list(:prmHeaderCode)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("deliveryDate", Hibernate.TIMESTAMP)
                .setParameter("prmHeaderCode", ""+headerCode+"")
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrderItemDeliveryDate.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataSearch(String code,String vendorCode,String vendorName,Date firstDate,Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) FROM "
                + "(SELECT COUNT(*) "
                + "FROM pur_purchase_order "
                + "INNER JOIN mst_branch ON pur_purchase_order.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_payment_term ON pur_purchase_order.paymenttermcode=mst_payment_term.Code "
                + "INNER JOIN mst_currency ON pur_purchase_order.currencycode=mst_currency.Code "
                + "INNER JOIN mst_vendor ON pur_purchase_order.vendorcode=mst_vendor.Code "
                + "LEFT JOIN mst_vendor_jn_contact ON mst_vendor.DefaultContactPersonCode = mst_vendor_jn_contact.Code "
                + "INNER JOIN mst_purchase_destination BillTo ON pur_purchase_order.BillToCode=BillTo.Code " 
                + "INNER JOIN mst_purchase_destination ShipTo ON pur_purchase_order.ShipToCode=ShipTo.Code  "
                + "LEFT JOIN mst_chart_of_account chart_of_account_disc ON pur_purchase_order.DiscountChartOfAccountCode=chart_of_account_disc.Code "
                + "LEFT JOIN mst_chart_of_account chart_of_account_otherfee ON pur_purchase_order.OtherFeeChartOfAccountCode=chart_of_account_otherfee.Code "
                + "LEFT JOIN fin_vendor_invoice ON fin_vendor_invoice.PurchaseOrderCode = pur_purchase_order.code "
                + "WHERE pur_purchase_order.code LIKE '%"+ code + "%' " 
                + "AND pur_purchase_order.vendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.name LIKE '%"+vendorName+"%' "
                + "AND pur_purchase_order.ApprovalStatus ='APPROVED' "
                + "AND pur_purchase_order.ClosingStatus ='OPEN' "
                + "AND DATE(pur_purchase_order.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "AND fin_vendor_invoice.PurchaseOrderCode IS NULL "
                + "GROUP BY pur_purchase_order.code "
                + ")AS purchase_order"
                ).uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseOrder> findDataSearch(String code,String vendorCode,String vendorName,Date firstDate,Date lastDate,int from,int row) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<PurchaseOrder> list = (List<PurchaseOrder>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
		+ "pur_purchase_order.Code, "
		+ "pur_purchase_order.TransactionDate, "
		+ "pur_purchase_order.BranchCode, "
		+ "mst_branch.name AS BranchName, "
		+ "pur_purchase_order.DeliveryDateStart, "
		+ "pur_purchase_order.DeliveryDateEnd, "
		+ "pur_purchase_order.PaymentTermCode, "
		+ "pur_purchase_order.CurrencyCode, "
		+ "mst_currency.name AS CurrencyName, "
		+ "pur_purchase_order.VendorCode, "
		+ "mst_vendor.name AS VendorName, "
		+ "mst_vendor.DefaultContactPersonCode AS DefaultContactPersonCode, "
		+ "mst_vendor.LocalImport AS vendorLocalImport, "
		+ "mst_vendor.Address AS vendorAddress, "
		+ "mst_vendor.Phone1 AS vendorPhone1, "
		+ "mst_vendor.Phone2 AS vendorPhone2, "
		+ "mst_vendor_jn_contact.Name AS vendorDefaultContactPersonName, "
		+ "pur_purchase_order.PenaltyStatus, "
		+ "pur_purchase_order.PenaltyPercent, "
		+ "pur_purchase_order.MaximumPenaltyPercent, "
		+ "pur_purchase_order.BillToCode, "
		+ "billTo.Name AS billToName, "
		+ "billTo.Address AS billToAddress, "
		+ "billTo.ContactPerson AS billToContactPerson, "
		+ "billTo.Phone1 AS billToPhone, "
		+ "pur_purchase_order.ShipToCode, "
		+ "shipTo.Name AS shipToName, "
		+ "shipTo.Address AS shipToAddress, "
		+ "shipTo.ContactPerson AS shipToContactPerson, "
		+ "shipTo.Phone1 AS shipToPhone, "
		+ "pur_purchase_order.RefNo, "
		+ "pur_purchase_order.Remark, "
		+ "pur_purchase_order.TotalTransactionAmount, "
		+ "pur_purchase_order.DiscountPercent, "
		+ "pur_purchase_order.DiscountAmount, "
		+ "pur_purchase_order.DiscountChartOfAccountCode, "
		+ "mst_chart_of_account.name AS DiscountChartOfAccountName, "
		+ "pur_purchase_order.DiscountDescription, "
		+ "pur_purchase_order.TaxBaseSubTotalAmount, "
		+ "pur_purchase_order.VATPercent, "
		+ "pur_purchase_order.VATAmount, "
		+ "pur_purchase_order.OtherFeeAmount, "
		+ "pur_purchase_order.OtherFeeChartOfAccountCode, "
		+ "OtherFeeChartOfAccount.name AS OtherFeeChartOfAccountName, "
		+ "pur_purchase_order.OtherFeeDescription, "
		+ "pur_purchase_order.GrandTotalAmount, "
		+ "pur_purchase_order.ApprovalStatus, "
		+ "pur_purchase_order.ApprovalRemark "
		+ "FROM  "
		+ "pur_purchase_order "
		+ "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_order.BranchCode "
		+ "INNER JOIN mst_purchase_destination billTo ON billTo.Code = pur_purchase_order.BillToCode "
		+ "INNER JOIN mst_purchase_destination shipTo ON shipTo.Code = pur_purchase_order.ShipToCode "
		+ "INNER JOIN mst_payment_term ON mst_payment_term.Code = pur_purchase_order.PaymentTermCode "
		+ "INNER JOIN mst_currency ON mst_currency.Code = pur_purchase_order.CurrencyCode "
		+ "INNER JOIN mst_vendor ON mst_vendor.Code = pur_purchase_order.VendorCode "
		+ "LEFT JOIN mst_vendor_jn_contact ON mst_vendor.DefaultContactPersonCode = mst_vendor_jn_contact.Code "
		+ "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = pur_purchase_order.DiscountChartOfAccountCode "
		+ "LEFT JOIN mst_chart_of_account OtherFeeChartOfAccount ON OtherFeeChartOfAccount.Code = pur_purchase_order.OtherFeeChartOfAccountCode "
                + "LEFT JOIN fin_vendor_invoice ON fin_vendor_invoice.PurchaseOrderCode = pur_purchase_order.code "            
                + "WHERE pur_purchase_order.code LIKE '%"+ code + "%' "
                + "AND pur_purchase_order.vendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.name LIKE '%"+vendorName+"%' "
                + "AND pur_purchase_order.ApprovalStatus ='APPROVED' "
                + "AND pur_purchase_order.ClosingStatus ='OPEN' "        
                + "AND DATE(pur_purchase_order.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "AND fin_vendor_invoice.PurchaseOrderCode IS NULL "        
                + "GROUP BY pur_purchase_order.code "
                + "ORDER BY pur_purchase_order.TransactionDate DESC "
                + "LIMIT "+from+","+row+"")
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateStart", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateEnd", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)                               
                .addScalar("vendorDefaultContactPersonName", Hibernate.STRING)                               
                .addScalar("vendorLocalImport", Hibernate.STRING) 
                .addScalar("vendorAddress", Hibernate.STRING) 
                .addScalar("vendorPhone1", Hibernate.STRING) 
                .addScalar("vendorPhone2", Hibernate.STRING) 
                .addScalar("penaltyStatus", Hibernate.BOOLEAN) 
                .addScalar("penaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("maximumPenaltyPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("billToCode", Hibernate.STRING)
                .addScalar("billToName", Hibernate.STRING)
                .addScalar("billToAddress", Hibernate.STRING)
                .addScalar("billToContactPerson", Hibernate.STRING)
                .addScalar("billToPhone", Hibernate.STRING)
                .addScalar("shipToCode", Hibernate.STRING)   
                .addScalar("shipToName", Hibernate.STRING)
                .addScalar("shipToAddress", Hibernate.STRING)
                .addScalar("shipToContactPerson", Hibernate.STRING)
                .addScalar("shipToPhone", Hibernate.STRING)      
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountChartOfAccountCode", Hibernate.STRING)    
                .addScalar("discountChartOfAccountName", Hibernate.STRING)    
                .addScalar("discountDescription", Hibernate.STRING)
                .addScalar("taxBaseSubTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeChartOfAccountCode", Hibernate.STRING)    
                .addScalar("otherFeeChartOfAccountName", Hibernate.STRING)    
                .addScalar("otherFeeDescription", Hibernate.STRING)    
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrder.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }  
    
    public List<PurchaseOrderDetail> findDataDetailByGrn(String headerCode) {
        try {
            List<PurchaseOrderDetail> list = (List<PurchaseOrderDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "pur_purchase_order_item_material_detail.Code,  "
                + "pur_purchase_order_item_material_detail.HeaderCode,  "
                + "pur_purchase_order_item_material_detail.ItemMaterialCode,  "        
                + "pur_purchase_order_item_material_detail.PurchaseRequestCode, "
                + "pur_purchase_order_item_material_detail.PurchaseRequestDetailCode, "
                + "mst_item_material.Name AS itemMaterialName,  "
                + "pur_purchase_order_item_material_detail.itemAlias, "
                + "SUM(pur_purchase_order_item_material_detail.Quantity) AS quantity, "
                + "IFNULL(data_grn.Quantity,0) AS receivedQuantity, "
                + "IFNULL(data_grn.Quantity,0) AS grnQuantity, "
                + "(SUM(pur_purchase_order_item_material_detail.Quantity) - IFNULL(data_grn.Quantity,0))AS balanceQuantity, "
                + "mst_item_material.UnitOfMeasureCode,  "
                + "pur_purchase_order_item_material_detail.Price, "
                + "(pur_purchase_order_item_material_detail.Price * SUM(pur_purchase_order_item_material_detail.Quantity))AS total,  "
                + "pur_purchase_order_item_material_detail.totalAmount, "
                + "pur_purchase_order_item_material_detail.DiscountPercent, "
                + "pur_purchase_order_item_material_detail.DiscountAmount, "
                + "pur_purchase_order_item_material_detail.NettPrice, "
                + "pur_purchase_order_item_material_detail.Remark "
                + "FROM pur_purchase_order_item_material_detail "
                + "LEFT JOIN(  "
                + "SELECT "
                + "ivt_goods_received_note.PurchaseOrderCode,  "
                + "ivt_goods_received_note_item_detail.HeaderCode,  "
                + "ivt_goods_received_note_item_detail.ItemMaterialCode,  "
                + "ivt_goods_received_note_item_detail.Price, "
                + "ivt_goods_received_note_item_detail.`PurchaseOrderDetailCode`, "
                + "SUM(ivt_goods_received_note_item_detail.Quantity) AS quantity   "
                + "FROM ivt_goods_received_note    "
                + "INNER JOIN ivt_goods_received_note_item_detail   "
                + "ON ivt_goods_received_note.Code=ivt_goods_received_note_item_detail.HeaderCode    "
                + "WHERE ivt_goods_received_note.PurchaseOrderCode='"+headerCode+"' "
                + "GROUP BY ivt_goods_received_note_item_detail.`PurchaseOrderDetailCode` "
                + ")AS data_grn   "
                + "ON pur_purchase_order_item_material_detail.code=data_grn.PurchaseOrderDetailCode    "
                + "AND pur_purchase_order_item_material_detail.ItemMaterialCode = data_grn.ItemMaterialCode "
                + "INNER JOIN mst_item_material ON pur_purchase_order_item_material_detail.ItemMaterialCode=mst_item_material.Code "
                + "WHERE pur_purchase_order_item_material_detail.HeaderCode='"+headerCode+"' "
                + "GROUP BY pur_purchase_order_item_material_detail.code "
                + "ORDER BY pur_purchase_order_item_material_detail.ItemMaterialCode")
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("purchaseRequestCode", Hibernate.STRING) 
                .addScalar("purchaseRequestDetailCode", Hibernate.STRING) 
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
//                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("grnQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("receivedQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("balanceQuantity", Hibernate.BIG_DECIMAL)    
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("nettPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrderDetail.class))
                .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countSearchByVendorInvoiceData(Date firstDate, Date lastDate,String code,String vendorCode,String vendorName){
        try{            
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_purchase_order_search_by_vendor_invoice(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,:prmFirstDate,:prmLastDate,0,0)")
            .setParameter("prmFlag", "COUNT")
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmVendorCode", "%"+vendorCode+"%")
            .setParameter("prmVendorName", "%"+vendorName+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseOrder> searchByVendorInvoiceData(Date firstDate, Date lastDate,String code,String vendorCode,String vendorName,int from, int to) {
        try {   
            
            List<PurchaseOrder> list = (List<PurchaseOrder>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_purchase_order_search_by_vendor_invoice(:prmFlag,:prmCode,:prmVendorCode,:prmVendorName,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("grnNo", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateStart", Hibernate.TIMESTAMP)
                .addScalar("deliveryDateEnd", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("vendorDefaultContactPersonCode", Hibernate.STRING)
                .addScalar("vendorDefaultContactPersonName", Hibernate.STRING)
                .addScalar("vendorAddress", Hibernate.STRING)
                .addScalar("vendorPhone1", Hibernate.STRING)
                .addScalar("vendorPhone2", Hibernate.STRING)
                .addScalar("npwp", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("paymentTermDays", Hibernate.STRING)
                .addScalar("billToCode", Hibernate.STRING)
                .addScalar("shipToCode", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountChartOfAccountCode", Hibernate.STRING)
                .addScalar("discountChartOfAccountName", Hibernate.STRING)
                .addScalar("discountDescription", Hibernate.STRING)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeChartOfAccountCode", Hibernate.STRING)
                .addScalar("otherFeeChartOfAccountName", Hibernate.STRING)
                .addScalar("otherFeeDescription", Hibernate.STRING)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmFlag", "LISTS")    
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmVendorCode", "%"+vendorCode+"%")
                .setParameter("prmVendorName", "%"+vendorName+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(PurchaseOrder.class))
                .list(); 
               
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }   
    
    public String createCode(PurchaseOrder purchaseOrder){   
        try{
            String acronim = purchaseOrder.getBranch().getCode()+ "/POD/"+AutoNumber.formatingDate(purchaseOrder.getTransactionDate(), true, true, false);;
            
            DetachedCriteria dc = DetachedCriteria.forClass(PurchaseOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));
            
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();
            
            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_4);
        }        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity, PurchaseOrder purchaseOrder, List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequest, List<PurchaseOrderDetail> listPurchaseOrderDetail, List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee,
                     List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception{
        try{
            hbmSession.hSession.beginTransaction();
            
            String headerCode = createCode(purchaseOrder);
            purchaseOrder.setCode(headerCode); 
            
           if(listPurchaseOrderPurchaseRequest==null || listPurchaseOrderDetail==null || listPurchaseOrderAdditionalFee ==null || listPurchaseOrderItemDeliveryDate == null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA PURCHASE REQUEST INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }

            if(!saveDetail(EnumActivity.ENUM_Activity.NEW, purchaseOrder, listPurchaseOrderPurchaseRequest, listPurchaseOrderDetail, 
                            listPurchaseOrderAdditionalFee, listPurchaseOrderItemDeliveryDate)){
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.save(purchaseOrder);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), purchaseOrder.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public void update(EnumActivity.ENUM_Activity enumActivity, PurchaseOrder purchaseOrder, List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequest, List<PurchaseOrderDetail> listPurchaseOrderDetail, List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee,
                     List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception{
        try{
            hbmSession.hSession.beginTransaction();
            
            purchaseOrder.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            purchaseOrder.setUpdatedDate(new Date());
            
            hbmSession.hSession.update(purchaseOrder);
            
           if(listPurchaseOrderPurchaseRequest==null || listPurchaseOrderDetail==null || listPurchaseOrderAdditionalFee ==null || listPurchaseOrderItemDeliveryDate == null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA PURCHASE REQUEST INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }

            if(!saveDetail(EnumActivity.ENUM_Activity.UPDATE, purchaseOrder, listPurchaseOrderPurchaseRequest, listPurchaseOrderDetail, 
                            listPurchaseOrderAdditionalFee, listPurchaseOrderItemDeliveryDate)){
                hbmSession.hTransaction.rollback();
            }
            
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), purchaseOrder.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public void delete(PurchaseOrder purchaseOrder, String moduleCode) throws Exception{
        try{
            hbmSession.hSession.beginTransaction();
                    
            
            if (!saveDetail(EnumActivity.ENUM_Activity.DELETE, purchaseOrder,null,null,null,null)) {
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM PurchaseOrder "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", purchaseOrder.getCode())
                    .executeUpdate();
            
         
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    purchaseOrder.getCode(), EnumActivity.toString(EnumActivity.ENUM_Activity.DELETE)));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
    
    private Boolean saveDetail(EnumActivity.ENUM_Activity enumActivity, PurchaseOrder purchaseOrder, List<PurchaseOrderPurchaseRequest> listPurchaseOrderPurchaseRequest, 
                               List<PurchaseOrderDetail> listPurchaseOrderDetail, List<PurchaseOrderAdditionalFee> listPurchaseOrderAdditionalFee, 
                               List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate) throws Exception{
        try {
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
               hbmSession.hSession.createQuery("DELETE FROM "+PurchaseOrderPurchaseRequestField.BEAN_NAME+" WHERE "+PurchaseOrderPurchaseRequestField.HEADERCODE+" = :prmCode")
                   .setParameter("prmCode", purchaseOrder.getCode())    
                   .executeUpdate();
            }
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
               hbmSession.hSession.createQuery("DELETE FROM "+PurchaseOrderDetailField.BEAN_NAME+" WHERE "+PurchaseOrderDetailField.HEADERCODE+" = :prmCode")
                   .setParameter("prmCode", purchaseOrder.getCode())    
                   .executeUpdate();
            }
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
               hbmSession.hSession.createQuery("DELETE FROM "+PurchaseOrderAdditionalFeeField.BEAN_NAME+" WHERE "+PurchaseOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                   .setParameter("prmCode", purchaseOrder.getCode())    
                   .executeUpdate();
            }
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
               hbmSession.hSession.createQuery("DELETE FROM "+PurchaseOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+PurchaseOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                   .setParameter("prmCode", purchaseOrder.getCode())    
                   .executeUpdate();
            }
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int i = 1;
                for(PurchaseOrderPurchaseRequest poJnPR : listPurchaseOrderPurchaseRequest){
                    String detailCode = purchaseOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    poJnPR.setCode(detailCode);
                    poJnPR.setHeaderCode(purchaseOrder.getCode());

                    hbmSession.hSession.save(poJnPR);
                    hbmSession.hSession.flush();

                    i++;
                }
                int j = 1;
                for(PurchaseOrderDetail pOD : listPurchaseOrderDetail){
                    String detailCode = purchaseOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    pOD.setCode(detailCode);
                    pOD.setHeaderCode(purchaseOrder.getCode());

                    hbmSession.hSession.save(pOD);
                    hbmSession.hSession.flush();

                    j++;
                }
                int k = 1;
                for (PurchaseOrderAdditionalFee pOA : listPurchaseOrderAdditionalFee){
                    String detailCode = purchaseOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(k),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    pOA.setCode(detailCode);
                    pOA.setHeaderCode(purchaseOrder.getCode());

                    hbmSession.hSession.save(pOA);
                    hbmSession.hSession.flush();
                    
                    k++;
                }
                int l = 1;
                for (PurchaseOrderItemDeliveryDate pOItemDelivery : listPurchaseOrderItemDeliveryDate){
                    String detailCode = purchaseOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(l),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    pOItemDelivery.setCode(detailCode);
                    pOItemDelivery.setHeaderCode(purchaseOrder.getCode());

                    hbmSession.hSession.save(pOItemDelivery);
                    hbmSession.hSession.flush();
                    
                    l++;
                }
            }
            
            return Boolean.TRUE;
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void approval(PurchaseOrder purchaseOrder,String moduleCode) throws Exception{
        try {
            
            String approvalBy="";
            Date approvalDate=commonFunction.setDateTime("01/01/1900 00:00:00");
                        
            if(purchaseOrder.getApprovalStatus().equals(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED.toString())){
                approvalBy=BaseSession.loadProgramSession().getUserName();
                approvalDate=new Date();
            }

            hbmSession.hSession.beginTransaction();
            
             String prmActivity = "";
            if ("APPROVED".equals(purchaseOrder.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.APPROVED);
            }else if ("REJECTED".equals(purchaseOrder.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.REJECTED);
            }
//            purchaseOrder.setLastStatus(prmActivity);
            purchaseOrder.setApprovalBy(approvalBy);
            purchaseOrder.setApprovalDate(approvalDate);
            //hbmSession.hSession.update(purchaseOrder);
            
            hbmSession.hSession.createQuery("UPDATE PurchaseOrder SET "
                    + "ApprovalStatus = :prmApprovalstatus, "
                    + "ApprovalBy = :prmApprovalBy, "
                    + "ApprovalDate = :prmApprovalDate, "
                    + "ApprovalRemark = :prmApprovalRemark, "
                    + "approvalReason = :prmApprovalReason "
                    + "WHERE code = :prmCode")
                    .setParameter("prmApprovalstatus", prmActivity)
                    .setParameter("prmApprovalBy", BaseSession.loadProgramSession().getUserName())
                    .setParameter("prmApprovalDate", new Date())
                    .setParameter("prmApprovalRemark", purchaseOrder.getApprovalRemark())
                    .setParameter("prmApprovalReason", purchaseOrder.getApprovalReason())
                    .setParameter("prmCode", purchaseOrder.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
                       
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    purchaseOrder.getCode(), "Approval: "+purchaseOrder.getApprovalStatus()));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.close();
        } catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void closing(PurchaseOrder purchaseOrderClosing, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            PurchaseOrder purchaseOrder =get(purchaseOrderClosing.getCode());
            
            purchaseOrder.setClosingStatus("CLOSED");
            purchaseOrder.setClosingBy(BaseSession.loadProgramSession().getUserName());
            purchaseOrder.setClosingDate(new Date());
            
            hbmSession.hSession.createQuery("UPDATE PurchaseOrder SET "
                    + "ClosingStatus = :prmClosingStatus, "
                    + "ClosingDate = :prmClosingDate, "
                    + "ClosingBy = :prmClosingBy "
                    + "WHERE code = :prmCode")
                    .setParameter("prmClosingStatus",purchaseOrder.getClosingStatus())
                    .setParameter("prmClosingDate", purchaseOrder.getClosingDate())
                    .setParameter("prmClosingBy",purchaseOrder.getClosingBy())
                    .setParameter("prmCode", purchaseOrder.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
                        
            hbmSession.hSession.update(purchaseOrder);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    purchaseOrderClosing.getApprovalStatus() , 
                                                                    purchaseOrderClosing.getCode(),""));
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
    
    public int countPOInform(String headerCode){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT    " +
                    "      COUNT(pur_purchase_order_item_material_detail.Code) " +
                    "FROM pur_purchase_order_item_material_detail   " +
                    "INNER JOIN pur_purchase_order ON pur_purchase_order.Code = pur_purchase_order_item_material_detail.HeaderCode   " +
                    "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_order_item_material_detail.ItemMaterialCode   " +
                    "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.code = mst_item_material.UnitOfMeasureCode   " +
                    "WHERE pur_purchase_order_item_material_detail.HeaderCode = '"+headerCode+"' "
            ).uniqueResult();
            
            return temp.intValue();
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseOrderDetail> findDataUpdateInformation(String headerCode){
        try{
            List<PurchaseOrderDetail> list = (List<PurchaseOrderDetail>)hbmSession.hSession.createSQLQuery(
                        "SELECT  " +
                        "pur_purchase_order_item_material_detail.code, " +
                        "pur_purchase_order_item_material_detail.headerCode, " +
                        "pur_purchase_order_item_material_detail.purchaseRequestCode, " +
                        "pur_purchase_order_item_material_detail.purchaseRequestDetailCode, " +
                        "pur_purchase_order_item_material_detail.itemMaterialCode, " +
                        "mst_item_material.name AS itemMaterialName, " +
                        "mst_item_material.UnitOfMeasureCode, " +
                        "mst_unit_of_measure.name AS UnitOfMeasureName, " +
                        "pur_purchase_order_item_material_detail.itemAlias, " +
                        "pur_purchase_order_item_material_detail.remark, " +
                        "pur_purchase_order_item_material_detail.quantity, " +
                        "pur_purchase_order_item_material_detail.price, " +
                        "pur_purchase_order_item_material_detail.discountPercent, " +
                        "pur_purchase_order_item_material_detail.discountAmount, " +
                        "pur_purchase_order_item_material_detail.nettPrice, " +
                        "pur_purchase_order_item_material_detail.totalAmount " +
                        "FROM pur_purchase_order_item_material_detail " +
                        "INNER JOIN pur_purchase_order ON pur_purchase_order.Code = pur_purchase_order_item_material_detail.HeaderCode " +
                        "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_order_item_material_detail.ItemMaterialCode " +
                        "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.code = mst_item_material.UnitOfMeasureCode " +
                        "WHERE pur_purchase_order_item_material_detail.HeaderCode = '"+headerCode+"' ")

                    .addScalar("code",Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(PurchaseOrderDetail.class))
                    .list();
            return list;
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    public void updateInformation(PurchaseOrder purchaseOrder, List<PurchaseOrderDetail> listPurchaseOrderUpdateInformationDetailView,
                                  List<PurchaseOrderDetail> listPurchaseOrderUpdateInformationDetailInput, List<PurchaseOrderItemDeliveryDate> listPurchaseOrderItemDeliveryDate, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            List<PurchaseOrderDetail> listPodOld = findDataUpdateInformation(purchaseOrder.getCode());
            List<String> code =new ArrayList<String>();
            int j = countPOInform(purchaseOrder.getCode());
            
            if(listPodOld.size() != listPurchaseOrderUpdateInformationDetailView.size()){
                for(int k=0; k<listPurchaseOrderUpdateInformationDetailView.size(); k++){
                    code.add(listPurchaseOrderUpdateInformationDetailView.get(k).getCode());
                }

                for(PurchaseOrderDetail detail : listPodOld){
                    if(!code.contains(detail.getCode())){
                        hbmSession.hSession.createQuery("DELETE FROM "+PurchaseOrderDetailField.BEAN_NAME+" WHERE CODE = :prmCode")
                       .setParameter("prmCode", detail.getCode())    
                       .executeUpdate();
                    }
                }  
            }
            
            hbmSession.hSession.createQuery("DELETE FROM "+PurchaseOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+PurchaseOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                   .setParameter("prmCode", purchaseOrder.getCode())    
                   .executeUpdate();
             
            for(PurchaseOrderDetail pOD : listPurchaseOrderUpdateInformationDetailInput){
                j++;
                String detailCode = purchaseOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                pOD.setCode(detailCode);
                pOD.setHeaderCode(purchaseOrder.getCode());

                hbmSession.hSession.save(pOD);
                hbmSession.hSession.flush();
            }
            
            int l = 1;
            for (PurchaseOrderItemDeliveryDate pOItemDelivery : listPurchaseOrderItemDeliveryDate){
                String detailCode = purchaseOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(l),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                pOItemDelivery.setCode(detailCode);
                pOItemDelivery.setHeaderCode(purchaseOrder.getCode());

                hbmSession.hSession.save(pOItemDelivery);
                hbmSession.hSession.flush();

                l++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    purchaseOrder.getCode(), ""));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
        }catch(HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }

    public PurchaseOrder get(String code) {
        try {
               return (PurchaseOrder) hbmSession.hSession.get(PurchaseOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    
}
