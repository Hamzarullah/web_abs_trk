/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.VendorInvoice;
import com.inkombizz.finance.model.VendorInvoiceField;
import com.inkombizz.finance.model.VendorInvoiceForexGainLoss;
import com.inkombizz.finance.model.VendorInvoiceForexGainLossField;
import com.inkombizz.finance.model.VendorInvoiceGoodsReceivedNote;
import com.inkombizz.finance.model.VendorInvoiceGoodsReceivedNoteField;
import com.inkombizz.finance.model.VendorInvoiceGoodsReceivedNoteTemp;
import com.inkombizz.finance.model.VendorInvoiceItemDetail;
import com.inkombizz.finance.model.VendorInvoiceItemDetailField;
import com.inkombizz.finance.model.VendorInvoiceItemDetailTemp;
import com.inkombizz.finance.model.VendorInvoiceTemp;
import com.inkombizz.finance.model.VendorInvoiceVendorDownPayment;
import com.inkombizz.finance.model.VendorInvoiceVendorDownPaymentField;
import com.inkombizz.finance.model.VendorInvoiceVendorDownPaymentTemp;
import com.inkombizz.master.model.Currency;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigDecimal;
import java.math.BigInteger;
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
 * @author jason
 */
public class VendorInvoiceDAO {
    
    private HBMSession hbmSession;
    
