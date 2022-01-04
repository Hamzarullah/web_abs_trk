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
    .ui-dialog-titlebar-close,#salesOrderSalesQuotationInput_grid_pager_center,
    #salesOrderItemDetailInput_grid_pager_center,#salesOrderAdditionalFeeInput_grid_pager_center,
    #salesOrderPaymentTermInput_grid_pager_center,#salesOrderItemDeliveryInput_grid_pager_center{
        display: none;
    }
    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var salesOrderSalesQuotationLastRowId=0,salesOrderSalesQuotation_lastSel = -1;
    var salesOrderItemDetailLastRowId=0,salesOrderItemDetail_lastSel = -1;
    var salesOrderAdditionalFeeLastRowId=0,salesOrderAdditionalFee_lastSel = -1;
    var salesOrderPaymentTermLastRowId=0,salesOrderPaymentTerm_lastSel = -1;
    var salesOrderItemDeliveryLastRowId=0,salesOrderItemDelivery_lastSel = -1;
    var cpoSalesQuotation_lastSel = -1;
    var 
        txtSalesOrderCode = $("#salesOrder\\.code"),
        dtpSalesOrderTransactionDate = $("#salesOrder\\.transactionDate"),
        txtSalesOrderCustomerCode= $("#salesOrder\\.customer\\.code"),
        txtSalesOrderCustomerName= $("#salesOrder\\.customer\\.name"),
        txtSalesOrderEndUserCode= $("#salesOrder\\.endUser\\.code"),
        txtSalesOrderEndUserName= $("#salesOrder\\.endUser\\.name"),
        txtSalesOrderRetention= $("#salesOrder\\.customerPurchaseOrder\\.retentionPercent"),
        txtSalesOrderCurrencyCode= $("#salesOrder\\.currency\\.code"),
        txtSalesOrderCurrencyName= $("#salesOrder\\.currency\\.name"),
        txtSalesOrderBranchCode= $("#salesOrder\\.branch\\.code"),
        txtSalesOrderBranchName= $("#salesOrder\\.branch\\.name"),
        txtSalesOrderSalesPersonCode= $("#salesOrder\\.salesPerson\\.code"),
        txtSalesOrderSalesPersonName= $("#salesOrder\\.salesPerson\\.name"),
        txtSalesOrderProjectCode= $("#salesOrder\\.project\\.code"),
        txtSalesOrderProjectName= $("#salesOrder\\.project\\.name"),
        txtSalesOrderRefNo = $("#salesOrder\\.refNo"),
        txtSalesOrderRemark = $("#salesOrder\\.remark"),
        txtSalesOrderTotalTransactionAmount = $("#salesOrder\\.totalTransactionAmount"),
        txtSalesOrderDiscountPercent = $("#salesOrder\\.discountPercent"),
        txtSalesOrderDiscountAmount = $("#salesOrder\\.discountAmount"),
        txtSalesOrderTotalAdditionalFee= $("#salesOrder\\.totalAdditionalFeeAmount"),
        txtSalesOrderTaxBaseAmount= $("#salesOrder\\.taxBaseAmount"),
        txtSalesOrderVATPercent = $("#salesOrder\\.vatPercent"),
        txtSalesOrderVATAmount = $("#salesOrder\\.vatAmount"),
        txtSalesOrderGrandTotalAmount = $("#salesOrder\\.grandTotalAmount");

        function loadGridItemSO(){
             //function groupingHeader
                $("#salesOrderItemDetailInput_grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true, 
                    groupHeaders:[
                          {startColumnName: 'salesOrderItemDetailBodyConstQuotation', numberOfColumns: 3, titleText: 'Body Const'},
                          {startColumnName: 'salesOrderItemDetailTypeDesignQuotation', numberOfColumns: 3, titleText: 'Type Design'},
                          {startColumnName: 'salesOrderItemDetailSeatDesignQuotation', numberOfColumns: 3, titleText: 'Seat Design'},
                          {startColumnName: 'salesOrderItemDetailSizeQuotation', numberOfColumns: 3, titleText: 'Size'},
                          {startColumnName: 'salesOrderItemDetailRatingQuotation', numberOfColumns: 3, titleText: 'Rating'},
                          {startColumnName: 'salesOrderItemDetailBoreQuotation', numberOfColumns: 3, titleText: 'Bore'},
                          
                          {startColumnName: 'salesOrderItemDetailEndConQuotation', numberOfColumns: 3, titleText: 'End Con'},
                          {startColumnName: 'salesOrderItemDetailBodyQuotation', numberOfColumns: 3, titleText: 'Body'},
                          {startColumnName: 'salesOrderItemDetailBallQuotation', numberOfColumns: 3, titleText: 'Ball'},
                          {startColumnName: 'salesOrderItemDetailSeatQuotation', numberOfColumns: 3, titleText: 'Seat'},
                          {startColumnName: 'salesOrderItemDetailSeatInsertQuotation', numberOfColumns: 3, titleText: 'Seat Insert'},
                          {startColumnName: 'salesOrderItemDetailStemQuotation', numberOfColumns: 3, titleText: 'Stem'},
                          
                          {startColumnName: 'salesOrderItemDetailSealQuotation', numberOfColumns: 3, titleText: 'Seal'},
                          {startColumnName: 'salesOrderItemDetailBoltQuotation', numberOfColumns: 3, titleText: 'Bolt'},
                          {startColumnName: 'salesOrderItemDetailDiscQuotation', numberOfColumns: 3, titleText: 'Disc'},
                          {startColumnName: 'salesOrderItemDetailPlatesQuotation', numberOfColumns: 3, titleText: 'Plates'},
                          {startColumnName: 'salesOrderItemDetailShaftQuotation', numberOfColumns: 3, titleText: 'Shaft'},
                          {startColumnName: 'salesOrderItemDetailSpringQuotation', numberOfColumns: 3, titleText: 'Spring'},
                          
                          {startColumnName: 'salesOrderItemDetailArmPinQuotation', numberOfColumns: 3, titleText: 'Arm Pin'},
                          {startColumnName: 'salesOrderItemDetailBackSeatQuotation', numberOfColumns: 3, titleText: 'Back Seat'},
                          {startColumnName: 'salesOrderItemDetailArmQuotation', numberOfColumns: 3, titleText: 'Arm'},
                          {startColumnName: 'salesOrderItemDetailHingePinQuotation', numberOfColumns: 3, titleText: 'Hinge Pin'},
                          {startColumnName: 'salesOrderItemDetailStopPinQuotation', numberOfColumns: 3, titleText: 'Stop Pin'},
                          {startColumnName: 'salesOrderItemDetailOperatorQuotation', numberOfColumns: 3, titleText: 'Operator'}
                    ]
                });
        }

    $(document).ready(function() {
        flagIsConfirmedSO=false;
        flagIsConfirmedSOSalesQuotation=false;
        flagIsConfirmedSOItemDelivery=false;
        $("#frmSalesOrderInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        
       
        
        formatNumericSO();
        $("#msgSalesOrderActivity").html(" - <i>" + $("#enumSalesOrderActivity").val()+"<i>").show();
        setSalesOrderPartialShipmentStatusStatus();
        
        $('input[name="salesOrderPartialShipmentStatusRad"][value="YES"]').change(function(ev){
            $("#salesOrder\\.customerPurchaseOrder\\.partialShipmentStatus").val("YES");
        });
        
        $('input[name="salesOrderPartialShipmentStatusRad"][value="NO"]').change(function(ev){
            $("#salesOrder\\.customerPurchaseOrder\\.partialShipmentStatus").val("NO");
        });
        
        $('input[name="salesOrderOrderStatusRad"][value="SALES_ORDER"]').change(function(ev){
            var value="SALES_ORDER";
            $("#salesOrder\\.orderStatus").val(value);
        });
                
        $('input[name="salesOrderOrderStatusRad"][value="SALES_ORDER"]').change(function(ev){
            var value="SALES_ORDER";
            $("#salesOrder\\.orderStatus").val(value);
        });
        
        $('#salesOrderOrderStatusRadSALES_ORDER').prop('checked',true);
        $("#salesOrder\\.orderStatus").val("SALES_ORDER");
        
        //Set Default View
        $("#btnUnConfirmSalesOrder").css("display", "none");
        $("#btnUnConfirmSalesOrderSalesQuotation").css("display", "none");
        $("#btnUnConfirmSalesOrderItemDetailDelivery").css("display", "none");
        $("#btnConfirmSalesOrderSalesQuotation").css("display", "none");
        $("#btnConfirmSalesOrderSalesQuotationDetailSort").css("display", "none");
        $("#btnConfirmSalesOrderItemDetailDelivery").css("display", "none");
        $("#btnSOSearchSalQuo").css("display", "none");
        $('#salesOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-payment-item-delivery-so').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-item-delivery-detail-so').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmSalesOrder").click(function(ev) {
            
            if(!$("#frmSalesOrderInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                return;
            }
            
            var date1 = dtpSalesOrderTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#salesOrderTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($('#enumSalesOrderActivity').val() === 'REVISE'){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#salesOrderTransactionDate").val(),dtpSalesOrderTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpSalesOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($('#enumSalesOrderActivity').val() === 'REVISE'){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#salesOrderTransactionDate").val(),dtpSalesOrderTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpSalesOrderTransactionDate);
                }
                return;
            }
            
            if(parseFloat(txtSalesOrderRetention.val())===0.00){
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
                                        flagIsConfirmedSO=true;
                                        flagIsConfirmedSOSalesQuotation=false;
                                        $("#btnUnConfirmSalesOrder").css("display", "block");
                                        $("#btnConfirmSalesOrder").css("display", "none");   
                                        $("#btnSOSearchSalQuo").css("display", "block");
                                        $('#headerSalesOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                        $("#btnConfirmSalesOrderSalesQuotation").show();
                                        $('#salesOrderSalesQuotationInputGrid').unblock();
                                        loadSalesOrderSalesQuotation();
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
                flagIsConfirmedSO=true;
                flagIsConfirmedSOSalesQuotation=false;
                $("#btnUnConfirmSalesOrder").css("display", "block");
                $("#btnConfirmSalesOrder").css("display", "none");   
                $("#btnSOSearchSalQuo").css("display", "block");
                $('#headerSalesOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#btnConfirmSalesOrderSalesQuotation").show();
                $('#salesOrderSalesQuotationInputGrid').unblock();
                loadSalesOrderSalesQuotation();
            }           
        });
                
        $("#btnUnConfirmSalesOrder").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#salesOrderSalesQuotationInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){ 
                    $("#btnUnConfirmSalesOrder").css("display", "none");
                    $("#btnConfirmSalesOrder").css("display", "block");
                    $("#btnSOSearchSalQuo").css("display", "none");
                    $('#headerSalesOrderInput').unblock();
                    $('#salesOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    $("#btnConfirmSalesOrderSalesQuotation").css("display","none");
                    flagIsConfirmedSO=false;
                    flagIsConfirmedSOSalesQuotation=false;
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
                                flagIsConfirmedSO=false;
                                $("#salesOrderSalesQuotationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmSalesOrder").css("display", "none");
                                $("#btnSOSearchSalQuo").css("display", "none");
                                $("#btnConfirmSalesOrder").css("display", "block");
                                $('#headerSalesOrderInput').unblock();
                                $('#salesOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#btnConfirmSalesOrderSalesQuotation").css("display","none");
                                clearSalesOrderTransactionAmount();
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
        
        $("#btnConfirmSalesOrderSalesQuotation").click(function(ev) {
            if(flagIsConfirmedSO){
                
                if(salesOrderSalesQuotation_lastSel !== -1) {
                    $('#salesOrderSalesQuotationInput_grid').jqGrid("saveRow",salesOrderSalesQuotation_lastSel); 
                }

                var ids = jQuery("#salesOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#salesOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[i]); 

                    if(data.salesOrderSalesQuotationCode===""){
                        alertMessage("Sales Quotation Can't Empty!");
                        return;
                    }
                }
            
                $("#btnUnConfirmSalesOrder").css("display", "none");
                $("#btnSOSearchSalQuo").css("display", "none");
                $("#btnUnConfirmSalesOrderSalesQuotation").css("display", "block");
                $("#btnConfirmSalesOrderSalesQuotationDetailSort").css("display", "block");
                $("#btnConfirmSalesOrderItemDetailDelivery").css("display", "block");
                $("#btnConfirmSalesOrderSalesQuotation").css("display", "none");   
                $('#salesOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-so').unblock();
                flagIsConfirmedSOSalesQuotation=true;
                loadSalesOrderItemDetailRevise();
                loadSalesOrderAdditionalFee();
                loadSalesOrderPaymentTerm();
            }
        });
        
        $("#btnUnConfirmSalesOrderSalesQuotation").click(function(ev) {
            $("#salesOrderItemDetailInput_grid").jqGrid('destroyGroupHeader');
            $("#salesOrderItemDetailInput_grid").jqGrid('clearGridData');
            $("#salesOrderAdditionalFeeInput_grid").jqGrid('clearGridData');
            $("#salesOrderPaymentTermInput_grid").jqGrid('clearGridData');
            $("#salesOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmSalesOrder").css("display", "block");
            $("#btnUnConfirmSalesOrderSalesQuotation").css("display", "none");
            $("#btnConfirmSalesOrderSalesQuotationDetailSort").css("display", "none");
            $("#btnConfirmSalesOrderItemDetailDelivery").css("display", "none");
            $("#btnConfirmSalesOrderSalesQuotation").css("display", "block");
            $('#salesOrderSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery-so').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedSOSalesQuotation=false;
            clearSalesOrderTransactionAmount();
        });
        
        $("#btnConfirmSalesOrderItemDetailDelivery").click(function(ev) {
            if(flagIsConfirmedSO){
                
                if(salesOrderItemDetail_lastSel !== -1) {
                    $('#salesOrderItemDetailInput_grid').jqGrid("saveRow",salesOrderItemDetail_lastSel); 
                }
                if(salesOrderAdditionalFee_lastSel !== -1) {
                    $('#salesOrderAdditionalFeeInput_grid').jqGrid("saveRow",salesOrderAdditionalFee_lastSel); 
                }
                if(salesOrderPaymentTerm_lastSel !== -1) {
                    $('#salesOrderPaymentTermInput_grid').jqGrid("saveRow",salesOrderPaymentTerm_lastSel); 
                }
                
                var idj = jQuery("#salesOrderItemDetailInput_grid").jqGrid('getDataIDs');
                var idl = jQuery("#salesOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
                var idq = jQuery("#salesOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                
                for(var j=0; j<idj.length;j++){
                    var data = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',idj[j]);
                    
                    if(data.salesOrderItemDetailItemFinishGoodsCode === ""){
                        alertMessage("Item Finish Goods Code Must Be Filled!");
                        return;
                    }
                    
                    if(data.salesOrderItemDetailSortNo===""){
                        alertMessage("Sort No Can't Empty!");
                        return;
                    }
                
                    if(data.salesOrderItemDetailSortNo=== '0' ){
                        alertMessage("Sort No Can't Zero!");
                        return;
                    }
                
                    for(var i=j; i<=idj.length-1; i++){
                        var details = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',idj[i+1]);
                        if(data.salesOrderItemDetailSortNo === details.salesOrderItemDetailSortNo){
                            alertMessage("Sort No Can't Be The Same!");
                            return;
                        }
                    }

                    if(parseFloat(data.salesOrderItemDetailQuantity)===0.00){
                        alertMessage("Quantity Item Can't be 0!");
                        return;
                    }
                }
                
                for(var l=0; l<idl.length;l++){
                    var data = $("#salesOrderAdditionalFeeInput_grid").jqGrid('getRowData',idl[l]);
                    
                    if(data.salesOrderAdditionalFeeAdditionalFeeCode === ""){
                        alertMessage("Additional Fee Must Be Filled!");
                        return;
                    }
                    if(parseFloat(data.salesOrderAdditionalFeeQuantity === 0.00)){
                        alertMessage("Quantity Must Be Greater Than 0!");
                        return;
                    }
                    if(parseFloat(data.salesOrderAdditionalFeePrice === 0.00)){
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
                    var data = $("#salesOrderPaymentTermInput_grid").jqGrid('getRowData',idq[p]); 

                    if(data.salesOrderPaymentTermSortNO=== '0' ){
                        alertMessage("Payment Term Sort No Can't Zero!");
                        return;
                    }

                    if(data.salesOrderPaymentTermSortNO === " "){
                        alertMessage("Payment Term Sort No Can't Empty!");
                        return;
                    }

                    if(data.salesOrderPaymentTermPaymentTermName===""){
                        alertMessage("Payment Term Can't Empty!");
                        return;
                    }

                    if(parseFloat(data.salesOrderPaymentTermPercent)===0.00){
                        alertMessage("Percent Payment term Can't be 0!");
                        return;
                    }
                    totalPercentagePaymentTerm+=parseFloat(data.salesOrderPaymentTermPercent);
                }
                if(parseFloat(totalPercentagePaymentTerm.toFixed(2))!==100){
                    alertMessage("Total Percent Payment Term must be 100%, Can't less or greater than 100%!",400);
                    return;
                }
                
                
                $("#btnConfirmSalesOrderItemDetailDelivery").css("display", "none");   
                $("#btnUnConfirmSalesOrderItemDetailDelivery").css("display", "block");
                $("#btnConfirmSalesOrderSalesQuotationDetailSort").css("display", "none");
                $("#btnUnConfirmSalesOrderSalesQuotation").css("display", "none");
                $('#salesOrderSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-so').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-item-delivery-detail-so').unblock();
                loadSalesOrderItemDeliveryDate();
                flagIsConfirmedSOItemDelivery=true;
                
            }
        });
        
        $("#btnUnConfirmSalesOrderItemDetailDelivery").click(function(ev) {
            $("#salesOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmSalesOrderItemDetailDelivery").css("display", "none");
            $("#btnConfirmSalesOrderItemDetailDelivery").css("display", "block");
            $("#btnUnConfirmSalesOrderSalesQuotation").show();
            $("#btnConfirmSalesOrderSalesQuotationDetailSort").show();
            $('#salesOrderSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery-so').unblock();
            $('#id-tbl-additional-item-delivery-detail-so').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedSOItemDelivery=false;
        });
        
        $.subscribe("salesOrderSalesQuotationInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderSalesQuotation_lastSel) {

                $('#salesOrderSalesQuotationInput_grid').jqGrid("saveRow",salesOrderSalesQuotation_lastSel); 
                $('#salesOrderSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderSalesQuotation_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderItemDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderItemDetail_lastSel) {

                $('#salesOrderItemDetailInput_grid').jqGrid("saveRow",salesOrderItemDetail_lastSel); 
                $('#salesOrderItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderItemDetail_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderAdditionalFee_lastSel) {

                $('#salesOrderAdditionalFeeInput_grid').jqGrid("saveRow",salesOrderAdditionalFee_lastSel); 
                $('#salesOrderAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderAdditionalFee_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderPaymentTermInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderPaymentTerm_lastSel) {

                $('#salesOrderPaymentTermInput_grid').jqGrid("saveRow",salesOrderPaymentTerm_lastSel); 
                $('#salesOrderPaymentTermInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderPaymentTerm_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderPaymentTermInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==salesOrderItemDelivery_lastSel) {

                $('#salesOrderItemDeliveryInput_grid').jqGrid("saveRow",salesOrderItemDelivery_lastSel); 
                $('#salesOrderItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderItemDelivery_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnSalesOrderAdditionalFeeAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#salesOrderAdditionalFeeAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    salesOrderAdditionalFeeDelete                : "delete",
                    salesOrderAdditionalFeeSearchUnitOfMeasure   : "..."
                };
                salesOrderAdditionalFeeLastRowId++;
                $("#salesOrderAdditionalFeeInput_grid").jqGrid("addRowData", salesOrderAdditionalFeeLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#salesOrderAdditionalFeeInput_grid").jqGrid('setRowData',salesOrderAdditionalFeeLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnSalesOrderPaymentTermAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#salesOrderPaymentTermAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var idp = jQuery("#salesOrderPaymentTermInput_grid").jqGrid('getDataIDs');
                var number = idp.length+1;
                var defRow = {
                    salesOrderPaymentTermDelete                : "delete",
                    salesOrderPaymentTermSearchPaymentTerm     : "...",
                    salesOrderPaymentTermSortNO                : number
                };
                salesOrderPaymentTermLastRowId++;
                $("#salesOrderPaymentTermInput_grid").jqGrid("addRowData", salesOrderPaymentTermLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#salesOrderPaymentTermInput_grid").jqGrid('setRowData',salesOrderPaymentTermLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnSalesOrderItemDelieryAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#salesOrderItemDelieryAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    salesOrderItemDeliveryDelete              : "delete",
                    salesOrderItemDeliverySearchQuotation     : "..."
                };
                salesOrderItemDeliveryLastRowId++;
                $("#salesOrderItemDeliveryInput_grid").jqGrid("addRowData", salesOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#salesOrderItemDeliveryInput_grid").jqGrid('setRowData',salesOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnSalesOrderCopyFromDetail').click(function(ev) {
            
            $("#salesOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(salesOrderItemDetail_lastSel !== -1) {
                $('#salesOrderItemDetailInput_grid').jqGrid("saveRow",salesOrderItemDetail_lastSel); 
            }
            
            var ids = jQuery("#salesOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    salesOrderItemDeliveryDelete                 : "delete",
                    salesOrderItemDeliveryItemCode               : data.salesOrderItemDetailItem,
                    salesOrderItemDeliverySortNo                 : data.salesOrderItemDetailSortNo,
                    salesOrderItemDeliveryQuantity               : data.salesOrderItemDetailQuantity,
                    salesOrderItemDeliverySearchQuotation        : "...",
                    salesOrderItemDeliverySalesQuotationCode     : data.salesOrderItemDetailQuotationNo,
                    salesOrderItemDeliverySalesQuotationRefNo    : data.salesOrderItemDetailQuotationRefNo,
                    salesOrderItemDeliveryItemFinishGoodsCode    : data.salesOrderItemDetailItemFinishGoodsCode,   
                    salesOrderItemDeliveryItemFinishGoodsRemark  : data.salesOrderItemDetailItemFinishGoodsRemark
                };
                salesOrderItemDeliveryLastRowId++;
                $("#salesOrderItemDeliveryInput_grid").jqGrid("addRowData", salesOrderItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#salesOrderItemDeliveryInput_grid").jqGrid('setRowData',salesOrderItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnSalesOrderSave').click(function(ev) {
            
            if(!flagIsConfirmedSOSalesQuotation){
                return;
            }
            
            if(salesOrderItemDetail_lastSel !== -1) {
                $('#salesOrderItemDetailInput_grid').jqGrid("saveRow",salesOrderItemDetail_lastSel); 
            }
            
            if(salesOrderAdditionalFee_lastSel !== -1) {
                $('#salesOrderAdditionalFeeInput_grid').jqGrid("saveRow",salesOrderAdditionalFee_lastSel); 
            }
            
            if(salesOrderPaymentTerm_lastSel !== -1) {
                $('#salesOrderPaymentTermInput_grid').jqGrid("saveRow",salesOrderPaymentTerm_lastSel); 
            }
            
            if(salesOrderItemDelivery_lastSel !== -1) {
                $('#salesOrderItemDeliveryInput_grid').jqGrid("saveRow",salesOrderItemDelivery_lastSel); 
            }
            
            var listCustomerSalesOrderSalesQuotation = new Array(); 
            var listCustomerSalesOrderItemDetail = new Array(); 
            var listCustomerSalesOrderAdditionalFee = new Array(); 
            var listCustomerSalesOrderPaymentTerm = new Array(); 
            var listCustomerSalesOrderItemDeliveryDate = new Array(); 
            
            var idq = jQuery("#salesOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
            var idi = jQuery("#salesOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            var idf = jQuery("#salesOrderAdditionalFeeInput_grid").jqGrid('getDataIDs'); 
            var idp = jQuery("#salesOrderPaymentTermInput_grid").jqGrid('getDataIDs'); 
            var idd = jQuery("#salesOrderItemDeliveryInput_grid").jqGrid('getDataIDs'); 

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
                var data = $("#salesOrderSalesQuotationInput_grid").jqGrid('getRowData',idq[q]); 
                  
                var salesOrderSalesQuotation = { 
                    salesQuotation              : {code:data.salesOrderSalesQuotationCode}
                };
                listCustomerSalesOrderSalesQuotation[q] = salesOrderSalesQuotation;
            }
            
            //Item Detail
            for(var i=0;i < idi.length;i++){ 
                var data = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
//                var sortNo = [];
//                sortNo[i] = data.salesOrderItemDetailSortNo;
                
                if(data.salesOrderItemDetailSortNo===""){
                    alertMessage("Sort No Can't Empty!");
                    return;
                }
                
                if(data.salesOrderItemDetailSortNo=== '0' ){
                    alertMessage("Sort No Can't Zero!");
                    return;
                }
                
                for(var j=i; j<=idi.length-1; j++){
                var details = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',idi[j+1]);
                if(data.salesOrderItemDetailSortNo === details.salesOrderItemDetailSortNo){
                    alertMessage("Sort No Can't Be The Same!");
                    return;
                }
                }
                
                if(parseFloat(data.salesOrderItemDetailQuantity)===0.00){
                    alertMessage("Quantity Item Can't be 0!");
                    return;
                }

                var salesOrderItemDetail = { 
                    salesQuotation                            : {code:data.salesOrderItemDetailQuotationNo},
                    salesQuotationDetail                      : {code:data.salesOrderItemDetailQuotationNoDetailCode},
                    itemFinishGoods                           : {code:data.salesOrderItemDetailItemFinishGoodsCode},
                    quantity                                  : data.salesOrderItemDetailQuantity,
                    customerPurchaseOrderSortNo               : data.salesOrderItemDetailSortNo,
                    itemAlias                                 : data.salesOrderItemDetailItemAlias,
                    valveTag                                  : data.salesOrderItemDetailValveTag,
                    dataSheet                                 : data.salesOrderItemDetailDataSheet,
                    description                               : data.salesOrderItemDetailDescription
                };
                listCustomerSalesOrderItemDetail[i] = salesOrderItemDetail;
            }
            
            //Additional Fee
            for(var f=0;f < idf.length;f++){ 
                var data = $("#salesOrderAdditionalFeeInput_grid").jqGrid('getRowData',idf[f]); 

                if(data.salesOrderAdditionalFeeRemark===""){
                    alertMessage("Remark Additional Fee Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.salesOrderAdditionalFeeQuantity)===0.00){
                    alertMessage("Quantity Additional Fee Can't be 0!");
                    return;
                }
                                
                if(data.salesOrderAdditionalFeeUnitOfMeasureCode===""){
                    alertMessage("Unit Additional Fee Can't Empty!");
                    return;
                }
                
                if(parseFloat(data.salesOrderAdditionalFeePrice)===0.00){
                    alertMessage("Price Additional Fee Can't be 0!");
                    return;
                }
                
                var salesOrderAdditionalFee = { 
                    remark          : data.salesOrderAdditionalFeeRemark,
                    unitOfMeasure   : {code:data.salesOrderAdditionalFeeUnitOfMeasureCode},
                    additionalFee   : {code:data.salesOrderAdditionalFeeAdditionalFeeCode},
                    price           : data.salesOrderAdditionalFeePrice,
                    quantity        : data.salesOrderAdditionalFeeQuantity,
                    total           : data.salesOrderAdditionalFeeTotal
                };
                listCustomerSalesOrderAdditionalFee[f] = salesOrderAdditionalFee;
            }
            
            //Payment term
            var totalPercentagePaymentTerm=0;
            for(var p=0;p < idp.length;p++){ 
                var data = $("#salesOrderPaymentTermInput_grid").jqGrid('getRowData',idp[p]); 
                
                if(data.salesOrderPaymentTermSortNO=== '0' ){
                    alertMessage("Sort No Payment Term Can't Zero!");
                    return;
                }
                
                if(data.salesOrderPaymentTermSortNO === " "){
                    alertMessage("Sort No Payment Term Can't Empty!");
                    return;
                }
                
                if(data.salesOrderPaymentTermPaymentTermName===""){
                    alertMessage("Payment Term Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.salesOrderPaymentTermPercent)===0.00){
                    alertMessage("Percent Payment term Can't be 0!");
                    return;
                }
                
                var salesOrderPaymentTerm = { 
                    sortNo          : data.salesOrderPaymentTermSortNO,
                    paymentTerm     : {code:data.salesOrderPaymentTermPaymentTermCode},
                    percentage      : data.salesOrderPaymentTermPercent,
                    remark          : data.salesOrderPaymentTermRemark
                };
                listCustomerSalesOrderPaymentTerm[p] = salesOrderPaymentTerm;
                totalPercentagePaymentTerm+=parseFloat(data.salesOrderPaymentTermPercent);
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
                var data = $("#salesOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[d]); 
                var deliveryDate = formatDate(data.salesOrderItemDeliveryDeliveryDate,false);
                 var deliveryDate = data.salesOrderItemDeliveryDeliveryDate.split('/');
                var deliveryDateNew = deliveryDate[1]+"/"+deliveryDate[0]+"/"+deliveryDate[2];
//                if(data.salesOrderItemDeliveryItemCode===""){
//                    alertMessage("Item Delivery Can't Empty!");
//                    return;
//                }
                
                if(data.salesOrderItemDeliveryDeliveryDate===""){
                    alertMessage("Delivery Date Can't Empty!");
                    return;
                }
                                
                if(parseFloat(data.salesOrderItemDeliveryQuantity)===0.00){
                    alertMessage("Quantity Delivery Can't be 0!");
                    return;
                }
                
                if(data.salesOrderItemDeliverySalesQuotationCode===""){
                    alertMessage("Quotation Date Can't Empty!");
                    return;
                }
                
                var salesOrderItemDeliveryDate = { 
                    itemFinishGoods     : {code:data.salesOrderItemDeliveryItemFinishGoodsCode},
                    salesQuotation      : {code:data.salesOrderItemDeliverySalesQuotationCode},
                    quantity            : data.salesOrderItemDeliveryQuantity,
                    deliveryDate        : deliveryDateNew
                };
                listCustomerSalesOrderItemDeliveryDate[d] = salesOrderItemDeliveryDate;
            }
            var sumQuantityGroupItem=0;
            
            for(var i=0;i < idi.length;i++){
                var data = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',idi[i]);
                sumQuantityGroupItem=0;
                for(var j=0;j < idd.length;j++){
                    var dataDelivery = $("#salesOrderItemDeliveryInput_grid").jqGrid('getRowData',idd[j]);
                    
                    if(data.salesOrderItemDetailQuotationNo === dataDelivery.salesOrderItemDeliverySalesQuotationCode){
                        if(data.salesOrderItemDetailItemFinishGoodsCode === dataDelivery.salesOrderItemDeliveryItemFinishGoodsCode){
                            if(data.salesOrderItemDetailSortNo === dataDelivery.salesOrderItemDeliverySortNo){
                                sumQuantityGroupItem += parseFloat(dataDelivery.salesOrderItemDeliveryQuantity);
    //                            alert(data.salesOrderItemDetailQuantity);
                            }
                        }
                    }
                }

                if(parseFloat(data.salesOrderItemDetailQuantity)!==sumQuantityGroupItem){
                    alertMessage("Sum Of Quantity Item </br> "+data.salesOrderItemDetailQuotationNo+" Must be Equal with Quantity Item Detail!");
                    return;
                }
                
            }
            
            formatDateSO();
            unFormatNumericSO();
            
            var url = "sales/customer-sales-order-save";
            var params = $("#frmSalesOrderInput").serialize();
                params += "&listCustomerSalesOrderSalesQuotationJSON=" + $.toJSON(listCustomerSalesOrderSalesQuotation);
                params += "&listCustomerSalesOrderItemDetailJSON=" + $.toJSON(listCustomerSalesOrderItemDetail);
                params += "&listCustomerSalesOrderAdditionalFeeJSON=" + $.toJSON(listCustomerSalesOrderAdditionalFee);
                params += "&listCustomerSalesOrderPaymentTermJSON=" + $.toJSON(listCustomerSalesOrderPaymentTerm);
                params += "&listCustomerSalesOrderItemDeliveryJSON=" + $.toJSON(listCustomerSalesOrderItemDeliveryDate);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateSO();
                    formatNumericSO();
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
                                        var params = "enumSalesOrderActivity=REVISE";
                                        var url = "sales/customer-sales-order-input";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_SALES_ORDER");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/customer-sales-order";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_SALES_ORDER");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnSalesOrderCancel').click(function(ev) {
            var url = "sales/customer-sales-order";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_SALES_ORDER"); 
        });
        
        $('#salesOrder_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=salesOrder&idsubdoc=branch","Search", "width=600, height=500");
        });

        $('#salesOrder_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=salesOrder&idsubdoc=customer","Search", "width=600, height=500");
        });
        
        $('#salesOrder_btnCustomerEndUser').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=salesOrder&idsubdoc=endUser","Search", "width=600, height=500");
        });
        
        
        $('#salesOrder_btnSalesPerson').click(function(ev) {
            window.open("./pages/search/search-sales-person.jsp?iddoc=salesOrder&idsubdoc=salesPerson","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#salesOrder_btnProject').click(function(ev) {
            window.open("./pages/search/search-project.jsp?iddoc=salesOrder&idsubdoc=project","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#salesOrder_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=salesOrder&idsubdoc=currency","Search", "width=600, height=500");
        });
        
        $('#salesOrder_btnDiscountAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=salesOrder&idsubdoc=discountAccount","Search", "width=600, height=500");
        });
        
        $('#btnSalesOrderDeliveryDateSet').click(function(ev) {
            if(salesOrderItemDelivery_lastSel !== -1) {
                $('#salesOrderItemDeliveryInput_grid').jqGrid("saveRow",salesOrderItemDelivery_lastSel); 
            }
            
            var deliveryDate=$("#salesOrderDeliveryDateSet").val();
            var ids = jQuery("#salesOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#salesOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "salesOrderItemDeliveryDeliveryDate",deliveryDate);
                $("#salesOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "salesOrderItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
        
        $('#btnConfirmSalesOrderSalesQuotationDetailSort').click(function(ev) {
             if($("#salesOrderItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Sales Quotation Can't Be Empty!");
                return;}
            }
            
            if(salesOrderItemDetail_lastSel !== -1) {
                $('#salesOrderItemDetailInput_grid').jqGrid("saveRow",salesOrderItemDetail_lastSel);  
            }
            
            var ids = jQuery("#salesOrderItemDetailInput_grid").jqGrid('getDataIDs');
            var listSalesQuotationDetail = new Array();

            for(var k=0;k<ids.length;k++){
                var detail = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',ids[k]);
                
                if(detail.salesOrderItemDetailSortNo===""){
                    alertMessage("Sort No Can't Empty!");
                    return;
                }

                if(detail.salesOrderItemDetailSortNo=== '0' ){
                    alertMessage("Sort No Can't Zero!");
                    return;
                }
                
                for(var j=k; j<=ids.length-1; j++){
                var details = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',ids[j+1]);
                if(detail.salesOrderItemDetailSortNo === details.salesOrderItemDetailSortNo){
                    alertMessage("Sort No Can't Be The Same!");
                    return;
                }
              }
            
            var data = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',ids[k]);    
            var salesOrderItemDetail = { 
                    salesQuotation              : {code:data.salesOrderItemDetailQuotationNo},
                    refNo                       : data.salesOrderItemDetailQuotationRefNo,
                    salesQuotationDetail        : data.salesOrderItemDetailQuotationNoDetailCode,
                    sort                        : data.salesOrderItemDetailSortNo,
                    itemFinishGoodsCode         : data.salesOrderItemDetailItemFinishGoodsCode,
                    itemFinishGoodsName         : data.salesOrderItemDetailItemFinishGoodsName,
                    itemFinishGoodsRemark       : data.salesOrderItemDetailItemFinishGoodsRemark,
                    valveTypeCode               : data.salesOrderItemDetailValveTypeCode,
                    valveTypeName               : data.salesOrderItemDetailValveTypeName,
                    valveTag                    : data.salesOrderItemDetailValveTag,
                    dataSheet                   : data.salesOrderItemDetailDataSheet,
                    dataDescription             : data.salesOrderItemDetailDescription,
                    itemAlias                   : data.salesOrderItemDetailItemAlias,
                    
                    //01
                    bodyConstQuo                : data.salesOrderItemDetailBodyConstQuotation,
                    bodyConstFinishGoodCode     : data.salesOrderItemDetailItemFinishGoodsBodyConstCode,
                    bodyConstFinishGoodName     : data.salesOrderItemDetailItemFinishGoodsBodyConstName,
                    //02
                    typeDesignQuo               : data.salesOrderItemDetailTypeDesignQuotation,
                    typeDesignFinishGoodCode    : data.salesOrderItemDetailItemFinishGoodsTypeDesignCode,
                    typeDesignFinishGoodName    : data.salesOrderItemDetailItemFinishGoodsTypeDesignName,
                    //03
                    seatDesignQuo               : data.salesOrderItemDetailSeatDesignQuotation,
                    seatDesignFinishGoodCode    : data.salesOrderItemDetailItemFinishGoodsSeatDesignCode,
                    seatDesignFinishGoodName    : data.salesOrderItemDetailItemFinishGoodsSeatDesignName,
                    //04
                    sizeQuo                     : data.salesOrderItemDetailSizeQuotation,
                    sizeFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsSizeCode,
                    sizeFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsSizeName,
                    //05
                    ratingQuo                   : data.salesOrderItemDetailRatingQuotation,
                    ratingFinishGoodCode        : data.salesOrderItemDetailItemFinishGoodsRatingCode,
                    ratingFinishGoodName        : data.salesOrderItemDetailItemFinishGoodsRatingName,
                    //06
                    boreQuo                     : data.salesOrderItemDetailBoreQuotation,
                    boreFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsBoreCode,
                    boreFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsBoreName,
                    
                    //07
                    endConQuo                   : data.salesOrderItemDetailEndConQuotation,
                    endConFinishGoodCode        : data.salesOrderItemDetailItemFinishGoodsEndConCode,
                    endConFinishGoodName        : data.salesOrderItemDetailItemFinishGoodsEndConName,
                    
                    //08
                    bodyQuo                     : data.salesOrderItemDetailBodyQuotation,
                    bodyFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsBodyCode,
                    bodyFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsBodyName,
                    
                    //09
                    ballQuo                     : data.salesOrderItemDetailBallQuotation,
                    ballFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsBallCode,
                    ballFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsBallName,
                    
                    //10
                    seatQuo                     : data.salesOrderItemDetailSeatQuotation,
                    seatFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsSeatCode,
                    seatFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsSeatName,
                    
                    //11
                    seatInsertQuo                     : data.salesOrderItemDetailSeatInsertQuotation,
                    seatInsertFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsSeatInsertCode,
                    seatInsertFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsSeatInsertName,
                    
                    //12
                    stemQuo                     : data.salesOrderItemDetailStemQuotation,
                    stemFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsStemCode,
                    stemFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsStemName,
                    
                    //13
                    sealQuo                     : data.salesOrderItemDetailSealQuotation,
                    sealFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsSealCode,
                    sealFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsSealName,
                    
                    //14
                    boltQuo                     : data.salesOrderItemDetailBoltQuotation,
                    boltFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsBoltCode,
                    boltFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsBoltName,
                    
                    //15
                    discQuo                     : data.salesOrderItemDetailDiscQuotation,
                    discFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsDiscCode,
                    discFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsDiscName,
                    
                    //16
                    platesQuo                     : data.salesOrderItemDetailPlatesQuotation,
                    platesFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsPlatesCode,
                    platesFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsPlatesName,
                    
                    //17
                    shaftQuo                     : data.salesOrderItemDetailShaftQuotation,
                    shaftFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsShaftCode,
                    shaftFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsShaftName,
                    
                    //18
                    springQuo                     : data.salesOrderItemDetailSpringQuotation,
                    springFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsSpringCode,
                    springFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsSpringName,
                    
                    //19
                    armPinQuo                     : data.salesOrderItemDetailArmPinQuotation,
                    armPinFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsArmPinCode,
                    armPinFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsArmPinName,
                    
                    //20
                    backSeatQuo                     : data.salesOrderItemDetailBackSeatQuotation,
                    backSeatFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsBackSeatCode,
                    backSeatFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsBackSeatName,
                    
                    //21
                    armQuo                     : data.salesOrderItemDetailArmQuotation,
                    armFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsArmCode,
                    armFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsArmName,
                    
                    //22
                    hingePinQuo                     : data.salesOrderItemDetailHingePinQuotation,
                    hingePinFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsHingePinCode,
                    hingePinFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsHingePinName,
                    
                    //23
                    stopPinQuo                     : data.salesOrderItemDetailStopPinQuotation,
                    stopPinFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsStopPinCode,
                    stopPinFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsStopPinName,
                    
                    //24
                    operatorQuo                     : data.salesOrderItemDetailOperatorQuotation,
                    operatorFinishGoodCode          : data.salesOrderItemDetailItemFinishGoodsOperatorCode,
                    operatorFinishGoodName          : data.salesOrderItemDetailItemFinishGoodsOperatorName,
                    
                    note                        : data.salesOrderItemDetailNote,
                    price                       : data.salesOrderItemDetailPrice,
                    total                       : data.salesOrderItemDetailTotal,
                    quantity                    : data.salesOrderItemDetailQuantity
                    
                };
                listSalesQuotationDetail[k] = salesOrderItemDetail;
            }
            
             var result = Enumerable.From(listSalesQuotationDetail)
                            .OrderBy('$.sort')
                            .Select()
                            .ToArray();
            
            $("#salesOrderItemDetailInput_grid").jqGrid('clearGridData');
            salesOrderItemDetail_lastSel = 0;
                for(var i = 0; i < result.length; i++){
                    salesOrderItemDetail_lastSel ++;
                    $("#salesOrderItemDetailInput_grid").jqGrid("addRowData",salesOrderItemDetail_lastSel, result[i]);
                    $("#salesOrderItemDetailInput_grid").jqGrid('setRowData',salesOrderItemDetail_lastSel,{
                        
                    salesOrderItemDetailQuotationNo                      : result[i].salesQuotation.code,
                    salesOrderItemDetailQuotationRefNo                   : result[i].refNo,
                    salesOrderItemDetailQuotationNoDetailCode            : result[i].salesQuotationDetail,
                    salesOrderItemDetailSortNo                           : result[i].sort,
                    salesOrderItemDetailItemFinishGoodsCode              : result[i].itemFinishGoodsCode,
                    salesOrderItemDetailItemFinishGoodsName              : result[i].itemFinishGoodsName,
                    salesOrderItemDetailItemFinishGoodsRemark            : result[i].itemFinishGoodsRemark,
                    salesOrderItemDetailValveTypeCode                    : result[i].valveTypeCode,
                    salesOrderItemDetailValveTypeName                    : result[i].valveTypeName,
                    salesOrderItemDetailValveTag                         : result[i].valveTag,
                    salesOrderItemDetailDataSheet                        : result[i].dataSheet,
                    salesOrderItemDetailDescription                      : result[i].dataDescription,
                    salesOrderItemDetailItemAlias                        : result[i].itemAlias,
                    //01
                    salesOrderItemDetailBodyConstQuotation               : result[i].bodyConstQuo,
                    salesOrderItemDetailItemFinishGoodsBodyConstCode     : result[i].bodyConstFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsBodyConstName     : result[i].bodyConstFinishGoodName,
                    //02
                    salesOrderItemDetailTypeDesignQuotation               : result[i].typeDesignQuo,
                    salesOrderItemDetailItemFinishGoodsTypeDesignCode     : result[i].typeDesignFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsTypeDesignName     : result[i].typeDesignFinishGoodName,
                    //03
                    salesOrderItemDetailSeatDesignQuotation               : result[i].seatDesignQuo,
                    salesOrderItemDetailItemFinishGoodsSeatDesignCode     : result[i].seatDesignFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsSeatDesignName     : result[i].seatDesignFinishGoodName,
                    //04
                    salesOrderItemDetailSizeQuotation               : result[i].sizeQuo,
                    salesOrderItemDetailItemFinishGoodsSizeCode     : result[i].sizeFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsSizeName     : result[i].sizeFinishGoodName,
                    //05
                    salesOrderItemDetailRatingQuotation               : result[i].ratingQuo,
                    salesOrderItemDetailItemFinishGoodsRatingCode     : result[i].ratingFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsRatingName     : result[i].ratingFinishGoodName,
                    //06
                    salesOrderItemDetailBoreQuotation               : result[i].boreQuo,
                    salesOrderItemDetailItemFinishGoodsBoreCode     : result[i].boreFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsBoreName     : result[i].boreFinishGoodName,
                    //07
                    salesOrderItemDetailEndConQuotation               : result[i].endConQuo,
                    salesOrderItemDetailItemFinishGoodsEndConCode     : result[i].endConFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsEndConName     : result[i].endConFinishGoodName,
                    //08
                    salesOrderItemDetailBodyQuotation               : result[i].bodyQuo,
                    salesOrderItemDetailItemFinishGoodsBodyCode     : result[i].bodyFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsBodyName     : result[i].bodyFinishGoodName,
                    //09
                    salesOrderItemDetailBallQuotation               : result[i].ballQuo,
                    salesOrderItemDetailItemFinishGoodsBallCode     : result[i].ballFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsBallName     : result[i].ballFinishGoodName,
                    //10
                    salesOrderItemDetailSeatQuotation               : result[i].seatQuo,
                    salesOrderItemDetailItemFinishGoodsSeatCode     : result[i].seatFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsSeatName     : result[i].seatFinishGoodName,
                    //11
                    salesOrderItemDetailSeatInsertQuotation               : result[i].seatInsertQuo,
                    salesOrderItemDetailItemFinishGoodsSeatInsertCode     : result[i].seatInsertFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsSeatInsertName     : result[i].seatInsertFinishGoodName,
                    //12
                    salesOrderItemDetailStemQuotation               : result[i].stemQuo,
                    salesOrderItemDetailItemFinishGoodsStemCode     : result[i].stemFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsStemName     : result[i].stemFinishGoodName,
                    //13
                    salesOrderItemDetailSealQuotation               : result[i].sealQuo,
                    salesOrderItemDetailItemFinishGoodsSealCode     : result[i].sealFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsSealName     : result[i].sealFinishGoodName,
                    //14
                    salesOrderItemDetailBoltQuotation               : result[i].boltQuo,
                    salesOrderItemDetailItemFinishGoodsBoltCode     : result[i].boltFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsBoltName     : result[i].boltFinishGoodName,
                    //15
                    salesOrderItemDetailDiscQuotation               : result[i].discQuo,
                    salesOrderItemDetailItemFinishGoodsDiscCode     : result[i].discFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsDiscName     : result[i].discFinishGoodName,
                    //16
                    salesOrderItemDetailPlatesQuotation               : result[i].platesQuo,
                    salesOrderItemDetailItemFinishGoodsPlatesCode     : result[i].platesFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsPlatesName     : result[i].platesFinishGoodName,
                    //17
                    salesOrderItemDetailShaftQuotation               : result[i].shaftQuo,
                    salesOrderItemDetailItemFinishGoodsShaftCode     : result[i].shaftFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsShaftName     : result[i].shaftFinishGoodName,
                    //18
                    salesOrderItemDetailSpringQuotation               : result[i].springQuo,
                    salesOrderItemDetailItemFinishGoodsSpringCode     : result[i].springFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsSpringName     : result[i].springFinishGoodName,
                    //19
                    salesOrderItemDetailArmPinQuotation               : result[i].armPinQuo,
                    salesOrderItemDetailItemFinishGoodsArmPinCode     : result[i].armPinFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsArmPinName     : result[i].armPinFinishGoodName,
                    //20
                    salesOrderItemDetailBackSeatQuotation               : result[i].backSeatQuo,
                    salesOrderItemDetailItemFinishGoodsBackSeatCode     : result[i].backSeatFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsBackSeatName     : result[i].backSeatFinishGoodName,
                    //21
                    salesOrderItemDetailArmQuotation               : result[i].armQuo,
                    salesOrderItemDetailItemFinishGoodsArmCode     : result[i].armFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsArmName     : result[i].armFinishGoodName,
                    //22
                    salesOrderItemDetailHingePinQuotation               : result[i].hingePinQuo,
                    salesOrderItemDetailItemFinishGoodsHingePinCode     : result[i].hingePinFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsHingePinName     : result[i].hingePinFinishGoodName,
                    //23
                    salesOrderItemDetailStopPinQuotation               : result[i].stopPinQuo,
                    salesOrderItemDetailItemFinishGoodsStopPinCode     : result[i].stopPinFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsStopPinName     : result[i].stopPinFinishGoodName,
                    //24
                    salesOrderItemDetailOperatorQuotation               : result[i].operatorQuo,
                    salesOrderItemDetailItemFinishGoodsOperatorCode     : result[i].operatorFinishGoodCode,
                    salesOrderItemDetailItemFinishGoodsOperatorName     : result[i].operatorFinishGoodName,
                    
                    salesOrderItemDetailNote                        : result[i].note,
                    salesOrderItemDetailPrice                       : result[i].price,
                    salesOrderItemDetailTotal                       : result[i].total,
                    salesOrderItemDetailQuantity                    : result[i].quantity
               });    
            }
        }); 
        
        $('#btnSOSearchSalQuo').click(function(ev) {
            var ids = jQuery("#salesOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
            var customer=txtSalesOrderCustomerCode.val();
            var customerName=txtSalesOrderCustomerName.val();
            var endUser=txtSalesOrderEndUserCode.val();
            var endUserName=txtSalesOrderEndUserName.val();
            var salesPerson=txtSalesOrderSalesPersonCode.val();
            var salesPersonName=txtSalesOrderSalesPersonName.val();
            var project=txtSalesOrderProjectCode.val();
            var projectName=txtSalesOrderProjectName.val();
            var currency=txtSalesOrderCurrencyCode.val();
            var currencyName=txtSalesOrderCurrencyName.val();
            var branch = txtSalesOrderBranchCode.val();
            var branchName = txtSalesOrderBranchName.val();
            var orderStatus = $("#salesOrder\\.orderStatus").val();
            window.open("./pages/search/search-sales-quotation-multiple.jsp?iddoc=salesOrderSalesQuotation&type=grid&rowLast="+ids.length+
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
            "&firstDate="+$("#salesOrderDateFirstSession").val()+"&lastDate="+$("#salesOrderDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
        });
        
    }); //EOF Ready
    
    function addRowDataMultiSelectedSO(lastRowId,defRow){
        
        var ids = jQuery("#salesOrderSalesQuotationInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
            $("#salesOrderSalesQuotationInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#salesOrderSalesQuotationInput_grid").jqGrid('setRowData',lastRowId,{
                    salesOrderSalesQuotationDelete              : defRow.salesOrderSalesQuotationDelete,
                    salesOrderSalesQuotationCode                : defRow.salesOrderSalesQuotationCode,
                    salesOrderSalesQuotationTransactionDate     : defRow.salesOrderSalesQuotationTransactionDate,
                    salesOrderSalesQuotationCustomerCode        : defRow.salesOrderSalesQuotationCustomerCode,
                    salesOrderSalesQuotationCustomerName        : defRow.salesOrderSalesQuotationCustomerName,
                    salesOrderSalesQuotationEndUserCode         : defRow.salesOrderSalesQuotationEndUserCode,
                    salesOrderSalesQuotationEndUserName         : defRow.salesOrderSalesQuotationEndUserName,
                    salesOrderSalesQuotationRfqCode             : defRow.salesOrderSalesQuotationRfqCode,
                    salesOrderSalesQuotationProjectCode         : defRow.salesOrderSalesQuotationProjectCode,
                    salesOrderSalesQuotationSubject             : defRow.salesOrderSalesQuotationSubject,
                    salesOrderSalesQuotationAttn                : defRow.salesOrderSalesQuotationAttn,
                    salesOrderSalesQuotationRefNo               : defRow.salesOrderSalesQuotationRefNo,
                    salesOrderSalesQuotationRemark              : defRow.salesOrderSalesQuotationRemark
            });
            
        setHeightGridSOSalQuoDetail();
 }
    
    // function Grid Detail
    function setHeightGridSOSalQuoDetail(){
        var ids = jQuery("#salesOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#salesOrderSalesQuotationInput_grid"+" tr").eq(1).height();
            $("#salesOrderSalesQuotationInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#salesOrderSalesQuotationInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateSO(){
        var transactionDateSplit=dtpSalesOrderTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpSalesOrderTransactionDate.val(transactionDate);
        
        var createdDate=$("#salesOrder\\.createdDate").val();
        $("#salesOrder\\.createdDateTemp").val(createdDate);
        
    }

    function unFormatNumericSO(){
        var retention =removeCommas(txtSalesOrderRetention.val());
        txtSalesOrderRetention.val(retention);
        
        var totalTransactionAmount =removeCommas(txtSalesOrderTotalTransactionAmount.val());
        txtSalesOrderTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtSalesOrderDiscountAmount.val());
        txtSalesOrderDiscountAmount.val(discountAmount);
        var taxBaseAmount =removeCommas(txtSalesOrderTaxBaseAmount.val());
        txtSalesOrderTaxBaseAmount.val(taxBaseAmount);
        var vatPercent =removeCommas(txtSalesOrderVATPercent.val());
        txtSalesOrderVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtSalesOrderVATAmount.val());
        txtSalesOrderVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtSalesOrderGrandTotalAmount.val());
        txtSalesOrderGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericSO(){
        
        var retention =parseFloat(txtSalesOrderRetention.val());
        txtSalesOrderRetention.val(formatNumber(retention,2));
        
        var totalTransactionAmount =parseFloat(txtSalesOrderTotalTransactionAmount.val());
        txtSalesOrderTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtSalesOrderDiscountPercent.val());
        txtSalesOrderDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtSalesOrderDiscountAmount.val());
        txtSalesOrderDiscountAmount.val(formatNumber(discountAmount,2));
        var taxBaseAmount =parseFloat(txtSalesOrderTaxBaseAmount.val());
        txtSalesOrderTaxBaseAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtSalesOrderVATPercent.val());
        txtSalesOrderVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtSalesOrderVATAmount.val());
        txtSalesOrderVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtSalesOrderGrandTotalAmount.val());
        txtSalesOrderGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }    
    
    function clearSalesOrderTransactionAmount(){
        txtSalesOrderTotalTransactionAmount.val("0.00");        
        txtSalesOrderDiscountPercent.val("0.00");
        txtSalesOrderDiscountAmount.val("0.00");
        txtSalesOrderTotalAdditionalFee.val("0.00");
        txtSalesOrderTaxBaseAmount.val("0.00");
        txtSalesOrderVATPercent.val("0.00");
        txtSalesOrderVATAmount.val("0.00");
        txtSalesOrderGrandTotalAmount.val("0.00");
    }
    
    function calculateItemSalesQuotationDetailReleaseSO(){

        var selectedRowID = $("#salesOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#salesOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = salesOrderItemDetailLastRowId;
        }
        var qty = $("#" + selectedRowID + "_salesOrderItemDetailQuantity").val();
        var unitPrice = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData', selectedRowID);
        var amount = unitPrice.salesOrderItemDetailPrice;

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#salesOrderItemDetailInput_grid").jqGrid("setCell", selectedRowID, "salesOrderItemDetailTotal", subAmount);

        calculateSalesOrderHeader();
    }
    
    function calculateSalesOrderAdditionalFee() {
        var selectedRowID = $("#salesOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var qty = $("#" + selectedRowID + "_salesOrderAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_salesOrderAdditionalFeePrice").val();
        
        var subTotal = (parseFloat(qty) * parseFloat(price));
        
        $("#salesOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "salesOrderAdditionalFeeTotal", subTotal);

        calculateSalesOrderTotalAdditional();
    }
    
    function calculateSalesOrderTotalAdditional() {
        var totalAmount =0;
        var ids = jQuery("#salesOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#salesOrderAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.salesOrderAdditionalFeeTotal);
        }   
        
        txtSalesOrderTotalAdditionalFee.val(formatNumber(totalAmount,2));
        calculateSalesOrderHeader();

    }
    
    function calculateSalesOrderHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var additionalFeeAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#salesOrderItemDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.salesOrderItemDetailTotal);
        }   
        txtSalesOrderTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtSalesOrderTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtSalesOrderDiscountPercent.val()));        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtSalesOrderDiscountAmount.val()===""){
            discAmount=0;
        }
        
        additionalFeeAmount=parseFloat(removeCommas(txtSalesOrderTotalAdditionalFee.val()));  
        
        subTotal = (totalTransaction-discAmount)+additionalFeeAmount;
        
        if(txtSalesOrderVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtSalesOrderVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtSalesOrderDiscountAmount.val(formatNumber(discAmount,2));
        txtSalesOrderTaxBaseAmount.val(formatNumber(subTotal,2));
        txtSalesOrderVATAmount.val(formatNumber(vatAmount,2));        
        txtSalesOrderGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onchangeAdditionalFeeCodeSO(){
        var selectedRowID = $("#salesOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var additionalFeeCode = $("#" + selectedRowID + "_salesOrderAdditionalFeeAdditionalFeeCode").val();

        var url = "master/additional-fee-get-sales";
        var params = "additionalFee.code=" + additionalFeeCode;
            params+= "&additionalFee.activeStatus=TRUE";
            params+= "&additionalFee.salesStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.additionalFeeTemp){
                $("#salesOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"salesOrderAdditionalFeeAdditionalFeeCode",data.additionalFeeTemp.code);
                $("#salesOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"salesOrderAdditionalFeeAdditionalFeeName",data.additionalFeeTemp.name);
                $("#salesOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"salesOrderAdditionalFeeSalesChartOfAccountCode",data.additionalFeeTemp.salesChartOfAccountCode);
                $("#salesOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"salesOrderAdditionalFeeSalesChartOfAccountName",data.additionalFeeTemp.salesChartOfAccountName);
            }
            else{
                $("#" + selectedRowID + "_salesOrderAdditionalFeeAdditionalFeeCode").val("");
                $("#" + selectedRowID + "_salesOrderAdditionalFeeAdditionalFeeName").val("");
                $("#" + selectedRowID + "_salesOrderAdditionalFeeSalesChartOfAccountCode").val("");
                $("#" + selectedRowID + "_salesOrderAdditionalFeeSalesChartOfAccountName").val("");
                alert("Additional Fee Not Found","");
            }
        });
            
    }
    
    function onchangeAdditionalFeeUnitOfMeasureCodeSO(){
        var selectedRowID = $("#salesOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var uomCode = $("#" + selectedRowID + "_salesOrderAdditionalFeeUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + uomCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";
        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_salesOrderAdditionalFeeUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
            }
            else{
                $("#" + selectedRowID + "_salesOrderAdditionalFeeUnitOfMeasureCode").val("");
                alert("UOM Not Found","");
            }
        });
            
    }
    
    function onchangePaymentTermPaymentTermCodeSO(){
        var selectedRowID = $("#salesOrderPaymentTermInput_grid").jqGrid("getGridParam", "selrow");
        var paymentTermCode = $("#" + selectedRowID + "_salesOrderPaymentTermPaymentTermCode").val();

        var url = "master/payment-term-get";
        var params = "paymentTerm.code=" + paymentTermCode;
            params+= "&paymentTerm.activeStatus=TRUE";
        $.post(url, params, function(result){
            var data = (result);
            if (data.paymentTermTemp){
                $("#salesOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"salesOrderPaymentTermPaymentTermCode",data.paymentTermTemp.code);
                $("#salesOrderPaymentTermInput_grid").jqGrid("setCell", selectedRowID,"salesOrderPaymentTermPaymentTermName",data.paymentTermTemp.name);
            }
            else{
                $("#" + selectedRowID + "_salesOrderPaymentTermPaymentTermCode").val("");
                $("#" + selectedRowID + "_salesOrderPaymentTermPaymentTermName").val("");
                alert("Payment Term Not Found","");
            }
        });
            
    }
    
    function salesOrderSalesQuotationInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#salesOrderSalesQuotationInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#salesOrderSalesQuotationInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function salesOrderItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#salesOrderItemDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#salesOrderItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
        
        calculateSalesOrderHeader();
    }
    
    function salesOrderAdditionalFeeInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#salesOrderAdditionalFeeInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#salesOrderAdditionalFeeInput_grid").jqGrid('delRowData',selectDetailRowId);    
        calculateSalesOrderTotalAdditional();
    }
    
    function salesOrderPaymentTermInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#salesOrderPaymentTermInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#salesOrderPaymentTermInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function salesOrderItemDeliveryInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#salesOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#salesOrderItemDeliveryInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function onchangeSalesOrderItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#salesOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_salesOrderItemDeliveryDeliveryDate").val();
        
        $("#salesOrderItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "salesOrderItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    
    function loadSalesOrderSalesQuotation() {
        var enumSalesOrderActivity=$("#enumSalesOrderActivity").val();
        if(enumSalesOrderActivity==="NEW"){
            return;
        }                
        
        var url = "sales/customer-sales-order-sales-quotation-data";
        var params = "salesOrder.code="+$("#salesOrder\\.customerSalesOrderCode").val();
        
        salesOrderSalesQuotationLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderSalesQuotation.length; i++) {
                salesOrderSalesQuotationLastRowId++;
                
                $("#salesOrderSalesQuotationInput_grid").jqGrid("addRowData", salesOrderSalesQuotationLastRowId, data.listCustomerSalesOrderSalesQuotation[i]);
                $("#salesOrderSalesQuotationInput_grid").jqGrid('setRowData',salesOrderSalesQuotationLastRowId,{
                    salesOrderSalesQuotationDelete           : "delete",
                    salesOrderSalesQuotationSearch           : "...",
                    salesOrderSalesQuotationCode             : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationCode,
                    salesOrderSalesQuotationTransactionDate  : formatDateRemoveT(data.listCustomerSalesOrderSalesQuotation[i].salesQuotationTransactionDate,true),
                    salesOrderSalesQuotationCustomerCode     : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationCustomerCode,
                    salesOrderSalesQuotationCustomerName     : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationCustomerName,
                    salesOrderSalesQuotationEndUserCode      : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationEndUserCode,
                    salesOrderSalesQuotationEndUserName      : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationEndUserName,
                    salesOrderSalesQuotationRfqCode          : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationRfqCode,
                    salesOrderSalesQuotationProjectCode      : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationProject,
                    salesOrderSalesQuotationSubject          : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationSubject,
                    salesOrderSalesQuotationAttn             : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationAttn,
                    salesOrderSalesQuotationRefNo            : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationRefNo,
                    salesOrderSalesQuotationRemark           : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationRemark
                });
            }
        });
        closeLoading();
    }
    
    function loadSalesOrderItemDetailRevise() {
        loadGridItemSO();
        var arrSalesQuotationNo=new Array();
        var totalTransaction=0;
        var ids = jQuery("#salesOrderSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#salesOrderSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNo.push(data.salesOrderSalesQuotationCode);
        }
        
        var url = "sales/customer-sales-order-item-detail-data-array-data";
        var params = "arrSalesQuotationSoNo="+arrSalesQuotationNo;   
            params += "&salesOrder.code="+$("#salesOrder\\.refCUSTSOCode").val();
        salesOrderItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerSalesOrderItemDetail.length; i++) {
                salesOrderItemDetailLastRowId++;
                
                $("#salesOrderItemDetailInput_grid").jqGrid("addRowData", salesOrderItemDetailLastRowId, data.listCustomerSalesOrderItemDetail[i]);
                $("#salesOrderItemDetailInput_grid").jqGrid('setRowData',salesOrderItemDetailLastRowId,{
                    salesOrderItemDetailDelete                   : "delete",
                    salesOrderItemDetailQuotationNoDetailCode    : data.listCustomerSalesOrderItemDetail[i].salesQuotationDetailCode,
                    salesOrderItemDetailQuotationNo              : data.listCustomerSalesOrderItemDetail[i].salesQuotationCode,
                    salesOrderItemDetailQuotationRefNo           : data.listCustomerSalesOrderItemDetail[i].refNo,
                    salesOrderItemDetailItemFinishGoodsCode      : data.listCustomerSalesOrderItemDetail[i].itemFinishGoodsCode,
                    salesOrderItemDetailItemFinishGoodsRemark    : data.listCustomerSalesOrderItemDetail[i].itemFinishGoodsRemark,
                    salesOrderItemDetailSortNo                   : data.listCustomerSalesOrderItemDetail[i].customerPurchaseOrderSortNo,
                    salesOrderItemDetailValveTypeCode            : data.listCustomerSalesOrderItemDetail[i].valveTypeCode,
                    salesOrderItemDetailValveTypeName            : data.listCustomerSalesOrderItemDetail[i].valveTypeName,
                    salesOrderItemDetailItemAlias                : data.listCustomerSalesOrderItemDetail[i].itemAlias,
                    salesOrderItemDetailValveTag                 : data.listCustomerSalesOrderItemDetail[i].valveTag,
                    salesOrderItemDetailDataSheet                : data.listCustomerSalesOrderItemDetail[i].dataSheet,
                    salesOrderItemDetailDescription              : data.listCustomerSalesOrderItemDetail[i].description,
                                      
                    // 24 valve Type Component Quotation
                    salesOrderItemDetailBodyConstQuotation   : data.listCustomerSalesOrderItemDetail[i].bodyConstruction,
                    salesOrderItemDetailTypeDesignQuotation  : data.listCustomerSalesOrderItemDetail[i].typeDesign,
                    salesOrderItemDetailSeatDesignQuotation  : data.listCustomerSalesOrderItemDetail[i].seatDesign,
                    salesOrderItemDetailSizeQuotation        : data.listCustomerSalesOrderItemDetail[i].size,
                    salesOrderItemDetailRatingQuotation      : data.listCustomerSalesOrderItemDetail[i].rating,
                    salesOrderItemDetailBoreQuotation        : data.listCustomerSalesOrderItemDetail[i].bore,
                    
                    salesOrderItemDetailEndConQuotation      : data.listCustomerSalesOrderItemDetail[i].endCon,
                    salesOrderItemDetailBodyQuotation        : data.listCustomerSalesOrderItemDetail[i].body,
                    salesOrderItemDetailBallQuotation        : data.listCustomerSalesOrderItemDetail[i].ball,
                    salesOrderItemDetailSeatQuotation        : data.listCustomerSalesOrderItemDetail[i].seat,
                    salesOrderItemDetailSeatInsertQuotation  : data.listCustomerSalesOrderItemDetail[i].seatInsert,
                    salesOrderItemDetailStemQuotation        : data.listCustomerSalesOrderItemDetail[i].stem,
                    
                    salesOrderItemDetailSealQuotation        : data.listCustomerSalesOrderItemDetail[i].seal,
                    salesOrderItemDetailBoltQuotation        : data.listCustomerSalesOrderItemDetail[i].bolting,
                    salesOrderItemDetailDiscQuotation        : data.listCustomerSalesOrderItemDetail[i].disc,
                    salesOrderItemDetailPlatesQuotation      : data.listCustomerSalesOrderItemDetail[i].plates,
                    salesOrderItemDetailShaftQuotation       : data.listCustomerSalesOrderItemDetail[i].shaft,
                    salesOrderItemDetailSpringQuotation      : data.listCustomerSalesOrderItemDetail[i].spring,
                    
                    salesOrderItemDetailArmPinQuotation      : data.listCustomerSalesOrderItemDetail[i].armPin,
                    salesOrderItemDetailBackSeatQuotation    : data.listCustomerSalesOrderItemDetail[i].backSeat,
                    salesOrderItemDetailArmQuotation         : data.listCustomerSalesOrderItemDetail[i].arm,
                    salesOrderItemDetailHingePinQuotation    : data.listCustomerSalesOrderItemDetail[i].hingePin,
                    salesOrderItemDetailStopPinQuotation     : data.listCustomerSalesOrderItemDetail[i].stopPin,
                    salesOrderItemDetailOperatorQuotation    : data.listCustomerSalesOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    salesOrderItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerSalesOrderItemDetail[i].itemBodyConstructionCode,
                    salesOrderItemDetailItemFinishGoodsBodyConstName     : data.listCustomerSalesOrderItemDetail[i].itemBodyConstructionName,
                    salesOrderItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerSalesOrderItemDetail[i].itemTypeDesignCode,
                    salesOrderItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerSalesOrderItemDetail[i].itemTypeDesignName,
                    salesOrderItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerSalesOrderItemDetail[i].itemSeatDesignCode,
                    salesOrderItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerSalesOrderItemDetail[i].itemSeatDesignName,
                    salesOrderItemDetailItemFinishGoodsSizeCode          : data.listCustomerSalesOrderItemDetail[i].itemSizeCode,
                    salesOrderItemDetailItemFinishGoodsSizeName          : data.listCustomerSalesOrderItemDetail[i].itemSizeName,
                    salesOrderItemDetailItemFinishGoodsRatingCode        : data.listCustomerSalesOrderItemDetail[i].itemRatingCode,
                    salesOrderItemDetailItemFinishGoodsRatingName        : data.listCustomerSalesOrderItemDetail[i].itemRatingName,
                    salesOrderItemDetailItemFinishGoodsBoreCode          : data.listCustomerSalesOrderItemDetail[i].itemBoreCode,
                    salesOrderItemDetailItemFinishGoodsBoreName          : data.listCustomerSalesOrderItemDetail[i].itemBoreName,
                    
                    salesOrderItemDetailItemFinishGoodsEndConCode        : data.listCustomerSalesOrderItemDetail[i].itemEndConCode,
                    salesOrderItemDetailItemFinishGoodsEndConName        : data.listCustomerSalesOrderItemDetail[i].itemEndConName,
                    salesOrderItemDetailItemFinishGoodsBodyCode          : data.listCustomerSalesOrderItemDetail[i].itemBodyCode,
                    salesOrderItemDetailItemFinishGoodsBodyName          : data.listCustomerSalesOrderItemDetail[i].itemBodyName,
                    salesOrderItemDetailItemFinishGoodsBallCode          : data.listCustomerSalesOrderItemDetail[i].itemBallCode,
                    salesOrderItemDetailItemFinishGoodsBallName          : data.listCustomerSalesOrderItemDetail[i].itemBallName,
                    salesOrderItemDetailItemFinishGoodsSeatCode          : data.listCustomerSalesOrderItemDetail[i].itemSeatCode,
                    salesOrderItemDetailItemFinishGoodsSeatName          : data.listCustomerSalesOrderItemDetail[i].itemSeatName,
                    salesOrderItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerSalesOrderItemDetail[i].itemSeatInsertCode,
                    salesOrderItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerSalesOrderItemDetail[i].itemSeatInsertName,
                    salesOrderItemDetailItemFinishGoodsStemCode          : data.listCustomerSalesOrderItemDetail[i].itemStemCode,
                    salesOrderItemDetailItemFinishGoodsStemName          : data.listCustomerSalesOrderItemDetail[i].itemStemName,
                    
                    salesOrderItemDetailItemFinishGoodsSealCode          : data.listCustomerSalesOrderItemDetail[i].itemSealCode,
                    salesOrderItemDetailItemFinishGoodsSealName          : data.listCustomerSalesOrderItemDetail[i].itemSealName,
                    salesOrderItemDetailItemFinishGoodsBoltCode          : data.listCustomerSalesOrderItemDetail[i].itemBoltCode,
                    salesOrderItemDetailItemFinishGoodsBoltName          : data.listCustomerSalesOrderItemDetail[i].itemBoltName,
                    salesOrderItemDetailItemFinishGoodsDiscCode          : data.listCustomerSalesOrderItemDetail[i].itemDiscCode,
                    salesOrderItemDetailItemFinishGoodsDiscName          : data.listCustomerSalesOrderItemDetail[i].itemDiscName,
                    salesOrderItemDetailItemFinishGoodsPlatesCode        : data.listCustomerSalesOrderItemDetail[i].itemPlatesCode,
                    salesOrderItemDetailItemFinishGoodsPlatesName        : data.listCustomerSalesOrderItemDetail[i].itemPlatesName,
                    salesOrderItemDetailItemFinishGoodsShaftCode         : data.listCustomerSalesOrderItemDetail[i].itemShaftCode,
                    salesOrderItemDetailItemFinishGoodsShaftName         : data.listCustomerSalesOrderItemDetail[i].itemShaftName,
                    salesOrderItemDetailItemFinishGoodsSpringCode        : data.listCustomerSalesOrderItemDetail[i].itemSpringCode,
                    salesOrderItemDetailItemFinishGoodsSpringName        : data.listCustomerSalesOrderItemDetail[i].itemSpringName,
                    
                    salesOrderItemDetailItemFinishGoodsArmPinCode        : data.listCustomerSalesOrderItemDetail[i].itemArmPinCode, 
                    salesOrderItemDetailItemFinishGoodsArmPinName        : data.listCustomerSalesOrderItemDetail[i].itemArmPinName, 
                    salesOrderItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerSalesOrderItemDetail[i].itemBackSeatCode,
                    salesOrderItemDetailItemFinishGoodsBackSeatName      : data.listCustomerSalesOrderItemDetail[i].itemBackSeatName,
                    salesOrderItemDetailItemFinishGoodsArmCode           : data.listCustomerSalesOrderItemDetail[i].itemArmCode,
                    salesOrderItemDetailItemFinishGoodsArmName           : data.listCustomerSalesOrderItemDetail[i].itemArmName,
                    salesOrderItemDetailItemFinishGoodsHingePinCode      : data.listCustomerSalesOrderItemDetail[i].itemHingePinCode,
                    salesOrderItemDetailItemFinishGoodsHingePinName      : data.listCustomerSalesOrderItemDetail[i].itemHingePinName,
                    salesOrderItemDetailItemFinishGoodsStopPinCode       : data.listCustomerSalesOrderItemDetail[i].itemStopPinCode,
                    salesOrderItemDetailItemFinishGoodsStopPinName       : data.listCustomerSalesOrderItemDetail[i].itemStopPinName,
                    salesOrderItemDetailItemFinishGoodsOperatorCode      : data.listCustomerSalesOrderItemDetail[i].itemOperatorCode,
                    salesOrderItemDetailItemFinishGoodsOperatorName      : data.listCustomerSalesOrderItemDetail[i].itemOperatorName,
                    
                    salesOrderItemDetailNote                 : data.listCustomerSalesOrderItemDetail[i].note,
                    salesOrderItemDetailQuantity             : data.listCustomerSalesOrderItemDetail[i].quantity,
                    salesOrderItemDetailPrice                : data.listCustomerSalesOrderItemDetail[i].unitPrice,
                    salesOrderItemDetailTotal                : data.listCustomerSalesOrderItemDetail[i].totalAmount
                });
                calculateSalesOrderHeader();
            }
        });
        closeLoading();
    }
    
    function loadSalesOrderAdditionalFee() {
        if($("#enumSalesOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-sales-order-additional-fee-data";
        var params = "salesOrder.code="+$("#salesOrder\\.customerSalesOrderCode").val();   
        
        salesOrderAdditionalFeeLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderAdditionalFee.length; i++) {
                salesOrderAdditionalFeeLastRowId++;
                
                $("#salesOrderAdditionalFeeInput_grid").jqGrid("addRowData", salesOrderAdditionalFeeLastRowId, data.listCustomerSalesOrderAdditionalFee[i]);
                $("#salesOrderAdditionalFeeInput_grid").jqGrid('setRowData',salesOrderAdditionalFeeLastRowId,{
                    salesOrderAdditionalFeeDelete                      : "delete",
                    salesOrderAdditionalFeeRemark                      : data.listCustomerSalesOrderAdditionalFee[i].remark,
                    salesOrderAdditionalFeeQuantity                    : data.listCustomerSalesOrderAdditionalFee[i].quantity,
                    salesOrderAdditionalFeeSearchUnitOfMeasure         : "...",
                    salesOrderAdditionalFeeUnitOfMeasureCode           : data.listCustomerSalesOrderAdditionalFee[i].unitOfMeasureCode,
                    salesOrderAdditionalFeeAdditionalFeeCode           : data.listCustomerSalesOrderAdditionalFee[i].additionalFeeCode,
                    salesOrderAdditionalFeeAdditionalFeeName           : data.listCustomerSalesOrderAdditionalFee[i].additionalFeeName,
                    salesOrderAdditionalFeeSalesChartOfAccountCode     : data.listCustomerSalesOrderAdditionalFee[i].coaCode,
                    salesOrderAdditionalFeeSalesChartOfAccountName     : data.listCustomerSalesOrderAdditionalFee[i].coaName,
                    salesOrderAdditionalFeePrice                       : data.listCustomerSalesOrderAdditionalFee[i].price,
                    salesOrderAdditionalFeeTotal                       : data.listCustomerSalesOrderAdditionalFee[i].total
                });
            }
            calculateSalesOrderTotalAdditional();
        });
        closeLoading();
    }
    
    function loadSalesOrderPaymentTerm() {
        if($("#enumSalesOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-sales-order-payment-term-data";
        var params = "salesOrder.code="+$("#salesOrder\\.customerSalesOrderCode").val();   
        
        salesOrderPaymentTermLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderPaymentTerm.length; i++) {
                salesOrderPaymentTermLastRowId++;
                
                $("#salesOrderPaymentTermInput_grid").jqGrid("addRowData", salesOrderPaymentTermLastRowId, data.listCustomerSalesOrderPaymentTerm[i]);
                $("#salesOrderPaymentTermInput_grid").jqGrid('setRowData',salesOrderPaymentTermLastRowId,{
                    salesOrderPaymentTermDelete             : "delete",
                    salesOrderPaymentTermSearchPaymentTerm  : "...",
                    salesOrderPaymentTermSortNO             : data.listCustomerSalesOrderPaymentTerm[i].sortNo,
                    salesOrderPaymentTermPaymentTermCode    : data.listCustomerSalesOrderPaymentTerm[i].paymentTermCode,
                    salesOrderPaymentTermPaymentTermName    : data.listCustomerSalesOrderPaymentTerm[i].paymentTermName,
                    salesOrderPaymentTermPercent            : data.listCustomerSalesOrderPaymentTerm[i].percentage,
                    salesOrderPaymentTermRemark             : data.listCustomerSalesOrderPaymentTerm[i].remark
                });
            }
        });
        closeLoading();
    }
    
    function loadSalesOrderItemDeliveryDate() {
        if($("#enumSalesOrderActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/customer-sales-order-item-delivery-data";
        var params = "salesOrder.code="+$("#salesOrder\\.customerSalesOrderCode").val();   
        
        salesOrderItemDeliveryLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderItemDeliveryDate.length; i++) {
                salesOrderItemDeliveryLastRowId++;
                
                $("#salesOrderItemDeliveryInput_grid").jqGrid("addRowData", salesOrderItemDeliveryLastRowId, data.listCustomerSalesOrderItemDeliveryDate[i]);
                $("#salesOrderItemDeliveryInput_grid").jqGrid('setRowData',salesOrderItemDeliveryLastRowId,{
                    salesOrderItemDeliveryDelete                   : "delete",
                    salesOrderItemDeliverySearchQuotation          : "...",
                    salesOrderItemDeliverySalesQuotationCode       : data.listCustomerSalesOrderItemDeliveryDate[i].salesQuotationCode,
                    salesOrderItemDeliverySalesQuotationRefNo      : data.listCustomerSalesOrderItemDeliveryDate[i].refNo,
                    salesOrderItemDeliveryItemFinishGoodsCode      : data.listCustomerSalesOrderItemDeliveryDate[i].itemFinishGoodsCode,
                    salesOrderItemDeliveryItemFinishGoodsRemark    : data.listCustomerSalesOrderItemDeliveryDate[i].itemFinishGoodsRemark,
                    salesOrderItemDeliverySortNo                   : data.listCustomerSalesOrderItemDeliveryDate[i].customerPurchaseOrderSortNo,
                    salesOrderItemDeliveryQuantity                 : data.listCustomerSalesOrderItemDeliveryDate[i].quantity,
                    salesOrderItemDeliveryDeliveryDate             : formatDateRemoveT(data.listCustomerSalesOrderItemDeliveryDate[i].deliveryDate,false)
                });
            }
        });
        closeLoading();
    }
    
    function salesOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=salesOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function salesOrderAdditionalFeeInputGrid_SearchAdditional_OnClick(){
        window.open("./pages/search/search-additional-fee-sales.jsp?iddoc=salesOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function salesOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick(){
        window.open("./pages/search/search-payment-term.jsp?iddoc=salesOrderPaymentTerm&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function salesOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick(){
        var customer=txtSalesOrderEndUserCode.val();
        window.open("./pages/search/search-item-finish-goods.jsp?iddoc=salesOrderItemDetail&type=grid&idcustomer="+customer ,"Search", "scrollbars=1,width=600, height=500");
    }
    
    function sortNoDeliverySO(itemCode){
        $('#salesOrderItemDetailInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel); 
        var ids = jQuery("#salesOrderItemDetailInput_grid").jqGrid('getDataIDs');
        var temp="";
        for(var i=0;i<ids.length;i++){
                var Detail = $("#salesOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                if (itemCode===Detail.salesOrderItemDetailItem){
                    temp=Detail.salesOrderItemDetailSortNo;
                }
               
        }
        
        $('#salesOrderItemDeliveryInput_grid').jqGrid("saveRow",salesOrderItemDelivery_lastSel); 
        var idt = jQuery("#salesOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
        for(var i=0;i<idt.length;i++){
             var Details = $("#salesOrderItemDeliveryInput_grid").jqGrid('getRowData',idt[i]); 
                if (itemCode===Details.salesOrderItemDeliveryItemCode){
                    $("#salesOrderItemDeliveryInput_grid").jqGrid("setCell",idt[i], "salesOrderItemDeliverySortNo",temp);

                }
         }
        
    }
    
    function salesOrderItemDeliveryInputGrid_SearchQuotation_OnClick(){
      var ids = jQuery("#salesOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
           
            if($("#salesOrderItemDeliveryInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;}
                
            }
            
            if(cpoSalesQuotation_lastSel !== -1) {
                $('#salesOrderItemDeliveryInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel);  
            }
            
           var listSalesQuotationCode = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#salesOrderItemDeliveryInput_grid").jqGrid('getRowData',ids[q]); 
                listSalesQuotationCode[q] = [data.salesOrderItemDeliverySalesQuotationCode];
//                 (listCode);
            }
        window.open("./pages/search/search-sales-quotation-array.jsp?iddoc=salesOrderItemDelivery&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function setSalesOrderPartialShipmentStatusStatus(){
        switch($("#salesOrder\\.customerPurchaseOrder\\.partialShipmentStatus").val()){
            case "YES":
                $('input[name="salesOrderPartialShipmentStatusRad"][value="YES"]').prop('checked',true);
                break;
            case "NO":
                $('input[name="salesOrderPartialShipmentStatusRad"][value="NO"]').prop('checked',true);
                break;
        } 
    }
    
    function avoidSpcCharSo(){
        
        var selectedRowID = $("#salesOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#salesOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = salesOrderItemDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_salesOrderItemDetailSortNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep = str.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_salesOrderItemDetailSortNo").val(rep);
        }
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_salesOrderItemDetailSortNo").val("");
        }
    }
</script>

<s:url id="remoteurlSalesOrderSalesQuotationInput" action="" />
<s:url id="remoteurlSalesOrderAdditionalFeeInput" action="" />
<s:url id="remoteurlSalesOrderPaymentTermInput" action="" />
<s:url id="remoteurlSalesOrderItemDeliveryInput" action="" />
<b>CUSTOMER SALES ORDER</b><span id="msgSalesOrderActivity"></span>
<hr>
<br class="spacer" />

<div id="salesOrderInput" class="content ui-widget">
    <s:form id="frmSalesOrderInput">
        <table cellpadding="2" cellspacing="2" id="headerSalesOrderInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" style="width:180px"><B>SOD No *</B></td>
                            <td>
                                <s:textfield id="salesOrder.code" name="salesOrder.code" key="salesOrder.code" readonly="true" size="30"></s:textfield>
                                <s:textfield id="salesOrder.customerSalesOrderCode" name="salesOrder.customerSalesOrderCode" key="salesOrder.customerSalesOrderCode" readonly="true" size="25" disabled="true" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ref SOD No *</B></td>
                            <td>
                            <s:textfield id="salesOrder.custSONo" name="salesOrder.custSONo" key="salesOrder.custSONo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                                <s:textfield id="salesOrder.refCUSTSOCode" name="salesOrder.refCUSTSOCode" key="salesOrder.refCUSTSOCode" readonly="true" size="30"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="salesOrder.revision" name="salesOrder.revision" key="salesOrder.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                txtSalesOrderBranchCode.change(function(ev) {

                                    if(txtSalesOrderBranchCode.val()===""){
                                        txtSalesOrderBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get";
                                    var params = "branch.code=" + txtSalesOrderBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtSalesOrderBranchCode.val(data.branchTemp.code);
                                            txtSalesOrderBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtSalesOrderBranchCode);
                                            txtSalesOrderBranchCode.val("");
                                            txtSalesOrderBranchName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="salesOrder.branch.code" name="salesOrder.branch.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="salesOrder_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="salesOrder.branch.name" name="salesOrder.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="salesOrder.transactionDate" name="salesOrder.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus"></sj:datepicker>
                                <sj:datepicker id="salesOrderTransactionDate" name="salesOrderTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right"><B>Order Status * </B></td>
                            <td colspan="2">
                                <s:radio id="salesOrderOrderStatusRad" name="salesOrderOrderStatusRad" label="salesOrderOrderStatusRad" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio>
                                <s:textfield id="salesOrder.orderStatus" name="salesOrder.orderStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order*</B></td>
                            <td colspan="3"><s:textfield id="salesOrder.customerPurchaseOrder.code" name="salesOrder.customerPurchaseOrder.code" size="27" title=" " required="true" cssClass="required" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order No*</B></td>
                            <td colspan="3"><s:textfield id="salesOrder.customerPurchaseOrder.customerPurchaseOrderNo" name="salesOrder.customerPurchaseOrder.customerPurchaseOrderNo" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtSalesOrderCustomerCode.change(function(ev) {

                                    if(txtSalesOrderCustomerCode.val()===""){
                                        txtSalesOrderCustomerName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get";
                                    var params = "customer.code=" + txtSalesOrderCustomerCode.val();
                                        params += "&customer.activeStatus=TRUE";
                                        params += "&customer.customerStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtSalesOrderCustomerCode.val(data.customerTemp.code);
                                            txtSalesOrderCustomerName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer Not Found!",txtSalesOrderCustomerCode);
                                            txtSalesOrderCustomerCode.val("");
                                            txtSalesOrderCustomerName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="salesOrder.customer.code" name="salesOrder.customer.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="salesOrder_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="salesOrder.customer.name" name="salesOrder.customer.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>End User *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtSalesOrderEndUserCode.change(function(ev) {

                                    if(txtSalesOrderEndUserCode.val()===""){
                                        txtSalesOrderEndUserName.val("");
                                        return;
                                    }
                                    var url = "master/customer-get-end-user";
                                    var params = "customer.code=" + txtSalesOrderEndUserCode.val();
                                        params += "&customer.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtSalesOrderEndUserCode.val(data.customerTemp.code);
                                            txtSalesOrderEndUserName.val(data.customerTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer End User Not Found!",txtSalesOrderEndUserCode);
                                            txtSalesOrderEndUserCode.val("");
                                            txtSalesOrderEndUserName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="salesOrder.endUser.code" name="salesOrder.endUser.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="salesOrder_btnCustomerEndUser" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="salesOrder.endUser.name" name="salesOrder.endUser.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Partial Shipment * </B></td>
                            <td colspan="2">
                                <s:radio id="salesOrderPartialShipmentStatusRad" name="salesOrderPartialShipmentStatusRad" label="salesOrderPartialShipmentStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="salesOrder.customerPurchaseOrder.partialShipmentStatus" name="salesOrder.customerPurchaseOrder.partialShipmentStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Retention</td>
                            <td>
                                <s:textfield id="salesOrder.customerPurchaseOrder.retentionPercent" name="salesOrder.customerPurchaseOrder.retentionPercent" size="5" cssStyle="text-align:right"></s:textfield>%
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

                                    txtSalesOrderCurrencyCode.change(function(ev) {

                                        if(txtSalesOrderCurrencyCode.val()===""){
                                            txtSalesOrderCurrencyName.val("");
                                            return;
                                        }

                                        var url = "master/currency-get";
                                        var params = "currency.code=" + txtSalesOrderCurrencyCode.val();
                                            params+= "&currency.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.currencyTemp){
                                                txtSalesOrderCurrencyCode.val(data.currencyTemp.code);
                                                txtSalesOrderCurrencyName.val(data.currencyTemp.name);
                                            }
                                            else{
                                                alertMessage("Currency Not Found",txtSalesOrderCurrencyCode);
                                                txtSalesOrderCurrencyCode.val("");
                                                txtSalesOrderCurrencyName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="salesOrder.currency.code" name="salesOrder.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                <sj:a id="salesOrder_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="salesOrder.currency.name" name="salesOrder.currency.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sales Person *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtSalesOrderSalesPersonCode.change(function(ev) {
                                        if(txtSalesOrderSalesPersonCode.val()===""){
                                            txtSalesOrderSalesPersonName.val("");
                                            return;
                                        }
                                        var url = "master/sales-person-get";
                                        var params = "salesPerson.code=" + txtSalesOrderSalesPersonCode.val();
                                            params+= "&salesPerson.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.salesPersonTemp){
                                                txtSalesOrderSalesPersonCode.val(data.salesPersonTemp.code);
                                                txtSalesOrderSalesPersonName.val(data.salesPersonTemp.name);
                                            }
                                            else{
                                                alertMessage("Sales Person Not Found!",txtSalesOrderSalesPersonCode);
                                                txtSalesOrderSalesPersonCode.val("");
                                                txtSalesOrderSalesPersonName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="salesOrder.salesPerson.code" name="salesOrder.salesPerson.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                    <sj:a id="salesOrder_btnSalesPerson" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="salesOrder.salesPerson.name" name="salesOrder.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Project</td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtSalesOrderProjectCode.change(function(ev) {
                                        if(txtSalesOrderProjectCode.val()===""){
                                            txtSalesOrderProjectName.val("");
                                            return;
                                        }
                                        var url = "master/project-get";
                                        var params = "project.code=" + txtSalesOrderProjectCode.val();
                                            params+= "&project.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.projectTemp){
                                                txtSalesOrderProjectCode.val(data.projectTemp.code);
                                                txtSalesOrderProjectName.val(data.projectTemp.name);
                                            }
                                            else{
                                                alertMessage("Project Not Found!",txtSalesOrderProjectCode);
                                                txtSalesOrderProjectCode.val("");
                                                txtSalesOrderProjectName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="salesOrder.project.code" name="salesOrder.project.code" title=" " size="22"></s:textfield>
                                    <sj:a id="salesOrder_btnProject" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="salesOrder.project.name" name="salesOrder.project.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3"><s:textfield id="salesOrder.refNo" name="salesOrder.refNo" size="27"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="salesOrder.remark" name="salesOrder.remark"  cols="70" rows="2" height="20"></s:textarea></td>
                        </tr> 
                    </table>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="salesOrderDateFirstSession" name="salesOrderDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="salesOrderDateLastSession" name="salesOrderDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumSalesOrderActivity" name="enumSalesOrderActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="salesOrder.createdBy" name="salesOrder.createdBy" key="salesOrder.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="salesOrder.createdDate" name="salesOrder.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="salesOrder.createdDateTemp" name="salesOrder.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmSalesOrder" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmSalesOrder" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnSOSearchSalQuo" button="true" style="width: 200px">Search Sales Quotation</sj:a>
                </td>
            </tr>
        </table>                
        <br class="spacer" />
        <div id="salesOrderSalesQuotationInputGrid">
            <sjg:grid
                id="salesOrderSalesQuotationInput_grid"
                caption="Sales Quotation"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listCustomerSalesOrderSalesQuotation"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuSalesOrderDetail').width()"
                editurl="%{remoteurlSalesOrderSalesQuotationInput}"
                onSelectRowTopics="salesOrderSalesQuotationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="salesOrderSalesQuotation" index="salesOrderSalesQuotation" key="salesOrderSalesQuotation" 
                    title="" width="50" sortable="true" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationDelete" index="salesOrderSalesQuotationDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'salesOrderSalesQuotationInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationCode" index="salesOrderSalesQuotationCode" 
                    title="SLS-QUO No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="salesOrderSalesQuotationTransactionDate" index="salesOrderSalesQuotationTransactionDate" key="salesOrderSalesQuotationTransactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationCustomerCode" index="salesOrderSalesQuotationCustomerCode" 
                    title="Customer Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationCustomerName" index="salesOrderSalesQuotationCustomerName" 
                    title="Customer Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationEndUserCode" index="salesOrderSalesQuotationEndUserCode" 
                    title="End User Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationEndUserName" index="salesOrderSalesQuotationEndUserName" 
                    title="End User Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "salesOrderSalesQuotationRfqCode" index = "salesOrderSalesQuotationRfqCode" key = "salesOrderSalesQuotationRfqCode" 
                    title = "RFQ No" width = "120" edittype="text" 
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationProjectCode" index="salesOrderSalesQuotationProjectCode" 
                    title="Project" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationSubject" index="salesOrderSalesQuotationSubject" 
                    title="Subject" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationAttn" index="salesOrderSalesQuotationAttn" 
                    title="Attn" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationRefNo" index="salesOrderSalesQuotationRefNo" key="salesOrderSalesQuotationRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderSalesQuotationRemark" index="salesOrderSalesQuotationRemark" key="salesOrderSalesQuotationRemark" 
                    title="Remark" width="150" sortable="true"
                />
            </sjg:grid >                
        </div>         
        <table>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmSalesOrderSalesQuotation" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmSalesOrderSalesQuotation" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmSalesOrderSalesQuotationDetailSort" button="true" style="width: 70px">Sort No</sj:a>
                </td>
            </tr>
        </table>
        <div id="id-tbl-additional-payment-item-delivery-so">
            <div>
                <sjg:grid
                    id="salesOrderItemDetailInput_grid"
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
                    editurl="%{remoteurlSalesOrderSalesQuotationInput}"
                    onSelectRowTopics="salesOrderItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="salesOrderItemDetail" index="salesOrderItemDetail" key="salesOrderItemDetail" 
                        title="" width="50" sortable="true" editable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailDelete" index="salesOrderItemDetailDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'salesOrderItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />                    
                    <sjg:gridColumn
                        name="salesOrderItemDetailQuotationNoDetailCode" index="salesOrderItemDetailQuotationNoDetailCode" key="salesOrderItemDetailQuotationNoDetailCode" 
                        title="Quotation No" width="150" sortable="true" hidden="false"
                    />                   
                    <sjg:gridColumn
                        name="salesOrderItemDetailQuotationNo" index="salesOrderItemDetailQuotationNo" key="salesOrderItemDetailQuotationNo" 
                        title="Quotation No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailQuotationRefNo" index="salesOrderItemDetailQuotationRefNo" key="salesOrderItemDetailQuotationRefNo" 
                        title="Ref No" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailSortNo" index="salesOrderItemDetailSortNo" 
                        title="Sort No" width="80" sortable="true" editable="true" edittype="text" formatter="integer"
                        editoptions="{onKeyUp:'avoidSpcCharSo()'}"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailSearchItemFinishGoods" index="salesOrderItemDetailSearchItemFinishGoods" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"
                        editoptions="{onClick:'salesOrderItemDetailInputGrid_SearchItemFinishGoods_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsCode" index="salesOrderItemDetailItemFinishGoodsCode" key="salesOrderItemDetailItemFinishGoodsCode" 
                        title="Item Finish Goods Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsRemark" index="salesOrderItemDetailItemFinishGoodsRemark" key="salesOrderItemDetailItemFinishGoodsRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailValveTypeCode" index="salesOrderItemDetailValveTypeCode" key="salesOrderItemDetailValveTypeCode" 
                        title="Valve Type Code (QUO)" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailValveTypeName" index="salesOrderItemDetailValveTypeName" key="salesOrderItemDetailValveTypeName" 
                        title="Valve Type Name (QUO)" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemAlias" index="salesOrderItemDetailItemAlias" 
                        title="Item Alias" width="100" sortable="true" editable="true" edittype="text"
                    /> 
                    <sjg:gridColumn
                        name="salesOrderItemDetailValveTag" index="salesOrderItemDetailValveTag" 
                        title="Valve Tag" width="100" sortable="true" editable="true" edittype="text"
                    />  
                    <sjg:gridColumn
                        name="salesOrderItemDetailDataSheet" index="salesOrderItemDetailDataSheet" 
                        title="Data Sheet" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailDescription" index="salesOrderItemDetailDescription" 
                        title="Description" width="100" sortable="true" editable="true" edittype="text"
                    />
                    <!--Body Const 01-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailBodyConstQuotation" index="salesOrderItemDetailBodyConstQuotation" 
                        title="QUO (01)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBodyConstCode" index="salesOrderItemDetailItemFinishGoodsBodyConstCode" 
                        title="IFG (01)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBodyConstName" index="salesOrderItemDetailItemFinishGoodsBodyConstName" 
                        title="IFG (01)" width="100" sortable="true"
                    />
                    <!--Type Design 02-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailTypeDesignQuotation" index="salesOrderItemDetailTypeDesignQuotation" 
                        title="QUO (02)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsTypeDesignCode" index="salesOrderItemDetailItemFinishGoodsTypeDesignCode" 
                        title="IFG (02)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsTypeDesignName" index="salesOrderItemDetailItemFinishGoodsTypeDesignName" 
                        title="IFG (02)" width="100" sortable="true"
                    />
                    <!--Seat Design 03-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailSeatDesignQuotation" index="salesOrderItemDetailSeatDesignQuotation" 
                        title="QUO (03)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSeatDesignCode" index="salesOrderItemDetailItemFinishGoodsSeatDesignCode" 
                        title="IFG (03)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSeatDesignName" index="salesOrderItemDetailItemFinishGoodsSeatDesignName" 
                        title="IFG (03)" width="100" sortable="true"
                    />
                    <!--Size 04-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailSizeQuotation" index="salesOrderItemDetailSizeQuotation" 
                        title="QUO (04)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSizeCode" index="salesOrderItemDetailItemFinishGoodsSizeCode" 
                        title="IFG (04)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSizeName" index="salesOrderItemDetailItemFinishGoodsSizeName" 
                        title="IFG (04)" width="100" sortable="true"
                    />
                    <!--Rating 05-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailRatingQuotation" index="salesOrderItemDetailRatingQuotation" 
                        title="QUO (05)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsRatingCode" index="salesOrderItemDetailItemFinishGoodsRatingCode" 
                        title="IFG (05)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsRatingName" index="salesOrderItemDetailItemFinishGoodsRatingName" 
                        title="IFG (05)" width="100" sortable="true"
                    />
                    <!--Bore 06-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailBoreQuotation" index="salesOrderItemDetailBoreQuotation" 
                        title="QUO (06)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBoreCode" index="salesOrderItemDetailItemFinishGoodsBoreCode" 
                        title="IFG (06)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBoreName" index="salesOrderItemDetailItemFinishGoodsBoreName" 
                        title="IFG (06)" width="100" sortable="true"
                    />
                    <!--EndCon 07-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailEndConQuotation" index="salesOrderItemDetailEndConQuotation" 
                        title="QUO (07)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsEndConCode" index="salesOrderItemDetailItemFinishGoodsEndConCode" 
                        title="IFG (07)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsEndConName" index="salesOrderItemDetailItemFinishGoodsEndConName" 
                        title="IFG (07)" width="100" sortable="true"
                    />
                    <!--Body 08-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailBodyQuotation" index="salesOrderItemDetailBodyQuotation" 
                        title="QUO (08)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBodyCode" index="salesOrderItemDetailItemFinishGoodsBodyCode" 
                        title="IFG (08)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBodyName" index="salesOrderItemDetailItemFinishGoodsBodyName" 
                        title="IFG (08)" width="100" sortable="true"
                    />
                    <!--Ball 09-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailBallQuotation" index="salesOrderItemDetailBallQuotation" 
                        title="QUO (09)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBallCode" index="salesOrderItemDetailItemFinishGoodsBallCode" 
                        title="IFG (09)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBallName" index="salesOrderItemDetailItemFinishGoodsBallName" 
                        title="IFG (09)" width="100" sortable="true"
                    />
                    <!--Seat 10-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailSeatQuotation" index="salesOrderItemDetailSeatQuotation" 
                        title="QUO (10)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSeatCode" index="salesOrderItemDetailItemFinishGoodsSeatCode" 
                        title="IFG (10)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSeatName" index="salesOrderItemDetailItemFinishGoodsSeatName" 
                        title="IFG (10)" width="100" sortable="true"
                    />
                    <!--SeatInsert 11-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailSeatInsertQuotation" index="salesOrderItemDetailSeatInsertQuotation" 
                        title="QUO (11)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSeatInsertCode" index="salesOrderItemDetailItemFinishGoodsSeatInsertCode" 
                        title="IFG (11)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSeatInsertName" index="salesOrderItemDetailItemFinishGoodsSeatInsertName" 
                        title="IFG (11)" width="100" sortable="true"
                    />
                    <!--Stem 12-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailStemQuotation" index="salesOrderItemDetailStemQuotation" 
                        title="QUO (12)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsStemCode" index="salesOrderItemDetailItemFinishGoodsStemCode" 
                        title="IFG (12)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsStemName" index="salesOrderItemDetailItemFinishGoodsStemName" 
                        title="IFG (12)" width="100" sortable="true"
                    />
                    <!--Seal 13-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailSealQuotation" index="salesOrderItemDetailSealQuotation" 
                        title="QUO (13)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSealCode" index="salesOrderItemDetailItemFinishGoodsSealCode" 
                        title="IFG (13)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSealName" index="salesOrderItemDetailItemFinishGoodsSealName" 
                        title="IFG (13)" width="100" sortable="true"
                    />
                    <!--Bolt 14-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailBoltQuotation" index="salesOrderItemDetailBoltQuotation" 
                        title="QUO (14)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBoltCode" index="salesOrderItemDetailItemFinishGoodsBoltCode" 
                        title="IFG (14)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBoltName" index="salesOrderItemDetailItemFinishGoodsBoltName" 
                        title="IFG (14)" width="100" sortable="true"
                    />
                    <!--Disc 15-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailDiscQuotation" index="salesOrderItemDetailDiscQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsDiscCode" index="salesOrderItemDetailItemFinishGoodsDiscCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsDiscName" index="salesOrderItemDetailItemFinishGoodsDiscName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Plates 16-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailPlatesQuotation" index="salesOrderItemDetailPlatesQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsPlatesCode" index="salesOrderItemDetailItemFinishGoodsPlatesCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsPlatesName" index="salesOrderItemDetailItemFinishGoodsPlatesName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Shaft 17-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailShaftQuotation" index="salesOrderItemDetailShaftQuotation" 
                        title="QUO (17)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsShaftCode" index="salesOrderItemDetailItemFinishGoodsShaftCode" 
                        title="IFG (17)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsShaftName" index="salesOrderItemDetailItemFinishGoodsShaftName" 
                        title="IFG (17)" width="100" sortable="true"
                    />
                    <!--Spring 18-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailSpringQuotation" index="salesOrderItemDetailSpringQuotation" 
                        title="QUO (18)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSpringCode" index="salesOrderItemDetailItemFinishGoodsSpringCode" 
                        title="IFG (18)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsSpringName" index="salesOrderItemDetailItemFinishGoodsSpringName" 
                        title="IFG (18)" width="100" sortable="true"
                    />
                    <!--ArmPin 19-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailArmPinQuotation" index="salesOrderItemDetailArmPinQuotation" 
                        title="QUO (19)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsArmPinCode" index="salesOrderItemDetailItemFinishGoodsArmPinCode" 
                        title="IFG (19)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsArmPinName" index="salesOrderItemDetailItemFinishGoodsArmPinName" 
                        title="IFG (19)" width="100" sortable="true"
                    />
                    <!--BackSeat 20-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailBackSeatQuotation" index="salesOrderItemDetailBackSeatQuotation" 
                        title="QUO (20)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBackSeatCode" index="salesOrderItemDetailItemFinishGoodsBackSeatCode" 
                        title="IFG (20)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsBackSeatName" index="salesOrderItemDetailItemFinishGoodsBackSeatName" 
                        title="IFG (20)" width="100" sortable="true"
                    />
                    <!--Arm 21-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailArmQuotation" index="salesOrderItemDetailArmQuotation" 
                        title="QUO (21)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsArmCode" index="salesOrderItemDetailItemFinishGoodsArmCode" 
                        title="IFG (21)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsArmName" index="salesOrderItemDetailItemFinishGoodsArmName" 
                        title="IFG (21)" width="100" sortable="true"
                    />
                    <!--HingePin 22-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailHingePinQuotation" index="salesOrderItemDetailHingePinQuotation" 
                        title="QUO (22)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsHingePinCode" index="salesOrderItemDetailItemFinishGoodsHingePinCode" 
                        title="IFG (22)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsHingePinName" index="salesOrderItemDetailItemFinishGoodsHingePinName" 
                        title="IFG (22)" width="100" sortable="true"
                    />
                    <!--StopPin 23-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailStopPinQuotation" index="salesOrderItemDetailStopPinQuotation" 
                        title="QUO (23)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsStopPinCode" index="salesOrderItemDetailItemFinishGoodsStopPinCode" 
                        title="IFG (23)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsStopPinName" index="salesOrderItemDetailItemFinishGoodsStopPinName" 
                        title="IFG (23)" width="100" sortable="true"
                    />
                    <!--Operator 99-->
                    <sjg:gridColumn
                        name="salesOrderItemDetailOperatorQuotation" index="salesOrderItemDetailOperatorQuotation" 
                        title="QUO (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsOperatorCode" index="salesOrderItemDetailItemFinishGoodsOperatorCode" 
                        title="IFG (99)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailItemFinishGoodsOperatorName" index="salesOrderItemDetailItemFinishGoodsOperatorName" 
                        title="IFG (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailNote" index="salesOrderItemDetailNote" title="Note" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailQuantity" index="salesOrderItemDetailQuantity" key="salesOrderItemDetailQuantity" title="Qty" 
                        width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                        formatter="number" editrules="{ double: true }"
                        editoptions="{onKeyUp:'calculateItemSalesQuotationDetailReleaseSO()'}"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailPrice" index="salesOrderItemDetailPrice" key="salesOrderItemDetailPrice" title="Unit Price" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="salesOrderItemDetailTotal" index="salesOrderItemDetailTotal" key="salesOrderItemDetailTotal" title="Total" 
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
                                id="salesOrderAdditionalFeeInput_grid"
                                caption="Additional"
                                dataType="local"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listCustomerSalesOrderAdditionalFee"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false"
                                editinline="true"
                                width="$('#tabmnuSalesOrderAdditionalFee').width()"
                                editurl="%{remoteurlSalesOrderAdditionalFeeInput}"
                                onSelectRowTopics="salesOrderAdditionalFeeInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFee" index="salesOrderAdditionalFee" key="salesOrderAdditionalFee" 
                                    title="" width="50" sortable="true" editable="true" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeDelete" index="salesOrderAdditionalFeeDelete" title="" width="50" align="centre"
                                    editable="true" edittype="button"
                                    editoptions="{onClick:'salesOrderAdditionalFeeInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeRemark" index="salesOrderAdditionalFeeRemark" key="salesOrderAdditionalFeeRemark" 
                                    title="Remark" width="150" sortable="true" editable="true"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeQuantity" index="salesOrderAdditionalFeeQuantity" key="salesOrderAdditionalFeeQuantity" title="Quantity" 
                                    width="80" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateSalesOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeSearchUnitOfMeasure" index="salesOrderAdditionalFeeSearchUnitOfMeasure" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'salesOrderAdditionalFeeInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeUnitOfMeasureCode" index="salesOrderAdditionalFeeUnitOfMeasureCode" 
                                    title="Unit" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeUnitOfMeasureCodeSO()'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeSearchAdditional" index="salesOrderAdditionalFeeSearchAdditional" title="" width="25" align="centre"
                                    editable="true" dataType="html" edittype="button"
                                    editoptions="{onClick:'salesOrderAdditionalFeeInputGrid_SearchAdditional_OnClick()', value:'...'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeAdditionalFeeCode" index="salesOrderAdditionalFeeAdditionalFeeCode" 
                                    title="Additional Fee Code" width="100" sortable="true" editable="true" edittype="text" 
                                    editoptions="{onChange:'onchangeAdditionalFeeCodeSO()'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeAdditionalFeeName" index="salesOrderAdditionalFeeAdditionalFeeName" 
                                    title="Additional Fee Name" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeSalesChartOfAccountCode" index="salesOrderAdditionalFeeSalesChartOfAccountCode" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeSalesChartOfAccountName" index="salesOrderAdditionalFeeSalesChartOfAccountName" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeePrice" index="salesOrderAdditionalFeePrice" key="salesOrderAdditionalFeePrice" title="Price" 
                                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateSalesOrderAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderAdditionalFeeTotal" index="salesOrderAdditionalFeeTotal" key="salesOrderAdditionalFeeTotal" title="Total" 
                                    width="150" align="right" edittype="text"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                            </sjg:grid >
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <s:textfield id="salesOrderAdditionalFeeAddRow" name="salesOrderAdditionalFeeAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                            <sj:a href="#" id="btnSalesOrderAdditionalFeeAdd" button="true"  style="width: 60px">Add</sj:a>
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
                                            id="salesOrderPaymentTermInput_grid"
                                            caption="Payment Term"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerSalesOrderPaymentTerm"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlSalesOrderPaymentTermInput}"
                                            onSelectRowTopics="salesOrderPaymentTermInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTerm" index="salesOrderPaymentTerm" 
                                                title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                            />  
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTermDelete" index="salesOrderPaymentTermDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'salesOrderPaymentTermInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTermSortNO" index="salesOrderPaymentTermSortNO" key="salesOrderPaymentTermSortNO" title="Term No" 
                                                width="80" align="right" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTermPaymentTermCode" index="salesOrderPaymentTermPaymentTermCode" 
                                                title="Payment Term Code" width="100" sortable="true" editable="true" edittype="text"
                                                editoptions="{onChange:'onchangePaymentTermPaymentTermCodeSO()'}"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTermSearchPaymentTerm" index="salesOrderPaymentTermSearchPaymentTerm" title="" width="25" align="centre"
                                                editable="true" dataType="html" edittype="button" 
                                                editoptions="{onClick:'salesOrderPaymentTermInputGrid_SearchPaymentTerm_OnClick()', value:'...'}"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTermPaymentTermName" index="salesOrderPaymentTermPaymentTermName" 
                                                title="Payment Term" width="100" sortable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTermPercent" index="salesOrderPaymentTermPercent" key="salesOrderPaymentTermPercent" title="Percent" 
                                                width="80" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderPaymentTermRemark" index="salesOrderPaymentTermRemark" 
                                                title="Note" width="200" sortable="true" edittype="text" editable="true"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="salesOrderPaymentTermAddRow" name="salesOrderPaymentTermAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnSalesOrderPaymentTermAdd" button="true"  style="width: 60px">Add</sj:a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table valign="top">
                                <tr>
                                    <td width="120px" align="right"><B>Total Transaction</B></td>
                                    <td width="120px">
                                        <s:textfield id="salesOrder.totalTransactionAmount" name="salesOrder.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Disc
                                        <s:textfield id="salesOrder.discountPercent" name="salesOrder.discountPercent" onkeyup="calculateSalesOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                    <s:textfield id="salesOrder.discountAmount" name="salesOrder.discountAmount" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Additional</td>
                                    <td>
                                    <s:textfield id="salesOrder.totalAdditionalFeeAmount" name="salesOrder.totalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" disabled="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><b>Sub Total(Tax Base)</b></td>
                                    <td>
                                        <s:textfield id="salesOrder.taxBaseAmount" name="salesOrder.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">VAT
                                        <s:textfield id="salesOrder.vatPercent" name="salesOrder.vatPercent" onkeyup="calculateSalesOrderHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                        <s:textfield id="salesOrder.vatAmount" name="salesOrder.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Grand Total</B></td>
                                    <td>
                                        <s:textfield id="salesOrder.grandTotalAmount" name="salesOrder.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
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
                        <sj:a href="#" id="btnConfirmSalesOrderItemDetailDelivery" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmSalesOrderItemDetailDelivery" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>                
            <div id="id-tbl-additional-item-delivery-detail-so">
                <table>
                    <tr>
                        <td align="right">Delivery Date
                            <sj:datepicker id="salesOrderDeliveryDateSet" name="salesOrderDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today"></sj:datepicker>
                            <sj:a href="#" id="btnSalesOrderDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;
                            <sj:a href="#" id="btnSalesOrderCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="salesOrderItemDeliveryInput_grid"
                                            caption="Item Delivery Date"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listCustomerSalesOrderItemDeliveryDate"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="800"
                                            editurl="%{remoteurlSalesOrderItemDeliveryInput}"
                                            onSelectRowTopics="salesOrderItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="salesOrderItemDelivery" index="salesOrderItemDelivery" key="salesOrderItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderItemDeliveryDelete" index="salesOrderItemDeliveryDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'salesOrderItemDeliveryInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderItemDeliverySearchQuotation" index="salesOrderItemDeliverySearchQuotation" title="" width="25" align="centre"
                                                editable="true"
                                                dataType="html"
                                                edittype="button"
                                                editoptions="{onClick:'salesOrderItemDeliveryInputGrid_SearchQuotation_OnClick()', value:'...'}"
                                            /> 
                                            <sjg:gridColumn
                                                name = "salesOrderItemDeliveryItemFinishGoodsCode" index = "salesOrderItemDeliveryItemFinishGoodsCode" key = "salesOrderItemDeliveryItemFinishGoodsCode" 
                                                title = "Item Finish Goods Code" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "salesOrderItemDeliveryItemFinishGoodsRemark" index = "salesOrderItemDeliveryItemFinishGoodsRemark" key = "salesOrderItemDeliveryItemFinishGoodsRemark" 
                                                title = "IFG Remark" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderItemDeliverySortNo" index="salesOrderItemDeliverySortNo" title="Sort No" width="80" sortable="true"
                                            />  
                                            <sjg:gridColumn
                                                name="salesOrderItemDeliveryQuantity" index="salesOrderItemDeliveryQuantity" key="salesOrderItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderItemDeliveryDeliveryDate" index="salesOrderItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="true" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangeSalesOrderItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderItemDeliveryDeliveryDateTemp" index="salesOrderItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                            <sjg:gridColumn
                                                name = "salesOrderItemDeliverySalesQuotationCode" index = "salesOrderItemDeliverySalesQuotationCode" key = "salesOrderItemDeliverySalesQuotationCode" 
                                                title = "Quotation No" width = "100"
                                            />
                                            <sjg:gridColumn
                                                name = "salesOrderItemDeliverySalesQuotationRefNo" index = "salesOrderItemDeliverySalesQuotationRefNo" key = "salesOrderItemDeliverySalesQuotationRefNo" 
                                                title = "Ref No" width = "100"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="salesOrderItemDelieryAddRow" name="salesOrderItemDelieryAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnSalesOrderItemDelieryAdd" button="true"  style="width: 60px">Add</sj:a>
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
                    <sj:a href="#" id="btnSalesOrderSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnSalesOrderCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    