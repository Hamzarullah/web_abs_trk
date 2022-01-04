
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
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

import com.inkombizz.finance.model.BankReceived;
import com.inkombizz.finance.model.BankReceivedDetail;
import com.inkombizz.finance.model.BankReceivedDetailTemp;
import com.inkombizz.finance.model.BankReceivedDeposit;
import com.inkombizz.finance.model.BankReceivedDepositTemp;
import com.inkombizz.finance.model.BankReceivedField;
import com.inkombizz.finance.model.BankReceivedTemp;
import com.inkombizz.system.dao.TransactionLogDAO;

public class BankReceivedDAO {
    private HBMSession hbmSession;
    
    private FinanceDocumentDAO financeDocumentDAO;
        
    public BankReceivedDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String userCodeTemp,String code, String receivedFrom,String bankAccountCode,String bankAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark,Date firstDate, Date lastDate){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(fin_bank_received.Code) "
                + "FROM fin_bank_received "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_bank_received.currencycode "
                + "INNER JOIN mst_bank_account ON mst_bank_account.code = fin_bank_received.bankaccountCode "   
                + "WHERE fin_bank_received.code LIKE '%"+code+"%' "
                + "AND fin_bank_received.ReceivedFrom LIKE '%"+receivedFrom+"%' "
                + "AND fin_bank_received.BankAccountCode LIKE '%"+bankAccountCode+"%' "
                + "AND mst_bank_account.Name LIKE '%"+bankAccountName+"%' "
                + "AND fin_bank_received.TotalTransactionAmount BETWEEN "+firstTotalTransactionAmount+" AND "+lastTotalTransactionAmount+" "
                + "AND fin_bank_received.Remark LIKE '%"+remark+"%' " 
                + "AND DATE(fin_bank_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
   
    public int countDataDeposit(String code, Date firstDate, Date lastDate){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                        "SELECT COUNT(*) "
                + "FROM fin_bank_received_deposit "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_bank_received_deposit.currencyCode "
                + "LEFT JOIN mst_customer ON fin_bank_received_deposit.CustomerCode=mst_customer.Code "
                + "WHERE fin_bank_received_deposit.code LIKE '%"+code+"%' "
                + "AND DATE(fin_bank_received_deposit.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
            ).uniqueResult();
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
    
    public List<BankReceivedTemp> findData(String userCodeTemp,String code,String receivedFrom,String bankAccountCode,String bankAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark,Date firstDate, Date lastDate,int from,int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<BankReceivedTemp> list = (List<BankReceivedTemp>)hbmSession.hSession.createSQLQuery(
                "select " 
                + "fin_bank_received.code, "
                + "fin_bank_received.branchCode, "
                + "fin_bank_received.transactionDate, "
                + "fin_bank_received.currencyCode, "
                + "mst_currency.name as currencyName, "
                + "fin_bank_received.exchangeRate, "
                + "fin_bank_received.bankAccountCode, "
                + "mst_bank_account.name as bankAccountName, "
                + "fin_bank_received.receivedFrom, "
                + "fin_bank_received.ReceivedType, "
                + "fin_bank_received.transferReceivedNo, "
                + "fin_bank_received.transferReceivedDate, "
                + "fin_bank_received.transferBankName, "
                + "fin_bank_received.transactionType, "
                + "fin_bank_received.GiroReceivedCode, "
                + "fin_bank_received.totalTransactionAmount, "
                + "fin_bank_received.refNo, "
                + "fin_bank_received.remark "
                + "from fin_bank_received "
                + "INNER JOIN mst_currency ON mst_currency.code = fin_bank_received.currencycode "
                + "INNER JOIN mst_bank_account ON mst_bank_account.code = fin_bank_received.bankaccountCode " 
                + "WHERE fin_bank_received.code LIKE '%"+code+"%' "
                + "AND fin_bank_received.ReceivedFrom LIKE '%"+receivedFrom+"%' "
                + "AND fin_bank_received.BankAccountCode LIKE '%"+bankAccountCode+"%' "
                + "AND mst_bank_account.Name LIKE '%"+bankAccountName+"%' "
                + "AND fin_bank_received.TotalTransactionAmount BETWEEN "+firstTotalTransactionAmount+" AND "+lastTotalTransactionAmount+" "
                + "AND fin_bank_received.Remark LIKE '%"+remark+"%' " 
                + "AND DATE(fin_bank_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_bank_received.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("bankAccountCode", Hibernate.STRING)
                .addScalar("bankAccountName", Hibernate.STRING)
                .addScalar("receivedFrom", Hibernate.STRING)
                .addScalar("receivedType", Hibernate.STRING)   
                .addScalar("transferReceivedNo", Hibernate.STRING)    
                .addScalar("transferReceivedDate", Hibernate.TIMESTAMP) 
                .addScalar("transferBankName", Hibernate.STRING)    
                .addScalar("giroReceivedCode", Hibernate.STRING)    
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BankReceivedTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BankReceivedDepositTemp> findDataDeposit(String code,Date firstDate, Date lastDate, int from,int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<BankReceivedDepositTemp> list = (List<BankReceivedDepositTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_bank_received_deposit.code, "
                + "fin_bank_received_deposit.transactionDate, "
                + "fin_bank_received_deposit.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_bank_received_deposit.exchangeRate, "
                + "fin_bank_received_deposit.CustomerCode, "
                + "IFNULL(mst_customer.Name,'') AS CustomerName, "
                + "fin_bank_received_deposit.GrandTotalAmount, "
                + "fin_bank_received_deposit.refNo, "
                + "fin_bank_received_deposit.remark "
                + "FROM fin_bank_received_deposit "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_bank_received_deposit.currencyCode "
                + "LEFT JOIN mst_customer ON fin_bank_received_deposit.CustomerCode=mst_customer.Code "
                + "WHERE fin_bank_received_deposit.code LIKE '%"+code+"%' "
                + "AND DATE(fin_bank_received_deposit.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_bank_received_deposit.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BankReceivedDepositTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BankReceivedDetailTemp> findDataDetail(String headerCode) {
        try {
            
            List<BankReceivedDetailTemp> list = (List<BankReceivedDetailTemp>)hbmSession.hSession.createSQLQuery(
              "CALL usp_fin_bank_received_detail_get('"+headerCode+"')"
            )
                                            
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
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
                .setResultTransformer(Transformers.aliasToBean(BankReceivedDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    private String createCode(BankReceived bankReceived){
        try{
//            String tempKode = EnumTransactionType.ENUM_TransactionType.BBM.toString();
//            if(bankReceived.getTransactionType().equals("Deposit")){
//                tempKode = EnumTransactionType.ENUM_TransactionType.CDPBBM.toString();
//            }
            String tempKode = "";
            if(bankReceived.getTransactionType().equals("Deposit")){
                tempKode = "CDP";
            }
            String acronim = bankReceived.getBranch().getCode()+"/"+bankReceived.getBankAccount().getBbmVoucherNo() +tempKode+AutoNumber.formatingDate(bankReceived.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(BankReceived.class)
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
    
    public void save(BankReceived bankReceived, List<BankReceivedDetail> listBankReceivedDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(bankReceived);
            
            hbmSession.hSession.beginTransaction();
            bankReceived.setCode(headerCode);
            bankReceived.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            bankReceived.setCreatedDate(new Date());
                        
            // save header
            hbmSession.hSession.save(bankReceived);

            //save detail
            if(listBankReceivedDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(BankReceivedDetail detail : listBankReceivedDetail){
                                                            
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
                if (bankReceived.getTransactionType().equals("Deposit")) {
                    BankReceivedDeposit bankReceivedDeposit = new BankReceivedDeposit();
                    bankReceivedDeposit.setCode(bankReceived.getCode());
                    bankReceivedDeposit.setBranch(bankReceived.getBranch());
                    bankReceivedDeposit.setTransactionDate(bankReceived.getTransactionDate());
                    bankReceivedDeposit.setCurrency(bankReceived.getCurrency());
                    bankReceivedDeposit.setExchangeRate(bankReceived.getExchangeRate());
                    bankReceivedDeposit.setGrandTotalAmount(bankReceived.getTotalTransactionAmount());
                    bankReceivedDeposit.setRefNo(bankReceived.getRefNo());
                    bankReceivedDeposit.setRemark(bankReceived.getRemark());
                    bankReceivedDeposit.setCustomer(null);
                    bankReceivedDeposit.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    bankReceivedDeposit.setCreatedDate(new Date());
                    hbmSession.hSession.save(bankReceivedDeposit);
                }
                i++;
            }
            
            //apabila giro, update statusnya
            if (!bankReceived.getGiroReceived().getCode().isEmpty()) {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Cleared' "
                        + "WHERE fin_giro_received.Code = '" + bankReceived.getGiroReceived().getCode() + "'")
                .executeUpdate();
            }
            
            // save forex amount
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery("INSERT INTO fin_bank_received_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
                                               "VALUES ('" + headerCode + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
 
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    bankReceived.getCode(), ""));
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
     private BankReceivedDepositTemp getBankReceivedDeposit(String code) {
        try {
            
            BankReceivedDepositTemp cashPaymentDepositTemp = (BankReceivedDepositTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_bank_received_deposit.RefNo, "
                + "fin_bank_received_deposit.Remark, "
                + "fin_bank_received_deposit.UpdatedBy, "
                + "fin_bank_received_deposit.UpdatedDate "
                + "FROM fin_bank_received_deposit "
                + "WHERE fin_bank_received_deposit.Code='"+code+"'")
                
                        
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                
                .setResultTransformer(Transformers.aliasToBean(BankReceivedDepositTemp.class))
                .uniqueResult(); 
                 
                return cashPaymentDepositTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
   
    public void update(BankReceived bankReceived, List<BankReceivedDetail> listBankReceivedDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //ambil giro yg lama
            String oldGiroCode = (String)hbmSession.hSession.createSQLQuery(
                    "SELECT fin_bank_received.GiroReceivedCode FROM fin_bank_received "
                    + "WHERE fin_bank_received.code = '" + bankReceived.getCode() + "'"
            ).uniqueResult();
            
            //balikin giro yg lama
            if (oldGiroCode != "") {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Pending' "
                        + "WHERE fin_giro_received.Code = '" + oldGiroCode + "'")
                .executeUpdate();
            }
            
            //ambil detail yg lama
            List<BankReceivedDetailTemp> listOldDetail = (List<BankReceivedDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_bank_received_detail.documentType, "
                    + "fin_bank_received_detail.documentNo, "
                    + "fin_bank_received_detail.creditIDR, "
                    + "fin_bank_received_detail.debitIDR "
                    + "FROM fin_bank_received_detail "
                    + "WHERE fin_bank_received_detail.HeaderCode='" + bankReceived.getCode() + "' "
                    + "AND fin_bank_received_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(BankReceivedDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(BankReceivedDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCreditIDR().add(detailEmpty.getDebitIDR());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //Ambil data deposit
            BankReceivedDepositTemp bankReceivedDepositTemp=getBankReceivedDeposit(bankReceived.getCode());
            
             //delete Deposit payment
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_received_deposit WHERE code = '" + bankReceived.getCode() + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_received_forex_gain_loss WHERE code = '" + bankReceived.getCode() + "'")
                    .executeUpdate();
            
            //delete detail bank receive
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_received_detail WHERE HeaderCode = '" + bankReceived.getCode() + "'")
                    .executeUpdate();
            
            //update header
            bankReceived.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            bankReceived.setUpdatedDate(new Date());
            hbmSession.hSession.update(bankReceived);

            // insert detail
            if(listBankReceivedDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(BankReceivedDetail detail : listBankReceivedDetail){
                                                            
                String detailCode = bankReceived.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(bankReceived.getCode());
                                    
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
                if (bankReceived.getTransactionType().equals("Deposit")) {
                    if(transactionStatus.equals("Other")){
                        BankReceivedDeposit bankReceivedDeposit = new BankReceivedDeposit();
                        bankReceivedDeposit.setCode(bankReceived.getCode());
                        bankReceivedDeposit.setBranch(bankReceived.getBranch());
                        bankReceivedDeposit.setTransactionDate(bankReceived.getTransactionDate());
                        bankReceivedDeposit.setCurrency(bankReceived.getCurrency());
                        bankReceivedDeposit.setExchangeRate(bankReceived.getExchangeRate());
//                        bankReceivedDeposit.setCustomer(bankReceived.getCustomer());
//                        bankReceivedDeposit.setRefNo(bankReceivedDepositTemp.getRefNo());
//                        bankReceivedDeposit.setRemark(bankReceivedDepositTemp.getRemark());
                        bankReceivedDeposit.setRefNo(bankReceived.getRefNo());
                        bankReceivedDeposit.setRemark(bankReceived.getRemark());
                        bankReceivedDeposit.setGrandTotalAmount(bankReceived.getTotalTransactionAmount());
                        bankReceivedDeposit.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        bankReceivedDeposit.setUpdatedDate(new Date());
                        bankReceivedDeposit.setCreatedBy(bankReceived.getCreatedBy());
                        bankReceivedDeposit.setCreatedDate(bankReceived.getCreatedDate());
                    
                        hbmSession.hSession.save(bankReceivedDeposit);
                    }
                }
                i++;
            }
            
            hbmSession.hSession.flush();
            
            //apabila giro, update statusnya
            if (!bankReceived.getGiroReceived().getCode().isEmpty()) {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Cleared' "
                        + "WHERE fin_giro_received.Code = '" + bankReceived.getGiroReceived().getCode() + "'")
                .executeUpdate();
            }
            
            //insert forex
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery("INSERT INTO fin_bank_received_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
                                               "VALUES ('" + bankReceived.getCode() + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    bankReceived.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
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
                    "SELECT fin_bank_received.GiroReceivedCode FROM fin_bank_received "
                    + "WHERE fin_bank_received.code = '" + headerCode + "'"
            ).uniqueResult();
            
            //balikin giro yg lama
            if (oldGiroCode != "") {
                hbmSession.hSession.createSQLQuery("UPDATE fin_giro_received SET fin_giro_received.GiroStatus = 'Pending' "
                        + "WHERE fin_giro_received.Code = '" + oldGiroCode + "'")
                .executeUpdate();
            }
            
            //ambil detail yg lama
            List<BankReceivedDetailTemp> listOldDetail = (List<BankReceivedDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_bank_received_detail.documentType, "
                    + "fin_bank_received_detail.documentNo, "
                    + "fin_bank_received_detail.creditIDR, "
                    + "fin_bank_received_detail.debitIDR "
                    + "FROM fin_bank_received_detail "
                    + "WHERE fin_bank_received_detail.HeaderCode='" + headerCode + "' "
                    + "AND fin_bank_received_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(BankReceivedDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(BankReceivedDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCreditIDR().add(detailEmpty.getDebitIDR());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //delete deposit
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_received_deposit WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_received_forex_gain_loss WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete detail bank received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_received_detail WHERE HeaderCode = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete header bank received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_bank_received WHERE code = '" + headerCode + "'")
                    .executeUpdate();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
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
    
    public void updateDeposit(BankReceivedDeposit bankReceivedDeposit,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery(
                    "UPDATE "+BankReceivedField.BEAN_NAME
                    + " SET customerCode = :prmCustomerCode "
                    + "WHERE "+BankReceivedField.CODE+" = :prmCode")
                    .setParameter("prmCustomerCode", bankReceivedDeposit.getCustomer().getCode())
                    .setParameter("prmCode", bankReceivedDeposit.getCode())
                    .executeUpdate();
            
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
//            String updatedDate= sdf.format(new Date());
            
            bankReceivedDeposit.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            bankReceivedDeposit.setUpdatedDate(new Date());
            hbmSession.hSession.update(bankReceivedDeposit);
            
//            hbmSession.hSession.createQuery(
//                    "UPDATE "+BankReceivedDepositField.BEAN_NAME
//                    + " SET customerCode = :prmCustomerCode,"
//                    + " UpdatedBy= :prmUpdatedBy, "
//                    + " UpdatedDate= :prmUpdatedDate "
//                    + "WHERE "+BankReceivedDepositField.CODE+" = :prmCode")
//                    .setParameter("prmCustomerCode", bankReceivedDeposit.getCustomer().getCode())
//                    .setParameter("prmUpdatedBy", BaseSession.loadProgramSession().getUserName())
//                    .setParameter("prmUpdatedDate", updatedDate)
//                    .setParameter("prmCode", bankReceivedDeposit.getCode())
//                    .executeUpdate();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    bankReceivedDeposit.getCode(), "DOWN PAYMENT UPDATE"));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
        }catch(Exception e){
            hbmSession.hTransaction.rollback();
            e.printStackTrace();
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public FinanceDocumentDAO getFinanceDocumentDAO() {
        return financeDocumentDAO;
    }

    public void setFinanceDocumentDAO(FinanceDocumentDAO financeDocumentDAO) {
        this.financeDocumentDAO = financeDocumentDAO;
    }
    
}
