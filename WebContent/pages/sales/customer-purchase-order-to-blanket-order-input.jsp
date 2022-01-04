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
    .ui-dialog-titlebar-close,#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid_pager_center,
    #customerPurchaseOrderToBlanketOrderItemDetailInput_grid_pager_center,#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid_pager_center,
    #customerPurchaseOrderToBlanketOrderPaymentTermInput_grid_pager_center,#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid_pager_center{
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
    
    var customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId=0,customerPurchaseOrderToBlanketOrderSalesQuotation_lastSel = -1;
    var customerPurchaseOrderToBlanketOrderItemDetailLastRowId=0,customerPurchaseOrderToBlanketOrderItemDetail_lastSel = -1;
    var customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId=0,customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel = -1;
    var customerPurchaseOrderToBlanketOrderPaymentTermLastRowId=0,customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel = -1;
    var customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId=0,customerPurchaseOrderToBlanketOrderItemDelivery_lastSel = -1;
    var cpoSalesQuotation_lastSel = -1;
    var 
        txtCustomerPurchaseOrderToBlanketOrderCode = $("#customerPurchaseOrderToBlanketOrder\\.code"),
        dtpCustomerPurchaseOrderToBlanketOrderTransactionDate = $("#customerPurchaseOrderToBlanketOrder\\.transactionDate"),
        txtCustomerPurchaseOrderToBlanketOrderCustomerCode= $("#customerPurchaseOrderToBlanketOrder\\.customer\\.code"),
        txtCustomerPurchaseOrderToBlanketOrderCustomerName= $("#customerPurchaseOrderToBlanketOrder\\.customer\\.name"),
        txtCustomerPurchaseOrderToBlanketOrderEndUserCode= $("#customerPurchaseOrderToBlanketOrder\\.endUser\\.code"),
        txtCustomerPurchaseOrderToBlanketOrderEndUserName= $("#customerPurchaseOrderToBlanketOrder\\.endUser\\.name"),
        txtCustomerPurchaseOrderToBlanketOrderRetention= $("#customerPurchaseOrderToBlanketOrder\\.retentionPercent"),
        txtCustomerPurchaseOrderToBlanketOrderCurrencyCode= $("#customerPurchaseOrderToBlanketOrder\\.currency\\.code"),
        txtCustomerPurchaseOrderToBlanketOrderCurrencyName= $("#customerPurchaseOrderToBlanketOrder\\.currency\\.name"),
        txtCustomerPurchaseOrderToBlanketOrderBranchCode= $("#customerPurchaseOrderToBlanketOrder\\.branch\\.code"),
        txtCustomerPurchaseOrderToBlanketOrderBranchName= $("#customerPurchaseOrderToBlanketOrder\\.branch\\.name"),
        txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode= $("#customerPurchaseOrderToBlanketOrder\\.salesPerson\\.code"),
        txtCustomerPurchaseOrderToBlanketOrderSalesPersonName= $("#customerPurchaseOrderToBlanketOrder\\.salesPerson\\.name"),
        txtCustomerPurchaseOrderToBlanketOrderProjectCode= $("#customerPurchaseOrderToBlanketOrder\\.project\\.code"),
        txtCustomerPurchaseOrderToBlanketOrderProjectName= $("#customerPurchaseOrderToBlanketOrder\\.project\\.name"),
        txtCustomerPurchaseOrderToBlanketOrderRefNo = $("#customerPurchaseOrderToBlanketOrder\\.refNo"),
        txtCustomerPurchaseOrderToBlanketOrderRemark = $("#customerPurchaseOrderToBlanketOrder\\.remark"),
        txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount = $("#customerPurchaseOrderToBlanketOrder\\.totalTransactionAmount"),
        txtCustomerPurchaseOrderToBlanketOrderDiscountPercent = $("#customerPurchaseOrderToBlanketOrder\\.discountPercent"),
        txtCustomerPurchaseOrderToBlanketOrderDiscountAmount = $("#customerPurchaseOrderToBlanketOrder\\.discountAmount"),
        txtCustomerPurchaseOrderToBlanketOrderTotalAdditionalFee= $("#customerPurchaseOrderToBlanketOrder\\.totalAdditionalFeeAmount"),
        txtCustomerPurchaseOrderToBlanketOrderTaxBaseAmount= $("#customerPurchaseOrderToBlanketOrder\\.taxBaseAmount"),
        txtCustomerPurchaseOrderToBlanketOrderVATPercent = $("#customerPurchaseOrderToBlanketOrder\\.vatPercent"),
        txtCustomerPurchaseOrderToBlanketOrderVATAmount = $("#customerPurchaseOrderToBlanketOrder\\.vatAmount"),
        txtCustomerPurchaseOrderToBlanketOrderGrandTotalAmount = $("#customerPurchaseOrderToBlanketOrder\\.grandTotalAmount");

        function loadGridItemCPOBO(){
             //function groupingHeader
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true, 
                    groupHeaders:[
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation', numberOfColumns: 3, titleText: 'Body Const'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation', numberOfColumns: 3, titleText: 'Type Design'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation', numberOfColumns: 3, titleText: 'Seat Design'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation', numberOfColumns: 3, titleText: 'Size'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation', numberOfColumns: 3, titleText: 'Rating'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation', numberOfColumns: 3, titleText: 'Bore'},
                          
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation', numberOfColumns: 3, titleText: 'End Con'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation', numberOfColumns: 3, titleText: 'Body'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailBallQuotation', numberOfColumns: 3, titleText: 'Ball'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation', numberOfColumns: 3, titleText: 'Seat'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation', numberOfColumns: 3, titleText: 'Seat Insert'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailStemQuotation', numberOfColumns: 3, titleText: 'Stem'},
                          
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailSealQuotation', numberOfColumns: 3, titleText: 'Seal'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation', numberOfColumns: 3, titleText: 'Bolt'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation', numberOfColumns: 3, titleText: 'Disc'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation', numberOfColumns: 3, titleText: 'Plates'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation', numberOfColumns: 3, titleText: 'Shaft'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation', numberOfColumns: 3, titleText: 'Spring'},
                          
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation', numberOfColumns: 3, titleText: 'Arm Pin'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation', numberOfColumns: 3, titleText: 'Back Seat'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailArmQuotation', numberOfColumns: 3, titleText: 'Arm'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation', numberOfColumns: 3, titleText: 'Hinge Pin'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation', numberOfColumns: 3, titleText: 'Stop Pin'},
                          {startColumnName: 'customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation', numberOfColumns: 3, titleText: 'Operator'}
                    ]
                });
        }

    $(document).ready(function() {
        flagIsConfirmedCPOBO=false;
        flagIsConfirmedCPOBOSalesQuotation=false;
        flagIsConfirmedCPOBOItemDelivery=false;
        $("#frmCustomerPurchaseOrderToBlanketOrderInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        
       
        
        formatNumericCPOBO();
        $("#msgCustomerPurchaseOrderToBlanketOrderActivity").html(" - <i>" + $("#enumCustomerPurchaseOrderToBlanketOrderActivity").val()+"<i>").show();
        setCustomerPurchaseOrderToBlanketOrderPartialShipmentStatusStatus();
        
        $('input[name="customerPurchaseOrderToBlanketOrderPartialShipmentStatusRad"][value="YES"]').change(function(ev){
            $("#customerPurchaseOrderToBlanketOrder\\.partialShipmentStatus").val("YES");
        });
        
        $('input[name="customerPurchaseOrderToBlanketOrderPartialShipmentStatusRad"][value="NO"]').change(function(ev){
            $("#customerPurchaseOrderToBlanketOrder\\.partialShipmentStatus").val("NO");
        });
        
        $('input[name="customerPurchaseOrderToBlanketOrderOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#customerPurchaseOrderToBlanketOrder\\.orderStatus").val(value);
        });
                
        $('input[name="customerPurchaseOrderToBlanketOrderOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#customerPurchaseOrderToBlanketOrder\\.orderStatus").val(value);
        });
        
        $('#customerPurchaseOrderToBlanketOrderOrderStatusRadBLANKET_ORDER').prop('checked',true);
        $("#customerPurchaseOrderToBlanketOrder\\.orderStatus").val("BLANKET_ORDER");
        
        //Set Default View
        $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "none");
        $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display", "none");
        $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotationDetailSort").css("display", "none");
        $("#btnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "none");
        $("#btnCPOBOSearchSalQuo").css("display", "none");
        $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-payment-item-delivery-cpoBO').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-item-delivery-detail-cpoBO').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmCustomerPurchaseOrderToBlanketOrder").click(function(ev) {
            
            if(!$("#frmCustomerPurchaseOrderToBlanketOrderInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                return;
            }
            
            var date1 = dtpCustomerPurchaseOrderToBlanketOrderTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#customerPurchaseOrderToBlanketOrderTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($('#enumCustomerPurchaseOrderToBlanketOrderActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#customerPurchaseOrderToBlanketOrderTransactionDate").val(),dtpCustomerPurchaseOrderToBlanketOrderTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpCustomerPurchaseOrderToBlanketOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($('#enumCustomerPurchaseOrderToBlanketOrderActivity').val() === 'UPDATE'){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#customerPurchaseOrderToBlanketOrderTransactionDate").val(),dtpCustomerPurchaseOrderToBlanketOrderTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpCustomerPurchaseOrderToBlanketOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(txtCustomerPurchaseOrderToBlanketOrderRetention.val())===0.00){
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
                                        flagIsConfirmedCPOBO=true;
                                        flagIsConfirmedCPOBOSalesQuotation=false;
                                        $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "block");
                                        $("#btnCPOBOSearchSalQuo").css("display", "block");
                                        $("#btnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "none");   
                                        $('#headerCustomerPurchaseOrderToBlanketOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                        $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").show();
                                        $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').unblock();
                                        loadCustomerPurchaseOrderToBlanketOrderSalesQuotation();
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
                flagIsConfirmedCPOBO=true;
                flagIsConfirmedCPOBOSalesQuotation=false;
                $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "block");
                $("#btnCPOBOSearchSalQuo").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "none");   
                $('#headerCustomerPurchaseOrderToBlanketOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").show();
                $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').unblock();
                loadCustomerPurchaseOrderToBlanketOrderSalesQuotation();
            }           
        });
                
        $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){ 
                    $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "none");
                    $("#btnCPOBOSearchSalQuo").css("display", "none");
                    $("#btnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "block");
                    $('#headerCustomerPurchaseOrderToBlanketOrderInput').unblock();
                    $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display","none");
                    flagIsConfirmedCPOBO=false;
                    flagIsConfirmedCPOBOSalesQuotation=false;
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
                                flagIsConfirmedCPOBO=false;
                                $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "none");
                                $("#btnCPOBOSearchSalQuo").css("display", "none");
                                $("#btnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "block");
                                $('#headerCustomerPurchaseOrderToBlanketOrderInput').unblock();
                                $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display","none");
                                clearCustomerPurchaseOrderToBlanketOrderTransactionAmount();
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
        
        $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").click(function(ev) {
            if(flagIsConfirmedCPOBO){
                
                if(customerPurchaseOrderToBlanketOrderSalesQuotation_lastSel !== -1) {
                    $('#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderSalesQuotation_lastSel); 
                }

                var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[i]); 

                    if(data.customerPurchaseOrderToBlanketOrderSalesQuotationCode===""){
                        alertMessage("Sales Quotation Can't Empty!");
                        return;
                    }
                }
            
                $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "none");
                $("#btnCPOBOSearchSalQuo").css("display", "none");
                $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotationDetailSort").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "block");
                $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display", "none");   
                $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-cpoBO').unblock();
                flagIsConfirmedCPOBOSalesQuotation=true;
                
                if($('#enumCustomerPurchaseOrderToBlanketOrderActivity').val() === 'UPDATE'){
                    loadCustomerPurchaseOrderToBlanketOrderItemDetailUpdate();
                }else if(($('#enumCustomerPurchaseOrderToBlanketOrderActivity').val() === 'REVISE')){
                    loadCustomerPurchaseOrderToBlanketOrderItemDetailRevise();
                }else if(($('#enumCustomerPurchaseOrderToBlanketOrderActivity').val() === 'CLONE')){
                    loadCustomerPurchaseOrderToBlanketOrderItemDetailClone();
                }else{
                    loadCustomerPurchaseOrderToBlanketOrderItemDetail();
                }
                
                loadCustomerPurchaseOrderToBlanketOrderAdditionalFee();
                loadCustomerPurchaseOrderToBlanketOrderPaymentTerm();
            }
        });
        
        $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").click(function(ev) {
            $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('destroyGroupHeader');
            $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('clearGridData');
            $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrder").css("display", "block");
            $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotationDetailSort").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display", "block");
            $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery-cpoBO').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedCPOBOSalesQuotation=false;
            clearCustomerPurchaseOrderToBlanketOrderTransactionAmount();
        });
        
        $("#btnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").click(function(ev) {
            if(flagIsConfirmedCPOBO){
                
                if(customerPurchaseOrderToBlanketOrderItemDetail_lastSel !== -1) {
                    $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDetail_lastSel); 
                }
                if(customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel !== -1) {
                    $('#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel); 
                }
                if(customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel !== -1) {
                    $('#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel); 
                }
                
                var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                var idj = jQuery("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
                var idl = jQuery("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
                var idq = jQuery("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                
                for(var j=0; j<idj.length;j++){
                    var data = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',idj[j]);
                    
                    if(data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode === ""){
                        alertMessage("Item Finish Goods Code Must Be Filled!");
                        return;
                    }
                    
                    if(data.customerPurchaseOrderToBlanketOrderItemDetailSortNo===""){
                        alertMessage("Sort No Can't Empty!");
                        return;
                    }
                
                    if(data.customerPurchaseOrderToBlanketOrderItemDetailSortNo=== '0' ){
                        alertMessage("Sort No Can't Zero!");
                        return;
                    }
                
                    for(var i=j; i<=idj.length-1; i++){
                        var details = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',idj[i+1]);
                        if(data.customerPurchaseOrderToBlanketOrderItemDetailSortNo === details.customerPurchaseOrderToBlanketOrderItemDetailSortNo){
                            alertMessage("Sort No Can't Be The Same!");
                            return;
                        }
                    }

                    if(parseFloat(data.customerPurchaseOrderToBlanketOrderItemDetailQuantity)===0.00){
                        alertMessage("Quantity Item Can't be 0!");
                        return;
                    }
                }
                
                for(var l=0; l<idl.length;l++){
                    var data = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('getRowData',idl[l]);
                    
                    if(data.customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode === ""){
                        alertMessage("Additional Fee Must Be Filled!");
                        return;
                    }
                    if(parseFloat(data.customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity === 0.00)){
                        alertMessage("Quantity Must Be Greater Than 0!");
                        return;
                    }
                    if(parseFloat(data.customerPurchaseOrderToBlanketOrderAdditionalFeePrice === 0.00)){
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
                    var data = $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('getRowData',idq[p]); 

                    if(data.customerPurchaseOrderToBlanketOrderPaymentTermSortNO=== '0' ){
                        alertMessage("Payment Term Sort No Can't Zero!");
                        return;
                    }

                    if(data.customerPurchaseOrderToBlanketOrderPaymentTermSortNO === " "){
                        alertMessage("Payment Term Sort No Can't Empty!");
                        return;
                    }

                    if(data.customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermName===""){
                        alertMessage("Payment Term Can't Empty!");
                        return;
                    }

                    if(parseFloat(data.customerPurchaseOrderToBlanketOrderPaymentTermPercent)===0.00){
                        alertMessage("Percent Payment term Can't be 0!");
                        return;
                    }
                    totalPercentagePaymentTerm+=parseFloat(data.customerPurchaseOrderToBlanketOrderPaymentTermPercent);
                }
                if(parseFloat(totalPercentagePaymentTerm.toFixed(2))!==100){
                    alertMessage("Total Percent Payment Term must be 100%, Can't less or greater than 100%!",400);
                    return;
                }
                
                $("#btnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "none");   
                $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "block"); 
                $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotationDetailSort").css("display", "none");
                $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").css("display", "none");
                $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-cpoBO').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-item-delivery-detail-cpoBO').unblock();
                loadCustomerPurchaseOrderToBlanketOrderItemDeliveryDate();
                flagIsConfirmedCPOBOItemDelivery=true;
                
            }
        });
        
        $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").click(function(ev) {
            $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "none");
            $("#btnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery").css("display", "block");
            $("#btnUnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation").show();
            $("#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotationDetailSort").show();
            $('#id-tbl-additional-payment-item-delivery-cpoBO').unblock();
            $('#id-tbl-additional-item-delivery-detail-cpoBO').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedCPOBOItemDelivery=false;
        });
        
        $.subscribe("customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderToBlanketOrderSalesQuotation_lastSel) {

                $('#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderSalesQuotation_lastSel); 
                $('#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderToBlanketOrderSalesQuotation_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderToBlanketOrderItemDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderToBlanketOrderItemDetail_lastSel) {

                $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDetail_lastSel); 
                $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderToBlanketOrderItemDetail_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel) {

                $('#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel); 
                $('#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderToBlanketOrderPaymentTermInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel) {

                $('#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel); 
                $('#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==customerPurchaseOrderToBlanketOrderItemDelivery_lastSel) {

                $('#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDelivery_lastSel); 
                $('#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerPurchaseOrderToBlanketOrderItemDelivery_lastSel=selectedRowID;

            }
            else{
                $('#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });


//        $('#btnCustomerPurchaseOrderToBlanketOrderSalesQuotationAdd').click(function(ev) {
//            
//            if(!flagIsConfirmedCPOBO){
//                return;
//            }
//            
//            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderToBlanketOrderSalesQuotationAddRow").val()));
//
//            for(var i=0; i<AddRowCount; i++){
//                var defRow = {};
//                customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId++;
//                $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId, defRow);
//
//                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
//                $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId,{Buttons:be});
//                ev.preventDefault();
//            } 
//        });
        
        $('#btnCustomerPurchaseOrderToBlanketOrderAdditionalFeeAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderToBlanketOrderAdditionalFeeAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerPurchaseOrderToBlanketOrderAdditionalFeeDelete                : "delete",
                    customerPurchaseOrderToBlanketOrderAdditionalFeeSearchUnitOfMeasure   : "..."
                };
                customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId++;
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderToBlanketOrderPaymentTermAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderToBlanketOrderPaymentTermAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var idp = jQuery("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                var number = idp.length+1;
                var defRow = {
                    customerPurchaseOrderToBlanketOrderPaymentTermDelete                : "delete",
                    customerPurchaseOrderToBlanketOrderPaymentTermSearchPaymentTerm     : "...",
                    customerPurchaseOrderToBlanketOrderPaymentTermSortNO                : number
                };
                customerPurchaseOrderToBlanketOrderPaymentTermLastRowId++;
                $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderPaymentTermLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderPaymentTermLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderToBlanketOrderItemDelieryAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#customerPurchaseOrderToBlanketOrderItemDelieryAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerPurchaseOrderToBlanketOrderItemDeliveryDelete              : "delete",
                    customerPurchaseOrderToBlanketOrderItemDeliverySearchQuotation     : "..."
                };
                customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId++;
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderToBlanketOrderCopyFromDetail').click(function(ev) {
            
            $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(customerPurchaseOrderToBlanketOrderItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDetail_lastSel); 
            }
            
            var ids = jQuery("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    customerPurchaseOrderToBlanketOrderItemDeliveryDelete                 : "delete",
                    customerPurchaseOrderToBlanketOrderItemDeliveryItemCode               : data.customerPurchaseOrderToBlanketOrderItemDetailItem,
                    customerPurchaseOrderToBlanketOrderItemDeliverySortNo                 : data.customerPurchaseOrderToBlanketOrderItemDetailSortNo,
                    customerPurchaseOrderToBlanketOrderItemDeliveryQuantity               : data.customerPurchaseOrderToBlanketOrderItemDetailQuantity,
                    customerPurchaseOrderToBlanketOrderItemDeliverySearchQuotation        : "...",
                    customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode     : data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNo,
                    customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationRefNo    : data.customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo,
                    customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsCode    : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode,   
                    customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsRemark  : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark
                };
                customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId++;
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerPurchaseOrderToBlanketOrderSave').click(function(ev) {
            
            if(!flagIsConfirmedCPOBOSalesQuotation){
                return;
            }
            
            if(customerPurchaseOrderToBlanketOrderItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDetail_lastSel); 
            }
            
            if(customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderAdditionalFee_lastSel); 
            }
            
            if(customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderPaymentTerm_lastSel); 
            }
            
            if(customerPurchaseOrderToBlanketOrderItemDelivery_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDelivery_lastSel); 
            }
            
            var listCustomerPurchaseOrderToBlanketOrderSalesQuotation = new Array(); 
            var listCustomerPurchaseOrderToBlanketOrderItemDetail = new Array(); 
            var listCustomerPurchaseOrderToBlanketOrderAdditionalFee = new Array(); 
            var listCustomerPurchaseOrderToBlanketOrderPaymentTerm = new Array(); 
            var listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate = new Array(); 
            
            var idq = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
            var idi = jQuery("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            var idf = jQuery("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('getDataIDs'); 
            var idp = jQuery("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('getDataIDs'); 
            var idd = jQuery("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs'); 

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
                var data = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getRowData',idq[q]); 
                  
                var customerPurchaseOrderToBlanketOrderSalesQuotation = { 
                    salesQuotation              : {code:data.customerPurchaseOrderToBlanketOrderSalesQuotationCode}
                };
                listCustomerPurchaseOrderToBlanketOrderSalesQuotation[q] = customerPurchaseOrderToBlanketOrderSalesQuotation;
            }
            
            //Item Detail
            for(var i=0;i < idi.length;i++){ 
                var data = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
//                var sortNo = [];
//                sortNo[i] = data.customerPurchaseOrderToBlanketOrderItemDetailSortNo;
                
                if(data.customerPurchaseOrderToBlanketOrderItemDetailSortNo===""){
                    alertMessage("Sort No Can't Empty!");
                    return;
                }
                
                if(data.customerPurchaseOrderToBlanketOrderItemDetailSortNo=== '0' ){
                    alertMessage("Sort No Can't Zero!");
                    return;
                }
                
                for(var j=i; j<=idi.length-1; j++){
                    var details = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',idi[j+1]);
                    if(data.customerPurchaseOrderToBlanketOrderItemDetailSortNo === details.customerPurchaseOrderToBlanketOrderItemDetailSortNo){
                        alertMessage("Sort No Can't Be The Same!");
                        return;
                    }
                }
                
                if(parseFloat(data.customerPurchaseOrderToBlanketOrderItemDetailQuantity)===0.00){
                    alertMessage("Quantity Item Can't be 0!");
                    return;
                }

                var customerPurchaseOrderToBlanketOrderItemDetail = { 
                    salesQuotation                            : {code:data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNo},
                    salesQuotationDetail                      : {code:data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode},
                    itemFinishGoods                           : {code:data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode},
                    quantity                                  : data.customerPurchaseOrderToBlanketOrderItemDetailQuantity,
                    customerPurchaseOrderSortNo               : data.customerPurchaseOrderToBlanketOrderItemDetailSortNo,
                    itemAlias                                 : data.customerPurchaseOrderToBlanketOrderItemDetailItemAlias,
                    valveTag                                  : data.customerPurchaseOrderToBlanketOrderItemDetailValveTag,
                    dataSheet                                 : data.customerPurchaseOrderToBlanketOrderItemDetailDataSheet,
                    description                               : data.customerPurchaseOrderToBlanketOrderItemDetailDescription
                };
                listCustomerPurchaseOrderToBlanketOrderItemDetail[i] = customerPurchaseOrderToBlanketOrderItemDetail;
            }
            
            //Additional Fee
            for(var f=0;f < idf.length;f++){ 
                var data = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('getRowData',idf[f]); 

                if(data.customerPurchaseOrderToBlanketOrderAdditionalFeeRemark===""){
                    alertMessage("Remark Additional Fee Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity)===0.00){
                    alertMessage("Quantity Additional Fee Can't be 0!");
                    return;
                }
                                
                if(data.customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode===""){
                    alertMessage("Unit Additional Fee Can't Empty!");
                    return;
                }
                
                if(parseFloat(data.customerPurchaseOrderToBlanketOrderAdditionalFeePrice)===0.00){
                    alertMessage("Price Additional Fee Can't be 0!");
                    return;
                }
                
                var customerPurchaseOrderToBlanketOrderAdditionalFee = { 
                    remark          : data.customerPurchaseOrderToBlanketOrderAdditionalFeeRemark,
                    unitOfMeasure   : {code:data.customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode},
                    additionalFee   : {code:data.customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode},
                    price           : data.customerPurchaseOrderToBlanketOrderAdditionalFeePrice,
                    quantity        : data.customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity,
                    total           : data.customerPurchaseOrderToBlanketOrderAdditionalFeeTotal
                };
                listCustomerPurchaseOrderToBlanketOrderAdditionalFee[f] = customerPurchaseOrderToBlanketOrderAdditionalFee;
            }
            
            //Payment term
            var totalPercentagePaymentTerm=0;
            for(var p=0;p < idp.length;p++){ 
                var data = $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('getRowData',idp[p]); 
                
                if(data.customerPurchaseOrderToBlanketOrderPaymentTermSortNO=== '0' ){
                    alertMessage("Sort No Payment Term Can't Zero!");
                    return;
                }
                
                if(data.customerPurchaseOrderToBlanketOrderPaymentTermSortNO === " "){
                    alertMessage("Sort No Payment Term Can't Empty!");
                    return;
                }
                
                if(data.customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermName===""){
                    alertMessage("Payment Term Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderToBlanketOrderPaymentTermPercent)===0.00){
                    alertMessage("Percent Payment term Can't be 0!");
                    return;
                }
                
                var customerPurchaseOrderToBlanketOrderPaymentTerm = { 
                    sortNo          : data.customerPurchaseOrderToBlanketOrderPaymentTermSortNO,
                    paymentTerm     : {code:data.customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermCode},
                    percentage      : data.customerPurchaseOrderToBlanketOrderPaymentTermPercent,
                    remark          : data.customerPurchaseOrderToBlanketOrderPaymentTermRemark
                };
                listCustomerPurchaseOrderToBlanketOrderPaymentTerm[p] = customerPurchaseOrderToBlanketOrderPaymentTerm;
                totalPercentagePaymentTerm+=parseFloat(data.customerPurchaseOrderToBlanketOrderPaymentTermPercent);
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
                var data = $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[d]); 
                var deliveryDate = data.customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate.split('/');
                var deliveryDateNew = deliveryDate[1]+"/"+deliveryDate[0]+"/"+deliveryDate[2];
//                if(data.customerPurchaseOrderToBlanketOrderItemDeliveryItemCode===""){
//                    alertMessage("Item Delivery Can't Empty!");
//                    return;
//                }
                
                if(data.customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate===""){
                    alertMessage("Delivery Date Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.customerPurchaseOrderToBlanketOrderItemDeliveryQuantity)===0.00){
                    alertMessage("Quantity Delivery Can't be 0!");
                    return;
                }
                
                if(data.customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode===""){
                    alertMessage("Quotation Date Can't Empty!");
                    return;
                }
                
                var customerPurchaseOrderToBlanketOrderItemDeliveryDate = { 
                    itemFinishGoods     : {code:data.customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsCode},
                    salesQuotation      : {code:data.customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode},
                    quantity            : data.customerPurchaseOrderToBlanketOrderItemDeliveryQuantity,
                    deliveryDate        : deliveryDateNew
                };
                listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[d] = customerPurchaseOrderToBlanketOrderItemDeliveryDate;
            }
            var sumQuantityGroupItem=0;
            
            for(var i=0;i < idi.length;i++){
                var data = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
                sumQuantityGroupItem=0;
                for(var j=0;j < idd.length;j++){
                    var dataDelivery = $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[j]);
                    
                    if(data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNo === dataDelivery.customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode){
                        if(data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode === dataDelivery.customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsCode){
                            if(data.customerPurchaseOrderToBlanketOrderItemDetailSortNo === dataDelivery.customerPurchaseOrderToBlanketOrderItemDeliverySortNo){
                                sumQuantityGroupItem += parseFloat(dataDelivery.customerPurchaseOrderToBlanketOrderItemDeliveryQuantity);
    //                            alert(data.customerPurchaseOrderToBlanketOrderItemDetailQuantity);
                            }
                        }
                    }
                }

                if(parseFloat(data.customerPurchaseOrderToBlanketOrderItemDetailQuantity)!==sumQuantityGroupItem){
                    alertMessage("Sum Of Quantity Item </br> "+data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNo+" Must be Equal with Quantity Item Detail!");
                    return;
                }
                
            }
            
            formatDateCPOBO();
            unFormatNumericCPOBO();
            
            var url = "sales/customer-purchase-order-to-blanket-order-save";
            var params = $("#frmCustomerPurchaseOrderToBlanketOrderInput").serialize();
                params += "&listCustomerPurchaseOrderToBlanketOrderSalesQuotationJSON=" + $.toJSON(listCustomerPurchaseOrderToBlanketOrderSalesQuotation);
                params += "&listCustomerPurchaseOrderToBlanketOrderItemDetailJSON=" + $.toJSON(listCustomerPurchaseOrderToBlanketOrderItemDetail);
                params += "&listCustomerPurchaseOrderToBlanketOrderAdditionalFeeJSON=" + $.toJSON(listCustomerPurchaseOrderToBlanketOrderAdditionalFee);
                params += "&listCustomerPurchaseOrderToBlanketOrderPaymentTermJSON=" + $.toJSON(listCustomerPurchaseOrderToBlanketOrderPaymentTerm);
                params += "&listCustomerPurchaseOrderToBlanketOrderItemDeliveryJSON=" + $.toJSON(listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateCPOBO();
                    formatNumericCPOBO();
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
                                        var params = "enumCustomerPurchaseOrderToBlanketOrderActivity=NEW";
                                        var url = "sales/customer-purchase-order-to-blanket-order-input";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_BLANKET_ORDER");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/customer-purchase-order-to-blanket-order";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_BLANKET_ORDER");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnCustomerPurchaseOrderToBlanketOrderCancel').click(function(ev) {
            var url = "sales/customer-purchase-order-to-blanket-order";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_BLANKET_ORDER"); 
        });
        
        $('#customerPurchaseOrderToBlanketOrder_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=customerPurchaseOrderToBlanketOrder&idsubdoc=branch","Search", "width=600, height=500");
        });

        $('#customerPurchaseOrderToBlanketOrder_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerPurchaseOrderToBlanketOrder&idsubdoc=customer","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrderToBlanketOrder_btnCustomerEndUser').click(function(ev) {
            window.open("./pages/search/search-customer-end-user.jsp?iddoc=customerPurchaseOrderToBlanketOrder&idsubdoc=endUser","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrderToBlanketOrder_btnSalesPerson').click(function(ev) {
            window.open("./pages/search/search-sales-person.jsp?iddoc=customerPurchaseOrderToBlanketOrder&idsubdoc=salesPerson","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerPurchaseOrderToBlanketOrder_btnProject').click(function(ev) {
            window.open("./pages/search/search-project.jsp?iddoc=customerPurchaseOrderToBlanketOrder&idsubdoc=project","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerPurchaseOrderToBlanketOrder_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=customerPurchaseOrderToBlanketOrder&idsubdoc=currency","Search", "width=600, height=500");
        });
        
        $('#customerPurchaseOrderToBlanketOrder_btnDiscountAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerPurchaseOrderToBlanketOrder&idsubdoc=discountAccount","Search", "width=600, height=500");
        });
        
        $('#btnCustomerPurchaseOrderToBlanketOrderDeliveryDateSet').click(function(ev) {
            if(customerPurchaseOrderToBlanketOrderItemDelivery_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDelivery_lastSel); 
            }
            
            var deliveryDate=$("#customerPurchaseOrderToBlanketOrderDeliveryDateSet").val();
            var ids = jQuery("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate",deliveryDate);
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
        
        $('#btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotationDetailSort').click(function(ev) {
             if($("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Sales Quotation Can't Be Empty!");
                return;}
            }
            
            if(customerPurchaseOrderToBlanketOrderItemDetail_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDetail_lastSel);  
            }
            
            var ids = jQuery("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
            var listSalesQuotationDetail = new Array();

            for(var k=0;k<ids.length;k++){
            var data = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[k]);    
            var customerPurchaseOrderToBlanketOrderItemDetail = { 
                    salesQuotation              : {code:data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNo},
                    refNo                       : data.customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo,
                    salesQuotationDetail        : data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode,
                    sort                        : data.customerPurchaseOrderToBlanketOrderItemDetailSortNo,
                    itemFinishGoodsCode         : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode,
                    itemFinishGoodsName         : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsName,
                    itemFinishGoodsRemark       : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark,
                    valveTypeCode               : data.customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode,
                    valveTypeName               : data.customerPurchaseOrderToBlanketOrderItemDetailValveTypeName,
                    valveTag                    : data.customerPurchaseOrderToBlanketOrderItemDetailValveTag,
                    dataSheet                   : data.customerPurchaseOrderToBlanketOrderItemDetailDataSheet,
                    dataDescription             : data.customerPurchaseOrderToBlanketOrderItemDetailDescription,
                    itemAlias                   : data.customerPurchaseOrderToBlanketOrderItemDetailItemAlias,
                    
                    //01
                    bodyConstQuo                : data.customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation,
                    bodyConstFinishGoodCode     : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstCode,
                    bodyConstFinishGoodName     : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstName,
                    //02
                    typeDesignQuo               : data.customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation,
                    typeDesignFinishGoodCode    : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignCode,
                    typeDesignFinishGoodName    : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignName,
                    //03
                    seatDesignQuo               : data.customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation,
                    seatDesignFinishGoodCode    : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignCode,
                    seatDesignFinishGoodName    : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignName,
                    //04
                    sizeQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation,
                    sizeFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeCode,
                    sizeFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeName,
                    //05
                    ratingQuo                   : data.customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation,
                    ratingFinishGoodCode        : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingCode,
                    ratingFinishGoodName        : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingName,
                    //06
                    boreQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation,
                    boreFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreCode,
                    boreFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreName,
                    
                    //07
                    endConQuo                   : data.customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation,
                    endConFinishGoodCode        : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConCode,
                    endConFinishGoodName        : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConName,
                    
                    //08
                    bodyQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation,
                    bodyFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyCode,
                    bodyFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyName,
                    
                    //09
                    ballQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailBallQuotation,
                    ballFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallCode,
                    ballFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallName,
                    
                    //10
                    seatQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation,
                    seatFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatCode,
                    seatFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatName,
                    
                    //11
                    seatInsertQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation,
                    seatInsertFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertCode,
                    seatInsertFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertName,
                    
                    //12
                    stemQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailStemQuotation,
                    stemFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemCode,
                    stemFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemName,
                    
                    //13
                    sealQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailSealQuotation,
                    sealFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealCode,
                    sealFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealName,
                    
                    //14
                    boltQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation,
                    boltFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltCode,
                    boltFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltName,
                    
                    //15
                    discQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation,
                    discFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscCode,
                    discFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscName,
                    
                    //16
                    platesQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation,
                    platesFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesCode,
                    platesFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesName,
                    
                    //17
                    shaftQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation,
                    shaftFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftCode,
                    shaftFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftName,
                    
                    //18
                    springQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation,
                    springFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringCode,
                    springFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringName,
                    
                    //19
                    armPinQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation,
                    armPinFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinCode,
                    armPinFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinName,
                    
                    //20
                    backSeatQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation,
                    backSeatFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatCode,
                    backSeatFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatName,
                    
                    //21
                    armQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailArmQuotation,
                    armFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmCode,
                    armFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmName,
                    
                    //22
                    hingePinQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation,
                    hingePinFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinCode,
                    hingePinFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinName,
                    
                    //23
                    stopPinQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation,
                    stopPinFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinCode,
                    stopPinFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinName,
                    
                    //24
                    operatorQuo                     : data.customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation,
                    operatorFinishGoodCode          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorCode,
                    operatorFinishGoodName          : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorName,
                    
                    note                        : data.customerPurchaseOrderToBlanketOrderItemDetailNote,
                    price                       : data.customerPurchaseOrderToBlanketOrderItemDetailPrice,
                    total                       : data.customerPurchaseOrderToBlanketOrderItemDetailTotal,
                    quantity                    : data.customerPurchaseOrderToBlanketOrderItemDetailQuantity
                    
                };
                listSalesQuotationDetail[k] = customerPurchaseOrderToBlanketOrderItemDetail;
            }
            
             var result = Enumerable.From(listSalesQuotationDetail)
                            .OrderBy('$.sort')
                            .Select()
                            .ToArray();
            
            $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('clearGridData');
            customerPurchaseOrderToBlanketOrderItemDetail_lastSel = 0;
                for(var i = 0; i < result.length; i++){
                    customerPurchaseOrderToBlanketOrderItemDetail_lastSel ++;
                    $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("addRowData",customerPurchaseOrderToBlanketOrderItemDetail_lastSel, result[i]);
                    $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDetail_lastSel,{
                        
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNo                      : result[i].salesQuotation.code,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo                   : result[i].refNo,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode            : result[i].salesQuotationDetail,
                    customerPurchaseOrderToBlanketOrderItemDetailSortNo                           : result[i].sort,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode              : result[i].itemFinishGoodsCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsName              : result[i].itemFinishGoodsName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark            : result[i].itemFinishGoodsRemark,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode                    : result[i].valveTypeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeName                    : result[i].valveTypeName,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTag                         : result[i].valveTag,
                    customerPurchaseOrderToBlanketOrderItemDetailDataSheet                        : result[i].dataSheet,
                    customerPurchaseOrderToBlanketOrderItemDetailDescription                      : result[i].dataDescription,
                    customerPurchaseOrderToBlanketOrderItemDetailItemAlias                        : result[i].itemAlias,
                    //01
                    customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation               : result[i].bodyConstQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstCode     : result[i].bodyConstFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstName     : result[i].bodyConstFinishGoodName,
                    //02
                    customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation               : result[i].typeDesignQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignCode     : result[i].typeDesignFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignName     : result[i].typeDesignFinishGoodName,
                    //03
                    customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation               : result[i].seatDesignQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignCode     : result[i].seatDesignFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignName     : result[i].seatDesignFinishGoodName,
                    //04
                    customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation               : result[i].sizeQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeCode     : result[i].sizeFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeName     : result[i].sizeFinishGoodName,
                    //05
                    customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation               : result[i].ratingQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingCode     : result[i].ratingFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingName     : result[i].ratingFinishGoodName,
                    //06
                    customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation               : result[i].boreQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreCode     : result[i].boreFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreName     : result[i].boreFinishGoodName,
                    //07
                    customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation               : result[i].endConQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConCode     : result[i].endConFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConName     : result[i].endConFinishGoodName,
                    //08
                    customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation               : result[i].bodyQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyCode     : result[i].bodyFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyName     : result[i].bodyFinishGoodName,
                    //09
                    customerPurchaseOrderToBlanketOrderItemDetailBallQuotation               : result[i].ballQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallCode     : result[i].ballFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallName     : result[i].ballFinishGoodName,
                    //10
                    customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation               : result[i].seatQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatCode     : result[i].seatFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatName     : result[i].seatFinishGoodName,
                    //11
                    customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation               : result[i].seatInsertQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertCode     : result[i].seatInsertFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertName     : result[i].seatInsertFinishGoodName,
                    //12
                    customerPurchaseOrderToBlanketOrderItemDetailStemQuotation               : result[i].stemQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemCode     : result[i].stemFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemName     : result[i].stemFinishGoodName,
                    //13
                    customerPurchaseOrderToBlanketOrderItemDetailSealQuotation               : result[i].sealQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealCode     : result[i].sealFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealName     : result[i].sealFinishGoodName,
                    //14
                    customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation               : result[i].boltQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltCode     : result[i].boltFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltName     : result[i].boltFinishGoodName,
                    //15
                    customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation               : result[i].discQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscCode     : result[i].discFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscName     : result[i].discFinishGoodName,
                    //16
                    customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation               : result[i].platesQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesCode     : result[i].platesFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesName     : result[i].platesFinishGoodName,
                    //17
                    customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation               : result[i].shaftQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftCode     : result[i].shaftFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftName     : result[i].shaftFinishGoodName,
                    //18
                    customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation               : result[i].springQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringCode     : result[i].springFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringName     : result[i].springFinishGoodName,
                    //19
                    customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation               : result[i].armPinQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinCode     : result[i].armPinFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinName     : result[i].armPinFinishGoodName,
                    //20
                    customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation               : result[i].backSeatQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatCode     : result[i].backSeatFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatName     : result[i].backSeatFinishGoodName,
                    //21
                    customerPurchaseOrderToBlanketOrderItemDetailArmQuotation               : result[i].armQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmCode     : result[i].armFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmName     : result[i].armFinishGoodName,
                    //22
                    customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation               : result[i].hingePinQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinCode     : result[i].hingePinFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinName     : result[i].hingePinFinishGoodName,
                    //23
                    customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation               : result[i].stopPinQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinCode     : result[i].stopPinFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinName     : result[i].stopPinFinishGoodName,
                    //24
                    customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation               : result[i].operatorQuo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorCode     : result[i].operatorFinishGoodCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorName     : result[i].operatorFinishGoodName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailNote                        : result[i].note,
                    customerPurchaseOrderToBlanketOrderItemDetailPrice                       : result[i].price,
                    customerPurchaseOrderToBlanketOrderItemDetailTotal                       : result[i].total,
                    customerPurchaseOrderToBlanketOrderItemDetailQuantity                    : result[i].quantity
               });    
            }
        }); 
        
        $('#btnCPOBOSearchSalQuo').click(function(ev) {
            var ids = jQuery("#customerPurchaseOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
            var customer=txtCustomerPurchaseOrderToBlanketOrderCustomerCode.val();
            var customerName=txtCustomerPurchaseOrderToBlanketOrderCustomerName.val();
            var endUser=txtCustomerPurchaseOrderToBlanketOrderEndUserCode.val();
            var endUserName=txtCustomerPurchaseOrderToBlanketOrderEndUserName.val();
            var salesPerson=txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode.val();
            var salesPersonName=txtCustomerPurchaseOrderToBlanketOrderSalesPersonName.val();
            var project=txtCustomerPurchaseOrderToBlanketOrderProjectCode.val();
            var projectName=txtCustomerPurchaseOrderToBlanketOrderProjectName.val();
            var currency=txtCustomerPurchaseOrderToBlanketOrderCurrencyCode.val();
            var currencyName=txtCustomerPurchaseOrderToBlanketOrderCurrencyName.val();
            var branch = txtCustomerPurchaseOrderToBlanketOrderBranchCode.val();
            var branchName = txtCustomerPurchaseOrderToBlanketOrderBranchName.val();
            var orderStatus = $("#customerPurchaseOrderToBlanketOrder\\.orderStatus").val();
            window.open("./pages/search/search-sales-quotation-multiple.jsp?iddoc=customerPurchaseOrderToBlanketOrderSalesQuotation&type=grid&rowLast="+ids.length+
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
            "&firstDate="+$("#customerPurchaseOrderToBlanketOrderDateFirstSession").val()+"&lastDate="+$("#customerPurchaseOrderToBlanketOrderDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
        });
        
    }); //EOF Ready
    
    function addRowDataMultiSelectedCPOBO(lastRowId,defRow){
        
        var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
            $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('setRowData',lastRowId,{
                    customerPurchaseOrderToBlanketOrderSalesQuotationDelete              : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationDelete,
                    customerPurchaseOrderToBlanketOrderSalesQuotationCode                : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationTransactionDate     : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationTransactionDate,
                    customerPurchaseOrderToBlanketOrderSalesQuotationCustomerCode        : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationCustomerCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationCustomerName        : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationCustomerName,
                    customerPurchaseOrderToBlanketOrderSalesQuotationEndUserCode         : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationEndUserCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationEndUserName         : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationEndUserName,
                    customerPurchaseOrderToBlanketOrderSalesQuotationRfqCode             : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationRfqCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationProjectCode         : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationProjectCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationSubject             : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationSubject,
                    customerPurchaseOrderToBlanketOrderSalesQuotationAttn                : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationAttn,
                    customerPurchaseOrderToBlanketOrderSalesQuotationRefNo               : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationRefNo,
                    customerPurchaseOrderToBlanketOrderSalesQuotationRemark              : defRow.customerPurchaseOrderToBlanketOrderSalesQuotationRemark
            });
            
        setHeightGridCPOBOSalQuoDetail();
 }
    
    // function Grid Detail
    function setHeightGridCPOBOSalQuoDetail(){
        var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid"+" tr").eq(1).height();
            $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateCPOBO(){
        var transactionDateSplit=dtpCustomerPurchaseOrderToBlanketOrderTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpCustomerPurchaseOrderToBlanketOrderTransactionDate.val(transactionDate);
        
        var createdDate=$("#customerPurchaseOrderToBlanketOrder\\.createdDate").val();
        $("#customerPurchaseOrderToBlanketOrder\\.createdDateTemp").val(createdDate);
    }

    function unFormatNumericCPOBO(){
        var retention =removeCommas(txtCustomerPurchaseOrderToBlanketOrderRetention.val());
        txtCustomerPurchaseOrderToBlanketOrderRetention.val(retention);
        
        var totalTransactionAmount =removeCommas(txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtCustomerPurchaseOrderToBlanketOrderDiscountAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderDiscountAmount.val(discountAmount);
        var taxBaseAmount =removeCommas(txtCustomerPurchaseOrderToBlanketOrderTaxBaseAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderTaxBaseAmount.val(taxBaseAmount);
        var vatPercent =removeCommas(txtCustomerPurchaseOrderToBlanketOrderVATPercent.val());
        txtCustomerPurchaseOrderToBlanketOrderVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtCustomerPurchaseOrderToBlanketOrderVATAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtCustomerPurchaseOrderToBlanketOrderGrandTotalAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericCPOBO(){
        
        var retention =parseFloat(txtCustomerPurchaseOrderToBlanketOrderRetention.val());
        txtCustomerPurchaseOrderToBlanketOrderRetention.val(formatNumber(retention,2));
        
        var totalTransactionAmount =parseFloat(txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtCustomerPurchaseOrderToBlanketOrderDiscountPercent.val());
        txtCustomerPurchaseOrderToBlanketOrderDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtCustomerPurchaseOrderToBlanketOrderDiscountAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderDiscountAmount.val(formatNumber(discountAmount,2));
        var taxBaseAmount =parseFloat(txtCustomerPurchaseOrderToBlanketOrderTaxBaseAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderTaxBaseAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtCustomerPurchaseOrderToBlanketOrderVATPercent.val());
        txtCustomerPurchaseOrderToBlanketOrderVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtCustomerPurchaseOrderToBlanketOrderVATAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtCustomerPurchaseOrderToBlanketOrderGrandTotalAmount.val());
        txtCustomerPurchaseOrderToBlanketOrderGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }    
    
    function clearCustomerPurchaseOrderToBlanketOrderTransactionAmount(){
        txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val("0.00");        
        txtCustomerPurchaseOrderToBlanketOrderDiscountPercent.val("0.00");
        txtCustomerPurchaseOrderToBlanketOrderDiscountAmount.val("0.00");
        txtCustomerPurchaseOrderToBlanketOrderTotalAdditionalFee.val("0.00");
        txtCustomerPurchaseOrderToBlanketOrderTaxBaseAmount.val("0.00");
        txtCustomerPurchaseOrderToBlanketOrderVATPercent.val("0.00");
        txtCustomerPurchaseOrderToBlanketOrderVATAmount.val("0.00");
        txtCustomerPurchaseOrderToBlanketOrderGrandTotalAmount.val("0.00");
    }
    
    function calculateItemSalesQuotationDetailCPOBO(){

        var selectedRowID = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerPurchaseOrderToBlanketOrderItemDetailLastRowId;
        }
        var qty = $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderItemDetailQuantity").val();
        var unitPrice = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData', selectedRowID);
        var amount = unitPrice.customerPurchaseOrderToBlanketOrderItemDetailPrice;

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("setCell", selectedRowID, "customerPurchaseOrderToBlanketOrderItemDetailTotal", subAmount);

        calculateCustomerPurchaseOrderToBlanketOrderHeader();
    }
    
    function calculateCustomerPurchaseOrderToBlanketOrderAdditionalFee() {
        var selectedRowID = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var qty = $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeePrice").val();
        
        var subTotal = (parseFloat(qty) * parseFloat(price));
        
        $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "customerPurchaseOrderToBlanketOrderAdditionalFeeTotal", subTotal);

        calculateCustomerPurchaseOrderToBlanketOrderTotalAdditional();
    }
    
    function calculateCustomerPurchaseOrderToBlanketOrderTotalAdditional() {
        var totalAmount =0;
        var ids = jQuery("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.customerPurchaseOrderToBlanketOrderAdditionalFeeTotal);
        }   
        
        txtCustomerPurchaseOrderToBlanketOrderTotalAdditionalFee.val(formatNumber(totalAmount,2));
        calculateCustomerPurchaseOrderToBlanketOrderHeader();

    }
    
    function calculateCustomerPurchaseOrderToBlanketOrderHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var additionalFeeAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.customerPurchaseOrderToBlanketOrderItemDetailTotal);
        }   
        txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtCustomerPurchaseOrderToBlanketOrderDiscountPercent.val()));        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtCustomerPurchaseOrderToBlanketOrderDiscountAmount.val()===""){
            discAmount=0;
        }
        
        additionalFeeAmount=parseFloat(removeCommas(txtCustomerPurchaseOrderToBlanketOrderTotalAdditionalFee.val()));  
        
        subTotal = (totalTransaction-discAmount)+additionalFeeAmount;
        
        if(txtCustomerPurchaseOrderToBlanketOrderVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtCustomerPurchaseOrderToBlanketOrderVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtCustomerPurchaseOrderToBlanketOrderDiscountAmount.val(formatNumber(discAmount,2));
        txtCustomerPurchaseOrderToBlanketOrderTaxBaseAmount.val(formatNumber(subTotal,2));
        txtCustomerPurchaseOrderToBlanketOrderVATAmount.val(formatNumber(vatAmount,2));        
        txtCustomerPurchaseOrderToBlanketOrderGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onchangeAdditionalFeeUnitOfMeasureCodeCPOBO(){
        var selectedRowID = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var uomCode = $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + uomCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode").val("");
                alert("UOM Not Found","");
            }
        });
            
    }
    
    function onchangeAdditionalFeeCode(){
        var selectedRowID = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var additionalFeeCode = $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode").val();

        var url = "master/additional-fee-get-sales";
        var params = "additionalFee.code=" + additionalFeeCode;
            params+= "&additionalFee.activeStatus=TRUE";
            params+= "&additionalFee.salesStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.additionalFeeTemp){
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode",data.additionalFeeTemp.code);
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeName",data.additionalFeeTemp.name);
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountCode",data.additionalFeeTemp.salesChartOfAccountCode);
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountName",data.additionalFeeTemp.salesChartOfAccountName);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeName").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountName").val("");
                alert("Additional Fee Not Found","");
            }
        });
            
    }
    
    function onchangePaymentTermPaymentTermCode(){
        var selectedRowID = $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");
        var paymentTermCode = $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermCode").val();

        var url = "master/payment-term-get";
        var params = "paymentTerm.code=" + paymentTermCode;
            params+= "&paymentTerm.activeStatus=TRUE";
        $.post(url, params, function(result){
            var data = (result);
            if (data.paymentTermTemp){
                $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermCode",data.paymentTermTemp.code);
                $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermName",data.paymentTermTemp.name);
            }
            else{
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermCode").val("");
                $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermName").val("");
                alert("Payment Term Not Found","");
            }
        });
            
    }
    
    function customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function customerPurchaseOrderToBlanketOrderItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
        
        calculateCustomerPurchaseOrderToBlanketOrderHeader();
    }
    
    function customerPurchaseOrderToBlanketOrderAdditionalFeeInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('delRowData',selectDetailRowId);    
        calculateCustomerPurchaseOrderToBlanketOrderTotalAdditional();
    }
    
    function customerPurchaseOrderToBlanketOrderPaymentTermInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function customerPurchaseOrderToBlanketOrderItemDeliveryInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    
    function onchangeCustomerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate").val();
        
        $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    
    function loadCustomerPurchaseOrderToBlanketOrderSalesQuotation() {
        var enumCustomerPurchaseOrderToBlanketOrderActivity=$("#enumCustomerPurchaseOrderToBlanketOrderActivity").val();
        if(enumCustomerPurchaseOrderToBlanketOrderActivity==="NEW"){
            return;
        }                
        
        var url = "sales/customer-purchase-order-to-blanket-order-sales-quotation-data";
        var params = "customerPurchaseOrderToBlanketOrder.code="+$("#customerPurchaseOrderToBlanketOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation.length; i++) {
                customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId, data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i]);
                $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderSalesQuotationLastRowId,{
                    customerPurchaseOrderToBlanketOrderSalesQuotationDelete           : "delete",
                    customerPurchaseOrderToBlanketOrderSalesQuotationSearch           : "...",
                    customerPurchaseOrderToBlanketOrderSalesQuotationCode             : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationTransactionDate  : formatDateRemoveT(data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationTransactionDate,true),
                    customerPurchaseOrderToBlanketOrderSalesQuotationCustomerCode     : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationCustomerCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationCustomerName     : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationCustomerName,
                    customerPurchaseOrderToBlanketOrderSalesQuotationEndUserCode      : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationEndUserCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationEndUserName      : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationEndUserName,
                    customerPurchaseOrderToBlanketOrderSalesQuotationRfqCode          : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationRfqCode,
                    customerPurchaseOrderToBlanketOrderSalesQuotationProjectCode      : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationProject,
                    customerPurchaseOrderToBlanketOrderSalesQuotationSubject          : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationSubject,
                    customerPurchaseOrderToBlanketOrderSalesQuotationAttn             : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationAttn,
                    customerPurchaseOrderToBlanketOrderSalesQuotationRefNo            : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationRefNo,
                    customerPurchaseOrderToBlanketOrderSalesQuotationRemark           : data.listCustomerPurchaseOrderToBlanketOrderSalesQuotation[i].salesQuotationRemark
                });
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderToBlanketOrderItemDetail() {
        loadGridItemCPOBO();
        var arrSalesQuotationNo=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNo.push(data.customerPurchaseOrderToBlanketOrderSalesQuotationCode);
        }
        
        var url = "sales/sales-quotation-detail-getgroupby-sales-quotation-data";
        var params = "arrSalesQuotationNo="+arrSalesQuotationNo;   
        customerPurchaseOrderToBlanketOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listSalesQuotationDetailTemp.length; i++) {
                customerPurchaseOrderToBlanketOrderItemDetailLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderItemDetailLastRowId, data.listSalesQuotationDetailTemp[i]);
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDetailLastRowId,{
                    customerPurchaseOrderToBlanketOrderItemDetailDelete               : "delete",
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode: data.listSalesQuotationDetailTemp[i].code,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNo          : data.listSalesQuotationDetailTemp[i].headerCode,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo       : data.listSalesQuotationDetailTemp[i].refNo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode  : data.listSalesQuotationDetailTemp[i].itemFinishGoodsCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsName  : data.listSalesQuotationDetailTemp[i].itemFinishGoodsName,
                    customerPurchaseOrderToBlanketOrderItemDetailSortNo               : data.listSalesQuotationDetailTemp[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode        : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeName        : data.listSalesQuotationDetailTemp[i].valveTypeName,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTag             : data.listSalesQuotationDetailTemp[i].valveTag,
                    customerPurchaseOrderToBlanketOrderItemDetailDataSheet            : data.listSalesQuotationDetailTemp[i].dataSheet,
                    customerPurchaseOrderToBlanketOrderItemDetailDescription          : data.listSalesQuotationDetailTemp[i].description,
                    customerPurchaseOrderToBlanketOrderItemDetailQuantity             : data.listSalesQuotationDetailTemp[i].quantity,
                    customerPurchaseOrderToBlanketOrderItemDetailPrice                : data.listSalesQuotationDetailTemp[i].unitPrice,
                    customerPurchaseOrderToBlanketOrderItemDetailTotal                : data.listSalesQuotationDetailTemp[i].total,
                    
                    // 24 valve Type Component
                    customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation   : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                    customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation  : data.listSalesQuotationDetailTemp[i].typeDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation  : data.listSalesQuotationDetailTemp[i].seatDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation        : data.listSalesQuotationDetailTemp[i].size,
                    customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation      : data.listSalesQuotationDetailTemp[i].rating,
                    customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation        : data.listSalesQuotationDetailTemp[i].bore,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation      : data.listSalesQuotationDetailTemp[i].endCon,
                    customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation        : data.listSalesQuotationDetailTemp[i].body,
                    customerPurchaseOrderToBlanketOrderItemDetailBallQuotation        : data.listSalesQuotationDetailTemp[i].ball,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation        : data.listSalesQuotationDetailTemp[i].seat,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation  : data.listSalesQuotationDetailTemp[i].seatInsert,
                    customerPurchaseOrderToBlanketOrderItemDetailStemQuotation        : data.listSalesQuotationDetailTemp[i].stem,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailSealQuotation        : data.listSalesQuotationDetailTemp[i].seal,
                    customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation        : data.listSalesQuotationDetailTemp[i].bolt,
                    customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation        : data.listSalesQuotationDetailTemp[i].disc,
                    customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation      : data.listSalesQuotationDetailTemp[i].plates,
                    customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation       : data.listSalesQuotationDetailTemp[i].shaft,
                    customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation      : data.listSalesQuotationDetailTemp[i].spring,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation      : data.listSalesQuotationDetailTemp[i].armPin,
                    customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation    : data.listSalesQuotationDetailTemp[i].backseat,
                    customerPurchaseOrderToBlanketOrderItemDetailArmQuotation         : data.listSalesQuotationDetailTemp[i].arm,
                    customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation    : data.listSalesQuotationDetailTemp[i].hingePin,
                    customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation     : data.listSalesQuotationDetailTemp[i].stopPin,
                    customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation    : data.listSalesQuotationDetailTemp[i].oper,
                    //
                    customerPurchaseOrderToBlanketOrderItemDetailNote                 : data.listSalesQuotationDetailTemp[i].note
                });
                totalTransaction+=parseFloat(data.listSalesQuotationDetailTemp[i].total.toFixed(2));
                txtCustomerPurchaseOrderToBlanketOrderTotalTransactionAmount.val(formatNumber(totalTransaction,2));
                calculateCustomerPurchaseOrderToBlanketOrderHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderToBlanketOrderItemDetailUpdate() {
        loadGridItemCPOBO();
        var arrSalesQuotationNoTemp=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNoTemp.push(data.customerPurchaseOrderToBlanketOrderSalesQuotationCode);
        }
        
        var url = "sales/customer-purchase-order-to-blanket-order-item-detail-data-array-data-lastest";
        var params = "arrSalesQuotationCode="+arrSalesQuotationNoTemp;
            params += "&customerPurchaseOrderToBlanketOrder.code="+$("#customerPurchaseOrderToBlanketOrder\\.customerPurchaseOrderCode").val();
        customerPurchaseOrderToBlanketOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderToBlanketOrderItemDetail.length; i++) {
                customerPurchaseOrderToBlanketOrderItemDetailLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderItemDetailLastRowId, data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i]);
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDetailLastRowId,{
                    customerPurchaseOrderToBlanketOrderItemDetailDelete                   : "delete",
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].salesQuotationDetailCode,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNo              : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].salesQuotationCode,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].refNo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemFinishGoodsCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemFinishGoodsRemark,
                    customerPurchaseOrderToBlanketOrderItemDetailSortNo                   : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode            : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTypeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeName            : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTypeName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemAlias                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemAlias,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTag                 : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTag,
                    customerPurchaseOrderToBlanketOrderItemDetailDataSheet                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].dataSheet,
                    customerPurchaseOrderToBlanketOrderItemDetailDescription              : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].description,
                    
                    
                    // 24 valve Type Component Quotation
                    customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation   : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bodyConstruction,
                    customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].typeDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seatDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].size,
                    customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].rating,
                    customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bore,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].endCon,
                    customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].body,
                    customerPurchaseOrderToBlanketOrderItemDetailBallQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].ball,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seat,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seatInsert,
                    customerPurchaseOrderToBlanketOrderItemDetailStemQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].stem,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailSealQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seal,
                    customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bolting,
                    customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].disc,
                    customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].plates,
                    customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].shaft,
                    customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].spring,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].armPin,
                    customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].backSeat,
                    customerPurchaseOrderToBlanketOrderItemDetailArmQuotation         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].arm,
                    customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].hingePin,
                    customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].stopPin,
                    customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyConstructionCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstName     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyConstructionName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemTypeDesignCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemTypeDesignName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatDesignCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatDesignName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSizeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSizeName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemRatingCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemRatingName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoreCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoreName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemEndConCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemEndConName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBallCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBallName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatInsertCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatInsertName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStemCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStemName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSealCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSealName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoltCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoltName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemDiscCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemDiscName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemPlatesCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemPlatesName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftCode         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemShaftCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftName         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemShaftName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSpringCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSpringName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmPinCode, 
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmPinName, 
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBackSeatCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBackSeatName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmCode           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmName           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemHingePinCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemHingePinName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinCode       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStopPinCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinName       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStopPinName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemOperatorCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemOperatorName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailNote                 : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].note,
                    customerPurchaseOrderToBlanketOrderItemDetailQuantity             : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].quantity,
                    customerPurchaseOrderToBlanketOrderItemDetailPrice                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].unitPrice,
                    customerPurchaseOrderToBlanketOrderItemDetailTotal                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].totalAmount
                });
                calculateCustomerPurchaseOrderToBlanketOrderHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderToBlanketOrderItemDetailRevise() {
        loadGridItemCPOBO();
        var arrSalesQuotationNoTemp=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNoTemp.push(data.customerPurchaseOrderToBlanketOrderSalesQuotationCode);
        }
        
        var url = "sales/customer-purchase-order-to-blanket-order-item-detail-data-array-data-lastest";
        var params = "arrSalesQuotationCode="+arrSalesQuotationNoTemp;
            params += "&customerPurchaseOrderToBlanketOrder.code="+$("#customerPurchaseOrderToBlanketOrder\\.customerPurchaseOrderCode").val();
        customerPurchaseOrderToBlanketOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderToBlanketOrderItemDetail.length; i++) {
                customerPurchaseOrderToBlanketOrderItemDetailLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderItemDetailLastRowId, data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i]);
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDetailLastRowId,{
                    customerPurchaseOrderToBlanketOrderItemDetailDelete                   : "delete",
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].salesQuotationDetailCode,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNo              : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].salesQuotationCode,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].refNo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemFinishGoodsCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemFinishGoodsRemark,
                    customerPurchaseOrderToBlanketOrderItemDetailSortNo                   : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode            : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTypeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeName            : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTypeName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemAlias                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemAlias,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTag                 : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTag,
                    customerPurchaseOrderToBlanketOrderItemDetailDataSheet                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].dataSheet,
                    customerPurchaseOrderToBlanketOrderItemDetailDescription              : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].description,
                    
                    
                    // 24 valve Type Component Quotation
                    customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation   : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bodyConstruction,
                    customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].typeDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seatDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].size,
                    customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].rating,
                    customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bore,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].endCon,
                    customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].body,
                    customerPurchaseOrderToBlanketOrderItemDetailBallQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].ball,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seat,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seatInsert,
                    customerPurchaseOrderToBlanketOrderItemDetailStemQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].stem,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailSealQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seal,
                    customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bolting,
                    customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].disc,
                    customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].plates,
                    customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].shaft,
                    customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].spring,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].armPin,
                    customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].backSeat,
                    customerPurchaseOrderToBlanketOrderItemDetailArmQuotation         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].arm,
                    customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].hingePin,
                    customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].stopPin,
                    customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyConstructionCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstName     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyConstructionName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemTypeDesignCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemTypeDesignName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatDesignCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatDesignName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSizeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSizeName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemRatingCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemRatingName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoreCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoreName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemEndConCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemEndConName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBallCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBallName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatInsertCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatInsertName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStemCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStemName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSealCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSealName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoltCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoltName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemDiscCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemDiscName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemPlatesCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemPlatesName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftCode         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemShaftCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftName         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemShaftName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSpringCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSpringName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmPinCode, 
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmPinName, 
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBackSeatCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBackSeatName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmCode           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmName           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemHingePinCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemHingePinName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinCode       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStopPinCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinName       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStopPinName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemOperatorCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemOperatorName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailNote                 : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].note,
                    customerPurchaseOrderToBlanketOrderItemDetailQuantity             : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].quantity,
                    customerPurchaseOrderToBlanketOrderItemDetailPrice                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].unitPrice,
                    customerPurchaseOrderToBlanketOrderItemDetailTotal                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].totalAmount
                });
                calculateCustomerPurchaseOrderToBlanketOrderHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderToBlanketOrderItemDetailClone() {
         loadGridItemCPOBO();
        var arrSalesQuotationNoTemp=new Array();
        var totalTransaction=0;
        var ids = jQuery("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNoTemp.push(data.customerPurchaseOrderToBlanketOrderSalesQuotationCode);
        }
        
        var url = "sales/customer-purchase-order-to-blanket-order-item-detail-data-array-data-lastest";
        var params = "arrSalesQuotationCode="+arrSalesQuotationNoTemp;
            params += "&customerPurchaseOrderToBlanketOrder.code="+$("#customerPurchaseOrderToBlanketOrder\\.customerPurchaseOrderCode").val();
        customerPurchaseOrderToBlanketOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderToBlanketOrderItemDetail.length; i++) {
                customerPurchaseOrderToBlanketOrderItemDetailLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderItemDetailLastRowId, data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i]);
                $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDetailLastRowId,{
                    customerPurchaseOrderToBlanketOrderItemDetailDelete                   : "delete",
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].salesQuotationDetailCode,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationNo              : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].salesQuotationCode,
                    customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].refNo,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemFinishGoodsCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemFinishGoodsRemark,
                    customerPurchaseOrderToBlanketOrderItemDetailSortNo                   : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode            : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTypeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTypeName            : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTypeName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemAlias                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemAlias,
                    customerPurchaseOrderToBlanketOrderItemDetailValveTag                 : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].valveTag,
                    customerPurchaseOrderToBlanketOrderItemDetailDataSheet                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].dataSheet,
                    customerPurchaseOrderToBlanketOrderItemDetailDescription              : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].description,
                    
                    
                    // 24 valve Type Component Quotation
                    customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation   : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bodyConstruction,
                    customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].typeDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seatDesign,
                    customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].size,
                    customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].rating,
                    customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bore,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].endCon,
                    customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].body,
                    customerPurchaseOrderToBlanketOrderItemDetailBallQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].ball,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seat,
                    customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation  : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seatInsert,
                    customerPurchaseOrderToBlanketOrderItemDetailStemQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].stem,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailSealQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].seal,
                    customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].bolting,
                    customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].disc,
                    customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].plates,
                    customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].shaft,
                    customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].spring,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].armPin,
                    customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].backSeat,
                    customerPurchaseOrderToBlanketOrderItemDetailArmQuotation         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].arm,
                    customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].hingePin,
                    customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].stopPin,
                    customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyConstructionCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstName     : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyConstructionName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemTypeDesignCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemTypeDesignName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatDesignCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatDesignName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSizeCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSizeName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemRatingCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemRatingName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoreCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoreName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemEndConCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemEndConName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBodyName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBallCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBallName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatInsertCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSeatInsertName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStemCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStemName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSealCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSealName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoltCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBoltName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscCode          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemDiscCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscName          : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemDiscName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemPlatesCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemPlatesName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftCode         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemShaftCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftName         : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemShaftName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSpringCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemSpringName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinCode        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmPinCode, 
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinName        : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmPinName, 
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBackSeatCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemBackSeatName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmCode           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmName           : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemArmName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemHingePinCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemHingePinName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinCode       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStopPinCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinName       : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemStopPinName,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemOperatorCode,
                    customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorName      : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].itemOperatorName,
                    
                    customerPurchaseOrderToBlanketOrderItemDetailNote                 : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].note,
                    customerPurchaseOrderToBlanketOrderItemDetailQuantity             : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].quantity,
                    customerPurchaseOrderToBlanketOrderItemDetailPrice                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].unitPrice,
                    customerPurchaseOrderToBlanketOrderItemDetailTotal                : data.listCustomerPurchaseOrderToBlanketOrderItemDetail[i].totalAmount
                });
                calculateCustomerPurchaseOrderToBlanketOrderHeader();
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderToBlanketOrderAdditionalFee() {
        if($("#enumCustomerPurchaseOrderToBlanketOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-to-blanket-order-additional-fee-data";
        var params = "customerPurchaseOrderToBlanketOrder.code="+$("#customerPurchaseOrderToBlanketOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee.length; i++) {
                customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId, data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i]);
                $("#customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderAdditionalFeeLastRowId,{
                    customerPurchaseOrderToBlanketOrderAdditionalFeeDelete                   : "delete",
                    customerPurchaseOrderToBlanketOrderAdditionalFeeRemark                   : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].remark,
                    customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity                 : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].quantity,
                    customerPurchaseOrderToBlanketOrderAdditionalFeeSearchUnitOfMeasure      : "...",
                    customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode        : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].unitOfMeasureCode,
                    customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode        : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].additionalFeeCode,
                    customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeName        : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].additionalFeeName,
                    customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountCode  : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].coaCode,
                    customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountName  : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].coaName,
                    customerPurchaseOrderToBlanketOrderAdditionalFeePrice                    : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].price,
                    customerPurchaseOrderToBlanketOrderAdditionalFeeTotal                    : data.listCustomerPurchaseOrderToBlanketOrderAdditionalFee[i].total
                });
            }
            calculateCustomerPurchaseOrderToBlanketOrderTotalAdditional();
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderToBlanketOrderPaymentTerm() {
        if($("#enumCustomerPurchaseOrderToBlanketOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-to-blanket-order-payment-term-data";
        var params = "customerPurchaseOrderToBlanketOrder.code="+$("#customerPurchaseOrderToBlanketOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderToBlanketOrderPaymentTermLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerPurchaseOrderToBlanketOrderPaymentTerm.length; i++) {
                customerPurchaseOrderToBlanketOrderPaymentTermLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderPaymentTermLastRowId, data.listCustomerPurchaseOrderToBlanketOrderPaymentTerm[i]);
                $("#customerPurchaseOrderToBlanketOrderPaymentTermInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderPaymentTermLastRowId,{
                    customerPurchaseOrderToBlanketOrderPaymentTermDelete             : "delete",
                    customerPurchaseOrderToBlanketOrderPaymentTermSearchPaymentTerm  : "...",
                    customerPurchaseOrderToBlanketOrderPaymentTermSortNO             : data.listCustomerPurchaseOrderToBlanketOrderPaymentTerm[i].sortNo,
                    customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermCode    : data.listCustomerPurchaseOrderToBlanketOrderPaymentTerm[i].paymentTermCode,
                    customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermName    : data.listCustomerPurchaseOrderToBlanketOrderPaymentTerm[i].paymentTermName,
                    customerPurchaseOrderToBlanketOrderPaymentTermPercent            : data.listCustomerPurchaseOrderToBlanketOrderPaymentTerm[i].percentage,
                    customerPurchaseOrderToBlanketOrderPaymentTermRemark             : data.listCustomerPurchaseOrderToBlanketOrderPaymentTerm[i].remark
                });
            }
        });
        closeLoading();
    }
    
    function loadCustomerPurchaseOrderToBlanketOrderItemDeliveryDate() {
        if($("#enumCustomerPurchaseOrderToBlanketOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-purchase-order-to-blanket-order-item-delivery-data";
        var params = "customerPurchaseOrderToBlanketOrder.code="+$("#customerPurchaseOrderToBlanketOrder\\.customerPurchaseOrderCode").val();   
        
        customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate.length; i++) {
                customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId++;
                
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId, data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i]);
                $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('setRowData',customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId,{
                    customerPurchaseOrderToBlanketOrderItemDeliveryDelete                   : "delete",
                    customerPurchaseOrderToBlanketOrderItemDeliverySearchQuotation          : "...",
                    customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode       : data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i].salesQuotationCode,
                    customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationRefNo      : data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i].refNo,
                    customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsCode      : data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i].itemFinishGoodsCode,
                    customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsRemark    : data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i].itemFinishGoodsRemark,
                    customerPurchaseOrderToBlanketOrderItemDeliverySortNo                   : data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i].customerPurchaseOrderSortNo,
                    customerPurchaseOrderToBlanketOrderItemDeliveryQuantity                 : data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i].quantity,
                    customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate             : formatDateRemoveT(data.listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate[i].deliveryDate,false)
                });
            }
        });
        closeLoading();
    }
    
    function customerPurchaseOrderToBlanketOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=customerPurchaseOrderToBlanketOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function customerPurchaseOrderToBlanketOrderAdditionalFeeInputGrid_SearchAdditional_OnClick(){
        window.open("./pages/search/search-additional-fee-sales.jsp?iddoc=customerPurchaseOrderToBlanketOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function customerPurchaseOrderToBlanketOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick(){
        window.open("./pages/search/search-payment-term.jsp?iddoc=customerPurchaseOrderToBlanketOrderPaymentTerm&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function customerPurchaseOrderToBlanketOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick(){
        var endUser=txtCustomerPurchaseOrderToBlanketOrderEndUserCode.val();
        window.open("./pages/search/search-item-finish-goods.jsp?iddoc=customerPurchaseOrderToBlanketOrderItemDetail&type=grid&idcustomer="+endUser ,"Search", "scrollbars=1,width=600, height=500");
    }
    
    function sortNoDelivery(itemCode){
         $('#customerPurchaseOrderToBlanketOrderItemDetailInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel); 
         var ids = jQuery("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getDataIDs');
         var temp="";
        for(var i=0;i<ids.length;i++){
                var Detail = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                if (itemCode===Detail.customerPurchaseOrderToBlanketOrderItemDetailItem){
                    temp=Detail.customerPurchaseOrderToBlanketOrderItemDetailSortNo;
                }
               
        }
        
         $('#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid').jqGrid("saveRow",customerPurchaseOrderToBlanketOrderItemDelivery_lastSel); 
         var idt = jQuery("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
         for(var i=0;i<idt.length;i++){
             var Details = $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getRowData',idt[i]); 
                if (itemCode===Details.customerPurchaseOrderToBlanketOrderItemDeliveryItemCode){
                    $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid("setCell",idt[i], "customerPurchaseOrderToBlanketOrderItemDeliverySortNo",temp);

                }
         }
    }
    
    function customerPurchaseOrderToBlanketOrderItemDeliveryInputGrid_SearchQuotation_OnClick(){
      var ids = jQuery("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
           
            if($("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;
                }
            }
            
            if(cpoSalesQuotation_lastSel !== -1) {
                $('#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel);  
            }
            
           var listSalesQuotationCode = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid").jqGrid('getRowData',ids[q]); 
                listSalesQuotationCode[q] = [data.customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode];
//                 (listCode);
            }
        window.open("./pages/search/search-sales-quotation-array.jsp?iddoc=customerPurchaseOrderToBlanketOrderItemDelivery&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function setCustomerPurchaseOrderToBlanketOrderPartialShipmentStatusStatus(){
        switch($("#customerPurchaseOrderToBlanketOrder\\.partialShipmentStatus").val()){
            case "YES":
                $('input[name="customerPurchaseOrderToBlanketOrderPartialShipmentStatusRad"][value="YES"]').prop('checked',true);
                break;
            case "NO":
                $('input[name="customerPurchaseOrderToBlanketOrderPartialShipmentStatusRad"][value="NO"]').prop('checked',true);
                break;
        } 
    }
    
    function cpoBOTransactionDateOnChange(){
        if($("#enumCustomerPurchaseOrderToBlanketOrderActivity").val()!=="UPDATE"){
            $("#customerPurchaseOrderToBlanketOrderTransactionDate").val(dtpCustomerPurchaseOrderToBlanketOrderTransactionDate.val());
        }
        if($("#enumCustomerPurchaseOrderToBlanketOrderActivity").val()!=="REVISE"){
            $("#customerPurchaseOrderToBlanketOrderTransactionDate").val(dtpCustomerPurchaseOrderToBlanketOrderTransactionDate.val());
        }
        if($("#enumCustomerPurchaseOrderToBlanketOrderActivity").val()!=="CLONE"){
            $("#customerPurchaseOrderToBlanketOrderTransactionDate").val(dtpCustomerPurchaseOrderToBlanketOrderTransactionDate.val());
        }
    }
    
    function avoidSpcCharCpoBo(){
        
        var selectedRowID = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerPurchaseOrderToBlanketOrderItemDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderItemDetailSortNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep = str.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderItemDetailSortNo").val(rep);
        }
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_customerPurchaseOrderToBlanketOrderItemDetailSortNo").val("");
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

<s:url id="remoteurlCustomerPurchaseOrderToBlanketOrderSalesQuotationInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderToBlanketOrderAdditionalFeeInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderToBlanketOrderPaymentTermInput" action="" />
<s:url id="remoteurlCustomerPurchaseOrderToBlanketOrderItemDeliveryInput" action="" />
<b>CUSTOMER PURCHASE ORDER TO BLANKET ORDER</b><span id="msgCustomerPurchaseOrderToBlanketOrderActivity"></span>
<hr>
<br class="spacer" />

<div id="customerPurchaseOrderToBlanketOrderInput" class="content ui-widget">
    <s:form id="frmCustomerPurchaseOrderToBlanketOrderInput">
        <table cellpadding="2" cellspacing="2" id="headerCustomerPurchaseOrderToBlanketOrderInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" style="width:180px"><B>CPO-BO No *</B></td>
                            <td>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.code" name="customerPurchaseOrderToBlanketOrder.code" key="customerPurchaseOrderToBlanketOrder.code" readonly="true" size="30"></s:textfield>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.customerPurchaseOrderCode" name="customerPurchaseOrderToBlanketOrder.customerPurchaseOrderCode" key="customerPurchaseOrderToBlanketOrder.customerPurchaseOrderCode" readonly="true" size="25" disabled="true" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ref CPO-BO No *</B></td>
                            <td>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.custPONo" name="customerPurchaseOrderToBlanketOrder.custPONo" key="customerPurchaseOrderToBlanketOrder.custPONo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.refCUSTPOCode" name="customerPurchaseOrderToBlanketOrder.refCUSTPOCode" key="customerPurchaseOrderToBlanketOrder.refCUSTPOCode" readonly="true" size="30"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.revision" name="customerPurchaseOrderToBlanketOrder.revision" key="customerPurchaseOrderToBlanketOrder.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                txtCustomerPurchaseOrderToBlanketOrderBranchCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderToBlanketOrderBranchCode.val()===""){
                                        txtCustomerPurchaseOrderToBlanketOrderBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get";
                                    var params = "branch.code=" + txtCustomerPurchaseOrderToBlanketOrderBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtCustomerPurchaseOrderToBlanketOrderBranchCode.val(data.branchTemp.code);
                                            txtCustomerPurchaseOrderToBlanketOrderBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtCustomerPurchaseOrderToBlanketOrderBranchCode);
                                            txtCustomerPurchaseOrderToBlanketOrderBranchCode.val("");
                                            txtCustomerPurchaseOrderToBlanketOrderBranchName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.branch.code" name="customerPurchaseOrderToBlanketOrder.branch.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrderToBlanketOrder_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.branch.name" name="customerPurchaseOrderToBlanketOrder.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="customerPurchaseOrderToBlanketOrder.transactionDate" name="customerPurchaseOrderToBlanketOrder.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" onchange="cpoBOTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                                <sj:datepicker id="customerPurchaseOrderToBlanketOrderTransactionDate" name="customerPurchaseOrderToBlanketOrderTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right"><B>Order Status * </B></td>
                            <td colspan="2">
                                <s:radio id="customerPurchaseOrderToBlanketOrderOrderStatusRad" name="customerPurchaseOrderToBlanketOrderOrderStatusRad" label="customerPurchaseOrderToBlanketOrderOrderStatusRad" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.orderStatus" name="customerPurchaseOrderToBlanketOrder.orderStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="customerPurchaseOrderToBlanketOrder.purchaseOrderType" name="customerPurchaseOrderToBlanketOrder.purchaseOrderType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order No *</B></td>
                            <td colspan="3"><s:textfield id="customerPurchaseOrderToBlanketOrder.customerPurchaseOrderNo" name="customerPurchaseOrderToBlanketOrder.customerPurchaseOrderNo" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtCustomerPurchaseOrderToBlanketOrderCustomerCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderToBlanketOrderCustomerCode.val()===""){
                                        txtCustomerPurchaseOrderToBlanketOrderCustomerName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get";
                                    var params = "customer.code=" + txtCustomerPurchaseOrderToBlanketOrderCustomerCode.val();
                                        params += "&customer.activeStatus=TRUE";
                                        params += "&customer.customerStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtCustomerPurchaseOrderToBlanketOrderCustomerCode.val(data.customerTemp.code);
                                            txtCustomerPurchaseOrderToBlanketOrderCustomerName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer Not Found!",txtCustomerPurchaseOrderToBlanketOrderCustomerCode);
                                            txtCustomerPurchaseOrderToBlanketOrderCustomerCode.val("");
                                            txtCustomerPurchaseOrderToBlanketOrderCustomerName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.customer.code" name="customerPurchaseOrderToBlanketOrder.customer.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrderToBlanketOrder_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.customer.name" name="customerPurchaseOrderToBlanketOrder.customer.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>End User *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtCustomerPurchaseOrderToBlanketOrderEndUserCode.change(function(ev) {

                                    if(txtCustomerPurchaseOrderToBlanketOrderEndUserCode.val()===""){
                                        txtCustomerPurchaseOrderToBlanketOrderEndUserName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get-end-user";
                                    var params = "customer.code=" + txtCustomerPurchaseOrderToBlanketOrderEndUserCode.val();
                                        params += "&customer.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtCustomerPurchaseOrderToBlanketOrderEndUserCode.val(data.customerTemp.code);
                                            txtCustomerPurchaseOrderToBlanketOrderEndUserName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer End User Not Found!",txtCustomerPurchaseOrderToBlanketOrderEndUserCode);
                                            txtCustomerPurchaseOrderToBlanketOrderEndUserCode.val("");
                                            txtCustomerPurchaseOrderToBlanketOrderEndUserName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.endUser.code" name="customerPurchaseOrderToBlanketOrder.endUser.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="customerPurchaseOrderToBlanketOrder_btnCustomerEndUser" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.endUser.name" name="customerPurchaseOrderToBlanketOrder.endUser.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Partial Shipment * </B></td>
                            <td colspan="2">
                                <s:radio id="customerPurchaseOrderToBlanketOrderPartialShipmentStatusRad" name="customerPurchaseOrderToBlanketOrderPartialShipmentStatusRad" label="customerPurchaseOrderToBlanketOrderPartialShipmentStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.partialShipmentStatus" name="customerPurchaseOrderToBlanketOrder.partialShipmentStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Retention</td>
                            <td>
                                <s:textfield id="customerPurchaseOrderToBlanketOrder.retentionPercent" name="customerPurchaseOrderToBlanketOrder.retentionPercent" size="5" cssStyle="text-align:right"></s:textfield>%
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

                                    txtCustomerPurchaseOrderToBlanketOrderCurrencyCode.change(function(ev) {

                                        if(txtCustomerPurchaseOrderToBlanketOrderCurrencyCode.val()===""){
                                            txtCustomerPurchaseOrderToBlanketOrderCurrencyName.val("");
                                            return;
                                        }

                                        var url = "master/currency-get";
                                        var params = "currency.code=" + txtCustomerPurchaseOrderToBlanketOrderCurrencyCode.val();
                                            params+= "&currency.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.currencyTemp){
                                                txtCustomerPurchaseOrderToBlanketOrderCurrencyCode.val(data.currencyTemp.code);
                                                txtCustomerPurchaseOrderToBlanketOrderCurrencyName.val(data.currencyTemp.name);
                                            }
                                            else{
                                                alertMessage("Currency Not Found",txtCustomerPurchaseOrderToBlanketOrderCurrencyCode);
                                                txtCustomerPurchaseOrderToBlanketOrderCurrencyCode.val("");
                                                txtCustomerPurchaseOrderToBlanketOrderCurrencyName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.currency.code" name="customerPurchaseOrderToBlanketOrder.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                <sj:a id="customerPurchaseOrderToBlanketOrder_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.currency.name" name="customerPurchaseOrderToBlanketOrder.currency.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sales Person *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode.change(function(ev) {
                                        if(txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode.val()===""){
                                            txtCustomerPurchaseOrderToBlanketOrderSalesPersonName.val("");
                                            return;
                                        }
                                        var url = "master/sales-person-get";
                                        var params = "salesPerson.code=" + txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode.val();
                                            params+= "&salesPerson.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.salesPersonTemp){
                                                txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode.val(data.salesPersonTemp.code);
                                                txtCustomerPurchaseOrderToBlanketOrderSalesPersonName.val(data.salesPersonTemp.name);
                                            }
                                            else{
                                                alertMessage("Sales Person Not Found!",txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode);
                                                txtCustomerPurchaseOrderToBlanketOrderSalesPersonCode.val("");
                                                txtCustomerPurchaseOrderToBlanketOrderSalesPersonName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.salesPerson.code" name="customerPurchaseOrderToBlanketOrder.salesPerson.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                    <sj:a id="customerPurchaseOrderToBlanketOrder_btnSalesPerson" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.salesPerson.name" name="customerPurchaseOrderToBlanketOrder.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Project</td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtCustomerPurchaseOrderToBlanketOrderProjectCode.change(function(ev) {
                                        if(txtCustomerPurchaseOrderToBlanketOrderProjectCode.val()===""){
                                            txtCustomerPurchaseOrderToBlanketOrderProjectName.val("");
                                            return;
                                        }
                                        var url = "master/project-get";
                                        var params = "project.code=" + txtCustomerPurchaseOrderToBlanketOrderProjectCode.val();
                                            params+= "&project.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.projectTemp){
                                                txtCustomerPurchaseOrderToBlanketOrderProjectCode.val(data.projectTemp.code);
                                                txtCustomerPurchaseOrderToBlanketOrderProjectName.val(data.projectTemp.name);
                                            }
                                            else{
                                                alertMessage("Project Not Found!",txtCustomerPurchaseOrderToBlanketOrderProjectCode);
                                                txtCustomerPurchaseOrderToBlanketOrderProjectCode.val("");
                                                txtCustomerPurchaseOrderToBlanketOrderProjectName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.project.code" name="customerPurchaseOrderToBlanketOrder.project.code" title=" " size="22"></s:textfield>
                                    <sj:a id="customerPurchaseOrderToBlanketOrder_btnProject" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.project.name" name="customerPurchaseOrderToBlanketOrder.project.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3"><s:textfield id="customerPurchaseOrderToBlanketOrder.refNo" name="customerPurchaseOrderToBlanketOrder.refNo" size="27"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="customerPurchaseOrderToBlanketOrder.remark" name="customerPurchaseOrderToBlanketOrder.remark"  cols="70" rows="2" height="20"></s:textarea></td>
                        </tr> 
                    </table>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="customerPurchaseOrderToBlanketOrderDateFirstSession" name="customerPurchaseOrderToBlanketOrderDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="customerPurchaseOrderToBlanketOrderDateLastSession" name="customerPurchaseOrderToBlanketOrderDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumCustomerPurchaseOrderToBlanketOrderActivity" name="enumCustomerPurchaseOrderToBlanketOrderActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="customerPurchaseOrderToBlanketOrder.createdBy" name="customerPurchaseOrderToBlanketOrder.createdBy" key="customerPurchaseOrderToBlanketOrder.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="customerPurchaseOrderToBlanketOrder.createdDate" name="customerPurchaseOrderToBlanketOrder.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="customerPurchaseOrderToBlanketOrder.createdDateTemp" name="customerPurchaseOrderToBlanketOrder.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderToBlanketOrder" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderToBlanketOrder" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnCPOBOSearchSalQuo" button="true" style="width: 200px">Search Sales Quotation</sj:a>
                </td>
            </tr>
        </table>     
        <br class="spacer" />
        <div id="customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid">
            <sjg:grid
                id="customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid"
                caption="Sales Quotation"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listCustomerPurchaseOrderToBlanketOrderTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuCustomerPurchaseOrderToBlanketOrderDetail').width()"
                editurl="%{remoteurlCustomerPurchaseOrderToBlanketOrderSalesQuotationInput}"
                onSelectRowTopics="customerPurchaseOrderToBlanketOrderSalesQuotationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotation" index="customerPurchaseOrderToBlanketOrderSalesQuotation" key="customerPurchaseOrderToBlanketOrderSalesQuotation" 
                    title="" width="50" sortable="true" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationDelete" index="customerPurchaseOrderToBlanketOrderSalesQuotationDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'customerPurchaseOrderToBlanketOrderSalesQuotationInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationCode" index="customerPurchaseOrderToBlanketOrderSalesQuotationCode" 
                    title="SLS-QUO No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationTransactionDate" index="customerPurchaseOrderToBlanketOrderSalesQuotationTransactionDate" key="customerPurchaseOrderToBlanketOrderSalesQuotationTransactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationCustomerCode" index="customerPurchaseOrderToBlanketOrderSalesQuotationCustomerCode" 
                    title="Customer Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationCustomerName" index="customerPurchaseOrderToBlanketOrderSalesQuotationCustomerName" 
                    title="Customer Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationEndUserCode" index="customerPurchaseOrderToBlanketOrderSalesQuotationEndUserCode" 
                    title="End User Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationEndUserName" index="customerPurchaseOrderToBlanketOrderSalesQuotationEndUserName" 
                    title="End User Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "customerPurchaseOrderToBlanketOrderSalesQuotationRfqCode" index = "customerPurchaseOrderToBlanketOrderSalesQuotationRfqCode" key = "customerPurchaseOrderToBlanketOrderSalesQuotationRfqCode" 
                    title = "RFQ No" width = "80" edittype="text" 
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationProjectCode" index="customerPurchaseOrderToBlanketOrderSalesQuotationProjectCode" 
                    title="Project" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationSubject" index="customerPurchaseOrderToBlanketOrderSalesQuotationSubject" 
                    title="Subject" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationAttn" index="customerPurchaseOrderToBlanketOrderSalesQuotationAttn" 
                    title="Attn" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationRefNo" index="customerPurchaseOrderToBlanketOrderSalesQuotationRefNo" key="customerPurchaseOrderToBlanketOrderSalesQuotationRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerPurchaseOrderToBlanketOrderSalesQuotationRemark" index="customerPurchaseOrderToBlanketOrderSalesQuotationRemark" key="customerPurchaseOrderToBlanketOrderSalesQuotationRemark" 
                    title="Remark" width="150" sortable="true"
                />
            </sjg:grid >     
        </div>         
        <table>    
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotation" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmCustomerPurchaseOrderToBlanketOrderSalesQuotationDetailSort" button="true" style="width: 70px">Sort No</sj:a>
                </td>
            </tr>
        </table>
        <div id="id-tbl-additional-payment-item-delivery-cpoBO">
            <div>
                <sjg:grid
                    id="customerPurchaseOrderToBlanketOrderItemDetailInput_grid"
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
                    editurl="%{remoteurlCustomerPurchaseOrderToBlanketOrderSalesQuotationInput}"
                    onSelectRowTopics="customerPurchaseOrderToBlanketOrderItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetail" index="customerPurchaseOrderToBlanketOrderItemDetail" key="customerPurchaseOrderToBlanketOrderItemDetail" 
                        title="" width="50" sortable="true" editable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailDelete" index="customerPurchaseOrderToBlanketOrderItemDetailDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'customerPurchaseOrderToBlanketOrderItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />                    
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode" index="customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode" key="customerPurchaseOrderToBlanketOrderItemDetailQuotationNoDetailCode" 
                        title="Quotation No " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailQuotationNo" index="customerPurchaseOrderToBlanketOrderItemDetailQuotationNo" key="customerPurchaseOrderToBlanketOrderItemDetailQuotationNo" 
                        title="Quotation No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo" index="customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo" key="customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo" 
                        title="Ref No" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSortNo" index="customerPurchaseOrderToBlanketOrderItemDetailSortNo" 
                        title="Sort No" width="80" sortable="true" editable="true" edittype="text" formatter="integer"
                        editoptions="{onKeyUp:'avoidSpcCharCpoBo()'}"
                    />  
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSearchItemFinishGoods" index="customerPurchaseOrderToBlanketOrderItemDetailSearchItemFinishGoods" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"
                        editoptions="{onClick:'customerPurchaseOrderToBlanketOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode" key="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode" 
                        title="Item Finish Goods Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark" key="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode" index="customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode" key="customerPurchaseOrderToBlanketOrderItemDetailValveTypeCode" 
                        title="Valve Type Code (QUO)" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailValveTypeName" index="customerPurchaseOrderToBlanketOrderItemDetailValveTypeName" key="customerPurchaseOrderToBlanketOrderItemDetailValveTypeName" 
                        title="Valve Type Name (QUO)" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemAlias" index="customerPurchaseOrderToBlanketOrderItemDetailItemAlias" 
                        title="Item Alias" width="100" sortable="true" editable="true" edittype="text"
                    /> 
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailValveTag" index="customerPurchaseOrderToBlanketOrderItemDetailValveTag" 
                        title="Valve Tag" width="100" sortable="true" editable="true" edittype="text"
                    />  
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailDataSheet" index="customerPurchaseOrderToBlanketOrderItemDetailDataSheet" 
                        title="Data Sheet" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailDescription" index="customerPurchaseOrderToBlanketOrderItemDetailDescription" 
                        title="Description" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <!--Body Const 01-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailBodyConstQuotation" 
                        title="QUO (01)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstCode" 
                        title="IFG (01)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyConstName" 
                        title="IFG (01)" width="100" sortable="true"
                    />
                    <!--Type Design 02-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailTypeDesignQuotation" 
                        title="QUO (02)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignCode" 
                        title="IFG (02)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsTypeDesignName" 
                        title="IFG (02)" width="100" sortable="true"
                    />
                    <!--Seat Design 03-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailSeatDesignQuotation" 
                        title="QUO (03)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignCode" 
                        title="IFG (03)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatDesignName" 
                        title="IFG (03)" width="100" sortable="true"
                    />
                    <!--Size 04-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailSizeQuotation" 
                        title="QUO (04)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeCode" 
                        title="IFG (04)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSizeName" 
                        title="IFG (04)" width="100" sortable="true"
                    />
                    <!--Rating 05-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailRatingQuotation" 
                        title="QUO (05)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingCode" 
                        title="IFG (05)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRatingName" 
                        title="IFG (05)" width="100" sortable="true"
                    />
                    <!--Bore 06-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailBoreQuotation" 
                        title="QUO (06)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreCode" 
                        title="IFG (06)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoreName" 
                        title="IFG (06)" width="100" sortable="true"
                    />
                    <!--EndCon 07-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailEndConQuotation" 
                        title="QUO (07)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConCode" 
                        title="IFG (07)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsEndConName" 
                        title="IFG (07)" width="100" sortable="true"
                    />
                    <!--Body 08-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailBodyQuotation" 
                        title="QUO (08)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyCode" 
                        title="IFG (08)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBodyName" 
                        title="IFG (08)" width="100" sortable="true"
                    />
                    <!--Ball 09-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailBallQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailBallQuotation" 
                        title="QUO (09)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallCode" 
                        title="IFG (09)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBallName" 
                        title="IFG (09)" width="100" sortable="true"
                    />
                    <!--Seat 10-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailSeatQuotation" 
                        title="QUO (10)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatCode" 
                        title="IFG (10)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatName" 
                        title="IFG (10)" width="100" sortable="true"
                    />
                    <!--SeatInsert 11-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailSeatInsertQuotation" 
                        title="QUO (11)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertCode" 
                        title="IFG (11)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSeatInsertName" 
                        title="IFG (11)" width="100" sortable="true"
                    />
                    <!--Stem 12-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailStemQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailStemQuotation" 
                        title="QUO (12)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemCode" 
                        title="IFG (12)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStemName" 
                        title="IFG (12)" width="100" sortable="true"
                    />
                    <!--Seal 13-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSealQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailSealQuotation" 
                        title="QUO (13)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealCode" 
                        title="IFG (13)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSealName" 
                        title="IFG (13)" width="100" sortable="true"
                    />
                    <!--Bolt 14-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailBoltQuotation" 
                        title="QUO (14)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltCode" 
                        title="IFG (14)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBoltName" 
                        title="IFG (14)" width="100" sortable="true"
                    />
                    <!--Disc 15-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailDiscQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsDiscName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Plates 16-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailPlatesQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsPlatesName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Shaft 17-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailShaftQuotation" 
                        title="QUO (17)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftCode" 
                        title="IFG (17)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsShaftName" 
                        title="IFG (17)" width="100" sortable="true"
                    />
                    <!--Spring 18-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailSpringQuotation" 
                        title="QUO (18)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringCode" 
                        title="IFG (18)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsSpringName" 
                        title="IFG (18)" width="100" sortable="true"
                    />
                    <!--ArmPin 19-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailArmPinQuotation" 
                        title="QUO (19)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinCode" 
                        title="IFG (19)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmPinName" 
                        title="IFG (19)" width="100" sortable="true"
                    />
                    <!--BackSeat 20-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailBackSeatQuotation" 
                        title="QUO (20)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatCode" 
                        title="IFG (20)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsBackSeatName" 
                        title="IFG (20)" width="100" sortable="true"
                    />
                    <!--Arm 21-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailArmQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailArmQuotation" 
                        title="QUO (21)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmCode" 
                        title="IFG (21)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsArmName" 
                        title="IFG (21)" width="100" sortable="true"
                    />
                    <!--HingePin 22-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailHingePinQuotation" 
                        title="QUO (22)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinCode" 
                        title="IFG (22)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsHingePinName" 
                        title="IFG (22)" width="100" sortable="true"
                    />
                    <!--StopPin 23-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailStopPinQuotation" 
                        title="QUO (23)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinCode" 
                        title="IFG (23)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsStopPinName" 
                        title="IFG (23)" width="100" sortable="true"
                    />
                    <!--Operator 99-->
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation" index="customerPurchaseOrderToBlanketOrderItemDetailOperatorQuotation" 
                        title="QUO (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorCode" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorCode" 
                        title="IFG (99)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorName" index="customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsOperatorName" 
                        title="IFG (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailNote" index="customerPurchaseOrderToBlanketOrderItemDetailNote" title="Note" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailQuantity" index="customerPurchaseOrderToBlanketOrderItemDetailQuantity" key="customerPurchaseOrderToBlanketOrderItemDetailQuantity" title="Qty" 
                        width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                        formatter="number" editrules="{ double: true }"
                        editoptions="{onKeyUp:'calculateItemSalesQuotationDetailCPOBO()'}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailPrice" index="customerPurchaseOrderToBlanketOrderItemDetailPrice" key="customerPurchaseOrderToBlanketOrderItemDetailPrice" title="Unit Price" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="customerPurchaseOrderToBlanketOrderItemDetailTotal" index="customerPurchaseOrderToBlanketOrderItemDetailTotal" key="customerPurchaseOrderToBlanketOrderItemDetailTotal" title="Total" 
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
                                id="customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid"
                                caption="Additional"
                                dataType="local"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listCustomerPurchaseOrderToBlanketOrderAdditionalFee"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false"
                                editinline="true"
                                width="$('#tabmnuCustomerPurchaseOrderToBlanketOrderAdditionalFee').width()"
                                editurl="%{remoteurlCustomerPurchaseOrderToBlanketOrderAdditionalFeeInput}"
                                onSelectRowTopics="customerPurchaseOrderToBlanketOrderAdditionalFeeInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFee" index="customerPurchaseOrderToBlanketOrderAdditionalFee" key="customerPurchaseOrderToBlanketOrderAdditionalFee" 
                                    title="" width="50" sortable="true" editable="true" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeDelete" index="customerPurchaseOrderToBlanketOrderAdditionalFeeDelete" title="" width="50" align="centre"
                                    editable="true" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderToBlanketOrderAdditionalFeeInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeRemark" index="customerPurchaseOrderToBlanketOrderAdditionalFeeRemark" key="customerPurchaseOrderToBlanketOrderAdditionalFeeRemark" 
                                    title="Remark" width="150" sortable="true" editable="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity" index="customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity" key="customerPurchaseOrderToBlanketOrderAdditionalFeeQuantity" title="Quantity" 
                                    width="80" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateCustomerPurchaseOrderToBlanketOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeSearchUnitOfMeasure" index="customerPurchaseOrderToBlanketOrderAdditionalFeeSearchUnitOfMeasure" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderToBlanketOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode" index="customerPurchaseOrderToBlanketOrderAdditionalFeeUnitOfMeasureCode" 
                                    title="Unit" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeUnitOfMeasureCodeCPOBO()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeSearchAdditional" index="customerPurchaseOrderToBlanketOrderAdditionalFeeSearchAdditional" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'customerPurchaseOrderToBlanketOrderAdditionalFeeInputGrid_SearchAdditional_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode" index="customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeCode" 
                                    title="Additional Fee Code" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeCode()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeName" index="customerPurchaseOrderToBlanketOrderAdditionalFeeAdditionalFeeName" 
                                    title="Additional Fee Name" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountCode" index="customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountCode" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountName" index="customerPurchaseOrderToBlanketOrderAdditionalFeeSalesChartOfAccountName" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeePrice" index="customerPurchaseOrderToBlanketOrderAdditionalFeePrice" key="customerPurchaseOrderToBlanketOrderAdditionalFeePrice" title="Price" 
                                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateCustomerPurchaseOrderToBlanketOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="customerPurchaseOrderToBlanketOrderAdditionalFeeTotal" index="customerPurchaseOrderToBlanketOrderAdditionalFeeTotal" key="customerPurchaseOrderToBlanketOrderAdditionalFeeTotal" title="Total" 
                                    width="150" align="right" edittype="text"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                            </sjg:grid >
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="customerPurchaseOrderToBlanketOrderAdditionalFeeAddRow" name="customerPurchaseOrderToBlanketOrderAdditionalFeeAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                            <sj:a href="#" id="btnCustomerPurchaseOrderToBlanketOrderAdditionalFeeAdd" button="true"  style="width: 60px">Add</sj:a>
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
                                            id="customerPurchaseOrderToBlanketOrderPaymentTermInput_grid"
                                            caption="Payment Term"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerPurchaseOrderToBlanketOrderPaymentTerm"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlCustomerPurchaseOrderToBlanketOrderPaymentTermInput}"
                                            onSelectRowTopics="customerPurchaseOrderToBlanketOrderPaymentTermInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTerm" index="customerPurchaseOrderToBlanketOrderPaymentTerm" 
                                                title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                            />  
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTermDelete" index="customerPurchaseOrderToBlanketOrderPaymentTermDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderToBlanketOrderPaymentTermInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTermSortNO" index="customerPurchaseOrderToBlanketOrderPaymentTermSortNO" key="customerPurchaseOrderToBlanketOrderPaymentTermSortNO" title="Term No" 
                                                width="80" align="right" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermCode" index="customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermCode" 
                                                title="Payment Term Code" width="100" sortable="true" editable="true" edittype="text"
                                                editoptions="{onChange:'onchangePaymentTermPaymentTermCode()'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTermSearchPaymentTerm" index="customerPurchaseOrderToBlanketOrderPaymentTermSearchPaymentTerm" title="" width="25" align="centre"
                                                editable="true" dataType="html" edittype="button" 
                                                editoptions="{onClick:'customerPurchaseOrderToBlanketOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick()', value:'...'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermName" index="customerPurchaseOrderToBlanketOrderPaymentTermPaymentTermName" 
                                                title="Payment Term" width="100" sortable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTermPercent" index="customerPurchaseOrderToBlanketOrderPaymentTermPercent" key="customerPurchaseOrderToBlanketOrderPaymentTermPercent" title="Percent" 
                                                width="80" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderPaymentTermRemark" index="customerPurchaseOrderToBlanketOrderPaymentTermRemark" 
                                                title="Note" width="200" sortable="true" edittype="text" editable="true"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderToBlanketOrderPaymentTermAddRow" name="customerPurchaseOrderToBlanketOrderPaymentTermAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnCustomerPurchaseOrderToBlanketOrderPaymentTermAdd" button="true"  style="width: 60px">Add</sj:a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table valign="top">
                                <tr>
                                    <td width="120px" align="right"><B>Total Transaction</B></td>
                                    <td width="120px">
                                        <s:textfield id="customerPurchaseOrderToBlanketOrder.totalTransactionAmount" name="customerPurchaseOrderToBlanketOrder.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Disc
                                        <s:textfield id="customerPurchaseOrderToBlanketOrder.discountPercent" name="customerPurchaseOrderToBlanketOrder.discountPercent" onkeyup="calculateCustomerPurchaseOrderToBlanketOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.discountAmount" name="customerPurchaseOrderToBlanketOrder.discountAmount" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Additional</td>
                                    <td>
                                    <s:textfield id="customerPurchaseOrderToBlanketOrder.totalAdditionalFeeAmount" name="customerPurchaseOrderToBlanketOrder.totalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" disabled="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><b>Sub Total(Tax Base)</b></td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderToBlanketOrder.taxBaseAmount" name="customerPurchaseOrderToBlanketOrder.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">VAT
                                        <s:textfield id="customerPurchaseOrderToBlanketOrder.vatPercent" name="customerPurchaseOrderToBlanketOrder.vatPercent" onkeyup="calculateCustomerPurchaseOrderToBlanketOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderToBlanketOrder.vatAmount" name="customerPurchaseOrderToBlanketOrder.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Grand Total</B></td>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderToBlanketOrder.grandTotalAmount" name="customerPurchaseOrderToBlanketOrder.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
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
                        <sj:a href="#" id="btnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmCustomerPurchaseOrderToBlanketOrderItemDetailDelivery" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>                
            <div id="id-tbl-additional-item-delivery-detail-cpoBO">
                <table>
                    <tr>
                        <td align="right">Delivery Date
                            <sj:datepicker id="customerPurchaseOrderToBlanketOrderDeliveryDateSet" name="customerPurchaseOrderToBlanketOrderDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today"></sj:datepicker>
                            <sj:a href="#" id="btnCustomerPurchaseOrderToBlanketOrderDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;
                            <sj:a href="#" id="btnCustomerPurchaseOrderToBlanketOrderCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid"
                                            caption="Item Delivery Date"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerPurchaseOrderToBlanketOrderItemDeliveryDate"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="1000"
                                            editurl="%{remoteurlCustomerPurchaseOrderToBlanketOrderItemDeliveryInput}"
                                            onSelectRowTopics="customerPurchaseOrderToBlanketOrderItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderItemDelivery" index="customerPurchaseOrderToBlanketOrderItemDelivery" key="customerPurchaseOrderToBlanketOrderItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderItemDeliveryDelete" index="customerPurchaseOrderToBlanketOrderItemDeliveryDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderToBlanketOrderItemDeliveryInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderItemDeliverySearchQuotation" index="customerPurchaseOrderToBlanketOrderItemDeliverySearchQuotation" title="" width="25" align="centre"
                                                editable="true"
                                                dataType="html"
                                                edittype="button"
                                                editoptions="{onClick:'customerPurchaseOrderToBlanketOrderItemDeliveryInputGrid_SearchQuotation_OnClick()', value:'...'}"
                                            /> 
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsCode" index = "customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsCode" key = "customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsCode" 
                                                title = "Item Finish Goods Code" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsRemark" index = "customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsRemark" key = "customerPurchaseOrderToBlanketOrderItemDeliveryItemFinishGoodsRemark" 
                                                title = "IFG Remark" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderItemDeliverySortNo" index="customerPurchaseOrderToBlanketOrderItemDeliverySortNo" title="Sort No" width="80" sortable="true"
                                            />  
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderItemDeliveryQuantity" index="customerPurchaseOrderToBlanketOrderItemDeliveryQuantity" key="customerPurchaseOrderToBlanketOrderItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate" index="customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="true" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangeCustomerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDateTemp" index="customerPurchaseOrderToBlanketOrderItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode" index = "customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode" key = "customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationCode" 
                                                title = "Quotation No" width = "100"
                                            />
                                            <sjg:gridColumn
                                                name = "customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationRefNo" index = "customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationRefNo" key = "customerPurchaseOrderToBlanketOrderItemDeliverySalesQuotationRefNo" 
                                                title = "Ref No" width = "100"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="customerPurchaseOrderToBlanketOrderItemDelieryAddRow" name="customerPurchaseOrderToBlanketOrderItemDelieryAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnCustomerPurchaseOrderToBlanketOrderItemDelieryAdd" button="true"  style="width: 60px">Add</sj:a>
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
                    <sj:a href="#" id="btnCustomerPurchaseOrderToBlanketOrderSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnCustomerPurchaseOrderToBlanketOrderCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    