
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.CustomerCreditNote;
import com.inkombizz.finance.model.CustomerCreditNoteDetail;
import com.inkombizz.finance.model.CustomerCreditNoteDetailField;
import com.inkombizz.finance.model.CustomerCreditNoteDetailTemp;
import com.inkombizz.finance.model.CustomerCreditNoteField;
import com.inkombizz.finance.model.CustomerCreditNoteTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
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


public class CustomerCreditNoteDAO {
    private HBMSession hbmSession;
    
    public CustomerCreditNoteDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String customerCode,String customerName, Date firstDate, Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*)  "
                + "FROM fin_customer_credit_note "
                + "INNER JOIN mst_branch ON fin_customer_credit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_credit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_credit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_credit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_credit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + "AND DATE(fin_customer_credit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
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
                    concatQueryAccStatus="AND fin_customer_credit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_customer_credit_note.AccStatus='Confirmed' ";
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
                + "FROM fin_customer_credit_note "
                + "INNER JOIN mst_branch ON fin_customer_credit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_credit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_credit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_credit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_credit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_customer_credit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }    
    public List<CustomerCreditNoteTemp> findData(String code,String customerCode,String customerName, int from,int to, Date firstDate, Date lastDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<CustomerCreditNoteTemp> list = (List<CustomerCreditNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_customer_credit_note.code, "
                + "fin_customer_credit_note.BranchCode, "            
                + "fin_customer_credit_note.Transactiondate, "
                + "fin_customer_credit_note.CurrencyCode, "
                + "fin_customer_credit_note.ExchangeRate, "
                + "fin_customer_credit_note.CustomerCode, "
                + "mst_customer.name AS CustomerName, "
                + "fin_customer_credit_note.taxInvoiceNo, "
                + "fin_customer_credit_note.RefNo, "
                + "fin_customer_credit_note.Remark, "
                + "fin_customer_credit_note.TotalTransactionAmount, "
                + "fin_customer_credit_note.DiscountPercent, "
                + "fin_customer_credit_note.DiscountAmount, "
                + "fin_customer_credit_note.VATPercent, "
                + "fin_customer_credit_note.VATAmount, "
                + "fin_customer_credit_note.GrandTotalAmount "
                + "FROM fin_customer_credit_note "
                + "INNER JOIN mst_branch ON fin_customer_credit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_credit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_credit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_credit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_credit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + "AND DATE(fin_customer_credit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_customer_credit_note.TransactionDate DESC "
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
                    
                .setResultTransformer(Transformers.aliasToBean(CustomerCreditNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     public List<CustomerCreditNoteTemp> findDataAccSpv(String code,String customerCode,String customerName, int from,int to, Date firstDate, Date lastDate,String status) {
        try {
             String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_customer_credit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_customer_credit_note.AccStatus='Confirmed' ";
                    break;
                case "":
                    concatQueryAccStatus=" ";
                    break;
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<CustomerCreditNoteTemp> list = (List<CustomerCreditNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_customer_credit_note.code, "
                + "fin_customer_credit_note.BranchCode, "            
                + "fin_customer_credit_note.Transactiondate, "
                + "fin_customer_credit_note.CurrencyCode, "
                + "fin_customer_credit_note.ExchangeRate, "
                + "fin_customer_credit_note.CustomerCode, "
                + "mst_customer.name AS CustomerName, "
                + "fin_customer_credit_note.taxInvoiceNo, "
                + "fin_customer_credit_note.RefNo, "
                + "fin_customer_credit_note.Remark, "
                + "fin_customer_credit_note.TotalTransactionAmount, "
                + "fin_customer_credit_note.DiscountPercent, "
                + "fin_customer_credit_note.DiscountAmount, "
                + "fin_customer_credit_note.VATPercent, "
                + "fin_customer_credit_note.VATAmount, "
                + "fin_customer_credit_note.GrandTotalAmount, "
                + "fin_customer_credit_note.AccStatus "
                + "FROM fin_customer_credit_note "
                + "INNER JOIN mst_branch ON fin_customer_credit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_customer_credit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_customer ON fin_customer_credit_note.CustomerCode=mst_customer.Code "
                + "WHERE fin_customer_credit_note.code LIKE '%"+code+"%' "
                + "AND fin_customer_credit_note.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.Name LIKE '%"+customerName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_customer_credit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_customer_credit_note.TransactionDate DESC "
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
                .setResultTransformer(Transformers.aliasToBean(CustomerCreditNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CustomerCreditNoteDetailTemp> findDataDetail(String headerCode) {
        try {
            
            List<CustomerCreditNoteDetailTemp> list = (List<CustomerCreditNoteDetailTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "fin_customer_credit_note_detail.code, "
                + "fin_customer_credit_note_detail.Headercode, "
                + "fin_customer_credit_note_detail.Remark, "
                + "fin_customer_credit_note_detail.BranchCode, "        
                + "fin_customer_credit_note_detail.ChartOfAccountCode, "
                + "mst_chart_of_account.Name AS chartOfAccountName, "
                + "fin_customer_credit_note_detail.Quantity, "
                + "fin_customer_credit_note_detail.Price, "
                + "fin_customer_credit_note_detail.UnitOfMeasureCode, "
                + "IFNULL(fin_customer_credit_note_detail.Quantity,0) * IFNULL(fin_customer_credit_note_detail.Price,0) AS Total "
                + "FROM fin_customer_credit_note_detail "
                + "INNER JOIN mst_chart_of_account ON mst_chart_of_account.Code=fin_customer_credit_note_detail.ChartOfAccountCode "
                + "WHERE fin_customer_credit_note_detail.HeaderCOde='"+headerCode+"'")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)    
                .addScalar("remark", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)    
                .setResultTransformer(Transformers.aliasToBean(CustomerCreditNoteDetailTemp.class))
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

    private String createCode(CustomerCreditNote customerCreditNote){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.CCN.toString();
            String acronim =  customerCreditNote.getBranch().getCode()+"/"+tempKode+"/"+AutoNumber.formatingDate(customerCreditNote.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerCreditNote.class)
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
    
    public void save(CustomerCreditNote customerCreditNote, List<CustomerCreditNoteDetail> listCustomerCreditNoteDetail, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(customerCreditNote);
            
            hbmSession.hSession.beginTransaction();
            
            customerCreditNote.setCode(headerCode);
            customerCreditNote.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerCreditNote.setCreatedDate(new Date());
            if(customerCreditNote.getDiscountAccount().getCode().equals("")){
               customerCreditNote.setDiscountAccount(null);
             }
            
            hbmSession.hSession.save(customerCreditNote);
            
            if(listCustomerCreditNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CustomerCreditNoteDetail detail : listCustomerCreditNoteDetail){
                                                            
                String detailCode = customerCreditNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(customerCreditNote.getCode());
                                    
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
                                                                    customerCreditNote.getCode(), ""));
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
    
    public void update(CustomerCreditNote customerCreditNote, List<CustomerCreditNoteDetail> listCustomerCreditNoteDetail, String moduleCode) throws Exception {
        try {

            hbmSession.hSession.beginTransaction();

            customerCreditNote.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerCreditNote.setUpdatedDate(new Date());
             if(customerCreditNote.getDiscountAccount().getCode().equals("")){
               customerCreditNote.setDiscountAccount(null);
             }
            hbmSession.hSession.update(customerCreditNote);

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerCreditNoteDetailField.BEAN_NAME+" WHERE "+CustomerCreditNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", customerCreditNote.getCode())    
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            if(listCustomerCreditNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(CustomerCreditNoteDetail detail : listCustomerCreditNoteDetail){
                                                            
                String detailCode = customerCreditNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(customerCreditNote.getCode());
                                    
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
                                                                    customerCreditNote.getCode(), ""));
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
                    
            hbmSession.hSession.createQuery("DELETE FROM "+CustomerCreditNoteField.BEAN_NAME+" WHERE "+CustomerCreditNoteField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM "+CustomerCreditNoteDetailField.BEAN_NAME+" WHERE "+CustomerCreditNoteDetailField.HEADERCODE+" = :prmCode")
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
       
}

    

