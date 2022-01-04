<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close,#customerPurchaseOrderReleaseSalesQuotationInput_grid_pager_center,
    #customerPurchaseOrderReleaseItemDetailInput_grid_pager_center,#customerPurchaseOrderReleaseAdditionalFeeInput_grid_pager_center,
    #customerPurchaseOrderReleasePaymentTermInput_grid_pager_center,#customerPurchaseOrderReleaseItemDeliveryInput_grid_pager_center{
        display: none;
    }
    
    .ui-dialog-titlebar-close{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
    
    var customerPurchaseOrderReleaseSalesQuotationLastRowId=0,customerPurchaseOrderReleaseSalesQuotation_lastSel = -1;
    var customerPurchaseOrderReleaseItemDetailLastRowId=0,customerPurchaseOrderReleaseItemDetail_lastSel = -1;
    var customerPurchaseOrderReleaseAdditionalFeeLastRowId=0,customerPurchaseOrderReleaseAdditionalFee_lastSel = -1;
    var customerPurchaseOrderReleasePaymentTermLastRowId=0,customerPurchaseOrderReleasePaymentTerm_lastSel = -1;
    var customerPurchaseOrderReleaseItemDeliveryLastRowId=0,customerPurchaseOrderReleaseItemDelivery_lastSel = -1;
    var cpoSalesQuotation_lastSel = -1;
    var 
        txtCustomerPurchaseOrderReleaseCode = $("#customerPurchaseOrderRelease\\.code"),
        dtpCustomerPurchaseOrderReleaseTransactionDate = $("#customerPurchaseOrderRelease\\.transactionDate"),
        txtCustomerPurchaseOrderReleaseBlanketOrderCode= $("#customerPurchaseOrderRelease\\.customerBlanketOrder\\.code"),
        txtCustomerPurchaseOrderReleaseCustomerPurchaseOrderCode= $("#customerPurchaseOrderRelease\\.customerBlanketOrder.\\customerPurchaseOrder.\\code"),
        txtCustomerPurchaseOrderReleaseCustomerCode= $("#customerPurchaseOrderRelease\\.customer\\.code"),
        txtCustomerPurchaseOrderReleaseCustomerName= $("#customerPurchaseOrderRelease\\.customer\\.name"),
        txtCustomerPurchaseOrderReleaseEndUserCode= $("#customerPurchaseOrderRelease\\.endUser\\.code"),
        txtCustomerPurchaseOrderReleaseEndUserName= $("#customerPurchaseOrderRelease\\.endUser\\.name"),
        txtCustomerPurchaseOrderReleaseRetention= $("#customerPurchaseOrderRelease\\.retentionPercent"),
        txtCustomerPurchaseOrderReleaseCurrencyCode= $("#customerPurchaseOrderRelease\\.currency\\.code"),
        txtCustomerPurchaseOrderReleaseCurrencyName= $("#customerPurchaseOrderRelease\\.currency\\.name"),
        txtCustomerPurchaseOrderReleaseBranchCode= $("#customerPurchaseOrderRelease\\.branch\\.code"),
        txtCustomerPurchaseOrderReleaseBranchName= $("#customerPurchaseOrderRelease\\.branch\\.name"),
        txtCustomerPurchaseOrderReleaseSalesPersonCode= $("#customerPurchaseOrderRelease\\.salesPerson\\.code"),
        txtCustomerPurchaseOrderReleaseSalesPersonName= $("#customerPurchaseOrderRelease\\.salesPerson\\.name"),
        txtCustomerPurchaseOrderReleaseProjectCode= $("#customerPurchaseOrderRelease\\.project\\.code"),
        txtCustomerPurchaseOrderReleaseProjectName= $("#customerPurchaseOrderRelease\\.project\\.name"),
        txtCustomerPurchaseOrderReleaseRefNo = $("#customerPurchaseOrderRelease\\.refNo"),
        txtCustomerPurchaseOrderReleaseRemark = $("#customerPurchaseOrderRelease\\.remark"),
        txtCustomerPurchaseOrderReleaseTotalTransactionAmount = $("#customerPurchaseOrderRelease\\.totalTransactionAmount"),
        txtCustomerPurchaseOrderReleaseDiscountPercent = $("#customerPurchaseOrderRelease\\.discountPercent"),
        txtCustomerPurchaseOrderReleaseDiscountAmount = $("#customerPurchaseOrderRelease\\.discountAmount"),
        txtCustomerPurchaseOrderReleaseTotalAdditionalFee= $("#customerPurchaseOrderRelease\\.totalAdditionalFeeAmount"),
        txtCustomerPurchaseOrderReleaseTaxBaseAmount= $("#customerPurchaseOrderRelease\\.taxBaseAmount"),
        txtCustomerPurchaseOrderReleaseVATPercent = $("#customerPurchaseOrderRelease\\.vatPercent"),
        txtCustomerPurchaseOrderReleaseVATAmount = $("#customerPurchaseOrderRelease\\.vatAmount"),
        txtCustomerPurchaseOrderReleaseGrandTotalAmount = $("#customerPurchaseOrderRelease\\.grandTotalAmount");

        function loadGridItemCPORL(){
             //function groupingHeader
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true, 
                    groupHeaders:[
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailBodyConstQuotation', numberOfColumns: 3, titleText: 'Body Const'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailTypeDesignQuotation', numberOfColumns: 3, titleText: 'Type Design'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailSeatDesignQuotation', numberOfColumns: 3, titleText: 'Seat Design'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailSizeQuotation', numberOfColumns: 3, titleText: 'Size'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailRatingQuotation', numberOfColumns: 3, titleText: 'Rating'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailBoreQuotation', numberOfColumns: 3, titleText: 'Bore'},
                          
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailEndConQuotation', numberOfColumns: 3, titleText: 'End Con'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailBodyQuotation', numberOfColumns: 3, titleText: 'Body'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailBallQuotation', numberOfColumns: 3, titleText: 'Ball'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailSeatQuotation', numberOfColumns: 3, titleText: 'Seat'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailSeatInsertQuotation', numberOfColumns: 3, titleText: 'Seat Insert'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailStemQuotation', numberOfColumns: 3, titleText: 'Stem'},
                          
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailSealQuotation', numberOfColumns: 3, titleText: 'Seal'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailBoltQuotation', numberOfColumns: 3, titleText: 'Bolt'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailDiscQuotation', numberOfColumns: 3, titleText: 'Disc'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailPlatesQuotation', numberOfColumns: 3, titleText: 'Plates'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailShaftQuotation', numberOfColumns: 3, titleText: 'Shaft'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailSpringQuotation', numberOfColumns: 3, titleText: 'Spring'},
                          
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailArmPinQuotation', numberOfColumns: 3, titleText: 'Arm Pin'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailBackSeatQuotation', numberOfColumns: 3, titleText: 'Back Seat'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailArmQuotation', numberOfColumns: 3, titleText: 'Arm'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailHingePinQuotation', numberOfColumns: 3, titleText: 'Hinge Pin'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailStopPinQuotation', numberOfColumns: 3, titleText: 'Stop Pin'},
                          {startColumnName: 'customerPurchaseOrderReleaseItemDetailOperatorQuotation', numberOfColumns: 3, titleText: 'Operator'}
                    ]
                });
        }

    $(document).ready(function() {
        flagIsConfirmedCPORL=false;
        flagIsConfirmedCPORLSalesQuotation=false;
        flagIsConfirmedCPORLItemDelivery=false;
        $("#frmCustomerPurchaseOrderReleaseInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        
        formatNumericCPORL();
        $("#msgCustomerPurchaseOrderReleaseActivity").html(" - <i>" + $("#enumCustomerPurchaseOrderReleaseActivity").val()+"<i>").show();
        setCustomerPurchaseOrderReleasePartialShipmentStatusStatus();
        
        $('input[name="customerPurchaseOrderReleasePartialShipmentStatusRad"][value="YES"]').change(function(ev){
            $("#customerPurchaseOrderRelease\\.partialShipmentStatus").val("YES");
        });
        
        $('input[name="customerPurchaseOrderReleasePartialShipmentStatusRad"][value="NO"]').change(function(ev){
            $("#customerPurchaseOrderRelease\\.partialShipmentStatus").val("NO");
        });
        
        $('input[name="customerPurchaseOrderReleaseOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#customerPurchaseOrderRelease\\.orderStatus").val(value);
        });
        
        $('#customerPurchaseOrderReleaseOrderStatusRadBLANKET_ORDER').prop('checked',true);
        $("#customerPurchaseOrderRelease\\.orderStatus").val("BLANKET_ORDER");
        
        //Set Default View
        $("#btnUnConfirmCustomerPurchaseOrderRelease").css("display", "none");
        $("#btnUnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display", "none");
        $("#btnUnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotationDetailSort").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display", "none");
        $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-payment-item-delivery-release-rl').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-item-delivery-detail-release-rl').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmCustomerPurchaseOrderRelease").click(function(ev) {
            
            if(!$("#frmCustomerPurchaseOrderReleaseInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                return;
            }
            
            var date1 = dtpCustomerPurchaseOrderReleaseTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#customerPurchaseOrderReleaseTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($('#enumCustomerPurchaseOrderReleaseActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#customerPurchaseOrderReleaseTransactionDate").val(),dtpCustomerPurchaseOrderReleaseTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpCustomerPurchaseOrderReleaseTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($('#enumCustomerPurchaseOrderReleaseActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#customerPurchaseOrderReleaseTransactionDate").val(),dtpCustomerPurchaseOrderReleaseTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpCustomerPurchaseOrderReleaseTransactionDate);
                }
                return;
            }
            
            if(parseFloat(txtCustomerPurchaseOrderReleaseRetention.val())===0.00){
                var dynamicDialog = $('<div id="conformBox">' +
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                    '</span>Retention is 0, are you sure to continue?</div>');

                dynamicDialog.dialog({
                    title        : "Confirmation!",
                    closeOnEscape: false,
                    modal        : true,
                    width        : 400,
                    resizable    : false,
                    buttons      :
                                [{
                                    text: "Yes",
                                    click: function () {
                                        $(this).dialog("close");
                                        flagIsConfirmedCPO=true;
                                        flagIsConfirmedCPOSalesQuotation=false;
                                        $("#btnUnConfirmCustomerPurchaseOrderRelease").css("display", "block");
                                        $("#btnConfirmCustomerPurchaseOrderRelease").css("display", "none");   
                                        $('#headerCustomerPurchaseOrderReleaseInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                        $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").show();
                                        $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').unblock();
                                        loadCustomerPurchaseOrderReleaseSalesQuotation();
                                    }
                                },
                                {
                                    text: "No",
                                    click: function () {
                                        $(this).dialog("close");
                                    }
                                }]
                });
            }else{
                flagIsConfirmedCPO=true;
                flagIsConfirmedCPOSalesQuotation=false;
                $("#btnUnConfirmCustomerPurchaseOrderRelease").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderRelease").css("display", "none");   
                $('#headerCustomerPurchaseOrderReleaseInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").show();
                $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').unblock();
                loadCustomerPurchaseOrderReleaseSalesQuotation();
            }           
        });
                
        $("#btnUnConfirmCustomerPurchaseOrderRelease").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){ 
                    $("#btnUnConfirmCustomerPurchaseOrderRelease").css("display", "none");
                    $("#btnConfirmCustomerPurchaseOrderRelease").css("display", "block");
                    $('#headerCustomerPurchaseOrderReleaseInput').unblock();
                    $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display","none");
                    flagIsConfirmedCPO=false;
                    flagIsConfirmedCPOSalesQuotation=false;
                    return;
                }
                
                dynamicDialog.dialog({
                    title : "Confirmation:",
                    closeOnEscape: false,
                    modal : true,
                    width: 500,
                    resizable: false,
                    buttons : 
                        [{
                            text : "Yes",
                            click : function() {
                                
                                $(this).dialog("close");
                                flagIsConfirmedCPO=false;
                                $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmCustomerPurchaseOrderRelease").css("display", "none");
                                $("#btnConfirmCustomerPurchaseOrderRelease").css("display", "block");
                                $('#headerCustomerPurchaseOrderReleaseInput').unblock();
                                $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display","none");
                                clearCustomerPurchaseOrderReleaseTransactionAmount();
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                
                                $(this).dialog("close");

                            }
                        }]
                });
        });
        
        $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").click(function(ev) {
            if(flagIsConfirmedCPO){
                
                if(customerPurchaseOrderReleaseSalesQuotation_lastSel !== -1) {
                    $('#customerPurchaseOrderReleaseSalesQuotationInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseSalesQuotation_lastSel); 
                }

                var ids = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getRowData',ids[i]); 

                    if(data.customerPurchaseOrderReleaseSalesQuotationCode===""){
                        alertMessage("Sales Quotation Can't Empty!");
                        return;
                    }
                }
            
                $("#btnUnConfirmCustomerPurchaseOrderRelease").css("display", "none");
                $("#btnUnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotationDetailSort").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display", "none");   
                $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-release-rl').unblock();
                flagIsConfirmedCPOSalesQuotation=true;
                
                if($('#enumCustomerPurchaseOrderReleaseActivity').val() === 'UPDATE'){
                    loadCustomerPurchaseOrderReleaseItemDetailUpdate();
                }else if($('#enumCustomerPurchaseOrderReleaseActivity').val() === 'REVISE'){
                    loadCustomerPurchaseOrderReleaseItemDetailRevise();
                }else if($('#enumCustomerPurchaseOrderReleaseActivity').val() === 'CLONE'){
                    loadCustomerPurchaseOrderReleaseItemDetailClone();
                }else{
                    loadCustomerPurchaseOrderReleaseItemDetail();
                }
                
                loadCustomerPurchaseOrderReleaseAdditionalFee();
                loadCustomerPurchaseOrderReleasePaymentTerm();
            }
        });
        
        $("#btnUnConfirmCustomerPurchaseOrderReleaseSalesQuotation").click(function(ev) {
            $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('destroyGroupHeader');
            $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmCustomerPurchaseOrderRelease").css("display", "block");
            $("#btnUnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotationDetailSort").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display", "block");
            $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery-release-rl').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedCPOSalesQuotation=false;
            clearCustomerPurchaseOrderReleaseTransactionAmount();
        });
        
        $("#btnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").click(function(ev) {
            if(flagIsConfirmedCPO){
                
                if(customerPurchaseOrderReleaseItemDetail_lastSel !== -1) {
                    $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDetail_lastSel); 
                }
                if(customerPurchaseOrderReleaseAdditionalFee_lastSel !== -1) {
                    $('#customerPurchaseOrderReleaseAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseAdditionalFee_lastSel); 
                }
                if(customerPurchaseOrderReleasePaymentTerm_lastSel !== -1) {
                    $('#customerPurchaseOrderReleasePaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderReleasePaymentTerm_lastSel); 
                }
                
                var ids = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                let idx = jQuery("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getDataIDs');
                let idl = jQuery("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('getDataIDs');
                let idq = jQuery("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('getDataIDs');

               for(var j=0; j<idx.length;j++){
                    var data = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',idx[j]);
                    
                    if(data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode === ""){
                        alertMessage("Item Finish Goods Code Must Be Filled!");
                        return;
                    }
                    
                    if(data.customerPurchaseOrderReleaseItemDetailSortNo===""){
                        alertMessage("Sort No Can't Empty!");
                        return;
                    }
                
                    if(data.customerPurchaseOrderReleaseItemDetailSortNo=== '0' ){
                        alertMessage("Sort No Can't Zero!");
                        return;
                    }
                
                    for(var i=j; i<=idx.length-1; i++){
                        var details = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',idx[i+1]);
                        if(data.customerPurchaseOrderReleaseItemDetailSortNo === details.customerPurchaseOrderReleaseItemDetailSortNo){
                            alertMessage("Sort No Can't Be The Same!");
                            return;
                        }
                    }

                    if(parseFloat(data.customerPurchaseOrderReleaseItemDetailQuantity)===0.00){
                        alertMessage("Quantity Item Can't be 0!");
                        return;
                    }
                }
                
                for(var l=0; l<idl.length;l++){
                    var data = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('getRowData',idl[l]);
                    
                    if(data.customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode === ""){
                        alertMessage("Additional Fee Must Be Filled!");
                        return;
                    }
                    if(parseFloat(data.customerPurchaseOrderReleaseAdditionalFeeQuantity === 0.00)){
                        alertMessage("Quantity Must Be Greater Than 0!");
                        return;
                    }
                }
                
                if(idq.length===0){
                    alertMessage("Grid Payment Term Minimal 1(one) row!");
                    return;
                }
                
                var totalPercentagePaymentTerm=0;
                for(var p=0;p < idq.length;p++){ 
                    var data = $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('getRowData',idq[p]); 

                    if(data.customerPurchaseOrderReleasePaymentTermSortNO=== '0' ){
                        alertMessage("Payment Term Sort No Can't Zero!");
                        return;
                    }

                    if(data.customerPurchaseOrderReleasePaymentTermSortNO === " "){
                        alertMessage("Payment Term Sort No Can't Empty!");
                        return;
                    }

                    if(data.customerPurchaseOrderReleasePaymentTermPaymentTermName===""){
                        alertMessage("Payment Term Can't Empty!");
                        return;
                    }

                    if(parseFloat(data.customerPurchaseOrderReleasePaymentTermPercent)===0.00){
                        alertMessage("Percent Payment term Can't be 0!");
                        return;
                    }
                    totalPercentagePaymentTerm+=parseFloat(data.customerPurchaseOrderReleasePaymentTermPercent);
                }
                if(parseFloat(totalPercentagePaymentTerm.toFixed(2))!==100){
                    alertMessage("Total Percent Payment Term must be 100%, Can't less or greater than 100%!",400);
                    return;
                }
                
                $("#btnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "none");   
                $("#btnUnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "block");  
                $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotationDetailSort").css("display", "none");
                $("#btnUnConfirmCustomerPurchaseOrderReleaseSalesQuotation").css("display", "none");
                $('#customerPurchaseOrderReleaseSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-release-rl').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-item-delivery-detail-release-rl').unblock();
                loadCustomerPurchaseOrderReleaseItemDeliveryDate();
                flagIsConfirmedCPOItemDelivery=true;
                
            }
        });
        
        $("#btnUnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").click(function(ev) {
            $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery").css("display", "block");
            $("#btnUnConfirmCustomerPurchaseOrderReleaseSalesQuotation").show();
            $("#btnConfirmCustomerPurchaseOrderReleaseSalesQuotationDetailSort").show();
            $('#id-tbl-additional-payment-item-delivery-release-rl').unblock();
            $('#id-tbl-additional-item-delivery-detail-release-rl').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedCPOItemDelivery=false;
        });
        
        $.subscribe("customerPurchaseOrderReleaseSalesQuotationInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderReleaseSalesQuotation_lastSel) {

                $('#customerPurchaseOrderReleaseSalesQuotationInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseSalesQuotation_lastSel); 
                $('#customerPurchaseOrderReleaseSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderReleaseSalesQuotation_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderReleaseSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderReleaseItemDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderReleaseItemDetail_lastSel) {

                $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDetail_lastSel); 
                $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderReleaseItemDetail_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderReleaseAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderReleaseAdditionalFee_lastSel) {

                $('#customerPurchaseOrderReleaseAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseAdditionalFee_lastSel); 
                $('#customerPurchaseOrderReleaseAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderReleaseAdditionalFee_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderReleaseAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderReleasePaymentTermInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderReleasePaymentTerm_lastSel) {

                $('#customerPurchaseOrderReleasePaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderReleasePaymentTerm_lastSel); 
                $('#customerPurchaseOrderReleasePaymentTermInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderReleasePaymentTerm_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderReleasePaymentTermInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderReleaseItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==customerPurchaseOrderReleaseItemDelivery_lastSel) {

                $('#customerPurchaseOrderReleaseItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDelivery_lastSel); 
                $('#customerPurchaseOrderReleaseItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderReleaseItemDelivery_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderReleaseItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnCustomerPurchaseOrderReleaseAdditionalFeeAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderReleaseAdditionalFeeAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerPurchaseOrderReleaseAdditionalFeeDelete                : "delete",
                    customerPurchaseOrderReleaseAdditionalFeeSearchUnitOfMeasure   : "..."
                };
                customerPurchaseOrderReleaseAdditionalFeeLastRowId++;
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseAdditionalFeeLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseAdditionalFeeLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderReleasePaymentTermAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderReleasePaymentTermAddRow").val()));
            var idp = jQuery("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('getDataIDs');
            var number = idp.length+1;
            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerPurchaseOrderReleasePaymentTermDelete                : "delete",
                    customerPurchaseOrderReleasePaymentTermSearchPaymentTerm     : "...",
                    customerPurchaseOrderReleasePaymentTermSortNO                : number
                };
                customerPurchaseOrderReleasePaymentTermLastRowId++;
                $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid("addRowData", customerPurchaseOrderReleasePaymentTermLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('setRowData',customerPurchaseOrderReleasePaymentTermLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderReleaseItemDelieryAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderReleaseItemDelieryAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerPurchaseOrderReleaseItemDeliveryDelete              : "delete",
                    customerPurchaseOrderReleaseItemDeliverySearchQuotation     : "..."
                };
                customerPurchaseOrderReleaseItemDeliveryLastRowId++;
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderReleaseCopyFromDetail').click(function(ev) {
            
            $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(customerPurchaseOrderReleaseItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDetail_lastSel); 
            }
            
            var ids = jQuery("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    customerPurchaseOrderReleaseItemDeliveryDelete                 : "delete",
                    customerPurchaseOrderReleaseItemDeliveryItemCode               : data.customerPurchaseOrderReleaseItemDetailItem,
                    customerPurchaseOrderReleaseItemDeliverySortNo                 : data.customerPurchaseOrderReleaseItemDetailSortNo,
                    customerPurchaseOrderReleaseItemDeliveryQuantity               : data.customerPurchaseOrderReleaseItemDetailQuantity,
                    customerPurchaseOrderReleaseItemDeliverySearchQuotation        : "...",
                    customerPurchaseOrderReleaseItemDeliverySalesQuotationCode     : data.customerPurchaseOrderReleaseItemDetailQuotationNo,
                    customerPurchaseOrderReleaseItemDeliverySalesQuotationRefNo    : data.customerPurchaseOrderReleaseItemDetailQuotationRefNo,
                    customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsCode    : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode,   
                    customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsRemark  : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark
                };
                customerPurchaseOrderReleaseItemDeliveryLastRowId++;
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderReleaseSave').click(function(ev) {
            
            if(!flagIsConfirmedCPOSalesQuotation){
                return;
            }
            
            if(customerPurchaseOrderReleaseItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDetail_lastSel); 
            }
            
            if(customerPurchaseOrderReleaseAdditionalFee_lastSel !== -1) {
                $('#customerPurchaseOrderReleaseAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseAdditionalFee_lastSel); 
            }
            
            if(customerPurchaseOrderReleasePaymentTerm_lastSel !== -1) {
                $('#customerPurchaseOrderReleasePaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderReleasePaymentTerm_lastSel); 
            }
            
            if(customerPurchaseOrderReleaseItemDelivery_lastSel !== -1) {
                $('#customerPurchaseOrderReleaseItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDelivery_lastSel); 
            }
            
            var listCustomerPurchaseOrderReleaseSalesQuotation = new Array(); 
            var listCustomerPurchaseOrderReleaseItemDetail = new Array(); 
            var listCustomerPurchaseOrderReleaseAdditionalFee = new Array(); 
            var listCustomerPurchaseOrderReleasePaymentTerm = new Array(); 
            var listCustomerPurchaseOrderReleaseItemDeliveryDate = new Array(); 
            
            var idq = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getDataIDs'); 
            var idi = jQuery("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getDataIDs'); 
            var idf = jQuery("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('getDataIDs'); 
            var idp = jQuery("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('getDataIDs'); 
            var idd = jQuery("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getDataIDs'); 

            if(idq.length===0){
                alertMessage("Grid Quotation Detail Can't Empty!");
                return;
            }
            
            if(idi.length===0){
                alertMessage("Grid Item Detail Can't Empty!");
                return;
            }

            //Sales Quptation
            for(var q=0;q < idq.length;q++){ 
                var data = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getRowData',idq[q]); 
                  
                var customerPurchaseOrderReleaseSalesQuotation = { 
                    salesQuotation              : {code:data.customerPurchaseOrderReleaseSalesQuotationCode}
                };
                listCustomerPurchaseOrderReleaseSalesQuotation[q] = customerPurchaseOrderReleaseSalesQuotation;
            }
            
            //Item Detail
            for(var i=0;i < idi.length;i++){ 
                var data = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',idi[i]);
//                var sortNo = [];
//                sortNo[i] = data.customerPurchaseOrderReleaseItemDetailSortNo;
                
                if(data.customerPurchaseOrderReleaseItemDetailSortNo===""){
                    alertMessage("Sort No Can't Empty!");
                    return;
                }
                
                if(data.customerPurchaseOrderReleaseItemDetailSortNo=== '0' ){
                    alertMessage("Sort No Can't Zero!");
                    return;
                }
                
                for(var j=i; j<=idi.length-1; j++){
                var details = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',idi[j+1]);
                if(data.customerPurchaseOrderReleaseItemDetailSortNo === details.customerPurchaseOrderReleaseItemDetailSortNo){
                    alertMessage("Sort No Can't Be The Same!");
                    return;
                }
                }
                
                if(parseFloat(data.customerPurchaseOrderReleaseItemDetailQuantity)===0.00){
                    alertMessage("Quantity Item Can't be 0!");
                    return;
                }

                var customerPurchaseOrderReleaseItemDetail = { 
                    salesQuotation                            : {code:data.customerPurchaseOrderReleaseItemDetailQuotationNo},
                    salesQuotationDetail                      : {code:data.customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode},
                    itemFinishGoods                           : {code:data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode},
                    quantity                                  : data.customerPurchaseOrderReleaseItemDetailQuantity,
                    customerPurchaseOrderSortNo               : data.customerPurchaseOrderReleaseItemDetailSortNo,
                    itemAlias                                 : data.customerPurchaseOrderReleaseItemDetailItemAlias,
                    valveTag                                  : data.customerPurchaseOrderReleaseItemDetailValveTag,
                    dataSheet                                 : data.customerPurchaseOrderReleaseItemDetailDataSheet,
                    description                               : data.customerPurchaseOrderReleaseItemDetailDescription
                };
                listCustomerPurchaseOrderReleaseItemDetail[i] = customerPurchaseOrderReleaseItemDetail;
            }
            
            //Additional Fee
            for(var f=0;f < idf.length;f++){ 
                var data = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('getRowData',idf[f]); 

                if(data.customerPurchaseOrderReleaseAdditionalFeeRemark===""){
                    alertMessage("Remark Additional Fee Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderReleaseAdditionalFeeQuantity)===0.00){
                    alertMessage("Quantity Additional Fee Can't be 0!");
                    return;
                }
                                
                if(data.customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode===""){
                    alertMessage("Unit Additional Fee Can't Empty!");
                    return;
                }
                
                if(parseFloat(data.customerPurchaseOrderReleaseAdditionalFeePrice)===0.00){
                    alertMessage("Price Additional Fee Can't be 0!");
                    return;
                }
                
                var customerPurchaseOrderReleaseAdditionalFee = { 
                    remark          : data.customerPurchaseOrderReleaseAdditionalFeeRemark,
                    unitOfMeasure   : {code:data.customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode},
                    additionalFee   : {code:data.customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode},
                    price           : data.customerPurchaseOrderReleaseAdditionalFeePrice,
                    quantity        : data.customerPurchaseOrderReleaseAdditionalFeeQuantity,
                    total           : data.customerPurchaseOrderReleaseAdditionalFeeTotal
                };
                listCustomerPurchaseOrderReleaseAdditionalFee[f] = customerPurchaseOrderReleaseAdditionalFee;
            }
            
            //Payment term
            var totalPercentagePaymentTerm=0;
            for(var p=0;p < idp.length;p++){ 
                var data = $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('getRowData',idp[p]); 
                
                if(data.customerPurchaseOrderReleasePaymentTermSortNO=== '0' ){
                    alertMessage("Sort No Payment Term Can't Zero!");
                    return;
                }
                
                if(data.customerPurchaseOrderReleasePaymentTermSortNO === " "){
                    alertMessage("Sort No Payment Term Can't Empty!");
                    return;
                }
                
                if(data.customerPurchaseOrderReleasePaymentTermPaymentTermName===""){
                    alertMessage("Payment Term Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderReleasePaymentTermPercent)===0.00){
                    alertMessage("Percent Payment term Can't be 0!");
                    return;
                }
                
                var customerPurchaseOrderReleasePaymentTerm = { 
                    sortNo          : data.customerPurchaseOrderReleasePaymentTermSortNO,
                    paymentTerm     : {code:data.customerPurchaseOrderReleasePaymentTermPaymentTermCode},
                    percentage      : data.customerPurchaseOrderReleasePaymentTermPercent,
                    remark          : data.customerPurchaseOrderReleasePaymentTermRemark
                };
                listCustomerPurchaseOrderReleasePaymentTerm[p] = customerPurchaseOrderReleasePaymentTerm;
                totalPercentagePaymentTerm+=parseFloat(data.customerPurchaseOrderReleasePaymentTermPercent);
            }
            
            if(idp.length>0){
                if(parseFloat(totalPercentagePaymentTerm.toFixed(2))!==100){
                    alertMessage("Total Percent Payment Term must be 100%, Can't less or greater than 100%!",400);
                    return;
                }
            }else{
                alertMessage("Grid Payment Term Minimal 1(one) row!");
                return;
            }
            
            //Delivery
            for(var d=0;d < idd.length;d++){ 
                var data = $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getRowData',idd[d]); 
                var deliveryDate = formatDate(data.customerPurchaseOrderReleaseItemDeliveryDeliveryDate,false);
                var deliveryDate = data.customerPurchaseOrderReleaseItemDeliveryDeliveryDate.split('/');
                var deliveryDateNew = deliveryDate[1]+"/"+deliveryDate[0]+"/"+deliveryDate[2];
//                if(data.customerPurchaseOrderReleaseItemDeliveryItemCode===""){
//                    alertMessage("Item Delivery Can't Empty!");
//                    return;
//                }
                
                if(data.customerPurchaseOrderReleaseItemDeliveryDeliveryDate===""){
                    alertMessage("Delivery Date Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderReleaseItemDeliveryQuantity)===0.00){
                    alertMessage("Quantity Delivery Can't be 0!");
                    return;
                }
                
                if(data.customerPurchaseOrderReleaseItemDeliverySalesQuotationCode===""){
                    alertMessage("Quotation Date Can't Empty!");
                    return;
                }
                
                var customerPurchaseOrderReleaseItemDeliveryDate = { 
                    itemFinishGoods     : {code:data.customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsCode},
                    salesQuotation      : {code:data.customerPurchaseOrderReleaseItemDeliverySalesQuotationCode},
                    quantity            : data.customerPurchaseOrderReleaseItemDeliveryQuantity,
                    deliveryDate        : deliveryDateNew
                };
                listCustomerPurchaseOrderReleaseItemDeliveryDate[d] = customerPurchaseOrderReleaseItemDeliveryDate;
            }
            var sumQuantityGroupItem=0;
            
            for(var i=0;i < idi.length;i++){
                var data = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',idi[i]);
                sumQuantityGroupItem=0;
                for(var j=0;j < idd.length;j++){
                    var dataDelivery = $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getRowData',idd[j]);
                    
                    if(data.customerPurchaseOrderReleaseItemDetailQuotationNo === dataDelivery.customerPurchaseOrderReleaseItemDeliverySalesQuotationCode){
                        if(data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode === dataDelivery.customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsCode){
                            if(data.customerPurchaseOrderReleaseItemDetailSortNo === dataDelivery.customerPurchaseOrderReleaseItemDeliverySortNo){
                                sumQuantityGroupItem += parseFloat(dataDelivery.customerPurchaseOrderReleaseItemDeliveryQuantity);
    //                            alert(data.customerPurchaseOrderReleaseItemDetailQuantity);
                            }
                        }
                    }
                }

                if(parseFloat(data.customerPurchaseOrderReleaseItemDetailQuantity)!==sumQuantityGroupItem){
                    alertMessage("Sum Of Quantity Item </br> "+data.customerPurchaseOrderReleaseItemDetailQuotationNo+" Must be Equal with Quantity Item Detail!");
                    return;
                }
                
            }
            
            formatDateCPORL();
            unFormatNumericCPORL();
            
            var url = "sales/customer-purchase-order-release-save";
            var params = $("#frmCustomerPurchaseOrderReleaseInput").serialize();
                params += "&listCustomerPurchaseOrderReleaseSalesQuotationJSON=" + $.toJSON(listCustomerPurchaseOrderReleaseSalesQuotation);
                params += "&listCustomerPurchaseOrderReleaseItemDetailJSON=" + $.toJSON(listCustomerPurchaseOrderReleaseItemDetail);
                params += "&listCustomerPurchaseOrderReleaseAdditionalFeeJSON=" + $.toJSON(listCustomerPurchaseOrderReleaseAdditionalFee);
                params += "&listCustomerPurchaseOrderReleasePaymentTermJSON=" + $.toJSON(listCustomerPurchaseOrderReleasePaymentTerm);
                params += "&listCustomerPurchaseOrderReleaseItemDeliveryJSON=" + $.toJSON(listCustomerPurchaseOrderReleaseItemDeliveryDate);
                
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateCPORL();
                    formatNumericCPORL();
                    alertMessage(data.errorMessage,500);
                    return;
                }
               
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');
                dynamicDialog.dialog({
                    title        : "Confirmation:",
                    closeOnEscape: false,
                    modal        : true,
                    width        : 500,
                    resizable    : false,
                    closeText    : "hide",
                    buttons      : 
                                [{
                                    text : "Yes",
                                    click : function() {
                                        $(this).dialog("close");
                                        var params = "enumCustomerPurchaseOrderReleaseActivity=NEW";
                                        var url = "sales/customer-purchase-order-release-input";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_RELEASE");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/customer-purchase-order-release";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_RELEASE");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnCustomerPurchaseOrderReleaseCancel').click(function(ev) {
            var url = "sales/customer-purchase-order-release";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_RELEASE"); 
        });
        
        $('#customerPurchaseOrderRelease_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=branch","Search", "width=600, height=500");
        });

        $('#customerPurchaseOrderRelease_btnBlanketOrder').click(function(ev) {
            window.open("./pages/search/search-customer-blanket-order.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=customerBlanketOrder&firstDate="+$("#customerPurchaseOrderReleaseDateFirstSession").val()+"&lastDate="+$("#customerPurchaseOrderReleaseDateLastSession").val(),"Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerPurchaseOrderRelease_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=customer","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrderRelease_btnCustomerEndUser').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=endUser","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrderRelease_btnSalesPerson').click(function(ev) {
            window.open("./pages/search/search-sales-person.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=salesPerson","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerPurchaseOrderRelease_btnProject').click(function(ev) {
            window.open("./pages/search/search-project.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=project","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerPurchaseOrderRelease_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=currency","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrderRelease_btnDiscountAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerPurchaseOrderRelease&idsubdoc=discountAccount","Search", "width=600, height=500");
        });
        
        $('#btnCustomerPurchaseOrderReleaseDeliveryDateSet').click(function(ev) {
            if(customerPurchaseOrderReleaseItemDelivery_lastSel !== -1) {
                $('#customerPurchaseOrderReleaseItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDelivery_lastSel); 
            }
            
            var deliveryDate=$("#customerPurchaseOrderReleaseDeliveryDateSet").val();
            var ids = jQuery("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("setCell",ids[i], "customerPurchaseOrderReleaseItemDeliveryDeliveryDate",deliveryDate);
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("setCell",ids[i], "customerPurchaseOrderReleaseItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
        
        $('#btnConfirmCustomerPurchaseOrderReleaseSalesQuotationDetailSort').click(function(ev) {
             if($("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Sales Quotation Can't Be Empty!");
                return;}
            }
            
            if(customerPurchaseOrderReleaseItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDetail_lastSel);  
            }
            
            var ids = jQuery("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getDataIDs');
            var listSalesQuotationDetail = new Array();

            for(var k=0;k<ids.length;k++){
            
            var data = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',ids[k]);    
            var customerPurchaseOrderReleaseItemDetail = { 
                    salesQuotation              : {code:data.customerPurchaseOrderReleaseItemDetailQuotationNo},
                    refNo                       : data.customerPurchaseOrderReleaseItemDetailQuotationRefNo,
                    salesQuotationDetail        : data.customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode,
                    sort                        : data.customerPurchaseOrderReleaseItemDetailSortNo,
                    itemFinishGoodsCode         : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode,
                    itemFinishGoodsName         : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsName,
                    itemFinishGoodsRemark       : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark,
                    valveTypeCode               : data.customerPurchaseOrderReleaseItemDetailValveTypeCode,
                    valveTypeName               : data.customerPurchaseOrderReleaseItemDetailValveTypeName,
                    valveTag                    : data.customerPurchaseOrderReleaseItemDetailValveTag,
                    dataSheet                   : data.customerPurchaseOrderReleaseItemDetailDataSheet,
                    dataDescription             : data.customerPurchaseOrderReleaseItemDetailDescription,
                    itemAlias                   : data.customerPurchaseOrderReleaseItemDetailItemAlias,
                    
                    //01
                    bodyConstQuo                : data.customerPurchaseOrderReleaseItemDetailBodyConstQuotation,
                    bodyConstFinishGoodCode     : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstCode,
                    bodyConstFinishGoodName     : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstName,
                    //02
                    typeDesignQuo               : data.customerPurchaseOrderReleaseItemDetailTypeDesignQuotation,
                    typeDesignFinishGoodCode    : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignCode,
                    typeDesignFinishGoodName    : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignName,
                    //03
                    seatDesignQuo               : data.customerPurchaseOrderReleaseItemDetailSeatDesignQuotation,
                    seatDesignFinishGoodCode    : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignCode,
                    seatDesignFinishGoodName    : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignName,
                    //04
                    sizeQuo                     : data.customerPurchaseOrderReleaseItemDetailSizeQuotation,
                    sizeFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeCode,
                    sizeFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeName,
                    //05
                    ratingQuo                   : data.customerPurchaseOrderReleaseItemDetailRatingQuotation,
                    ratingFinishGoodCode        : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingCode,
                    ratingFinishGoodName        : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingName,
                    //06
                    boreQuo                     : data.customerPurchaseOrderReleaseItemDetailBoreQuotation,
                    boreFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreCode,
                    boreFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreName,
                    
                    //07
                    endConQuo                   : data.customerPurchaseOrderReleaseItemDetailEndConQuotation,
                    endConFinishGoodCode        : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConCode,
                    endConFinishGoodName        : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConName,
                    
                    //08
                    bodyQuo                     : data.customerPurchaseOrderReleaseItemDetailBodyQuotation,
                    bodyFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyCode,
                    bodyFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyName,
                    
                    //09
                    ballQuo                     : data.customerPurchaseOrderReleaseItemDetailBallQuotation,
                    ballFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallCode,
                    ballFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallName,
                    
                    //10
                    seatQuo                     : data.customerPurchaseOrderReleaseItemDetailSeatQuotation,
                    seatFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatCode,
                    seatFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatName,
                    
                    //11
                    seatInsertQuo                     : data.customerPurchaseOrderReleaseItemDetailSeatInsertQuotation,
                    seatInsertFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertCode,
                    seatInsertFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertName,
                    
                    //12
                    stemQuo                     : data.customerPurchaseOrderReleaseItemDetailStemQuotation,
                    stemFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemCode,
                    stemFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemName,
                    
                    //13
                    sealQuo                     : data.customerPurchaseOrderReleaseItemDetailSealQuotation,
                    sealFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealCode,
                    sealFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealName,
                    
                    //14
                    boltQuo                     : data.customerPurchaseOrderReleaseItemDetailBoltQuotation,
                    boltFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltCode,
                    boltFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltName,
                    
                    //15
                    discQuo                     : data.customerPurchaseOrderReleaseItemDetailDiscQuotation,
                    discFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscCode,
                    discFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscName,
                    
                    //16
                    platesQuo                     : data.customerPurchaseOrderReleaseItemDetailPlatesQuotation,
                    platesFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesCode,
                    platesFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesName,
                    
                    //17
                    shaftQuo                     : data.customerPurchaseOrderReleaseItemDetailShaftQuotation,
                    shaftFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftCode,
                    shaftFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftName,
                    
                    //18
                    springQuo                     : data.customerPurchaseOrderReleaseItemDetailSpringQuotation,
                    springFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringCode,
                    springFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringName,
                    
                    //19
                    armPinQuo                     : data.customerPurchaseOrderReleaseItemDetailArmPinQuotation,
                    armPinFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinCode,
                    armPinFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinName,
                    
                    //20
                    backSeatQuo                     : data.customerPurchaseOrderReleaseItemDetailBackSeatQuotation,
                    backSeatFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatCode,
                    backSeatFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatName,
                    
                    //21
                    armQuo                     : data.customerPurchaseOrderReleaseItemDetailArmQuotation,
                    armFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmCode,
                    armFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmName,
                    
                    //22
                    hingePinQuo                     : data.customerPurchaseOrderReleaseItemDetailHingePinQuotation,
                    hingePinFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinCode,
                    hingePinFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinName,
                    
                    //23
                    stopPinQuo                     : data.customerPurchaseOrderReleaseItemDetailStopPinQuotation,
                    stopPinFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinCode,
                    stopPinFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinName,
                    
                    //24
                    operatorQuo                     : data.customerPurchaseOrderReleaseItemDetailOperatorQuotation,
                    operatorFinishGoodCode          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorCode,
                    operatorFinishGoodName          : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorName,
                    
                    note                        : data.customerPurchaseOrderReleaseItemDetailNote,
                    price                       : data.customerPurchaseOrderReleaseItemDetailPrice,
                    total                       : data.customerPurchaseOrderReleaseItemDetailTotal,
                    quantity                    : data.customerPurchaseOrderReleaseItemDetailQuantity
                    
                };
                listSalesQuotationDetail[k] = customerPurchaseOrderReleaseItemDetail;
            }
            
             var result = Enumerable.From(listSalesQuotationDetail)
                            .OrderBy('$.sort')
                            .Select()
                            .ToArray();
            
            $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('clearGridData');
            customerPurchaseOrderReleaseItemDetail_lastSel = 0;
                for(var i = 0; i < result.length; i++){
                    customerPurchaseOrderReleaseItemDetail_lastSel ++;
                    $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("addRowData",customerPurchaseOrderReleaseItemDetail_lastSel, result[i]);
                    $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDetail_lastSel,{
                        
                    customerPurchaseOrderReleaseItemDetailQuotationNo                      : result[i].salesQuotation.code,
                    customerPurchaseOrderReleaseItemDetailQuotationRefNo                   : result[i].refNo,
                    customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode            : result[i].salesQuotationDetail,
                    customerPurchaseOrderReleaseItemDetailSortNo                           : result[i].sort,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode              : result[i].itemFinishGoodsCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsName              : result[i].itemFinishGoodsName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark            : result[i].itemFinishGoodsRemark,
                    customerPurchaseOrderReleaseItemDetailValveTypeCode                    : result[i].valveTypeCode,
                    customerPurchaseOrderReleaseItemDetailValveTypeName                    : result[i].valveTypeName,
                    customerPurchaseOrderReleaseItemDetailValveTag                         : result[i].valveTag,
                    customerPurchaseOrderReleaseItemDetailDataSheet                        : result[i].dataSheet,
                    customerPurchaseOrderReleaseItemDetailDescription                      : result[i].dataDescription,
                    customerPurchaseOrderReleaseItemDetailItemAlias                        : result[i].itemAlias,
                    //01
                    customerPurchaseOrderReleaseItemDetailBodyConstQuotation               : result[i].bodyConstQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstCode     : result[i].bodyConstFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstName     : result[i].bodyConstFinishGoodName,
                    //02
                    customerPurchaseOrderReleaseItemDetailTypeDesignQuotation               : result[i].typeDesignQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignCode     : result[i].typeDesignFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignName     : result[i].typeDesignFinishGoodName,
                    //03
                    customerPurchaseOrderReleaseItemDetailSeatDesignQuotation               : result[i].seatDesignQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignCode     : result[i].seatDesignFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignName     : result[i].seatDesignFinishGoodName,
                    //04
                    customerPurchaseOrderReleaseItemDetailSizeQuotation               : result[i].sizeQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeCode     : result[i].sizeFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeName     : result[i].sizeFinishGoodName,
                    //05
                    customerPurchaseOrderReleaseItemDetailRatingQuotation               : result[i].ratingQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingCode     : result[i].ratingFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingName     : result[i].ratingFinishGoodName,
                    //06
                    customerPurchaseOrderReleaseItemDetailBoreQuotation               : result[i].boreQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreCode     : result[i].boreFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreName     : result[i].boreFinishGoodName,
                    //07
                    customerPurchaseOrderReleaseItemDetailEndConQuotation               : result[i].endConQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConCode     : result[i].endConFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConName     : result[i].endConFinishGoodName,
                    //08
                    customerPurchaseOrderReleaseItemDetailBodyQuotation               : result[i].bodyQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyCode     : result[i].bodyFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyName     : result[i].bodyFinishGoodName,
                    //09
                    customerPurchaseOrderReleaseItemDetailBallQuotation               : result[i].ballQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallCode     : result[i].ballFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallName     : result[i].ballFinishGoodName,
                    //10
                    customerPurchaseOrderReleaseItemDetailSeatQuotation               : result[i].seatQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatCode     : result[i].seatFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatName     : result[i].seatFinishGoodName,
                    //11
                    customerPurchaseOrderReleaseItemDetailSeatInsertQuotation               : result[i].seatInsertQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertCode     : result[i].seatInsertFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertName     : result[i].seatInsertFinishGoodName,
                    //12
                    customerPurchaseOrderReleaseItemDetailStemQuotation               : result[i].stemQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemCode     : result[i].stemFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemName     : result[i].stemFinishGoodName,
                    //13
                    customerPurchaseOrderReleaseItemDetailSealQuotation               : result[i].sealQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealCode     : result[i].sealFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealName     : result[i].sealFinishGoodName,
                    //14
                    customerPurchaseOrderReleaseItemDetailBoltQuotation               : result[i].boltQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltCode     : result[i].boltFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltName     : result[i].boltFinishGoodName,
                    //15
                    customerPurchaseOrderReleaseItemDetailDiscQuotation               : result[i].discQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscCode     : result[i].discFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscName     : result[i].discFinishGoodName,
                    //16
                    customerPurchaseOrderReleaseItemDetailPlatesQuotation               : result[i].platesQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesCode     : result[i].platesFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesName     : result[i].platesFinishGoodName,
                    //17
                    customerPurchaseOrderReleaseItemDetailShaftQuotation               : result[i].shaftQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftCode     : result[i].shaftFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftName     : result[i].shaftFinishGoodName,
                    //18
                    customerPurchaseOrderReleaseItemDetailSpringQuotation               : result[i].springQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringCode     : result[i].springFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringName     : result[i].springFinishGoodName,
                    //19
                    customerPurchaseOrderReleaseItemDetailArmPinQuotation               : result[i].armPinQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinCode     : result[i].armPinFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinName     : result[i].armPinFinishGoodName,
                    //20
                    customerPurchaseOrderReleaseItemDetailBackSeatQuotation               : result[i].backSeatQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatCode     : result[i].backSeatFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatName     : result[i].backSeatFinishGoodName,
                    //21
                    customerPurchaseOrderReleaseItemDetailArmQuotation               : result[i].armQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmCode     : result[i].armFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmName     : result[i].armFinishGoodName,
                    //22
                    customerPurchaseOrderReleaseItemDetailHingePinQuotation               : result[i].hingePinQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinCode     : result[i].hingePinFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinName     : result[i].hingePinFinishGoodName,
                    //23
                    customerPurchaseOrderReleaseItemDetailStopPinQuotation               : result[i].stopPinQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinCode     : result[i].stopPinFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinName     : result[i].stopPinFinishGoodName,
                    //24
                    customerPurchaseOrderReleaseItemDetailOperatorQuotation               : result[i].operatorQuo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorCode     : result[i].operatorFinishGoodCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorName     : result[i].operatorFinishGoodName,
                    
                    customerPurchaseOrderReleaseItemDetailNote                        : result[i].note,
                    customerPurchaseOrderReleaseItemDetailPrice                       : result[i].price,
                    customerPurchaseOrderReleaseItemDetailTotal                       : result[i].total,
                    customerPurchaseOrderReleaseItemDetailQuantity                    : result[i].quantity
               });    
            }
        }); 
    }); //EOF Ready
    
    function formatDateCPORL(){
        var transactionDateSplit=dtpCustomerPurchaseOrderReleaseTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpCustomerPurchaseOrderReleaseTransactionDate.val(transactionDate);
        
        var createdDate=$("#customerPurchaseOrderRelease\\.createdDate").val();
        $("#customerPurchaseOrderRelease\\.createdDateTemp").val(createdDate);
        
    }

    function unFormatNumericCPORL(){
        var retention =removeCommas(txtCustomerPurchaseOrderReleaseRetention.val());
        txtCustomerPurchaseOrderReleaseRetention.val(retention);
        
        var totalTransactionAmount =removeCommas(txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val());
        txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtCustomerPurchaseOrderReleaseDiscountAmount.val());
        txtCustomerPurchaseOrderReleaseDiscountAmount.val(discountAmount);
        var taxBaseAmount =removeCommas(txtCustomerPurchaseOrderReleaseTaxBaseAmount.val());
        txtCustomerPurchaseOrderReleaseTaxBaseAmount.val(taxBaseAmount);
        var vatPercent =removeCommas(txtCustomerPurchaseOrderReleaseVATPercent.val());
        txtCustomerPurchaseOrderReleaseVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtCustomerPurchaseOrderReleaseVATAmount.val());
        txtCustomerPurchaseOrderReleaseVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtCustomerPurchaseOrderReleaseGrandTotalAmount.val());
        txtCustomerPurchaseOrderReleaseGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericCPORL(){
        
        var retention =parseFloat(txtCustomerPurchaseOrderReleaseRetention.val());
        txtCustomerPurchaseOrderReleaseRetention.val(formatNumber(retention,2));
        
        var totalTransactionAmount =parseFloat(txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val());
        txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtCustomerPurchaseOrderReleaseDiscountPercent.val());
        txtCustomerPurchaseOrderReleaseDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtCustomerPurchaseOrderReleaseDiscountAmount.val());
        txtCustomerPurchaseOrderReleaseDiscountAmount.val(formatNumber(discountAmount,2));
        var taxBaseAmount =parseFloat(txtCustomerPurchaseOrderReleaseTaxBaseAmount.val());
        txtCustomerPurchaseOrderReleaseTaxBaseAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtCustomerPurchaseOrderReleaseVATPercent.val());
        txtCustomerPurchaseOrderReleaseVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtCustomerPurchaseOrderReleaseVATAmount.val());
        txtCustomerPurchaseOrderReleaseVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtCustomerPurchaseOrderReleaseGrandTotalAmount.val());
        txtCustomerPurchaseOrderReleaseGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }    
    
    function clearCustomerPurchaseOrderReleaseTransactionAmount(){
        txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val("0.00");        
        txtCustomerPurchaseOrderReleaseDiscountPercent.val("0.00");
        txtCustomerPurchaseOrderReleaseDiscountAmount.val("0.00");
        txtCustomerPurchaseOrderReleaseTotalAdditionalFee.val("0.00");
        txtCustomerPurchaseOrderReleaseTaxBaseAmount.val("0.00");
        txtCustomerPurchaseOrderReleaseVATPercent.val("0.00");
        txtCustomerPurchaseOrderReleaseVATAmount.val("0.00");
        txtCustomerPurchaseOrderReleaseGrandTotalAmount.val("0.00");
    }
    
    function calculateItemSalesQuotationDetailRelease(){

        var selectedRowID = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerPurchaseOrderReleaseItemDetailLastRowId;
        }
        var qty = $("#" + selectedRowID + "_customerPurchaseOrderReleaseItemDetailQuantity").val();
        var unitPrice = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData', selectedRowID);
        var amount = unitPrice.customerPurchaseOrderReleaseItemDetailPrice;

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("setCell", selectedRowID, "customerPurchaseOrderReleaseItemDetailTotal", subAmount);

        calculateCustomerPurchaseOrderReleaseHeader();
    }
    
    function calculateCustomerPurchaseOrderReleaseAdditionalFee() {
        var selectedRowID = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var qty = $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeePrice").val();
        
        var subTotal = (parseFloat(qty) * parseFloat(price));
        
        $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "customerPurchaseOrderReleaseAdditionalFeeTotal", subTotal);

        calculateCustomerPurchaseOrderReleaseTotalAdditional();
    }
    
    function calculateCustomerPurchaseOrderReleaseTotalAdditional() {
        var totalAmount =0;
        var ids = jQuery("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.customerPurchaseOrderReleaseAdditionalFeeTotal);
        }   
        
        txtCustomerPurchaseOrderReleaseTotalAdditionalFee.val(formatNumber(totalAmount,2));
        calculateCustomerPurchaseOrderReleaseHeader();

    }
    
    function calculateCustomerPurchaseOrderReleaseHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var additionalFeeAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.customerPurchaseOrderReleaseItemDetailTotal);
        }   
        txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtCustomerPurchaseOrderReleaseDiscountPercent.val()));        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtCustomerPurchaseOrderReleaseDiscountAmount.val()===""){
            discAmount=0;
        }
        
        additionalFeeAmount=parseFloat(removeCommas(txtCustomerPurchaseOrderReleaseTotalAdditionalFee.val()));  
        
        subTotal = (totalTransaction-discAmount)+additionalFeeAmount;
        
        if(txtCustomerPurchaseOrderReleaseVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtCustomerPurchaseOrderReleaseVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtCustomerPurchaseOrderReleaseDiscountAmount.val(formatNumber(discAmount,2));
        txtCustomerPurchaseOrderReleaseTaxBaseAmount.val(formatNumber(subTotal,2));
        txtCustomerPurchaseOrderReleaseVATAmount.val(formatNumber(vatAmount,2));        
        txtCustomerPurchaseOrderReleaseGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onchangeAdditionalFeeUnitOfMeasureCodeCPORL(){
        var selectedRowID = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var uomCodeNice = $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + uomCodeNice;
            params+= "&unitOfMeasure.activeStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode").val("");
                alert("UOM Not Found","");
            }
        });
            
    }
    
    function onchangeAdditionalFeeCodeCPORL(){
        var selectedRowID = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var additionalFeeCode = $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode").val();

        var url = "master/additional-fee-get-sales";
        var params = "additionalFee.code=" + additionalFeeCode;
            params+= "&additionalFee.activeStatus=TRUE";
            params+= "&additionalFee.salesStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.additionalFeeTemp){
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode",data.additionalFeeTemp.code);
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeName",data.additionalFeeTemp.name);
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountCode",data.additionalFeeTemp.salesChartOfAccountCode);
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountName",data.additionalFeeTemp.salesChartOfAccountName);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeName").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountName").val("");
                alert("Additional Fee Not Found","");
            }
        });
            
    }
    
    function onchangePaymentTermPaymentTermCodeCPORL(){
        var selectedRowID = $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid("getGridParam", "selrow");
        var paymentTermCode = $("#" + selectedRowID + "_customerPurchaseOrderReleasePaymentTermPaymentTermCode").val();

        var url = "master/payment-term-get";
        var params = "paymentTerm.code=" + paymentTermCode;
            params+= "&paymentTerm.activeStatus=TRUE";
        $.post(url, params, function(result){
            var data = (result);
            if (data.paymentTermTemp){
                $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderReleasePaymentTermPaymentTermCode",data.paymentTermTemp.code);
                $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderReleasePaymentTermPaymentTermName",data.paymentTermTemp.name);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderReleasePaymentTermPaymentTermCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderReleasePaymentTermPaymentTermName").val("");
                alert("Payment Term Not Found","");
            }
        });
            
    }
    
    function customerPurchaseOrderReleaseSalesQuotationInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function customerPurchaseOrderReleaseItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
        
        calculateCustomerPurchaseOrderReleaseHeader();
    }
    
    function customerPurchaseOrderReleaseAdditionalFeeInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('delRowData',selectDetailRowId);    
        calculateCustomerPurchaseOrderReleaseTotalAdditional();
    }
    
    function customerPurchaseOrderReleasePaymentTermInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function customerPurchaseOrderReleaseItemDeliveryInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    
    function onchangeCustomerPurchaseOrderReleaseItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_customerPurchaseOrderReleaseItemDeliveryDeliveryDate").val();
        
        $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "customerPurchaseOrderReleaseItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    function loadCustomerPurchaseOrderReleaseItemDetail() {
        loadGridItemCPORL();
        var arrSalesQuotationNo=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNo.push(data.customerPurchaseOrderReleaseSalesQuotationCode);
        }
        
        var url = "sales/sales-quotation-detail-getgroupby-sales-quotation-data";
        var params = "arrSalesQuotationNo="+arrSalesQuotationNo;   
        customerPurchaseOrderReleaseItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listSalesQuotationDetailTemp.length; i++) {
                customerPurchaseOrderReleaseItemDetailLastRowId++;
                
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseItemDetailLastRowId, data.listSalesQuotationDetailTemp[i]);
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDetailLastRowId,{
                    customerPurchaseOrderReleaseItemDetailDelete               : "delete",
                    customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode: data.listSalesQuotationDetailTemp[i].code,
                    customerPurchaseOrderReleaseItemDetailQuotationNo          : data.listSalesQuotationDetailTemp[i].headerCode,
                    customerPurchaseOrderReleaseItemDetailQuotationRefNo       : data.listSalesQuotationDetailTemp[i].refNo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode  : data.listSalesQuotationDetailTemp[i].itemFinishGoodsCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsName  : data.listSalesQuotationDetailTemp[i].itemFinishGoodsName,
                    customerPurchaseOrderReleaseItemDetailSortNo               : data.listSalesQuotationDetailTemp[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderReleaseItemDetailValveTypeCode        : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                    customerPurchaseOrderReleaseItemDetailValveTypeName        : data.listSalesQuotationDetailTemp[i].valveTypeName,
                    customerPurchaseOrderReleaseItemDetailValveTag             : data.listSalesQuotationDetailTemp[i].valveTag,
                    customerPurchaseOrderReleaseItemDetailDataSheet            : data.listSalesQuotationDetailTemp[i].dataSheet,
                    customerPurchaseOrderReleaseItemDetailDescription          : data.listSalesQuotationDetailTemp[i].description,
                    customerPurchaseOrderReleaseItemDetailQuantity             : data.listSalesQuotationDetailTemp[i].quantity,
                    customerPurchaseOrderReleaseItemDetailPrice                : data.listSalesQuotationDetailTemp[i].unitPrice,
                    customerPurchaseOrderReleaseItemDetailTotal                : data.listSalesQuotationDetailTemp[i].total,
                    
                    // 24 valve Type Component
                    customerPurchaseOrderReleaseItemDetailBodyConstQuotation   : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                    customerPurchaseOrderReleaseItemDetailTypeDesignQuotation  : data.listSalesQuotationDetailTemp[i].typeDesign,
                    customerPurchaseOrderReleaseItemDetailSeatDesignQuotation  : data.listSalesQuotationDetailTemp[i].seatDesign,
                    customerPurchaseOrderReleaseItemDetailSizeQuotation        : data.listSalesQuotationDetailTemp[i].size,
                    customerPurchaseOrderReleaseItemDetailRatingQuotation      : data.listSalesQuotationDetailTemp[i].rating,
                    customerPurchaseOrderReleaseItemDetailBoreQuotation        : data.listSalesQuotationDetailTemp[i].bore,
                    
                    customerPurchaseOrderReleaseItemDetailEndConQuotation      : data.listSalesQuotationDetailTemp[i].endCon,
                    customerPurchaseOrderReleaseItemDetailBodyQuotation        : data.listSalesQuotationDetailTemp[i].body,
                    customerPurchaseOrderReleaseItemDetailBallQuotation        : data.listSalesQuotationDetailTemp[i].ball,
                    customerPurchaseOrderReleaseItemDetailSeatQuotation        : data.listSalesQuotationDetailTemp[i].seat,
                    customerPurchaseOrderReleaseItemDetailSeatInsertQuotation  : data.listSalesQuotationDetailTemp[i].seatInsert,
                    customerPurchaseOrderReleaseItemDetailStemQuotation        : data.listSalesQuotationDetailTemp[i].stem,
                    
                    customerPurchaseOrderReleaseItemDetailSealQuotation        : data.listSalesQuotationDetailTemp[i].seal,
                    customerPurchaseOrderReleaseItemDetailBoltQuotation        : data.listSalesQuotationDetailTemp[i].bolt,
                    customerPurchaseOrderReleaseItemDetailDiscQuotation        : data.listSalesQuotationDetailTemp[i].disc,
                    customerPurchaseOrderReleaseItemDetailPlatesQuotation      : data.listSalesQuotationDetailTemp[i].plates,
                    customerPurchaseOrderReleaseItemDetailShaftQuotation       : data.listSalesQuotationDetailTemp[i].shaft,
                    customerPurchaseOrderReleaseItemDetailSpringQuotation      : data.listSalesQuotationDetailTemp[i].spring,
                    
                    customerPurchaseOrderReleaseItemDetailArmPinQuotation      : data.listSalesQuotationDetailTemp[i].armPin,
                    customerPurchaseOrderReleaseItemDetailBackSeatQuotation    : data.listSalesQuotationDetailTemp[i].backseat,
                    customerPurchaseOrderReleaseItemDetailArmQuotation         : data.listSalesQuotationDetailTemp[i].arm,
                    customerPurchaseOrderReleaseItemDetailHingePinQuotation    : data.listSalesQuotationDetailTemp[i].hingePin,
                    customerPurchaseOrderReleaseItemDetailStopPinQuotation     : data.listSalesQuotationDetailTemp[i].stopPin,
                    customerPurchaseOrderReleaseItemDetailOperatorQuotation    : data.listSalesQuotationDetailTemp[i].oper,
                    //
                    customerPurchaseOrderReleaseItemDetailNote                 : data.listSalesQuotationDetailTemp[i].note
                });
                totalTransaction+=parseFloat(data.listSalesQuotationDetailTemp[i].total.toFixed(2));
                txtCustomerPurchaseOrderReleaseTotalTransactionAmount.val(formatNumber(totalTransaction,2));
                calculateCustomerPurchaseOrderReleaseHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderReleaseItemDetailUpdate() {
        loadGridItemCPORL();
        var arrSalesQuotationNoTemp=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNoTemp.push(data.customerPurchaseOrderReleaseSalesQuotationCode);
        }
        
        var url = "sales/customer-purchase-order-release-item-detail-data-array-data";
        var params = "arrSalesQuotationNo="+arrSalesQuotationNoTemp;
            params += "&customerPurchaseOrderRelease.code="+$("#customerPurchaseOrderRelease\\.customerPurchaseOrderReleaseCode").val();
        customerPurchaseOrderReleaseItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderReleaseItemDetail.length; i++) {
                customerPurchaseOrderReleaseItemDetailLastRowId++;
                
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseItemDetailLastRowId, data.listCustomerPurchaseOrderReleaseItemDetail[i]);
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDetailLastRowId,{
                    customerPurchaseOrderReleaseItemDetailDelete                   : "delete",
                    customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].salesQuotationDetailCode,
                    customerPurchaseOrderReleaseItemDetailQuotationNo              : data.listCustomerPurchaseOrderReleaseItemDetail[i].salesQuotationCode,
                    customerPurchaseOrderReleaseItemDetailQuotationRefNo           : data.listCustomerPurchaseOrderReleaseItemDetail[i].refNo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemFinishGoodsCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemFinishGoodsRemark,
                    customerPurchaseOrderReleaseItemDetailSortNo                   : data.listCustomerPurchaseOrderReleaseItemDetail[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderReleaseItemDetailValveTypeCode            : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTypeCode,
                    customerPurchaseOrderReleaseItemDetailValveTypeName            : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTypeName,
                    customerPurchaseOrderReleaseItemDetailItemAlias                : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemAlias,
                    customerPurchaseOrderReleaseItemDetailValveTag                 : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTag,
                    customerPurchaseOrderReleaseItemDetailDataSheet                : data.listCustomerPurchaseOrderReleaseItemDetail[i].dataSheet,
                    customerPurchaseOrderReleaseItemDetailDescription              : data.listCustomerPurchaseOrderReleaseItemDetail[i].description,
                    
                    
                    // 24 valve Type Component Quotation
                    customerPurchaseOrderReleaseItemDetailBodyConstQuotation   : data.listCustomerPurchaseOrderReleaseItemDetail[i].bodyConstruction,
                    customerPurchaseOrderReleaseItemDetailTypeDesignQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].typeDesign,
                    customerPurchaseOrderReleaseItemDetailSeatDesignQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].seatDesign,
                    customerPurchaseOrderReleaseItemDetailSizeQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].size,
                    customerPurchaseOrderReleaseItemDetailRatingQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].rating,
                    customerPurchaseOrderReleaseItemDetailBoreQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].bore,
                    
                    customerPurchaseOrderReleaseItemDetailEndConQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].endCon,
                    customerPurchaseOrderReleaseItemDetailBodyQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].body,
                    customerPurchaseOrderReleaseItemDetailBallQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].ball,
                    customerPurchaseOrderReleaseItemDetailSeatQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].seat,
                    customerPurchaseOrderReleaseItemDetailSeatInsertQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].seatInsert,
                    customerPurchaseOrderReleaseItemDetailStemQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].stem,
                    
                    customerPurchaseOrderReleaseItemDetailSealQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].seal,
                    customerPurchaseOrderReleaseItemDetailBoltQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].bolting,
                    customerPurchaseOrderReleaseItemDetailDiscQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].disc,
                    customerPurchaseOrderReleaseItemDetailPlatesQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].plates,
                    customerPurchaseOrderReleaseItemDetailShaftQuotation       : data.listCustomerPurchaseOrderReleaseItemDetail[i].shaft,
                    customerPurchaseOrderReleaseItemDetailSpringQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].spring,
                    
                    customerPurchaseOrderReleaseItemDetailArmPinQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].armPin,
                    customerPurchaseOrderReleaseItemDetailBackSeatQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].backSeat,
                    customerPurchaseOrderReleaseItemDetailArmQuotation         : data.listCustomerPurchaseOrderReleaseItemDetail[i].arm,
                    customerPurchaseOrderReleaseItemDetailHingePinQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].hingePin,
                    customerPurchaseOrderReleaseItemDetailStopPinQuotation     : data.listCustomerPurchaseOrderReleaseItemDetail[i].stopPin,
                    customerPurchaseOrderReleaseItemDetailOperatorQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyConstructionCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstName     : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyConstructionName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemTypeDesignCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemTypeDesignName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatDesignCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatDesignName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSizeCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSizeName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemRatingCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemRatingName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoreCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoreName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemEndConCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemEndConName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBallCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBallName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatInsertCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatInsertName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStemCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStemName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSealCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSealName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoltCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoltName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemDiscCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemDiscName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemPlatesCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemPlatesName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftCode         : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemShaftCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftName         : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemShaftName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSpringCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSpringName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmPinCode, 
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmPinName, 
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBackSeatCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBackSeatName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmCode           : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmName           : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemHingePinCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemHingePinName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinCode       : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStopPinCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinName       : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStopPinName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemOperatorCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemOperatorName,
                    
                    customerPurchaseOrderReleaseItemDetailNote                 : data.listCustomerPurchaseOrderReleaseItemDetail[i].note,
                    customerPurchaseOrderReleaseItemDetailQuantity             : data.listCustomerPurchaseOrderReleaseItemDetail[i].quantity,
                    customerPurchaseOrderReleaseItemDetailPrice                : data.listCustomerPurchaseOrderReleaseItemDetail[i].unitPrice,
                    customerPurchaseOrderReleaseItemDetailTotal                : data.listCustomerPurchaseOrderReleaseItemDetail[i].totalAmount
                });
                calculateCustomerPurchaseOrderReleaseHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderReleaseItemDetailRevise() {
        loadGridItemCPORL();
        var arrSalesQuotationNoTemp=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNoTemp.push(data.customerPurchaseOrderReleaseSalesQuotationCode);
        }
        
        var url = "sales/customer-purchase-order-release-item-detail-data-array-data";
        var params = "arrSalesQuotationNo="+arrSalesQuotationNoTemp;
            params += "&customerPurchaseOrderRelease.code="+$("#customerPurchaseOrderRelease\\.customerPurchaseOrderReleaseCode").val();
        customerPurchaseOrderReleaseItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderReleaseItemDetail.length; i++) {
                customerPurchaseOrderReleaseItemDetailLastRowId++;
                
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseItemDetailLastRowId, data.listCustomerPurchaseOrderReleaseItemDetail[i]);
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDetailLastRowId,{
                    customerPurchaseOrderReleaseItemDetailDelete                   : "delete",
                    customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].salesQuotationDetailCode,
                    customerPurchaseOrderReleaseItemDetailQuotationNo              : data.listCustomerPurchaseOrderReleaseItemDetail[i].salesQuotationCode,
                    customerPurchaseOrderReleaseItemDetailQuotationRefNo           : data.listCustomerPurchaseOrderReleaseItemDetail[i].refNo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemFinishGoodsCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemFinishGoodsRemark,
                    customerPurchaseOrderReleaseItemDetailSortNo                   : data.listCustomerPurchaseOrderReleaseItemDetail[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderReleaseItemDetailValveTypeCode            : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTypeCode,
                    customerPurchaseOrderReleaseItemDetailValveTypeName            : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTypeName,
                    customerPurchaseOrderReleaseItemDetailItemAlias                : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemAlias,
                    customerPurchaseOrderReleaseItemDetailValveTag                 : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTag,
                    customerPurchaseOrderReleaseItemDetailDataSheet                : data.listCustomerPurchaseOrderReleaseItemDetail[i].dataSheet,
                    customerPurchaseOrderReleaseItemDetailDescription              : data.listCustomerPurchaseOrderReleaseItemDetail[i].description,
                    
                    
                    // 24 valve Type Component Quotation
                    customerPurchaseOrderReleaseItemDetailBodyConstQuotation   : data.listCustomerPurchaseOrderReleaseItemDetail[i].bodyConstruction,
                    customerPurchaseOrderReleaseItemDetailTypeDesignQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].typeDesign,
                    customerPurchaseOrderReleaseItemDetailSeatDesignQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].seatDesign,
                    customerPurchaseOrderReleaseItemDetailSizeQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].size,
                    customerPurchaseOrderReleaseItemDetailRatingQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].rating,
                    customerPurchaseOrderReleaseItemDetailBoreQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].bore,
                    
                    customerPurchaseOrderReleaseItemDetailEndConQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].endCon,
                    customerPurchaseOrderReleaseItemDetailBodyQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].body,
                    customerPurchaseOrderReleaseItemDetailBallQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].ball,
                    customerPurchaseOrderReleaseItemDetailSeatQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].seat,
                    customerPurchaseOrderReleaseItemDetailSeatInsertQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].seatInsert,
                    customerPurchaseOrderReleaseItemDetailStemQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].stem,
                    
                    customerPurchaseOrderReleaseItemDetailSealQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].seal,
                    customerPurchaseOrderReleaseItemDetailBoltQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].bolting,
                    customerPurchaseOrderReleaseItemDetailDiscQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].disc,
                    customerPurchaseOrderReleaseItemDetailPlatesQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].plates,
                    customerPurchaseOrderReleaseItemDetailShaftQuotation       : data.listCustomerPurchaseOrderReleaseItemDetail[i].shaft,
                    customerPurchaseOrderReleaseItemDetailSpringQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].spring,
                    
                    customerPurchaseOrderReleaseItemDetailArmPinQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].armPin,
                    customerPurchaseOrderReleaseItemDetailBackSeatQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].backSeat,
                    customerPurchaseOrderReleaseItemDetailArmQuotation         : data.listCustomerPurchaseOrderReleaseItemDetail[i].arm,
                    customerPurchaseOrderReleaseItemDetailHingePinQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].hingePin,
                    customerPurchaseOrderReleaseItemDetailStopPinQuotation     : data.listCustomerPurchaseOrderReleaseItemDetail[i].stopPin,
                    customerPurchaseOrderReleaseItemDetailOperatorQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyConstructionCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstName     : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyConstructionName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemTypeDesignCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemTypeDesignName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatDesignCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatDesignName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSizeCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSizeName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemRatingCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemRatingName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoreCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoreName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemEndConCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemEndConName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBallCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBallName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatInsertCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatInsertName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStemCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStemName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSealCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSealName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoltCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoltName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemDiscCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemDiscName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemPlatesCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemPlatesName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftCode         : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemShaftCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftName         : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemShaftName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSpringCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSpringName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmPinCode, 
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmPinName, 
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBackSeatCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBackSeatName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmCode           : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmName           : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemHingePinCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemHingePinName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinCode       : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStopPinCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinName       : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStopPinName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemOperatorCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemOperatorName,
                    
                    customerPurchaseOrderReleaseItemDetailNote                 : data.listCustomerPurchaseOrderReleaseItemDetail[i].note,
                    customerPurchaseOrderReleaseItemDetailQuantity             : data.listCustomerPurchaseOrderReleaseItemDetail[i].quantity,
                    customerPurchaseOrderReleaseItemDetailPrice                : data.listCustomerPurchaseOrderReleaseItemDetail[i].unitPrice,
                    customerPurchaseOrderReleaseItemDetailTotal                : data.listCustomerPurchaseOrderReleaseItemDetail[i].totalAmount
                });
                calculateCustomerPurchaseOrderReleaseHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderReleaseItemDetailClone() {
        loadGridItemCPORL();
        var arrSalesQuotationNoTemp=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNoTemp.push(data.customerPurchaseOrderReleaseSalesQuotationCode);
        }
        
        var url = "sales/customer-purchase-order-release-item-detail-data-array-data";
        var params = "arrSalesQuotationNo="+arrSalesQuotationNoTemp;
            params += "&customerPurchaseOrderRelease.code="+$("#customerPurchaseOrderRelease\\.customerPurchaseOrderReleaseCode").val();
        customerPurchaseOrderReleaseItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderReleaseItemDetail.length; i++) {
                customerPurchaseOrderReleaseItemDetailLastRowId++;
                
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseItemDetailLastRowId, data.listCustomerPurchaseOrderReleaseItemDetail[i]);
                $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDetailLastRowId,{
                    customerPurchaseOrderReleaseItemDetailDelete                   : "delete",
                    customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].salesQuotationDetailCode,
                    customerPurchaseOrderReleaseItemDetailQuotationNo              : data.listCustomerPurchaseOrderReleaseItemDetail[i].salesQuotationCode,
                    customerPurchaseOrderReleaseItemDetailQuotationRefNo           : data.listCustomerPurchaseOrderReleaseItemDetail[i].refNo,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemFinishGoodsCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemFinishGoodsRemark,
                    customerPurchaseOrderReleaseItemDetailSortNo                   : data.listCustomerPurchaseOrderReleaseItemDetail[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderReleaseItemDetailValveTypeCode            : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTypeCode,
                    customerPurchaseOrderReleaseItemDetailValveTypeName            : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTypeName,
                    customerPurchaseOrderReleaseItemDetailItemAlias                : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemAlias,
                    customerPurchaseOrderReleaseItemDetailValveTag                 : data.listCustomerPurchaseOrderReleaseItemDetail[i].valveTag,
                    customerPurchaseOrderReleaseItemDetailDataSheet                : data.listCustomerPurchaseOrderReleaseItemDetail[i].dataSheet,
                    customerPurchaseOrderReleaseItemDetailDescription              : data.listCustomerPurchaseOrderReleaseItemDetail[i].description,
                    
                    // 24 valve Type Component Quotation
                    customerPurchaseOrderReleaseItemDetailBodyConstQuotation   : data.listCustomerPurchaseOrderReleaseItemDetail[i].bodyConstruction,
                    customerPurchaseOrderReleaseItemDetailTypeDesignQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].typeDesign,
                    customerPurchaseOrderReleaseItemDetailSeatDesignQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].seatDesign,
                    customerPurchaseOrderReleaseItemDetailSizeQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].size,
                    customerPurchaseOrderReleaseItemDetailRatingQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].rating,
                    customerPurchaseOrderReleaseItemDetailBoreQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].bore,
                    
                    customerPurchaseOrderReleaseItemDetailEndConQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].endCon,
                    customerPurchaseOrderReleaseItemDetailBodyQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].body,
                    customerPurchaseOrderReleaseItemDetailBallQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].ball,
                    customerPurchaseOrderReleaseItemDetailSeatQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].seat,
                    customerPurchaseOrderReleaseItemDetailSeatInsertQuotation  : data.listCustomerPurchaseOrderReleaseItemDetail[i].seatInsert,
                    customerPurchaseOrderReleaseItemDetailStemQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].stem,
                    
                    customerPurchaseOrderReleaseItemDetailSealQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].seal,
                    customerPurchaseOrderReleaseItemDetailBoltQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].bolting,
                    customerPurchaseOrderReleaseItemDetailDiscQuotation        : data.listCustomerPurchaseOrderReleaseItemDetail[i].disc,
                    customerPurchaseOrderReleaseItemDetailPlatesQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].plates,
                    customerPurchaseOrderReleaseItemDetailShaftQuotation       : data.listCustomerPurchaseOrderReleaseItemDetail[i].shaft,
                    customerPurchaseOrderReleaseItemDetailSpringQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].spring,
                    
                    customerPurchaseOrderReleaseItemDetailArmPinQuotation      : data.listCustomerPurchaseOrderReleaseItemDetail[i].armPin,
                    customerPurchaseOrderReleaseItemDetailBackSeatQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].backSeat,
                    customerPurchaseOrderReleaseItemDetailArmQuotation         : data.listCustomerPurchaseOrderReleaseItemDetail[i].arm,
                    customerPurchaseOrderReleaseItemDetailHingePinQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].hingePin,
                    customerPurchaseOrderReleaseItemDetailStopPinQuotation     : data.listCustomerPurchaseOrderReleaseItemDetail[i].stopPin,
                    customerPurchaseOrderReleaseItemDetailOperatorQuotation    : data.listCustomerPurchaseOrderReleaseItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyConstructionCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstName     : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyConstructionName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemTypeDesignCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemTypeDesignName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatDesignCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatDesignName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSizeCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSizeName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemRatingCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemRatingName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoreCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoreName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemEndConCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemEndConName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBodyName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBallCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBallName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatInsertCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSeatInsertName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStemCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStemName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSealCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSealName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoltCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBoltName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscCode          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemDiscCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscName          : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemDiscName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemPlatesCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemPlatesName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftCode         : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemShaftCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftName         : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemShaftName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSpringCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemSpringName,
                    
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinCode        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmPinCode, 
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinName        : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmPinName, 
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBackSeatCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemBackSeatName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmCode           : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmName           : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemArmName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemHingePinCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemHingePinName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinCode       : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStopPinCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinName       : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemStopPinName,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorCode      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemOperatorCode,
                    customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorName      : data.listCustomerPurchaseOrderReleaseItemDetail[i].itemOperatorName,
                    
                    customerPurchaseOrderReleaseItemDetailNote                 : data.listCustomerPurchaseOrderReleaseItemDetail[i].note,
                    customerPurchaseOrderReleaseItemDetailQuantity             : data.listCustomerPurchaseOrderReleaseItemDetail[i].quantity,
                    customerPurchaseOrderReleaseItemDetailPrice                : data.listCustomerPurchaseOrderReleaseItemDetail[i].unitPrice,
                    customerPurchaseOrderReleaseItemDetailTotal                : data.listCustomerPurchaseOrderReleaseItemDetail[i].totalAmount
                });
                calculateCustomerPurchaseOrderReleaseHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderReleaseSalesQuotation() {       
        var url = "sales/blanket-order-sales-quotation-data-release";
        var params = "blanketOrder.code="+$("#customerPurchaseOrderRelease\\.customerBlanketOrder\\.code").val();   
        
        customerPurchaseOrderReleaseSalesQuotationLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderReleaseSalesQuotation.length; i++) {
                customerPurchaseOrderReleaseSalesQuotationLastRowId++;
                
                $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseSalesQuotationLastRowId, data.listCustomerPurchaseOrderReleaseSalesQuotation[i]);
                $("#customerPurchaseOrderReleaseSalesQuotationInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseSalesQuotationLastRowId,{
                    customerPurchaseOrderReleaseSalesQuotationDelete           : "delete",
                    customerPurchaseOrderReleaseSalesQuotationSearch           : "...",
                    customerPurchaseOrderReleaseSalesQuotationCode             : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationCode,
                    customerPurchaseOrderReleaseSalesQuotationTransactionDate  : formatDateRemoveT(data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationTransactionDate,true),
                    customerPurchaseOrderReleaseSalesQuotationCustomerCode     : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationCustomerCode,
                    customerPurchaseOrderReleaseSalesQuotationCustomerName     : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationCustomerName,
                    customerPurchaseOrderReleaseSalesQuotationEndUserCode      : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationEndUserCode,
                    customerPurchaseOrderReleaseSalesQuotationEndUserName      : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationEndUserName,
                    customerPurchaseOrderReleaseSalesQuotationRfqCode          : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationRfqCode,
                    customerPurchaseOrderReleaseSalesQuotationProjectCode      : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationProject,
                    customerPurchaseOrderReleaseSalesQuotationSubject          : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationSubject,
                    customerPurchaseOrderReleaseSalesQuotationAttn             : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationAttn,
                    customerPurchaseOrderReleaseSalesQuotationRefNo            : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationRefNo,
                    customerPurchaseOrderReleaseSalesQuotationRemark           : data.listCustomerPurchaseOrderReleaseSalesQuotation[i].salesQuotationRemark
                });
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderReleaseAdditionalFee() {
        if($("#enumCustomerPurchaseOrderReleaseActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-release-additional-fee-data";
        var params = "customerPurchaseOrderRelease.code="+$("#customerPurchaseOrderRelease\\.customerPurchaseOrderReleaseCode").val();   
        
        customerPurchaseOrderReleaseAdditionalFeeLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderReleaseAdditionalFee.length; i++) {
                customerPurchaseOrderReleaseAdditionalFeeLastRowId++;
                
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseAdditionalFeeLastRowId, data.listCustomerPurchaseOrderReleaseAdditionalFee[i]);
                $("#customerPurchaseOrderReleaseAdditionalFeeInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseAdditionalFeeLastRowId,{
                    customerPurchaseOrderReleaseAdditionalFeeDelete                    : "delete",
                    customerPurchaseOrderReleaseAdditionalFeeRemark                    : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].remark,
                    customerPurchaseOrderReleaseAdditionalFeeQuantity                  : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].quantity,
                    customerPurchaseOrderReleaseAdditionalFeeSearchUnitOfMeasure       : "...",
                    customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode         : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].unitOfMeasureCode,
                    customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode         : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].additionalFeeCode,
                    customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeName         : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].additionalFeeName,
                    customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountCode   : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].coaCode,
                    customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountName   : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].coaName,
                    customerPurchaseOrderReleaseAdditionalFeePrice                     : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].price,
                    customerPurchaseOrderReleaseAdditionalFeeTotal                     : data.listCustomerPurchaseOrderReleaseAdditionalFee[i].total
                });
            }
            calculateCustomerPurchaseOrderReleaseTotalAdditional();
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderReleasePaymentTerm() {
        if($("#enumCustomerPurchaseOrderReleaseActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-release-payment-term-data";
        var params = "customerPurchaseOrderRelease.code="+$("#customerPurchaseOrderRelease\\.customerPurchaseOrderReleaseCode").val();   
        
        customerPurchaseOrderReleasePaymentTermLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderReleasePaymentTerm.length; i++) {
                customerPurchaseOrderReleasePaymentTermLastRowId++;
                
                $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid("addRowData", customerPurchaseOrderReleasePaymentTermLastRowId, data.listCustomerPurchaseOrderReleasePaymentTerm[i]);
                $("#customerPurchaseOrderReleasePaymentTermInput_grid").jqGrid('setRowData',customerPurchaseOrderReleasePaymentTermLastRowId,{
                    customerPurchaseOrderReleasePaymentTermDelete             : "delete",
                    customerPurchaseOrderReleasePaymentTermSearchPaymentTerm  : "...",
                    customerPurchaseOrderReleasePaymentTermSortNO             : data.listCustomerPurchaseOrderReleasePaymentTerm[i].sortNo,
                    customerPurchaseOrderReleasePaymentTermPaymentTermCode    : data.listCustomerPurchaseOrderReleasePaymentTerm[i].paymentTermCode,
                    customerPurchaseOrderReleasePaymentTermPaymentTermName    : data.listCustomerPurchaseOrderReleasePaymentTerm[i].paymentTermName,
                    customerPurchaseOrderReleasePaymentTermPercent            : data.listCustomerPurchaseOrderReleasePaymentTerm[i].percentage,
                    customerPurchaseOrderReleasePaymentTermRemark             : data.listCustomerPurchaseOrderReleasePaymentTerm[i].remark
                });
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderReleaseItemDeliveryDate(){
        if($("#enumCustomerPurchaseOrderReleaseActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-release-item-delivery-data";
        var params = "customerPurchaseOrderRelease.code="+$("#customerPurchaseOrderRelease\\.customerPurchaseOrderReleaseCode").val();   
        
        customerPurchaseOrderReleaseItemDeliveryLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderReleaseItemDeliveryDate.length; i++) {
                customerPurchaseOrderReleaseItemDeliveryLastRowId++;
                
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderReleaseItemDeliveryLastRowId, data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i]);
                $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderReleaseItemDeliveryLastRowId,{
                    customerPurchaseOrderReleaseItemDeliveryDelete                   : "delete",
                    customerPurchaseOrderReleaseItemDeliverySearchQuotation          : "...",
                    customerPurchaseOrderReleaseItemDeliverySalesQuotationCode       : data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i].salesQuotationCode,
                    customerPurchaseOrderReleaseItemDeliverySalesQuotationRefNo      : data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i].refNo,
                    customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsCode      : data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i].itemFinishGoodsCode,
                    customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsRemark    : data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i].itemFinishGoodsRemark,
                    customerPurchaseOrderReleaseItemDeliverySortNo                   : data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderReleaseItemDeliveryQuantity                 : data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i].quantity,
                    customerPurchaseOrderReleaseItemDeliveryDeliveryDate             : formatDateRemoveT(data.listCustomerPurchaseOrderReleaseItemDeliveryDate[i].deliveryDate,false)
                });
            }
        });
        closeLoading();
    }
    
    function customerPurchaseOrderReleaseInputGrid_SearchSalesQuotation_OnClick(){
        var customer=txtCustomerPurchaseOrderReleaseCustomerCode.val();
        var customerName=txtCustomerPurchaseOrderReleaseCustomerName.val();
        var endUser=txtCustomerPurchaseOrderReleaseEndUserCode.val();
        var endUserName=txtCustomerPurchaseOrderReleaseEndUserName.val();
        var salesPerson=txtCustomerPurchaseOrderReleaseSalesPersonCode.val();
        var salesPersonName=txtCustomerPurchaseOrderReleaseSalesPersonName.val();
        var project=txtCustomerPurchaseOrderReleaseProjectCode.val();
        var projectName=txtCustomerPurchaseOrderReleaseProjectName.val();
        var currency=txtCustomerPurchaseOrderReleaseCurrencyCode.val();
        var currencyName=txtCustomerPurchaseOrderReleaseCurrencyName.val();
        var branch = txtCustomerPurchaseOrderReleaseBranchCode.val();
        var branchName = txtCustomerPurchaseOrderReleaseBranchName.val();
        var orderStatus = $("#customerPurchaseOrderRelease\\.orderStatus").val();
        window.open("./pages/search/search-sales-quotation.jsp?iddoc=customerPurchaseOrderReleaseSalesQuotation&type=grid" +
        "&customer=" +customer +
        "&customerName=" +customerName +
        "&endUser="+endUser+
        "&endUserName="+endUserName+
        "&salesPerson="+salesPerson+
        "&salesPersonName="+salesPersonName+
        "&project="+project+
        "&projectName="+projectName+
        "&currency="+currency+
        "&currencyName="+currencyName+
        "&branch="+branch+
        "&branchName="+branchName+
        "&orderStatus="+orderStatus+
        "&firstDate="+$("#customerPurchaseOrderReleaseDateFirstSession").val()+"&lastDate="+$("#customerPurchaseOrderReleaseDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
    }
    
    function customerPurchaseOrderReleaseAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=customerPurchaseOrderReleaseAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function customerPurchaseOrderReleaseAdditionalFeeInputGrid_SearchChartOfAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerPurchaseOrderReleaseAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function customerPurchaseOrderReleaseAdditionalFeeInputGrid_SearchAdditional_OnClick(){
        window.open("./pages/search/search-additional-fee-sales.jsp?iddoc=customerPurchaseOrderReleaseAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function customerPurchaseOrderReleasePaymentTermInputGrid_SearchPaymentTerm_OnClick(){
        window.open("./pages/search/search-payment-term.jsp?iddoc=customerPurchaseOrderReleasePaymentTerm&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function customerPurchaseOrderReleaseItemDetailInputGrid_SearchItemFinishGoods_OnClick(){
        var customer=txtCustomerPurchaseOrderReleaseEndUserCode.val();
        window.open("./pages/search/search-item-finish-goods.jsp?iddoc=customerPurchaseOrderReleaseItemDetail&type=grid&idcustomer="+customer ,"Search", "scrollbars=1,width=600, height=500");
    }
    
    function sortNoDeliveryRL(itemCode){
         $('#customerPurchaseOrderReleaseItemDetailInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel); 
         var ids = jQuery("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getDataIDs');
         var temp="";
        for(var i=0;i<ids.length;i++){
                var Detail = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                if (itemCode===Detail.customerPurchaseOrderReleaseItemDetailItem){
                    temp=Detail.customerPurchaseOrderReleaseItemDetailSortNo;
                }
               
        }
        
         $('#customerPurchaseOrderReleaseItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderReleaseItemDelivery_lastSel); 
         var idt = jQuery("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getDataIDs');
         for(var i=0;i<idt.length;i++){
             var Details = $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getRowData',idt[i]); 
                if (itemCode===Details.customerPurchaseOrderReleaseItemDeliveryItemCode){
                    $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid("setCell",idt[i], "customerPurchaseOrderReleaseItemDeliverySortNo",temp);

                }
         }     
    }
    
    function customerPurchaseOrderReleaseItemDeliveryInputGrid_SearchQuotation_OnClick(){
      var ids = jQuery("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getDataIDs');
           
            if($("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;
                }
            }
            
            if(cpoSalesQuotation_lastSel !== -1) {
                $('#customerPurchaseOrderReleaseItemDeliveryInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel);  
            }
            
           var listSalesQuotationCode = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#customerPurchaseOrderReleaseItemDeliveryInput_grid").jqGrid('getRowData',ids[q]); 
                listSalesQuotationCode[q] = [data.customerPurchaseOrderReleaseItemDeliverySalesQuotationCode];
//                 (listCode);
            }
        window.open("./pages/search/search-sales-quotation-array.jsp?iddoc=customerPurchaseOrderReleaseItemDelivery&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function setCustomerPurchaseOrderReleasePartialShipmentStatusStatus(){
        switch($("#customerPurchaseOrderRelease\\.partialShipmentStatus").val()){
            case "YES":
                $('input[name="customerPurchaseOrderReleasePartialShipmentStatusRad"][value="YES"]').prop('checked',true);
                break;
            case "NO":
                $('input[name="customerPurchaseOrderReleasePartialShipmentStatusRad"][value="NO"]').prop('checked',true);
                break;
        } 
    }
    
    function cpoRLTransactionDateOnChange(){
        if($("#enumCustomerPurchaseOrderReleaseActivity").val()!=="UPDATE"){
            $("#customerPurchaseOrderReleaseTransactionDate").val(dtpCustomerPurchaseOrderReleaseTransactionDate.val());
        }
        if($("#enumCustomerPurchaseOrderReleaseActivity").val()!=="REVISE"){
            $("#customerPurchaseOrderReleaseTransactionDate").val(dtpCustomerPurchaseOrderReleaseTransactionDate.val());
        }
        if($("#enumCustomerPurchaseOrderReleaseActivity").val()!=="CLONE"){
            $("#customerPurchaseOrderReleaseTransactionDate").val(dtpCustomerPurchaseOrderReleaseTransactionDate.val());
        }
    }
    
    function avoidSpcCharCpoRl(){
        
        var selectedRowID = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerPurchaseOrderReleaseItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerPurchaseOrderReleaseItemDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_customerPurchaseOrderReleaseItemDetailSortNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep = str.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_customerPurchaseOrderReleaseItemDetailSortNo").val(rep);
        }
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_customerPurchaseOrderReleaseItemDetailSortNo").val("");
        }
    }
    
//    function formatDateRemoveT(date, useTime) {
//        var dateValues = date.split('T');
//        var dateValuesTemp = dateValues[0].split('-');
//        var dateValue = dateValuesTemp[2] + "/" + dateValuesTemp[1] + "/" + dateValuesTemp[0];
//        var dateValuesTemps;
//
//        if (useTime) {
//            dateValuesTemps = dateValue + ' ' + dateValues[1];
//        } else {
//            dateValuesTemps = dateValue;
//        }
//
//        return dateValuesTemps;
//    }
</script>

<s:url id="remoteurlCustomerPurchaseOrderReleaseSalesQuotationInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderReleaseAdditionalFeeInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderReleasePaymentTermInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderReleaseItemDeliveryInput" action="" />
<b>CUSTOMER PURCHASE ORDER RELEASE</b><span id="msgCustomerPurchaseOrderReleaseActivity"></span>
<hr>
<br class="spacer" />

<div id="customerPurchaseOrderReleaseInput" class="content ui-widget">
    <s:form id="frmCustomerPurchaseOrderReleaseInput">
        <table cellpadding="2" cellspacing="2" id="headerCustomerPurchaseOrderReleaseInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" style="width:180px"><B>CPO-RL No *</B></td>
                            <td>
                                <s:textfield id="customerPurchaseOrderRelease.code" name="customerPurchaseOrderRelease.code" key="customerPurchaseOrderRelease.code" readonly="true" size="30"></s:textfield>
                                <s:textfield id="customerPurchaseOrderRelease.customerPurchaseOrderReleaseCode" name="customerPurchaseOrderRelease.customerPurchaseOrderReleaseCode" key="customerPurchaseOrderRelease.customerPurchaseOrderReleaseCode" readonly="true" size="25" disabled="true" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ref POC No *</B></td>
                            <td>
                                <s:textfield id="customerPurchaseOrderRelease.custPONo" name="customerPurchaseOrderRelease.custPONo" key="customerPurchaseOrderRelease.custPONo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                                <s:textfield id="customerPurchaseOrderRelease.refCUSTPOCode" name="customerPurchaseOrderRelease.refCUSTPOCode" key="customerPurchaseOrderRelease.refCUSTPOCode" readonly="true" size="30"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="customerPurchaseOrderRelease.revision" name="customerPurchaseOrderRelease.revision" key="customerPurchaseOrderRelease.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                txtCustomerPurchaseOrderReleaseBranchCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderReleaseBranchCode.val()===""){
                                        txtCustomerPurchaseOrderReleaseBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get";
                                    var params = "branch.code=" + txtCustomerPurchaseOrderReleaseBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtCustomerPurchaseOrderReleaseBranchCode.val(data.branchTemp.code);
                                            txtCustomerPurchaseOrderReleaseBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtCustomerPurchaseOrderReleaseBranchCode);
                                            txtCustomerPurchaseOrderReleaseBranchCode.val("");
                                            txtCustomerPurchaseOrderReleaseBranchName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerPurchaseOrderRelease.branch.code" name="customerPurchaseOrderRelease.branch.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrderRelease_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerPurchaseOrderRelease.branch.name" name="customerPurchaseOrderRelease.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="customerPurchaseOrderRelease.transactionDate" name="customerPurchaseOrderRelease.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" onchange="cpoRLTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                                <sj:datepicker id="customerPurchaseOrderReleaseTransactionDate" name="customerPurchaseOrderReleaseTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right"><B>Order Status * </B></td>
                            <td colspan="2">
                                <s:radio id="customerPurchaseOrderReleaseOrderStatusRad" name="customerPurchaseOrderReleaseOrderStatusRad" label="customerPurchaseOrderReleaseOrderStatusRad" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio>
                                <s:textfield id="customerPurchaseOrderRelease.orderStatus" name="customerPurchaseOrderRelease.orderStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="customerPurchaseOrderRelease.purchaseOrderType" name="customerPurchaseOrderRelease.purchaseOrderType" size="20" readonly="true" value="CPO-RL"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order No *</B></td>
                            <td colspan="3"><s:textfield id="customerPurchaseOrderRelease.customerPurchaseOrderNo" name="customerPurchaseOrderRelease.customerPurchaseOrderNo" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Blanket Order *</B></td>
                            <td colspan="2">
<!--                            <script type = "text/javascript">
                                txtCustomerPurchaseOrderReleaseBlanketOrderCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderReleaseBlanketOrderCode.val()===""){
                                        txtCustomerPurchaseOrderReleaseCustomerPurchaseOrderCode.val("");
                                        return;
                                    }
                                    var url = "sales/blanket-order-get";
                                    var params = "branch.code=" + txtCustomerPurchaseOrderReleaseBlanketOrderCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerBlanketOrder){
                                            txtCustomerPurchaseOrderReleaseBlanketOrderCode.val(data.customerBlanketOrder.code);
                                            txtCustomerPurchaseOrderReleaseCustomerPurchaseOrderCode.val(data.customerBlanketOrder.name);
                                        }
                                        else{
                                            alertMessage("Blanket Order Not Found!",txtCustomerPurchaseOrderReleaseBlanketOrderCode);
                                            txtCustomerPurchaseOrderReleaseBlanketOrderCode.val("");
                                            txtCustomerPurchaseOrderReleaseCustomerPurchaseOrderCode.val("");
                                        }
                                    });
                                });
                            </script>-->
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="customerPurchaseOrderRelease.customerBlanketOrder.code" name="customerPurchaseOrderRelease.customerBlanketOrder.code" size="25" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrderRelease_btnBlanketOrder" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                        </tr>
                        <tr>
                            <td align="right">CPO-BO No</td>
                            <td>
                            <s:textfield id="customerPurchaseOrderRelease.customerBlanketOrder.customerPurchaseOrder.code" name="customerPurchaseOrderRelease.customerBlanketOrder.customerPurchaseOrder.code" size="25" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Customer</td>
                            <td colspan="2">
                                <s:textfield id="customerPurchaseOrderRelease.customer.code" name="customerPurchaseOrderRelease.customer.code" size="22" readonly="true"></s:textfield>
                                <s:textfield id="customerPurchaseOrderRelease.customer.name" name="customerPurchaseOrderRelease.customer.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">End user</td>
                            <td colspan="2">
                                <s:textfield id="customerPurchaseOrderRelease.endUser.code" name="customerPurchaseOrderRelease.endUser.code" size="22" readonly="true"></s:textfield>
                                <s:textfield id="customerPurchaseOrderRelease.endUser.name" name="customerPurchaseOrderRelease.endUser.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Partial Shipment * </B></td>
                            <td colspan="2">
                                <s:radio id="customerPurchaseOrderReleasePartialShipmentStatusRad" name="customerPurchaseOrderReleasePartialShipmentStatusRad" label="customerPurchaseOrderReleasePartialShipmentStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="customerPurchaseOrderRelease.partialShipmentStatus" name="customerPurchaseOrderRelease.partialShipmentStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Retention</td>
                            <td>
                                <s:textfield id="customerPurchaseOrderRelease.retentionPercent" name="customerPurchaseOrderRelease.retentionPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right">Currency</td>
                            <td colspan="2">
                                <s:textfield id="customerPurchaseOrderRelease.currency.code" name="customerPurchaseOrderRelease.currency.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="customerPurchaseOrderRelease.currency.name" name="customerPurchaseOrderRelease.currency.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Sales Person</td>
                            <td colspan="2">
                                <s:textfield id="customerPurchaseOrderRelease.salesPerson.code" name="customerPurchaseOrderRelease.salesPerson.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="customerPurchaseOrderRelease.salesPerson.name" name="customerPurchaseOrderRelease.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Project</td>
                            <td colspan="2">
                                <s:textfield id="customerPurchaseOrderRelease.project.code" name="customerPurchaseOrderRelease.project.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="customerPurchaseOrderRelease.project.name" name="customerPurchaseOrderRelease.project.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3"><s:textfield id="customerPurchaseOrderRelease.refNo" name="customerPurchaseOrderRelease.refNo" size="27"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="customerPurchaseOrderRelease.remark" name="customerPurchaseOrderRelease.remark"  cols="70" rows="2" height="20"></s:textarea></td>
                        </tr> 
                    </table>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="customerPurchaseOrderReleaseDateFirstSession" name="customerPurchaseOrderReleaseDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="customerPurchaseOrderReleaseDateLastSession" name="customerPurchaseOrderReleaseDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumCustomerPurchaseOrderReleaseActivity" name="enumCustomerPurchaseOrderReleaseActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="customerPurchaseOrderRelease.createdBy" name="customerPurchaseOrderRelease.createdBy" key="customerPurchaseOrderRelease.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="customerPurchaseOrderRelease.createdDate" name="customerPurchaseOrderRelease.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="customerPurchaseOrderRelease.createdDateTemp" name="customerPurchaseOrderRelease.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderRelease" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderRelease" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>          
        <br class="spacer" />
        <div id="customerPurchaseOrderReleaseSalesQuotationInputGrid">
            <sjg:grid
                id="customerPurchaseOrderReleaseSalesQuotationInput_grid"
                caption="Sales Quotation"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listCustomerPurchaseOrderReleaseTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuCustomerPurchaseOrderReleaseDetail').width()"
                editurl="%{remoteurlCustomerPurchaseOrderReleaseSalesQuotationInput}"
                onSelectRowTopics="customerPurchaseOrderReleaseSalesQuotationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotation" index="customerPurchaseOrderReleaseSalesQuotation" key="customerPurchaseOrderReleaseSalesQuotation" 
                    title="" width="50" sortable="true" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationDelete" index="customerPurchaseOrderReleaseSalesQuotationDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'customerPurchaseOrderReleaseSalesQuotationInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationCode" index="customerPurchaseOrderReleaseSalesQuotationCode" 
                    title="SLS-QUO No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationTransactionDate" index="customerPurchaseOrderReleaseSalesQuotationTransactionDate" key="customerPurchaseOrderReleaseSalesQuotationTransactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationCustomerCode" index="customerPurchaseOrderReleaseSalesQuotationCustomerCode" 
                    title="Customer Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationCustomerName" index="customerPurchaseOrderReleaseSalesQuotationCustomerName" 
                    title="Customer Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationEndUserCode" index="customerPurchaseOrderReleaseSalesQuotationEndUserCode" 
                    title="End User Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationEndUserName" index="customerPurchaseOrderReleaseSalesQuotationEndUserName" 
                    title="End User Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "customerPurchaseOrderReleaseSalesQuotationRfqCode" index = "customerPurchaseOrderReleaseSalesQuotationRfqCode" key = "customerPurchaseOrderReleaseSalesQuotationRfqCode" 
                    title = "RFQ No" width = "80" edittype="text" 
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationProjectCode" index="customerPurchaseOrderReleaseSalesQuotationProjectCode" 
                    title="Project" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationSubject" index="customerPurchaseOrderReleaseSalesQuotationSubject" 
                    title="Subject" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationAttn" index="customerPurchaseOrderReleaseSalesQuotationAttn" 
                    title="Attn" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationRefNo" index="customerPurchaseOrderReleaseSalesQuotationRefNo" key="customerPurchaseOrderReleaseSalesQuotationRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderReleaseSalesQuotationRemark" index="customerPurchaseOrderReleaseSalesQuotationRemark" key="customerPurchaseOrderReleaseSalesQuotationRemark" 
                    title="Remark" width="150" sortable="true"
                />
            </sjg:grid >   
        </div>        
        <table>    
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderReleaseSalesQuotation" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderReleaseSalesQuotation" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderReleaseSalesQuotationDetailSort" button="true" style="width: 70px">Sort No</sj:a>
                </td>
            </tr>
        </table>
        <div id="id-tbl-additional-payment-item-delivery-release-rl">
            <div>
                <sjg:grid
                    id="customerPurchaseOrderReleaseItemDetailInput_grid"
                    caption="Item"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listCustomerPurchaseOrderReleaseItemDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnucustomerpurchaseOrder').width()"
                    editurl="%{remoteurlCustomerPurchaseOrderReleaseSalesQuotationInput}"
                    onSelectRowTopics="customerPurchaseOrderReleaseItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetail" index="customerPurchaseOrderReleaseItemDetail" key="customerPurchaseOrderReleaseItemDetail" 
                        title="" width="50" sortable="true" editable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailDelete" index="customerPurchaseOrderReleaseItemDetailDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'customerPurchaseOrderReleaseItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />                    
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode" index="customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode" key="customerPurchaseOrderReleaseItemDetailQuotationNoDetailCode" 
                        title="Quotation No " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailQuotationNo" index="customerPurchaseOrderReleaseItemDetailQuotationNo" key="customerPurchaseOrderReleaseItemDetailQuotationNo" 
                        title="Quotation No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailQuotationRefNo" index="customerPurchaseOrderReleaseItemDetailQuotationRefNo" key="customerPurchaseOrderReleaseItemDetailQuotationRefNo" 
                        title="Ref No" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSortNo" index="customerPurchaseOrderReleaseItemDetailSortNo" 
                        title="Sort No" width="80" sortable="true" editable="true" edittype="text" formatter="integer"
                        editoptions="{onKeyUp:'avoidSpcCharCpoRl()'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSearchItemFinishGoods" index="customerPurchaseOrderReleaseItemDetailSearchItemFinishGoods" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"
                        editoptions="{onClick:'customerPurchaseOrderReleaseItemDetailInputGrid_SearchItemFinishGoods_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode" key="customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode" 
                        title="Item Finish Goods Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark" key="customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailValveTypeCode" index="customerPurchaseOrderReleaseItemDetailValveTypeCode" key="customerPurchaseOrderReleaseItemDetailValveTypeCode" 
                        title="Valve Type Code (QUO)" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailValveTypeName" index="customerPurchaseOrderReleaseItemDetailValveTypeName" key="customerPurchaseOrderReleaseItemDetailValveTypeName" 
                        title="Valve Type Name (QUO)" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemAlias" index="customerPurchaseOrderReleaseItemDetailItemAlias" 
                        title="Item Alias" width="100" sortable="true" editable="true" edittype="text"
                    /> 
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailValveTag" index="customerPurchaseOrderReleaseItemDetailValveTag" 
                        title="Valve Tag" width="100" sortable="true" editable="true" edittype="text"
                    />  
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailDataSheet" index="customerPurchaseOrderReleaseItemDetailDataSheet" 
                        title="Data Sheet" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailDescription" index="customerPurchaseOrderReleaseItemDetailDescription" 
                        title="Description" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <!--Body Const 01-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailBodyConstQuotation" index="customerPurchaseOrderReleaseItemDetailBodyConstQuotation" 
                        title="QUO (01)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstCode" 
                        title="IFG (01)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyConstName" 
                        title="IFG (01)" width="100" sortable="true"
                    />
                    <!--Type Design 02-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailTypeDesignQuotation" index="customerPurchaseOrderReleaseItemDetailTypeDesignQuotation" 
                        title="QUO (02)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignCode" 
                        title="IFG (02)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsTypeDesignName" 
                        title="IFG (02)" width="100" sortable="true"
                    />
                    <!--Seat Design 03-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSeatDesignQuotation" index="customerPurchaseOrderReleaseItemDetailSeatDesignQuotation" 
                        title="QUO (03)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignCode" 
                        title="IFG (03)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatDesignName" 
                        title="IFG (03)" width="100" sortable="true"
                    />
                    <!--Size 04-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSizeQuotation" index="customerPurchaseOrderReleaseItemDetailSizeQuotation" 
                        title="QUO (04)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeCode" 
                        title="IFG (04)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSizeName" 
                        title="IFG (04)" width="100" sortable="true"
                    />
                    <!--Rating 05-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailRatingQuotation" index="customerPurchaseOrderReleaseItemDetailRatingQuotation" 
                        title="QUO (05)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingCode" 
                        title="IFG (05)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsRatingName" 
                        title="IFG (05)" width="100" sortable="true"
                    />
                    <!--Bore 06-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailBoreQuotation" index="customerPurchaseOrderReleaseItemDetailBoreQuotation" 
                        title="QUO (06)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreCode" 
                        title="IFG (06)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoreName" 
                        title="IFG (06)" width="100" sortable="true"
                    />
                    <!--EndCon 07-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailEndConQuotation" index="customerPurchaseOrderReleaseItemDetailEndConQuotation" 
                        title="QUO (07)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConCode" 
                        title="IFG (07)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsEndConName" 
                        title="IFG (07)" width="100" sortable="true"
                    />
                    <!--Body 08-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailBodyQuotation" index="customerPurchaseOrderReleaseItemDetailBodyQuotation" 
                        title="QUO (08)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyCode" 
                        title="IFG (08)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBodyName" 
                        title="IFG (08)" width="100" sortable="true"
                    />
                    <!--Ball 09-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailBallQuotation" index="customerPurchaseOrderReleaseItemDetailBallQuotation" 
                        title="QUO (09)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallCode" 
                        title="IFG (09)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBallName" 
                        title="IFG (09)" width="100" sortable="true"
                    />
                    <!--Seat 10-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSeatQuotation" index="customerPurchaseOrderReleaseItemDetailSeatQuotation" 
                        title="QUO (10)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatCode" 
                        title="IFG (10)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatName" 
                        title="IFG (10)" width="100" sortable="true"
                    />
                    <!--SeatInsert 11-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSeatInsertQuotation" index="customerPurchaseOrderReleaseItemDetailSeatInsertQuotation" 
                        title="QUO (11)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertCode" 
                        title="IFG (11)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSeatInsertName" 
                        title="IFG (11)" width="100" sortable="true"
                    />
                    <!--Stem 12-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailStemQuotation" index="customerPurchaseOrderReleaseItemDetailStemQuotation" 
                        title="QUO (12)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemCode" 
                        title="IFG (12)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStemName" 
                        title="IFG (12)" width="100" sortable="true"
                    />
                    <!--Seal 13-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSealQuotation" index="customerPurchaseOrderReleaseItemDetailSealQuotation" 
                        title="QUO (13)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealCode" 
                        title="IFG (13)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSealName" 
                        title="IFG (13)" width="100" sortable="true"
                    />
                    <!--Bolt 14-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailBoltQuotation" index="customerPurchaseOrderReleaseItemDetailBoltQuotation" 
                        title="QUO (14)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltCode" 
                        title="IFG (14)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBoltName" 
                        title="IFG (14)" width="100" sortable="true"
                    />
                    <!--Disc 15-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailDiscQuotation" index="customerPurchaseOrderReleaseItemDetailDiscQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsDiscName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Plates 16-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailPlatesQuotation" index="customerPurchaseOrderReleaseItemDetailPlatesQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsPlatesName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Shaft 17-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailShaftQuotation" index="customerPurchaseOrderReleaseItemDetailShaftQuotation" 
                        title="QUO (17)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftCode" 
                        title="IFG (17)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsShaftName" 
                        title="IFG (17)" width="100" sortable="true"
                    />
                    <!--Spring 18-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailSpringQuotation" index="customerPurchaseOrderReleaseItemDetailSpringQuotation" 
                        title="QUO (18)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringCode" 
                        title="IFG (18)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsSpringName" 
                        title="IFG (18)" width="100" sortable="true"
                    />
                    <!--ArmPin 19-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailArmPinQuotation" index="customerPurchaseOrderReleaseItemDetailArmPinQuotation" 
                        title="QUO (19)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinCode" 
                        title="IFG (19)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmPinName" 
                        title="IFG (19)" width="100" sortable="true"
                    />
                    <!--BackSeat 20-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailBackSeatQuotation" index="customerPurchaseOrderReleaseItemDetailBackSeatQuotation" 
                        title="QUO (20)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatCode" 
                        title="IFG (20)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsBackSeatName" 
                        title="IFG (20)" width="100" sortable="true"
                    />
                    <!--Arm 21-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailArmQuotation" index="customerPurchaseOrderReleaseItemDetailArmQuotation" 
                        title="QUO (21)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmCode" 
                        title="IFG (21)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsArmName" 
                        title="IFG (21)" width="100" sortable="true"
                    />
                    <!--HingePin 22-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailHingePinQuotation" index="customerPurchaseOrderReleaseItemDetailHingePinQuotation" 
                        title="QUO (22)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinCode" 
                        title="IFG (22)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsHingePinName" 
                        title="IFG (22)" width="100" sortable="true"
                    />
                    <!--StopPin 23-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailStopPinQuotation" index="customerPurchaseOrderReleaseItemDetailStopPinQuotation" 
                        title="QUO (23)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinCode" 
                        title="IFG (23)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsStopPinName" 
                        title="IFG (23)" width="100" sortable="true"
                    />
                    <!--Operator 99-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailOperatorQuotation" index="customerPurchaseOrderReleaseItemDetailOperatorQuotation" 
                        title="QUO (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorCode" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorCode" 
                        title="IFG (99)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorName" index="customerPurchaseOrderReleaseItemDetailItemFinishGoodsOperatorName" 
                        title="IFG (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailNote" index="customerPurchaseOrderReleaseItemDetailNote" title="Note" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailQuantity" index="customerPurchaseOrderReleaseItemDetailQuantity" key="customerPurchaseOrderReleaseItemDetailQuantity" title="Qty" 
                        width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                        formatter="number" editrules="{ double: true }"
                        editoptions="{onKeyUp:'calculateItemSalesQuotationDetailRelease()'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailPrice" index="customerPurchaseOrderReleaseItemDetailPrice" key="customerPurchaseOrderReleaseItemDetailPrice" title="Unit Price" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderReleaseItemDetailTotal" index="customerPurchaseOrderReleaseItemDetailTotal" key="customerPurchaseOrderReleaseItemDetailTotal" title="Total" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                </sjg:grid >
            </div>
            <div>
                <table width="100%">
                    <tr height="10px"/>
                    <tr>
                        <td>
                            <sjg:grid
                                id="customerPurchaseOrderReleaseAdditionalFeeInput_grid"
                                caption="Additional"
                                dataType="local"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listCustomerPurchaseOrderReleaseAdditionalFee"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false"
                                editinline="true"
                                width="$('#tabmnuCustomerPurchaseOrderReleaseAdditionalFee').width()"
                                editurl="%{remoteurlCustomerPurchaseOrderReleaseAdditionalFeeInput}"
                                onSelectRowTopics="customerPurchaseOrderReleaseAdditionalFeeInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFee" index="customerPurchaseOrderReleaseAdditionalFee" key="customerPurchaseOrderReleaseAdditionalFee" 
                                    title="" width="50" sortable="true" editable="true" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeDelete" index="customerPurchaseOrderReleaseAdditionalFeeDelete" title="" width="50" align="centre"
                                    editable="true" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderReleaseAdditionalFeeInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeRemark" index="customerPurchaseOrderReleaseAdditionalFeeRemark" key="customerPurchaseOrderReleaseAdditionalFeeRemark" 
                                    title="Remark" width="150" sortable="true" editable="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeQuantity" index="customerPurchaseOrderReleaseAdditionalFeeQuantity" key="customerPurchaseOrderReleaseAdditionalFeeQuantity" title="Quantity" 
                                    width="80" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateCustomerPurchaseOrderReleaseAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeSearchUnitOfMeasure" index="customerPurchaseOrderReleaseAdditionalFeeSearchUnitOfMeasure" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderReleaseAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode" index="customerPurchaseOrderReleaseAdditionalFeeUnitOfMeasureCode" 
                                    title="Unit" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeUnitOfMeasureCodeCPORL()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeSearchAdditional" index="customerPurchaseOrderReleaseAdditionalFeeSearchAdditional" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderReleaseAdditionalFeeInputGrid_SearchAdditional_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode" index="customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeCode" 
                                    title="Additional Fee Code" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeCodeCPORL()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeName" index="customerPurchaseOrderReleaseAdditionalFeeAdditionalFeeName" 
                                    title="Additional Fee Name" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountCode" index="customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountCode" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountName" index="customerPurchaseOrderReleaseAdditionalFeeSalesChartOfAccountName" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeePrice" index="customerPurchaseOrderReleaseAdditionalFeePrice" key="customerPurchaseOrderReleaseAdditionalFeePrice" title="Price" 
                                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateCustomerPurchaseOrderReleaseAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderReleaseAdditionalFeeTotal" index="customerPurchaseOrderReleaseAdditionalFeeTotal" key="customerPurchaseOrderReleaseAdditionalFeeTotal" title="Total" 
                                    width="150" align="right" edittype="text"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                            </sjg:grid >
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="customerPurchaseOrderReleaseAdditionalFeeAddRow" name="customerPurchaseOrderReleaseAdditionalFeeAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                            <sj:a href="#" id="btnCustomerPurchaseOrderReleaseAdditionalFeeAdd" button="true"  style="width: 60px">Add</sj:a>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                 <table width="100%">
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="customerPurchaseOrderReleasePaymentTermInput_grid"
                                            caption="Payment Term"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerPurchaseOrderReleasePaymentTerm"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlCustomerPurchaseOrderReleasePaymentTermInput}"
                                            onSelectRowTopics="customerPurchaseOrderReleasePaymentTermInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTerm" index="customerPurchaseOrderReleasePaymentTerm" 
                                                title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                            />  
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTermDelete" index="customerPurchaseOrderReleasePaymentTermDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderReleasePaymentTermInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTermSortNO" index="customerPurchaseOrderReleasePaymentTermSortNO" key="customerPurchaseOrderReleasePaymentTermSortNO" title="Term No" 
                                                width="80" align="right" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTermPaymentTermCode" index="customerPurchaseOrderReleasePaymentTermPaymentTermCode" 
                                                title="Payment Term Code" width="100" sortable="true" editable="true" edittype="text"
                                                editoptions="{onChange:'onchangePaymentTermPaymentTermCodeCPORL()'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTermSearchPaymentTerm" index="customerPurchaseOrderReleasePaymentTermSearchPaymentTerm" title="" width="25" align="centre"
                                                editable="true" dataType="html" edittype="button" 
                                                editoptions="{onClick:'customerPurchaseOrderReleasePaymentTermInputGrid_SearchPaymentTerm_OnClick()', value:'...'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTermPaymentTermName" index="customerPurchaseOrderReleasePaymentTermPaymentTermName" 
                                                title="Payment Term" width="100" sortable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTermPercent" index="customerPurchaseOrderReleasePaymentTermPercent" key="customerPurchaseOrderReleasePaymentTermPercent" title="Percent" 
                                                width="80" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleasePaymentTermRemark" index="customerPurchaseOrderReleasePaymentTermRemark" 
                                                title="Note" width="200" sortable="true" edittype="text" editable="true"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderReleasePaymentTermAddRow" name="customerPurchaseOrderReleasePaymentTermAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnCustomerPurchaseOrderReleasePaymentTermAdd" button="true"  style="width: 60px">Add</sj:a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table valign="top">
                                <tr>
                                    <td width="120px" align="right"><B>Total Transaction</B></td>
                                    <td width="120px">
                                        <s:textfield id="customerPurchaseOrderRelease.totalTransactionAmount" name="customerPurchaseOrderRelease.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Disc
                                        <s:textfield id="customerPurchaseOrderRelease.discountPercent" name="customerPurchaseOrderRelease.discountPercent" onkeyup="calculateCustomerPurchaseOrderReleaseHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                    <s:textfield id="customerPurchaseOrderRelease.discountAmount" name="customerPurchaseOrderRelease.discountAmount" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Additional</td>
                                    <td>
                                    <s:textfield id="customerPurchaseOrderRelease.totalAdditionalFeeAmount" name="customerPurchaseOrderRelease.totalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" disabled="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><b>Sub Total(Tax Base)</b></td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderRelease.taxBaseAmount" name="customerPurchaseOrderRelease.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">VAT
                                        <s:textfield id="customerPurchaseOrderRelease.vatPercent" name="customerPurchaseOrderRelease.vatPercent" onkeyup="calculateCustomerPurchaseOrderReleaseHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderRelease.vatAmount" name="customerPurchaseOrderRelease.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Grand Total</B></td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderRelease.grandTotalAmount" name="customerPurchaseOrderRelease.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
            <table>
                <tr>
                    <td align="left">
                        <sj:a href="#" id="btnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderReleaseItemDetailDelivery" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>                
            <div id="id-tbl-additional-item-delivery-detail-release-rl">
                <table>
                    <tr>
                        <td align="right">Delivery Date
                            <sj:datepicker id="customerPurchaseOrderReleaseDeliveryDateSet" name="customerPurchaseOrderReleaseDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today"></sj:datepicker>
                            <sj:a href="#" id="btnCustomerPurchaseOrderReleaseDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;
                            <sj:a href="#" id="btnCustomerPurchaseOrderReleaseCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="customerPurchaseOrderReleaseItemDeliveryInput_grid"
                                            caption="Item Delivery Date"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerPurchaseOrderReleaseItemDeliveryDate"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlCustomerPurchaseOrderReleaseItemDeliveryInput}"
                                            onSelectRowTopics="customerPurchaseOrderReleaseItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleaseItemDelivery" index="customerPurchaseOrderReleaseItemDelivery" key="customerPurchaseOrderReleaseItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleaseItemDeliveryDelete" index="customerPurchaseOrderReleaseItemDeliveryDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderReleaseItemDeliveryInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleaseItemDeliverySearchQuotation" index="customerPurchaseOrderReleaseItemDeliverySearchQuotation" title="" width="25" align="centre"
                                                editable="true"
                                                dataType="html"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderReleaseItemDeliveryInputGrid_SearchQuotation_OnClick()', value:'...'}"
                                            /> 
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsCode" index = "customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsCode" key = "customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsCode" 
                                                title = "Item Finish Goods Code" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsRemark" index = "customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsRemark" key = "customerPurchaseOrderReleaseItemDeliveryItemFinishGoodsRemark" 
                                                title = "IFG Remark" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleaseItemDeliverySortNo" index="customerPurchaseOrderReleaseItemDeliverySortNo" title="Sort No" width="80" sortable="true"
                                            />  
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleaseItemDeliveryQuantity" index="customerPurchaseOrderReleaseItemDeliveryQuantity" key="customerPurchaseOrderReleaseItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleaseItemDeliveryDeliveryDate" index="customerPurchaseOrderReleaseItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="true" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangeCustomerPurchaseOrderReleaseItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderReleaseItemDeliveryDeliveryDateTemp" index="customerPurchaseOrderReleaseItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderReleaseItemDeliverySalesQuotationCode" index = "customerPurchaseOrderReleaseItemDeliverySalesQuotationCode" key = "customerPurchaseOrderReleaseItemDeliverySalesQuotationCode" 
                                                title = "Quotation No" width = "100"
                                            />
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderReleaseItemDeliverySalesQuotationRefNo" index = "customerPurchaseOrderReleaseItemDeliverySalesQuotationRefNo" key = "customerPurchaseOrderReleaseItemDeliverySalesQuotationRefNo" 
                                                title = "Ref No" width = "100"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderReleaseItemDelieryAddRow" name="customerPurchaseOrderReleaseItemDelieryAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnCustomerPurchaseOrderReleaseItemDelieryAdd" button="true"  style="width: 60px">Add</sj:a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        
        <br class="spacer" />
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnCustomerPurchaseOrderReleaseSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnCustomerPurchaseOrderReleaseCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    