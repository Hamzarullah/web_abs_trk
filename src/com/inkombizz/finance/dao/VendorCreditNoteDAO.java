
package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.finance.model.VendorCreditNoteDetailTemp;
import com.inkombizz.finance.model.VendorCreditNote;
import com.inkombizz.finance.model.VendorCreditNoteDetail;
import com.inkombizz.finance.model.VendorCreditNoteDetailField;
import com.inkombizz.finance.model.VendorCreditNoteField;
import com.inkombizz.finance.model.VendorCreditNoteTemp;
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

public class VendorCreditNoteDAO {
    private HBMSession hbmSession;
    
    public VendorCreditNoteDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String vendorCode,String vendorName, Date firstDate, Date lastDate){
        try{

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM fin_vendor_credit_note "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_vendor_credit_note.CurrencyCode "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = fin_vendor_credit_note.VendorCode "
                + "WHERE fin_vendor_credit_note.Code Like '%"+code+"%' "
                + "AND fin_vendor_credit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + "AND DATE(fin_vendor_credit_note.Transactiondate)  BETWEEN '"+dateFirst+"' AND '"+dateLast+"'")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<VendorCreditNoteTemp> findData(String code,String vendorCode,String vendorName,int from, int row, Date firstDate, Date lastDate) {
        try {   
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<VendorCreditNoteTemp> list = (List<VendorCreditNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_credit_note.Code, "
                + "fin_vendor_credit_note.Branchcode AS branchCode, "
                + "fin_vendor_credit_note.Transactiondate, "
                + "fin_vendor_credit_note.Currencycode, "
                + "mst_currency.Name AS currencyName, "
                + "fin_vendor_credit_note.Exchangerate, "
                + "fin_vendor_credit_note.VendorCode, "
                + "mst_vendor.Name AS VendorName, "
                + "fin_vendor_credit_note.taxInvoiceNo, "
                + "fin_vendor_credit_note.RefNo, "
                + "fin_vendor_credit_note.Remark, "
                + "fin_vendor_credit_note.Totaltransactionamount, "
                + "fin_vendor_credit_note.DiscountPercent, "
                + "fin_vendor_credit_note.DiscountAmount, "
                + "fin_vendor_credit_note.vatPercent, "
                + "fin_vendor_credit_note.vatAmount, "
                + "fin_vendor_credit_note.Grandtotalamount, "
                + "fin_vendor_credit_note.PaidAmount, "
                + "fin_vendor_credit_note.SettlementDate, "
                + "fin_vendor_credit_note.SettlementDocumentNo "
                + "FROM fin_vendor_credit_note "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_vendor_credit_note.CurrencyCode "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = fin_vendor_credit_note.VendorCode "
                + "WHERE fin_vendor_credit_note.Code Like '%"+code+"%' "
                + "AND fin_vendor_credit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + "AND DATE(fin_vendor_credit_note.Transactiondate)  BETWEEN  '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY fin_vendor_credit_note.Transactiondate DESC "
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
                .setResultTransformer(Transformers.aliasToBean(VendorCreditNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
 
    
    public List<VendorCreditNoteDetailTemp> findDataDetail(String headerCode) {
        try {
            List<VendorCreditNoteDetailTemp> list = (List<VendorCreditNoteDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_credit_note_detail.Code, "
                + "fin_vendor_credit_note_detail.Headercode, "
                + "fin_vendor_credit_note_detail.BranchCode, "
                + "fin_vendor_credit_note_detail.ChartOfAccountCode, "
                + "mst_chart_of_account.name AS chartOfAccountName, "
                + "fin_vendor_credit_note_detail.Remark, "
                + "fin_vendor_credit_note_detail.Quantity, "
                + "fin_vendor_credit_note_detail.Price, "
                + "fin_vendor_credit_note_detail.UnitOfMeasureCode, "
                + "IFNULL(fin_vendor_credit_note_detail.Quantity,0) * IFNULL(fin_vendor_credit_note_detail.Price,0) AS total "
                + "FROM fin_vendor_credit_note_detail "
                + "INNER JOIN mst_chart_of_account ON mst_chart_of_account.Code = fin_vendor_credit_note_detail.ChartOfAccountCode "
                + "WHERE fin_vendor_credit_note_detail.Headercode = '"+headerCode+"'")

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
                .setResultTransformer(Transformers.aliasToBean(VendorCreditNoteDetailTemp.class))
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

    private String createCode(VendorCreditNote vendorCreditNote){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.VCN.toString();
            String acronim =  vendorCreditNote.getBranch().getCode()+"/"+tempKode+"/"+AutoNumber.formatingDate(vendorCreditNote.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(VendorCreditNote.class)
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
    
    
    public void save(VendorCreditNote vendorCreditNote, List<VendorCreditNoteDetail> listVendorCreditNoteDetail, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(vendorCreditNote);
            
            hbmSession.hSession.beginTransaction();
            
            vendorCreditNote.setCode(headerCode);
            vendorCreditNote.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorCreditNote.setCreatedDate(new Date());

            if(vendorCreditNote.getDiscountAccount().getCode().equals("")){
                vendorCreditNote.setDiscountAccount(null);
            }
            hbmSession.hSession.save(vendorCreditNote);
            
            if(listVendorCreditNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(VendorCreditNoteDetail detail : listVendorCreditNoteDetail){
                                                            
                String detailCode = vendorCreditNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(vendorCreditNote.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                    
                hbmSession.hSession.save(detail);
        
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    vendorCreditNote.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(VendorCreditNote vendorCreditNote, List<VendorCreditNoteDetail> listVendorCreditNoteDetail, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            vendorCreditNote.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorCreditNote.setUpdatedDate(new Date());
            if(vendorCreditNote.getDiscountAccount().getCode().equals("")){
                vendorCreditNote.setDiscountAccount(null);
            }
            hbmSession.hSession.saveOrUpdate(vendorCreditNote);

            hbmSession.hSession.createQuery("DELETE FROM "+VendorCreditNoteDetailField.BEAN_NAME+" WHERE "+VendorCreditNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", vendorCreditNote.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            if(listVendorCreditNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(VendorCreditNoteDetail detail : listVendorCreditNoteDetail){
                                                            
                String detailCode = vendorCreditNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(vendorCreditNote.getCode());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                    
                hbmSession.hSession.save(detail);
        
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    vendorCreditNote.getCode(), ""));
            
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
            
            hbmSession.hSession.createQuery("DELETE FROM "+VendorCreditNoteField.BEAN_NAME+" WHERE "+VendorCreditNoteField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+VendorCreditNoteDetailField.BEAN_NAME+" WHERE "+VendorCreditNoteDetailField.HEADERCODE+" = :prmCode")
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
    
    public int countDataAccSpv(String code,String vendorCode,String vendorName, String status, Date firstDate, Date lastDate){
        try{
            String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_vendor_credit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_vendor_credit_note.AccStatus='Confirmed' ";
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
                + "FROM fin_vendor_credit_note "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_vendor_credit_note.CurrencyCode "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = fin_vendor_credit_note.VendorCode "
                + "WHERE fin_vendor_credit_note.Code Like '%"+code+"%' "
                + "AND fin_vendor_credit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_vendor_credit_note.Transactiondate)  BETWEEN DATE '"+dateFirst+"' AND DATE '"+dateLast+"'")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    public List<VendorCreditNoteTemp> findDataAccSpv(String code, String vendorCode, String vendorName, Date firstDate, Date lastDate, String status, int fromRow, int toRow) {
      try {   
               String concatQueryAccStatus="";
            switch(status){
                case "Open":
                    concatQueryAccStatus="AND fin_vendor_credit_note.AccStatus='Open' ";
                    break;
                case "Confirmed":
                    concatQueryAccStatus="AND fin_vendor_credit_note.AccStatus='Confirmed' ";
                    break;
                case "":
                    concatQueryAccStatus=" ";
                    break;
            }
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            List<VendorCreditNoteTemp> list = (List<VendorCreditNoteTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "fin_vendor_credit_note.Code, "
                + "fin_vendor_credit_note.AccStatus, "
                + "fin_vendor_credit_note.Branchcode AS branchCode, "
                + "fin_vendor_credit_note.Transactiondate, "
                + "fin_vendor_credit_note.Currencycode, "
                + "mst_currency.Name AS currencyName, "
                + "fin_vendor_credit_note.Exchangerate, "
                + "fin_vendor_credit_note.VendorCode, "
                + "mst_vendor.Name AS VendorName, "
                + "fin_vendor_credit_note.taxInvoiceNo, "
                + "fin_vendor_credit_note.RefNo, "
                + "fin_vendor_credit_note.Remark, "
                + "fin_vendor_credit_note.Totaltransactionamount, "
                + "fin_vendor_credit_note.DiscountPercent, "
                + "fin_vendor_credit_note.DiscountAmount, "
                + "fin_vendor_credit_note.vatPercent, "
                + "fin_vendor_credit_note.vatAmount, "
                + "fin_vendor_credit_note.Grandtotalamount, "
                + "fin_vendor_credit_note.PaidAmount, "
                + "fin_vendor_credit_note.SettlementDate, "
                + "fin_vendor_credit_note.SettlementDocumentNo "
                + "FROM fin_vendor_credit_note "
                + "INNER JOIN mst_currency ON mst_currency.Code = fin_vendor_credit_note.CurrencyCode "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = fin_vendor_credit_note.VendorCode "
                + "WHERE fin_vendor_credit_note.Code Like '%"+code+"%' "
                + "AND fin_vendor_credit_note.VendorCode LIKE '%"+vendorCode+"%' "
                + "AND mst_vendor.Name LIKE '%"+vendorName+"%' "
                + concatQueryAccStatus
                + "AND DATE(fin_vendor_credit_note.Transactiondate)  BETWEEN DATE '"+dateFirst+"' AND DATE '"+dateLast+"' "
                + "ORDER BY fin_vendor_credit_note.Transactiondate DESC "
                + "LIMIT "+fromRow+","+toRow+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("accStatus", Hibernate.STRING)
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
                .setResultTransformer(Transformers.aliasToBean(VendorCreditNoteTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public void updateAccSpv(VendorCreditNote vendorCreditNote, List<VendorCreditNoteDetail> listVendorCreditNoteDetail, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            vendorCreditNote.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorCreditNote.setUpdatedDate(new Date());
            if(vendorCreditNote.getDiscountAccount().getCode().equals("")){
                vendorCreditNote.setDiscountAccount(null);
            }
            hbmSession.hSession.saveOrUpdate(vendorCreditNote);
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM "+VendorCreditNoteDetailField.BEAN_NAME+" WHERE "+VendorCreditNoteDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", vendorCreditNote.getCode())
                    .executeUpdate();
            
            if(listVendorCreditNoteDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(VendorCreditNoteDetail detail : listVendorCreditNoteDetail){
                                                            
                String detailCode = vendorCreditNote.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(vendorCreditNote.getCode());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                    
                hbmSession.hSession.save(detail);
        
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    vendorCreditNote.getCode(), ""));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
}

    

