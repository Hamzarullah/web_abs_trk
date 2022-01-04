
package com.inkombizz.sales.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonConst;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.sales.model.ContractReview;
import com.inkombizz.sales.model.ContractReviewCADDocumentApproval;
import com.inkombizz.sales.model.ContractReviewCADDocumentApprovalField;
import com.inkombizz.sales.model.ContractReviewDCASDesign;
import com.inkombizz.sales.model.ContractReviewDCASDesignField;
import com.inkombizz.sales.model.ContractReviewDCASFireSafeByDesign;
import com.inkombizz.sales.model.ContractReviewDCASFireSafeByDesignField;
import com.inkombizz.sales.model.ContractReviewDCASHydroTest;
import com.inkombizz.sales.model.ContractReviewDCASHydroTestField;
import com.inkombizz.sales.model.ContractReviewDCASLegalRequirements;
import com.inkombizz.sales.model.ContractReviewDCASLegalRequirementsField;
import com.inkombizz.sales.model.ContractReviewDCASMarking;
import com.inkombizz.sales.model.ContractReviewDCASMarkingField;
import com.inkombizz.sales.model.ContractReviewDCASNde;
import com.inkombizz.sales.model.ContractReviewDCASNdeField;
import com.inkombizz.sales.model.ContractReviewDCASTesting;
import com.inkombizz.sales.model.ContractReviewDCASTestingField;
import com.inkombizz.sales.model.ContractReviewDCASVisualExamination;
import com.inkombizz.sales.model.ContractReviewDCASVisualExaminationField;
import com.inkombizz.sales.model.ContractReviewField;
import com.inkombizz.sales.model.ContractReviewSalesQuotation;
import com.inkombizz.sales.model.ContractReviewSalesQuotationField;
import com.inkombizz.sales.model.ContractReviewTemp;
import com.inkombizz.sales.model.ContractReviewValveType;
import com.inkombizz.sales.model.ContractReviewValveTypeField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.io.File;
import java.math.BigInteger;
import java.text.SimpleDateFormat;;
import java.util.Date;
import java.util.List;
import org.apache.commons.io.FileUtils;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class ContractReviewDAO {
    
    private HBMSession hbmSession;
    
    public ContractReviewDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code, String customerCode, String customerName, String validStatus, Date firstDate,Date lastDate){
        try{
             SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_qry="";
            if(!validStatus.equals("")){
                concat_qry="AND sal_contract_review.ValidStatus="+validStatus+" ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(sal_contract_review.Code) "
                + "FROM sal_contract_review "
                + "INNER JOIN sal_customer_purchase_order ON sal_customer_purchase_order.Code = sal_contract_review.customerPurchaseOrderCode "
                + "INNER JOIN mst_customer ON sal_customer_purchase_order.customerCode = mst_customer.Code "
                + "INNER JOIN mst_customer EndUser ON sal_customer_purchase_order.endUserCode = EndUser.Code "
//                + "INNER JOIN mst_currency ON sal_customer_purchase_order.CurrencyCode = mst_currency.Code "
//                + "LEFT JOIN mst_project ON sal_customer_purchase_order.projectCode = mst_project.Code "
                + "INNER JOIN mst_sales_person ON sal_customer_purchase_order.salesPersonCode = mst_sales_person.Code "
                + "LEFT JOIN mst_item_brand ON sal_contract_review.TN_BrandCode = mst_item_brand.Code "
//                + "INNER JOIN sal_customer_purchase_order_jn_sales_quotation ON sal_customer_purchase_order_jn_sales_quotation.HeaderCode = sal_customer_purchase_order.Code "
//                + "INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode "
                + "WHERE sal_contract_review.Code LIKE '%"+code+"%' "
                + "AND sal_customer_purchase_order.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + concat_qry
                + "AND DATE(sal_contract_review.TransactionDate) BETWEEN DATE '"+dateFirst+"' AND DATE '"+dateLast+"' "
                
            ).uniqueResult();
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
     
    public List<ContractReviewTemp> findData(String code, String customerCode, String customerName, String validStatus, Date firstDate, Date lastDate, int from, int to) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_qry="";
            if(!validStatus.equals("")){
                concat_qry="AND sal_contract_review.ValidStatus="+validStatus+" ";
            }
            
            List<ContractReviewTemp> list = (List<ContractReviewTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "sal_contract_review.Code, "
                + "sal_contract_review.TransactionDate, "
                + "sal_contract_review.CustomerPurchaseOrderCode, "
                + "sal_customer_purchase_order.TransactionDate AS customerPurchaseOrderDate, "
//                + "mst_currency.code AS currencyCode, "
//                + "mst_currency.name AS currencyName, "
//                + "mst_project.Code AS projectCode, "
                + "sal_customer_purchase_order.customerPurchaseOrderNo, "
                + "sal_customer_purchase_order.customerCode, "
                + "mst_customer.name AS customerName, "
                + "sal_customer_purchase_order.endUserCode, "
                + "EndUser.name AS endUserName, "
                + "sal_customer_purchase_order.salesPersonCode, "
                + "mst_sales_person.name AS salesPersonName, "
                + "sal_contract_review.deliveryPoint, "
                + "sal_contract_review.deliveryTime, "
                + "sal_contract_review.refNo, "
                + "sal_contract_review.remark, "
                + "sal_contract_review.SFS_SparepartCommissioningStatus AS sfsSparepartCommissioningStatus, "
                + "sal_contract_review.SFS_SparepartCommissioningFilePath AS sfsSparepartCommissioningFilePath, "
                + "sal_contract_review.SFS_2YearSparepartStatus AS sfs2YearSparepartStatus, "
                + "sal_contract_review.SFS_2YearSparepartFilePath AS sfs2YearSparepartFilePath, "
                + "sal_contract_review.SFS_SpecialToolsStatus AS sfsSpecialToolsStatus, "
                + "sal_contract_review.SFS_SpecialToolsStatusFilePath AS sfsSpecialToolsStatusFilePath, "
                + "sal_contract_review.SFS_PackingStatus AS sfsPackingStatus, "
                + "sal_contract_review.SFS_PaintingStatus AS sfsPaintingStatus, "
                + "sal_contract_review.SFS_PaintingSpec AS sfsPaintingSpec, "
                + "sal_contract_review.SFS_Note AS sfsNote, "
                + "sal_contract_review.DCAS_PressureTestHydroStatus AS dcasPressureTestHydroStatus, "
                + "sal_contract_review.DCAS_PressureTestHydroStatusRemark AS dcasPressureTestHydroStatusRemark, "
                + "sal_contract_review.DCAS_PressureTestGasStatus AS dcasPressureTestGasStatus, "
                + "sal_contract_review.DCAS_PressureTestGasStatusRemark AS dcasPressureTestGasStatusRemark, "
                + "sal_contract_review.DCAS_PMIStatus AS dcasPmiStatus, "
                + "sal_contract_review.DCAS_PMIStatusRemark AS dcasPmiStatusRemark, "
                + "sal_contract_review.DCAS_WitnessStatus AS dcasWitnessStatus, "
                + "sal_contract_review.DCAS_WitnessStatusRemark AS dcasWitnessStatusRemark, "
                + "sal_contract_review.DCAS_HyperbaricTestStatus AS dcasHyperbaricTestStatus, "
                + "sal_contract_review.DCAS_HyperbaricTestStatusRemark AS dcasHyperbaricTestStatusRemark, "
                + "sal_contract_review.DCAS_AntiStaticTestStatus AS dcasAntiStaticTestStatus, "
                + "sal_contract_review.DCAS_AntiStaticTestStatusRemark AS dcasAntiStaticTestStatusRemark, "
                + "sal_contract_review.DCAS_TorqueTestStatus AS dcasTorqueTestStatus, "
                + "sal_contract_review.DCAS_TorqueTestStatusRemark AS dcasTorqueTestStatusRemark, "
                + "sal_contract_review.DCAS_DIB_DBBTestStatus AS dcasDibDbbTestStatus, "
                + "sal_contract_review.DCAS_DIB_DBBTestStatusRemark AS dcasDibDbbTestStatusRemark, "
                + "sal_contract_review.DCAS_Design_Other AS dcasDesignOther, "
                + "sal_contract_review.DCAS_FireSafebyDesign_Other AS dcasFireSafebyDesignOther, "
                + "sal_contract_review.DCAS_Testing_Other AS dcasTestingOther, "
                + "sal_contract_review.DCAS_HydroTest_Other AS dcasHydroTestOther, "
                + "sal_contract_review.DCAS_VisualExamination_Other AS dcasVisualExaminationOther, "
                + "sal_contract_review.DCAS_NDE_Other AS dcasNdeOther, "
                + "sal_contract_review.DCAS_Marking_Other AS dcasMarkingOther, "
                + "sal_contract_review.DCAS_Requirement_Other AS dcasRequirementOther, "
                + "sal_contract_review.CAD_PressureContainingPartsStatus AS cadPressureContainingPartsStatus, "
                + "sal_contract_review.CAD_PressureContainingPartsRemark AS cadPressureContainingPartsRemark, "
                + "sal_contract_review.CAD_PressureControllingPartsStatus AS cadPressureControllingPartsStatus, "
                + "sal_contract_review.CAD_PressureControllingPartsRemark AS cadPressureControllingPartsRemark, "
                + "sal_contract_review.CAD_NonPressureControllingPartsStatus AS cadNonPressureControllingPartsStatus, "
                + "sal_contract_review.CAD_NonPressureControllingPartsRemark AS cadNonPressureControllingPartsRemark, "
                + "sal_contract_review.CAD_Actuator AS cadActuator, "
                + "sal_contract_review.CAD_Note1 AS cadNote1, "
                + "sal_contract_review.CAD_Note2 AS cadNote2, "
                + "sal_contract_review.CAD_DocumentationForApprovalNote AS cadDocumentationForApprovalNote, "
                + "sal_contract_review.TN_ActuatorStatus AS tnActuatorStatus, "
                + "sal_contract_review.TN_BrandCode AS tnBrandCode, "
                + "mst_item_brand.Name AS tnBrandName, "
                + "sal_contract_review.TN_LimitationOriginStatus AS tnLimitationOriginStatus, "
                + "sal_contract_review.TN_LimitationOriginPath AS tnLimitationOriginPath, "
                + "sal_contract_review.TN_LimitationOriginRemark AS tnLimitationOriginRemark, "
                + "sal_contract_review.TN_ApprovalManufacturedListStatus AS tnApprovalManufacturedListStatus, "
                + "sal_contract_review.TN_ApprovalManufacturedListPath AS tnApprovalManufacturedListPath, "
                + "sal_contract_review.TN_ApprovalManufacturedListRemark AS tnApprovalManufacturedListRemark, "
                + "sal_contract_review.TN_BOM AS tnBom, "
                + "sal_contract_review.TN_PR AS tnPr, "
                + "sal_contract_review.TN_POAndArrivalMat AS tnPOAndArrivalMat, "
                + "sal_contract_review.TN_MatchAssTest AS tnMatchAssTest, "
                + "sal_contract_review.TN_Painting AS tnPainting, "
                + "sal_contract_review.TN_PackingAndDocumentation AS tnPackingAndDocumentation, "
                + "sal_contract_review.TN_EstimationIssueDocumentsApproval AS tnEstimationIssueDocumentsApproval, "
                + "sal_contract_review.TN_Note AS tnNote, "
                + "sal_contract_review.AdditionalNote AS additionalNote, "
                + "sal_contract_review.conclusionNote "
                + "FROM sal_contract_review "
                + "INNER JOIN sal_customer_purchase_order ON sal_customer_purchase_order.Code = sal_contract_review.customerPurchaseOrderCode "
                + "INNER JOIN mst_customer ON sal_customer_purchase_order.customerCode = mst_customer.Code "
                + "INNER JOIN mst_customer EndUser ON sal_customer_purchase_order.endUserCode = EndUser.Code "
//                + "INNER JOIN mst_currency ON sal_customer_purchase_order.CurrencyCode = mst_currency.Code "
//                + "LEFT JOIN mst_project ON sal_customer_purchase_order.projectCode = mst_project.Code "
                + "INNER JOIN mst_sales_person ON sal_customer_purchase_order.salesPersonCode = mst_sales_person.Code "
                + "LEFT JOIN mst_item_brand ON sal_contract_review.TN_BrandCode = mst_item_brand.Code "
                + "WHERE sal_contract_review.Code LIKE '%"+code+"%' "
                + "AND sal_customer_purchase_order.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + concat_qry
                + "AND DATE(sal_contract_review.TransactionDate) BETWEEN DATE '"+dateFirst+"' AND DATE '"+dateLast+"' "       
                + "ORDER BY sal_contract_review.Code ASC "
                + " LIMIT "+from+","+to+"")
            
            .addScalar("code", Hibernate.STRING)
            .addScalar("transactionDate", Hibernate.TIMESTAMP)
            .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
            .addScalar("customerPurchaseOrderDate", Hibernate.TIMESTAMP)
//            .addScalar("currencyCode", Hibernate.STRING)
//            .addScalar("currencyName", Hibernate.STRING)
//            .addScalar("projectCode", Hibernate.STRING)
            .addScalar("customerPurchaseOrderNo", Hibernate.STRING)
            .addScalar("customerCode", Hibernate.STRING)
            .addScalar("customerName", Hibernate.STRING)
            .addScalar("endUserCode", Hibernate.STRING)
            .addScalar("endUserName", Hibernate.STRING)
            .addScalar("salesPersonCode", Hibernate.STRING)
            .addScalar("salesPersonName", Hibernate.STRING)
            .addScalar("deliveryPoint", Hibernate.STRING)
            .addScalar("deliveryTime", Hibernate.STRING)
            .addScalar("refNo", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("sfsSparepartCommissioningStatus", Hibernate.STRING)
            .addScalar("sfsSparepartCommissioningFilePath", Hibernate.STRING)
            .addScalar("sfs2YearSparepartStatus", Hibernate.STRING)
            .addScalar("sfs2YearSparepartFilePath", Hibernate.STRING)
            .addScalar("sfsSpecialToolsStatus", Hibernate.STRING)
            .addScalar("sfsSpecialToolsStatusFilePath", Hibernate.STRING)
            .addScalar("sfsPackingStatus", Hibernate.STRING)
            .addScalar("sfsPaintingStatus", Hibernate.STRING)
            .addScalar("sfsPaintingSpec", Hibernate.STRING)
            .addScalar("sfsNote", Hibernate.STRING)
            .addScalar("dcasPressureTestHydroStatus", Hibernate.STRING)
            .addScalar("dcasPressureTestHydroStatusRemark", Hibernate.STRING)
            .addScalar("dcasPressureTestGasStatus", Hibernate.STRING)
            .addScalar("dcasPressureTestGasStatusRemark", Hibernate.STRING)
            .addScalar("dcasPmiStatus", Hibernate.STRING)
            .addScalar("dcasPmiStatusRemark", Hibernate.STRING)
            .addScalar("dcasWitnessStatus", Hibernate.STRING)
            .addScalar("dcasWitnessStatusRemark", Hibernate.STRING)
            .addScalar("dcasHyperbaricTestStatus", Hibernate.STRING)
            .addScalar("dcasHyperbaricTestStatusRemark", Hibernate.STRING)
            .addScalar("dcasAntiStaticTestStatus", Hibernate.STRING)
            .addScalar("dcasAntiStaticTestStatusRemark", Hibernate.STRING)
            .addScalar("dcasTorqueTestStatus", Hibernate.STRING)
            .addScalar("dcasTorqueTestStatusRemark", Hibernate.STRING)
            .addScalar("dcasDibDbbTestStatus", Hibernate.STRING)
            .addScalar("dcasDesignOther", Hibernate.STRING)
            .addScalar("dcasFireSafebyDesignOther", Hibernate.STRING)
            .addScalar("dcasTestingOther", Hibernate.STRING)
            .addScalar("dcasHydroTestOther", Hibernate.STRING)
            .addScalar("dcasVisualExaminationOther", Hibernate.STRING)
            .addScalar("dcasNdeOther", Hibernate.STRING)
            .addScalar("dcasMarkingOther", Hibernate.STRING)
            .addScalar("dcasRequirementOther", Hibernate.STRING)
            .addScalar("cadPressureContainingPartsStatus", Hibernate.STRING)
            .addScalar("cadPressureContainingPartsRemark", Hibernate.STRING)
            .addScalar("cadPressureControllingPartsStatus", Hibernate.STRING)
            .addScalar("cadPressureControllingPartsRemark", Hibernate.STRING)
            .addScalar("cadNonPressureControllingPartsStatus", Hibernate.STRING)
            .addScalar("cadNonPressureControllingPartsRemark", Hibernate.STRING)
            .addScalar("cadActuator", Hibernate.STRING)
            .addScalar("cadNote1", Hibernate.STRING)
            .addScalar("cadNote2", Hibernate.STRING)
            .addScalar("cadDocumentationForApprovalNote", Hibernate.STRING)
            .addScalar("tnActuatorStatus", Hibernate.STRING)
            .addScalar("tnBrandCode", Hibernate.STRING)
            .addScalar("tnBrandName", Hibernate.STRING)
            .addScalar("tnLimitationOriginStatus", Hibernate.STRING)
            .addScalar("tnLimitationOriginPath", Hibernate.STRING)
            .addScalar("tnLimitationOriginRemark", Hibernate.STRING)
            .addScalar("tnApprovalManufacturedListStatus", Hibernate.STRING)
            .addScalar("tnApprovalManufacturedListPath", Hibernate.STRING)
            .addScalar("tnApprovalManufacturedListRemark", Hibernate.STRING)
            .addScalar("tnBom", Hibernate.STRING)
            .addScalar("tnPr", Hibernate.STRING)
            .addScalar("tnPOAndArrivalMat", Hibernate.STRING)
            .addScalar("tnMatchAssTest", Hibernate.STRING)
            .addScalar("tnPainting", Hibernate.STRING)
            .addScalar("tnPackingAndDocumentation", Hibernate.STRING)
            .addScalar("tnEstimationIssueDocumentsApproval", Hibernate.STRING)
            .addScalar("tnNote", Hibernate.STRING)
            .addScalar("additionalNote", Hibernate.STRING)
            .addScalar("conclusionNote", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ContractReviewTemp.class))
            .list(); 
                   
            
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewSalesQuotation> findDataSalesQuotation(String headerCode) {
        try {
            
            List<ContractReviewSalesQuotation> list = (List<ContractReviewSalesQuotation>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_quotation.SalesQuotationCode " +
                "sal_sales_quotation.TransactionDate AS SalesQuotationTransactionDate, " +
                "sal_sales_quotation.subject AS SalesQuotationSubject " +
                "FROM sal_contract_review_jn_quotation " +
                "INNER JOIN " +
                    "sal_sales_quotation ON sal_sales_quotation.Code = sal_contract_review_jn_quotation.SalesQuotationCode " +
                "WHERE sal_contract_review_jn_quotation.HeaderCode=:prmHeaderCode")
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("salesQuotationTransactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewSalesQuotation.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ContractReview findSoForUpdateContractReview(String customerPurchaseOrderCode){
        try {
            ContractReview contractReview = (ContractReview)hbmSession.hSession.createSQLQuery(""
                    +" SELECT DISTINCT "
                        + " sal_contract_review.CustomerPurchaseOrderCode,  "
                        + " sal_customer_sales_order.Code AS salesOrderCode "
                    + " FROM "
                        + " sal_contract_review "
                    + " LEFT JOIN sal_customer_sales_order ON sal_customer_sales_order.CustomerPurchaseOrderCode = sal_contract_review.CustomerPurchaseOrderCode "
                + " WHERE sal_contract_review.CustomerPurchaseOrderCode = '"+customerPurchaseOrderCode+"' "
                + " AND sal_customer_sales_order.ValidStatus =  TRUE "
            )
                    
                .addScalar("salesOrderCode", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(ContractReview.class))
                .uniqueResult(); 
                 
                return contractReview;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewValveType> findDataValveType(String headerCode) {
        try {
            
            List<ContractReviewValveType> list = (List<ContractReviewValveType>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_sfs_valve_type.ValveTypeCode, " +
                "mst_valve_type.Name as ValveTypeName " +
                "FROM sal_contract_review_jn_sfs_valve_type " +
                "INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_contract_review_jn_sfs_valve_type.ValveTypeCode " +
                "WHERE sal_contract_review_jn_sfs_valve_type.HeaderCode=:prmHeaderCode")
                        
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewValveType.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASDesign> findDataDcasDesign(String headerCode) {
        try {
            
            List<ContractReviewDCASDesign> list = (List<ContractReviewDCASDesign>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_design.DesignCode AS dcasDesignCode, " +
                "mst_dcas_design.Name as dcasDesignName " +
                "FROM sal_contract_review_jn_dcas_design " +
                "INNER JOIN mst_dcas_design ON mst_dcas_design.Code = sal_contract_review_jn_dcas_design.DesignCode " +
                "WHERE sal_contract_review_jn_dcas_design.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasDesignCode", Hibernate.STRING)
                .addScalar("dcasDesignName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASDesign.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASFireSafeByDesign> findDataDcasFireSafeByDesign(String headerCode) {
        try {
            
            List<ContractReviewDCASFireSafeByDesign> list = (List<ContractReviewDCASFireSafeByDesign>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_fire_safe_by_design.FireSafeByDesignCode AS dcasFireSafeByDesignCode, " +
                "mst_dcas_fire_safe_by_design.Name as dcasFireSafeByDesignName " +
                "FROM sal_contract_review_jn_dcas_fire_safe_by_design " +
                "INNER JOIN mst_dcas_fire_safe_by_design ON mst_dcas_fire_safe_by_design.Code = sal_contract_review_jn_dcas_fire_safe_by_design.FireSafeByDesignCode " +
                "WHERE sal_contract_review_jn_dcas_fire_safe_by_design.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasFireSafeByDesignCode", Hibernate.STRING)
                .addScalar("dcasFireSafeByDesignName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASFireSafeByDesign.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASTesting> findDataDcasTesting(String headerCode) {
        try {
            
            List<ContractReviewDCASTesting> list = (List<ContractReviewDCASTesting>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_testing.TestingCode AS dcasTestingCode, " +
                "mst_dcas_testing.Name as dcasTestingName " +
                "FROM sal_contract_review_jn_dcas_testing " +
                "INNER JOIN mst_dcas_testing ON mst_dcas_testing.Code = sal_contract_review_jn_dcas_testing.TestingCode " +
                "WHERE sal_contract_review_jn_dcas_testing.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasTestingCode", Hibernate.STRING)
                .addScalar("dcasTestingName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASTesting.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASHydroTest> findDataDcasHydroTest(String headerCode) {
        try {
            
            List<ContractReviewDCASHydroTest> list = (List<ContractReviewDCASHydroTest>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_hydro_test.HydroTestCode AS dcasHydroTestCode, " +
                "mst_dcas_hydro_test.Name as dcasHydroTestName " +
                "FROM sal_contract_review_jn_dcas_hydro_test " +
                "INNER JOIN mst_dcas_hydro_test ON mst_dcas_hydro_test.Code = sal_contract_review_jn_dcas_hydro_test.HydroTestCode " +
                "WHERE sal_contract_review_jn_dcas_hydro_test.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasHydroTestCode", Hibernate.STRING)
                .addScalar("dcasHydroTestName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASHydroTest.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASVisualExamination> findDataDcasVisualExamination(String headerCode) {
        try {
            
            List<ContractReviewDCASVisualExamination> list = (List<ContractReviewDCASVisualExamination>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_visual_examination.VisualExaminationCode AS dcasVisualExaminationCode, " +
                "mst_dcas_visual_examination.Name as dcasVisualExaminationName " +
                "FROM sal_contract_review_jn_dcas_visual_examination " +
                "INNER JOIN mst_dcas_visual_examination ON mst_dcas_visual_examination.Code = sal_contract_review_jn_dcas_visual_examination.VisualExaminationCode " +
                "WHERE sal_contract_review_jn_dcas_visual_examination.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasVisualExaminationCode", Hibernate.STRING)
                .addScalar("dcasVisualExaminationName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASVisualExamination.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASNde> findDataDcasNde(String headerCode) {
        try {
            
            List<ContractReviewDCASNde> list = (List<ContractReviewDCASNde>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_nde.NdeCode AS dcasNdeCode, " +
                "mst_dcas_nde.Name as dcasNdeName " +
                "FROM sal_contract_review_jn_dcas_nde " +
                "INNER JOIN mst_dcas_nde ON mst_dcas_nde.Code = sal_contract_review_jn_dcas_nde.NdeCode " +
                "WHERE sal_contract_review_jn_dcas_nde.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasNdeCode", Hibernate.STRING)
                .addScalar("dcasNdeName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASNde.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASMarking> findDataDcasMarking(String headerCode) {
        try {
            
            List<ContractReviewDCASMarking> list = (List<ContractReviewDCASMarking>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_marking.MarkingCode AS dcasMarkingCode, " +
                "mst_dcas_marking.Name as dcasMarkingName " +
                "FROM sal_contract_review_jn_dcas_marking " +
                "INNER JOIN mst_dcas_marking ON mst_dcas_marking.Code = sal_contract_review_jn_dcas_marking.MarkingCode " +
                "WHERE sal_contract_review_jn_dcas_marking.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasMarkingCode", Hibernate.STRING)
                .addScalar("dcasMarkingName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASMarking.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewDCASLegalRequirements> findDataDcasLegalRequirements(String headerCode) {
        try {
            
            List<ContractReviewDCASLegalRequirements> list = (List<ContractReviewDCASLegalRequirements>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_dcas_legal_requirements.LegalRequirementsCode AS dcasLegalRequirementsCode, " +
                "mst_dcas_legal_requirements.Name as dcasLegalRequirementsName " +
                "FROM sal_contract_review_jn_dcas_legal_requirements " +
                "INNER JOIN mst_dcas_legal_requirements ON mst_dcas_legal_requirements.Code = sal_contract_review_jn_dcas_legal_requirements.LegalRequirementsCode " +
                "WHERE sal_contract_review_jn_dcas_legal_requirements.HeaderCode=:prmHeaderCode")
                        
                .addScalar("dcasLegalRequirementsCode", Hibernate.STRING)
                .addScalar("dcasLegalRequirementsName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewDCASLegalRequirements.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ContractReviewCADDocumentApproval> findDataCadDocumentApproval(String headerCode) {
        try {
            
            List<ContractReviewCADDocumentApproval> list = (List<ContractReviewCADDocumentApproval>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "sal_contract_review_jn_cad_document_for_approval.DocumentTypeCode AS cadDocumentApprovalCode, " +
                "mst_cad_document_for_approval.Name as cadDocumentApprovalName " +
                "FROM sal_contract_review_jn_cad_document_for_approval " +
                "INNER JOIN mst_cad_document_for_approval ON mst_cad_document_for_approval.Code = sal_contract_review_jn_cad_document_for_approval.DocumentTypeCode " +
                "WHERE sal_contract_review_jn_cad_document_for_approval.HeaderCode=:prmHeaderCode")
                        
                .addScalar("cadDocumentApprovalCode", Hibernate.STRING)
                .addScalar("cadDocumentApprovalName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ContractReviewCADDocumentApproval.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ContractReview get(String code) {
        try {
               return (ContractReview) hbmSession.hSession.get(ContractReview.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity, ContractReview contractReview){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.CR.toString();
            String tempKode1 = EnumTransactionType.ENUM_TransactionType.REV.toString();
            String acronim = "/"+tempKode+"/"+AutoNumber.getYear(contractReview.getTransactionDate(),true)+"_"+tempKode1;

            DetachedCriteria dc = DetachedCriteria.forClass(ContractReview.class)
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
    
    public String createReviseCode(EnumActivity.ENUM_Activity enumActivity, ContractReview contractReview){        
        try{
            String acronim =  contractReview.getCode().split("[.]")[0]+".";

            DetachedCriteria dc = DetachedCriteria.forClass(ContractReview.class)
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
    
    public void save(EnumActivity.ENUM_Activity enumActivity,ContractReview contractReview, List<ContractReviewSalesQuotation> listContractReviewSalesQuotation, List<ContractReviewValveType> listContractReviewValveType,
                     List<ContractReviewDCASDesign> listContractReviewDCASDesign, List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign,
                     List<ContractReviewDCASTesting> listContractReviewDCASTesting, List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest,
                     List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination, List<ContractReviewDCASNde> listContractReviewDCASNde,
                     List<ContractReviewDCASMarking> listContractReviewDCASMarking, List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements,
                     List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval, String moduleCode) throws Exception {
        try {
            
            String headerCode = createCode(enumActivity,contractReview);
            hbmSession.hSession.beginTransaction();
            
            contractReview.setCode(headerCode);
            String[] custCRNo=contractReview.getCode().split("_REV.");
            String custCRNo1 = custCRNo[0];
            contractReview.setCustCRNo(custCRNo1);
            
            contractReview.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            contractReview.setCreatedDate(new Date());
            
            ContractReview contractReviewUpload = new ContractReview();
            
            contractReviewUpload = upload(contractReview);
            
            hbmSession.hSession.save(contractReviewUpload);
            
            if(listContractReviewSalesQuotation==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
            
             if(listContractReviewValveType==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASDesign==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASFireSafeByDesign==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASTesting==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASHydroTest==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASVisualExamination==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASNde==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASMarking==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewDCASLegalRequirements==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
             if(listContractReviewCADDocumentApproval==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
             
            if(!processDetail(EnumActivity.ENUM_Activity.NEW, contractReview, listContractReviewSalesQuotation,
                     listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                     listContractReviewDCASTesting, listContractReviewDCASHydroTest, listContractReviewDCASVisualExamination,
                     listContractReviewDCASNde, listContractReviewDCASMarking, 
                     listContractReviewDCASLegalRequirements, listContractReviewCADDocumentApproval)) {
                hbmSession.hTransaction.rollback();
            } 
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    contractReview.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ContractReview contractReview, List<ContractReviewSalesQuotation> listContractReviewSalesQuotation, List<ContractReviewValveType> listContractReviewValveType,
                     List<ContractReviewDCASDesign> listContractReviewDCASDesign, List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign,
                     List<ContractReviewDCASTesting> listContractReviewDCASTesting, List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest,
                     List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination, List<ContractReviewDCASNde> listContractReviewDCASNde,
                     List<ContractReviewDCASMarking> listContractReviewDCASMarking, List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements,
                     List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            contractReview.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            contractReview.setUpdatedDate(new Date());
            hbmSession.hSession.update(contractReview);
            hbmSession.hSession.flush();
            
            if(!processDetail(EnumActivity.ENUM_Activity.UPDATE, contractReview, listContractReviewSalesQuotation,
                     listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                     listContractReviewDCASTesting, listContractReviewDCASHydroTest, listContractReviewDCASVisualExamination,
                     listContractReviewDCASNde, listContractReviewDCASMarking, 
                     listContractReviewDCASLegalRequirements, listContractReviewCADDocumentApproval)) {
                hbmSession.hTransaction.rollback();
            } 
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    contractReview.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void revise(ContractReview contractReview, List<ContractReviewSalesQuotation> listContractReviewSalesQuotation, List<ContractReviewValveType> listContractReviewValveType,
                     List<ContractReviewDCASDesign> listContractReviewDCASDesign, List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign,
                     List<ContractReviewDCASTesting> listContractReviewDCASTesting, List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest,
                     List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination, List<ContractReviewDCASNde> listContractReviewDCASNde,
                     List<ContractReviewDCASMarking> listContractReviewDCASMarking, List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements,
                     List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.beginTransaction();
            
            Boolean validStatus = false;
            
            String contractReviewCode=contractReview.getRefCUSTCRCode();
            ContractReview contractReviewCodeOld = get(contractReviewCode);
            contractReviewCodeOld.setValidStatus(validStatus);
            hbmSession.hSession.update(contractReviewCodeOld);
  
            hbmSession.hSession.flush();
            
            contractReview.setRefCUSTCRCode(contractReviewCodeOld.getCode());
            String headerCode=createReviseCode(EnumActivity.ENUM_Activity.REVISE,contractReview);
            contractReview.setCode(headerCode);
            contractReview.setRevision(contractReview.getCode().substring(contractReview.getCode().length()-2));
            
            hbmSession.hSession.save(contractReview);
            
            if(!processDetail(EnumActivity.ENUM_Activity.UPDATE, contractReview, listContractReviewSalesQuotation,
                     listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                     listContractReviewDCASTesting, listContractReviewDCASHydroTest, listContractReviewDCASVisualExamination,
                     listContractReviewDCASNde, listContractReviewDCASMarking, 
                     listContractReviewDCASLegalRequirements, listContractReviewCADDocumentApproval)) {
                hbmSession.hTransaction.rollback();
            } 
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    contractReview.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.REVISE)));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();                      
        }
        catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
    
    public boolean processDetail(EnumActivity.ENUM_Activity enumActivity, ContractReview contractReview, List<ContractReviewSalesQuotation> listContractReviewSalesQuotation, List<ContractReviewValveType> listContractReviewValveType,
                     List<ContractReviewDCASDesign> listContractReviewDCASDesign, List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign,
                     List<ContractReviewDCASTesting> listContractReviewDCASTesting, List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest,
                     List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination, List<ContractReviewDCASNde> listContractReviewDCASNde,
                     List<ContractReviewDCASMarking> listContractReviewDCASMarking, List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements,
                     List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval) {
        try {
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewCADDocumentApprovalField.BEAN_NAME + 
                                    " WHERE " + ContractReviewCADDocumentApprovalField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASDesignField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASDesignField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASFireSafeByDesignField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASFireSafeByDesignField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASHydroTestField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASHydroTestField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASLegalRequirementsField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASLegalRequirementsField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASMarkingField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASMarkingField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASNdeField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASNdeField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASTestingField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASTestingField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewDCASVisualExaminationField.BEAN_NAME + 
                                    " WHERE " + ContractReviewDCASVisualExaminationField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewSalesQuotationField.BEAN_NAME + 
                                    " WHERE " + ContractReviewSalesQuotationField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
                hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewValveTypeField.BEAN_NAME + 
                                    " WHERE " + ContractReviewValveTypeField.HEADERCODE + " = :prmHeaderCode")
                       .setParameter("prmHeaderCode", contractReview.getCode())
                       .executeUpdate();
            }
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int h = 1;
                for(ContractReviewDCASDesign contractReviewDCASDesign : listContractReviewDCASDesign){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(h),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASDesign.setCode(detailCode);
                    contractReviewDCASDesign.setHeaderCode(contractReview.getCode());

                    contractReviewDCASDesign.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASDesign.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASDesign);
                    h++;
                }

                int i = 1;
                for(ContractReviewSalesQuotation contractReviewSalesQuotation : listContractReviewSalesQuotation){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewSalesQuotation.setCode(detailCode);
                    contractReviewSalesQuotation.setHeaderCode(contractReview.getCode());

                    contractReviewSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewSalesQuotation);
                    i++;
                }

                int j = 1;
                for(ContractReviewValveType contractReviewValveType : listContractReviewValveType){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewValveType.setCode(detailCode);
                    contractReviewValveType.setHeaderCode(contractReview.getCode());

                    contractReviewValveType.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewValveType.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewValveType);
                    j++;
                }

                int k = 1;
                for(ContractReviewDCASFireSafeByDesign contractReviewDCASFireSafeByDesign : listContractReviewDCASFireSafeByDesign){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(k),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASFireSafeByDesign.setCode(detailCode);
                    contractReviewDCASFireSafeByDesign.setHeaderCode(contractReview.getCode());

                    contractReviewDCASFireSafeByDesign.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASFireSafeByDesign.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASFireSafeByDesign);
                    k++;
                }

                int l = 1;
                for(ContractReviewDCASTesting contractReviewDCASTesting : listContractReviewDCASTesting){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(l),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASTesting.setCode(detailCode);
                    contractReviewDCASTesting.setHeaderCode(contractReview.getCode());

                    contractReviewDCASTesting.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASTesting.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASTesting);
                    l++;
                }

                int m = 1;
                for(ContractReviewDCASHydroTest contractReviewDCASHydroTest : listContractReviewDCASHydroTest){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(m),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASHydroTest.setCode(detailCode);
                    contractReviewDCASHydroTest.setHeaderCode(contractReview.getCode());

                    contractReviewDCASHydroTest.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASHydroTest.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASHydroTest);
                    m++;
                }

                int n = 1;
                for(ContractReviewDCASVisualExamination contractReviewDCASVisualExamination : listContractReviewDCASVisualExamination){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(n),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASVisualExamination.setCode(detailCode);
                    contractReviewDCASVisualExamination.setHeaderCode(contractReview.getCode());

                    contractReviewDCASVisualExamination.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASVisualExamination.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASVisualExamination);
                    n++;
                }

                int o = 1;
                 for(ContractReviewDCASNde contractReviewDCASNde : listContractReviewDCASNde){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(o),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASNde.setCode(detailCode);
                    contractReviewDCASNde.setHeaderCode(contractReview.getCode());

                    contractReviewDCASNde.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASNde.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASNde);
                    o++;
                }

                int p = 1;
                 for(ContractReviewDCASMarking contractReviewDCASMarking : listContractReviewDCASMarking){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASMarking.setCode(detailCode);
                    contractReviewDCASMarking.setHeaderCode(contractReview.getCode());

                    contractReviewDCASMarking.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASMarking.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASMarking);
                    p++;
                }

                int q = 1;
                for(ContractReviewDCASLegalRequirements contractReviewDCASLegalRequirements : listContractReviewDCASLegalRequirements){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewDCASLegalRequirements.setCode(detailCode);
                    contractReviewDCASLegalRequirements.setHeaderCode(contractReview.getCode());

                    contractReviewDCASLegalRequirements.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewDCASLegalRequirements.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewDCASLegalRequirements);
                    q++;
                }

                int r = 1;
                for(ContractReviewCADDocumentApproval contractReviewCADDocumentApproval : listContractReviewCADDocumentApproval){

                    String detailCode = contractReview.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(r),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    contractReviewCADDocumentApproval.setCode(detailCode);
                    contractReviewCADDocumentApproval.setHeaderCode(contractReview.getCode());

                    contractReviewCADDocumentApproval.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    contractReviewCADDocumentApproval.setCreatedDate(new Date());

                    hbmSession.hSession.save(contractReviewCADDocumentApproval);
                    r++;
                }
            }
            return Boolean.TRUE;
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(ContractReview contractReview, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            if (!processDetail(EnumActivity.ENUM_Activity.DELETE, contractReview, null, null, null, null,
                     null, null, null, null, null, null, null)) {
                hbmSession.hTransaction.rollback();
            }
     
             hbmSession.hSession.createQuery("DELETE FROM " + ContractReviewField.BEAN_NAME + 
                                 " WHERE " + ContractReviewField.CODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", contractReview.getCode())
                    .executeUpdate();
             
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    contractReview.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
    public ContractReview upload(ContractReview contractReview) throws Exception {
        if(contractReview.getSfs2YearSparepartFile() != null){
            String fileName = contractReview.getCode()+"SFS."+contractReview.getExt1();
//            String filePath = BaseSession.loadProgramSession().getSetup().getPathImg();
            String filePath = "C:/xampp/htdocs/foto/";
            File fileToCreate = new File(filePath, fileName);
            if(fileToCreate.exists()){
                fileToCreate.delete();
            }
            FileUtils.copyFile(contractReview.getSfs2YearSparepartFile(), fileToCreate);
            contractReview.setSfs2YearSparepartFilePath(fileName);
        } 
        if(contractReview.getSfsSparepartCommissioningFile()!= null){
            String fileName = contractReview.getCode()+"SPC."+contractReview.getExt2();
//            String filePath = BaseSession.loadProgramSession().getSetup().getPathImg();
            String filePath = "C:/xampp/htdocs/foto/";
            File fileToCreate = new File(filePath, fileName);
            if(fileToCreate.exists()){
                fileToCreate.delete();
            }
            FileUtils.copyFile(contractReview.getSfsSparepartCommissioningFile(), fileToCreate);
            contractReview.setSfsSparepartCommissioningFilePath(fileName);
        } 
        if(contractReview.getSfsSpecialToolsStatusFile()!= null){
            String fileName = contractReview.getCode()+"STS."+contractReview.getExt3();
//            String filePath = BaseSession.loadProgramSession().getSetup().getPathImg();
            String filePath = "C:/xampp/htdocs/foto/";
            File fileToCreate = new File(filePath, fileName);
            if(fileToCreate.exists()){
                fileToCreate.delete();
            }
            FileUtils.copyFile(contractReview.getSfsSpecialToolsStatusFile(), fileToCreate);
            contractReview.setSfsSpecialToolsStatusFilePath(fileName);
        } 
        if(contractReview.getTnApprovalManufacturedList() != null){
            String fileName = contractReview.getCode()+"TML."+contractReview.getExt4();
//            String filePath = BaseSession.loadProgramSession().getSetup().getPathImg();
            String filePath = "C:/xampp/htdocs/foto/";
            File fileToCreate = new File(filePath, fileName);
            if(fileToCreate.exists()){
                fileToCreate.delete();
            }
            FileUtils.copyFile(contractReview.getTnApprovalManufacturedList(), fileToCreate);
            contractReview.setTnApprovalManufacturedListPath(fileName);
        }
        if(contractReview.getTnLimitationOrigin()!= null){
            String fileName = contractReview.getCode()+"TLO."+contractReview.getExt5();
//            String filePath = BaseSession.loadProgramSession().getSetup().getPathImg(); 
            String filePath = "C:/xampp/htdocs/foto/";
            File fileToCreate = new File(filePath, fileName);
            if(fileToCreate.exists()){
                fileToCreate.delete();
            }
            FileUtils.copyFile(contractReview.getTnLimitationOrigin(), fileToCreate); 
            contractReview.setTnLimitationOriginPath(fileName);
        } 
       return contractReview;
    }   

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    

}
