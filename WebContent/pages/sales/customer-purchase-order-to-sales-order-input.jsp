
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
    .ui-dialog-titlebar-close,#customerPurchaseOrderSalesQuotationInput_grid_pager_center,
    #customerPurchaseOrderItemDetailInput_grid_pager_center,#customerPurchaseOrderAdditionalFeeInput_grid_pager_center,
    #customerPurchaseOrderPaymentTermInput_grid_pager_center,#customerPurchaseOrderItemDeliveryInput_grid_pager_center{
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

    var customerPurchaseOrderSalesQuotationLastRowId=0,customerPurchaseOrderSalesQuotation_lastSel = -1;
    var customerPurchaseOrderItemDetailLastRowId=0,customerPurchaseOrderItemDetail_lastSel = -1;
    var customerPurchaseOrderAdditionalFeeLastRowId=0,customerPurchaseOrderAdditionalFee_lastSel = -1;
    var customerPurchaseOrderPaymentTermLastRowId=0,customerPurchaseOrderPaymentTerm_lastSel = -1;
    var customerPurchaseOrderItemDeliveryLastRowId=0,customerPurchaseOrderItemDelivery_lastSel = -1;
    var cpoSalesQuotation_lastSel = -1;
    var 
        txtCustomerPurchaseOrderCode = $("#customerPurchaseOrder\\.code"),
        dtpCustomerPurchaseOrderTransactionDate = $("#customerPurchaseOrder\\.transactionDate"),
        txtCustomerPurchaseOrderCustomerCode= $("#customerPurchaseOrder\\.customer\\.code"),
        txtCustomerPurchaseOrderCustomerName= $("#customerPurchaseOrder\\.customer\\.name"),
        txtCustomerPurchaseOrderEndUserCode= $("#customerPurchaseOrder\\.endUser\\.code"),
        txtCustomerPurchaseOrderEndUserName= $("#customerPurchaseOrder\\.endUser\\.name"),
        txtCustomerPurchaseOrderRetention= $("#customerPurchaseOrder\\.retentionPercent"),
        txtCustomerPurchaseOrderCurrencyCode= $("#customerPurchaseOrder\\.currency\\.code"),
        txtCustomerPurchaseOrderCurrencyName= $("#customerPurchaseOrder\\.currency\\.name"),
        txtCustomerPurchaseOrderBranchCode= $("#customerPurchaseOrder\\.branch\\.code"),
        txtCustomerPurchaseOrderBranchName= $("#customerPurchaseOrder\\.branch\\.name"),
        txtCustomerPurchaseOrderSalesPersonCode= $("#customerPurchaseOrder\\.salesPerson\\.code"),
        txtCustomerPurchaseOrderSalesPersonName= $("#customerPurchaseOrder\\.salesPerson\\.name"),
        txtCustomerPurchaseOrderProjectCode= $("#customerPurchaseOrder\\.project\\.code"),
        txtCustomerPurchaseOrderProjectName= $("#customerPurchaseOrder\\.project\\.name"),
        txtCustomerPurchaseOrderRefNo = $("#customerPurchaseOrder\\.refNo"),
        txtCustomerPurchaseOrderRemark = $("#customerPurchaseOrder\\.remark"),
        txtCustomerPurchaseOrderTotalTransactionAmount = $("#customerPurchaseOrder\\.totalTransactionAmount"),
        txtCustomerPurchaseOrderDiscountPercent = $("#customerPurchaseOrder\\.discountPercent"),
        txtCustomerPurchaseOrderDiscountAmount = $("#customerPurchaseOrder\\.discountAmount"),
        txtCustomerPurchaseOrderTotalAdditionalFee= $("#customerPurchaseOrder\\.totalAdditionalFeeAmount"),
        txtCustomerPurchaseOrderTaxBaseAmount= $("#customerPurchaseOrder\\.taxBaseAmount"),
        txtCustomerPurchaseOrderVATPercent = $("#customerPurchaseOrder\\.vatPercent"),
        txtCustomerPurchaseOrderVATAmount = $("#customerPurchaseOrder\\.vatAmount"),
        txtCustomerPurchaseOrderGrandTotalAmount = $("#customerPurchaseOrder\\.grandTotalAmount");

        function loadGridItem(){
             //function groupingHeader
                $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true, 
                    groupHeaders:[
                          {startColumnName: 'customerPurchaseOrderItemDetailBodyConstQuotation', numberOfColumns: 3, titleText: 'Body Const'},
                          {startColumnName: 'customerPurchaseOrderItemDetailTypeDesignQuotation', numberOfColumns: 3, titleText: 'Type Design'},
                          {startColumnName: 'customerPurchaseOrderItemDetailSeatDesignQuotation', numberOfColumns: 3, titleText: 'Seat Design'},
                          {startColumnName: 'customerPurchaseOrderItemDetailSizeQuotation', numberOfColumns: 3, titleText: 'Size'},
                          {startColumnName: 'customerPurchaseOrderItemDetailRatingQuotation', numberOfColumns: 3, titleText: 'Rating'},
                          {startColumnName: 'customerPurchaseOrderItemDetailBoreQuotation', numberOfColumns: 3, titleText: 'Bore'},
                          
                          {startColumnName: 'customerPurchaseOrderItemDetailEndConQuotation', numberOfColumns: 3, titleText: 'End Con'},
                          {startColumnName: 'customerPurchaseOrderItemDetailBodyQuotation', numberOfColumns: 3, titleText: 'Body'},
                          {startColumnName: 'customerPurchaseOrderItemDetailBallQuotation', numberOfColumns: 3, titleText: 'Ball'},
                          {startColumnName: 'customerPurchaseOrderItemDetailSeatQuotation', numberOfColumns: 3, titleText: 'Seat'},
                          {startColumnName: 'customerPurchaseOrderItemDetailSeatInsertQuotation', numberOfColumns: 3, titleText: 'Seat Insert'},
                          {startColumnName: 'customerPurchaseOrderItemDetailStemQuotation', numberOfColumns: 3, titleText: 'Stem'},
                          
                          {startColumnName: 'customerPurchaseOrderItemDetailSealQuotation', numberOfColumns: 3, titleText: 'Seal'},
                          {startColumnName: 'customerPurchaseOrderItemDetailBoltQuotation', numberOfColumns: 3, titleText: 'Bolt'},
                          {startColumnName: 'customerPurchaseOrderItemDetailDiscQuotation', numberOfColumns: 3, titleText: 'Disc'},
                          {startColumnName: 'customerPurchaseOrderItemDetailPlatesQuotation', numberOfColumns: 3, titleText: 'Plates'},
                          {startColumnName: 'customerPurchaseOrderItemDetailShaftQuotation', numberOfColumns: 3, titleText: 'Shaft'},
                          {startColumnName: 'customerPurchaseOrderItemDetailSpringQuotation', numberOfColumns: 3, titleText: 'Spring'},
                          
                          {startColumnName: 'customerPurchaseOrderItemDetailArmPinQuotation', numberOfColumns: 3, titleText: 'Arm Pin'},
                          {startColumnName: 'customerPurchaseOrderItemDetailBackSeatQuotation', numberOfColumns: 3, titleText: 'Back Seat'},
                          {startColumnName: 'customerPurchaseOrderItemDetailArmQuotation', numberOfColumns: 3, titleText: 'Arm'},
                          {startColumnName: 'customerPurchaseOrderItemDetailHingePinQuotation', numberOfColumns: 3, titleText: 'Hinge Pin'},
                          {startColumnName: 'customerPurchaseOrderItemDetailStopPinQuotation', numberOfColumns: 3, titleText: 'Stop Pin'},
                          {startColumnName: 'customerPurchaseOrderItemDetailOperatorQuotation', numberOfColumns: 3, titleText: 'Operator'}
                    ]
                });
        }

    $(document).ready(function() {
        flagIsConfirmedCPO=false;
        flagIsConfirmedCPOSalesQuotation=false;
        flagIsConfirmedCPOItemDelivery=false;
        $("#frmCustomerPurchaseOrderInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        
        formatNumericCPOSO();
        $("#msgCustomerPurchaseOrderActivity").html(" - <i>" + $("#enumCustomerPurchaseOrderActivity").val()+"<i>").show();
        setCustomerPurchaseOrderPartialShipmentStatusStatus();
        
        $('input[name="customerPurchaseOrderPartialShipmentStatusRad"][value="YES"]').change(function(ev){
            $("#customerPurchaseOrder\\.partialShipmentStatus").val("YES");
        });
        
        $('input[name="customerPurchaseOrderPartialShipmentStatusRad"][value="NO"]').change(function(ev){
            $("#customerPurchaseOrder\\.partialShipmentStatus").val("NO");
        });
        
        $('input[name="customerPurchaseOrderOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#customerPurchaseOrder\\.orderStatus").val(value);
        });
                
        $('input[name="customerPurchaseOrderOrderStatusRad"][value="SALES_ORDER"]').change(function(ev){
            var value="SALES_ORDER";
            $("#customerPurchaseOrder\\.orderStatus").val(value);
        });
        
        $('#customerPurchaseOrderOrderStatusRadSALES\\ ORDER').prop('checked',true);
        $("#customerPurchaseOrder\\.orderStatus").val("SALES_ORDER");
        
        //Set Default View
        $("#btnUnConfirmCustomerPurchaseOrder").css("display", "none");
        $("#btnUnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "none");
        $("#btnUnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderSalesQuotationDetailSort").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "none");
        $("#btnCPOSOSearchSalQuo").css("display", "none");
        $('#customerPurchaseOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-payment-item-delivery').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-item-delivery-detail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmCustomerPurchaseOrder").click(function(ev) {
            
            if(!$("#frmCustomerPurchaseOrderInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                return;
            }
            
            var date1 = dtpCustomerPurchaseOrderTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#customerPurchaseOrderTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($('#enumCustomerPurchaseOrderActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#customerPurchaseOrderTransactionDate").val(),dtpCustomerPurchaseOrderTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpCustomerPurchaseOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($('#enumCustomerPurchaseOrderActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#customerPurchaseOrderTransactionDate").val(),dtpCustomerPurchaseOrderTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpCustomerPurchaseOrderTransactionDate);
                }
                return;
            }

            
            if(parseFloat(txtCustomerPurchaseOrderRetention.val())===0.00){
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
                                        $("#btnUnConfirmCustomerPurchaseOrder").css("display", "block");
                                        $("#btnCPOSOSearchSalQuo").css("display", "block");
                                        $("#btnConfirmCustomerPurchaseOrder").css("display", "none");   
                                        $('#headerCustomerPurchaseOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                        $("#btnConfirmCustomerPurchaseOrderSalesQuotation").show();
                                        $('#customerPurchaseOrderSalesQuotationInputGrid').unblock();
                                        loadCustomerPurchaseOrderSalesQuotation();
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
                $("#btnUnConfirmCustomerPurchaseOrder").css("display", "block");
                $("#btnCPOSOSearchSalQuo").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrder").css("display", "none");   
                $('#headerCustomerPurchaseOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#btnConfirmCustomerPurchaseOrderSalesQuotation").show();
                $('#customerPurchaseOrderSalesQuotationInputGrid').unblock();
                loadCustomerPurchaseOrderSalesQuotation();
            }           
        });
                
        $("#btnUnConfirmCustomerPurchaseOrder").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){ 
                    $("#btnUnConfirmCustomerPurchaseOrder").css("display", "none");
                    $("#btnCPOSOSearchSalQuo").css("display", "none");
                    $("#btnConfirmCustomerPurchaseOrder").css("display", "block");
                    $('#headerCustomerPurchaseOrderInput').unblock();
                    $('#customerPurchaseOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    $("#btnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "none");
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
                                $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmCustomerPurchaseOrder").css("display", "none");
                                $("#btnCPOSOSearchSalQuo").css("display", "none");
                                $("#btnConfirmCustomerPurchaseOrder").css("display", "block");
                                $('#headerCustomerPurchaseOrderInput').unblock();
                                $('#customerPurchaseOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#btnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "none");
                                clearCustomerPurchaseOrderTransactionAmount();
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
        
        $("#btnConfirmCustomerPurchaseOrderSalesQuotation").click(function(ev) {
            if(flagIsConfirmedCPO){
                
                if(customerPurchaseOrderSalesQuotation_lastSel !== -1) {
                    $('#customerPurchaseOrderSalesQuotationInput_grid').jqGrid("saveRow",customerPurchaseOrderSalesQuotation_lastSel); 
                }

                var ids = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[i]); 

                    if(data.customerPurchaseOrderSalesQuotationCode===""){
                        alertMessage("Sales Quotation Can't Empty!");
                        return;
                    }
                }
            
                $("#btnUnConfirmCustomerPurchaseOrder").css("display", "none");
                $("#btnCPOSOSearchSalQuo").css("display", "none");
                $("#btnUnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderSalesQuotationDetailSort").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "none");   
                $('#customerPurchaseOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery').unblock();
                flagIsConfirmedCPOSalesQuotation=true;
                
                if($('#enumCustomerPurchaseOrderActivity').val() === 'UPDATE' || $('#enumCustomerPurchaseOrderActivity').val() === 'REVISE'|| $('#enumCustomerPurchaseOrderActivity').val() === 'CLONE'){
                    loadCustomerPurchaseOrderItemDetailUpdate();
                }else{
                    loadCustomerPurchaseOrderItemDetail();
                }
                
                loadCustomerPurchaseOrderAdditionalFee();
                loadCustomerPurchaseOrderPaymentTerm();
            }
        });
        
        $("#btnUnConfirmCustomerPurchaseOrderSalesQuotation").click(function(ev) {
            $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('destroyGroupHeader');
            $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmCustomerPurchaseOrder").css("display", "block");
            $("#btnUnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "block");
            $("#btnConfirmCustomerPurchaseOrderSalesQuotationDetailSort").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "none");
            $('#customerPurchaseOrderSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedCPOSalesQuotation=false;
            clearCustomerPurchaseOrderTransactionAmount();
        });
        
        $("#btnConfirmCustomerPurchaseOrderItemDetailDelivery").click(function(ev) {
            if(flagIsConfirmedCPO){
                
                if(customerPurchaseOrderItemDetail_lastSel !== -1) {
                    $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDetail_lastSel); 
                }
                if(customerPurchaseOrderAdditionalFee_lastSel !== -1) {
                    $('#customerPurchaseOrderAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderAdditionalFee_lastSel); 
                }
                if(customerPurchaseOrderPaymentTerm_lastSel !== -1) {
                    $('#customerPurchaseOrderPaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderPaymentTerm_lastSel); 
                }
                
                var ids = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                let idw = jQuery("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs');
                let idl = jQuery("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
                let idq = jQuery("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                
                for(var j=0; j<idw.length;j++){
                    var data = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',idw[j]);
                    
                    if(data.customerPurchaseOrderItemDetailItemFinishGoodsCode === ""){
                        alertMessage("Item Finish Goods Code Must Be Filled!");
                        return;
                    }
                    
                    if(data.customerPurchaseOrderItemDetailSortNo===""){
                        alertMessage("Sort No Can't Empty!");
                        return;
                    }
                
                    if(data.customerPurchaseOrderItemDetailSortNo=== '0' ){
                        alertMessage("Sort No Can't Zero!");
                        return;
                    }
                
                    for(var i=j; i<=idw.length-1; i++){
                        var details = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',idw[i+1]);
                        if(data.customerPurchaseOrderItemDetailSortNo === details.customerPurchaseOrderItemDetailSortNo){
                            alertMessage("Sort No Can't Be The Same!");
                            return;
                        }
                    }

                    if(parseFloat(data.customerPurchaseOrderItemDetailQuantity)===0.00){
                        alertMessage("Quantity Item Can't be 0!");
                        return;
                    }
                }
                
                for(var l=0; l<idl.length;l++){
                    var data = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getRowData',idl[l]);
                    
                    if(data.customerPurchaseOrderAdditionalFeeAdditionalFeeCode === ""){
                        alertMessage("Additional Fee Must Be Filled!");
                        return;
                    }
                    if(parseFloat(data.customerPurchaseOrderAdditionalFeeQuantity === 0.00)){
                        alertMessage("Quantity Must Be Greater Than 0!");
                        return;
                    }
                    if(parseFloat(data.customerPurchaseOrderAdditionalFeePrice === 0.00)){
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
                    var data = $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('getRowData',idq[p]); 

                    if(data.customerPurchaseOrderPaymentTermSortNO=== '0' ){
                        alertMessage("Payment Term Sort No Can't Zero!");
                        return;
                    }

                    if(data.customerPurchaseOrderPaymentTermSortNO === " "){
                        alertMessage("Payment Term Sort No Can't Empty!");
                        return;
                    }

                    if(data.customerPurchaseOrderPaymentTermPaymentTermName===""){
                        alertMessage("Payment Term Can't Empty!");
                        return;
                    }

                    if(parseFloat(data.customerPurchaseOrderPaymentTermPercent)===0.00){
                        alertMessage("Percent Payment term Can't be 0!");
                        return;
                    }
                    totalPercentagePaymentTerm+=parseFloat(data.customerPurchaseOrderPaymentTermPercent);
                }
                if(parseFloat(totalPercentagePaymentTerm.toFixed(2))!==100){
                    alertMessage("Total Percent Payment Term must be 100%, Can't less or greater than 100%!",400);
                    return;
                }
                
                $("#btnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "none");   
                $("#btnUnConfirmCustomerPurchaseOrderSalesQuotation").css("display", "none");   
                $("#btnConfirmCustomerPurchaseOrderSalesQuotationDetailSort").css("display", "none");    
                $("#btnUnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "block");   
                $('#customerPurchaseOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-item-delivery-detail').unblock();
                loadCustomerPurchaseOrderItemDeliveryDate();
                flagIsConfirmedCPOItemDelivery=true;
                
            }
        });
        
        $("#btnUnConfirmCustomerPurchaseOrderItemDetailDelivery").click(function(ev) {
            $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderItemDetailDelivery").css("display", "block");
            $("#btnUnConfirmCustomerPurchaseOrderSalesQuotation").show();
            $("#btnConfirmCustomerPurchaseOrderSalesQuotationDetailSort").show();
            $('#customerPurchaseOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#id-tbl-additional-payment-item-delivery').unblock();
            $('#id-tbl-additional-item-delivery-detail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedCPOItemDelivery=false;
        });
        
        $.subscribe("customerPurchaseOrderSalesQuotationInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderSalesQuotation_lastSel) {

                $('#customerPurchaseOrderSalesQuotationInput_grid').jqGrid("saveRow",customerPurchaseOrderSalesQuotation_lastSel); 
                $('#customerPurchaseOrderSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderSalesQuotation_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderItemDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderItemDetail_lastSel) {

                $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDetail_lastSel); 
                $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderItemDetail_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderAdditionalFee_lastSel) {

                $('#customerPurchaseOrderAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderAdditionalFee_lastSel); 
                $('#customerPurchaseOrderAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderAdditionalFee_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderPaymentTermInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderPaymentTerm_lastSel) {

                $('#customerPurchaseOrderPaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderPaymentTerm_lastSel); 
                $('#customerPurchaseOrderPaymentTermInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderPaymentTerm_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderPaymentTermInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==customerPurchaseOrderItemDelivery_lastSel) {

                $('#customerPurchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDelivery_lastSel); 
                $('#customerPurchaseOrderItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderItemDelivery_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });


//        $('#btnCustomerPurchaseOrderSalesQuotationAdd').click(function(ev) {
//            
//            if(!flagIsConfirmedCPO){
//                return;
//            }
//            
//            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderSalesQuotationAddRow").val()));
//
//            for(var i=0; i<AddRowCount; i++){
//                var defRow = {};
//                customerPurchaseOrderSalesQuotationLastRowId++;
//                $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid("addRowData", customerPurchaseOrderSalesQuotationLastRowId, defRow);
//
//                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
//                $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('setRowData',customerPurchaseOrderSalesQuotationLastRowId,{Buttons:be});
//                ev.preventDefault();
//            } 
//        });
        
        $('#btnCustomerPurchaseOrderAdditionalFeeAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderAdditionalFeeAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerPurchaseOrderAdditionalFeeDelete                : "delete",
                    customerPurchaseOrderAdditionalFeeSearchUnitOfMeasure   : "..."
                };
                customerPurchaseOrderAdditionalFeeLastRowId++;
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("addRowData", customerPurchaseOrderAdditionalFeeLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('setRowData',customerPurchaseOrderAdditionalFeeLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderPaymentTermAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderPaymentTermAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var idp = jQuery("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                var number = idp.length+1;
                var defRow = {
                    customerPurchaseOrderPaymentTermDelete                : "delete",
                    customerPurchaseOrderPaymentTermSearchPaymentTerm     : "...",
                    customerPurchaseOrderPaymentTermSortNO                : number
                    
                };
                customerPurchaseOrderPaymentTermLastRowId++;
                $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid("addRowData", customerPurchaseOrderPaymentTermLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('setRowData',customerPurchaseOrderPaymentTermLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderItemDelieryAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderItemDelieryAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerPurchaseOrderItemDeliveryDelete                   : "delete",
                    customerPurchaseOrderItemDeliverySearchQuotation          : "..."
                };
                customerPurchaseOrderItemDeliveryLastRowId++;
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderCopyFromDetail').click(function(ev) {
            
            $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(customerPurchaseOrderItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDetail_lastSel); 
            }
            
            var ids = jQuery("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    customerPurchaseOrderItemDeliveryDelete                 : "delete",
                    customerPurchaseOrderItemDeliveryItemCode               : data.customerPurchaseOrderItemDetailItem,
                    customerPurchaseOrderItemDeliverySortNo                 : data.customerPurchaseOrderItemDetailSortNo,
                    customerPurchaseOrderItemDeliveryQuantity               : data.customerPurchaseOrderItemDetailQuantity,
                    customerPurchaseOrderItemDeliverySearchQuotation        : "...",
                    customerPurchaseOrderItemDeliverySalesQuotationCode     : data.customerPurchaseOrderItemDetailQuotationNo,
                    customerPurchaseOrderItemDeliverySalesQuotationRefNo    : data.customerPurchaseOrderItemDetailQuotationRefNo,
                    customerPurchaseOrderItemDeliveryItemFinishGoodsCode    : data.customerPurchaseOrderItemDetailItemFinishGoodsCode,   
                    customerPurchaseOrderItemDeliveryItemFinishGoodsRemark  : data.customerPurchaseOrderItemDetailItemFinishGoodsRemark
                };
                customerPurchaseOrderItemDeliveryLastRowId++;
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderSave').click(function(ev) {
            
            if(!flagIsConfirmedCPOSalesQuotation){
                return;
            }
            
            if(customerPurchaseOrderItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDetail_lastSel); 
            }
            
            if(customerPurchaseOrderAdditionalFee_lastSel !== -1) {
                $('#customerPurchaseOrderAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderAdditionalFee_lastSel); 
            }
            
            if(customerPurchaseOrderPaymentTerm_lastSel !== -1) {
                $('#customerPurchaseOrderPaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderPaymentTerm_lastSel); 
            }
            
            if(customerPurchaseOrderItemDelivery_lastSel !== -1) {
                $('#customerPurchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDelivery_lastSel); 
            }
            
            var listCustomerPurchaseOrderSalesQuotation = new Array(); 
            var listCustomerPurchaseOrderItemDetail = new Array(); 
            var listCustomerPurchaseOrderAdditionalFee = new Array(); 
            var listCustomerPurchaseOrderPaymentTerm = new Array(); 
            var listCustomerPurchaseOrderItemDeliveryDate = new Array(); 
            
            var idq = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
            var idi = jQuery("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            var idf = jQuery("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getDataIDs'); 
            var idp = jQuery("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('getDataIDs'); 
            var idd = jQuery("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs'); 

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
                var data = $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getRowData',idq[q]); 
                  
                var customerPurchaseOrderSalesQuotation = { 
                    salesQuotation              : {code:data.customerPurchaseOrderSalesQuotationCode}
                };
                listCustomerPurchaseOrderSalesQuotation[q] = customerPurchaseOrderSalesQuotation;
            }
            
            //Item Detail
            for(var i=0;i < idi.length;i++){ 
                var data = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
//                var sortNo = [];
//                sortNo[i] = data.customerPurchaseOrderItemDetailSortNo;
                
                if(data.customerPurchaseOrderItemDetailSortNo===""){
                    alertMessage("Sort No Can't Empty!");
                    return;
                }
                
                if(data.customerPurchaseOrderItemDetailSortNo=== '0' ){
                    alertMessage("Sort No Can't Zero!");
                    return;
                }
                
            for(var j=i; j<=idi.length-1; j++){
                var details = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',idi[j+1]);
                if(data.customerPurchaseOrderItemDetailSortNo === details.customerPurchaseOrderItemDetailSortNo){
                    alertMessage("Sort No Can't Be The Same!");
                    return;
                }
            }
                
                if(parseFloat(data.customerPurchaseOrderItemDetailQuantity)===0.00){
                    alertMessage("Quantity Item Can't be 0!");
                    return;
                }

                var customerPurchaseOrderItemDetail = { 
                    salesQuotation              : {code:data.customerPurchaseOrderItemDetailQuotationNo},
                    salesQuotationDetail        : {code:data.customerPurchaseOrderItemDetailQuotationNoDetailCode},
                    itemFinishGoods             : {code:data.customerPurchaseOrderItemDetailItemFinishGoodsCode},
                    quantity                    : data.customerPurchaseOrderItemDetailQuantity,
                    customerPurchaseOrderSortNo : data.customerPurchaseOrderItemDetailSortNo,
                    itemAlias                   : data.customerPurchaseOrderItemDetailItemAlias,
                    valveTag                    : data.customerPurchaseOrderItemDetailValveTag,
                    dataSheet                   : data.customerPurchaseOrderItemDetailDataSheet,
                    description                 : data.customerPurchaseOrderItemDetailDescription
                };
                listCustomerPurchaseOrderItemDetail[i] = customerPurchaseOrderItemDetail;
            }
            
            //Additional Fee
            for(var f=0;f < idf.length;f++){ 
                var data = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getRowData',idf[f]); 

                if(data.customerPurchaseOrderAdditionalFeeRemark===""){
                    alertMessage("Remark Additional Fee Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderAdditionalFeeQuantity)===0.00){
                    alertMessage("Quantity Additional Fee Can't be 0!");
                    return;
                }
                                
                if(data.customerPurchaseOrderAdditionalFeeUnitOfMeasureCode===""){
                    alertMessage("Unit Additional Fee Can't Empty!");
                    return;
                }
                
                if(parseFloat(data.customerPurchaseOrderAdditionalFeePrice)===0.00){
                    alertMessage("Price Additional Fee Can't be 0!");
                    return;
                }
                
                var customerPurchaseOrderAdditionalFee = { 
                    remark          : data.customerPurchaseOrderAdditionalFeeRemark,
                    unitOfMeasure   : {code:data.customerPurchaseOrderAdditionalFeeUnitOfMeasureCode},
                    additionalFee   : {code:data.customerPurchaseOrderAdditionalFeeAdditionalFeeCode},
                    price           : data.customerPurchaseOrderAdditionalFeePrice,
                    quantity        : data.customerPurchaseOrderAdditionalFeeQuantity,
                    total           : data.customerPurchaseOrderAdditionalFeeTotal
                };
                listCustomerPurchaseOrderAdditionalFee[f] = customerPurchaseOrderAdditionalFee;
            }
            
            //Payment term
            var totalPercentagePaymentTerm=0;
            for(var p=0;p < idp.length;p++){ 
                var data = $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('getRowData',idp[p]); 
                
                if(data.customerPurchaseOrderPaymentTermSortNO=== '0' ){
                    alertMessage("Sort No Payment Term Can't Zero!");
                    return;
                }
                
                if(data.customerPurchaseOrderPaymentTermSortNO === " "){
                    alertMessage("Sort No Payment Term Can't Empty!");
                    return;
                }
                
                if(data.customerPurchaseOrderPaymentTermPaymentTermName===""){
                    alertMessage("Payment Term Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderPaymentTermPercent)===0.00){
                    alertMessage("Percent Payment term Can't be 0!");
                    return;
                }
                
                var customerPurchaseOrderPaymentTerm = { 
                    sortNo          : data.customerPurchaseOrderPaymentTermSortNO,
                    paymentTerm     : {code:data.customerPurchaseOrderPaymentTermPaymentTermCode},
                    percentage      : data.customerPurchaseOrderPaymentTermPercent,
                    remark          : data.customerPurchaseOrderPaymentTermRemark
                };
                listCustomerPurchaseOrderPaymentTerm[p] = customerPurchaseOrderPaymentTerm;
                totalPercentagePaymentTerm+=parseFloat(data.customerPurchaseOrderPaymentTermPercent);
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
                var data = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[d]); 
                var deliveryDate = formatDate(data.customerPurchaseOrderItemDeliveryDeliveryDate,false);
                var deliveryDate = data.customerPurchaseOrderItemDeliveryDeliveryDate.split('/');
                var deliveryDateNew = deliveryDate[1]+"/"+deliveryDate[0]+"/"+deliveryDate[2];
//                if(data.customerPurchaseOrderItemDeliveryItemCode===""){
//                    alertMessage("Item Delivery Can't Empty!");
//                    return;
//                }
                
                if(data.customerPurchaseOrderItemDeliveryDeliveryDate===""){
                    alertMessage("Delivery Date Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderItemDeliveryQuantity)===0.00){
                    alertMessage("Quantity Delivery Can't be 0!");
                    return;
                }
                
                if(data.customerPurchaseOrderItemDeliverySalesQuotationCode===""){
                    alertMessage("Quotation Date Can't Empty!");
                    return;
                }
                
                var customerPurchaseOrderItemDeliveryDate = { 
                    itemFinishGoods     : {code:data.customerPurchaseOrderItemDeliveryItemFinishGoodsCode},
                    salesQuotation      : {code:data.customerPurchaseOrderItemDeliverySalesQuotationCode},
                    quantity            : data.customerPurchaseOrderItemDeliveryQuantity,
                    deliveryDate        : deliveryDateNew
                };
                listCustomerPurchaseOrderItemDeliveryDate[d] = customerPurchaseOrderItemDeliveryDate;
            }
            var sumQuantityGroupItem=0;
            
            for(var i=0;i < idi.length;i++){
                var data = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
                sumQuantityGroupItem=0;
                for(var j=0;j < idd.length;j++){
                    var dataDelivery = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[j]);
                    
                    if(data.customerPurchaseOrderItemDetailQuotationNo === dataDelivery.customerPurchaseOrderItemDeliverySalesQuotationCode){
                        if(data.customerPurchaseOrderItemDetailSortNo === dataDelivery.customerPurchaseOrderItemDeliverySortNo){
                            sumQuantityGroupItem += parseFloat(dataDelivery.customerPurchaseOrderItemDeliveryQuantity);
//                            alert(data.customerPurchaseOrderItemDetailQuantity);
                        }
                        
                    }
                }

                if(parseFloat(data.customerPurchaseOrderItemDetailQuantity)!==sumQuantityGroupItem){
                    alertMessage("Sum Of Quantity Item </br> "+data.customerPurchaseOrderItemDetailQuotationNo+" Must be Equal with Quantity Item Detail!");
                    return;
                }
                
            }
            
            formatDateCPOSO();
            unFormatNumericCPOSO();
            
            var url = "sales/customer-purchase-order-save";
            var params = $("#frmCustomerPurchaseOrderInput").serialize();
                params += "&listCustomerPurchaseOrderSalesQuotationJSON=" + $.toJSON(listCustomerPurchaseOrderSalesQuotation);
                params += "&listCustomerPurchaseOrderItemDetailJSON=" + $.toJSON(listCustomerPurchaseOrderItemDetail);
                params += "&listCustomerPurchaseOrderAdditionalFeeJSON=" + $.toJSON(listCustomerPurchaseOrderAdditionalFee);
                params += "&listCustomerPurchaseOrderPaymentTermJSON=" + $.toJSON(listCustomerPurchaseOrderPaymentTerm);
                params += "&listCustomerPurchaseOrderItemDeliveryJSON=" + $.toJSON(listCustomerPurchaseOrderItemDeliveryDate);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateCPOSO();
                    formatNumericCPOSO();
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
                                        var params = "enumCustomerPurchaseOrderActivity=NEW";
                                        var url = "sales/customer-purchase-order-to-sales-order-input";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/customer-purchase-order-to-sales-order";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnCustomerPurchaseOrderCancel').click(function(ev) {
            var url = "sales/customer-purchase-order-to-sales-order";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER"); 
        });
        
        $('#customerPurchaseOrder_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=customerPurchaseOrder&idsubdoc=branch","Search", "width=600, height=500");
        });

        $('#customerPurchaseOrder_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerPurchaseOrder&idsubdoc=customer","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrder_btnCustomerEndUser').click(function(ev) {
            window.open("./pages/search/search-customer-end-user.jsp?iddoc=customerPurchaseOrder&idsubdoc=endUser","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrder_btnSalesPerson').click(function(ev) {
            window.open("./pages/search/search-sales-person.jsp?iddoc=customerPurchaseOrder&idsubdoc=salesPerson","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerPurchaseOrder_btnProject').click(function(ev) {
            window.open("./pages/search/search-project.jsp?iddoc=customerPurchaseOrder&idsubdoc=project","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerPurchaseOrder_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=customerPurchaseOrder&idsubdoc=currency","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrder_btnDiscountAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerPurchaseOrder&idsubdoc=discountAccount","Search", "width=600, height=500");
        });
        
        $('#btnCustomerPurchaseOrderDeliveryDateSet').click(function(ev) {
            if(customerPurchaseOrderItemDelivery_lastSel !== -1) {
                $('#customerPurchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDelivery_lastSel); 
            }
            
            var deliveryDate=$("#customerPurchaseOrderDeliveryDateSet").val();
            var ids = jQuery("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "customerPurchaseOrderItemDeliveryDeliveryDate",deliveryDate);
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "customerPurchaseOrderItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
        
        $('#btnConfirmCustomerPurchaseOrderSalesQuotationDetailSort').click(function(ev) {
             if($("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                alertMessage("Grid Sales Quotation Can't Be Empty!");
                return;
            }
            
            if(customerPurchaseOrderItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDetail_lastSel);  
            }
            
            var ids = jQuery("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs');
            var listSalesQuotationDetail = new Array();
            
            for(var k=0;k<ids.length;k++){
            var data = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',ids[k]);    
            var customerPurchaseOrderItemDetail = { 
                    salesQuotation              : {code:data.customerPurchaseOrderItemDetailQuotationNo},
                    refNo                       : data.customerPurchaseOrderItemDetailQuotationRefNo,
                    salesQuotationDetail        : data.customerPurchaseOrderItemDetailQuotationNoDetailCode,
                    sort                        : data.customerPurchaseOrderItemDetailSortNo,
                    itemFinishGoodsCode         : data.customerPurchaseOrderItemDetailItemFinishGoodsCode,
                    itemFinishGoodsName         : data.customerPurchaseOrderItemDetailItemFinishGoodsName,
                    itemFinishGoodsRemark       : data.customerPurchaseOrderItemDetailItemFinishGoodsRemark,
                    valveTypeCode               : data.customerPurchaseOrderItemDetailValveTypeCode,
                    valveTypeName               : data.customerPurchaseOrderItemDetailValveTypeName,
                    valveTag                    : data.customerPurchaseOrderItemDetailValveTag,
                    dataSheet                   : data.customerPurchaseOrderItemDetailDataSheet,
                    dataDescription             : data.customerPurchaseOrderItemDetailDescription,
                    itemAlias                   : data.customerPurchaseOrderItemDetailItemAlias,
                    
                    //01
                    bodyConstQuo                : data.customerPurchaseOrderItemDetailBodyConstQuotation,
                    bodyConstFinishGoodCode     : data.customerPurchaseOrderItemDetailItemFinishGoodsBodyConstCode,
                    bodyConstFinishGoodName     : data.customerPurchaseOrderItemDetailItemFinishGoodsBodyConstName,
                    //02
                    typeDesignQuo               : data.customerPurchaseOrderItemDetailTypeDesignQuotation,
                    typeDesignFinishGoodCode    : data.customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignCode,
                    typeDesignFinishGoodName    : data.customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignName,
                    //03
                    seatDesignQuo               : data.customerPurchaseOrderItemDetailSeatDesignQuotation,
                    seatDesignFinishGoodCode    : data.customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignCode,
                    seatDesignFinishGoodName    : data.customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignName,
                    //04
                    sizeQuo                     : data.customerPurchaseOrderItemDetailSizeQuotation,
                    sizeFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsSizeCode,
                    sizeFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsSizeName,
                    //05
                    ratingQuo                   : data.customerPurchaseOrderItemDetailRatingQuotation,
                    ratingFinishGoodCode        : data.customerPurchaseOrderItemDetailItemFinishGoodsRatingCode,
                    ratingFinishGoodName        : data.customerPurchaseOrderItemDetailItemFinishGoodsRatingName,
                    //06
                    boreQuo                     : data.customerPurchaseOrderItemDetailBoreQuotation,
                    boreFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsBoreCode,
                    boreFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsBoreName,
                    
                    //07
                    endConQuo                   : data.customerPurchaseOrderItemDetailEndConQuotation,
                    endConFinishGoodCode        : data.customerPurchaseOrderItemDetailItemFinishGoodsEndConCode,
                    endConFinishGoodName        : data.customerPurchaseOrderItemDetailItemFinishGoodsEndConName,
                    
                    //08
                    bodyQuo                     : data.customerPurchaseOrderItemDetailBodyQuotation,
                    bodyFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsBodyCode,
                    bodyFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsBodyName,
                    
                    //09
                    ballQuo                     : data.customerPurchaseOrderItemDetailBallQuotation,
                    ballFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsBallCode,
                    ballFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsBallName,
                    
                    //10
                    seatQuo                     : data.customerPurchaseOrderItemDetailSeatQuotation,
                    seatFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsSeatCode,
                    seatFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsSeatName,
                    
                    //11
                    seatInsertQuo                     : data.customerPurchaseOrderItemDetailSeatInsertQuotation,
                    seatInsertFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertCode,
                    seatInsertFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertName,
                    
                    //12
                    stemQuo                     : data.customerPurchaseOrderItemDetailStemQuotation,
                    stemFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsStemCode,
                    stemFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsStemName,
                    
                    //13
                    sealQuo                     : data.customerPurchaseOrderItemDetailSealQuotation,
                    sealFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsSealCode,
                    sealFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsSealName,
                    
                    //14
                    boltQuo                     : data.customerPurchaseOrderItemDetailBoltQuotation,
                    boltFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsBoltCode,
                    boltFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsBoltName,
                    
                    //15
                    discQuo                     : data.customerPurchaseOrderItemDetailDiscQuotation,
                    discFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsDiscCode,
                    discFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsDiscName,
                    
                    //16
                    platesQuo                     : data.customerPurchaseOrderItemDetailPlatesQuotation,
                    platesFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsPlatesCode,
                    platesFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsPlatesName,
                    
                    //17
                    shaftQuo                     : data.customerPurchaseOrderItemDetailShaftQuotation,
                    shaftFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsShaftCode,
                    shaftFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsShaftName,
                    
                    //18
                    springQuo                     : data.customerPurchaseOrderItemDetailSpringQuotation,
                    springFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsSpringCode,
                    springFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsSpringName,
                    
                    //19
                    armPinQuo                     : data.customerPurchaseOrderItemDetailArmPinQuotation,
                    armPinFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsArmPinCode,
                    armPinFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsArmPinName,
                    
                    //20
                    backSeatQuo                     : data.customerPurchaseOrderItemDetailBackSeatQuotation,
                    backSeatFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsBackSeatCode,
                    backSeatFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsBackSeatName,
                    
                    //21
                    armQuo                     : data.customerPurchaseOrderItemDetailArmQuotation,
                    armFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsArmCode,
                    armFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsArmName,
                    
                    //22
                    hingePinQuo                     : data.customerPurchaseOrderItemDetailHingePinQuotation,
                    hingePinFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsHingePinCode,
                    hingePinFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsHingePinName,
                    
                    //23
                    stopPinQuo                     : data.customerPurchaseOrderItemDetailStopPinQuotation,
                    stopPinFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsStopPinCode,
                    stopPinFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsStopPinName,
                    
                    //24
                    operatorQuo                     : data.customerPurchaseOrderItemDetailOperatorQuotation,
                    operatorFinishGoodCode          : data.customerPurchaseOrderItemDetailItemFinishGoodsOperatorCode,
                    operatorFinishGoodName          : data.customerPurchaseOrderItemDetailItemFinishGoodsOperatorName,
                    
                    note                        : data.customerPurchaseOrderItemDetailNote,
                    price                       : data.customerPurchaseOrderItemDetailPrice,
                    total                       : data.customerPurchaseOrderItemDetailTotal,
                    quantity                    : data.customerPurchaseOrderItemDetailQuantity
                    
                };
                listSalesQuotationDetail[k] = customerPurchaseOrderItemDetail;
            }
            
             var result = Enumerable.From(listSalesQuotationDetail)
                            .OrderBy('$.sort')
                            .Select()
                            .ToArray();
            
            $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('clearGridData');
            customerPurchaseOrderItemDetail_lastSel = 0;
                for(var i = 0; i < result.length; i++){
                    customerPurchaseOrderItemDetail_lastSel ++;
                    $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("addRowData",customerPurchaseOrderItemDetail_lastSel, result[i]);
                    $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderItemDetail_lastSel,{
                        
                    customerPurchaseOrderItemDetailQuotationNo                      : result[i].salesQuotation.code,
                    customerPurchaseOrderItemDetailQuotationRefNo                   : result[i].refNo,
                    customerPurchaseOrderItemDetailQuotationNoDetailCode            : result[i].salesQuotationDetail,
                    customerPurchaseOrderItemDetailSortNo                           : result[i].sort,
                    customerPurchaseOrderItemDetailItemFinishGoodsCode              : result[i].itemFinishGoodsCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsName              : result[i].itemFinishGoodsName,
                    customerPurchaseOrderItemDetailItemFinishGoodsRemark            : result[i].itemFinishGoodsRemark,
                    customerPurchaseOrderItemDetailValveTypeCode                    : result[i].valveTypeCode,
                    customerPurchaseOrderItemDetailValveTypeName                    : result[i].valveTypeName,
                    customerPurchaseOrderItemDetailValveTag                         : result[i].valveTag,
                    customerPurchaseOrderItemDetailDataSheet                        : result[i].dataSheet,
                    customerPurchaseOrderItemDetailDescription                      : result[i].dataDescription,
                    customerPurchaseOrderItemDetailItemAlias                        : result[i].itemAlias,
                    //01
                    customerPurchaseOrderItemDetailBodyConstQuotation               : result[i].bodyConstQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyConstCode     : result[i].bodyConstFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyConstName     : result[i].bodyConstFinishGoodName,
                    //02
                    customerPurchaseOrderItemDetailTypeDesignQuotation               : result[i].typeDesignQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignCode     : result[i].typeDesignFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignName     : result[i].typeDesignFinishGoodName,
                    //03
                    customerPurchaseOrderItemDetailSeatDesignQuotation               : result[i].seatDesignQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignCode     : result[i].seatDesignFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignName     : result[i].seatDesignFinishGoodName,
                    //04
                    customerPurchaseOrderItemDetailSizeQuotation               : result[i].sizeQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsSizeCode     : result[i].sizeFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSizeName     : result[i].sizeFinishGoodName,
                    //05
                    customerPurchaseOrderItemDetailRatingQuotation               : result[i].ratingQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsRatingCode     : result[i].ratingFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsRatingName     : result[i].ratingFinishGoodName,
                    //06
                    customerPurchaseOrderItemDetailBoreQuotation               : result[i].boreQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoreCode     : result[i].boreFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoreName     : result[i].boreFinishGoodName,
                    //07
                    customerPurchaseOrderItemDetailEndConQuotation               : result[i].endConQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsEndConCode     : result[i].endConFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsEndConName     : result[i].endConFinishGoodName,
                    //08
                    customerPurchaseOrderItemDetailBodyQuotation               : result[i].bodyQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyCode     : result[i].bodyFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyName     : result[i].bodyFinishGoodName,
                    //09
                    customerPurchaseOrderItemDetailBallQuotation               : result[i].ballQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsBallCode     : result[i].ballFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBallName     : result[i].ballFinishGoodName,
                    //10
                    customerPurchaseOrderItemDetailSeatQuotation               : result[i].seatQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatCode     : result[i].seatFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatName     : result[i].seatFinishGoodName,
                    //11
                    customerPurchaseOrderItemDetailSeatInsertQuotation               : result[i].seatInsertQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertCode     : result[i].seatInsertFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertName     : result[i].seatInsertFinishGoodName,
                    //12
                    customerPurchaseOrderItemDetailStemQuotation               : result[i].stemQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsStemCode     : result[i].stemFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsStemName     : result[i].stemFinishGoodName,
                    //13
                    customerPurchaseOrderItemDetailSealQuotation               : result[i].sealQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsSealCode     : result[i].sealFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSealName     : result[i].sealFinishGoodName,
                    //14
                    customerPurchaseOrderItemDetailBoltQuotation               : result[i].boltQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoltCode     : result[i].boltFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoltName     : result[i].boltFinishGoodName,
                    //15
                    customerPurchaseOrderItemDetailDiscQuotation               : result[i].discQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsDiscCode     : result[i].discFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsDiscName     : result[i].discFinishGoodName,
                    //16
                    customerPurchaseOrderItemDetailPlatesQuotation               : result[i].platesQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsPlatesCode     : result[i].platesFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsPlatesName     : result[i].platesFinishGoodName,
                    //17
                    customerPurchaseOrderItemDetailShaftQuotation               : result[i].shaftQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsShaftCode     : result[i].shaftFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsShaftName     : result[i].shaftFinishGoodName,
                    //18
                    customerPurchaseOrderItemDetailSpringQuotation               : result[i].springQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsSpringCode     : result[i].springFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSpringName     : result[i].springFinishGoodName,
                    //19
                    customerPurchaseOrderItemDetailArmPinQuotation               : result[i].armPinQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsArmPinCode     : result[i].armPinFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsArmPinName     : result[i].armPinFinishGoodName,
                    //20
                    customerPurchaseOrderItemDetailBackSeatQuotation               : result[i].backSeatQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsBackSeatCode     : result[i].backSeatFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBackSeatName     : result[i].backSeatFinishGoodName,
                    //21
                    customerPurchaseOrderItemDetailArmQuotation               : result[i].armQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsArmCode     : result[i].armFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsArmName     : result[i].armFinishGoodName,
                    //22
                    customerPurchaseOrderItemDetailHingePinQuotation               : result[i].hingePinQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsHingePinCode     : result[i].hingePinFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsHingePinName     : result[i].hingePinFinishGoodName,
                    //23
                    customerPurchaseOrderItemDetailStopPinQuotation               : result[i].stopPinQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsStopPinCode     : result[i].stopPinFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsStopPinName     : result[i].stopPinFinishGoodName,
                    //24
                    customerPurchaseOrderItemDetailOperatorQuotation               : result[i].operatorQuo,
                    customerPurchaseOrderItemDetailItemFinishGoodsOperatorCode     : result[i].operatorFinishGoodCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsOperatorName     : result[i].operatorFinishGoodName,
                    
                    customerPurchaseOrderItemDetailNote                        : result[i].note,
                    customerPurchaseOrderItemDetailPrice                       : result[i].price,
                    customerPurchaseOrderItemDetailTotal                       : result[i].total,
                    customerPurchaseOrderItemDetailQuantity                    : result[i].quantity
               });    
            }
        }); 
        
        $('#btnCPOSOSearchSalQuo').click(function(ev) {
            var ids = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
            var customer=txtCustomerPurchaseOrderCustomerCode.val();
            var customerName=txtCustomerPurchaseOrderCustomerName.val();
            var endUser=txtCustomerPurchaseOrderEndUserCode.val();
            var endUserName=txtCustomerPurchaseOrderEndUserName.val();
            var salesPerson=txtCustomerPurchaseOrderSalesPersonCode.val();
            var salesPersonName=txtCustomerPurchaseOrderSalesPersonName.val();
            var project=txtCustomerPurchaseOrderProjectCode.val();
            var projectName=txtCustomerPurchaseOrderProjectName.val();
            var currency=txtCustomerPurchaseOrderCurrencyCode.val();
            var currencyName=txtCustomerPurchaseOrderCurrencyName.val();
            var branch = txtCustomerPurchaseOrderBranchCode.val();
            var branchName = txtCustomerPurchaseOrderBranchName.val();
            var orderStatus = $("#customerPurchaseOrder\\.orderStatus").val();
            window.open("./pages/search/search-sales-quotation-multiple.jsp?iddoc=customerPurchaseOrderSalesQuotation&type=grid&rowLast="+ids.length+
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
            "&firstDate="+$("#customerPurchaseOrderDateFirstSession").val()+"&lastDate="+$("#customerPurchaseOrderDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
        });
        
    }); //EOF Ready
    
    function addRowDataMultiSelectedCPOSO(lastRowId,defRow){
        
        var ids = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
            $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('setRowData',lastRowId,{
                    customerPurchaseOrderSalesQuotationDelete              : defRow.customerPurchaseOrderSalesQuotationDelete,
                    customerPurchaseOrderSalesQuotationCode                : defRow.customerPurchaseOrderSalesQuotationCode,
                    customerPurchaseOrderSalesQuotationTransactionDate     : defRow.customerPurchaseOrderSalesQuotationTransactionDate,
                    customerPurchaseOrderSalesQuotationCustomerCode        : defRow.customerPurchaseOrderSalesQuotationCustomerCode,
                    customerPurchaseOrderSalesQuotationCustomerName        : defRow.customerPurchaseOrderSalesQuotationCustomerName,
                    customerPurchaseOrderSalesQuotationEndUserCode         : defRow.customerPurchaseOrderSalesQuotationEndUserCode,
                    customerPurchaseOrderSalesQuotationEndUserName         : defRow.customerPurchaseOrderSalesQuotationEndUserName,
                    customerPurchaseOrderSalesQuotationRfqCode             : defRow.customerPurchaseOrderSalesQuotationRfqCode,
                    customerPurchaseOrderSalesQuotationProjectCode         : defRow.customerPurchaseOrderSalesQuotationProjectCode,
                    customerPurchaseOrderSalesQuotationSubject             : defRow.customerPurchaseOrderSalesQuotationSubject,
                    customerPurchaseOrderSalesQuotationAttn                : defRow.customerPurchaseOrderSalesQuotationAttn,
                    customerPurchaseOrderSalesQuotationRefNo               : defRow.customerPurchaseOrderSalesQuotationRefNo,
                    customerPurchaseOrderSalesQuotationRemark              : defRow.customerPurchaseOrderSalesQuotationRemark
            });
            
        setHeightGridCPOSOSalQuoDetail();
 }
    
    // function Grid Detail
    function setHeightGridCPOSOSalQuoDetail(){
        var ids = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#customerPurchaseOrderSalesQuotationInput_grid"+" tr").eq(1).height();
            $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateCPOSO(){
        var transactionDateSplit=dtpCustomerPurchaseOrderTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpCustomerPurchaseOrderTransactionDate.val(transactionDate);
        
        var createdDate=$("#customerPurchaseOrder\\.createdDate").val();
        $("#customerPurchaseOrder\\.createdDateTemp").val(createdDate);
    }

    function unFormatNumericCPOSO(){
        var retention =removeCommas(txtCustomerPurchaseOrderRetention.val());
        txtCustomerPurchaseOrderRetention.val(retention);
        
        var totalTransactionAmount =removeCommas(txtCustomerPurchaseOrderTotalTransactionAmount.val());
        txtCustomerPurchaseOrderTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtCustomerPurchaseOrderDiscountAmount.val());
        txtCustomerPurchaseOrderDiscountAmount.val(discountAmount);
        var taxBaseAmount =removeCommas(txtCustomerPurchaseOrderTaxBaseAmount.val());
        txtCustomerPurchaseOrderTaxBaseAmount.val(taxBaseAmount);
        var vatPercent =removeCommas(txtCustomerPurchaseOrderVATPercent.val());
        txtCustomerPurchaseOrderVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtCustomerPurchaseOrderVATAmount.val());
        txtCustomerPurchaseOrderVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtCustomerPurchaseOrderGrandTotalAmount.val());
        txtCustomerPurchaseOrderGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericCPOSO(){
        
        var retention =parseFloat(txtCustomerPurchaseOrderRetention.val());
        txtCustomerPurchaseOrderRetention.val(formatNumber(retention,2));
        
        var totalTransactionAmount =parseFloat(txtCustomerPurchaseOrderTotalTransactionAmount.val());
        txtCustomerPurchaseOrderTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtCustomerPurchaseOrderDiscountPercent.val());
        txtCustomerPurchaseOrderDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtCustomerPurchaseOrderDiscountAmount.val());
        txtCustomerPurchaseOrderDiscountAmount.val(formatNumber(discountAmount,2));
        var taxBaseAmount =parseFloat(txtCustomerPurchaseOrderTaxBaseAmount.val());
        txtCustomerPurchaseOrderTaxBaseAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtCustomerPurchaseOrderVATPercent.val());
        txtCustomerPurchaseOrderVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtCustomerPurchaseOrderVATAmount.val());
        txtCustomerPurchaseOrderVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtCustomerPurchaseOrderGrandTotalAmount.val());
        txtCustomerPurchaseOrderGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }    
    
    function clearCustomerPurchaseOrderTransactionAmount(){
        txtCustomerPurchaseOrderTotalTransactionAmount.val("0.00");        
        txtCustomerPurchaseOrderDiscountPercent.val("0.00");
        txtCustomerPurchaseOrderDiscountAmount.val("0.00");
        txtCustomerPurchaseOrderTotalAdditionalFee.val("0.00");
        txtCustomerPurchaseOrderTaxBaseAmount.val("0.00");
        txtCustomerPurchaseOrderVATPercent.val("0.00");
        txtCustomerPurchaseOrderVATAmount.val("0.00");
        txtCustomerPurchaseOrderGrandTotalAmount.val("0.00");
    }
    
    function calculateItemSalesQuotationDetailCPOSO(){

        var selectedRowID = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerPurchaseOrderItemDetailLastRowId;
        }
        var qty = $("#" + selectedRowID + "_customerPurchaseOrderItemDetailQuantity").val();
        var unitPrice = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData', selectedRowID);
        var amount = unitPrice.customerPurchaseOrderItemDetailPrice;

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("setCell", selectedRowID, "customerPurchaseOrderItemDetailTotal", subAmount);

        calculateCustomerPurchaseOrderHeader();
    }
    
    function calculateCustomerPurchaseOrderAdditionalFee() {
        var selectedRowID = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var qty = $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeePrice").val();
        
        var subTotal = (parseFloat(qty) * parseFloat(price));
        
        $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "customerPurchaseOrderAdditionalFeeTotal", subTotal);

        calculateCustomerPurchaseOrderTotalAdditional();
    }
    
    function calculateCustomerPurchaseOrderTotalAdditional() {
        var totalAmount =0;
        var ids = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.customerPurchaseOrderAdditionalFeeTotal);
        }   
        txtCustomerPurchaseOrderTotalAdditionalFee.val(formatNumber(totalAmount,2));
        calculateCustomerPurchaseOrderHeader();
    }
    
    function calculateCustomerPurchaseOrderTotalAdditionalUpdate() {
        var totalAmount =0;
        var ids = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
  
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.customerPurchaseOrderAdditionalFeeTotal);
        }   
        txtCustomerPurchaseOrderTotalAdditionalFee.val(formatNumber(totalAmount,2));
    }
    
    function calculateCustomerPurchaseOrderHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var additionalFeeAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.customerPurchaseOrderItemDetailTotal);
        }   
        txtCustomerPurchaseOrderTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtCustomerPurchaseOrderTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtCustomerPurchaseOrderDiscountPercent.val()));        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtCustomerPurchaseOrderDiscountAmount.val()===""){
            discAmount=0;
        }
        
        additionalFeeAmount=parseFloat(removeCommas(txtCustomerPurchaseOrderTotalAdditionalFee.val()));  
        
        subTotal = (totalTransaction-discAmount)+additionalFeeAmount;
        
        if(txtCustomerPurchaseOrderVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtCustomerPurchaseOrderVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtCustomerPurchaseOrderDiscountAmount.val(formatNumber(discAmount,2));
        txtCustomerPurchaseOrderTaxBaseAmount.val(formatNumber(subTotal,2));
        txtCustomerPurchaseOrderVATAmount.val(formatNumber(vatAmount,2));        
        txtCustomerPurchaseOrderGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onchangeAdditionalFeeUnitOfMeasureCodeCPOSO(){
        var selectedRowID = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var uomCode = $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + uomCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeUnitOfMeasureCode").val("");
                alert("UOM Not Found","");
            }
        });
            
    }
    
    function onchangeAdditionalFeeCodeCPOSO(){
        var selectedRowID = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var additionalFeeCode = $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeAdditionalFeeCode").val();

        var url = "master/additional-fee-get-sales";
        var params = "additionalFee.code=" + additionalFeeCode;
            params+= "&additionalFee.activeStatus=TRUE";
            params+= "&additionalFee.salesStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.additionalFeeTemp){
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderAdditionalFeeAdditionalFeeCode",data.additionalFeeTemp.code);
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderAdditionalFeeAdditionalFeeName",data.additionalFeeTemp.name);
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderAdditionalFeeSalesChartOfAccountCode",data.additionalFeeTemp.salesChartOfAccountCode);
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderAdditionalFeeSalesChartOfAccountName",data.additionalFeeTemp.salesChartOfAccountName);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeAdditionalFeeCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeAdditionalFeeName").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeSalesChartOfAccountCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderAdditionalFeeSalesChartOfAccountName").val("");
                alert("Additional Fee Not Found","");
            }
        });
            
    }
    
    function onchangePaymentTermPaymentTermCodeCPOSO(){
        var selectedRowID = $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");
        var paymentTermCode = $("#" + selectedRowID + "_customerPurchaseOrderPaymentTermPaymentTermCode").val();

        var url = "master/payment-term-get";
        var params = "paymentTerm.code=" + paymentTermCode;
            params+= "&paymentTerm.activeStatus=TRUE";
        $.post(url, params, function(result){
            var data = (result);
            if (data.paymentTermTemp){
                $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderPaymentTermPaymentTermCode",data.paymentTermTemp.code);
                $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderPaymentTermPaymentTermName",data.paymentTermTemp.name);
            }
            else{
                $("#" + selectedRowID + "customerPurchaseOrderPaymentTermPaymentTermCode").val("");
                $("#" + selectedRowID + "customerPurchaseOrderPaymentTermPaymentTermName").val("");
                alert("Payment Term Not Found","");
            }
        });
            
    }
    
    function customerPurchaseOrderItemDeliveryInputGrid_SearchQuotation_OnClick(){
      var ids = jQuery("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
           
            if($("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;
                }
            }
            
            if(cpoSalesQuotation_lastSel !== -1) {
                $('#customerPurchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel);  
            }
            
           var listSalesQuotationCode = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getRowData',ids[q]); 
                listSalesQuotationCode[q] = [data.customerPurchaseOrderItemDeliverySalesQuotationCode];
//                 (listCode);
            }
        window.open("./pages/search/search-sales-quotation-array.jsp?iddoc=customerPurchaseOrderItemDelivery&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function customerPurchaseOrderSalesQuotationInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function customerPurchaseOrderItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
        
        calculateCustomerPurchaseOrderHeader();
    }
    
    function customerPurchaseOrderAdditionalFeeInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('delRowData',selectDetailRowId);    
        calculateCustomerPurchaseOrderTotalAdditional();
    }
    
    function customerPurchaseOrderPaymentTermInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function customerPurchaseOrderItemDeliveryInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    
    function onchangeCustomerPurchaseOrderItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_customerPurchaseOrderItemDeliveryDeliveryDate").val();
        
        $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "customerPurchaseOrderItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    
    function loadCustomerPurchaseOrderSalesQuotation() {
        var enumCustomerPurchaseOrderActivity=$("#enumCustomerPurchaseOrderActivity").val();
        if(enumCustomerPurchaseOrderActivity==="NEW"){
            return;
        }                
        
        var url = "sales/customer-purchase-order-sales-quotation-data";
        var params = "customerPurchaseOrder.code="+$("#customerPurchaseOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderSalesQuotationLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderSalesQuotation.length; i++) {
                customerPurchaseOrderSalesQuotationLastRowId++;
                
                $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid("addRowData", customerPurchaseOrderSalesQuotationLastRowId, data.listCustomerPurchaseOrderSalesQuotation[i]);
                $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('setRowData',customerPurchaseOrderSalesQuotationLastRowId,{
                    customerPurchaseOrderSalesQuotationDelete           : "delete",
                    customerPurchaseOrderSalesQuotationSearch           : "...",
                    customerPurchaseOrderSalesQuotationCode             : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationCode,
                    customerPurchaseOrderSalesQuotationTransactionDate  : formatDateRemoveT(data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationTransactionDate, true),
                    customerPurchaseOrderSalesQuotationCustomerCode     : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationCustomerCode,
                    customerPurchaseOrderSalesQuotationCustomerName     : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationCustomerName,
                    customerPurchaseOrderSalesQuotationEndUserCode      : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationEndUserCode,
                    customerPurchaseOrderSalesQuotationEndUserName      : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationEndUserName,
                    customerPurchaseOrderSalesQuotationRfqCode          : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationRfqCode,
                    customerPurchaseOrderSalesQuotationProjectCode      : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationProject,
                    customerPurchaseOrderSalesQuotationSubject          : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationSubject,
                    customerPurchaseOrderSalesQuotationAttn             : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationAttn,
                    customerPurchaseOrderSalesQuotationRefNo            : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationRefNo,
                    customerPurchaseOrderSalesQuotationRemark           : data.listCustomerPurchaseOrderSalesQuotation[i].salesQuotationRemark
                });
            }
        });
        closeLoading();
    }
    function loadCustomerPurchaseOrderItemDetailUpdate(){
       loadGridItem();
       
        var totalTransaction=0;
        var url = "sales/customer-purchase-order-item-detail-get-data";
        
        if($('#enumCustomerPurchaseOrderActivity').val() === 'UPDATE'){
            var params = "customerPurchaseOrder.code="+$('#customerPurchaseOrder\\.code').val(); 
        }else if($('#enumCustomerPurchaseOrderActivity').val() === 'REVISE'){
            var params = "customerPurchaseOrder.code="+$('#customerPurchaseOrder\\.refCUSTPOCode').val(); 
        }else if($('#enumCustomerPurchaseOrderActivity').val() === 'CLONE'){
            var params = "customerPurchaseOrder.code="+$('#customerPurchaseOrderCloneModeCode').val(); 
        }
        
        customerPurchaseOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderItemDetail.length; i++) {
                
                customerPurchaseOrderItemDetailLastRowId++;
                
                $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderItemDetailLastRowId, data.listCustomerPurchaseOrderItemDetail[i]);
                $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderItemDetailLastRowId,{
                    customerPurchaseOrderItemDetailDelete                   : "delete",
                    customerPurchaseOrderItemDetailQuotationNoDetailCode    : data.listCustomerPurchaseOrderItemDetail[i].salesQuotationDetailCode,
                    customerPurchaseOrderItemDetailQuotationNo              : data.listCustomerPurchaseOrderItemDetail[i].salesQuotationCode,
                    customerPurchaseOrderItemDetailQuotationRefNo           : data.listCustomerPurchaseOrderItemDetail[i].refNo,
                    customerPurchaseOrderItemDetailItemFinishGoodsCode      : data.listCustomerPurchaseOrderItemDetail[i].itemFinishGoodsCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsRemark    : data.listCustomerPurchaseOrderItemDetail[i].itemFinishGoodsRemark,
                    customerPurchaseOrderItemDetailSortNo                   : data.listCustomerPurchaseOrderItemDetail[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderItemDetailValveTypeCode            : data.listCustomerPurchaseOrderItemDetail[i].valveTypeCode,
                    customerPurchaseOrderItemDetailValveTypeName            : data.listCustomerPurchaseOrderItemDetail[i].valveTypeName,
                    customerPurchaseOrderItemDetailItemAlias                : data.listCustomerPurchaseOrderItemDetail[i].itemAlias,
                    customerPurchaseOrderItemDetailValveTag                 : data.listCustomerPurchaseOrderItemDetail[i].valveTag,
                    customerPurchaseOrderItemDetailDataSheet                : data.listCustomerPurchaseOrderItemDetail[i].dataSheet,
                    customerPurchaseOrderItemDetailDescription              : data.listCustomerPurchaseOrderItemDetail[i].description,
                    
                    
                    // 24 valve Type Component Quotation
                    customerPurchaseOrderItemDetailBodyConstQuotation   : data.listCustomerPurchaseOrderItemDetail[i].bodyConstruction,
                    customerPurchaseOrderItemDetailTypeDesignQuotation  : data.listCustomerPurchaseOrderItemDetail[i].typeDesign,
                    customerPurchaseOrderItemDetailSeatDesignQuotation  : data.listCustomerPurchaseOrderItemDetail[i].seatDesign,
                    customerPurchaseOrderItemDetailSizeQuotation        : data.listCustomerPurchaseOrderItemDetail[i].size,
                    customerPurchaseOrderItemDetailRatingQuotation      : data.listCustomerPurchaseOrderItemDetail[i].rating,
                    customerPurchaseOrderItemDetailBoreQuotation        : data.listCustomerPurchaseOrderItemDetail[i].bore,
                    
                    customerPurchaseOrderItemDetailEndConQuotation      : data.listCustomerPurchaseOrderItemDetail[i].endCon,
                    customerPurchaseOrderItemDetailBodyQuotation        : data.listCustomerPurchaseOrderItemDetail[i].body,
                    customerPurchaseOrderItemDetailBallQuotation        : data.listCustomerPurchaseOrderItemDetail[i].ball,
                    customerPurchaseOrderItemDetailSeatQuotation        : data.listCustomerPurchaseOrderItemDetail[i].seat,
                    customerPurchaseOrderItemDetailSeatInsertQuotation  : data.listCustomerPurchaseOrderItemDetail[i].seatInsert,
                    customerPurchaseOrderItemDetailStemQuotation        : data.listCustomerPurchaseOrderItemDetail[i].stem,
                    
                    customerPurchaseOrderItemDetailSealQuotation        : data.listCustomerPurchaseOrderItemDetail[i].seal,
                    customerPurchaseOrderItemDetailBoltQuotation        : data.listCustomerPurchaseOrderItemDetail[i].bolting,
                    customerPurchaseOrderItemDetailDiscQuotation        : data.listCustomerPurchaseOrderItemDetail[i].disc,
                    customerPurchaseOrderItemDetailPlatesQuotation      : data.listCustomerPurchaseOrderItemDetail[i].plates,
                    customerPurchaseOrderItemDetailShaftQuotation       : data.listCustomerPurchaseOrderItemDetail[i].shaft,
                    customerPurchaseOrderItemDetailSpringQuotation      : data.listCustomerPurchaseOrderItemDetail[i].spring,
                    
                    customerPurchaseOrderItemDetailArmPinQuotation      : data.listCustomerPurchaseOrderItemDetail[i].armPin,
                    customerPurchaseOrderItemDetailBackSeatQuotation    : data.listCustomerPurchaseOrderItemDetail[i].backSeat,
                    customerPurchaseOrderItemDetailArmQuotation         : data.listCustomerPurchaseOrderItemDetail[i].arm,
                    customerPurchaseOrderItemDetailHingePinQuotation    : data.listCustomerPurchaseOrderItemDetail[i].hingePin,
                    customerPurchaseOrderItemDetailStopPinQuotation     : data.listCustomerPurchaseOrderItemDetail[i].stopPin,
                    customerPurchaseOrderItemDetailOperatorQuotation    : data.listCustomerPurchaseOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerPurchaseOrderItemDetail[i].itemBodyConstructionCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyConstName     : data.listCustomerPurchaseOrderItemDetail[i].itemBodyConstructionName,
                    customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerPurchaseOrderItemDetail[i].itemTypeDesignCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerPurchaseOrderItemDetail[i].itemTypeDesignName,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerPurchaseOrderItemDetail[i].itemSeatDesignCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerPurchaseOrderItemDetail[i].itemSeatDesignName,
                    customerPurchaseOrderItemDetailItemFinishGoodsSizeCode          : data.listCustomerPurchaseOrderItemDetail[i].itemSizeCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSizeName          : data.listCustomerPurchaseOrderItemDetail[i].itemSizeName,
                    customerPurchaseOrderItemDetailItemFinishGoodsRatingCode        : data.listCustomerPurchaseOrderItemDetail[i].itemRatingCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsRatingName        : data.listCustomerPurchaseOrderItemDetail[i].itemRatingName,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoreCode          : data.listCustomerPurchaseOrderItemDetail[i].itemBoreCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoreName          : data.listCustomerPurchaseOrderItemDetail[i].itemBoreName,
                    
                    customerPurchaseOrderItemDetailItemFinishGoodsEndConCode        : data.listCustomerPurchaseOrderItemDetail[i].itemEndConCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsEndConName        : data.listCustomerPurchaseOrderItemDetail[i].itemEndConName,
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyCode          : data.listCustomerPurchaseOrderItemDetail[i].itemBodyCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBodyName          : data.listCustomerPurchaseOrderItemDetail[i].itemBodyName,
                    customerPurchaseOrderItemDetailItemFinishGoodsBallCode          : data.listCustomerPurchaseOrderItemDetail[i].itemBallCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBallName          : data.listCustomerPurchaseOrderItemDetail[i].itemBallName,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatCode          : data.listCustomerPurchaseOrderItemDetail[i].itemSeatCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatName          : data.listCustomerPurchaseOrderItemDetail[i].itemSeatName,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerPurchaseOrderItemDetail[i].itemSeatInsertCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerPurchaseOrderItemDetail[i].itemSeatInsertName,
                    customerPurchaseOrderItemDetailItemFinishGoodsStemCode          : data.listCustomerPurchaseOrderItemDetail[i].itemStemCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsStemName          : data.listCustomerPurchaseOrderItemDetail[i].itemStemName,
                    
                    customerPurchaseOrderItemDetailItemFinishGoodsSealCode          : data.listCustomerPurchaseOrderItemDetail[i].itemSealCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSealName          : data.listCustomerPurchaseOrderItemDetail[i].itemSealName,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoltCode          : data.listCustomerPurchaseOrderItemDetail[i].itemBoltCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBoltName          : data.listCustomerPurchaseOrderItemDetail[i].itemBoltName,
                    customerPurchaseOrderItemDetailItemFinishGoodsDiscCode          : data.listCustomerPurchaseOrderItemDetail[i].itemDiscCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsDiscName          : data.listCustomerPurchaseOrderItemDetail[i].itemDiscName,
                    customerPurchaseOrderItemDetailItemFinishGoodsPlatesCode        : data.listCustomerPurchaseOrderItemDetail[i].itemPlatesCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsPlatesName        : data.listCustomerPurchaseOrderItemDetail[i].itemPlatesName,
                    customerPurchaseOrderItemDetailItemFinishGoodsShaftCode         : data.listCustomerPurchaseOrderItemDetail[i].itemShaftCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsShaftName         : data.listCustomerPurchaseOrderItemDetail[i].itemShaftName,
                    customerPurchaseOrderItemDetailItemFinishGoodsSpringCode        : data.listCustomerPurchaseOrderItemDetail[i].itemSpringCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsSpringName        : data.listCustomerPurchaseOrderItemDetail[i].itemSpringName,
                    
                    customerPurchaseOrderItemDetailItemFinishGoodsArmPinCode        : data.listCustomerPurchaseOrderItemDetail[i].itemArmPinCode, 
                    customerPurchaseOrderItemDetailItemFinishGoodsArmPinName        : data.listCustomerPurchaseOrderItemDetail[i].itemArmPinName, 
                    customerPurchaseOrderItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerPurchaseOrderItemDetail[i].itemBackSeatCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsBackSeatName      : data.listCustomerPurchaseOrderItemDetail[i].itemBackSeatName,
                    customerPurchaseOrderItemDetailItemFinishGoodsArmCode           : data.listCustomerPurchaseOrderItemDetail[i].itemArmCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsArmName           : data.listCustomerPurchaseOrderItemDetail[i].itemArmName,
                    customerPurchaseOrderItemDetailItemFinishGoodsHingePinCode      : data.listCustomerPurchaseOrderItemDetail[i].itemHingePinCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsHingePinName      : data.listCustomerPurchaseOrderItemDetail[i].itemHingePinName,
                    customerPurchaseOrderItemDetailItemFinishGoodsStopPinCode       : data.listCustomerPurchaseOrderItemDetail[i].itemStopPinCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsStopPinName       : data.listCustomerPurchaseOrderItemDetail[i].itemStopPinName,
                    customerPurchaseOrderItemDetailItemFinishGoodsOperatorCode      : data.listCustomerPurchaseOrderItemDetail[i].itemOperatorCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsOperatorName      : data.listCustomerPurchaseOrderItemDetail[i].itemOperatorName,
                    
                    customerPurchaseOrderItemDetailNote                 : data.listCustomerPurchaseOrderItemDetail[i].note,
                    customerPurchaseOrderItemDetailQuantity             : data.listCustomerPurchaseOrderItemDetail[i].quantity,
                    customerPurchaseOrderItemDetailPrice                : data.listCustomerPurchaseOrderItemDetail[i].unitPrice,
                    customerPurchaseOrderItemDetailTotal                : data.listCustomerPurchaseOrderItemDetail[i].totalAmount
                });
                calculateCustomerPurchaseOrderHeader();
            }
        });
        closeLoading();
    }
    function loadCustomerPurchaseOrderItemDetail() {
        loadGridItem();
        var arrSalesQuotationNo=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNo.push(data.customerPurchaseOrderSalesQuotationCode);
        }
        
        var url = "sales/sales-quotation-detail-getgroupby-sales-quotation-data";
        var params = "arrSalesQuotationNo="+arrSalesQuotationNo;   
        customerPurchaseOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listSalesQuotationDetailTemp.length; i++) {
                customerPurchaseOrderItemDetailLastRowId++;
                
                $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderItemDetailLastRowId, data.listSalesQuotationDetailTemp[i]);
                $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderItemDetailLastRowId,{
                    customerPurchaseOrderItemDetailDelete               : "delete",
                    customerPurchaseOrderItemDetailQuotationNoDetailCode: data.listSalesQuotationDetailTemp[i].code,
                    customerPurchaseOrderItemDetailQuotationNo          : data.listSalesQuotationDetailTemp[i].headerCode,
                    customerPurchaseOrderItemDetailQuotationRefNo       : data.listSalesQuotationDetailTemp[i].refNo,
                    customerPurchaseOrderItemDetailItemFinishGoodsCode  : data.listSalesQuotationDetailTemp[i].itemFinishGoodsCode,
                    customerPurchaseOrderItemDetailItemFinishGoodsName  : data.listSalesQuotationDetailTemp[i].itemFinishGoodsName,
                    customerPurchaseOrderItemDetailSortNo               : data.listSalesQuotationDetailTemp[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderItemDetailValveTypeCode        : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                    customerPurchaseOrderItemDetailValveTypeName        : data.listSalesQuotationDetailTemp[i].valveTypeName,
                    customerPurchaseOrderItemDetailValveTag             : data.listSalesQuotationDetailTemp[i].valveTag,
                    customerPurchaseOrderItemDetailDataSheet            : data.listSalesQuotationDetailTemp[i].dataSheet,
                    customerPurchaseOrderItemDetailDescription          : data.listSalesQuotationDetailTemp[i].description,
                    customerPurchaseOrderItemDetailQuantity             : data.listSalesQuotationDetailTemp[i].quantity,
                    customerPurchaseOrderItemDetailPrice                : data.listSalesQuotationDetailTemp[i].unitPrice,
                    customerPurchaseOrderItemDetailTotal                : data.listSalesQuotationDetailTemp[i].total,
                    
                    // 24 valve Type Component
                    customerPurchaseOrderItemDetailBodyConstQuotation   : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                    customerPurchaseOrderItemDetailTypeDesignQuotation  : data.listSalesQuotationDetailTemp[i].typeDesign,
                    customerPurchaseOrderItemDetailSeatDesignQuotation  : data.listSalesQuotationDetailTemp[i].seatDesign,
                    customerPurchaseOrderItemDetailSizeQuotation        : data.listSalesQuotationDetailTemp[i].size,
                    customerPurchaseOrderItemDetailRatingQuotation      : data.listSalesQuotationDetailTemp[i].rating,
                    customerPurchaseOrderItemDetailBoreQuotation        : data.listSalesQuotationDetailTemp[i].bore,
                    
                    customerPurchaseOrderItemDetailEndConQuotation      : data.listSalesQuotationDetailTemp[i].endCon,
                    customerPurchaseOrderItemDetailBodyQuotation        : data.listSalesQuotationDetailTemp[i].body,
                    customerPurchaseOrderItemDetailBallQuotation        : data.listSalesQuotationDetailTemp[i].ball,
                    customerPurchaseOrderItemDetailSeatQuotation        : data.listSalesQuotationDetailTemp[i].seat,
                    customerPurchaseOrderItemDetailSeatInsertQuotation  : data.listSalesQuotationDetailTemp[i].seatInsert,
                    customerPurchaseOrderItemDetailStemQuotation        : data.listSalesQuotationDetailTemp[i].stem,
                    
                    customerPurchaseOrderItemDetailSealQuotation        : data.listSalesQuotationDetailTemp[i].seal,
                    customerPurchaseOrderItemDetailBoltQuotation        : data.listSalesQuotationDetailTemp[i].bolt,
                    customerPurchaseOrderItemDetailDiscQuotation        : data.listSalesQuotationDetailTemp[i].disc,
                    customerPurchaseOrderItemDetailPlatesQuotation      : data.listSalesQuotationDetailTemp[i].plates,
                    customerPurchaseOrderItemDetailShaftQuotation       : data.listSalesQuotationDetailTemp[i].shaft,
                    customerPurchaseOrderItemDetailSpringQuotation      : data.listSalesQuotationDetailTemp[i].spring,
                    
                    customerPurchaseOrderItemDetailArmPinQuotation      : data.listSalesQuotationDetailTemp[i].armPin,
                    customerPurchaseOrderItemDetailBackSeatQuotation    : data.listSalesQuotationDetailTemp[i].backseat,
                    customerPurchaseOrderItemDetailArmQuotation         : data.listSalesQuotationDetailTemp[i].arm,
                    customerPurchaseOrderItemDetailHingePinQuotation    : data.listSalesQuotationDetailTemp[i].hingePin,
                    customerPurchaseOrderItemDetailStopPinQuotation     : data.listSalesQuotationDetailTemp[i].stopPin,
                    customerPurchaseOrderItemDetailOperatorQuotation    : data.listSalesQuotationDetailTemp[i].oper,
                    //
                    customerPurchaseOrderItemDetailNote                 : data.listSalesQuotationDetailTemp[i].note
                });
                totalTransaction+=parseFloat(data.listSalesQuotationDetailTemp[i].total.toFixed(2));
                txtCustomerPurchaseOrderTotalTransactionAmount.val(formatNumber(totalTransaction,2));
                calculateCustomerPurchaseOrderHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderAdditionalFee() {
        if($("#enumCustomerPurchaseOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-additional-fee-data";
        var params = "customerPurchaseOrder.code="+$("#customerPurchaseOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderAdditionalFeeLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderAdditionalFee.length; i++) {
                customerPurchaseOrderAdditionalFeeLastRowId++;
                
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid("addRowData", customerPurchaseOrderAdditionalFeeLastRowId, data.listCustomerPurchaseOrderAdditionalFee[i]);
                $("#customerPurchaseOrderAdditionalFeeInput_grid").jqGrid('setRowData',customerPurchaseOrderAdditionalFeeLastRowId,{
                    customerPurchaseOrderAdditionalFeeDelete                   : "delete",
                    customerPurchaseOrderAdditionalFeeRemark                   : data.listCustomerPurchaseOrderAdditionalFee[i].remark,
                    customerPurchaseOrderAdditionalFeeQuantity                 : data.listCustomerPurchaseOrderAdditionalFee[i].quantity,
                    customerPurchaseOrderAdditionalFeeSearchUnitOfMeasure      : "...",
                    customerPurchaseOrderAdditionalFeeUnitOfMeasureCode        : data.listCustomerPurchaseOrderAdditionalFee[i].unitOfMeasureCode,
                    customerPurchaseOrderAdditionalFeeAdditionalFeeCode        : data.listCustomerPurchaseOrderAdditionalFee[i].additionalFeeCode,
                    customerPurchaseOrderAdditionalFeeAdditionalFeeName        : data.listCustomerPurchaseOrderAdditionalFee[i].additionalFeeName,
                    customerPurchaseOrderAdditionalFeeSalesChartOfAccountCode  : data.listCustomerPurchaseOrderAdditionalFee[i].coaCode,
                    customerPurchaseOrderAdditionalFeeSalesChartOfAccountName  : data.listCustomerPurchaseOrderAdditionalFee[i].coaName,
                    customerPurchaseOrderAdditionalFeePrice                    : data.listCustomerPurchaseOrderAdditionalFee[i].price,
                    customerPurchaseOrderAdditionalFeeTotal                    : data.listCustomerPurchaseOrderAdditionalFee[i].total
                });
            }
            calculateCustomerPurchaseOrderTotalAdditional();
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderPaymentTerm() {
        if($("#enumCustomerPurchaseOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-payment-term-data";
        var params = "customerPurchaseOrder.code="+$("#customerPurchaseOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderPaymentTermLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderPaymentTerm.length; i++) {
                customerPurchaseOrderPaymentTermLastRowId++;
                
                $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid("addRowData", customerPurchaseOrderPaymentTermLastRowId, data.listCustomerPurchaseOrderPaymentTerm[i]);
                $("#customerPurchaseOrderPaymentTermInput_grid").jqGrid('setRowData',customerPurchaseOrderPaymentTermLastRowId,{
                    customerPurchaseOrderPaymentTermDelete             : "delete",
                    customerPurchaseOrderPaymentTermSearchPaymentTerm  : "...",
                    customerPurchaseOrderPaymentTermSortNO             : data.listCustomerPurchaseOrderPaymentTerm[i].sortNo,
                    customerPurchaseOrderPaymentTermPaymentTermCode    : data.listCustomerPurchaseOrderPaymentTerm[i].paymentTermCode,
                    customerPurchaseOrderPaymentTermPaymentTermName    : data.listCustomerPurchaseOrderPaymentTerm[i].paymentTermName,
                    customerPurchaseOrderPaymentTermPercent            : data.listCustomerPurchaseOrderPaymentTerm[i].percentage,
                    customerPurchaseOrderPaymentTermRemark             : data.listCustomerPurchaseOrderPaymentTerm[i].remark
                });
            }
        });
        closeLoading();
    }
    
    function customerPurchaseOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=customerPurchaseOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function customerPurchaseOrderAdditionalFeeInputGrid_SearchAdditional_OnClick(){
        window.open("./pages/search/search-additional-fee-sales.jsp?iddoc=customerPurchaseOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function customerPurchaseOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick(){
        window.open("./pages/search/search-payment-term.jsp?iddoc=customerPurchaseOrderPaymentTerm&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function customerPurchaseOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick(){
        var customer=txtCustomerPurchaseOrderEndUserCode.val();
        window.open("./pages/search/search-item-finish-goods.jsp?iddoc=customerPurchaseOrderItemDetail&type=grid&idcustomer="+customer ,"Search", "scrollbars=1,width=600, height=500");
    }
    
    function customerPurchaseOrderItemDeliveryInputGrid_SearchItem_OnClick(){
       var selectedRowID = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
       var sqCode = $("#" + selectedRowID + "_customerPurchaseOrderItemDeliverySalesQuotationCode").val();
       
       if (sqCode ===""){
           alertMessage("Please Input Sales Quotation");
           return;
       }
       
        window.open("./pages/search/search-item-delivery.jsp?iddoc=customerPurchaseOrderItemDelivery&type=grid&idsalesquotationcode="+sqCode,"Search", "width=600, height=500");
    }
    
    function sortNoDelivery(itemCode){
         $('#customerPurchaseOrderItemDetailInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel); 
         var ids = jQuery("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs');
         var temp="";
        for(var i=0;i<ids.length;i++){
            var Detail = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                if (itemCode===Detail.customerPurchaseOrderItemDetailItem){
                    temp=Detail.customerPurchaseOrderItemDetailSortNo;
                }
        }
        
         $('#customerPurchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderItemDelivery_lastSel); 
         var idt = jQuery("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
         for(var i=0;i<idt.length;i++){
             var Details = $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('getRowData',idt[i]); 
                if (itemCode===Details.customerPurchaseOrderItemDeliveryItemCode){
                    $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("setCell",idt[i], "customerPurchaseOrderItemDeliverySortNo",temp);

                }
         }
    }
    
     function loadCustomerPurchaseOrderItemDeliveryDate() {
        if($("#enumCustomerPurchaseOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-item-delivery-data";
        var params = "customerPurchaseOrder.code="+$("#customerPurchaseOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderItemDeliveryLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderItemDeliveryDate.length; i++) {
                customerPurchaseOrderItemDeliveryLastRowId++;
                
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderItemDeliveryLastRowId, data.listCustomerPurchaseOrderItemDeliveryDate[i]);
                $("#customerPurchaseOrderItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderItemDeliveryLastRowId,{
                    customerPurchaseOrderItemDeliveryDelete                   : "delete",
                    customerPurchaseOrderItemDeliverySearchQuotation          : "...",
                    customerPurchaseOrderItemDeliverySalesQuotationCode       : data.listCustomerPurchaseOrderItemDeliveryDate[i].salesQuotationCode,
                    customerPurchaseOrderItemDeliverySalesQuotationRefNo      : data.listCustomerPurchaseOrderItemDeliveryDate[i].refNo,
                    customerPurchaseOrderItemDeliveryItemFinishGoodsCode      : data.listCustomerPurchaseOrderItemDeliveryDate[i].itemFinishGoodsCode,
                    customerPurchaseOrderItemDeliveryItemFinishGoodsRemark    : data.listCustomerPurchaseOrderItemDeliveryDate[i].itemFinishGoodsRemark,
                    customerPurchaseOrderItemDeliverySortNo                   : data.listCustomerPurchaseOrderItemDeliveryDate[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderItemDeliveryQuantity                 : data.listCustomerPurchaseOrderItemDeliveryDate[i].quantity,
                    customerPurchaseOrderItemDeliveryDeliveryDate             : formatDateRemoveT(data.listCustomerPurchaseOrderItemDeliveryDate[i].deliveryDate,false)
                });
            }
        });
        closeLoading();
    }
    
    function reqstSQArry(){
        var ids = jQuery("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getDataIDs');
        var listSalesQuotationCode = new Array();
        for(var q=0;q < ids.length;q++){ 
             var data = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid('getRowData',ids[q]); 
             listSalesQuotationCode[q] = {
                 code:data.customerPurchaseOrderItemDetailQuotationNo,
                 name:data.customerPurchaseOrderItemDetailQuotationNo
             };
         }
         return listSalesQuotationCode;
    }
    
    function setCustomerPurchaseOrderPartialShipmentStatusStatus(){
        switch($("#customerPurchaseOrder\\.partialShipmentStatus").val()){
            case "YES":
                $('input[name="customerPurchaseOrderPartialShipmentStatusRad"][value="YES"]').prop('checked',true);
                break;
            case "NO":
                $('input[name="customerPurchaseOrderPartialShipmentStatusRad"][value="NO"]').prop('checked',true);
                break;
        } 
    }
    
    function cpoSOTransactionDateOnChange(){
        if($("#enumCustomerPurchaseOrderActivity").val()!=="UPDATE"){
            $("#customerPurchaseOrderTransactionDate").val(dtpCustomerPurchaseOrderTransactionDate.val());
        }
        if($("#enumCustomerPurchaseOrderActivity").val()!=="REVISE"){
            $("#customerPurchaseOrderTransactionDate").val(dtpCustomerPurchaseOrderTransactionDate.val());
        }
        if($("#enumCustomerPurchaseOrderActivity").val()!=="CLONE"){
            $("#customerPurchaseOrderTransactionDate").val(dtpCustomerPurchaseOrderTransactionDate.val());
        }
    }
    
    function avoidSpcCharCpoSo(){
        
        var selectedRowID = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerPurchaseOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerPurchaseOrderItemDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_customerPurchaseOrderItemDetailSortNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep = str.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_customerPurchaseOrderItemDetailSortNo").val(rep);
        }
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_customerPurchaseOrderItemDetailSortNo").val("");
        }
    }
</script>

<s:url id="remoteurlCustomerPurchaseOrderSalesQuotationInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderAdditionalFeeInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderPaymentTermInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderItemDeliveryInput" action="" />
<b>CUSTOMER PURCHASE ORDER TO SALES ORDER</b><span id="msgCustomerPurchaseOrderActivity"></span>
<hr>
<br class="spacer" />

<div id="customerPurchaseOrderInput" class="content ui-widget">
    <s:form id="frmCustomerPurchaseOrderInput">
        <table cellpadding="2" cellspacing="2" id="headerCustomerPurchaseOrderInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" style="width:180px"><B>CPO-SO No *</B></td>
                            <td>
                                <s:textfield id="customerPurchaseOrder.code" name="customerPurchaseOrder.code" key="customerPurchaseOrder.code" readonly="true" size="30"></s:textfield>
                                <s:textfield id="customerPurchaseOrder.customerPurchaseOrderCode" name="customerPurchaseOrder.customerPurchaseOrderCode" key="customerPurchaseOrder.customerPurchaseOrderCode" readonly="true" size="25" disabled="true" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ref CPO-SO No *</B></td>
                            <td>
                            <s:textfield id="customerPurchaseOrder.custPONo" name="customerPurchaseOrder.custPONo" key="customerPurchaseOrder.custPONo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                                <s:textfield id="customerPurchaseOrder.refCUSTPOCode" name="customerPurchaseOrder.refCUSTPOCode" key="customerPurchaseOrder.refCUSTPOCode" readonly="true" size="30"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="customerPurchaseOrder.revision" name="customerPurchaseOrder.revision" key="customerPurchaseOrder.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                txtCustomerPurchaseOrderBranchCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderBranchCode.val()===""){
                                        txtCustomerPurchaseOrderBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get";
                                    var params = "branch.code=" + txtCustomerPurchaseOrderBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtCustomerPurchaseOrderBranchCode.val(data.branchTemp.code);
                                            txtCustomerPurchaseOrderBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtCustomerPurchaseOrderBranchCode);
                                            txtCustomerPurchaseOrderBranchCode.val("");
                                            txtCustomerPurchaseOrderBranchName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerPurchaseOrder.branch.code" name="customerPurchaseOrder.branch.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrder_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerPurchaseOrder.branch.name" name="customerPurchaseOrder.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="customerPurchaseOrder.transactionDate" name="customerPurchaseOrder.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" onchange="cpoSOTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                                <sj:datepicker id="customerPurchaseOrderTransactionDate" name="customerPurchaseOrderTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right"><B>Order Status * </B></td>
                            <td colspan="2">
                                <s:radio id="customerPurchaseOrderOrderStatusRad" name="customerPurchaseOrderOrderStatusRad" label="customerPurchaseOrderOrderStatusRad" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio>
                                <s:textfield id="customerPurchaseOrder.orderStatus" name="customerPurchaseOrder.orderStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="customerPurchaseOrder.purchaseOrderType" name="customerPurchaseOrder.purchaseOrderType" size="20" readonly="true" value="CPO-SO"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order No *</B></td>
                            <td colspan="3"><s:textfield id="customerPurchaseOrder.customerPurchaseOrderNo" name="customerPurchaseOrder.customerPurchaseOrderNo" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtCustomerPurchaseOrderCustomerCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderCustomerCode.val()===""){
                                        txtCustomerPurchaseOrderCustomerName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get";
                                    var params = "customer.code=" + txtCustomerPurchaseOrderCustomerCode.val();
                                        params += "&customer.activeStatus=TRUE";
                                        params += "&customer.customerStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtCustomerPurchaseOrderCustomerCode.val(data.customerTemp.code);
                                            txtCustomerPurchaseOrderCustomerName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer Not Found!",txtCustomerPurchaseOrderCustomerCode);
                                            txtCustomerPurchaseOrderCustomerCode.val("");
                                            txtCustomerPurchaseOrderCustomerName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerPurchaseOrder.customer.code" name="customerPurchaseOrder.customer.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrder_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerPurchaseOrder.customer.name" name="customerPurchaseOrder.customer.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>End User *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtCustomerPurchaseOrderEndUserCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderEndUserCode.val()===""){
                                        txtCustomerPurchaseOrderEndUserName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get-end-user";
                                    var params = "customer.code=" + txtCustomerPurchaseOrderEndUserCode.val();
                                        params += "&customer.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtCustomerPurchaseOrderEndUserCode.val(data.customerTemp.code);
                                            txtCustomerPurchaseOrderEndUserName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer End User Not Found!",txtCustomerPurchaseOrderEndUserCode);
                                            txtCustomerPurchaseOrderEndUserCode.val("");
                                            txtCustomerPurchaseOrderEndUserName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerPurchaseOrder.endUser.code" name="customerPurchaseOrder.endUser.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrder_btnCustomerEndUser" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerPurchaseOrder.endUser.name" name="customerPurchaseOrder.endUser.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Partial Shipment * </B></td>
                            <td colspan="2">
                                <s:radio id="customerPurchaseOrderPartialShipmentStatusRad" name="customerPurchaseOrderPartialShipmentStatusRad" label="customerPurchaseOrderPartialShipmentStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="customerPurchaseOrder.partialShipmentStatus" name="customerPurchaseOrder.partialShipmentStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Retention</td>
                            <td>
                                <s:textfield id="customerPurchaseOrder.retentionPercent" name="customerPurchaseOrder.retentionPercent" size="5" cssStyle="text-align:right"></s:textfield>%
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

                                    txtCustomerPurchaseOrderCurrencyCode.change(function(ev) {

                                        if(txtCustomerPurchaseOrderCurrencyCode.val()===""){
                                            txtCustomerPurchaseOrderCurrencyName.val("");
                                            return;
                                        }

                                        var url = "master/currency-get";
                                        var params = "currency.code=" + txtCustomerPurchaseOrderCurrencyCode.val();
                                            params+= "&currency.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.currencyTemp){
                                                txtCustomerPurchaseOrderCurrencyCode.val(data.currencyTemp.code);
                                                txtCustomerPurchaseOrderCurrencyName.val(data.currencyTemp.name);
                                            }
                                            else{
                                                alertMessage("Currency Not Found",txtCustomerPurchaseOrderCurrencyCode);
                                                txtCustomerPurchaseOrderCurrencyCode.val("");
                                                txtCustomerPurchaseOrderCurrencyName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="customerPurchaseOrder.currency.code" name="customerPurchaseOrder.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                <sj:a id="customerPurchaseOrder_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="customerPurchaseOrder.currency.name" name="customerPurchaseOrder.currency.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sales Person *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtCustomerPurchaseOrderSalesPersonCode.change(function(ev) {
                                        if(txtCustomerPurchaseOrderSalesPersonCode.val()===""){
                                            txtCustomerPurchaseOrderSalesPersonName.val("");
                                            return;
                                        }
                                        var url = "master/sales-person-get";
                                        var params = "salesPerson.code=" + txtCustomerPurchaseOrderSalesPersonCode.val();
                                            params+= "&salesPerson.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.salesPersonTemp){
                                                txtCustomerPurchaseOrderSalesPersonCode.val(data.salesPersonTemp.code);
                                                txtCustomerPurchaseOrderSalesPersonName.val(data.salesPersonTemp.name);
                                            }
                                            else{
                                                alertMessage("Sales Person Not Found!",txtCustomerPurchaseOrderSalesPersonCode);
                                                txtCustomerPurchaseOrderSalesPersonCode.val("");
                                                txtCustomerPurchaseOrderSalesPersonName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="customerPurchaseOrder.salesPerson.code" name="customerPurchaseOrder.salesPerson.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                    <sj:a id="customerPurchaseOrder_btnSalesPerson" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="customerPurchaseOrder.salesPerson.name" name="customerPurchaseOrder.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Project</td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtCustomerPurchaseOrderProjectCode.change(function(ev) {
                                        if(txtCustomerPurchaseOrderProjectCode.val()===""){
                                            txtCustomerPurchaseOrderProjectName.val("");
                                            return;
                                        }
                                        var url = "master/project-get";
                                        var params = "project.code=" + txtCustomerPurchaseOrderProjectCode.val();
                                            params+= "&project.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.projectTemp){
                                                txtCustomerPurchaseOrderProjectCode.val(data.projectTemp.code);
                                                txtCustomerPurchaseOrderProjectName.val(data.projectTemp.name);
                                            }
                                            else{
                                                alertMessage("Project Not Found!",txtCustomerPurchaseOrderProjectCode);
                                                txtCustomerPurchaseOrderProjectCode.val("");
                                                txtCustomerPurchaseOrderProjectName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="customerPurchaseOrder.project.code" name="customerPurchaseOrder.project.code" title=" " size="22"></s:textfield>
                                    <sj:a id="customerPurchaseOrder_btnProject" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="customerPurchaseOrder.project.name" name="customerPurchaseOrder.project.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3"><s:textfield id="customerPurchaseOrder.refNo" name="customerPurchaseOrder.refNo" size="27"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="customerPurchaseOrder.remark" name="customerPurchaseOrder.remark"  cols="70" rows="2" height="20"></s:textarea></td>
                        </tr> 
                    </table>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="customerPurchaseOrderDateFirstSession" name="customerPurchaseOrderDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="customerPurchaseOrderDateLastSession" name="customerPurchaseOrderDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumCustomerPurchaseOrderActivity" name="enumCustomerPurchaseOrderActivity" size="20" cssStyle="display:nones"></s:textfield>
                    <s:textfield id="customerPurchaseOrderCloneModeCode" name="customerPurchaseOrderCloneModeCode" size="20" cssStyle="display:nones"></s:textfield>
                    <s:textfield id="customerPurchaseOrder.createdBy" name="customerPurchaseOrder.createdBy" key="customerPurchaseOrder.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="customerPurchaseOrder.createdDate" name="customerPurchaseOrder.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="customerPurchaseOrder.createdDateTemp" name="customerPurchaseOrder.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrder" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrder" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnCPOSOSearchSalQuo" button="true" style="width: 200px">Search Sales Quotation</sj:a>
                </td>
            </tr>
        </table>        
        <br class="spacer" />
        <div id="customerPurchaseOrderSalesQuotationInputGrid">
            <sjg:grid
                id="customerPurchaseOrderSalesQuotationInput_grid"
                caption="Sales Quotation"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listCustomerPurchaseOrderTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuCustomerPurchaseOrderDetail').width()"
                editurl="%{remoteurlCustomerPurchaseOrderSalesQuotationInput}"
                onSelectRowTopics="customerPurchaseOrderSalesQuotationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotation" index="customerPurchaseOrderSalesQuotation" key="customerPurchaseOrderSalesQuotation" 
                    title="" width="50" sortable="true" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationDelete" index="customerPurchaseOrderSalesQuotationDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'customerPurchaseOrderSalesQuotationInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationCode" index="customerPurchaseOrderSalesQuotationCode" 
                    title="SLS-QUO No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationTransactionDate" index="customerPurchaseOrderSalesQuotationTransactionDate" key="customerPurchaseOrderSalesQuotationTransactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationCustomerCode" index="customerPurchaseOrderSalesQuotationCustomerCode" 
                    title="Customer Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationCustomerName" index="customerPurchaseOrderSalesQuotationCustomerName" 
                    title="Customer Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationEndUserCode" index="customerPurchaseOrderSalesQuotationEndUserCode" 
                    title="End User Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationEndUserName" index="customerPurchaseOrderSalesQuotationEndUserName" 
                    title="End User Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "customerPurchaseOrderSalesQuotationRfqCode" index = "customerPurchaseOrderSalesQuotationRfqCode" key = "customerPurchaseOrderSalesQuotationRfqCode" 
                    title = "RFQ No" width = "120" edittype="text" 
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationProjectCode" index="customerPurchaseOrderSalesQuotationProjectCode" 
                    title="Project" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationSubject" index="customerPurchaseOrderSalesQuotationSubject" 
                    title="Subject" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationAttn" index="customerPurchaseOrderSalesQuotationAttn" 
                    title="Attn" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationRefNo" index="customerPurchaseOrderSalesQuotationRefNo" key="customerPurchaseOrderSalesQuotationRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderSalesQuotationRemark" index="customerPurchaseOrderSalesQuotationRemark" key="customerPurchaseOrderSalesQuotationRemark" 
                    title="Remark" width="150" sortable="true"
                />
            </sjg:grid >     
        </div>
        <table>        
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderSalesQuotation" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderSalesQuotation" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderSalesQuotationDetailSort" button="true" style="width: 70px">Sort No</sj:a>
                </td>
            </tr>
        </table>
        <div id="id-tbl-additional-payment-item-delivery">
            <div>
                <sjg:grid
                    id="customerPurchaseOrderItemDetailInput_grid"
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
                    editurl="%{remoteurlCustomerPurchaseOrderSalesQuotationInput}"
                    onSelectRowTopics="customerPurchaseOrderItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetail" index="customerPurchaseOrderItemDetail" key="customerPurchaseOrderItemDetail" 
                        title="" width="50" sortable="true" editable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailDelete" index="customerPurchaseOrderItemDetailDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'customerPurchaseOrderItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />                    
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailQuotationNoDetailCode" index="customerPurchaseOrderItemDetailQuotationNoDetailCode" key="customerPurchaseOrderItemDetailQuotationNoDetailCode" 
                        title="Quotation No" width="150" sortable="true"
                    />                   
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailQuotationNo" index="customerPurchaseOrderItemDetailQuotationNo" key="customerPurchaseOrderItemDetailQuotationNo" 
                        title="Quotation No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailQuotationRefNo" index="customerPurchaseOrderItemDetailQuotationRefNo" key="customerPurchaseOrderItemDetailQuotationRefNo" 
                        title="Ref No" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSortNo" index="customerPurchaseOrderItemDetailSortNo" 
                        title="Sort No" width="80" sortable="true" editable="true" edittype="text" formatter="integer"
                        editoptions="{onKeyUp:'avoidSpcCharCpoSo()'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSearchItemFinishGoods" index="customerPurchaseOrderItemDetailSearchItemFinishGoods" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"
                        editoptions="{onClick:'customerPurchaseOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsCode" index="customerPurchaseOrderItemDetailItemFinishGoodsCode" key="customerPurchaseOrderItemDetailItemFinishGoodsCode" 
                        title="Item Finish Goods Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsRemark" index="customerPurchaseOrderItemDetailItemFinishGoodsRemark" key="customerPurchaseOrderItemDetailItemFinishGoodsRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailValveTypeCode" index="customerPurchaseOrderItemDetailValveTypeCode" key="customerPurchaseOrderItemDetailValveTypeCode" 
                        title="Valve Type Code (QUO)" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailValveTypeName" index="customerPurchaseOrderItemDetailValveTypeName" key="customerPurchaseOrderItemDetailValveTypeName" 
                        title="Valve Type Name (QUO)" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemAlias" index="customerPurchaseOrderItemDetailItemAlias" 
                        title="Item Alias" width="100" sortable="true" editable="true" edittype="text"
                    /> 
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailValveTag" index="customerPurchaseOrderItemDetailValveTag" 
                        title="Valve Tag" width="100" sortable="true" editable="true" edittype="text"
                    />  
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailDataSheet" index="customerPurchaseOrderItemDetailDataSheet" 
                        title="Data Sheet" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailDescription" index="customerPurchaseOrderItemDetailDescription" 
                        title="Description" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <!--Body Const 01-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailBodyConstQuotation" index="customerPurchaseOrderItemDetailBodyConstQuotation" 
                        title="QUO (01)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBodyConstCode" index="customerPurchaseOrderItemDetailItemFinishGoodsBodyConstCode" 
                        title="IFG (01)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBodyConstName" index="customerPurchaseOrderItemDetailItemFinishGoodsBodyConstName" 
                        title="IFG (01)" width="100" sortable="true"
                    />
                    <!--Type Design 02-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailTypeDesignQuotation" index="customerPurchaseOrderItemDetailTypeDesignQuotation" 
                        title="QUO (02)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignCode" index="customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignCode" 
                        title="IFG (02)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignName" index="customerPurchaseOrderItemDetailItemFinishGoodsTypeDesignName" 
                        title="IFG (02)" width="100" sortable="true"
                    />
                    <!--Seat Design 03-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSeatDesignQuotation" index="customerPurchaseOrderItemDetailSeatDesignQuotation" 
                        title="QUO (03)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignCode" index="customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignCode" 
                        title="IFG (03)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignName" index="customerPurchaseOrderItemDetailItemFinishGoodsSeatDesignName" 
                        title="IFG (03)" width="100" sortable="true"
                    />
                    <!--Size 04-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSizeQuotation" index="customerPurchaseOrderItemDetailSizeQuotation" 
                        title="QUO (04)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSizeCode" index="customerPurchaseOrderItemDetailItemFinishGoodsSizeCode" 
                        title="IFG (04)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSizeName" index="customerPurchaseOrderItemDetailItemFinishGoodsSizeName" 
                        title="IFG (04)" width="100" sortable="true"
                    />
                    <!--Rating 05-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailRatingQuotation" index="customerPurchaseOrderItemDetailRatingQuotation" 
                        title="QUO (05)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsRatingCode" index="customerPurchaseOrderItemDetailItemFinishGoodsRatingCode" 
                        title="IFG (05)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsRatingName" index="customerPurchaseOrderItemDetailItemFinishGoodsRatingName" 
                        title="IFG (05)" width="100" sortable="true"
                    />
                    <!--Bore 06-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailBoreQuotation" index="customerPurchaseOrderItemDetailBoreQuotation" 
                        title="QUO (06)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBoreCode" index="customerPurchaseOrderItemDetailItemFinishGoodsBoreCode" 
                        title="IFG (06)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBoreName" index="customerPurchaseOrderItemDetailItemFinishGoodsBoreName" 
                        title="IFG (06)" width="100" sortable="true"
                    />
                    <!--EndCon 07-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailEndConQuotation" index="customerPurchaseOrderItemDetailEndConQuotation" 
                        title="QUO (07)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsEndConCode" index="customerPurchaseOrderItemDetailItemFinishGoodsEndConCode" 
                        title="IFG (07)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsEndConName" index="customerPurchaseOrderItemDetailItemFinishGoodsEndConName" 
                        title="IFG (07)" width="100" sortable="true"
                    />
                    <!--Body 08-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailBodyQuotation" index="customerPurchaseOrderItemDetailBodyQuotation" 
                        title="QUO (08)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBodyCode" index="customerPurchaseOrderItemDetailItemFinishGoodsBodyCode" 
                        title="IFG (08)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBodyName" index="customerPurchaseOrderItemDetailItemFinishGoodsBodyName" 
                        title="IFG (08)" width="100" sortable="true"
                    />
                    <!--Ball 09-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailBallQuotation" index="customerPurchaseOrderItemDetailBallQuotation" 
                        title="QUO (09)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBallCode" index="customerPurchaseOrderItemDetailItemFinishGoodsBallCode" 
                        title="IFG (09)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBallName" index="customerPurchaseOrderItemDetailItemFinishGoodsBallName" 
                        title="IFG (09)" width="100" sortable="true"
                    />
                    <!--Seat 10-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSeatQuotation" index="customerPurchaseOrderItemDetailSeatQuotation" 
                        title="QUO (10)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSeatCode" index="customerPurchaseOrderItemDetailItemFinishGoodsSeatCode" 
                        title="IFG (10)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSeatName" index="customerPurchaseOrderItemDetailItemFinishGoodsSeatName" 
                        title="IFG (10)" width="100" sortable="true"
                    />
                    <!--SeatInsert 11-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSeatInsertQuotation" index="customerPurchaseOrderItemDetailSeatInsertQuotation" 
                        title="QUO (11)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertCode" index="customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertCode" 
                        title="IFG (11)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertName" index="customerPurchaseOrderItemDetailItemFinishGoodsSeatInsertName" 
                        title="IFG (11)" width="100" sortable="true"
                    />
                    <!--Stem 12-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailStemQuotation" index="customerPurchaseOrderItemDetailStemQuotation" 
                        title="QUO (12)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsStemCode" index="customerPurchaseOrderItemDetailItemFinishGoodsStemCode" 
                        title="IFG (12)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsStemName" index="customerPurchaseOrderItemDetailItemFinishGoodsStemName" 
                        title="IFG (12)" width="100" sortable="true"
                    />
                    <!--Seal 13-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSealQuotation" index="customerPurchaseOrderItemDetailSealQuotation" 
                        title="QUO (13)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSealCode" index="customerPurchaseOrderItemDetailItemFinishGoodsSealCode" 
                        title="IFG (13)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSealName" index="customerPurchaseOrderItemDetailItemFinishGoodsSealName" 
                        title="IFG (13)" width="100" sortable="true"
                    />
                    <!--Bolt 14-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailBoltQuotation" index="customerPurchaseOrderItemDetailBoltQuotation" 
                        title="QUO (14)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBoltCode" index="customerPurchaseOrderItemDetailItemFinishGoodsBoltCode" 
                        title="IFG (14)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBoltName" index="customerPurchaseOrderItemDetailItemFinishGoodsBoltName" 
                        title="IFG (14)" width="100" sortable="true"
                    />
                    <!--Disc 15-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailDiscQuotation" index="customerPurchaseOrderItemDetailDiscQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsDiscCode" index="customerPurchaseOrderItemDetailItemFinishGoodsDiscCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsDiscName" index="customerPurchaseOrderItemDetailItemFinishGoodsDiscName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Plates 16-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailPlatesQuotation" index="customerPurchaseOrderItemDetailPlatesQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsPlatesCode" index="customerPurchaseOrderItemDetailItemFinishGoodsPlatesCode" 
                        title="IFG (16)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsPlatesName" index="customerPurchaseOrderItemDetailItemFinishGoodsPlatesName" 
                        title="IFG (16)" width="100" sortable="true"
                    />
                    <!--Shaft 17-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailShaftQuotation" index="customerPurchaseOrderItemDetailShaftQuotation" 
                        title="QUO (17)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsShaftCode" index="customerPurchaseOrderItemDetailItemFinishGoodsShaftCode" 
                        title="IFG (17)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsShaftName" index="customerPurchaseOrderItemDetailItemFinishGoodsShaftName" 
                        title="IFG (17)" width="100" sortable="true"
                    />
                    <!--Spring 18-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailSpringQuotation" index="customerPurchaseOrderItemDetailSpringQuotation" 
                        title="QUO (18)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSpringCode" index="customerPurchaseOrderItemDetailItemFinishGoodsSpringCode" 
                        title="IFG (18)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsSpringName" index="customerPurchaseOrderItemDetailItemFinishGoodsSpringName" 
                        title="IFG (18)" width="100" sortable="true"
                    />
                    <!--ArmPin 19-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailArmPinQuotation" index="customerPurchaseOrderItemDetailArmPinQuotation" 
                        title="QUO (19)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsArmPinCode" index="customerPurchaseOrderItemDetailItemFinishGoodsArmPinCode" 
                        title="IFG (19)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsArmPinName" index="customerPurchaseOrderItemDetailItemFinishGoodsArmPinName" 
                        title="IFG (19)" width="100" sortable="true"
                    />
                    <!--BackSeat 20-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailBackSeatQuotation" index="customerPurchaseOrderItemDetailBackSeatQuotation" 
                        title="QUO (20)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBackSeatCode" index="customerPurchaseOrderItemDetailItemFinishGoodsBackSeatCode" 
                        title="IFG (20)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsBackSeatName" index="customerPurchaseOrderItemDetailItemFinishGoodsBackSeatName" 
                        title="IFG (20)" width="100" sortable="true"
                    />
                    <!--Arm 21-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailArmQuotation" index="customerPurchaseOrderItemDetailArmQuotation" 
                        title="QUO (21)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsArmCode" index="customerPurchaseOrderItemDetailItemFinishGoodsArmCode" 
                        title="IFG (21)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsArmName" index="customerPurchaseOrderItemDetailItemFinishGoodsArmName" 
                        title="IFG (21)" width="100" sortable="true"
                    />
                    <!--HingePin 22-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailHingePinQuotation" index="customerPurchaseOrderItemDetailHingePinQuotation" 
                        title="QUO (22)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsHingePinCode" index="customerPurchaseOrderItemDetailItemFinishGoodsHingePinCode" 
                        title="IFG (22)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsHingePinName" index="customerPurchaseOrderItemDetailItemFinishGoodsHingePinName" 
                        title="IFG (22)" width="100" sortable="true"
                    />
                    <!--StopPin 23-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailStopPinQuotation" index="customerPurchaseOrderItemDetailStopPinQuotation" 
                        title="QUO (23)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsStopPinCode" index="customerPurchaseOrderItemDetailItemFinishGoodsStopPinCode" 
                        title="IFG (23)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsStopPinName" index="customerPurchaseOrderItemDetailItemFinishGoodsStopPinName" 
                        title="IFG (23)" width="100" sortable="true"
                    />
                    <!--Operator 99-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailOperatorQuotation" index="customerPurchaseOrderItemDetailOperatorQuotation" 
                        title="QUO (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsOperatorCode" index="customerPurchaseOrderItemDetailItemFinishGoodsOperatorCode" 
                        title="IFG (99)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailItemFinishGoodsOperatorName" index="customerPurchaseOrderItemDetailItemFinishGoodsOperatorName" 
                        title="IFG (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailNote" index="customerPurchaseOrderItemDetailNote" title="Note" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailQuantity" index="customerPurchaseOrderItemDetailQuantity" key="customerPurchaseOrderItemDetailQuantity" title="Qty" 
                        width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                        formatter="number" editrules="{ double: true }"
                        editoptions="{onKeyUp:'calculateItemSalesQuotationDetailCPOSO()'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailPrice" index="customerPurchaseOrderItemDetailPrice" key="customerPurchaseOrderItemDetailPrice" title="Unit Price" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderItemDetailTotal" index="customerPurchaseOrderItemDetailTotal" key="customerPurchaseOrderItemDetailTotal" title="Total" 
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
                                id="customerPurchaseOrderAdditionalFeeInput_grid"
                                caption="Additional"
                                dataType="local"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listCustomerPurchaseOrderAdditionalFee"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false"
                                editinline="true"
                                width="$('#tabmnuCustomerPurchaseOrderAdditionalFee').width()"
                                editurl="%{remoteurlCustomerPurchaseOrderAdditionalFeeInput}"
                                onSelectRowTopics="customerPurchaseOrderAdditionalFeeInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFee" index="customerPurchaseOrderAdditionalFee" key="customerPurchaseOrderAdditionalFee" 
                                    title="" width="50" sortable="true" editable="true" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeDelete" index="customerPurchaseOrderAdditionalFeeDelete" title="" width="50" align="centre"
                                    editable="true" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderAdditionalFeeInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeRemark" index="customerPurchaseOrderAdditionalFeeRemark" key="customerPurchaseOrderAdditionalFeeRemark" 
                                    title="Remark" width="150" sortable="true" editable="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeQuantity" index="customerPurchaseOrderAdditionalFeeQuantity" key="customerPurchaseOrderAdditionalFeeQuantity" title="Quantity" 
                                    width="80" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateCustomerPurchaseOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeSearchUnitOfMeasure" index="customerPurchaseOrderAdditionalFeeSearchUnitOfMeasure" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeUnitOfMeasureCode" index="customerPurchaseOrderAdditionalFeeUnitOfMeasureCode" 
                                    title="Unit" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeUnitOfMeasureCodeCPOSO()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeSearchAdditional" index="customerPurchaseOrderAdditionalFeeSearchAdditional" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderAdditionalFeeInputGrid_SearchAdditional_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeAdditionalFeeCode" index="customerPurchaseOrderAdditionalFeeAdditionalFeeCode" 
                                    title="Additional Fee Code" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeCodeCPOSO()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeAdditionalFeeName" index="customerPurchaseOrderAdditionalFeeAdditionalFeeName" 
                                    title="Additional Fee Name" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeSalesChartOfAccountCode" index="customerPurchaseOrderAdditionalFeeSalesChartOfAccountCode" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" 
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeSalesChartOfAccountName" index="customerPurchaseOrderAdditionalFeeSalesChartOfAccountName" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeePrice" index="customerPurchaseOrderAdditionalFeePrice" key="customerPurchaseOrderAdditionalFeePrice" title="Price" 
                                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateCustomerPurchaseOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderAdditionalFeeTotal" index="customerPurchaseOrderAdditionalFeeTotal" key="customerPurchaseOrderAdditionalFeeTotal" title="Total" 
                                    width="150" align="right" edittype="text"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                            </sjg:grid >
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="customerPurchaseOrderAdditionalFeeAddRow" name="customerPurchaseOrderSalesQuotationAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                            <sj:a href="#" id="btnCustomerPurchaseOrderAdditionalFeeAdd" button="true"  style="width: 60px">Add</sj:a>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table width="100%">
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr height="10px"/>
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="customerPurchaseOrderPaymentTermInput_grid"
                                            caption="Payment Term"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerPurchaseOrderPaymentTerm"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlCustomerPurchaseOrderPaymentTermInput}"
                                            onSelectRowTopics="customerPurchaseOrderPaymentTermInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTerm" index="customerPurchaseOrderPaymentTerm" 
                                                title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                            />  
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTermDelete" index="customerPurchaseOrderPaymentTermDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderPaymentTermInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTermSortNO" index="customerPurchaseOrderPaymentTermSortNO" key="customerPurchaseOrderPaymentTermSortNO" title="Term No" 
                                                width="80" align="right" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTermPaymentTermCode" index="customerPurchaseOrderPaymentTermPaymentTermCode" 
                                                title="Payment Term Code" width="100" sortable="true" edittype="text" editable="true"
                                                editoptions="{onChange:'onchangePaymentTermPaymentTermCodeCPOSO()'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTermSearchPaymentTerm" index="customerPurchaseOrderPaymentTermSearchPaymentTerm" title="" width="25" align="centre"
                                                editable="true" dataType="html" edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick()', value:'...'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTermPaymentTermName" index="customerPurchaseOrderPaymentTermPaymentTermName" 
                                                title="Payment Term" width="100" sortable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTermPercent" index="customerPurchaseOrderPaymentTermPercent" key="customerPurchaseOrderPaymentTermPercent" title="Percent" 
                                                width="80" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderPaymentTermRemark" index="customerPurchaseOrderPaymentTermRemark" 
                                                title="Note" width="200" sortable="true" edittype="text" editable="true"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderPaymentTermAddRow" name="customerPurchaseOrderPaymentTermAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnCustomerPurchaseOrderPaymentTermAdd" button="true"  style="width: 60px">Add</sj:a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table valign="top">
                                <tr>
                                    <td width="120px" align="right"><B>Total Transaction</B></td>
                                    <td width="120px">
                                        <s:textfield id="customerPurchaseOrder.totalTransactionAmount" name="customerPurchaseOrder.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Disc
                                        <s:textfield id="customerPurchaseOrder.discountPercent" name="customerPurchaseOrder.discountPercent" onkeyup="calculateCustomerPurchaseOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                    <s:textfield id="customerPurchaseOrder.discountAmount" name="customerPurchaseOrder.discountAmount" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Additional</td>
                                    <td>
                                    <s:textfield id="customerPurchaseOrder.totalAdditionalFeeAmount" name="customerPurchaseOrder.totalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" disabled="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><b>Sub Total(Tax Base)</b></td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrder.taxBaseAmount" name="customerPurchaseOrder.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">VAT
                                        <s:textfield id="customerPurchaseOrder.vatPercent" name="customerPurchaseOrder.vatPercent" onkeyup="calculateCustomerPurchaseOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrder.vatAmount" name="customerPurchaseOrder.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Grand Total</B></td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrder.grandTotalAmount" name="customerPurchaseOrder.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
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
                        <sj:a href="#" id="btnConfirmCustomerPurchaseOrderItemDetailDelivery" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderItemDetailDelivery" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>                
            <div id="id-tbl-additional-item-delivery-detail">
                <table>
                    <tr>
                        <td align="right">Delivery Date
                            <sj:datepicker id="customerPurchaseOrderDeliveryDateSet" name="customerPurchaseOrderDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today"></sj:datepicker>
                            <sj:a href="#" id="btnCustomerPurchaseOrderDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;
                            <sj:a href="#" id="btnCustomerPurchaseOrderCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="customerPurchaseOrderItemDeliveryInput_grid"
                                            caption="Item Delivery Date"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerPurchaseOrderTemp"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="1000"
                                            editurl="%{remoteurlCustomerPurchaseOrderItemDeliveryInput}"
                                            onSelectRowTopics="customerPurchaseOrderItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderItemDelivery" index="customerPurchaseOrderItemDelivery" key="customerPurchaseOrderItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderItemDeliveryDelete" index="customerPurchaseOrderItemDeliveryDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderItemDeliveryInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderItemDeliverySearchQuotation" index="customerPurchaseOrderItemDeliverySearchQuotation" title="" width="25" align="centre"
                                                editable="true"
                                                dataType="html"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderItemDeliveryInputGrid_SearchQuotation_OnClick()', value:'...'}"
                                            /> 
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderItemDeliveryItemFinishGoodsCode" index = "customerPurchaseOrderItemDeliveryItemFinishGoodsCode" key = "customerPurchaseOrderItemDeliveryItemFinishGoodsCode" 
                                                title = "Item Finish Goods Code" width = "100" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderItemDeliveryItemFinishGoodsRemark" index = "customerPurchaseOrderItemDeliveryItemFinishGoodsRemark" key = "customerPurchaseOrderItemDeliveryItemFinishGoodsRemark" 
                                                title = "IFG Remark" width = "100" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderItemDeliverySortNo" index="customerPurchaseOrderItemDeliverySortNo" title="Sort No" width="80" sortable="true"
                                            />  
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderItemDeliveryQuantity" index="customerPurchaseOrderItemDeliveryQuantity" key="customerPurchaseOrderItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderItemDeliveryDeliveryDate" index="customerPurchaseOrderItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="true" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}" 
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangeCustomerPurchaseOrderItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderItemDeliveryDeliveryDateTemp" index="customerPurchaseOrderItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderItemDeliverySalesQuotationCode" index = "customerPurchaseOrderItemDeliverySalesQuotationCode" key = "customerPurchaseOrderItemDeliverySalesQuotationCode" 
                                                title = "Quotation No" width = "220" edittype="text"
                                            />
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderItemDeliverySalesQuotationRefNo" index = "customerPurchaseOrderItemDeliverySalesQuotationRefNo" key = "customerPurchaseOrderItemDeliverySalesQuotationRefNo" 
                                                title = "Ref No" width = "220" edittype="text"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderItemDelieryAddRow" name="customerPurchaseOrderItemDelieryAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnCustomerPurchaseOrderItemDelieryAdd" button="true"  style="width: 60px">Add</sj:a>
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
                    <sj:a href="#" id="btnCustomerPurchaseOrderSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnCustomerPurchaseOrderCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    