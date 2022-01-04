/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.GiroReceived;
import com.inkombizz.finance.model.GiroReceivedInquiryTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

/**
 *
 * @author Rayis
 */
public class GiroReceivedInquiryDAO {
    
    private HBMSession hbmSession;
    
    public GiroReceivedInquiryDAO(HBMSession session) {
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
                + "FROM fin_giro_received "
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
     public List<GiroReceivedInquiryTemp> findData(String code,String bankCode,String remark,String grpNo,String giroNo,String bankName,String refNo,
             String giroStatus,Date firstDate, Date lastDate,Date firstDueDate, Date lastDueDate,int from, int row) {
        try {   
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
//            
            String dueDateFirst = DATE_FORMAT.format(firstDueDate);
            String dueDateLast = DATE_FORMAT.format(lastDueDate);
            
            List<GiroReceivedInquiryTemp> list = (List<GiroReceivedInquiryTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "fin_giro_received.Code, "
                + "fin_giro_received.BranchCode, "
                + "mst_branch.Name AS BranchName, "
                + "fin_giro_received.TransactionDate, "
                + "fin_giro_received.DueDate As dueDate, "
                + "fin_giro_received.GiroNo, "
                + "mst_bank.Code AS BankCode, "
                + "mst_bank.Name AS BankName, "
                + "fin_giro_received.ReceivedFrom, "
                + "fin_giro_received.CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "fin_giro_received.Amount, "
                + "fin_giro_received.GiroStatus, "
                + "fin_giro_received.RefNo, "
                + "fin_giro_received.Remark, "
                + "fin_giro_received.RejectedReasonCode AS rejectedReasonCode, "
                + "mst_reason.Name AS rejectedReasonName, "
                + "fin_giro_received.RejectedRemark AS rejectedRemark "
                + "FROM fin_giro_received "
                + "INNER JOIN mst_branch ON mst_branch.Code = fin_giro_received.BranchCode "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_giro_received.CurrencyCode "
                + "INNER JOIN mst_bank ON mst_bank.Code = fin_giro_received.BankCode "
                + "LEFT JOIN mst_reason ON mst_reason.Code = fin_giro_received.RejectedReasonCode "
                + "WHERE "
                + "fin_giro_received.Code LIKE '%" + code + "%' "
                + "AND DATE(fin_giro_received.TransactionDate) BETWEEN DATE('" + dateFirst + "') AND DATE('" + dateLast + "') "
                + "AND DATE(fin_giro_received.DueDate) BETWEEN DATE('" + dueDateFirst + "') AND DATE('" + dueDateLast + "') "
                + "AND fin_giro_received.BankCode LIKE '%" + bankCode + "%' "
                + "AND fin_giro_received.Remark LIKE '%" + remark + "%' "
                + "AND fin_giro_received.GiroNo LIKE '%" + giroNo + "%' "
                + "AND mst_bank.Name LIKE '%" + bankName + "%' "
                + "AND fin_giro_received.RefNo LIKE '%" + refNo + "%' "
                + "AND fin_giro_received.GiroStatus LIKE '%" + giroStatus + "%' "
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("dueDate", Hibernate.TIMESTAMP)
                .addScalar("dueDate", Hibernate.TIMESTAMP)
                .addScalar("giroNo", Hibernate.STRING)
                .addScalar("bankCode", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("receivedFrom", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("amount", Hibernate.BIG_DECIMAL)
                .addScalar("giroStatus", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("rejectedReasonCode", Hibernate.STRING)
                .addScalar("rejectedReasonName", Hibernate.STRING)
                .addScalar("rejectedRemark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(GiroReceivedInquiryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
//    END FIND HEADER
     
    public void save(GiroReceived giroReceivedInquiry, String MODULECODE) throws Exception {
        
        try {
            hbmSession.hSession.beginTransaction();
            
            giroReceivedInquiry.setRejectedBy(BaseSession.loadProgramSession().getUserName());
            
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received "
                        + "SET "
                            + "fin_giro_received.GiroStatus ='Rejected', "
                            + "fin_giro_received.RejectedReasonCode = :prmReason, "
                            + "fin_giro_received.RejectedRemark = :prmRejectedRemark, "
                            + "fin_giro_received.RejectedDate = :prmRejectedDate, "
                            + "fin_giro_received.RejectedBy = :prmRejectedBy "
                        + "WHERE fin_giro_received.Code = :prmCode")
                        .setParameter("prmCode", giroReceivedInquiry.getCode())
                        .setParameter("prmReason", giroReceivedInquiry.getReason().getCode())
                        .setParameter("prmRejectedRemark", giroReceivedInquiry.getRejectedRemark())
                        .setParameter("prmRejectedDate", new Date())
                        .setParameter("prmRejectedBy", giroReceivedInquiry.getRejectedBy())
                        .executeUpdate();

                hbmSession.hSession.flush();
                
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    giroReceivedInquiry.getCode(), ""));      
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
