
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
  $(document).ready(function(){
      hoverButton();
      
        $('#contractReviewSearchValidStatusRadYES').prop('checked',true);
        $("#contractReviewSearchValidStatus").val("true");
        
        $('input[name="contractReviewSearchValidStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#contractReviewSearchValidStatus").val(value);
        });

        $('input[name="contractReviewSearchValidStatusRad"][value="YES"]').change(function(ev){
            var value="TRUE";
            $("#contractReviewSearchValidStatus").val(value);
        });

        $('input[name="contractReviewSearchValidStatusRad"][value="NO"]').change(function(ev){
            var value="FALSE";
            $("#contractReviewSearchValidStatus").val(value);
        });
      
      $.subscribe("contractReview_grid_onSelect", function(event, data){
            var selectedRowID = $("#contractReview_grid").jqGrid("getGridParam", "selrow"); 
            var contractReview = $("#contractReview_grid").jqGrid("getRowData", selectedRowID);

            $("#contractReviewValveType_grid").jqGrid("setGridParam",{url:"sales/contract-review-valve-type-data?contractReview.code=" + contractReview.code});
            $("#contractReviewValveType_grid").jqGrid("setCaption", "Valve Type : " + contractReview.code);
            $("#contractReviewValveType_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasDesign_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-design-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasDesign_grid").jqGrid("setCaption", "Design : " + contractReview.code);
            $("#contractReviewDcasDesign_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasFireSafeByDesign_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-fire-safe-by-design-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasFireSafeByDesign_grid").jqGrid("setCaption", "Fire Safe Design : " + contractReview.code);
            $("#contractReviewDcasFireSafeByDesign_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasTesting_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-testing-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasTesting_grid").jqGrid("setCaption", "Testing : " + contractReview.code);
            $("#contractReviewDcasTesting_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasHydroTest_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-hydro-test-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasHydroTest_grid").jqGrid("setCaption", "Hydro Test : " + contractReview.code);
            $("#contractReviewDcasHydroTest_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasVisualExamination_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-visual-examination-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasVisualExamination_grid").jqGrid("setCaption", "Visual Examination : " + contractReview.code);
            $("#contractReviewDcasVisualExamination_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasNde_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-nde-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasNde_grid").jqGrid("setCaption", "NDE : " + contractReview.code);
            $("#contractReviewDcasNde_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasMarking_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-marking-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasMarking_grid").jqGrid("setCaption", "Marking : " + contractReview.code);
            $("#contractReviewDcasMarking_grid").trigger("reloadGrid");
            
            $("#contractReviewDcasLegalRequirements_grid").jqGrid("setGridParam",{url:"sales/contract-review-dcas-legal-requirements-data?contractReview.code=" + contractReview.code});
            $("#contractReviewDcasLegalRequirements_grid").jqGrid("setCaption", "Legal Requirements : " + contractReview.code);
            $("#contractReviewDcasLegalRequirements_grid").trigger("reloadGrid");
            
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("setGridParam",{url:"sales/contract-review-cad-document-approval-data?contractReview.code=" + contractReview.code});
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("setCaption", "Document Approval : " + contractReview.code);
            $("#contractReviewCadDocumentApprovalInput_grid").trigger("reloadGrid");
            
//          SFS            
            var sfsSparepartCommissioningStatus = contractReview.sfsSparepartCommissioningStatus;
            switch(sfsSparepartCommissioningStatus){
                case "REQUIRED":
                    $('#sfsSparepartCommissioningStatusRadREQUIRED').prop('checked',true);
                    $('#sfsSparepartCommissioningStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#sfsSparepartCommissioningStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#sfsSparepartCommissioningStatusRadREQUIRED').attr('disabled',true);
                    break;
            }
            
            var sfs2YearSparepartStatus = contractReview.sfs2YearSparepartStatus;
            switch(sfs2YearSparepartStatus){
                case "REQUIRED":
                    $('#sfs2YearSparepartStatusRadREQUIRED').prop('checked',true);
                    $('#sfs2YearSparepartStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#sfs2YearSparepartStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#sfs2YearSparepartStatusRadREQUIRED').attr('disabled',true);
                    break;
            }
            
            var sfsSpecialToolsStatus = contractReview.sfsSpecialToolsStatus;
            switch(sfsSpecialToolsStatus){
                case "REQUIRED":
                    $('#sfsSpecialToolsStatusRadREQUIRED').prop('checked',true);
                    $('#sfsSpecialToolsStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#sfsSpecialToolsStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#sfsSpecialToolsStatusRadREQUIRED').attr('disabled',true);
                    break;
            }
            
            var sfsPackingStatus = contractReview.sfsPackingStatus;
            switch(sfsPackingStatus){
                case "REQUIRED":
                    $('#sfsPackingStatusRadREQUIRED').prop('checked',true);
                    $('#sfsPackingStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#sfsPackingStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#sfsPackingStatusRadREQUIRED').attr('disabled',true);
                    break;
            }
            
            var sfsPaintingStatus = contractReview.sfsPaintingStatus;
            switch(sfsPaintingStatus){
                case "REQUIRED":
                    $('#sfsPaintingStatusRadREQUIRED').prop('checked',true);
                    $('#sfsPaintingStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#sfsPaintingStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#sfsPaintingStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#sfsPaintingStatusRadREQUIRED').attr('disabled',true);
                    $('#sfsPaintingStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#sfsPaintingStatusRadOTHER').prop('checked',true);
                    $('#sfsPaintingStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#sfsPaintingStatusRadREQUIRED').attr('disabled',true);
                    break;
            }
            
            $("#sfsPaintingSpec").val(contractReview.sfsPaintingSpec);
            $("#sfsNote").val(contractReview.sfsNote);

            var dcasPressureTestHydroStatus = contractReview.dcasPressureTestHydroStatus;
            switch(dcasPressureTestHydroStatus){
                case "REQUIRED":
                    $('#dcasPressureTestHydroStatusRadREQUIRED').prop('checked',true);
                    $('#dcasPressureTestHydroStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasPressureTestHydroStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasPressureTestHydroStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasPressureTestHydroStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasPressureTestHydroStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#dcasPressureTestHydroStatusRadOTHER').prop('checked',true);
                    $('#dcasPressureTestHydroStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasPressureTestHydroStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
            }
            $("#dcasPressureTestHydroStatusRemark").val(contractReview.dcasPressureTestHydroStatusRemark);
          
            var dcasPressureTestGasStatus = contractReview.dcasPressureTestGasStatus;
            switch(dcasPressureTestGasStatus){
                case "REQUIRED":
                    $('#dcasPressureTestGasStatusRadREQUIRED').prop('checked',true);
                    $('#dcasPressureTestGasStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasPressureTestGasStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasPressureTestGasStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasPressureTestGasStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasPressureTestGasStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#dcasPressureTestGasStatusRadOTHER').prop('checked',true);
                    $('#dcasPressureTestGasStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasPressureTestGasStatusRadREQUIRED').attr('disabled',true);
                    break;
            }
            $("#dcasPressureTestGasStatusRemark").val(contractReview.dcasPressureTestGasStatusRemark);
            
            var dcasPmiStatus = contractReview.dcasPmiStatus;
            switch(dcasPmiStatus){
                case "REQUIRED":
                    $('#dcasPmiStatusRadREQUIRED').prop('checked',true);
                    $('#dcasPmiStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasPmiStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasPmiStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasPmiStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasPmiStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#dcasPmiStatusRadOTHER').prop('checked',true);
                    $('#dcasPmiStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasPmiStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
            }
            $("#dcasPmiStatusRemark").val(contractReview.dcasPmiStatusRemark);
            
            var dcasWitnessStatus = contractReview.dcasWitnessStatus;
            switch(dcasWitnessStatus){
                case "REQUIRED":
                    $('#dcasWitnessStatusRadREQUIRED').prop('checked',true);
                    $('#dcasWitnessStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasWitnessStatusRadAS_PER_APPROVED_ITP').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasWitnessStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasWitnessStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasWitnessStatusRadAS_PER_APPROVED_ITP').attr('disabled',true);
                    break;
                case "AS_PER_APPROVED_ITP":
                    $('#dcasWitnessStatusRadAS_PER_APPROVED_ITP').prop('checked',true);
                    $('#dcasWitnessStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasWitnessStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
            }
            $("#dcasWitnessStatusRemark").val(contractReview.dcasWitnessStatusRemark);
            
              var dcasHyperbaricTestStatus = contractReview.dcasHyperbaricTestStatus;
            switch(dcasHyperbaricTestStatus){
                case "REQUIRED":
                    $('#dcasHyperbaricTestStatusRadREQUIRED').prop('checked',true);
                    $('#dcasHyperbaricTestStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasHyperbaricTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasHyperbaricTestStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasHyperbaricTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasHyperbaricTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#dcasHyperbaricTestStatusRadOTHER').prop('checked',true);
                    $('#dcasHyperbaricTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasHyperbaricTestStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
            }
            $("#dcasHyperbaricTestStatusRemark").val(contractReview.dcasHyperbaricTestStatusRemark);
            
              var dcasAntiStaticTestStatus = contractReview.dcasAntiStaticTestStatus;
            switch(dcasAntiStaticTestStatus){
                case "REQUIRED":
                    $('#dcasAntiStaticTestStatusRadREQUIRED').prop('checked',true);
                    $('#dcasAntiStaticTestStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasAntiStaticTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasAntiStaticTestStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasAntiStaticTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasAntiStaticTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#dcasAntiStaticTestStatusRadOTHER').prop('checked',true);
                    $('#dcasAntiStaticTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasAntiStaticTestStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
            }
            $("#dcasAntiStaticTestStatusRemark").val(contractReview.dcasAntiStaticTestStatusRemark); 
           
              var dcasTorqueTestStatus = contractReview.dcasTorqueTestStatus;
            switch(dcasTorqueTestStatus){
                case "REQUIRED":
                    $('#dcasTorqueTestStatusRadREQUIRED').prop('checked',true);
                    $('#dcasTorqueTestStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasTorqueTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasTorqueTestStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasTorqueTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasTorqueTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#dcasTorqueTestStatusRadOTHER').prop('checked',true);
                    $('#dcasTorqueTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasTorqueTestStatusRadNOT_REQUIRED').attr('disabled',true);
                    break;
            }
            $("#dcasTorqueTestStatusRemark").val(contractReview.dcasTorqueTestStatusRemark); 
            
              var dcasDibDbbTestStatus = contractReview.dcasDibDbbTestStatus;
            switch(dcasDibDbbTestStatus){
                case "REQUIRED":
                    $('#dcasDibDbbTestStatusRadREQUIRED').prop('checked',true);
                    $('#dcasDibDbbTestStatusRadNOT_REQUIRED').attr('disabled',true);
                    $('#dcasDibDbbTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "NOT_REQUIRED":
                    $('#dcasDibDbbTestStatusRadNOT_REQUIRED').prop('checked',true);
                    $('#dcasDibDbbTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasDibDbbTestStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#dcasDibDbbTestStatusRadOTHER').prop('checked',true);
                    $('#dcasDibDbbTestStatusRadREQUIRED').attr('disabled',true);
                    $('#dcasDibDbbTestStatusRadNOT_REQUIRED').prop('disabled',true);
                    break;
            }
            $("#dcasDibDbbTestStatusRemark").val(contractReview.dcasDibDbbTestStatusRemark); 
            
              var cadPressureContainingPartsStatus = contractReview.cadPressureContainingPartsStatus;
            switch(cadPressureContainingPartsStatus){
                case "TYPE_3.2":
                    $('#cadPressureContainingPartsStatusRadTYPE_3\\.2').prop('checked',true);
                    $('#cadPressureContainingPartsStatusRadTYPE_3\\.1').attr('disabled',true);
                    $('#cadPressureContainingPartsStatusRadOTHER').attr('disabled',true);
                    break;
                case "TYPE_3.1":
                    $('#cadPressureContainingPartsStatusRadTYPE_3\\.1').prop('checked',true);
                    $('#cadPressureContainingPartsStatusRadTYPE_3\\.2').attr('disabled',true);
                    $('#cadPressureContainingPartsStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#cadPressureContainingPartsStatusRadOTHER').prop('checked',true);
                    $('#cadPressureContainingPartsStatusRadTYPE_3\\.1').attr('disabled',true);
                    $('#cadPressureContainingPartsStatusRadTYPE_3\\.2').attr('disabled',true);
                    break;
            }
            
              var cadPressureControllingPartsStatus = contractReview.cadPressureControllingPartsStatus;
            switch(cadPressureControllingPartsStatus){
                case "TYPE_3.2":
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.2').prop('checked',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.1').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_2\\.2').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadOTHER').attr('disabled',true);
                    break;
                case "TYPE_3.1":
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.1').prop('checked',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_2\\.2').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.2').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadOTHER').attr('disabled',true);
                    break;
                case "TYPE_2.2":
                    $('#cadPressureControllingPartsStatusRadTYPE_2\\.2').prop('checked',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.2').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.1').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadOTHER').attr('disabled',true);
                    break;
                case "OTHER":
                    $('#cadPressureControllingPartsStatusRadOTHER').prop('checked',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.2').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_3\\.1').attr('disabled',true);
                    $('#cadPressureControllingPartsStatusRadTYPE_2\\.2').attr('disabled',true);
                    break;
            }
            
              var cadNonPressureControllingPartsStatus = contractReview.cadNonPressureControllingPartsStatus;
            switch(cadNonPressureControllingPartsStatus){
                case "TYPE_2.2":
                    $('#cadNonPressureControllingPartsStatusRadTYPE_2\\.2').prop('checked',true);
                    $('#cadNonPressureControllingPartsStatusRadTYPE_2\\.1').attr('disabled',true);
                    $('#cadNonPressureControllingPartsStatusRadOTHER').attr('disabled',true);
                    break;
                 case "TYPE_2.1":
                    $('#cadNonPressureControllingPartsStatusRadTYPE_2\\.1').prop('checked',true);
                    $('#cadNonPressureControllingPartsStatusRadTYPE_2\\.2').attr('disabled',true);
                    $('#cadNonPressureControllingPartsStatusRadOTHER').attr('disabled',true);
                    break;    
                case "OTHER":
                    $('#cadNonPressureControllingPartsStatusRadOTHER').prop('checked',true);
                    $('#cadNonPressureControllingPartsStatusRadTYPE_2\\.2').attr('disabled',true);
                    $('#cadNonPressureControllingPartsStatusRadTYPE_2\\.1').attr('disabled',true);
                    break;
            }
            
            $("#cadPressureContainingPartsRemark").val(contractReview.cadPressureContainingPartsRemark);
            $("#cadPressureControllingPartsRemark").val(contractReview.cadPressureControllingPartsRemark);
            $("#cadNonPressureControllingPartsRemark").val(contractReview.cadNonPressureControllingPartsRemark);
            $("#cadActuator").val(contractReview.cadActuator);
            $("#cadNote1").val(contractReview.cadNote1);
            $("#cadNote2").val(contractReview.cadNote2);
            $("#cadDocumentationForApprovalNote").val(contractReview.cadDocumentationForApprovalNote);
            
              var tnActuatorStatus = contractReview.tnActuatorStatus;
            switch(tnActuatorStatus){
                case "YES":
                    $('#tnActuatorStatusRadYES').prop('checked',true);
                    $('#tnActuatorStatusRadNO').attr('disabled',true);
                    break;
                case "NO":
                    $('#tnActuatorStatusRadNO').prop('checked',true);
                    $('#tnActuatorStatusRadYES').attr('disabled',true);
                    break;
            }
            
              var tnLimitationOriginStatus = contractReview.tnLimitationOriginStatus;
            switch(tnLimitationOriginStatus){
                case "YES":
                    $('#tnLimitationOriginStatusRadYES').prop('checked',true);
                    $('#tnLimitationOriginStatusRadNO').attr('disabled',true);
                    break;
                case "NO":
                    $('#tnLimitationOriginStatusRadNO').prop('checked',true);
                    $('#tnLimitationOriginStatusRadYES').attr('disabled',true);
                    break;
            }
            
              var tnApprovalManufacturedListStatus = contractReview.tnApprovalManufacturedListStatus;
            switch(tnApprovalManufacturedListStatus){
                case "YES":
                    $('#tnApprovalManufacturedListStatusRadYES').prop('checked',true);
                    $('#tnApprovalManufacturedListStatusRadNO').attr('disabled',true);
                    break;
                case "NO":
                    $('#tnApprovalManufacturedListStatusRadNO').prop('checked',true);
                    $('#tnApprovalManufacturedListStatusRadYES').attr('disabled',true);
                    break;
            }
            
            $("#dcasDesignOther").val(contractReview.dcasDesignOther);
            $("#dcasFireSafebyDesignOther").val(contractReview.dcasFireSafebyDesignOther);
            $("#dcasTestingOther").val(contractReview.dcasTestingOther);
            $("#dcasHydroTestOther").val(contractReview.dcasHydroTestOther);
            $("#dcasNdeOther").val(contractReview.dcasNdeOther);
            $("#dcasMarkingOther").val(contractReview.dcasMarkingOther);
            $("#dcasRequirementOther").val(contractReview.dcasRequirementOther);
            $("#tnBrandCode").val(contractReview.tnBrandCode);
            $("#tnBrandName").val(contractReview.tnBrandName);
            $("#tnLimitationOriginRemark").val(contractReview.tnLimitationOriginRemark);
            $("#tnApprovalManufacturedListRemark").val(contractReview.tnApprovalManufacturedListRemark);
            $("#tnBom").val(contractReview.tnBom);
            $("#tnPr").val(contractReview.tnPr);
            $("#tnPOAndArrivalMat").val(contractReview.tnPOAndArrivalMat);
            $("#tnMatchAssTest").val(contractReview.tnMatchAssTest);
            $("#tnPainting").val(contractReview.tnPainting);
            $("#tnPackingAndDocumentation").val(contractReview.tnPackingAndDocumentation);
            $("#tnEstimationIssueDocumentsApproval").val(contractReview.tnEstimationIssueDocumentsApproval);
            $("#tnNote").val(contractReview.tnNote);
            
            $("#additionalNote").val(contractReview.additionalNote);
            
            $("#conclusionNote").val(contractReview.conclusionNote);
        });
        
//      SFS Sparepart Commisioning       tnActuatorStatus
        $('#sfsSparepartCommissioningStatusRad').prop('checked',true);
        $("#contractReview\\.sfsSparepartCommissioningStatus").val("REQUIRED");
        
        $('input[name="sfsSparepartCommissioningStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.sfsSparepartCommissioningStatus").val(value);
        });
        
        $('input[name="sfsSparepartCommissioningStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.sfsSparepartCommissioningStatus").val(value);
        });

//      SFS 2 Year Sparepart      
        $('#sfs2YearSparepartStatusRad').prop('checked',true);
        $("#contractReview\\.sfs2YearSparepartStatus").val("REQUIRED");
        
        $('input[name="sfs2YearSparepartStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.sfs2YearSparepartStatus").val(value);
        });
        
        $('input[name="sfs2YearSparepartStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.sfs2YearSparepartStatus").val(value);
        });
        
