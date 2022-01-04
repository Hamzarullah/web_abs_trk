
package com.inkombizz.sales.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ExcelColumnName;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumCellExcellType;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.ErrorMessageImportExcel;
import com.inkombizz.master.dao.ValveTypeComponentDAO;
import com.inkombizz.master.dao.ValveTypeDAO;
import com.inkombizz.master.model.ValveType;
import com.inkombizz.master.model.ValveTypeComponentDetailTemp;
import com.inkombizz.master.model.ValveTypeComponentTemp;
import com.inkombizz.master.model.ValveTypeTemp;
import com.inkombizz.sales.model.SalesQuotation;
import com.inkombizz.sales.model.SalesQuotationDetail;
import com.inkombizz.sales.model.SalesQuotationDetailField;
import com.inkombizz.sales.model.SalesQuotationDetailTemp;
import com.inkombizz.sales.model.SalesQuotationField;
import com.inkombizz.sales.model.SalesQuotationTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import static com.mysql.jdbc.StringUtils.isNullOrEmpty;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import static org.hibernate.criterion.Restrictions.isEmpty;
import org.hibernate.transform.Transformers;


public class SalesQuotationDAO {
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction(); 
    
    public SalesQuotationDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String remark, String refNo, String customerCode,String customerName, String endUserCode, String endUserName, String status, String active, Date firstDate, Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND sal_sales_quotation.ValidStatus="+active+" ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*)  "
                + "FROM sal_sales_quotation "
                + "INNER JOIN mst_city ON sal_sales_quotation.ShipToCode=mst_city.Code "
                + "INNER JOIN mst_term_of_delivery ON sal_sales_quotation.termOfDeliveryCode=mst_term_of_delivery.Code "
                + "INNER JOIN sal_request_for_quotation ON  sal_sales_quotation.`RFQCode` = sal_request_for_quotation.`code` "
                + "LEFT JOIN mst_project ON sal_sales_quotation.projectCode = mst_project.Code "
                + "INNER JOIN mst_branch ON sal_sales_quotation.BranchCode = mst_branch.Code "
                + "INNER JOIN mst_customer ON sal_sales_quotation.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_customer endUser ON sal_sales_quotation.endUserCode = endUser.Code "            
                + "INNER JOIN mst_sales_person ON sal_request_for_quotation.salesPersonCode = mst_sales_person.Code "
                + "WHERE sal_sales_quotation.code LIKE '%"+code+"%' "
                + "AND sal_sales_quotation.Remark LIKE '%"+remark+"%' "        
                + "AND sal_sales_quotation.refNo LIKE '%"+refNo+"%' "        
                + "AND sal_sales_quotation.CustomerCode LIKE '%"+customerCode+"%' "        
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND sal_sales_quotation.endUserCode LIKE '%"+endUserCode+"%' "
                + "AND endUser.name LIKE '%"+endUserName+"%' "       
                + "AND sal_sales_quotation.SALQUOStatus LIKE '%"+status+"%' " 
                + concat_qry          
                + "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' ")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countSearchData(SalesQuotationTemp salesQuotationTemp){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(salesQuotationTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(salesQuotationTemp.getLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(sal_sales_quotation.Code)  " +
                "FROM sal_sales_quotation " +
                "INNER JOIN mst_customer customer ON sal_sales_quotation.CustomerCode=customer.Code " +
                "INNER JOIN mst_customer endUser ON sal_sales_quotation.endUserCode=endUser.Code " +
                "WHERE sal_sales_quotation.CustomerCode='"+salesQuotationTemp.getCustomerCode()+"' " +
                "AND sal_sales_quotation.endUserCode='"+salesQuotationTemp.getEndUserCode()+"' " +
                "AND sal_sales_quotation.SalesPersonCode='"+salesQuotationTemp.getSalesPersonCode()+"' " +
//                "AND sal_sales_quotation.ProjectCode='"+salesQuotationTemp.getProjectCode()+"' " +
                "AND sal_sales_quotation.CurrencyCode='"+salesQuotationTemp.getCurrencyCode()+"' " +
                "AND sal_sales_quotation.BranchCode='"+salesQuotationTemp.getBranchCode()+"' " + 
                "AND sal_sales_quotation.SALQUOStatus='APPROVED' " +
                "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' " +
                "ORDER BY sal_sales_quotation.TransactionDate DESC"
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
   
    public int countDataArray(SalesQuotationTemp salesQuotationTemp, String concat){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(salesQuotationTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(salesQuotationTemp.getLastDate());
            
            String[] x  = concat.split(",");
            String concatTemp = "";
            for(int i = 0; i <x.length; i++){
                if(i == 0){
                    concatTemp += "'" + x[i] + "'";
                }else{
                    concatTemp += ",'" + x[i] + "'";
                }
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(sal_sales_quotation.Code)  " +
                "FROM sal_sales_quotation " +
                "INNER JOIN mst_customer customer ON sal_sales_quotation.CustomerCode=customer.Code " +
                "INNER JOIN mst_customer endUser ON sal_sales_quotation.endUserCode=endUser.Code " +
                "WHERE sal_sales_quotation.CustomerCode='"+salesQuotationTemp.getCustomerCode()+"' " +
                "AND sal_sales_quotation.endUserCode='"+salesQuotationTemp.getEndUserCode()+"' " +
                "AND sal_sales_quotation.SalesPersonCode='"+salesQuotationTemp.getSalesPersonCode()+"' " +
                "AND sal_sales_quotation.ProjectCode='"+salesQuotationTemp.getProjectCode()+"' " +
                "AND sal_sales_quotation.CurrencyCode='"+salesQuotationTemp.getCurrencyCode()+"' " +
                "AND sal_sales_quotation.Code IN ("+concatTemp+") "+        
                "AND sal_sales_quotation.SALQUOStatus='APPROVED' " +
                "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' " +
                "ORDER BY sal_sales_quotation.TransactionDate DESC"
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
   
    public int countDataDetailArray(String concat){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(*)  " +
                "FROM sal_sales_quotation_detail " +
                "INNER JOIN sal_sales_quotation ON sal_sales_quotation.`code` = sal_sales_quotation_detail.`HeaderCode` " +
                "WHERE sal_sales_quotation_detail.HeaderCode ='"+concat+"' "  
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
   
    public List<SalesQuotationTemp> findData(String code,String remark, String refNo, String customerCode,String customerName, String endUserCode, String endUserName, String status, String active, int from,int to, Date firstDate, Date lastDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
             String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND sal_sales_quotation.ValidStatus="+active+" ";
            }
            
            List<SalesQuotationTemp> list = (List<SalesQuotationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_sales_quotation.code, "
                + "sal_sales_quotation.salQuoNo, "
                + "sal_sales_quotation.validStatus, "
                + "sal_sales_quotation.salQUOStatus, "
                + "sal_sales_quotation.revision, "
                + "sal_sales_quotation.refSalQUOCode, "
                + "sal_sales_quotation.Transactiondate, "
                + "sal_sales_quotation.ShipToCode AS shipToCode, "
                + "mst_city.name AS shipToName, "
                + "sal_sales_quotation.`RFQCode`, "
                + "sal_request_for_quotation.`OrderStatus`, "
                + "mst_customer.code AS customerCode, "
                + "mst_customer.name AS customerName, "
                + "sal_sales_quotation.endUserCode, "
                + "endUser.Name AS endUserName, "            
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "mst_project.code AS projectCode, "
                + "mst_project.name AS projectName, "
                + "mst_sales_person.code AS salesPersonCode, "
                + "mst_sales_person.name AS salesPersonName, "
                + "sal_sales_quotation.termOfDeliveryCode AS termOfDeliveryCode, "
                + "mst_term_of_delivery.name AS termOfDeliveryName, "
                + "sal_sales_quotation.RefNo, "
                + "sal_sales_quotation.Remark, "
                + "sal_sales_quotation.TotalTransactionAmount, "
                + "sal_sales_quotation.DiscountPercent, "
                + "sal_sales_quotation.DiscountAmount, "
                + "sal_sales_quotation.VATPercent, "
                + "sal_sales_quotation.VATAmount, "
                + "sal_sales_quotation.TaxBaseAmount, "
                + "sal_sales_quotation.GrandTotalAmount, "
                + "sal_sales_quotation.priceValidity, "
                + "sal_sales_quotation.certificateDocumentation, "
                + "sal_sales_quotation.testing, "
                + "sal_sales_quotation.inspection, "
                + "sal_sales_quotation.painting, "
                + "sal_sales_quotation.packing, "
                + "sal_sales_quotation.tagging, "
                + "sal_sales_quotation.warranty, "
                + "sal_sales_quotation.payment "
                + "FROM sal_sales_quotation "
                + "INNER JOIN mst_city ON sal_sales_quotation.ShipToCode=mst_city.Code "
                + "INNER JOIN mst_term_of_delivery ON sal_sales_quotation.termOfDeliveryCode=mst_term_of_delivery.Code "
                + "INNER JOIN mst_customer ON sal_sales_quotation.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_customer endUser ON sal_sales_quotation.endUserCode=endUser.Code "            
                + "INNER JOIN sal_request_for_quotation ON  sal_sales_quotation.`RFQCode` = sal_request_for_quotation.`code` "
                + "INNER JOIN mst_branch ON sal_sales_quotation.BranchCode = mst_branch.Code "
                + "LEFT JOIN mst_project ON sal_sales_quotation.projectCode = mst_project.Code "
                + "INNER JOIN mst_sales_person ON sal_sales_quotation.salesPersonCode = mst_sales_person.Code "
                + "WHERE sal_sales_quotation.code LIKE '%"+code+"%' "
                + "AND sal_sales_quotation.Remark LIKE '%"+remark+"%' "        
                + "AND sal_sales_quotation.refNo LIKE '%"+refNo+"%' "        
                + "AND sal_sales_quotation.CustomerCode LIKE '%"+customerCode+"%' "        
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND sal_sales_quotation.endUserCode LIKE '%"+endUserCode+"%' "
                + "AND endUser.name LIKE '%"+endUserName+"%' "           
                + "AND sal_sales_quotation.SALQUOStatus LIKE '%"+status+"%' " 
                + concat_qry          
                + "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY sal_sales_quotation.code DESC,sal_sales_quotation.TransactionDate DESC "
                + "LIMIT "+from+","+to+""
            )
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("termOfDeliveryCode", Hibernate.STRING)
                .addScalar("termOfDeliveryName", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("salQuoNo", Hibernate.STRING)
                .addScalar("salQUOStatus", Hibernate.STRING)
                .addScalar("orderStatus", Hibernate.STRING)
                .addScalar("shipToCode", Hibernate.STRING)
                .addScalar("shipToName", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("refSalQUOCode", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("rfqCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("priceValidity", Hibernate.STRING)
                .addScalar("certificateDocumentation", Hibernate.STRING)
                .addScalar("testing", Hibernate.STRING)
                .addScalar("inspection", Hibernate.STRING)
                .addScalar("painting", Hibernate.STRING)
                .addScalar("packing", Hibernate.STRING)
                .addScalar("tagging", Hibernate.STRING)
                .addScalar("warranty", Hibernate.STRING)
                .addScalar("payment", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.BOOLEAN)
                    
                .setResultTransformer(Transformers.aliasToBean(SalesQuotationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<SalesQuotationTemp> findSearchData(SalesQuotationTemp salesQuotationTemp, int from,int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(salesQuotationTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(salesQuotationTemp.getLastDate());
            
            List<SalesQuotationTemp> list = (List<SalesQuotationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_sales_quotation.code, "
                + "sal_sales_quotation.salQuoNo, "
                + "sal_sales_quotation.revision, "
                + "sal_sales_quotation.refSalQUOCode, "
                + "sal_sales_quotation.Transactiondate, "
                + "sal_sales_quotation.ShipToCode, "
                + "sal_sales_quotation.orderStatus, "
                + "sal_sales_quotation.`RFQCode`, "
                + "sal_sales_quotation.`CustomerCode`, "
                + "customer.Name AS CustomerName, "
                + "sal_sales_quotation.endUserCode, "
                + "endUser.Name AS endUserName, "
                + "sal_sales_quotation.ProjectCode, "
                + "sal_sales_quotation.SalesPersonCode, "
                + "sal_sales_quotation.termOfDeliveryCode, "
                + "sal_sales_quotation.subject, "
                + "sal_sales_quotation.Attn, "
                + "sal_sales_quotation.RefNo, "
                + "sal_sales_quotation.orderStatus, "
                + "sal_sales_quotation.Remark, "
                + "sal_sales_quotation.priceValidity, "
                + "sal_sales_quotation.certificateDocumentation, "
                + "sal_sales_quotation.testing, "
                + "sal_sales_quotation.inspection, "
                + "sal_sales_quotation.painting, "
                + "sal_sales_quotation.packing, "
                + "sal_sales_quotation.tagging, "
                + "sal_sales_quotation.warranty, "
                + "sal_sales_quotation.payment "            
                + "FROM sal_sales_quotation "
                + "INNER JOIN mst_customer customer ON sal_sales_quotation.CustomerCode=customer.Code "
                + "INNER JOIN mst_customer endUser ON sal_sales_quotation.endUserCode=endUser.Code "
                + "WHERE sal_sales_quotation.Code LIKE '%"+salesQuotationTemp.getCode()+"%' "
                + "AND sal_sales_quotation.CustomerCode='"+salesQuotationTemp.getCustomerCode()+"' "
                + "AND sal_sales_quotation.endUserCode='"+salesQuotationTemp.getEndUserCode()+"' "
                + "AND sal_sales_quotation.SalesPersonCode='"+salesQuotationTemp.getSalesPersonCode()+"' "
//                + "AND sal_sales_quotation.ProjectCode='"+salesQuotationTemp.getProjectCode()+"' "
                + "AND sal_sales_quotation.CurrencyCode='"+salesQuotationTemp.getCurrencyCode()+"' "
                + "AND sal_sales_quotation.BranchCode='"+salesQuotationTemp.getBranchCode()+"' "
                + "AND sal_sales_quotation.SALQUOStatus='APPROVED' "
                + "AND sal_sales_quotation.OrderStatus='"+salesQuotationTemp.getOrderStatus()+"' "
                + "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY sal_sales_quotation.TransactionDate DESC "
                + "LIMIT "+from+","+to+""
            )
                 
            .addScalar("code", Hibernate.STRING)
            .addScalar("salQuoNo", Hibernate.STRING)
            .addScalar("revision", Hibernate.STRING)
            .addScalar("orderStatus", Hibernate.STRING)
            .addScalar("refSalQUOCode", Hibernate.STRING)
            .addScalar("transactionDate", Hibernate.TIMESTAMP)
            .addScalar("shipToCode", Hibernate.STRING)
            .addScalar("rfqCode", Hibernate.STRING)
            .addScalar("customerCode", Hibernate.STRING)
            .addScalar("customerName", Hibernate.STRING)
            .addScalar("endUserCode", Hibernate.STRING)
            .addScalar("endUserName", Hibernate.STRING)
            .addScalar("projectCode", Hibernate.STRING)
            .addScalar("salesPersonCode", Hibernate.STRING)
            .addScalar("termOfDeliveryCode", Hibernate.STRING)
            .addScalar("refNo", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("subject", Hibernate.STRING)
            .addScalar("attn", Hibernate.STRING)
            .addScalar("priceValidity", Hibernate.STRING)
            .addScalar("certificateDocumentation", Hibernate.STRING)
            .addScalar("testing", Hibernate.STRING)
            .addScalar("inspection", Hibernate.STRING)
            .addScalar("painting", Hibernate.STRING)
            .addScalar("packing", Hibernate.STRING)
            .addScalar("tagging", Hibernate.STRING)
            .addScalar("warranty", Hibernate.STRING)
            .addScalar("payment", Hibernate.STRING)        

            .setResultTransformer(Transformers.aliasToBean(SalesQuotationTemp.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<SalesQuotationTemp> findDataArray(SalesQuotationTemp salesQuotationTemp, String concat, int from,int to) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(salesQuotationTemp.getFirstDate());
            String dateLast = DATE_FORMAT.format(salesQuotationTemp.getLastDate());
            
            String[] x  = concat.split(",");
            String concatTemp = "";
            for(int i = 0; i <x.length; i++){
                if(i == 0){
                    concatTemp += "'" + x[i] + "'";
                }else{
                    concatTemp += ",'" + x[i] + "'";
                }
            }
            
            List<SalesQuotationTemp> list = (List<SalesQuotationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_sales_quotation.code, "
                + "sal_sales_quotation.salQuoNo, "
                + "sal_sales_quotation.revision, "
                + "sal_sales_quotation.refSalQUOCode, "
                + "sal_sales_quotation.Transactiondate, "
                + "sal_sales_quotation.ShipToCode, "
                + "sal_sales_quotation.orderStatus, "
                + "sal_sales_quotation.`RFQCode`, "
                + "sal_sales_quotation.`CustomerCode`, "
                + "customer.Name AS CustomerName, "
                + "sal_sales_quotation.endUserCode, "
                + "endUser.Name AS endUserName, "
                + "sal_sales_quotation.ProjectCode, "
                + "sal_sales_quotation.SalesPersonCode, "
                + "sal_sales_quotation.termOfDeliveryCode, "
                + "sal_sales_quotation.subject, "
                + "sal_sales_quotation.Attn, "
                + "sal_sales_quotation.RefNo, "
                + "sal_sales_quotation.orderStatus, "
                + "sal_sales_quotation.Remark, "
                + "sal_sales_quotation.priceValidity, "
                + "sal_sales_quotation.certificateDocumentation, "
                + "sal_sales_quotation.testing, "
                + "sal_sales_quotation.inspection, "
                + "sal_sales_quotation.painting, "
                + "sal_sales_quotation.packing, "
                + "sal_sales_quotation.tagging, "
                + "sal_sales_quotation.warranty, "
                + "sal_sales_quotation.payment, "            
                + "sal_sales_quotation_detail.HeaderCode "
//                + "sal_sales_quotation_detail.Item AS itemDetail "
                + "FROM sal_sales_quotation "
                + "INNER JOIN mst_customer customer ON sal_sales_quotation.CustomerCode=customer.Code "
                + "INNER JOIN mst_customer endUser ON sal_sales_quotation.endUserCode=endUser.Code "
                + "INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.HeaderCode = sal_sales_quotation.code "
                + "WHERE sal_sales_quotation.Code IN ("+concatTemp+") " 
                + "AND sal_sales_quotation.CustomerCode='"+salesQuotationTemp.getCustomerCode()+"' "
                + "AND sal_sales_quotation.endUserCode='"+salesQuotationTemp.getEndUserCode()+"' "
                + "AND sal_sales_quotation.SalesPersonCode='"+salesQuotationTemp.getSalesPersonCode()+"' "
//                + "AND sal_sales_quotation.ProjectCode='"+salesQuotationTemp.getProjectCode()+"' "
                + "AND sal_sales_quotation.CurrencyCode='"+salesQuotationTemp.getCurrencyCode()+"' "
                + "AND sal_sales_quotation.BranchCode='"+salesQuotationTemp.getBranchCode()+"' "
                + "AND sal_sales_quotation.SALQUOStatus='APPROVED' "
                + "AND sal_sales_quotation.OrderStatus='"+salesQuotationTemp.getOrderStatus()+"' "
                + "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY sal_sales_quotation.TransactionDate DESC "
                
            )
                 
            .addScalar("code", Hibernate.STRING)
//            .addScalar("itemDetail", Hibernate.STRING)
            .addScalar("salQuoNo", Hibernate.STRING)
            .addScalar("revision", Hibernate.STRING)
            .addScalar("orderStatus", Hibernate.STRING)
            .addScalar("refSalQUOCode", Hibernate.STRING)
            .addScalar("transactionDate", Hibernate.TIMESTAMP)
            .addScalar("shipToCode", Hibernate.STRING)
            .addScalar("rfqCode", Hibernate.STRING)
            .addScalar("customerCode", Hibernate.STRING)
            .addScalar("customerName", Hibernate.STRING)
            .addScalar("endUserCode", Hibernate.STRING)
            .addScalar("endUserName", Hibernate.STRING)
            .addScalar("projectCode", Hibernate.STRING)
            .addScalar("salesPersonCode", Hibernate.STRING)
            .addScalar("termOfDeliveryCode", Hibernate.STRING)
            .addScalar("refNo", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("subject", Hibernate.STRING)
            .addScalar("attn", Hibernate.STRING)
            .addScalar("priceValidity", Hibernate.STRING)
            .addScalar("certificateDocumentation", Hibernate.STRING)
            .addScalar("testing", Hibernate.STRING)
            .addScalar("inspection", Hibernate.STRING)
            .addScalar("painting", Hibernate.STRING)
            .addScalar("packing", Hibernate.STRING)
            .addScalar("tagging", Hibernate.STRING)
            .addScalar("warranty", Hibernate.STRING)
            .addScalar("payment", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(SalesQuotationTemp.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<SalesQuotationDetailTemp> findDataDetail(String headerCode) {
        try {
            
            List<SalesQuotationDetailTemp> list = (List<SalesQuotationDetailTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "sal_sales_quotation_detail.code, "
                + "sal_sales_quotation_detail.Headercode, "
                + "sal_sales_quotation_detail.ValveTypeCode, "
                + "mst_valve_type.name AS valveTypeName, "
                + "sal_sales_quotation_detail.valveTag, "
                + "sal_sales_quotation_detail.dataSheet, "
                + "sal_sales_quotation_detail.description, "
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.size, "
                + "sal_sales_quotation_detail.rating, "
                + "sal_sales_quotation_detail.endCon, "
                + "sal_sales_quotation_detail.body, "
                + "sal_sales_quotation_detail.ball, "
                + "sal_sales_quotation_detail.seat, "
                + "sal_sales_quotation_detail.stem, "
                + "sal_sales_quotation_detail.seatInsert, "
                + "sal_sales_quotation_detail.seal, "
                + "sal_sales_quotation_detail.bolting AS bolt, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.oper, "
                + "sal_sales_quotation_detail.bore, "
                + "sal_sales_quotation_detail.disc, "
                + "sal_sales_quotation_detail.plates, "
                + "sal_sales_quotation_detail.shaft, "
                + "sal_sales_quotation_detail.spring, "
                + "sal_sales_quotation_detail.armPin, "
                + "sal_sales_quotation_detail.backseat, "
                + "sal_sales_quotation_detail.arm, "
                + "sal_sales_quotation_detail.hingePin, "
                + "sal_sales_quotation_detail.stopPin, "
                + "sal_sales_quotation_detail.Note, "
                + "sal_sales_quotation_detail.Quantity, "
                + "sal_sales_quotation_detail.UnitPrice, "
                + "sal_sales_quotation_detail.TotalAmount AS total, "
                + "IFNULL(sal_sales_quotation_detail.Quantity,0) * IFNULL(sal_sales_quotation_detail.unitPrice,0) AS Total "
                + "FROM sal_sales_quotation_detail "
                + "INNER JOIN mst_valve_type ON mst_valve_type.code = sal_sales_quotation_detail.ValveTypeCode "
                + "WHERE sal_sales_quotation_detail.HeaderCode='"+headerCode+"'")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolt", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("oper", Hibernate.STRING)
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                .addScalar("backseat", Hibernate.STRING)
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)    
                .setResultTransformer(Transformers.aliasToBean(SalesQuotationDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<SalesQuotationDetailTemp> findDataArrayDetail(String headerCode,int from,int to) {
        try {
            
            List<SalesQuotationDetailTemp> list = (List<SalesQuotationDetailTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "sal_sales_quotation_detail.code, "
                + "sal_sales_quotation_detail.Headercode, "
                + "sal_sales_quotation_detail.ValveTypeCode, "
                + "mst_valve_type.name AS valveTypeName, "
                + "sal_sales_quotation_detail.valveTag, "
                + "sal_sales_quotation_detail.dataSheet, "
                + "sal_sales_quotation_detail.description, "
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.size, "
                + "sal_sales_quotation_detail.rating, "
                + "sal_sales_quotation_detail.endCon, "
                + "sal_sales_quotation_detail.body, "
                + "sal_sales_quotation_detail.ball, "
                + "sal_sales_quotation_detail.seat, "
                + "sal_sales_quotation_detail.stem, "
                + "sal_sales_quotation_detail.seatInsert, "
                + "sal_sales_quotation_detail.seal, "
                + "sal_sales_quotation_detail.bolting AS bolt, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.oper, "
                + "sal_sales_quotation_detail.bore, "
                + "sal_sales_quotation_detail.disc, "
                + "sal_sales_quotation_detail.plates, "
                + "sal_sales_quotation_detail.shaft, "
                + "sal_sales_quotation_detail.spring, "
                + "sal_sales_quotation_detail.armPin, "
                + "sal_sales_quotation_detail.backseat, "
                + "sal_sales_quotation_detail.arm, "
                + "sal_sales_quotation_detail.hingePin, "
                + "sal_sales_quotation_detail.stopPin, "
                + "sal_sales_quotation_detail.Note, "
                + "sal_sales_quotation_detail.Quantity, "
                + "sal_sales_quotation_detail.UnitPrice, "
                + "sal_sales_quotation_detail.TotalAmount AS total, "
                + "IFNULL(sal_sales_quotation_detail.Quantity,0) * IFNULL(sal_sales_quotation_detail.unitPrice,0) AS Total "
                + "FROM sal_sales_quotation_detail "
                + "INNER JOIN mst_valve_type ON mst_valve_type.code = sal_sales_quotation_detail.ValveTypeCode "        
                + "WHERE sal_sales_quotation_detail.HeaderCode='"+headerCode+"' "
                + "LIMIT "+from+","+to+"")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolt", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("oper", Hibernate.STRING)
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                .addScalar("backseat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("stopPin", Hibernate.STRING)
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)    
                .setResultTransformer(Transformers.aliasToBean(SalesQuotationDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<SalesQuotationDetailTemp> findDataDetail(ArrayList arrSalesQuotationNo) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationNo.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            
            List<SalesQuotationDetailTemp> list = (List<SalesQuotationDetailTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT DISTINCT "
                + "sal_sales_quotation_detail.code, "
                + "sal_sales_quotation_detail.Headercode, "
                + "sal_sales_quotation_detail.ValveTypeCode, "
                + "mst_valve_type.name AS valveTypeName, "
                + "sal_sales_quotation_detail.valveTag, "
                + "sal_sales_quotation_detail.dataSheet, "
                + "sal_sales_quotation_detail.description, "
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.size, "
                + "sal_sales_quotation_detail.rating, "
                + "sal_sales_quotation_detail.endCon, "
                + "sal_sales_quotation_detail.body, "
                + "sal_sales_quotation_detail.ball, "
                + "sal_sales_quotation_detail.seat, "
                + "sal_sales_quotation_detail.stem, "
                + "sal_sales_quotation_detail.seatInsert, "
                + "sal_sales_quotation_detail.seal, "
                + "sal_sales_quotation_detail.bolting AS bolt, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.oper, "
                + "sal_sales_quotation_detail.bore, "
                + "sal_sales_quotation_detail.disc, "
                + "sal_sales_quotation_detail.plates, "
                + "sal_sales_quotation_detail.shaft, "
                + "sal_sales_quotation_detail.spring, "
                + "sal_sales_quotation_detail.armPin, "
                + "sal_sales_quotation_detail.backseat, "
                + "sal_sales_quotation_detail.arm, "
                + "sal_sales_quotation_detail.hingePin, "
                + "sal_sales_quotation_detail.stopPin, "        
                + "sal_sales_quotation_detail.Note, "
                + "sal_sales_quotation_detail.Quantity, "
                + "sal_sales_quotation_detail.UnitPrice, "
                + "sal_sales_quotation_detail.TotalAmount AS total, "
                + "sal_sales_quotation.RefNo "
//                + "IFNULL(qry1.customerPurchaseOrderSortNo,0) AS customerPurchaseOrderSortNo "
                + "FROM sal_sales_quotation_detail "
                + "LEFT JOIN( "
                    + "SELECT  "
                        + "sal_customer_purchase_order_item_detail.SalesQuotationCode AS salesQuotationCode, "
                        + "sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                        + "sal_customer_purchase_order_item_detail.ItemFinishGoodsCode, "
                        + "mst_item_finish_goods.Remark AS itemFinishGoodsName "
                    + "FROM "
                        + "sal_customer_purchase_order_item_detail "
                        + "INNER JOIN mst_item_finish_goods "
                        + "ON mst_item_finish_goods.code = sal_customer_purchase_order_item_detail.ItemFinishGoodsCode "
                    + ") AS qry1 ON qry1.salesQuotationCode = sal_sales_quotation_detail.HeaderCode "
                + "INNER JOIN mst_valve_type ON mst_valve_type.code = sal_sales_quotation_detail.ValveTypeCode "    
                + "INNER JOIN sal_sales_quotation ON sal_sales_quotation.code = sal_sales_quotation_detail.HeaderCode "    
                + "WHERE sal_sales_quotation_detail.HeaderCode IN ('"+strSalesQuotationNo+"') "
                + "ORDER BY sal_sales_quotation_detail.HeaderCode ASC ")
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolt", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("oper", Hibernate.STRING)
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                .addScalar("backseat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("stopPin", Hibernate.STRING)    
                .addScalar("note", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)    
//                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)    
//                .addScalar("itemFinishGoodsCode", Hibernate.STRING)    
//                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)    
                .setResultTransformer(Transformers.aliasToBean(SalesQuotationDetailTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public boolean is_Compnt(List<ValveTypeComponentDetailTemp> arrList, String targetValue) {
        Boolean status = false;
	for(ValveTypeComponentDetailTemp component: arrList){
            if(component.getValveTypeComponentCode().equals(targetValue)){
                status= component.isIs_valid();
            }
	}
	return status;
    }
    
    public List<ValveTypeComponentDetailTemp> getComponentValidation(String Code){
        try {
            List<ValveTypeComponentDetailTemp>  list = (List<ValveTypeComponentDetailTemp>)hbmSession.hSession.createSQLQuery(""
                    + " SELECT "
                    + "   '"+Code+"' AS valveTypeCode, "
                    + "   mst_valve_type_component.code AS valveTypeComponentCode, "
                    + "   case "
                    + "     WHEN component_detail.ValveTypeComponentCode IS NULL "
                    + "     then 0 "
                    + "     ELSE 1 "
                    + "   end as is_valid "
                    + " FROM "
                    + "   mst_valve_type_component "
                    + "   LEFT JOIN "
                    + "     (SELECT "
                    + "       mst_valve_type_component_detail.ValveTypeCode, "
                    + "       mst_valve_type_component_detail.ValveTypeComponentCode "
                    + "     FROM "
                    + "       mst_valve_type_component_detail "
                    + "     WHERE mst_valve_type_component_detail.ValveTypeCode = '"+Code+"') AS component_detail "
                    + "     ON component_detail.ValveTypeComponentCode = mst_valve_type_component.code "
                    + " ")

                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeComponentCode", Hibernate.STRING)
                .addScalar("is_valid", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeComponentDetailTemp.class))
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
    
     public int countDataStatus(String code,String remark, String refNo, String customerCode,String customerName,String salQuoStatus, String validStatus, Date fromDate,Date upToDate){
        try{            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            String dateFirst = DATE_FORMAT.format(fromDate);
            String dateLast = DATE_FORMAT.format(upToDate);
            String concat_qry="";
            if(!validStatus.equals("")){
                concat_qry="AND sal_sales_quotation.ValidStatus="+validStatus+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
              "SELECT COUNT(*)  "
                + "FROM sal_sales_quotation "
                + "INNER JOIN mst_city ON sal_sales_quotation.ShipToCode=mst_city.Code "
                + "INNER JOIN mst_term_of_delivery ON sal_sales_quotation.termOfDeliveryCode=mst_term_of_delivery.Code "
                + "INNER JOIN sal_request_for_quotation ON  sal_sales_quotation.`RFQCode` = sal_request_for_quotation.`code` "
                + "LEFT JOIN mst_project ON sal_request_for_quotation.projectCode = mst_project.Code "
                + "INNER JOIN mst_branch ON sal_request_for_quotation.BranchCode = mst_branch.Code "
                + "INNER JOIN mst_customer ON sal_sales_quotation.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_sales_person ON sal_request_for_quotation.salesPersonCode = mst_sales_person.Code "
                + "WHERE sal_sales_quotation.code LIKE '%"+code+"%' "
                + "AND sal_sales_quotation.Remark LIKE '%"+remark+"%' "        
                + "AND sal_sales_quotation.refNo LIKE '%"+refNo+"%' "        
                + "AND sal_sales_quotation.CustomerCode LIKE '%"+customerCode+"%' "        
                + "AND mst_customer.name LIKE '%"+customerName+"%' "        
                + "AND sal_sales_quotation.SALQUOStatus LIKE '%"+salQuoStatus+"%' " 
                + concat_qry          
                + "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' ")	
   
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     
      public List<SalesQuotationTemp> findDataStatus(String code,String remark, String refNo, String customerCode,String customerName,String salQuoStatus, String validStatus,Date fromDate,Date upToDate,int from, int to) {
        try {   
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(fromDate);
            String dateLast = DATE_FORMAT.format(upToDate);
            
            String concat_qry="";
            if(!validStatus.equals("")){
                concat_qry="AND sal_sales_quotation.ValidStatus="+validStatus+" ";
            }

            List<SalesQuotationTemp> list = (List<SalesQuotationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sal_sales_quotation.code, "
                + "sal_sales_quotation.SALQUOStatus AS salQUOStatus, "
                + "sal_sales_quotation.salQuoNo, "
                + "sal_sales_quotation.revision, "
                + "sal_sales_quotation.refSalQUOCode, "
                + "sal_sales_quotation.Transactiondate, "
                + "sal_sales_quotation.ShipToCode AS shipToCode, "
                + "mst_city.name AS shipToName, "
                + "sal_sales_quotation.`RFQCode`, "
                + "sal_request_for_quotation.`OrderStatus`, "
                + "mst_customer.code AS customerCode, "
                + "mst_customer.name AS customerName, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "mst_project.code AS projectCode, "
                + "mst_project.name AS projectName, "
                + "mst_sales_person.code AS salesPersonCode, "
                + "mst_sales_person.name AS salesPersonName, "
                + "sal_sales_quotation.endUserCode, "
                + "endUser.Name AS endUserName, "            
                + "sal_sales_quotation.termOfDeliveryCode AS termOfDeliveryCode, "
                + "mst_term_of_delivery.name AS termOfDeliveryName, "
                + "sal_sales_quotation.RefNo, "
                + "sal_sales_quotation.Remark, "
                + "sal_sales_quotation.TotalTransactionAmount, "
                + "sal_sales_quotation.DiscountPercent, "
                + "sal_sales_quotation.DiscountAmount, "
                + "sal_sales_quotation.VATPercent, "
                + "sal_sales_quotation.VATAmount, "
                + "sal_sales_quotation.TaxBaseAmount, "
                + "sal_sales_quotation.GrandTotalAmount, "
                + "sal_sales_quotation.ValidStatus, "
                + "sal_sales_quotation.priceValidity, "
                + "sal_sales_quotation.certificateDocumentation, "
                + "sal_sales_quotation.testing, "
                + "sal_sales_quotation.inspection, "
                + "sal_sales_quotation.painting, "
                + "sal_sales_quotation.packing, "
                + "sal_sales_quotation.tagging, "
                + "sal_sales_quotation.warranty, "
                + "sal_sales_quotation.payment "                  
                + "FROM sal_sales_quotation "
                + "INNER JOIN mst_city ON sal_sales_quotation.ShipToCode = mst_city.Code "
                + "INNER JOIN mst_term_of_delivery ON sal_sales_quotation.termOfDeliveryCode=mst_term_of_delivery.Code "
                + "INNER JOIN mst_customer ON sal_sales_quotation.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN sal_request_for_quotation ON  sal_sales_quotation.`RFQCode` = sal_request_for_quotation.`code` "
                + "INNER JOIN mst_branch ON sal_request_for_quotation.BranchCode = mst_branch.Code "
                + "LEFT JOIN mst_project ON sal_request_for_quotation.projectCode = mst_project.Code "
                + "INNER JOIN mst_sales_person ON sal_request_for_quotation.salesPersonCode = mst_sales_person.Code "
                + "INNER JOIN mst_customer endUser ON sal_sales_quotation.endUserCode=endUser.Code "            
                + "WHERE sal_sales_quotation.code LIKE '%"+code+"%' "
                + "AND sal_sales_quotation.Remark LIKE '%"+remark+"%' "        
                + "AND sal_sales_quotation.refNo LIKE '%"+refNo+"%' "        
                + "AND sal_sales_quotation.CustomerCode LIKE '%"+customerCode+"%' "        
                + "AND mst_customer.name LIKE '%"+customerName+"%' "        
                + "AND sal_sales_quotation.SALQUOStatus LIKE '%"+salQuoStatus+"%' " 
                + concat_qry          
                + "AND DATE(sal_sales_quotation.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY sal_sales_quotation.TransactionDate DESC "
                + "LIMIT "+from+","+to+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("salQUOStatus", Hibernate.STRING)
                .addScalar("termOfDeliveryCode", Hibernate.STRING)
                .addScalar("termOfDeliveryName", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("salQuoNo", Hibernate.STRING)
                .addScalar("orderStatus", Hibernate.STRING)
                .addScalar("shipToCode", Hibernate.STRING)
                .addScalar("shipToName", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("refSalQUOCode", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("rfqCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("validStatus", Hibernate.BOOLEAN)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("priceValidity", Hibernate.STRING)
                .addScalar("certificateDocumentation", Hibernate.STRING)
                .addScalar("testing", Hibernate.STRING)
                .addScalar("inspection", Hibernate.STRING)
                .addScalar("painting", Hibernate.STRING)
                .addScalar("packing", Hibernate.STRING)
                .addScalar("tagging", Hibernate.STRING)
                .addScalar("warranty", Hibernate.STRING)
                .addScalar("payment", Hibernate.STRING)    
                .setResultTransformer(Transformers.aliasToBean(SalesQuotationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
      
      public SalesQuotation get(String code) {
        try {
               return (SalesQuotation) hbmSession.hSession.get(SalesQuotation.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    private String createCode(SalesQuotation salesQuotation){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.Q.toString();
            String tempKode1 = EnumTransactionType.ENUM_TransactionType.REV.toString();
            String acronim = "/"+tempKode+"/"+AutoNumber.getYear(salesQuotation.getTransactionDate(),true)+"_"+tempKode1;

            DetachedCriteria dc = DetachedCriteria.forClass(SalesQuotation.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%"+ acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

           String oldID = "";
            if(list != null){
                    if (list.size() > 0)
                        if(list.get(0) != null){
                            String oldID1 = list.get(0).toString();
                            oldID=oldID1.split("[.]")[0];
                        }
                }
            return AutoNumber.generateCode(AutoNumber.DEFAULT_TRANSACTION_LENGTH_4,acronim,oldID)+".00";
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void saveRevise(SalesQuotation salesQuotation,List<SalesQuotationDetail> listSalesQuotationDetail, String moduleCode) throws Exception{
        try{
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createSQLQuery("UPDATE sal_sales_quotation SET "
                        + "ValidStatus = '0' " 
                        + "WHERE sal_sales_quotation.Code ='"+salesQuotation.getRefSalQUOCode()+"'")
                .executeUpdate();
            hbmSession.hSession.flush();
            
            salesQuotation.setRefSalQUOCode(salesQuotation.getCode());
            salesQuotation.setSalQuoNo(salesQuotation.getCode().substring(0,11));
            salesQuotation.setRevision(salesQuotation.getCode().split("[.]")[1]);
            salesQuotation.setValidStatus(true);
            
            salesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            salesQuotation.setCreatedDate(new Date());
            
//            if(listSalesQuotationDetail==null){
//                hbmSession.hTransaction.rollback();
//                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
//            }
            
            int i = 1;
            for(SalesQuotationDetail detail : listSalesQuotationDetail){
                                                            
                String detailCode = salesQuotation.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(salesQuotation.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(detail);
                            
                i++;
            }
            
            hbmSession.hSession.save(salesQuotation);
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), salesQuotation.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    public void save(SalesQuotation salesQuotation, List<SalesQuotationDetail> listSalesQuotationDetail, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(salesQuotation);
            
            hbmSession.hSession.beginTransaction();
            
            salesQuotation.setCode(headerCode);
            salesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            salesQuotation.setCreatedDate(new Date());
            salesQuotation.setSalQuoNo(salesQuotation.getCode().substring(0,11));
            salesQuotation.setRevision("00");
            salesQuotation.setValidStatus(true);

            hbmSession.hSession.save(salesQuotation);
            
//            if(listSalesQuotationDetail==null){
//                hbmSession.hTransaction.rollback();
//                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
//            }
            
            int i = 1;
            for(SalesQuotationDetail detail : listSalesQuotationDetail){
                                                            
                String detailCode = salesQuotation.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(salesQuotation.getCode());
                                    
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
                                                                    salesQuotation.getCode(), ""));
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
    
    public void update(SalesQuotation salesQuotation, List<SalesQuotationDetail> listSalesQuotationDetail, String moduleCode) throws Exception {
        try {

            hbmSession.hSession.beginTransaction();

            salesQuotation.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            salesQuotation.setUpdatedDate(new Date());
            salesQuotation.setValidStatus(true);
//             if(salesQuotation.getDiscountAccount().getCode().equals("")){
//               salesQuotation.setDiscountAccount(null);
//             }
            hbmSession.hSession.update(salesQuotation);

            hbmSession.hSession.createQuery("DELETE FROM "+SalesQuotationDetailField.BEAN_NAME+" WHERE "+SalesQuotationDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", salesQuotation.getCode())    
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
//            if(listSalesQuotationDetail==null){
//                hbmSession.hTransaction.rollback();
//                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
//            }
            
            int i = 1;
            for(SalesQuotationDetail detail : listSalesQuotationDetail){
                                                            
                String detailCode = salesQuotation.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(salesQuotation.getCode());
                                    
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
                                                                    salesQuotation.getCode(), ""));
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
                    
            hbmSession.hSession.createQuery("DELETE FROM "+SalesQuotationField.BEAN_NAME+" WHERE "+SalesQuotationField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM "+SalesQuotationDetailField.BEAN_NAME+" WHERE "+SalesQuotationDetailField.HEADERCODE+" = :prmCode")
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
    
    public List<SalesQuotationDetailTemp> exportExcel(String valveTypeCode, File sqExcel, String MODULECODE) throws Exception {
        try {
            OPCPackage pkg = OPCPackage.open(sqExcel);
            XSSFWorkbook wb = new XSSFWorkbook(pkg);
            XSSFSheet sheet = wb.getSheetAt(0);
            
            List<SalesQuotationDetailTemp> listSalesQuotationDetailTemp = new ArrayList<SalesQuotationDetailTemp>();
//            List<ErrorMessageImportExcel> listErrorMessageImportExcel = new ArrayList<ErrorMessageImportExcel>();
            Iterator<Row> rowIterator = sheet.iterator();
            int i = 1;
            String[] arr = new String[28];
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
              
                if (row.getRowNum() == 0) {
                    Iterator<Cell> cellIterator = row.cellIterator();
                    int no = 0;
                    while (cellIterator.hasNext()) {
                        Cell cell = cellIterator.next();
                        
                        switch(cell.getStringCellValue().toString()){
                            case "Valve Type Code" :
                               arr[no]= "Valve Type Code";
                               no++;
                               break;
                            case "Valve Tag" :
                               arr[no]= "Valve Tag";
                               no++;
                               break; 
                            case "Data Sheet" :
                               arr[no]= "Data Sheet";
                               no++;
                               break;    
                            case "Description" :
                               arr[no]= "Description";
                               no++;
                               break; 
                            case "Body Construction" :
                               arr[no]= "Body Construction";
                               no++;
                               break; 
                            case "Type Design" :
                               arr[no]= "Type Design";
                               no++;
                               break; 
                            case "Seat Design" :
                               arr[no]= "Seat Design";
                               no++;
                               break; 
                            case "Size" :
                               arr[no]= "Size";
                               no++;
                               break; 
                            case "Rating" :
                               arr[no]= "Rating";
                               no++;
                               break; 
                            case "Bore" :
                               arr[no]= "Bore";
                               no++;
                               break; 
                            case "End Con" :
                               arr[no]= "End Con";
                               no++;
                               break; 
                            case "Body" :
                               arr[no]= "Body";
                               no++;
                               break; 
                            case "Ball" :
                               arr[no]= "Ball";
                               no++;
                               break; 
                            case "Seat" :
                               arr[no]= "Seat";
                               no++;
                               break; 
                            case "Seat Insert" :
                               arr[no]= "Seat Insert";
                               no++;
                               break; 
                            case "Stem" :
                               arr[no]= "Stem";
                               no++;
                               break; 
                            case "Seal" :
                               arr[no]= "Seal";
                               no++;
                               break; 
                            case "Bolt" :
                               arr[no]= "Bolt";
                               no++;
                               break; 
                            case "Disc" :
                               arr[no]= "Disc";
                               no++;
                               break; 
                            case "Plates" :
                               arr[no]= "Plates";
                               no++;
                               break; 
                            case "Shaft" :
                               arr[no]= "Shaft";
                               no++;
                               break; 
                            case "Spring" :
                               arr[no]= "Spring";
                               no++;
                               break; 
                            case "Arm Pin" :
                               arr[no]= "Arm Pin";
                               no++;
                               break; 
                            case "Backseat" :
                               arr[no]= "Backseat";
                               no++;
                               break; 
                            case "Arm" :
                               arr[no]= "Arm";
                               no++;
                               break; 
                            case "Hinge Pin" :
                               arr[no]= "Hinge Pin";
                               no++;
                               break; 
                            case "Stop Pin" :
                               arr[no]= "Stop Pin";
                               no++;
                               break; 
                            case "Operator" :
                               arr[no]= "Operator";
                               no++;
                               break;    
                            case "Note" :
                               arr[no]= "Note";
                               no++;
                               break; 
                            case "Quantity" :
                               arr[no]= "Quantity";
                               no++;
                               break; 
                            case "Unit Price" :
                               arr[no]= "Unit Price";
                               no++;
                               break; 
                            default :
                               no++;
                               // Statements
                        }
                    }
                }else{
                    SalesQuotationDetailTemp salesQuotationDetailTemp = new SalesQuotationDetailTemp();
                    Iterator<Cell> cellIterator = row.cellIterator();
                    int no = 0;
                    Cell cell = cellIterator.next();
                    List<ValveTypeComponentDetailTemp> typeCompVald = getComponentValidation(cell.getStringCellValue().toString().toUpperCase());      
                    ArrayList<String> arr_msg = new ArrayList<String>();
                    
                    for (int cn = 0; cn < row.getLastCellNum(); cn++) {
                      cell = row.getCell(cn,Row.CREATE_NULL_AS_BLANK);
                        switch(arr[no]) { 
                            case "Valve Type Code" :
                               if(cell.getCellType() == cell.CELL_TYPE_STRING){
                                salesQuotationDetailTemp.setValveTypeCode(cell.getStringCellValue().toString().toUpperCase());
                                ValveType valveType = new ValveType();
                                valveType = (ValveType) hbmSession.hSession.get(ValveType.class, cell.getStringCellValue().toString());

                                    if(valveType!=null){
                                        if(!valveTypeCode.equalsIgnoreCase(cell.getStringCellValue().toString())){
                                            arr_msg.add((row.getRowNum()+1)+", Valve Type Code is NOT Match");
                                        }
                                        else{
                                            String valveTypeName = valveType.getName();
                                            salesQuotationDetailTemp.setValveTypeName(valveTypeName);
                                        }
                                    }
                               }else if(cell.getCellType() == cell.CELL_TYPE_BLANK){
                                   arr_msg.add((row.getRowNum()+1)+", The Column Valve Type Code Must Be Filled");
                               }else{
                                   arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Valve Type Code");
                               }
                               no++;
                               break;
                            case "Valve Tag" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                  salesQuotationDetailTemp.setValveTag(cell.getStringCellValue().toString());
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Valve Tag");
                                }
                                no++;
                                break;
                            case "Data Sheet" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                  salesQuotationDetailTemp.setDataSheet(cell.getStringCellValue().toString());
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Data Sheet");
                                }
                                no++;
                                break;    
                            case "Description" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                  salesQuotationDetailTemp.setDescription(cell.getStringCellValue().toString());
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Description");
                                }
                                no++;
                                break; 
                            case "Body Construction" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setBodyConstruction(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"BDYDSG") && salesQuotationDetailTemp.getBodyConstruction().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Body Construction Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"BDYDSG") && !salesQuotationDetailTemp.getBodyConstruction().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Body Construction Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Body Construction");
                                }
                               no++;
                               break; 
                            case "Type Design" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setTypeDesign(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"TYPDSG") && salesQuotationDetailTemp.getTypeDesign().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Type Design Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"TYPDSG") && !salesQuotationDetailTemp.getTypeDesign().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Type Design Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Type Design");
                                }
                               no++;
                               break; 
                            case "Seat Design" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setSeatDesign(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"STDSG") && salesQuotationDetailTemp.getSeatDesign().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seat Design Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"STDSG") && !salesQuotationDetailTemp.getSeatDesign().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seat Design Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Seat Design");
                                }
                               no++;
                               break; 
                            case "Size" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setSize(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"SIZE") && salesQuotationDetailTemp.getSize().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Size Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"SIZE") && !salesQuotationDetailTemp.getSize().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Size Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Size");
                                }
                               no++;
                               break; 
                            case "Rating" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setRating(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"RTG") && salesQuotationDetailTemp.getRating().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Rating Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"RTG") && !salesQuotationDetailTemp.getRating().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Rating Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Rating");
                                }
                               no++;
                               break; 
                            case "Bore" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setBore(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"BORE") && salesQuotationDetailTemp.getBore().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Bore Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"BORE") && !salesQuotationDetailTemp.getBore().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Bore Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Bore");
                                }
                               no++;
                               break; 
                            case "End Con" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setEndCon(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"ENDCON") && salesQuotationDetailTemp.getEndCon().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column End Con Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"ENDCON") && !salesQuotationDetailTemp.getEndCon().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Bore Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column End Con");
                                }    
                               no++;
                               break; 
                            case "Body" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setBody(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"BDY") && salesQuotationDetailTemp.getBody().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Body Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"BDY") && !salesQuotationDetailTemp.getBody().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Body Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Body");
                                }
                               no++;
                               break; 
                            case "Ball" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setBall(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"BALL") && salesQuotationDetailTemp.getBall().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Ball Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"BALL") && !salesQuotationDetailTemp.getBall().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Ball Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Ball");
                                } 
                               no++;
                               break; 
                            case "Seat" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setSeat(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"ST") && salesQuotationDetailTemp.getSeat().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seat Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"ST") && !salesQuotationDetailTemp.getSeat().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seat Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Seat");
                                }     
                               no++;
                               break; 
                            case "Seat Insert" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setSeatInsert(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"STINS") && salesQuotationDetailTemp.getSeat().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seat Insert Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"STINS") && !salesQuotationDetailTemp.getSeat().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seat Insert Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Seat Insert");
                                } 
                               no++;
                               break; 
                            case "Stem" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setStem(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"STM") && salesQuotationDetailTemp.getStem().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Stem Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"STM") && !salesQuotationDetailTemp.getStem().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Stem Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Stem");
                                }    
                               no++;
                               break; 
                            case "Seal" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setSeal(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"SEAL") && salesQuotationDetailTemp.getSeal().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seal Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"SEAL") && !salesQuotationDetailTemp.getSeal().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Seal Must NOT Be Filled");
                                    }
                                }else{
                                   arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Seal");
                                }    
                               no++;
                               break; 
                            case "Bolt" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                    salesQuotationDetailTemp.setBolt(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"BLT") && salesQuotationDetailTemp.getBolt().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Bolt Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"BLT") && !salesQuotationDetailTemp.getBolt().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Bolt Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Bolt");
                                } 
                               no++;
                               break;  
                            case "Disc" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setDisc(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"DISC") && salesQuotationDetailTemp.getDisc().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Disc Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"DISC") && !salesQuotationDetailTemp.getDisc().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Disc Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Disc");
                                }     
                               no++;
                               break; 
                            case "Plates" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setPlates(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"PLT") && salesQuotationDetailTemp.getPlates().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Plates Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"PLT") && !salesQuotationDetailTemp.getPlates().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Plates Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Plates");
                                }     
                               no++;
                               break; 
                            case "Shaft" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setShaft(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"SHFT") && salesQuotationDetailTemp.getShaft().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Shaft Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"SHFT") && !salesQuotationDetailTemp.getShaft().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Shaft Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Shaft");
                                } 
                               no++;
                               break; 
                            case "Spring" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setSpring(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"SPRNG") && salesQuotationDetailTemp.getSpring().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Spring Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"SPRNG") && !salesQuotationDetailTemp.getSpring().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Spring Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Spring");
                                } 
                               no++;
                               break; 
                            case "Arm Pin" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setArmPin(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"ARMPIN") && salesQuotationDetailTemp.getArmPin().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Arm Pin Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"ARMPIN") && !salesQuotationDetailTemp.getArmPin().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Arm Pin Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Arm Pin");
                                } 
                               no++;
                               break; 
                            case "Backseat" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setBackseat(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"BCKST") && salesQuotationDetailTemp.getBackseat().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Backseat Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"BCKST") && !salesQuotationDetailTemp.getBackseat().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Backseat Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Backseat");
                                } 
                               no++;
                               break;
                            case "Arm" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setArm(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"ARM") && salesQuotationDetailTemp.getArm().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Arm Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"ARM") && !salesQuotationDetailTemp.getArm().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Arm Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Arm");
                                }  
                               no++;
                               break;
                            case "Hinge Pin" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setHingePin(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"HNGPIN") && salesQuotationDetailTemp.getHingePin().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Hinge Pin Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"HNGPIN") && !salesQuotationDetailTemp.getHingePin().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Hinge Pin Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Hinge Pin");
                                }     
                               no++;
                               break;
                            case "Stop Pin" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setStopPin(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"STPPIN") && salesQuotationDetailTemp.getStopPin().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Stop Pin Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"STPPIN") && !salesQuotationDetailTemp.getStopPin().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+",  The Column Stop Pin Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Stop Pin");
                                }   
                               no++;
                               break;
                            case "Operator" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK){
                                salesQuotationDetailTemp.setOper(cell.getStringCellValue().toString());
                                    if(is_Compnt(typeCompVald,"OPR") && salesQuotationDetailTemp.getOper().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Operator Must Be Filled");
                                    }else if(!is_Compnt(typeCompVald,"OPR") && !salesQuotationDetailTemp.getOper().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Operator Must NOT Be Filled");
                                    }
                                }else{
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Operator");
                                }    
                               no++;
                               break;   
                            case "Note" :
                                if(cell.getCellType() == cell.CELL_TYPE_STRING || cell.getCellType() == cell.CELL_TYPE_BLANK ){
                                salesQuotationDetailTemp.setNote(cell.getStringCellValue().toString());
                                    if(salesQuotationDetailTemp.getNote().trim().isEmpty()){
                                        arr_msg.add((row.getRowNum()+1)+", The Column Note Must Be Filled");
                                    }
                                }else if(cell.getCellType() != cell.CELL_TYPE_STRING){
                                    arr_msg.add((row.getRowNum()+1)+", The "+ EnumCellExcellType.Enum_CellExcellType.convertIntToEnum_CellExcellType(cell.getCellType())+" Type is WRONG for Column Note");
                                }
                               no++;
                               break;
                            case "Quantity" :
                                if(cell.getCellType() == cell.CELL_TYPE_NUMERIC){
                                 salesQuotationDetailTemp.setQuantity(new BigDecimal(cell.getNumericCellValue()));
                                }else{
                                   salesQuotationDetailTemp.setQuantity(new BigDecimal(BigInteger.ZERO));
                                }
                               no++;
                               break;
                            case "Unit Price" :
                                if(cell.getCellType() == cell.CELL_TYPE_NUMERIC){
                                  salesQuotationDetailTemp.setUnitPrice(new BigDecimal(cell.getNumericCellValue()));
                                }else{
                                    salesQuotationDetailTemp.setUnitPrice(new BigDecimal(BigInteger.ZERO));
                                }
                               no++;
                               break;    
                            default :
                               no++;
                               // Statements
                            }
                    }
                          
                salesQuotationDetailTemp.setList_msg(arr_msg);
                listSalesQuotationDetailTemp.add(salesQuotationDetailTemp);
                i++;
            }
        }
//            
//            ValveTypeComponentDAO valveTypeComponentDAO=new ValveTypeComponentDAO(hbmSession);
//            String beginDIV="<DIV><Table><tr><td colspan='2'>Doesn't Exist in Database!</td></tr>"
//                    + "<tr><td>No.</td><td>ValveType</td></tr>";
//            ValveTypeComponentTemp valveTypeComponentTemp=new ValveTypeComponentTemp();
//            int count=0;
//            for(SalesQuotationDetailTemp salesQuotationDetail:listSalesQuotationDetailTemp){
//                valveTypeComponentTemp=valveTypeComponentDAO.findData(salesQuotationDetail.getValveTypeCode(), true);
//                if(valveTypeComponentTemp==null){
//                    count+=1;
//                    beginDIV+="<tr><td>"+count+"</td><td>"+salesQuotationDetail.getValveTypeCode()+"</td></tr>";
//                }
//            }
//            beginDIV+="</Table></DIV>";
//            
//            if(count>0){
//                throw new Exception(beginDIV);
//            }
            
            return listSalesQuotationDetailTemp;
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        } catch(Exception e){
            e.printStackTrace();
            throw e;
        }
    }
    
    public void approval(String salesQuotationCode,String salQuoStatus,String salQuoRemark,String salQuoReason, String moduleCode) throws Exception{
        try {

            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery("UPDATE SalesQuotation SET "
                    + "SALQUOStatus = :prmsalQuoStatus, "
                    + "SALQUOStatusRemark = :prmsalQuoRemark, "
                    + "SALQUOStatusReason = :prmsalQuoReason "
                    + "WHERE code = :prmCode")
                    .setParameter("prmsalQuoStatus",salQuoStatus )
                    .setParameter("prmsalQuoRemark", salQuoRemark)
                    .setParameter("prmsalQuoReason", salQuoReason)
                    .setParameter("prmCode", salesQuotationCode)
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    salesQuotationCode, ""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.close();
        } catch (Exception e) {
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

    

