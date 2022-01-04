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
import com.inkombizz.ppic.model.ItemMaterialRequest;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingDetailField;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingPartDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemBookingPartDetailField;
import com.inkombizz.ppic.model.ItemMaterialRequestItemProcessedPartDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemProcessedPartDetailField;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestDetailField;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestPartDetail;
import com.inkombizz.ppic.model.ItemMaterialRequestItemRequestPartDetailField;
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
 * @author Sukha Vaddhana
 */
public class ItemMaterialRequestDAO {
    private HBMSession hbmSession;
     private CommonFunction commonFunction=new CommonFunction();

    public ItemMaterialRequestDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(ItemMaterialRequest itemMaterialRequest) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(itemMaterialRequest.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(itemMaterialRequest.getTransactionLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                " SELECT "
                +" COUNT(ppic_item_material_request.Code) "
                +" FROM ppic_item_material_request "
                +" INNER JOIN ppic_production_planning_order ON ppic_production_planning_order.Code = ppic_item_material_request.ProductionPlanningOrderCode "
                +" INNER JOIN mst_customer ON ppic_production_planning_order.CustomerCode = mst_customer.Code "
                +" WHERE ppic_item_material_request.Code LIKE '%"+itemMaterialRequest.getCode()+"%' "
                +" AND ppic_item_material_request.ProductionPlanningOrderCode LIKE '%"+itemMaterialRequest.getProductionPlanningOrderCode()+"%' "
                +" AND ppic_production_planning_order.CustomerCode LIKE '%"+itemMaterialRequest.getCustomerCode()+"%' "
                +" AND mst_customer.name LIKE '%"+itemMaterialRequest.getCustomerName()+"%' "
                +" AND ppic_item_material_request.refNo LIKE '%"+itemMaterialRequest.getRefNo()+"%' "
                +" AND ppic_item_material_request.remark LIKE '%"+itemMaterialRequest.getRemark()+"%' "
                +" AND DATE(ppic_item_material_request.TransactionDate) BETWEEN DATE('"+dateFirst+"') AND DATE('"+dateLast+"') "
            )
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemMaterialRequest> findData(ItemMaterialRequest itemMaterialRequest, int from, int to){
        try{
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(itemMaterialRequest.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(itemMaterialRequest.getTransactionLastDate());
            
            List<ItemMaterialRequest> list = (List<ItemMaterialRequest>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "ppic_item_material_request.Code, " +
                    "ppic_item_material_request.TransactionDate, " +
                    "ppic_item_material_request.ProductionPlanningOrderCode, " +
                    "ppic_production_planning_order.DocumentType, " +
                    "ppic_production_planning_order.DocumentCode AS documentNo, " +
                    "ppic_production_planning_order.TransactionDate AS ppoDate, " +
                    "ppic_production_planning_order.TargetDate, " +
                    "ppic_production_planning_order.CustomerCode, " +
                    "mst_customer.Name AS customerName, " +
                    "ppic_item_material_request.RefNo, " +
                    "ppic_item_material_request.Remark " +
                    "FROM ppic_item_material_request " +
                    "INNER JOIN ppic_production_planning_order ON ppic_production_planning_order.Code = ppic_item_material_request.ProductionPlanningOrderCode " +
                    "INNER JOIN mst_customer ON mst_customer.Code = ppic_production_planning_order.CustomerCode " +
                    "WHERE ppic_item_material_request.Code LIKE '%"+itemMaterialRequest.getCode()+"%' " +
                    "AND ppic_item_material_request.ProductionPlanningOrderCode LIKE '%"+itemMaterialRequest.getProductionPlanningOrderCode()+"%' " +
                    "AND ppic_production_planning_order.CustomerCode LIKE '%"+itemMaterialRequest.getCustomerCode()+"%' " +
                    "AND mst_customer.name LIKE '%"+itemMaterialRequest.getCustomerName()+"%' " +
                    "AND ppic_item_material_request.refNo LIKE '%"+itemMaterialRequest.getRefNo()+"%' " +
                    "AND ppic_item_material_request.remark LIKE '%"+itemMaterialRequest.getRemark()+"%' " +
                    "AND DATE(ppic_item_material_request.TransactionDate) BETWEEN DATE('"+dateFirst+"') AND DATE('"+dateLast+"') " +
                    "LIMIT "+from+","+to+"")
                    
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("productionPlanningOrderCode", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .addScalar("documentType", Hibernate.STRING)
                    .addScalar("ppoDate", Hibernate.TIMESTAMP)
                    .addScalar("targetDate", Hibernate.TIMESTAMP)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequest.class))
                    .list(); 
                    return list;
        }catch (HibernateException e){
            throw e;
        }
    }
    
    public int countDataApproval(ItemMaterialRequest itemMaterialRequestApproval) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(itemMaterialRequestApproval.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(itemMaterialRequestApproval.getTransactionLastDate());
            
            String concat_qry="";
            if(!itemMaterialRequestApproval.getApprovalStatus().equals("")){
                concat_qry="AND ppic_item_material_request.ApprovalStatus= '"+itemMaterialRequestApproval.getApprovalStatus()+"' ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                " SELECT "
                +" COUNT(ppic_item_material_request.Code) "
                +" FROM ppic_item_material_request "
                +" INNER JOIN ppic_production_planning_order ON ppic_production_planning_order.Code = ppic_item_material_request.ProductionPlanningOrderCode "
                +" INNER JOIN mst_customer ON ppic_production_planning_order.CustomerCode = mst_customer.Code "
                +" WHERE ppic_item_material_request.Code LIKE '%"+itemMaterialRequestApproval.getCode()+"%' "
                +" AND ppic_item_material_request.ProductionPlanningOrderCode LIKE '%"+itemMaterialRequestApproval.getProductionPlanningOrderCode()+"%' "
                +" AND ppic_production_planning_order.CustomerCode LIKE '%"+itemMaterialRequestApproval.getCustomerCode()+"%' "
                +" AND mst_customer.name LIKE '%"+itemMaterialRequestApproval.getCustomerName()+"%' "
                +" AND ppic_item_material_request.refNo LIKE '%"+itemMaterialRequestApproval.getRefNo()+"%' "
                +" AND ppic_item_material_request.remark LIKE '%"+itemMaterialRequestApproval.getRemark()+"%' "
                +concat_qry        
                +" AND DATE(ppic_item_material_request.TransactionDate) BETWEEN DATE('"+dateFirst+"') AND DATE('"+dateLast+"') "
            )
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemMaterialRequest> findDataApproval(ItemMaterialRequest itemMaterialRequestApproval, int from, int to){
        try{
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(itemMaterialRequestApproval.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(itemMaterialRequestApproval.getTransactionLastDate());
            
            String concat_qry="";
            if(!itemMaterialRequestApproval.getApprovalStatus().equals("")){
                concat_qry="AND ppic_item_material_request.ApprovalStatus='"+itemMaterialRequestApproval.getApprovalStatus()+"' ";
            }
            
            List<ItemMaterialRequest> list = (List<ItemMaterialRequest>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "ppic_item_material_request.Code, " +
                    "ppic_item_material_request.TransactionDate, " +
                    "ppic_item_material_request.ProductionPlanningOrderCode, " +
                    "ppic_production_planning_order.DocumentType, " +
                    "ppic_production_planning_order.DocumentCode AS documentNo, " +
                    "ppic_production_planning_order.TransactionDate AS ppoDate, " +
                    "ppic_production_planning_order.TargetDate, " +
                    "ppic_production_planning_order.CustomerCode, " +
                    "mst_customer.Name AS customerName, " +
                    "ppic_item_material_request.approvalStatus, " +
                    "ppic_item_material_request.RefNo, " +
                    "ppic_item_material_request.Remark " +
                    "FROM ppic_item_material_request " +
                    "INNER JOIN ppic_production_planning_order ON ppic_production_planning_order.Code = ppic_item_material_request.ProductionPlanningOrderCode " +
                    "INNER JOIN mst_customer ON mst_customer.Code = ppic_production_planning_order.CustomerCode " +
                    "WHERE ppic_item_material_request.Code LIKE '%"+itemMaterialRequestApproval.getCode()+"%' " +
                    "AND ppic_item_material_request.ProductionPlanningOrderCode LIKE '%"+itemMaterialRequestApproval.getProductionPlanningOrderCode()+"%' " +
                    "AND ppic_production_planning_order.CustomerCode LIKE '%"+itemMaterialRequestApproval.getCustomerCode()+"%' " +
                    "AND mst_customer.name LIKE '%"+itemMaterialRequestApproval.getCustomerName()+"%' " +
                    "AND ppic_item_material_request.refNo LIKE '%"+itemMaterialRequestApproval.getRefNo()+"%' " +
                    "AND ppic_item_material_request.remark LIKE '%"+itemMaterialRequestApproval.getRemark()+"%' " +
                    concat_qry +
                    "AND DATE(ppic_item_material_request.TransactionDate) BETWEEN DATE('"+dateFirst+"') AND DATE('"+dateLast+"') " +
                    "LIMIT "+from+","+to+"")
                    
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("productionPlanningOrderCode", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .addScalar("documentType", Hibernate.STRING)
                    .addScalar("ppoDate", Hibernate.TIMESTAMP)
                    .addScalar("targetDate", Hibernate.TIMESTAMP)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("approvalStatus", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequest.class))
                    .list(); 
                    return list;
        }catch (HibernateException e){
            throw e;
        }
    }
    
    public int countDataClosing(ItemMaterialRequest itemMaterialRequestClosing) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(itemMaterialRequestClosing.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(itemMaterialRequestClosing.getTransactionLastDate());
            
            String concat_qry="";
            if(!itemMaterialRequestClosing.getClosingStatus().equals("")){
                concat_qry="AND ppic_item_material_request.ClosingStatus= '"+itemMaterialRequestClosing.getClosingStatus()+"' ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                " SELECT "
                +" COUNT(ppic_item_material_request.Code) "
                +" FROM ppic_item_material_request "
                +" INNER JOIN ppic_production_planning_order ON ppic_production_planning_order.Code = ppic_item_material_request.ProductionPlanningOrderCode "
                +" INNER JOIN mst_customer ON ppic_production_planning_order.CustomerCode = mst_customer.Code "
                +" WHERE ppic_item_material_request.Code LIKE '%"+itemMaterialRequestClosing.getCode()+"%' "
                +" AND ppic_item_material_request.ProductionPlanningOrderCode LIKE '%"+itemMaterialRequestClosing.getProductionPlanningOrderCode()+"%' "
                +" AND ppic_production_planning_order.CustomerCode LIKE '%"+itemMaterialRequestClosing.getCustomerCode()+"%' "
                +" AND mst_customer.name LIKE '%"+itemMaterialRequestClosing.getCustomerName()+"%' "
                +" AND ppic_item_material_request.refNo LIKE '%"+itemMaterialRequestClosing.getRefNo()+"%' "
                +" AND ppic_item_material_request.remark LIKE '%"+itemMaterialRequestClosing.getRemark()+"%' "
                +concat_qry        
                +" AND DATE(ppic_item_material_request.TransactionDate) BETWEEN DATE('"+dateFirst+"') AND DATE('"+dateLast+"') "
            )
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemMaterialRequest> findDataClosing(ItemMaterialRequest itemMaterialRequestClosing, int from, int to){
        try{
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(itemMaterialRequestClosing.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(itemMaterialRequestClosing.getTransactionLastDate());
            
            String concat_qry="";
            if(!itemMaterialRequestClosing.getClosingStatus().equals("")){
                concat_qry="AND ppic_item_material_request.ClosingStatus='"+itemMaterialRequestClosing.getClosingStatus()+"' ";
            }
            
            List<ItemMaterialRequest> list = (List<ItemMaterialRequest>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "ppic_item_material_request.Code, " +
                    "ppic_item_material_request.TransactionDate, " +
                    "ppic_item_material_request.ProductionPlanningOrderCode, " +
                    "ppic_production_planning_order.DocumentType, " +
                    "ppic_production_planning_order.DocumentCode AS documentNo, " +
                    "ppic_production_planning_order.TransactionDate AS ppoDate, " +
                    "ppic_production_planning_order.TargetDate, " +
                    "ppic_production_planning_order.CustomerCode, " +
                    "mst_customer.Name AS customerName, " +
                    "ppic_item_material_request.approvalStatus, " +
                    "ppic_item_material_request.closingStatus, " +
                    "ppic_item_material_request.RefNo, " +
                    "ppic_item_material_request.Remark " +
                    "FROM ppic_item_material_request " +
                    "INNER JOIN ppic_production_planning_order ON ppic_production_planning_order.Code = ppic_item_material_request.ProductionPlanningOrderCode " +
                    "INNER JOIN mst_customer ON mst_customer.Code = ppic_production_planning_order.CustomerCode " +
                    "WHERE ppic_item_material_request.Code LIKE '%"+itemMaterialRequestClosing.getCode()+"%' " +
                    "AND ppic_item_material_request.ProductionPlanningOrderCode LIKE '%"+itemMaterialRequestClosing.getProductionPlanningOrderCode()+"%' " +
                    "AND ppic_production_planning_order.CustomerCode LIKE '%"+itemMaterialRequestClosing.getCustomerCode()+"%' " +
                    "AND mst_customer.name LIKE '%"+itemMaterialRequestClosing.getCustomerName()+"%' " +
                    "AND ppic_item_material_request.refNo LIKE '%"+itemMaterialRequestClosing.getRefNo()+"%' " +
                    "AND ppic_item_material_request.remark LIKE '%"+itemMaterialRequestClosing.getRemark()+"%' " +
                    concat_qry +
                    "AND DATE(ppic_item_material_request.TransactionDate) BETWEEN DATE('"+dateFirst+"') AND DATE('"+dateLast+"') " +
                    "LIMIT "+from+","+to+"")
                    
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("productionPlanningOrderCode", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .addScalar("documentType", Hibernate.STRING)
                    .addScalar("ppoDate", Hibernate.TIMESTAMP)
                    .addScalar("targetDate", Hibernate.TIMESTAMP)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("approvalStatus", Hibernate.STRING)
                    .addScalar("closingStatus", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequest.class))
                    .list(); 
                    return list;
        }catch (HibernateException e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemProcessedPartDetail> findProcessedPartDetail(String headerCode){
        try{
            List<ItemMaterialRequestItemProcessedPartDetail> list = (List<ItemMaterialRequestItemProcessedPartDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "ppic_item_material_request_item_processed_part_detail.Code, " +
                    "ppic_item_material_request_item_processed_part_detail.HeaderCode, " +
                    "ppic_item_material_request_item_processed_part_detail.DocumentDetailCode, " +
                    "eng_bill_of_material_part_detail.HeaderCode AS bomCode, " +
                    "eng_bill_of_material_part_detail.Code AS bomDetailCode, " +
                    "ppic_production_planning_order_item_detail.Code AS ppoDetailCode, " +
                    "ppic_production_planning_order_item_detail.HeaderCode AS ppoCode, " +
                    "ppic_item_material_request_item_processed_part_detail.DocumentSortNo, " +
                    "ppic_item_material_request_item_processed_part_detail.ItemProductionPlanningOrderNo, " +
                    "ppic_item_material_request_item_processed_part_detail.ItemFinishGoodsCode, " +
                    "mst_item_finish_goods.remark AS itemFinishGoodsRemark, " +
                    "eng_bill_of_material_part_detail.PartNo, " +
                    "eng_bill_of_material_part_detail.PartCode, " +
                    "mst_part.Name AS partName, " +
                    "eng_bill_of_material_part_detail.DrawingCode, " +
                    "eng_bill_of_material_part_detail.Dimension, " +
                    "eng_bill_of_material_part_detail.RequiredLength, " +
                    "eng_bill_of_material_part_detail.Material, " +
                    "eng_bill_of_material_part_detail.Requirement, " +
                    "eng_bill_of_material_part_detail.ProcessedStatus, " +
                    "eng_bill_of_material_part_detail.Remark, " +
                    "eng_bill_of_material_part_detail.x, " +
                    "eng_bill_of_material_part_detail.RevNo, " +
                    "eng_bill_of_material_part_detail.Quantity AS quantityBom " +
                    "FROM ppic_item_material_request_item_processed_part_detail " +
                    "INNER JOIN ppic_item_material_request ON ppic_item_material_request.Code = ppic_item_material_request_item_processed_part_detail.HeaderCode " +
                    "INNER JOIN ppic_production_planning_order_item_detail ON ppic_production_planning_order_item_detail.DocumentDetailCode = ppic_item_material_request_item_processed_part_detail.DocumentDetailCode " +
                    "INNER JOIN eng_bill_of_material_part_detail ON eng_bill_of_material_part_detail.HeaderCode = ppic_production_planning_order_item_detail.BillOfMaterialCode " +
                    "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = ppic_item_material_request_item_processed_part_detail.ItemFinishGoodsCode " +
                    "INNER JOIN mst_part ON mst_part.Code = eng_bill_of_material_part_detail.PartCode " +
                    "WHERE ppic_item_material_request_item_processed_part_detail.HeaderCode = '"+headerCode+"' " +
                    "GROUP BY eng_bill_of_material_part_detail.Code"
            )
             .addScalar("code", Hibernate.STRING)
             .addScalar("headerCode", Hibernate.STRING)
             .addScalar("bomDetailCode", Hibernate.STRING)
             .addScalar("documentDetailCode", Hibernate.STRING)
             .addScalar("documentSortNo", Hibernate.BIG_DECIMAL)
             .addScalar("itemFinishGoodsCode", Hibernate.STRING)
             .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
             .addScalar("itemProductionPlanningOrderNo", Hibernate.BIG_DECIMAL)
             .addScalar("partNo", Hibernate.BIG_DECIMAL)
             .addScalar("partCode", Hibernate.STRING)
             .addScalar("partName", Hibernate.STRING)
             .addScalar("drawingCode", Hibernate.STRING)
             .addScalar("dimension", Hibernate.STRING)
             .addScalar("requiredLength", Hibernate.STRING)
             .addScalar("material", Hibernate.STRING)
             .addScalar("requirement", Hibernate.STRING)
             .addScalar("processedStatus", Hibernate.STRING)
             .addScalar("remark", Hibernate.STRING)
             .addScalar("x", Hibernate.STRING)
             .addScalar("revNo", Hibernate.STRING)
             .addScalar("quantityBom", Hibernate.BIG_DECIMAL)
             .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequestItemProcessedPartDetail.class))
             .list(); 
             return list;
            
        }catch(HibernateException e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemBookingDetail> findItemBookingDetail(String headerCode){
        try{
            List<ItemMaterialRequestItemBookingDetail> list = (List<ItemMaterialRequestItemBookingDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT  " +
                    "ppic_item_material_request_item_booking_detail.Code, " +
                    "ppic_item_material_request_item_booking_detail.HeaderCode, " +
                    "ppic_item_material_request_item_booking_detail.ItemMaterialCode, " +
                    "mst_item_material.Name AS itemMaterialName, " +
                    "mst_item_material.UnitOfMeasureCode AS uomCode, " +
                    "mst_unit_of_measure.Name AS uomName, " +
                    "ppic_item_material_request_item_booking_detail.Remark, " +
                    "ppic_item_material_request_item_booking_detail.BookingQuantity " +
                    "FROM ppic_item_material_request_item_booking_detail " +
                    "INNER JOIN mst_item_material ON mst_item_material.Code = ppic_item_material_request_item_booking_detail.ItemMaterialCode " +
                    "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode " +
                    "WHERE ppic_item_material_request_item_booking_detail.HeaderCode = '"+headerCode+"' "
            )
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("bookingQuantity", Hibernate.BIG_DECIMAL)
                    .addScalar("uomCode", Hibernate.STRING)
                    .addScalar("uomName", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequestItemBookingDetail.class))
                    .list();
                    return list;
        }catch(HibernateException e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemBookingPartDetail> findItemBookingPartDetail(String headerCode){
        try{
            List<ItemMaterialRequestItemBookingPartDetail> list = (List<ItemMaterialRequestItemBookingPartDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                "	ppic_item_material_request_item_booking_part_detail.Code, " +
                "	ppic_item_material_request_item_booking_part_detail.HeaderCode, " +
                "	ppic_item_material_request_item_booking_part_detail.ItemMaterialRequestBookingDetailCode, " +
                "	imrBookingDetail.itemMaterialName, " +
                "	ppic_item_material_request_item_booking_part_detail.ProcessedPartDetailCode, " +
                "	ppic_item_material_request_item_processed_part_detail.DocumentDetailCode, " +
                "	ppic_item_material_request_item_processed_part_detail.ItemProductionPlanningOrderNo,   " +
                "	ppic_item_material_request_item_processed_part_detail.ItemFinishGoodsCode,   " +
                "	mst_item_finish_goods.remark AS itemFinishGoodsRemark,   " +
                "	eng_bill_of_material_part_detail.code AS bomDetailCode,   " +
                "	eng_bill_of_material_part_detail.PartNo,   " +
                "	eng_bill_of_material_part_detail.PartCode,   " +
                "	mst_part.Name AS partName,   " +
                "	eng_bill_of_material_part_detail.DrawingCode,   " +
                "	eng_bill_of_material_part_detail.Dimension,   " +
                "	eng_bill_of_material_part_detail.RequiredLength,   " +
                "	eng_bill_of_material_part_detail.Material,   " +
                "	eng_bill_of_material_part_detail.Requirement,   " +
                "	eng_bill_of_material_part_detail.ProcessedStatus,   " +
                "	eng_bill_of_material_part_detail.Remark,   " +
                "	eng_bill_of_material_part_detail.x,   " +
                "	eng_bill_of_material_part_detail.RevNo,   " +
                "	eng_bill_of_material_part_detail.Quantity AS quantityBom   " +
                "FROM ppic_item_material_request_item_booking_part_detail " +
                "INNER JOIN (SELECT  " +
                "		ppic_item_material_request_item_booking_detail.ItemMaterialCode, " +
                "		mst_item_material.Name AS itemMaterialName " +
                "	    FROM ppic_item_material_request_item_booking_detail " +
                "	    INNER JOIN mst_item_material ON mst_item_material.Code = ppic_item_material_request_item_booking_detail.ItemMaterialCode) " +
                "imrBookingDetail ON imrBookingDetail.ItemMaterialCode = ppic_item_material_request_item_booking_part_detail.ItemMaterialRequestBookingDetailCode " +
                "INNER JOIN ppic_item_material_request_item_processed_part_detail ON ppic_item_material_request_item_processed_part_detail.Code = ppic_item_material_request_item_booking_part_detail.ProcessedPartDetailCode " +
                "INNER JOIN ppic_item_material_request ON ppic_item_material_request.Code = ppic_item_material_request_item_booking_part_detail.HeaderCode  " +
                "INNER JOIN ppic_production_planning_order_item_detail ON ppic_production_planning_order_item_detail.DocumentDetailCode = ppic_item_material_request_item_processed_part_detail.DocumentDetailCode " +
                "INNER JOIN eng_bill_of_material_part_detail ON eng_bill_of_material_part_detail.HeaderCode = ppic_production_planning_order_item_detail.BillOfMaterialCode   " +
                "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = ppic_item_material_request_item_processed_part_detail.ItemFinishGoodsCode  " +
                "INNER JOIN mst_part ON mst_part.Code = eng_bill_of_material_part_detail.PartCode " +
                "WHERE ppic_item_material_request_item_booking_part_detail.HeaderCode = '"+headerCode+"' " +
                "GROUP BY eng_bill_of_material_part_detail.code"
            )
                    .addScalar("itemMaterialRequestBookingDetailCode",Hibernate.STRING)
                    .addScalar("itemMaterialName",Hibernate.STRING)
                    .addScalar("documentDetailCode",Hibernate.STRING)
                    .addScalar("itemFinishGoodsCode",Hibernate.STRING)
                    .addScalar("itemFinishGoodsRemark",Hibernate.STRING)
                    .addScalar("bomDetailCode",Hibernate.STRING)
                    .addScalar("partNo",Hibernate.BIG_DECIMAL)
                    .addScalar("partCode",Hibernate.STRING)
                    .addScalar("partName",Hibernate.STRING)
                    .addScalar("drawingCode",Hibernate.STRING)
                    .addScalar("dimension",Hibernate.STRING)
                    .addScalar("requiredLength",Hibernate.STRING)
                    .addScalar("material",Hibernate.STRING)
                    .addScalar("requirement",Hibernate.STRING)
                    .addScalar("processedStatus",Hibernate.STRING)
                    .addScalar("remark",Hibernate.STRING)
                    .addScalar("x",Hibernate.STRING)
                    .addScalar("revNo",Hibernate.STRING)
                    .addScalar("quantityBom",Hibernate.BIG_DECIMAL)
                    .addScalar("itemProductionPlanningOrderNo",Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequestItemBookingPartDetail.class))
                    .list();
            return list;
        }catch(HibernateException e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemRequestDetail> findItemRequestDetail(String headerCode){
        try{
            List<ItemMaterialRequestItemRequestDetail> list = (List<ItemMaterialRequestItemRequestDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT  " +
                    "ppic_item_material_request_item_purchase_request_detail.Code, " +
                    "ppic_item_material_request_item_purchase_request_detail.HeaderCode, " +
                    "ppic_item_material_request_item_purchase_request_detail.ItemMaterialCode, " +
                    "mst_item_material.Name AS itemMaterialName, " +
                    "mst_item_material.UnitOfMeasureCode AS uomCode, " +
                    "mst_unit_of_measure.name AS uomName, " +
                    "ppic_item_material_request_item_purchase_request_detail.Remark, " +
                    "ppic_item_material_request_item_purchase_request_detail.quantity " +
                    "FROM ppic_item_material_request_item_purchase_request_detail " +
                    "INNER JOIN mst_item_material ON mst_item_material.Code = ppic_item_material_request_item_purchase_request_detail.ItemMaterialCode " +
                    "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode " +
                    "WHERE ppic_item_material_request_item_purchase_request_detail.HeaderCode = '"+headerCode+"' "
            )
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("uomCode", Hibernate.STRING)
                    .addScalar("uomName", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequestItemRequestDetail.class))
                    .list();
                    return list;
        }catch(HibernateException e){
            throw e;
        }
    }
    
    public List<ItemMaterialRequestItemRequestPartDetail> findItemRequestPartDetail(String headerCode){
        try{
            List<ItemMaterialRequestItemRequestPartDetail> list = (List<ItemMaterialRequestItemRequestPartDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                "	ppic_item_material_request_item_purchase_request_part_detail.Code, " +
                "	ppic_item_material_request_item_purchase_request_part_detail.HeaderCode, " +
                "	ppic_item_material_request_item_purchase_request_part_detail.itemMaterialRequestPurchaseRequestDetailCode, " +
                "	imrBookingDetail.itemMaterialName, " +
                "	ppic_item_material_request_item_purchase_request_part_detail.ProcessedPartDetailCode, " +
                "	ppic_item_material_request_item_processed_part_detail.DocumentDetailCode, " +
                "	ppic_item_material_request_item_processed_part_detail.ItemProductionPlanningOrderNo,   " +
                "	ppic_item_material_request_item_processed_part_detail.ItemFinishGoodsCode,   " +
                "	mst_item_finish_goods.remark AS itemFinishGoodsRemark,   " +
                "	eng_bill_of_material_part_detail.code AS bomDetailCode,   " +
                "	eng_bill_of_material_part_detail.PartNo,   " +
                "	eng_bill_of_material_part_detail.PartCode,   " +
                "	mst_part.Name AS partName,   " +
                "	eng_bill_of_material_part_detail.DrawingCode,   " +
                "	eng_bill_of_material_part_detail.Dimension,   " +
                "	eng_bill_of_material_part_detail.RequiredLength,   " +
                "	eng_bill_of_material_part_detail.Material,   " +
                "	eng_bill_of_material_part_detail.Requirement,   " +
                "	eng_bill_of_material_part_detail.ProcessedStatus,   " +
                "	eng_bill_of_material_part_detail.Remark,   " +
                "	eng_bill_of_material_part_detail.x,   " +
                "	eng_bill_of_material_part_detail.RevNo,   " +
                "	eng_bill_of_material_part_detail.Quantity AS quantityBom   " +
                "FROM  ppic_item_material_request_item_purchase_request_part_detail " +
                "INNER JOIN (SELECT  " +
                "		ppic_item_material_request_item_purchase_request_detail.ItemMaterialCode, " +
                "		mst_item_material.Name AS itemMaterialName " +
                "	    FROM ppic_item_material_request_item_purchase_request_detail " +
                "	    INNER JOIN mst_item_material ON mst_item_material.Code = ppic_item_material_request_item_purchase_request_detail.ItemMaterialCode) " +
                "imrBookingDetail ON imrBookingDetail.ItemMaterialCode =  ppic_item_material_request_item_purchase_request_part_detail.itemMaterialRequestPurchaseRequestDetailCode " +
                "INNER JOIN ppic_item_material_request_item_processed_part_detail ON ppic_item_material_request_item_processed_part_detail.Code =  ppic_item_material_request_item_purchase_request_part_detail.ProcessedPartDetailCode " +
                "INNER JOIN ppic_item_material_request ON ppic_item_material_request.Code =  ppic_item_material_request_item_purchase_request_part_detail.HeaderCode  " +
                "INNER JOIN ppic_production_planning_order_item_detail ON ppic_production_planning_order_item_detail.DocumentDetailCode = ppic_item_material_request_item_processed_part_detail.DocumentDetailCode " +
                "INNER JOIN eng_bill_of_material_part_detail ON eng_bill_of_material_part_detail.HeaderCode = ppic_production_planning_order_item_detail.BillOfMaterialCode   " +
                "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = ppic_item_material_request_item_processed_part_detail.ItemFinishGoodsCode  " +
                "INNER JOIN mst_part ON mst_part.Code = eng_bill_of_material_part_detail.PartCode " +
                "WHERE  ppic_item_material_request_item_purchase_request_part_detail.HeaderCode = '"+headerCode+"' " +
                "GROUP BY eng_bill_of_material_part_detail.code"
            )
                    .addScalar("itemMaterialRequestPurchaseRequestDetailCode",Hibernate.STRING)
                    .addScalar("itemMaterialName",Hibernate.STRING)
                    .addScalar("documentDetailCode",Hibernate.STRING)
                    .addScalar("itemFinishGoodsCode",Hibernate.STRING)
                    .addScalar("itemFinishGoodsRemark",Hibernate.STRING)
                    .addScalar("bomDetailCode",Hibernate.STRING)
                    .addScalar("partNo",Hibernate.BIG_DECIMAL)
                    .addScalar("partCode",Hibernate.STRING)
                    .addScalar("partName",Hibernate.STRING)
                    .addScalar("drawingCode",Hibernate.STRING)
                    .addScalar("dimension",Hibernate.STRING)
                    .addScalar("requiredLength",Hibernate.STRING)
                    .addScalar("material",Hibernate.STRING)
                    .addScalar("requirement",Hibernate.STRING)
                    .addScalar("processedStatus",Hibernate.STRING)
                    .addScalar("remark",Hibernate.STRING)
                    .addScalar("x",Hibernate.STRING)
                    .addScalar("revNo",Hibernate.STRING)
                    .addScalar("quantityBom",Hibernate.BIG_DECIMAL)
                    .addScalar("itemProductionPlanningOrderNo",Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(ItemMaterialRequestItemRequestPartDetail.class))
                    .list();
            return list;
        }catch(HibernateException e){
            throw e;
        }
    }
    
    private String createCode(ItemMaterialRequest itemMaterialRequest) {
        try {
            String tempKode = "IMR";
            String acronim = itemMaterialRequest.getBranch().getCode() + "/" +tempKode + "/"+AutoNumber.formatingDate(itemMaterialRequest.getTransactionDate(), true, true, false);
            
            DetachedCriteria dc = DetachedCriteria.forClass(ItemMaterialRequest.class)
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
    
    public void save(EnumActivity.ENUM_Activity enumActivity, ItemMaterialRequest itemMaterialRequest, List<ItemMaterialRequestItemProcessedPartDetail> listItemMaterialRequestItemProcessedPartDetail,
        List<ItemMaterialRequestItemBookingDetail> listItemMaterialRequestItemBookingDetail, List<ItemMaterialRequestItemBookingPartDetail> listItemMaterialRequestItemBookingPartDetail,
        List<ItemMaterialRequestItemRequestDetail> listItemMaterialRequestItemRequestDetail, List<ItemMaterialRequestItemRequestPartDetail> listItemMaterialRequestItemRequestPartDetail, String moduleCode) throws Exception{
        try{
            String headerCode = createCode(itemMaterialRequest);
            
            hbmSession.hSession.beginTransaction();
            
            itemMaterialRequest.setCode(headerCode);
            itemMaterialRequest.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemMaterialRequest.setCreatedDate(new Date());
            itemMaterialRequest.setApprovalStatus("PENDING");
            
            if(!processDetail(EnumActivity.ENUM_Activity.NEW, itemMaterialRequest, listItemMaterialRequestItemProcessedPartDetail,
                listItemMaterialRequestItemBookingDetail, listItemMaterialRequestItemBookingPartDetail, listItemMaterialRequestItemRequestDetail,
                listItemMaterialRequestItemRequestPartDetail)){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA ITEM DETAIL INPUT!<br/><br/>");
            }
            
            hbmSession.hSession.save(itemMaterialRequest);
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    itemMaterialRequest.getCode(),EnumActivity.toString(enumActivity)));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();   
            
            
        }catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }    
    }
    
    public void delete(ItemMaterialRequest itemMaterialRequest, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            if(!processDetail(EnumActivity.ENUM_Activity.DELETE, itemMaterialRequest, null, null, null, null, null)){
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM ItemMaterialRequest "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", itemMaterialRequest.getCode())
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE),
                                                                    itemMaterialRequest.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.DELETE)));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void approval(ItemMaterialRequest itemMaterialRequest,String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            ItemMaterialRequest itemMaterialRequestOld = (ItemMaterialRequest) hbmSession.hSession.get(ItemMaterialRequest.class, itemMaterialRequest.getCode());
            
            String approvalBy="";
            Date approvalDate=commonFunction.setDateTime("01/01/1900 00:00:00");
                        
            if(itemMaterialRequest.getApprovalStatus().equals(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED.toString())){
                
                approvalBy=BaseSession.loadProgramSession().getUserName();
                approvalDate=new Date();
            }
            
            String prmActivity = "";
            if ("APPROVED".equals(itemMaterialRequest.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.APPROVED);
            }else if ("REJECTED".equals(itemMaterialRequest.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.REJECTED);
            }
            
            itemMaterialRequestOld.setApprovalStatus(prmActivity);
            itemMaterialRequestOld.setApprovalBy(approvalBy);
            itemMaterialRequestOld.setApprovalDate(approvalDate);
            itemMaterialRequestOld.setApprovalRemark(itemMaterialRequest.getApprovalRemark());
            itemMaterialRequestOld.setApprovalReason(itemMaterialRequest.getApprovalReason());
            hbmSession.hSession.update(itemMaterialRequestOld);
                        
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    itemMaterialRequest.getCode(), "Item Material Request - Approval"));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void closing(ItemMaterialRequest itemMaterialRequest,String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            ItemMaterialRequest itemMaterialRequestOld = (ItemMaterialRequest) hbmSession.hSession.get(ItemMaterialRequest.class, itemMaterialRequest.getCode());
            
            String closingBy="";
            Date closingDate=commonFunction.setDateTime("01/01/1900 00:00:00");
            
            closingBy=BaseSession.loadProgramSession().getUserName();
            closingDate=new Date();
            
            itemMaterialRequestOld.setClosingStatus("CLOSED");
            itemMaterialRequestOld.setClosingBy(closingBy);
            itemMaterialRequestOld.setClosingDate(closingDate);
            hbmSession.hSession.update(itemMaterialRequestOld);
                        
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    itemMaterialRequest.getCode(), "Item Material Request - Closing"));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    private boolean processDetail(EnumActivity.ENUM_Activity enumActivity, ItemMaterialRequest itemMaterialRequest, List<ItemMaterialRequestItemProcessedPartDetail> listItemMaterialRequestItemProcessedPartDetail,
        List<ItemMaterialRequestItemBookingDetail> listItemMaterialRequestItemBookingDetail, List<ItemMaterialRequestItemBookingPartDetail> listItemMaterialRequestItemBookingPartDetail,
        List<ItemMaterialRequestItemRequestDetail> listItemMaterialRequestItemRequestDetail, List<ItemMaterialRequestItemRequestPartDetail> listItemMaterialRequestItemRequestPartDetail){
        try{
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM "+ItemMaterialRequestItemProcessedPartDetailField.BEAN_NAME+" WHERE "+ItemMaterialRequestItemProcessedPartDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", itemMaterialRequest.getCode())    
                    .executeUpdate();
            
                hbmSession.hSession.createQuery("DELETE FROM "+ItemMaterialRequestItemBookingDetailField.BEAN_NAME+" WHERE "+ItemMaterialRequestItemBookingDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", itemMaterialRequest.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+ItemMaterialRequestItemBookingPartDetailField.BEAN_NAME+" WHERE "+ItemMaterialRequestItemBookingPartDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", itemMaterialRequest.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+ItemMaterialRequestItemRequestDetailField.BEAN_NAME+" WHERE "+ItemMaterialRequestItemRequestDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", itemMaterialRequest.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+ItemMaterialRequestItemRequestPartDetailField.BEAN_NAME+" WHERE "+ItemMaterialRequestItemRequestPartDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", itemMaterialRequest.getCode())    
                        .executeUpdate();
            }
            
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int q = 1;
                int s = 1;
                int d = 1;
                int x = 0;
                int y = 0;
                int z = 0;
                for(ItemMaterialRequestItemProcessedPartDetail itemMaterialRequestItemProcessedPartDetail : listItemMaterialRequestItemProcessedPartDetail){

                    String detailCode = itemMaterialRequest.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    itemMaterialRequestItemProcessedPartDetail.setCode(detailCode);
                    itemMaterialRequestItemProcessedPartDetail.setHeaderCode(itemMaterialRequest.getCode());

                    if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                        itemMaterialRequestItemProcessedPartDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                        itemMaterialRequestItemProcessedPartDetail.setCreatedDate(new Date());   
                    }else{
                        itemMaterialRequestItemProcessedPartDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        itemMaterialRequestItemProcessedPartDetail.setCreatedDate(new Date());   
                    }
                  
                    for(ItemMaterialRequestItemBookingPartDetail itemMaterialRequestItemBookingPartDetail : listItemMaterialRequestItemBookingPartDetail){

                        if (listItemMaterialRequestItemBookingPartDetail.size() > y){
                            if(listItemMaterialRequestItemProcessedPartDetail.get(x).getDocumentDetailCode().equals(listItemMaterialRequestItemBookingPartDetail.get(y).getItemMaterialRequestBookingDocumentDetailCode()) && listItemMaterialRequestItemProcessedPartDetail.get(x).getItemFinishGoods().getCode().equals(listItemMaterialRequestItemBookingPartDetail.get(y).getItemMaterialRequestBookingFinishGoodsCode())
                            && listItemMaterialRequestItemProcessedPartDetail.get(x).getPartCode().equals(listItemMaterialRequestItemBookingPartDetail.get(y).getItemMaterialRequestBookingFinishPartCode())){

                                String detailCodeBookingPart = itemMaterialRequest.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(s),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                                itemMaterialRequestItemBookingPartDetail.setCode(detailCodeBookingPart);
                                itemMaterialRequestItemBookingPartDetail.setHeaderCode(itemMaterialRequest.getCode());
                                itemMaterialRequestItemBookingPartDetail.setProcessedPartDetailCode(itemMaterialRequestItemProcessedPartDetail.getCode());

                                if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                                    itemMaterialRequestItemBookingPartDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                                    itemMaterialRequestItemBookingPartDetail.setCreatedDate(new Date());
                                }else{
                                    itemMaterialRequestItemBookingPartDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                                    itemMaterialRequestItemBookingPartDetail.setUpdatedDate(new Date());
                                }
                                
                                hbmSession.hSession.save(itemMaterialRequestItemBookingPartDetail);
                                hbmSession.hSession.flush();
                                hbmSession.hSession.clear();
                                s++;
                                y++;
                            }   
                        }
                    }
                        
                    for(ItemMaterialRequestItemRequestPartDetail itemMaterialRequestItemRequestPartDetail : listItemMaterialRequestItemRequestPartDetail){

                        if(listItemMaterialRequestItemRequestPartDetail.size() > z){
                            if(listItemMaterialRequestItemProcessedPartDetail.get(x).getDocumentDetailCode().equals(listItemMaterialRequestItemRequestPartDetail.get(z).getItemMaterialRequestPurchaseRequestDocumentDetailCode()) && listItemMaterialRequestItemProcessedPartDetail.get(x).getItemFinishGoods().getCode().equals(listItemMaterialRequestItemRequestPartDetail.get(z).getItemMaterialRequestPurchaseRequestFinishGoodsCode())
                            && listItemMaterialRequestItemProcessedPartDetail.get(x).getPartCode().equals(listItemMaterialRequestItemRequestPartDetail.get(z).getItemMaterialRequestPurchaseRequestPartCode())){
                            
                                String detailCodeRequest = itemMaterialRequest.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                                itemMaterialRequestItemRequestPartDetail.setCode(detailCodeRequest);
                                itemMaterialRequestItemRequestPartDetail.setHeaderCode(itemMaterialRequest.getCode());
                                itemMaterialRequestItemRequestPartDetail.setProcessedPartDetailCode(itemMaterialRequestItemProcessedPartDetail.getCode());

                                if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                                    itemMaterialRequestItemRequestPartDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                                    itemMaterialRequestItemRequestPartDetail.setCreatedDate(new Date());
                                }else{
                                    itemMaterialRequestItemRequestPartDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                                    itemMaterialRequestItemRequestPartDetail.setUpdatedDate(new Date());
                                }

                                hbmSession.hSession.save(itemMaterialRequestItemRequestPartDetail);
                                hbmSession.hSession.flush();
                                hbmSession.hSession.clear();
                                d++;
                                z++;
                            }
                        }
                    }
                    