//      SFS SpecialTools     
        $('#sfsSpecialToolsStatusRad').prop('checked',true);
        $("#contractReview\\.sfsSpecialToolsStatus").val("REQUIRED");
        
        $('input[name="sfsSpecialToolsStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.sfsSpecialToolsStatus").val(value);
        });
        
        $('input[name="sfsSpecialToolsStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.sfsSpecialToolsStatus").val(value);
        });

//      SFS Packing        
        $('#sfsPackingStatusRad').prop('checked',true);
        $("#contractReview\\.sfsPackingStatus").val("REQUIRED");
        
        $('input[name="sfsPackingStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.sfsPackingStatus").val(value);
        });
        
        $('input[name="sfsPackingStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.sfsPackingStatus").val(value);
        });

//      SFS Painting        
        $('#sfsPaintingStatusRad').prop('checked',true);
        $("#contractReview\\.sfsPaintingStatus").val("REQUIRED");
        
        $('input[name="sfsPaintingStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.sfsPaintingStatus").val(value);
        });
        
        $('input[name="sfsPaintingStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.sfsPaintingStatus").val(value);
        });
      
        $('input[name="sfsPaintingStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.sfsPaintingStatus").val(value);
        });
       
//      DCAS Pressure TestHydro        
        $('#dcasPressureTestHydroStatusRad').prop('checked',true);
        $("#contractReview\\.dcasPressureTestHydroStatus").val("REQUIRED");
        
        $('input[name="dcasPressureTestHydroStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasPressureTestHydroStatus").val(value);
        });
        
        $('input[name="dcasPressureTestHydroStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasPressureTestHydroStatus").val(value);
        });
      
        $('input[name="dcasPressureTestHydroStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.dcasPressureTestHydroStatus").val(value);
        });

