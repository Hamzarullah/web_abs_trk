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
    .ui-dialog-titlebar-close,#blanketOrderSalesQuotationInput_grid_pager_center,
    #blanketOrderItemDetailInput_grid_pager_center,#blanketOrderAdditionalFeeInput_grid_pager_center,
    #blanketOrderPaymentTermInput_grid_pager_center,#blanketOrderItemDeliveryInput_grid_pager_center{
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
    
    var blanketOrderSalesQuotationLastRowId=0,blanketOrderSalesQuotation_lastSel = -1;
    var blanketOrderItemDetailLastRowId=0,blanketOrderItemDetail_lastSel = -1;
    var blanketOrderAdditionalFeeLastRowId=0,blanketOrderAdditionalFee_lastSel = -1;
    var blanketOrderPaymentTermLastRowId=0,blanketOrderPaymentTerm_lastSel = -1;
    var blanketOrderItemDeliveryLastRowId=0,blanketOrderItemDelivery_lastSel = -1;
    var cpoSalesQuotation_lastSel = -1;
    var 
        txtBlanketOrderCode = $("#blanketOrder\\.code"),
        dtpBlanketOrderTransactionDate = $("#blanketOrder\\.transactionDate"),
        txtBlanketOrderCustomerCode= $("#blanketOrder\\.customer\\.code"),
        txtBlanketOrderCustomerName= $("#blanketOrder\\.customer\\.name"),
        txtBlanketOrderEndUserCode= $("#blanketOrder\\.endUser\\.code"),
        txtBlanketOrderEndUserName= $("#blanketOrder\\.endUser\\.name"),
        txtBlanketOrderRetention= $("#blanketOrder\\.customerPurchaseOrder\\.retentionPercent"),
        txtBlanketOrderCurrencyCode= $("#blanketOrder\\.currency\\.code"),
        txtBlanketOrderCurrencyName= $("#blanketOrder\\.currency\\.name"),
        txtBlanketOrderBranchCode= $("#blanketOrder\\.branch\\.code"),
        txtBlanketOrderBranchName= $("#blanketOrder\\.branch\\.name"),
        txtBlanketOrderSalesPersonCode= $("#blanketOrder\\.salesPerson\\.code"),
        txtBlanketOrderSalesPersonName= $("#blanketOrder\\.salesPerson\\.name"),
        txtBlanketOrderProjectCode= $("#blanketOrder\\.project\\.code"),
        txtBlanketOrderProjectName= $("#blanketOrder\\.project\\.name"),
        txtBlanketOrderRefNo = $("#blanketOrder\\.refNo"),
        txtBlanketOrderRemark = $("#blanketOrder\\.remark"),
        txtBlanketOrderTotalTransactionAmount = $("#blanketOrder\\.totalTransactionAmount"),
        txtBlanketOrderDiscountPercent = $("#blanketOrder\\.discountPercent"),
        txtBlanketOrderDiscountAmount = $("#blanketOrder\\.discountAmount"),
        txtBlanketOrderTotalAdditionalFee= $("#blanketOrder\\.totalAdditionalFeeAmount"),
        txtBlanketOrderTaxBaseAmount= $("#blanketOrder\\.taxBaseAmount"),
        txtBlanketOrderVATPercent = $("#blanketOrder\\.vatPercent"),
        txtBlanketOrderVATAmount = $("#blanketOrder\\.vatAmount"),
        txtBlanketOrderGrandTotalAmount = $("#blanketOrder\\.grandTotalAmount");

        function loadGridItemBO(){
             //function groupingHeader
                $("#blanketOrderItemDetailInput_grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true, 
                    groupHeaders:[
                          {startColumnName: 'blanketOrderItemDetailBodyConstQuotation', numberOfColumns: 3, titleText: 'Body Const'},
                          {startColumnName: 'blanketOrderItemDetailTypeDesignQuotation', numberOfColumns: 3, titleText: 'Type Design'},
                          {startColumnName: 'blanketOrderItemDetailSeatDesignQuotation', numberOfColumns: 3, titleText: 'Seat Design'},
                          {startColumnName: 'blanketOrderItemDetailSizeQuotation', numberOfColumns: 3, titleText: 'Size'},
                          {startColumnName: 'blanketOrderItemDetailRatingQuotation', numberOfColumns: 3, titleText: 'Rating'},
                          {startColumnName: 'blanketOrderItemDetailBoreQuotation', numberOfColumns: 3, titleText: 'Bore'},
                          
                          {startColumnName: 'blanketOrderItemDetailEndConQuotation', numberOfColumns: 3, titleText: 'End Con'},
                          {startColumnName: 'blanketOrderItemDetailBodyQuotation', numberOfColumns: 3, titleText: 'Body'},
                          {startColumnName: 'blanketOrderItemDetailBallQuotation', numberOfColumns: 3, titleText: 'Ball'},
                          {startColumnName: 'blanketOrderItemDetailSeatQuotation', numberOfColumns: 3, titleText: 'Seat'},
                          {startColumnName: 'blanketOrderItemDetailSeatInsertQuotation', numberOfColumns: 3, titleText: 'Seat Insert'},
                          {startColumnName: 'blanketOrderItemDetailStemQuotation', numberOfColumns: 3, titleText: 'Stem'},
                          
                          {startColumnName: 'blanketOrderItemDetailSealQuotation', numberOfColumns: 3, titleText: 'Seal'},
                          {startColumnName: 'blanketOrderItemDetailBoltQuotation', numberOfColumns: 3, titleText: 'Bolt'},
                          {startColumnName: 'blanketOrderItemDetailDiscQuotation', numberOfColumns: 3, titleText: 'Disc'},
                          {startColumnName: 'blanketOrderItemDetailPlatesQuotation', numberOfColumns: 3, titleText: 'Plates'},
                          {startColumnName: 'blanketOrderItemDetailShaftQuotation', numberOfColumns: 3, titleText: 'Shaft'},
                          {startColumnName: 'blanketOrderItemDetailSpringQuotation', numberOfColumns: 3, titleText: 'Spring'},
                          
                          {startColumnName: 'blanketOrderItemDetailArmPinQuotation', numberOfColumns: 3, titleText: 'Arm Pin'},
                          {startColumnName: 'blanketOrderItemDetailBackSeatQuotation', numberOfColumns: 3, titleText: 'Back Seat'},
                          {startColumnName: 'blanketOrderItemDetailArmQuotation', numberOfColumns: 3, titleText: 'Arm'},
                          {startColumnName: 'blanketOrderItemDetailHingePinQuotation', numberOfColumns: 3, titleText: 'Hinge Pin'},
                          {startColumnName: 'blanketOrderItemDetailStopPinQuotation', numberOfColumns: 3, titleText: 'Stop Pin'},
                          {startColumnName: 'blanketOrderItemDetailOperatorQuotation', numberOfColumns: 3, titleText: 'Operator'}
                    ]
                });
        }

    $(document).ready(function() {
        flagIsConfirmedBO=false;
        flagIsConfirmedBOSalesQuotation=false;
        flagIsConfirmedBOItemDelivery=false;
        $("#frmBlanketOrderInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        
        formatNumericBO();
        $("#msgBlanketOrderActivity").html(" - <i>" + $("#enumBlanketOrderActivity").val()+"<i>").show();
        setBlanketOrderPartialShipmentStatusStatus();
        
        $('input[name="blanketOrderPartialShipmentStatusRad"][value="YES"]').change(function(ev){
            $("#blanketOrder\\.customerPurchaseOrder\\.partialShipmentStatus").val("YES");
        });
        
        $('input[name="blanketOrderPartialShipmentStatusRad"][value="NO"]').change(function(ev){
            $("#blanketOrder\\.customerPurchaseOrder\\.partialShipmentStatus").val("NO");
        });
        
        $('input[name="blanketOrderOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#blanketOrder\\.orderStatus").val(value);
        });
                
        $('input[name="blanketOrderOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#blanketOrder\\.orderStatus").val(value);
        });
        
        $('#blanketOrderOrderStatusRadBLANKET_ORDER').prop('checked',true);
        $("#blanketOrder\\.orderStatus").val("BLANKET_ORDER");
        
        //Set Default View
        $("#btnUnConfirmBlanketOrder").css("display", "none");
        $("#btnUnConfirmBlanketOrderSalesQuotation").css("display", "none");
        $("#btnUnConfirmBlanketOrderItemDetailDelivery").css("display", "none");
        $("#btnConfirmBlanketOrderSalesQuotation").css("display", "none");
        $("#btnConfirmBlanketOrderSalesQuotationDetailSort").css("display", "none");
        $("#btnConfirmBlanketOrderItemDetailDelivery").css("display", "none");
        $("#btnBOSearchSalQuo").css("display", "none");
        $('#blanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-payment-item-delivery-bo').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-item-delivery-detail-bo').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmBlanketOrder").click(function(ev) {
            
            if(!$("#frmBlanketOrderInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                return;
            }
            
            var date1 = dtpBlanketOrderTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#blanketOrderTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($('#enumBlanketOrderActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#blanketOrderTransactionDate").val(),dtpBlanketOrderTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpBlanketOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($('#enumBlanketOrderActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#blanketOrderTransactionDate").val(),dtpBlanketOrderTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpBlanketOrderTransactionDate);
                }
                return;
            }
            
            if(parseFloat(txtBlanketOrderRetention.val())===0.00){
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
                                        flagIsConfirmedBO=true;
                                        flagIsConfirmedBOSalesQuotation=false;
                                        $("#btnUnConfirmBlanketOrder").css("display", "block");
                                        $("#btnConfirmBlanketOrder").css("display", "none");  
                                        $("#btnBOSearchSalQuo").css("display", "block");
                                        $('#headerBlanketOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                        $("#btnConfirmBlanketOrderSalesQuotation").show();
                                        $('#blanketOrderSalesQuotationInputGrid').unblock();
                                        loadBlanketOrderSalesQuotation();
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
                flagIsConfirmedBO=true;
                flagIsConfirmedBOSalesQuotation=false;
                $("#btnUnConfirmBlanketOrder").css("display", "block");
                $("#btnConfirmBlanketOrder").css("display", "none");   
                $("#btnBOSearchSalQuo").css("display", "block");
                $('#headerBlanketOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#btnConfirmBlanketOrderSalesQuotation").show();
                $('#blanketOrderSalesQuotationInputGrid').unblock();
                loadBlanketOrderSalesQuotation();
            }           
        });
                
        $("#btnUnConfirmBlanketOrder").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#blanketOrderSalesQuotationInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){ 
                    $("#btnUnConfirmBlanketOrder").css("display", "none");
                    $("#btnConfirmBlanketOrder").css("display", "block");
                    $("#btnBOSearchSalQuo").css("display", "none");
                    $('#headerBlanketOrderInput').unblock();
                    $('#blanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    $("#btnConfirmBlanketOrderSalesQuotation").css("display","none");
                    flagIsConfirmedBO=false;
                    flagIsConfirmedBOSalesQuotation=false;
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
                                flagIsConfirmedBO=false;
                                $("#blanketOrderSalesQuotationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmBlanketOrder").css("display", "none");
                                $("#btnConfirmBlanketOrder").css("display", "block");
                                $("#btnBOSearchSalQuo").css("display", "none");
                                $('#headerBlanketOrderInput').unblock();
                                $('#blanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#btnConfirmBlanketOrderSalesQuotation").css("display","none");
                                clearBlanketOrderTransactionAmount();
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
        
        $("#btnConfirmBlanketOrderSalesQuotation").click(function(ev) {
            if(flagIsConfirmedBO){
                
                if(blanketOrderSalesQuotation_lastSel !== -1) {
                    $('#blanketOrderSalesQuotationInput_grid').jqGrid("saveRow",blanketOrderSalesQuotation_lastSel); 
                }

                var ids = jQuery("#blanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#blanketOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[i]); 

                    if(data.blanketOrderSalesQuotationCode===""){
                        alertMessage("Sales Quotation Can't Empty!");
                        return;
                    }
                }
            
                $("#btnUnConfirmBlanketOrder").css("display", "none");
                $("#btnBOSearchSalQuo").css("display", "none");
                $("#btnUnConfirmBlanketOrderSalesQuotation").css("display", "block");
                $("#btnConfirmBlanketOrderSalesQuotationDetailSort").css("display", "block");
                $("#btnConfirmBlanketOrderItemDetailDelivery").css("display", "block");
                $("#btnConfirmBlanketOrderSalesQuotation").css("display", "none");   
                $('#blanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-bo').unblock();
                flagIsConfirmedBOSalesQuotation=true;
                loadBlanketOrderItemDetailRevise();
                loadBlanketOrderAdditionalFee();
                loadBlanketOrderPaymentTerm();
            }
        });
        
        $("#btnUnConfirmBlanketOrderSalesQuotation").click(function(ev) {
            $("#blanketOrderItemDetailInput_grid").jqGrid('destroyGroupHeader');
            $("#blanketOrderItemDetailInput_grid").jqGrid('clearGridData');
            $("#blanketOrderAdditionalFeeInput_grid").jqGrid('clearGridData');
            $("#blanketOrderPaymentTermInput_grid").jqGrid('clearGridData');
            $("#blanketOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmBlanketOrder").css("display", "block");
            $("#btnUnConfirmBlanketOrderSalesQuotation").css("display", "none");
            $("#btnConfirmBlanketOrderSalesQuotationDetailSort").css("display", "none");
            $("#btnConfirmBlanketOrderItemDetailDelivery").css("display", "none");
            $("#btnConfirmBlanketOrderSalesQuotation").css("display", "block");
            $('#blanketOrderSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery-bo').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedBOSalesQuotation=false;
            clearBlanketOrderTransactionAmount();
        });
        
        $("#btnConfirmBlanketOrderItemDetailDelivery").click(function(ev) {
            if(flagIsConfirmedBO){
                
                if(blanketOrderItemDetail_lastSel !== -1) {
                    $('#blanketOrderItemDetailInput_grid').jqGrid("saveRow",blanketOrderItemDetail_lastSel); 
                }
                if(blanketOrderAdditionalFee_lastSel !== -1) {
                    $('#blanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",blanketOrderAdditionalFee_lastSel); 
                }
                if(blanketOrderPaymentTerm_lastSel !== -1) {
                    $('#blanketOrderPaymentTermInput_grid').jqGrid("saveRow",blanketOrderPaymentTerm_lastSel); 
                }
                
                var idj = jQuery("#blanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
                var idl = jQuery("#blanketOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
                var idq = jQuery("#blanketOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                
                for(var j=0; j<idj.length;j++){
                    var data = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',idj[j]);
                    
                    if(data.blanketOrderItemDetailItemFinishGoodsCode === ""){
                        alertMessage("Item Finish Goods Code Must Be Filled!");
                        return;
                    }
                   
                    if(data.blanketOrderItemDetailSortNo===""){
                        alertMessage("Sort No Can't Empty!");
                        return;
                    }
                
                    if(data.blanketOrderItemDetailSortNo=== '0' ){
                        alertMessage("Sort No Can't Zero!");
                        return;
                    }
                
                    for(var i=j; i<=idj.length-1; i++){
                        var details = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',idj[i+1]);
                        if(data.blanketOrderItemDetailSortNo === details.blanketOrderItemDetailSortNo){
                            alertMessage("Sort No Can't Be The Same!");
                            return;
                        }
                    }

                    if(parseFloat(data.blanketOrderItemDetailQuantity)===0.00){
                        alertMessage("Quantity Item Can't be 0!");
                        return;
                    }
                }
                
                for(var l=0; l<idl.length;l++){
                    var data = $("#blanketOrderAdditionalFeeInput_grid").jqGrid('getRowData',idl[l]);
                    
                    if(data.blanketOrderAdditionalFeeAdditionalFeeCode === ""){
                        alertMessage("Additional Fee Must Be Filled!");
                        return;
                    }
                    if(parseFloat(data.blanketOrderAdditionalFeeQuantity === 0.00)){
                        alertMessage("Quantity Must Be Greater Than 0!");
                        return;
                    }
                    if(parseFloat(data.blanketOrderAdditionalFeePrice === 0.00)){
                        alertMessage("Price Must Be Greater Than 0!");
                        return;
                    }
                }
                
                if(idq.length===0){
                    alertMessage("Grid Payment Term Minimal 1(one) row!");
                    return;
                }
                
                var totalPercentagePaymentTerm=0;
                for(var p=0;p < idq.length;p++){ 
                    var data = $("#blanketOrderPaymentTermInput_grid").jqGrid('getRowData',idq[p]); 

                    if(data.blanketOrderPaymentTermSortNO=== '0' ){
                        alertMessage("Payment Term Sort No Can't Zero!");
                        return;
                    }

                    if(data.blanketOrderPaymentTermSortNO === " "){
                        alertMessage("Payment Term Sort No Can't Empty!");
                        return;
                    }

                    if(data.blanketOrderPaymentTermPaymentTermName===""){
                        alertMessage("Payment Term Can't Empty!");
                        return;
                    }

                    if(parseFloat(data.blanketOrderPaymentTermPercent)===0.00){
                        alertMessage("Percent Payment term Can't be 0!");
                        return;
                    }
                    totalPercentagePaymentTerm+=parseFloat(data.blanketOrderPaymentTermPercent);
                }
                if(parseFloat(totalPercentagePaymentTerm.toFixed(2))!==100){
                    alertMessage("Total Percent Payment Term must be 100%, Can't less or greater than 100%!",400);
                    return;
                }
                
                $("#btnConfirmBlanketOrderItemDetailDelivery").css("display", "none");   
                $("#btnUnConfirmBlanketOrderItemDetailDelivery").css("display", "block");
                $("#btnConfirmBlanketOrderSalesQuotationDetailSort").css("display", "none");
                $("#btnUnConfirmBlanketOrderSalesQuotation").css("display", "none");
                $('#blanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-bo').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-item-delivery-detail-bo').unblock();
                loadBlanketOrderItemDeliveryDate();
                flagIsConfirmedBOItemDelivery=true;
                
            }
        });
        
        $("#btnUnConfirmBlanketOrderItemDetailDelivery").click(function(ev) {
            $("#blanketOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmBlanketOrderItemDetailDelivery").css("display", "none");
            $("#btnConfirmBlanketOrderItemDetailDelivery").css("display", "block");
            $("#btnUnConfirmBlanketOrderSalesQuotation").show();
            $("#btnConfirmBlanketOrderSalesQuotationDetailSort").show();
            $('#id-tbl-additional-payment-item-delivery-bo').unblock();
            $('#id-tbl-additional-item-delivery-detail-bo').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#blanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedBOItemDelivery=false;
        });
        
        $.subscribe("blanketOrderSalesQuotationInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderSalesQuotation_lastSel) {

                $('#blanketOrderSalesQuotationInput_grid').jqGrid("saveRow",blanketOrderSalesQuotation_lastSel); 
                $('#blanketOrderSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderSalesQuotation_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderItemDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderItemDetail_lastSel) {

                $('#blanketOrderItemDetailInput_grid').jqGrid("saveRow",blanketOrderItemDetail_lastSel); 
                $('#blanketOrderItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderItemDetail_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderAdditionalFee_lastSel) {

                $('#blanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",blanketOrderAdditionalFee_lastSel); 
                $('#blanketOrderAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderAdditionalFee_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderPaymentTermInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderPaymentTerm_lastSel) {

                $('#blanketOrderPaymentTermInput_grid').jqGrid("saveRow",blanketOrderPaymentTerm_lastSel); 
                $('#blanketOrderPaymentTermInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderPaymentTerm_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderPaymentTermInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==blanketOrderItemDelivery_lastSel) {

                $('#blanketOrderItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderItemDelivery_lastSel); 
                $('#blanketOrderItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderItemDelivery_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnBlanketOrderAdditionalFeeAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#blanketOrderAdditionalFeeAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    blanketOrderAdditionalFeeDelete                : "delete",
                    blanketOrderAdditionalFeeSearchUnitOfMeasure   : "..."
                };
                blanketOrderAdditionalFeeLastRowId++;
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid("addRowData", blanketOrderAdditionalFeeLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid('setRowData',blanketOrderAdditionalFeeLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnBlanketOrderPaymentTermAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#blanketOrderPaymentTermAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var idp = jQuery("#blanketOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                var number = idp.length+1;
                var defRow = {
                    blanketOrderPaymentTermDelete                : "delete",
                    blanketOrderPaymentTermSearchPaymentTerm     : "...",
                    blanketOrderPaymentTermSortNO                : number
                };
                blanketOrderPaymentTermLastRowId++;
                $("#blanketOrderPaymentTermInput_grid").jqGrid("addRowData", blanketOrderPaymentTermLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#blanketOrderPaymentTermInput_grid").jqGrid('setRowData',blanketOrderPaymentTermLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnBlanketOrderItemDelieryAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#blanketOrderItemDelieryAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    blanketOrderItemDeliveryDelete                   : "delete",
                    blanketOrderItemDeliverySearchQuotation          : "..."
                };
                blanketOrderItemDeliveryLastRowId++;
                $("#blanketOrderItemDeliveryInput_grid").jqGrid("addRowData", blanketOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#blanketOrderItemDeliveryInput_grid").jqGrid('setRowData',blanketOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnBlanketOrderCopyFromDetail').click(function(ev) {
            
            $("#blanketOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(blanketOrderItemDetail_lastSel !== -1) {
                $('#blanketOrderItemDetailInput_grid').jqGrid("saveRow",blanketOrderItemDetail_lastSel); 
            }
            
            var ids = jQuery("#blanketOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    blanketOrderItemDeliveryDelete                 : "delete",
                    blanketOrderItemDeliveryItemCode               : data.blanketOrderItemDetailItem,
                    blanketOrderItemDeliverySortNo                 : data.blanketOrderItemDetailSortNo,
                    blanketOrderItemDeliveryQuantity               : data.blanketOrderItemDetailQuantity,
                    blanketOrderItemDeliverySearchQuotation        : "...",
                    blanketOrderItemDeliverySalesQuotationCode     : data.blanketOrderItemDetailQuotationNo,
                    blanketOrderItemDeliverySalesQuotationRefNo    : data.blanketOrderItemDetailQuotationRefNo,
                    blanketOrderItemDeliveryItemFinishGoodsCode    : data.blanketOrderItemDetailItemFinishGoodsCode,   
                    blanketOrderItemDeliveryItemFinishGoodsRemark  : data.blanketOrderItemDetailItemFinishGoodsRemark
                };
                blanketOrderItemDeliveryLastRowId++;
                $("#blanketOrderItemDeliveryInput_grid").jqGrid("addRowData", blanketOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#blanketOrderItemDeliveryInput_grid").jqGrid('setRowData',blanketOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnBlanketOrderSave').click(function(ev) {
            
            if(!flagIsConfirmedBOSalesQuotation){
                return;
            }
            
            if(blanketOrderItemDetail_lastSel !== -1) {
                $('#blanketOrderItemDetailInput_grid').jqGrid("saveRow",blanketOrderItemDetail_lastSel); 
            }
            
            if(blanketOrderAdditionalFee_lastSel !== -1) {
                $('#blanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",blanketOrderAdditionalFee_lastSel); 
            }
            
            if(blanketOrderPaymentTerm_lastSel !== -1) {
                $('#blanketOrderPaymentTermInput_grid').jqGrid("saveRow",blanketOrderPaymentTerm_lastSel); 
            }
            
            if(blanketOrderItemDelivery_lastSel !== -1) {
                $('#blanketOrderItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderItemDelivery_lastSel); 
            }
            
            var listCustomerBlanketOrderSalesQuotation = new Array(); 
            var listCustomerBlanketOrderItemDetail = new Array(); 
            var listCustomerBlanketOrderAdditionalFee = new Array(); 
            var listCustomerBlanketOrderPaymentTerm = new Array(); 
            var listCustomerBlanketOrderItemDeliveryDate = new Array(); 
            
            var idq = jQuery("#blanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
            var idi = jQuery("#blanketOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            var idf = jQuery("#blanketOrderAdditionalFeeInput_grid").jqGrid('getDataIDs'); 
            var idp = jQuery("#blanketOrderPaymentTermInput_grid").jqGrid('getDataIDs'); 
            var idd = jQuery("#blanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs'); 

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
                var data = $("#blanketOrderSalesQuotationInput_grid").jqGrid('getRowData',idq[q]); 
                  
                var blanketOrderSalesQuotation = { 
                    salesQuotation              : {code:data.blanketOrderSalesQuotationCode}
                };
                listCustomerBlanketOrderSalesQuotation[q] = blanketOrderSalesQuotation;
            }
            
            //Item Detail
            for(var i=0;i < idi.length;i++){ 
                var data = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
//                var sortNo = [];
//                sortNo[i] = data.blanketOrderItemDetailSortNo;
                
                if(data.blanketOrderItemDetailSortNo===""){
                    alertMessage("Sort No Can't Empty!");
                    return;
                }
                
                if(data.blanketOrderItemDetailSortNo=== '0' ){
                    alertMessage("Sort No Can't Zero!");
                    return;
                }
                
                for(var j=i; j<=idi.length-1; j++){
                var details = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',idi[j+1]);
                if(data.blanketOrderItemDetailSortNo === details.blanketOrderItemDetailSortNo){
                    alertMessage("Sort No Can't Be The Same!");
                    return;
                }
                }
                
                if(parseFloat(data.blanketOrderItemDetailQuantity)===0.00){
                    alertMessage("Quantity Item Can't be 0!");
                    return;
                }

                var blanketOrderItemDetail = { 
                    salesQuotation                            : {code:data.blanketOrderItemDetailQuotationNo},
                    salesQuotationDetail                      : {code:data.blanketOrderItemDetailQuotationNoDetailCode},
                    itemFinishGoods                           : {code:data.blanketOrderItemDetailItemFinishGoodsCode},
                    quantity                                  : data.blanketOrderItemDetailQuantity,
                    customerPurchaseOrderSortNo               : data.blanketOrderItemDetailSortNo,
                    itemAlias                                 : data.blanketOrderItemDetailItemAlias,
                    valveTag                                  : data.blanketOrderItemDetailValveTag,
                    dataSheet                                 : data.blanketOrderItemDetailDataSheet,
                    description                               : data.blanketOrderItemDetailDescription
                };
                listCustomerBlanketOrderItemDetail[i] = blanketOrderItemDetail;
            }
            
            //Additional Fee
            for(var f=0;f < idf.length;f++){ 
                var data = $("#blanketOrderAdditionalFeeInput_grid").jqGrid('getRowData',idf[f]); 

                if(data.blanketOrderAdditionalFeeRemark===""){
                    alertMessage("Remark Additional Fee Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.blanketOrderAdditionalFeeQuantity)===0.00){
                    alertMessage("Quantity Additional Fee Can't be 0!");
                    return;
                }
                                
                if(data.blanketOrderAdditionalFeeUnitOfMeasureCode===""){
                    alertMessage("Unit Additional Fee Can't Empty!");
                    return;
                }
                
                if(parseFloat(data.blanketOrderAdditionalFeePrice)===0.00){
                    alertMessage("Price Additional Fee Can't be 0!");
                    return;
                }
                
                var blanketOrderAdditionalFee = { 
                    remark          : data.blanketOrderAdditionalFeeRemark,
                    unitOfMeasure   : {code:data.blanketOrderAdditionalFeeUnitOfMeasureCode},
                    additionalFee   : {code:data.blanketOrderAdditionalFeeAdditionalFeeCode},
                    price           : data.blanketOrderAdditionalFeePrice,
                    quantity        : data.blanketOrderAdditionalFeeQuantity,
                    total           : data.blanketOrderAdditionalFeeTotal
                };
                listCustomerBlanketOrderAdditionalFee[f] = blanketOrderAdditionalFee;
            }
            
            //Payment term
            var totalPercentagePaymentTerm=0;
            for(var p=0;p < idp.length;p++){ 
                var data = $("#blanketOrderPaymentTermInput_grid").jqGrid('getRowData',idp[p]); 
                
                if(data.blanketOrderPaymentTermSortNO=== '0' ){
                    alertMessage("Sort No Payment Term Can't Zero!");
                    return;
                }
                
                if(data.blanketOrderPaymentTermSortNO === " "){
                    alertMessage("Sort No Payment Term Can't Empty!");
                    return;
                }
                
                if(data.blanketOrderPaymentTermPaymentTermName===""){
                    alertMessage("Payment Term Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.blanketOrderPaymentTermPercent)===0.00){
                    alertMessage("Percent Payment term Can't be 0!");
                    return;
                }
                
                var blanketOrderPaymentTerm = { 
                    sortNo          : data.blanketOrderPaymentTermSortNO,
                    paymentTerm     : {code:data.blanketOrderPaymentTermPaymentTermCode},
                    percentage      : data.blanketOrderPaymentTermPercent,
                    remark          : data.blanketOrderPaymentTermRemark
                };
                listCustomerBlanketOrderPaymentTerm[p] = blanketOrderPaymentTerm;
                totalPercentagePaymentTerm+=parseFloat(data.blanketOrderPaymentTermPercent);
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
                var data = $("#blanketOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[d]); 
                var deliveryDate = formatDate(data.blanketOrderItemDeliveryDeliveryDate,false);
                var deliveryDate = data.blanketOrderItemDeliveryDeliveryDate.split('/');
                var deliveryDateNew = deliveryDate[1]+"/"+deliveryDate[0]+"/"+deliveryDate[2];
//                if(data.blanketOrderItemDeliveryItemCode===""){
//                    alertMessage("Item Delivery Can't Empty!");
//                    return;
//                }
                
                if(data.blanketOrderItemDeliveryDeliveryDate===""){
                    alertMessage("Delivery Date Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.blanketOrderItemDeliveryQuantity)===0.00){
                    alertMessage("Quantity Delivery Can't be 0!");
                    return;
                }
                
                if(data.blanketOrderItemDeliverySalesQuotationCode===""){
                    alertMessage("Quotation Date Can't Empty!");
                    return;
                }
                
                var blanketOrderItemDeliveryDate = { 
                    itemFinishGoods     : {code:data.blanketOrderItemDeliveryItemFinishGoodsCode},
                    salesQuotation      : {code:data.blanketOrderItemDeliverySalesQuotationCode},
                    quantity            : data.blanketOrderItemDeliveryQuantity,
                    deliveryDate        : deliveryDateNew
                };
                listCustomerBlanketOrderItemDeliveryDate[d] = blanketOrderItemDeliveryDate;
            }
            var sumQuantityGroupItem=0;
            
            for(var i=0;i < idi.length;i++){
                var data = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
                sumQuantityGroupItem=0;
                for(var j=0;j < idd.length;j++){
                    var dataDelivery = $("#blanketOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[j]);
                    
                    if(data.blanketOrderItemDetailQuotationNo === dataDelivery.blanketOrderItemDeliverySalesQuotationCode){
                        if(data.blanketOrderItemDetailItemFinishGoodsCode === dataDelivery.blanketOrderItemDeliveryItemFinishGoodsCode){
                            if(data.blanketOrderItemDetailSortNo === dataDelivery.blanketOrderItemDeliverySortNo){
                                sumQuantityGroupItem += parseFloat(dataDelivery.blanketOrderItemDeliveryQuantity);
    //                            alert(data.blanketOrderItemDetailQuantity);
                            }
                        }
                    }
                }

                if(parseFloat(data.blanketOrderItemDetailQuantity)!==sumQuantityGroupItem){
                    alertMessage("Sum Of Quantity Item </br> "+data.blanketOrderItemDetailQuotationNo+" Must be Equal with Quantity Item Detail!");
                    return;
                }
                
            }
            
            formatDateBO();
            unFormatNumericBO();
            
            var url = "sales/blanket-order-save";
            var params = $("#frmBlanketOrderInput").serialize();
                params += "&listCustomerBlanketOrderSalesQuotationJSON=" + $.toJSON(listCustomerBlanketOrderSalesQuotation);
                params += "&listCustomerBlanketOrderItemDetailJSON=" + $.toJSON(listCustomerBlanketOrderItemDetail);
                params += "&listCustomerBlanketOrderAdditionalFeeJSON=" + $.toJSON(listCustomerBlanketOrderAdditionalFee);
                params += "&listCustomerBlanketOrderPaymentTermJSON=" + $.toJSON(listCustomerBlanketOrderPaymentTerm);
                params += "&listCustomerBlanketOrderItemDeliveryJSON=" + $.toJSON(listCustomerBlanketOrderItemDeliveryDate);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateBO();
                    formatNumericBO();
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
                                        var params = "enumBlanketOrderActivity=REVISE";
                                        var url = "sales/customer-blanket-order-input";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_BLANKET_ORDER");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/customer-blanket-order";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_BLANKET_ORDER");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnBlanketOrderCancel').click(function(ev) {
            var url = "sales/customer-blanket-order";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_BLANKET_ORDER"); 
        });
        
        $('#blanketOrder_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=blanketOrder&idsubdoc=branch","Search", "width=600, height=500");
        });

        $('#blanketOrder_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=blanketOrder&idsubdoc=customer","Search", "width=600, height=500");
        });
        
        $('#blanketOrder_btnCustomerEndUser').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=blanketOrder&idsubdoc=endUser","Search", "width=600, height=500");
        });
        
        
        $('#blanketOrder_btnSalesPerson').click(function(ev) {
            window.open("./pages/search/search-sales-person.jsp?iddoc=blanketOrder&idsubdoc=salesPerson","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#blanketOrder_btnProject').click(function(ev) {
            window.open("./pages/search/search-project.jsp?iddoc=blanketOrder&idsubdoc=project","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#blanketOrder_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=blanketOrder&idsubdoc=currency","Search", "width=600, height=500");
        });
        
        $('#blanketOrder_btnDiscountAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=blanketOrder&idsubdoc=discountAccount","Search", "width=600, height=500");
        });
        
        $('#btnBlanketOrderDeliveryDateSet').click(function(ev) {
            if(blanketOrderItemDelivery_lastSel !== -1) {
                $('#blanketOrderItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderItemDelivery_lastSel); 
            }
            
            var deliveryDate=$("#blanketOrderDeliveryDateSet").val();
            var ids = jQuery("#blanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#blanketOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "blanketOrderItemDeliveryDeliveryDate",deliveryDate);
                $("#blanketOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "blanketOrderItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
        
        $('#btnConfirmBlanketOrderSalesQuotationDetailSort').click(function(ev) {
             if($("#blanketOrderItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Sales Quotation Can't Be Empty!");
                return;}
            }
            
            if(blanketOrderItemDetail_lastSel !== -1) {
                $('#blanketOrderItemDetailInput_grid').jqGrid("saveRow",blanketOrderItemDetail_lastSel);  
            }
            
            var ids = jQuery("#blanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
            var listSalesQuotationDetail = new Array();

            for(var k=0;k<ids.length;k++){
            
            var data = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[k]);    
            var blanketOrderItemDetail = { 
                    salesQuotation              : {code:data.blanketOrderItemDetailQuotationNo},
                    refNo                       : data.blanketOrderItemDetailQuotationRefNo,
                    salesQuotationDetail        : data.blanketOrderItemDetailQuotationNoDetailCode,
                    sort                        : data.blanketOrderItemDetailSortNo,
                    itemFinishGoodsCode         : data.blanketOrderItemDetailItemFinishGoodsCode,
                    itemFinishGoodsName         : data.blanketOrderItemDetailItemFinishGoodsName,
                    itemFinishGoodsRemark       : data.blanketOrderItemDetailItemFinishGoodsRemark,
                    valveTypeCode               : data.blanketOrderItemDetailValveTypeCode,
                    valveTypeName               : data.blanketOrderItemDetailValveTypeName,
                    valveTag                    : data.blanketOrderItemDetailValveTag,
                    dataSheet                   : data.blanketOrderItemDetailDataSheet,
                    dataDescription             : data.blanketOrderItemDetailDescription,
                    itemAlias                   : data.blanketOrderItemDetailItemAlias,
                    
                    //01
                    bodyConstQuo                : data.blanketOrderItemDetailBodyConstQuotation,
                    bodyConstFinishGoodCode     : data.blanketOrderItemDetailItemFinishGoodsBodyConstCode,
                    bodyConstFinishGoodName     : data.blanketOrderItemDetailItemFinishGoodsBodyConstName,
                    //02
                    typeDesignQuo               : data.blanketOrderItemDetailTypeDesignQuotation,
                    typeDesignFinishGoodCode    : data.blanketOrderItemDetailItemFinishGoodsTypeDesignCode,
                    typeDesignFinishGoodName    : data.blanketOrderItemDetailItemFinishGoodsTypeDesignName,
                    //03
                    seatDesignQuo               : data.blanketOrderItemDetailSeatDesignQuotation,
                    seatDesignFinishGoodCode    : data.blanketOrderItemDetailItemFinishGoodsSeatDesignCode,
                    seatDesignFinishGoodName    : data.blanketOrderItemDetailItemFinishGoodsSeatDesignName,
                    //04
                    sizeQuo                     : data.blanketOrderItemDetailSizeQuotation,
                    sizeFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsSizeCode,
                    sizeFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsSizeName,
                    //05
                    ratingQuo                   : data.blanketOrderItemDetailRatingQuotation,
                    ratingFinishGoodCode        : data.blanketOrderItemDetailItemFinishGoodsRatingCode,
                    ratingFinishGoodName        : data.blanketOrderItemDetailItemFinishGoodsRatingName,
                    //06
                    boreQuo                     : data.blanketOrderItemDetailBoreQuotation,
                    boreFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsBoreCode,
                    boreFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsBoreName,
                    
                    //07
                    endConQuo                   : data.blanketOrderItemDetailEndConQuotation,
                    endConFinishGoodCode        : data.blanketOrderItemDetailItemFinishGoodsEndConCode,
                    endConFinishGoodName        : data.blanketOrderItemDetailItemFinishGoodsEndConName,
                    
                    //08
                    bodyQuo                     : data.blanketOrderItemDetailBodyQuotation,
                    bodyFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsBodyCode,
                    bodyFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsBodyName,
                    
                    //09
                    ballQuo                     : data.blanketOrderItemDetailBallQuotation,
                    ballFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsBallCode,
                    ballFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsBallName,
                    
                    //10
                    seatQuo                     : data.blanketOrderItemDetailSeatQuotation,
                    seatFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsSeatCode,
                    seatFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsSeatName,
                    
                    //11
                    seatInsertQuo                     : data.blanketOrderItemDetailSeatInsertQuotation,
                    seatInsertFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsSeatInsertCode,
                    seatInsertFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsSeatInsertName,
                    
                    //12
                    stemQuo                     : data.blanketOrderItemDetailStemQuotation,
                    stemFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsStemCode,
                    stemFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsStemName,
                    
                    //13
                    sealQuo                     : data.blanketOrderItemDetailSealQuotation,
                    sealFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsSealCode,
                    sealFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsSealName,
                    
                    //14
                    boltQuo                     : data.blanketOrderItemDetailBoltQuotation,
                    boltFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsBoltCode,
                    boltFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsBoltName,
                    
                    //15
                    discQuo                     : data.blanketOrderItemDetailDiscQuotation,
                    discFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsDiscCode,
                    discFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsDiscName,
                    
                    //16
                    platesQuo                     : data.blanketOrderItemDetailPlatesQuotation,
                    platesFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsPlatesCode,
                    platesFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsPlatesName,
                    
                    //17
                    shaftQuo                     : data.blanketOrderItemDetailShaftQuotation,
                    shaftFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsShaftCode,
                    shaftFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsShaftName,
                    
                    //18
                    springQuo                     : data.blanketOrderItemDetailSpringQuotation,
                    springFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsSpringCode,
                    springFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsSpringName,
                    
                    //19
                    armPinQuo                     : data.blanketOrderItemDetailArmPinQuotation,
                    armPinFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsArmPinCode,
                    armPinFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsArmPinName,
                    
                    //20
                    backSeatQuo                     : data.blanketOrderItemDetailBackSeatQuotation,
                    backSeatFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsBackSeatCode,
                    backSeatFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsBackSeatName,
                    
                    //21
                    armQuo                     : data.blanketOrderItemDetailArmQuotation,
                    armFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsArmCode,
                    armFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsArmName,
                    
                    //22
                    hingePinQuo                     : data.blanketOrderItemDetailHingePinQuotation,
                    hingePinFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsHingePinCode,
                    hingePinFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsHingePinName,
                    
                    //23
                    stopPinQuo                     : data.blanketOrderItemDetailStopPinQuotation,
                    stopPinFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsStopPinCode,
                    stopPinFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsStopPinName,
                    
                    //24
                    operatorQuo                     : data.blanketOrderItemDetailOperatorQuotation,
                    operatorFinishGoodCode          : data.blanketOrderItemDetailItemFinishGoodsOperatorCode,
                    operatorFinishGoodName          : data.blanketOrderItemDetailItemFinishGoodsOperatorName,
                    
                    note                        : data.blanketOrderItemDetailNote,
                    price                       : data.blanketOrderItemDetailPrice,
                    total                       : data.blanketOrderItemDetailTotal,
                    quantity                    : data.blanketOrderItemDetailQuantity
                    
                };
                listSalesQuotationDetail[k] = blanketOrderItemDetail;
            }
            
             var result = Enumerable.From(listSalesQuotationDetail)
                            .OrderBy('$.sort')
                            .Select()
                            .ToArray();
            
            $("#blanketOrderItemDetailInput_grid").jqGrid('clearGridData');
            blanketOrderItemDetail_lastSel = 0;
                for(var i = 0; i < result.length; i++){
                    blanketOrderItemDetail_lastSel ++;
                    $("#blanketOrderItemDetailInput_grid").jqGrid("addRowData",blanketOrderItemDetail_lastSel, result[i]);
                    $("#blanketOrderItemDetailInput_grid").jqGrid('setRowData',blanketOrderItemDetail_lastSel,{
                        
                    blanketOrderItemDetailQuotationNo                      : result[i].salesQuotation.code,
                    blanketOrderItemDetailQuotationRefNo                   : result[i].refNo,
                    blanketOrderItemDetailQuotationNoDetailCode            : result[i].salesQuotationDetail,
                    blanketOrderItemDetailSortNo                           : result[i].sort,
                    blanketOrderItemDetailItemFinishGoodsCode              : result[i].itemFinishGoodsCode,
                    blanketOrderItemDetailItemFinishGoodsName              : result[i].itemFinishGoodsName,
                    blanketOrderItemDetailItemFinishGoodsRemark            : result[i].itemFinishGoodsRemark,
                    blanketOrderItemDetailValveTypeCode                    : result[i].valveTypeCode,
                    blanketOrderItemDetailValveTypeName                    : result[i].valveTypeName,
                    blanketOrderItemDetailValveTag                         : result[i].valveTag,
                    blanketOrderItemDetailDataSheet                        : result[i].dataSheet,
                    blanketOrderItemDetailDescription                      : result[i].dataDescription,
                    blanketOrderItemDetailItemAlias                        : result[i].itemAlias,
                    //01
                    blanketOrderItemDetailBodyConstQuotation               : result[i].bodyConstQuo,
                    blanketOrderItemDetailItemFinishGoodsBodyConstCode     : result[i].bodyConstFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsBodyConstName     : result[i].bodyConstFinishGoodName,
                    //02
                    blanketOrderItemDetailTypeDesignQuotation               : result[i].typeDesignQuo,
                    blanketOrderItemDetailItemFinishGoodsTypeDesignCode     : result[i].typeDesignFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsTypeDesignName     : result[i].typeDesignFinishGoodName,
                    //03
                    blanketOrderItemDetailSeatDesignQuotation               : result[i].seatDesignQuo,
                    blanketOrderItemDetailItemFinishGoodsSeatDesignCode     : result[i].seatDesignFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsSeatDesignName     : result[i].seatDesignFinishGoodName,
                    //04
                    blanketOrderItemDetailSizeQuotation               : result[i].sizeQuo,
                    blanketOrderItemDetailItemFinishGoodsSizeCode     : result[i].sizeFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsSizeName     : result[i].sizeFinishGoodName,
                    //05
                    blanketOrderItemDetailRatingQuotation               : result[i].ratingQuo,
                    blanketOrderItemDetailItemFinishGoodsRatingCode     : result[i].ratingFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsRatingName     : result[i].ratingFinishGoodName,
                    //06
                    blanketOrderItemDetailBoreQuotation               : result[i].boreQuo,
                    blanketOrderItemDetailItemFinishGoodsBoreCode     : result[i].boreFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsBoreName     : result[i].boreFinishGoodName,
                    //07
                    blanketOrderItemDetailEndConQuotation               : result[i].endConQuo,
                    blanketOrderItemDetailItemFinishGoodsEndConCode     : result[i].endConFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsEndConName     : result[i].endConFinishGoodName,
                    //08
                    blanketOrderItemDetailBodyQuotation               : result[i].bodyQuo,
                    blanketOrderItemDetailItemFinishGoodsBodyCode     : result[i].bodyFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsBodyName     : result[i].bodyFinishGoodName,
                    //09
                    blanketOrderItemDetailBallQuotation               : result[i].ballQuo,
                    blanketOrderItemDetailItemFinishGoodsBallCode     : result[i].ballFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsBallName     : result[i].ballFinishGoodName,
                    //10
                    blanketOrderItemDetailSeatQuotation               : result[i].seatQuo,
                    blanketOrderItemDetailItemFinishGoodsSeatCode     : result[i].seatFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsSeatName     : result[i].seatFinishGoodName,
                    //11
                    blanketOrderItemDetailSeatInsertQuotation               : result[i].seatInsertQuo,
                    blanketOrderItemDetailItemFinishGoodsSeatInsertCode     : result[i].seatInsertFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsSeatInsertName     : result[i].seatInsertFinishGoodName,
                    //12
                    blanketOrderItemDetailStemQuotation               : result[i].stemQuo,
                    blanketOrderItemDetailItemFinishGoodsStemCode     : result[i].stemFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsStemName     : result[i].stemFinishGoodName,
                    //13
                    blanketOrderItemDetailSealQuotation               : result[i].sealQuo,
                    blanketOrderItemDetailItemFinishGoodsSealCode     : result[i].sealFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsSealName     : result[i].sealFinishGoodName,
                    //14
                    blanketOrderItemDetailBoltQuotation               : result[i].boltQuo,
                    blanketOrderItemDetailItemFinishGoodsBoltCode     : result[i].boltFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsBoltName     : result[i].boltFinishGoodName,
                    //15
                    blanketOrderItemDetailDiscQuotation               : result[i].discQuo,
                    blanketOrderItemDetailItemFinishGoodsDiscCode     : result[i].discFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsDiscName     : result[i].discFinishGoodName,
                    //16
                    blanketOrderItemDetailPlatesQuotation               : result[i].platesQuo,
                    blanketOrderItemDetailItemFinishGoodsPlatesCode     : result[i].platesFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsPlatesName     : result[i].platesFinishGoodName,
                    //17
                    blanketOrderItemDetailShaftQuotation               : result[i].shaftQuo,
                    blanketOrderItemDetailItemFinishGoodsShaftCode     : result[i].shaftFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsShaftName     : result[i].shaftFinishGoodName,
                    //18
                    blanketOrderItemDetailSpringQuotation               : result[i].springQuo,
                    blanketOrderItemDetailItemFinishGoodsSpringCode     : result[i].springFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsSpringName     : result[i].springFinishGoodName,
                    //19
                    blanketOrderItemDetailArmPinQuotation               : result[i].armPinQuo,
                    blanketOrderItemDetailItemFinishGoodsArmPinCode     : result[i].armPinFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsArmPinName     : result[i].armPinFinishGoodName,
                    //20
                    blanketOrderItemDetailBackSeatQuotation               : result[i].backSeatQuo,
                    blanketOrderItemDetailItemFinishGoodsBackSeatCode     : result[i].backSeatFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsBackSeatName     : result[i].backSeatFinishGoodName,
                    //21
                    blanketOrderItemDetailArmQuotation               : result[i].armQuo,
                    blanketOrderItemDetailItemFinishGoodsArmCode     : result[i].armFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsArmName     : result[i].armFinishGoodName,
                    //22
                    blanketOrderItemDetailHingePinQuotation               : result[i].hingePinQuo,
                    blanketOrderItemDetailItemFinishGoodsHingePinCode     : result[i].hingePinFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsHingePinName     : result[i].hingePinFinishGoodName,
                    //23
                    blanketOrderItemDetailStopPinQuotation               : result[i].stopPinQuo,
                    blanketOrderItemDetailItemFinishGoodsStopPinCode     : result[i].stopPinFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsStopPinName     : result[i].stopPinFinishGoodName,
                    //24
                    blanketOrderItemDetailOperatorQuotation               : result[i].operatorQuo,
                    blanketOrderItemDetailItemFinishGoodsOperatorCode     : result[i].operatorFinishGoodCode,
                    blanketOrderItemDetailItemFinishGoodsOperatorName     : result[i].operatorFinishGoodName,
                    
                    blanketOrderItemDetailNote                        : result[i].note,
                    blanketOrderItemDetailPrice                       : result[i].price,
                    blanketOrderItemDetailTotal                       : result[i].total,
                    blanketOrderItemDetailQuantity                    : result[i].quantity
               });    
            }
        }); 
        
        $('#btnBOSearchSalQuo').click(function(ev) {
            var ids = jQuery("#blanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
            var customer=txtBlanketOrderCustomerCode.val();
            var customerName=txtBlanketOrderCustomerName.val();
            var endUser=txtBlanketOrderEndUserCode.val();
            var endUserName=txtBlanketOrderEndUserName.val();
            var salesPerson=txtBlanketOrderSalesPersonCode.val();
            var salesPersonName=txtBlanketOrderSalesPersonName.val();
            var project=txtBlanketOrderProjectCode.val();
            var projectName=txtBlanketOrderProjectName.val();
            var currency=txtBlanketOrderCurrencyCode.val();
            var currencyName=txtBlanketOrderCurrencyName.val();
            var branch = txtBlanketOrderBranchCode.val();
            var branchName = txtBlanketOrderBranchName.val();
            var orderStatus = $("#blanketOrder\\.orderStatus").val();
            window.open("./pages/search/search-sales-quotation-multiple.jsp?iddoc=blanketOrderSalesQuotation&type=grid&rowLast="+ids.length+
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
            "&firstDate="+$("#blanketOrderDateFirstSession").val()+"&lastDate="+$("#blanketOrderDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
        });
        
    }); //EOF Ready
    
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#blanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#blanketOrderSalesQuotationInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#blanketOrderSalesQuotationInput_grid").jqGrid('setRowData',lastRowId,{
                    blanketOrderSalesQuotationDelete              : defRow.blanketOrderSalesQuotationDelete,
                    blanketOrderSalesQuotationCode                : defRow.blanketOrderSalesQuotationCode,
                    blanketOrderSalesQuotationTransactionDate     : defRow.blanketOrderSalesQuotationTransactionDate,
                    blanketOrderSalesQuotationCustomerCode        : defRow.blanketOrderSalesQuotationCustomerCode,
                    blanketOrderSalesQuotationCustomerName        : defRow.blanketOrderSalesQuotationCustomerName,
                    blanketOrderSalesQuotationEndUserCode         : defRow.blanketOrderSalesQuotationEndUserCode,
                    blanketOrderSalesQuotationEndUserName         : defRow.blanketOrderSalesQuotationEndUserName,
                    blanketOrderSalesQuotationRfqCode             : defRow.blanketOrderSalesQuotationRfqCode,
                    blanketOrderSalesQuotationProjectCode         : defRow.blanketOrderSalesQuotationProjectCode,
                    blanketOrderSalesQuotationSubject             : defRow.blanketOrderSalesQuotationSubject,
                    blanketOrderSalesQuotationAttn                : defRow.blanketOrderSalesQuotationAttn,
                    blanketOrderSalesQuotationRefNo               : defRow.blanketOrderSalesQuotationRefNo,
                    blanketOrderSalesQuotationRemark              : defRow.blanketOrderSalesQuotationRemark
            });
            
        setHeightGridBOSalQuoDetail();
 }
    
    // function Grid Detail
    function setHeightGridBOSalQuoDetail(){
        var ids = jQuery("#blanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#blanketOrderSalesQuotationInput_grid"+" tr").eq(1).height();
            $("#blanketOrderSalesQuotationInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#blanketOrderSalesQuotationInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateBO(){
        var transactionDateSplit=dtpBlanketOrderTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpBlanketOrderTransactionDate.val(transactionDate);
        
        var createdDate=$("#blanketOrder\\.createdDate").val();
        $("#blanketOrder\\.createdDateTemp").val(createdDate);
    }

    function unFormatNumericBO(){
        var retention =removeCommas(txtBlanketOrderRetention.val());
        txtBlanketOrderRetention.val(retention);
        
        var totalTransactionAmount =removeCommas(txtBlanketOrderTotalTransactionAmount.val());
        txtBlanketOrderTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtBlanketOrderDiscountAmount.val());
        txtBlanketOrderDiscountAmount.val(discountAmount);
        var taxBaseAmount =removeCommas(txtBlanketOrderTaxBaseAmount.val());
        txtBlanketOrderTaxBaseAmount.val(taxBaseAmount);
        var vatPercent =removeCommas(txtBlanketOrderVATPercent.val());
        txtBlanketOrderVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtBlanketOrderVATAmount.val());
        txtBlanketOrderVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtBlanketOrderGrandTotalAmount.val());
        txtBlanketOrderGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericBO(){
        
        var retention =parseFloat(txtBlanketOrderRetention.val());
        txtBlanketOrderRetention.val(formatNumber(retention,2));
        
        var totalTransactionAmount =parseFloat(txtBlanketOrderTotalTransactionAmount.val());
        txtBlanketOrderTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtBlanketOrderDiscountPercent.val());
        txtBlanketOrderDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtBlanketOrderDiscountAmount.val());
        txtBlanketOrderDiscountAmount.val(formatNumber(discountAmount,2));
        var taxBaseAmount =parseFloat(txtBlanketOrderTaxBaseAmount.val());
        txtBlanketOrderTaxBaseAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtBlanketOrderVATPercent.val());
        txtBlanketOrderVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtBlanketOrderVATAmount.val());
        txtBlanketOrderVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtBlanketOrderGrandTotalAmount.val());
        txtBlanketOrderGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }    
    
    function clearBlanketOrderTransactionAmount(){
        txtBlanketOrderTotalTransactionAmount.val("0.00");        
        txtBlanketOrderDiscountPercent.val("0.00");
        txtBlanketOrderDiscountAmount.val("0.00");
        txtBlanketOrderTotalAdditionalFee.val("0.00");
        txtBlanketOrderTaxBaseAmount.val("0.00");
        txtBlanketOrderVATPercent.val("0.00");
        txtBlanketOrderVATAmount.val("0.00");
        txtBlanketOrderGrandTotalAmount.val("0.00");
    }
    
    function calculateItemSalesQuotationDetailBO(){

        var selectedRowID = $("#blanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#blanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = blanketOrderItemDetailLastRowId;
        }
        var qty = $("#" + selectedRowID + "_blanketOrderItemDetailQuantity").val();
        var unitPrice = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData', selectedRowID);
        var amount = unitPrice.blanketOrderItemDetailPrice;

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#blanketOrderItemDetailInput_grid").jqGrid("setCell", selectedRowID, "blanketOrderItemDetailTotal", subAmount);

        calculateBlanketOrderHeader();
    }
    
    function calculateBlanketOrderAdditionalFee() {
        var selectedRowID = $("#blanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var qty = $("#" + selectedRowID + "_blanketOrderAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_blanketOrderAdditionalFeePrice").val();
        
        var subTotal = (parseFloat(qty) * parseFloat(price));
        
        $("#blanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "blanketOrderAdditionalFeeTotal", subTotal);

        calculateBlanketOrderTotalAdditional();
    }
    
    function calculateBlanketOrderTotalAdditional() {
        var totalAmount =0;
        var ids = jQuery("#blanketOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#blanketOrderAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.blanketOrderAdditionalFeeTotal);
        }   
        
        txtBlanketOrderTotalAdditionalFee.val(formatNumber(totalAmount,2));
        calculateBlanketOrderHeader();

    }
    
    function calculateBlanketOrderHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var additionalFeeAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#blanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.blanketOrderItemDetailTotal);
        }   
        txtBlanketOrderTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtBlanketOrderTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtBlanketOrderDiscountPercent.val()));        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtBlanketOrderDiscountAmount.val()===""){
            discAmount=0;
        }
        
        additionalFeeAmount=parseFloat(removeCommas(txtBlanketOrderTotalAdditionalFee.val()));  
        
        subTotal = (totalTransaction-discAmount)+additionalFeeAmount;
        
        if(txtBlanketOrderVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtBlanketOrderVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtBlanketOrderDiscountAmount.val(formatNumber(discAmount,2));
        txtBlanketOrderTaxBaseAmount.val(formatNumber(subTotal,2));
        txtBlanketOrderVATAmount.val(formatNumber(vatAmount,2));        
        txtBlanketOrderGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onchangeAdditionalFeeUnitOfMeasureCodeBO(){
        var selectedRowID = $("#blanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var uomCode = $("#" + selectedRowID + "_blanketOrderAdditionalFeeUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + uomCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
            }
            else{
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeUnitOfMeasureCode").val("");
                alert("UOM Not Found","");
            }
        });
            
    }
    
    function onchangeAdditionalFeeChartOfAccountCodeBO(){
        var selectedRowID = $("#blanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var coaCode = $("#" + selectedRowID + "_blanketOrderAdditionalFeeChartOfAccountCode").val();

        var url = "master/chart-of-account-get-data";
        var params = "chartOfAccount.code=" + coaCode;
//            params+= "&unitOfMeasure.activeStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.chartOfAccountTemp){
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeChartOfAccountCode").val(data.chartOfAccountTemp.code);
            }
            else{
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeChartOfAccountCode").val("");
                alert("COA Not Found","");
            }
        });
            
    }
    
    function onchangeAdditionalFeeCodeBO(){
        var selectedRowID = $("#blanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var additionalFeeCode = $("#" + selectedRowID + "_blanketOrderAdditionalFeeAdditionalFeeCode").val();

        var url = "master/additional-fee-get-sales";
        var params = "additionalFee.code=" + additionalFeeCode;
            params+= "&additionalFee.activeStatus=TRUE";
            params+= "&additionalFee.salesStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.additionalFeeTemp){
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"blanketOrderAdditionalFeeAdditionalFeeCode",data.additionalFeeTemp.code);
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"blanketOrderAdditionalFeeAdditionalFeeName",data.additionalFeeTemp.name);
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"blanketOrderAdditionalFeeSalesChartOfAccountCode",data.additionalFeeTemp.salesChartOfAccountCode);
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"blanketOrderAdditionalFeeSalesChartOfAccountName",data.additionalFeeTemp.salesChartOfAccountName);
            }
            else{
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeAdditionalFeeCode").val("");
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeAdditionalFeeName").val("");
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeSalesChartOfAccountCode").val("");
                $("#" + selectedRowID + "_blanketOrderAdditionalFeeSalesChartOfAccountName").val("");
                alert("Additional Fee Not Found","");
            }
        });
            
    }
    
    function onchangePaymentTermPaymentTermCodeBO(){
        var selectedRowID = $("#blanketOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");
        var paymentTermCode = $("#" + selectedRowID + "_blanketOrderPaymentTermPaymentTermCode").val();

        var url = "master/payment-term-get";
        var params = "paymentTerm.code=" + paymentTermCode;
            params+= "&paymentTerm.activeStatus=TRUE";
        $.post(url, params, function(result){
            var data = (result);
            if (data.paymentTermTemp){
                $("#blanketOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"blanketOrderPaymentTermPaymentTermCode",data.paymentTermTemp.code);
                $("#blanketOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"blanketOrderPaymentTermPaymentTermName",data.paymentTermTemp.name);
            }
            else{
                $("#" + selectedRowID + "_blanketOrderPaymentTermPaymentTermCode").val("");
                $("#" + selectedRowID + "_blanketOrderPaymentTermPaymentTermName").val("");
                alert("Payment Term Not Found","");
            }
        });
            
    }
    
    function blanketOrderSalesQuotationInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#blanketOrderSalesQuotationInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#blanketOrderSalesQuotationInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function blanketOrderItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#blanketOrderItemDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#blanketOrderItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
        
        calculateBlanketOrderHeader();
    }
    
    function blanketOrderAdditionalFeeInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#blanketOrderAdditionalFeeInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#blanketOrderAdditionalFeeInput_grid").jqGrid('delRowData',selectDetailRowId);    
        calculateBlanketOrderTotalAdditional();
    }
    
    function blanketOrderPaymentTermInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#blanketOrderPaymentTermInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#blanketOrderPaymentTermInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function blanketOrderItemDeliveryInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#blanketOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#blanketOrderItemDeliveryInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    
    function onchangeBlanketOrderItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#blanketOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_blanketOrderItemDeliveryDeliveryDate").val();
        
        $("#blanketOrderItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "blanketOrderItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    
    function loadBlanketOrderSalesQuotation() {
        var enumBlanketOrderActivity=$("#enumBlanketOrderActivity").val();
        if(enumBlanketOrderActivity==="NEW"){
            return;
        }                
        
        var url = "sales/blanket-order-sales-quotation-data";
        var params = "blanketOrder.code="+$("#blanketOrder\\.customerBlanketOrderCode").val();
        
        blanketOrderSalesQuotationLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderSalesQuotation.length; i++) {
                blanketOrderSalesQuotationLastRowId++;
                
                $("#blanketOrderSalesQuotationInput_grid").jqGrid("addRowData", blanketOrderSalesQuotationLastRowId, data.listCustomerBlanketOrderSalesQuotation[i]);
                $("#blanketOrderSalesQuotationInput_grid").jqGrid('setRowData',blanketOrderSalesQuotationLastRowId,{
                    blanketOrderSalesQuotationDelete           : "delete",
                    blanketOrderSalesQuotationSearch           : "...",
                    blanketOrderSalesQuotationCode             : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationCode,
                    blanketOrderSalesQuotationTransactionDate  : formatDateRemoveT(data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationTransactionDate,true),
                    blanketOrderSalesQuotationCustomerCode     : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationCustomerCode,
                    blanketOrderSalesQuotationCustomerName     : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationCustomerName,
                    blanketOrderSalesQuotationEndUserCode      : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationEndUserCode,
                    blanketOrderSalesQuotationEndUserName      : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationEndUserName,
                    blanketOrderSalesQuotationRfqCode          : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationRfqCode,
                    blanketOrderSalesQuotationProjectCode      : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationProject,
                    blanketOrderSalesQuotationSubject          : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationSubject,
                    blanketOrderSalesQuotationAttn             : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationAttn,
                    blanketOrderSalesQuotationRefNo            : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationRefNo,
                    blanketOrderSalesQuotationRemark           : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationRemark
                });
            }
        });
        closeLoading();
    }
    
    function loadBlanketOrderItemDetailRevise() {
        loadGridItemBO();
        var arrSalesQuotationNo=new Array();
        var totalTransaction=0;
        var ids = jQuery("#blanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#blanketOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNo.push(data.blanketOrderSalesQuotationCode);
        }
        
        var url = "sales/blanket-order-item-detail-data-array-data";
        var params = "arrSalesQuotationBoNo="+arrSalesQuotationNo;   
            params += "&blanketOrder.code="+$("#blanketOrder\\.refCUSTBOCode").val();
        blanketOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerBlanketOrderItemDetail.length; i++) {
                blanketOrderItemDetailLastRowId++;
                
                $("#blanketOrderItemDetailInput_grid").jqGrid("addRowData", blanketOrderItemDetailLastRowId, data.listCustomerBlanketOrderItemDetail[i]);
                $("#blanketOrderItemDetailInput_grid").jqGrid('setRowData',blanketOrderItemDetailLastRowId,{
                    blanketOrderItemDetailDelete                   : "delete",
                    blanketOrderItemDetailQuotationNoDetailCode    : data.listCustomerBlanketOrderItemDetail[i].salesQuotationDetailCode,
                    blanketOrderItemDetailQuotationNo              : data.listCustomerBlanketOrderItemDetail[i].salesQuotationCode,
                    blanketOrderItemDetailQuotationRefNo           : data.listCustomerBlanketOrderItemDetail[i].refNo,
                    blanketOrderItemDetailItemFinishGoodsCode      : data.listCustomerBlanketOrderItemDetail[i].itemFinishGoodsCode,
                    blanketOrderItemDetailItemFinishGoodsRemark    : data.listCustomerBlanketOrderItemDetail[i].itemFinishGoodsRemark,
                    blanketOrderItemDetailSortNo                   : data.listCustomerBlanketOrderItemDetail[i].customerPurchaseOrderSortNo,
                    blanketOrderItemDetailValveTypeCode            : data.listCustomerBlanketOrderItemDetail[i].valveTypeCode,
                    blanketOrderItemDetailValveTypeName            : data.listCustomerBlanketOrderItemDetail[i].valveTypeName,
                    blanketOrderItemDetailItemAlias                : data.listCustomerBlanketOrderItemDetail[i].itemAlias,
                    blanketOrderItemDetailValveTag                 : data.listCustomerBlanketOrderItemDetail[i].valveTag,
                    blanketOrderItemDetailDataSheet                : data.listCustomerBlanketOrderItemDetail[i].dataSheet,
                    blanketOrderItemDetailDescription              : data.listCustomerBlanketOrderItemDetail[i].description,
                                      
                    // 24 valve Type Component Quotation
                    blanketOrderItemDetailBodyConstQuotation   : data.listCustomerBlanketOrderItemDetail[i].bodyConstruction,
                    blanketOrderItemDetailTypeDesignQuotation  : data.listCustomerBlanketOrderItemDetail[i].typeDesign,
                    blanketOrderItemDetailSeatDesignQuotation  : data.listCustomerBlanketOrderItemDetail[i].seatDesign,
                    blanketOrderItemDetailSizeQuotation        : data.listCustomerBlanketOrderItemDetail[i].size,
                    blanketOrderItemDetailRatingQuotation      : data.listCustomerBlanketOrderItemDetail[i].rating,
                    blanketOrderItemDetailBoreQuotation        : data.listCustomerBlanketOrderItemDetail[i].bore,
                    
                    blanketOrderItemDetailEndConQuotation      : data.listCustomerBlanketOrderItemDetail[i].endCon,
                    blanketOrderItemDetailBodyQuotation        : data.listCustomerBlanketOrderItemDetail[i].body,
                    blanketOrderItemDetailBallQuotation        : data.listCustomerBlanketOrderItemDetail[i].ball,
                    blanketOrderItemDetailSeatQuotation        : data.listCustomerBlanketOrderItemDetail[i].seat,
                    blanketOrderItemDetailSeatInsertQuotation  : data.listCustomerBlanketOrderItemDetail[i].seatInsert,
                    blanketOrderItemDetailStemQuotation        : data.listCustomerBlanketOrderItemDetail[i].stem,
                    
                    blanketOrderItemDetailSealQuotation        : data.listCustomerBlanketOrderItemDetail[i].seal,
                    blanketOrderItemDetailBoltQuotation        : data.listCustomerBlanketOrderItemDetail[i].bolting,
                    blanketOrderItemDetailDiscQuotation        : data.listCustomerBlanketOrderItemDetail[i].disc,
                    blanketOrderItemDetailPlatesQuotation      : data.listCustomerBlanketOrderItemDetail[i].plates,
                    blanketOrderItemDetailShaftQuotation       : data.listCustomerBlanketOrderItemDetail[i].shaft,
                    blanketOrderItemDetailSpringQuotation      : data.listCustomerBlanketOrderItemDetail[i].spring,
                    
                    blanketOrderItemDetailArmPinQuotation      : data.listCustomerBlanketOrderItemDetail[i].armPin,
                    blanketOrderItemDetailBackSeatQuotation    : data.listCustomerBlanketOrderItemDetail[i].backSeat,
                    blanketOrderItemDetailArmQuotation         : data.listCustomerBlanketOrderItemDetail[i].arm,
                    blanketOrderItemDetailHingePinQuotation    : data.listCustomerBlanketOrderItemDetail[i].hingePin,
                    blanketOrderItemDetailStopPinQuotation     : data.listCustomerBlanketOrderItemDetail[i].stopPin,
                    blanketOrderItemDetailOperatorQuotation    : data.listCustomerBlanketOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    blanketOrderItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerBlanketOrderItemDetail[i].itemBodyConstructionCode,
                    blanketOrderItemDetailItemFinishGoodsBodyConstName     : data.listCustomerBlanketOrderItemDetail[i].itemBodyConstructionName,
                    blanketOrderItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerBlanketOrderItemDetail[i].itemTypeDesignCode,
                    blanketOrderItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerBlanketOrderItemDetail[i].itemTypeDesignName,
                    blanketOrderItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerBlanketOrderItemDetail[i].itemSeatDesignCode,
                    blanketOrderItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerBlanketOrderItemDetail[i].itemSeatDesignName,
                    blanketOrderItemDetailItemFinishGoodsSizeCode          : data.listCustomerBlanketOrderItemDetail[i].itemSizeCode,
                    blanketOrderItemDetailItemFinishGoodsSizeName          : data.listCustomerBlanketOrderItemDetail[i].itemSizeName,
                    blanketOrderItemDetailItemFinishGoodsRatingCode        : data.listCustomerBlanketOrderItemDetail[i].itemRatingCode,
                    blanketOrderItemDetailItemFinishGoodsRatingName        : data.listCustomerBlanketOrderItemDetail[i].itemRatingName,
                    blanketOrderItemDetailItemFinishGoodsBoreCode          : data.listCustomerBlanketOrderItemDetail[i].itemBoreCode,
                    blanketOrderItemDetailItemFinishGoodsBoreName          : data.listCustomerBlanketOrderItemDetail[i].itemBoreName,
                    
                    blanketOrderItemDetailItemFinishGoodsEndConCode        : data.listCustomerBlanketOrderItemDetail[i].itemEndConCode,
                    blanketOrderItemDetailItemFinishGoodsEndConName        : data.listCustomerBlanketOrderItemDetail[i].itemEndConName,
                    blanketOrderItemDetailItemFinishGoodsBodyCode          : data.listCustomerBlanketOrderItemDetail[i].itemBodyCode,
                    blanketOrderItemDetailItemFinishGoodsBodyName          : data.listCustomerBlanketOrderItemDetail[i].itemBodyName,
                    blanketOrderItemDetailItemFinishGoodsBallCode          : data.listCustomerBlanketOrderItemDetail[i].itemBallCode,
                    blanketOrderItemDetailItemFinishGoodsBallName          : data.listCustomerBlanketOrderItemDetail[i].itemBallName,
                    blanketOrderItemDetailItemFinishGoodsSeatCode          : data.listCustomerBlanketOrderItemDetail[i].itemSeatCode,
                    blanketOrderItemDetailItemFinishGoodsSeatName          : data.listCustomerBlanketOrderItemDetail[i].itemSeatName,
                    blanketOrderItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerBlanketOrderItemDetail[i].itemSeatInsertCode,
                    blanketOrderItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerBlanketOrderItemDetail[i].itemSeatInsertName,
                    blanketOrderItemDetailItemFinishGoodsStemCode          : data.listCustomerBlanketOrderItemDetail[i].itemStemCode,
                    blanketOrderItemDetailItemFinishGoodsStemName          : data.listCustomerBlanketOrderItemDetail[i].itemStemName,
                    
                    blanketOrderItemDetailItemFinishGoodsSealCode          : data.listCustomerBlanketOrderItemDetail[i].itemSealCode,
                    blanketOrderItemDetailItemFinishGoodsSealName          : data.listCustomerBlanketOrderItemDetail[i].itemSealName,
                    blanketOrderItemDetailItemFinishGoodsBoltCode          : data.listCustomerBlanketOrderItemDetail[i].itemBoltCode,
                    blanketOrderItemDetailItemFinishGoodsBoltName          : data.listCustomerBlanketOrderItemDetail[i].itemBoltName,
                    blanketOrderItemDetailItemFinishGoodsDiscCode          : data.listCustomerBlanketOrderItemDetail[i].itemDiscCode,
                    blanketOrderItemDetailItemFinishGoodsDiscName          : data.listCustomerBlanketOrderItemDetail[i].itemDiscName,
                    blanketOrderItemDetailItemFinishGoodsPlatesCode        : data.listCustomerBlanketOrderItemDetail[i].itemPlatesCode,
                    blanketOrderItemDetailItemFinishGoodsPlatesName        : data.listCustomerBlanketOrderItemDetail[i].itemPlatesName,
                    blanketOrderItemDetailItemFinishGoodsShaftCode         : data.listCustomerBlanketOrderItemDetail[i].itemShaftCode,
                    blanketOrderItemDetailItemFinishGoodsShaftName         : data.listCustomerBlanketOrderItemDetail[i].itemShaftName,
                    blanketOrderItemDetailItemFinishGoodsSpringCode        : data.listCustomerBlanketOrderItemDetail[i].itemSpringCode,
                    blanketOrderItemDetailItemFinishGoodsSpringName        : data.listCustomerBlanketOrderItemDetail[i].itemSpringName,
                    
                    blanketOrderItemDetailItemFinishGoodsArmPinCode        : data.listCustomerBlanketOrderItemDetail[i].itemArmPinCode, 
                    blanketOrderItemDetailItemFinishGoodsArmPinName        : data.listCustomerBlanketOrderItemDetail[i].itemArmPinName, 
                    blanketOrderItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerBlanketOrderItemDetail[i].itemBackSeatCode,
                    blanketOrderItemDetailItemFinishGoodsBackSeatName      : data.listCustomerBlanketOrderItemDetail[i].itemBackSeatName,
                    blanketOrderItemDetailItemFinishGoodsArmCode           : data.listCustomerBlanketOrderItemDetail[i].itemArmCode,
                    blanketOrderItemDetailItemFinishGoodsArmName           : data.listCustomerBlanketOrderItemDetail[i].itemArmName,
                    blanketOrderItemDetailItemFinishGoodsHingePinCode      : data.listCustomerBlanketOrderItemDetail[i].itemHingePinCode,
                    blanketOrderItemDetailItemFinishGoodsHingePinName      : data.listCustomerBlanketOrderItemDetail[i].itemHingePinName,
                    blanketOrderItemDetailItemFinishGoodsStopPinCode       : data.listCustomerBlanketOrderItemDetail[i].itemStopPinCode,
                    blanketOrderItemDetailItemFinishGoodsStopPinName       : data.listCustomerBlanketOrderItemDetail[i].itemStopPinName,
                    blanketOrderItemDetailItemFinishGoodsOperatorCode      : data.listCustomerBlanketOrderItemDetail[i].itemOperatorCode,
                    blanketOrderItemDetailItemFinishGoodsOperatorName      : data.listCustomerBlanketOrderItemDetail[i].itemOperatorName,
                    
                    blanketOrderItemDetailNote                 : data.listCustomerBlanketOrderItemDetail[i].note,
                    blanketOrderItemDetailQuantity             : data.listCustomerBlanketOrderItemDetail[i].quantity,
                    blanketOrderItemDetailPrice                : data.listCustomerBlanketOrderItemDetail[i].unitPrice,
                    blanketOrderItemDetailTotal                : data.listCustomerBlanketOrderItemDetail[i].totalAmount
                });
                calculateBlanketOrderHeader();
            }
        });
        closeLoading();
    }
    
    function loadBlanketOrderAdditionalFee() {
        if($("#enumBlanketOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/blanket-order-additional-fee-data";
        var params = "blanketOrder.code="+$("#blanketOrder\\.customerBlanketOrderCode").val();   
        
        blanketOrderAdditionalFeeLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderAdditionalFee.length; i++) {
                blanketOrderAdditionalFeeLastRowId++;
                
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid("addRowData", blanketOrderAdditionalFeeLastRowId, data.listCustomerBlanketOrderAdditionalFee[i]);
                $("#blanketOrderAdditionalFeeInput_grid").jqGrid('setRowData',blanketOrderAdditionalFeeLastRowId,{
                    blanketOrderAdditionalFeeDelete                    : "delete",
                    blanketOrderAdditionalFeeRemark                    : data.listCustomerBlanketOrderAdditionalFee[i].remark,
                    blanketOrderAdditionalFeeQuantity                  : data.listCustomerBlanketOrderAdditionalFee[i].quantity,
                    blanketOrderAdditionalFeeSearchUnitOfMeasure       : "...",
                    blanketOrderAdditionalFeeUnitOfMeasureCode         : data.listCustomerBlanketOrderAdditionalFee[i].unitOfMeasureCode,
                    blanketOrderAdditionalFeeAdditionalFeeCode         : data.listCustomerBlanketOrderAdditionalFee[i].additionalFeeCode,
                    blanketOrderAdditionalFeeAdditionalFeeName         : data.listCustomerBlanketOrderAdditionalFee[i].additionalFeeName,
                    blanketOrderAdditionalFeeSalesChartOfAccountCode   : data.listCustomerBlanketOrderAdditionalFee[i].coaCode,
                    blanketOrderAdditionalFeeSalesChartOfAccountName   : data.listCustomerBlanketOrderAdditionalFee[i].coaName,
                    blanketOrderAdditionalFeeChartOfAccountCode        : data.listCustomerBlanketOrderAdditionalFee[i].coaCode,
                    blanketOrderAdditionalFeePrice                     : data.listCustomerBlanketOrderAdditionalFee[i].price,
                    blanketOrderAdditionalFeeTotal                     : data.listCustomerBlanketOrderAdditionalFee[i].total
                });
            }
            calculateBlanketOrderTotalAdditional();
        });
        closeLoading();
    }
    
    function loadBlanketOrderPaymentTerm() {
        if($("#enumBlanketOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/blanket-order-payment-term-data";
        var params = "blanketOrder.code="+$("#blanketOrder\\.customerBlanketOrderCode").val();   
        
        blanketOrderPaymentTermLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderPaymentTerm.length; i++) {
                blanketOrderPaymentTermLastRowId++;
                
                $("#blanketOrderPaymentTermInput_grid").jqGrid("addRowData", blanketOrderPaymentTermLastRowId, data.listCustomerBlanketOrderPaymentTerm[i]);
                $("#blanketOrderPaymentTermInput_grid").jqGrid('setRowData',blanketOrderPaymentTermLastRowId,{
                    blanketOrderPaymentTermDelete             : "delete",
                    blanketOrderPaymentTermSearchPaymentTerm  : "...",
                    blanketOrderPaymentTermSortNO             : data.listCustomerBlanketOrderPaymentTerm[i].sortNo,
                    blanketOrderPaymentTermPaymentTermCode    : data.listCustomerBlanketOrderPaymentTerm[i].paymentTermCode,
                    blanketOrderPaymentTermPaymentTermName    : data.listCustomerBlanketOrderPaymentTerm[i].paymentTermName,
                    blanketOrderPaymentTermPercent            : data.listCustomerBlanketOrderPaymentTerm[i].percentage,
                    blanketOrderPaymentTermRemark             : data.listCustomerBlanketOrderPaymentTerm[i].remark
                });
            }
        });
        closeLoading();
    }
    
    function loadBlanketOrderItemDeliveryDate() {
        if($("#enumBlanketOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/blanket-order-item-delivery-data";
        var params = "blanketOrder.code="+$("#blanketOrder\\.customerBlanketOrderCode").val();   
        
        blanketOrderItemDeliveryLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderItemDeliveryDate.length; i++) {
                blanketOrderItemDeliveryLastRowId++;
                
                $("#blanketOrderItemDeliveryInput_grid").jqGrid("addRowData", blanketOrderItemDeliveryLastRowId, data.listCustomerBlanketOrderItemDeliveryDate[i]);
                $("#blanketOrderItemDeliveryInput_grid").jqGrid('setRowData',blanketOrderItemDeliveryLastRowId,{
                    blanketOrderItemDeliveryDelete                   : "delete",
                    blanketOrderItemDeliverySearchQuotation          : "...",
                    blanketOrderItemDeliverySalesQuotationCode       : data.listCustomerBlanketOrderItemDeliveryDate[i].salesQuotationCode,
                    blanketOrderItemDeliverySalesQuotationRefNo      : data.listCustomerBlanketOrderItemDeliveryDate[i].refNo,
                    blanketOrderItemDeliveryItemFinishGoodsCode      : data.listCustomerBlanketOrderItemDeliveryDate[i].itemFinishGoodsCode,
                    blanketOrderItemDeliveryItemFinishGoodsRemark    : data.listCustomerBlanketOrderItemDeliveryDate[i].itemFinishGoodsRemark,
                    blanketOrderItemDeliverySortNo                   : data.listCustomerBlanketOrderItemDeliveryDate[i].customerPurchaseOrderSortNo,
                    blanketOrderItemDeliveryQuantity                 : data.listCustomerBlanketOrderItemDeliveryDate[i].quantity,
                    blanketOrderItemDeliveryDeliveryDate             : formatDateRemoveT(data.listCustomerBlanketOrderItemDeliveryDate[i].deliveryDate,false)
                });
            }
        });
        closeLoading();
    }
    
    function blanketOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=blanketOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function blanketOrderAdditionalFeeInputGrid_SearchAdditional_OnClick(){
        window.open("./pages/search/search-additional-fee-sales.jsp?iddoc=blanketOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function blanketOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick(){
        window.open("./pages/search/search-payment-term.jsp?iddoc=blanketOrderPaymentTerm&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function blanketOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick(){
        var customer=txtBlanketOrderEndUserCode.val();
        window.open("./pages/search/search-item-finish-goods.jsp?iddoc=blanketOrderItemDetail&type=grid&idcustomer="+customer ,"Search", "scrollbars=1,width=600, height=500");
    }
    
    function sortNoDeliveryBO(itemCode){
         $('#blanketOrderItemDetailInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel); 
         var ids = jQuery("#blanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
         var temp="";
        for(var i=0;i<ids.length;i++){
                var Detail = $("#blanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                if (itemCode===Detail.blanketOrderItemDetailItem){
                    temp=Detail.blanketOrderItemDetailSortNo;
                }
               
        }
        
         $('#blanketOrderItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderItemDelivery_lastSel); 
         var idt = jQuery("#blanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
         for(var i=0;i<idt.length;i++){
             var Details = $("#blanketOrderItemDeliveryInput_grid").jqGrid('getRowData',idt[i]); 
                if (itemCode===Details.blanketOrderItemDeliveryItemCode){
                    $("#blanketOrderItemDeliveryInput_grid").jqGrid("setCell",idt[i], "blanketOrderItemDeliverySortNo",temp);

                }
         }
    }
    
    function blanketOrderItemDeliveryInputGrid_SearchQuotation_OnClick(){
      var ids = jQuery("#blanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
           
            if($("#blanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;}
                
            }
            
            if(cpoSalesQuotation_lastSel !== -1) {
                $('#blanketOrderItemDeliveryInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel);  
            }
            
           var listSalesQuotationCode = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#blanketOrderItemDeliveryInput_grid").jqGrid('getRowData',ids[q]); 
                listSalesQuotationCode[q] = [data.blanketOrderItemDeliverySalesQuotationCode];
//                 (listCode);
            }
        window.open("./pages/search/search-sales-quotation-array.jsp?iddoc=blanketOrderItemDelivery&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function setBlanketOrderPartialShipmentStatusStatus(){
        switch($("#blanketOrder\\.customerPurchaseOrder\\.partialShipmentStatus").val()){
            case "YES":
                $('input[name="blanketOrderPartialShipmentStatusRad"][value="YES"]').prop('checked',true);
                break;
            case "NO":
                $('input[name="blanketOrderPartialShipmentStatusRad"][value="NO"]').prop('checked',true);
                break;
        } 
    }
    
    function avoidSpcCharBo(){
        
        var selectedRowID = $("#blanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#blanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = blanketOrderItemDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_blanketOrderItemDetailSortNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep = str.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_blanketOrderItemDetailSortNo").val(rep);
        }
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_blanketOrderItemDetailSortNo").val("");
        }
    }
</script>

<s:url id="remoteurlBlanketOrderSalesQuotationInput" action="" />
<s:url id="remoteurlBlanketOrderAdditionalFeeInput" action="" />
<s:url id="remoteurlBlanketOrderPaymentTermInput" action="" />
<s:url id="remoteurlBlanketOrderItemDeliveryInput" action="" />
<b>CUSTOMER BLANKET ORDER</b><span id="msgBlanketOrderActivity"></span>
<hr>
<br class="spacer" />

<div id="blanketOrderInput" class="content ui-widget">
    <s:form id="frmBlanketOrderInput">
        <table cellpadding="2" cellspacing="2" id="headerBlanketOrderInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" style="width:180px"><B>BOD No *</B></td>
                            <td>
                                <s:textfield id="blanketOrder.code" name="blanketOrder.code" key="blanketOrder.code" readonly="true" size="30"></s:textfield>
                                <s:textfield id="blanketOrder.customerBlanketOrderCode" name="blanketOrder.customerBlanketOrderCode" key="blanketOrder.customerBlanketOrderCode" readonly="true" size="25" disabled="true" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ref BOD No *</B></td>
                            <td>
                            <s:textfield id="blanketOrder.custBONo" name="blanketOrder.custBONo" key="blanketOrder.custBONo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                                <s:textfield id="blanketOrder.refCUSTBOCode" name="blanketOrder.refCUSTBOCode" key="blanketOrder.refCUSTBOCode" readonly="true" size="30"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="blanketOrder.revision" name="blanketOrder.revision" key="blanketOrder.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                txtBlanketOrderBranchCode.change(function(ev) {

                                    if(txtBlanketOrderBranchCode.val()===""){
                                        txtBlanketOrderBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get";
                                    var params = "branch.code=" + txtBlanketOrderBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtBlanketOrderBranchCode.val(data.branchTemp.code);
                                            txtBlanketOrderBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtBlanketOrderBranchCode);
                                            txtBlanketOrderBranchCode.val("");
                                            txtBlanketOrderBranchName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="blanketOrder.branch.code" name="blanketOrder.branch.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="blanketOrder_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="blanketOrder.branch.name" name="blanketOrder.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="blanketOrder.transactionDate" name="blanketOrder.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                                <sj:datepicker id="blanketOrderTransactionDate" name="blanketOrderTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right"><B>Order Status * </B></td>
                            <td colspan="2">
                                <s:radio id="blanketOrderOrderStatusRad" name="blanketOrderOrderStatusRad" label="blanketOrderOrderStatusRad" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio>
                                <s:textfield id="blanketOrder.orderStatus" name="blanketOrder.orderStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="blanketOrder.purchaseOrderType" name="blanketOrder.purchaseOrderType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order*</B></td>
                            <td colspan="3"><s:textfield id="blanketOrder.customerPurchaseOrder.code" name="blanketOrder.customerPurchaseOrder.code" size="27" title=" " required="true" cssClass="required" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order No*</B></td>
                            <td colspan="3"><s:textfield id="blanketOrder.customerPurchaseOrder.customerPurchaseOrderNo" name="blanketOrder.customerPurchaseOrder.customerPurchaseOrderNo" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtBlanketOrderCustomerCode.change(function(ev) {

                                    if(txtBlanketOrderCustomerCode.val()===""){
                                        txtBlanketOrderCustomerName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get";
                                    var params = "customer.code=" + txtBlanketOrderCustomerCode.val();
                                        params += "&customer.activeStatus=TRUE";
                                        params += "&customer.customerStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtBlanketOrderCustomerCode.val(data.customerTemp.code);
                                            txtBlanketOrderCustomerName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer Not Found!",txtBlanketOrderCustomerCode);
                                            txtBlanketOrderCustomerCode.val("");
                                            txtBlanketOrderCustomerName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="blanketOrder.customer.code" name="blanketOrder.customer.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="blanketOrder_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="blanketOrder.customer.name" name="blanketOrder.customer.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>End User *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtBlanketOrderEndUserCode.change(function(ev) {

                                    if(txtBlanketOrderEndUserCode.val()===""){
                                        txtBlanketOrderEndUserName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get-end-user";
                                    var params = "customer.code=" + txtBlanketOrderEndUserCode.val();
                                        params += "&customer.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtBlanketOrderEndUserCode.val(data.customerTemp.code);
                                            txtBlanketOrderEndUserName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer End User Not Found!",txtBlanketOrderEndUserCode);
                                            txtBlanketOrderEndUserCode.val("");
                                            txtBlanketOrderEndUserName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="blanketOrder.endUser.code" name="blanketOrder.endUser.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="blanketOrder_btnCustomerEndUser" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="blanketOrder.endUser.name" name="blanketOrder.endUser.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Partial Shipment * </B></td>
                            <td colspan="2">
                                <s:radio id="blanketOrderPartialShipmentStatusRad" name="blanketOrderPartialShipmentStatusRad" label="blanketOrderPartialShipmentStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="blanketOrder.customerPurchaseOrder.partialShipmentStatus" name="blanketOrder.customerPurchaseOrder.partialShipmentStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Retention</td>
                            <td>
                                <s:textfield id="blanketOrder.customerPurchaseOrder.retentionPercent" name="blanketOrder.customerPurchaseOrder.retentionPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>Currency *</B></td>
                            <td colspan="3">
                                <script type = "text/javascript">

                                    txtBlanketOrderCurrencyCode.change(function(ev) {

                                        if(txtBlanketOrderCurrencyCode.val()===""){
                                            txtBlanketOrderCurrencyName.val("");
                                            return;
                                        }

                                        var url = "master/currency-get";
                                        var params = "currency.code=" + txtBlanketOrderCurrencyCode.val();
                                            params+= "&currency.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.currencyTemp){
                                                txtBlanketOrderCurrencyCode.val(data.currencyTemp.code);
                                                txtBlanketOrderCurrencyName.val(data.currencyTemp.name);
                                            }
                                            else{
                                                alertMessage("Currency Not Found",txtBlanketOrderCurrencyCode);
                                                txtBlanketOrderCurrencyCode.val("");
                                                txtBlanketOrderCurrencyName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="blanketOrder.currency.code" name="blanketOrder.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                <sj:a id="blanketOrder_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="blanketOrder.currency.name" name="blanketOrder.currency.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sales Person *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtBlanketOrderSalesPersonCode.change(function(ev) {
                                        if(txtBlanketOrderSalesPersonCode.val()===""){
                                            txtBlanketOrderSalesPersonName.val("");
                                            return;
                                        }
                                        var url = "master/sales-person-get";
                                        var params = "salesPerson.code=" + txtBlanketOrderSalesPersonCode.val();
                                            params+= "&salesPerson.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.salesPersonTemp){
                                                txtBlanketOrderSalesPersonCode.val(data.salesPersonTemp.code);
                                                txtBlanketOrderSalesPersonName.val(data.salesPersonTemp.name);
                                            }
                                            else{
                                                alertMessage("Sales Person Not Found!",txtBlanketOrderSalesPersonCode);
                                                txtBlanketOrderSalesPersonCode.val("");
                                                txtBlanketOrderSalesPersonName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="blanketOrder.salesPerson.code" name="blanketOrder.salesPerson.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                    <sj:a id="blanketOrder_btnSalesPerson" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="blanketOrder.salesPerson.name" name="blanketOrder.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Project</td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtBlanketOrderProjectCode.change(function(ev) {
                                        if(txtBlanketOrderProjectCode.val()===""){
                                            txtBlanketOrderProjectName.val("");
                                            return;
                                        }
                                        var url = "master/project-get";
                                        var params = "project.code=" + txtBlanketOrderProjectCode.val();
                                            params+= "&project.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.projectTemp){
                                                txtBlanketOrderProjectCode.val(data.projectTemp.code);
                                                txtBlanketOrderProjectName.val(data.projectTemp.name);
                                            }
                                            else{
                                                alertMessage("Project Not Found!",txtBlanketOrderProjectCode);
                                                txtBlanketOrderProjectCode.val("");
                                                txtBlanketOrderProjectName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="blanketOrder.project.code" name="blanketOrder.project.code" title=" " size="22"></s:textfield>
                                    <sj:a id="blanketOrder_btnProject" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="blanketOrder.project.name" name="blanketOrder.project.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3"><s:textfield id="blanketOrder.refNo" name="blanketOrder.refNo" size="27"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="blanketOrder.remark" name="blanketOrder.remark"  cols="70" rows="2" height="20"></s:textarea></td>
                        </tr> 
                    </table>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="blanketOrderDateFirstSession" name="blanketOrderDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="blanketOrderDateLastSession" name="blanketOrderDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumBlanketOrderActivity" name="enumBlanketOrderActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="blanketOrder.createdBy" name="blanketOrder.createdBy" key="blanketOrder.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="blanketOrder.createdDate" name="blanketOrder.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="blanketOrder.createdDateTemp" name="blanketOrder.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmBlanketOrder" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmBlanketOrder" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnBOSearchSalQuo" button="true" style="width: 200px">Search Sales Quotation</sj:a>
                </td>
            </tr>
        </table>           
        <br class="spacer" />
        <div id="blanketOrderSalesQuotationInputGrid">
            <sjg:grid
                id="blanketOrderSalesQuotationInput_grid"
                caption="Sales Quotation"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listCustomerBlanketOrderSalesQuotation"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuBlanketOrderDetail').width()"
                editurl="%{remoteurlBlanketOrderSalesQuotationInput}"
                onSelectRowTopics="blanketOrderSalesQuotationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="blanketOrderSalesQuotation" index="blanketOrderSalesQuotation" key="blanketOrderSalesQuotation" 
                    title="" width="50" sortable="true" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationDelete" index="blanketOrderSalesQuotationDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'blanketOrderSalesQuotationInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationCode" index="blanketOrderSalesQuotationCode" 
                    title="SLS-QUO No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationTransactionDate" index="blanketOrderSalesQuotationTransactionDate" key="blanketOrderSalesQuotationTransactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationCustomerCode" index="blanketOrderSalesQuotationCustomerCode" 
                    title="Customer Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationCustomerName" index="blanketOrderSalesQuotationCustomerName" 
                    title="Customer Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationEndUserCode" index="blanketOrderSalesQuotationEndUserCode" 
                    title="End User Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationEndUserName" index="blanketOrderSalesQuotationEndUserName" 
                    title="End User Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "blanketOrderSalesQuotationRfqCode" index = "blanketOrderSalesQuotationRfqCode" key = "blanketOrderSalesQuotationRfqCode" 
                    title = "RFQ No" width = "80" edittype="text" 
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationProjectCode" index="blanketOrderSalesQuotationProjectCode" 
                    title="Project" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationSubject" index="blanketOrderSalesQuotationSubject" 
                    title="Subject" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationAttn" index="blanketOrderSalesQuotationAttn" 
                    title="Attn" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationRefNo" index="blanketOrderSalesQuotationRefNo" key="blanketOrderSalesQuotationRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderSalesQuotationRemark" index="blanketOrderSalesQuotationRemark" key="blanketOrderSalesQuotationRemark" 
                    title="Remark" width="150" sortable="true"
                />
            </sjg:grid > 
        </div>          
        <table>        
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmBlanketOrderSalesQuotation" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmBlanketOrderSalesQuotation" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmBlanketOrderSalesQuotationDetailSort" button="true" style="width: 70px">Sort No</sj:a>
                </td>
            </tr>
        </table>
        <div id="id-tbl-additional-payment-item-delivery-bo">
            <div>
                <sjg:grid
                    id="blanketOrderItemDetailInput_grid"
                    caption="Item"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listSalesQuotationDetailTemp"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnucustomerpurchaseOrder').width()"
                    editurl="%{remoteurlBlanketOrderSalesQuotationInput}"
                    onSelectRowTopics="blanketOrderItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="blanketOrderItemDetail" index="blanketOrderItemDetail" key="blanketOrderItemDetail" 
                        title="" width="50" sortable="true" editable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailDelete" index="blanketOrderItemDetailDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'blanketOrderItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />                    
                    <sjg:gridColumn
                        name="blanketOrderItemDetailQuotationNoDetailCode" index="blanketOrderItemDetailQuotationNoDetailCode" key="blanketOrderItemDetailQuotationNoDetailCode" 
                        title="Quotation No" width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="blanketOrderItemDetailQuotationNo" index="blanketOrderItemDetailQuotationNo" key="blanketOrderItemDetailQuotationNo" 
                        title="Quotation No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailQuotationRefNo" index="blanketOrderItemDetailQuotationRefNo" key="blanketOrderItemDetailQuotationRefNo" 
                        title="Ref No" width="150" sortable="true" hidden = "true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSortNo" index="blanketOrderItemDetailSortNo" 
                        title="Sort No" width="80" sortable="true" editable="true" edittype="text" formatter="integer"
                        editoptions="{onKeyUp:'avoidSpcCharBo()'}"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSearchItemFinishGoods" index="blanketOrderItemDetailSearchItemFinishGoods" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"
                        editoptions="{onClick:'blanketOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsCode" index="blanketOrderItemDetailItemFinishGoodsCode" key="blanketOrderItemDetailItemFinishGoodsCode" 
                        title="Item Finish Goods Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsRemark" index="blanketOrderItemDetailItemFinishGoodsRemark" key="blanketOrderItemDetailItemFinishGoodsRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailValveTypeCode" index="blanketOrderItemDetailValveTypeCode" key="blanketOrderItemDetailValveTypeCode" 
                        title="Valve Type Code (QUO)" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailValveTypeName" index="blanketOrderItemDetailValveTypeName" key="blanketOrderItemDetailValveTypeName" 
                        title="Valve Type Name (QUO)" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemAlias" index="blanketOrderItemDetailItemAlias" 
                        title="Item Alias" width="100" sortable="true" editable="true" edittype="text"
                    /> 
                    <sjg:gridColumn
                        name="blanketOrderItemDetailValveTag" index="blanketOrderItemDetailValveTag" 
                        title="Valve Tag" width="100" sortable="true" editable="true" edittype="text"
                    />  
                    <sjg:gridColumn
                        name="blanketOrderItemDetailDataSheet" index="blanketOrderItemDetailDataSheet" 
                        title="Data Sheet" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailDescription" index="blanketOrderItemDetailDescription" 
                        title="Description" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <!--Body Const 01-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailBodyConstQuotation" index="blanketOrderItemDetailBodyConstQuotation" 
                        title="QUO (01)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBodyConstCode" index="blanketOrderItemDetailItemFinishGoodsBodyConstCode" 
                        title="IFG (01)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBodyConstName" index="blanketOrderItemDetailItemFinishGoodsBodyConstName" 
                        title="IFG (01)" width="100" sortable="true"
                    />
                    <!--Type Design 02-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailTypeDesignQuotation" index="blanketOrderItemDetailTypeDesignQuotation" 
                        title="QUO (02)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsTypeDesignCode" index="blanketOrderItemDetailItemFinishGoodsTypeDesignCode" 
                        title="IFG (02)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsTypeDesignName" index="blanketOrderItemDetailItemFinishGoodsTypeDesignName" 
                        title="IFG (02)" width="100" sortable="true"
                    />
                    <!--Seat Design 03-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSeatDesignQuotation" index="blanketOrderItemDetailSeatDesignQuotation" 
                        title="QUO (03)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSeatDesignCode" index="blanketOrderItemDetailItemFinishGoodsSeatDesignCode" 
                        title="IFG (03)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSeatDesignName" index="blanketOrderItemDetailItemFinishGoodsSeatDesignName" 
                        title="IFG (03)" width="100" sortable="true"
                    />
                    <!--Size 04-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSizeQuotation" index="blanketOrderItemDetailSizeQuotation" 
                        title="QUO (04)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSizeCode" index="blanketOrderItemDetailItemFinishGoodsSizeCode" 
                        title="IFG (04)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSizeName" index="blanketOrderItemDetailItemFinishGoodsSizeName" 
                        title="IFG (04)" width="100" sortable="true"
                    />
                    <!--Rating 05-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailRatingQuotation" index="blanketOrderItemDetailRatingQuotation" 
                        title="QUO (05)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsRatingCode" index="blanketOrderItemDetailItemFinishGoodsRatingCode" 
                        title="IFG (05)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsRatingName" index="blanketOrderItemDetailItemFinishGoodsRatingName" 
                        title="IFG (05)" width="100" sortable="true"
                    />
                    <!--Bore 06-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailBoreQuotation" index="blanketOrderItemDetailBoreQuotation" 
                        title="QUO (06)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBoreCode" index="blanketOrderItemDetailItemFinishGoodsBoreCode" 
                        title="IFG (06)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBoreName" index="blanketOrderItemDetailItemFinishGoodsBoreName" 
                        title="IFG (06)" width="100" sortable="true"
                    />
                    <!--EndCon 07-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailEndConQuotation" index="blanketOrderItemDetailEndConQuotation" 
                        title="QUO (07)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsEndConCode" index="blanketOrderItemDetailItemFinishGoodsEndConCode" 
                        title="IFG (07)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsEndConName" index="blanketOrderItemDetailItemFinishGoodsEndConName" 
                        title="IFG (07)" width="100" sortable="true"
                    />
                    <!--Body 08-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailBodyQuotation" index="blanketOrderItemDetailBodyQuotation" 
                        title="QUO (08)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBodyCode" index="blanketOrderItemDetailItemFinishGoodsBodyCode" 
                        title="IFG (08)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBodyName" index="blanketOrderItemDetailItemFinishGoodsBodyName" 
                        title="IFG (08)" width="100" sortable="true"
                    />
                    <!--Ball 09-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailBallQuotation" index="blanketOrderItemDetailBallQuotation" 
                        title="QUO (09)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBallCode" index="blanketOrderItemDetailItemFinishGoodsBallCode" 
                        title="IFG (09)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBallName" index="blanketOrderItemDetailItemFinishGoodsBallName" 
                        title="IFG (09)" width="100" sortable="true"
                    />
                    <!--Seat 10-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSeatQuotation" index="blanketOrderItemDetailSeatQuotation" 
                        title="QUO (10)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSeatCode" index="blanketOrderItemDetailItemFinishGoodsSeatCode" 
                        title="IFG (10)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSeatName" index="blanketOrderItemDetailItemFinishGoodsSeatName" 
                        title="IFG (10)" width="100" sortable="true"
                    />
                    <!--SeatInsert 11-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSeatInsertQuotation" index="blanketOrderItemDetailSeatInsertQuotation" 
                        title="QUO (11)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSeatInsertCode" index="blanketOrderItemDetailItemFinishGoodsSeatInsertCode" 
                        title="IFG (11)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSeatInsertName" index="blanketOrderItemDetailItemFinishGoodsSeatInsertName" 
                        title="IFG (11)" width="100" sortable="true"
                    />
                    <!--Stem 12-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailStemQuotation" index="blanketOrderItemDetailStemQuotation" 
                        title="QUO (12)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsStemCode" index="blanketOrderItemDetailItemFinishGoodsStemCode" 
                        title="IFG (12)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsStemName" index="blanketOrderItemDetailItemFinishGoodsStemName" 
                        title="IFG (12)" width="100" sortable="true"
                    />
                    <!--Seal 13-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSealQuotation" index="blanketOrderItemDetailSealQuotation" 
                        title="QUO (13)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSealCode" index="blanketOrderItemDetailItemFinishGoodsSealCode" 
                        title="IFG (13)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSealName" index="blanketOrderItemDetailItemFinishGoodsSealName" 
                        title="IFG (13)" width="100" sortable="true"
                    />
                    <!--Bolt 14-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailBoltQuotation" index="blanketOrderItemDetailBoltQuotation" 
                        title="QUO (14)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBoltCode" index="blanketOrderItemDetailItemFinishGoodsBoltCode" 
                        title="IFG (14)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBoltName" index="blanketOrderItemDetailItemFinishGoodsBoltName" 
                        title="IFG (14)" width="100" sortable="true"
                    />
                    <!--Disc 15-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailDiscQuotation" index="blanketOrderItemDetailDiscQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsDiscCode" index="blanketOrderItemDetailItemFinishGoodsDiscCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsDiscName" index="blanketOrderItemDetailItemFinishGoodsDiscName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Plates 16-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailPlatesQuotation" index="blanketOrderItemDetailPlatesQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsPlatesCode" index="blanketOrderItemDetailItemFinishGoodsPlatesCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsPlatesName" index="blanketOrderItemDetailItemFinishGoodsPlatesName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Shaft 17-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailShaftQuotation" index="blanketOrderItemDetailShaftQuotation" 
                        title="QUO (17)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsShaftCode" index="blanketOrderItemDetailItemFinishGoodsShaftCode" 
                        title="IFG (17)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsShaftName" index="blanketOrderItemDetailItemFinishGoodsShaftName" 
                        title="IFG (17)" width="100" sortable="true"
                    />
                    <!--Spring 18-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailSpringQuotation" index="blanketOrderItemDetailSpringQuotation" 
                        title="QUO (18)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSpringCode" index="blanketOrderItemDetailItemFinishGoodsSpringCode" 
                        title="IFG (18)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsSpringName" index="blanketOrderItemDetailItemFinishGoodsSpringName" 
                        title="IFG (18)" width="100" sortable="true"
                    />
                    <!--ArmPin 19-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailArmPinQuotation" index="blanketOrderItemDetailArmPinQuotation" 
                        title="QUO (19)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsArmPinCode" index="blanketOrderItemDetailItemFinishGoodsArmPinCode" 
                        title="IFG (19)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsArmPinName" index="blanketOrderItemDetailItemFinishGoodsArmPinName" 
                        title="IFG (19)" width="100" sortable="true"
                    />
                    <!--BackSeat 20-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailBackSeatQuotation" index="blanketOrderItemDetailBackSeatQuotation" 
                        title="QUO (20)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBackSeatCode" index="blanketOrderItemDetailItemFinishGoodsBackSeatCode" 
                        title="IFG (20)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsBackSeatName" index="blanketOrderItemDetailItemFinishGoodsBackSeatName" 
                        title="IFG (20)" width="100" sortable="true"
                    />
                    <!--Arm 21-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailArmQuotation" index="blanketOrderItemDetailArmQuotation" 
                        title="QUO (21)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsArmCode" index="blanketOrderItemDetailItemFinishGoodsArmCode" 
                        title="IFG (21)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsArmName" index="blanketOrderItemDetailItemFinishGoodsArmName" 
                        title="IFG (21)" width="100" sortable="true"
                    />
                    <!--HingePin 22-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailHingePinQuotation" index="blanketOrderItemDetailHingePinQuotation" 
                        title="QUO (22)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsHingePinCode" index="blanketOrderItemDetailItemFinishGoodsHingePinCode" 
                        title="IFG (22)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsHingePinName" index="blanketOrderItemDetailItemFinishGoodsHingePinName" 
                        title="IFG (22)" width="100" sortable="true"
                    />
                    <!--StopPin 23-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailStopPinQuotation" index="blanketOrderItemDetailStopPinQuotation" 
                        title="QUO (23)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsStopPinCode" index="blanketOrderItemDetailItemFinishGoodsStopPinCode" 
                        title="IFG (23)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsStopPinName" index="blanketOrderItemDetailItemFinishGoodsStopPinName" 
                        title="IFG (23)" width="100" sortable="true"
                    />
                    <!--Operator 99-->
                    <sjg:gridColumn
                        name="blanketOrderItemDetailOperatorQuotation" index="blanketOrderItemDetailOperatorQuotation" 
                        title="QUO (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsOperatorCode" index="blanketOrderItemDetailItemFinishGoodsOperatorCode" 
                        title="IFG (99)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailItemFinishGoodsOperatorName" index="blanketOrderItemDetailItemFinishGoodsOperatorName" 
                        title="IFG (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailNote" index="blanketOrderItemDetailNote" title="Note" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailQuantity" index="blanketOrderItemDetailQuantity" key="blanketOrderItemDetailQuantity" title="Qty" 
                        width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                        formatter="number" editrules="{ double: true }"
                        editoptions="{onKeyUp:'calculateItemSalesQuotationDetailBO()'}"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailPrice" index="blanketOrderItemDetailPrice" key="blanketOrderItemDetailPrice" title="Unit Price" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="blanketOrderItemDetailTotal" index="blanketOrderItemDetailTotal" key="blanketOrderItemDetailTotal" title="Total" 
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
                                id="blanketOrderAdditionalFeeInput_grid"
                                caption="Additional"
                                dataType="local"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listCustomerBlanketOrderAdditionalFee"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false"
                                editinline="true"
                                width="$('#tabmnuBlanketOrderAdditionalFee').width()"
                                editurl="%{remoteurlBlanketOrderAdditionalFeeInput}"
                                onSelectRowTopics="blanketOrderAdditionalFeeInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFee" index="blanketOrderAdditionalFee" key="blanketOrderAdditionalFee" 
                                    title="" width="50" sortable="true" editable="true" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeDelete" index="blanketOrderAdditionalFeeDelete" title="" width="50" align="centre"
                                    editable="true" edittype="button"
                                    editoptions="{onClick:'blanketOrderAdditionalFeeInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeRemark" index="blanketOrderAdditionalFeeRemark" key="blanketOrderAdditionalFeeRemark" 
                                    title="Remark" width="150" sortable="true" editable="true"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeQuantity" index="blanketOrderAdditionalFeeQuantity" key="blanketOrderAdditionalFeeQuantity" title="Quantity" 
                                    width="80" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateBlanketOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeSearchUnitOfMeasure" index="blanketOrderAdditionalFeeSearchUnitOfMeasure" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'blanketOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeUnitOfMeasureCode" index="blanketOrderAdditionalFeeUnitOfMeasureCode" 
                                    title="Unit" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeUnitOfMeasureCodeBO()'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeSearchAdditional" index="blanketOrderAdditionalFeeSearchAdditional" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'blanketOrderAdditionalFeeInputGrid_SearchAdditional_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeAdditionalFeeCode" index="blanketOrderAdditionalFeeAdditionalFeeCode" 
                                    title="Additional Fee Code" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeCodeBO()'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeAdditionalFeeName" index="blanketOrderAdditionalFeeAdditionalFeeName" 
                                    title="Additional Fee Name" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeSalesChartOfAccountCode" index="blanketOrderAdditionalFeeSalesChartOfAccountCode" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeSalesChartOfAccountName" index="blanketOrderAdditionalFeeSalesChartOfAccountName" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeePrice" index="blanketOrderAdditionalFeePrice" key="blanketOrderAdditionalFeePrice" title="Price" 
                                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateBlanketOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderAdditionalFeeTotal" index="blanketOrderAdditionalFeeTotal" key="blanketOrderAdditionalFeeTotal" title="Total" 
                                    width="150" align="right" edittype="text"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                            </sjg:grid >
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="blanketOrderAdditionalFeeAddRow" name="blanketOrderAdditionalFeeAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                            <sj:a href="#" id="btnBlanketOrderAdditionalFeeAdd" button="true"  style="width: 60px">Add</sj:a>
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
                                            id="blanketOrderPaymentTermInput_grid"
                                            caption="Payment Term"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerBlanketOrderPaymentTerm"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlBlanketOrderPaymentTermInput}"
                                            onSelectRowTopics="blanketOrderPaymentTermInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTerm" index="blanketOrderPaymentTerm" 
                                                title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                            />  
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTermDelete" index="blanketOrderPaymentTermDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'blanketOrderPaymentTermInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTermSortNO" index="blanketOrderPaymentTermSortNO" key="blanketOrderPaymentTermSortNO" title="Term No" 
                                                width="80" align="right" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTermPaymentTermCode" index="blanketOrderPaymentTermPaymentTermCode" 
                                                title="Payment Term Code" width="100" sortable="true" editable="true" edittype="text"
                                                editoptions="{onChange:'onchangePaymentTermPaymentTermCodeBO()'}"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTermSearchPaymentTerm" index="blanketOrderPaymentTermSearchPaymentTerm" title="" width="25" align="centre"
                                                editable="true" dataType="html" edittype="button" 
                                                editoptions="{onClick:'blanketOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick()', value:'...'}"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTermPaymentTermName" index="blanketOrderPaymentTermPaymentTermName" 
                                                title="Payment Term" width="100" sortable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTermPercent" index="blanketOrderPaymentTermPercent" key="blanketOrderPaymentTermPercent" title="Percent" 
                                                width="80" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderPaymentTermRemark" index="blanketOrderPaymentTermRemark" 
                                                title="Note" width="200" sortable="true" edittype="text" editable="true"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="blanketOrderPaymentTermAddRow" name="blanketOrderPaymentTermAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnBlanketOrderPaymentTermAdd" button="true"  style="width: 60px">Add</sj:a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table valign="top">
                                <tr>
                                    <td width="120px" align="right"><B>Total Transaction</B></td>
                                    <td width="120px">
                                        <s:textfield id="blanketOrder.totalTransactionAmount" name="blanketOrder.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Disc
                                        <s:textfield id="blanketOrder.discountPercent" name="blanketOrder.discountPercent" onkeyup="calculateBlanketOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                    <s:textfield id="blanketOrder.discountAmount" name="blanketOrder.discountAmount" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Additional</td>
                                    <td>
                                    <s:textfield id="blanketOrder.totalAdditionalFeeAmount" name="blanketOrder.totalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" disabled="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><b>Sub Total(Tax Base)</b></td>
                                    <td>
                                        <s:textfield id="blanketOrder.taxBaseAmount" name="blanketOrder.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">VAT
                                        <s:textfield id="blanketOrder.vatPercent" name="blanketOrder.vatPercent" onkeyup="calculateBlanketOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                        <s:textfield id="blanketOrder.vatAmount" name="blanketOrder.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Grand Total</B></td>
                                    <td>
                                        <s:textfield id="blanketOrder.grandTotalAmount" name="blanketOrder.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
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
                        <sj:a href="#" id="btnConfirmBlanketOrderItemDetailDelivery" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmBlanketOrderItemDetailDelivery" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>                
            <div id="id-tbl-additional-item-delivery-detail-bo">
                <table>
                    <tr>
                        <td align="right">Delivery Date
                            <sj:datepicker id="blanketOrderDeliveryDateSet" name="blanketOrderDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today"></sj:datepicker>
                            <sj:a href="#" id="btnBlanketOrderDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;
                            <sj:a href="#" id="btnBlanketOrderCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="blanketOrderItemDeliveryInput_grid"
                                            caption="Item Delivery Date"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerBlanketOrderItemDeliveryDate"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlBlanketOrderItemDeliveryInput}"
                                            onSelectRowTopics="blanketOrderItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="blanketOrderItemDelivery" index="blanketOrderItemDelivery" key="blanketOrderItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderItemDeliveryDelete" index="blanketOrderItemDeliveryDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'blanketOrderItemDeliveryInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderItemDeliverySearchQuotation" index="blanketOrderItemDeliverySearchQuotation" title="" width="25" align="centre"
                                                editable="true"
                                                dataType="html"
                                                edittype="button"
                                                editoptions="{onClick:'blanketOrderItemDeliveryInputGrid_SearchQuotation_OnClick()', value:'...'}"
                                            /> 
                                            <sjg:gridColumn
                                                name = "blanketOrderItemDeliveryItemFinishGoodsCode" index = "blanketOrderItemDeliveryItemFinishGoodsCode" key = "blanketOrderItemDeliveryItemFinishGoodsCode" 
                                                title = "Item Finish Goods Code" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "blanketOrderItemDeliveryItemFinishGoodsRemark" index = "blanketOrderItemDeliveryItemFinishGoodsRemark" key = "blanketOrderItemDeliveryItemFinishGoodsRemark" 
                                                title = "IFG Remark" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderItemDeliverySortNo" index="blanketOrderItemDeliverySortNo" title="Sort No" width="80" sortable="true"
                                            />  
                                            <sjg:gridColumn
                                                name="blanketOrderItemDeliveryQuantity" index="blanketOrderItemDeliveryQuantity" key="blanketOrderItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderItemDeliveryDeliveryDate" index="blanketOrderItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="true" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangeBlanketOrderItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderItemDeliveryDeliveryDateTemp" index="blanketOrderItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                            <sjg:gridColumn
                                                name = "blanketOrderItemDeliverySalesQuotationCode" index = "blanketOrderItemDeliverySalesQuotationCode" key = "blanketOrderItemDeliverySalesQuotationCode" 
                                                title = "Quotation No" width = "100" 
                                            />
                                            <sjg:gridColumn
                                                name = "blanketOrderItemDeliverySalesQuotationRefNo" index = "blanketOrderItemDeliverySalesQuotationRefNo" key = "blanketOrderItemDeliverySalesQuotationRefNo" 
                                                title = "Ref No" width = "100" 
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="blanketOrderItemDelieryAddRow" name="blanketOrderItemDelieryAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnBlanketOrderItemDelieryAdd" button="true"  style="width: 60px">Add</sj:a>
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
                    <sj:a href="#" id="btnBlanketOrderSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnBlanketOrderCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    