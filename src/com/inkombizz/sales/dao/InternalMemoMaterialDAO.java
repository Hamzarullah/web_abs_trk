/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.sales.model.InternalMemoMaterial;
import com.inkombizz.sales.model.InternalMemoMaterialDetail;
import com.inkombizz.sales.model.InternalMemoMaterialDetailField;
import com.inkombizz.sales.model.InternalMemoMaterialField;
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

/**
 *
 * @author ikb
 */
public class InternalMemoMaterialDAO {
    private HBMSession hbmSession;
    
    public InternalMemoMaterialDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    //    Purchase Request Non Item Material Request
    public int countData(InternalMemoMaterial internalMemoMaterial){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM sal_internal_memo_material "
                + "INNER JOIN mst_branch ON mst_branch.Code = sal_internal_memo_material.BranchCode "
                + " INNER JOIN mst_division ON mst_division.Code = sal_internal_memo_material.DivisionCode "
                + " INNER JOIN mst_department ON mst_department.Code = mst_division.DepartmentCode "
                + "AND sal_internal_memo_material.ClosingStatus = 'OPEN' "
                    
                + " AND( "
                + "CASE "
                + "	WHEN '"+internalMemoMaterial.getApprovalStatus()+"' = 'PENDING' THEN "
                + "		sal_internal_memo_material.ApprovalStatus = 'PENDING' "
                + "	WHEN '"+internalMemoMaterial.getApprovalStatus()+"' = 'APPROVED' THEN "
                + "		sal_internal_memo_material.ApprovalStatus = 'APPROVED' "
                + "	WHEN '"+internalMemoMaterial.getApprovalStatus()+"' = 'REJECTED' THEN "
                + "		sal_internal_memo_material.ApprovalStatus = 'REJECTED' "
                + "	ELSE "
                + "		1=1 "
                + "END) " 
                    
                + " AND( "
                + "CASE "
                + "	WHEN '"+internalMemoMaterial.getClosingStatus()+"' = 'OPEN' THEN "
                + "		sal_internal_memo_material.ClosingStatus = 'OPEN' "
                + "	WHEN '"+internalMemoMaterial.getClosingStatus()+"' = 'CLOSED' THEN "
                + "		sal_internal_memo_material.ClosingStatus = 'CLOSED' "
                + "	ELSE "
                + "		1=1 "
                + "END) "
                    
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<InternalMemoMaterial> findData(InternalMemoMaterial internalMemoMaterial,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(internalMemoMaterial.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(internalMemoMaterial.getTransactionLastDate());
            
            List<InternalMemoMaterial> list = (List<InternalMemoMaterial>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "sal_internal_memo_material.Code, "
                + "sal_internal_memo_material.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "mst_division.Code AS DivisionCode, "
                + "mst_division.Name AS DivisionName, "
                + "mst_department.Code AS DepartmentCode, "
                + "mst_department.Name AS DepartmentName, "
                + "sal_internal_memo_material.RequestBy, "
                + "sal_internal_memo_material.RefNo, "
                + "sal_internal_memo_material.Remark, "
                + "sal_internal_memo_material.ApprovalStatus "
                            
                    + "FROM "
                + "sal_internal_memo_material "
                + "INNER JOIN mst_branch ON mst_branch.Code = sal_internal_memo_material.BranchCode "
                + " INNER JOIN mst_division ON mst_division.Code = sal_internal_memo_material.DivisionCode "
                + " INNER JOIN mst_department ON mst_department.Code = mst_division.DepartmentCode "
                + "WHERE sal_internal_memo_material.code LIKE '%"+internalMemoMaterial.getCode()+"%' "
                + "AND mst_branch.Code LIKE '%"+internalMemoMaterial.getBranchCode()+"%' "
                + "AND mst_branch.Name LIKE '%"+internalMemoMaterial.getBranchName()+"%' "
                + "AND sal_internal_memo_material.ClosingStatus = 'OPEN' "
                        
                + " AND( "
                + "CASE "
                + "	WHEN '"+internalMemoMaterial.getApprovalStatus()+"' = 'PENDING' THEN "
                + "		sal_internal_memo_material.ApprovalStatus = 'PENDING' "
                + "	WHEN '"+internalMemoMaterial.getApprovalStatus()+"' = 'APPROVED' THEN "
                + "		sal_internal_memo_material.ApprovalStatus = 'APPROVED' "
                + "	WHEN '"+internalMemoMaterial.getApprovalStatus()+"' = 'REJECTED' THEN "
                + "		sal_internal_memo_material.ApprovalStatus = 'REJECTED' "
                + "	ELSE "
                + "		1=1 "
                + "END) "
                        
                + " AND( "
                + "CASE "
                + "	WHEN '"+internalMemoMaterial.getClosingStatus()+"' = 'OPEN' THEN "
                + "		sal_internal_memo_material.ClosingStatus = 'OPEN' "
                + "	WHEN '"+internalMemoMaterial.getClosingStatus()+"' = 'CLOSED' THEN "
                + "		sal_internal_memo_material.ClosingStatus = 'CLOSED' "
                + "	ELSE "
                + "		1=1 "
                + "END) "
                        
                + "AND DATE(sal_internal_memo_material.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
            
                + " ORDER BY sal_internal_memo_material.TransactionDate DESC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("divisionCode", Hibernate.STRING)
                .addScalar("divisionName", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterial.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataDetail(String code) {
        try {
            
            List<InternalMemoMaterialDetail> list = (List<InternalMemoMaterialDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_internal_memo_material_detail.Code, "
                + "sal_internal_memo_material_detail.HeaderCode, "
                + "mst_item_material.Code AS itemMaterialCode, "
                + "mst_item_material.Name AS itemMaterialName, "
                + "mst_item_material_jn_current_stock.ItemMaterialCode, " 
                + "IFNULL(mst_item_material_jn_current_stock.ActualStock, 0) AS onHandStock,"            
                + "sal_internal_memo_material_detail.Quantity, "
                + "sal_internal_memo_material_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "sal_internal_memo_material_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = sal_internal_memo_material_detail.ItemMaterialCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "sal_internal_memo_material_detail.HeaderCode = '"+code+"' "
                + "ORDER BY sal_internal_memo_material_detail.Code ASC, sal_internal_memo_material_detail.HeaderCode ASC "    
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
            .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterialDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataDetailIMMNo(ArrayList arrPurchaseOrderNo) {
        try {
            String concat_qry="";
            
            String strPurchaseOrderNo=Arrays.toString(arrPurchaseOrderNo.toArray());
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll("[\\[\\]]", "");
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll(",", "','");
            
            List<InternalMemoMaterialDetail> list = (List<InternalMemoMaterialDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_internal_memo_material_detail.Code, "
                + "sal_internal_memo_material_detail.HeaderCode, "
                + "mst_item_material.Code AS itemMaterialCode, "
                + "mst_item_material.Name AS itemMaterialName, "
                + "mst_item_material_jn_current_stock.ItemMaterialCode, " 
                + "mst_item_material_jn_current_stock.ActualStock AS onHandStock,"            
                + "sal_internal_memo_material_detail.Quantity, "
                + "sal_internal_memo_material_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "sal_internal_memo_material_detail "
                + "INNER JOIN sal_internal_memo_material ON sal_internal_memo_material.code = sal_internal_memo_material_detail.HeaderCode "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = sal_internal_memo_material_detail.ItemMaterialCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "sal_internal_memo_material_detail.HeaderCode IN ('"+strPurchaseOrderNo+"') "
                + "ORDER BY sal_internal_memo_material_detail.Code ASC, sal_internal_memo_material_detail.HeaderCode ASC "        
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
            .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterialDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataDetailSubItem(ArrayList arrPurchaseOrderNo) {
        try {
            String strPurchaseOrderNo=Arrays.toString(arrPurchaseOrderNo.toArray());
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll("[\\[\\]]", "");
            strPurchaseOrderNo = strPurchaseOrderNo.replaceAll(",", "','");
            
            List<InternalMemoMaterialDetail> list = (List<InternalMemoMaterialDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "pur_purchase_request_by_imr_detail.Code, "
                + "pur_purchase_request_by_imr_detail.HeaderCode, "
                + "pur_purchase_request_by_imr_detail.documentDetailCode, "
                + "mst_item_material.Code AS itemMaterialCode, "
                + "mst_item_material.Name AS itemMaterialName, "
                + "mst_item_material_jn_current_stock.ItemMaterialCode, "
                + "mst_item_material_jn_current_stock.ActualStock AS onHandStock, "
                + "pur_purchase_request_by_imr_detail.Quantity, "
                + "pur_purchase_request_by_imr_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                + "FROM pur_purchase_request_by_imr_detail  "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_by_imr_detail.ItemMaterialCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                + "UNION ALL "
                + "SELECT "
                + "sal_internal_memo_material_detail.Code, "
                + "sal_internal_memo_material_detail.HeaderCode, "
                + "'No Doc' AS documentDetailCode, "
                + "mst_item_material.Code AS itemMaterialCode, "
                + "mst_item_material.Name AS itemMaterialName, "
                + "mst_item_material_jn_current_stock.ItemMaterialCode, "
                + "mst_item_material_jn_current_stock.ActualStock AS onHandStock, "
                + "sal_internal_memo_material_detail.Quantity, "
                + "sal_internal_memo_material_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                + "FROM sal_internal_memo_material_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = sal_internal_memo_material_detail.ItemMaterialCode "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                + "WHERE "
                + "sal_internal_memo_material_detail.HeaderCode IN ('"+strPurchaseOrderNo+"') "
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
            .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterialDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataSubItem(String code) {
        try {
            
            List<InternalMemoMaterialDetail> list = (List<InternalMemoMaterialDetail>)hbmSession.hSession.createSQLQuery(
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
                    + "sal_internal_memo_material_detail.Code, "
                    + "sal_internal_memo_material_detail.HeaderCode, "
                    + "'No Doc' AS documentDetailCode, "
                    + "mst_item_material.Code AS ItemMaterialCode, "
                    + "mst_item_material.Name AS itemMaterialName, "
                    + "mst_item_material_jn_current_stock.ItemMaterialCode AS ItemMaterialCode1, "
                    + "mst_item_material_jn_current_stock.ActualStock AS onHandStock, "
                    + "sal_internal_memo_material_detail.Quantity, "
                    + "sal_internal_memo_material_detail.Remark, "
                    + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                    + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM sal_internal_memo_material_detail "
                    + "INNER JOIN sal_internal_memo_material ON sal_internal_memo_material.Code = sal_internal_memo_material_detail.HeaderCode "    
                    + "INNER JOIN mst_item_material ON mst_item_material.Code = sal_internal_memo_material_detail.ItemMaterialCode "
                    + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material.Code =  mst_item_material_jn_current_stock.ItemMaterialCode  "
                    + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode ) purchaseRequest "
                + "WHERE "
                + "purchaseRequest.HeaderCode = '"+code+"' "       
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("purchaseOrderSubItemPurchaseRequestNo", Hibernate.STRING)
            .addScalar("purchaseOrderSubItemPurchaseOrderItemMaterialCode", Hibernate.STRING)
            .addScalar("purchaseOrderSubItemPurchaseOrderItemMaterialName", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterialDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataApproval(InternalMemoMaterial internalMemoMaterialApprovalTemp){
        try{
            String concat_qry="";
            if(!internalMemoMaterialApprovalTemp.getApprovalStatus().equals("")){
                concat_qry="WHERE sal_internal_memo_material.ApprovalStatus LIKE '%"+internalMemoMaterialApprovalTemp.getApprovalStatus()+"%' ";
            }else{
                concat_qry="WHERE sal_internal_memo_material.ApprovalStatus LIKE '%%' ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM sal_internal_memo_material "
                + "INNER JOIN mst_branch ON mst_branch.Code = sal_internal_memo_material.BranchCode "       
                + concat_qry    
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<InternalMemoMaterial> findDataApproval(InternalMemoMaterial internalMemoMaterialApprovalTemp,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(internalMemoMaterialApprovalTemp.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(internalMemoMaterialApprovalTemp.getTransactionLastDate());
            
            String concat_qry="";
            if(!internalMemoMaterialApprovalTemp.getApprovalStatus().equals("")){
                concat_qry="AND sal_internal_memo_material.ApprovalStatus LIKE '%"+internalMemoMaterialApprovalTemp.getApprovalStatus()+"%' ";
            }else{
                concat_qry="AND sal_internal_memo_material.ApprovalStatus LIKE '%%' ";
            }
            
            List<InternalMemoMaterial> list = (List<InternalMemoMaterial>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "sal_internal_memo_material.Code, "
                + "sal_internal_memo_material.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "sal_internal_memo_material.RequestBy, "
                + "sal_internal_memo_material.RefNo, "
                + "sal_internal_memo_material.Remark, "
                + "sal_internal_memo_material.ApprovalStatus "
                    + "FROM "
                + "sal_internal_memo_material "
                + "INNER JOIN mst_branch ON mst_branch.Code = sal_internal_memo_material.BranchCode "
                + "WHERE sal_internal_memo_material.code LIKE '%"+internalMemoMaterialApprovalTemp.getCode()+"%' "
                + "AND sal_internal_memo_material.RefNo LIKE '%"+internalMemoMaterialApprovalTemp.getRefNo()+"%' "
                + "AND sal_internal_memo_material.Remark LIKE '%"+internalMemoMaterialApprovalTemp.getRemark()+"%' "
                + "AND DATE(sal_internal_memo_material.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + concat_qry
                + " AND sal_internal_memo_material.ClosingStatus = 'OPEN' "
                + " ORDER BY sal_internal_memo_material.TransactionDate DESC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterial.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataApprovalDetail(String code) {
        try {
            
            List<InternalMemoMaterialDetail> list = (List<InternalMemoMaterialDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_internal_memo_material_detail.Code, "
                + "sal_internal_memo_material_detail.HeaderCode, "
                + "mst_item_material.Code AS ItemMaterialCode, "
                + "mst_item_material.Name AS itemName, "
                + "sal_internal_memo_material_detail.Quantity, "
                + "sal_internal_memo_material_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "sal_internal_memo_material_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = sal_internal_memo_material_detail.ItemMaterialCode "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "sal_internal_memo_material_detail.HeaderCode = '"+code+"' "
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemCode", Hibernate.STRING)
            .addScalar("itemName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterialDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataClosing(InternalMemoMaterial internalMemoMaterialClosingTemp){
        try{
            String concat_qry="";
            if(!internalMemoMaterialClosingTemp.getClosingStatus().equals("")){
                concat_qry="WHERE sal_internal_memo_material.ClosingStatus LIKE '%"+internalMemoMaterialClosingTemp.getClosingStatus()+"%' ";
            }else{
                concat_qry="WHERE sal_internal_memo_material.ClosingStatus LIKE '%%' ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM sal_internal_memo_material "
                + "INNER JOIN mst_branch ON mst_branch.Code = sal_internal_memo_material.BranchCode "
                + concat_qry    
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<InternalMemoMaterial> findDataClosing(InternalMemoMaterial internalMemoMaterialClosingTemp,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(internalMemoMaterialClosingTemp.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(internalMemoMaterialClosingTemp.getTransactionLastDate());
            
            String concat_qry="";
            if(!internalMemoMaterialClosingTemp.getClosingStatus().equals("")){
                concat_qry="AND sal_internal_memo_material.ClosingStatus LIKE '%"+internalMemoMaterialClosingTemp.getClosingStatus()+"%' ";
            }else{
                concat_qry="AND sal_internal_memo_material.ClosingStatus LIKE '%%' ";
            }
            
            List<InternalMemoMaterial> list = (List<InternalMemoMaterial>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "sal_internal_memo_material.Code, "
                + "sal_internal_memo_material.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "sal_internal_memo_material.RequestBy, "
                + "sal_internal_memo_material.RefNo, "
                + "sal_internal_memo_material.Remark "
                + "FROM "
                + "sal_internal_memo_material "
                + "INNER JOIN mst_branch ON mst_branch.Code = sal_internal_memo_material.BranchCode "
                + "WHERE sal_internal_memo_material.code LIKE '%"+internalMemoMaterialClosingTemp.getCode()+"%' "
                + "AND sal_internal_memo_material.RefNo LIKE '%"+internalMemoMaterialClosingTemp.getRefNo()+"%' "
                + "AND sal_internal_memo_material.Remark LIKE '%"+internalMemoMaterialClosingTemp.getRemark()+"%' "
                + "AND DATE(sal_internal_memo_material.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + concat_qry
                + " ORDER BY sal_internal_memo_material.TransactionDate DESC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterial.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<InternalMemoMaterialDetail> findDataClosingDetail(String code) {
        try {
            
            List<InternalMemoMaterialDetail> list = (List<InternalMemoMaterialDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_internal_memo_material_detail.Code, "
                + "sal_internal_memo_material_detail.HeaderCode, "
                + "mst_item_material.Code AS ItemMaterialCode, "
                + "mst_item_material.Name AS itemName, "
                + "sal_internal_memo_material_detail.Quantity, "
                + "sal_internal_memo_material_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "sal_internal_memo_material_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = sal_internal_memo_material_detail.ItemMaterialCode "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "sal_internal_memo_material_detail.HeaderCode = '"+code+"' "
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemCode", Hibernate.STRING)
            .addScalar("itemName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterialDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public InternalMemoMaterial get(String code) {
        try {
               return (InternalMemoMaterial) hbmSession.hSession.get(InternalMemoMaterial.class, code);
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
    
    public String createCode(InternalMemoMaterial internalMemoMaterial){   
        try{
            String acronim = internalMemoMaterial.getBranch().getCode()+ "/IMM/"+AutoNumber.formatingDate(internalMemoMaterial.getTransactionDate(), true, true, false);;
            
            DetachedCriteria dc = DetachedCriteria.forClass(InternalMemoMaterial.class)
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
    
    public void save(InternalMemoMaterial internalMemoMaterial,List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail,String moduleCode) throws Exception{
        try{
            hbmSession.hSession.beginTransaction();
            
            String headerCode = createCode(internalMemoMaterial);
            internalMemoMaterial.setCode(headerCode);
            internalMemoMaterial.setTransactionDate(DateUtils.newDateTime(internalMemoMaterial.getTransactionDate(),true));
            internalMemoMaterial.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            internalMemoMaterial.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(internalMemoMaterial);
            
            if(listInternalMemoMaterialDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }

            int i = 1;
            for(InternalMemoMaterialDetail internalMemoMaterialDetail : listInternalMemoMaterialDetail){
                                                            
                String detailCode = headerCode+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                internalMemoMaterialDetail.setCode(detailCode);
                internalMemoMaterialDetail.setHeaderCode(internalMemoMaterial.getCode());
                
                internalMemoMaterialDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                internalMemoMaterialDetail.setCreatedDate(new Date());
                
                hbmSession.hSession.save(internalMemoMaterialDetail);
                i++;
            }
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), internalMemoMaterial.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }catch(HibernateException e){
           hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public void update(InternalMemoMaterial internalMemoMaterial,List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail,String moduleCode) throws Exception {
        try {
                                            
            hbmSession.hSession.beginTransaction();
            
            //ambil detail yg lama
            InternalMemoMaterial internalMemoMaterialOld = (InternalMemoMaterial)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    InternalMemoMaterialField.TRANSACTIONDATE + ", "+
                    InternalMemoMaterialField.CREATEDDATE + " "+
                    "FROM " + InternalMemoMaterialField.TABLE_NAME + "  " +
                    "WHERE " + InternalMemoMaterialField.CODE + "= :prmCode ")
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", internalMemoMaterial.getCode())
                .setResultTransformer(Transformers.aliasToBean(InternalMemoMaterial.class))
                .uniqueResult();
            
            hbmSession.hSession.flush();
            
            if(DateUtils.getExistingDate(internalMemoMaterialOld.getTransactionDate()).compareTo(DateUtils.getExistingDate(internalMemoMaterial.getTransactionDate()))!=0){
                internalMemoMaterial.setTransactionDate(DateUtils.newDateTime(internalMemoMaterial.getTransactionDate(),true));
            }else{
                internalMemoMaterial.setTransactionDate(internalMemoMaterialOld.getTransactionDate());
            }
            
            hbmSession.hSession.createQuery("DELETE FROM " + InternalMemoMaterialDetailField.BEAN_NAME + 
                                " WHERE " + InternalMemoMaterialDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", internalMemoMaterial.getCode())
                    .executeUpdate();
            internalMemoMaterial.setCreatedDate(internalMemoMaterialOld.getCreatedDate());
            internalMemoMaterial.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            internalMemoMaterial.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(internalMemoMaterial);
            
            if(listInternalMemoMaterialDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
            
            if(!updateDetail(internalMemoMaterial,listInternalMemoMaterialDetail)){
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    internalMemoMaterial.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private Boolean updateDetail(InternalMemoMaterial internalMemoMaterial,List<InternalMemoMaterialDetail> listInternalMemoMaterialDetail) throws Exception{
        try {
            
    
            int i = 1;
            for(InternalMemoMaterialDetail internalMemoMaterialDetail : listInternalMemoMaterialDetail){
                internalMemoMaterialDetail.setHeaderCode(internalMemoMaterial.getCode());
                String detailCode = internalMemoMaterial.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                internalMemoMaterialDetail.setCode(detailCode);
                internalMemoMaterialDetail.setCreatedBy(internalMemoMaterial.getCreatedBy());
                internalMemoMaterialDetail.setCreatedDate(internalMemoMaterial.getCreatedDate());
                internalMemoMaterialDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                internalMemoMaterialDetail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(internalMemoMaterialDetail);
                
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
                    
            hbmSession.hSession.createQuery("DELETE FROM "+InternalMemoMaterialField.BEAN_NAME+" WHERE "+InternalMemoMaterialField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM " + InternalMemoMaterialDetailField.BEAN_NAME + 
                                " WHERE " + InternalMemoMaterialDetailField.HEADERCODE + " = :prmHeaderCode")
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
    
    public void approval(InternalMemoMaterial internalMemoMaterialApproval, String MODULECODE) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            InternalMemoMaterial internalMemoMaterial=get(internalMemoMaterialApproval.getCode());
            
            internalMemoMaterial.setApprovalStatus(internalMemoMaterialApproval.getApprovalStatus());
            internalMemoMaterial.setApprovalBy(BaseSession.loadProgramSession().getUserName());
            internalMemoMaterial.setApprovalDate(new Date());
            internalMemoMaterial.setApprovalReason(internalMemoMaterialApproval.getApprovalReason());
                
            hbmSession.hSession.update(internalMemoMaterial);
            
//            if(listinternalMemoMaterialApproval==null){
//                hbmSession.hTransaction.rollback();
//                throw new Exception("FAILED DATA DETAIL INPUT!");
//            }
//            
//            hbmSession.hSession.createQuery("DELETE FROM " + InternalMemoMaterialDetailField.BEAN_NAME + 
//                                 " WHERE " + InternalMemoMaterialDetailField.HEADERCODE + " = :prmHeaderCode")
//                    .setParameter("prmHeaderCode", internalMemoMaterial.getCode())
//                    .executeUpdate();
//             
//            int i = 1;
//            for(InternalMemoMaterialDetail internalMemoMaterialDetail : listinternalMemoMaterialApproval){
//                                                            
//                String detailCode = internalMemoMaterial.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
//                internalMemoMaterialDetail.setCode(detailCode);
//                internalMemoMaterialDetail.setHeaderCode(internalMemoMaterial.getCode());
//                
//                internalMemoMaterialDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//                internalMemoMaterialDetail.setCreatedDate(new Date());
//                
//                hbmSession.hSession.save(internalMemoMaterialDetail);
//                i++;
//            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    internalMemoMaterialApproval.getApprovalStatus() , 
                                                                    internalMemoMaterialApproval.getCode(),"Approval Process: "+internalMemoMaterialApproval.getClosingStatus()));
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
    
    public void closing(InternalMemoMaterial internalMemoMaterialClosing, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            InternalMemoMaterial internalMemoMaterial=get(internalMemoMaterialClosing.getCode());
            
            String closingBy="";
            Date closingDate=DateUtils.newDate(1900, 1, 1);
            
            if(internalMemoMaterialClosing.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.ENUM_ClosingStatus.CLOSED.toString())){
                closingBy=BaseSession.loadProgramSession().getUserName();
                closingDate=new Date();
            }
            
            internalMemoMaterial.setClosingBy(closingBy);
            internalMemoMaterial.setClosingDate(closingDate);
            internalMemoMaterial.setClosingRemark(internalMemoMaterialClosing.getClosingRemark());
            internalMemoMaterial.setClosingStatus(internalMemoMaterialClosing.getClosingStatus());
            internalMemoMaterial.setClosingReason(internalMemoMaterialClosing.getClosingReason());
            hbmSession.hSession.update(internalMemoMaterial);
           

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    internalMemoMaterial.getClosingStatus(), 
                                                                    internalMemoMaterialClosing.getCode(), "Closing Process: "+internalMemoMaterialClosing.getClosingStatus()));
                        
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