//      DCAS Pressure Test Gas        
        $('#dcasPressureTestGasStatusRad').prop('checked',true);
        $("#contractReview\\.dcasPressureTestGasStatus").val("REQUIRED");
        
        $('input[name="dcasPressureTestGasStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasPressureTestGasStatus").val(value);
        });
        
        $('input[name="dcasPressureTestGasStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasPressureTestGasStatus").val(value);
        });
      
        $('input[name="dcasPressureTestGasStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.dcasPressureTestGasStatus").val(value);
        });

//      DCAS PMI        
        $('#dcasPmiStatusRad').prop('checked',true);
        $("#contractReview\\.dcasPmiStatus").val("REQUIRED");
        
        $('input[name="dcasPmiStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasPmiStatus").val(value);
        });
        
        $('input[name="dcasPmiStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasPmiStatus").val(value);
        });
      
        $('input[name="dcasPmiStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.dcasPmiStatus").val(value);
        });

//      DCAS Witness        
        $('#dcasWitnessStatusRad').prop('checked',true);
        $("#contractReview\\.dcasWitnessStatus").val("REQUIRED");
        
        $('input[name="dcasWitnessStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasWitnessStatus").val(value);
        });
        
        $('input[name="dcasWitnessStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasWitnessStatus").val(value);
        });
      
        $('input[name="dcasWitnessStatusRad"][value="AS_PER_APPROVED_ITP"]').change(function(ev){
            var value="AS_PER_APPROVED_ITP";
            $("#contractReview\\.dcasWitnessStatus").val(value);
        });
        
//      DCAS Hyperbaric Test    
        $('#dcasHyperbaricTestStatusRad').prop('checked',true);
        $("#contractReview\\.dcasHyperbaricTestStatus").val("REQUIRED");
        
        $('input[name="dcasHyperbaricTestStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasHyperbaricTestStatus").val(value);
        });
        
        $('input[name="dcasHyperbaricTestStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasHyperbaricTestStatus").val(value);
        });
      
        $('input[name="dcasHyperbaricTestStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.dcasHyperbaricTestStatus").val(value);
        });
      
//      DCAS AntiStatic      
        $('#dcasAntiStaticTestStatusRad').prop('checked',true);
        $("#contractReview\\.dcasAntiStaticTestStatus").val("REQUIRED");
        
        $('input[name="dcasAntiStaticTestStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasAntiStaticTestStatus").val(value);
        });
        
        $('input[name="dcasAntiStaticTestStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasAntiStaticTestStatus").val(value);
        });
      
        $('input[name="dcasAntiStaticTestStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.dcasAntiStaticTestStatus").val(value);
        });
      
//      DCAS Torque      
        $('#dcasTorqueTestStatusRad').prop('checked',true);
        $("#contractReview\\.dcasTorqueTestStatus").val("REQUIRED");
        
        $('input[name="dcasTorqueTestStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasTorqueTestStatus").val(value);
        });
        
        $('input[name="dcasTorqueTestStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasTorqueTestStatus").val(value);
        });
      
        $('input[name="dcasTorqueTestStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.dcasTorqueTestStatus").val(value);
        });
      
//      DCAS DIB DBB      
        $('#dcasDibDbbTestStatusRad').prop('checked',true);
        $("#contractReview\\.dcasDibDbbTestStatus").val("REQUIRED");
        
        $('input[name="dcasDibDbbTestStatusRad"][value="REQUIRED"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.dcasDibDbbTestStatus").val(value);
        });
        
        $('input[name="dcasDibDbbTestStatusRad"][value="NOT_REQUIRED"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.dcasDibDbbTestStatus").val(value);
        });
      
        $('input[name="dcasDibDbbTestStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.dcasDibDbbTestStatus").val(value);
        });
      
