/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.InventoryCommon;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumCOGSType;
import com.inkombizz.common.enumeration.EnumInventoryType;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.GoodsReceivedNote;
import com.inkombizz.inventory.model.GoodsReceivedNoteField;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemDetail;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemDetailField;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemSerialNoDetail;
import com.inkombizz.inventory.model.GoodsReceivedNoteItemSerialNoDetailField;
import com.inkombizz.inventory.model.ItemMaterialStockLocation;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigDecimal;
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
 * @author ikb
 */
public class GoodsRecivedNoteDAO {
    private HBMSession hbmSession;

    public GoodsRecivedNoteDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(GoodsReceivedNote goodsReceivedNote){
        try{
            String confirmationStatus=goodsReceivedNote.getConfirmationStatus().equals("ALL") ? "%%" : "%"+goodsReceivedNote.getConfirmationStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_good_received_note_list(:prmFlag,:prmCode,:prmPurchaseOrderCode,:prmVendorCode,:prmVendorName,"
                        + ":prmWarehouseCode,:prmWarehouseName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+goodsReceivedNote.getCode()+"%")
                .setParameter("prmPurchaseOrderCode","%"+goodsReceivedNote.getPurchaseOrderCode() +"%")
                .setParameter("prmVendorCode","%"+goodsReceivedNote.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+goodsReceivedNote.getVendorName()+"%")
                .setParameter("prmWarehouseCode", "%"+goodsReceivedNote.getWarehouseCode()+"%")
                .setParameter("prmWarehouseName", "%"+goodsReceivedNote.getWarehouseName()+"%")
                .setParameter("prmRefNo", "%"+goodsReceivedNote.getRefNo()+"%")
                .setParameter("prmRemark", "%"+goodsReceivedNote.getRemark()+"%")
                .setParameter("prmFirstDate", goodsReceivedNote.getTransactionFirstDate())
                .setParameter("prmLastDate", goodsReceivedNote.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();
                      
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataConfirmation(GoodsReceivedNote goodsReceivedNote){
        try{
            String confirmationStatus=goodsReceivedNote.getConfirmationStatus().equals("ALL") ? "%%" : "%"+goodsReceivedNote.getConfirmationStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_good_received_note_confirmation_list(:prmFlag,:prmCode,:prmPurchaseOrderCode,:prmVendorCode,:prmVendorName,"
                        + ":prmWarehouseCode,:prmWarehouseName,:prmRefNo,:prmRemark,'"+goodsReceivedNote.getConfirmationStatus()+"',:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+goodsReceivedNote.getCode()+"%")
                .setParameter("prmPurchaseOrderCode","%"+goodsReceivedNote.getPurchaseOrderCode() +"%")
                .setParameter("prmVendorCode","%"+goodsReceivedNote.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+goodsReceivedNote.getVendorName()+"%")
                .setParameter("prmWarehouseCode", "%"+goodsReceivedNote.getWarehouseCode()+"%")
                .setParameter("prmWarehouseName", "%"+goodsReceivedNote.getWarehouseName()+"%")
                .setParameter("prmRefNo", "%"+goodsReceivedNote.getRefNo()+"%")
                .setParameter("prmRemark", "%"+goodsReceivedNote.getRemark()+"%")
                .setParameter("prmFirstDate", goodsReceivedNote.getTransactionFirstDate())
                .setParameter("prmLastDate", goodsReceivedNote.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();
                      
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<GoodsReceivedNote> findData(GoodsReceivedNote goodsReceivedNote, int from, int to) {
        try {
            String confirmationStatus=goodsReceivedNote.getConfirmationStatus().equals("ALL") ? "%%" : "%"+goodsReceivedNote.getConfirmationStatus() +"%";
            List<GoodsReceivedNote> list = (List<GoodsReceivedNote>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_good_received_note_list(:prmFlag,:prmCode,:prmPurchaseOrderCode,:prmVendorCode,:prmVendorName,"
                        + ":prmWarehouseCode,:prmWarehouseName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("purchaseOrderCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("receivedBy", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("expeditionCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("confirmationStatus", Hibernate.STRING)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+goodsReceivedNote.getCode()+"%")
                .setParameter("prmPurchaseOrderCode","%"+goodsReceivedNote.getPurchaseOrderCode() +"%")
                .setParameter("prmVendorCode","%"+goodsReceivedNote.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+goodsReceivedNote.getVendorName()+"%")
                .setParameter("prmWarehouseCode", "%"+goodsReceivedNote.getWarehouseCode()+"%")
                .setParameter("prmWarehouseName", "%"+goodsReceivedNote.getWarehouseName()+"%")
                .setParameter("prmRefNo", "%"+goodsReceivedNote.getRefNo()+"%")
                .setParameter("prmRemark", "%"+goodsReceivedNote.getRemark()+"%")
                .setParameter("prmFirstDate", goodsReceivedNote.getTransactionFirstDate())
                .setParameter("prmLastDate", goodsReceivedNote.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNote.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GoodsReceivedNote> findDataConfirmation(GoodsReceivedNote goodsReceivedNote, int from, int to) {
        try {
            String confirmationStatus=goodsReceivedNote.getConfirmationStatus().equals("ALL") ? "%%" : "%"+goodsReceivedNote.getConfirmationStatus() +"%";
            List<GoodsReceivedNote> list = (List<GoodsReceivedNote>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_good_received_note_confirmation_list(:prmFlag,:prmCode,:prmPurchaseOrderCode,:prmVendorCode,:prmVendorName,"
                        + ":prmWarehouseCode,:prmWarehouseName,:prmRefNo,:prmRemark,'"+goodsReceivedNote.getConfirmationStatus()+"',:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("purchaseOrderCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("receivedBy", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("expeditionCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("confirmationStatus", Hibernate.STRING)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+goodsReceivedNote.getCode()+"%")
                .setParameter("prmPurchaseOrderCode","%"+goodsReceivedNote.getPurchaseOrderCode() +"%")
                .setParameter("prmVendorCode","%"+goodsReceivedNote.getVendorCode() +"%")
                .setParameter("prmVendorName","%"+goodsReceivedNote.getVendorName()+"%")
                .setParameter("prmWarehouseCode", "%"+goodsReceivedNote.getWarehouseCode()+"%")
                .setParameter("prmWarehouseName", "%"+goodsReceivedNote.getWarehouseName()+"%")
                .setParameter("prmRefNo", "%"+goodsReceivedNote.getRefNo()+"%")
                .setParameter("prmRemark", "%"+goodsReceivedNote.getRemark()+"%")
                .setParameter("prmFirstDate", goodsReceivedNote.getTransactionFirstDate())
                .setParameter("prmLastDate", goodsReceivedNote.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNote.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GoodsReceivedNoteItemDetail> findDataGRNItemDetail(String headerCode) {
        try {
            List<GoodsReceivedNoteItemDetail> list = (List<GoodsReceivedNoteItemDetail>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_good_received_note_detail_item_detail_list(:prmHeaderCode)")
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("poQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("receivedQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("balanceQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("nettPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
//                .addScalar("purchaseRequestCode", Hibernate.STRING)
                .addScalar("purchaseOrderDetailCode", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("heatNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNoteItemDetail.class))
                .list(); 
                  
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GoodsReceivedNoteItemSerialNoDetail> findDataItemSerialNoDetail(String headerCode) {
        try {
            List<GoodsReceivedNoteItemSerialNoDetail> list = (List<GoodsReceivedNoteItemSerialNoDetail>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_good_receive_note_serial_no_detail_list(:prmHeaderCode)")
                
                .addScalar("ItemMaterialCode", Hibernate.STRING)
                .addScalar("ItemMaterialName", Hibernate.STRING)
                .addScalar("capacity", Hibernate.BIG_DECIMAL)
                .addScalar("poQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("purchaseOrderDetailCode", Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("heatNo", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)    
                .addScalar("remark", Hibernate.STRING)
                .addScalar("serialNo", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNoteItemSerialNoDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GoodsReceivedNote> findDataByVendorInvoice(String code) {
        try {
            
            List<GoodsReceivedNote> list = (List<GoodsReceivedNote>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_good_receive_note_by_vendor_invoice_list(:prmCode)")
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("purchaseOrderCode", Hibernate.STRING)
                .addScalar("receivedBy", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmCode", code)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNote.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GoodsReceivedNoteItemDetail> findDataItemDetailByVendorInvoice(String headerCode) {
        try {
            List<GoodsReceivedNoteItemDetail> list = (List<GoodsReceivedNoteItemDetail>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_good_receive_note_detail_by_vendor_invoice(:prmHeaderCode)")
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("inventoryType", Hibernate.STRING)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("nettPrice", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNoteItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GoodsReceivedNote> findDataByVendorInvoiceUpdate(String purchaseOrderNo,String vendorInvoiceNo) {
        try {
            
            List<GoodsReceivedNote> list = (List<GoodsReceivedNote>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_good_receive_note_by_vendor_invoice_list_update(:prmPurchaseOrderCode,:prmVendorInvoiceCode)")
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("purchaseOrderCode", Hibernate.STRING)
                .addScalar("receivedBy", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmPurchaseOrderCode", purchaseOrderNo)
                .setParameter("prmVendorInvoiceCode", vendorInvoiceNo)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNote.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public GoodsReceivedNote get(String code) {
        try {
               return (GoodsReceivedNote) hbmSession.hSession.get(GoodsReceivedNote.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GoodsReceivedNote> checkItemGrn(String poCode, String podCode, String itemMaterialCode){
        try{
            List<GoodsReceivedNote> list = (List<GoodsReceivedNote>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "ivt_goods_received_note.Code, " +
                "ivt_goods_received_note.PurchaseOrderCode, " +
                "ivt_goods_received_note_item_detail.ItemMaterialCode, " +
                "pur_purchase_order_item_material_detail.Code AS purchaseOrderDetailCode " +
                "FROM  ivt_goods_received_note " +
                "INNER JOIN pur_purchase_order ON pur_purchase_order.code = ivt_goods_received_note.PurchaseOrderCode " +
                "INNER JOIN pur_purchase_order_item_material_detail ON pur_purchase_order_item_material_detail.HeaderCode = pur_purchase_order.code " +
                "INNER JOIN ivt_goods_received_note_item_detail ON ivt_goods_received_note_item_detail.HeaderCode = ivt_goods_received_note.Code " +
                "where ivt_goods_received_note.PurchaseOrderCode = '"+poCode+"' " +
                "and pur_purchase_order_item_material_detail.Code = '"+podCode+"' " +
                "and ivt_goods_received_note_item_detail.ItemMaterialCode = '"+itemMaterialCode+"' " +
                "GROUP BY ivt_goods_received_note.PurchaseOrderCode"
            )
                    .addScalar("code",Hibernate.STRING)
                    .addScalar("purchaseOrderCode",Hibernate.STRING)
                    .addScalar("purchaseOrderDetailCode",Hibernate.STRING)
                    .addScalar("itemMaterialCode",Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNote.class))
                    .list(); 

            return list;
        }catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countGrnUdt(GoodsReceivedNote goodsReceivedNoteUpadtePo){
        try{
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            String dateFirst = DATE_FORMAT.format(goodsReceivedNoteUpadtePo.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(goodsReceivedNoteUpadtePo.getTransactionLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(ivt_goods_received_note.Code) " +
                    "FROM ivt_goods_received_note " +
                    "INNER JOIN mst_vendor ON ivt_goods_received_note.VendorCode=mst_vendor.Code " +
                    "INNER JOIN mst_warehouse ON ivt_goods_received_note.WarehouseCode=mst_warehouse.Code " +
                    "INNER JOIN pur_purchase_order ON pur_purchase_order.Code = ivt_goods_received_note.PurchaseOrderCode " +
                    "INNER JOIN ivt_goods_received_note_item_detail ON ivt_goods_received_note_item_detail.HeaderCode = ivt_goods_received_note.Code " +
                    "WHERE ivt_goods_received_note.Code LIKE '%"+goodsReceivedNoteUpadtePo.getCode()+"%' " +
                    "AND ivt_goods_received_note.PurchaseOrderCode LIKE '%"+goodsReceivedNoteUpadtePo.getPurchaseOrderCode()+"%' " +
                    "AND ivt_goods_received_note.VendorCode LIKE '%"+goodsReceivedNoteUpadtePo.getVendorCode()+"%' " +
                    "AND mst_vendor.Name LIKE '%"+goodsReceivedNoteUpadtePo.getVendorName()+"%' " +
                    "AND ivt_goods_received_note.WarehouseCode LIKE '%"+goodsReceivedNoteUpadtePo.getWarehouseCode()+"%' " +
                    "AND mst_warehouse.Name LIKE '%"+goodsReceivedNoteUpadtePo.getWarehouseName()+"%' " +
                    "AND ivt_goods_received_note.RefNo LIKE '%"+goodsReceivedNoteUpadtePo.getRefNo()+"%' " +
                    "AND ivt_goods_received_note.Remark LIKE '%"+goodsReceivedNoteUpadtePo.getRemark()+"%'   " +
                    "AND ivt_goods_received_note_item_detail.PurchaseOrderDetailCode = '' " +
                    "AND DATE(ivt_goods_received_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
            ).uniqueResult();
            return temp.intValue();
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<GoodsReceivedNote> findDataGrnUdt (GoodsReceivedNote goodsReceivedNoteUpadtePo, int from, int to) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            String dateFirst = DATE_FORMAT.format(goodsReceivedNoteUpadtePo.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(goodsReceivedNoteUpadtePo.getTransactionLastDate());
            List<GoodsReceivedNote> list = (List<GoodsReceivedNote>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "ivt_goods_received_note.Code, " +
                    "ivt_goods_received_note.BranchCode, " +
                    "ivt_goods_received_note.TransactionDate, " +
                    "ivt_goods_received_note.PurchaseOrderCode, " +
                    "ivt_goods_received_note.CurrencyCode, " +
                    "ivt_goods_received_note.ExchangeRate, " +
                    "ivt_goods_received_note.VendorCode, " +
                    "mst_vendor.Name AS VendorName, " +
                    "ivt_goods_received_note.ReceivedBy, " +
                    "ivt_goods_received_note.WarehouseCode, " +
                    "mst_warehouse.Name AS WarehouseName, " +
                    "ivt_goods_received_note.ExpeditionCode, " +
                    "ivt_goods_received_note.TotalTransactionAmount, " +
                    "ivt_goods_received_note.DiscountPercent, " +
                    "ivt_goods_received_note.DiscountAmount, " +
                    "(ivt_goods_received_note.TotalTransactionAmount - ivt_goods_received_note.DiscountAmount) AS TaxBaseAmount, " +
                    "ivt_goods_received_note.VATPercent, " +
                    "ivt_goods_received_note.VATAmount, " +
                    "ivt_goods_received_note.GrandTotalAmount, " +
                    "ivt_goods_received_note.ExchangeRate, " +
                    "ivt_goods_received_note.RefNo, " +
                    "ivt_goods_received_note.Remark, " +
                    "ivt_goods_received_note.ConfirmationStatus, " +
                    "ivt_goods_received_note_item_detail.PurchaseOrderDetailCode " +
                    "FROM ivt_goods_received_note " +
                    "INNER JOIN ivt_goods_received_note_item_detail ON ivt_goods_received_note_item_detail.HeaderCode = ivt_goods_received_note.Code " +
                    "INNER JOIN mst_vendor ON mst_vendor.Code = ivt_goods_received_note.VendorCode " +
                    "INNER JOIN mst_warehouse ON mst_warehouse.Code = ivt_goods_received_note.WarehouseCode " +
                    "WHERE ivt_goods_received_note.Code LIKE '%"+goodsReceivedNoteUpadtePo.getCode()+"%' " +
                    "AND ivt_goods_received_note.PurchaseOrderCode LIKE '%"+goodsReceivedNoteUpadtePo.getPurchaseOrderCode()+"%' " +
                    "AND ivt_goods_received_note.VendorCode LIKE '%"+goodsReceivedNoteUpadtePo.getVendorCode()+"%' " +
                    "AND mst_vendor.Name LIKE '%"+goodsReceivedNoteUpadtePo.getVendorName()+"%' " +
                    "AND ivt_goods_received_note.WarehouseCode LIKE '%"+goodsReceivedNoteUpadtePo.getWarehouseCode()+"%' " +
                    "AND mst_warehouse.Name LIKE '%"+goodsReceivedNoteUpadtePo.getWarehouseName()+"%' " +
                    "AND ivt_goods_received_note.RefNo LIKE '%"+goodsReceivedNoteUpadtePo.getRefNo()+"%' " +
                    "AND ivt_goods_received_note.Remark LIKE '%"+goodsReceivedNoteUpadtePo.getRemark()+"%'   " +
                    "AND ivt_goods_received_note_item_detail.PurchaseOrderDetailCode = '' " +
                    "AND DATE(ivt_goods_received_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                    + "LIMIT "+from+","+to+" ")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("purchaseOrderCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("receivedBy", Hibernate.STRING)
                .addScalar("warehouseCode", Hibernate.STRING)
                .addScalar("warehouseName", Hibernate.STRING)
                .addScalar("expeditionCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("confirmationStatus", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(GoodsReceivedNote.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    private String createCode(GoodsReceivedNote goodsReceivedNote){
        try{
            String prefix=goodsReceivedNote.getBranch().getCode();
            String GRN= "GRN" ;  
            String L= "L" ;  
            String acronim = prefix+ "/"+GRN+"/"+AutoNumber.formatingDate(goodsReceivedNote.getTransactionDate(), true, true, false);
            
            DetachedCriteria dc = DetachedCriteria.forClass(GoodsReceivedNote.class)
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
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_5);
        }
        catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(GoodsReceivedNote goodsReceivedNote, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteItemDetail,String MODULECODE) throws Exception {
        try {
            
            String headerCode=createCode(goodsReceivedNote);
            
            hbmSession.hSession.beginTransaction();
            
            goodsReceivedNote.setCode(headerCode);
            goodsReceivedNote.setConfirmationStatus(EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.PENDING));
            goodsReceivedNote.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            goodsReceivedNote.setCreatedDate(new Date());
            if (goodsReceivedNote.getExpedition().getCode().equals("") ){
            goodsReceivedNote.setExpedition(null);
            }
            hbmSession.hSession.save(goodsReceivedNote);
            
            int i=1;
            for(GoodsReceivedNoteItemDetail goodsReceivedNoteItemDetail:listGoodsReceivedNoteItemDetail){
                String detailCode = goodsReceivedNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                goodsReceivedNoteItemDetail.setCode(detailCode);
                goodsReceivedNoteItemDetail.setHeaderCode(headerCode);
                goodsReceivedNoteItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                goodsReceivedNoteItemDetail.setCreatedDate(new Date());
             
                hbmSession.hSession.save(goodsReceivedNoteItemDetail);
                i++;
                
            }
           
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    goodsReceivedNote.getCode(), ""));
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
    
    public void update(GoodsReceivedNote goodsReceivedNote, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteLocalNonSerialNoItemDetail,String MODULECODE) throws Exception {
        try {
                        
            hbmSession.hSession.beginTransaction();
            
            goodsReceivedNote.setConfirmationStatus(EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.PENDING));
            if (goodsReceivedNote.getExpedition().getCode().equals("") ){
            goodsReceivedNote.setExpedition(null);
            }
            hbmSession.hSession.update(goodsReceivedNote);
            
            
            //delete detail
            hbmSession.hSession.createQuery("DELETE FROM " + GoodsReceivedNoteItemDetailField.BEAN_NAME + 
                                 " WHERE " + GoodsReceivedNoteItemDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", goodsReceivedNote.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            int i=1;
            for(GoodsReceivedNoteItemDetail goodsReceivedNoteItemDetail:listGoodsReceivedNoteLocalNonSerialNoItemDetail){
                String detailCode = goodsReceivedNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                goodsReceivedNoteItemDetail.setCode(detailCode);
                goodsReceivedNoteItemDetail.setHeaderCode(goodsReceivedNote.getCode());
                goodsReceivedNoteItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                goodsReceivedNoteItemDetail.setCreatedDate(new Date());
                goodsReceivedNoteItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                goodsReceivedNoteItemDetail.setUpdatedDate(new Date());
                        
                hbmSession.hSession.save(goodsReceivedNoteItemDetail);
                hbmSession.hSession.flush();
                
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.CONFIRMATION), 
                                                                    goodsReceivedNote.getCode(), ""));
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
    
    public void updateGrnPo(GoodsReceivedNote goodsReceivedNote, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteLocalNonSerialNoItemDetail,String MODULECODE) throws Exception {
        try {
                        
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery("DELETE FROM " + GoodsReceivedNoteItemDetailField.BEAN_NAME + 
                                 " WHERE " + GoodsReceivedNoteItemDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", goodsReceivedNote.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            int i=1;
            for(GoodsReceivedNoteItemDetail goodsReceivedNoteItemDetail:listGoodsReceivedNoteLocalNonSerialNoItemDetail){
                String detailCode = goodsReceivedNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                goodsReceivedNoteItemDetail.setCode(detailCode);
                goodsReceivedNoteItemDetail.setHeaderCode(goodsReceivedNote.getCode());
                goodsReceivedNoteItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                goodsReceivedNoteItemDetail.setCreatedDate(new Date());
                goodsReceivedNoteItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                goodsReceivedNoteItemDetail.setUpdatedDate(new Date());
                        
                hbmSession.hSession.save(goodsReceivedNoteItemDetail);
                hbmSession.hSession.flush();
                
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.CONFIRMATION), 
                                                                    goodsReceivedNote.getCode(), ""));
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
    
    public void confirmation(GoodsReceivedNote goodsReceivedNote, List<GoodsReceivedNoteItemDetail> listGoodsReceivedNoteItemDetail, String MODULECODE) throws Exception {
        try {
                        
            hbmSession.hSession.beginTransaction();
            
            goodsReceivedNote.setConfirmationBy(BaseSession.loadProgramSession().getUserName());
            goodsReceivedNote.setConfirmationDate(new Date());
            if (goodsReceivedNote.getExpedition().getCode().equals("") ){
            goodsReceivedNote.setExpedition(null);
            }
            hbmSession.hSession.update(goodsReceivedNote);
            
            
            //delete detail
            hbmSession.hSession.createQuery("DELETE FROM " + GoodsReceivedNoteItemDetailField.BEAN_NAME + 
                                 " WHERE " + GoodsReceivedNoteItemDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", goodsReceivedNote.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            int i=1;
            for(GoodsReceivedNoteItemDetail goodsReceivedNoteItemDetail:listGoodsReceivedNoteItemDetail){
                String detailCode = goodsReceivedNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                goodsReceivedNoteItemDetail.setCode(detailCode);
                goodsReceivedNoteItemDetail.setHeaderCode(goodsReceivedNote.getCode());
                goodsReceivedNoteItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                goodsReceivedNoteItemDetail.setCreatedDate(new Date());
                goodsReceivedNoteItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                goodsReceivedNoteItemDetail.setUpdatedDate(new Date());
                        
                hbmSession.hSession.save(goodsReceivedNoteItemDetail);
                
                if(goodsReceivedNote.getConfirmationStatus().equals("CONFIRMED")){
                    if(goodsReceivedNoteItemDetail.getItemMaterial().getInventoryType().equals("INVENTORY")){
                        InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
                        IvtActualStock newRec = new IvtActualStock(); 
                        int actualStock_SortNo =0;
                        newRec = InventoryCommon.newInstance(
                                goodsReceivedNote.getBranch().getCode(),
                                goodsReceivedNote.getWarehouse().getCode(),
                                goodsReceivedNoteItemDetail.getItemMaterial().getCode(),
                                goodsReceivedNoteItemDetail.getQuantity(),
                                goodsReceivedNoteItemDetail.getRack().getCode(),
                                goodsReceivedNoteItemDetail.getHeatNo()
                        );

                        inventoryInOutDAO.ActualStockIncrease_AVG(newRec,false,true,goodsReceivedNote.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.GRN,actualStock_SortNo);
                    }
                }
                
                i++;
            }
           
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.CONFIRMATION), 
                                                                    goodsReceivedNote.getCode(), ""));
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
    
    public Boolean isConfirmed(String code) throws Exception{
        try {
            String accStatus = (String)hbmSession.hSession.createSQLQuery(
                "SELECT  "
            + "CASE  "
            + "WHEN ivt_goods_received_note.ConfirmationStatus='CONFIRMED' THEN 'CONFIRMED' "
            + "WHEN ivt_goods_received_note.ConfirmationStatus='PENDING' THEN 'PENDING' "
            + "ELSE 'ERROR' END AS ConfirmationStatus  "
            + "FROM ivt_goods_received_note  "
            + "WHERE ivt_goods_received_note.Code='"+code+"'"
            ).uniqueResult();
            
            if(accStatus.equals("CONFIRMED")){
                return Boolean.TRUE;
            }
            
            return Boolean.FALSE;
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            //delete detail
            hbmSession.hSession.createQuery("DELETE FROM " + GoodsReceivedNoteItemDetailField.BEAN_NAME + 
                                 " WHERE " + GoodsReceivedNoteItemDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            //delete header
            hbmSession.hSession.createQuery("DELETE FROM " + GoodsReceivedNoteField.BEAN_NAME + 
                                 " WHERE " + GoodsReceivedNoteField.CODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            hbmSession.hSession.flush();
                    
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
}
