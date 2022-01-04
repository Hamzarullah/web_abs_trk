/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.dao;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang.xwork.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

import com.inkombizz.finance.model.VendorDownPayment;
import com.inkombizz.finance.model.VendorDownPaymentPaid;
import com.inkombizz.finance.model.VendorDownPaymentTemp;
import com.inkombizz.finance.model.VendorDownPaymentUsed;
import java.math.BigDecimal;


public class VendorDownPaymentDAO {
    
    private HBMSession hbmSession;

    public VendorDownPaymentDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String vendorCode,String vendorName,String currencyCode,Date firstDate,Date lastDate){
        try{
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM fin_vendor_down_payment "
                + "INNER JOIN mst_vendor ON fin_vendor_down_payment.VendorCode=mst_vendor.Code "
                + "INNER JOIN mst_currency ON fin_vendor_down_payment.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_item_division ON fin_vendor_down_payment.ItemDivisionCode=mst_item_division.Code "
                + "WHERE fin_vendor_down_payment.Code LIKE '%"+code+"%' "
                + "AND fin_vendor_down_payment.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + "AND fin_vendor_down_payment.CurrencyCode LIKE '%"+currencyCode+"%' "
                + "AND DATE(fin_vendor_down_payment.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'").uniqueResult();

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
        
    public List<VendorDownPaymentTemp> findData(String code,String vendorCode,String vendorName,String currencyCode,Date firstDate,Date lastDate,int from,int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<VendorDownPaymentTemp> list = (List<VendorDownPaymentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_down_payment.Code, "
                + "fin_vendor_down_payment.TransactionDate, "
                + "fin_vendor_down_payment.VendorCode, "
                + "mst_vendor.Name AS vendorName, "
                + "fin_vendor_down_payment.ItemDivisionCode, "
                + "mst_item_division.Name AS itemDivisionName, "
                + "fin_vendor_down_payment.taxInvoiceNo, "
                + "fin_vendor_down_payment.CurrencyCode, "
                + "fin_vendor_down_payment.ExchangeRate, "
                + "fin_vendor_down_payment.TotalTransactionAmount, "
                + "fin_vendor_down_payment.VATAmount, "
                + "fin_vendor_down_payment.GrandTotalAmount, "
                + "fin_vendor_down_payment.RefNo, "
                + "fin_vendor_down_payment.Remark "
                + "FROM fin_vendor_down_payment "
                + "INNER JOIN mst_vendor ON fin_vendor_down_payment.VendorCode=mst_vendor.Code "
                + "INNER JOIN mst_currency ON fin_vendor_down_payment.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_item_division ON fin_vendor_down_payment.ItemDivisionCode=mst_item_division.Code "            
                + "WHERE fin_vendor_down_payment.Code LIKE '%"+code+"%' "
                + "AND fin_vendor_down_payment.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + "AND fin_vendor_down_payment.CurrencyCode LIKE '%"+currencyCode+"%' "
                + "AND DATE(fin_vendor_down_payment.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_vendor_down_payment.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")

                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("taxInvoiceNo", Hibernate.STRING)    
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDownPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorDownPaymentTemp> findByPurchaseOrder(String vendorCode) {
        try {

            List<VendorDownPaymentTemp> list = (List<VendorDownPaymentTemp>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_vendor_down_payment_by_purchase_order_list(:prmVendorCode)")
                    .addScalar("vdpNo", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.DATE)
                    .addScalar("vendorCode", Hibernate.STRING)
                    .addScalar("vendorName", Hibernate.STRING)
                    .addScalar("tinNo", Hibernate.STRING)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("usedAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("balance", Hibernate.BIG_DECIMAL)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setParameter("prmVendorCode", vendorCode)
                    .setResultTransformer(Transformers.aliasToBean(VendorDownPaymentTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorDownPaymentTemp> findByVendorInvoice(String vendorCode) {
        try {

            List<VendorDownPaymentTemp> list = (List<VendorDownPaymentTemp>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_vendor_down_payment_by_vendor_invoice_list('"+vendorCode+"')")
                    .addScalar("vdpNo", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("vendorCode", Hibernate.STRING)
                    .addScalar("vendorName", Hibernate.STRING)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("usedAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("balance", Hibernate.BIG_DECIMAL)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(VendorDownPaymentTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(VendorDownPayment vendorDownPayment){        
        try{
            
            String tempKode = EnumTransactionType.ENUM_TransactionType.VDP.toString();
            String acronim =  vendorDownPayment.getBranch().getCode()+"/"+tempKode+"/"+AutoNumber.formatingDate(vendorDownPayment.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(VendorDownPayment.class)
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
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(VendorDownPayment vendorDownPayment,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            vendorDownPayment.setCode(createCode(vendorDownPayment));
            
            vendorDownPayment.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPayment.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(vendorDownPayment);
            
            VendorDownPaymentUsed vendorDownPaymentUsed=new VendorDownPaymentUsed();
            vendorDownPaymentUsed.setCode(vendorDownPayment.getCode());
            vendorDownPaymentUsed.setTotalTransactionAmount(vendorDownPayment.getTotalTransactionAmount());
            vendorDownPaymentUsed.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPaymentUsed.setCreatedDate(new Date()); 
            vendorDownPaymentUsed.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPaymentUsed.setUpdatedDate(new Date());
            hbmSession.hSession.save(vendorDownPaymentUsed);
            
            VendorDownPaymentPaid vendorDownPaymentPaid=new VendorDownPaymentPaid();
            vendorDownPaymentPaid.setCode(vendorDownPayment.getCode());
            vendorDownPaymentPaid.setGrandTotalAmount(vendorDownPayment.getGrandTotalAmount());
            vendorDownPaymentPaid.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPaymentPaid.setCreatedDate(new Date()); 
            vendorDownPaymentPaid.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPaymentPaid.setUpdatedDate(new Date()); 
            hbmSession.hSession.save(vendorDownPaymentPaid);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), vendorDownPayment.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public void update(VendorDownPayment vendorDownPayment,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            vendorDownPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPayment.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(vendorDownPayment);
            
            VendorDownPaymentUsed vendorDownPaymentUsed=new VendorDownPaymentUsed();
            vendorDownPaymentUsed.setCode(vendorDownPayment.getCode());
            vendorDownPaymentUsed.setTotalTransactionAmount(vendorDownPayment.getTotalTransactionAmount());
            vendorDownPaymentUsed.setCreatedBy(vendorDownPayment.getCreatedBy());
            vendorDownPaymentUsed.setCreatedDate(vendorDownPayment.getCreatedDate()); 
            vendorDownPaymentUsed.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPaymentUsed.setUpdatedDate(new Date());
            hbmSession.hSession.update(vendorDownPaymentUsed);
            
            VendorDownPaymentPaid vendorDownPaymentPaid=new VendorDownPaymentPaid();
            vendorDownPaymentPaid.setCode(vendorDownPayment.getCode());
            vendorDownPaymentPaid.setGrandTotalAmount(vendorDownPayment.getGrandTotalAmount());
            vendorDownPaymentPaid.setCreatedBy(vendorDownPayment.getCreatedBy());
            vendorDownPaymentPaid.setCreatedDate(vendorDownPayment.getCreatedDate()); 
            vendorDownPaymentPaid.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDownPaymentPaid.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(vendorDownPaymentPaid);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), vendorDownPayment.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public List<VendorDownPaymentTemp> listDataHeaderByVendorInvoiceUpdate(String sinNo,String vendorCode,String currencyCode) {
        try {
          
            List<VendorDownPaymentTemp> list = (List<VendorDownPaymentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_down_payment.code, "
                + "fin_vendor_down_payment.Transactiondate, "
                + "fin_vendor_down_payment.CurrencyCode, "
                + "fin_vendor_down_payment.ExchangeRate, "
                + "fin_vendor_down_payment_used.TotalTransactionAmount, "
                + "IFNULL((SELECT fin_vendor_invoice_sdp_detail_temp.amount FROM fin_vendor_invoice_sdp_detail fin_vendor_invoice_sdp_detail_temp WHERE fin_vendor_invoice_sdp_detail_temp.headerCode='"+sinNo+"' AND fin_vendor_invoice_sdp_detail_temp.sdpno=fin_vendor_down_payment.code),0)AS appliedAmount, "
                + "(fin_vendor_down_payment_used.UsedAmount - (SELECT appliedAmount)) AS UsedAmount, "
                + "(fin_vendor_down_payment_used.TotalTransactionAmount-((fin_vendor_down_payment_used.UsedAmount - (SELECT appliedAmount)))) AS balance "
                + "FROM fin_vendor_down_payment "
                + "INNER JOIN fin_vendor_down_payment_used ON fin_vendor_down_payment_used.code = fin_vendor_down_payment.code "
                + "LEFT JOIN fin_vendor_invoice_sdp_detail ON fin_vendor_down_payment.Code=fin_vendor_invoice_sdp_detail.Sdpno "
                + "WHERE fin_vendor_invoice_sdp_detail.Headercode='"+sinNo+"' "
                + "OR fin_vendor_down_payment.VendorCode='"+vendorCode+"' "
                + "AND fin_vendor_down_payment.CurrencyCode='"+currencyCode+"' "
                + "GROUP BY fin_vendor_down_payment.code "
                + "ORDER BY fin_vendor_down_payment.code DESC")

                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("usedAmount", Hibernate.BIG_DECIMAL)
                .addScalar("balance", Hibernate.BIG_DECIMAL)
                .addScalar("appliedAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(VendorDownPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    //digunakan oleh vendorInvoice[temp]...
//    public void UpdateUsedAmount(BigDecimal amount,String sdpNo,String headerCode,String flag) throws Exception {
//        try{
//                VendorDownPaymentUsed vendorDownPaymentUsed = new VendorDownPaymentUsed();
//                BigDecimal usedAmount=new BigDecimal("0.00");
//                
//                vendorDownPaymentUsed = (VendorDownPaymentUsed) hbmSession.hSession.createSQLQuery(
//                        "SELECT "
//                    + "totalTransactionAmount, "
//                    + "usedAmount "
//                    + "FROM fin_vendor_down_payment_used "
//                    + "WHERE CODE = '"+sdpNo+"'")
//                        
//                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
//                    .addScalar("usedAmount", Hibernate.BIG_DECIMAL)
//                    .setResultTransformer(Transformers.aliasToBean(VendorDownPaymentUsed.class))
//                    .uniqueResult();
//                        
//                switch(flag){
//                    case "NEW":
//                        usedAmount=vendorDownPaymentUsed.getUsedAmount().add(amount);
//                        break;
//                    case "DELETE":
//                        usedAmount=vendorDownPaymentUsed.getUsedAmount().subtract(amount);
//                        break;
//                    case "UPDATE":
//                        //
//                        break;
//                }
//                
//            hbmSession.hSession.createSQLQuery(
//                                "UPDATE fin_vendor_down_payment_used "
//                            + "SET fin_vendor_down_payment_used.usedAmount ="+usedAmount+" "
//                            + "WHERE fin_vendor_down_payment_used.code ='"+sdpNo+"'")
//                            .executeUpdate();
//        }
//            catch(HibernateException e){
//                hbmSession.hTransaction.rollback();
//                throw e;
//            }
//    }
    
    public Boolean checkExistInUsedPaidAmount(String code) throws Exception{
        try {
            
            boolean isExist;
            BigDecimal temp = (BigDecimal)hbmSession.hSession.createSQLQuery(
                    "SELECT SUM(chckSDP.amount) AS amount "
                + "FROM (SELECT fin_vendor_down_payment_paid.Code,fin_vendor_down_payment_paid.PaidAmount AS amount "
                + "FROM fin_vendor_down_payment_paid "
                + "UNION ALL "
                + "SELECT fin_vendor_down_payment_used.Code,fin_vendor_down_payment_used.UsedAmount AS amount "
                + "FROM fin_vendor_down_payment_used "
                + ")AS chckSDP "
                + "WHERE chckSDP.code='"+code+"' "
                + "GROUP BY chckSDP.code"            
            ).uniqueResult();
            
            if(temp.doubleValue() >0){
                isExist=Boolean.TRUE;
            }else{
                isExist=Boolean.FALSE;
            }
            return isExist;
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void delete(String code,String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            hbmSession.hSession.createSQLQuery(
                                    "DELETE FROM fin_vendor_down_payment" 
                                + " WHERE fin_vendor_down_payment.code ='"+code+"'")
                                .executeUpdate();

            hbmSession.hSession.createSQLQuery(
                                    "DELETE FROM fin_vendor_down_payment_paid" 
                                + " WHERE fin_vendor_down_payment_paid.code ='"+code+"'")
                                .executeUpdate();
  
            hbmSession.hSession.createSQLQuery(
                                    "DELETE FROM fin_vendor_down_payment_used" 
                                + " WHERE fin_vendor_down_payment_used.code ='"+code+"'")
                                .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
//    public VendorDownPaymentTemp getHeader(String code){
//       try {   
//            VendorDownPaymentTemp vendorDownPaymentTemp = (VendorDownPaymentTemp)hbmSession.hSession.createSQLQuery(
//                    "SELECT "
//                + "fin_vendor_down_payment.Code, "
//                + "fin_vendor_down_payment.CompanyCode, "
//                + "fin_vendor_down_payment.TransactionDate, "
//                + "fin_vendor_down_payment.VendorCode, "
//                + "fin_vendor_down_payment.TINNo, "
//                + "fin_vendor_down_payment.CurrencyCode, "
//                + "fin_vendor_down_payment.ExchangeRate, "
//                + "fin_vendor_down_payment.TotalTransactionAmount, "
//                + "fin_vendor_down_payment.VATPercent, "
//                + "fin_vendor_down_payment.VATAmount, "
//                + "fin_vendor_down_payment.GrandTotalAmount, "
//                + "fin_vendor_down_payment.RefNo, "
//                + "fin_vendor_down_payment.Remark, "
//                + "fin_vendor_down_payment.CreatedBy, "
//                + "fin_vendor_down_payment.CreatedDate "
//                + "FROM fin_vendor_down_payment "
//                + "WHERE fin_vendor_down_payment.Code='"+code+"'")
//                    
//                .addScalar("code", Hibernate.STRING)
//                .addScalar("companyCode", Hibernate.STRING)
//                .addScalar("transactionDate", Hibernate.TIMESTAMP)
//                .addScalar("vendorCode", Hibernate.STRING)
//                .addScalar("tinNo", Hibernate.STRING)
//                .addScalar("currencyCode", Hibernate.STRING)
//                .addScalar("exchangeRate",Hibernate.BIG_DECIMAL)
//                .addScalar("totalTransactionAmount",Hibernate.BIG_DECIMAL)
//                .addScalar("vatPercent",Hibernate.BIG_DECIMAL)
//                .addScalar("vatAmount",Hibernate.BIG_DECIMAL)
//                .addScalar("grandTotalAmount",Hibernate.BIG_DECIMAL)
//                .addScalar("refNo",Hibernate.STRING)
//                .addScalar("remark",Hibernate.STRING)
//                .addScalar("createdBy", Hibernate.STRING)
//                .addScalar("createdDate", Hibernate.TIMESTAMP)
//                .setResultTransformer(Transformers.aliasToBean(VendorDownPaymentTemp.class))
//                .uniqueResult(); 
//                 
//                return vendorDownPaymentTemp;
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    
}
