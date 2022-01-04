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
import com.inkombizz.finance.model.CustomerDepositAssignmentTemp;
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
public class CustomerDepositAssignmentDAO {
    
    private HBMSession hbmSession;
    
    public CustomerDepositAssignmentDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(Date firstDate,Date lastDate,String code, String depositNo, String remark, String refNo){
        try{
            String userCode = BaseSession.loadProgramSession().getUserCode();
            BigDecimal temp = (BigDecimal)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_customer_deposit_assignment_list_count(:prmUserCodeTemp, :prmfirstDate, :prmlastDate, :prmCode)")
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
    
    public List<CustomerDepositAssignmentTemp> findData(Date firstDate,Date lastDate,String code,String depositNo,String remark,String refNo,int from, int row) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String userCode = BaseSession.loadProgramSession().getUserCode();
            List<CustomerDepositAssignmentTemp> list = (List<CustomerDepositAssignmentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                        "fin_bank_received_deposit.Code AS depositNo, " +
                        "'VDP-BBK' AS transType, " +
                        "fin_bank_received_deposit.BranchCode, " +
                        "fin_bank_received_deposit.TransactionDate, " +
                        "fin_bank_received_deposit.CurrencyCode, " +
                        "fin_bank_received_deposit.ExchangeRate, " +
                        "mst_customer.code as CustomerCode, " +
                        "mst_customer.name as CustomerName, " +
                        "fin_bank_received_deposit.RefNo, " +
                        "fin_bank_received_deposit.Remark, " +
                        "fin_bank_received_deposit.GrandTotalAmount " +
                    "FROM fin_bank_received_deposit " +
                    "LEFT JOIN mst_customer on mst_customer.code = fin_bank_received_deposit.customerCode "+ 
                    "WHERE " +
                        "fin_bank_received_deposit.Code LIKE '%" + depositNo + "%' " +
                        "AND DATE(fin_bank_received_deposit.TransactionDate) BETWEEN DATE('" + dateFirst + "') AND DATE('" + dateLast + "') " +
                        "AND fin_bank_received_deposit.Remark LIKE '%" + remark + "%' " +
                        "AND fin_bank_received_deposit.RefNo LIKE '%" + refNo + "%' " +
                    "UNION ALL " +
                    "SELECT " +
                        "fin_cash_received_deposit.Code AS depositNo, " +
                        "'VDP-BKK' AS transType, " +
                        "fin_cash_received_deposit.BranchCode, " +
                        "fin_cash_received_deposit.TransactionDate, " +
                        "fin_cash_received_deposit.CurrencyCode, " +
                        "fin_cash_received_deposit.ExchangeRate, " +
                        "mst_customer.code as CustomerCode, " +
                        "mst_customer.name as CustomerName, " +
                        "fin_cash_received_deposit.RefNo, " +
                        "fin_cash_received_deposit.Remark, " +
                        "fin_cash_received_deposit.GrandTotalAmount " +
                    "FROM fin_cash_received_deposit "+
                    "LEFT JOIN mst_customer on mst_customer.code = fin_cash_received_deposit.customerCode " +
                    "WHERE " +
                        "fin_cash_received_deposit.Code LIKE '%" + depositNo + "%' " +
                        "AND DATE(fin_cash_received_deposit.TransactionDate) BETWEEN DATE('" + dateFirst + "') AND DATE('" + dateLast + "') " +
                        "AND fin_cash_received_deposit.Remark LIKE '%" + remark + "%' " +
                        "AND fin_cash_received_deposit.RefNo LIKE '%" + refNo + "%' "    )
                        .addScalar("depositNo", Hibernate.STRING)
                        .addScalar("transType", Hibernate.STRING)
                        .addScalar("branchCode", Hibernate.STRING)
                        .addScalar("transactionDate", Hibernate.TIMESTAMP)
                        .addScalar("currencyCode", Hibernate.STRING)
                        .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                        .addScalar("customerCode", Hibernate.STRING)
                        .addScalar("customerName", Hibernate.STRING)
                        .addScalar("refNo", Hibernate.STRING)
                        .addScalar("remark", Hibernate.STRING)
                        .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                        .setResultTransformer(Transformers.aliasToBean(CustomerDepositAssignmentTemp.class))
                    .list(); 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerDepositAssignmentTemp get(String depositNo) {
        try {
               CustomerDepositAssignmentTemp customerDepositAssignmentTemp = (CustomerDepositAssignmentTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                        "fin_bank_received_deposit.Code AS depositNo, " +
                        "'VDP-BBK' AS transType, " +
                        "fin_bank_received_deposit.BranchCode, " +
                        "fin_bank_received_deposit.TransactionDate, " +
                        "fin_bank_received_deposit.CurrencyCode, " +
                        "fin_bank_received_deposit.ExchangeRate, " +
                        "mst_customer.code as CustomerCode, " +
                        "mst_customer.name as CustomerName, " +
                        "fin_bank_received_deposit.RefNo, " +
                        "fin_bank_received_deposit.Remark, " +
                        "fin_bank_received_deposit.GrandTotalAmount " +
                    "FROM fin_bank_received_deposit " +
                    "LEFT JOIN mst_customer on mst_customer.code = fin_bank_received_deposit.customerCode " +
                    "UNION ALL " +
                    "SELECT " +
                        "fin_cash_received_deposit.Code AS depositNo, " +
                        "'VDP-BKK' AS transType, " +
                        "fin_cash_received_deposit.BranchCode, " +
                        "fin_cash_received_deposit.TransactionDate, " +
                        "fin_cash_received_deposit.CurrencyCode, " +
                        "fin_cash_received_deposit.ExchangeRate, " +
                        "mst_customer.code as CustomerCode, " +
                        "mst_customer.name as CustomerName, " +
                        "fin_cash_received_deposit.RefNo, " +
                        "fin_cash_received_deposit.Remark, " +
                        "fin_cash_received_deposit.GrandTotalAmount " +
                    "FROM fin_cash_received_deposit " +
                    "LEFT JOIN mst_customer on mst_customer.code = fin_cash_received_deposit.customerCode " )
                        .addScalar("depositNo", Hibernate.STRING)
                        .addScalar("transType", Hibernate.STRING)
                        .addScalar("branchCode", Hibernate.STRING)
                        .addScalar("transactionDate", Hibernate.TIMESTAMP)
                        .addScalar("currencyCode", Hibernate.STRING)
                        .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                        .addScalar("customerCode", Hibernate.STRING)
                        .addScalar("customerName", Hibernate.STRING)
                        .addScalar("refNo", Hibernate.STRING)
                        .addScalar("remark", Hibernate.STRING)
                        .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                        .setParameter("prmCode", depositNo)
                        .setResultTransformer(Transformers.aliasToBean(CustomerDepositAssignmentTemp.class))
                        .uniqueResult();

            return customerDepositAssignmentTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(CustomerDepositAssignmentTemp customerDepositAssignment, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            customerDepositAssignment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerDepositAssignment.setUpdatedDate(new Date());
            
            if(customerDepositAssignment.getTransType().equals("VDP-BBK")){
                hbmSession.hSession.createSQLQuery("UPDATE fin_bank_received_deposit SET fin_bank_received_deposit.customerCode = :prmCustomerCode "
                        + "WHERE fin_bank_received_deposit.Code = :prmDepositNo")
                        .setParameter("prmDepositNo", customerDepositAssignment.getDepositNo())
                        .setParameter("prmCustomerCode", customerDepositAssignment.getCustomerCode())
                        .executeUpdate();

                hbmSession.hSession.flush();
                
            }else if(customerDepositAssignment.getTransType().equals("VDP-BKK")){
                hbmSession.hSession.createSQLQuery("UPDATE fin_cash_received_deposit SET fin_cash_received_deposit.customerCode = :prmCustomerCode "
                        + "WHERE fin_cash_received_deposit.Code = :prmDepositNo")
                        .setParameter("prmDepositNo", customerDepositAssignment.getDepositNo())
                        .setParameter("prmCustomerCode", customerDepositAssignment.getCustomerCode())
                        .executeUpdate();

                hbmSession.hSession.flush();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    customerDepositAssignment.getDepositNo(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
   
    
}