//      CAD Pressure Containing Parts      
        $('#cadPressureContainingPartsStatusRad').prop('checked',true);
        $("#contractReview\\.cadPressureContainingPartsStatus").val("TYPE_3.2");
        
        $('input[name="cadPressureContainingPartsStatusRad"][value="TYPE_3.2"]').change(function(ev){
            var value="TYPE_3.2";
            $("#contractReview\\.cadPressureContainingPartsStatus").val(value);
        });
        
        $('input[name="cadPressureContainingPartsStatusRad"][value="TYPE_3.1"]').change(function(ev){
            var value="TYPE_3.1";
            $("#contractReview\\.cadPressureContainingPartsStatus").val(value);
        });
      
        $('input[name="cadPressureContainingPartsStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.cadPressureContainingPartsStatus").val(value);
        });
        
//      CAD Pressure Controlling
        $('#cadPressureControllingPartsStatusRad').prop('checked',true);
        $("#contractReview\\.cadPressureControllingPartsStatus").val("TYPE_3.2");
        
        $('input[name="cadPressureControllingPartsStatusRad"][value="TYPE_3.2"]').change(function(ev){
            var value="TYPE_3.2";
            $("#contractReview\\.cadPressureControllingPartsStatus").val(value);
        });
        
        $('input[name="cadPressureControllingPartsStatusRad"][value="TYPE_3.1"]').change(function(ev){
            var value="TYPE_3.1";
            $("#contractReview\\.cadPressureControllingPartsStatus").val(value);
        });
      
        $('input[name="cadPressureControllingPartsStatusRad"][value="TYPE_2.2"]').change(function(ev){
            var value="TYPE_2.2";
            $("#contractReview\\.cadPressureControllingPartsStatus").val(value);
        });
      
        $('input[name="cadPressureControllingPartsStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.cadPressureControllingPartsStatus").val(value);
        });
        
//      CAD Non Pressure Controlling Parts      
        $('#cadNonPressureControllingPartsStatusRad').prop('checked',true);
        $("#contractReview\\.cadNonPressureControllingPartsStatus").val("TYPE_2.2");
        
        $('input[name="cadNonPressureControllingPartsStatusRad"][value="TYPE_2.2"]').change(function(ev){
            var value="REQUIRED";
            $("#contractReview\\.cadNonPressureControllingPartsStatus").val(value);
        });
        
        $('input[name="cadNonPressureControllingPartsStatusRad"][value="TYPE_2.1"]').change(function(ev){
            var value="NOT_REQUIRED";
            $("#contractReview\\.cadNonPressureControllingPartsStatus").val(value);
        });
      
        $('input[name="cadNonPressureControllingPartsStatusRad"][value="OTHER"]').change(function(ev){
            var value="OTHER";
            $("#contractReview\\.cadNonPressureControllingPartsStatus").val(value);
        });
      
//      TN Actuator     
        $('#tnActuatorStatusRad').prop('checked',true);
        $("#contractReview\\.tnActuatorStatus").val("YES");
        
        $('input[name="tnActuatorStatusRad"][value="YES"]').change(function(ev){
            var value="YES";
            $("#contractReview\\.tnActuatorStatus").val(value);
        });
        
        $('input[name="tnActuatorStatusRad"][value="NO"]').change(function(ev){
            var value="NO";
            $("#contractReview\\.tnActuatorStatus").val(value);
        });
      
//      TN Limitaiton     
        $('#tnLimitationOriginStatusRad').prop('checked',true);
        $("#contractReview\\.tnLimitationOriginStatus").val("YES");
        
        $('input[name="tnLimitationOriginStatusRad"][value="YES"]').change(function(ev){
            var value="YES";
            $("#contractReview\\.tnLimitationOriginStatus").val(value);
        });
        
        $('input[name="tnLimitationOriginStatusRad"][value="NO"]').change(function(ev){
            var value="NO";
            $("#contractReview\\.tnLimitationOriginStatus").val(value);
        });
    
        $('#tnApprovalManufacturedListStatusRad').prop('checked',true);
        $("#contractReview\\.tnApprovalManufacturedListStatus").val("YES");
        
        $('input[name="tnApprovalManufacturedListStatusRad"][value="YES"]').change(function(ev){
            var value="YES";
            $("#contractReview\\.tnApprovalManufacturedListStatus").val(value);
        });
        
        $('input[name="tnApprovalManufacturedListStatusRad"][value="NO"]').change(function(ev){
            var value="NO";
            $("#contractReview\\.tnApprovalManufacturedListStatus").val(value);
        });
    
      
      $("#btnContractReviewNew").click(function (ev) {
           
            var url = "sales/contract-review-input";
            var params = "enumContractReviewActivity=NEW";

            pageLoad(url, params, "#tabmnuCONTRACT_REVIEW"); 
            ev.preventDefault();
        });
        
        $('#btnContractReviewUpdate').click(function(ev) {

                var selectRowId = $("#contractReview_grid").jqGrid('getGridParam','selrow');
                var contractReview = $("#contractReview_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url = "sales/contract-review-input";
                var params = "enumContractReviewActivity=UPDATE";
                params+="&contractReview.code=" + contractReview.code;
                pageLoad(url, params, "#tabmnuCONTRACT_REVIEW");

        });
        
        $('#btnContractReviewRevise').click(function(ev) {
            var selectRowId = $("#contractReview_grid").jqGrid('getGridParam','selrow');
            var contractReview = $("#contractReview_grid").jqGrid("getRowData", selectRowId);
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "sales/contract-review-input";
            var params = "enumContractReviewActivity=REVISE";
                params+="&contractReview.code=" + contractReview.code;
                pageLoad(url, params, "#tabmnuCONTRACT_REVIEW");
        });
        
        $('#btnContractReviewDelete').click(function(ev) {
            
            var deleteRowId = $("#contractReview_grid").jqGrid('getGridParam','selrow');

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var contractReview = $("#contractReview_grid").jqGrid('getRowData', deleteRowId);
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PCO No: '+contractReview.code+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title : "Confirmation!",
                closeOnEscape: false,
                modal : true,
                width: 300,
                resizable: false,
                buttons : 
                    [{
                        text : "Yes",
                        click : function() {
                            var url = "sales/contract-review-delete";
                            var params = "contractReview.code=" + contractReview.code;
                            $.post(url, params, function(data) {
                                if (data.error) {
                                    alertMessage(data.errorMessage);
                                    return;
                                }
                                reloadGridCR();
                                reloadDetailGridCR();
                            });  
                            $(this).dialog("close");
                        }
                    },
                    {
                        text : "No",
                        click : function() {
                            $(this).dialog("close");                                       
                        }
                    }]
            });
            ev.preventDefault();
        });
        
        
        
        $('#btnContractReviewRefresh').click(function(ev) {
            var url = "sales/contract-review";
            var params = "";
            pageLoad(url, params, "#tabmnuCONTRACT_REVIEW");
            ev.preventDefault();   
        });
        
       $('#btnContractReview_search').click(function(ev) {
            formatDateCR();
            $("#contractReview_grid").jqGrid("clearGridData");
            $("#contractReview_grid").jqGrid("setGridParam",{url:"sales/contract-review-data?" + $("#frmContractReviewSearchInput").serialize()});
            $("#contractReview_grid").trigger("reloadGrid");
            
            $("#contractReviewValveType_grid").jqGrid("clearGridData");
            $("#contractReviewValveType_grid").jqGrid("setCaption", "Valve Type");
            
            $("#contractReviewDcasDesign_grid").jqGrid("clearGridData");
            $("#contractReviewDcasDesign_grid").jqGrid("setCaption", "Design");
            
            $("#contractReviewDcasFireSafeByDesign_grid").jqGrid("clearGridData");
            $("#contractReviewDcasFireSafeByDesign_grid").jqGrid("setCaption", "Fire Safe By Design");
            
            $("#contractReviewDcasTesting_grid").jqGrid("clearGridData");
            $("#contractReviewDcasTesting_grid").jqGrid("setCaption", "Testing");
            
            $("#contractReviewDcasHydroTest_grid").jqGrid("clearGridData");
            $("#contractReviewDcasHydroTest_grid").jqGrid("setCaption", "Hydro Test");
            
            $("#contractReviewDcasVisualExamination_grid").jqGrid("clearGridData");
            $("#contractReviewDcasVisualExamination_grid").jqGrid("setCaption", "Visual Examination");
            
            $("#contractReviewDcasNde_grid").jqGrid("clearGridData");
            $("#contractReviewDcasNde_grid").jqGrid("setCaption", "NDE");
            
            $("#contractReviewDcasMarking_grid").jqGrid("clearGridData");
            $("#contractReviewDcasMarking_grid").jqGrid("setCaption", "Marking");
            
            $("#contractReviewDcasLegalRequirements_grid").jqGrid("clearGridData");
            $("#contractReviewDcasLegalRequirements_grid").jqGrid("setCaption", "Legal Requirements");
            
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("clearGridData");
            $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("setCaption", "Description");
            formatDateCR();
            ev.preventDefault();
           
        });  
  });
  
   function formatDateCR(){
        var firstDate=$("#contractReviewSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#contractReviewSearchFirstDate").val(firstDateValue);

        var lastDate=$("#contractReviewSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#contractReviewSearchLastDate").val(lastDateValue);
        
    }
    
    function reloadGridCR() {
        $("#contractReview_grid").trigger("reloadGrid");
    };
    
    function reloadDetailGridCR() {
        $("#contractReviewValveType_grid").trigger("reloadGrid");  
        $("#contractReviewValveType_grid").jqGrid("clearGridData");
        $("#contractReviewValveType_grid").jqGrid("setCaption", "Valve Type");
        
        $("#contractReviewDcasDesign_grid").trigger("reloadGrid");  
        $("#contractReviewDcasDesign_grid").jqGrid("clearGridData");
        $("#contractReviewDcasDesign_grid").jqGrid("setCaption", "Design");
        
        $("#contractReviewDcasFireSafeByDesign_grid").trigger("reloadGrid");  
        $("#contractReviewDcasFireSafeByDesign_grid").jqGrid("clearGridData");
        $("#contractReviewDcasFireSafeByDesign_grid").jqGrid("setCaption", "Fire Safe Design");
        
        $("#contractReviewDcasTesting_grid").trigger("reloadGrid");  
        $("#contractReviewDcasTesting_grid").jqGrid("clearGridData");
        $("#contractReviewDcasTesting_grid").jqGrid("setCaption", "Testing");
        
        $("#contractReviewDcasHydroTest_grid").trigger("reloadGrid");  
        $("#contractReviewDcasHydroTest_grid").jqGrid("clearGridData");
        $("#contractReviewDcasHydroTest_grid").jqGrid("setCaption", "Hydro Test");
        
        $("#contractReviewDcasVisualExamination_grid").trigger("reloadGrid");  
        $("#contractReviewDcasVisualExamination_grid").jqGrid("clearGridData");
        $("#contractReviewDcasVisualExamination_grid").jqGrid("setCaption", "Visual Examination");
        
        $("#contractReviewDcasNde_grid").trigger("reloadGrid");  
        $("#contractReviewDcasNde_grid").jqGrid("clearGridData");
        $("#contractReviewDcasNde_grid").jqGrid("setCaption", "NDE");
        
        $("#contractReviewDcasMarking_grid").trigger("reloadGrid");  
        $("#contractReviewDcasMarking_grid").jqGrid("clearGridData");
        $("#contractReviewDcasMarking_grid").jqGrid("setCaption", "Marking");
        
        $("#contractReviewDcasLegalRequirements_grid").trigger("reloadGrid");  
        $("#contractReviewDcasLegalRequirements_grid").jqGrid("clearGridData");
        $("#contractReviewDcasLegalRequirements_grid").jqGrid("setCaption", "Legal Requirements");
        
        $("#contractReviewCadDocumentApprovalInput_grid").trigger("reloadGrid");  
        $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("clearGridData");
        $("#contractReviewCadDocumentApprovalInput_grid").jqGrid("setCaption", "Description");
    };
