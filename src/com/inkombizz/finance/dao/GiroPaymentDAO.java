
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentField;
import com.inkombizz.finance.model.GiroPaymentTemp;
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



public class GiroPaymentDAO {
 
    private HBMSession hbmSession;
    
    public GiroPaymentDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String giroStatus,Date firstDate, Date lastDate){
        try{
            
            String qry_giro_status="";
            if(!giroStatus.equals("")){
                qry_giro_status="AND fin_giro_payment.GiroStatus='"+giroStatus+"' ";
            }
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*)  "
                + "FROM fin_giro_payment "
                + "INNER JOIN mst_branch ON fin_giro_payment.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_giro_payment.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_bank ON fin_giro_payment.BankCode=mst_bank.Code "
                + "WHERE fin_giro_payment.Code LIKE '%"+code+"%' "
                + qry_giro_status
                + "AND DATE(fin_giro_payment.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<GiroPaymentTemp> findData(String code,String giroStatus,Date firstDate, Date lastDate,int from, int row) {
        try {   
            
            String qry_giro_status="";
            if(!giroStatus.equals("")){
                qry_giro_status="AND fin_giro_payment.GiroStatus='"+giroStatus+"' ";
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<GiroPaymentTemp> list = (List<GiroPaymentTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "fin_giro_payment.Code, "
                + "fin_giro_payment.BranchCode, "
                + "fin_giro_payment.TransactionDate, "
                + "fin_giro_payment.DueDate As dueDate, "
                + "fin_giro_payment.GiroNo, "
                + "fin_giro_payment.BankCode, "
                + "mst_bank.Name AS BankName, "
                + "fin_giro_payment.PaymentTo, "
                + "fin_giro_payment.CurrencyCode, "
                + "mst_currency.Name AS CurrencyName, "
                + "fin_giro_payment.Amount, "
                + "fin_giro_payment.GiroStatus, "
                + "fin_giro_payment.RefNo, "
                + "fin_giro_payment.Remark "
                + "FROM fin_giro_payment "
                + "INNER JOIN mst_branch ON fin_giro_payment.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_giro_payment.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_bank ON fin_giro_payment.BankCode=mst_bank.Code "
                + "WHERE fin_giro_payment.Code LIKE '%"+code+"%' "
                + qry_giro_status
                + "AND DATE(fin_giro_payment.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_giro_payment.TransactionDate DESC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("dueDate", Hibernate.TIMESTAMP)
                .addScalar("giroNo", Hibernate.STRING)
                .addScalar("bankCode", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("paymentTo", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("amount", Hibernate.BIG_DECIMAL)
                .addScalar("giroStatus", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(GiroPaymentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public GiroPaymentTemp findData(String code){
        try {
                GiroPaymentTemp giroReceivedTemp = (GiroPaymentTemp)hbmSession.hSession.createSQLQuery(
                        "SELECT "
                    + "fin_giro_payment.Code, "
                    + "fin_giro_payment.TransactionDate, "
                    + "fin_giro_payment.DueDate, "
                    + "fin_giro_payment.CurrencyCode, "
                    + "mst_currency.Name AS CurrencyName, "
                    + "fin_giro_payment.GiroNo, "
                    + "mst_bank.Name AS BankName, "
                    + "fin_giro_payment.PaymentTo, "
                    + "fin_giro_payment.Amount "
                    + "FROM fin_giro_payment "
                    + "INNER JOIN mst_bank ON fin_giro_payment.BankCode=mst_bank.Code "
                    + "INNER JOIN mst_currency ON fin_giro_payment.CurrencyCode=mst_currency.code "
                    + "WHERE fin_giro_payment.Code='"+code+"' "
                    + "AND fin_giro_payment.GiroStatus='Pending'")

                    .addScalar("code", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("dueDate", Hibernate.TIMESTAMP)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("currencyName", Hibernate.STRING)
                    .addScalar("giroNo", Hibernate.STRING)
                    .addScalar("bankName", Hibernate.STRING)
                    .addScalar("paymentTo", Hibernate.STRING)
                    .addScalar("amount", Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(GiroPaymentTemp.class))
                    .uniqueResult(); 

                    return giroReceivedTemp;
                }catch (HibernateException e) {
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
    
    private String createCode(GiroPayment giroPayment){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.GRP.toString();
            String acronim =  giroPayment.getBranch().getCode()+"/"+tempKode+AutoNumber.formatingDate(giroPayment.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(GiroPayment.class)
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
    
    public void save(GiroPayment giroPayment, String moduleCode) {
        try {
            
            String headerCode=createCode(giroPayment);
            
            hbmSession.hSession.beginTransaction();
            giroPayment.setCode(headerCode);
            giroPayment.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            giroPayment.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(giroPayment);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    giroPayment.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(GiroPayment giroPayment, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            giroPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            giroPayment.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(giroPayment);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    giroPayment.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void rejected(GiroPayment giroPayment, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            giroPayment.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
            String updatedDate= sdf.format(new Date());
            
            hbmSession.hSession.createSQLQuery(
                    "UPDATE fin_giro_payment "
                + "SET fin_giro_payment.GiroStatus = 'Rejected', "
                + "fin_giro_payment.UpdatedBy='"+giroPayment.getUpdatedBy()+"', "
                + "fin_giro_payment.UpdatedDate='"+updatedDate+"' "
                + "WHERE fin_giro_payment.Code = '" + giroPayment.getCode() + "'")
                .executeUpdate();
                        
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    giroPayment.getCode(), "GIRO PAYMENT - REJECTED"));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + GiroPaymentField.BEAN_NAME + " WHERE " + GiroPaymentField.CODE + " = :prmCode")
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
    
    public List<GiroPaymentTemp> isUsedByBankPayment(String code){
        try{
            String sql = "SELECT "
                    + "fin_bank_payment.Code "
                    + "FROM fin_bank_payment "
                    + "WHERE fin_bank_payment.GiroPaymentNo='"+code+"'";
            Query q = hbmSession.hSession.createSQLQuery(sql)
                    .addScalar("code", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(GiroPaymentTemp.class));
            List<GiroPaymentTemp> list =  q.list();
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
                + "	CASE WHEN fin_giro_payment.GiroStatus='Rejected' THEN  "
                + "		'Rejected'  "
                + "	ELSE 'Pending'  "
                + "	END AS GiroStatus "
                + "FROM fin_giro_payment "
                + "WHERE fin_giro_payment.Code='"+code+"'"
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
}
