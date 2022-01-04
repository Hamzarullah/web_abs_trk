
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.VendorDebitNoteDetailTemp;
import com.inkombizz.finance.model.VendorDebitNote;
import com.inkombizz.finance.model.VendorDebitNoteDetail;
import com.inkombizz.finance.model.VendorDebitNoteDetailField;
import com.inkombizz.finance.model.VendorDebitNoteField;
import com.inkombizz.finance.model.VendorDebitNoteTemp;
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

public class VendorDebitNoteDAO {
    private HBMSession hbmSession;
    
    public VendorDebitNoteDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String vendorCode,String vendorName, Date firstDate, Date lastDate){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM fin_vendor_debit_note "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_vendor_debit_note.CurrencyCode "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = fin_vendor_debit_note.VendorCode "
                + "WHERE fin_vendor_debit_note.Code Like '%"+code+"%' "
                + "AND fin_vendor_debit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + "AND DATE(fin_vendor_debit_note.Transactiondate)  BETWEEN '"+dateFirst+"' AND '"+dateLast+"'")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<VendorDebitNoteTemp> findData(String code,String vendorCode,String vendorName,int from, int row, Date firstDate, Date lastDate) {
        try {   
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<VendorDebitNoteTemp> list = (List<VendorDebitNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_debit_note.Code, "
                + "fin_vendor_debit_note.Branchcode AS branchCode, "
                + "fin_vendor_debit_note.Transactiondate, "
                + "fin_vendor_debit_note.Currencycode, "
                + "mst_currency.Name AS currencyName, "
                + "fin_vendor_debit_note.Exchangerate, "
                + "fin_vendor_debit_note.VendorCode, "
                + "mst_vendor.Name AS VendorName, "
                + "fin_vendor_debit_note.taxInvoiceNo, "
                + "fin_vendor_debit_note.RefNo, "
                + "fin_vendor_debit_note.Remark, "
                + "fin_vendor_debit_note.Totaltransactionamount, "
                + "fin_vendor_debit_note.DiscountPercent, "
                + "fin_vendor_debit_note.DiscountAmount, "
                + "fin_vendor_debit_note.vatPercent, "
                + "fin_vendor_debit_note.vatAmount, "
                + "fin_vendor_debit_note.Grandtotalamount, "
                + "fin_vendor_debit_note.PaidAmount, "
                + "fin_vendor_debit_note.SettlementDate, "
                + "fin_vendor_debit_note.SettlementDocumentNo "
                + "FROM fin_vendor_debit_note "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_vendor_debit_note.CurrencyCode "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = fin_vendor_debit_note.VendorCode "
                + "WHERE fin_vendor_debit_note.Code Like '%"+code+"%' "
                + "AND fin_vendor_debit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + "AND DATE(fin_vendor_debit_note.Transactiondate)  BETWEEN  '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_vendor_debit_note.Transactiondate DESC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode",  Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("taxInvoiceNo", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("TotalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("paidAmount", Hibernate.BIG_DECIMAL)
                .addScalar("settlementDate", Hibernate.TIMESTAMP)
                .addScalar("settlementDocumentNo", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDebitNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
 
    
    public List<VendorDebitNoteDetailTemp> findDataDetail(String headerCode) {
        try {
            List<VendorDebitNoteDetailTemp> list = (List<VendorDebitNoteDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_debit_note_detail.Code, "
                + "fin_vendor_debit_note_detail.Headercode, "
                + "fin_vendor_debit_note_detail.BranchCode, "
                + "fin_vendor_debit_note_detail.ChartOfAccountCode, "
                + "mst_chart_of_account.name AS chartOfAccountName, "
                + "fin_vendor_debit_note_detail.Remark, "
                + "fin_vendor_debit_note_detail.Quantity, "
                + "fin_vendor_debit_note_detail.Price, "
                + "fin_vendor_debit_note_detail.UnitOfMeasureCode, "
                + "IFNULL(fin_vendor_debit_note_detail.Quantity,0) * IFNULL(fin_vendor_debit_note_detail.Price,0) AS total "
                + "FROM fin_vendor_debit_note_detail "
                + "INNER JOIN mst_chart_of_account ON mst_chart_of_account.Code = fin_vendor_debit_note_detail.ChartOfAccountCode "
                + "WHERE fin_vendor_debit_note_detail.Headercode = '"+headerCode+"'")

                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING) 
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(VendorDebitNoteDetailTemp.class))
                .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public int countDataAccSpv(String code,String vendorCode,String vendorName, Date firstDate, Date lastDate, String status){
        try{
             String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_vendor_debit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_vendor_debit_note.AccStatus='Confirmed' ";
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
                + "FROM fin_vendor_debit_note "
                + "INNER JOIN mst_branch ON fin_vendor_debit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_vendor_debit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_vendor ON fin_vendor_debit_note.VendorCode=mst_vendor.Code "
                + "WHERE fin_vendor_debit_note.code LIKE '%"+code+"%' "
                + "AND fin_vendor_debit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_vendor_debit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public List<VendorDebitNoteTemp> findDataAccSpv(String code,String vendorCode,String vendorName, int from,int to, Date firstDate, Date lastDate,String status) {
        try {
             String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_vendor_debit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_vendor_debit_note.AccStatus='Confirmed' ";
                    break;
                case "":
                    concatQueryAccStatus=" ";
                    break;
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
                        
            List<VendorDebitNoteTemp> list = (List<VendorDebitNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_debit_note.code, "
                + "fin_vendor_debit_note.BranchCode, "            
                + "fin_vendor_debit_note.Transactiondate, "
                + "fin_vendor_debit_note.CurrencyCode, "
                + "fin_vendor_debit_note.ExchangeRate, "
                + "fin_vendor_debit_note.VendorCode, "
                + "mst_vendor.name AS VendorName, "
                + "fin_vendor_debit_note.taxInvoiceNo, "
                + "fin_vendor_debit_note.RefNo, "
                + "fin_vendor_debit_note.Remark, "
                + "fin_vendor_debit_note.TotalTransactionAmount, "
                + "fin_vendor_debit_note.DiscountPercent, "
                + "fin_vendor_debit_note.DiscountAmount, "
                + "fin_vendor_debit_note.VATPercent, "
                + "fin_vendor_debit_note.VATAmount, "
                + "fin_vendor_debit_note.GrandTotalAmount, "
                + "fin_vendor_debit_note.AccStatus "
                + "FROM fin_vendor_debit_note "
                + "INNER JOIN mst_branch ON fin_vendor_debit_note.BranchCode=mst_branch.Code "
                + "INNER JOIN mst_currency ON fin_vendor_debit_note.CurrencyCode=mst_currency.Code "
                + "INNER JOIN mst_vendor ON fin_vendor_debit_note.VendorCode=mst_vendor.Code "
                + "WHERE fin_vendor_debit_note.code LIKE '%"+code+"%' "
                + "AND fin_vendor_debit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_vendor_debit_note.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_vendor_debit_note.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
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
                .setResultTransformer(Transformers.aliasToBean(VendorDebitNoteTemp.class))
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

    private String createCode(VendorDebitNote vendorDebitNote){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.VDN.toString();
            String acronim =  vendorDebitNote.getBranch().getCode()+"/"+tempKode+"/"+AutoNumber.formatingDate(vendorDebitNote.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(VendorDebitNote.class)
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
    
    
    public void save(VendorDebitNote vendorDebitNote, List<VendorDebitNoteDetail> listVendorDebitNoteDetail, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(vendorDebitNote);
            
            hbmSession.hSession.beginTransaction();
            
            vendorDebitNote.setCode(headerCode);
            vendorDebitNote.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDebitNote.setCreatedDate(new Date());
            if(vendorDebitNote.getDiscountAccount().getCode().equals("")){
               vendorDebitNote.setDiscountAccount(null);
             }
            hbmSession.hSession.save(vendorDebitNote);
            
            if(listVendorDebitNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(VendorDebitNoteDetail detail : listVendorDebitNoteDetail){
                                                            
                String detailCode = vendorDebitNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(vendorDebitNote.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                    
                hbmSession.hSession.save(detail);
        
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    vendorDebitNote.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(VendorDebitNote vendorDebitNote, List<VendorDebitNoteDetail> listVendorDebitNoteDetail, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            vendorDebitNote.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDebitNote.setUpdatedDate(new Date());
             if(vendorDebitNote.getDiscountAccount().getCode().equals("")){
               vendorDebitNote.setDiscountAccount(null);
             }
            hbmSession.hSession.saveOrUpdate(vendorDebitNote);

            hbmSession.hSession.createQuery("DELETE FROM "+VendorDebitNoteDetailField.BEAN_NAME+" WHERE "+VendorDebitNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", vendorDebitNote.getCode())
                    .executeUpdate();
            
            if(listVendorDebitNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(VendorDebitNoteDetail detail : listVendorDebitNoteDetail){
                                                            
                String detailCode = vendorDebitNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(vendorDebitNote.getCode());
                                    
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                    
                hbmSession.hSession.save(detail);
        
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    vendorDebitNote.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
      public void updateAccSpv(VendorDebitNote vendorDebitNote, List<VendorDebitNoteDetail> listVendorDebitNoteDetail, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            vendorDebitNote.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorDebitNote.setUpdatedDate(new Date());
             if(vendorDebitNote.getDiscountAccount().getCode().equals("")){
               vendorDebitNote.setDiscountAccount(null);
             }
            hbmSession.hSession.saveOrUpdate(vendorDebitNote);

            hbmSession.hSession.createQuery("DELETE FROM "+VendorDebitNoteDetailField.BEAN_NAME+" WHERE "+VendorDebitNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", vendorDebitNote.getCode())
                    .executeUpdate();
            
            if(listVendorDebitNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(VendorDebitNoteDetail detail : listVendorDebitNoteDetail){
                                                            
                String detailCode = vendorDebitNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(vendorDebitNote.getCode());
                                    
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                    
                hbmSession.hSession.save(detail);
        
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    vendorDebitNote.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    public void delete(String code, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery("DELETE FROM "+VendorDebitNoteField.BEAN_NAME+" WHERE "+VendorDebitNoteField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+VendorDebitNoteDetailField.BEAN_NAME+" WHERE "+VendorDebitNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
}

    

