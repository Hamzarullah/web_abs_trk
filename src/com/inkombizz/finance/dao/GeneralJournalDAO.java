
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.utils.DateUtils;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;
import com.inkombizz.system.dao.TransactionLogDAO;
import org.hibernate.criterion.Restrictions;
import java.math.BigDecimal;

import com.inkombizz.finance.model.GeneralJournal;
import com.inkombizz.finance.model.GeneralJournalDetail;
import com.inkombizz.finance.model.GeneralJournalTemp;
import com.inkombizz.finance.model.GeneralJournalDetailTemp;



public class GeneralJournalDAO {
    
    private HBMSession hbmSession;
    
    private FinanceDocumentDAO financeDocumentDAO;
    
    public GeneralJournalDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String refNo,String remark,Date firstDate,Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM fin_general_journal "
                + "INNER JOIN mst_branch ON fin_general_journal.BranchCode=mst_branch.code "
//                + "INNER JOIN mst_division ON fin_general_journal.DivisionCode=mst_division.code "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_general_journal.currencyCode "
                + "WHERE fin_general_journal.code LIKE '%"+code+"%' "
                + "AND fin_general_journal.RefNo LIKE '%"+refNo+"%' "
                + "AND fin_general_journal.Remark LIKE '%"+remark+"%' "
                + "AND DATE(fin_general_journal.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
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

