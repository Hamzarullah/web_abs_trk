
package com.inkombizz.purchasing.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequest;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequestDetail;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequestDetailField;
import com.inkombizz.purchasing.model.PurchaseRequestNonItemMaterialRequestField;
import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.utils.DateUtils;

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


public class PurchaseRequestNonItemMaterialRequestDAO {
    private HBMSession hbmSession;
    
    public PurchaseRequestNonItemMaterialRequestDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
//  Look up PRQ
    public int countDataLookUp(String code, Date fromDate,Date upToDate) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_purchase_request_search_list(:prmFlag,:prmCode,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmFirstDate", fromDate)
                .setParameter("prmLastDate", upToDate)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequest> findDataLookUp(String code, Date fromDate,Date upToDate, int from, int to) {
        try {
            List<PurchaseRequestNonItemMaterialRequest> list = (List<PurchaseRequestNonItemMaterialRequest>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_purchase_request_search_list(:prmFlag,:prmCode,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo) ")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("ppoCode", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmFirstDate", fromDate)
                .setParameter("prmLastDate", upToDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequest.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
//    Purchase Request Non Item Material Request
    public int countData(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM pur_purchase_request_non_imr "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_imr.BranchCode "
                + "AND pur_purchase_request_non_imr.ClosingStatus = 'OPEN' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequest> findData(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(purchaseRequestNonItemMaterialRequest.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(purchaseRequestNonItemMaterialRequest.getTransactionLastDate());
            
            List<PurchaseRequestNonItemMaterialRequest> list = (List<PurchaseRequestNonItemMaterialRequest>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "pur_purchase_request_non_imr.Code, "
                + "pur_purchase_request_non_imr.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "pur_purchase_request_non_imr.RequestBy, "
                + "pur_purchase_request_non_imr.RefNo, "
                + "pur_purchase_request_non_imr.Remark "
                    + "FROM "
                + "pur_purchase_request_non_imr "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_imr.BranchCode "
                + "WHERE pur_purchase_request_non_imr.code LIKE '%"+purchaseRequestNonItemMaterialRequest.getCode()+"%' "
                + "AND mst_branch.Code LIKE '%"+purchaseRequestNonItemMaterialRequest.getBranchCode()+"%' "
                + "AND mst_branch.Name LIKE '%"+purchaseRequestNonItemMaterialRequest.getBranchName()+"%' "
                + "AND pur_purchase_request_non_imr.ClosingStatus = 'OPEN' "
                + "AND DATE(pur_purchase_request_non_imr.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequest.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataDetail(String code) {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> list = (List<PurchaseRequestNonItemMaterialRequestDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "pur_purchase_request_non_imr_detail.Code, "
                + "pur_purchase_request_non_imr_detail.HeaderCode, "
                + "mst_item_material.Code AS itemMaterialCode, "
                + "mst_item_material.Name AS itemMaterialName, "
                + "mst_item_material_jn_current_stock.ItemMaterialCode, " 
                + "IFNULL(mst_item_material_jn_current_stock.ActualStock, 0) AS onHandStock,"            
                + "pur_purchase_request_non_imr_detail.Quantity, "
                + "pur_purchase_request_non_imr_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "pur_purchase_request_non_imr_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_non_imr_detail.ItemMaterialCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "pur_purchase_request_non_imr_detail.HeaderCode = '"+code+"' "
                + "ORDER BY pur_purchase_request_non_imr_detail.Code ASC, pur_purchase_request_non_imr_detail.HeaderCode ASC "    
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemMaterialCode", Hibernate.STRING)
            .addScalar("itemMaterialName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .addScalar("onHandStock", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequestDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataDetailPRQNo(ArrayList arrPurchaseOrderNo, String purchaseRequestNonStatus) {
        try {
            String concat_qry="";
            
            String strPurchaseOrderNo=Arrays.toString(arrPurchaseOrderNo.toArray());
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll("[\\[\\]]", "");
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll(",", "','");
            
            List<PurchaseRequestNonItemMaterialRequestDetail> list = (List<PurchaseRequestNonItemMaterialRequestDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "pur_purchase_request_non_imr_detail.Code, "
                + "pur_purchase_request_non_imr_detail.HeaderCode, "
                + "mst_item_material.Code AS itemMaterialCode, "
                + "mst_item_material.Name AS itemMaterialName, "
                + "mst_item_material_jn_current_stock.ItemMaterialCode, " 
                + "mst_item_material_jn_current_stock.ActualStock AS onHandStock,"            
                + "pur_purchase_request_non_imr_detail.Quantity, "
                + "pur_purchase_request_non_imr_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "pur_purchase_request_non_imr_detail "
                + "INNER JOIN pur_purchase_request_non_imr ON pur_purchase_request_non_imr.code = pur_purchase_request_non_imr_detail.HeaderCode "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_non_imr_detail.ItemMaterialCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "pur_purchase_request_non_imr_detail.HeaderCode IN ('"+strPurchaseOrderNo+"') "
                + "ORDER BY pur_purchase_request_non_imr_detail.Code ASC, pur_purchase_request_non_imr_detail.HeaderCode ASC "        
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemMaterialCode", Hibernate.STRING)
            .addScalar("itemMaterialName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .addScalar("onHandStock", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequestDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataDetailSubItem(ArrayList arrPurchaseOrderNo) {
        try {
            String strPurchaseOrderNo=Arrays.toString(arrPurchaseOrderNo.toArray());
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll("[\\[\\]]", "");
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll(",", "','");
            
            List<PurchaseRequestNonItemMaterialRequestDetail> list = (List<PurchaseRequestNonItemMaterialRequestDetail>)hbmSession.hSession.createSQLQuery(
                " SELECT "
                        + "purchase.code, "
                        + "purchase.HeaderCode, "
                        + "purchase.itemMaterialCode, "
                        + "purchase.itemMaterialName, "
                        + "IFNULL(purchase.Quantity, 0) AS quantity, "
                        + "purchase.unitOfMeasureCode, "
                        + "purchase.unitOfMeasureName, "
                        + "pur_purchase_order.Code AS poCode, "
                        + "purchase.itemMaterialJnVendor, "
                        + "purchase.vendorCode "
                        + "FROM( "
                            + "SELECT "
                            + "sal_internal_memo_material_detail.Code, "
                            + "sal_internal_memo_material_detail.HeaderCode, "
                            + "sal_internal_memo_material_detail.itemMaterialCode, "
                            + "mst_item_material.Name AS itemMaterialName, "
                            + "sal_internal_memo_material_detail.Quantity, "
                            + "mst_item_material.unitOfMeasureCode, "
                            + "mst_unit_of_measure.Name AS unitOfMeasureName, "
                            + "mst_item_material_jn_vendor.ItemMaterialCode AS itemMaterialJnVendor, "
                            + "mst_item_material_jn_vendor.VendorCode "
                            + "FROM sal_internal_memo_material_detail  "
                            + "LEFT JOIN mst_item_material_jn_vendor ON mst_item_material_jn_vendor.ItemMaterialCode = sal_internal_memo_material_detail.ItemMaterialCode "
                            + "INNER JOIN mst_item_material ON mst_item_material.Code = sal_internal_memo_material_detail.ItemMaterialCode "
                            + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                            + "UNION ALL "
                            + "SELECT "
                            + "ppic_item_material_request_item_purchase_request_detail.Code, "
                            + "ppic_item_material_request_item_purchase_request_detail.HeaderCode, "
                            + "ppic_item_material_request_item_purchase_request_detail.itemMaterialCode, "
                            + "mst_item_material.Name AS itemMaterialName, "
                            + "ppic_item_material_request_item_purchase_request_detail.Quantity, "
                            + "mst_item_material.unitOfMeasureCode, "
                            + "mst_unit_of_measure.Name AS unitOfMeasureName, "
                            + "mst_item_material_jn_vendor.ItemMaterialCode AS itemMaterialJnVendor, "
                            + "mst_item_material_jn_vendor.VendorCode "
                            + "FROM ppic_item_material_request_item_purchase_request_detail "
                            + "LEFT JOIN mst_item_material_jn_vendor ON mst_item_material_jn_vendor.ItemMaterialCode = ppic_item_material_request_item_purchase_request_detail.ItemMaterialCode "
                            + "INNER JOIN mst_item_material ON mst_item_material.Code = ppic_item_material_request_item_purchase_request_detail.ItemMaterialCode "
                            + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode) purchase "
                + "LEFT JOIN pur_purchase_order_item_material_detail ON pur_purchase_order_item_material_detail.PurchaseRequestDetailCode = purchase.headerCode "
                + "LEFT JOIN pur_purchase_order ON pur_purchase_order.Code = pur_purchase_order_item_material_detail.headerCode "
                + "WHERE purchase.HeaderCode IN ('"+strPurchaseOrderNo+"') "
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemMaterialCode", Hibernate.STRING)
            .addScalar("itemMaterialName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("poCode", Hibernate.STRING)
            .addScalar("itemMaterialJnVendor", Hibernate.STRING)
            .addScalar("vendorCode", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequestDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataSubItem(String code) {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> list = (List<PurchaseRequestNonItemMaterialRequestDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "purchaseRequest.code, "
                + "purchaseRequest.headerCode AS purchaseOrderSubItemPurchaseRequestNo, "
                + "purchaseRequest.itemMaterialCode AS purchaseOrderSubItemPurchaseOrderItemMaterialCode, "
                + "purchaseRequest.itemMaterialName AS purchaseOrderSubItemPurchaseOrderItemMaterialName "
                + "FROM ( "
                    + "SELECT "
                    + "pur_purchase_request_by_imr_detail.Code, "
                    + "pur_purchase_request_by_imr_detail.HeaderCode, "
                    + "pur_purchase_request_by_imr_detail.documentDetailCode, "
                    + "mst_item_material.Code AS ItemMaterialCode, "
                    + "mst_item_material.Name AS itemMaterialName, "
                    + "mst_item_material_jn_current_stock.ItemMaterialCode AS ItemMaterialCode1, "
                    + "mst_item_material_jn_current_stock.ActualStock AS onHandStock, "
                    + "pur_purchase_request_by_imr_detail.Quantity, "
                    + "pur_purchase_request_by_imr_detail.Remark, "
                    + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                    + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM pur_purchase_request_by_imr_detail  "
                    + "INNER JOIN pur_purchase_request_by_imr ON pur_purchase_request_by_imr.Code = pur_purchase_request_by_imr_detail.HeaderCode "
                    + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_by_imr_detail.ItemMaterialCode "
                    + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                    + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "UNION "
                    + " SELECT "
                    + "pur_purchase_request_non_imr_detail.Code, "
                    + "pur_purchase_request_non_imr_detail.HeaderCode, "
                    + "'No Doc' AS documentDetailCode, "
                    + "mst_item_material.Code AS ItemMaterialCode, "
                    + "mst_item_material.Name AS itemMaterialName, "
                    + "mst_item_material_jn_current_stock.ItemMaterialCode AS ItemMaterialCode1, "
                    + "mst_item_material_jn_current_stock.ActualStock AS onHandStock, "
                    + "pur_purchase_request_non_imr_detail.Quantity, "
                    + "pur_purchase_request_non_imr_detail.Remark, "
                    + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                    + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM pur_purchase_request_non_imr_detail "
                    + "INNER JOIN pur_purchase_request_non_imr ON pur_purchase_request_non_imr.Code = pur_purchase_request_non_imr_detail.HeaderCode "    
                    + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_non_imr_detail.ItemMaterialCode "
                    + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                    + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode ) purchaseRequest "
                + "WHERE "
                + "purchaseRequest.HeaderCode = '"+code+"' "       
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("purchaseOrderSubItemPurchaseRequestNo", Hibernate.STRING)
            .addScalar("purchaseOrderSubItemPurchaseOrderItemMaterialCode", Hibernate.STRING)
            .addScalar("purchaseOrderSubItemPurchaseOrderItemMaterialName", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequestDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataApproval(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApprovalTemp){
        try{
            String concat_qry="";
            if(!purchaseRequestNonItemMaterialRequestApprovalTemp.getApprovalStatus().equals("")){
                concat_qry="WHERE pur_purchase_request_non_imr.ApprovalStatus LIKE '%"+purchaseRequestNonItemMaterialRequestApprovalTemp.getApprovalStatus()+"%' ";
            }else{
                concat_qry="WHERE pur_purchase_request_non_imr.ApprovalStatus LIKE '%%' ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM pur_purchase_request_non_imr "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_imr.BranchCode "       
                + concat_qry    
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequest> findDataApproval(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApprovalTemp,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(purchaseRequestNonItemMaterialRequestApprovalTemp.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(purchaseRequestNonItemMaterialRequestApprovalTemp.getTransactionLastDate());
            
            String concat_qry="";
            if(!purchaseRequestNonItemMaterialRequestApprovalTemp.getApprovalStatus().equals("")){
                concat_qry="AND pur_purchase_request_non_imr.ApprovalStatus LIKE '%"+purchaseRequestNonItemMaterialRequestApprovalTemp.getApprovalStatus()+"%' ";
            }else{
                concat_qry="AND pur_purchase_request_non_imr.ApprovalStatus LIKE '%%' ";
            }
            
            List<PurchaseRequestNonItemMaterialRequest> list = (List<PurchaseRequestNonItemMaterialRequest>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "pur_purchase_request_non_imr.Code, "
                + "pur_purchase_request_non_imr.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "pur_purchase_request_non_imr.RequestBy, "
                + "pur_purchase_request_non_imr.RefNo, "
                + "pur_purchase_request_non_imr.Remark "
                    + "FROM "
                + "pur_purchase_request_non_imr "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_imr.BranchCode "
                + "WHERE pur_purchase_request_non_imr.code LIKE '%"+purchaseRequestNonItemMaterialRequestApprovalTemp.getCode()+"%' "
                + "AND pur_purchase_request_non_imr.RefNo LIKE '%"+purchaseRequestNonItemMaterialRequestApprovalTemp.getRefNo()+"%' "
                + "AND pur_purchase_request_non_imr.Remark LIKE '%"+purchaseRequestNonItemMaterialRequestApprovalTemp.getRemark()+"%' "
                + "AND DATE(pur_purchase_request_non_imr.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequest.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataApprovalDetail(String code) {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> list = (List<PurchaseRequestNonItemMaterialRequestDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "pur_purchase_request_non_imr_detail.Code, "
                + "pur_purchase_request_non_imr_detail.HeaderCode, "
                + "mst_item_material.Code AS ItemMaterialCode, "
                + "mst_item_material.Name AS itemName, "
                + "pur_purchase_request_non_imr_detail.Quantity, "
                + "pur_purchase_request_non_imr_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "pur_purchase_request_non_imr_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_non_imr_detail.ItemMaterialCode "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "pur_purchase_request_non_imr_detail.HeaderCode = '"+code+"' "
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemCode", Hibernate.STRING)
            .addScalar("itemName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequestDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataClosing(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosingTemp){
        try{
            String concat_qry="";
            if(!purchaseRequestNonItemMaterialRequestClosingTemp.getClosingStatus().equals("")){
                concat_qry="WHERE pur_purchase_request_non_imr.ClosingStatus LIKE '%"+purchaseRequestNonItemMaterialRequestClosingTemp.getClosingStatus()+"%' ";
            }else{
                concat_qry="WHERE pur_purchase_request_non_imr.ClosingStatus LIKE '%%' ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM pur_purchase_request_non_imr "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_imr.BranchCode "
                + concat_qry    
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequest> findDataClosing(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosingTemp,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(purchaseRequestNonItemMaterialRequestClosingTemp.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(purchaseRequestNonItemMaterialRequestClosingTemp.getTransactionLastDate());
            
            String concat_qry="";
            if(!purchaseRequestNonItemMaterialRequestClosingTemp.getClosingStatus().equals("")){
                concat_qry="AND pur_purchase_request_non_imr.ClosingStatus LIKE '%"+purchaseRequestNonItemMaterialRequestClosingTemp.getClosingStatus()+"%' ";
            }else{
                concat_qry="AND pur_purchase_request_non_imr.ClosingStatus LIKE '%%' ";
            }
            
            List<PurchaseRequestNonItemMaterialRequest> list = (List<PurchaseRequestNonItemMaterialRequest>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "pur_purchase_request_non_imr.Code, "
                + "pur_purchase_request_non_imr.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "pur_purchase_request_non_imr.RequestBy, "
                + "pur_purchase_request_non_imr.RefNo, "
                + "pur_purchase_request_non_imr.Remark "
                + "FROM "
                + "pur_purchase_request_non_imr "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_imr.BranchCode "
                + "WHERE pur_purchase_request_non_imr.code LIKE '%"+purchaseRequestNonItemMaterialRequestClosingTemp.getCode()+"%' "
                + "AND pur_purchase_request_non_imr.RefNo LIKE '%"+purchaseRequestNonItemMaterialRequestClosingTemp.getRefNo()+"%' "
                + "AND pur_purchase_request_non_imr.Remark LIKE '%"+purchaseRequestNonItemMaterialRequestClosingTemp.getRemark()+"%' "
                + "AND DATE(pur_purchase_request_non_imr.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequest.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestNonItemMaterialRequestDetail> findDataClosingDetail(String code) {
        try {
            
            List<PurchaseRequestNonItemMaterialRequestDetail> list = (List<PurchaseRequestNonItemMaterialRequestDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "pur_purchase_request_non_imr_detail.Code, "
                + "pur_purchase_request_non_imr_detail.HeaderCode, "
                + "mst_item_material.Code AS ItemMaterialCode, "
                + "mst_item_material.Name AS itemName, "
                + "pur_purchase_request_non_imr_detail.Quantity, "
                + "pur_purchase_request_non_imr_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "pur_purchase_request_non_imr_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_non_imr_detail.ItemMaterialCode "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "pur_purchase_request_non_imr_detail.HeaderCode = '"+code+"' "
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemCode", Hibernate.STRING)
            .addScalar("itemName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequestDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public PurchaseRequestNonItemMaterialRequest get(String code) {
        try {
               return (PurchaseRequestNonItemMaterialRequest) hbmSession.hSession.get(PurchaseRequestNonItemMaterialRequest.class, code);
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
    
    public String createCode(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest){   
        try{
            String acronim = purchaseRequestNonItemMaterialRequest.getBranch().getCode()+ "/PRQ-NIMR/"+AutoNumber.formatingDate(purchaseRequestNonItemMaterialRequest.getTransactionDate(), true, true, false);;
            
            DetachedCriteria dc = DetachedCriteria.forClass(PurchaseRequestNonItemMaterialRequest.class)
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
    
    public void save(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest,List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail,String moduleCode) throws Exception{
        try{
            hbmSession.hSession.beginTransaction();
            
            String headerCode = createCode(purchaseRequestNonItemMaterialRequest);
            purchaseRequestNonItemMaterialRequest.setCode(headerCode);
            purchaseRequestNonItemMaterialRequest.setTransactionDate(DateUtils.newDateTime(purchaseRequestNonItemMaterialRequest.getTransactionDate(),true));
            purchaseRequestNonItemMaterialRequest.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            purchaseRequestNonItemMaterialRequest.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(purchaseRequestNonItemMaterialRequest);
            
            if(listPurchaseRequestNonItemMaterialRequestDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }

            int i = 1;
            for(PurchaseRequestNonItemMaterialRequestDetail purchaseRequestNonItemMaterialRequestDetail : listPurchaseRequestNonItemMaterialRequestDetail){
                                                            
                String detailCode = headerCode+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                purchaseRequestNonItemMaterialRequestDetail.setCode(detailCode);
                purchaseRequestNonItemMaterialRequestDetail.setHeaderCode(purchaseRequestNonItemMaterialRequest.getCode());
                
                purchaseRequestNonItemMaterialRequestDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                purchaseRequestNonItemMaterialRequestDetail.setCreatedDate(new Date());
                
                hbmSession.hSession.save(purchaseRequestNonItemMaterialRequestDetail);
                i++;
            }
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), purchaseRequestNonItemMaterialRequest.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }catch(HibernateException e){
           hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public void update(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest,List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail,String moduleCode) throws Exception {
        try {
                                            
            hbmSession.hSession.beginTransaction();
            
            //ambil detail yg lama
            PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestOld = (PurchaseRequestNonItemMaterialRequest)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    PurchaseRequestNonItemMaterialRequestField.TRANSACTIONDATE + ", "+
                    PurchaseRequestNonItemMaterialRequestField.CREATEDDATE + " "+
                    "FROM " + PurchaseRequestNonItemMaterialRequestField.TABLE_NAME + "  " +
                    "WHERE " + PurchaseRequestNonItemMaterialRequestField.CODE + "= :prmCode ")
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", purchaseRequestNonItemMaterialRequest.getCode())
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestNonItemMaterialRequest.class))
                .uniqueResult();
            
            hbmSession.hSession.flush();
            
            if(DateUtils.getExistingDate(purchaseRequestNonItemMaterialRequestOld.getTransactionDate()).compareTo(DateUtils.getExistingDate(purchaseRequestNonItemMaterialRequest.getTransactionDate()))!=0){
                purchaseRequestNonItemMaterialRequest.setTransactionDate(DateUtils.newDateTime(purchaseRequestNonItemMaterialRequest.getTransactionDate(),true));
            }else{
                purchaseRequestNonItemMaterialRequest.setTransactionDate(purchaseRequestNonItemMaterialRequestOld.getTransactionDate());
            }
            
            hbmSession.hSession.createQuery("DELETE FROM " + PurchaseRequestNonItemMaterialRequestDetailField.BEAN_NAME + 
                                 " WHERE " + PurchaseRequestNonItemMaterialRequestDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", purchaseRequestNonItemMaterialRequest.getCode())
                    .executeUpdate();
            purchaseRequestNonItemMaterialRequest.setCreatedDate(purchaseRequestNonItemMaterialRequestOld.getCreatedDate());
            purchaseRequestNonItemMaterialRequest.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            purchaseRequestNonItemMaterialRequest.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(purchaseRequestNonItemMaterialRequest);
            
            if(listPurchaseRequestNonItemMaterialRequestDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
            
            if(!updateDetail(purchaseRequestNonItemMaterialRequest,listPurchaseRequestNonItemMaterialRequestDetail)){
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    purchaseRequestNonItemMaterialRequest.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private Boolean updateDetail(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest,List<PurchaseRequestNonItemMaterialRequestDetail> listPurchaseRequestNonItemMaterialRequestDetail) throws Exception{
        try {
            
    
            int i = 1;
            for(PurchaseRequestNonItemMaterialRequestDetail purchaseRequestNonItemMaterialRequestDetail : listPurchaseRequestNonItemMaterialRequestDetail){
                purchaseRequestNonItemMaterialRequestDetail.setHeaderCode(purchaseRequestNonItemMaterialRequest.getCode());
                String detailCode = purchaseRequestNonItemMaterialRequest.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                purchaseRequestNonItemMaterialRequestDetail.setCode(detailCode);
                purchaseRequestNonItemMaterialRequestDetail.setCreatedBy(purchaseRequestNonItemMaterialRequest.getCreatedBy());
                purchaseRequestNonItemMaterialRequestDetail.setCreatedDate(purchaseRequestNonItemMaterialRequest.getCreatedDate());
                purchaseRequestNonItemMaterialRequestDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                purchaseRequestNonItemMaterialRequestDetail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(purchaseRequestNonItemMaterialRequestDetail);
                
                i++;
            }
            
            return Boolean.TRUE;
            
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void delete(String code, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
                    
            hbmSession.hSession.createQuery("DELETE FROM "+PurchaseRequestNonItemMaterialRequestField.BEAN_NAME+" WHERE "+PurchaseRequestNonItemMaterialRequestField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM " + PurchaseRequestNonItemMaterialRequestDetailField.BEAN_NAME + 
                                " WHERE " + PurchaseRequestNonItemMaterialRequestDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void approval(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestApproval,List<PurchaseRequestNonItemMaterialRequestDetail> listpurchaseRequestNonItemMaterialRequestApproval, String MODULECODE) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest=get(purchaseRequestNonItemMaterialRequestApproval.getCode());
            
            if(purchaseRequestNonItemMaterialRequestApproval.getApprovalStatus().equalsIgnoreCase(EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED))){
                purchaseRequestNonItemMaterialRequest.setApprovalRemark(purchaseRequestNonItemMaterialRequestApproval.getApprovalRemark());
            }else{
                purchaseRequestNonItemMaterialRequest.setApprovalReason(null);
                purchaseRequestNonItemMaterialRequest.setApprovalRemark("");
            }
            
            purchaseRequestNonItemMaterialRequest.setApprovalStatus(purchaseRequestNonItemMaterialRequestApproval.getApprovalStatus());
            purchaseRequestNonItemMaterialRequest.setApprovalBy(BaseSession.loadProgramSession().getUserName());
            purchaseRequestNonItemMaterialRequest.setApprovalDate(new Date());
            purchaseRequestNonItemMaterialRequest.setApprovalReason(purchaseRequestNonItemMaterialRequestApproval.getApprovalReason());
                
            hbmSession.hSession.update(purchaseRequestNonItemMaterialRequest);
            
            if(listpurchaseRequestNonItemMaterialRequestApproval==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
            
            hbmSession.hSession.createQuery("DELETE FROM " + PurchaseRequestNonItemMaterialRequestDetailField.BEAN_NAME + 
                                 " WHERE " + PurchaseRequestNonItemMaterialRequestDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", purchaseRequestNonItemMaterialRequest.getCode())
                    .executeUpdate();
             
            int i = 1;
            for(PurchaseRequestNonItemMaterialRequestDetail purchaseRequestNonItemMaterialRequestDetail : listpurchaseRequestNonItemMaterialRequestApproval){
                                                            
                String detailCode = purchaseRequestNonItemMaterialRequest.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                purchaseRequestNonItemMaterialRequestDetail.setCode(detailCode);
                purchaseRequestNonItemMaterialRequestDetail.setHeaderCode(purchaseRequestNonItemMaterialRequest.getCode());
                
                purchaseRequestNonItemMaterialRequestDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                purchaseRequestNonItemMaterialRequestDetail.setCreatedDate(new Date());
                
                hbmSession.hSession.save(purchaseRequestNonItemMaterialRequestDetail);
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    purchaseRequestNonItemMaterialRequestApproval.getApprovalStatus() , 
                                                                    purchaseRequestNonItemMaterialRequestApproval.getCode(),"Approval Process: "+purchaseRequestNonItemMaterialRequestApproval.getClosingStatus()));
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
    
    public void closing(PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequestClosing, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            PurchaseRequestNonItemMaterialRequest purchaseRequestNonItemMaterialRequest=get(purchaseRequestNonItemMaterialRequestClosing.getCode());
            
            String closingBy="";
            Date closingDate=DateUtils.newDate(1900, 1, 1);
            
            if(purchaseRequestNonItemMaterialRequestClosing.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.ENUM_ClosingStatus.CLOSED.toString())){
                closingBy=BaseSession.loadProgramSession().getUserName();
                closingDate=new Date();
            }
            
            purchaseRequestNonItemMaterialRequest.setClosingBy(closingBy);
            purchaseRequestNonItemMaterialRequest.setClosingDate(closingDate);
            purchaseRequestNonItemMaterialRequest.setClosingRemark(purchaseRequestNonItemMaterialRequestClosing.getClosingRemark());
            purchaseRequestNonItemMaterialRequest.setClosingStatus(purchaseRequestNonItemMaterialRequestClosing.getClosingStatus());
            purchaseRequestNonItemMaterialRequest.setClosingReason(purchaseRequestNonItemMaterialRequestClosing.getClosingReason());
            hbmSession.hSession.update(purchaseRequestNonItemMaterialRequest);
           

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    purchaseRequestNonItemMaterialRequest.getClosingStatus(), 
                                                                    purchaseRequestNonItemMaterialRequestClosing.getCode(), "Closing Process: "+purchaseRequestNonItemMaterialRequestClosing.getClosingStatus()));
                        
            hbmSession.hTransaction.commit(); 
            hbmSession.hSession.close();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
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