</script>

<s:url id="remoteurlContractReview" action="contract-review-json" />
<b>CONTRACT REVIEW</b>
<hr>
<br class="spacer"/>


<sj:div id="contractReviewButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnContractReviewNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnContractReviewUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnContractReviewRevise" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Revise"/><br/>Revise</a>
            </td>
            <td><a href="#" id="btnContractReviewDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnContractReviewRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnContractReviewPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>
<!--            <td><a href="#" id="btnContractReviewForm" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Form"/><br/>Form Checklist</a>
            </td>-->
        </tr>
        
    </table>
</sj:div>      
    
<div id="ContractReviewSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmContractReviewSearchInput">
        <table>
            <tr>
                <td align="right" valign="center">Period *</td>
                <td>
                    <sj:datepicker id="contractReviewSearchFirstDate" name="contractReviewSearchFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    Up To *
                    <sj:datepicker id="contractReviewSearchLastDate" name="contractReviewSearchLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right" valign="center" >CTR-REV No</td>
                <td>
                    <s:textfield id="contractReviewSearchCode" name="contractReviewSearchCode" size="20" placeHolder="Code"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="center" >Customer Code</td>
                <td>
                    <s:textfield id="contractReviewCustomerSearchCode" name="contractReviewCustomerSearchCode" size="20" placeHolder="Customer Code"></s:textfield>
                    <s:textfield id="contractReviewCustomerSearchName" name="contractReviewCustomerSearchName" size="20" placeHolder="Customer Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Valid Status</td>
                <td>
                    <s:radio id="contractReviewSearchValidStatusRad" name="contractReviewSearchValidStatusRad" label="contractReviewSearchValidStatusRad" list="{'ALL','YES','NO'}"></s:radio>
                    <s:textfield id="contractReviewSearchValidStatus" name="contractReviewSearchValidStatus" size="20" style="display:none" ></s:textfield>
                </td>
            </tr>
        </table>
                <br/>
                    <sj:a href="#" id="btnContractReview_search" button="true">Search</sj:a>
                <br/>
    </s:form>