    public List<GeneralJournalTemp> findData(String code,String refNo,String remark,Date firstDate,Date lastDate,int from,int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<GeneralJournalTemp> list = (List<GeneralJournalTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_general_journal.code, "
                + "fin_general_journal.branchCode, "
                + "mst_branch.Name AS branchName, "
//                + "fin_general_journal.divisionCode, "
//                + "mst_division.Name AS companyName, "
                + "fin_general_journal.transactiondate, "
                + "fin_general_journal.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "fin_general_journal.exchangeRate, "
                + "fin_general_journal.totalTransactionAmount, "
                + "fin_general_journal.refno, "
                + "fin_general_journal.remark "
                + "FROM fin_general_journal "
                + "INNER JOIN mst_branch ON fin_general_journal.BranchCode=mst_branch.code "
//                + "INNER JOIN mst_division ON fin_general_journal.DivisionCode=mst_division.code "
                + "INNER JOIN mst_currency ON mst_currency.code=fin_general_journal.currencyCode "
                + "WHERE fin_general_journal.code LIKE '%"+code+"%' "
                + "AND fin_general_journal.RefNo LIKE '%"+refNo+"%' "
                + "AND fin_general_journal.Remark LIKE '%"+remark+"%' "
                + "AND DATE(fin_general_journal.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_general_journal.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(GeneralJournalTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<GeneralJournalDetailTemp> findDataDetail(String headerCode) {
        try {
            
            List<GeneralJournalDetailTemp> list = (List<GeneralJournalDetailTemp>)hbmSession.hSession.createSQLQuery(
              "CALL usp_fin_general_journal_detail_get_update('"+headerCode+"')"
            )
                                 
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("documentBranchCode", Hibernate.STRING)
            .addScalar("documentType", Hibernate.STRING)
            .addScalar("documentNo", Hibernate.STRING)
            .addScalar("currencyCode", Hibernate.STRING)
            .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
            .addScalar("transactionStatus", Hibernate.STRING)
            .addScalar("chartOfAccountCode", Hibernate.STRING)
            .addScalar("chartOfAccountName", Hibernate.STRING)
            .addScalar("debit", Hibernate.BIG_DECIMAL)    
            .addScalar("debitIDR", Hibernate.BIG_DECIMAL)  
            .addScalar("credit", Hibernate.BIG_DECIMAL)    
            .addScalar("creditIDR", Hibernate.BIG_DECIMAL)    
            .addScalar("remark", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(GeneralJournalDetailTemp.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    private String createCode(GeneralJournal generalJournal){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.GJM.toString();
            String acronim =  generalJournal.getBranch().getCode()+"/"+tempKode+AutoNumber.formatingDate(generalJournal.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(GeneralJournal.class)
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
    
    
    public void save(GeneralJournal generalJournal, List<GeneralJournalDetail> listGeneralJournalDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(generalJournal);
            
            hbmSession.hSession.beginTransaction();
            
            generalJournal.setCode(headerCode);
            generalJournal.setParentTransactionType(EnumTransactionType.ENUM_TransactionType.GJM.toString());
            generalJournal.setParentVoucherNo(headerCode);
            generalJournal.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            generalJournal.setCreatedDate(new Date());
            
            hbmSession.hSession.save(generalJournal);

            //INSERT DETAIL AND UPDATE PAID AMOUNT
            if(listGeneralJournalDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(GeneralJournalDetail detail : listGeneralJournalDetail){
                                                            
                String detailCode = generalJournal.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(generalJournal.getCode());
                                    
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
                                
                i++;
            }
            
            // insert forex amount
//            if (forexAmount != 0) {
//                hbmSession.hSession.createSQLQuery("INSERT INTO fin_general_journal_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
//                                               "VALUES ('" + headerCode + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
//                .executeUpdate();
//            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    generalJournal.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(GeneralJournal generalJournal, List<GeneralJournalDetail> listGeneralJournalDetail, Double forexAmount, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //ambil detail yg lama
            List<GeneralJournalDetailTemp> listOldDetail = (List<GeneralJournalDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_general_journal_detail.documentType, "
                    + "fin_general_journal_detail.documentNo, "
                    + "fin_general_journal_detail.credit, "
                    + "fin_general_journal_detail.debit "
                    + "FROM fin_general_journal_detail "
                    + "WHERE fin_general_journal_detail.HeaderCode='" + generalJournal.getCode() + "' "
                    + "AND fin_general_journal_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("credit", Hibernate.BIG_DECIMAL)
                .addScalar("debit", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(GeneralJournalDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(GeneralJournalDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCredit().add(detailEmpty.getDebit());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(), Amount);
            }
            
            //delete forex
//            hbmSession.hSession.createSQLQuery("DELETE FROM fin_general_journal_forex_gain_loss WHERE code = '" + generalJournal.getCode() + "'")
//                    .executeUpdate();
            
            //delete detail cash receive
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_general_journal_detail WHERE HeaderCode = '" + generalJournal.getCode() + "'")
                    .executeUpdate();
            
            //update header
            generalJournal.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            generalJournal.setUpdatedDate(new Date());
            hbmSession.hSession.update(generalJournal);

            // insert detail
            if(listGeneralJournalDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(GeneralJournalDetail detail : listGeneralJournalDetail){
                                                            
                String detailCode = generalJournal.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(generalJournal.getCode());
                                    
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
                
                i++;
            }
            
            //insert forex
//            if (forexAmount != 0) {
//                hbmSession.hSession.createSQLQuery("INSERT INTO fin_general_journal_forex_gain_loss (Code, CurrencyCode, ExchangeRate, Amount, CreatedBy, CreatedDate) " +
//                                               "VALUES ('" + generalJournal.getCode() + "', 'IDR', 1, " + forexAmount + ", '" + BaseSession.loadProgramSession().getUserName() + "', '" + DateUtils.toString(new Date(), "yyyy-MM-dd") +"')")
//                .executeUpdate();
//            }
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    generalJournal.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
//    private Boolean paidAmount_update(String documentType,BigDecimal amount,String documentNo,String headerCode) throws Exception{
//        try {
//            if(documentType.equals("VIN")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("INV")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("PRT")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("CDP")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("SDP")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("CCN-SRT")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("CCN")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("CDN")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("SCN")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else if(documentType.equals("SDN")){
////                CustomerDownPaymentDAO customerDownPaymentDAO = new CustomerDownPaymentDAO(hbmSession);
////                customerDownPaymentDAO.updatePaidAmount(amount,documentNo,headerCode);
//                return Boolean.TRUE;
//            }else{
//                return Boolean.FALSE;
//            }
//        } catch (HibernateException e) {
//            e.printStackTrace();
//            return Boolean.FALSE;
//        }
//    }
        
    public void delete(String headerCode, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            //ambil detail yg lama
            List<GeneralJournalDetailTemp> listOldDetail = (List<GeneralJournalDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "fin_general_journal_detail.documentType, "
                    + "fin_general_journal_detail.documentNo, "
                    + "fin_general_journal_detail.credit, "
                    + "fin_general_journal_detail.debit "
                    + "FROM fin_general_journal_detail "
                    + "WHERE fin_general_journal_detail.HeaderCode='" + headerCode + "' "
                    + "AND fin_general_journal_detail.DocumentNo <> ''")
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("credit", Hibernate.BIG_DECIMAL)
                .addScalar("debit", Hibernate.BIG_DECIMAL) 
                .setResultTransformer(Transformers.aliasToBean(GeneralJournalDetailTemp.class))
                .list(); 
            
            // empty paid amount detail yg lama
            for(GeneralJournalDetailTemp detailEmpty : listOldDetail){
                financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
                BigDecimal Amount = detailEmpty.getCredit().add(detailEmpty.getDebit());
                financeDocumentDAO.emptyPaidAount(detailEmpty.getDocumentType(), detailEmpty.getDocumentNo(),Amount);
            }
            
            //delete forex
//            hbmSession.hSession.createSQLQuery("DELETE FROM fin_general_journal_forex_gain_loss WHERE code = '" + headerCode + "'")
//                    .executeUpdate();
            
            //delete detail bank received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_general_journal_detail WHERE HeaderCode = '" + headerCode + "'")
                    .executeUpdate();
            
            //delete header bank received
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_general_journal WHERE code = '" + headerCode + "'")
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
