/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonConst;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.engineering.model.BillOfMaterial;
import com.inkombizz.engineering.model.BillOfMaterialPartDetail;
import com.inkombizz.engineering.model.BillOfMaterialPartDetailField;
import com.inkombizz.engineering.model.BomTemp;
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
 * @author CHRIST
 */
public class BillOfMaterialDAO {
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();

    public BillOfMaterialDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(BillOfMaterial billOfMaterial) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(billOfMaterial.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(billOfMaterial.getTransactionLastDate());

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    " CALL usp_bill_of_material_find_data_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,:prmRemarkDoc,:prmRefNo,:prmDocumentOrderType,:prmFirstDate,:prmLastDate,0,0) " )
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+billOfMaterial.getCode()+"%")
                .setParameter("prmCustomerCode", "%"+billOfMaterial.getCustomerCode()+"%")
                .setParameter("prmCustomerName", "%"+billOfMaterial.getCustomerName()+"%")
                .setParameter("prmRemarkDoc", "%"+billOfMaterial.getRemarkDoc()+"%")
                .setParameter("prmRefNo", "%"+billOfMaterial.getRefNo()+"%")
                .setParameter("prmDocumentOrderType", "%"+billOfMaterial.getDocumentOrderType()+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<BillOfMaterial> findData(BillOfMaterial billOfMaterial,int from, int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(billOfMaterial.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(billOfMaterial.getTransactionLastDate());


            List<BillOfMaterial> list = (List<BillOfMaterial>)hbmSession.hSession.createSQLQuery(
                   " CALL usp_bill_of_material_find_data_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,:prmRemarkDoc,:prmRefNo,:prmDocumentOrderType,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo) " )
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("documentOrderCode", Hibernate.STRING)
                .addScalar("documentOrderDetailCode", Hibernate.STRING)
                .addScalar("documentOrderType", Hibernate.STRING)
                .addScalar("bomStatusNew", Hibernate.STRING)    
                .addScalar("transactionDateDoc", Hibernate.TIMESTAMP)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remarkDoc", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)    
                .addScalar("customerName", Hibernate.STRING)    
                .addScalar("approvalStatus", Hibernate.STRING)      
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+billOfMaterial.getCode()+"%")
                .setParameter("prmCustomerCode", "%"+billOfMaterial.getCustomerCode()+"%")
                .setParameter("prmCustomerName", "%"+billOfMaterial.getCustomerName()+"%")
                .setParameter("prmRemarkDoc", "%"+billOfMaterial.getRemarkDoc()+"%")
                .setParameter("prmRefNo", "%"+billOfMaterial.getRefNo()+"%")
                .setParameter("prmDocumentOrderType", "%"+billOfMaterial.getDocumentOrderType()+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)          
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterial.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

    public int countDataApproval(BillOfMaterial billOfMaterialApproval) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(billOfMaterialApproval.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(billOfMaterialApproval.getTransactionLastDate());

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    " CALL usp_bill_of_material_approval_data(:prmFlag,:prmCode,:prmDocumentOrderCode,:prmCustomerCode,:prmCustomerName,:prmRemarkDoc,:prmRefNo,:prmDocumentType,:prmApproval,:prmFirstDate,:prmLastDate,0,0) " )
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+billOfMaterialApproval.getCode()+"%")
                .setParameter("prmDocumentOrderCode", "%"+billOfMaterialApproval.getDocumentOrderCode()+"%")
                .setParameter("prmCustomerCode", "%"+billOfMaterialApproval.getCustomerCode()+"%")
                .setParameter("prmCustomerName", "%"+billOfMaterialApproval.getCustomerName()+"%")
                .setParameter("prmRemarkDoc", "%"+billOfMaterialApproval.getRemarkDoc()+"%")
                .setParameter("prmRefNo", "%"+billOfMaterialApproval.getRefNo()+"%")
                .setParameter("prmDocumentType", "%"+billOfMaterialApproval.getDocumentType()+"%")
                .setParameter("prmApproval", "%"+billOfMaterialApproval.getApprovalStatus()+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<BillOfMaterial> findDataApproval(BillOfMaterial billOfMaterialApproval,int from, int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(billOfMaterialApproval.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(billOfMaterialApproval.getTransactionLastDate());


            List<BillOfMaterial> list = (List<BillOfMaterial>)hbmSession.hSession.createSQLQuery(
                   " CALL usp_bill_of_material_approval_data(:prmFlag,:prmCode,:prmDocumentOrderCode,:prmCustomerCode,:prmCustomerName,:prmRemarkDoc,:prmRefNo,:prmDocumentType,:prmApproval,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo) " )
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("documentDetailCode", Hibernate.STRING)
                .addScalar("documentOrderCode", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)    
                .addScalar("approvalBy", Hibernate.STRING)    
                .addScalar("approvalDate", Hibernate.TIMESTAMP)      
                .addScalar("transactionDateDoc", Hibernate.TIMESTAMP)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remarkDoc", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)      
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)      
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+billOfMaterialApproval.getCode()+"%")
                .setParameter("prmDocumentOrderCode", "%"+billOfMaterialApproval.getDocumentOrderCode()+"%")
                .setParameter("prmCustomerCode", "%"+billOfMaterialApproval.getCustomerCode()+"%")
                .setParameter("prmCustomerName", "%"+billOfMaterialApproval.getCustomerName()+"%")
                .setParameter("prmRemarkDoc", "%"+billOfMaterialApproval.getRemarkDoc()+"%")
                .setParameter("prmRefNo", "%"+billOfMaterialApproval.getRefNo()+"%")
                .setParameter("prmDocumentType", "%"+billOfMaterialApproval.getDocumentType()+"%")
                .setParameter("prmApproval", "%"+billOfMaterialApproval.getApprovalStatus()+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)         
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterial.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BillOfMaterialPartDetail> findDataComponentDetail(String headerCode) {
        try {   
            
            List<BillOfMaterialPartDetail> list = (List<BillOfMaterialPartDetail>)hbmSession.hSession.createSQLQuery(
                 " CALL usp_bill_of_material_find_detail_list(:prmFlag,:prmCode) " )
                    
                .addScalar("bomCode", Hibernate.STRING)
                .addScalar("documentOrderDetailCode", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)    
                .addScalar("dataSheet", Hibernate.STRING)    
                .addScalar("description", Hibernate.STRING)  
//                .addScalar("refNo", Hibernate.STRING)
                .addScalar("bomStatusNew", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)    
//                .addScalar("docDetailCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
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
                .addScalar("quantityIfg", Hibernate.BIG_DECIMAL)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+headerCode+"%")    
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterialPartDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BillOfMaterialPartDetail> findDataPartDetail(String headerCodeBom) {
        try{
            List<BillOfMaterialPartDetail> list = (List<BillOfMaterialPartDetail>)hbmSession.hSession.createSQLQuery(
                 " SELECT "
                         + "eng_bill_of_material_part_detail.code, "
                         + "eng_bill_of_material_part_detail.headerCode, "
                         + "eng_bill_of_material_part_detail.sortNo, "
                         + "eng_bill_of_material_part_detail.partNo, "
                         + "eng_bill_of_material_part_detail.documentDetailCode, "
                         + "eng_bill_of_material_part_detail.partCode, "
                         + "mst_part.name AS partName, "
                         + "eng_bill_of_material_part_detail.requiredLength, "
                         + "eng_bill_of_material_part_detail.drawingCode, "
                         + "eng_bill_of_material_part_detail.dimension, "
                         + "eng_bill_of_material_part_detail.material, "
                         + "eng_bill_of_material_part_detail.quantity, "
                         + "eng_bill_of_material_part_detail.requirement, "
                         + "eng_bill_of_material_part_detail.processedStatus, "
                         + "eng_bill_of_material_part_detail.remark, "
                         + "eng_bill_of_material_part_detail.x, "
                         + "eng_bill_of_material_part_detail.revNo "
                    + "FROM eng_bill_of_material_part_detail "
                         + "INNER JOIN mst_part on mst_part.code = eng_bill_of_material_part_detail.partCode "
                         + "INNER JOIN eng_bill_of_material ON eng_bill_of_material.code = eng_bill_of_material_part_detail.HeaderCode "
                         + "WHERE eng_bill_of_material_part_detail.headerCode = '"+headerCodeBom+"' " )
                    
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                    .addScalar("partNo", Hibernate.BIG_DECIMAL)
                    .addScalar("documentDetailCode", Hibernate.STRING)
                    .addScalar("partCode", Hibernate.STRING)
                    .addScalar("partName", Hibernate.STRING)
                    .addScalar("drawingCode", Hibernate.STRING)
                    .addScalar("requiredLength", Hibernate.BIG_DECIMAL)
                    .addScalar("dimension", Hibernate.STRING)
                    .addScalar("material", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("requirement", Hibernate.STRING)
                    .addScalar("processedStatus", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("x", Hibernate.STRING)
                    .addScalar("revNo", Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(BillOfMaterialPartDetail.class))
                    .list(); 
                 
                return list;
                    
        }catch (HibernateException e) {
            throw e;
        }
    } 
    
    public BomTemp getDataCode(String detailCode){
        try{
            BomTemp bomTemp = (BomTemp)hbmSession.hSession.createSQLQuery(
            "SELECT "
                + " bom.documentOrderDetailCode, "
                + " bom.documentOrderCode, "
                + " bom.transactionDateDoc "
                    + " FROM( "
                    + "SELECT   " +
                "sal_customer_sales_order_item_detail.Code AS documentOrderDetailCode,    " +
                "sal_customer_sales_order_item_detail.HeaderCode AS documentOrderCode,    " +
                "sal_customer_sales_order.transactionDate AS transactionDateDoc,  " +
                "sal_customer_sales_order.customerCode,  " +
                "mst_customer.name AS customerName,  " +
                "sal_customer_sales_order.refNo,  " +
                "sal_customer_sales_order.remark AS remarkDoc  " +
                "FROM    " +
                "sal_customer_sales_order_item_detail    " +
                "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = sal_customer_sales_order_item_detail.ItemFinishGoodsCode    " +
                "INNER JOIN sal_customer_sales_order ON sal_customer_sales_order_item_detail.HeaderCode = sal_customer_sales_order.Code    " +
                "INNER JOIN mst_customer ON mst_customer.Code = sal_customer_sales_order.customerCode " +
                "WHERE sal_customer_sales_order.ValidStatus = 1 " +
                "AND sal_customer_sales_order.ClosingStatus = 'OPEN' " +
                "AND sal_customer_sales_order.BlanketOrderCode IS NULL " +
                "" +
                "UNION ALL    " +
                "" +
                "SELECT    " +
                "sal_customer_blanket_order_item_detail.Code AS documentOrderDetailCode,      " +
                "sal_customer_blanket_order_item_detail.HeaderCode AS documentOrderCode,   " +
                "sal_customer_blanket_order.transactionDate AS transactionDateDoc,  " +
                "sal_customer_blanket_order.customerCode,  " +
                "mst_customer.name AS customerName,  " +
                "sal_customer_blanket_order.refNo,  " +
                "sal_customer_blanket_order.remark AS remarkDoc   " +
                "FROM    " +
                "sal_customer_blanket_order_item_detail    " +
                "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = sal_customer_blanket_order_item_detail.ItemFinishGoodsCode    " +
                "INNER JOIN sal_customer_blanket_order ON sal_customer_blanket_order_item_detail.HeaderCode = sal_customer_blanket_order.Code    " +
                "INNER JOIN mst_customer ON mst_customer.Code = sal_customer_blanket_order.customerCode " +
                "WHERE sal_customer_blanket_order.ValidStatus = 1 " +
                "AND sal_customer_blanket_order.ClosingStatus = 'OPEN' " +
                "" +
                "UNION ALL    " +
                "" +
                "SELECT     " +
                "eng_internal_memo_production_detail.Code AS documentOrderDetailCode,     " +
                "eng_internal_memo_production_detail.HeaderCode AS documentOrderCode,    " +
                "eng_internal_memo_production.transactionDate AS transactionDateDoc,  " +
                "eng_internal_memo_production.customerCode,  " +
                "mst_customer.name AS customerName, " +
                "eng_internal_memo_production.refNo,  " +
                "eng_internal_memo_production.remark AS remarkDoc  " +
                "FROM    " +
                "eng_internal_memo_production_detail    " +
                "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = eng_internal_memo_production_detail.ItemFinishGoodsCode    " +
                "INNER JOIN eng_internal_memo_production ON eng_internal_memo_production_detail.HeaderCode = eng_internal_memo_production.Code    " +
                "INNER JOIN mst_customer ON mst_customer.Code = eng_internal_memo_production.customerCode " +
                "WHERE eng_internal_memo_production.ApprovalStatus = 'APPROVED' " +
                "AND eng_internal_memo_production.ClosingStatus = 'OPEN' " +
                ") bom "
                    + "WHERE bom.documentOrderDetailCode = '"+ detailCode +"' "
                   
            )
                .addScalar("documentOrderDetailCode", Hibernate.STRING)
                .addScalar("documentOrderCode", Hibernate.STRING)
                .addScalar("transactionDateDoc", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(BomTemp.class))
                .uniqueResult(); 
                 
                return bomTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataExisting(BillOfMaterial billOfMaterial) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(billOfMaterial.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(billOfMaterial.getTransactionLastDate());

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    " SELECT "
                            + "COUNT(eng_bill_of_material.code) "
                            + "FROM eng_bill_of_material "
                            + "WHERE eng_bill_of_material.code LIKE '%"+billOfMaterial.getCode()+"%'  " )
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<BillOfMaterial> findDataExisting(BillOfMaterial billOfMaterial,int from, int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(billOfMaterial.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(billOfMaterial.getTransactionLastDate());


            List<BillOfMaterial> list = (List<BillOfMaterial>)hbmSession.hSession.createSQLQuery(
                   " SELECT "
                           + "eng_bill_of_material.code, "
                           + "eng_bill_of_material.remark "
                    + "FROM eng_bill_of_material "
                    + "WHERE eng_bill_of_material.code LIKE '%"+billOfMaterial.getCode()+"%' "
                    + "LIMIT "+from+","+to+" " )
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterial.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BillOfMaterialPartDetail> findBomArrayImr(String docDetailCode){
        try{
            
            List<BillOfMaterialPartDetail> list = (List<BillOfMaterialPartDetail>)hbmSession.hSession.createSQLQuery(
                    " SELECT" +
                    "	eng_bill_of_material_part_detail.Code, " +
                    "	eng_bill_of_material_part_detail.HeaderCode, " +
                    "	eng_bill_of_material_part_detail.DocumentDetailCode, " +
                    "	document.documentSortNo, " +
                    "	eng_bill_of_material.ItemFinishGoodsCode, " +
                    "	mst_item_finish_goods.Remark AS itemFinishGoodsRemark, " +
                    "	eng_bill_of_material_part_detail.PartNo, " +
                    "	eng_bill_of_material_part_detail.PartCode, " +
                    "	mst_part.Name AS partName, " +
                    "	eng_bill_of_material_part_detail.DrawingCode, " +
                    "	eng_bill_of_material_part_detail.Dimension, " +
                    "	eng_bill_of_material_part_detail.RequiredLength, " +
                    "	eng_bill_of_material_part_detail.Material, " +
                    "	eng_bill_of_material_part_detail.Quantity, " +
                    "	eng_bill_of_material_part_detail.Requirement, " +
                    "	eng_bill_of_material_part_detail.ProcessedStatus, " +
                    "	eng_bill_of_material_part_detail.Remark, " +
                    "	eng_bill_of_material_part_detail.X, " +
                    "	eng_bill_of_material_part_detail.RevNo, " +
                    "	ppic_production_planning_order_item_detail.DocumentSortNo AS itemPPONo, " +
                    "	ppic_production_planning_order_item_detail.Code AS ppoDetailCode, " +
                    "	IFNULL(ppic_item_material_request.Code,'') AS imrNo, " +
                    "	CASE "
                            + "WHEN ppic_item_material_request.TransactionDate IS NULL THEN NULL "
                            + "ELSE ppic_item_material_request.TransactionDate "
                    + "END AS imrDate " +
                    "FROM eng_bill_of_material_part_detail "
                    + "INNER JOIN ( " +
                            "SELECT " +
                                "sal_customer_sales_order_item_detail.Code AS documentOrderDetailCode, " +
                                "sal_customer_sales_order_item_detail.CustomerPurchaseOrderSortNo AS documentSortNo " +
                                "FROM sal_customer_sales_order_item_detail " +
                                "INNER JOIN sal_customer_sales_order " +
                                    "ON sal_customer_sales_order_item_detail.HeaderCode = sal_customer_sales_order.Code " +
                                "WHERE sal_customer_sales_order.ValidStatus = 1 " +
                                "AND sal_customer_sales_order.ClosingStatus = 'OPEN' " +
                                "AND sal_customer_sales_order.BlanketOrderCode IS NULL " +
                                "       " +
                            "UNION ALL " +
                            "SELECT " +
                                "sal_customer_blanket_order_item_detail.Code AS documentOrderDetailCode, " +
                                "sal_customer_blanket_order_item_detail.CustomerPurchaseOrderSortNo AS documentSortNo " +
                            "FROM sal_customer_blanket_order_item_detail " +
                            "INNER JOIN sal_customer_blanket_order " +
                                "ON sal_customer_blanket_order_item_detail.HeaderCode = sal_customer_blanket_order.Code " +
                            "WHERE sal_customer_blanket_order.ValidStatus = 1 " +
                            "AND sal_customer_blanket_order.ClosingStatus = 'OPEN' " +
                                "        " +
                            "UNION ALL " +
                            "SELECT " +
                            "	eng_internal_memo_production_detail.Code AS documentOrderDetailCode, " +
                            "	eng_internal_memo_production_detail.InternalMemoSortNo AS documentSortNo " +
                            "FROM eng_internal_memo_production_detail " +
                            "INNER JOIN eng_internal_memo_production " +
                            "	ON eng_internal_memo_production_detail.HeaderCode = eng_internal_memo_production.Code " +
                            "WHERE eng_internal_memo_production.ApprovalStatus = 'APPROVED' " +
                            "AND eng_internal_memo_production.ClosingStatus = 'OPEN' " +
                    ") document ON eng_bill_of_material_part_detail.DocumentDetailCode = document.documentOrderDetailCode  " +
                    "	INNER JOIN ppic_production_planning_order_item_detail ON ppic_production_planning_order_item_detail.DocumentDetailCode = eng_bill_of_material_part_detail.DocumentDetailCode " +
                    "	INNER JOIN ppic_production_planning_order ON ppic_production_planning_order.Code = ppic_production_planning_order_item_detail.HeaderCode " +
                    "	INNER JOIN eng_bill_of_material ON eng_bill_of_material.Code = eng_bill_of_material_part_detail.HeaderCode " +
                    "	INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = eng_bill_of_material.ItemFinishGoodsCode " +
                    "	INNER JOIN mst_part ON mst_part.Code = eng_bill_of_material_part_detail.PartCode " +
                    "	LEFT JOIN ppic_item_material_request ON ppic_item_material_request.ProductionPlanningOrderCode = ppic_production_planning_order.Code " +
                    "	WHERE ppic_production_planning_order.code = '"+docDetailCode+"' "
                        + "AND ppic_production_planning_order.ApprovalStatus = 'APPROVED'"
                        + "AND ppic_production_planning_order.ClosingStatus = 'OPEN' "
                    + "GROUP BY eng_bill_of_material_part_detail.Code "
            )
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("ppoDetailCode", Hibernate.STRING)
                    .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                    .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                    .addScalar("documentSortNo", Hibernate.BIG_DECIMAL)
                    .addScalar("itemPPONo", Hibernate.BIG_DECIMAL)
                    .addScalar("imrNo", Hibernate.STRING)
                    .addScalar("imrDate", Hibernate.TIMESTAMP)
                    .addScalar("partNo", Hibernate.BIG_DECIMAL)
                    .addScalar("documentDetailCode", Hibernate.STRING)
                    .addScalar("partCode", Hibernate.STRING)
                    .addScalar("partName", Hibernate.STRING)
                    .addScalar("drawingCode", Hibernate.STRING)
                    .addScalar("dimension", Hibernate.STRING)
                    .addScalar("material", Hibernate.STRING)
                    .addScalar("requiredLength", Hibernate.BIG_DECIMAL)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("requirement", Hibernate.STRING)
                    .addScalar("processedStatus", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("x", Hibernate.STRING)
                    .addScalar("revNo", Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(BillOfMaterialPartDetail.class))
                .list(); 

            return list;
            
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0) {
                return 0;
            } else {
                return ((Integer) criteria.list().get(0)).intValue();
            }
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public BillOfMaterial get(String code) {
        try {
               return (BillOfMaterial) hbmSession.hSession.get(BillOfMaterial.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity, BillOfMaterial billOfMaterial){
        try{
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                acronim = "BOM";
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_4;
            }
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                acronim = billOfMaterial.getBomNo()+ splitter;
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_2;
            }

            DetachedCriteria dc = DetachedCriteria.forClass(BillOfMaterial.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

           String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                            oldID = list.get(0).toString().split("["+splitter+"]",2)[0];
                        }
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_rev(enumActivity,acronim, oldID, transactionLength);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,BillOfMaterial billOfMaterial,
            List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail, String MODULECODE) throws Exception {
        try {

            String headerCode = createCode(enumActivity,billOfMaterial);

            hbmSession.hSession.beginTransaction();

            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                
                String oldBomCode=billOfMaterial.getRefBomCode();
                BillOfMaterial billOfMaterialOld=get(oldBomCode);
                billOfMaterialOld.setValidStatus(false);
                
                hbmSession.hSession.update(billOfMaterialOld);
                
                billOfMaterial.setRefBomCode(billOfMaterialOld.getCode());
                billOfMaterial.setCode(headerCode);
                billOfMaterial.setRevision(billOfMaterial.getCode().substring(billOfMaterial.getCode().length()-2));
                billOfMaterial.setApprovalStatus("APPROVED");
                billOfMaterial.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                billOfMaterial.setCreatedDate(new Date());
            }else{
                billOfMaterial.setCode(headerCode);
                billOfMaterial.setBomNo(billOfMaterial.getCode().split("["+CommonConst.spliterNo+"]")[0]);
                billOfMaterial.setApprovalStatus("PENDING");
                billOfMaterial.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                billOfMaterial.setCreatedDate(new Date());
            }
            
            hbmSession.hSession.save(billOfMaterial);

            if (listBillOfMaterialPartDetail == null) {
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA ITEM DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed Or Others!<B/>");
            }

            int i = 1;
            for (BillOfMaterialPartDetail billOfMaterialPartDetail : listBillOfMaterialPartDetail) {
                String detailCode = billOfMaterial.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                billOfMaterialPartDetail.setCode(detailCode);
                billOfMaterialPartDetail.setHeaderCode(headerCode);
                billOfMaterialPartDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                billOfMaterialPartDetail.setCreatedDate(new Date());

                hbmSession.hSession.save(billOfMaterialPartDetail);

                i++;
            }

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    billOfMaterial.getCode(), ""));
            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(BillOfMaterial billOfMaterial, List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            if (!updateDetail(billOfMaterial, listBillOfMaterialPartDetail)) {
                hbmSession.hTransaction.rollback();
            }

            billOfMaterial.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            billOfMaterial.setUpdatedDate(new Date());
            hbmSession.hSession.update(billOfMaterial);

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE),
                    billOfMaterial.getCode(), ""));

            hbmSession.hTransaction.commit();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
    private boolean updateDetail(BillOfMaterial billOfMaterial, List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail) throws Exception {
        try {
            hbmSession.hSession.createQuery("DELETE FROM " + BillOfMaterialPartDetailField.BEAN_NAME
                    + " WHERE " + BillOfMaterialPartDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", billOfMaterial.getCode())
                    .executeUpdate();

            int i = 1;
            for (BillOfMaterialPartDetail billOfMaterialPartDetail : listBillOfMaterialPartDetail) {

                billOfMaterialPartDetail.setHeaderCode(billOfMaterial.getCode());
                String detailCode = billOfMaterial.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                billOfMaterialPartDetail.setCode(detailCode);
                billOfMaterialPartDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                billOfMaterialPartDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(billOfMaterialPartDetail);

                i++;

            }

            return Boolean.TRUE;

        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void approval(BillOfMaterial billOfMaterial,String moduleCode) throws Exception{
        try {
            
            String approvalBy="";
            Date approvalDate=commonFunction.setDateTime("01/01/1900 00:00:00");
                        
            if(billOfMaterial.getApprovalStatus().equals(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED.toString())){
                approvalBy=BaseSession.loadProgramSession().getUserName();
                approvalDate=new Date();
            }

            hbmSession.hSession.beginTransaction();
            
             String prmActivity = "";
            if ("APPROVED".equals(billOfMaterial.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.APPROVED);
            }else if ("REJECTED".equals(billOfMaterial.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.REJECTED);
            }
//            purchaseOrder.setLastStatus(prmActivity);
            billOfMaterial.setApprovalBy(approvalBy);
            billOfMaterial.setApprovalDate(approvalDate);
            //hbmSession.hSession.update(purchaseOrder);
            
            hbmSession.hSession.createQuery("UPDATE BillOfMaterial SET "
                    + "ApprovalStatus = :prmApprovalstatus, "
                    + "ApprovalBy = :prmApprovalBy, "
                    + "ApprovalDate = :prmApprovalDate, "
                    + "ApprovalRemark = :prmApprovalRemark, "
                    + "approvalReason = :prmApprovalReason "
                    + "WHERE code = :prmCode")
                    .setParameter("prmApprovalstatus", prmActivity)
                    .setParameter("prmApprovalBy", BaseSession.loadProgramSession().getUserName())
                    .setParameter("prmApprovalDate", new Date())
                    .setParameter("prmApprovalRemark", billOfMaterial.getApprovalRemark())
                    .setParameter("prmApprovalReason", billOfMaterial.getApprovalReason())
                    .setParameter("prmCode", billOfMaterial.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
                       
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    billOfMaterial.getCode(), "Approval: "+billOfMaterial.getApprovalStatus()));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.close();
        } catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
}
