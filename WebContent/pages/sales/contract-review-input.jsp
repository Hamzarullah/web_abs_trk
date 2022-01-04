<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
   var  contractReviewValveType_lastSel = -1,
        contractReviewValveType_rowId = 0,
        
        contractReviewDcasDesign_lastSel = -1,
        contractReviewDcasDesign_rowId = 0,

        contractReviewDcasFireSafeByDesign_lastSel = -1,
        contractReviewDcasFireSafeByDesign_rowId = 0,
        
        contractReviewDcasTesting_lastSel = -1,
        contractReviewDcasTesting_rowId = 0,
        
        contractReviewDcasHydroTest_lastSel = -1,
        contractReviewDcasHydroTest_rowId = 0,
        
        contractReviewDcasVisualExamination_lastSel = -1,
        contractReviewDcasVisualExamination_rowId = 0,
        
        contractReviewDcasNde_lastSel = -1,
        contractReviewDcasNde_rowId = 0,
        
        contractReviewDcasMarking_lastSel = -1,
        contractReviewDcasMarking_rowId = 0,
        
        contractReviewDcasLegalRequirements_lastSel = -1,
        contractReviewDcasLegalRequirements_rowId = 0,
        
        contractReviewSalesQuotation_lastSel = -1,
        contractReviewSalesQuotation_rowId = 0,
        
        contractReviewCadDocumentApproval_lastSel = -1,
        contractReviewCadDocumentApproval_rowId = 0;
        
   var                                    
        txtContractReviewCode = $("#contractReview\\.code"),
        txtContractReviewBranchCode = $("#contractReview\\.branch\\.code"),
        txtContractReviewBranchName = $("#contractReview\\.branch\\.name"),
        dtpContractReviewTransactionDate = $("#contractReview\\.transactionDate"),
        txtContractReviewCustomerPurchaseOrderCode = $("#contractReview\\.customerPurchaseOrder\\.code"),
        txtContractReviewCustomerPurchaseOrderBranchCode = $("#contractReview\\.customerPurchaseOrder\\.branch\\.code"),
        txtContractReviewCustomerPurchaseOrderBranchName = $("#contractReview\\.customerPurchaseOrder\\.branch\\.name"),
        txtContractReviewCustomerPurchaseOrderCurrencyCode = $("#contractReview\\.customerPurchaseOrder\\.currency\\.code"),
        txtContractReviewCustomerPurchaseOrderCurrencyName = $("#contractReview\\.customerPurchaseOrder\\.currency\\.name"),
        txtContractReviewCustomerPurchaseOrderProjectCode = $("#contractReview\\.customerPurchaseOrder\\.project\\.code"),
        txtContractReviewCustomerPurchaseOrderNo = $("#contractReview\\.customerPurchaseOrder\\.customerPurchaseOrderNo"),
        txtContractReviewCustomerPurchaseOrderCustomerCode = $("#contractReview\\.customerPurchaseOrder\\.customer\\.code"),
        txtContractReviewCustomerPurchaseOrderCustomerName = $("#contractReview\\.customerPurchaseOrder\\.customer\\.name"),
        txtContractReviewCustomerPurchaseOrderEndUserCode = $("#contractReview\\.customerPurchaseOrder\\.endUser\\.code"),
        txtContractReviewCustomerPurchaseOrderEndUserName = $("#contractReview\\.customerPurchaseOrder\\.endUser\\.name"),
        txtContractReviewCustomerPurchaseOrderSalesPersonCode = $("#contractReview\\.customerPurchaseOrder\\.salesPerson\\.code"),
        txtContractReviewCustomerPurchaseOrderSalesPersonName = $("#contractReview\\.customerPurchaseOrder\\.salesPerson\\.name"),
        
        txtContractReviewSfsSparepartCommissioningFilePath = $("#contractReview\\.sfsSparepartCommissioningFile"),
        txtContractReviewSfs2YearSparepartFilePath = $("#contractReview\\.sfs2YearSparepartFile"),
        txtContractReviewSfsSpecialToolsFilePath = $("#contractReview\\.sfsSpecialToolsStatusFile"),
        
        txtContractReviewTnBrandCode = $("#contractReview\\.tnBrand\\.code"),
        txtContractReviewTnBrandName = $("#contractReview\\.tnBrand\\.name"),
        txtContractReviewTnLimitationOriginPath = $("#contractReview\\.tnLimitationOrigin"),
        txtContractReviewTnApprovalManufacturedListPath = $("#contractReview\\.tnApprovalManufacturedList");
    
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        var code = txtContractReviewCustomerPurchaseOrderCode.val();
        
       if ($("#enumContractReviewActivity").val()==="UPDATE" || $("#enumContractReviewActivity").val()==="REVISE"){
            loadDataContractReviewDetail(code);
            loadValveTypeDetail();
            loadDcasDesignDetail();
            loadDcasFireSafeByDesignDetail();
            loadDcasTestingDetail();
            loadDcasHydroTestDetail();
            loadDcasVisualExaminationDetail();
            loadDcasNdeDetail();
            loadDcasMarkingDetail();
            loadDcasLegalRequirementsDetail();
            loadCadDocumentApprovalDetail();
            radioButtonStatusContractReview();
        }
        else{
//       SFS
        $('#contractReviewSfsSparepartCommissioningStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.sfsSparepartCommissioningStatus").val("REQUIRED");
        
        $('#contractReviewSfs2YearSparepartStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.sfs2YearSparepartStatus").val("REQUIRED");
        
        $('#contractReviewSfsSpecialToolsStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.sfsSpecialToolsStatus").val("REQUIRED");
        
        $('#contractReviewSfsPackingStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.sfsPackingStatus").val("REQUIRED");
        
        $('#contractReviewSfsPaintingStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.sfsPaintingStatus").val("REQUIRED");
        
//        DCAS
        $('#contractReviewDcasPressureTestHydroStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasPressureTestHydroStatus").val("REQUIRED");
        
        $('#contractReviewDcasPressureTestGasStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasPressureTestGasStatus").val("REQUIRED");
        
        $('#contractReviewDcasPmiStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasPmiStatus").val("REQUIRED");
        
        $('#contractReviewDcasWitnessStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasWitnessStatus").val("REQUIRED");
        
        $('#contractReviewDcasHyperbaricTestStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasHyperbaricTestStatus").val("REQUIRED");
        
        $('#contractReviewDcasAntiStaticTestStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasAntiStaticTestStatus").val("REQUIRED");
        
        $('#contractReviewDcasTorqueTestStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasTorqueTestStatus").val("REQUIRED");
        
        $('#contractReviewDcasDibDbbTestStatusRadREQUIRED').prop('checked',true);
        $("#contractReview\\.dcasDibDbbTestStatus").val("REQUIRED");
        
//        CAD
        $('#contractReviewCadPressureContainingPartsStatusRadTYPE_3\\.2').prop('checked',true);
        $("#contractReview\\.cadPressureContainingPartsStatus").val("TYPE_3.2");
        
        $('#contractReviewCadPressureControllingPartsStatusRadTYPE_3\\.2').prop('checked',true);
        $("#contractReview\\.cadPressureControllingPartsStatus").val("TYPE_3.2");
        
        $('#contractReviewCadNonPressureControllingPartsStatusRadTYPE_2\\.2').prop('checked',true);
        $("#contractReview\\.cadNonPressureControllingPartsStatus").val("TYPE_2.2");
        
//        TN
        $('#contractReviewTnActuatorStatusRadYES').prop('checked',true);
        $("#contractReview\\.tnActuatorStatus").val("YES");
        
        
        $('#contractReviewTnLimitationOriginStatusRadYES').prop('checked',true);
        $("#contractReview\\.tnLimitationOriginStatus").val("YES");
        
        $('#contractReviewTnApprovalManufacturedListStatusRadYES').prop('checked',true);
        $("#contractReview\\.tnApprovalManufacturedListStatus").val("YES");
        
        }
        
//        SFS
        $('#contractReviewSfsSparepartCommissioningStatusRadREQUIRED').change(function(ev){
        $("#contractReview\\.sfsSparepartCommissioningStatus").val("REQUIRED");
        });
        
        $('#contractReviewSfsSparepartCommissioningStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.sfsSparepartCommissioningStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewSfs2YearSparepartStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.sfs2YearSparepartStatus").val("REQUIRED");
        });
        
        $('#contractReviewSfs2YearSparepartStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.sfs2YearSparepartStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewSfsSpecialToolsStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.sfsSpecialToolsStatus").val("REQUIRED");
        });
        
        $('#contractReviewSfsSpecialToolsStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.sfsSpecialToolsStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewSfsPackingStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.sfsPackingStatus").val("REQUIRED");
        });
        
        $('#contractReviewSfsPackingStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.sfsPackingStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewSfsPaintingStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.sfsPaintingStatus").val("REQUIRED");
        });
                
        $('#contractReviewSfsPaintingStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.sfsPaintingStatus").val("NOT_REQUIRED");
        });
         
//        DCAS
               
        $('#contractReviewDcasPressureTestHydroStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasPressureTestHydroStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasPressureTestHydroStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasPressureTestHydroStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasPressureTestHydroStatusRadOTHER').change(function(ev){
            $("#contractReview\\.dcasPressureTestHydroStatus").val("OTHER");
        });
               
        $('#contractReviewDcasPressureTestGasStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasPressureTestGasStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasPressureTestGasStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasPressureTestGasStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasPressureTestGasStatusRadOTHER').change(function(ev){
            $("#contractReview\\.dcasPressureTestGasStatus").val("OTHER");
        });
               
        $('#contractReviewDcasPmiStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasPmiStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasPmiStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasPmiStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasPmiStatusRadOTHER').change(function(ev){
            $("#contractReview\\.dcasPmiStatus").val("OTHER");
        });
       
        $('#contractReviewDcasWitnessStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasWitnessStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasWitnessStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasWitnessStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasWitnessStatusRadAS_PER_APPROVED_ITP').change(function(ev){
            $("#contractReview\\.dcasWitnessStatus").val("AS_PER_APPROVED_ITP");
        });
       
        $('#contractReviewDcasHyperbaricTestStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasHyperbaricTestStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasHyperbaricTestStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasHyperbaricTestStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasHyperbaricTestStatusRadOTHER').change(function(ev){
            $("#contractReview\\.dcasHyperbaricTestStatus").val("OTHER");
        });
             
        $('#contractReviewDcasAntiStaticTestStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasAntiStaticTestStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasAntiStaticTestStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasAntiStaticTestStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasAntiStaticTestStatusRadOTHER').change(function(ev){
            $("#contractReview\\.dcasAntiStaticTestStatus").val("OTHER");
        });
              
        $('#contractReviewDcasTorqueTestStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasTorqueTestStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasTorqueTestStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasTorqueTestStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasTorqueTestStatusRadOTHER').change(function(ev){
            $("#contractReview\\.dcasTorqueTestStatus").val("OTHER");
        });
               
        $('#contractReviewDcasDibDbbTestStatusRadREQUIRED').change(function(ev){
            $("#contractReview\\.dcasDibDbbTestStatus").val("REQUIRED");
        });
                
        $('#contractReviewDcasDibDbbTestStatusRadNOT_REQUIRED').change(function(ev){
            $("#contractReview\\.dcasDibDbbTestStatus").val("NOT_REQUIRED");
        });
        
        $('#contractReviewDcasDibDbbTestStatusRadOTHER').change(function(ev){
            $("#contractReview\\.dcasDibDbbTestStatus").val("OTHER");
        });

//        CAD

        $('#contractReviewCadPressureContainingPartsStatusRadTYPE_3\\.2').change(function(ev){
            $("#contractReview\\.cadPressureContainingPartsStatus").val("TYPE_3.2");
        });
        
        $('#contractReviewCadPressureContainingPartsStatusRadTYPE_3\\.1').change(function(ev){
            $("#contractReview\\.cadPressureContainingPartsStatus").val("TYPE_3.1");
        });

        $('#contractReviewCadPressureContainingPartsStatusRadOTHER').change(function(ev){
            $("#contractReview\\.cadPressureContainingPartsStatus").val("OTHER");
        });
       
        $('#contractReviewCadPressureControllingPartsStatusRadTYPE_3\\.2').change(function(ev){
            $("#contractReview\\.cadPressureControllingPartsStatus").val("TYPE_3.2");
        });
                
        $('#contractReviewCadPressureControllingPartsStatusRadTYPE_3\\.1').change(function(ev){
            $("#contractReview\\.cadPressureControllingPartsStatus").val("TYPE_3.1");
        });
        
        $('#contractReviewCadPressureControllingPartsStatusRadTYPE_2\\.2').change(function(ev){
            $("#contractReview\\.cadPressureControllingPartsStatus").val("TYPE_2.2");
        });
        
        $('#contractReviewCadPressureControllingPartsStatusRadOTHER').change(function(ev){
            $("#contractReview\\.cadPressureControllingPartsStatus").val("OTHER");
        });
        
        $('#contractReviewCadNonPressureControllingPartsStatusRadTYPE_2\\.2').change(function(ev){
            $("#contractReview\\.cadNonPressureControllingPartsStatus").val("TYPE_2.2");
        });
                
        $('#contractReviewCadNonPressureControllingPartsStatusRadTYPE_2\\.1').change(function(ev){
            $("#contractReview\\.cadNonPressureControllingPartsStatus").val("TYPE_2.1");
        });
        
        $('#contractReviewCadNonPressureControllingPartsStatusRadOTHER').change(function(ev){
            $("#contractReview\\.cadNonPressureControllingPartsStatus").val("OTHER");
        });
        
//        TN
        
        $('#contractReviewTnActuatorStatusRadYES').change(function(ev){
            $("#contractReview\\.tnActuatorStatus").val("YES");
            $("#contractReview\\.tnBrand\\.code").val("");
            txtContractReviewTnBrandCode.attr("readonly",false);
            
            $("#contractReview\\.tnBrand\\.name").val("");
            $("#contractReview_btnBrand").show();
        });
        
        $('#contractReviewTnActuatorStatusRadNO').change(function(ev){
            $("#contractReview\\.tnActuatorStatus").val("NO");
            $("#contractReview\\.tnBrand\\.code").val("");
            txtContractReviewTnBrandCode.attr("readonly",true);
            
            $("#contractReview\\.tnBrand\\.name").val("");
            $("#contractReview_btnBrand").hide();
        });
        
        $('#contractReviewTnLimitationOriginStatusRadYES').change(function(ev){
            $("#contractReview\\.tnLimitationOriginStatus").val("YES");
        });
        
        $('#contractReviewTnLimitationOriginStatusRadNO').change(function(ev){
            $("#contractReview\\.tnLimitationOriginStatus").val("NO");
        });
        
        $('#contractReviewTnApprovalManufacturedListStatusRadYES').change(function(ev){
            $("#contractReview\\.tnApprovalManufacturedListStatus").val("YES");
        });
        
        $('#contractReviewTnApprovalManufacturedListStatusRadNO').change(function(ev){
            $("#contractReview\\.tnApprovalManufacturedListStatus").val("NO");
        });
        
//        $("#contractReview\\.salesOrderCode").val($("#contractReview\\.customerPurchaseOrder\\.salesOrderCode").val());
       
      $.subscribe("contractReviewSalesQuotationInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewSalesQuotation_lastSel) {
                $('#contractReviewSalesQuotationInput_grid').jqGrid("saveRow",contractReviewSalesQuotation_lastSel); 
                $('#contractReviewSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewSalesQuotation_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewValveTypeInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewValveTypeInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewValveType_lastSel) {
                $('#contractReviewValveTypeInput_grid').jqGrid("saveRow",contractReviewValveType_lastSel); 
                $('#contractReviewValveTypeInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewValveType_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewValveTypeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasDesignInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasDesignInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasDesign_lastSel) {
                $('#contractReviewDcasDesignInput_grid').jqGrid("saveRow",contractReviewDcasDesign_lastSel); 
                $('#contractReviewDcasDesignInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasDesign_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasDesignInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasFireSafeByDesignInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasFireSafeByDesign_lastSel) {
                $('#contractReviewDcasFireSafeByDesignInput_grid').jqGrid("saveRow",contractReviewDcasFireSafeByDesign_lastSel); 
                $('#contractReviewDcasFireSafeByDesignInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasFireSafeByDesign_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasFireSafeByDesignInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasTestingInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasTestingInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasTesting_lastSel) {
                $('#contractReviewDcasTestingInput_grid').jqGrid("saveRow",contractReviewDcasTesting_lastSel); 
                $('#contractReviewDcasTestingInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasTesting_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasTestingInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasHydroTestInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasHydroTestInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasHydroTest_lastSel) {
                $('#contractReviewDcasHydroTestInput_grid').jqGrid("saveRow",contractReviewDcasHydroTest_lastSel); 
                $('#contractReviewDcasHydroTestInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasHydroTest_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasHydroTestInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasVisualExaminationInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasVisualExaminationInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasVisualExamination_lastSel) {
                $('#contractReviewDcasVisualExaminationInput_grid').jqGrid("saveRow",contractReviewDcasVisualExamination_lastSel); 
                $('#contractReviewDcasVisualExaminationInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasVisualExamination_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasVisualExaminationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasNdeInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasNdeInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasNde_lastSel) {
                $('#contractReviewDcasNdeInput_grid').jqGrid("saveRow",contractReviewDcasNde_lastSel); 
                $('#contractReviewDcasNdeInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasNde_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasNdeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasMarkingInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasMarkingInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasMarking_lastSel) {
                $('#contractReviewDcasMarkingInput_grid').jqGrid("saveRow",contractReviewDcasMarking_lastSel); 
                $('#contractReviewDcasMarkingInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasMarking_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasMarkingInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewDcasLegalRequirementsInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewDcasLegalRequirements_lastSel) {
                $('#contractReviewDcasLegalRequirementsInput_grid').jqGrid("saveRow",contractReviewDcasLegalRequirements_lastSel); 
                $('#contractReviewDcasLegalRequirementsInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewDcasLegalRequirements_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewDcasLegalRequirementsInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
      $.subscribe("contractReviewCadDocumentApprovalInput_grid_onSelect", function() {
            var selectedRowID = $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==contractReviewCadDocumentApproval_lastSel) {
                $('#contractReviewCadDocumentApprovalInput_grid').jqGrid("saveRow",contractReviewCadDocumentApproval_lastSel); 
                $('#contractReviewCadDocumentApprovalInput_grid').jqGrid("editRow",selectedRowID,true);            
                contractReviewCadDocumentApproval_lastSel=selectedRowID;
            }
            else{
                $('#contractReviewCadDocumentApprovalInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
//        Button Look Up 
        $('#btnValveTypeSearch').click(function(ev) {
            var ids = jQuery("#contractReviewValveTypeInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-valve-type-multiple.jsp?iddoc=contractReviewValveType&type=grid&rowLast="+ids.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnDcasDesignSearch').click(function(ev) {
            var idk = jQuery("#contractReviewDcasDesignInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-design.jsp?iddoc=contractReviewDcasDesign&type=grid&rowLast="+idk.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnDcasFireSafeByDesignSearch').click(function(ev) {
            var idl = jQuery("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-fire-safe-by-design.jsp?iddoc=contractReviewDcasFireSafeByDesign&type=grid&rowLast="+idl.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnDcasTestingSearch').click(function(ev) {
            var idj = jQuery("#contractReviewDcasTestingInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-testing.jsp?iddoc=contractReviewDcasTesting&type=grid&rowLast="+idj.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnDcasHydroTestSearch').click(function(ev) {
            var idk = jQuery("#contractReviewDcasHydroTestInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-hydro-test.jsp?iddoc=contractReviewDcasHydroTest&type=grid&rowLast="+idk.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnDcasVisualExaminationSearch').click(function(ev) {
            var idm = jQuery("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-visual-examination.jsp?iddoc=contractReviewDcasVisualExamination&type=grid&rowLast="+idm.length,"Search", "scrollbars=1,width=600, height=500");
        });  
        
        $('#btnDcasNdeSearch').click(function(ev) {
            var idn = jQuery("#contractReviewDcasNdeInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-nde.jsp?iddoc=contractReviewDcasNde&type=grid&rowLast="+idn.length,"Search", "scrollbars=1,width=600, height=500");
        });  
        
        $('#btnDcasMarkingSearch').click(function(ev) {
            var ido = jQuery("#contractReviewDcasMarkingInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-marking.jsp?iddoc=contractReviewDcasMarking&type=grid&rowLast="+ido.length,"Search", "scrollbars=1,width=600, height=500");
        });  
        
        $('#btnDcasLegalRequirementsSearch').click(function(ev) {
            var idp = jQuery("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-dcas-legal-requirements.jsp?iddoc=contractReviewDcasLegalRequirements&type=grid&rowLast="+idp.length,"Search", "scrollbars=1,width=600, height=500");
        });  
        
        $('#btnCadDocumentApprovalSearch').click(function(ev) {
            var idq = jQuery("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-cad-document-approval.jsp?iddoc=contractReviewCadDocumentApproval&type=grid&rowLast="+idq.length,"Search", "scrollbars=1,width=600, height=500");
        });  
        
      $('#btnContractReviewSave').click(function(ev) {
          
        var date1 = dtpContractReviewTransactionDate.val().split("/");
        var month1 = date1[1];
        var year1 = date1[2].split(" ");
        var date2 = $("#contractReviewTransactionDate").val().split("/");
        var month2 = date2[1];
        var year2 = date2[2].split(" ");

        if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
            if($('#enumContractReviewActivity').val() === 'UPDATE'){
                alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#contractReviewTransactionDate").val(),dtpContractReviewTransactionDate);
            }else{
                alertMessage("Transaction Month Must Between Session Period Month!",dtpContractReviewTransactionDate);
            }
            return;
        }

        if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
            if($('#enumContractReviewActivity').val() === 'UPDATE'){
                alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#contractReviewTransactionDate").val(),dtpContractReviewTransactionDate);
            }else{
                alertMessage("Transaction Year Must Between Session Period Year!",dtpContractReviewTransactionDate);
            }
            return;
        }  
          
        if($("#contractReview\\.tnActuatorStatus").val() === "YES"){
            if(txtContractReviewTnBrandCode.val()===""){
                alertMessage("Fill The Brand");
                return;
            }
        
            if(txtContractReviewBranchCode.val()===""){
                alertMessage("Fill The Branch");
                return;
            } 
        }  
        
        $("#contractReview\\.ext1").val(txtContractReviewSfsSparepartCommissioningFilePath.val().split('.').pop());
        $("#contractReview\\.ext2").val(txtContractReviewSfs2YearSparepartFilePath.val().split('.').pop());
        $("#contractReview\\.ext3").val(txtContractReviewSfsSpecialToolsFilePath.val().split('.').pop());
        $("#contractReview\\.ext4").val(txtContractReviewTnLimitationOriginPath.val().split('.').pop());
        $("#contractReview\\.ext5").val(txtContractReviewTnApprovalManufacturedListPath.val().split('.').pop());
        
                if(contractReviewValveType_lastSel !== -1) {
                    $('#contractReviewValveTypeInput_grid').jqGrid("saveRow",contractReviewValveType_lastSel);
                }
                if(contractReviewDcasDesign_lastSel !== -1) {
                    $('#contractReviewDcasDesignInput_grid').jqGrid("saveRow",contractReviewDcasDesign_lastSel);
                }
                if(contractReviewDcasFireSafeByDesign_lastSel !== -1) {
                    $('#contractReviewDcasFireSafeByDesignInput_grid').jqGrid("saveRow",contractReviewDcasFireSafeByDesign_lastSel);
                }
                if(contractReviewDcasTesting_lastSel !== -1) {
                    $('#contractReviewDcasTestingInput_grid').jqGrid("saveRow",contractReviewDcasTesting_lastSel);
                }
                if(contractReviewDcasHydroTest_lastSel !== -1) {
                    $('#contractReviewDcasHydroTestInput_grid').jqGrid("saveRow",contractReviewDcasHydroTest_lastSel);
                }
                if(contractReviewDcasNde_lastSel !== -1) {
                    $('#contractReviewDcasNdeInput_grid').jqGrid("saveRow",contractReviewDcasNde_lastSel);
                }
                if(contractReviewDcasMarking_lastSel !== -1) {
                    $('#contractReviewDcasMarkingInput_grid').jqGrid("saveRow",contractReviewDcasMarking_lastSel);
                }
                if(contractReviewDcasVisualExamination_lastSel !== -1) {
                    $('#contractReviewDcasVisualExaminationInput_grid').jqGrid("saveRow",contractReviewDcasVisualExamination_lastSel);
                }
                if(contractReviewDcasLegalRequirements_lastSel !== -1) {
                    $('#contractReviewDcasLegalRequirementsInput_grid').jqGrid("saveRow",contractReviewDcasLegalRequirements_lastSel);
                }
                if(contractReviewSalesQuotation_lastSel !== -1) {
                    $('#contractReviewSalesQuotationInput_grid').jqGrid("saveRow",contractReviewSalesQuotation_lastSel);
                }
                if(contractReviewCadDocumentApproval_lastSel !== -1) {
                    $('#contractReviewCadDocumentApprovalInput_grid').jqGrid("saveRow",contractReviewCadDocumentApproval_lastSel);
                }

                var listContractReviewSalesQuotation = new Array();
                var listContractReviewValveType = new Array();
                var listContractReviewDCASDesign = new Array();
                var listContractReviewDCASFireSafeByDesign = new Array();
                var listContractReviewDCASTesting = new Array();
                var listContractReviewDCASHydroTest = new Array();
                var listContractReviewDCASVisualExamination = new Array();
                var listContractReviewDCASNde = new Array();
                var listContractReviewDCASMarking = new Array();
                var listContractReviewDCASLegalRequirements = new Array();
                var listContractReviewCADDocumentApproval = new Array();
                
                var idq = jQuery("#contractReviewSalesQuotationInput_grid").jqGrid('getDataIDs');
                var idr = jQuery("#contractReviewValveTypeInput_grid").jqGrid('getDataIDs');
                var ids = jQuery("#contractReviewDcasDesignInput_grid").jqGrid('getDataIDs');
                var idt = jQuery("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getDataIDs');
                var idu = jQuery("#contractReviewDcasTestingInput_grid").jqGrid('getDataIDs');
                var idv = jQuery("#contractReviewDcasHydroTestInput_grid").jqGrid('getDataIDs');
                var idw = jQuery("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getDataIDs');
                var idx = jQuery("#contractReviewDcasNdeInput_grid").jqGrid('getDataIDs');
                var idy = jQuery("#contractReviewDcasMarkingInput_grid").jqGrid('getDataIDs');
                var idz = jQuery("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getDataIDs');
                var idl = jQuery("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getDataIDs');

//                if(idq.length===0){
//                    alertMessage("Data can not empty..!!! ");
//                    return;
//                }
                
                 //Sales Quptation
                for(var q=0;q < idq.length;q++){ 
                    var data = $("#contractReviewSalesQuotationInput_grid").jqGrid('getRowData',idq[q]); 

                    var contractReviewSalesQuotation = { 
                        salesQuotation              : {code:data.contractReviewSalesQuotationCode}
                    };
                    listContractReviewSalesQuotation[q] = contractReviewSalesQuotation;
                }
                
                 //Valve Type
                for(var r=0;r < idr.length;r++){ 
                    var data = $("#contractReviewValveTypeInput_grid").jqGrid('getRowData',idr[r]); 

                    var contractReviewValveType = { 
                        valveType             : {code:data.contractReviewValveTypeCode}
                    };
                    listContractReviewValveType[r] = contractReviewValveType;
                }
                
                 //DCAS Design
                for(var s=0;s < ids.length;s++){ 
                    var data = $("#contractReviewDcasDesignInput_grid").jqGrid('getRowData',ids[s]); 

                    var contractReviewDcasDesign = { 
                        dcasDesign             : {code:data.contractReviewDcasDesignCode}
                    };
                    listContractReviewDCASDesign[s] = contractReviewDcasDesign;
                }
               
                 //DCAS Fire Safe By Design
                for(var t=0;t < idt.length;t++){ 
                    var data = $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getRowData',idt[t]); 

                    var contractReviewDcasFireSafeByDesign = { 
                        dcasFireSafeByDesign             : {code:data.contractReviewDcasFireSafeByDesignCode}
                    };
                    listContractReviewDCASFireSafeByDesign[t] = contractReviewDcasFireSafeByDesign;
                }
               
                 //DCAS Testing
                for(var u=0;u < idu.length;u++){ 
                    var data = $("#contractReviewDcasTestingInput_grid").jqGrid('getRowData',idu[u]); 

                    var contractReviewDcasTesting = { 
                        dcasTesting             : {code:data.contractReviewDcasTestingCode}
                    };
                    listContractReviewDCASTesting[u] = contractReviewDcasTesting;
                }
               
                 //DCAS Hydro Test
                for(var v=0;v < idv.length;v++){ 
                    var data = $("#contractReviewDcasHydroTestInput_grid").jqGrid('getRowData',idv[v]); 

                    var contractReviewDcasHydroTest = { 
                        dcasHydroTest             : {code:data.contractReviewDcasHydroTestCode}
                    };
                    listContractReviewDCASHydroTest[v] = contractReviewDcasHydroTest;
                }
               
                 //DCAS Visual Examination
                for(var w=0;w < idw.length;w++){ 
                    var data = $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getRowData',idw[w]); 

                    var contractReviewDcasVisualExamination = { 
                        dcasVisualExamination             : {code:data.contractReviewDcasVisualExaminationCode}
                    };
                    listContractReviewDCASVisualExamination[w] = contractReviewDcasVisualExamination;
                }
               
                 //DCAS Nde
                for(var x=0;x < idx.length;x++){ 
                    var data = $("#contractReviewDcasNdeInput_grid").jqGrid('getRowData',idx[x]); 

                    var contractReviewDcasNde = { 
                        dcasNde             : {code:data.contractReviewDcasNdeCode}
                    };
                    listContractReviewDCASNde[x] = contractReviewDcasNde;
                }
               
                 //DCAS Marking
                for(var y=0;y < idy.length;y++){ 
                    var data = $("#contractReviewDcasMarkingInput_grid").jqGrid('getRowData',idy[y]); 

                    var contractReviewDcasMarking = { 
                        dcasMarking             : {code:data.contractReviewDcasMarkingCode}
                    };
                    listContractReviewDCASMarking[y] = contractReviewDcasMarking;
                }
               
                 //DCAS Legal Requirements
                for(var z=0;z < idz.length;z++){ 
                    var data = $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getRowData',idz[z]); 

                    var contractReviewDcasLegalRequirements = { 
                        dcasLegalRequirements             : {code:data.contractReviewDcasLegalRequirementsCode}
                    };
                    listContractReviewDCASLegalRequirements[z] = contractReviewDcasLegalRequirements;
                }
                
                 //CAD Document Approval
                for(var l=0;l < idl.length;l++){ 
                    var data = $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getRowData',idl[l]); 

                    var contractReviewCadDocumentApproval = { 
                        cadDocumentApproval             : {code:data.contractReviewCadDocumentApprovalCode}
                    };
                    listContractReviewCADDocumentApproval[l] = contractReviewCadDocumentApproval;
                }
                
                formatDateCRv();
                
                var url="";
                var params = new FormData($('#frmContractReviewInput')[0]);
//                var params = $("#frmContractReviewInput").serialize();
                params.append("listContractReviewSalesQuotationJSON", $.toJSON(listContractReviewSalesQuotation));
                params.append("listContractReviewValveTypeJSON", $.toJSON(listContractReviewValveType));
                params.append("listContractReviewDCASDesignJSON", $.toJSON(listContractReviewDCASDesign));
                params.append("listContractReviewDCASFireSafeByDesignJSON", $.toJSON(listContractReviewDCASFireSafeByDesign));
                params.append("listContractReviewDCASTestingJSON", $.toJSON(listContractReviewDCASTesting));
                params.append("listContractReviewDCASHydroTestJSON", $.toJSON(listContractReviewDCASHydroTest));
                params.append("listContractReviewDCASVisualExaminationJSON", $.toJSON(listContractReviewDCASVisualExamination));
                params.append("listContractReviewDCASNdeJSON", $.toJSON(listContractReviewDCASNde));
                params.append("listContractReviewDCASMarkingJSON", $.toJSON(listContractReviewDCASMarking));
                params.append("listContractReviewDCASLegalRequirementsJSON", $.toJSON(listContractReviewDCASLegalRequirements));
                params.append("listContractReviewCADDocumentApprovalJSON", $.toJSON(listContractReviewCADDocumentApproval));
               
                if (updateRowId < 0) {
                    url = "sales/contract-review-save";
                } else {
                    url = "sales/contract-review-update";
                }
//                $("#dlgLoading").dialog("open");
                $.ajax({
                   url: url,
                   enctype: 'multipart/form-data',
                   type: 'POST',
                   data: params,
                   async: false,
                   success: function (data) {
                       $("#dlgLoading").dialog("close");
                       if (data.error) {
                           alertMessage(data.errorMessage);
                           return;
                       }
                   var dynamicDialog= $('<div id="conformBox">'+
                                       '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                       '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');
                       dynamicDialog.dialog({
                           title : "Confirmation:",
                           closeOnEsdcape: false,
                           modal : true,
                           width: 500,
                           resizable: false,
                           buttons : 
                                   [{
                                       text : "Yes",
                                       click : function() {
                                           $(this).dialog("close");
                                           var params = "enumContractReviewActivity=NEW";
                                           var url = "sales/contract-review-input";
                                           pageLoad(url, params, "#tabmnuCONTRACT_REVIEW");
                                       }
                                   },
                                   {
                                       text : "No",
                                       click : function() {
                                           $(this).dialog("close");
                                           var params = "";
                                           var url = "sales/contract-review";
                                           pageLoad(url, params, "#tabmnuCONTRACT_REVIEW");                                        
                                       }
                                   }]
                       });
                   },
                   cache: false,
                   contentType: false,
                   processData: false
               });
            ev.preventDefault();
        });        

        $('#btnContractReviewCancel').click(function(ev) {
            var url = "sales/contract-review";
            var params = "";
            pageLoad(url, params, "#tabmnuCONTRACT_REVIEW"); 
        });
        
        $('#contractReview_btnBrand').click(function(ev) {
            window.open("./pages/search/search-item-brand.jsp?iddoc=contractReview&idsubdoc=tnBrand","Search", "width=600, height=500");
        });
            
  });

   function formatDateCRv(){
        var transactionDateSplit=dtpContractReviewTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpContractReviewTransactionDate.val(transactionDate);
        
        var createdDate=$("#contractReview\\.createdDate").val();
        $("#contractReview\\.createdDateTemp").val(createdDate);
    }
        
//    Valve Type
    
    function addRowDataMultiSelectedValveType(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewValveTypeInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewValveTypeInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewValveTypeInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewValveTypeDelete              : defRow.contractReviewValveTypeDelete,
                    contractReviewValveTypeCode                : defRow.contractReviewValveTypeCode,
                    contractReviewValveTypeName                : defRow.contractReviewValveTypeName
            });
            
        setHeightGridValveType();
    }
    
    function contractReviewValveTypeDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewValveTypeInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewValveTypeInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridValveType();
    }
    
//    DCAS Design

     function addRowDataMultiSelectedDcasDesign(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasDesignInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasDesignInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasDesignInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasDesignDelete              : defRow.contractReviewDcasDesignDelete,
                    contractReviewDcasDesignCode                : defRow.contractReviewDcasDesignCode,
                    contractReviewDcasDesignName                : defRow.contractReviewDcasDesignName
            });
            
        setHeightGridDcasDesign();
    }
    
    function contractReviewDcasDesignDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasDesignInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasDesignInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasDesign();
    }
    
//    DCAS Fire Base By Design
    
    function addRowDataMultiSelectedDcasFireSafeByDesign(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasFireSafeByDesignDelete              : defRow.contractReviewDcasFireSafeByDesignDelete,
                    contractReviewDcasFireSafeByDesignCode                : defRow.contractReviewDcasFireSafeByDesignCode,
                    contractReviewDcasFireSafeByDesignName                : defRow.contractReviewDcasFireSafeByDesignName
            });
            
        setHeightGridDcasFireSafeByDesign();
    }
    
    function contractReviewDcasFireSafeByDesignDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasFireSafeByDesign();
    }
    
//    DCAS Testing
    
    function addRowDataMultiSelectedDcasTesting(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasTestingInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasTestingInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasTestingInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasTestingDelete              : defRow.contractReviewDcasTestingDelete,
                    contractReviewDcasTestingCode                : defRow.contractReviewDcasTestingCode,
                    contractReviewDcasTestingName                : defRow.contractReviewDcasTestingName
            });
            
        setHeightGridDcasTesting();
    }
    
    function contractReviewDcasTestingDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasTestingInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasTestingInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasTesting();
    }
    
//    DCAS Hydro Test

    function addRowDataMultiSelectedDcasHydroTest(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasHydroTestInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasHydroTestInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasHydroTestInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasHydroTestDelete              : defRow.contractReviewDcasHydroTestDelete,
                    contractReviewDcasHydroTestCode                : defRow.contractReviewDcasHydroTestCode,
                    contractReviewDcasHydroTestName                : defRow.contractReviewDcasHydroTestName
            });
            
        setHeightGridDcasHydroTest();
    }
    
    function contractReviewDcasHydroTestDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasHydroTestInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasHydroTestInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasHydroTest();
    }
    
//    DCAS Visual Examination

    function addRowDataMultiSelectedDcasVisualExamination(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasVisualExaminationInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasVisualExaminationDelete              : defRow.contractReviewDcasVisualExaminationDelete,
                    contractReviewDcasVisualExaminationCode                : defRow.contractReviewDcasVisualExaminationCode,
                    contractReviewDcasVisualExaminationName                : defRow.contractReviewDcasVisualExaminationName
            });
            
        setHeightGridDcasVisualExamination();
    }
    
    function contractReviewDcasVisualExaminationDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasVisualExamination();
    }
    
//    DCAS NDE
    
    function addRowDataMultiSelectedDcasNde(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasNdeInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasNdeInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasNdeInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasNdeDelete              : defRow.contractReviewDcasNdeDelete,
                    contractReviewDcasNdeCode                : defRow.contractReviewDcasNdeCode,
                    contractReviewDcasNdeName                : defRow.contractReviewDcasNdeName
            });
            
        setHeightGridDcasNde();
    }
    
    function contractReviewDcasNdeDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasNdeInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasNdeInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasNde();
    }
    
//    DCAS Marking
    
    function addRowDataMultiSelectedDcasMarking(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasMarkingInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasMarkingInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasMarkingInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasMarkingDelete              : defRow.contractReviewDcasMarkingDelete,
                    contractReviewDcasMarkingCode                : defRow.contractReviewDcasMarkingCode,
                    contractReviewDcasMarkingName                : defRow.contractReviewDcasMarkingName
            });
            
        setHeightGridDcasMarking();
    }
    
    function contractReviewDcasMarkingDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasMarkingInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasMarkingInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasMarking();
    }
    
//    DCAS Legal Requirements
    
    function addRowDataMultiSelectedDcasLegalRequirements(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewDcasLegalRequirementsDelete              : defRow.contractReviewDcasLegalRequirementsDelete,
                    contractReviewDcasLegalRequirementsCode                : defRow.contractReviewDcasLegalRequirementsCode,
                    contractReviewDcasLegalRequirementsName                : defRow.contractReviewDcasLegalRequirementsName
            });
            
        setHeightGridDcasLegalRequirements();
    }
    
    function contractReviewDcasLegalRequirementsDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDcasLegalRequirements();
    }
    
