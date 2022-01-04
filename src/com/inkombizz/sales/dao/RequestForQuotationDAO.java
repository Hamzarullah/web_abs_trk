/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.dao;

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
import com.inkombizz.sales.model.RequestForQuotation;
import com.inkombizz.sales.model.RequestForQuotationField;
import com.inkombizz.sales.model.RequestForQuotationTemp;
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


public class RequestForQuotationDAO {

   private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();
    
    public RequestForQuotationDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String rfqNoCode, String tenderNo, String customerCode, String customerName,
                         String subject, String projectCode, String active, String endUserCode, 
                         String endUserName, String refNo, String remark,
                         String approvalStatus, Date firstDate,Date lastDate){
        try{
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND sal_request_for_quotation.ValidStatus="+active+" ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(sal_request_for_quotation.Code) "
                + "FROM sal_request_for_quotation "
                + "INNER JOIN mst_customer ON sal_request_for_quotation.customerCode = mst_customer.Code "
                + "INNER JOIN mst_customer EndUser ON sal_request_for_quotation.EndUserCode = EndUser.Code "
                + "INNER JOIN mst_currency ON sal_request_for_quotation.CurrencyCode = mst_currency.Code "
                + "INNER JOIN mst_branch ON sal_request_for_quotation.branchCode = mst_branch.Code "
                + "INNER JOIN mst_sales_person ON sal_request_for_quotation.salesPersonCode = mst_sales_person.Code "
                + "LEFT JOIN mst_project ON sal_request_for_quotation.ProjectCode = mst_project.Code "
                + "LEFT JOIN mst_reason ON sal_request_for_quotation.ApprovalReasonCode = mst_reason.Code "
                + "WHERE sal_request_for_quotation.Code LIKE '%"+rfqNoCode+"%' "
                + "AND sal_request_for_quotation.tenderNo LIKE '%"+tenderNo+"%' "
                + "AND sal_request_for_quotation.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND sal_request_for_quotation.endUserCode LIKE '%"+endUserCode+"%' "
                + "AND EndUser.name LIKE '%"+endUserName+"%' "
                + "AND sal_request_for_quotation.ProjectCode LIKE '%"+projectCode+"%' "
                + "AND sal_request_for_quotation.Subject LIKE '%"+subject+"%' "
                + "AND sal_request_for_quotation.RefNo LIKE '%"+refNo+"%' "
                + "AND sal_request_for_quotation.Remark LIKE '%"+remark+"%' "
                + "AND sal_request_for_quotation.ApprovalStatus LIKE '%"+approvalStatus+"%' "
                + concat_qry  
                + "AND DATE(DATE(sal_request_for_quotation.TransactionDate)) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'").uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<RequestForQuotationTemp> findByCriteria(String rfqNoCode, String tenderNo, String customerCode, 
                                                        String customerName, String subject, String projectCode, 
                                                        String active,String endUserCode, String endUserName, 
                                                        String refNo, String remark, String approvalStatus, 
                                                        Date firstDate,Date lastDate,int from,int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
           
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND sal_request_for_quotation.ValidStatus="+active+" ";
            }
            
            List<RequestForQuotationTemp> list = (List<RequestForQuotationTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "sal_request_for_quotation.Code, "
                + "sal_request_for_quotation.RFQNo, "
                + "sal_request_for_quotation.Revision, "
                + "sal_request_for_quotation.RefRFQCode, "
                + "sal_request_for_quotation.TenderNo, "
                + "sal_request_for_quotation.OrderStatus, "
                + "CASE "
                        +"WHEN sal_request_for_quotation.OrderStatus = 'SALES_ORDER' THEN 'SALES ORDER' "
                        +"WHEN sal_request_for_quotation.OrderStatus = 'BLANKET_ORDER' THEN 'BLANKET ORDER' "
                +   "END AS OrderStatus, "
                + "sal_request_for_quotation.BranchCode, "
                + "mst_branch.name AS branchName, "
                + "sal_request_for_quotation.TransactionDate, "
                + "sal_request_for_quotation.RegisteredDate, "
                + "CASE " 
                        +"WHEN sal_request_for_quotation.ReviewedStatus = 1 THEN 'YES' " 
                        +"WHEN sal_request_for_quotation.ReviewedStatus = 0 THEN 'NO' " 
                + "END AS ReviewedStatus, " 
                + "CASE " 
                        +"WHEN sal_request_for_quotation.ValidStatus = 1 THEN 'YES' " 
                        +"WHEN sal_request_for_quotation.ValidStatus = 0 THEN 'NO' " 
                    +"END AS ValidStatus, "        
                + "sal_request_for_quotation.PreBidMeetingDate, "
                + "sal_request_for_quotation.SendToFactoryDate, "
                + "sal_request_for_quotation.SubmittedDate AS submittedDateToCustomer, "
                + "sal_request_for_quotation.ScopeOfSupply, "
                + "sal_request_for_quotation.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "sal_request_for_quotation.customerCode, "
                + "mst_customer.name AS customerName, "
                + "sal_request_for_quotation.endUserCode, "
                + "EndUser.name AS endUserName, "
                + "sal_request_for_quotation.Attn, "
                + "sal_request_for_quotation.SalesPersonCode, "
                + "mst_sales_person.name AS SalesPersonName, "
                + "sal_request_for_quotation.ProjectCode, "
                + "mst_project.name AS projectName, "
                + "sal_request_for_quotation.Subject, "
                + "sal_request_for_quotation.RefNo, "
                + "sal_request_for_quotation.Remark, "
                + "sal_request_for_quotation.approvalStatus "
                + "FROM sal_request_for_quotation "
                + "INNER JOIN mst_customer ON sal_request_for_quotation.customerCode = mst_customer.Code "
                + "INNER JOIN mst_customer EndUser ON sal_request_for_quotation.EndUserCode = EndUser.Code "
                + "INNER JOIN mst_currency ON sal_request_for_quotation.CurrencyCode = mst_currency.Code "
                + "INNER JOIN mst_branch ON sal_request_for_quotation.branchCode = mst_branch.Code "
                + "INNER JOIN mst_sales_person ON sal_request_for_quotation.salesPersonCode = mst_sales_person.Code "
                + "LEFT JOIN mst_project ON sal_request_for_quotation.ProjectCode = mst_project.Code "
                + "WHERE sal_request_for_quotation.Code LIKE '%"+rfqNoCode+"%' "
                + "AND sal_request_for_quotation.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND sal_request_for_quotation.endUserCode LIKE '%"+endUserCode+"%' "
                + "AND EndUser.name LIKE '%"+endUserName+"%' "
                + "AND sal_request_for_quotation.tenderNo LIKE '%"+tenderNo+"%' "
                + "AND sal_request_for_quotation.ProjectCode LIKE '%"+projectCode+"%' "
                + "AND sal_request_for_quotation.Subject LIKE '%"+subject+"%' "
                + "AND sal_request_for_quotation.RefNo LIKE '%"+refNo+"%' "
                + "AND sal_request_for_quotation.Remark LIKE '%"+remark+"%' "
                + "AND sal_request_for_quotation.ApprovalStatus LIKE '%"+approvalStatus+"%' "
                + "AND DATE(sal_request_for_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'"
                + concat_qry         
                + "ORDER BY sal_request_for_quotation.TransactionDate DESC,sal_request_for_quotation.Code DESC "
                + "LIMIT "+from+","+to+"")

                .addScalar("code", Hibernate.STRING)
                .addScalar("rfqNo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refRfqCode", Hibernate.STRING)
                .addScalar("tenderNo", Hibernate.STRING)
                .addScalar("orderStatus", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("registeredDate", Hibernate.TIMESTAMP)     
                .addScalar("reviewedStatus", Hibernate.STRING) 
                .addScalar("preBidMeetingDate", Hibernate.TIMESTAMP) 
                .addScalar("sendToFactoryDate", Hibernate.TIMESTAMP) 
                .addScalar("submittedDateToCustomer", Hibernate.TIMESTAMP) 
                .addScalar("scopeOfSupply", Hibernate.STRING) 
                .addScalar("currencyCode", Hibernate.STRING) 
                .addScalar("currencyName", Hibernate.STRING) 
                .addScalar("customerCode", Hibernate.STRING)   
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)   
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("attn", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("subject", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(RequestForQuotationTemp.class))
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
    
    public int countDataApproval(String code,String tenderNo,String customerCode,String customerName,
                                 String projectCode, String subject,String approvalStatus,
                                 String validStatus,String endUserCode, String endUserName, 
                                 String refNo, String remark, Date fromDate,Date upToDate){
        try{            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            String dateFirst = DATE_FORMAT.format(fromDate);
            String dateLast = DATE_FORMAT.format(upToDate);
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_sales_request_for_quotation_approval_list_count(:prmCode,:prmTenderNo,:prmCustomerCode,:prmCustomerName,:prmProjectCode,:prmSubject,:prmApprovalStatus,:prmValidStatus,:prmEndUserCode,:prmEndUserName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate)")
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmTenderNo", "%"+tenderNo+"%")
            .setParameter("prmCustomerCode", "%"+customerCode+"%")
            .setParameter("prmCustomerName", "%"+customerName+"%")
            .setParameter("prmProjectCode", "%"+projectCode+"%")  
            .setParameter("prmSubject", "%"+subject+"%")  
            .setParameter("prmApprovalStatus", "%"+approvalStatus+"%")
            .setParameter("prmValidStatus", validStatus)
            .setParameter("prmEndUserCode", "%"+endUserCode+"%")
            .setParameter("prmEndUserName", "%"+endUserName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmRemark", "%"+remark+"%")
            .setParameter("prmFirstDate", dateFirst)
            .setParameter("prmLastDate", dateLast)
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<RequestForQuotationTemp> findDataApproval(String code, String tenderNo, String customerCode, 
                                                          String customerName, String projectCode, String subject, 
                                                          String approvalStatus, String validStatus, String endUserCode, 
                                                          String endUserName, String refNo, String remark,
                                                          Date fromDate,Date upToDate,int from, int to) {
        try {   
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(fromDate);
            String dateLast = DATE_FORMAT.format(upToDate);
            
            List<RequestForQuotationTemp> list = (List<RequestForQuotationTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_sales_request_for_quotation_approval_list(:prmCode,:prmTenderNo,:prmCustomerCode,:prmCustomerName,"
                                                                    + ":prmProjectCode,:prmSubject,:prmApprovalStatus,:prmValidStatus,"
                                                                    + ":prmEndUserCode,:prmEndUserName,:prmRefNo,:prmRemark,"
                                                                    + ":prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("rfqNo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refRfqCode", Hibernate.STRING)
                .addScalar("tenderNo", Hibernate.STRING)
                .addScalar("orderStatus", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("registeredDate", Hibernate.TIMESTAMP)     
                .addScalar("reviewedStatus", Hibernate.STRING) 
                .addScalar("preBidMeetingDate", Hibernate.TIMESTAMP) 
                .addScalar("sendToFactoryDate", Hibernate.TIMESTAMP) 
                .addScalar("submittedDateToCustomer", Hibernate.TIMESTAMP) 
                .addScalar("scopeOfSupply", Hibernate.STRING) 
                .addScalar("currencyCode", Hibernate.STRING) 
                .addScalar("currencyName", Hibernate.STRING) 
                .addScalar("customerCode", Hibernate.STRING)   
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)   
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("attn", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("subject", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("approvalRemark", Hibernate.STRING)    
                .addScalar("approvalReasonCode", Hibernate.STRING)
                .addScalar("approvalReasonName", Hibernate.STRING)
                .addScalar("rfqCode", Hibernate.STRING)
                
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmTenderNo", "%"+tenderNo+"%")
                .setParameter("prmCustomerCode", "%"+customerCode+"%")
                .setParameter("prmCustomerName", "%"+customerName+"%")
                .setParameter("prmProjectCode", "%"+projectCode+"%")  
                .setParameter("prmSubject", "%"+subject+"%")  
                .setParameter("prmApprovalStatus", "%"+approvalStatus+"%")
                .setParameter("prmValidStatus", validStatus)
                .setParameter("prmEndUserCode", "%"+endUserCode+"%")
                .setParameter("prmEndUserName", "%"+endUserName+"%")
                .setParameter("prmRefNo", "%"+refNo+"%")
                .setParameter("prmRemark", "%"+remark+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(RequestForQuotationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    Closing
    public int countDataClosing(String code,String tenderNo,String customerCode,String customerName,String projectCode, String subject,String closingStatus, String endUserCode, String endUserName, Date fromDate,Date upToDate){
        try{            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            String dateFirst = DATE_FORMAT.format(fromDate);
            String dateLast = DATE_FORMAT.format(upToDate);
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_sales_request_for_quotation_closing_list_count(:prmCode,:prmTenderNo,:prmCustomerCode,:prmCustomerName,:prmProjectCode,:prmSubject,:prmClosingStatus,:prmEndUserCode,:prmEndUserName,:prmFirstDate,:prmLastDate)")
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmTenderNo", "%"+tenderNo+"%")
            .setParameter("prmCustomerCode", "%"+customerCode+"%")
            .setParameter("prmCustomerName", "%"+customerName+"%")
            .setParameter("prmProjectCode", "%"+projectCode+"%")  
            .setParameter("prmSubject", "%"+subject+"%")  
            .setParameter("prmClosingStatus", "%"+closingStatus+"%")
            .setParameter("prmEndUserCode", "%"+endUserCode+"%")
            .setParameter("prmEndUserName", "%"+endUserName+"%")
            .setParameter("prmFirstDate", dateFirst)
            .setParameter("prmLastDate", dateLast)
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<RequestForQuotationTemp> findDataClosing(String code,String tenderNo,String customerCode,String customerName,String projectCode, String subject, String closingStatus,String endUserCode, String endUserName,Date fromDate,Date upToDate,int from, int to) {
        try {   
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(fromDate);
            String dateLast = DATE_FORMAT.format(upToDate);
            
            List<RequestForQuotationTemp> list = (List<RequestForQuotationTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_sales_request_for_quotation_closing_list(:prmCode,:prmTenderNo,:prmCustomerCode,:prmCustomerName,:prmProjectCode,:prmSubject,:prmClosingStatus,:prmEndUserCode,:prmEndUserName,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")
                .addScalar("code", Hibernate.STRING)
                .addScalar("rfqNo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refRfqCode", Hibernate.STRING)
                .addScalar("tenderNo", Hibernate.STRING)
                .addScalar("orderStatus", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("registeredDate", Hibernate.TIMESTAMP)     
                .addScalar("reviewedStatus", Hibernate.STRING) 
                .addScalar("preBidMeetingDate", Hibernate.TIMESTAMP) 
                .addScalar("sendToFactoryDate", Hibernate.TIMESTAMP) 
                .addScalar("submittedDateToCustomer", Hibernate.TIMESTAMP) 
                .addScalar("scopeOfSupply", Hibernate.STRING) 
                .addScalar("currencyCode", Hibernate.STRING) 
                .addScalar("currencyName", Hibernate.STRING) 
                .addScalar("customerCode", Hibernate.STRING)   
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)   
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("attn", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("subject", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmTenderNo", "%"+tenderNo+"%")
                .setParameter("prmCustomerCode", "%"+customerCode+"%")
                .setParameter("prmCustomerName", "%"+customerName+"%")
                .setParameter("prmProjectCode", "%"+projectCode+"%")  
                .setParameter("prmSubject", "%"+subject+"%")  
                .setParameter("prmClosingStatus", "%"+closingStatus+"%")
                .setParameter("prmEndUserCode", "%"+endUserCode+"%")
                .setParameter("prmEndUserName", "%"+endUserName+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(RequestForQuotationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    Search
    public int countRFQData(String code, Date firstDate,Date lastDate){
        try{
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(sal_request_for_quotation.Code) "
                + "FROM sal_request_for_quotation "
                + "INNER JOIN mst_customer ON sal_request_for_quotation.customerCode = mst_customer.Code "
                + "INNER JOIN mst_customer EndUser ON sal_request_for_quotation.EndUserCode = EndUser.Code "
                + "INNER JOIN mst_currency ON sal_request_for_quotation.CurrencyCode = mst_currency.Code "
                + "INNER JOIN mst_branch ON sal_request_for_quotation.branchCode = mst_branch.Code "
                + "INNER JOIN mst_sales_person ON sal_request_for_quotation.salesPersonCode = mst_sales_person.Code "
                + "LEFT JOIN mst_project ON sal_request_for_quotation.ProjectCode = mst_project.Code "
                + "WHERE sal_request_for_quotation.Code LIKE '%"+code+"%' "
                + "AND sal_request_for_quotation.validStatus = TRUE "
                + "AND sal_request_for_quotation.approvalStatus = 'APPROVED' "
                + "AND DATE(sal_request_for_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'").uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
      public List<RequestForQuotationTemp> findRFQ(String code, Date firstDate,Date lastDate,int from,int to) {
        try {
                        
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
           
            
            List<RequestForQuotationTemp> list = (List<RequestForQuotationTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "sal_request_for_quotation.Code, "
                + "sal_request_for_quotation.RFQNo, "
                + "sal_request_for_quotation.Revision, "
                + "sal_request_for_quotation.RefRFQCode, "
                + "sal_request_for_quotation.TenderNo, "
                + "sal_request_for_quotation.OrderStatus, "
                + "sal_request_for_quotation.BranchCode, "
                + "mst_branch.name AS branchName, "
                + "sal_request_for_quotation.TransactionDate, "
                + "sal_request_for_quotation.RegisteredDate, "
                + "sal_request_for_quotation.ReviewedStatus AS ReviewedStatusRfq, "
                + "sal_request_for_quotation.PreBidMeetingDate, "
                + "sal_request_for_quotation.SendToFactoryDate, "
                + "sal_request_for_quotation.SubmittedDate AS submittedDateToCustomer, "
                + "sal_request_for_quotation.ScopeOfSupply, "
                + "sal_request_for_quotation.currencyCode, "
                + "mst_currency.name AS currencyName, "
                + "sal_request_for_quotation.customerCode, "
                + "mst_customer.name AS customerName, "
                + "sal_request_for_quotation.endUserCode, "
                + "EndUser.name AS endUserName, "
                + "sal_request_for_quotation.Attn, "
                + "sal_request_for_quotation.SalesPersonCode, "
                + "mst_sales_person.name AS SalesPersonName, "
                + "sal_request_for_quotation.ProjectCode, "
                + "mst_project.name AS projectName, "
                + "sal_request_for_quotation.Subject, "
                + "sal_request_for_quotation.RefNo, "
                + "sal_request_for_quotation.ValidStatus AS validStatusRfq, "
                + "sal_request_for_quotation.Remark, "
                + "sal_request_for_quotation.approvalStatus, "
                + "sal_request_for_quotation.closingStatus "
                + "FROM sal_request_for_quotation "
                + "INNER JOIN mst_customer ON sal_request_for_quotation.customerCode = mst_customer.Code "
                + "INNER JOIN mst_customer EndUser ON sal_request_for_quotation.EndUserCode = EndUser.Code "
                + "INNER JOIN mst_currency ON sal_request_for_quotation.CurrencyCode = mst_currency.Code "
                + "INNER JOIN mst_branch ON sal_request_for_quotation.branchCode = mst_branch.Code "
                + "INNER JOIN mst_sales_person ON sal_request_for_quotation.salesPersonCode = mst_sales_person.Code "
                + "LEFT JOIN mst_project ON sal_request_for_quotation.ProjectCode = mst_project.Code "
                + "WHERE sal_request_for_quotation.Code LIKE '%"+code+"%' "
                + "AND sal_request_for_quotation.validStatus = TRUE "
                + "AND sal_request_for_quotation.ApprovalStatus = 'APPROVED' "
                + "AND sal_request_for_quotation.ClosingStatus = 'OPEN' "
                + "AND DATE(sal_request_for_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"'" 
                + "ORDER BY sal_request_for_quotation.Code ASC "
                + "LIMIT "+from+","+to+"")

                .addScalar("code", Hibernate.STRING)
                .addScalar("rfqNo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refRfqCode", Hibernate.STRING)
                .addScalar("tenderNo", Hibernate.STRING)
                .addScalar("orderStatus", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("registeredDate", Hibernate.TIMESTAMP)     
                .addScalar("validStatusRfq", Hibernate.BOOLEAN) 
                .addScalar("preBidMeetingDate", Hibernate.TIMESTAMP) 
                .addScalar("sendToFactoryDate", Hibernate.TIMESTAMP) 
                .addScalar("submittedDateToCustomer", Hibernate.TIMESTAMP) 
                .addScalar("scopeOfSupply", Hibernate.STRING) 
                .addScalar("currencyCode", Hibernate.STRING) 
                .addScalar("currencyName", Hibernate.STRING) 
                .addScalar("customerCode", Hibernate.STRING)   
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)   
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("attn", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("subject", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("reviewedStatusRfq", Hibernate.BOOLEAN)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(RequestForQuotationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
       
    public RequestForQuotation get(String code) {
        try {
               return (RequestForQuotation) hbmSession.hSession.get(RequestForQuotation.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public RequestForQuotationTemp check(String code) {

        try {
               RequestForQuotationTemp requestForQuotationTemp = (RequestForQuotationTemp) hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "sal_request_for_quotation.Code "
                + "FROM sal_request_for_quotation "
                + "INNER JOIN sal_sales_quotation ON sal_sales_quotation.rfqCode = sal_request_for_quotation.Code "
                + "WHERE sal_request_for_quotation.code ='"+code+"' "
                + "")
                       
                .addScalar("code", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(RequestForQuotationTemp.class))
                .uniqueResult(); 
                 
                return requestForQuotationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(RequestForQuotation requestForQuotation){        
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.RFQ.toString();
            String tempKode1 = EnumTransactionType.ENUM_TransactionType.REV.toString();
            String acronim =  "/"+tempKode+"/"+AutoNumber.getYear(requestForQuotation.getTransactionDate(), true)+"_"+tempKode1;

            DetachedCriteria dc = DetachedCriteria.forClass(RequestForQuotation.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%"+ acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                    if (list.size() > 0)
                        if(list.get(0) != null){
                            String oldID1=list.get(0).toString();
                            oldID=oldID1.split("[.]")[0];
//                            String[] id = iddata.split(".");
//                            oldID = 
                        }
                            
                }
            return AutoNumber.generateCode(AutoNumber.DEFAULT_TRANSACTION_LENGTH_4, acronim, oldID)+".00";
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public String createReviseCode(RequestForQuotation requestForQuotation){        
        try{
            String acronim =  requestForQuotation.getCode().split("[.]")[0]+".";

            DetachedCriteria dc = DetachedCriteria.forClass(RequestForQuotation.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                    if (list.size() > 0)
                        if(list.get(0) != null){
                            oldID=list.get(0).toString();
                        }
                            
                }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_2);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
     public void save(RequestForQuotation requestForQuotation,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            requestForQuotation.setCode(createCode(requestForQuotation));
            requestForQuotation.setRfqNo(requestForQuotation.getCode().split("[.]")[0]);
            requestForQuotation.setRevision("00");
            
            requestForQuotation.setValidStatus(true);
            requestForQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            requestForQuotation.setCreatedDate(new Date());
            
            hbmSession.hSession.save(requestForQuotation);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), requestForQuotation.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
     
     public void saveRevise(RequestForQuotation requestForQuotation,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery("UPDATE FROM " + RequestForQuotationField.BEAN_NAME + "  " +
                                            "SET " + RequestForQuotationField.VALIDSTATUS +"= :prmValidStatus  " + 
                                            "WHERE " + RequestForQuotationField.CODE + " = :prmCode")
                    .setParameter("prmValidStatus", false)
                    .setParameter("prmCode", requestForQuotation.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            requestForQuotation.setRefRfqCode(requestForQuotation.getCode());
            requestForQuotation.setCode(createReviseCode(requestForQuotation));
            requestForQuotation.setRfqNo(requestForQuotation.getCode().split("[_]")[0]);
            requestForQuotation.setValidStatus(true);
            requestForQuotation.setRevision(requestForQuotation.getCode().split("[.]")[1]);
            
            requestForQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            requestForQuotation.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(requestForQuotation);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), requestForQuotation.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
     
     public void update(RequestForQuotation requestForQuotation,String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            requestForQuotation.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            requestForQuotation.setUpdatedDate(new Date()); 
            requestForQuotation.setValidStatus(true);
            
            hbmSession.hSession.update(requestForQuotation);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), requestForQuotation.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
     
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery("DELETE FROM " + RequestForQuotationField.BEAN_NAME + " WHERE " + RequestForQuotationField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void approval(RequestForQuotation requestForQuotation,String moduleCode) throws Exception{
        try {
            
            String approvalBy="";
            Date approvalDate=commonFunction.setDateTime("01/01/1900 00:00:00");
                        
            if(requestForQuotation.getApprovalStatus().equals(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED.toString())){
                approvalBy=BaseSession.loadProgramSession().getUserName();
                approvalDate=new Date();
            }

            hbmSession.hSession.beginTransaction();
            
            String prmActivity = "";
            switch(requestForQuotation.getApprovalStatus()){
                    case "APPROVED" :
                        prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.APPROVED);
                        break;
                    case "DECLINED" :
                        prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.DECLINED);
                        break;
                    case "PENDING" :
                        prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.PENDING);
                        break;
            }
//            if ("APPROVED".equals(requestForQuotation.getApprovalStatus())) {
//                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.APPROVED);
//            }else if ("DECLINED".equals(requestForQuotation.getApprovalStatus())) {
//                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.DECLINED);
//            }else if ("PENDING".equals(requestForQuotation.getApprovalStatus())){
//                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.PENDING);
//            }
//            purchaseOrder.setLastStatus(prmActivity);
            requestForQuotation.setApprovalBy(approvalBy);
            requestForQuotation.setApprovalDate(approvalDate);
            //hbmSession.hSession.update(purchaseOrder);
            
            hbmSession.hSession.createQuery("UPDATE RequestForQuotation SET "
                    + "ApprovalStatus = :prmApprovalstatus, "
                    + "ApprovalBy = :prmApprovalBy, "
                    + "ApprovalDate = :prmApprovalDate, "
                    + "ApprovalRemark = :prmApprovalRemark, "
                    + "approvalReason = :prmApprovalReason, "
                    + "PreventiveAction = :prmPreventiveAction "
                    + "WHERE code = :prmCode")
                    .setParameter("prmApprovalstatus", prmActivity)
                    .setParameter("prmApprovalBy", BaseSession.loadProgramSession().getUserName())
                    .setParameter("prmApprovalDate", new Date())
                    .setParameter("prmApprovalRemark", requestForQuotation.getApprovalRemark())
                    .setParameter("prmApprovalReason", requestForQuotation.getApprovalReason())
                    .setParameter("prmCode", requestForQuotation.getCode())
                    .setParameter("prmPreventiveAction", requestForQuotation.getPreventiveAction())
                    .executeUpdate();
            hbmSession.hSession.flush();
           
//           String reason = requestForQuotation.getApprovalReason().getCode();
//            
//           if(reason.equals("")){
//               requestForQuotation.setApprovalReason(saya);
//           }
//            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    requestForQuotation.getCode(), "Approval: "+requestForQuotation.getApprovalStatus()));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.close();
        } catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void closing(RequestForQuotation requestForQuotationClosing, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            RequestForQuotation requestForQuotation = get(requestForQuotationClosing.getCode());
            
            requestForQuotation.setClosingStatus("CLOSED");
            requestForQuotation.setClosingBy(BaseSession.loadProgramSession().getUserName());
            requestForQuotation.setClosingDate(new Date());
                
            hbmSession.hSession.update(requestForQuotation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    requestForQuotation.getApprovalStatus() , 
                                                                    requestForQuotation.getCode(),""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();           
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }
    
}
