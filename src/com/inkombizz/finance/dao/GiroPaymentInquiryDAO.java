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
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentInquiryTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

public class GiroPaymentInquiryDAO {

    private HBMSession hbmSession;
    
    public GiroPaymentInquiryDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
//    COUNT HEADER
    public int countData(String code,String bankCode,String remark,String grpNo,String giroNo,String bankName,
            String refNo,String giroStatus,Date firstDate, Date lastDate,Date firstDueDate, Date lastDueDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                  "SELECT COUNT(*)  "
                + "FROM fin_giro_payment "
                  )
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
//    END COUNT HEADER
    
//    FIND HEADER
     public List<GiroPaymentInquiryTemp> findData(String code,String bankCode,String remark,String grpNo,String giroNo,String bankName,String refNo,
             String giroStatus,Date firstDate, Date lastDate,Date firstDueDate, Date lastDueDate,int from, int row) {
        try {   
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
//            
            String dueDateFirst = DATE_FORMAT.format(firstDueDate);
            String dueDateLast = DATE_FORMAT.format(lastDueDate);
            
            List<GiroPaymentInquiryTemp> list = (List<GiroPaymentInquiryTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "fin_giro_payment.Code, "
                + "fin_giro_payment.BranchCode, "
                + "mst_branch.Name AS BranchName, "
                + "fin_giro_payment.TransactionDate, "
                + "fin_giro_payment.RejectedReasonCode, "
                + "fin_giro_payment.RejectedRemark, "
                + "fin_giro_payment.DueDate As dueDate, "
                + "fin_giro_payment.GiroNo, "
                + "mst_bank.Code AS BankCode, "
                + "mst_bank.Name AS BankName, "
                + "fin_giro_payment.PaymentTo, "
                + "fin_giro_payment.CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "fin_giro_payment.Amount, "
                + "fin_giro_payment.GiroStatus, "
                + "fin_giro_payment.RefNo, "
                + "fin_giro_payment.Remark "
                + "FROM fin_giro_payment "
                + "INNER JOIN mst_branch ON mst_branch.Code = fin_giro_payment.BranchCode "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_giro_payment.CurrencyCode "
                + "INNER JOIN mst_bank ON mst_bank.Code = fin_giro_payment.BankCode "
                + "WHERE "
                + "fin_giro_payment.Code LIKE '%" + code + "%' "
                + "AND DATE(fin_giro_payment.TransactionDate) BETWEEN DATE('" + dateFirst + "') AND DATE('" + dateLast + "') "
                + "AND DATE(fin_giro_payment.DueDate) BETWEEN DATE('" + dueDateFirst + "') AND DATE('" + dueDateLast + "') "
                + "AND fin_giro_payment.BankCode LIKE '%" + bankCode + "%' "
                + "AND fin_giro_payment.Remark LIKE '%" + remark + "%' "
                + "AND fin_giro_payment.GiroNo LIKE '%" + giroNo + "%' "
                + "AND mst_bank.Name LIKE '%" + bankName + "%' "
                + "AND fin_giro_payment.RefNo LIKE '%" + refNo + "%' "
                + "AND fin_giro_payment.GiroStatus LIKE '%" + giroStatus + "%' "
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("dueDate", Hibernate.TIMESTAMP)
                .addScalar("rejectedReasonCode", Hibernate.STRING)
                .addScalar("rejectedRemark", Hibernate.STRING)
                .addScalar("dueDate", Hibernate.TIMESTAMP)
                .addScalar("giroNo", Hibernate.STRING)
                .addScalar("bankCode", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("paymentTo", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("amount", Hibernate.BIG_DECIMAL)
                .addScalar("giroStatus", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(GiroPaymentInquiryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
//    END FIND HEADER
     
    public void save(GiroPayment giroPaymentInquiry, String MODULECODE) throws Exception {
        
        try {
            hbmSession.hSession.beginTransaction();
            
            giroPaymentInquiry.setRejectedBy(BaseSession.loadProgramSession().getUserName());
            
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_payment "
                        + "SET "
                            + "fin_giro_payment.GiroStatus ='Rejected', "
                            + "fin_giro_payment.RejectedReasonCode = :prmReason, "
                            + "fin_giro_payment.RejectedRemark = :prmRejectedRemark, "
                            + "fin_giro_payment.RejectedDate = :prmRejectedDate, "
                            + "fin_giro_payment.RejectedBy = :prmRejectedBy "
                        + "WHERE fin_giro_payment.Code = :prmCode")
                        .setParameter("prmCode", giroPaymentInquiry.getCode())
                        .setParameter("prmReason", giroPaymentInquiry.getReason().getCode())
                        .setParameter("prmRejectedRemark", giroPaymentInquiry.getRejectedRemark())
                        .setParameter("prmRejectedDate", new Date())
                        .setParameter("prmRejectedBy", giroPaymentInquiry.getRejectedBy())
                        .executeUpdate();

                hbmSession.hSession.flush();
                
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    giroPaymentInquiry.getCode(), ""));      
            hbmSession.hTransaction.commit();
//            hbmSession.hSession.clear();
//            hbmSession.hSession.close();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw ex;
        }
    }    
    
    
     
}
