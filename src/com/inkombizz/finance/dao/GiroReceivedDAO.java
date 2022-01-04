
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.GiroReceived;
import com.inkombizz.finance.model.GiroReceivedField;
import com.inkombizz.finance.model.GiroReceivedTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;




public class GiroReceivedDAO {
    
    private HBMSession hbmSession;
    
    public GiroReceivedDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String giroStatus,Date firstDate,Date lastDate){
        try{
   
            String qry_giro_status="";
            if(!giroStatus.equals("")){
                qry_giro_status="AND fin_giro_received.GiroStatus ='"+giroStatus+"' ";
            }
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                        "SELECT COUNT(fin_giro_received.Code) "
                + "FROM fin_giro_received "
                + "INNER JOIN mst_bank ON fin_giro_received.BankCode=mst_bank.Code "
                + "INNER JOIN mst_currency ON fin_giro_received.CurrencyCode=mst_currency.code "
                + "WHERE fin_giro_received.Code LIKE '%"+code+"%' "
                + qry_giro_status
                + "AND DATE(fin_giro_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    
    public List<GiroReceivedTemp> findData(String code,String giroStatus,Date firstDate,Date lastDate,int from, int row) {
        try {   
            
            String qry_giro_status="";
            if(!giroStatus.equals("")){
                qry_giro_status="AND fin_giro_received.GiroStatus ='"+giroStatus+"' ";
            }
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<GiroReceivedTemp> list = (List<GiroReceivedTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "fin_giro_received.Code, "
                + "fin_giro_received.BranchCode, "
                + "fin_giro_received.TransactionDate, "
                + "fin_giro_received.DueDate AS dueDate, "
                + "fin_giro_received.GiroNo, "
                + "fin_giro_received.BankCode, "
                + "mst_bank.Name AS BankName, "
                + "fin_giro_received.ReceivedFrom, "
                + "fin_giro_received.CurrencyCode, "
                + "mst_currency.Name as CurrencyName, "
                + "fin_giro_received.Amount, "
                + "fin_giro_received.GiroStatus, "
                + "fin_giro_received.RefNo, "
                + "fin_giro_received.Remark "
                + "FROM fin_giro_received "
                + "INNER JOIN mst_bank ON fin_giro_received.BankCode=mst_bank.Code "
                + "INNER JOIN mst_currency ON fin_giro_received.CurrencyCode=mst_currency.code "
                + "WHERE fin_giro_received.Code LIKE '%"+code+"%' "
                + qry_giro_status
                + "AND DATE(fin_giro_received.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_giro_received.TransactionDate DESC "                  
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
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
                .setResultTransformer(Transformers.aliasToBean(GiroReceivedTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
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
    
    private String createCode(GiroReceived giroReceived){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.GRR.toString();
            String acronim =  giroReceived.getBranch().getCode()+"/"+tempKode+AutoNumber.formatingDate(giroReceived.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(GiroReceived.class)
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
    
    public void save(GiroReceived giroReceived, String moduleCode) {
        try {
            
            String headerCode=createCode(giroReceived);
            
            hbmSession.hSession.beginTransaction();
            giroReceived.setCode(headerCode);
            giroReceived.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            giroReceived.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(giroReceived);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    giroReceived.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(GiroReceived giroReceived, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            giroReceived.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            giroReceived.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(giroReceived);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    giroReceived.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + GiroReceivedField.BEAN_NAME + " WHERE " + GiroReceivedField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
//    public List<BankReceivedTemp> isUsedByBankReceived(String code){
//        try{
//            String sql = "SELECT "
//                        + "fin_bank_received.code "
//                        + "FROM fin_giro_received "
//                        + "INNER JOIN fin_bank_received ON fin_giro_received.code=fin_bank_received.GiroCode "
//                        + "WHERE fin_giro_received.code='"+code+"'";
//            Query q = hbmSession.hSession.createSQLQuery(sql)
//                    .addScalar("code", Hibernate.STRING)
//                    .setResultTransformer(Transformers.aliasToBean(BankReceivedTemp.class));
//            List<BankReceivedTemp> list =  q.list();
//            hbmSession.hSession.clear();
//            hbmSession.hSession.close();
//            return list;
//        }catch(Exception e){
//            e.printStackTrace();
//            return null;
//        }
//        
//    }
    
    public List<GiroReceivedTemp> isUsedByBankReceived(String code){
        try{
            String sql = "SELECT "
                    + "fin_bank_received.Code "
                    + "FROM fin_bank_received "
                    + "WHERE fin_bank_received.GiroReceivedCode='"+code+"'";
            Query q = hbmSession.hSession.createSQLQuery(sql)
                    .addScalar("code", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(GiroReceivedTemp.class));
            List<GiroReceivedTemp> list =  q.list();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            return list;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    public Boolean isRejected(String code) throws Exception{
        try {
            String giroStatus = (String)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "	CASE WHEN fin_giro_received.GiroStatus='Rejected' THEN  "
                + "		'Rejected'  "
                + "	ELSE 'Pending'  "
                + "	END AS GiroStatus "
                + "FROM fin_giro_received "
                + "WHERE fin_giro_received.Code='"+code+"'"
            ).uniqueResult();
            
            if(giroStatus.equals("Rejected")){
                return Boolean.TRUE;
            }
            
            return Boolean.FALSE;
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void rejected(GiroReceived giroReceived, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            giroReceived.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
            String updatedDate= sdf.format(new Date());
            
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_giro_received "
                + "SET fin_giro_received.GiroStatus = 'Rejected', "
                + "fin_giro_received.UpdatedBy='"+giroReceived.getUpdatedBy()+"', "
                + "fin_giro_received.UpdatedDate='"+updatedDate+"' "
                + "WHERE fin_giro_received.Code = '" + giroReceived.getCode() + "'")
                .executeUpdate();
                        
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    giroReceived.getCode(), "GIRO RECEIVED - REJECTED"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
}
