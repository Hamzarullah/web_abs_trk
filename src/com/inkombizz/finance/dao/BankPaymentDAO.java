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
import com.inkombizz.finance.model.BankPayment;
import com.inkombizz.finance.model.BankPaymentDeposit;
import com.inkombizz.finance.model.BankPaymentDetail;
import com.inkombizz.finance.model.BankPaymentDetailTemp;
import com.inkombizz.finance.model.BankPaymentPaymentRequest;
import com.inkombizz.finance.model.BankPaymentPaymentRequestTemp;
import com.inkombizz.finance.model.BankPaymentTemp;
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

public class BankPaymentDAO {
    private HBMSession hbmSession;
    
    private FinanceDocumentDAO financeDocumentDAO;
    public BankPaymentDAO(HBMSession session) {
        this.hbmSession = session;
    }
    //Count Header
    public int countData(BankPaymentTemp bankPaymentTemp){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(bankPaymentTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(bankPaymentTemp.getLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                        "SELECT COUNT(*) FROM fin_bank_payment "
                        + "INNER JOIN mst_currency ON mst_currency.code = fin_bank_payment.currencycode "
                        + "INNER JOIN mst_bank_account ON mst_bank_account.code = fin_bank_payment.bankaccountCode "   
                        + "WHERE fin_bank_payment.code LIKE :prmCode "
                        + "AND DATE(fin_bank_payment.TransactionDate) BETWEEN :prmFirstDate AND :prmLastDate "
                        + "AND fin_bank_payment.RefNo LIKE :prmRefNo " 
                        + "AND fin_bank_payment.Remark LIKE :prmRemark " 
                    )
                    .setParameter("prmCode", "%"+bankPaymentTemp.getCode()+"%")
                    .setParameter("prmFirstDate", dateFirst)
                    .setParameter("prmLastDate", dateLast)
                    .setParameter("prmRefNo", "%"+bankPaymentTemp.getRefNo()+"%")
                    .setParameter("prmRemark", "%"+bankPaymentTemp.getRemark()+"%")
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
    public List<BankPaymentTemp> findData(BankPaymentTemp bankPaymentTemp, int from, int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(bankPaymentTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(bankPaymentTemp.getLastDate());
            
                        
            List<BankPaymentTemp> list = (List<BankPaymentTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "fin_bank_payment.code, "
                + "fin_bank_payment.branchCode, "
                + "fin_bank_payment.transactionDate, "
                + "fin_bank_payment.transactionType, "
                + "fin_bank_payment.paymentTo, "
                + "fin_bank_payment.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_bank_payment.exchangeRate, "
                + "fin_bank_payment.bankAccountCode, "
                + "mst_bank_account.name AS bankAccountName, "
                + "fin_bank_payment.giroPaymentNo AS giroPaymentCode, "
//                + "fin_giro_payment.giroNo AS giroPaymentNo, "
                + "fin_bank_payment.transferPaymentNo, "
                + "fin_bank_payment.transferPaymentDate, "
                + "fin_bank_payment.transferBankName, "
                + "fin_bank_payment.totalTransactionAmount, "
                + "fin_bank_payment.refNo, "
                + "fin_bank_payment.remark "
                + "FROM fin_bank_payment "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_bank_payment.currencyCode "
                + "INNER JOIN mst_bank_account ON mst_bank_account.code = fin_bank_payment.bankaccountCode "    
//                + "INNER JOIN fin_giro_payment ON fin_giro_payment.code = fin_bank_payment.giroPaymentNo "    
                + "WHERE fin_bank_payment.code LIKE :prmCode "
                + "AND DATE(fin_bank_payment.TransactionDate) BETWEEN :prmFirstDate AND :prmLastDate "
                + "AND fin_bank_payment.RefNo LIKE :prmRefNo " 
                + "AND fin_bank_payment.Remark LIKE :prmRemark " 
                + "ORDER BY fin_bank_payment.TransactionDate DESC ")  
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("transactionType", Hibernate.STRING)
                    .addScalar("paymentTo", Hibernate.STRING)   
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("bankAccountCode", Hibernate.STRING)
                    .addScalar("bankAccountName", Hibernate.STRING)
                    .addScalar("giroPaymentCode", Hibernate.STRING)    
                    .addScalar("transferPaymentNo", Hibernate.STRING)    
                    .addScalar("transferPaymentDate", Hibernate.TIMESTAMP) 
                    .addScalar("transferBankName", Hibernate.STRING)    
                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                .setParameter("prmCode", "%"+bankPaymentTemp.getCode()+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)
                .setParameter("prmRefNo", "%"+bankPaymentTemp.getRefNo()+"%")
                .setParameter("prmRemark", "%"+bankPaymentTemp.getRemark()+"%")
                .setFirstResult(from)
                .setMaxResults(to)
                .setResultTransformer(Transformers.aliasToBean(BankPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    //Find Payment Request
    public List<BankPaymentPaymentRequestTemp> findDataBankPaymentRequest(String headerCode) {
        try {
            
            List<BankPaymentPaymentRequestTemp> list = (List<BankPaymentPaymentRequestTemp>)hbmSession.hSession.createSQLQuery(
              "SELECT " 
                + "fin_bank_payment_jn_payment_request.code, "
                + "fin_bank_payment_jn_payment_request.headerCode, "
                + "fin_bank_payment_jn_payment_request.paymentRequestCode, "
                + "fin_payment_request.transactionDate AS paymentRequestTransactionDate, "
                + "fin_payment_request.transactionType AS paymentRequestTransactionType, "
                + "fin_payment_request.currencyCode AS paymentRequestCurrencyCode, "
                + "mst_currency.name AS paymentRequestCurrencyName, "
                + "fin_payment_request.totalTransactionAmount AS paymentRequestTotalTransactionAmount, "
                + "fin_payment_request.refNo AS paymentRequestRefNo, "
                + "fin_payment_request.remark AS paymentRequestRemark "
                + "FROM fin_bank_payment_jn_payment_request "
                + "INNER JOIN fin_payment_request ON fin_payment_request.code = fin_bank_payment_jn_payment_request.paymentRequestCode "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_payment_request.currencyCode "
                + "WHERE fin_bank_payment_jn_payment_request.headerCode LIKE '%"+headerCode+"%' ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("paymentRequestCode", Hibernate.STRING)
                    .addScalar("paymentRequestTransactionDate", Hibernate.TIMESTAMP)
                    .addScalar("paymentRequestTransactionType", Hibernate.STRING)
                    .addScalar("paymentRequestCurrencyCode", Hibernate.STRING)
                    .addScalar("paymentRequestCurrencyName", Hibernate.STRING)
                    .addScalar("paymentRequestTotalTransactionAmount", Hibernate.BIG_DECIMAL)
                    .addScalar("paymentRequestRefNo", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BankPaymentPaymentRequestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    //Find Payment Request Detail
    public List<BankPaymentDetailTemp> findDataBankPaymentDetail(String headerCode) {
        try {
            
            
            List<BankPaymentDetailTemp> list = (List<BankPaymentDetailTemp>)hbmSession.hSession.createSQLQuery(
              "CALL usp_fin_bank_payment_detail_get('"+headerCode+"')"
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
                .setResultTransformer(Transformers.aliasToBean(BankPaymentDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(BankPayment bankPayment, List<BankPaymentDetail> listBankPaymentDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(bankPayment);
            String paymentRequestCode = "";
            hbmSession.hSession.beginTransaction();
            bankPayment.setCode(headerCode);
            bankPayment.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            bankPayment.setCreatedDate(new Date());
                        
            // save header
            hbmSession.hSession.save(bankPayment);

            //save detail
            if(listBankPaymentDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(BankPaymentDetail detail : listBankPaymentDetail){
                
                if(!paymentRequestCode.equalsIgnoreCase(detail.getPaymentRequest().getCode())){
                    BankPaymentPaymentRequest payment = new BankPaymentPaymentRequest();
                    String detailRequestCode = headerCode+"/"+detail.getPaymentRequest().getCode();
                    
                    payment.setCode(detailRequestCode);
                    payment.setBankPayment(bankPayment);
                        PaymentRequest p = new PaymentRequest();
                        p.setCode(detail.getPaymentRequest().getCode());
                    payment.setPaymentRequest(p);
                    payment.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    payment.setCreatedDate(new Date());
                    
                    // save Bank Payment Request
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
                if (bankPayment.getTransactionType().equals("Deposit")) {
                    BankPaymentDeposit bankPaymentDeposit = new BankPaymentDeposit();
                    bankPaymentDeposit.setCode(bankPayment.getCode());
                    bankPaymentDeposit.setBranch(bankPayment.getBranch());
                    bankPaymentDeposit.setTransactionDate(bankPayment.getTransactionDate());
                    bankPaymentDeposit.setCurrency(bankPayment.getCurrency());
                    bankPaymentDeposit.setExchangeRate(bankPayment.getExchangeRate());
                    bankPaymentDeposit.setGrandTotalAmount(bankPayment.getTotalTransactionAmount());
                    bankPaymentDeposit.setRefNo(bankPayment.getRefNo());
                    bankPaymentDeposit.setRemark(bankPayment.getRemark());
                    bankPaymentDeposit.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    bankPaymentDeposit.setCreatedDate(new Date());
                    hbmSession.hSession.save(bankPaymentDeposit);
                }
                i++;
            }
            
            //apabila giro, update statusnya
            if (!bankPayment.getGiroPayment().getCode().isEmpty()) {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_payment SET fin_giro_payment.GiroStatus = 'Cleared' "
                        + "WHERE fin_giro_payment.Code = '" + bankPayment.getGiroPayment().getCode() + "'")
                .executeUpdate();
            }
            
            // save forex amount
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery("INSERT INTO fin_bank_payment_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
                                               "VALUES ('" + headerCode + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
 
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    bankPayment.getCode(), ""));
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
    
    public void update(BankPayment bankPayment, List<BankPaymentDetail> listBankPaymentDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //ambil giro yg lama
            String oldGiroCode = (String)hbmSession.hSession.createSQLQuery(
                    "SELECT fin_bank_payment.GiroReceivedCode FROM fin_bank_payment "
                    + "WHERE fin_bank_payment.code = '" + bankPayment.getCode() + "'"
            ).uniqueResult();
            
            //balikin giro yg lama
            if (oldGiroCode != "") {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Pending' "
                        + "WHERE fin_giro_received.Code = '" + oldGiroCode + "'")
                .executeUpdate();
            }
            
            //ambil detail yg lama
            List<BankPaymentDetailTemp> listOldDetail = (List<BankPaymentDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_bank_payment_detail.documentType, "
                    + "fin_bank_payment_detail.documentNo, "
                    + "fin_bank_payment_detail.creditIDR, "
                    + "fin_bank_payment_detail.debitIDR "
                    + "FROM fin_bank_payment_detail "
                    + "WHERE fin_bank_payment_detail.HeaderCode='" + bankPayment.getCode() + "' "
                    + "AND fin_bank_payment_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(BankPaymentDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(BankPaymentDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCreditIDR().add(detailEmpty.getDebitIDR());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //Ambil data deposit
//            BankPaymentDepositTemp bankPaymentDepositTemp=getBankPaymentDeposit(bankPayment.getCode());
            
             //delete Deposit payment
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_payment_deposit WHERE code = '" + bankPayment.getCode() + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_payment_forex_gain_loss WHERE code = '" + bankPayment.getCode() + "'")
                    .executeUpdate();
            
            //delete detail bank receive
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_payment_detail WHERE HeaderCode = '" + bankPayment.getCode() + "'")
                    .executeUpdate();
            
            //update header
            bankPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            bankPayment.setUpdatedDate(new Date());
            hbmSession.hSession.update(bankPayment);

            // insert detail
            if(listBankPaymentDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(BankPaymentDetail detail : listBankPaymentDetail){
                                                            
                String detailCode = bankPayment.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(bankPayment.getCode());
                                    
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
                if (bankPayment.getTransactionType().equals("Deposit")) {
                    if(transactionStatus.equals("Other")){
                        BankPaymentDeposit bankPaymentDeposit = new BankPaymentDeposit();
                        bankPaymentDeposit.setCode(bankPayment.getCode());
                        bankPaymentDeposit.setBranch(bankPayment.getBranch());
                        bankPaymentDeposit.setTransactionDate(bankPayment.getTransactionDate());
                        bankPaymentDeposit.setCurrency(bankPayment.getCurrency());
                        bankPaymentDeposit.setExchangeRate(bankPayment.getExchangeRate());
//                        bankPaymentDeposit.setCustomer(bankPayment.getCustomer());
//                        bankPaymentDeposit.setRefNo(bankPaymentDepositTemp.getRefNo());
//                        bankPaymentDeposit.setRemark(bankPaymentDepositTemp.getRemark());
                        bankPaymentDeposit.setRefNo(bankPayment.getRefNo());
                        bankPaymentDeposit.setRemark(bankPayment.getRemark());
                        bankPaymentDeposit.setGrandTotalAmount(bankPayment.getTotalTransactionAmount());
                        bankPaymentDeposit.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        bankPaymentDeposit.setUpdatedDate(new Date());
                        bankPaymentDeposit.setCreatedBy(bankPayment.getCreatedBy());
                        bankPaymentDeposit.setCreatedDate(bankPayment.getCreatedDate());
                    
                        hbmSession.hSession.save(bankPaymentDeposit);
                    }
                }
                i++;
            }
            
            hbmSession.hSession.flush();
            
            //apabila giro, update statusnya
            if (!bankPayment.getGiroPayment().getCode().isEmpty()) {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Cleared' "
                        + "WHERE fin_giro_received.Code = '" + bankPayment.getGiroPayment().getCode() + "'")
                .executeUpdate();
            }
            
            //insert forex
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery("INSERT INTO fin_bank_payment_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
                                               "VALUES ('" + bankPayment.getCode() + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    bankPayment.getCode(), ""));
            
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
                    "SELECT fin_bank_payment.GiroReceivedCode FROM fin_bank_payment "
                    + "WHERE fin_bank_payment.code = '" + headerCode + "'"
            ).uniqueResult();
            
            //balikin giro yg lama
            if (oldGiroCode != "") {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Pending' "
                        + "WHERE fin_giro_received.Code = '" + oldGiroCode + "'")
                .executeUpdate();
            }
            
            //ambil detail yg lama
            List<BankPaymentDetailTemp> listOldDetail = (List<BankPaymentDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_bank_payment_detail.documentType, "
                    + "fin_bank_payment_detail.documentNo, "
                    + "fin_bank_payment_detail.creditIDR, "
                    + "fin_bank_payment_detail.debitIDR "
                    + "FROM fin_bank_payment_detail "
                    + "WHERE fin_bank_payment_detail.HeaderCode='" + headerCode + "' "
                    + "AND fin_bank_payment_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(BankPaymentDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(BankPaymentDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCreditIDR().add(detailEmpty.getDebitIDR());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //delete deposit
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_payment_deposit WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_payment_forex_gain_loss WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete detail bank received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_payment_detail WHERE HeaderCode = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete header bank received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_payment WHERE code = '" + headerCode + "'")
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
    
    private String createCode(BankPayment bankPayment){
        try{
//            String tempKode = EnumTransactionType.ENUM_TransactionType.BBM.toString();
//            if(bankPayment.getTransactionType().equals("Deposit")){
//                tempKode = EnumTransactionType.ENUM_TransactionType.CDPBBM.toString();
//            }
            String tempKode = "";
            if(bankPayment.getTransactionType().equals("Deposit")){
                tempKode = "CDP";
            }
            String acronim = bankPayment.getBranch().getCode()+"/"+bankPayment.getBankAccount().getBbkVoucherNo()+tempKode+AutoNumber.formatingDate(bankPayment.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(BankPayment.class)
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
        public int countDataAccSpv(String bankCode, String bankPaymentTo, String bankAccStatus, Date bankFirstDate, Date bankLastDate){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(bankFirstDate);
            String dateLast = DATE_FORMAT.format(bankLastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                        "SELECT COUNT(*) FROM fin_bank_payment "
                        + "INNER JOIN mst_currency ON mst_currency.code = fin_bank_payment.currencycode "
                        + "INNER JOIN mst_bank_account ON mst_bank_account.code = fin_bank_payment.bankaccountCode "   
                        + "WHERE fin_bank_payment.code LIKE :prmCode "
                        + "AND fin_bank_payment.PaymentTo LIKE :prmPaymentTo " 
                        + "AND fin_bank_payment.AccStatus LIKE :prmAccStatus " 
                        + "AND DATE(fin_bank_payment.TransactionDate) BETWEEN :prmFirstDate AND :prmLastDate "
                    )
                    .setParameter("prmCode", "%"+bankCode+"%")
                    .setParameter("prmPaymentTo", "%"+bankPaymentTo+"%")
                    .setParameter("prmAccStatus", "%"+bankAccStatus+"%")
                    .setParameter("prmFirstDate", dateFirst)
                    .setParameter("prmLastDate", dateLast)
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
   
    public List<BankPaymentTemp> findDataAccSpv(String bankCode, String bankPaymentTo, String bankAccStatus, Date bankFirstDate, Date bankLastDate, int from, int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(bankFirstDate);
            String dateLast = DATE_FORMAT.format(bankLastDate);
            
                        
            List<BankPaymentTemp> list = (List<BankPaymentTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "fin_bank_payment.code, "
                + "fin_bank_payment.accStatus, "
                + "fin_bank_payment.branchCode, "
                + "fin_bank_payment.transactionDate, "
                + "fin_bank_payment.transactionType, "
                + "fin_bank_payment.paymentTo, "
                + "fin_bank_payment.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_bank_payment.exchangeRate, "
                + "fin_bank_payment.bankAccountCode, "
                + "mst_bank_account.name AS bankAccountName, "
                + "fin_bank_payment.giroPaymentNo AS giroPaymentCode, "
//                + "fin_giro_payment.giroNo AS giroPaymentNo, "
                + "fin_bank_payment.transferPaymentNo, "
                + "fin_bank_payment.transferPaymentDate, "
                + "fin_bank_payment.transferBankName, "
                + "fin_bank_payment.totalTransactionAmount, "
                + "fin_bank_payment.refNo, "
                + "fin_bank_payment.remark "
                + "FROM fin_bank_payment "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_bank_payment.currencyCode "
                + "INNER JOIN mst_bank_account ON mst_bank_account.code = fin_bank_payment.bankaccountCode "    
//                + "INNER JOIN fin_giro_payment ON fin_giro_payment.code = fin_bank_payment.giroPaymentNo "    
                + "WHERE fin_bank_payment.code LIKE :prmCode "
                + "AND fin_bank_payment.PaymentTo LIKE :prmPaymentTo " 
                + "AND fin_bank_payment.AccStatus LIKE :prmAccStatus " 
                + "AND DATE(fin_bank_payment.TransactionDate) BETWEEN DATE :prmFirstDate AND DATE :prmLastDate "
                     + "ORDER BY fin_bank_payment.TransactionDate DESC ")  
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("accStatus", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("transactionType", Hibernate.STRING)
                    .addScalar("paymentTo", Hibernate.STRING)   
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                    .addScalar("bankAccountCode", Hibernate.STRING)
                    .addScalar("bankAccountName", Hibernate.STRING)
                    .addScalar("giroPaymentCode", Hibernate.STRING)    
                    .addScalar("transferPaymentNo", Hibernate.STRING)    
                    .addScalar("transferPaymentDate", Hibernate.TIMESTAMP) 
                    .addScalar("transferBankName", Hibernate.STRING)    
                    .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setParameter("prmCode", "%"+bankCode+"%")
                    .setParameter("prmPaymentTo", "%"+bankPaymentTo+"%")
                    .setParameter("prmAccStatus", "%"+bankAccStatus+"%")
                    .setParameter("prmFirstDate", dateFirst)
                    .setParameter("prmLastDate", dateLast)
                .setFirstResult(from)
                .setMaxResults(to)
                .setResultTransformer(Transformers.aliasToBean(BankPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
     
    
    public void updateAccSpv(BankPayment bankPayment, List<BankPaymentDetail> listBankPaymentDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            //update header
            bankPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            bankPayment.setUpdatedDate(new Date());
            hbmSession.hSession.update(bankPayment);
            hbmSession.hSession.flush();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    bankPayment.getCode(), ""));
            
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