//    CAD Document Approval
    
    function addRowDataMultiSelectedCadDocumentApproval(lastRowId,defRow){
        
        var ids = jQuery("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('setRowData',lastRowId,{
                    contractReviewCadDocumentApprovalDelete              : defRow.contractReviewCadDocumentApprovalDelete,
                    contractReviewCadDocumentApprovalCode                : defRow.contractReviewCadDocumentApprovalCode,
                    contractReviewCadDocumentApprovalName                : defRow.contractReviewCadDocumentApprovalName
            });
            
        setHeightGridDescription();
    }
    
    function contractReviewCadDocumentApprovalDelete_OnClick(){
        var selectDetailRowId = $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridDescription();
    }
    
//    Set Height Grid or Scroll

    function setHeightGridSalesQuotation(){
      var ids = jQuery("#contractReviewSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewSalesQuotationInput_grid"+" tr").eq(1).height();
            $("#contractReviewSalesQuotationInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewSalesQuotationInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function setHeightGridValveType(){
      var ids = jQuery("#contractReviewValveTypeInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewValveTypeInput_grid"+" tr").eq(1).height();
            $("#contractReviewValveTypeInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewValveTypeInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function setHeightGridDcasDesign(){
      var ids = jQuery("#contractReviewDcasDesignInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasDesignInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasDesignInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasDesignInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function setHeightGridDcasFireSafeByDesign(){
      var ids = jQuery("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasFireSafeByDesignInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function setHeightGridDcasTesting(){
      var ids = jQuery("#contractReviewDcasTestingInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasTestingInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasTestingInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasTestingInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function setHeightGridDcasHydroTest(){
      var ids = jQuery("#contractReviewDcasHydroTestInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasHydroTestInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasHydroTestInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasHydroTestInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
       
    function setHeightGridDcasVisualExamination(){
      var ids = jQuery("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasVisualExaminationInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function setHeightGridDcasNde(){
      var ids = jQuery("#contractReviewDcasNdeInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasNdeInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasNdeInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasNdeInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
 
    function setHeightGridDcasMarking(){
      var ids = jQuery("#contractReviewDcasMarkingInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasMarkingInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasMarkingInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasMarkingInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
 
    function setHeightGridDcasLegalRequirements(){
      var ids = jQuery("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewDcasLegalRequirementsInput_grid"+" tr").eq(1).height();
            $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function setHeightGridDescription(){
      var ids = jQuery("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 5){
            var rowHeight = $("#contractReviewCadDocumentApprovalInput_grid"+" tr").eq(1).height();
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('setGridHeight', rowHeight * 5 , true);
        }else{
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateCR(){
        var transactionDateSplit=dtpContractReviewTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpContractReviewTransactionDate.val(transactionDate);
        
        var createdDate=$("#contractReview\\.createdDate").val();
        $("#contractReview\\.createdDateTemp").val(createdDate);
    }
    
    function loadDataContractReviewDetail(code) {
       $("#contractReviewSalesQuotationInput_grid").jqGrid("clearGridData");
        var url = "sales/customer-purchase-order-sales-quotation-data";
        var params = "customerPurchaseOrder.code=" + code;
      
            $.getJSON(url, params, function(data) {
                for (var i=0; i<data.listCustomerPurchaseOrderSalesQuotation.length; i++) {
                    contractReviewSalesQuotation_rowId++;
                  
                    $("#contractReviewSalesQuotationInput_grid").jqGrid("addRowData", contractReviewSalesQuotation_rowId, data.listCustomerPurchaseOrderSalesQuotation[i]);
                    $("#contractReviewSalesQuotationInput_grid").jqGrid('setRowData', contractReviewSalesQuotation_rowId,{
                        contractReviewCustomerPurchaseOrderCode                         : data.listCustomerPurchaseOrderSalesQuotation[i].code,
                        contractReviewSalesQuotationCode                                : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationCode,
                        contractReviewSalesQuotationTransactionDate                     : formatDateRemoveT(data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationTransactionDate),
                        contractReviewSalesQuotationSubject                             : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationSubject
                    });
                }
                setHeightGridSalesQuotation();
            });
    }
    
    function loadValveTypeDetail() {
        var url = "sales/contract-review-valve-type-data";
        
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            valveTypeComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewValveType.length; i++) {
                 valveTypeComponentRowId++;
                $("#contractReviewValveTypeInput_grid").jqGrid("addRowData", valveTypeComponentRowId, data.listContractReviewValveType[i]);
                $("#contractReviewValveTypeInput_grid").jqGrid('setRowData', valveTypeComponentRowId, {
                    contractReviewValveTypeDelete       :"delete",
                    contractReviewValveTypeCode         : data.listContractReviewValveType[i].valveTypeCode,
                    contractReviewValveTypeName         : data.listContractReviewValveType[i].valveTypeName
                });

            }
        });
    }
    
    function loadDcasDesignDetail() {
        var url = "sales/contract-review-dcas-design-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasDesignComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASDesign.length; i++) {
                 dcasDesignComponentRowId++;
                $("#contractReviewDcasDesignInput_grid").jqGrid("addRowData", dcasDesignComponentRowId, data.listContractReviewDCASDesign[i]);
                $("#contractReviewDcasDesignInput_grid").jqGrid('setRowData', dcasDesignComponentRowId, {
                    contractReviewDcasDesignDelete       :"delete",
                    contractReviewDcasDesignCode         : data.listContractReviewDCASDesign[i].dcasDesignCode,
                    contractReviewDcasDesignName         : data.listContractReviewDCASDesign[i].dcasDesignName
                });

            }
        });
    }
    
    function loadDcasFireSafeByDesignDetail() {
        var url = "sales/contract-review-dcas-fire-safe-by-design-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasFireSafeByDesignComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASFireSafeByDesign.length; i++) {
                 dcasFireSafeByDesignComponentRowId++;
                $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid("addRowData", dcasFireSafeByDesignComponentRowId, data.listContractReviewDCASFireSafeByDesign[i]);
                $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('setRowData', dcasFireSafeByDesignComponentRowId, {
                    contractReviewDcasFireSafeByDesignDelete       :"delete",
                    contractReviewDcasFireSafeByDesignCode         : data.listContractReviewDCASFireSafeByDesign[i].dcasFireSafeByDesignCode,
                    contractReviewDcasFireSafeByDesignName         : data.listContractReviewDCASFireSafeByDesign[i].dcasFireSafeByDesignName
                });

            }
        });
    }
    
    function loadDcasTestingDetail() {
        var url = "sales/contract-review-dcas-testing-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasTestingComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASTesting.length; i++) {
                 dcasTestingComponentRowId++;
                $("#contractReviewDcasTestingInput_grid").jqGrid("addRowData", dcasTestingComponentRowId, data.listContractReviewDCASTesting[i]);
                $("#contractReviewDcasTestingInput_grid").jqGrid('setRowData', dcasTestingComponentRowId, {
                    contractReviewDcasTestingDelete       :"delete",
                    contractReviewDcasTestingCode         : data.listContractReviewDCASTesting[i].dcasTestingCode,
                    contractReviewDcasTestingName         : data.listContractReviewDCASTesting[i].dcasTestingName
                });

            }
        });
    }
    
    function loadDcasHydroTestDetail() {
        var url = "sales/contract-review-dcas-hydro-test-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasHydroTestComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASHydroTest.length; i++) {
                 dcasHydroTestComponentRowId++;
                $("#contractReviewDcasHydroTestInput_grid").jqGrid("addRowData", dcasHydroTestComponentRowId, data.listContractReviewDCASHydroTest[i]);
                $("#contractReviewDcasHydroTestInput_grid").jqGrid('setRowData', dcasHydroTestComponentRowId, {
                    contractReviewDcasHydroTestDelete       :"delete",
                    contractReviewDcasHydroTestCode         : data.listContractReviewDCASHydroTest[i].dcasHydroTestCode,
                    contractReviewDcasHydroTestName         : data.listContractReviewDCASHydroTest[i].dcasHydroTestName
                });

            }
        });
    }
    
    function loadDcasVisualExaminationDetail() {
        var url = "sales/contract-review-dcas-visual-examination-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasVisualExaminationComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASVisualExamination.length; i++) {
                 dcasVisualExaminationComponentRowId++;
                $("#contractReviewDcasVisualExaminationInput_grid").jqGrid("addRowData", dcasVisualExaminationComponentRowId, data.listContractReviewDCASVisualExamination[i]);
                $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('setRowData', dcasVisualExaminationComponentRowId, {
                    contractReviewDcasVisualExaminationDelete       :"delete",
                    contractReviewDcasVisualExaminationCode         : data.listContractReviewDCASVisualExamination[i].dcasVisualExaminationCode,
                    contractReviewDcasVisualExaminationName         : data.listContractReviewDCASVisualExamination[i].dcasVisualExaminationName
                });

            }
        });
    }
    
    function loadDcasNdeDetail() {
        var url = "sales/contract-review-dcas-nde-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasNdeComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASNde.length; i++) {
                 dcasNdeComponentRowId++;
                $("#contractReviewDcasNdeInput_grid").jqGrid("addRowData", dcasNdeComponentRowId, data.listContractReviewDCASNde[i]);
                $("#contractReviewDcasNdeInput_grid").jqGrid('setRowData', dcasNdeComponentRowId, {
                    contractReviewDcasNdeDelete       :"delete",
                    contractReviewDcasNdeCode         : data.listContractReviewDCASNde[i].dcasNdeCode,
                    contractReviewDcasNdeName         : data.listContractReviewDCASNde[i].dcasNdeName
                });

            }
        });
    }
    
    function loadDcasMarkingDetail() {
        var url = "sales/contract-review-dcas-marking-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasMarkingComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASMarking.length; i++) {
                 dcasMarkingComponentRowId++;
                $("#contractReviewDcasMarkingInput_grid").jqGrid("addRowData", dcasMarkingComponentRowId, data.listContractReviewDCASMarking[i]);
                $("#contractReviewDcasMarkingInput_grid").jqGrid('setRowData', dcasMarkingComponentRowId, {
                    contractReviewDcasMarkingDelete       :"delete",
                    contractReviewDcasMarkingCode         : data.listContractReviewDCASMarking[i].dcasMarkingCode,
                    contractReviewDcasMarkingName         : data.listContractReviewDCASMarking[i].dcasMarkingName
                });

            }
        });
    }
    
    function loadDcasLegalRequirementsDetail() {
        var url = "sales/contract-review-dcas-legal-requirements-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            dcasLegalRequirementsComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewDCASLegalRequirements.length; i++) {
                 dcasLegalRequirementsComponentRowId++;
                $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid("addRowData", dcasLegalRequirementsComponentRowId, data.listContractReviewDCASLegalRequirements[i]);
                $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('setRowData', dcasLegalRequirementsComponentRowId, {
                    contractReviewDcasLegalRequirementsDelete       :"delete",
                    contractReviewDcasLegalRequirementsCode         : data.listContractReviewDCASLegalRequirements[i].dcasLegalRequirementsCode,
                    contractReviewDcasLegalRequirementsName         : data.listContractReviewDCASLegalRequirements[i].dcasLegalRequirementsName
                });

            }
        });
    }
    
    function loadCadDocumentApprovalDetail() {
        var url = "sales/contract-review-cad-document-approval-data";
        if($('#enumContractReviewActivity').val() === 'UPDATE'){
            var params = "contractReview.code=" + txtContractReviewCode.val();
        }else if($('#enumContractReviewActivity').val() === 'REVISE'){
            var params = "contractReview.code="+$('#contractReview\\.refCUSTCRCode').val(); 
        }

        $.getJSON(url, params, function (data) {
            cadDocumentApprovalComponentRowId = 0;

            for (var i = 0; i < data.listContractReviewCADDocumentApproval.length; i++) {
                 cadDocumentApprovalComponentRowId++;
                $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("addRowData", cadDocumentApprovalComponentRowId, data.listContractReviewCADDocumentApproval[i]);
                $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('setRowData', cadDocumentApprovalComponentRowId, {
                    contractReviewCadDocumentApprovalDelete       :"delete",
                    contractReviewCadDocumentApprovalCode         : data.listContractReviewCADDocumentApproval[i].cadDocumentApprovalCode,
                    contractReviewCadDocumentApprovalName         : data.listContractReviewCADDocumentApproval[i].cadDocumentApprovalName
                });

            }
        });
    }
    
