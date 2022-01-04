package com.inkombizz.finance.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
//import com.inkombizz.finance.bll.VendorInvoiceBLL;
//import com.inkombizz.finance.bll.VendorInvoicePostingBLL;
//import com.inkombizz.finance.model.DocumentBudgetTemp;
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

import com.inkombizz.finance.model.PaymentRequest;
import com.inkombizz.finance.model.PaymentRequestDetail;
import com.inkombizz.finance.model.PaymentRequestDetailTemp;
import com.inkombizz.finance.model.PaymentRequestTemp;
//import com.inkombizz.finance.model.VendorInvoice;
//import com.inkombizz.finance.model.VendorInvoicePosting;
//import com.inkombizz.purchasing.model.PurchaseOrderDetailTemp;
//import com.inkombizz.purchasing.model.PurchaseOrderTemp;
//import com.inkombizz.purchasing.model.PurchaseRequestActivityLog;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Locale;

public class PaymentRequestDAO{
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();
    public PaymentRequestDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String refNo,String remark,Date firstDate, Date lastDate){
        try{
                        
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_payment_request_list_count(:prmCode,"
                        + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate)")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmRefNo", "%"+refNo+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataPayment(String code, String transactionType, String requestType, String currencyCode){
        try{
                        
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                +  "count(fin_payment_request.Code) "
                +  "FROM fin_payment_request "
                +  "WHERE fin_payment_request.code LIKE :prmCode "
//                +  "AND fin_payment_request.transactionType = :prmTransactionType "
//                +  "AND fin_payment_request.requestType = :prmRequestType "
//                +  "AND fin_payment_request.currencyCode = :prmCurrency "
//                +  "AND fin_payment_request.code NOT IN ("
//                            + "SELECT fin_bank_payment_jn_payment_request.paymentRequestCode "
//                            + "FROM fin_bank_payment_jn_payment_request) "
                +  " ")
                .setParameter("prmCode", "%"+code+"%")
//                .setParameter("prmTransactionType", transactionType)
//                .setParameter("prmRequestType", requestType)
//                .setParameter("prmCurrency", currencyCode)
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataApproval(String code,String paymentTo,String refNo,String remark,String status,Date firstDate, Date lastDate){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "CALL usp_payment_request_approval_list_count(:prmCode,"
                            + ":prmPaymentTo,:prmRefNo,:prmRemark,:prmApprovalStatus,:prmFirstDate,:prmLastDate)")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmPaymentTo", "%"+paymentTo+"%")
                .setParameter("prmRefNo", "%"+refNo+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmApprovalStatus","%"+status+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
        
    public int countDataSearch(String code,String paymentTo,Date firstDate, Date lastDate){
        try{
                        
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_payment_request_search_list_count(:prmCode,:prmPaymentTo,:prmFirstDate,:prmLastDate)")
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmPaymentTo", "%"+paymentTo+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
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
    public int countDataRelease(String code,String releasedStatus,Date fromDate,Date lastDate){
        try{            
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_payment_request_release_list_count(:prmCode,:prmReleasedStatus,:prmFromDate,:prmUpToDate)")
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmReleasedStatus", "%"+releasedStatus+"%")  
            .setParameter("prmFromDate", fromDate)
            .setParameter("prmUpToDate", lastDate)
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public List<PaymentRequestTemp> findDataRelease(String code,String releasedStatus,Date fromDate,Date lastDate,int from, int to) {
        try {   
                        
            List<PaymentRequestTemp> list = (List<PaymentRequestTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_payment_request_release_list(:prmCode,:prmReleasedStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("divisionCode", Hibernate.STRING)
                .addScalar("divisionName", Hibernate.STRING)
                .addScalar("paidStatus", Hibernate.STRING)
                .addScalar("paymentTo", Hibernate.STRING)
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("releasedStatus", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP) 
                .setParameter("prmCode", "%"+code+"%")           
                .setParameter("prmReleasedStatus", "%"+releasedStatus+"%")
                .setParameter("prmFirstDate", fromDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<PaymentRequestTemp> findData(String code,String refNo,String remark,Date firstDate, Date lastDate, int from,int to) {
        try {
                                    
            List<PaymentRequestTemp> list = (List<PaymentRequestTemp>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_payment_request_list(:prmCode,"
                        + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
//                .addScalar("divisionCode", Hibernate.STRING)
//                .addScalar("divisionName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP) 
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("paymentTo", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("approvalStatus", Hibernate.STRING)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmRefNo", "%"+refNo+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PaymentRequestTemp> findDataPayment(String code, String transactionType, String requestType, String currencyCode, int from,int to) {
        try {
            
            List<PaymentRequestTemp> list = (List<PaymentRequestTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                +  "fin_payment_request.code, "
                +  "fin_payment_request.branchCode, "
                +  "fin_payment_request.transactionDate, "
                +  "fin_payment_request.currencyCode, "
                +  "fin_payment_request.totalTransactionAmount, "
                +  "fin_payment_request.transactionType, "
                +  "fin_payment_request.refNo, "
                +  "fin_payment_request.remark "
                +  "FROM fin_payment_request "
                +  "LEFT JOIN(" 
                +  "SELECT fin_bank_payment_jn_payment_request.`PaymentRequestCode`, 'BANK-REQUEST' AS _TYPE FROM fin_bank_payment_jn_payment_request " 
                +  "UNION ALL " 
                +  "SELECT fin_cash_payment_jn_payment_request.`PaymentRequestCode`,'CASH-REQUEST' AS _TYPE FROM fin_cash_payment_jn_payment_request " 
                +  ")AS CASH_BANK_PAYMENT_REQUEST ON fin_payment_request.`Code`=CASH_BANK_PAYMENT_REQUEST.PaymentRequestCode "
                +  "WHERE fin_payment_request.code LIKE :prmCode "
                +  "AND CASH_BANK_PAYMENT_REQUEST.PaymentRequestCode IS NULL "
                +  "AND fin_payment_request.ApprovalStatus = 'APPROVED' "
                +  " ")                   
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP) 
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmCode", "%"+code+"%")
                .setFirstResult(from)
                .setMaxResults(to)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PaymentRequestDetailTemp> findDataPaymentDetail(String code) {
        try {
                                    
            List<PaymentRequestDetailTemp> list = (List<PaymentRequestDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                +  "fin_payment_request_detail.code, "
                +  "fin_payment_request_detail.HeaderCode, "
                +  "fin_payment_request.branchCode AS branchCode, "
                +  "fin_payment_request_detail.DocumentNo, "
                +  "fin_payment_request_detail.DocumentType, "
                +  "fin_payment_request_detail.DocumentBranchCode, "
                +  "fin_payment_request_detail.DepartmentCode, "
                +  "mst_department.Name AS departmentName, "
                +  "fin_payment_request_detail.TransactionStatus, "
                +  "fin_payment_request_detail.ChartOfAccountCode, "
                +  "mst_chart_of_account.name AS chartOfAccountName, "
                +  "fin_payment_request_detail.currencyCode, "
                +  "fin_payment_request_detail.ExchangeRate, "
                +  "fin_payment_request_detail.Debit, "
                +  "(fin_payment_request_detail.ExchangeRate * fin_payment_request_detail.Debit) AS debitIDR, "
                +  "fin_payment_request_detail.Credit, "
                +  "(fin_payment_request_detail.ExchangeRate * fin_payment_request_detail.Credit) AS creditIDR, "
                +  "fin_payment_request_detail.remark "
                +  "FROM fin_payment_request_detail "
                +  "INNER JOIN fin_payment_request ON fin_payment_request.code = fin_payment_request_detail.headerCode "
                +  "INNER JOIN mst_chart_of_account ON mst_chart_of_account.code = fin_payment_request_detail.chartOfAccountCode "
                +  "INNER JOIN mst_department ON mst_department.code = fin_payment_request_detail.departmentCode "
                +  "WHERE fin_payment_request_detail.HeaderCode IN ("+code+") ")                   
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentBranchCode", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)
                .addScalar("transactionStatus", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)    
                .addScalar("debit", Hibernate.BIG_DECIMAL)    
                .addScalar("debitIDR", Hibernate.BIG_DECIMAL)
                .addScalar("credit", Hibernate.BIG_DECIMAL)    
                .addScalar("creditIDR", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
//                    .setParameter("prmCode", code)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PaymentRequestTemp> findDataApproval(String code,String paymentTo,String refNo,String remark,String createdBy,String status,Date firstDate, Date lastDate, int from,int to) {
        try {
                        
            List<PaymentRequestTemp> list = (List<PaymentRequestTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_payment_request_approval_list(:prmCode,"
                            + ":prmPaymentTo,:prmRefNo,:prmRemark,:prmCreatedBy,:prmApprovalStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP) 
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("paymentTo", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("approvalStatus", Hibernate.STRING)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmPaymentTo", "%"+paymentTo+"%")
                .setParameter("prmRefNo", "%"+refNo+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmCreatedBy", "%"+createdBy+"%")
                .setParameter("prmApprovalStatus", "%"+status+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
        
    public List<PaymentRequestTemp> findDataSearch(String code,String paymentTo,Date firstDate, Date lastDate, int from,int to) {
        try {
                       
            List<PaymentRequestTemp> list = (List<PaymentRequestTemp>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_payment_request_search_list(:prmCode,:prmPaymentTo,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("divisionCode", Hibernate.STRING)
                .addScalar("divisionName", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)    
                .addScalar("transactionDate", Hibernate.TIMESTAMP) 
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("paymentTo", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("approvalStatus", Hibernate.STRING)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("paymentCode", Hibernate.STRING)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmPaymentTo", "%"+paymentTo+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", to)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public PaymentRequestTemp findData(String code) {
        try {
                                   
            PaymentRequestTemp paymentRequestTemp = (PaymentRequestTemp)hbmSession.hSession.createSQLQuery(
                "SELECT   "
            + "	fin_payment_request.code,  "
            + "	fin_payment_request.branchCode,  "
            + "	mst_branch.Name AS branchName,  "
            + "	fin_payment_request.DivisionCode,  "
            + "	mst_division.Name AS DivisionName,  "
            + "	fin_payment_request.transactionDate,  "
            + "	fin_payment_request.TransactionType,  "
            + "	fin_payment_request.paymentTo,  "
            + "	fin_payment_request.currencyCode,  "
            + "	mst_currency.name AS currencyName,  "
            + "	fin_payment_request.totalTransactionAmount,  "
            + "	fin_payment_request.refNo,  "
            + "	fin_payment_request.remark, "
            + "	IFNULL(data_payment.PaymentCode,'')AS PaymentCode "
            + "FROM fin_payment_request  "
            + "INNER JOIN mst_branch ON fin_payment_request.BranchCode=mst_branch.code  "
            + "INNER JOIN mst_division ON fin_payment_request.DivisionCode=mst_division.Code "
            + "INNER JOIN mst_currency ON fin_payment_request.CurrencyCode=mst_currency.code  "
            + "LEFT JOIN( "
            + "	SELECT fin_cash_payment.Code AS PaymentCode,fin_cash_payment.PaymentRequestCode FROM fin_cash_payment "
            + "	UNION ALL "
            + "	SELECT fin_bank_payment.Code AS PaymentCode,fin_bank_payment.PaymentRequestCode FROM fin_bank_payment "
            + ")AS data_payment ON fin_payment_request.Code=data_payment.PaymentRequestCode "
            + "WHERE fin_payment_request.code=:prmCode  "
            + "AND fin_payment_request.ApprovalStatus='Approved'")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("divisionCode", Hibernate.STRING)
                .addScalar("divisionName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("transactionType", Hibernate.STRING)
                .addScalar("paymentTo", Hibernate.STRING)  
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("paymentCode", Hibernate.STRING)
                .setParameter("prmCode", code)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestTemp.class))
                .uniqueResult(); 
                 
                return paymentRequestTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     public void isReleasedStatus(String code) throws Exception{
        try {
            String _status = (String)hbmSession.hSession.createSQLQuery(
                "SELECT "
            + "CASE "
            + "WHEN fin_payment_request.ReleasedStatus='RELEASED' THEN 'RELEASED' "
            + "ELSE 'ERROR' "
            + "END AS _status "
            + "FROM fin_payment_request "
            + "WHERE fin_payment_request.Code='"+code+"'"
            ).uniqueResult();
            
                        
            if(_status.equals("RELEASED")){
                throw new Exception("This Transaction has been RELEASED!");
            }
            
            
        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
      public String paymentRequestReleased(String code){
        try{
            String temp = (String) hbmSession.hSession.createSQLQuery(""
                    + "SELECT fin_payment_request.ReleasedStatus "
                    + "FROM fin_payment_request "
                    + "WHERE fin_payment_request.Code = :prmCode ")
                    .setParameter("prmCode", code)
                    .uniqueResult().toString();
            
            return temp;
        }catch(HibernateException e){
            return "ERROR";
        }catch(Exception e){
            return "ERROR";   
        }
    }
    public List<PaymentRequestDetailTemp> findDataDetail(String headerCode) {
        try {
            
            List<PaymentRequestDetailTemp> list = (List<PaymentRequestDetailTemp>)hbmSession.hSession.createSQLQuery(
              "CALL usp_payment_request_detail_list(:prmHeaderCode)")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("documentType", Hibernate.STRING)
                .addScalar("documentBranchCode", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("documentAmount", Hibernate.BIG_DECIMAL)
                .addScalar("documentBalanceAmount", Hibernate.BIG_DECIMAL)
                .addScalar("transactionStatus", Hibernate.STRING)
                .addScalar("debit", Hibernate.BIG_DECIMAL)
                .addScalar("credit", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode",headerCode)
                .setResultTransformer(Transformers.aliasToBean(PaymentRequestDetailTemp.class))
                .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }    
    private String createCode(PaymentRequest paymentRequest){
        try{

            String tempKode =paymentRequest.getBranch().getCode()+"/"+"PYM-RQ"+"/"+EnumTransactionType.ENUM_TransactionType.PRQ.toString();
            String acronim = tempKode+AutoNumber.formatingDate(paymentRequest.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(PaymentRequest.class)
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
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_5);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(PaymentRequest paymentRequest, List<PaymentRequestDetail> listPaymentRequestDetail,String moduleCode) throws Exception {
        try {

            
            String headerCode=createCode(paymentRequest);
            paymentRequest.setCode(headerCode);
            
            hbmSession.hSession.beginTransaction();
            
            paymentRequest.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            paymentRequest.setCreatedDate(new Date());
            
//            if ("".equals(paymentRequest.getApprovalReason().getCode())) {
//                paymentRequest.setApprovalReason(null);
//            }
            
            hbmSession.hSession.save(paymentRequest);
            
//            if(listPaymentRequestDetail==null){
//                hbmSession.hTransaction.rollback();
//                throw new Exception("FAILED DATA DETAIL INPUT!");
//            }
            
            
            int i = 1;
            for(PaymentRequestDetail detail : listPaymentRequestDetail){
                                                            
                String detailCode = headerCode+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(headerCode);
                                    
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
                                                                    paymentRequest.getCode(), ""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(PaymentRequest paymentRequest, List<PaymentRequestDetail> listPaymentRequestDetail, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
                             
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_payment_request_detail WHERE fin_payment_request_detail.HeaderCode = '" + paymentRequest.getCode() + "'")
                    .executeUpdate();
            
            paymentRequest.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            paymentRequest.setUpdatedDate(new Date());
            hbmSession.hSession.update(paymentRequest);
                        
            // insert detail
            
            if(listPaymentRequestDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
            
            try{
                int i = 1;
                for(PaymentRequestDetail detail : listPaymentRequestDetail){

                    String detailCode = paymentRequest.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    detail.setCode(detailCode);
                    detail.setHeaderCode(paymentRequest.getCode());

                    detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    detail.setCreatedDate(new Date());
                    detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                    detail.setUpdatedDate(new Date());

                    hbmSession.hSession.save(detail);
                    
                    i++;
                }
            }catch (HibernateException e) {
                e.printStackTrace();
                hbmSession.hTransaction.rollback();
                throw e;
            }
            
                        
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    paymentRequest.getCode(), ""));
            
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
    
    public void delete(String headerCode, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            // delete dulu yg existing
//            hbmSession.hSession.createQuery("DELETE FROM PurchaseRequestActivityLog WHERE Code LIKE :prmCode")
//                .setParameter("prmCode", "%" + headerCode + "%")
//                .executeUpdate();
//            hbmSession.hSession.flush();
                                  
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_payment_request_detail WHERE fin_payment_request_detail.HeaderCode = '" + headerCode + "'")
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createSQLQuery("DELETE FROM fin_payment_request WHERE fin_payment_request.code = '" + headerCode + "'")
                    .executeUpdate();
            hbmSession.hSession.flush();
            
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
    
    public void approval(PaymentRequest paymentRequest,String moduleCode) throws Exception {
        try {
            
//            String approvalBy="";
//            Date approvalDate=commonFunction.setDateTime("01/01/1900 00:00:00");
                        
//            if(paymentRequest.getApprovalStatus().equals(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED.toString())){
//                approvalBy=BaseSession.loadProgramSession().getUserName();
//                approvalDate=new Date();
//            }

            String approvalBy = BaseSession.loadProgramSession().getUserName();
            Date approvalDate = new Date();
            
            String prmActivity = "";
            if ("APPROVED".equals(paymentRequest.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.GRANTED);
            }else if ("REJECTED".equals(paymentRequest.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.REFUSED);
            }
            
            hbmSession.hSession.beginTransaction();
            
            // ambil detail Finance Request
            List<PaymentRequestDetailTemp> listPaymentRequestDetailTemp = findDataDetail(paymentRequest.getCode());
            
            for(PaymentRequestDetailTemp detail : listPaymentRequestDetailTemp){
                
            }
            
            paymentRequest.setApprovalBy(approvalBy);
            paymentRequest.setApprovalDate(approvalDate);
            hbmSession.hSession.update(paymentRequest);
                        
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    paymentRequest.getCode(), "Approval - Finance Request"));
            
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
    
//    public void paid(PaymentRequest paymentRequest,String moduleCode) throws Exception {
//        try {
//            
//            
//            hbmSession.hSession.beginTransaction();
//            
//            String strQuery="UPDATE fin_payment_request SET "
//                + "fin_payment_request.PaidStatus ='"+paymentRequest.getPaidStatus() +"', "
//                + "fin_payment_request.Remark='"+paymentRequest.getRemark() +"' "
//                + "WHERE fin_payment_request.Code ='"+paymentRequest.getCode()+"'";
//            hbmSession.hSession.createSQLQuery(strQuery
//                    )
//                .executeUpdate();
//                        
//            //insert transaction log
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
//                                                                    paymentRequest.getCode(), "Paid - payment Request"));
//            
//            hbmSession.hTransaction.commit();
//            hbmSession.hSession.clear();
//            hbmSession.hSession.close();
//                      
//        }
//        catch (HibernateException e) {
//            e.printStackTrace();
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
        
    public Boolean isApproved(String code) throws Exception{
        try {
            String approvedStatus = (String)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "CASE WHEN fin_payment_request.ApprovalStatus='PENDING' THEN "
                + "'PENDING' "
                + "WHEN fin_payment_request.ApprovalStatus='APPROVED' THEN "
                + "'APPROVED' "
                + "ELSE "
                + "'ERORR' "
                + "END AS ApprovalStatus "
                + "FROM fin_payment_request "
                + "WHERE fin_payment_request.Code='"+code+"'"
            ).uniqueResult();
            
            if(approvedStatus.equals("APPROVED")){
                return Boolean.TRUE;
            }
            
            return Boolean.FALSE;
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    public PaymentRequest get(String code) {
        try {
               return (PaymentRequest) hbmSession.hSession.get(PaymentRequest.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
}