</div>   
<div id="contractReviewAll">   
    <br class="spacer"/>
    <table>
        <tr>
            <td>
                <sjg:grid
                    id="contractReview_grid"
                    caption="Contract Review"
                    dataType="json"   
                    href="%{remoteurlContractReview}"
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listContractReviewTemp"
                    rowList="10,20,30"
                    rowNum="10"
                    sortable="true"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuCONTRACT_REVIEW').width()"
                    onSelectRowTopics="contractReview_grid_onSelect"
                    >
                   <sjg:gridColumn
                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="code" index="code" key="code" title="CTR-REV No" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="transactionDate" index="transactionDate" key="transactionDate" 
                        title="Transaction Date" width="130" formatter="date"  
                        formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s' }"  sortable="true" 
                    />
                   <sjg:gridColumn
                        name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="customerName" index="customerName" key="customerName" title="Customer Name" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="salesPersonCode" index="salesPersonCode" key="salesPersonCode" title="Sales Person Code" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="salesPersonName" index="salesPersonName" key="salesPersonName" title="Sales Person Name" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="customerPurchaseOrderCode" index="customerPurchaseOrderCode" key="customerPurchaseOrderCode" title="POC No" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="customerPurchaseOrderNo" index="customerPurchaseOrderNo" key="customerPurchaseOrderNo" title="Customer PO No" width="130" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="sfsSparepartCommissioningStatus" index="sfsSparepartCommissioningStatus" key="sfsSparepartCommissioningStatus" title="" width="130" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="sfs2YearSparepartStatus" index="sfs2YearSparepartStatus" key="sfs2YearSparepartStatus" title="" width="130" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="sfsSpecialToolsStatus" index="sfsSpecialToolsStatus" key="sfsSpecialToolsStatus" title="" width="130" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="sfsPackingStatus" index="sfsPackingStatus" key="sfsPackingStatus" title="" width="130" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="sfsPaintingStatus" index="sfsPaintingStatus" key="sfsPaintingStatus" title="" width="130" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="sfsPaintingSpec" index="sfsPaintingSpec" key="sfsPaintingSpec" title="sfsPaintingSpec" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="sfsNote" index="sfsNote" key="sfsNote" title="sfsNote" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasPressureTestHydroStatus" index="dcasPressureTestHydroStatus" key="dcasPressureTestHydroStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasPressureTestHydroStatusRemark" index="dcasPressureTestHydroStatusRemark" key="dcasPressureTestHydroStatusRemark" title="" width="130" sortable="true" hidden ="false"
                    />
                   <sjg:gridColumn
                        name="dcasPressureTestGasStatus" index="dcasPressureTestGasStatus" key="dcasPressureTestGasStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasPressureTestGasStatusRemark" index="dcasPressureTestGasStatusRemark" key="dcasPressureTestGasStatusRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasPmiStatus" index="dcasPmiStatus" key="dcasPmiStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasPmiStatusRemark" index="dcasPmiStatusRemark" key="dcasPmiStatusRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasWitnessStatus" index="dcasWitnessStatus" key="dcasWitnessStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasWitnessStatusRemark" index="dcasWitnessStatusRemark" key="dcasWitnessStatusRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasHyperbaricTestStatus" index="dcasHyperbaricTestStatus" key="dcasHyperbaricTestStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasHyperbaricTestStatusRemark" index="dcasHyperbaricTestStatusRemark" key="dcasHyperbaricTestStatusRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasAntiStaticTestStatus" index="dcasAntiStaticTestStatus" key="dcasAntiStaticTestStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasAntiStaticTestStatusRemark" index="dcasAntiStaticTestStatusRemark" key="dcasAntiStaticTestStatusRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasTorqueTestStatus" index="dcasTorqueTestStatus" key="dcasTorqueTestStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasTorqueTestStatusRemark" index="dcasTorqueTestStatusRemark" key="dcasTorqueTestStatusRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasDibDbbTestStatus" index="dcasDibDbbTestStatus" key="dcasDibDbbTestStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasDibDbbTestStatusRemark" index="dcasDibDbbTestStatusRemark" key="dcasDibDbbTestStatusRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasDesignOther" index="dcasDesignOther" key="dcasDesignOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasFireSafebyDesignOther" index="dcasFireSafebyDesignOther" key="dcasFireSafebyDesignOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasTestingOther" index="dcasTestingOther" key="dcasTestingOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasHydroTestOther" index="dcasHydroTestOther" key="dcasHydroTestOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasVisualExaminationOther" index="dcasVisualExaminationOther" key="dcasVisualExaminationOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasNdeOther" index="dcasNdeOther" key="dcasNdeOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasMarkingOther" index="dcasMarkingOther" key="dcasMarkingOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="dcasRequirementOther" index="dcasRequirementOther" key="dcasRequirementOther" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadPressureContainingPartsStatus" index="cadPressureContainingPartsStatus" key="cadPressureContainingPartsStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadPressureControllingPartsStatus" index="cadPressureControllingPartsStatus" key="cadPressureControllingPartsStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadNonPressureControllingPartsStatus" index="cadNonPressureControllingPartsStatus" key="cadNonPressureControllingPartsStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadPressureContainingPartsRemark" index="cadPressureContainingPartsRemark" key="cadPressureContainingPartsRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadPressureControllingPartsRemark" index="cadPressureControllingPartsRemark" key="cadPressureControllingPartsRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadNonPressureControllingPartsRemark" index="cadNonPressureControllingPartsRemark" key="cadNonPressureControllingPartsRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadActuator" index="cadActuator" key="cadActuator" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadNote1" index="cadNote1" key="cadNote1" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadNote2" index="cadNote2" key="cadNote2" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="cadDocumentationForApprovalNote" index="cadDocumentationForApprovalNote" key="cadDocumentationForApprovalNote" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnActuatorStatus" index="tnActuatorStatus" key="tnActuatorStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnLimitationOriginStatus" index="tnLimitationOriginStatus" key="tnLimitationOriginStatus" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnApprovalManufacturedListStatus" index="tnApprovalManufacturedListStatusRad" key="tnApprovalManufacturedListStatusRad" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnBrandCode" index="tnBrandCode" key="tnBrandCode" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnBrandName" index="tnBrandName" key="tnBrandName" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnLimitationOriginRemark" index="tnLimitationOriginRemark" key="tnLimitationOriginRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnApprovalManufacturedListRemark" index="tnApprovalManufacturedListRemark" key="tnApprovalManufacturedListRemark" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnBom" index="tnBom" key="tnBom" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnPr" index="tnPr" key="tnPr" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnPOAndArrivalMat" index="tnPOAndArrivalMat" key="tnPOAndArrivalMat" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnMatchAssTest" index="tnMatchAssTest" key="tnMatchAssTest" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnPainting" index="tnPainting" key="tnPainting" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnPackingAndDocumentation" index="tnPackingAndDocumentation" key="tnPackingAndDocumentation" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnEstimationIssueDocumentsApproval" index="tnEstimationIssueDocumentsApproval" key="tnEstimationIssueDocumentsApproval" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="tnNote" index="tnNote" key="tnNote" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="additionalNote" index="additionalNote" key="additionalNote" title="" width="130" sortable="true" hidden ="true"
                    />
                   <sjg:gridColumn
                        name="conclusionNote" index="conclusionNote" key="conclusionNote" title="" width="130" sortable="true" hidden ="true"
                    />
                </sjg:grid>
            </td>
        </tr>
    <tr>
            <td>
            <br><br>
            <center><b>SCOPE FOR SUPPLY</b></center>
            <br><br>
            </td>
    </tr>

        <tr>
            <td>
                <sjg:grid
                    id="contractReviewValveType_grid"
                    caption="VALVE TYPE"
                    dataType="json"
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listContractReviewValveType"
                    rowList="10,20,30"
                    rowNum="10"
                    viewrecords="true"
                    rownumbers="true"
                    >
                    <sjg:gridColumn
                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="valveTypeCode" index="valveTypeCode" key="valveTypeCode" title="Valve Type" width="60" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="valveTypeName" index="valveTypeName" key="valveTypeName" title="Valve Type Name"  width="130" sortable="true" 
                    />
                </sjg:grid>
            </td>
        </tr>
    </table>     

    <br><br>
    <table>
        <tr>
            <td align="right"><B>Spare Parts Commissioning</B></td>
            <td colspan="2">
                    <s:radio id="sfsSparepartCommissioningStatusRad" name="sfsSparepartCommissioningStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" value="REQUIRED" disabled="true"></s:radio>
                    <s:textfield id="sfsSparepartCommissioningStatus" name="sfsSparepartCommissioningStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                    <s:textfield id="sfsSparepartCommissioningFilePath" name="sfsSparepartCommissioningFilePath" readonly="true" size="20"></s:textfield>
            </td>                    
        </tr>
        <tr>
            <td align="right"><B>2 Year Spare Parts</B></td>
            <td colspan="2">
                    <s:radio id="sfs2YearSparepartStatusRad" name="sfs2YearSparepartStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" value="REQUIRED" disabled="true"></s:radio>
                    <s:textfield id="sfs2YearSparepartStatus" name="sfs2YearSparepartStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                    <s:textfield id="sfs2YearSparepartFilePath" name="sfs2YearSparepartFilePath" readonly="true" size="20"></s:textfield>
            </td>                    
       </tr>
        <tr>
            <td align="right"><B>Special Tools</B></td>
            <td colspan="2">
                    <s:radio id="sfsSpecialToolsStatusRad" name="sfsSpecialToolsStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" value="REQUIRED" disabled="true"></s:radio>
                    <s:textfield id="sfsSpecialToolsStatus" name="sfsSpecialToolsStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                    <s:textfield id="sfsSpecialToolsStatusFilePath" name="sfsSpecialToolsStatusFilePath" readonly="true" size="20"></s:textfield>
            </td>                    
        </tr>
        <tr>
            <td align="right"><B>Packing</B></td>
            <td colspan="2">
                    <s:radio id="sfsPackingStatusRad" name="sfsPackingStatusRad" list="{'REQUIRED','NOT_REQUIRED'}" value="REQUIRED" disabled="true"></s:radio>
                    <s:textfield id="sfsPackingStatus" name="sfsPackingStatus" readonly="false" size="5" style="display:none" ></s:textfield>
            </td>                 
        </tr>
        <tr>
            <td align="right"><B>Painting</B></td>
            <td colspan="2">
                    <s:radio id="sfsPaintingStatusRad" name="sfsPaintingStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                    <s:textfield id="sfsPaintingStatus" name="sfsPaintingStatus" readonly="false" size="5" style="display:none" ></s:textfield>
            </td>                 
        </tr>
        <tr>
            <td align="right"><B>Painting Spec</B></td>
            <td colspan="2">
                    <s:textfield id="sfsPaintingSpec" name="sfsPaintingSpec" readonly="true" size="20" ></s:textfield>
            </td>                 
        </tr>
        <tr>
            <td align="right"><B>Notes</B></td>
            <td colspan="2">
                    <s:textfield id="sfsNote" name="sfsNote" readonly="true" size="20" ></s:textfield>
            </td>                 
       </tr>
    </table>
