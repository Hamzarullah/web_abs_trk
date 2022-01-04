
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.CustomerDebitNote;
import com.inkombizz.finance.model.CustomerDebitNoteDetail;
import com.inkombizz.finance.model.CustomerDebitNoteDetailField;
import com.inkombizz.finance.model.CustomerDebitNoteDetailTemp;
import com.inkombizz.finance.model.CustomerDebitNoteField;
import com.inkombizz.finance.model.CustomerDebitNoteTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
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


public class CustomerDebitNoteDAO {
    private HBMSession hbmSession;
    
    public CustomerDebitNoteDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String customerCode,String customerName, Date firstDate, Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*)  "
                + "FROM fin_customer_debit_note "
                + "INNER JOIN mst_branch ON fin_customer_debit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_debit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_debit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_debit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_debit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + "AND DATE(fin_customer_debit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countDataAccSpv(String code,String customerCode,String customerName, Date firstDate, Date lastDate, String status){
        try{
             String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_customer_debit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_customer_debit_note.AccStatus='Confirmed' ";
                    break;
                case "":
                    concatQueryAccStatus=" ";
                    break;    
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*)  "
                + "FROM fin_customer_debit_note "
                + "INNER JOIN mst_branch ON fin_customer_debit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_debit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_debit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_debit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_debit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_customer_debit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public List<CustomerDebitNoteTemp> findDataAccSpv(String code,String customerCode,String customerName, int from,int to, Date firstDate, Date lastDate,String status) {
        try {
             String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_customer_debit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_customer_debit_note.AccStatus='Confirmed' ";
                    break;
                case "":
                    concatQueryAccStatus=" ";
                    break;
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<CustomerDebitNoteTemp> list = (List<CustomerDebitNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_customer_debit_note.code, "
                + "fin_customer_debit_note.BranchCode, "            
                + "fin_customer_debit_note.Transactiondate, "
                + "fin_customer_debit_note.CurrencyCode, "
                + "fin_customer_debit_note.ExchangeRate, "
                + "fin_customer_debit_note.CustomerCode, "
                + "mst_customer.name AS CustomerName, "
                + "fin_customer_debit_note.taxInvoiceNo, "
                + "fin_customer_debit_note.RefNo, "
                + "fin_customer_debit_note.Remark, "
                + "fin_customer_debit_note.TotalTransactionAmount, "
                + "fin_customer_debit_note.DiscountPercent, "
                + "fin_customer_debit_note.DiscountAmount, "
                + "fin_customer_debit_note.VATPercent, "
                + "fin_customer_debit_note.VATAmount, "
                + "fin_customer_debit_note.GrandTotalAmount, "
                + "fin_customer_debit_note.AccStatus "
                + "FROM fin_customer_debit_note "
                + "INNER JOIN mst_branch ON fin_customer_debit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_debit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_debit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_debit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_debit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_customer_debit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_customer_debit_note.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("taxInvoiceNo", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("accStatus", Hibernate.STRING)    
                .setResultTransformer(Transformers.aliasToBean(CustomerDebitNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CustomerDebitNoteTemp> findData(String code,String customerCode,String customerName, int from,int to, Date firstDate, Date lastDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<CustomerDebitNoteTemp> list = (List<CustomerDebitNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_customer_debit_note.code, "
                + "fin_customer_debit_note.BranchCode, "            
                + "fin_customer_debit_note.Transactiondate, "
                + "fin_customer_debit_note.CurrencyCode, "
                + "fin_customer_debit_note.ExchangeRate, "
                + "fin_customer_debit_note.CustomerCode, "
                + "mst_customer.name AS CustomerName, "
                + "fin_customer_debit_note.taxInvoiceNo, "
                + "fin_customer_debit_note.RefNo, "
                + "fin_customer_debit_note.Remark, "
                + "fin_customer_debit_note.TotalTransactionAmount, "
                + "fin_customer_debit_note.DiscountPercent, "
                + "fin_customer_debit_note.DiscountAmount, "
                + "fin_customer_debit_note.VATPercent, "
                + "fin_customer_debit_note.VATAmount, "
                + "fin_customer_debit_note.GrandTotalAmount "
                + "FROM fin_customer_debit_note "
                + "INNER JOIN mst_branch ON fin_customer_debit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_debit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_debit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_debit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_debit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + "AND DATE(fin_customer_debit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_customer_debit_note.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("taxInvoiceNo", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                    
                .setResultTransformer(Transformers.aliasToBean(CustomerDebitNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerDebitNoteDetailTemp> findDataDetail(String headerCode) {
        try {
            
            List<CustomerDebitNoteDetailTemp> list = (List<CustomerDebitNoteDetailTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "fin_customer_debit_note_detail.code, "
                + "fin_customer_debit_note_detail.Headercode, "
                + "fin_customer_debit_note_detail.Remark, "
                + "fin_customer_debit_note_detail.BranchCode, "        
                + "fin_customer_debit_note_detail.ChartOfAccountCode, "
                + "mst_chart_of_account.Name AS chartOfAccountName, "
                + "fin_customer_debit_note_detail.Quantity, "
                + "fin_customer_debit_note_detail.Price, "
                + "fin_customer_debit_note_detail.UnitOfMeasureCode, "
                + "mst_unit_of_measure.name AS unitOfMeasureName, "
                + "IFNULL(fin_customer_debit_note_detail.Quantity,0) * IFNULL(fin_customer_debit_note_detail.Price,0) AS Total "
                + "FROM fin_customer_debit_note_detail "
                + "INNER JOIN mst_chart_of_account ON mst_chart_of_account.Code=fin_customer_debit_note_detail.ChartOfAccountCode "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.code = fin_customer_debit_note_detail.UnitOfMeasureCode "
                + "WHERE fin_customer_debit_note_detail.HeaderCOde='"+headerCode+"'")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)    
                .addScalar("remark", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("unitOfMeasureName", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)    
                .setResultTransformer(Transformers.aliasToBean(CustomerDebitNoteDetailTemp.class))
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

    private String createCode(CustomerDebitNote customerDebitNote){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.CDN.toString();
            String acronim =  customerDebitNote.getBranch().getCode()+"/"+tempKode+"/"+AutoNumber.formatingDate(customerDebitNote.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerDebitNote.class)
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
    
    public void save(CustomerDebitNote customerDebitNote, List<CustomerDebitNoteDetail> listCustomerDebitNoteDetail, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(customerDebitNote);
            
            hbmSession.hSession.beginTransaction();
            
            customerDebitNote.setCode(headerCode);
            customerDebitNote.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerDebitNote.setCreatedDate(new Date());
            if(customerDebitNote.getDiscountAccount().getCode().equals("")){
               customerDebitNote.setDiscountAccount(null);
             }
            hbmSession.hSession.save(customerDebitNote);
            
            if(listCustomerDebitNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CustomerDebitNoteDetail detail : listCustomerDebitNoteDetail){
                                                            
                String detailCode = customerDebitNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(customerDebitNote.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(detail);
                            
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    customerDebitNote.getCode(), ""));
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
    
    public void update(CustomerDebitNote customerDebitNote, List<CustomerDebitNoteDetail> listCustomerDebitNoteDetail, String moduleCode) throws Exception {
        try {

            hbmSession.hSession.beginTransaction();

            customerDebitNote.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerDebitNote.setUpdatedDate(new Date());
             if(customerDebitNote.getDiscountAccount().getCode().equals("")){
               customerDebitNote.setDiscountAccount(null);
             }
            hbmSession.hSession.update(customerDebitNote);

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerDebitNoteDetailField.BEAN_NAME+" WHERE "+CustomerDebitNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", customerDebitNote.getCode())    
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            if(listCustomerDebitNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CustomerDebitNoteDetail detail : listCustomerDebitNoteDetail){
                                                            
                String detailCode = customerDebitNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(customerDebitNote.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                
                    
                hbmSession.hSession.save(detail);
                            
                i++;
            }
            

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerDebitNote.getCode(), ""));
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
    
    public void delete(String code, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
                    
            hbmSession.hSession.createQuery("DELETE FROM "+CustomerDebitNoteField.BEAN_NAME+" WHERE "+CustomerDebitNoteField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM "+CustomerDebitNoteDetailField.BEAN_NAME+" WHERE "+CustomerDebitNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
       
}

    

