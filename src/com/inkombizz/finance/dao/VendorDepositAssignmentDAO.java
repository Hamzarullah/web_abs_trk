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
//import com.inkombizz.finance.model.BankReceivedDeposit;
import com.inkombizz.finance.model.VendorDepositAssignmentTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

/**
 *
 * @author egie
 */
public class VendorDepositAssignmentDAO {
    
    private HBMSession hbmSession;
    
    public VendorDepositAssignmentDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(Date firstDate,Date lastDate,String code, String depositNo, String remark, String refNo){
        try{
            String userCode = BaseSession.loadProgramSession().getUserCode();
            BigDecimal temp = (BigDecimal)hbmSession.hSession.createSQLQuery(
            "SELECT COUNT(*)  "
                + "FROM fin_bank_received_deposit "
                + "INNER JOIN mst_customer ON mst_customer.code = fin_bank_received_deposit.CustomerCode "
            )
                    .setParameter("prmUserCodeTemp", userCode)
                    .setParameter("prmfirstDate", firstDate)
                    .setParameter("prmlastDate", lastDate)
                    .setParameter("prmCode", "%"+code+"%")
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<VendorDepositAssignmentTemp> findData(Date firstDate,Date lastDate,String code,String depositNo,String remark,String refNo,int from, int row) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String userCode = BaseSession.loadProgramSession().getUserCode();
            List<VendorDepositAssignmentTemp> list = (List<VendorDepositAssignmentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                        "fin_bank_payment_deposit.Code AS depositNo, " +
                        "'VDP-BBK' AS transType, " +
                        "fin_bank_payment_deposit.BranchCode, " +
                        "fin_bank_payment_deposit.TransactionDate, " +
                        "fin_bank_payment_deposit.CurrencyCode, " +
                        "fin_bank_payment_deposit.ExchangeRate, " +
                        "mst_vendor.code as VendorCode, " +
                        "mst_vendor.name as VendorName, " +
                        "fin_bank_payment_deposit.RefNo, " +
                        "fin_bank_payment_deposit.Remark, " +
                        "fin_bank_payment_deposit.GrandTotalAmount " +
                    "FROM fin_bank_payment_deposit " +
                    "LEFT JOIN mst_vendor on mst_vendor.code = fin_bank_payment_deposit.vendorCode "+ 
                    "WHERE " +
                        "fin_bank_payment_deposit.Code LIKE '%" + depositNo + "%' " +
                        "AND DATE(fin_bank_payment_deposit.TransactionDate) BETWEEN DATE('" + dateFirst + "') AND DATE('" + dateLast + "') " +
                        "AND fin_bank_payment_deposit.Remark LIKE '%" + remark + "%' " +
                        "AND fin_bank_payment_deposit.RefNo LIKE '%" + refNo + "%' " +
                    "UNION ALL " +
                    "SELECT " +
                        "fin_cash_payment_deposit.Code AS depositNo, " +
                        "'VDP-BKK' AS transType, " +
                        "fin_cash_payment_deposit.BranchCode, " +
                        "fin_cash_payment_deposit.TransactionDate, " +
                        "fin_cash_payment_deposit.CurrencyCode, " +
                        "fin_cash_payment_deposit.ExchangeRate, " +
                        "mst_vendor.code as VendorCode, " +
                        "mst_vendor.name as VendorName, " +
                        "fin_cash_payment_deposit.RefNo, " +
                        "fin_cash_payment_deposit.Remark, " +
                        "fin_cash_payment_deposit.GrandTotalAmount " +
                    "FROM fin_cash_payment_deposit "+
                    "LEFT JOIN mst_vendor on mst_vendor.code = fin_cash_payment_deposit.vendorCode " +
                    "WHERE " +
                        "fin_cash_payment_deposit.Code LIKE '%" + depositNo + "%' " +
                        "AND DATE(fin_cash_payment_deposit.TransactionDate) BETWEEN DATE('" + dateFirst + "') AND DATE('" + dateLast + "') " +
                        "AND fin_cash_payment_deposit.Remark LIKE '%" + remark + "%' " +
                        "AND fin_cash_payment_deposit.RefNo LIKE '%" + refNo + "%' "    )
                        .addScalar("depositNo", Hibernate.STRING)
                        .addScalar("transType", Hibernate.STRING)
                        .addScalar("branchCode", Hibernate.STRING)
                        .addScalar("transactionDate", Hibernate.TIMESTAMP)
                        .addScalar("currencyCode", Hibernate.STRING)
                        .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                        .addScalar("vendorCode", Hibernate.STRING)
                        .addScalar("vendorName", Hibernate.STRING)
                        .addScalar("refNo", Hibernate.STRING)
                        .addScalar("remark", Hibernate.STRING)
                        .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                        .setResultTransformer(Transformers.aliasToBean(VendorDepositAssignmentTemp.class))
                    .list(); 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorDepositAssignmentTemp get(String depositNo) {
        try {
               VendorDepositAssignmentTemp vendorDepositAssignmentTemp = (VendorDepositAssignmentTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                        "fin_bank_payment_deposit.Code AS depositNo, " +
                        "'VDP-BBK' AS transType, " +
                        "fin_bank_payment_deposit.BranchCode, " +
                        "fin_bank_payment_deposit.TransactionDate, " +
                        "fin_bank_payment_deposit.CurrencyCode, " +
                        "fin_bank_payment_deposit.ExchangeRate, " +
                        "mst_vendor.code as VendorCode, " +
                        "mst_vendor.name as VendorName, " +
                        "fin_bank_payment_deposit.RefNo, " +
                        "fin_bank_payment_deposit.Remark, " +
                        "fin_bank_payment_deposit.GrandTotalAmount " +
                    "FROM fin_bank_payment_deposit " +
                    "LEFT JOIN mst_vendor on mst_vendor.code = fin_bank_payment_deposit.vendorCode " +
                    "UNION ALL " +
                    "SELECT " +
                        "fin_cash_payment_deposit.Code AS depositNo, " +
                        "'VDP-BKK' AS transType, " +
                        "fin_cash_payment_deposit.BranchCode, " +
                        "fin_cash_payment_deposit.TransactionDate, " +
                        "fin_cash_payment_deposit.CurrencyCode, " +
                        "fin_cash_payment_deposit.ExchangeRate, " +
                        "mst_vendor.code as VendorCode, " +
                        "mst_vendor.name as VendorName, " +
                        "fin_cash_payment_deposit.RefNo, " +
                        "fin_cash_payment_deposit.Remark, " +
                        "fin_cash_payment_deposit.GrandTotalAmount " +
                    "FROM fin_cash_payment_deposit " +
                    "LEFT JOIN mst_vendor on mst_vendor.code = fin_cash_payment_deposit.vendorCode " )
                        .addScalar("depositNo", Hibernate.STRING)
                        .addScalar("transType", Hibernate.STRING)
                        .addScalar("branchCode", Hibernate.STRING)
                        .addScalar("transactionDate", Hibernate.TIMESTAMP)
                        .addScalar("currencyCode", Hibernate.STRING)
                        .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                        .addScalar("vendorCode", Hibernate.STRING)
                        .addScalar("vendorName", Hibernate.STRING)
                        .addScalar("refNo", Hibernate.STRING)
                        .addScalar("remark", Hibernate.STRING)
                        .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                        .setParameter("prmCode", depositNo)
                        .setResultTransformer(Transformers.aliasToBean(VendorDepositAssignmentTemp.class))
                        .uniqueResult();

            return vendorDepositAssignmentTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(VendorDepositAssignmentTemp vendorDepositAssignment, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            vendorDepositAssignment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDepositAssignment.setUpdatedDate(new Date());
            
            if(vendorDepositAssignment.getTransType().equals("VDP-BBK")){
                hbmSession.hSession.createSQLQuery("UPDATE fin_bank_payment_deposit SET fin_bank_payment_deposit.vendorCode = :prmVendorCode "
                        + "WHERE fin_bank_payment_deposit.Code = :prmDepositNo")
                        .setParameter("prmDepositNo", vendorDepositAssignment.getDepositNo())
                        .setParameter("prmVendorCode", vendorDepositAssignment.getVendorCode())
                        .executeUpdate();

                hbmSession.hSession.flush();
                
            }else if(vendorDepositAssignment.getTransType().equals("VDP-BKK")){
                hbmSession.hSession.createSQLQuery("UPDATE fin_cash_payment_deposit SET fin_cash_payment_deposit.vendorCode = :prmVendorCode "
                        + "WHERE fin_cash_payment_deposit.Code = :prmDepositNo")
                        .setParameter("prmDepositNo", vendorDepositAssignment.getDepositNo())
                        .setParameter("prmVendorCode", vendorDepositAssignment.getVendorCode())
                        .executeUpdate();

                hbmSession.hSession.flush();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    vendorDepositAssignment.getDepositNo(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
   
    
}
