

package com.inkombizz.master.dao;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;

import com.inkombizz.master.model.Journal;
import com.inkombizz.master.model.JournalChartOfAccount;
import com.inkombizz.master.model.JournalChartOfAccountTemp;
import com.inkombizz.master.model.JournalTemp;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;


public class JournalDAO {
        
    private HBMSession hbmsession;
    
    public JournalDAO (HBMSession session){
            this.hbmsession = session;
    }
     
    public int countData(String code,String name){
        try{
            BigInteger temp = (BigInteger)hbmsession.hSession.createSQLQuery(""
                + "SELECT COUNT(*) " 
                + "FROM mst_journal "
                + "WHERE mst_journal.code LIKE '%"+code+"%' "
                + "AND mst_journal.name LIKE '%"+name+"%' "
                + "").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
   
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmsession.hSession);
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
     
    public List <Journal> findByCriteria (DetachedCriteria dc, int from,int size){
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmsession.hSession);
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e){
            throw e;
        }
    }     

    public JournalTemp get(String code) {
        try {
            JournalTemp journalTemp = (JournalTemp)hbmsession.hSession.createSQLQuery(
                 "SELECT mst_journal.Code AS code, "
                + "mst_journal.activeStatus AS activeStatus, "
                + "mst_journal.name AS name "
                + "FROM "
                + "mst_journal "
                + "WHERE "
                + "mst_journal.code ='"+code+"' ")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(JournalTemp.class))
                .uniqueResult(); 
                 
                return journalTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    
    public List<JournalTemp> findData(String code, String name,int from, int row) {
        try {   
            List<JournalTemp> list = (List<JournalTemp>)hbmsession.hSession.createSQLQuery(
                    "SELECT mst_journal.Code AS code, "
                + "mst_journal.name AS name "
                + "FROM mst_journal "
                + "WHERE mst_journal.code LIKE '%"+code+"%' "
                + "AND mst_journal.name LIKE '%"+name+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(JournalTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataDetail(String journalCode){
        try{
            BigInteger temp = (BigInteger)hbmsession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM(SELECT "
                + "mst_journal_chart_of_account.JournalCode, "
                + "mst_journal.Name AS JournalName, "
                + "mst_journal_chart_of_account.CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "mst_journal_chart_of_account.AutomaticJournalSetupCode, "
                + "mst_journal_type.AutomaticJournalType, "
                + "mst_journal_type.JournalPosition, "
                + "mst_journal_chart_of_account.AccountCode, "
                + "mst_chart_of_account.Name AS AccountName "
                + "FROM mst_journal_chart_of_account "
                + "LEFT JOIN mst_journal_type ON mst_journal_chart_of_account.AutomaticJournalSetupCode = mst_journal_type.Code "
                + "LEFT JOIN mst_chart_of_account ON mst_journal_chart_of_account.AccountCode = mst_chart_of_account.Code "
                + "LEFT JOIN mst_currency ON mst_journal_chart_of_account.CurrencyCode = mst_currency.Code "
                + "LEFT JOIN mst_journal ON mst_journal_chart_of_account.JournalCode = mst_journal.Code "
                + "WHERE mst_journal.Code = '"+journalCode+"' "
                + "AND mst_journal_type.ActiveStatus = 1 "
                + " "
                + "UNION ALL "
                + " "
                + "SELECT "
                + "mst_journal.Code AS JournalCode, "
                + "mst_journal.Name AS JournalName, "
                + "mst_currency.Code AS CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "mst_journal_type.Code AS AutomaticJournalSetupCode, "
                + "mst_journal_type.AutomaticJournalType, "
                + "mst_journal_type.JournalPosition, "
                + "'' AS AccountCode, "
                + "'' AS AccountName "
                + "FROM mst_journal_type "
                + "LEFT JOIN mst_journal_chart_of_account ON mst_journal_type.Code = mst_journal_chart_of_account.AutomaticJournalSetupCode "
                + "CROSS JOIN mst_currency "
                + "CROSS JOIN mst_journal "
                + "WHERE mst_journal_chart_of_account.AutomaticJournalSetupCode IS NULL "
                + "AND mst_journal.Code = '"+journalCode+"' "
                + "AND mst_journal_type.ActiveStatus = 1 "
                + ")AS qry").uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<JournalChartOfAccountTemp> findDataDetail(String journalCode) {
        try {   
            List<JournalChartOfAccountTemp> list = (List<JournalChartOfAccountTemp>)hbmsession.hSession.createSQLQuery(
                    "SELECT "
                + "qry.JournalCode, "
                + "qry.JournalName, "
                + "qry.CurrencyCode, "
                + "qry.CurrencyName, "
                + "qry.AutomaticJournalSetupCode, "
                + "qry.AutomaticJournalType, "
                + "qry.JournalPosition, "
                + "qry.AccountCode, "
                + "qry.AccountName "
                + "FROM(SELECT "
                + "mst_journal_chart_of_account.JournalCode, "
                + "mst_journal.Name AS JournalName, "
                + "mst_journal_chart_of_account.CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "mst_journal_chart_of_account.AutomaticJournalSetupCode, "
                + "mst_journal_type.AutomaticJournalType, "
                + "mst_journal_type.JournalPosition, "
                + "mst_journal_chart_of_account.AccountCode, "
                + "mst_chart_of_account.Name AS AccountName "
                + "FROM mst_journal_chart_of_account "
                + "LEFT JOIN mst_journal_type ON mst_journal_chart_of_account.AutomaticJournalSetupCode = mst_journal_type.Code "
                + "LEFT JOIN mst_chart_of_account ON mst_journal_chart_of_account.AccountCode = mst_chart_of_account.Code "
                + "LEFT JOIN mst_currency ON mst_journal_chart_of_account.CurrencyCode = mst_currency.Code "
                + "LEFT JOIN mst_journal ON mst_journal_chart_of_account.JournalCode = mst_journal.Code "
                + "WHERE mst_journal.Code = '"+journalCode+"' "
                + "AND mst_journal_type.ActiveStatus = 1 "
                + " "
                + "UNION ALL "
                + " "
                + "SELECT "
                + "mst_journal.Code AS JournalCode, "
                + "mst_journal.Name AS JournalName, "
                + "mst_currency.Code AS CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "mst_journal_type.Code AS AutomaticJournalSetupCode, "
                + "mst_journal_type.AutomaticJournalType, "
                + "mst_journal_type.JournalPosition, "
                + "'' AS AccountCode, "
                + "'' AS AccountName "
                + "FROM mst_journal_type "
                + "LEFT JOIN mst_journal_chart_of_account ON mst_journal_type.Code = mst_journal_chart_of_account.AutomaticJournalSetupCode "
                + "CROSS JOIN mst_currency "
                + "CROSS JOIN mst_journal "
                + "WHERE mst_journal_chart_of_account.AutomaticJournalSetupCode IS NULL "
                + "AND mst_journal.Code = '"+journalCode+"' "
                + "AND mst_journal_type.ActiveStatus = 1 "
                + ")AS qry "
                + "ORDER BY qry.CurrencyCode, qry.AutomaticJournalSetupCode ")
                    
                .addScalar("journalCode", Hibernate.STRING)
                .addScalar("journalName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("automaticJournalSetupCode", Hibernate.STRING)
                .addScalar("automaticJournalType", Hibernate.STRING)
                .addScalar("journalPosition", Hibernate.STRING)
                .addScalar("accountCode", Hibernate.STRING)
                .addScalar("accountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(JournalChartOfAccountTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<JournalChartOfAccountTemp> findDataGetDetail(String journalCode) {
        try {   
            List<JournalChartOfAccountTemp> list = (List<JournalChartOfAccountTemp>)hbmsession.hSession.createSQLQuery(
                    "SELECT "
                + "qry.JournalCode, "
                + "qry.JournalName, "
                + "qry.CurrencyCode, "
                + "qry.CurrencyName, "
                + "qry.AutomaticJournalSetupCode, "
                + "qry.AutomaticJournalType, "
                + "qry.JournalPosition, "
                + "qry.AccountCode, "
                + "qry.AccountName "
                + "FROM(SELECT "
                + "mst_journal_chart_of_account.JournalCode, "
                + "mst_journal.Name AS JournalName, "
                + "mst_journal_chart_of_account.CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "mst_journal_chart_of_account.AutomaticJournalSetupCode, "
                + "mst_journal_type.AutomaticJournalType, "
                + "mst_journal_type.JournalPosition, "
                + "mst_journal_chart_of_account.AccountCode, "
                + "mst_chart_of_account.Name AS AccountName "
                + "FROM mst_journal_chart_of_account "
                + "LEFT JOIN mst_journal_type ON mst_journal_chart_of_account.AutomaticJournalSetupCode = mst_journal_type.Code "
                + "LEFT JOIN mst_chart_of_account ON mst_journal_chart_of_account.AccountCode = mst_chart_of_account.Code "
                + "LEFT JOIN mst_currency ON mst_journal_chart_of_account.CurrencyCode = mst_currency.Code "
                + "LEFT JOIN mst_journal ON mst_journal_chart_of_account.JournalCode = mst_journal.Code "
                + "WHERE mst_journal.Code = '"+journalCode+"' "
                + "AND mst_journal_type.ActiveStatus = 1 "
                + " "
                + "UNION ALL "
                + " "
                + "SELECT "
                + "mst_journal.Code AS JournalCode, "
                + "mst_journal.Name AS JournalName, "
                + "mst_currency.Code AS CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "mst_journal_type.Code AS AutomaticJournalSetupCode, "
                + "mst_journal_type.AutomaticJournalType, "
                + "mst_journal_type.JournalPosition, "
                + "'' AS AccountCode, "
                + "'' AS AccountName "
                + "FROM mst_journal_type "
                + "LEFT JOIN mst_journal_chart_of_account ON mst_journal_type.Code = mst_journal_chart_of_account.AutomaticJournalSetupCode "
                + "CROSS JOIN mst_currency "
                + "CROSS JOIN mst_journal "
                + "WHERE mst_journal_chart_of_account.AutomaticJournalSetupCode IS NULL "
                + "AND mst_journal.Code = '"+journalCode+"' "
                + "AND mst_journal_type.ActiveStatus = 1 "
                + ")AS qry "
                + "WHERE qry.CurrencyName IS NOT NULL "
                + "ORDER BY qry.CurrencyCode, qry.AutomaticJournalSetupCode")
                    
                .addScalar("journalCode", Hibernate.STRING)
                .addScalar("journalName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("automaticJournalSetupCode", Hibernate.STRING)
                .addScalar("automaticJournalType", Hibernate.STRING)
                .addScalar("journalPosition", Hibernate.STRING)
                .addScalar("accountCode", Hibernate.STRING)
                .addScalar("accountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(JournalChartOfAccountTemp.class))
                .list();
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Journal journal,List<JournalChartOfAccount> listJournalChartOfAccount, String moduleCode)throws Exception {
        try {
            hbmsession.hSession.beginTransaction();
            
            journal.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            journal.setCreatedDate(new Date()); 
            journal.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            journal.setUpdatedDate(new Date()); 
            
            hbmsession.hSession.update(journal);
            
            if(!saveDetail(journal,listJournalChartOfAccount)){
                hbmsession.hTransaction.rollback();
            }
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmsession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    journal.getCode(), ""));

            hbmsession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmsession.hTransaction.rollback();
            throw e;
        }
    }
    
//    public void update(Journal journal,List<JournalDetailTemp> listJournalDetailTemp, String moduleCode) throws Exception{
//        try {
//            hbmsession.hSession.beginTransaction();
//            
//            journal.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
//            journal.setUpdatedDate(new Date()); 
//            
//            hbmsession.hSession.update(journal);
//            
//            if(!saveDetail(listJournalDetailTemp)){
//                hbmsession.hTransaction.rollback();
//            }
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmsession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
//                                                                    journal.getCode(), ""));
//             
//            hbmsession.hTransaction.commit();
//        }
//        catch (HibernateException e) {
//            hbmsession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
//    public void delete(String code, String moduleCode) {
//        try {
//            hbmsession.hSession.beginTransaction();
//            hbmsession.hSession.createQuery("DELETE FROM " + JournalField.BEAN_NAME + " WHERE " + JournalField.CODE + " = :prmCode")
//                    .setParameter("prmCode", code)
//                    .executeUpdate();
//            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmsession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
//                                                                    code, ""));
//             
//            hbmsession.hTransaction.commit();
//        }
//        catch (HibernateException e) {
//            hbmsession.hTransaction.rollback();
//            throw e;
//        }
//    }

//    public int checkIsExistToDeleteInvoice (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmsession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_giro.code)  "
//            + "FROM mst_giro  "
//            + "INNER JOIN sal_invoice ON sal_invoice.girocode = mst_giro.code  " 
//            + "WHERE "       
//            + "sal_invoice.girocode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//      }

    private boolean saveDetail(Journal journal,List<JournalChartOfAccount> listJournalChartOfAccount) throws Exception {
        try {
            
            hbmsession.hSession.createSQLQuery("DELETE FROM mst_journal_chart_of_account " 
                                 +" WHERE mst_journal_chart_of_account.JournalCode = :prmJournalCode")
                    .setParameter("prmJournalCode", journal.getCode())
                    .executeUpdate();
            
                hbmsession.hSession.flush();
            
            for(JournalChartOfAccount journalChartOfAccount : listJournalChartOfAccount){
                                                            
                hbmsession.hSession.save(journalChartOfAccount);
                
//                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
//                detail.setUpdatedDate(new Date());
//                
//                hbmsession.hSession.createSQLQuery(
//                        "UPDATE "
//                    + "mst_journal_chart_of_account "
//                    + "SET mst_journal_chart_of_account.AccountCode='"+detail.getAccountCode()+"' "
//                    + "WHERE mst_journal_chart_of_account.currencyCode='"+detail.getCurrencyCode() +"' "
//                    + "AND mst_journal_chart_of_account.JournalCode='"+detail.getJournalCode() +"' "
//                    + "AND mst_journal_chart_of_account.AutomaticJournalSetupCode='"+detail.getAutomaticJournalSetupCode() +"'"
//                ).executeUpdate();
            }
            

            return Boolean.TRUE;
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
}
