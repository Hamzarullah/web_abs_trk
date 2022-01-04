/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.dao;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.PaymentHistoryDetailTemp;
import com.inkombizz.finance.model.PaymentHistoryTemp;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

public class PaymentHistoryDAO {
    
    private HBMSession hbmSession;
    
    public PaymentHistoryDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countByData(Date firstDate, Date lastDate, PaymentHistoryTemp paymentHistoryTemp) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String sql = "CALL usp_Finance_PaymentHistoryHeader_Get_Count("
                    + "'"+paymentHistoryTemp.getTransactionType()+"'"
                    + ",'"+dateFirst+"'"
                    + ",'"+dateLast+"'"
                    + ",'%"+paymentHistoryTemp.getDocumentNo()+"%'"
                    + ",'%"+paymentHistoryTemp.getDocumentRefNo()+"%'"
                    + ",'%"+paymentHistoryTemp.getDocumentCustomerVendorCode()+"%'"
                    + ",'%"+paymentHistoryTemp.getDocumentCustomerVendorName()+"%')";
            BigInteger count = (BigInteger) hbmSession.hSession.createSQLQuery(sql).list().get(0);
            return count.intValue();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<PaymentHistoryTemp> findData(Date firstDate, Date lastDate, PaymentHistoryTemp paymentHistoryTemp, int from, int to) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String sql = "CALL usp_Finance_PaymentHistoryHeader_Get("
                    + "'"+paymentHistoryTemp.getTransactionType()+"'"
                    + ",'"+dateFirst+"'"
                    + ",'"+dateLast+"'"
                    + ",'%"+paymentHistoryTemp.getDocumentNo()+"%'"
                    + ",'%"+paymentHistoryTemp.getDocumentRefNo()+"%'"
                    + ",'%"+paymentHistoryTemp.getDocumentCustomerVendorCode()+"%'"
                    + ",'%"+paymentHistoryTemp.getDocumentCustomerVendorName()+"%'"
                    + ","+from+""
                    + ","+to+")";
            
            List<PaymentHistoryTemp> list = hbmSession.hSession.createSQLQuery(sql)
                    .addScalar("transactionType", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .addScalar("documentRefNo", Hibernate.STRING)
                    .addScalar("documentTransactionDate", Hibernate.TIMESTAMP)
                    .addScalar("documentCustomerVendorCode", Hibernate.STRING)
                    .addScalar("documentCustomerVendorName", Hibernate.STRING)
                    .addScalar("documentCurrencyCode", Hibernate.STRING)
                    .addScalar("documentExchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("documentTotalTransactionAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("documentDownPaymentAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("documentNettAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("documentPaidAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("documentBalanceAmount", Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(PaymentHistoryTemp.class))
                    .list();
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PaymentHistoryDetailTemp> findPaymentHistoryDetail(String documentType, String documentNo) {
        try {

            
            String sql = "CALL usp_Finance_PaymentHistoryDetail_Get("
                    + "'"+documentNo+"'"
                    + ",'"+documentType+"')";
            
            List<PaymentHistoryDetailTemp> list = hbmSession.hSession.createSQLQuery(sql)
                    .addScalar("documentBranchCode", Hibernate.STRING)
                    .addScalar("documentNo", Hibernate.STRING)
                    .addScalar("bankCashAccountCode", Hibernate.STRING)
                    .addScalar("bankCashAccountName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("voucherNo", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("paymentReceivedType", Hibernate.STRING)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("amount", Hibernate.BIG_DECIMAL)
                    .addScalar("amountIDR", Hibernate.BIG_DECIMAL)
                    .addScalar("chartOfAccountCode", Hibernate.STRING)
                    .addScalar("chartOfAccountName", Hibernate.STRING)
                    .addScalar("transactionStatus", Hibernate.STRING)
                    
                    .setResultTransformer(Transformers.aliasToBean(PaymentHistoryDetailTemp.class))
                    .list();
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
}
