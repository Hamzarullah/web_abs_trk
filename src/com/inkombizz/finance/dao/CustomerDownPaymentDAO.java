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

import com.inkombizz.finance.model.CustomerDownPayment;
import com.inkombizz.finance.model.CustomerDownPaymentPaid;
import com.inkombizz.finance.model.CustomerDownPaymentTemp;
import com.inkombizz.finance.model.CustomerDownPaymentUsed;
import java.math.BigDecimal;


public class CustomerDownPaymentDAO {
    
    private HBMSession hbmSession;

    public CustomerDownPaymentDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String customerCode,String customerName,String currencyCode,Date firstDate,Date lastDate){
        try{
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM fin_customer_down_payment "
                + "INNER JOIN mst_customer ON fin_customer_down_payment.CustomerCode=mst_customer.Code "
                + "INNER JOIN mst_currency ON fin_customer_down_payment.CurrencyCode=mst_currency.Code "
                + "WHERE fin_customer_down_payment.Code LIKE '%"+code+"%' "
                + "AND fin_customer_down_payment.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + "AND fin_customer_down_payment.CurrencyCode LIKE '%"+currencyCode+"%' "
                + "AND DATE(fin_customer_down_payment.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'").uniqueResult();

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
        
    public List<CustomerDownPaymentTemp> findData(String code,String customerCode,String customerName,String currencyCode,Date firstDate,Date lastDate,int from,int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<CustomerDownPaymentTemp> list = (List<CustomerDownPaymentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_customer_down_payment.Code, "
                + "fin_customer_down_payment.TransactionDate, "
                + "fin_customer_down_payment.CustomerCode, "
                + "mst_customer.Name AS customerName, "
                + "fin_customer_down_payment.TINNo, "
                + "fin_customer_down_payment.CurrencyCode, "
                + "fin_customer_down_payment.`BankAccountCode` AS bankAccountCode, " 
                + "mst_bank_account.`Name` AS bankAccountName, "
                + "fin_customer_down_payment.`PaymentTermCode` AS paymentTermCode, " 
                + "mst_payment_term.`Name` AS paymentTermName, "
                + "fin_customer_down_payment.ExchangeRate, "
                + "fin_customer_down_payment.`CDPNote`, "
                + "fin_customer_down_payment.TotalTransactionAmount, "
                + "fin_customer_down_payment.VATAmount, "
                + "fin_customer_down_payment.GrandTotalAmount, "
                + "fin_customer_down_payment.RefNo, "
                + "fin_customer_down_payment.Remark "
                + "FROM fin_customer_down_payment "
                + "INNER JOIN mst_customer ON fin_customer_down_payment.CustomerCode=mst_customer.Code "
                + "INNER JOIN mst_currency ON fin_customer_down_payment.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_bank_account ON fin_customer_down_payment.bankAccountCode=mst_bank_account.Code "
                + "INNER JOIN mst_payment_term ON fin_customer_down_payment.`PaymentTermCode` = mst_payment_term.`Code` "
                + "WHERE fin_customer_down_payment.Code LIKE '%"+code+"%' "
                + "AND fin_customer_down_payment.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + "AND fin_customer_down_payment.CurrencyCode LIKE '%"+currencyCode+"%' "
                + "AND DATE(fin_customer_down_payment.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_customer_down_payment.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")

                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("bankAccountCode", Hibernate.STRING)
                .addScalar("bankAccountName", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("tinNo", Hibernate.STRING)    
                .addScalar("cdpNote", Hibernate.STRING)    
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDownPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(CustomerDownPayment customerDownPayment){        
        try{
            
            String tempKode = EnumTransactionType.ENUM_TransactionType.CDP.toString();
            String acronim =  customerDownPayment.getBranch().getCode()+"/"+tempKode+"/"+AutoNumber.formatingDate(customerDownPayment.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerDownPayment.class)
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
    
    public void save(CustomerDownPayment customerDownPayment,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            customerDownPayment.setCode(createCode(customerDownPayment));
            
            customerDownPayment.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPayment.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(customerDownPayment);
            
            CustomerDownPaymentUsed customerDownPaymentUsed=new CustomerDownPaymentUsed();
            customerDownPaymentUsed.setCode(customerDownPayment.getCode());
            BigDecimal tempUsed=new BigDecimal("0.00");
            if(customerDownPaymentUsed.getUsedAmount()==null){
                customerDownPaymentUsed.setUsedAmount(tempUsed);
            }
            customerDownPaymentUsed.setTotalTransactionAmount(customerDownPayment.getTotalTransactionAmount());
            customerDownPaymentUsed.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPaymentUsed.setCreatedDate(new Date()); 
            customerDownPaymentUsed.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPaymentUsed.setUpdatedDate(new Date());
            hbmSession.hSession.save(customerDownPaymentUsed);
            
            CustomerDownPaymentPaid customerDownPaymentPaid=new CustomerDownPaymentPaid();
            customerDownPaymentPaid.setCode(customerDownPayment.getCode());
            BigDecimal tempPaid=new BigDecimal("0.00");
            if(customerDownPaymentPaid.getPaidAmount()==null){
                customerDownPaymentPaid.setPaidAmount(tempPaid);
            }
            
            customerDownPaymentPaid.setGrandTotalAmount(customerDownPayment.getGrandTotalAmount());
            customerDownPaymentPaid.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPaymentPaid.setCreatedDate(new Date()); 
            customerDownPaymentPaid.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPaymentPaid.setUpdatedDate(new Date()); 
            hbmSession.hSession.save(customerDownPaymentPaid);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), customerDownPayment.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public void update(CustomerDownPayment customerDownPayment,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            customerDownPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPayment.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(customerDownPayment);
            
            CustomerDownPaymentUsed customerDownPaymentUsed=new CustomerDownPaymentUsed();
            customerDownPaymentUsed.setCode(customerDownPayment.getCode());
            customerDownPaymentUsed.setTotalTransactionAmount(customerDownPayment.getTotalTransactionAmount());
            customerDownPaymentUsed.setCreatedBy(customerDownPayment.getCreatedBy());
            customerDownPaymentUsed.setCreatedDate(customerDownPayment.getCreatedDate()); 
            customerDownPaymentUsed.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPaymentUsed.setUpdatedDate(new Date());
            hbmSession.hSession.update(customerDownPaymentUsed);
            
            CustomerDownPaymentPaid customerDownPaymentPaid=new CustomerDownPaymentPaid();
            customerDownPaymentPaid.setCode(customerDownPayment.getCode());
            customerDownPaymentPaid.setGrandTotalAmount(customerDownPayment.getGrandTotalAmount());
            customerDownPaymentPaid.setCreatedBy(customerDownPayment.getCreatedBy());
            customerDownPaymentPaid.setCreatedDate(customerDownPayment.getCreatedDate()); 
            customerDownPaymentPaid.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerDownPaymentPaid.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(customerDownPaymentPaid);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), customerDownPayment.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public List<CustomerDownPaymentTemp> listDataHeaderByCustomerInvoiceUpdate(String sinNo,String customerCode,String currencyCode) {
        try {
          
            List<CustomerDownPaymentTemp> list = (List<CustomerDownPaymentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_customer_down_payment.code, "
                + "fin_customer_down_payment.Transactiondate, "
                + "fin_customer_down_payment.CurrencyCode, "
                + "fin_customer_down_payment.ExchangeRate, "
                + "fin_customer_down_payment_used.TotalTransactionAmount, "
                + "IFNULL((SELECT fin_customer_invoice_sdp_detail_temp.amount FROM fin_customer_invoice_sdp_detail fin_customer_invoice_sdp_detail_temp WHERE fin_customer_invoice_sdp_detail_temp.headerCode='"+sinNo+"' AND fin_customer_invoice_sdp_detail_temp.sdpno=fin_customer_down_payment.code),0)AS appliedAmount, "
                + "(fin_customer_down_payment_used.UsedAmount - (SELECT appliedAmount)) AS UsedAmount, "
                + "(fin_customer_down_payment_used.TotalTransactionAmount-((fin_customer_down_payment_used.UsedAmount - (SELECT appliedAmount)))) AS balance "
                + "FROM fin_customer_down_payment "
                + "INNER JOIN fin_customer_down_payment_used ON fin_customer_down_payment_used.code = fin_customer_down_payment.code "
                + "LEFT JOIN fin_customer_invoice_sdp_detail ON fin_customer_down_payment.Code=fin_customer_invoice_sdp_detail.Sdpno "
                + "WHERE fin_customer_invoice_sdp_detail.Headercode='"+sinNo+"' "
                + "OR fin_customer_down_payment.CustomerCode='"+customerCode+"' "
                + "AND fin_customer_down_payment.CurrencyCode='"+currencyCode+"' "
                + "GROUP BY fin_customer_down_payment.code "
                + "ORDER BY fin_customer_down_payment.code DESC")

                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("usedAmount", Hibernate.BIG_DECIMAL)
                .addScalar("balance", Hibernate.BIG_DECIMAL)
                .addScalar("appliedAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CustomerDownPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    //digunakan oleh customerInvoice[temp]...
//    public void UpdateUsedAmount(BigDecimal amount,String sdpNo,String headerCode,String flag) throws Exception {
//        try{
//                CustomerDownPaymentUsed customerDownPaymentUsed = new CustomerDownPaymentUsed();
//                BigDecimal usedAmount=new BigDecimal("0.00");
//                
//                customerDownPaymentUsed = (CustomerDownPaymentUsed) hbmSession.hSession.createSQLQuery(
//                        "SELECT "
//                    + "totalTransactionAmount, "
//                    + "usedAmount "
//                    + "FROM fin_customer_down_payment_used "
//                    + "WHERE CODE = '"+sdpNo+"'")
//                        
//                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
//                    .addScalar("usedAmount", Hibernate.BIG_DECIMAL)
//                    .setResultTransformer(Transformers.aliasToBean(CustomerDownPaymentUsed.class))
//                    .uniqueResult();
//                        
//                switch(flag){
//                    case "NEW":
//                        usedAmount=customerDownPaymentUsed.getUsedAmount().add(amount);
//                        break;
//                    case "DELETE":
//                        usedAmount=customerDownPaymentUsed.getUsedAmount().subtract(amount);
//                        break;
//                    case "UPDATE":
//                        //
//                        break;
//                }
//                
//            hbmSession.hSession.createSQLQuery(
//                                "UPDATE fin_customer_down_payment_used "
//                            + "SET fin_customer_down_payment_used.usedAmount ="+usedAmount+" "
//                            + "WHERE fin_customer_down_payment_used.code ='"+sdpNo+"'")
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
                + "FROM (SELECT fin_customer_down_payment_paid.Code,fin_customer_down_payment_paid.PaidAmount AS amount "
                + "FROM fin_customer_down_payment_paid "
                + "UNION ALL "
                + "SELECT fin_customer_down_payment_used.Code,fin_customer_down_payment_used.UsedAmount AS amount "
                + "FROM fin_customer_down_payment_used "
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
                                    "DELETE FROM fin_customer_down_payment" 
                                + " WHERE fin_customer_down_payment.code ='"+code+"'")
                                .executeUpdate();

            hbmSession.hSession.createSQLQuery(
                                    "DELETE FROM fin_customer_down_payment_paid" 
                                + " WHERE fin_customer_down_payment_paid.code ='"+code+"'")
                                .executeUpdate();
  
            hbmSession.hSession.createSQLQuery(
                                    "DELETE FROM fin_customer_down_payment_used" 
                                + " WHERE fin_customer_down_payment_used.code ='"+code+"'")
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
    public List<CustomerDownPaymentTemp> findByCustomerInvoice(String customerCode) {
        try {

            List<CustomerDownPaymentTemp> list = (List<CustomerDownPaymentTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT \n" +
"		fin_customer_down_payment.Code, \n" +
"		fin_customer_down_payment.TransactionDate AS transactionDate, \n" +
"		fin_customer_down_payment.customerCode AS customerCode, \n" +
"		mst_customer.Name AS customerName, \n" +
"		fin_customer_down_payment.TINNo AS tinNo, \n" +
"		fin_customer_down_payment.CurrencyCode AS currencyCode, \n" +
"		fin_customer_down_payment.ExchangeRate AS exchangeRate, \n" +
"		fin_customer_down_payment.TotalTransactionAmount AS totalTransactionAmount, \n" +
"		fin_customer_down_payment.VATAmount AS vatAmount, \n" +
"		fin_customer_down_payment.GrandTotalAmount AS grandTotalAmount, \n" +
"		fin_customer_down_payment_used.UsedAmount AS usedAmount,\n" +
"		(fin_customer_down_payment_used.TotalTransactionAmount - fin_customer_down_payment_used.UsedAmount) AS balance,\n" +
"		fin_customer_down_payment.RefNo, \n" +
"		fin_customer_down_payment.Remark \n" +
"	fROM fin_customer_down_payment \n" +
"	INNER JOIN mst_customer ON fin_customer_down_payment.customerCode=mst_customer.Code\n" +
"	INNER JOIN fin_customer_down_payment_used ON fin_customer_down_payment_used.Code = fin_customer_down_payment.Code\n" +
"	WHERE mst_customer.Code = '"+customerCode+"' \n" +
"             AND fin_customer_down_payment_used.TotalTransactionAmount > fin_customer_down_payment_used.UsedAmount \n" +
"	ORDER BY fin_customer_down_payment.Code ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
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
                    .setResultTransformer(Transformers.aliasToBean(CustomerDownPaymentTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
}