<br><br>

<hr>
<center><b>DESIGN, CODE, APPLICABLE STANDARDS</b></center>
<br><br>
        
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <div id="contractReviewDcasDesignInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasDesign_grid"
                                    caption="DCAS Design"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASDesign"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasDesignCode" index="dcasDesignCode" key="dcasDesignCode" title="Design Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasDesignName" index="dcasDesignName" key="dcasDesignName" title="Design Name"  width="130" sortable="true" 
                                    />
                                </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasDesignOther" name="dcasDesignOther" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <div id="contractReviewDcasFireSafeByDesignInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasFireSafeByDesign_grid"
                                    caption="DCAS Fire Safe By Design"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASFireSafeByDesign"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasFireSafeByDesignCode" index="dcasFireSafeByDesignCode" key="dcasFireSafeByDesignCode" title="Fire Safe by Design Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasFireSafeByDesignName" index="dcasFireSafeByDesignName" key="dcasFireSafeByDesignName" title="Fire Safe by Design Name" width="130" sortable="true" 
                                    />
                                </sjg:grid >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasFireSafebyDesignOther" name="dcasFireSafebyDesignOther" size="40" readonly="true"></s:textfield>
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
                            <div id="contractReviewDcasTestingInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasTesting_grid"
                                    caption="DCAS Testing"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASTesting"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasTestingCode" index="dcasTestingCode" key="dcasTestingCode" title="Testing Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasTestingName" index="dcasTestingName" key="dcasTestingName" title="Testing Name" width="130"  sortable="true" 
                                    />
                                </sjg:grid>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasTestingOther" name="dcasTestingOther" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                </table>      
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <div id="contractReviewDcasHydroTestInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasHydroTest_grid"
                                    caption="DCAS Hydro Test"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASHydroTest"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasHydroTestCode" index="dcasHydroTestCode" key="dcasHydroTestCode" title="Hydro Test Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasHydroTestName" index="dcasHydroTestName" key="dcasHydroTestName" title="Hydro Test Name"  width="130" sortable="true" 
                                    />
                                </sjg:grid>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasHydroTestOther" name="dcasHydroTestOther" size="40" readonly="true"></s:textfield>
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
                            <div id="contractReviewDcasVisualExaminationGrid">
                                <sjg:grid
                                    id="contractReviewDcasVisualExamination_grid"
                                    caption="DCAS Visual Examination"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASVisualExamination"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasVisualExaminationCode" index="dcasVisualExaminationCode" key="dcasVisualExaminationCode" title="Visual Examination Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasVisualExaminationName" index="dcasVisualExaminationName" key="dcasVisualExaminationName" title="Visual Examination Name" width="130" sortable="true" 
                                    />
                                </sjg:grid>
                            </div>    
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasVisualExaminationOther" name="dcasVisualExaminationOther" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <div id="contractReviewDcasNdeInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasNde_grid"
                                    caption="DCAS Nde"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASNde"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasNdeCode" index="dcasNdeCode" key="dcasNdeCode" title="Nde Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasNdeName" index="dcasNdeName" key="dcasNdeName" title="Nde Name" width="130" sortable="true" 
                                    />
                                </sjg:grid>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasNdeOther" name="dcasNdeOther" size="40" readonly="true"></s:textfield>
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
                            <div id="contractReviewDcasMarkingInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasMarking_grid"
                                    caption="DCAS Marking"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASMarking"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasMarkingCode" index="dcasMarkingCode" key="dcasMarkingCode" title="Marking Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasMarkingName" index="dcasMarkingName" key="dcasMarkingName" title="Marking Name" width="130" sortable="true" 
                                    />
                                </sjg:grid>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasMarkingOther" name="dcasMarkingOther" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <div id="contractReviewDcasLegalRequirementsInputGrid">
                                <sjg:grid
                                    id="contractReviewDcasLegalRequirements_grid"
                                    caption="DCAS Legal Requirements"
                                    dataType="json"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listContractReviewDCASLegalRequirements"
                                    rowList="10,20,30"
                                    rowNum="10"
                                    viewrecords="true"
                                    rownumbers="true"
                                    >
                                    <sjg:gridColumn
                                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                    />
                                   <sjg:gridColumn
                                        name="dcasLegalRequirementsCode" index="dcasLegalRequirementsCode" key="dcasLegalRequirementsCode" title="Legal Requirements Code" width="130" sortable="true" 
                                    />
                                   <sjg:gridColumn
                                        name="dcasLegalRequirementsName" index="dcasLegalRequirementsName" key="dcasLegalRequirementsName" title="Legal Requirements Name" width="130" sortable="true" 
                                    />
                                </sjg:grid>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="dcasRequirementOther" name="dcasRequirementOther" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                </table>
                <br/>        
            </td>
        </tr>
    </table> 
    <table>  
        <tr>
            <td align="right"><B>Pressure Test (Hydro)</B></td>
            <td>
                <s:radio id="dcasPressureTestHydroStatusRad" name="dcasPressureTestHydroStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasPressureTestHydroStatus" name="dcasPressureTestHydroStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="dcasPressureTestHydroStatusRemark" name="dcasPressureTestHydroStatusRemark" readonly = "true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Pressure Test (Gas)</B></td>
            <td>
                <s:radio id="dcasPressureTestGasStatusRad" name="dcasPressureTestGasStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasPressureTestGasStatus" name="dcasPressureTestGasStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="dcasPressureTestGasStatusRemark" name="dcasPressureTestGasStatusRemark" readonly = "true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>PMI </B></td>
            <td>
                <s:radio id="dcasPmiStatusRad" name="dcasPmiStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasPmiStatus" name="dcasPmiStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="dcasPmiStatusRemark" name="dcasPmiStatusRemark" readonly = "true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Witness </B></td>
            <td>
                <s:radio id="dcasWitnessStatusRad" name="dcasWitnessStatusRad" list="{'REQUIRED','NOT_REQUIRED','AS_PER_APPROVED_ITP'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasWitnessStatus" name="dcasWitnessStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;Remark
                <s:textarea id="dcasWitnessStatusRemark" name="dcasWitnessStatusRemark" readonly="true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Hyperbaric Test </B></td>
            <td>
                <s:radio id="dcasHyperbaricTestStatusRad" name="dcasHyperbaricTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasHyperbaricTestStatus" name="dcasHyperbaricTestStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="dcasHyperbaricTestStatusRemark" name="dcasHyperbaricTestStatusRemark" readonly="true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Anti Static Test</B></td>
            <td>
                <s:radio id="dcasAntiStaticTestStatusRad" name="dcasAntiStaticTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasAntiStaticTestStatus" name="dcasAntiStaticTestStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                 <s:textarea id="dcasAntiStaticTestStatusRemark" name="dcasAntiStaticTestStatusRemark" readonly = "true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Torque Test </B></td>
            <td>
                <s:radio id="dcasTorqueTestStatusRad" name="dcasTorqueTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasTorqueTestStatus" name="dcasTorqueTestStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="dcasTorqueTestStatusRemark" name="dcasTorqueTestStatusRemark" readonly="true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>DIB/DBB </B></td>
            <td>
                <s:radio id="dcasDibDbbTestStatusRad" name="dcasDibDbbTestStatusRad" list="{'REQUIRED','NOT_REQUIRED','OTHER'}" value="REQUIRED" disabled="true"></s:radio>
                <s:textfield id="dcasDibDbbTestStatus" name="dcasDibDbbTestStatus" readonly="false" size="5" style="display:none" ></s:textfield>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Remark
                <s:textarea id="dcasDibDbbTestStatusRemark" name="dcasDibDbbTestStatusRemark" readonly="true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
    </table>
        
