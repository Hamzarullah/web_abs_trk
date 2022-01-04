/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author ikb
 */
public class ContractReviewTemp {
    
    private String code="";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private String customerPurchaseOrderCode = "";
    private Date customerPurchaseOrderDate= DateUtils.newDate(1900, 1, 1);
    private String branchCode = "";
    private String branchName = "";
    private String currencyCode = "";
    private String currencyName = "";
    private String projectCode = "";
    private String customerPurchaseOrderNo ="";
    private String salesPersonCode ="";
    private String salesPersonName ="";
    private String customerCode ="";
    private String customerName ="";
    private String endUserCode ="";
    private String endUserName ="";
    private String salesQuotationCode ="";
    private Date salesQuotationTransactionDate = DateUtils.newDate(1900, 1, 1);
    private String salesQuotationSubject ="";
    private String deliveryPoint ="";
    private String deliveryTime ="";
    private String refNo ="";
    private String remark ="";
    
    private String sfsSparepartCommissioningStatus = "";
    private String sfsSparepartCommissioningFilePath = "";
    private String sfs2YearSparepartStatus = "";
    private String sfs2YearSparepartFilePath = "";
    private String sfsSpecialToolsStatus = "";
    private String sfsSpecialToolsStatusFilePath = "";
    private String sfsPackingStatus = "";
    private String sfsPaintingStatus = "";
    private String sfsPaintingSpec = "";
    private String sfsNote = "";
    
    private String dcasPressureTestHydroStatus = "";
    private String dcasPressureTestHydroStatusRemark = "";
    private String dcasPressureTestGasStatus = "";
    private String dcasPressureTestGasStatusRemark = "";
    private String dcasPmiStatus = "";
    private String dcasPmiStatusRemark = "";
    private String dcasWitnessStatus = "";
    private String dcasWitnessStatusRemark = "";
    private String dcasHyperbaricTestStatus = "";
    private String dcasHyperbaricTestStatusRemark = "";
    private String dcasAntiStaticTestStatus = "";
    private String dcasAntiStaticTestStatusRemark = "";
    private String dcasTorqueTestStatus = "";
    private String dcasTorqueTestStatusRemark = "";
    private String dcasDibDbbTestStatus = "";
    private String dcasDibDbbTestStatusRemark = "";
    private String dcasDesignOther = "";
    private String dcasFireSafebyDesignOther = "";
    private String dcasTestingOther = "";
    private String dcasHydroTestOther = "";
    private String dcasVisualExaminationOther = "";
    private String dcasNdeOther = "";
    private String dcasMarkingOther = "";
    private String dcasRequirementOther = "";
    
    private String cadPressureContainingPartsStatus = "";
    private String cadPressureContainingPartsRemark = "";
    private String cadPressureControllingPartsStatus = "";
    private String cadPressureControllingPartsRemark = "";
    private String cadNonPressureControllingPartsStatus = "";
    private String cadNonPressureControllingPartsRemark = "";
    private String cadActuator = "";
    private String cadNote1 = "";
    private String cadNote2 = "";
    private String cadDocumentationForApprovalNote = "";
    
    private String tnActuatorStatus = "";
    private String tnBrandCode = "";
    private String tnBrandName = "";
    private String tnLimitationOriginStatus = "";
    private String tnLimitationOriginPath = "";
    private String tnLimitationOriginRemark = "";
    private String tnApprovalManufacturedListStatus = "";
    private String tnApprovalManufacturedListPath = "";
    private String tnApprovalManufacturedListRemark = "";
    private String tnBom ="";
    private String tnPr ="";
    private String tnPOAndArrivalMat ="";
    private String tnMatchAssTest ="";
    private String tnPainting ="";
    private String tnPackingAndDocumentation ="";
    private String tnEstimationIssueDocumentsApproval ="";
    private String tnNote="";
    
    private String additionalNote="";
    private String conclusionNote="";
    private String createdBy="";
    private Date createdDate=DateUtils.newDate(1900, 1, 1);
    private String updatedBy="";
    private Date updatedDate=DateUtils.newDate(1900, 1, 1);

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getCustomerPurchaseOrderCode() {
        return customerPurchaseOrderCode;
    }

    public void setCustomerPurchaseOrderCode(String customerPurchaseOrderCode) {
        this.customerPurchaseOrderCode = customerPurchaseOrderCode;
    }

    public Date getCustomerPurchaseOrderDate() {
        return customerPurchaseOrderDate;
    }

