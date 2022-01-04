
package com.inkombizz.sales.model;


import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.utils.DateUtils;
import java.io.File;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.Transient;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "sal_contract_review")
public class ContractReview implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "CUSTCRNo")
    private String custCRNo="";
    
    @Column(name = "Revision")
    private String revision="00";
    
    @Column(name = "RefCUSTCRCode")
    private String refCUSTCRCode="";
    
    @Column(name = "ValidStatus")
    private boolean validStatus=true;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch =null;
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CustomerPurchaseOrderCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private CustomerPurchaseOrder customerPurchaseOrder =null;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesOrderCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    private CustomerSalesOrder salesOrder =null;
    
    @Column(name = "DeliveryPoint")
    private String deliveryPoint="";
    
    @Column(name = "DeliveryTime")
    private String deliveryTime="";
    
    @Column(name = "RefNo")
    private String refNo="";
    
    @Column(name = "Remark")
    private String remark="";
    
    @Column(name = "SFS_SparepartCommissioningStatus")
    private String sfsSparepartCommissioningStatus="REQUIRED";
    
    @Column(name = "SFS_SparepartCommissioningFilePath")
    private String sfsSparepartCommissioningFilePath="";
    
    @Column(name = "SFS_2YearSparepartStatus")
    private String sfs2YearSparepartStatus="REQUIRED";
    
    @Column(name = "SFS_2YearSparepartFilePath")
    private String sfs2YearSparepartFilePath="";
    
    @Column(name = "SFS_SpecialToolsStatus")
    private String sfsSpecialToolsStatus="REQUIRED";
    
    @Column(name = "SFS_SpecialToolsStatusFilePath")
    private String sfsSpecialToolsStatusFilePath="";
    
    @Column(name = "SFS_PackingStatus")
    private String sfsPackingStatus="REQUIRED"; 
    
    @Column(name = "SFS_PaintingStatus")
    private String sfsPaintingStatus="REQUIRED";
    
    @Column(name = "SFS_PaintingSpec")
    private String sfsPaintingSpec="";
    
    @Column(name = "SFS_Note")
    private String sfsNote="";
    
    @Column(name = "DCAS_PressureTestHydroStatus")
    private String dcasPressureTestHydroStatus="REQUIRED";
    
    @Column(name = "DCAS_PressureTestHydroStatusRemark")
    private String dcasPressureTestHydroStatusRemark="";
    
    @Column(name = "DCAS_PressureTestGasStatus")
    private String dcasPressureTestGasStatus="REQUIRED";
    
    @Column(name = "DCAS_PressureTestGasStatusRemark")
    private String dcasPressureTestGasStatusRemark="";
    
    @Column(name = "DCAS_PMIStatus")
    private String dcasPmiStatus="REQUIRED";
    
    @Column(name = "DCAS_PMIStatusRemark")
    private String dcasPmiStatusRemark="";
    
    @Column(name = "DCAS_WitnessStatus")
    private String dcasWitnessStatus="REQUIRED";
    
    @Column(name = "DCAS_WitnessStatusRemark")
    private String dcasWitnessStatusRemark="";
    
    @Column(name = "DCAS_HyperbaricTestStatus")
    private String dcasHyperbaricTestStatus="REQUIRED";
    
    @Column(name = "DCAS_HyperbaricTestStatusRemark")
    private String dcasHyperbaricTestStatusRemark="";
    
    @Column(name = "DCAS_AntiStaticTestStatus")
    private String dcasAntiStaticTestStatus="REQUIRED";
    
    @Column(name = "DCAS_AntiStaticTestStatusRemark")
    private String dcasAntiStaticTestStatusRemark="";
    
    @Column(name = "DCAS_TorqueTestStatus")
    private String dcasTorqueTestStatus="REQUIRED";
    
    @Column(name = "DCAS_TorqueTestStatusRemark")
    private String dcasTorqueTestStatusRemark="";
    
    @Column(name = "DCAS_DIB_DBBTestStatus")
    private String dcasDibDbbTestStatus="REQUIRED";
    
    @Column(name = "DCAS_DIB_DBBTestStatusRemark")
    private String dcasDibDbbTestStatusRemark="";
    
    @Column(name = "DCAS_Design_Other")
    private String dcasDesignOther="";
    
    @Column(name = "DCAS_FireSafebyDesign_Other")
    private String dcasFireSafebyDesignOther="";
    
    @Column(name = "DCAS_Testing_Other")
    private String dcasTestingOther="";
    
    @Column(name = "DCAS_HydroTest_Other")
    private String dcasHydroTestOther="";
    
    @Column(name = "DCAS_VisualExamination_Other")
    private String dcasVisualExaminationOther="";
    
    @Column(name = "DCAS_NDE_Other")
    private String dcasNdeOther="";
    
    @Column(name = "DCAS_Marking_Other")
    private String dcasMarkingOther="";
    
    @Column(name = "DCAS_Requirement_Other")
    private String dcasRequirementOther="";
    
    @Column(name = "CAD_PressureContainingPartsStatus")
    private String cadPressureContainingPartsStatus="TYPE_3.2";
    
    @Column(name = "CAD_PressureContainingPartsRemark")
    private String cadPressureContainingPartsRemark="";
    
    @Column(name = "CAD_PressureControllingPartsStatus")
    private String cadPressureControllingPartsStatus="TYPE_3.2";
    
    @Column(name = "CAD_PressureControllingPartsRemark")
    private String cadPressureControllingPartsRemark="";
    
    @Column(name = "CAD_NonPressureControllingPartsStatus")
    private String cadNonPressureControllingPartsStatus="TYPE_2.2";
    
    @Column(name = "CAD_NonPressureControllingPartsRemark")
    private String cadNonPressureControllingPartsRemark="";
    
    @Column(name = "CAD_Actuator")
    private String cadActuator="";
    
    @Column(name = "CAD_Note1")
    private String cadNote1="";
    
    @Column(name = "CAD_Note2")
    private String cadNote2="";
    
    @Column(name = "CAD_DocumentationForApprovalNote")
    private String cadDocumentationForApprovalNote="";
    
    @Column(name = "TN_ActuatorStatus")
    private String tnActuatorStatus="YES";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "TN_BrandCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private ItemBrand tnBrand=null;
    
    @Column(name = "TN_LimitationOriginStatus")
    private String tnLimitationOriginStatus="YES";
    
    @Column(name = "TN_LimitationOriginPath")
    private String tnLimitationOriginPath="";
    
    @Column(name = "TN_LimitationOriginRemark")
    private String tnLimitationOriginRemark="";
    
    @Column(name = "TN_ApprovalManufacturedListStatus")
    private String tnApprovalManufacturedListStatus="YES";
    
    @Column(name = "TN_ApprovalManufacturedListPath")
    private String tnApprovalManufacturedListPath="";
    
    @Column(name = "TN_ApprovalManufacturedListRemark")
    private String tnApprovalManufacturedListRemark="";
    
    @Column(name = "TN_BOM")
    private String tnBom = "";
    
    @Column(name = "TN_PR")
    private String tnPr = "";
    
    @Column(name = "TN_POAndArrivalMat")
    private String tnPOAndArrivalMat = "";
    
    @Column(name = "TN_MatchAssTest")
    private String tnMatchAssTest = "";
    
    @Column(name = "TN_Painting")
    private String tnPainting ="";
    
    @Column(name = "TN_PackingAndDocumentation")
    private String tnPackingAndDocumentation ="";
    
    @Column(name = "TN_EstimationIssueDocumentsApproval")
    private String tnEstimationIssueDocumentsApproval ="";
    
    @Column(name = "TN_Note")
     private String tnNote="";
    
    @Column(name = "AdditionalNote")
     private String additionalNote="";
    
    @Column(name = "ConclusionNote")
     private String conclusionNote="";
    
    @Column(name="CreatedBy")
     private String createdBy="";
    
    @Column(name="CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
     private Date createdDate=DateUtils.newDate(1990, 01, 01);
    
    @Column(name="UpdatedBy")
     private String updatedBy="";
    
    @Column(name="UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
     private Date updatedDate=DateUtils.newDate(1990, 01, 01);
    
    @Transient private String ext1="";
    @Transient private String ext2="";
    @Transient private String ext3="";
    @Transient private String ext4="";
    @Transient private String ext5="";
    @Transient private String salesOrderCode="";
    @Transient private String branchCode="";
    @Transient private String branchName="";
    @Transient private File sfsSparepartCommissioningFile=null;
    @Transient private File sfs2YearSparepartFile=null;
    @Transient private File sfsSpecialToolsStatusFile=null;
    @Transient private File tnLimitationOrigin=null;
    @Transient private File tnApprovalManufacturedList=null;

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

    public CustomerPurchaseOrder getCustomerPurchaseOrder() {
        return customerPurchaseOrder;
    }

    public void setCustomerPurchaseOrder(CustomerPurchaseOrder customerPurchaseOrder) {
        this.customerPurchaseOrder = customerPurchaseOrder;
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

    public ItemBrand getTnBrand() {
        return tnBrand;
    }

    public void setTnBrand(ItemBrand tnBrand) {
        this.tnBrand = tnBrand;
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

    public String getExt1() {
        return ext1;
    }

    public void setExt1(String ext1) {
        this.ext1 = ext1;
    }

    public String getExt2() {
        return ext2;
    }

    public void setExt2(String ext2) {
        this.ext2 = ext2;
    }

    public String getExt3() {
        return ext3;
    }

    public void setExt3(String ext3) {
        this.ext3 = ext3;
    }

    public String getExt4() {
        return ext4;
    }

    public void setExt4(String ext4) {
        this.ext4 = ext4;
    }

    public String getExt5() {
        return ext5;
    }

    public void setExt5(String ext5) {
        this.ext5 = ext5;
    }

    public File getSfsSparepartCommissioningFile() {
        return sfsSparepartCommissioningFile;
    }

    public void setSfsSparepartCommissioningFile(File sfsSparepartCommissioningFile) {
        this.sfsSparepartCommissioningFile = sfsSparepartCommissioningFile;
    }

    public File getSfs2YearSparepartFile() {
        return sfs2YearSparepartFile;
    }

    public void setSfs2YearSparepartFile(File sfs2YearSparepartFile) {
        this.sfs2YearSparepartFile = sfs2YearSparepartFile;
    }

    public File getSfsSpecialToolsStatusFile() {
        return sfsSpecialToolsStatusFile;
    }

    public void setSfsSpecialToolsStatusFile(File sfsSpecialToolsStatusFile) {
        this.sfsSpecialToolsStatusFile = sfsSpecialToolsStatusFile;
    }

    public File getTnLimitationOrigin() {
        return tnLimitationOrigin;
    }

    public void setTnLimitationOrigin(File tnLimitationOrigin) {
        this.tnLimitationOrigin = tnLimitationOrigin;
    }

    public File getTnApprovalManufacturedList() {
        return tnApprovalManufacturedList;
    }

    public void setTnApprovalManufacturedList(File tnApprovalManufacturedList) {
        this.tnApprovalManufacturedList = tnApprovalManufacturedList;
    }

    public String getCustCRNo() {
        return custCRNo;
    }

    public void setCustCRNo(String custCRNo) {
        this.custCRNo = custCRNo;
    }

    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    public String getRefCUSTCRCode() {
        return refCUSTCRCode;
    }

    public void setRefCUSTCRCode(String refCUSTCRCode) {
        this.refCUSTCRCode = refCUSTCRCode;
    }

    public boolean isValidStatus() {
        return validStatus;
    }

    public void setValidStatus(boolean validStatus) {
        this.validStatus = validStatus;
    }

    public String getSalesOrderCode() {
        return salesOrderCode;
    }

    public void setSalesOrderCode(String salesOrderCode) {
        this.salesOrderCode = salesOrderCode;
    }

    public CustomerSalesOrder getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(CustomerSalesOrder salesOrder) {
        this.salesOrder = salesOrder;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
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