                    hbmSession.hSession.save(itemMaterialRequestItemProcessedPartDetail);

                    q++;
                    x++;
                }

                int i = 1;
                for(ItemMaterialRequestItemBookingDetail itemMaterialRequestItemBookingDetail : listItemMaterialRequestItemBookingDetail){

                    String detailCode = itemMaterialRequest.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    itemMaterialRequestItemBookingDetail.setCode(detailCode);
                    itemMaterialRequestItemBookingDetail.setHeaderCode(itemMaterialRequest.getCode());

                    if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                        itemMaterialRequestItemBookingDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                        itemMaterialRequestItemBookingDetail.setCreatedDate(new Date());
                    }else{
                        itemMaterialRequestItemBookingDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        itemMaterialRequestItemBookingDetail.setUpdatedDate(new Date());
                    }

                    hbmSession.hSession.save(itemMaterialRequestItemBookingDetail);

                    i++;
                }

                int p = 1;
                for(ItemMaterialRequestItemRequestDetail itemMaterialRequestItemRequestDetail : listItemMaterialRequestItemRequestDetail){

                    String detailCode = itemMaterialRequest.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    itemMaterialRequestItemRequestDetail.setCode(detailCode);
                    itemMaterialRequestItemRequestDetail.setHeaderCode(itemMaterialRequest.getCode());

                    if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                        itemMaterialRequestItemRequestDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                        itemMaterialRequestItemRequestDetail.setCreatedDate(new Date());
                    }else{
                        itemMaterialRequestItemRequestDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        itemMaterialRequestItemRequestDetail.setUpdatedDate(new Date());
                    }
                    
                    hbmSession.hSession.save(itemMaterialRequestItemRequestDetail);

                    p++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }
    
    
    
}