    public VendorInvoiceDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(Date from,Date upTo, Date fromDueDate, Date upDueDate, String code, String purchaseOrderCode , String paymentTermCode, String branchCode, String branchName, String vendorCode, String vendorName, String refno ){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_vendor_invoice_list_count(:prmFromDate,:prmUpToDate,:prmFromDueDate,:prmUpDueDate,"
                + ":prmCode,:prmPurchaseOrderCode,:prmPaymentTermCode, "
                + ":prmBranchCode,:prmBranchName,"
                + ":prmVendorCode,:prmVendorName,:prmRefno)")
                .setParameter("prmFromDate", from)
                .setParameter("prmUpToDate", upTo)
                .setParameter("prmFromDueDate", fromDueDate)
                .setParameter("prmUpDueDate", upDueDate)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmPurchaseOrderCode", "%"+purchaseOrderCode+"%")
                .setParameter("prmPaymentTermCode", "%"+paymentTermCode+"%")
                .setParameter("prmBranchCode", "%"+branchCode+"%")
                .setParameter("prmBranchName", "%"+branchName+"%")
                .setParameter("prmVendorCode", "%"+vendorCode+"%")
                .setParameter("prmVendorName", "%"+vendorName+"%")
                .setParameter("prmRefno", "%"+refno+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countDataVatIn(String documentNo, String vendorCode,String vendorName,Date from,Date upTo){
        try{
 
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "CALL usp_vat_in_list_count(:prmDocumentCode,:prmVendorCode,:prmVendorName,:prmFirstDate,:prmLastDate)")
                .setParameter("prmDocumentCode", "%"+documentNo+"%")
                .setParameter("prmVendorCode", "%"+vendorCode+"%")
                .setParameter("prmVendorName", "%"+vendorName+"%")
                .setParameter("prmFirstDate", from)
                .setParameter("prmLastDate", upTo)
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countSearchData(Date from, Date upTo, String code){
        try{
 
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_vendor_invoice_search_list_count(:prmFirstDate, :prmLastDate, :prmCode)")
                    .setParameter("prmFirstDate", from)
                    .setParameter("prmLastDate", upTo)
                    .setParameter("prmCode", "%"+code+"%")
                    .uniqueResult();
            
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
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
    
    public VendorInvoice get(String code) {
        try {
               return (VendorInvoice) hbmSession.hSession.get(VendorInvoice.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorInvoiceTemp> findData(Date firstDate,Date lastDate, Date firstDueDate, Date lastDueDate, String code, String purchaseOrderCode , String paymentTermCode,
           String branchCode, String branchName, String vendorCode, String vendorName, String refno, int from, int row) {
        try {   
            List<VendorInvoiceTemp> list = (List<VendorInvoiceTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_vendor_invoice_list(:prmFromDate,:prmUpToDate,:prmFromDueDate,:pmrUpDueDate,"
                + ":prmCode,:prmPurchaseOrderCode,:prmPaymentTermCode,:prmBranchCode,:prmBranchName,"
                + ":prmVendorCode,:prmVendorName,:prmRefno,:prmLimitFrom,:prmLimitUpTo)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("dueDate", Hibernate.TIMESTAMP)
                .addScalar("purchaseOrderCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("vendorInvoiceNo", Hibernate.STRING)
                .addScalar("vendorInvoiceDate", Hibernate.TIMESTAMP)
                .addScalar("vendorTaxInvoiceNo", Hibernate.STRING)
                .addScalar("vendorTaxInvoiceDate", Hibernate.TIMESTAMP)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountChartOfAccountCode", Hibernate.STRING)
                .addScalar("discountChartOfAccountName", Hibernate.STRING)
                .addScalar("discountDescription", Hibernate.STRING)
                .addScalar("downPaymentAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("otherFeeChartOfAccountCode", Hibernate.STRING)
                .addScalar("otherFeeChartOfAccountName", Hibernate.STRING)
                .addScalar("otherFeeDescription", Hibernate.STRING)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP) 
                .setParameter("prmFromDate", firstDate)
                .setParameter("prmUpToDate", lastDate)
                .setParameter("prmFromDueDate", firstDueDate)
                .setParameter("pmrUpDueDate", lastDueDate)
                .setParameter("prmCode", "%"+code+"%") 
                .setParameter("prmPurchaseOrderCode", "%"+purchaseOrderCode+"%")
                .setParameter("prmPaymentTermCode", "%"+paymentTermCode+"%")
                .setParameter("prmBranchCode", "%"+branchCode+"%")
                .setParameter("prmBranchName", "%"+branchName+"%")
                .setParameter("prmVendorCode", "%"+vendorCode+"%")
                .setParameter("prmVendorName", "%"+vendorName+"%")
                .setParameter("prmRefno", "%"+refno+"%")
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", row)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<VendorInvoiceTemp> findDataVatIn(String documentNo, String vendorCode,String vendorName,Date firstDate,Date lastDate,int from, int row) {
        try {   

            List<VendorInvoiceTemp> list = (List<VendorInvoiceTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_vat_in_list(:prmDocumentCode,:prmVendorCode,:prmVendorName,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")
                .addScalar("documentCode", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("taxInvoiceNo", Hibernate.STRING)
                .addScalar("taxInvoiceDate", Hibernate.TIMESTAMP)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("downPaymentAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmDocumentCode", "%"+documentNo+"%")
                .setParameter("prmVendorCode", "%"+vendorCode+"%")
                .setParameter("prmVendorName", "%"+vendorName+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", row)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<VendorInvoiceTemp> findSearchData(Date firstDate, Date lastDate, String code,
            int from, int row) {
        try {   

            List<VendorInvoiceTemp> list = (List<VendorInvoiceTemp>)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_vendor_invoice_search_list(:prmFirstDate, :prmLastDate,"
                    + ":prmCode,:prmLimitFrom, :prmLimitUpTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("purchaseOrderCode", Hibernate.STRING)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("vendorCode", Hibernate.STRING)
                    .addScalar("vendorName", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("paymentTermCode", Hibernate.STRING)
                    .addScalar("paymentTermName", Hibernate.STRING)
                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                    .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("downPaymentAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                    .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", row)
                    .setResultTransformer(Transformers.aliasToBean(VendorInvoiceTemp.class))
                    .list(); 
            
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorInvoiceGoodsReceivedNoteTemp> findGRNData(String code) {
        try {   

            List<VendorInvoiceGoodsReceivedNoteTemp> list = (List<VendorInvoiceGoodsReceivedNoteTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_vendor_invoice_goods_received_note_list(:prmCode)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", code)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceGoodsReceivedNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorInvoiceVendorDownPaymentTemp> findDPData(String code) {
        try {   

            List<VendorInvoiceVendorDownPaymentTemp> list = (List<VendorInvoiceVendorDownPaymentTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_vendor_invoice_vendor_down_payment_list(:prmCode)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("dpAmount", Hibernate.BIG_DECIMAL)
                .addScalar("used", Hibernate.BIG_DECIMAL)
                .addScalar("balance", Hibernate.BIG_DECIMAL)
                .addScalar("applied", Hibernate.BIG_DECIMAL)
                .setParameter("prmCode", code)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceVendorDownPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorInvoiceItemDetailTemp> findItemData(String code) {
        try {   

            List<VendorInvoiceItemDetailTemp> list = (List<VendorInvoiceItemDetailTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_vendor_invoice_item_detail_list('',:prmHeaderCode,'','')")
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName", Hibernate.STRING)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("nettPrice", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
//                .addScalar("prtQuantity", Hibernate.BIG_DECIMAL)
//                .addScalar("balancedQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode", code)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceItemDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorInvoiceItemDetailTemp> findItemDetailSearchData(VendorInvoiceItemDetailTemp vendorInvoiceItemDetailTemp) {
        try {   

            List<VendorInvoiceItemDetailTemp> list = (List<VendorInvoiceItemDetailTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_vendor_invoice_item_detail_list('SEARCH',:prmCode,:prmItemCode,:prmItemName)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("cogsIdr", Hibernate.STRING)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("discount1Percent", Hibernate.BIG_DECIMAL)
                .addScalar("discount1Amount", Hibernate.BIG_DECIMAL)
                .addScalar("discount2Percent", Hibernate.BIG_DECIMAL)
                .addScalar("discount2Amount", Hibernate.BIG_DECIMAL)
                .addScalar("discount3Percent", Hibernate.BIG_DECIMAL)
                .addScalar("discount3Amount", Hibernate.BIG_DECIMAL)
                .addScalar("nettPrice", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .addScalar("prtQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("balancedQuantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .setParameter("prmCode", vendorInvoiceItemDetailTemp.getHeaderCode())
                .setParameter("prmItemCode", vendorInvoiceItemDetailTemp.getItemMaterialCode())
                .setParameter("prmItemName", vendorInvoiceItemDetailTemp.getItemMaterialName())
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceItemDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorInvoiceItemDetailTemp> findItemDataPR(String vendorInvoiceVendorCode, String vendorInvoiceItemCode) {
        try {   

            List<VendorInvoiceItemDetailTemp> list = (List<VendorInvoiceItemDetailTemp>)hbmSession.hSession.createSQLQuery(
                " SELECT "
                + " ivt_goods_received_note_item_detail.Code, "
                + " fin_vendor_invoice.code AS vinNo, "
                + " ivt_goods_received_note_item_detail.ItemCode, " 
                + " mst_item.Name AS ItemName, "
                + " pur_purchase_order_detail.ItemAlias AS itemAlias, "
                + " ivt_goods_received_note_item_detail.Price, "
                + " ivt_goods_received_note_item_detail.Quantity, "
                + " pur_purchase_order_detail.DiscountPercent AS discountPercent, "
                + " pur_purchase_order_detail.DiscountAmount AS discountAmount, "
                + " (ivt_goods_received_note_item_detail.Price-pur_purchase_order_detail.DiscountAmount) AS nettPrice, "
                + " (ivt_goods_received_note_item_detail.Price*ivt_goods_received_note_item_detail.Quantity)-pur_purchase_order_detail.DiscountAmount AS total, "
                + " mst_item.DefaultUnitOfMeasureCode AS unitOfMeasureCode, "
                + " pur_purchase_request.ItemBrandCode, "
                + " mst_item_brand.Name AS itemBrandName, "
                + " ivt_goods_received_note_item_detail.Remark "
                + " FROM fin_vendor_invoice_jn_goods_received_note "
                + " INNER JOIN fin_vendor_invoice ON fin_vendor_invoice_jn_goods_received_note.HeaderCode = fin_vendor_invoice.code "
		+ " INNER JOIN mst_vendor ON fin_vendor_invoice.VendorCode = mst_vendor.code "
                + " INNER JOIN ivt_goods_received_note_item_detail ON ivt_goods_received_note_item_detail.HeaderCode = fin_vendor_invoice_jn_goods_received_note.GoodsReceivedNoteCode "
                + " INNER JOIN mst_item ON ivt_goods_received_note_item_detail.ItemCode=mst_item.Code "
                + " INNER JOIN mst_unit_of_measure ON mst_item.DefaultUnitOfMeasureCode=mst_unit_of_measure.Code "
                + " INNER JOIN ivt_goods_received_note ON ivt_goods_received_note.Code = ivt_goods_received_note_item_detail.HeaderCode "
                + " INNER JOIN pur_purchase_order_detail ON pur_purchase_order_detail.HeaderCode = ivt_goods_received_note.PurchaseOrderCode "
                + " AND ivt_goods_received_note_item_detail.ItemCode = pur_purchase_order_detail.ItemCode "
                + " INNER JOIN pur_purchase_request ON pur_purchase_request.Code =  pur_purchase_order_detail.PurchaseRequestCode "
                + " INNER JOIN mst_item_brand ON mst_item_brand.Code=pur_purchase_request.ItemBrandCode "
                + " WHERE mst_item.Code = :prmItemCode "
                + " AND mst_vendor.Code = :prmVendorCode "
                + " ORDER BY ivt_goods_received_note_item_detail.ItemCode ASC")
                .addScalar("code", Hibernate.STRING)
                .addScalar("vinNo", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("nettPrice", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("itemBrandName", Hibernate.STRING)
                .setParameter("prmVendorCode", vendorInvoiceVendorCode)
                .setParameter("prmItemCode", vendorInvoiceItemCode)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceItemDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    private String createCode(VendorInvoice vendorInvoice){
        try{
            String tempKode = vendorInvoice.getBranch().getCode()+"VIN";
            String acronim = tempKode+"/"+AutoNumber.formatingDate(vendorInvoice.getTransactionDate(), true, true, false)+"/";

            DetachedCriteria dc = DetachedCriteria.forClass(VendorInvoice.class)
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
    
    public void save(VendorInvoice vendorInvoice,List<VendorInvoiceGoodsReceivedNote>  listVendorInvoiceGRN, 
            List<VendorInvoiceVendorDownPayment> listVendorInvoiceVendorDownPayment,
            List<VendorInvoiceItemDetail> listVendorInvoiceItemDetail,
//            List<VendorInvoicePostingItemDetail> listVendorInvoicePostingItemDetail,
            VendorInvoiceForexGainLoss vendorInvoiceForexGainLoss,String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            vendorInvoice.setCode(createCode(vendorInvoice));
            vendorInvoice.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorInvoice.setCreatedDate(new Date()); 
  
            vendorInvoice.setPaymentTerm(vendorInvoice.getPurchaseOrder().getPaymentTerm());
            vendorInvoice.setVendor(vendorInvoice.getPurchaseOrder().getVendor());
            
            hbmSession.hSession.save(vendorInvoice);
            hbmSession.hSession.flush();
            
            int iGRN = 1;
            for(VendorInvoiceGoodsReceivedNote grnDetail : listVendorInvoiceGRN){
                
                String detailCode = vendorInvoice.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(iGRN),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                
                grnDetail.setCode(detailCode);
                grnDetail.setHeaderCode(vendorInvoice.getCode());
                grnDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                grnDetail.setCreatedDate(new Date());
                hbmSession.hSession.save(grnDetail);
                hbmSession.hSession.flush();
//                hbmSession.hSession.createSQLQuery("UPDATE ivt_goods_received_note SET LastStatus = 'BILLED' WHERE ivt_goods_received_note.Code ='"+grnDetail.getGoodsReceivedNote().getCode()+"'")
//                .executeUpdate();
//                hbmSession.hSession.flush();
                iGRN++;
            }
            
            int iDP = 1;
            for(VendorInvoiceVendorDownPayment downPaymentDetail : listVendorInvoiceVendorDownPayment){
                
                String detailCode = vendorInvoice.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(iDP),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                
                downPaymentDetail.setCode(detailCode);
                downPaymentDetail.setHeaderCode(vendorInvoice.getCode());
                downPaymentDetail.setCreatedBy(BaseSession.loadProgramSession().getUserCode());
                downPaymentDetail.setCreatedDate(new Date());
                hbmSession.hSession.save(downPaymentDetail);
                hbmSession.hSession.flush();
                
                hbmSession.hSession.createSQLQuery("UPDATE fin_vendor_down_payment_used SET "
                        + "UsedAmount = UsedAmount + :prmAmount "
                        + "WHERE code = :prmCode")
                        .setParameter("prmAmount", downPaymentDetail.getAmount())
                        .setParameter("prmCode", downPaymentDetail.getVendorDownPayment().getCode())
                        .executeUpdate();
                hbmSession.hSession.flush();
                
                iDP++;
            }
            
            for(VendorInvoiceItemDetail itemDetail : listVendorInvoiceItemDetail){
                String detailCode = vendorInvoice.getCode()+ "-" + itemDetail.getGoodsReceivedNoteDetailCode();
                
                itemDetail.setCode(detailCode);
                itemDetail.setHeaderCode(vendorInvoice.getCode());
                itemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserCode());
                itemDetail.setCreatedDate(new Date());
                hbmSession.hSession.save(itemDetail);
                hbmSession.hSession.flush();
            }
            
            // create automatic vendor invoice posting apabila instalment status false
//            if (vendorInvoice.isInstallmentStatus() == false) {
//                
//                VendorInvoicePosting vendorInvoicePosting=new VendorInvoicePosting();
//                String vendorInvoicePostingCode = vendorInvoice.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(1),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
//                vendorInvoicePosting.setCode(vendorInvoicePostingCode);
//                vendorInvoicePosting.setBranch(vendorInvoice.getBranch());
//                vendorInvoicePosting.setTransactionDate(vendorInvoice.getTransactionDate());
//                vendorInvoicePosting.setVendorInvoice(vendorInvoice);
//                vendorInvoicePosting.setCurrency(vendorInvoice.getCurrency());
//                vendorInvoicePosting.setVendor(vendorInvoice.getVendor());
//                vendorInvoicePosting.setExchangeRate(vendorInvoice.getExchangeRate());
//                vendorInvoicePosting.setPaymentTerm(vendorInvoice.getPaymentTerm());
//                vendorInvoicePosting.setContraBonDate(vendorInvoice.getContraBonDate());
//                vendorInvoicePosting.setDueDate(vendorInvoice.getDueDate());
//                vendorInvoicePosting.setVendorInvoiceDate(vendorInvoice.getVendorInvoiceDate());
//                vendorInvoicePosting.setVendorInvoiceNo(vendorInvoice.getVendorInvoiceNo());
//                vendorInvoicePosting.setVendorTaxInvoiceDate(vendorInvoice.getVendorTaxInvoiceDate());
//                vendorInvoicePosting.setVendorTaxInvoiceNo(vendorInvoice.getVendorTaxInvoiceNo());
//                vendorInvoicePosting.setRefNo(vendorInvoice.getRefNo());
//                vendorInvoicePosting.setRemark(vendorInvoice.getRemark());
//                vendorInvoicePosting.setTotalTransactionAmount(vendorInvoice.getTotalTransactionAmount());
//                vendorInvoicePosting.setDiscountPercent(vendorInvoice.getDiscountPercent());
//                vendorInvoicePosting.setDiscountAmount(vendorInvoice.getDiscountAmount());
//                vendorInvoicePosting.setDownPaymentAmount(vendorInvoice.getDownPaymentAmount());
//                vendorInvoicePosting.setVatPercent(vendorInvoice.getVatPercent());
//                vendorInvoicePosting.setVatAmount(vendorInvoice.getVatAmount());
//                vendorInvoicePosting.setGrandTotalAmount(vendorInvoice.getGrandTotalAmount());
//                vendorInvoicePosting.setCreatedBy(BaseSession.loadProgramSession().getUserName());
//                vendorInvoicePosting.setCreatedDate(new Date());
//                vendorInvoicePosting.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
//                vendorInvoicePosting.setUpdatedDate(new Date());
//
//                hbmSession.hSession.save(vendorInvoicePosting);
//                hbmSession.hSession.flush();
//                
//                int iVendorInvoicePosting = 1;
//                for(VendorInvoicePostingItemDetail itemDetailPosting : listVendorInvoicePostingItemDetail){
//                    String detailCode = vendorInvoicePostingCode + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(iVendorInvoicePosting),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
//
//                    itemDetailPosting.setCode(detailCode);
//                    itemDetailPosting.setHeaderCode(vendorInvoicePostingCode);
//                    itemDetailPosting.setCreatedBy(BaseSession.loadProgramSession().getUserCode());
//                    itemDetailPosting.setCreatedDate(new Date());
//                    hbmSession.hSession.save(itemDetailPosting);
//                    iVendorInvoicePosting++;
//                }
//
//                hbmSession.hSession.flush();
//                
//            }else {
//                // do nothing
//            }
            
            if(!vendorInvoiceForexGainLoss.getAmount().toString().equals("0.00")){
                if(!saveVendorInvoiceForexGainLoss(vendorInvoice,vendorInvoiceForexGainLoss)){
                    hbmSession.hTransaction.rollback();
                }
            }
            
            hbmSession.hSession.flush();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    vendorInvoice.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(VendorInvoice vendorInvoice,List<VendorInvoiceGoodsReceivedNote>  listVendorInvoiceGRN, 
            List<VendorInvoiceVendorDownPayment> listVendorInvoiceVendorDownPayment,
            List<VendorInvoiceItemDetail> listVendorInvoiceItemDetail,VendorInvoiceForexGainLoss vendorInvoiceForexGainLoss, 
            String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            vendorInvoice.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorInvoice.setUpdatedDate(new Date()); 
            
            vendorInvoice.setPaymentTerm(vendorInvoice.getPurchaseOrder().getPaymentTerm());
            vendorInvoice.setVendor(vendorInvoice.getPurchaseOrder().getVendor());
            
            hbmSession.hSession.update(vendorInvoice);
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceForexGainLossField.BEAN_NAME +" WHERE Code = :prmCode")
                    .setParameter("prmCode", vendorInvoice.getCode())
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceGoodsReceivedNoteField.BEAN_NAME +" WHERE headerCode = :prmCode")
                    .setParameter("prmCode", vendorInvoice.getCode())
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceItemDetailField.BEAN_NAME +" WHERE headerCode = :prmCode")
                    .setParameter("prmCode", vendorInvoice.getCode())
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            List<VendorInvoiceVendorDownPayment> listVendorInvoiceVendorDownPaymentOld = (List<VendorInvoiceVendorDownPayment>) hbmSession.hSession.createSQLQuery(
                    "SELECT VendorDownPaymentCode,Amount FROM fin_vendor_invoice_jn_vendor_down_payment "
                    + " WHERE HeaderCode=:prmHeaderCode")
                    .addScalar("vendorDownPaymentCode", Hibernate.STRING)
                    .addScalar("amount", Hibernate.BIG_DECIMAL)
                    .setParameter("prmHeaderCode", vendorInvoice.getCode())
                    .setResultTransformer(Transformers.aliasToBean(VendorInvoiceVendorDownPayment.class))
                    .list();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceVendorDownPaymentField.BEAN_NAME +" WHERE headerCode = :prmCode")
                    .setParameter("prmCode", vendorInvoice.getCode())
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            int iGRN = 1;
            for(VendorInvoiceGoodsReceivedNote grnDetail : listVendorInvoiceGRN){
                
                String detailCode = vendorInvoice.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(iGRN),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                
                grnDetail.setCode(detailCode);
                grnDetail.setHeaderCode(vendorInvoice.getCode());
                grnDetail.setCreatedBy(BaseSession.loadProgramSession().getUserCode());
                grnDetail.setCreatedDate(new Date());
                hbmSession.hSession.save(grnDetail);
                hbmSession.hSession.flush();
                iGRN++;
            }
            
            for(VendorInvoiceVendorDownPayment vdpDetail : listVendorInvoiceVendorDownPaymentOld){
                
                BigDecimal newUsedAmount=new BigDecimal("0.00");
                
                 BigDecimal usedAmount = (BigDecimal) hbmSession.hSession.createSQLQuery(""
                    + "SELECT UsedAmount FROM fin_vendor_down_payment_used "
                    + " WHERE Code = :prmCode")
                    .setParameter("prmCode", vdpDetail.getVendorDownPaymentCode())
                    .uniqueResult();
                
                newUsedAmount=usedAmount.subtract(vdpDetail.getAmount());
                
                hbmSession.hSession.createSQLQuery("UPDATE fin_vendor_down_payment_used SET "
                        + "UsedAmount = :prmAmount "
                        + "WHERE code = :prmCode")
                        .setParameter("prmAmount", newUsedAmount)
                        .setParameter("prmCode", vdpDetail.getVendorDownPaymentCode())
                        .executeUpdate();
                hbmSession.hSession.flush();
            }
            
            
            int iDP = 1;
            for(VendorInvoiceVendorDownPayment downPaymentDetail : listVendorInvoiceVendorDownPayment){
                
                String detailCode = vendorInvoice.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(iDP),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                
                downPaymentDetail.setCode(detailCode);
                downPaymentDetail.setHeaderCode(vendorInvoice.getCode());
                downPaymentDetail.setCreatedBy(BaseSession.loadProgramSession().getUserCode());
                downPaymentDetail.setCreatedDate(new Date());
                hbmSession.hSession.save(downPaymentDetail);
                hbmSession.hSession.flush();
                
                hbmSession.hSession.createSQLQuery("UPDATE fin_vendor_down_payment_used SET "
                        + "UsedAmount = UsedAmount + :prmAmount "
                        + "WHERE code = :prmCode")
                        .setParameter("prmAmount", downPaymentDetail.getAmount())
                        .setParameter("prmCode", downPaymentDetail.getVendorDownPayment().getCode())
                        .executeUpdate();
                hbmSession.hSession.flush();
                                
                iDP++;
            }
            
            int iItem = 1;
            for(VendorInvoiceItemDetail itemDetail : listVendorInvoiceItemDetail){
                String detailCode = vendorInvoice.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(iItem),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                
                itemDetail.setCode(detailCode);
                itemDetail.setHeaderCode(vendorInvoice.getCode());
                itemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserCode());
                itemDetail.setCreatedDate(new Date());
                hbmSession.hSession.save(itemDetail);
                iItem++;
            }
            
            if(!vendorInvoiceForexGainLoss.getAmount().toString().equals("0.00")){
                if(!saveVendorInvoiceForexGainLoss(vendorInvoice,vendorInvoiceForexGainLoss)){
                    hbmSession.hTransaction.rollback();
                }
            }
            
            hbmSession.hSession.flush();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    vendorInvoice.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            List<VendorInvoiceVendorDownPaymentTemp> list = (List<VendorInvoiceVendorDownPaymentTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_vendor_invoice_vendor_down_payment_list(:prmCode)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("dpAmount", Hibernate.BIG_DECIMAL)
                .addScalar("used", Hibernate.BIG_DECIMAL)
                .addScalar("balance", Hibernate.BIG_DECIMAL)
                .addScalar("applied", Hibernate.BIG_DECIMAL)
                .setParameter("prmCode", code)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceVendorDownPaymentTemp.class))
                .list(); 
            
            hbmSession.hSession.createQuery("DELETE FROM VendorInvoiceForexGainLoss WHERE code = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceGoodsReceivedNoteField.BEAN_NAME +" WHERE headerCode = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceItemDetailField.BEAN_NAME +" WHERE headerCode = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceVendorDownPaymentField.BEAN_NAME +" WHERE headerCode = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+ VendorInvoiceField.BEAN_NAME +" WHERE code = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            for(VendorInvoiceVendorDownPaymentTemp dpDetail: list){
                hbmSession.hSession.createSQLQuery("UPDATE fin_vendor_down_payment_used SET "
                        + "UsedAmount = UsedAmount - :prmAmount "
                        + "WHERE code = :prmCode")
                        .setParameter("prmAmount", dpDetail.getApplied())
                        .setParameter("prmCode", dpDetail.getCode())
                        .executeUpdate();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private Boolean saveVendorInvoiceForexGainLoss(VendorInvoice vendorInvoice,VendorInvoiceForexGainLoss vendorInvoiceForexGainLoss) throws Exception {
        try{
             
            vendorInvoiceForexGainLoss.setCode(vendorInvoice.getCode());
            
            Currency currency=new Currency();
            currency.setCode(BaseSession.loadProgramSession().getSetup().getCurrencyCode());
            vendorInvoiceForexGainLoss.setCurrency(currency);
            
            vendorInvoiceForexGainLoss.setExchangeRate(vendorInvoice.getExchangeRate());
            
            vendorInvoiceForexGainLoss.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorInvoiceForexGainLoss.setCreatedDate(new Date()); 
            vendorInvoiceForexGainLoss.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorInvoiceForexGainLoss.setUpdatedDate(new Date());
            
            hbmSession.hSession.save(vendorInvoiceForexGainLoss);

     
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance("VENDOR_INVOICE_FOREX_GAIN_LOSS", 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    vendorInvoiceForexGainLoss.getCode(), ""));
             
            return Boolean.TRUE;
        }
        catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public int countValidateGRNByPOCash(String code){
        try{
 
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) FROM `fin_vendor_invoice_jn_goods_received_note` " +
                    "INNER JOIN `ivt_goods_received_note` ON ivt_goods_received_note.`Code` = fin_vendor_invoice_jn_goods_received_note.`GoodsReceivedNoteCode` " +
                    "INNER JOIN `pur_purchase_order` ON pur_purchase_order.`Code` = ivt_goods_received_note.`PurchaseOrderCode` " +
                    "WHERE pur_purchase_order.`TransactionStatus` = 'CASH' AND fin_vendor_invoice_jn_goods_received_note.`Headercode` = :prmCode")
                .setParameter("prmCode", code)
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countSearchDataForPosting(Date from, Date upTo, String code){
        try{
 
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "CALL usp_vendor_invoice_search_for_posting_list_count(:prmFromDate, :prmUpToDate, :prmCode)")
                .setParameter("prmFromDate", from)
                .setParameter("prmUpToDate", upTo)
                .setParameter("prmCode", code)
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<VendorInvoiceTemp> findSearchDataForPosting(Date firstDate, Date lastDate, int from, int row) {
        try {   

            List<VendorInvoiceTemp> list = (List<VendorInvoiceTemp>)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_vendor_invoice_search_for_posting_list(:prmFromDate, :prmUpToDate, :prmLimitFrom, :prmLimitUpTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("purchaseOrderCode", Hibernate.STRING)
                    .addScalar("vendorCode", Hibernate.STRING)
                    .addScalar("vendorName", Hibernate.STRING)
                    .addScalar("vendorContactPerson", Hibernate.STRING)
                    .addScalar("vendorAddress", Hibernate.STRING)
                    .addScalar("vendorPhone1", Hibernate.STRING)
                    .addScalar("vendorPhone2", Hibernate.STRING)
                    .addScalar("vendorNPWP", Hibernate.STRING)
                    .addScalar("goodsSupplyStatus", Hibernate.BOOLEAN)
                    .addScalar("serviceSupplyStatus", Hibernate.BOOLEAN)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("paymentTermCode", Hibernate.STRING)
                    .addScalar("paymentTermName", Hibernate.STRING)
                    .addScalar("pph23Percent", Hibernate.BIG_DECIMAL)
                    .addScalar("totalTransactionAmountHeader", Hibernate.BIG_DECIMAL)
                    .addScalar("discountPercentHeader", Hibernate.BIG_DECIMAL)
                    .addScalar("discountAmountHeader", Hibernate.BIG_DECIMAL)
                    .addScalar("downPaymentAmountHeader", Hibernate.BIG_DECIMAL)
                    .addScalar("vatPercentHeader", Hibernate.BIG_DECIMAL)
                    .addScalar("vatAmountHeader", Hibernate.BIG_DECIMAL)
                    .addScalar("grandTotalAmountHeader", Hibernate.BIG_DECIMAL)
                    .addScalar("postedTotalTransactionAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("postedDiscountPercent", Hibernate.BIG_DECIMAL)
                    .addScalar("postedDiscountAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("postedDownPaymentAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("postedVatPercent", Hibernate.BIG_DECIMAL)
                    .addScalar("postedVatAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("postedGrandTotalAmount", Hibernate.BIG_DECIMAL)
                    .setParameter("prmFromDate", firstDate)
                    .setParameter("prmUpToDate", lastDate)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", row)
                    .setResultTransformer(Transformers.aliasToBean(VendorInvoiceTemp.class))
                    .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
      
    public int vendorInvoiceUsedInPosting(String code){
        try{
            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(""
                    + "SELECT COUNT(fin_vendor_invoice.Code)  " +
                    "FROM fin_vendor_invoice " +
                    "INNER JOIN fin_vendor_invoice ON fin_vendor_invoice.VendorInvoiceCode = fin_vendor_invoice.Code " +
                    "WHERE fin_vendor_invoice.Code = :prmCode")
                    .setParameter("prmCode", code)
                    .uniqueResult();
            
            return temp.intValue();
        }catch(HibernateException e){
            return 0;
        }catch(Exception e){
            return 0;   
        }
    }

    public int countOutstandingData(String code,String vendorCode,String vendorName,String statusInvoice){
        try{
 
            String strQueryConcat="";
            if(!statusInvoice.equals("")){
                switch(statusInvoice){
                    case "Health":
                        strQueryConcat="AND DATE(NOW()) BETWEEN DATE(fin_vendor_invoice.Transactiondate) AND DATE(fin_vendor_invoice.DueDate) ";
                        break;
                    case "Warning":
                        strQueryConcat="AND DATE(NOW()) BETWEEN DATE(fin_vendor_invoice.DueDate) AND ADDDATE(DATE(fin_vendor_invoice.DueDate),INTERVAL (SELECT sys_setup.DueDays FROM sys_setup) DAY) ";
                        break;
                    case "Critical":
                        strQueryConcat="AND DATE(NOW()) > ADDDATE(DATE(fin_vendor_invoice.DueDate),INTERVAL (SELECT sys_setup.DueDays FROM sys_setup) DAY) ";
                        break;
                } 
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) " +
                "FROM fin_vendor_invoice " +
                "INNER JOIN mst_vendor ON fin_vendor_invoice.VendorCode=mst_vendor.Code " +
                "INNER JOIN mst_payment_term ON fin_vendor_invoice.PaymentTermCode=mst_payment_term.Code " +
                "WHERE (fin_vendor_invoice.GrandTotalAmount - fin_vendor_invoice.PaidAmount)<>0 " +
                "AND fin_vendor_invoice.Code LIKE :prmCode " +
                "AND fin_vendor_invoice.VendorCode LIKE :prmVendorCode " +
                "AND mst_vendor.Name LIKE :prmVendorName " +
                strQueryConcat)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmVendorCode", "%"+vendorCode+"%")
                .setParameter("prmVendorName", "%"+vendorName+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<VendorInvoiceTemp> findOutstandingData(String code,String vendorCode,String vendorName,String statusInvoice,int from, int row) {
        try {   
            
            String strQueryConcat="";
            if(!statusInvoice.equals("")){
                switch(statusInvoice){
                    case "Health":
                        strQueryConcat="AND DATE(NOW()) BETWEEN DATE(fin_vendor_invoice.Transactiondate) AND DATE(fin_vendor_invoice.DueDate) ";
                        break;
                    case "Warning":
                        strQueryConcat="AND DATE(NOW()) BETWEEN DATE(fin_vendor_invoice.DueDate) AND ADDDATE(DATE(fin_vendor_invoice.DueDate),INTERVAL (SELECT sys_setup.DueDays FROM sys_setup) DAY) ";
                        break;
                    case "Critical":
                        strQueryConcat="AND DATE(NOW()) > ADDDATE(DATE(fin_vendor_invoice.DueDate),INTERVAL (SELECT sys_setup.DueDays FROM sys_setup) DAY) ";
                        break;
                } 
            }
            
            List<VendorInvoiceTemp> list = (List<VendorInvoiceTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	CASE " +
                "	WHEN DATE(NOW()) BETWEEN DATE(fin_vendor_invoice.Transactiondate) AND DATE(fin_vendor_invoice.DueDate) THEN " +
                "		'Health' " +
                "	WHEN DATE(NOW()) BETWEEN DATE(fin_vendor_invoice.DueDate) AND ADDDATE(DATE(fin_vendor_invoice.DueDate),INTERVAL (SELECT sys_setup.DueDays FROM sys_setup) DAY)   THEN " +
                "		'Warning'  " +
                "	WHEN DATE(NOW()) > ADDDATE(DATE(fin_vendor_invoice.DueDate),INTERVAL (SELECT sys_setup.DueDays FROM sys_setup) DAY) THEN " +
                "		'Critical' " +
                "	END AS statusInvoice, " +
                "	fin_vendor_invoice.Code, " +
                "	fin_vendor_invoice.Transactiondate, " +
                "	fin_vendor_invoice.VendorCode, " +
                "	mst_vendor.Name AS VendorName, " +
                "	fin_vendor_invoice.Currencycode, " +
                "	fin_vendor_invoice.ExchangeRate, " +
                "	fin_vendor_invoice.PaymentTermCode, " +
                "	mst_payment_term.Name AS PaymentTermName, " +
                "	mst_payment_term.Days AS PaymentTermDays, " +
                "	fin_vendor_invoice.DueDate, " +
                "	(SELECT sys_setup.DueDays FROM sys_setup) AS dueDays, " +
                "	fin_vendor_invoice.GrandTotalAmount, " +
                "	fin_vendor_invoice.PaidAmount, " +
                "	(fin_vendor_invoice.GrandTotalAmount - fin_vendor_invoice.PaidAmount) AS BalanceAmount " +
                "FROM fin_vendor_invoice " +
                "INNER JOIN mst_vendor ON fin_vendor_invoice.VendorCode=mst_vendor.Code " +
                "INNER JOIN mst_payment_term ON fin_vendor_invoice.PaymentTermCode=mst_payment_term.Code " +
                "WHERE (fin_vendor_invoice.GrandTotalAmount - fin_vendor_invoice.PaidAmount)<>0 " +
                "AND fin_vendor_invoice.Code LIKE :prmCode " +
                "AND fin_vendor_invoice.VendorCode LIKE :prmVendorCode " +
                "AND mst_vendor.Name LIKE :prmVendorName " +
                strQueryConcat +
                "ORDER BY fin_vendor_invoice.DueDate ASC")
                .addScalar("statusInvoice", Hibernate.STRING)
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("paymentTermDays", Hibernate.BIG_DECIMAL)
                .addScalar("dueDate", Hibernate.TIMESTAMP)
                .addScalar("dueDays", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("paidAmount", Hibernate.BIG_DECIMAL)
                .addScalar("balanceAmount", Hibernate.BIG_DECIMAL)
                
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmVendorCode", "%"+vendorCode+"%")
                .setParameter("prmVendorName", "%"+vendorName+"%")
                .setFirstResult(from)
                .setMaxResults(row)
                .setResultTransformer(Transformers.aliasToBean(VendorInvoiceTemp.class))
                .list(); 
                 
                return list;
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
