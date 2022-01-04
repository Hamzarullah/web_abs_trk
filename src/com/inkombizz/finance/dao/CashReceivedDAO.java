
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

import com.inkombizz.finance.model.CashReceived;
import com.inkombizz.finance.model.CashReceivedDetail;
import com.inkombizz.finance.model.CashReceivedDetailTemp;
import com.inkombizz.finance.model.CashReceivedDeposit;
import com.inkombizz.finance.model.CashReceivedDepositField;
import com.inkombizz.finance.model.CashReceivedDepositTemp;
import com.inkombizz.finance.model.CashReceivedField;
import com.inkombizz.finance.model.CashReceivedTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Locale;

public class CashReceivedDAO {
    
    private HBMSession hbmSession;
    private FinanceDocumentDAO financeDocumentDAO;
    
    public CashReceivedDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String userCodeTemp,String code, String receivedFrom,String cashAccountCode,String cashAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark, Date firstDate, Date lastDate){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM fin_cash_received "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_cash_received.currencyCode "
                + "INNER JOIN mst_cash_account ON mst_cash_account.code=fin_cash_received.cashAccountCode "
//                + "INNER JOIN scr_user_branch ON scr_user_branch.`UserCode` = '"+userCodeTemp+"' AND scr_user_branch.`BranchCode`=fin_cash_received.`BranchCode` "
//                + "INNER JOIN scr_user_cash_account ON scr_user_cash_account.`UserCode` = '"+userCodeTemp+"' AND scr_user_cash_account.`CashAccountCode`=fin_cash_received.`CashAccountCode` "
                + "WHERE fin_cash_received.code LIKE '%"+code+"%' "
                + "AND fin_cash_received.ReceivedFrom LIKE '%"+receivedFrom+"%' " 
                + "AND fin_cash_received.CashAccountCode LIKE '%"+cashAccountCode+"%' "
                + "AND mst_cash_account.Name LIKE '%"+cashAccountName+"%' "
                + "AND fin_cash_received.TotalTransactionAmount BETWEEN "+firstTotalTransactionAmount+" AND "+lastTotalTransactionAmount+" "
                + "AND fin_cash_received.Remark LIKE '%"+remark+"%' " 
                + "AND DATE(fin_cash_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public int countDataAccSpv(String userCodeTemp,String code, String receivedFrom,String cashAccountCode,String cashAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark, Date firstDate, Date lastDate, String status){
        try{
            String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_cash_received.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_cash_received.AccStatus='Confirmed' ";
                    break;
                case "":
                    concatQueryAccStatus=" ";
                    break;    
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM fin_cash_received "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_cash_received.currencyCode "
                + "INNER JOIN mst_cash_account ON mst_cash_account.code=fin_cash_received.cashAccountCode "
//                + "INNER JOIN scr_user_branch ON scr_user_branch.`UserCode` = '"+userCodeTemp+"' AND scr_user_branch.`BranchCode`=fin_cash_received.`BranchCode` "
//                + "INNER JOIN scr_user_cash_account ON scr_user_cash_account.`UserCode` = '"+userCodeTemp+"' AND scr_user_cash_account.`CashAccountCode`=fin_cash_received.`CashAccountCode` "
                + "WHERE fin_cash_received.code LIKE '%"+code+"%' "
                + "AND fin_cash_received.ReceivedFrom LIKE '%"+receivedFrom+"%' " 
                + "AND fin_cash_received.CashAccountCode LIKE '%"+cashAccountCode+"%' "
                + "AND mst_cash_account.Name LIKE '%"+cashAccountName+"%' "
                + "AND fin_cash_received.TotalTransactionAmount BETWEEN "+firstTotalTransactionAmount+" AND "+lastTotalTransactionAmount+" "
                + "AND fin_cash_received.Remark LIKE '%"+remark+"%' " 
                + concatQueryAccStatus
                + "AND DATE(fin_cash_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
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
                + "FROM fin_cash_received_deposit "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_cash_received_deposit.currencyCode "
                + "WHERE fin_cash_received_deposit.code LIKE '%"+code+"%' "
                + "AND DATE(fin_cash_received_deposit.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
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
    
    public List<CashReceivedTemp> findData(String userCodeTemp,String code, String receiveFrom,String cashAccountCode,String cashAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark, int from,int to, Date firstDate, Date lastDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<CashReceivedTemp> list = (List<CashReceivedTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_cash_received.code, "
                + "fin_cash_received.branchcode, "
                + "fin_cash_received.transactionDate, "
                + "fin_cash_received.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_cash_received.exchangeRate, "
                + "fin_cash_received.cashAccountCode, "
                + "mst_cash_account.name AS cashAccountName, "
                + "fin_cash_received.TransactionType, "
                + "fin_cash_received.receivedFrom, "
                + "fin_cash_received.totalTransactionAmount, "
                + "fin_cash_received.refNo, "
                + "fin_cash_received.remark "
                + "FROM fin_cash_received "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_cash_received.currencyCode "
                + "INNER JOIN mst_cash_account ON mst_cash_account.code=fin_cash_received.cashAccountCode "
//                + "INNER JOIN scr_user_branch ON scr_user_branch.`UserCode` = '"+userCodeTemp+"' AND scr_user_branch.`BranchCode`=fin_cash_received.`BranchCode` "
//                + "INNER JOIN scr_user_cash_account ON scr_user_cash_account.`UserCode` = '"+userCodeTemp+"' AND scr_user_cash_account.`CashAccountCode`=fin_cash_received.`CashAccountCode` "
                + "WHERE fin_cash_received.code LIKE '%"+code+"%' "
                + "AND fin_cash_received.ReceivedFrom LIKE '%"+receiveFrom+"%' "
                + "AND fin_cash_received.CashAccountCode LIKE '%"+cashAccountCode+"%' "
                + "AND mst_cash_account.Name LIKE '%"+cashAccountName+"%' "
                + "AND fin_cash_received.TotalTransactionAmount BETWEEN "+firstTotalTransactionAmount+" AND "+lastTotalTransactionAmount+" "
                + "AND fin_cash_received.Remark LIKE '%"+remark+"%' " 
                + "AND DATE(fin_cash_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_cash_received.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("cashAccountCode", Hibernate.STRING)
                .addScalar("cashAccountName", Hibernate.STRING)
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("receivedFrom", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CashReceivedTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CashReceivedTemp> findDataAccSpv(String userCodeTemp,String code, String receiveFrom,String cashAccountCode,String cashAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark, int from,int to, Date firstDate, Date lastDate,String status) {
        try {
            String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_cash_received.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_cash_received.AccStatus='Confirmed' ";
                    break;
                case "":
                    concatQueryAccStatus=" ";
                    break;
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<CashReceivedTemp> list = (List<CashReceivedTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_cash_received.code, "
                + "fin_cash_received.branchcode, "
                + "fin_cash_received.transactionDate, "
                + "fin_cash_received.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_cash_received.exchangeRate, "
                + "fin_cash_received.cashAccountCode, "
                + "mst_cash_account.name AS cashAccountName, "
                + "fin_cash_received.TransactionType, "
                + "fin_cash_received.receivedFrom, "
                + "fin_cash_received.totalTransactionAmount, "
                + "fin_cash_received.refNo, "
                + "fin_cash_received.remark, "
                + "fin_cash_received.accStatus "
                + "FROM fin_cash_received "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_cash_received.currencyCode "
                + "INNER JOIN mst_cash_account ON mst_cash_account.code=fin_cash_received.cashAccountCode "
//                + "INNER JOIN scr_user_branch ON scr_user_branch.`UserCode` = '"+userCodeTemp+"' AND scr_user_branch.`BranchCode`=fin_cash_received.`BranchCode` "
//                + "INNER JOIN scr_user_cash_account ON scr_user_cash_account.`UserCode` = '"+userCodeTemp+"' AND scr_user_cash_account.`CashAccountCode`=fin_cash_received.`CashAccountCode` "
                + "WHERE fin_cash_received.code LIKE '%"+code+"%' "
                + "AND fin_cash_received.ReceivedFrom LIKE '%"+receiveFrom+"%' "
                + "AND fin_cash_received.CashAccountCode LIKE '%"+cashAccountCode+"%' "
                + "AND mst_cash_account.Name LIKE '%"+cashAccountName+"%' "
                + "AND fin_cash_received.TotalTransactionAmount BETWEEN "+firstTotalTransactionAmount+" AND "+lastTotalTransactionAmount+" "
                + "AND fin_cash_received.Remark LIKE '%"+remark+"%' " 
                + concatQueryAccStatus
                + "AND DATE(fin_cash_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_cash_received.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("cashAccountCode", Hibernate.STRING)
                .addScalar("cashAccountName", Hibernate.STRING)
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("receivedFrom", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("accStatus", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CashReceivedTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CashReceivedDepositTemp> findDataDeposit(String code,Date firstDate, Date lastDate, int from,int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<CashReceivedDepositTemp> list = (List<CashReceivedDepositTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_cash_received_deposit.code, "
                + "fin_cash_received_deposit.transactionDate, "
                + "fin_cash_received_deposit.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_cash_received_deposit.exchangeRate, "
                + "fin_cash_received_deposit.CustomerCode, "
                + "mst_customer.Name AS CustomerName, "
                + "fin_cash_received_deposit.GrandTotalAmount, "
                + "fin_cash_received_deposit.refNo, "
                + "fin_cash_received_deposit.remark "
                + "FROM fin_cash_received_deposit "
                + "LEFT JOIN mst_customer ON mst_customer.code=fin_cash_received_deposit.customerCode "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_cash_received_deposit.currencyCode "
                + "WHERE fin_cash_received_deposit.code LIKE '%"+code+"%' "
                + "AND DATE(fin_cash_received_deposit.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_cash_received_deposit.TransactionDate DESC "
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
                .setResultTransformer(Transformers.aliasToBean(CashReceivedDepositTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CashReceivedDetailTemp> findDataDetail(String headerCode) {
        try {
            
            List<CashReceivedDetailTemp> list = (List<CashReceivedDetailTemp>)hbmSession.hSession.createSQLQuery(
              "CALL usp_fin_cash_received_detail_get('"+headerCode+"')"
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
                .setResultTransformer(Transformers.aliasToBean(CashReceivedDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
            
    
    private String createCode(CashReceived cashReceived){
        try{
//            String tempKode = EnumTransactionType.ENUM_TransactionType.BKM.toString();
//            if(cashReceived.getTransactionType().equals("Deposit")){
//                tempKode = EnumTransactionType.ENUM_TransactionType.CDPBKM.toString();
//            }
            
            String tempKode = "";
            if(cashReceived.getTransactionType().equals("Deposit")){
                tempKode = "CDP";
            }
            
            String acronim = cashReceived.getBranch().getCode()+"/"+cashReceived.getCashAccount().getBkmVoucherNo()+tempKode+AutoNumber.formatingDate(cashReceived.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(CashReceived.class)
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
    
    public void save(CashReceived cashReceived, List<CashReceivedDetail> listCashReceivedDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            String headerCode = createCode(cashReceived);
            
            hbmSession.hSession.beginTransaction();
            
            cashReceived.setCode(headerCode);
            cashReceived.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            cashReceived.setCreatedDate(new Date());
            hbmSession.hSession.save(cashReceived);
            
            if(listCashReceivedDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CashReceivedDetail detail : listCashReceivedDetail){
                                                            
                String detailCode = cashReceived.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(cashReceived.getCode());
                                    
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
                if (cashReceived.getTransactionType().equals("Deposit")) {
                    CashReceivedDeposit cashReceivedDeposit = new CashReceivedDeposit();
                    cashReceivedDeposit.setCode(cashReceived.getCode());
                    cashReceivedDeposit.setTransactionDate(cashReceived.getTransactionDate());
                    cashReceivedDeposit.setCurrency(cashReceived.getCurrency());
                    cashReceivedDeposit.setExchangeRate(cashReceived.getExchangeRate());
                    cashReceivedDeposit.setGrandTotalAmount(cashReceived.getTotalTransactionAmount());
                    cashReceivedDeposit.setRefNo(cashReceived.getRefNo());
                    cashReceivedDeposit.setRemark(cashReceived.getRemark());
                    cashReceivedDeposit.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    cashReceivedDeposit.setCreatedDate(new Date());
                    cashReceivedDeposit.setCustomer(null);
                    hbmSession.hSession.save(cashReceivedDeposit);
                }
                
                i++;
            }
            
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery(
                        "INSERT INTO fin_cash_received_forex_gain_loss "
                    + "(Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) "
                    + "VALUES ('" + headerCode + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    cashReceived.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private CashReceivedDepositTemp getCashReceivedDeposit(String code) {
        try {
            
            CashReceivedDepositTemp cashPaymentDepositTemp = (CashReceivedDepositTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_cash_received_deposit.RefNo, "
                + "fin_cash_received_deposit.Remark, "
                + "fin_cash_received_deposit.UpdatedBy, "
                + "fin_cash_received_deposit.UpdatedDate "
                + "FROM fin_cash_received_deposit "
                + "WHERE fin_cash_received_deposit.Code='"+code+"'")
                
                        
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                
                .setResultTransformer(Transformers.aliasToBean(CashReceivedDepositTemp.class))
                .uniqueResult(); 
                 
                return cashPaymentDepositTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    public void update(CashReceived cashReceived, List<CashReceivedDetail> listCashReceivedDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //ambil detail yg lama
            List<CashReceivedDetailTemp> listOldDetail = (List<CashReceivedDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_cash_received_detail.documentType, "
                    + "fin_cash_received_detail.documentNo, "
                    + "fin_cash_received_detail.debit, "
                    + "fin_cash_received_detail.credit "
                    + "FROM fin_cash_received_detail "
                    + "WHERE fin_cash_received_detail.HeaderCode='" + cashReceived.getCode() + "' "
                    + "AND fin_cash_received_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("credit", Hibernate.BIG_DECIMAL)
                .addScalar("debit", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CashReceivedDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(CashReceivedDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCredit().add(detailEmpty.getDebit());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //Ambil data deposit
            CashReceivedDepositTemp cashReceivedDepositTemp=getCashReceivedDeposit(cashReceived.getCode());
            
             //delete Deposit payment
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_received_deposit WHERE code = '" + cashReceived.getCode() + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_received_forex_gain_loss WHERE code = '" + cashReceived.getCode() + "'")
                    .executeUpdate();
            
            //delete detail cash receive
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_received_detail WHERE HeaderCode = '" + cashReceived.getCode() + "'")
                    .executeUpdate();
            
            //update header
            cashReceived.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            cashReceived.setUpdatedDate(new Date());
            hbmSession.hSession.update(cashReceived);

            // insert detail
            if(listCashReceivedDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CashReceivedDetail detail : listCashReceivedDetail){
                                                            
                String detailCode = cashReceived.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(cashReceived.getCode());
                                    
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
                if (cashReceived.getTransactionType().equals("Deposit")) {
                    if(transactionStatus.equals("Other")){
                        CashReceivedDeposit cashReceivedDeposit = new CashReceivedDeposit();
                        cashReceivedDeposit.setCode(cashReceived.getCode());
                        cashReceivedDeposit.setTransactionDate(cashReceived.getTransactionDate());
                        cashReceivedDeposit.setCurrency(cashReceived.getCurrency());
//                        cashReceivedDeposit.setCustomer(cashReceived.getCustomer());
                        cashReceivedDeposit.setExchangeRate(cashReceived.getExchangeRate());
//                        cashReceivedDeposit.setRefNo(cashReceivedDepositTemp.getRefNo());
//                        cashReceivedDeposit.setRemark(cashReceivedDepositTemp.getRemark());
                        cashReceivedDeposit.setRefNo(cashReceived.getRefNo());
                        cashReceivedDeposit.setRemark(cashReceived.getRemark());
                        cashReceivedDeposit.setGrandTotalAmount(cashReceived.getTotalTransactionAmount());
                        cashReceivedDeposit.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        cashReceivedDeposit.setUpdatedDate(new Date());
                        cashReceivedDeposit.setCreatedBy(cashReceived.getCreatedBy());
                        cashReceivedDeposit.setCreatedDate(cashReceived.getCreatedDate());
                        hbmSession.hSession.save(cashReceivedDeposit);
                    }
                }
                i++;
            }
            
            //insert forex
            if (forexAmount != 0) {
                hbmSession.hSession.createSQLQuery("INSERT INTO fin_cash_received_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
                                               "VALUES ('" + cashReceived.getCode() + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
                .executeUpdate();
            }
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    cashReceived.getCode(), ""));
            
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
            
            //ambil detail yg lama
            List<CashReceivedDetailTemp> listOldDetail = (List<CashReceivedDetailTemp>)hbmSession.hSession.createSQLQuery(
                        "SELECT "
                    + "fin_cash_received_detail.documentType, "
                    + "fin_cash_received_detail.documentNo, "
                    + "fin_cash_received_detail.debit, "
                    + "fin_cash_received_detail.credit "
                    + "FROM fin_cash_received_detail "
                    + "WHERE fin_cash_received_detail.HeaderCode='" + headerCode + "' "
                    + "AND fin_cash_received_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("debit", Hibernate.BIG_DECIMAL)
                .addScalar("credit", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CashReceivedDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(CashReceivedDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCredit().add(detailEmpty.getDebit());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //delete deposit
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_received_deposit WHERE fin_cash_received_deposit.Code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete forex
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_received_forex_gain_loss WHERE fin_cash_received_forex_gain_loss.Code = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete detail cash received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_received_detail WHERE fin_cash_received_detail.HeaderCode = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete header cash received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_cash_received WHERE fin_cash_received.Code = '" + headerCode + "'")
                    .executeUpdate();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    headerCode, ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void updateDeposit(CashReceivedDeposit cashReceivedDeposit,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery(
                    "UPDATE "+CashReceivedField.BEAN_NAME
                    + " SET customerCode = :prmCustomerCode "
                    + "WHERE "+CashReceivedField.CODE+" = :prmCode")
                    .setParameter("prmCustomerCode", cashReceivedDeposit.getCustomer().getCode())
                    .setParameter("prmCode", cashReceivedDeposit.getCode())
                    .executeUpdate();
            
            cashReceivedDeposit.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            cashReceivedDeposit.setUpdatedDate(new Date());
            hbmSession.hSession.update(cashReceivedDeposit);
            
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
//            String updatedDate= sdf.format(new Date());
//            
//            hbmSession.hSession.createQuery(
//                    "UPDATE "+CashReceivedDepositField.BEAN_NAME
//                    + " SET customerCode = :prmCustomerCode,"
//                    + " UpdatedBy= :prmUpdatedBy, "
//                    + " UpdatedDate= :prmUpdatedDate "
//                    + "WHERE "+CashReceivedDepositField.CODE+" = :prmCode")
//                    .setParameter("prmCustomerCode", cashReceived.getCustomer().getCode())
//                    .setParameter("prmUpdatedBy", BaseSession.loadProgramSession().getUserName())
//                    .setParameter("prmUpdatedDate", updatedDate)
//                    .setParameter("prmCode", cashReceived.getCode())
//                    .executeUpdate();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    cashReceivedDeposit.getCode(), "DOWN PAYMENT UPDATE"));
            
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

    