    public void setCustomerPurchaseOrderDate(Date customerPurchaseOrderDate) {
        this.customerPurchaseOrderDate = customerPurchaseOrderDate;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getCurrencyName() {
        return currencyName;
    }

    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getCustomerPurchaseOrderNo() {
        return customerPurchaseOrderNo;
    }

    public void setCustomerPurchaseOrderNo(String customerPurchaseOrderNo) {
        this.customerPurchaseOrderNo = customerPurchaseOrderNo;
    }

    public String getSalesPersonCode() {
        return salesPersonCode;
    }

    public void setSalesPersonCode(String salesPersonCode) {
        this.salesPersonCode = salesPersonCode;
    }

    public String getSalesPersonName() {
        return salesPersonName;
    }

    public void setSalesPersonName(String salesPersonName) {
        this.salesPersonName = salesPersonName;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEndUserCode() {
        return endUserCode;
    }

    public void setEndUserCode(String endUserCode) {
        this.endUserCode = endUserCode;
    }

    public String getEndUserName() {
        return endUserName;
    }

    public void setEndUserName(String endUserName) {
        this.endUserName = endUserName;
    }

    public String getSalesQuotationCode() {
        return salesQuotationCode;
    }

    public void setSalesQuotationCode(String salesQuotationCode) {
        this.salesQuotationCode = salesQuotationCode;
    }

    public Date getSalesQuotationTransactionDate() {
        return salesQuotationTransactionDate;
    }

    public void setSalesQuotationTransactionDate(Date salesQuotationTransactionDate) {
        this.salesQuotationTransactionDate = salesQuotationTransactionDate;
    }

    public String getSalesQuotationSubject() {
        return salesQuotationSubject;
    }

    public void setSalesQuotationSubject(String salesQuotationSubject) {
        this.salesQuotationSubject = salesQuotationSubject;
    }

    public String getSfsSparepartCommissioningStatus() {
        return sfsSparepartCommissioningStatus;
    }

    public void setSfsSparepartCommissioningStatus(String sfsSparepartCommissioningStatus) {
        this.sfsSparepartCommissioningStatus = sfsSparepartCommissioningStatus;
    }

    public String getSfsSparepartCommissioningFilePath() {
        return sfsSparepartCommissioningFilePath;
    }

    public void setSfsSparepartCommissioningFilePath(String sfsSparepartCommissioningFilePath) {
        this.sfsSparepartCommissioningFilePath = sfsSparepartCommissioningFilePath;
    }

    public String getSfs2YearSparepartStatus() {
        return sfs2YearSparepartStatus;
    }

    public void setSfs2YearSparepartStatus(String sfs2YearSparepartStatus) {
        this.sfs2YearSparepartStatus = sfs2YearSparepartStatus;
    }

    public String getSfs2YearSparepartFilePath() {
        return sfs2YearSparepartFilePath;
    }

    public void setSfs2YearSparepartFilePath(String sfs2YearSparepartFilePath) {
        this.sfs2YearSparepartFilePath = sfs2YearSparepartFilePath;
    }

    public String getSfsSpecialToolsStatus() {
        return sfsSpecialToolsStatus;
    }

    public void setSfsSpecialToolsStatus(String sfsSpecialToolsStatus) {
        this.sfsSpecialToolsStatus = sfsSpecialToolsStatus;
    }

    public String getSfsSpecialToolsStatusFilePath() {
        return sfsSpecialToolsStatusFilePath;
    }

    public void setSfsSpecialToolsStatusFilePath(String sfsSpecialToolsStatusFilePath) {
        this.sfsSpecialToolsStatusFilePath = sfsSpecialToolsStatusFilePath;
    }

    public String getSfsPackingStatus() {
        return sfsPackingStatus;
    }

    public void setSfsPackingStatus(String sfsPackingStatus) {
        this.sfsPackingStatus = sfsPackingStatus;
    }

    public String getSfsPaintingStatus() {
        return sfsPaintingStatus;
    }

    public void setSfsPaintingStatus(String sfsPaintingStatus) {
        this.sfsPaintingStatus = sfsPaintingStatus;
    }

    public String getSfsPaintingSpec() {
        return sfsPaintingSpec;
    }

    public void setSfsPaintingSpec(String sfsPaintingSpec) {
        this.sfsPaintingSpec = sfsPaintingSpec;
    }

    public String getSfsNote() {
        return sfsNote;
    }

    public void setSfsNote(String sfsNote) {
        this.sfsNote = sfsNote;
    }

    public String getDcasPressureTestHydroStatus() {
        return dcasPressureTestHydroStatus;
    }

    public void setDcasPressureTestHydroStatus(String dcasPressureTestHydroStatus) {
        this.dcasPressureTestHydroStatus = dcasPressureTestHydroStatus;
    }

    public String getDcasPressureTestGasStatus() {
        return dcasPressureTestGasStatus;
    }

    public void setDcasPressureTestGasStatus(String dcasPressureTestGasStatus) {
        this.dcasPressureTestGasStatus = dcasPressureTestGasStatus;
    }

    public String getDcasPmiStatus() {
        return dcasPmiStatus;
    }

    public void setDcasPmiStatus(String dcasPmiStatus) {
        this.dcasPmiStatus = dcasPmiStatus;
    }

    public String getDcasWitnessStatus() {
        return dcasWitnessStatus;
    }

    public void setDcasWitnessStatus(String dcasWitnessStatus) {
        this.dcasWitnessStatus = dcasWitnessStatus;
    }

    public String getDcasHyperbaricTestStatus() {
        return dcasHyperbaricTestStatus;
    }

    public void setDcasHyperbaricTestStatus(String dcasHyperbaricTestStatus) {
        this.dcasHyperbaricTestStatus = dcasHyperbaricTestStatus;
    }

    public String getDcasAntiStaticTestStatus() {
        return dcasAntiStaticTestStatus;
    }

    public void setDcasAntiStaticTestStatus(String dcasAntiStaticTestStatus) {
        this.dcasAntiStaticTestStatus = dcasAntiStaticTestStatus;
    }

    public String getDcasTorqueTestStatus() {
        return dcasTorqueTestStatus;
    }

    public void setDcasTorqueTestStatus(String dcasTorqueTestStatus) {
        this.dcasTorqueTestStatus = dcasTorqueTestStatus;
    }

    public String getDcasDibDbbTestStatus() {
        return dcasDibDbbTestStatus;
    }

    public void setDcasDibDbbTestStatus(String dcasDibDbbTestStatus) {
        this.dcasDibDbbTestStatus = dcasDibDbbTestStatus;
    }

    public String getCadPressureContainingPartsStatus() {
        return cadPressureContainingPartsStatus;
    }

    public void setCadPressureContainingPartsStatus(String cadPressureContainingPartsStatus) {
        this.cadPressureContainingPartsStatus = cadPressureContainingPartsStatus;
    }

    public String getCadPressureContainingPartsRemark() {
        return cadPressureContainingPartsRemark;
    }

    public void setCadPressureContainingPartsRemark(String cadPressureContainingPartsRemark) {
        this.cadPressureContainingPartsRemark = cadPressureContainingPartsRemark;
    }

    public String getCadPressureControllingPartsStatus() {
        return cadPressureControllingPartsStatus;
    }

    public void setCadPressureControllingPartsStatus(String cadPressureControllingPartsStatus) {
        this.cadPressureControllingPartsStatus = cadPressureControllingPartsStatus;
    }

    public String getCadPressureControllingPartsRemark() {
        return cadPressureControllingPartsRemark;
    }

    public void setCadPressureControllingPartsRemark(String cadPressureControllingPartsRemark) {
        this.cadPressureControllingPartsRemark = cadPressureControllingPartsRemark;
    }

    public String getCadNonPressureControllingPartsStatus() {
        return cadNonPressureControllingPartsStatus;
    }

    public void setCadNonPressureControllingPartsStatus(String cadNonPressureControllingPartsStatus) {
        this.cadNonPressureControllingPartsStatus = cadNonPressureControllingPartsStatus;
    }

    public String getCadNonPressureControllingPartsRemark() {
        return cadNonPressureControllingPartsRemark;
    }

    public void setCadNonPressureControllingPartsRemark(String cadNonPressureControllingPartsRemark) {
        this.cadNonPressureControllingPartsRemark = cadNonPressureControllingPartsRemark;
    }

    public String getCadActuator() {
        return cadActuator;
    }

    public void setCadActuator(String cadActuator) {
        this.cadActuator = cadActuator;
    }

    public String getCadNote1() {
        return cadNote1;
    }

    public void setCadNote1(String cadNote1) {
        this.cadNote1 = cadNote1;
    }

    public String getCadNote2() {
        return cadNote2;
    }

    public void setCadNote2(String cadNote2) {
        this.cadNote2 = cadNote2;
    }

    public String getCadDocumentationForApprovalNote() {
        return cadDocumentationForApprovalNote;
    }

    public void setCadDocumentationForApprovalNote(String cadDocumentationForApprovalNote) {
        this.cadDocumentationForApprovalNote = cadDocumentationForApprovalNote;
    }

    public String getTnActuatorStatus() {
        return tnActuatorStatus;
    }

    public void setTnActuatorStatus(String tnActuatorStatus) {
        this.tnActuatorStatus = tnActuatorStatus;
    }

    public String getTnBrandCode() {
        return tnBrandCode;
    }

    public void setTnBrandCode(String tnBrandCode) {
        this.tnBrandCode = tnBrandCode;
    }

    public String getTnBrandName() {
        return tnBrandName;
    }

    public void setTnBrandName(String tnBrandName) {
        this.tnBrandName = tnBrandName;
    }

    public String getTnLimitationOriginStatus() {
        return tnLimitationOriginStatus;
    }

    public void setTnLimitationOriginStatus(String tnLimitationOriginStatus) {
        this.tnLimitationOriginStatus = tnLimitationOriginStatus;
    }

    public String getTnLimitationOriginPath() {
        return tnLimitationOriginPath;
    }

    public void setTnLimitationOriginPath(String tnLimitationOriginPath) {
        this.tnLimitationOriginPath = tnLimitationOriginPath;
    }

    public String getTnLimitationOriginRemark() {
        return tnLimitationOriginRemark;
    }

    public void setTnLimitationOriginRemark(String tnLimitationOriginRemark) {
        this.tnLimitationOriginRemark = tnLimitationOriginRemark;
    }

    public String getTnApprovalManufacturedListStatus() {
        return tnApprovalManufacturedListStatus;
    }

    public void setTnApprovalManufacturedListStatus(String tnApprovalManufacturedListStatus) {
        this.tnApprovalManufacturedListStatus = tnApprovalManufacturedListStatus;
    }

    public String getTnApprovalManufacturedListPath() {
        return tnApprovalManufacturedListPath;
    }

    public void setTnApprovalManufacturedListPath(String tnApprovalManufacturedListPath) {
        this.tnApprovalManufacturedListPath = tnApprovalManufacturedListPath;
    }

    public String getTnApprovalManufacturedListRemark() {
        return tnApprovalManufacturedListRemark;
    }

    public void setTnApprovalManufacturedListRemark(String tnApprovalManufacturedListRemark) {
        this.tnApprovalManufacturedListRemark = tnApprovalManufacturedListRemark;
    }

    public String getTnBom() {
        return tnBom;
    }

    public void setTnBom(String tnBom) {
        this.tnBom = tnBom;
    }

    public String getTnPr() {
        return tnPr;
    }

    public void setTnPr(String tnPr) {
        this.tnPr = tnPr;
    }

    public String getTnPOAndArrivalMat() {
        return tnPOAndArrivalMat;
    }

    public void setTnPOAndArrivalMat(String tnPOAndArrivalMat) {
        this.tnPOAndArrivalMat = tnPOAndArrivalMat;
    }

    public String getTnMatchAssTest() {
        return tnMatchAssTest;
    }

    public void setTnMatchAssTest(String tnMatchAssTest) {
        this.tnMatchAssTest = tnMatchAssTest;
    }

    public String getTnPainting() {
        return tnPainting;
    }

    public void setTnPainting(String tnPainting) {
        this.tnPainting = tnPainting;
    }

    public String getTnPackingAndDocumentation() {
        return tnPackingAndDocumentation;
    }

    public void setTnPackingAndDocumentation(String tnPackingAndDocumentation) {
        this.tnPackingAndDocumentation = tnPackingAndDocumentation;
    }

    public String getTnEstimationIssueDocumentsApproval() {
        return tnEstimationIssueDocumentsApproval;
    }

    public void setTnEstimationIssueDocumentsApproval(String tnEstimationIssueDocumentsApproval) {
        this.tnEstimationIssueDocumentsApproval = tnEstimationIssueDocumentsApproval;
    }

    public String getTnNote() {
        return tnNote;
    }

    public void setTnNote(String tnNote) {
        this.tnNote = tnNote;
    }

    public String getAdditionalNote() {
        return additionalNote;
    }

    public void setAdditionalNote(String additionalNote) {
        this.additionalNote = additionalNote;
    }

    public String getConclusionNote() {
        return conclusionNote;
    }

    public void setConclusionNote(String conclusionNote) {
        this.conclusionNote = conclusionNote;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getDeliveryPoint() {
        return deliveryPoint;
    }

    public void setDeliveryPoint(String deliveryPoint) {
        this.deliveryPoint = deliveryPoint;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDcasPressureTestHydroStatusRemark() {
        return dcasPressureTestHydroStatusRemark;
    }

    public void setDcasPressureTestHydroStatusRemark(String dcasPressureTestHydroStatusRemark) {
        this.dcasPressureTestHydroStatusRemark = dcasPressureTestHydroStatusRemark;
    }

    public String getDcasPressureTestGasStatusRemark() {
        return dcasPressureTestGasStatusRemark;
    }

    public void setDcasPressureTestGasStatusRemark(String dcasPressureTestGasStatusRemark) {
        this.dcasPressureTestGasStatusRemark = dcasPressureTestGasStatusRemark;
    }

    public String getDcasPmiStatusRemark() {
        return dcasPmiStatusRemark;
    }

    public void setDcasPmiStatusRemark(String dcasPmiStatusRemark) {
        this.dcasPmiStatusRemark = dcasPmiStatusRemark;
    }

    public String getDcasWitnessStatusRemark() {
        return dcasWitnessStatusRemark;
    }

    public void setDcasWitnessStatusRemark(String dcasWitnessStatusRemark) {
        this.dcasWitnessStatusRemark = dcasWitnessStatusRemark;
    }

    public String getDcasHyperbaricTestStatusRemark() {
        return dcasHyperbaricTestStatusRemark;
    }

    public void setDcasHyperbaricTestStatusRemark(String dcasHyperbaricTestStatusRemark) {
        this.dcasHyperbaricTestStatusRemark = dcasHyperbaricTestStatusRemark;
    }

    public String getDcasAntiStaticTestStatusRemark() {
        return dcasAntiStaticTestStatusRemark;
    }

    public void setDcasAntiStaticTestStatusRemark(String dcasAntiStaticTestStatusRemark) {
        this.dcasAntiStaticTestStatusRemark = dcasAntiStaticTestStatusRemark;
    }

    public String getDcasTorqueTestStatusRemark() {
        return dcasTorqueTestStatusRemark;
    }

    public void setDcasTorqueTestStatusRemark(String dcasTorqueTestStatusRemark) {
        this.dcasTorqueTestStatusRemark = dcasTorqueTestStatusRemark;
    }

    public String getDcasDibDbbTestStatusRemark() {
        return dcasDibDbbTestStatusRemark;
    }

    public void setDcasDibDbbTestStatusRemark(String dcasDibDbbTestStatusRemark) {
        this.dcasDibDbbTestStatusRemark = dcasDibDbbTestStatusRemark;
    }

    public String getDcasDesignOther() {
        return dcasDesignOther;
    }

    public void setDcasDesignOther(String dcasDesignOther) {
        this.dcasDesignOther = dcasDesignOther;
    }

    public String getDcasFireSafebyDesignOther() {
        return dcasFireSafebyDesignOther;
    }

    public void setDcasFireSafebyDesignOther(String dcasFireSafebyDesignOther) {
        this.dcasFireSafebyDesignOther = dcasFireSafebyDesignOther;
    }

    public String getDcasTestingOther() {
        return dcasTestingOther;
    }

    public void setDcasTestingOther(String dcasTestingOther) {
        this.dcasTestingOther = dcasTestingOther;
    }

    public String getDcasHydroTestOther() {
        return dcasHydroTestOther;
    }

    public void setDcasHydroTestOther(String dcasHydroTestOther) {
        this.dcasHydroTestOther = dcasHydroTestOther;
    }

    public String getDcasVisualExaminationOther() {
        return dcasVisualExaminationOther;
    }

    public void setDcasVisualExaminationOther(String dcasVisualExaminationOther) {
        this.dcasVisualExaminationOther = dcasVisualExaminationOther;
    }

    public String getDcasNdeOther() {
        return dcasNdeOther;
    }

    public void setDcasNdeOther(String dcasNdeOther) {
        this.dcasNdeOther = dcasNdeOther;
    }

    public String getDcasMarkingOther() {
        return dcasMarkingOther;
    }

    public void setDcasMarkingOther(String dcasMarkingOther) {
        this.dcasMarkingOther = dcasMarkingOther;
    }

    public String getDcasRequirementOther() {
        return dcasRequirementOther;
    }

    public void setDcasRequirementOther(String dcasRequirementOther) {
        this.dcasRequirementOther = dcasRequirementOther;
    }
    
    
}