//    OnChange Valve
    function contractReviewSearchValveTypeCode(){
            var selectedRowID = $("#contractReviewValveTypeInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewValveTypeCode = $("#" + selectedRowID + "_contractReviewValveTypeCode").val();
            
            var url = "master/valve-type-get";
            var params = "valveType.code=" + contractReviewValveTypeCode;
            params+="&valveType.activeStatus=TRUE";
            
            if(contractReviewValveTypeCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewValveTypeInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewValveTypeInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewValveTypeCode===dataGridComponentCode.contractReviewValveTypeCode){                            
                                    alertMessage("Valve Type "+ contractReviewValveTypeCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewValveTypeCode"));
                                    $("#" + selectedRowID + "_contractReviewValveTypeCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.valveTypeTemp){
                    
                    if(data.valveTypeTemp.code=== contractReviewValveTypeCode){
                        alertMessage("Valve Type Must be other Item!",$("#" + selectedRowID + "_contractReviewValveTypeCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewValveTypeInput_grid").jqGrid("setCell", selectedRowID,"contractReviewValveTypeCode",data.valveTypeTemp.code);
                    $("#contractReviewValveTypeInput_grid").jqGrid("setCell", selectedRowID,"contractReviewValveTypeName",data.valveTypeTemp.name);
                }
                else{
                    alertMessage("Valve Type Not Found!",$("#" + selectedRowID + "_contractReviewValveTypeCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
//    OnChange DCAS
    function contractReviewSearchDcasDesignCode(){
            var selectedRowID = $("#contractReviewDcasDesignInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasDesignCode = $("#" + selectedRowID + "_contractReviewDcasDesignCode").val();
            
            var url = "master/dcas-design-get";
            var params = "dcasDesign.code=" + contractReviewDcasDesignCode;
            params+="&dcasDesign.activeStatus=TRUE";
            
            if(contractReviewDcasDesignCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasDesignInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasDesignInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasDesignCode===dataGridComponentCode.contractReviewDcasDesignCode){                            
                                    alertMessage("DCAS Design "+ contractReviewDcasDesignCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasDesignCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasDesignCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasDesignTemp){
                    
                    if(data.dcasDesignTemp.code=== contractReviewDcasDesignCode){
                        alertMessage("DCAS Design Must be different!",$("#" + selectedRowID + "_contractReviewDcasDesignCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasDesignInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasDesignCode",data.dcasDesignTemp.code);
                    $("#contractReviewDcasDesignInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasDesignName",data.dcasDesignTemp.name);
                }
                else{
                    alertMessage("DCAS Design Not Found!",$("#" + selectedRowID + "_contractReviewDcasDesignCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
    function contractReviewSearchDcasFireSafeByDesignCode(){
            var selectedRowID = $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasFireSafeByDesignCode = $("#" + selectedRowID + "_contractReviewDcasFireSafeByDesignCode").val();
            
            var url = "master/dcas-fire-safe-by-design-get";
            var params = "dcasFireSafeByDesign.code=" + contractReviewDcasFireSafeByDesignCode;
            params+="&dcasFireSafeByDesign.activeStatus=TRUE";
            
            if(contractReviewDcasFireSafeByDesignCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasFireSafeByDesignCode===dataGridComponentCode.contractReviewDcasFireSafeByDesignCode){                            
                                    alertMessage("Valve Type "+ contractReviewDcasFireSafeByDesignCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasFireSafeByDesignCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasFireSafeByDesignCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasFireSafeByDesignTemp){
                    
                    if(data.dcasFireSafeByDesignTemp.code=== contractReviewDcasFireSafeByDesignCode){
                        alertMessage("DCAS Fire Safe By Design Must be different!",$("#" + selectedRowID + "_contractReviewDcasFireSafeByDesignCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasFireSafeByDesignCode",data.dcasFireSafeByDesignTemp.code);
                    $("#contractReviewDcasFireSafeByDesignInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasFireSafeByDesignName",data.dcasFireSafeByDesignTemp.name);
                }
                else{
                    alertMessage("DCAS Fire Safe By Design Not Found!",$("#" + selectedRowID + "_contractReviewDcasFireSafeByDesignCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
    function contractReviewSearchDcasTestingCode(){
            var selectedRowID = $("#contractReviewDcasTestingInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasTestingCode = $("#" + selectedRowID + "_contractReviewDcasTestingCode").val();
            
            var url = "master/dcas-testing-get";
            var params = "dcasTesting.code=" + contractReviewDcasTestingCode;
            params+="&dcasTesting.activeStatus=TRUE";
            
            if(contractReviewDcasTestingCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasTestingInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasTestingInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasTestingCode===dataGridComponentCode.contractReviewDcasTestingCode){                            
                                    alertMessage("DCAS Testing "+ contractReviewDcasTestingCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasTestingCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasTestingCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasTestingTemp){
                    
                    if(data.dcasTestingTemp.code=== contractReviewDcasTestingCode){
                        alertMessage("DCAS Testing Must be different!",$("#" + selectedRowID + "_contractReviewDcasTestingCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasTestingInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasTestingCode",data.dcasTestingTemp.code);
                    $("#contractReviewDcasTestingInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasTestingName",data.dcasTestingTemp.name);
                }
                else{
                    alertMessage("DCAS Testing Not Found!",$("#" + selectedRowID + "_contractReviewDcasTestingCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
    function contractReviewSearchDcasHydroTestCode(){
            var selectedRowID = $("#contractReviewDcasHydroTestInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasHydroTestCode = $("#" + selectedRowID + "_contractReviewDcasHydroTestCode").val();
            
            var url = "master/dcas-hyrdro-test-get";
            var params = "dcasHydroTest.code=" + contractReviewDcasHydroTestCode;
            params+="&dcasHydroTest.activeStatus=TRUE";
            
            if(contractReviewDcasHydroTestCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasHydroTestInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasHydroTestInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasHydroTestCode===dataGridComponentCode.contractReviewDcasHydroTestCode){                            
                                    alertMessage("DCAS Hydro Test "+ contractReviewDcasHydroTestCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasHydroTestCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasHydroTestCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasHydroTestTemp){
                    
                    if(data.dcasHydroTestTemp.code=== contractReviewDcasHydroTestCode){
                        alertMessage("DCAS Hydro Test Must be different!",$("#" + selectedRowID + "_contractReviewDcasHydroTestCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasHydroTestInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasHydroTestCode",data.dcasHydroTestTemp.code);
                    $("#contractReviewDcasHydroTestInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasHydroTestName",data.dcasHydroTestTemp.name);
                }
                else{
                    alertMessage("DCAS Hydro Test Not Found!",$("#" + selectedRowID + "_contractReviewDcasHydroTestCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
    function contractReviewSearchDcasVisualExaminationCode(){
            var selectedRowID = $("#contractReviewDcasVisualExaminationInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasVisualExaminationCode = $("#" + selectedRowID + "_contractReviewDcasVisualExaminationCode").val();
            
            var url = "master/dcas-visual-examination-get";
            var params = "dcasVisualExamination.code=" + contractReviewDcasVisualExaminationCode;
            params+="&dcasVisualExamination.activeStatus=TRUE";
            
            if(contractReviewDcasVisualExaminationCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasVisualExaminationInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasVisualExaminationCode===dataGridComponentCode.contractReviewDcasVisualExaminationCode){                            
                                    alertMessage("DCAS Visual Examination "+ contractReviewDcasVisualExaminationCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasVisualExaminationCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasVisualExaminationCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasVisualExaminationTemp){
                    
                    if(data.dcasVisualExaminationTemp.code=== contractReviewDcasVisualExaminationCode){
                        alertMessage("DCAS Visual Examination Must be different!",$("#" + selectedRowID + "_contractReviewDcasVisualExaminationCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasVisualExaminationInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasVisualExaminationCode",data.dcasVisualExaminationTemp.code);
                    $("#contractReviewDcasVisualExaminationInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasVisualExaminationName",data.dcasVisualExaminationTemp.name);
                }
                else{
                    alertMessage("DCAS Visual Examination Not Found!",$("#" + selectedRowID + "_contractReviewDcasVisualExaminationCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
     function contractReviewSearcDcasNdeCode(){
            var selectedRowID = $("#contractReviewDcasNdeInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasNdeCode = $("#" + selectedRowID + "_contractReviewDcasNdeCode").val();
            
            var url = "master/dcas-nde-get";
            var params = "dcasNde.code=" + contractReviewDcasNdeCode;
            params+="&dcasNde.activeStatus=TRUE";
            
            if(contractReviewDcasNdeCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasNdeInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasNdeInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasNdeCode===dataGridComponentCode.contractReviewDcasNdeCode){                            
                                    alertMessage("DCAS Nde "+ contractReviewDcasNdeCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasNdeCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasNdeCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasNdeTemp){
                    
                    if(data.dcasNdeTemp.code=== contractReviewDcasNdeCode){
                        alertMessage("DCAS Nde Must be different!",$("#" + selectedRowID + "_contractReviewDcasNdeCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasNdeInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasNdeCode",data.dcasNdeTemp.code);
                    $("#contractReviewDcasNdeInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasNdeName",data.dcasNdeTemp.name);
                }
                else{
                    alertMessage("DCAS Nde Not Found!",$("#" + selectedRowID + "_contractReviewDcasNdeCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
     function contractReviewSearchDcasMarkingCode(){
            var selectedRowID = $("#contractReviewDcasMarkingInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasMarkingCode = $("#" + selectedRowID + "_contractReviewDcasMarkingCode").val();
            
            var url = "master/dcas-marking-get";
            var params = "dcasMarking.code=" + contractReviewDcasMarkingCode;
            params+="&dcasMarking.activeStatus=TRUE";
            
            if(contractReviewDcasMarkingCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasMarkingInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasMarkingInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasMarkingCode===dataGridComponentCode.contractReviewDcasMarkingCode){                            
                                    alertMessage("DCAS Marking "+ contractReviewDcasMarkingCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasMarkingCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasMarkingCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasMarkingTemp){
                    
                    if(data.dcasMarkingTemp.code=== contractReviewDcasMarkingCode){
                        alertMessage("DCAS Marking Must be different!",$("#" + selectedRowID + "_contractReviewDcasMarkingCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasMarkingInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasMarkingCode",data.dcasMarkingTemp.code);
                    $("#contractReviewDcasMarkingInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasMarkingName",data.dcasMarkingTemp.name);
                }
                else{
                    alertMessage("DCAS Marking Not Found!",$("#" + selectedRowID + "_contractReviewDcasMarkingCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
     function contractReviewSearchDcasLegalRequirementsCode(){
            var selectedRowID = $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewDcasLegalRequirementsCode = $("#" + selectedRowID + "_contractReviewDcasLegalRequirementsCode").val();
            
            var url = "master/dcas-legal-requirements-get";
            var params = "dcasLegalRequirements.code=" + contractReviewDcasLegalRequirementsCode;
            params+="&dcasLegalRequirements.activeStatus=TRUE";
            
            if(contractReviewDcasLegalRequirementsCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewDcasLegalRequirementsCode===dataGridComponentCode.contractReviewDcasLegalRequirementsCode){                            
                                    alertMessage("DCAS Legal Requirements "+ contractReviewDcasLegalRequirementsCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewDcasLegalRequirementsCode"));
                                    $("#" + selectedRowID + "_contractReviewDcasLegalRequirementsCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.dcasLegalRequirementsTemp){
                    
                    if(data.dcasLegalRequirementsTemp.code=== contractReviewDcasLegalRequirementsCode){
                        alertMessage("DCAS Legal Requirements Must be different!",$("#" + selectedRowID + "_contractReviewDcasLegalRequirementsCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasLegalRequirementsCode",data.dcasLegalRequirementsTemp.code);
                    $("#contractReviewDcasLegalRequirementsInput_grid").jqGrid("setCell", selectedRowID,"contractReviewDcasLegalRequirementsName",data.dcasLegalRequirementsTemp.name);
                }
                else{
                    alertMessage("DCAS Legal Requirements Not Found!",$("#" + selectedRowID + "_contractReviewDcasLegalRequirementsCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
//    CAD 
    function contractReviewSearchCadDocumentApprovalCode(){
            var selectedRowID = $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("getGridParam", "selrow");
            var contractReviewCadDocumentApprovalCode = $("#" + selectedRowID + "_contractReviewCadDocumentApprovalCode").val();
            
            var url = "master/cad-document-for-approval-get";
            var params = "cadDocumentForApproval.code=" + contractReviewCadDocumentApprovalCode;
            params+="&cadDocumentForApproval.activeStatus=TRUE";
            
            if(contractReviewCadDocumentApprovalCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#contractReviewCadDocumentApprovalInput_grid").jqGrid('getRowData',idx[j]);
                            if(contractReviewCadDocumentApprovalCode===dataGridComponentCode.contractReviewCadDocumentApprovalCode){                            
                                    alertMessage("DCAS Legal Requirements "+ contractReviewCadDocumentApprovalCode +" has been exists in Grid!",$("#" + selectedRowID + "_contractReviewCadDocumentApprovalCode"));
                                    $("#" + selectedRowID + "_contractReviewCadDocumentApprovalCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.cadDocumentForApprovalTemp){
                    
                    if(data.cadDocumentForApprovalTemp.code=== contractReviewCadDocumentApprovalCode){
                        alertMessage("DCAS Legal Requirements Must be different!",$("#" + selectedRowID + "_contractReviewCadDocumentApprovalCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("setCell", selectedRowID,"contractReviewCadDocumentApprovalCode",data.cadDocumentForApprovalTemp.code);
                    $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("setCell", selectedRowID,"contractReviewCadDocumentApprovalName",data.cadDocumentForApprovalTemp.name);
                }
                else{
                    alertMessage("DCAS Legal Requirements Not Found!",$("#" + selectedRowID + "_contractReviewCadDocumentApprovalCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
    
    
    function radioButtonStatusContractReview(){
 
        //SFS
        if ($("#contractReview\\.sfsSparepartCommissioningStatus").val()==="REQUIRED"){
            $('#contractReviewSfsSparepartCommissioningStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfsSparepartCommissioningStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewSfsSparepartCommissioningStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfs2YearSparepartStatus").val()==="REQUIRED"){
            $('#contractReviewSfs2YearSparepartStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfs2YearSparepartStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewSfs2YearSparepartStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfsSpecialToolsStatus").val()==="REQUIRED"){
            $('#contractReviewSfsSpecialToolsStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfsSpecialToolsStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewSfsSpecialToolsStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfsPackingStatus").val()==="REQUIRED"){
            $('#contractReviewSfsPackingStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfsPackingStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewSfsPackingStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfsPaintingStatus").val()==="REQUIRED"){
            $('#contractReviewSfsPaintingStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.sfsPaintingStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewSfsPaintingStatusRadNOT_REQUIRED').prop('checked',true);
        }
        
        //DCAS
        if ($("#contractReview\\.dcasPressureTestHydroStatus").val()==="REQUIRED"){
            $('#contractReviewDcasPressureTestHydroStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPressureTestHydroStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasPressureTestHydroStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPressureTestHydroStatus").val()==="OTHER"){
            $('#contractReviewDcasPressureTestHydroStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPressureTestGasStatus").val()==="REQUIRED"){
            $('#contractReviewDcasPressureTestGasStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPressureTestGasStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasPressureTestGasStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPressureTestGasStatus").val()==="OTHER"){
            $('#contractReviewDcasPressureTestGasStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPmiStatus").val()==="REQUIRED"){
            $('#contractReviewDcasPmiStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPmiStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasPmiStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasPmiStatus").val()==="OTHER"){
            $('#contractReviewDcasPmiStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.dcasWitnessStatus").val()==="REQUIRED"){
            $('#contractReviewDcasWitnessStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasWitnessStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasWitnessStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasWitnessStatus").val()==="AS_PER_APPROVED_ITP"){
            $('#contractReviewDcasWitnessStatusRadAS_PER_APPROVED_ITP').prop('checked',true);
        }
        if ($("#contractReview\\.dcasHyperbaricTestStatus").val()==="REQUIRED"){
            $('#contractReviewDcasHyperbaricTestStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasHyperbaricTestStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasHyperbaricTestStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasHyperbaricTestStatus").val()==="OTHER"){
            $('#contractReviewDcasHyperbaricTestStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.dcasAntiStaticTestStatus").val()==="REQUIRED"){
            $('#contractReviewDcasAntiStaticTestStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasAntiStaticTestStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasAntiStaticTestStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasAntiStaticTestStatus").val()==="OTHER"){
            $('#contractReviewDcasAntiStaticTestStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.dcasTorqueTestStatus").val()==="REQUIRED"){
            $('#contractReviewDcasTorqueTestStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasTorqueTestStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasTorqueTestStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasTorqueTestStatus").val()==="OTHER"){
            $('#contractReviewDcasTorqueTestStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.dcasDibDbbTestStatus").val()==="REQUIRED"){
            $('#contractReviewDcasDibDbbTestStatusRadREQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasDibDbbTestStatus").val()==="NOT_REQUIRED"){
            $('#contractReviewDcasDibDbbTestStatusRadNOT_REQUIRED').prop('checked',true);
        }
        if ($("#contractReview\\.dcasDibDbbTestStatus").val()==="OTHER"){
            $('#contractReviewDcasDibDbbTestStatusRadOTHER').prop('checked',true);
        }
         
//       CAD
        if ($("#contractReview\\.cadPressureContainingPartsStatus").val()==="TYPE_3.2"){
            $('#contractReviewCadPressureContainingPartsStatusRadTYPE_3\\.2').prop('checked',true);
        }
        if ($("#contractReview\\.cadPressureContainingPartsStatus").val()==="TYPE_3.1"){
            $('#contractReviewCadPressureContainingPartsStatusRadTYPE_3\\.1').prop('checked',true);
        }
        if ($("#contractReview\\.cadPressureContainingPartsStatus").val()==="OTHER"){
            $('#contractReviewDcasDibDbbTestStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.cadPressureControllingPartsStatus").val()==="TYPE_3.2"){
            $('#contractReviewCadPressureControllingPartsStatusRadTYPE_3\\.2').prop('checked',true);
        }
        if ($("#contractReview\\.cadPressureControllingPartsStatus").val()==="TYPE_3.1"){
            $('#contractReviewCadPressureControllingPartsStatusRadTYPE_3\\.1').prop('checked',true);
        }
        if ($("#contractReview\\.cadPressureControllingPartsStatus").val()==="TYPE_2.2"){
            $('#contractReviewCadPressureControllingPartsStatusRadTYPE_2\\.2').prop('checked',true);
        }
        if ($("#contractReview\\.cadPressureControllingPartsStatus").val()==="OTHER"){
            $('#contractReviewCadPressureControllingPartsStatusRadOTHER').prop('checked',true);
        }
        if ($("#contractReview\\.cadNonPressureControllingPartsStatus").val()==="TYPE_2.2"){
            $('#contractReviewCadNonPressureControllingPartsStatusRadTYPE_2\\.2').prop('checked',true);
        }
        if ($("#contractReview\\.cadNonPressureControllingPartsStatus").val()==="TYPE_2.1"){
            $('#contractReviewCadNonPressureControllingPartsStatusRadTYPE_2\\.1').prop('checked',true);
        }
        if ($("#contractReview\\.cadNonPressureControllingPartsStatus").val()==="OTHER"){
            $('#contractReviewCadNonPressureControllingPartsStatusRadOTHER').prop('checked',true);
        }
        
//        TN
        if ($("#contractReview\\.tnActuatorStatus").val()==="YES"){
            $('#contractReviewTnActuatorStatusRadYES').prop('checked',true);
        }
        if ($("#contractReview\\.tnActuatorStatus").val()==="NO"){
            $('#contractReviewTnActuatorStatusRadNO').prop('checked',true);
        }
        if ($("#contractReview\\.tnLimitationOriginStatus").val()==="YES"){
            $('#contractReviewTnLimitationOriginStatusRadYES').prop('checked',true);
        }
        if ($("#contractReview\\.tnLimitationOriginStatus").val()==="NO"){
            $('#contractReviewTnLimitationOriginStatusRadNO').prop('checked',true);
        }
        if ($("#contractReview\\.tnApprovalManufacturedListStatus").val()==="YES"){
            $('#contractReviewTnApprovalManufacturedListStatusRadYES').prop('checked',true);
        }
        if ($("#contractReview\\.tnApprovalManufacturedListStatus").val()==="NO"){
            $('#contractReviewTnApprovalManufacturedListStatusRadNO').prop('checked',true);
        }
    }
    
    function coaUpload_AjaxSaveAndFileUpload() {
//        if(!$("#frmCoaUploadInput").valid()) {
//           //ev.preventDefault();
//           return;
//        };       
        var ext = $("#coaDocument").val().split('.').pop();
        $("#ext").val(ext);
                alert(ext);
            var form = new FormData($('#frmCoaUploadInput')[0]);
             $.ajax({
                url: 'inventory/coa-upload-save',
                type: 'POST',
                data: form,
                async: false,
                success: function (data) {
                    $("#dlgLoading").dialog("close");
                    if (data.error) {
                        alert(data.errorMessage);
                        return;
                    }
                    alert(data.message);
                    $("#coaDocument").html("");    
                    $("#frmCoaUploadInput").resetForm();
                    hideInput("coaUpload");
                    showInput("coaUploadSearch");
                    allFields.val("").removeClass('ui-state-error');
                    reloadGrid();
                },
                cache: false,
                contentType: false,
                processData: false
            });
    };    

</script>
<s:url id="remoteurlContractReviewDetailInput" action="" />
<s:url id="remoteurlContractReviewValveTypeInput" action="" />
<s:url id="remoteurlContractReviewDcasDesignInput" action="" />
<s:url id="remoteurlContractReviewDcasFireSafeByDesignInput" action="" />
<s:url id="remoteurlContractReviewDcasTestingInput" action="" />
<s:url id="remoteurlContractReviewDcasHydroTestInput" action="" />
<s:url id="remoteurlContractReviewDcasVisualExaminationInput" action="" />
<s:url id="remoteurlContractReviewDcasNdeInput" action="" />
<s:url id="remoteurlContractReviewDcasMarkingInput" action="" />
<s:url id="remoteurlContractReviewDcasLegalRequirementsInput" action="" />
<s:url id="remotedetailurlContractReviewCadDocumentApprovalInput" action="" />
<b>CONTRACT REVIEW</b>
<hr>
<br class="spacer" />
<div id="contractReviewInput" class="content ui-widget">
<s:form id="frmContractReviewInput">
    <table cellpadding="2" cellspacing="2" id="contractReview_Input">
        <tr valign="top">
            <td>
                <table>
                    <tr>
                        <td align="right"><B>Contract Review No *</B></td>
                        <td><s:textfield id="contractReview.code" name="contractReview.code" key="contractReview.code" readonly="true" size="25"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right"><B>Ref CR No *</B></td>
                        <td>
                            <s:textfield id="contractReview.custCRNo" name="contractReview.custCRNo" key="contractReview.custCRNo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                            <s:textfield id="contractReview.refCUSTCRCode" name="contractReview.refCUSTCRCode" key="contractReview.refCUSTCRCode" readonly="true" size="25"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Revision</td>
                        <td>
                            <s:textfield id="contractReview.revision" name="contractReview.revision" key="contractReview.revision" readonly="true" size="5"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width:180px"><B>Branch *</B></td>
                        <td colspan="2">
                        <script type = "text/javascript">
                            $('#contractReview_btnBranch').click(function(ev) {
                                 window.open("./pages/search/search-branch.jsp?iddoc=contractReview&idsubdoc=branch","Search", "width=600, height=500");
                            });
                            
                            txtContractReviewBranchCode.change(function(ev) {

                                if(txtContractReviewBranchCode.val()===""){
                                    txtContractReviewBranchName.val("");
                                    return;
                                }
                                var url = "master/branch-get";
                                var params = "branch.code=" + txtContractReviewBranchCode.val();
                                    params += "&branch.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.branchTemp){
                                        txtContractReviewBranchCode.val(data.branchTemp.code);
                                        txtContractReviewBranchName.val(data.branchTemp.name);
                                    }
                                    else{
                                        alertMessage("Branch Not Found!",txtContractReviewBranchCode);
                                        txtContractReviewBranchCode.val("");
                                        txtContractReviewBranchName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header" hidden="true">
                            <s:textfield id="contractReview.branch.code" name="contractReview.branch.code" size="20"></s:textfield>
                            <sj:a id="contractReview_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        <s:textfield id="contractReview.branch.name" name="contractReview.branch.name" size="25" readonly="true"></s:textfield>
                    </tr>
                    <tr>
                        <td align="right"><B>Contract Review Date *</B></td>
                        <td>
                            <sj:datepicker id="contractReview.transactionDate" name="contractReview.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" onchange=""></sj:datepicker>
                            <sj:datepicker id="contractReviewTransactionDate" name="contractReviewTransactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">SO No</td>
                        <td><script type = "text/javascript"> 
                                $('#contractReview_btnSalesOrder').click(function(ev) {
                                    window.open("./pages/search/search-customer-sales-order.jsp?iddoc=contractReview&idsubdoc=customerSalesOrder&firstDate="+$("#contractReviewTransactionDateFirstSession").val()+"&lastDate="+$("#contractReviewTransactionDateLastSession").val(),"Search", "width=600, height=500"); 
                                });
                            </script>
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="contractReview.salesOrder.code" name="contractReview.salesOrder.code" size="22"></s:textfield>
                                <sj:a id="contractReview_btnSalesOrder" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Customer PO No*</B></td>
                        <td>
                            <script type = "text/javascript"> 

                                    $('#contractReview_btnCustomerPurchaseOrder').click(function(ev) {
                                        window.open("./pages/search/search-customer-purchase-order.jsp?iddoc=contractReview&idsubdoc=customerPurchaseOrder&firstDate="+$("#contractReviewTransactionDateFirstSession").val()+"&lastDate="+$("#contractReviewTransactionDateLastSession").val(),"Search", "width=600, height=500"); 
                                    });
                                    
                                    txtContractReviewCustomerPurchaseOrderCode.change(function(ev) {
                                    if(txtContractReviewCustomerPurchaseOrderCode.val()===""){
                                        txtContractReviewCustomerPurchaseOrderCode.val("");
                                        txtContractReviewCustomerPurchaseOrderBranchCode.val("");
                                        txtContractReviewCustomerPurchaseOrderBranchName.val("");
                                        txtContractReviewCustomerPurchaseOrderCurrencyCode.val("");
                                        txtContractReviewCustomerPurchaseOrderCurrencyName.val("");
                                        txtContractReviewCustomerPurchaseOrderProjectCode.val("");
                                        txtContractReviewCustomerPurchaseOrderNo.val("");
                                        txtContractReviewCustomerPurchaseOrderCustomerCode.val("");
                                        txtContractReviewCustomerPurchaseOrderCustomerName.val("");
                                        txtContractReviewCustomerPurchaseOrderEndUserCode.val("");
                                        txtContractReviewCustomerPurchaseOrderEndUserName.val("");
                                        txtContractReviewCustomerPurchaseOrderSalesPersonCode.val("");
                                        txtContractReviewCustomerPurchaseOrderSalesPersonName.val("");
                                        $("#contractReview\\.customerPurchaseOrder\\.salesOrderCode").val("");
                                        return;
                                    }
                                    var url = "sales/customer-purchase-order-get";
                                    var params = "customerPurchaseOrder.code=" + txtContractReviewCustomerPurchaseOrderCode.val();
                                    params += "&customerPurchaseOrder.validStatus=TRUE";
                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.CustomerPurchaseOrder){
                                            txtContractReviewCustomerPurchaseOrderCode.val(data.CustomerPurchaseOrder.code);
                                            txtContractReviewCustomerPurchaseOrderBranchCode.val(data.CustomerPurchaseOrder.branchCode);
                                            txtContractReviewCustomerPurchaseOrderBranchName.val(data.CustomerPurchaseOrder.branchName);
                                            txtContractReviewCustomerPurchaseOrderCurrencyCode.val(data.CustomerPurchaseOrder.currencyCode);
                                            txtContractReviewCustomerPurchaseOrderCurrencyName.val(data.CustomerPurchaseOrder.currencyName);
                                            txtContractReviewCustomerPurchaseOrderProjectCode.val(data.CustomerPurchaseOrder.projectCode);
                                            txtContractReviewCustomerPurchaseOrderNo.val(data.CustomerPurchaseOrder.customerPurchaseOrderNo);
                                            txtContractReviewCustomerPurchaseOrderCustomerCode.val(data.CustomerPurchaseOrder.customerCode);
                                            txtContractReviewCustomerPurchaseOrderCustomerName.val(data.CustomerPurchaseOrder.customerName);
                                            txtContractReviewCustomerPurchaseOrderEndUserCode.val(data.CustomerPurchaseOrder.endUserCode);
                                            txtContractReviewCustomerPurchaseOrderEndUserName.val(data.CustomerPurchaseOrder.endUserName);
                                            txtContractReviewCustomerPurchaseOrderSalesPersonCode.val(data.CustomerPurchaseOrder.salesPersonCode);
                                            txtContractReviewCustomerPurchaseOrderSalesPersonName.val(data.CustomerPurchaseOrder.salesPersonName);
                                            $("#contractReview\\.customerPurchaseOrder\\.salesOrderCode").val(data.CustomerPurchaseOrder.salesOrderCode);
                                            
                                        }else{
                                            alertMessage("Customer Purchase Order Not Found!",txtContractReviewCustomerPurchaseOrderCode);
                                            txtContractReviewCustomerPurchaseOrderCode.val("");
                                            txtContractReviewCustomerPurchaseOrderBranchCode.val("");
                                            txtContractReviewCustomerPurchaseOrderBranchName.val("");
                                            txtContractReviewCustomerPurchaseOrderCurrencyCode.val("");
                                            txtContractReviewCustomerPurchaseOrderCurrencyName.val("");
                                            txtContractReviewCustomerPurchaseOrderProjectCode.val("");
                                            txtContractReviewCustomerPurchaseOrderNo.val("");
                                            txtContractReviewCustomerPurchaseOrderCustomerCode.val("");
                                            txtContractReviewCustomerPurchaseOrderCustomerName.val("");
                                            txtContractReviewCustomerPurchaseOrderEndUserCode.val("");
                                            txtContractReviewCustomerPurchaseOrderEndUserName.val("");
                                            txtContractReviewCustomerPurchaseOrderSalesPersonCode.val("");
                                            txtContractReviewCustomerPurchaseOrderSalesPersonName.val("");
                                            $("#contractReview\\.customerPurchaseOrder\\.salesOrderCode").val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="contractReview.customerPurchaseOrder.code" name="contractReview.customerPurchaseOrder.code" size="22"></s:textfield>
                                <sj:a id="contractReview_btnCustomerPurchaseOrder" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Branch</td>
                        <td>
                            <s:textfield id="contractReview.customerPurchaseOrder.branch.code" name="contractReview.customerPurchaseOrder.branch.code" size="20" maxLength="45" readonly="true"></s:textfield>
                            <s:textfield id="contractReview.customerPurchaseOrder.branch.name" name="contractReview.customerPurchaseOrder.branch.name" size="35" maxLength="45" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Currency</td>
                        <td>
                            <s:textfield id="contractReview.customerPurchaseOrder.currency.code" name="contractReview.customerPurchaseOrder.currency.code" size="20" maxLength="45" readonly="true"></s:textfield>
                            <s:textfield id="contractReview.customerPurchaseOrder.currency.name" name="contractReview.customerPurchaseOrder.currency.name" size="35" maxLength="45" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Project</td>
                        <td>
                            <s:textfield id="contractReview.customerPurchaseOrder.project.code" name="contractReview.customerPurchaseOrder.project.code" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                            <s:textfield id="contractReview.customerPurchaseOrder.project.name" name="contractReview.customerPurchaseOrder.project.name" size="20" maxLength="45" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                           <div id="contractReviewSalesQuotationDetailInputGrid">
                                <sjg:grid
                                    id="contractReviewSalesQuotationInput_grid"
                                    caption="SALES QUOTATION"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewSalesQuotation"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    onSelectRowTopics="contractReviewSalesQuotationInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewCustomerPurchaseOrderCode" index="contractReviewCustomerPurchaseOrderCode" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewSalesQuotationCode" index="contractReviewSalesQuotationCode" key="contractReviewSalesQuotationCode" title="Code" width="100" sortable="true" 
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewSalesQuotationTransactionDate" index="contractReviewSalesQuotationTransactionDate" key="contractReviewSalesQuotationTransactionDate" 
                                        title="Transaction Date" width="130" formatter="date"  
                                        formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewSalesQuotationSubject" index="contractReviewSalesQuotationSubject" key="contractReviewSalesQuotationSubject" title="Subject"  width="60" sortable="true" 
                                    />
                                </sjg:grid>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table>
                    <tr>
                        <td align="right"><B>Customer PO No*</B></td>
                        <td>
                            <s:textfield id="contractReview.customerPurchaseOrder.customerPurchaseOrderNo" name="contractReview.customerPurchaseOrder.customerPurchaseOrderNo" size="22" readonly="true"></s:textfield>
                        </td>
                    </tr>   
                    <tr>
                        <td align="right"><B>Customer *</B></td>
                        <td>
                            <s:textfield id="contractReview.customerPurchaseOrder.customer.code" name="contractReview.customerPurchaseOrder.customer.code" size="22" readonly="true"></s:textfield>
                            <s:textfield id="contractReview.customerPurchaseOrder.customer.name" name="contractReview.customerPurchaseOrder.customer.name" size="40" readonly="true" ></s:textfield> 
                        </td>
                    </tr>   
                    <tr>
                        <td align="right"><B>End User *</B></td>
                        <td>
                            <s:textfield id="contractReview.customerPurchaseOrder.endUser.code" name="contractReview.customerPurchaseOrder.endUser.code" size="22" readonly="true"></s:textfield>
                            <s:textfield id="contractReview.customerPurchaseOrder.endUser.name" name="contractReview.customerPurchaseOrder.endUser.name" size="40" readonly="true" ></s:textfield> 
                        </td>
                    </tr>   
                    <tr>
                        <td align="right" style="width:120px"><B>Sales Person *</B></td>
                        <td colspan="2">
                            <s:textfield id="contractReview.customerPurchaseOrder.salesPerson.code" name="contractReview.customerPurchaseOrder.salesPerson.code" size="22" readonly="true"></s:textfield>
                            <s:textfield id="contractReview.customerPurchaseOrder.salesPerson.name" name="contractReview.customerPurchaseOrder.salesPerson.name" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Delivery Point</td>
                        <td>
                            <s:textarea id="contractReview.deliveryPoint" name="contractReview.deliveryPoint" cols="50" rows="2" height="20"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Delivery Time</td>
                        <td>
                            <s:textarea id="contractReview.deliveryTime" name="contractReview.deliveryTime" cols="50" rows="2" height="20"></s:textarea>
                        </td>                  
                    </tr> 
                    <tr>
                        <td align="right">Ref No</td>
                        <td><s:textfield id="contractReview.refNo" name="contractReview.refNo" size="27"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td>
                            <s:textarea id="contractReview.remark" name="contractReview.remark" cols="50" rows="2" height="20"></s:textarea>
                        </td>                  
                    </tr> 
                    <tr hidden="true">
                        <td/>
                        <td colspan="2">
                            <s:textfield id="contractReview.createdBy"  name="contractReview.createdBy" size="20"></s:textfield>
                            <sj:datepicker id="contractReview.createdDate" name="contractReview.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                        </td>
                    </tr>
                    <tr hidden="true">
                        <td>
                            <s:textfield id="contractReview.createdBy" name="contractReview.createdBy" key="salesQuotation.createdBy" readonly="true" size="22"></s:textfield>
                            <sj:datepicker id="contractReview.createdDate" name="salesQuotation.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                            <sj:datepicker id="contractReviewTransactionDateFirstSession" name="contractReviewTransactionDateFirstSession" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            <sj:datepicker id="contractReviewTransactionDateLastSession" name="contractReviewTransactionDateLastSession" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            <s:textfield id="contractReviewTemp.createdDateTemp" name="salesQuotationTemp.createdDateTemp" size="20"></s:textfield>
                            <s:textfield id="enumContractReviewActivity" name="enumContractReviewActivity" size="20" cssStyle="display:none"></s:textfield>
                            <s:textfield id="contractReview.salesOrderCode" name="contractReview.salesOrderCode" size="20" cssStyle="display:none"></s:textfield>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
            
    <hr>
    <center><b>SCOPE FOR SUPPLY</b></center>
    <br><br>
            
    <table>
        <tr>
            <td>
                <sj:a href="#" id="btnValveTypeSearch" button="true" style="width: 130px">Search Valve Type</sj:a>
            </td>
        </tr>
        <tr>
            <td>
                <div id="contractReviewValveTypeInputGrid">
                    <sjg:grid
                        id="contractReviewValveTypeInput_grid"
                        caption="Valve Type"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listContractReviewValveType"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        editinline="true"
                        editurl="%{remoteurlContractReviewValveTypeInput}"
                        onSelectRowTopics="contractReviewValveTypeInput_grid_onSelect"
                        >
                        <sjg:gridColumn
                            name="contractReviewValveType" index="contractReviewValveType" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="contractReviewValveTypeDelete" index="contractReviewValveTypeDelete" title="" width="50" align="center"
                            editable="true"
                            edittype="button"
                            editoptions="{onClick:'contractReviewValveTypeDelete_OnClick()', value:'delete'}"
                        />
                        <sjg:gridColumn
                            name="contractReviewValveTypeCode" index="contractReviewValveTypeCode" key="contractReviewValveTypeCode" 
                            title="Valve Type" width="150" sortable="true" editable="true" edittype="text" 
                            editoptions="{onChange:'contractReviewSearchValveTypeCode()'}"
                        /> 
                        <sjg:gridColumn
                            name="contractReviewValveTypeName" index="contractReviewValveTypeName" 
                            title="Valve Type Name" width="200" sortable="true" editable="false"
                        /> 
                        </sjg:grid >
                </div>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <table>
                    <tr>   
                        <td align="right">Spare Parts Commissioning</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.sfsSparepartCommissioningStatus" name="contractReview.sfsSparepartCommissioningStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewSfsSparepartCommissioningStatusRad" name="contractReviewSfsSparepartCommissioningStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" ></s:radio>
                        </td>
                        <td align="right"> </td>
                        <td colspan="2">
                            <s:file name="contractReview.sfsSparepartCommissioningFile" id="contractReview.sfsSparepartCommissioningFile" readonly="true" label="bbb" style="height:20px"/>
                            <s:textfield id="contractReview.ext1" name="contractReview.ext1" readonly="true" style="display:none"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">2 Year Spare Parts</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.sfs2YearSparepartStatus" name="contractReview.sfs2YearSparepartStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewSfs2YearSparepartStatusRad" name="contractReviewSfs2YearSparepartStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" ></s:radio>
                        </td>
                        <td align="right"> </td>
                        <td colspan="2">
                            <s:file name="contractReview.sfs2YearSparepartFile" id="contractReview.sfs2YearSparepartFile" readonly="true" label="bbb" style="height:20px"/>
                            <s:textfield id="contractReview.ext2" name="contractReview.ext2" readonly="true" style="display:none"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Special Tools</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.sfsSpecialToolsStatus" name="contractReview.sfsSpecialToolsStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewSfsSpecialToolsStatusRad" name="contractReviewSfsSpecialToolsStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" ></s:radio>
                        </td>
                        <td align="right"> </td>
                        <td colspan="2">
                            <s:file name="contractReview.sfsSpecialToolsStatusFile" id="contractReview.sfsSpecialToolsStatusFile" readonly="true" label="bbb" style="height:20px"/>
                            <s:textfield id="contractReview.ext3" name="contractReview.ext3" readonly="true" style="display:none"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Packing</td>
                        <td>
                            <s:textfield id="contractReview.sfsPackingStatus" name="contractReview.sfsPackingStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewSfsPackingStatusRad" name="contractReviewSfsPackingStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" ></s:radio>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Painting </td>
                        <td colspan="2">
                            <s:textfield id="contractReview.sfsPaintingStatus" name="contractReview.sfsPaintingStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewSfsPaintingStatusRad" name="contractReviewSfsPaintingStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" ></s:radio>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Painting Spec </td>
                        <td colspan="2">
                            <s:textarea id="contractReview.sfsPaintingSpec" name="contractReview.sfsPaintingSpec" cols="80" rows="5"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Note </td>
                        <td>
                            <s:textarea id="contractReview.sfsNote" name="contractReview.sfsNote" cols="80" rows="5"></s:textarea>
                        </td>
                    </tr>
                </table>
            </td>
            
        </tr>    
    </table>
    
    <hr>          
    <center><b>DESIGN, CODE, APPLICABLE STANDARDS</b></center>
    <br><br>
    
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasDesignSearch" button="true" style="width: 130px">Search Dcas Design</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasDesignInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasDesignInput_grid"
                                    caption="DCAS Design"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASDesign"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasDesignInput}"
                                    onSelectRowTopics="contractReviewDcasDesignInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasDesign" index="contractReviewDcasDesign" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasDesignDelete" index="contractReviewDcasDesignDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasDesignDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasDesignCode" index="contractReviewDcasDesignCode" key="contractReviewDcasDesignCode" 
                                        title="Design" width="150" sortable="true" editable="true" edittype="text"
                                        editoptions="{onChange:'contractReviewSearchDcasDesignCode()'}"
                                    /> 
                                    <sjg:gridColumn
                                        name="contractReviewDcasDesignName" index="contractReviewDcasDesignName" key="contractReviewDcasDesignName" 
                                        title="Design Name" width="200" sortable="true" editable="false"
                                    /> 
                                    </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasDesignOther" name="contractReview.dcasDesignOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasFireSafeByDesignSearch" button="true" style="width: 130px">Search Dcas Fire Safe By Design</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasFireSafeByDesignInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasFireSafeByDesignInput_grid"
                                    caption="DCAS Fire Safe by Design"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASFireSafeByDesign"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasFireSafeByDesignInput}"
                                    onSelectRowTopics="contractReviewDcasFireSafeByDesignInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasFireSafeByDesign" index="contractReviewDcasFireSafeByDesign" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasFireSafeByDesignDelete" index="contractReviewDcasFireSafeByDesignDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasFireSafeByDesignDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasFireSafeByDesignCode" index="contractReviewDcasFireSafeByDesignCode" key="contractReviewDcasFireSafeByDesignCode" 
                                        title="Fire Safe by Design" width="150" sortable="true" editable="true" edittype="text"
                                        editoptions="{onChange:'contractReviewSearchDcasFireSafeByDesignCode()'}"
                                    /> 
                                    <sjg:gridColumn
                                        name="contractReviewDcasFireSafeByDesignName" index="contractReviewDcasFireSafeByDesignName" key="contractReviewDcasFireSafeByDesignName" 
                                        title="Fire Safe by Design Name" width="200" sortable="true" editable="false" 
                                    /> 
                                    </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasFireSafebyDesignOther" name="contractReview.dcasFireSafebyDesignOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasTestingSearch" button="true" style="width: 130px">Search Dcas Testing</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasTestingInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasTestingInput_grid"
                                    caption="DCAS Testing"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASTesting"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasTestingInput}"
                                    onSelectRowTopics="contractReviewDcasTestingInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasTesting" index="contractReviewDcasTesting" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasTestingDelete" index="contractReviewDcasTestingDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasTestingDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasTestingCode" index="contractReviewDcasTestingCode" key="contractReviewDcasTestingCode" 
                                        title="Testing" width="150" sortable="true" editable="true" edittype="text"
                                        editoptions="{onChange:'contractReviewSearchDcasTestingCode()'}"
                                    />    
                                    <sjg:gridColumn
                                        name="contractReviewDcasTestingName" index="contractReviewDcasTestingName" key="contractReviewDcasTestingName" 
                                        title="Testing Name" width="200" sortable="true" editable="false" 
                                    />    
                                    </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasTestingOther" name="contractReview.dcasTestingOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>      
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasHydroTestSearch" button="true" style="width: 130px">Search Dcas Hyrdro Test</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasHydroTestInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasHydroTestInput_grid"
                                    caption="DCAS Hydro Test"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASHydroTest"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasHydroTestInput}"
                                    onSelectRowTopics="contractReviewDcasHydroTestInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasHydroTest" index="contractReviewDcasHydroTest" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasHydroTestDelete" index="contractReviewDcasHydroTestDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasHydroTestDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasHydroTestCode" index="contractReviewDcasHydroTestCode" key="contractReviewDcasHydroTestCode" 
                                        title="Hydro Test" width="150" sortable="true" editable="true" edittype="text"
                                        editoptions="{onChange:'contractReviewSearchDcasHydroTestCode()'}"
                                    /> 
                                    <sjg:gridColumn
                                        name="contractReviewDcasHydroTestName" index="contractReviewDcasHydroTestName" key="contractReviewDcasHydroTestName" 
                                        title="Hydro Test" width="200" sortable="true" editable="false"
                                    /> 
                                    </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasHydroTestOther" name="contractReview.dcasHydroTestOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasVisualExaminationSearch" button="true" style="width: 130px">Search Dcas Visual Examination</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasVisualExaminationGrid">
                                <sjg:grid
                                    id="contractReviewDcasVisualExaminationInput_grid"
                                    caption="DCAS Visual Examination"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASVisualExamination"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasVisualExaminationInput}"
                                    onSelectRowTopics="contractReviewDcasVisualExaminationInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasVisualExamination" index="contractReviewDcasVisualExamination" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasVisualExaminationDelete" index="contractReviewDcasVisualExaminationDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasVisualExaminationDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasVisualExaminationCode" index="contractReviewDcasVisualExaminationCode" key="contractReviewDcasVisualExaminationCode" 
                                        title="Visual Examination" width="150" sortable="true" editable="true" edittype="text" 
                                        editoptions="{onChange:'contractReviewSearchDcasVisualExaminationCode()'}"
                                    /> 
                                    <sjg:gridColumn
                                        name="contractReviewDcasVisualExaminationName" index="contractReviewDcasVisualExaminationName" key="contractReviewDcasVisualExaminationName" 
                                        title="Visual Examination Name" width="200" sortable="true" editable="false" 
                                    /> 
                                    </sjg:grid >
                            </div>    
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasVisualExaminationOther" name="contractReview.dcasVisualExaminationOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasNdeSearch" button="true" style="width: 130px">Search Dcas NDE</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasNdeInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasNdeInput_grid"
                                    caption="DCAS Nde"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASNde"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasNdeInput}"
                                    onSelectRowTopics="contractReviewDcasNdeInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasNde" index="contractReviewDcasNde" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasNdeDelete" index="contractReviewDcasNdeDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasNdeDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasNdeCode" index="contractReviewDcasNdeCode" key="contractReviewDcasNdeCode" 
                                        title="NDE" width="150" sortable="true" editable="true" edittype="text"
                                        editoptions="{onChange:'contractReviewSearcDcasNdeCode()'}"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasNdeName" index="contractReviewDcasNdeName" key="contractReviewDcasNdeName" 
                                        title="NDE Name" width="200" sortable="true" editable="false" 
                                    />  
                                    </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasNdeOther" name="contractReview.dcasNdeOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasMarkingSearch" button="true" style="width: 130px">Search Dcas Marking</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasMarkingInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasMarkingInput_grid"
                                    caption="DCAS Marking"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASMarking"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasMarkingInput}"
                                    onSelectRowTopics="contractReviewDcasMarkingInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasMarking" index="contractReviewDcasMarking" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasMarkingDelete" index="contractReviewDcasMarkingDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasMarkingDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasMarkingCode" index="contractReviewDcasMarkingCode" key="contractReviewDcasMarkingCode" 
                                        title="Marking" width="150" sortable="true" editable="true" edittype="text"
                                        editoptions="{onChange:'contractReviewSearchDcasMarkingCode()'}"
                                    />  
                                    <sjg:gridColumn
                                        name="contractReviewDcasMarkingName" index="contractReviewDcasMarkingName" key="contractReviewDcasMarkingName" 
                                        title="Marking Name" width="200" sortable="true" editable="false" 
                                    />  
                                    </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasMarkingOther" name="contractReview.dcasMarkingOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnDcasLegalRequirementsSearch" button="true" style="width: 130px">Search Dcas Legal Requirements</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="contractReviewDcasLegalRequirementsInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasLegalRequirementsInput_grid"
                                    caption="DCAS Legal Requirements"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASLegalRequirements"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    editurl="%{remoteurlContractReviewDcasLegalRequirementsInput}"
                                    onSelectRowTopics="contractReviewDcasLegalRequirementsInput_grid_onSelect"
                                    >
                                    <sjg:gridColumn
                                        name="contractReviewDcasLegalRequirements" index="contractReviewDcasLegalRequirements" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                     <sjg:gridColumn
                                        name="contractReviewDcasLegalRequirementsDelete" index="contractReviewDcasLegalRequirementsDelete" title="" width="50" align="center"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'contractReviewDcasLegalRequirementsDelete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="contractReviewDcasLegalRequirementsCode" index="contractReviewDcasLegalRequirementsCode" key="contractReviewDcasLegalRequirementsCode" 
                                        title="Legal Requirements" width="150" sortable="true" editable="true" edittype="text"
                                        editoptions="{onChange:'contractReviewSearchDcasLegalRequirementsCode()'}"
                                    /> 
                                    <sjg:gridColumn
                                        name="contractReviewDcasLegalRequirementsName" index="contractReviewDcasLegalRequirementsName" key="contractReviewDcasLegalRequirementsName" 
                                        title="Legal Requirements" width="200" sortable="true" editable="false"
                                    /> 
                                    </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="contractReview.dcasRequirementOther" name="contractReview.dcasRequirementOther" size="60"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
        </tr>
    </table>
    <br/>
    <table>
        <tr>
            <td align="right">Pressure Test (Hydro)</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasPressureTestHydroStatus" name="contractReview.dcasPressureTestHydroStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasPressureTestHydroStatusRad" name="contractReviewDcasPressureTestHydroStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" ></s:radio>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="contractReview.dcasPressureTestHydroStatusRemark" name="contractReview.dcasPressureTestHydroStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right">Pressure Test (Gas)</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasPressureTestGasStatus" name="contractReview.dcasPressureTestGasStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasPressureTestGasStatusRad" name="contractReviewDcasPressureTestGasStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" ></s:radio>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="contractReview.dcasPressureTestGasStatusRemark" name="contractReview.dcasPressureTestGasStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>    
        <tr>
            <td align="right">PMI</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasPmiStatus" name="contractReview.dcasPmiStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasPmiStatusRad" name="contractReviewDcasPmiStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" ></s:radio>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="contractReview.dcasPmiStatusRemark" name="contractReview.dcasPmiStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>    
        <tr>
            <td align="right">Witness</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasWitnessStatus" name="contractReview.dcasWitnessStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasWitnessStatusRad" name="contractReviewDcasWitnessStatusRad" list="{'REQUIRED','NOT_REQUIRED','AS_PER_APPROVED_ITP'}" ></s:radio>
                &emsp;Remark
                <s:textarea id="contractReview.dcasWitnessStatusRemark" name="contractReview.dcasWitnessStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>    
        <tr>
            <td align="right">Hyperbaric Test</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasHyperbaricTestStatus" name="contractReview.dcasHyperbaricTestStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasHyperbaricTestStatusRad" name="contractReviewDcasHyperbaricTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" ></s:radio>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="contractReview.dcasHyperbaricTestStatusRemark" name="contractReview.dcasHyperbaricTestStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right">Anti Static Test</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasAntiStaticTestStatus" name="contractReview.dcasAntiStaticTestStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasAntiStaticTestStatusRad" name="contractReviewDcasAntiStaticTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" ></s:radio>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="contractReview.dcasAntiStaticTestStatusRemark" name="contractReview.dcasAntiStaticTestStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right">Torque Test</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasTorqueTestStatus" name="contractReview.dcasTorqueTestStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasTorqueTestStatusRad" name="contractReviewDcasTorqueTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" ></s:radio>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="contractReview.dcasTorqueTestStatusRemark" name="contractReview.dcasTorqueTestStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right">DIB/DBB Test</td>
            <td colspan="2">
                <s:textfield id="contractReview.dcasDibDbbTestStatus" name="contractReview.dcasDibDbbTestStatus" readonly="false" size="20" style="display:none"></s:textfield>
                <s:radio id="contractReviewDcasDibDbbTestStatusRad" name="contractReviewDcasDibDbbTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" ></s:radio>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="contractReview.dcasDibDbbTestStatusRemark" name="contractReview.dcasDibDbbTestStatusRemark" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
    </table>

    <hr>    
    <center><b>CERTIFICATION AND DOCUMENTATION</b></center>
    <br><br>

    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td align="right">Pressure Containing Parts</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.cadPressureContainingPartsStatus" name="contractReview.cadPressureContainingPartsStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewCadPressureContainingPartsStatusRad" name="contractReviewCadPressureContainingPartsStatusRad" list="{'TYPE_3.2','TYPE_3.1','OTHER'}" ></s:radio>
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                            <s:textarea id="contractReview.cadPressureContainingPartsRemark" name="contractReview.cadPressureContainingPartsRemark" cols="50" rows="3"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Pressure Controlling Parts</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.cadPressureControllingPartsStatus" name="contractReview.cadPressureControllingPartsStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewCadPressureControllingPartsStatusRad" name="contractReviewCadPressureControllingPartsStatusRad" list="{'TYPE_3.2','TYPE_3.1','TYPE_2.2','OTHER'}" ></s:radio>
                            &emsp;&emsp;&nbsp;Remark
                            <s:textarea id="contractReview.cadPressureControllingPartsRemark" name="contractReview.cadPressureControllingPartsRemark" cols="50" rows="3"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Non Pressure Containing Parts</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.cadNonPressureControllingPartsStatus" name="contractReview.cadNonPressureControllingPartsStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewCadNonPressureControllingPartsStatusRad" name="contractReviewCadNonPressureControllingPartsStatusRad" list="{'TYPE_2.2','TYPE_2.1','OTHER'}" ></s:radio>
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                            <s:textarea id="contractReview.cadNonPressureControllingPartsRemark" name="contractReview.cadNonPressureControllingPartsRemark" cols="50" rows="3"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Actuator (If Any)</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.cadActuator" name="contractReview.cadActuator" size="27"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Notes </td>
                        <td colspan="2">
                            <s:textfield id="contractReview.cadNote1" name="contractReview.cadNote1" size="27"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Notes</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.cadNote2" name="contractReview.cadNote2" size="27"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td><B> Documentation For Approval </B></td>
                    </tr>
                </table>    
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnCadDocumentApprovalSearch" button="true" style="width: 130px">Search CAD Doc Approval</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <div id="contractReviewDetailDescriptionInputGrid">
                            <sjg:grid
                                id="contractReviewCadDocumentApprovalInput_grid"
                                caption="Document Approval"
                                dataType="local"
                                pager="true"
                                navigator="false"
                                navigatorView="true"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listContractReviewCADDocumentApproval"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false"
                                editinline="true"
                                editurl="%{remotedetailurlContractReviewCadDocumentApprovalInput}"
                                onSelectRowTopics="contractReviewCadDocumentApprovalInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="contractReviewCadDocumentApproval" index="contractReviewCadDocumentApproval" key="contractReviewCadDocumentApproval" title="" editable="true" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="contractReviewCadDocumentApprovalDelete" index="contractReviewCadDocumentApprovalDelete" title="" width="50" align="center"
                                    editable="true"
                                    edittype="button"
                                    editoptions="{onClick:'contractReviewCadDocumentApprovalDelete_OnClick()', value:'delete'}"
                                />
                                <sjg:gridColumn
                                    name = "contractReviewCadDocumentApprovalCode" index = "contractReviewCadDocumentApprovalCode" key = "contractReviewCadDocumentApprovalCode" 
                                    title = "Description" width = "150" editable="true"
                                    editoptions="{onChange:'contractReviewSearchCadDocumentApprovalCode()'}"
                                />
                                <sjg:gridColumn
                                    name = "contractReviewCadDocumentApprovalName" index = "contractReviewCadDocumentApprovalName" key = "contractReviewCadDocumentApprovalName" 
                                    title = "Description Name" width = "200" editable="false"
                                />
                                </sjg:grid >
                            </div>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td align="right">Notes</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.cadDocumentationForApprovalNote" name="contractReview.cadDocumentationForApprovalNote" size="27"></s:textfield>
                        </td>
                    </tr>
                </table>
            </td>            
        </tr>        
    </table>
                        
    <hr>
    <center><b>TECHNICAL NOTES</b></center>
    <br><br>
    
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td align="right">Actuator</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.tnActuatorStatus" name="contractReview.tnActuatorStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewTnActuatorStatusRad" name="contractReviewTnActuatorStatusRad" list="{'YES','NO'}" ></s:radio>
                        </td>
                        <td>
                            <script type = "text/javascript"> 
                                txtContractReviewTnBrandCode.change(function(ev) {

                                        if(txtContractReviewTnBrandCode.val()===""){
                                            txtContractReviewTnBrandCode.val("");
                                            txtContractReviewTnBrandName.val("");
                                            return;
                                        }
                                        var url = "master/item-brand-get";
                                        var params = "itemBrand.code=" + txtContractReviewTnBrandCode.val();
                                            params += "&itemBrand.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.itemBrandTemp){
                                                txtContractReviewTnBrandCode.val(data.itemBrandTemp.code);
                                                txtContractReviewTnBrandName.val(data.itemBrandTemp.name);
                                            }
                                            else{
                                                alertMessage("Brand Not Found!",txtContractReviewTnBrandCode);
                                                txtContractReviewTnBrandCode.val("");
                                                txtContractReviewTnBrandName.val("");
                                            }
                                        });
                                    });
                            </script>
                            <div class="searchbox ui-widget-header">
                                <B>Brand</B>
                                <s:textfield id="contractReview.tnBrand.code" name="contractReview.tnBrand.code" size="22"></s:textfield>
                                <sj:a id="contractReview_btnBrand" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="contractReview.tnBrand.name" name="contractReview.tnBrand.name" readonly="true" size="22"></s:textfield>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td align="right">Limitation Origin</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.tnLimitationOriginStatus" name="contractReview.tnLimitationOriginStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewTnLimitationOriginStatusRad" name="contractReviewTnLimitationOriginStatusRad" list="{'YES','NO'}" ></s:radio>
                        </td>
                        <td colspan="2">
                            <s:file name="contractReview.tnLimitationOrigin" id="contractReview.tnLimitationOrigin" readonly="true" label="bbb" style="height:20px;width:380px" /> 
                            <s:textfield id="contractReview.ext4" name="contractReview.ext4" readonly="true" style="display:none"></s:textfield> 
                        </td>
                        <td>Remark</td>
                        <td>
                            <s:textarea id="contractReview.tnLimitationOriginRemark" name="contractReview.tnLimitationOriginRemark" cols="50" rows="3"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Approval Manufactured List</td>
                        <td colspan="2">
                            <s:textfield id="contractReview.tnApprovalManufacturedListStatus" name="contractReview.tnApprovalManufacturedListStatus" readonly="false" size="20" style="display:none"></s:textfield>
                            <s:radio id="contractReviewTnApprovalManufacturedListStatusRad" name="contractReviewTnApprovalManufacturedListStatusRad" list="{'YES','NO'}" ></s:radio>
                             
                        </td>
                        <td colspan="2">
                            <s:file name="contractReview.tnApprovalManufacturedList" id="contractReview.tnApprovalManufacturedList" readonly="true" label="bbb" style="height:20px;width:380px"/>
                            <s:textfield id="contractReview.ext5" name="contractReview.ext5" readonly="true" style="display:none"></s:textfield> 
                        </td>
                        <td>Remark</td>
                        <td>
                            <s:textarea id="contractReview.tnApprovalManufacturedListRemark" name="contractReview.tnApprovalManufacturedListRemark" cols="50" rows="3"></s:textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><B> Estimation Issues :</B>
                <table>
                    <tr>
                        <td align="right">BOM</td>
                        <td>
                            <s:textfield id="contractReview.tnBom" name="contractReview.tnBom" size="10" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">PR</td>
                        <td>
                            <s:textfield id="contractReview.tnPr" name="contractReview.tnPr" size="10" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">PO & Arrival Mat</td>
                        <td>
                            <s:textfield id="contractReview.tnPOAndArrivalMat" name="contractReview.tnPOAndArrivalMat" size="10" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Machining, Assembly, Testing</td>
                        <td>
                            <s:textfield id="contractReview.tnMatchAssTest" name="contractReview.tnMatchAssTest" size="10" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Painting (If Any)</td>
                        <td>
                            <s:textfield id="contractReview.tnPainting" name="contractReview.tnPainting" size="10" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Packing & Documentation</td>
                        <td>
                            <s:textfield id="contractReview.tnPackingAndDocumentation" name="contractReview.tnPackingAndDocumentation" size="10" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Estimation Issue Documents Approval</td>
                        <td>
                            <s:textfield id="contractReview.tnEstimationIssueDocumentsApproval" name="contractReview.tnEstimationIssueDocumentsApproval" size="10" ></s:textfield>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td align="right">Notes </td>
                        <td colspan="2">
                            <s:textarea id="contractReview.tnNote" name="contractReview.tnNote" cols="80" rows="5"></s:textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
                
    <hr>    
    <center><b>ADDITIONAL NOTES</b></center>
    <br><br>
    
    <table>
        <tr>
            <td colspan="2">
                <s:textarea id="contractReview.additionalNote" name="contractReview.additionalNote" cols="80" rows="5"></s:textarea>
            </td>
        </tr>
    </table>
      
    <hr>   
    <center><b>CONCLUSION</b></center>
    <br><br>
    
    <table>
        <tr>
            <td align="right"></td>
            <td colspan="2">
                <s:textarea id="contractReview.conclusionNote" name="contractReview.conclusionNote" cols="80" rows="5"></s:textarea>
            </td>
        </tr>
    </table>
</s:form>      
     
</div>
<table width="100%">
    <tr>
        <td width="20%" valign="top">
            <table  width="100%">
                <tr>
                    <td>
                        <sj:a href="#" id="btnContractReviewSave" button="true">Save</sj:a>
                        <sj:a href="#" id="btnContractReviewCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </td>
</table>