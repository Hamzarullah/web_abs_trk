/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.ppic.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import com.inkombizz.ppic.model.ProductionPlanningOrderField;
import com.inkombizz.ppic.model.ProductionPlanningOrderItemDetail;
import com.inkombizz.ppic.model.ProductionPlanningOrderItemDetailField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
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
 * @author diphda
 */
public class ProductionPlanningOrderDAO {
     private HBMSession hbmSession;
     private CommonFunction commonFunction=new CommonFunction();

    public ProductionPlanningOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }
    public int countData(ProductionPlanningOrder productionPlanningOrder) {
        try {

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_order_list(:prmFlag,'%"+productionPlanningOrder.getCode()+"%','%"+productionPlanningOrder.getCustomerCode()+"%','%"+productionPlanningOrder.getCustomerName()+"%',"
                    + "'%"+productionPlanningOrder.getRemark()+"%','%"+productionPlanningOrder.getRefNo()+"%','%"+productionPlanningOrder.getDocumentType()+"%','%"+productionPlanningOrder.getApprovalStatus()+"%',:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
//                .setParameter("prmCode", "%"+productionPlanningOrder.getCode()+"%")
//                .setParameter("prmCustomerCode", "%"+productionPlanningOrder.getCustomerCode()+"%")
//                .setParameter("prmCustomerName", "%"+productionPlanningOrder.getCustomerName()+"%")
//                .setParameter("prmRemark", "%"+productionPlanningOrder.getRemark()+"%")
//                .setParameter("prmRefNo", "%"+productionPlanningOrder.getRefNo()+"%")
//                .setParameter("prmDocumentType", "%"+productionPlanningOrder.getDocumentType()+"%")
//                .setParameter("prmApprovalStatus", "%"+productionPlanningOrder.getApprovalStatus()+"%")
                .setParameter("prmFirstDate", productionPlanningOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", productionPlanningOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataBom(ProductionPlanningOrder productionPlanningOrderItemBillOfMaterial) {
        try {

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                " SELECT "
                +" COUNT(ppic_production_planning_order.Code) "
                +" FROM ppic_production_planning_order "
                +" INNER JOIN mst_branch ON ppic_production_planning_order.BranchCode = mst_branch.Code "
                +" INNER JOIN mst_customer ON ppic_production_planning_order.CustomerCode = mst_customer.Code "
                +" WHERE "
                +" ppic_production_planning_order.Code LIKE '%"+productionPlanningOrderItemBillOfMaterial.getCode()+"%' "
                +" AND ppic_production_planning_order.ApprovalStatus = 'APPROVED' "
                +" AND ppic_production_planning_order.ClosingStatus = 'OPEN' "
            )
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ProductionPlanningOrder> findData(ProductionPlanningOrder productionPlanningOrder,int from, int to) {
        try {

            List<ProductionPlanningOrder> list = (List<ProductionPlanningOrder>)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmRemark,:prmRefNo,:prmDocumentType,:prmApprovalStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentCode", Hibernate.STRING)
                .addScalar("targetDate", Hibernate.TIMESTAMP) 
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+productionPlanningOrder.getCode()+"%")
                .setParameter("prmCustomerCode", "%"+productionPlanningOrder.getCustomerCode()+"%")
                .setParameter("prmCustomerName", "%"+productionPlanningOrder.getCustomerName()+"%")
                .setParameter("prmRemark", "%"+productionPlanningOrder.getRemark()+"%")
                .setParameter("prmRefNo", "%"+productionPlanningOrder.getRefNo()+"%")
                .setParameter("prmDocumentType", "%"+productionPlanningOrder.getDocumentType()+"%")
                .setParameter("prmApprovalStatus", "%"+productionPlanningOrder.getApprovalStatus()+"%")
                .setParameter("prmFirstDate", productionPlanningOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", productionPlanningOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ProductionPlanningOrder> findDataBom(ProductionPlanningOrder productionPlanningOrder,int from, int to) {
        try {

            List<ProductionPlanningOrder> list = (List<ProductionPlanningOrder>)hbmSession.hSession.createSQLQuery(
                " SELECT "
                    +" CASE "
                    +" WHEN IFNULL(qr1.HeaderCode,'') = '' THEN 'NO' "
                    +" WHEN IFNULL(qr1.HeaderCode,'') != '' THEN 'YES' "
                    +" END AS bomStatus, "
                    +" ppic_production_planning_order.Code, "
                    +" ppic_production_planning_order.BranchCode, "
                    +" mst_branch.Name AS BranchName, "
                    +" ppic_production_planning_order.TransactionDate, "
                    +" ppic_production_planning_order.DocumentType, "
                    +" ppic_production_planning_order.DocumentCode, "
                    +" ppic_production_planning_order.TargetDate, "
                    +" ppic_production_planning_order.CustomerCode, "
                    +" mst_customer.Name AS CustomerName, "
                    +" ppic_production_planning_order.RefNo, "
                    +" ppic_production_planning_order.Remark, "
                    +" ppic_production_planning_order.ApprovalStatus "
                +" FROM ppic_production_planning_order "
                +" INNER JOIN mst_branch ON ppic_production_planning_order.BranchCode = mst_branch.Code "
                +" INNER JOIN mst_customer ON ppic_production_planning_order.CustomerCode = mst_customer.Code "
                +" LEFT JOIN( "
                    +" SELECT "
                    +" ppic_production_planning_order_item_bill_of_material.Code, "
                    +" ppic_production_planning_order_item_bill_of_material.HeaderCode "
                    +" FROM "
                    +" ppic_production_planning_order_item_bill_of_material "
                +" ) qr1 ON qr1.HeaderCode = ppic_production_planning_order.Code "
            )                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentCode", Hibernate.STRING)
                .addScalar("targetDate", Hibernate.TIMESTAMP) 
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("bomStatus", Hibernate.STRING)
                
//                .setParameter("prmCode", "%"+productionPlanningOrder.getCode()+"%")
//                .setParameter("prmCustomerCode", "%"+productionPlanningOrder.getCustomerCode()+"%")
//                .setParameter("prmCustomerName", "%"+productionPlanningOrder.getCustomerName()+"%")
//                .setParameter("prmRemark", "%"+productionPlanningOrder.getRemark()+"%")
//                .setParameter("prmRefNo", "%"+productionPlanningOrder.getRefNo()+"%")
//                .setParameter("prmDocumentType", "%"+productionPlanningOrder.getDocumentType()+"%")
//                .setParameter("prmApprovalStatus", "%"+productionPlanningOrder.getApprovalStatus()+"%")
//                .setParameter("prmFirstDate", productionPlanningOrder.getTransactionFirstDate())
//                .setParameter("prmLastDate", productionPlanningOrder.getTransactionLastDate())
//                .setParameter("prmLimitFrom", from)
//                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataSearch(ProductionPlanningOrder productionPlanningOrder) {
        try {

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_order_search_list(:prmFlag,:prmCode,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+productionPlanningOrder.getCode()+"%")
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ProductionPlanningOrder> findDataSearch(ProductionPlanningOrder productionPlanningOrder,int from, int to) {
        try {

            List<ProductionPlanningOrder> list = (List<ProductionPlanningOrder>)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_order_search_list(:prmFlag,:prmCode,:prmLimitFrom,:prmLimitUpTo)")                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentCode", Hibernate.STRING)
                .addScalar("targetDate", Hibernate.TIMESTAMP) 
                
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+productionPlanningOrder.getCode()+"%")
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public ProductionPlanningOrder get(String code) {
        try {
               return (ProductionPlanningOrder) hbmSession.hSession.get(ProductionPlanningOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countApprovalData(String code,String remark,String refno,
            Date firstDate,Date lastDate,String customerCode,String customerName,String approvalStatus,String documentType) {
        try {
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_approval_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmRemark,:prmRefNo,:prmDocumentType,:prmApprovalStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmCustomerCode", "%"+customerCode+"%")
                .setParameter("prmCustomerName", "%"+customerName+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmRefNo", "%"+refno+"%")
                .setParameter("prmDocumentType", "%"+documentType+"%")
                .setParameter("prmApprovalStatus", "%"+approvalStatus+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ProductionPlanningOrder> findApprovalData(String code,String remark,String refno,
            Date firstDate,Date lastDate,String customerCode,String customerName,String approvalStatus,String documentType,int from, int to) {
        try {

            List<ProductionPlanningOrder> list = (List<ProductionPlanningOrder>)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_approval_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmRemark,:prmRefNo,:prmDocumentType,:prmApprovalStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentCode", Hibernate.STRING)
                .addScalar("targetDate", Hibernate.TIMESTAMP) 
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmCustomerCode", "%"+customerCode+"%")
                .setParameter("prmCustomerName", "%"+customerName+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmRefNo", "%"+refno+"%")
                .setParameter("prmDocumentType", "%"+documentType+"%")
                .setParameter("prmApprovalStatus", "%"+approvalStatus+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countClosingData(String code,String remark,String refno,
            Date firstDate,Date lastDate,String customerCode,String customerName,String closingStatus,String documentType) {
        try {
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_closing_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmRemark,:prmRefNo,:prmDocumentType,:prmClosingStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmCustomerCode", "%"+customerCode+"%")
                .setParameter("prmCustomerName", "%"+customerName+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmRefNo", "%"+refno+"%")
                .setParameter("prmDocumentType", "%"+documentType+"%")
                .setParameter("prmClosingStatus", "%"+closingStatus+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ProductionPlanningOrder> findClosingData(String code,String remark,String refno,
            Date firstDate,Date lastDate,String customerCode,String customerName,String closingStatus,String documentType,int from, int to) {
        try {

            List<ProductionPlanningOrder> list = (List<ProductionPlanningOrder>)hbmSession.hSession.createSQLQuery(
                "CALL usp_production_planning_closing_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmRemark,:prmRefNo,:prmDocumentType,:prmClosingStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentCode", Hibernate.STRING)
                .addScalar("targetDate", Hibernate.TIMESTAMP) 
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmCustomerCode", "%"+customerCode+"%")
                .setParameter("prmCustomerName", "%"+customerName+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmRefNo", "%"+refno+"%")
                .setParameter("prmDocumentType", "%"+documentType+"%")
                .setParameter("prmClosingStatus", "%"+closingStatus+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
     
    public List<ProductionPlanningOrderItemDetail> findDataItemDetail(String headerCode,String documentType) {
        try {
            List<ProductionPlanningOrderItemDetail> list = (List<ProductionPlanningOrderItemDetail>)hbmSession.hSession.createSQLQuery(
              "CALL usp_production_planning_order_item_detail_list(:prmHeaderCode,:prmDocumentType)")
                    
                .addScalar("documentSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("documentDetailCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("billOfMaterialCode", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("Description", Hibernate.STRING)
                    
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
                    
                .addScalar("orderQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("processedQty", Hibernate.BIG_DECIMAL)
                .addScalar("balancedQty", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode",headerCode)
                .setParameter("prmDocumentType",documentType)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrderItemDetail.class))
                .list(); 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ProductionPlanningOrderItemDetail> findDataBomItemDetail(String headerCode) {
        try {
            List<ProductionPlanningOrderItemDetail> list = (List<ProductionPlanningOrderItemDetail>)hbmSession.hSession.createSQLQuery(
            " SELECT "
                +" CASE "
                    +" WHEN IFNULL(qr2.HeaderCode,'') = '' THEN 'NO' "
                    +" WHEN IFNULL(qr2.HeaderCode,'') != '' THEN 'YES' "
                +" END AS bomStatus, "
                +" CASE "
                    +" WHEN IFNULL(qr2.ApprovalStatus,'') = '' THEN 'PENDING' "
                    +" WHEN IFNULL(qr2.ApprovalStatus,'') = 'PENDING' THEN 'PENDING' "
                    +" WHEN IFNULL(qr2.ApprovalStatus,'') = 'APPROVED' THEN 'APPROVED' "
                    +" WHEN IFNULL(qr2.ApprovalStatus,'') = 'REJECTED' THEN 'REJECTED' "
                +" END AS approvalStatus, "
                +" IFNULL(qr2.Code,'') AS bomCode, "
                +" ppic_production_planning_order_item_detail.Code, "
                +" ppic_production_planning_order_item_detail.HeaderCode, "
                +" ppic_production_planning_order_item_detail.DocumentDetailCode, "
                +" ppic_production_planning_order_item_detail.ItemFinishGoodsCode, "

                +" IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode,  "
                +" IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName,  "
                +" IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, " 
                +" IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName,  "
                +" IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode,  "
                +" IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName,  "
                +" IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode,  "
                +" IFNULL(mst_item_size.Name,'') AS itemSizeName,  "
                +" IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode,  "
                +" IFNULL(mst_item_rating.Name,'') AS itemRatingName,  "
                +" IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode,  "
                +" IFNULL(mst_item_bore.Name,'') AS itemBoreName,  "

                +" IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode,  "
                +" IFNULL(mst_item_end_con.Name,'') AS itemEndConName,  "
                +" IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode,  "
                +" IFNULL(mst_item_body.Name,'') AS itemBodyName,  "
                +" IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode,  "
                +" IFNULL(mst_item_ball.Name,'') AS itemBallName,  "
                +" IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode,  "
                +" IFNULL(mst_item_seat.Name,'') AS itemSeatName,  "
                +" IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode,  "
                +" IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName,  "
                +" IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode,  "
                +" IFNULL(mst_item_stem.Name,'') AS itemStemName,  "

                +" IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode,  "
                +" IFNULL(mst_item_seal.Name,'') AS itemSealName,  "
                +" IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode,  "
                +" IFNULL(mst_item_bolt.Name,'') AS itemBoltName,  "
                +" IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode,  "
                +" IFNULL(mst_item_disc.Name,'') AS itemDiscName,  "
                +" IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode,  "
                +" IFNULL(mst_item_plates.Name,'') AS itemPlatesName,  "
                +" IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode,  "
                +" IFNULL(mst_item_shaft.Name,'') AS itemShaftName,  "
                +" IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode,  "
                +" IFNULL(mst_item_spring.Name,'') ItemSpringName,  "

                +" IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, " 
                +" IFNULL(mst_item_arm.Name,'') AS itemArmPinName,  "
                +" IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode,  "
                +" IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName,  "
                +" IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode,  "
                +" IFNULL(mst_item_arm.Name,'') AS itemArmName,  "
                +" IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode,  "
                +" IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName,  "
                +" IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode,  "
                +" IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName,  "
                +" IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode,  "
                +" IFNULL(mst_item_operator.Name,'') AS itemOperatorName,  "

                +" ppic_production_planning_order_item_detail.Quantity "
            +" FROM "
                +" ppic_production_planning_order_item_detail "

            +" INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.code = ppic_production_planning_order_item_detail.ItemFinishGoodsCode  "
            +" LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode  "
            +" LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode  "
            +" LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode  "
            +" LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode  "
            +" LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode  "
            +" LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode  "

            +" LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode  "
            +" LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode  "
            +" LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode  "
            +" LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode  "
            +" LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode  "
            +" LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode  "

            +" LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode  "
            +" LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode  "
            +" LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode  "
            +" LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode  "
            +" LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode  "
            +" LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode  "

            +" LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode  "
            +" LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode  "
            +" LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode  "
            +" LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode  "
            +" LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode  "
            +" LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode  "
            +" LEFT JOIN( "
                +" SELECT "
                    +" ppic_production_planning_order_item_bill_of_material.Code, "
                    +" ppic_production_planning_order_item_bill_of_material.HeaderCode, "
                    +" ppic_production_planning_order_item_bill_of_material.ItemFinishGoodsCode, "
                    +" ppic_production_planning_order_item_bill_of_material.ApprovalReasonCode, "
                    +" ppic_production_planning_order_item_bill_of_material.ApprovalStatus "
                +" FROM "
                    +" ppic_production_planning_order_item_bill_of_material "
            +" ) AS qr2 ON qr2.ItemFinishGoodsCode = ppic_production_planning_order_item_detail.ItemFinishGoodsCode  "
            +" AND qr2.HeaderCode = ppic_production_planning_order_item_detail.Code "
            +" WHERE ppic_production_planning_order_item_detail.HeaderCode = :prmHeaderCode"
              )
                    
//                .addScalar("documentSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("code", Hibernate.STRING)
                .addScalar("documentDetailCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("bomStatus", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("bomCode", Hibernate.STRING)
//                .addScalar("Description", Hibernate.STRING)
                    
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
                    
//                .addScalar("orderQuantity", Hibernate.BIG_DECIMAL)
//                .addScalar("processedQty", Hibernate.BIG_DECIMAL)
//                .addScalar("balancedQty", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode",headerCode)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrderItemDetail.class))
                .list(); 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ProductionPlanningOrderItemDetail> findApprovalDataItemDetail(String headerCode,String documentType) {
        try {
            List<ProductionPlanningOrderItemDetail> list = (List<ProductionPlanningOrderItemDetail>)hbmSession.hSession.createSQLQuery(
              "CALL usp_production_planning_order_item_detail_list(:prmHeaderCode,:prmDocumentType)")
                    
                .addScalar("documentSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("documentDetailCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("billOfMaterialCode", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("Description", Hibernate.STRING)
                    
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
                    
                .addScalar("orderQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("processedQty", Hibernate.BIG_DECIMAL)
                .addScalar("balancedQty", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode",headerCode)
                .setParameter("prmDocumentType",documentType)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrderItemDetail.class))
                .list(); 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ProductionPlanningOrderItemDetail> findClosingDataItemDetail(String headerCode,String documentType) {
        try {
            List<ProductionPlanningOrderItemDetail> list = (List<ProductionPlanningOrderItemDetail>)hbmSession.hSession.createSQLQuery(
              "CALL usp_production_planning_order_item_detail_list(:prmHeaderCode,:prmDocumentType)")
                    
                .addScalar("documentSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("documentDetailCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("billOfMaterialCode", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("Description", Hibernate.STRING)
                    
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
                    
                .addScalar("orderQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("processedQty", Hibernate.BIG_DECIMAL)
                .addScalar("balancedQty", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode",headerCode)
                .setParameter("prmDocumentType",documentType)
                .setResultTransformer(Transformers.aliasToBean(ProductionPlanningOrderItemDetail.class))
                .list(); 
                return list;
        } catch (HibernateException e) {
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
    
    private String createCode(ProductionPlanningOrder productionPlanning) {
        try {
            String tempKode = "PPO";
            String acronim = productionPlanning.getBranch().getCode() + "/" +tempKode + "/"+AutoNumber.formatingDate(productionPlanning.getTransactionDate(), true, true, false);
            
            DetachedCriteria dc = DetachedCriteria.forClass(ProductionPlanningOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%"));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if (list != null) {
                if (list.size() > 0) {
                    if (list.get(0) != null) {
                        oldID = list.get(0).toString();
                    }
                }
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_4);
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    public void save(ProductionPlanningOrder productionPlanning, List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderDetail, String MODULECODE) throws Exception {
        try {

            String headerCode = createCode(productionPlanning);

            hbmSession.hSession.beginTransaction();

            productionPlanning.setCode(headerCode);
            productionPlanning.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            productionPlanning.setCreatedDate(new Date());

            hbmSession.hSession.save(productionPlanning);

            if (listProductionPlanningOrderDetail == null) {
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA ITEM DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed Or Others!<B/>");
            }

            int i = 1;
            for (ProductionPlanningOrderItemDetail productionPlanningDetail : listProductionPlanningOrderDetail) {
                String detailCode = productionPlanning.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                productionPlanningDetail.setCode(detailCode);
                productionPlanningDetail.setHeaderCode(headerCode);
                productionPlanningDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                productionPlanningDetail.setCreatedDate(new Date());
                productionPlanningDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                productionPlanningDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(productionPlanningDetail);

                i++;
            }

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    productionPlanning.getCode(), ""));
            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    public void update(ProductionPlanningOrder productionPlanning, List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            if (!updateDetail(productionPlanning, listProductionPlanningOrderDetail)) {
                hbmSession.hTransaction.rollback();
            }

            productionPlanning.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            productionPlanning.setUpdatedDate(new Date());
            hbmSession.hSession.update(productionPlanning);

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE),
                    productionPlanning.getCode(), ""));

            hbmSession.hTransaction.commit();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    private boolean updateDetail(ProductionPlanningOrder productionPlanning, List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderDetail) throws Exception {
        try {
            hbmSession.hSession.createQuery("DELETE FROM " + ProductionPlanningOrderItemDetailField.BEAN_NAME
                    + " WHERE " + ProductionPlanningOrderItemDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", productionPlanning.getCode())
                    .executeUpdate();

            int i = 1;
            for (ProductionPlanningOrderItemDetail productionPlanningDetail : listProductionPlanningOrderDetail) {

                productionPlanningDetail.setHeaderCode(productionPlanning.getCode());
                String detailCode = productionPlanning.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                productionPlanningDetail.setCode(detailCode);
                productionPlanningDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                productionPlanningDetail.setCreatedDate(new Date());
                productionPlanningDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                productionPlanningDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(productionPlanningDetail);

                i++;

            }

            return Boolean.TRUE;

        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }

    public void delete(String code, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            hbmSession.hSession.createQuery("DELETE FROM " + ProductionPlanningOrderItemDetailField.BEAN_NAME
                    + " WHERE " + ProductionPlanningOrderItemDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();

            hbmSession.hSession.flush();

            hbmSession.hSession.createQuery("DELETE FROM " + ProductionPlanningOrderField.BEAN_NAME
                    + " WHERE " + ProductionPlanningOrderField.CODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE),
                    code, ""));

            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void approval(ProductionPlanningOrder productionPlanningOrder,String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            ProductionPlanningOrder productionPlanningOrderOld=(ProductionPlanningOrder)get(productionPlanningOrder.getCode());
            
            String approvalBy="";
            Date approvalDate=commonFunction.setDateTime("01/01/1900 00:00:00");
                        
            if(productionPlanningOrder.getApprovalStatus().equals(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED.toString())){
                
                approvalBy=BaseSession.loadProgramSession().getUserName();
                approvalDate=new Date();
            }
            
            String prmActivity = "";
            if ("APPROVED".equals(productionPlanningOrder.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.APPROVED);
            }else if ("REJECTED".equals(productionPlanningOrder.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.REJECTED);
            }
            
            productionPlanningOrderOld.setApprovalStatus(prmActivity);
            productionPlanningOrderOld.setApprovalBy(approvalBy);
            productionPlanningOrderOld.setApprovalDate(approvalDate);
            productionPlanningOrderOld.setApprovalRemark(productionPlanningOrder.getApprovalRemark());
            productionPlanningOrderOld.setApprovalReason(productionPlanningOrder.getApprovalReason());
            hbmSession.hSession.update(productionPlanningOrderOld);
                        
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    productionPlanningOrder.getCode(), "Production Planning Order - Approval"));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void closing(ProductionPlanningOrder productionPlanningOrder,String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            ProductionPlanningOrder productionPlanningOrderOld=(ProductionPlanningOrder)get(productionPlanningOrder.getCode());
            
            String closingBy="";
            Date closingDate=commonFunction.setDateTime("01/01/1900 00:00:00");
            
            closingBy=BaseSession.loadProgramSession().getUserName();
            closingDate=new Date();
            
            productionPlanningOrderOld.setClosingStatus("CLOSED");
            productionPlanningOrderOld.setClosingBy(closingBy);
            productionPlanningOrderOld.setClosingDate(closingDate);
            productionPlanningOrderOld.setClosingRemark(productionPlanningOrder.getClosingRemark());
            hbmSession.hSession.update(productionPlanningOrderOld);
                        
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    productionPlanningOrder.getCode(), "Production Planning Order - Closing"));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
}