<hr>
<center><b>CERTIFICATION AND DOCUMENTATION</b></center>
<br><br>

    <table>
        <tr>
            <td align="right"><B>Pressure Containing Parts</B></td>
            <td>
                <s:radio id="cadPressureContainingPartsStatusRad" name="cadPressureContainingPartsStatusRad" list="{'TYPE_3.2','TYPE_3.1','OTHER'}" value="TYPE_3.2" disabled="true"></s:radio> 
                <s:textfield id="cadPressureContainingPartsStatus" name="cadPressureContainingPartsStatus" readonly="false" size="5" style="display:none" ></s:textfield> 
            </td>
            <td align="right"><B>Remark</B></td>
            <td>
                <s:textarea id="cadPressureContainingPartsRemark" name="cadPressureContainingPartsRemark" readonly="true" cols="50" rows="3" ></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Pressure Controlling Parts</B></td>
            <td>
                <s:radio id="cadPressureControllingPartsStatusRad" name="cadPressureControllingPartsStatusRad" list="{'TYPE_3.2','TYPE_3.1','TYPE_2.2','OTHER'}" value="TYPE_3.2" disabled="true"></s:radio> 
                <s:textfield id="cadPressureControllingPartsStatus" name="cadPressureControllingPartsStatus" readonly="false" size="5" style="display:none" ></s:textfield> 
            </td>
            <td align="right"><B>Remark</B></td>
            <td>
                <s:textarea id="cadPressureControllingPartsRemark" name="cadPressureControllingPartsRemark" readonly="true" cols="50" rows="3" ></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Non Pressure Controlling Parts</B></td>
            <td>
                <s:radio id="cadNonPressureControllingPartsStatusRad" name="cadNonPressureControllingPartsStatusRad" list="{'TYPE_2.2','TYPE_2.1','OTHER'}" value="TYPE_2.2" disabled="true"></s:radio> 
                <s:textfield id="cadNonPressureControllingPartsStatus" name="cadNonPressureControllingPartsStatus" readonly="false" size="5" style="display:none" ></s:textfield> 
            </td>
            <td align="right"><B>Remark</B></td>
            <td>
                <s:textarea id="cadNonPressureControllingPartsRemark" name="cadNonPressureControllingPartsRemark" readonly="true" cols="50" rows="3" ></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Actuator (If Any)</B></td>
            <td>
                <s:textfield id="cadActuator" name="cadActuator" readonly="true" size="20" ></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Notes </B></td>
            <td>
                <s:textfield id="cadNote1" name="cadNote1" readonly="true" size="20" ></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Notes </B></td>
            <td>
                <s:textfield id="cadNote2" name="cadNote2" readonly="true" size="20" ></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="left"><B>Description </B></td>
            <sjg:grid
                    id="contractReviewCadDocumentApprovalInput_grid"
                    caption="CAD Document Approval"
                    dataType="json"
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listContractReviewCADDocumentApproval"
                    rowList="10,20,30"
                    rowNum="10"
                    viewrecords="true"
                    rownumbers="true"
                    >
                    <sjg:gridColumn
                        name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                    />
                   <sjg:gridColumn
                        name="cadDocumentApprovalCode" index="cadDocumentApprovalCode" key="cadDocumentApprovalCode" title="Description Code" width="130" sortable="true" 
                    />
                   <sjg:gridColumn
                        name="cadDocumentApprovalName" index="cadDocumentApprovalName" key="cadDocumentApprovalName" title="Description Name" width="130" sortable="true" 
                    />
            </sjg:grid>
        </tr>
        <br><br>
        <tr>
            <td align="right"><B>Notes </B></td>
            <td>
                <s:textfield id="cadDocumentationForApprovalNote" name="cadDocumentationForApprovalNote" readonly="true" size="20" ></s:textfield>
            </td>
        </tr>
    </table>
    <br /><br />
            
<hr>
<center><b>TECHNICAL NOTES</b></center>
<br><br>

    <table cellpadding="2" cellspacing="2" >
        <tr>
            <td align="right">Actuator </td>
            <td>
                <s:radio id="tnActuatorStatusRad" name="tnActuatorStatusRad" list="{'YES','NO'}" value="YES" disabled="true"></s:radio> 
                <s:textfield id="tnActuatorStatus" name="tnActuatorStatus" readonly="false" size="5" style="display:none" ></s:textfield> 
            </td>
            <td align="right">Brand </td>
            <td>
                <s:textfield id="tnBrandCode" name="tnBrandCode" readonly="true" size="20"></s:textfield> 
                <s:textfield id="tnBrandName" name="tnBrandName" readonly="true" size="20"></s:textfield> 
            </td>
        </tr>
        <tr>
            <td align="right">Limitation Origin </td>
            <td>
                <s:radio id="tnLimitationOriginStatusRad" name="tnLimitationOriginStatusRad" list="{'YES','NO'}" value="YES" disabled="true"></s:radio> 
                <s:textfield id="tnLimitationOriginStatus" name="tnLimitationOriginStatus" readonly="false" size="5" style="display:none" ></s:textfield> 
                <s:textfield id="tnLimitationOriginPath" name="tnLimitationOriginPath" readonly="true" size="20"></s:textfield> 
            </td>
            <td align="right">Remark</td>
            <td>
                <s:textarea id="tnLimitationOriginRemark" name="tnLimitationOriginRemark" readonly="true" cols="50" rows="3"></s:textarea>
            </td>
        </tr>
        <tr>
            <td align="right">Approved Origin</td>
            <td>
                <s:radio id="tnApprovalManufacturedListStatusRad" name="tnApprovalManufacturedListStatusRad" list="{'YES','NO'}" value="YES" disabled="true"></s:radio> 
                <s:textfield id="tnApprovalManufacturedListStatus" name="tnApprovalManufacturedListStatus" readonly="false" size="5" style="display:none" ></s:textfield> 
                <s:textfield id="tnApprovalManufacturedListPath" name="tnApprovalManufacturedListPath" readonly="true" size="20"></s:textfield> 
            </td>
            <td align="right">Remark</td>
            <td>
                <s:textarea id="tnApprovalManufacturedListRemark" name="tnApprovalManufacturedListRemark" readonly="true" cols="50" rows="3" ></s:textarea>
            </td>
        </tr>
        <tr>
            <td><B> Estimation Issue :</B></td>
        </tr>
        <tr>
            <td align="right">BOM </td>
            <td>
                <s:textfield id="tnBom" name="tnBom" readonly="true" size="7"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">PR </td>
            <td>
                <s:textfield id="tnPr" name="tnPr" readonly="true" size="7"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">PO & Arrival Mat </td>
            <td>
                <s:textfield id="tnPOAndArrivalMat" name="tnPOAndArrivalMat" readonly="true" size="7"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">Machining, Assembly, Testing </td>
            <td>
                <s:textfield id="tnMatchAssTest" name="tnMatchAssTest" readonly="true" size="7"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">Painting (If Any) </td>
            <td>
                <s:textfield id="tnPainting" name="tnPainting" readonly="true" size="7"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">Packing and Documentation </td>
            <td>
                <s:textfield id="tnPackingAndDocumentation" name="tnPackingAndDocumentation" readonly="true" size="7"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">Estimation Issue Documents Approval </td>
            <td>
                <s:textfield id="tnEstimationIssueDocumentsApproval" name="tnEstimationIssueDocumentsApproval" readonly="true" size="7"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">Notes</td>
            <td>
                 <s:textarea id="tnNote" name="tnNote" cols="80" rows="5" readonly="true"></s:textarea>
            </td>
        </tr>
    </table> 
        
<hr>
<center><b>ADDITIONAL NOTES</b></center>
<br><br>

    <table cellpadding="2" cellspacing="2" >
        <tr>
            <td>
                <s:textarea id="additionalNote" name="additionalNote" cols="80" rows="5" readonly="true" ></s:textarea>
            </td>
        </tr>  
    </table>

<hr>
<center><b>CONCLUSION</b></center>
<br><br>
    
    <table cellpadding="2" cellspacing="2" >
        <tr>
            <td>
                <s:textarea id="conclusionNote" name="conclusionNote" cols="80" rows="5" readonly="true"></s:textarea>
            </td>
        </tr>
    </table>
</div>              
