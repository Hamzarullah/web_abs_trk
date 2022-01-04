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
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.CashPayment;
import com.inkombizz.finance.model.CashPaymentDeposit;
import com.inkombizz.finance.model.CashPaymentDetail;
import com.inkombizz.finance.model.CashPaymentDetailTemp;
import com.inkombizz.finance.model.CashPaymentPaymentRequest;
import com.inkombizz.finance.model.CashPaymentPaymentRequestTemp;
import com.inkombizz.finance.model.CashPaymentTemp;
import com.inkombizz.finance.model.PaymentRequest;
import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.utils.DateUtils;
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

public class CashPaymentDAO {
    private HBMSession hbmSession;
    
    private FinanceDocumentDAO financeDocumentDAO;
    public CashPaymentDAO(HBMSession session) {
        this.hbmSession = session;
    }
    //Count Header
    public int countData(CashPaymentTemp cashPaymentTemp){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(cashPaymentTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(cashPaymentTemp.getLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                        "SELECT COUNT(*) FROM fin_cash_payment "
                        + "INNER JOIN mst_currency ON mst_currency.code = fin_cash_payment.currencycode "
                        + "INNER JOIN mst_cash_account ON mst_cash_account.code = fin_cash_payment.cashAccountCode "   
                        + "WHERE fin_cash_payment.code LIKE :prmCode "
                        + "AND DATE(fin_cash_payment.TransactionDate) BETWEEN :prmFirstDate AND :prmLastDate "
                        + "AND fin_cash_payment.RefNo LIKE :prmRefNo " 
                        + "AND fin_cash_payment.Remark LIKE :prmRemark " 
                    )
                    .setParameter("prmCode", "%"+cashPaymentTemp.getCode()+"%")
                    .setParameter("prmFirstDate", dateFirst)
                    .setParameter("prmLastDate", dateLast)
                    .setParameter("prmRefNo", "%"+cashPaymentTemp.getRefNo()+"%")
                    .setParameter("prmRemark", "%"+cashPaymentTemp.getRemark()+"%")
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    //Count Criteria
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
    //Find Header
    public List<CashPaymentTemp> findData(CashPaymentTemp cashPaymentTemp, int from, int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(cashPaymentTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(cashPaymentTemp.getLastDate());
            
                        
            List<CashPaymentTemp> list = (List<CashPaymentTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "fin_cash_payment.code, "
                + "fin_cash_payment.branchCode, "
                + "fin_cash_payment.transactionDate, "
                + "fin_cash_payment.transactionType, "
                + "fin_cash_payment.paymentTo, "
                + "fin_cash_payment.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_cash_payment.exchangeRate, "
                + "fin_cash_payment.cashAccountCode, "
                + "mst_cash_account.name AS cashAccountName, "
//                + "fin_cash_payment.giroPaymentNo AS giroPaymentCode, "
//                + "fin_giro_payment.giroNo AS giroPaymentNo, "
//                + "fin_cash_payment.transferPaymentNo, "
//                + "fin_cash_payment.transferPaymentDate, "
//                + "fin_cash_payment.transferCashName, "
                + "fin_cash_payment.totalTransactionAmount, "
                + "fin_cash_payment.refNo, "
                + "fin_cash_payment.remark "
                + "FROM fin_cash_payment "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_cash_payment.currencyCode "
                + "INNER JOIN mst_cash_account ON mst_cash_account.code = fin_cash_payment.cashaccountCode "    
//                + "INNER JOIN fin_giro_payment ON fin_giro_payment.code = fin_cash_payment.giroPaymentNo "    
                + "WHERE fin_cash_payment.code LIKE :prmCode "
                + "AND DATE(fin_cash_payment.TransactionDate) BETWEEN :prmFirstDate AND :prmLastDate "
                + "AND fin_cash_payment.RefNo LIKE :prmRefNo " 
                + "AND fin_cash_payment.Remark LIKE :prmRemark " 
                + "ORDER BY fin_cash_payment.TransactionDate DESC ")  
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("transactionType", Hibernate.STRING)
                    .addScalar("paymentTo", Hibernate.STRING)   
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("cashAccountCode", Hibernate.STRING)
                    .addScalar("cashAccountName", Hibernate.STRING)
//                    .addScalar("giroPaymentCode", Hibernate.STRING)    
//                    .addScalar("transferPaymentNo", Hibernate.STRING)    
//                    .addScalar("transferPaymentDate", Hibernate.TIMESTAMP) 
//                    .addScalar("transferCashName", Hibernate.STRING)    
                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                .setParameter("prmCode", "%"+cashPaymentTemp.getCode()+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)
                .setParameter("prmRefNo", "%"+cashPaymentTemp.getRefNo()+"%")
                .setParameter("prmRemark", "%"+cashPaymentTemp.getRemark()+"%")
                .setFirstResult(from)
                .setMaxResults(to)
                .setResultTransformer(Transformers.aliasToBean(CashPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<CashPaymentTemp> findDataAccSpv(String cashCode, String cashPaymentTo, Date cashFirstDate, Date cashLastDate, int from, int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(cashFirstDate);
            String dateLast = DATE_FORMAT.format(cashLastDate);
                   
            List<CashPaymentTemp> list = (List<CashPaymentTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "fin_cash_payment.code, "
                + "fin_cash_payment.branchCode, "
                + "fin_cash_payment.transactionDate, "
                + "fin_cash_payment.transactionType, "
                + "fin_cash_payment.paymentTo, "
                + "fin_cash_payment.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_cash_payment.exchangeRate, "
                + "fin_cash_payment.cashAccountCode, "
                + "mst_cash_account.name AS cashAccountName, "
                + "fin_cash_payment.totalTransactionAmount, "
                + "fin_cash_payment.refNo, "
                + "fin_cash_payment.remark "
                + "FROM fin_cash_payment "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_cash_payment.currencyCode "
                + "INNER JOIN mst_cash_account ON mst_cash_account.code = fin_cash_payment.cashaccountCode "    
                + "WHERE fin_cash_payment.code LIKE '%"+cashCode+"%' "
                + "AND fin_cash_payment.PaymentTo LIKE '%"+cashPaymentTo+"%' " 
                + "AND DATE(fin_cash_payment.TransactionDate) BETWEEN DATE '"+dateFirst+"' AND DATE '"+dateLast+"' "
                + "ORDER BY fin_cash_payment.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("transactionType", Hibernate.STRING)
                    .addScalar("paymentTo", Hibernate.STRING)   
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("cashAccountCode", Hibernate.STRING)
                    .addScalar("cashAccountName", Hibernate.STRING)
                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(CashPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
        public int countDataAccSpv(String cashCode, String cashPaymentTo, Date cashFirstDate, Date cashLastDate){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(cashFirstDate);
            String dateLast = DATE_FORMAT.format(cashLastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                        "SELECT COUNT(*) FROM fin_cash_payment "
                        + "INNER JOIN mst_currency ON mst_currency.code = fin_cash_payment.currencycode "
                        + "INNER JOIN mst_cash_account ON mst_cash_account.code = fin_cash_payment.cashAccountCode "   
                        + "WHERE fin_cash_payment.code LIKE '%"+cashCode+"%' "
                        + "AND fin_cash_payment.PaymentTo LIKE '%"+cashPaymentTo+"%' " 
                        + "AND DATE(fin_cash_payment.TransactionDate) BETWEEN DATE '"+dateFirst+"' AND DATE '"+dateLast+"' "
                    )
              
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
     }
    //Find Payment Request
    public List<CashPaymentPaymentRequestTemp> findDataCashPaymentRequest(String headerCode) {
        try {
            
            List<CashPaymentPaymentRequestTemp> list = (List<CashPaymentPaymentRequestTemp>)hbmSession.hSession.createSQLQuery(
              "SELECT " 
                + "fin_cash_payment_jn_payment_request.code, "
                + "fin_cash_payment_jn_payment_request.HeaderCode, "
                + "fin_cash_payment_jn_payment_request.paymentRequestCode, "
                + "fin_payment_request.transactionDate AS paymentRequestTransactionDate, "
                + "fin_payment_request.transactionType AS paymentRequestTransactionType, "
                + "fin_payment_request.currencyCode AS paymentRequestCurrencyCode, "
                + "mst_currency.name AS paymentRequestCurrencyName, "
                + "fin_payment_request.totalTransactionAmount AS paymentRequestTotalTransactionAmount, "
                + "fin_payment_request.refNo AS paymentRequestRefNo, "
                + "fin_payment_request.remark AS paymentRequestRemark "
                + "FROM fin_cash_payment_jn_payment_request "
                + "INNER JOIN fin_payment_request ON fin_payment_request.code = fin_cash_payment_jn_payment_request.paymentRequestCode "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_payment_request.currencyCode "
                + "WHERE fin_cash_payment_jn_payment_request.HeaderCode LIKE :prmCode ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("paymentRequestCode", Hibernate.STRING)
                    .addScalar("paymentRequestTransactionDate", Hibernate.TIMESTAMP)
                    .addScalar("paymentRequestTransactionType", Hibernate.STRING)
                    .addScalar("paymentRequestCurrencyCode", Hibernate.STRING)
                    .addScalar("paymentRequestCurrencyName", Hibernate.STRING)
                    .addScalar("paymentRequestTotalTransactionAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("paymentRequestRefNo", Hibernate.STRING)
                    .addScalar("paymentRequestRemark", Hibernate.STRING)
                .setParameter("prmCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CashPaymentPaymentRequestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    //Find Payment Request Detail
    public List<CashPaymentDetailTemp> findDataCashPaymentDetail(String headerCode) {
        try {
            
            
            List<CashPaymentDetailTemp> list = (List<CashPaymentDetailTemp>)hbmSession.hSession.createSQLQuery(
              "CALL usp_fin_cash_payment_detail_get('"+headerCode+"')"
            )
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("documentBranchCode", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("documentAmount", Hibernate.BIG_DECIMAL)
                .addScalar("documentAmountIDR", Hibernate.BIG_DECIMAL)
                .addScalar("documentBalanceAmount", Hibernate.BIG_DECIMAL)
                .addScalar("documentBalanceAmountIDR", Hibernate.BIG_DECIMAL)   
                .addScalar("transactionStatus", Hibernate.STRING)
                .addScalar("debit", Hibernate.BIG_DECIMAL)
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .addScalar("credit", Hibernate.BIG_DECIMAL)
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CashPaymentDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(CashPayment cashPayment, List<CashPaymentDetail> listCashPaymentDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(cashPayment);
            String paymentRequestCode = "";
            hbmSession.hSession.beginTransaction();
            cashPayment.setCode(headerCode);
            cashPayment.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            cashPayment.setCreatedDate(new Date());
                        
            // save header
            hbmSession.hSession.save(cashPayment);

            //save detail
            if(listCashPaymentDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CashPaymentDetail detail : listCashPaymentDetail){
                
                if(!paymentRequestCode.equalsIgnoreCase(detail.getPaymentRequest().getCode())){
                    CashPaymentPaymentRequest payment = new CashPaymentPaymentRequest();
                    String detailRequestCode = headerCode+"/"+detail.getPaymentRequest().getCode();
                    
                    payment.setCode(detailRequestCode);
                    payment.setCashPayment(cashPayment);
                        PaymentRequest p = new PaymentRequest();
                        p.setCode(detail.getPaymentRequest().getCode());
                    payment.setPaymentRequest(p);
                    payment.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    payment.setCreatedDate(new Date());
                    
                    // save Cash Payment Request
                    hbmSession.hSession.save(payment);
                    
                    //set code temp
                    paymentRequestCode = detail.getPaymentRequest().getCode();
                }
                
                String detailCode = headerCode+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(headerCode);
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                
                BigDecimal amountNew;
                Double amount = 0.00;
                
                BigDecimal debitAmount = detail.getDebit();
                BigDecimal creditAmount = detail.getCredit();
                
                amount = debitAmount.doubleValue() + creditAmount.doubleValue();
                amountNew = new BigDecimal(amount);
                    
                hbmSession.hSession.save(detail);
                
                String transactionStatus=detail.getTransactionStatus();
                if(transactionStatus.equals("Transaction")){
                    financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                    financeDocumentDAO.updatePaidAount(detail.getDocumentType(),amountNew,detail.getDocumentNo(),detail.getHeaderCode());
                }
                 
                // save Deposit
                if (cashPayment.getTransactionType().equals("Deposit")) {
                    CashPaymentDeposit cashPaymentDeposit = new CashPaymentDeposit();
                    cashPaymentDeposit.setCode(cashPayment.getCode());
                    cashPaymentDeposit.setBranch(cashPayment.getBranch());
                    cashPaymentDeposit.setTransactionDate(cashPayment.getTransactionDate());
                    cashPaymentDeposit.setCurrency(cashPayment.getCurrency());
                    cashPaymentDeposit.setExchangeRate(cashPayment.getExchangeRate());
                    cashPaymentDeposit.setGrandTotalAmount(cashPayment.getTotalTransactionAmount());
                    cashPaymentDeposit.setRefNo(cashPayment.getRefNo());
                    cashPaymentDeposit.setRemark(cashPayment.getRemark());
                    cashPaymentDeposit.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    cashPaymentDeposit.setCreatedDate(new Date());
                    hbmSession.hSession.save(cashPaymentDeposit);
                }
                i++;
            }
            
            // save forex amount
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery("INSERT INTO fin_cash_payment_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
                                               "VALUES ('" + headerCode + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
 
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    cashPayment.getCode(), ""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(CashPayment cashPayment, List<CashPaymentDetail> listCashPaymentDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //ambil giro yg lama
            String oldGiroCode = (String)hbmSession.hSession.createSQLQuery(
                    "SELECT fin_cash_payment.GiroReceivedCode FROM fin_cash_payment "
                    + "WHERE fin_cash_payment.code = '" + cashPayment.getCode() + "'"
            ).uniqueResult();
            
            //balikin giro yg lama
            if (oldGiroCode != "") {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Pending' "
                        + "WHERE fin_giro_received.Code = '" + oldGiroCode + "'")
                .executeUpdate();
            }
            
            //ambil detail yg lama
            List<CashPaymentDetailTemp> listOldDetail = (List<CashPaymentDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_cash_payment_detail.documentType, "
                    + "fin_cash_payment_detail.documentNo, "
                    + "fin_cash_payment_detail.creditIDR, "
                    + "fin_cash_payment_detail.debitIDR "
                    + "FROM fin_cash_payment_detail "
                    + "WHERE fin_cash_payment_detail.HeaderCode='" + cashPayment.getCode() + "' "
                    + "AND fin_cash_payment_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CashPaymentDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(CashPaymentDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCreditIDR().add(detailEmpty.getDebitIDR());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //Ambil data deposit
//            CashPaymentDepositTemp cashPaymentDepositTemp=getCashPaymentDeposit(cashPayment.getCode());
            
             //delete Deposit payment
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_payment_deposit WHERE code = '" + cashPayment.getCode() + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_payment_forex_gain_loss WHERE code = '" + cashPayment.getCode() + "'")
                    .executeUpdate();
            
            //delete detail cash receive
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_payment_detail WHERE HeaderCode = '" + cashPayment.getCode() + "'")
                    .executeUpdate();
            
            //update header
            cashPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            cashPayment.setUpdatedDate(new Date());
            hbmSession.hSession.update(cashPayment);

            // insert detail
            if(listCashPaymentDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CashPaymentDetail detail : listCashPaymentDetail){
                                                            
                String detailCode = cashPayment.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(cashPayment.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                
                BigDecimal amountNew;
                Double amount = 0.00;
                
                BigDecimal debitAmount = detail.getDebit();
                BigDecimal creditAmount = detail.getCredit();
                
                amount = debitAmount.doubleValue() + creditAmount.doubleValue();
                amountNew = new BigDecimal(amount);
                    
                hbmSession.hSession.save(detail);
                
                String transactionStatus=detail.getTransactionStatus();
                if(transactionStatus.equals("Transaction")){
                    financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                    financeDocumentDAO.updatePaidAount(detail.getDocumentType(),amountNew,detail.getDocumentNo(),detail.getHeaderCode());
                }
                
                // save Deposit
                if (cashPayment.getTransactionType().equals("Deposit")) {
                    if(transactionStatus.equals("Other")){
                        CashPaymentDeposit cashPaymentDeposit = new CashPaymentDeposit();
                        cashPaymentDeposit.setCode(cashPayment.getCode());
                        cashPaymentDeposit.setBranch(cashPayment.getBranch());
                        cashPaymentDeposit.setTransactionDate(cashPayment.getTransactionDate());
                        cashPaymentDeposit.setCurrency(cashPayment.getCurrency());
                        cashPaymentDeposit.setExchangeRate(cashPayment.getExchangeRate());
//                        cashPaymentDeposit.setCustomer(cashPayment.getCustomer());
//                        cashPaymentDeposit.setRefNo(cashPaymentDepositTemp.getRefNo());
//                        cashPaymentDeposit.setRemark(cashPaymentDepositTemp.getRemark());
                        cashPaymentDeposit.setRefNo(cashPayment.getRefNo());
                        cashPaymentDeposit.setRemark(cashPayment.getRemark());
                        cashPaymentDeposit.setGrandTotalAmount(cashPayment.getTotalTransactionAmount());
                        cashPaymentDeposit.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        cashPaymentDeposit.setUpdatedDate(new Date());
                        cashPaymentDeposit.setCreatedBy(cashPayment.getCreatedBy());
                        cashPaymentDeposit.setCreatedDate(cashPayment.getCreatedDate());
                    
                        hbmSession.hSession.save(cashPaymentDeposit);
                    }
                }
                i++;
            }
            
            hbmSession.hSession.flush();
            
            //insert forex
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery("INSERT INTO fin_cash_payment_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
                                               "VALUES ('" + cashPayment.getCode() + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    cashPayment.getCode(), ""));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String headerCode, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //ambil giro yg lama
            String oldGiroCode = (String)hbmSession.hSession.createSQLQuery(
                    "SELECT fin_cash_payment.GiroReceivedCode FROM fin_cash_payment "
                    + "WHERE fin_cash_payment.code = '" + headerCode + "'"
            ).uniqueResult();
            
            //balikin giro yg lama
            if (oldGiroCode != "") {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Pending' "
                        + "WHERE fin_giro_received.Code = '" + oldGiroCode + "'")
                .executeUpdate();
            }
            
            //ambil detail yg lama
            List<CashPaymentDetailTemp> listOldDetail = (List<CashPaymentDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_cash_payment_detail.documentType, "
                    + "fin_cash_payment_detail.documentNo, "
                    + "fin_cash_payment_detail.creditIDR, "
                    + "fin_cash_payment_detail.debitIDR "
                    + "FROM fin_cash_payment_detail "
                    + "WHERE fin_cash_payment_detail.HeaderCode='" + headerCode + "' "
                    + "AND fin_cash_payment_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CashPaymentDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(CashPaymentDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCreditIDR().add(detailEmpty.getDebitIDR());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //delete deposit
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_payment_deposit WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_payment_forex_gain_loss WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete detail cash received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_payment_detail WHERE HeaderCode = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete header cash received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_payment WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    headerCode, ""));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private String createCode(CashPayment cashPayment){
        try{
//            String tempKode = EnumTransactionType.ENUM_TransactionType.BBM.toString();
//            if(cashPayment.getTransactionType().equals("Deposit")){
//                tempKode = EnumTransactionType.ENUM_TransactionType.CDPBBM.toString();
//            }
            String tempKode = "";
            if(cashPayment.getTransactionType().equals("Deposit")){
                tempKode = "CDP";
            }
            String acronim = cashPayment.getBranch().getCode()+"/"+cashPayment.getCashAccount().getBkkVoucherNo()+tempKode+AutoNumber.formatingDate(cashPayment.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(CashPayment.class)
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
    
    public void updateAccSpv(CashPayment cashPayment, List<CashPaymentDetail> listCashPaymentDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //update header
            cashPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            cashPayment.setUpdatedDate(new Date());
            hbmSession.hSession.update(cashPayment);
            hbmSession.hSession.flush();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    cashPayment.getCode(), ""));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
}
