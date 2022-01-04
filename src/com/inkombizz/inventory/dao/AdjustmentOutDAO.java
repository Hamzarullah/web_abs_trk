
package com.inkombizz.inventory.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.InventoryCommon;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumCOGSType;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.AdjustmentInSerialNoDetail;
import com.inkombizz.inventory.model.AdjustmentOutItemDetail;
import com.inkombizz.inventory.model.AdjustmentOutSerialNoDetail;
import com.inkombizz.inventory.model.AdjustmentOut;
import com.inkombizz.inventory.model.AdjustmentOutItemDetail;
import com.inkombizz.inventory.model.AdjustmentOutItemDetailField;
import com.inkombizz.inventory.model.AdjustmentOutSerialNoDetail;
import com.inkombizz.inventory.model.AdjustmentOutSerialNoDetailField;
import com.inkombizz.inventory.model.ItemMaterialStockLocation;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.inventory.model.InventoryActualStockField;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.master.model.Currency;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

public class AdjustmentOutDAO {
    
    private HBMSession hbmSession;
    private InventoryInOutDAO inventoryInOutDAO;
    
    public AdjustmentOutDAO (HBMSession session) {
        this.hbmSession = session;
    } 
    
    public int countData(AdjustmentOut adjustmentOut){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(adjustmentOut.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(adjustmentOut.getTransactionLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	COUNT(ivt_adjustment_out.`Code`) " +
                "FROM ivt_adjustment_out " +
                "INNER JOIN `mst_warehouse` ON ivt_adjustment_out.`WarehouseCode`=mst_warehouse.`Code` " +
                "WHERE ivt_adjustment_out.`Code` LIKE '%"+adjustmentOut.getCode()+"%' " +
                "	AND ivt_adjustment_out.`WarehouseCode` LIKE '%"+adjustmentOut.getWarehouseCode()+"%' " +
                "	AND mst_warehouse.`Name` LIKE '%"+adjustmentOut.getWarehouseName()+"%' " +
                "	AND ivt_adjustment_out.`RefNo` LIKE '%"+adjustmentOut.getRefNo()+"%' " +
                "	AND ivt_adjustment_out.`Remark` LIKE '%"+adjustmentOut.getRemark()+"%' " +
                "	AND DATE(ivt_adjustment_out.`TransactionDate`) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
            ).uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<AdjustmentOut> findData(AdjustmentOut adjustmentOut,int from,int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(adjustmentOut.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(adjustmentOut.getTransactionLastDate());
            
            List<AdjustmentOut> list = (List<AdjustmentOut>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	ivt_adjustment_out.Code, " +
                "	ivt_adjustment_out.BranchCode, " +
                "	ivt_adjustment_out.TransactionDate, " +
                "	ivt_adjustment_out.CurrencyCode, " +
                "	ivt_adjustment_out.ExchangeRate, " +
                "	ivt_adjustment_out.WarehouseCode, " +
                "	mst_warehouse.Name AS WarehouseName, " +
                "	ivt_adjustment_out.RefNo, " +
                "	ivt_adjustment_out.Remark " +
                "FROM ivt_adjustment_out " +
                "INNER JOIN `mst_warehouse` ON ivt_adjustment_out.`WarehouseCode`=mst_warehouse.`Code` " +
                "WHERE ivt_adjustment_out.`Code` LIKE '%"+adjustmentOut.getCode()+"%' " +
                "	AND ivt_adjustment_out.`WarehouseCode` LIKE '%"+adjustmentOut.getWarehouseCode()+"%' " +
                "	AND mst_warehouse.`Name` LIKE '%"+adjustmentOut.getWarehouseName()+"%' " +
                "	AND ivt_adjustment_out.`RefNo` LIKE '%"+adjustmentOut.getRefNo()+"%' " +
                "	AND ivt_adjustment_out.`Remark` LIKE '%"+adjustmentOut.getRemark()+"%' " +
                "	AND DATE(ivt_adjustment_out.`TransactionDate`) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY ivt_adjustment_out.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOut.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataApproval(AdjustmentOut adjustmentOut){
        try{
            
            String concatQueryApprovalStatus="";
            if(!adjustmentOut.getApprovalStatus().equals("")){
                concatQueryApprovalStatus="AND ivt_adjustment_out.ApprovalStatus='"+adjustmentOut.getApprovalStatus()+"' ";
            }
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(adjustmentOut.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(adjustmentOut.getTransactionLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM ivt_adjustment_out "
                + "INNER JOIN mst_branch ON ivt_adjustment_out.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_warehouse ON ivt_adjustment_out.WarehouseCode=mst_warehouse.code "
                + "WHERE ivt_adjustment_out.Code LIKE '%"+adjustmentOut.getCode()+"%' "
                + concatQueryApprovalStatus
                + "AND DATE(ivt_adjustment_out.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     
    public List<AdjustmentOut> findDataApproval(AdjustmentOut adjustmentOut, int from, int row) {
        try {   
            
            String concatQueryApprovalStatus="";
            if(!adjustmentOut.getApprovalStatus().equals("")){
                concatQueryApprovalStatus="AND ivt_adjustment_out.ApprovalStatus='"+adjustmentOut.getApprovalStatus()+"' ";
            }
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            
            String dateFirst = DATE_FORMAT.format(adjustmentOut.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(adjustmentOut.getTransactionLastDate());
            
            List<AdjustmentOut> list = (List<AdjustmentOut>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_out.Code, "
                + "ivt_adjustment_out.BranchCode, "
                + "ivt_adjustment_out.TransactionDate, "
                + "ivt_adjustment_out.CurrencyCode, "
                + "ivt_adjustment_out.ExchangeRate, "
                + "ivt_adjustment_out.WarehouseCode, "
                + "mst_warehouse.Name AS warehouseName, "
                + "ivt_adjustment_out.ApprovalStatus, "
                + "ivt_adjustment_out.ApprovalDate, "
                + "ivt_adjustment_out.ApprovalBy, "
                + "ivt_adjustment_out.RefNo, "
                + "ivt_adjustment_out.Remark "
                + "FROM ivt_adjustment_out "
                + "INNER JOIN mst_branch ON ivt_adjustment_out.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_warehouse ON ivt_adjustment_out.WarehouseCode=mst_warehouse.code "
                + "WHERE ivt_adjustment_out.Code LIKE '%"+adjustmentOut.getCode()+"%' "            
                + concatQueryApprovalStatus
                + "AND DATE(ivt_adjustment_out.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY ivt_adjustment_out.TransactionDate DESC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING) 
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("approvalDate", Hibernate.TIMESTAMP)
                .addScalar("approvalBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOut.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdjustmentOutItemDetail> findDataItemDetail(String headerCode) {
        try {
            List<AdjustmentOutItemDetail> list = (List<AdjustmentOutItemDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_out_item_detail.Code, "
                + "ivt_adjustment_out_item_detail.ItemMaterialCode, "
                + "mst_item_material.Name AS ItemMaterialName, "
                + "CASE "
                + "WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
                + "WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO'  "
                + "END AS itemMaterialSerialNoStatus, "
                + "mst_item_material.InventoryType AS ItemMaterialInventoryType, "
                + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                + "ivt_adjustment_out_item_detail.Quantity, "
                + "ivt_adjustment_out_item_detail.ReasonCode, "
                + "IFNULL(mst_reason.Name,'')AS ReasonName, "
                + "ivt_adjustment_out_item_detail.Remark, "
                + "ivt_adjustment_out_item_detail.rackCode, "
                + "mst_rack.name AS rackName "
                + "FROM ivt_adjustment_out_item_detail "
                + "INNER JOIN mst_item_material ON ivt_adjustment_out_item_detail.ItemMaterialCode=mst_item_material.Code "
                + "LEFT JOIN mst_reason ON ivt_adjustment_out_item_detail.ReasonCode=mst_reason.Code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "LEFT JOIN mst_rack ON mst_rack.code=ivt_adjustment_out_item_detail.rackCode "
                + "WHERE ivt_adjustment_out_item_detail.HeaderCode='"+headerCode+"' "
                + "ORDER BY ivt_adjustment_out_item_detail.ItemMaterialCode ASC")

                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode",  Hibernate.STRING)
                .addScalar("itemMaterialName",  Hibernate.STRING)
                .addScalar("itemMaterialSerialNoStatus",  Hibernate.STRING)
                .addScalar("itemMaterialInventoryType",  Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("reasonCode",  Hibernate.STRING)
                .addScalar("reasonName",  Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("rackCode",Hibernate.STRING)
                .addScalar("rackName",Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOutItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdjustmentOutSerialNoDetail> findDataSerialNoDetail(String headerCode) {
        try {
            List<AdjustmentOutSerialNoDetail> list = (List<AdjustmentOutSerialNoDetail>)hbmSession.hSession.createSQLQuery(
                   "SELECT "
                + "ivt_adjustment_out_serial_no_detail.ItemMaterialCode, "
                + "mst_item_material.Name AS ItemMaterialName, "
                + "CASE "
                + "WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
                + "WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO'  "
                + "END AS itemMaterialSerialNoStatus, "
                + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                + "ivt_adjustment_out_serial_no_detail.SerialNo, "
                + "ivt_adjustment_out_serial_no_detail.reasonCode, "
                + "mst_reason.name AS reasonName, "
                + "ivt_adjustment_out_serial_no_detail.inTransactionCode, "
                + "ivt_adjustment_out_serial_no_detail.capacity, "
                + "ivt_adjustment_out_serial_no_detail.cogsIdr, "
                + "ivt_adjustment_out_serial_no_detail.rackCode, "
                + "mst_rack.name AS rackName, "
                + "ivt_adjustment_out_serial_no_detail.Remark "
                + "FROM ivt_adjustment_out_serial_no_detail "
                + "INNER JOIN mst_item_material ON ivt_adjustment_out_serial_no_detail.ItemMaterialCode=mst_item_material.Code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "LEFT JOIN mst_reason ON mst_reason.code=ivt_adjustment_out_serial_no_detail.reasonCode "
                + "LEFT JOIN mst_rack ON mst_rack.code=ivt_adjustment_out_serial_no_detail.rackCode "
                + "WHERE ivt_adjustment_out_serial_no_detail.HeaderCode ='"+headerCode+"' "
                + "ORDER BY ivt_adjustment_out_serial_no_detail.ItemMaterialCode ASC")

                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName",Hibernate.STRING)
                .addScalar("itemMaterialSerialNoStatus",Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode",Hibernate.STRING)
                .addScalar("serialNo",Hibernate.STRING)
                .addScalar("reasonCode",Hibernate.STRING)
                .addScalar("reasonName",Hibernate.STRING)
                .addScalar("capacity",Hibernate.BIG_DECIMAL)
                .addScalar("cogsIdr",Hibernate.BIG_DECIMAL)
                .addScalar("rackCode",Hibernate.STRING)
                .addScalar("rackName",Hibernate.STRING)
                .addScalar("inTransactionCode",Hibernate.STRING)
                .addScalar("remark",Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOutSerialNoDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdjustmentOutSerialNoDetail> findBulkDataSerialNoDetail(List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail) {
        try {
            
            ArrayList<String> arrItemDetailCode=new ArrayList<String>();
            for(AdjustmentOutItemDetail adjustmentOutItemDetail:listAdjustmentOutItemDetail){
                arrItemDetailCode.add(adjustmentOutItemDetail.getCode());
            }
            
            String strItemDetailCode=Arrays.toString(arrItemDetailCode.toArray());
            strItemDetailCode = strItemDetailCode.replaceAll(" ","");
            strItemDetailCode = strItemDetailCode.replaceAll("[\\[\\]]", "");
            strItemDetailCode = strItemDetailCode.replaceAll(",", "','");
            
            List<AdjustmentOutSerialNoDetail> list = (List<AdjustmentOutSerialNoDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_out_serial_no_detail.Code, "
                + "ivt_adjustment_out_serial_no_detail.HeaderCode, "
                + "ivt_adjustment_out_serial_no_detail.ItemMaterialCode, "
                + "mst_item_material.Name AS ItemMaterialName, "
                + "CASE "
                + "WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
                + "WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO'  "
                + "END AS itemMaterialSerialNoStatus, "
                + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                + "ivt_adjustment_out_serial_no_detail.SerialNo, "
                + "ivt_adjustment_out_serial_no_detail.Capacity, "
                + "ivt_adjustment_out_serial_no_detail.RackCode, "
                + "mst_rack.Name AS RackName, "
                + "ivt_adjustment_out_serial_no_detail.Remark "
                + "FROM ivt_adjustment_out_serial_no_detail "
                + "INNER JOIN mst_item_material ON ivt_adjustment_out_serial_no_detail.ItemMaterialCode=mst_item_material.Code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_rack ON mst_rack.Code=ivt_adjustment_out_serial_no_detail.RackCode "
                + "WHERE ivt_adjustment_out_serial_no_detail.HeaderCode IN('"+strItemDetailCode+"') "
                + "ORDER BY ivt_adjustment_out_serial_no_detail.HeaderCode ASC")

                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName",Hibernate.STRING)
                .addScalar("itemMaterialSerialNoStatus",Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode",Hibernate.STRING)
                .addScalar("serialNo",Hibernate.STRING)
                .addScalar("remark",Hibernate.STRING)
                .addScalar("capacity",Hibernate.BIG_DECIMAL)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName",Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOutSerialNoDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdjustmentOutSerialNoDetail> findDataSerialNoDetailByApproval(String code) {
        try {
            
           
            
            List<AdjustmentOutSerialNoDetail> list = (List<AdjustmentOutSerialNoDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_out_serial_no_detail.ItemMaterialCode, "
                + "mst_item_material.Name AS ItemMaterialName, "
                + "CASE "
                + "WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
                + "WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO'  "
                + "END AS itemMaterialSerialNoStatus, "
                + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                + "ivt_adjustment_out_serial_no_detail.SerialNo, "
                + "ivt_adjustment_out_serial_no_detail.reasonCode, "
                + "mst_reason.name AS reasonName, "
                + "ivt_adjustment_out_serial_no_detail.inTransactionCode, "
                + "ivt_adjustment_out_serial_no_detail.capacity, "
                + "ivt_adjustment_out_serial_no_detail.cogsIdr, "
                + "ivt_adjustment_out_serial_no_detail.rackCode, "
                + "mst_rack.name AS rackName "
                + "FROM ivt_adjustment_out_serial_no_detail "
                + "INNER JOIN mst_item_material ON ivt_adjustment_out_serial_no_detail.ItemMaterialCode=mst_item_material.Code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "LEFT JOIN mst_reason ON mst_reason.code=ivt_adjustment_out_serial_no_detail.reasonCode "
                +"LEFT JOIN mst_rack ON mst_rack.code=ivt_adjustment_out_serial_no_detail.rackCode "
                + "WHERE ivt_adjustment_out_serial_no_detail.HeaderCode ='"+code+"' "
                + "ORDER BY ivt_adjustment_out_serial_no_detail.ItemMaterialCode ASC")

                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName",Hibernate.STRING)
                .addScalar("itemMaterialSerialNoStatus",Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode",Hibernate.STRING)
                .addScalar("serialNo",Hibernate.STRING)
                .addScalar("reasonCode",Hibernate.STRING)
                .addScalar("reasonName",Hibernate.STRING)
                .addScalar("capacity",Hibernate.BIG_DECIMAL)
                .addScalar("cogsIdr",Hibernate.BIG_DECIMAL)
                .addScalar("rackCode",Hibernate.STRING)
                .addScalar("rackName",Hibernate.STRING)
                .addScalar("inTransactionCode",Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOutSerialNoDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public AdjustmentOut findDataHeader(String code){
       try {   
            AdjustmentOut adjustmentOutTemp = (AdjustmentOut)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_out.Code, "
                + "ivt_adjustment_out.BranchCode, "
                + "mst_branch.Name AS BranchName, "
//                + "ivt_adjustment_out.CompanyCode, "
//                + "mst_company.Name AS CompanyName, "
                + "ivt_adjustment_out.TransactionDate, "
                + "ivt_adjustment_out.CurrencyCode, "
                + "ivt_adjustment_out.ExchangeRate, "
                + "ivt_adjustment_out.WarehouseCode, "
                + "mst_warehouse.Name AS warehouseName, "
                + "ivt_adjustment_out.approvalStatus, "
                + "ivt_adjustment_out.approvalDate, "
                + "ivt_adjustment_out.approvalBy, "            
                + "ivt_adjustment_out.Refno, "
                + "ivt_adjustment_out.Remark "
                + "FROM ivt_adjustment_out "
                + "INNER JOIN mst_branch ON ivt_adjustment_out.BranchCode=mst_branch.Code "
//                + "INNER JOIN mst_company ON ivt_adjustment_out.CompanyCode=mst_company.Code "
                + "INNER JOIN mst_warehouse ON mst_warehouse.Code=ivt_adjustment_out.WarehouseCode "
                 + "WHERE ivt_adjustment_out.code LIKE '%"+code+"%' ")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
//                .addScalar("companyCode", Hibernate.STRING)
//                .addScalar("companyName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING) 
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("approvalDate", Hibernate.TIMESTAMP)
                .addScalar("approvalBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOut.class))
                .uniqueResult(); 
                 
                return adjustmentOutTemp;
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
    
    private String createCode(AdjustmentOut adjustmentOut){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.ADJOUT.toString();
            String acronim = adjustmentOut.getBranch().getCode() +"/"+tempKode+"/"+AutoNumber.formatingDate(adjustmentOut.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(AdjustmentOut.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

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
    
    public void save(AdjustmentOut adjustmentOut, List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail,List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail,String MODULECODE) throws Exception {
        try {
            
            String headerCode=createCode(adjustmentOut);
            
            hbmSession.hSession.beginTransaction();
            
            adjustmentOut.setCode(headerCode);
            adjustmentOut.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            adjustmentOut.setCreatedDate(new Date());
            adjustmentOut.setCurrency(null);
            adjustmentOut.setApprovalStatus("PENDING");
            
            int i=1;
            for(AdjustmentOutItemDetail adjustmentOutItemDetail:listAdjustmentOutItemDetail){
                String detailCode = adjustmentOut.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                adjustmentOutItemDetail.setCode(detailCode);
//                adjustmentOutItemDetail.setPrice(BigDecimal.ZERO);
//                adjustmentOutItemDetail.setTotalAmount(BigDecimal.ZERO);
                adjustmentOutItemDetail.setHeaderCode(headerCode);
                adjustmentOutItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentOutItemDetail.setCreatedDate(new Date());
                                
                hbmSession.hSession.save(adjustmentOutItemDetail);	
                
                i++;
            }   
            
            int j = 1;
            for(AdjustmentOutSerialNoDetail adjustmentOutSerialNoDetail : listAdjustmentOutSerialNoDetail){

                    String serialDetailCode = adjustmentOut.getCode()+ "-" +adjustmentOutSerialNoDetail.getSerialNo() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    adjustmentOutSerialNoDetail.setCode(serialDetailCode);
                    adjustmentOutSerialNoDetail.setHeaderCode(adjustmentOut.getCode());

                    adjustmentOutSerialNoDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    adjustmentOutSerialNoDetail.setCreatedDate(new Date());
                    
                    hbmSession.hSession.save(adjustmentOutSerialNoDetail);
                    j++;
            }
            
            hbmSession.hSession.save(adjustmentOut);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    adjustmentOut.getCode(), ""));
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(AdjustmentOut adjustmentOut, List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail,List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            adjustmentOut.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            adjustmentOut.setUpdatedDate(new Date());
            Currency c = new Currency();
                c.setCode(BaseSession.loadProgramSession().getSetup().getCurrencyCode());
            adjustmentOut.setCurrency(c);
            adjustmentOut.setExchangeRate(new BigDecimal("1"));

            hbmSession.hSession.update(adjustmentOut);
            
            if(!updateDetail(adjustmentOut, listAdjustmentOutItemDetail,listAdjustmentOutSerialNoDetail)){
                hbmSession.hTransaction.rollback();
            }
           
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    adjustmentOut.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
    private Boolean updateDetail(AdjustmentOut adjustmentOut, List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail,List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail) throws Exception{
        try {
            
//            List<AdjustmentOutItemDetail> oldItemDetail = findDataItemDetail(adjustmentOut.getCode());  
//            for(AdjustmentOutItemDetail itemDetail : oldItemDetail){
//                hbmSession.hSession.createQuery("DELETE FROM " + AdjustmentOutSerialNoDetailField.BEAN_NAME + 
//                                 " WHERE " + AdjustmentOutSerialNoDetailField.HEADERCODE + " = :prmHeaderCode")
//                    .setParameter("prmHeaderCode", adjustmentOut.getCode())
//                    .executeUpdate();
//            }
            
            hbmSession.hSession.createQuery("DELETE FROM " + AdjustmentOutSerialNoDetailField.BEAN_NAME + 
                                 " WHERE " + AdjustmentOutSerialNoDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", adjustmentOut.getCode())
                    .executeUpdate();
            
            
            hbmSession.hSession.createQuery("DELETE FROM " + AdjustmentOutItemDetailField.BEAN_NAME + 
                                 " WHERE " + AdjustmentOutItemDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", adjustmentOut.getCode())
                    .executeUpdate();
            
            
            
            
            int i = 1;
            for(AdjustmentOutItemDetail adjustmentOutItemDetail : listAdjustmentOutItemDetail){
                adjustmentOutItemDetail.setHeaderCode(adjustmentOut.getCode());
                String detailCode = adjustmentOut.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                adjustmentOutItemDetail.setCode(detailCode);
                adjustmentOutItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentOutItemDetail.setCreatedDate(new Date());
                adjustmentOutItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentOutItemDetail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(adjustmentOutItemDetail);
                
                i++;
                
            }
            
            int j = 1;
            for(AdjustmentOutSerialNoDetail adjustmentOutSerialNoDetail : listAdjustmentOutSerialNoDetail){
                String serialDetailCode = adjustmentOut.getCode()+ "-" +adjustmentOutSerialNoDetail.getSerialNo() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                adjustmentOutSerialNoDetail.setCode(serialDetailCode);
                adjustmentOutSerialNoDetail.setHeaderCode(adjustmentOut.getCode());
                adjustmentOutSerialNoDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentOutSerialNoDetail.setCreatedDate(new Date());
                adjustmentOutSerialNoDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentOutSerialNoDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(adjustmentOutSerialNoDetail);
                j++;
            }
            
            return Boolean.TRUE;
            
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public int countDataApproval(String code,String approvalStatus,Date firstDate,Date lastDate){
        try{
            
            String concatQueryApprovalStatus="";
            switch(approvalStatus){
                case "A":
                    concatQueryApprovalStatus="AND ivt_adjustment_out.ApprovalStatus='APPROVED' ";
                    break;
                case "P":
                    concatQueryApprovalStatus="AND ivt_adjustment_out.ApprovalStatus='PENDING' ";
                    break;
            }
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM ivt_adjustment_out "
                + "INNER JOIN mst_branch ON ivt_adjustment_out.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_warehouse ON ivt_adjustment_out.WarehouseCode=mst_warehouse.code "
                + "WHERE ivt_adjustment_out.Code LIKE '%"+code+"%' "
                + concatQueryApprovalStatus
                + "AND DATE(ivt_adjustment_out.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<AdjustmentOut> findDataApproval(String code,String approvalStatus,Date firstDate,Date lastDate, int from, int row) {
        try {   
            
            String concatQueryApprovalStatus="";
            switch(approvalStatus){
                case "A":
                    concatQueryApprovalStatus="AND ivt_adjustment_out.ApprovalStatus='APPROVED' ";
                    break;
                case "P":
                    concatQueryApprovalStatus="AND ivt_adjustment_out.ApprovalStatus='PENDING' ";
                    break;
            }
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<AdjustmentOut> list = (List<AdjustmentOut>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_out.Code, "
                + "ivt_adjustment_out.BranchCode, "
                + "ivt_adjustment_out.TransactionDate, "                
                + "ivt_adjustment_out.WarehouseCode, "
                + "mst_warehouse.Name AS warehouseName, "
                + "ivt_adjustment_out.approvalStatus, "
                + "ivt_adjustment_out.ApprovalDate, "
                + "ivt_adjustment_out.ApprovalBy, "
                + "ivt_adjustment_out.Refno, "
                + "ivt_adjustment_out.Remark "
                + "FROM ivt_adjustment_out "
                + "INNER JOIN mst_branch ON ivt_adjustment_out.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_warehouse ON ivt_adjustment_out.WarehouseCode=mst_warehouse.code "
                + "WHERE ivt_adjustment_out.Code LIKE '%"+code+"%' "            
                + concatQueryApprovalStatus
                + "AND DATE(ivt_adjustment_out.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY ivt_adjustment_out.TransactionDate DESC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING) 
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("approvalDate", Hibernate.TIMESTAMP)
                .addScalar("approvalBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentOut.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void approval(AdjustmentOut adjustmentOut, List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail,List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail,String MODULECODE) throws Exception {
        try {
                        
            hbmSession.hSession.beginTransaction();
            
            String approvalBy = BaseSession.loadProgramSession().getUserName();

            adjustmentOut.setApprovalBy(approvalBy);
            adjustmentOut.setApprovalDate(new Date());
            hbmSession.hSession.update(adjustmentOut);
            int i=1;
            InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
            for(AdjustmentOutItemDetail adjustmentOutItemDetail:listAdjustmentOutItemDetail){ 
                 String detailCode = adjustmentOut.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                int actualStock_SortNo =0;
                 IvtActualStock newRec = new IvtActualStock();
                if(adjustmentOutItemDetail.getItemMaterial().getInventoryType().equals("INVENTORY")){
                    newRec = InventoryCommon.newInstance(
                            adjustmentOut.getWarehouse().getCode(),
                            adjustmentOut.getBranch().getCode(),
                            adjustmentOutItemDetail.getItemMaterial().getCode(),
                            adjustmentOutItemDetail.getQuantity(),
                            BigDecimal.ZERO,adjustmentOutItemDetail.getRack().getCode());
                    inventoryInOutDAO.ActualStockDecrease_AVG(newRec,false,false,adjustmentOut.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.IIN,actualStock_SortNo);
                }
            }
                        
            ItemMaterialStockLocationDAO itemMaterialStockLocationDAO=new ItemMaterialStockLocationDAO(hbmSession);
            int j = 1;
            for(AdjustmentOutSerialNoDetail adjustmentOutSerialNoDetail : listAdjustmentOutSerialNoDetail){
                    
                    String code=adjustmentOut.getCode()+"-"+ adjustmentOutSerialNoDetail.getItemMaterial().getCode()+"-"+ org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_5, "0");

                    ItemMaterialStockLocation itemMaterialStockLocation=new ItemMaterialStockLocation();
                    itemMaterialStockLocation.setCode(code);
                    itemMaterialStockLocation.setIsOut(true);
                    itemMaterialStockLocation.setSerialNo(adjustmentOutSerialNoDetail.getSerialNo());
                    itemMaterialStockLocation.setWarehouse(adjustmentOut.getWarehouse());
                    itemMaterialStockLocation.setRack(adjustmentOutSerialNoDetail.getRack());
                    itemMaterialStockLocation.setCapacity(adjustmentOutSerialNoDetail.getCapacity().negate());
                    itemMaterialStockLocation.setTransactionDate(adjustmentOut.getApprovalDate());
                    itemMaterialStockLocation.setTransactionCode(adjustmentOut.getCode());
                    itemMaterialStockLocation.setTransactionType(EnumTransactionType.ENUM_TransactionType.ADJOUT.toString());
                    itemMaterialStockLocation.setItemMaterial(adjustmentOutSerialNoDetail.getItemMaterial());

                    if(!itemMaterialStockLocationDAO.save(itemMaterialStockLocation, "003_IVT_ITEM_STOCK_LOCATION")){
                        hbmSession.hTransaction.rollback();
                    };
                    j++;
            }
            
            hbmSession.hSession.update(adjustmentOut);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    adjustmentOut.getCode(), "Adjustment Out Approval"));
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
//        finally{
//            hbmSession.hSession.clear();
//            hbmSession.hSession.close();
//        }
    }
    
//    public CurrenctStockSerialNo findDataCheckCurrentStock(String code){
//       try {   
//            CurrenctStockSerialNo currenctStockTemp = (CurrenctStockSerialNo)hbmSession.hSession.createSQLQuery(
//                    "SELECT "
//                + "ivt_adjustment_out.Code, "
//                + "ivt_adjustment_out.BranchCode, "
//                + "mst_branch.Name AS BranchName, "
////                + "ivt_adjustment_out.CompanyCode, "
////                + "mst_company.Name AS CompanyName, "
//                + "ivt_adjustment_out.TransactionDate, "
//                + "ivt_adjustment_out.WarehouseCode, "
//                + "mst_warehouse.Name AS warehouseName, "
//                + "ivt_adjustment_out.approvalStatus, "
//                + "ivt_adjustment_out.approvalDate, "
//                + "ivt_adjustment_out.approvalBy, "            
//                + "ivt_adjustment_out.RefNo, "
//                + "ivt_adjustment_out.Remark "
//                + "FROM ivt_adjustment_out "
//                + "INNER JOIN mst_branch ON ivt_adjustment_out.BranchCode=mst_branch.Code "
////                + "INNER JOIN mst_company ON ivt_adjustment_out.CompanyCode=mst_company.Code "
//                + "INNER JOIN mst_warehouse ON mst_warehouse.Code=ivt_adjustment_out.WarehouseCode "
//                 + "WHERE ivt_adjustment_out.code LIKE '%"+code+"%' ")
//                    
//                .addScalar("code", Hibernate.STRING)
//                .addScalar("branchCode", Hibernate.STRING)
//                .addScalar("branchName", Hibernate.STRING)
////                .addScalar("companyCode", Hibernate.STRING)
////                .addScalar("companyName", Hibernate.STRING)
//                .addScalar("transactionDate", Hibernate.TIMESTAMP)
//                .addScalar("warehouseCode", Hibernate.STRING)
//                .addScalar("warehouseName", Hibernate.STRING) 
//                .addScalar("approvalStatus", Hibernate.STRING)
//                .addScalar("approvalDate", Hibernate.TIMESTAMP)
//                .addScalar("approvalBy", Hibernate.STRING)
//                .addScalar("refNo", Hibernate.STRING)
//                .addScalar("remark", Hibernate.STRING)
//                .setResultTransformer(Transformers.aliasToBean(CurrenctStockSerialNo.class))
//                .uniqueResult(); 
//                 
//                return currenctStockTemp;
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public void delete(String code, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            List<AdjustmentOutItemDetail> oldItemDetail = findDataItemDetail(code);  
            
            for(AdjustmentOutItemDetail itemDetail : oldItemDetail){                
                hbmSession.hSession.createQuery("DELETE FROM AdjustmentOutSerialNoDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            
                hbmSession.hSession.flush();
            }
    
            hbmSession.hSession.createQuery("DELETE FROM AdjustmentOutItemDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM AdjustmentOut " 
                                 +" WHERE code  = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
            
            hbmSession.hTransaction.commit();
            
        }catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public Boolean isApproved(String code) throws Exception{
        try {
            String approvalStatus = (String)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "CASE "
                + "WHEN ivt_adjustment_out.ApprovalStatus='APPROVED' THEN "
                + " 'APPROVED' "
                + "WHEN ivt_adjustment_out.ApprovalStatus='REJECTED' THEN "
                + " 'REJECTED' "
                + "ELSE 'PENDING' END AS ApprovalStatus "
                + "FROM ivt_adjustment_out "
                + "WHERE ivt_adjustment_out.Code='"+code+"'"
            ).uniqueResult();
            
            if(approvalStatus.equals("APPROVED") || approvalStatus.equals("REJECTED")){
                return Boolean.TRUE;
            }
            
            return Boolean.FALSE;
        } catch (HibernateException e) {
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

    public InventoryInOutDAO getInventoryInOutDAO() {
        return inventoryInOutDAO;
    }

    public void setInventoryInOutDAO(InventoryInOutDAO inventoryInOutDAO) {
        this.inventoryInOutDAO = inventoryInOutDAO;
    }
    
}
