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
    .ui-dialog-titlebar-close,#salesOrderClosingSalesQuotationInput_grid_pager_center,
    #salesOrderClosingItemDetailInput_grid_pager_center,#salesOrderClosingAdditionalFeeInput_grid_pager_center,
    #salesOrderClosingPaymentTermInput_grid_pager_center,#salesOrderClosingItemDeliveryInput_grid_pager_center{
        display: none;
    }
    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var salesOrderClosingSalesQuotationLastRowId=0,salesOrderClosingSalesQuotation_lastSel = -1;
    var salesOrderClosingItemDetailLastRowId=0,salesOrderClosingItemDetail_lastSel = -1;
    var salesOrderClosingAdditionalFeeLastRowId=0,salesOrderClosingAdditionalFee_lastSel = -1;
    var salesOrderClosingPaymentTermLastRowId=0,salesOrderClosingPaymentTerm_lastSel = -1;
    var salesOrderClosingItemDeliveryLastRowId=0,salesOrderClosingItemDelivery_lastSel = -1;
    var cpoSalesQuotation_lastSel = -1;
    var 
        txtSalesOrderClosingCode = $("#salesOrderClosing\\.code"),
        dtpSalesOrderClosingTransactionDate = $("#salesOrderClosing\\.transactionDate"),
        txtSalesOrderClosingRetention= $("#salesOrderClosing\\.customerPurchaseOrder\\.retentionPercent"),
        txtSalesOrderClosingRefNo = $("#salesOrderClosing\\.refNo"),
        txtSalesOrderClosingRemark = $("#salesOrderClosing\\.remark"),
        txtSalesOrderClosingTotalTransactionAmount = $("#salesOrderClosing\\.totalTransactionAmount"),
        txtSalesOrderClosingDiscountPercent = $("#salesOrderClosing\\.discountPercent"),
        txtSalesOrderClosingDiscountAmount = $("#salesOrderClosing\\.discountAmount"),
        txtSalesOrderClosingTotalAdditionalFee= $("#salesOrderClosing\\.totalAdditionalFeeAmount"),
        txtSalesOrderClosingTaxBaseAmount= $("#salesOrderClosing\\.taxBaseAmount"),
        txtSalesOrderClosingVATPercent = $("#salesOrderClosing\\.vatPercent"),
        txtSalesOrderClosingVATAmount = $("#salesOrderClosing\\.vatAmount"),
        txtSalesOrderClosingGrandTotalAmount = $("#salesOrderClosing\\.grandTotalAmount");

        function loadGridItemSOClosing(){
             //function groupingHeader
                $("#salesOrderClosingItemDetailInput_grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true, 
                    groupHeaders:[
                          {startColumnName: 'salesOrderClosingItemDetailBodyConstQuotation', numberOfColumns: 3, titleText: 'Body Const'},
                          {startColumnName: 'salesOrderClosingItemDetailTypeDesignQuotation', numberOfColumns: 3, titleText: 'Type Design'},
                          {startColumnName: 'salesOrderClosingItemDetailSeatDesignQuotation', numberOfColumns: 3, titleText: 'Seat Design'},
                          {startColumnName: 'salesOrderClosingItemDetailSizeQuotation', numberOfColumns: 3, titleText: 'Size'},
                          {startColumnName: 'salesOrderClosingItemDetailRatingQuotation', numberOfColumns: 3, titleText: 'Rating'},
                          {startColumnName: 'salesOrderClosingItemDetailBoreQuotation', numberOfColumns: 3, titleText: 'Bore'},
                          
                          {startColumnName: 'salesOrderClosingItemDetailEndConQuotation', numberOfColumns: 3, titleText: 'End Con'},
                          {startColumnName: 'salesOrderClosingItemDetailBodyQuotation', numberOfColumns: 3, titleText: 'Body'},
                          {startColumnName: 'salesOrderClosingItemDetailBallQuotation', numberOfColumns: 3, titleText: 'Ball'},
                          {startColumnName: 'salesOrderClosingItemDetailSeatQuotation', numberOfColumns: 3, titleText: 'Seat'},
                          {startColumnName: 'salesOrderClosingItemDetailSeatInsertQuotation', numberOfColumns: 3, titleText: 'Seat Insert'},
                          {startColumnName: 'salesOrderClosingItemDetailStemQuotation', numberOfColumns: 3, titleText: 'Stem'},
                          
                          {startColumnName: 'salesOrderClosingItemDetailSealQuotation', numberOfColumns: 3, titleText: 'Seal'},
                          {startColumnName: 'salesOrderClosingItemDetailBoltQuotation', numberOfColumns: 3, titleText: 'Bolt'},
                          {startColumnName: 'salesOrderClosingItemDetailDiscQuotation', numberOfColumns: 3, titleText: 'Disc'},
                          {startColumnName: 'salesOrderClosingItemDetailPlatesQuotation', numberOfColumns: 3, titleText: 'Plates'},
                          {startColumnName: 'salesOrderClosingItemDetailShaftQuotation', numberOfColumns: 3, titleText: 'Shaft'},
                          {startColumnName: 'salesOrderClosingItemDetailSpringQuotation', numberOfColumns: 3, titleText: 'Spring'},
                          
                          {startColumnName: 'salesOrderClosingItemDetailArmPinQuotation', numberOfColumns: 3, titleText: 'Arm Pin'},
                          {startColumnName: 'salesOrderClosingItemDetailBackSeatQuotation', numberOfColumns: 3, titleText: 'Back Seat'},
                          {startColumnName: 'salesOrderClosingItemDetailArmQuotation', numberOfColumns: 3, titleText: 'Arm'},
                          {startColumnName: 'salesOrderClosingItemDetailHingePinQuotation', numberOfColumns: 3, titleText: 'Hinge Pin'},
                          {startColumnName: 'salesOrderClosingItemDetailStopPinQuotation', numberOfColumns: 3, titleText: 'Stop Pin'},
                          {startColumnName: 'salesOrderClosingItemDetailOperatorQuotation', numberOfColumns: 3, titleText: 'Operator'}
                    ]
                });
        }

    $(document).ready(function() {
        flagIsConfirmedSOClosing=false;
        flagIsConfirmedSOClosingSalesQuotation=false;
        flagIsConfirmedSOClosingItemDelivery=false;
        $("#frmSalesOrderClosingInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        
       
        
        formatNumericSOClosing();
//        $("#msgSalesOrderClosingActivity").html(" - <i>" + $("#enumSalesOrderClosingActivity").val()+"<i>").show();
        setSalesOrderClosingPartialShipmentStatusStatus();
        
        $('input[name="salesOrderClosingPartialShipmentStatusRad"][value="YES"]').change(function(ev){
            $("#salesOrderClosing\\.customerPurchaseOrder\\.partialShipmentStatus").val("YES");
        });
        
        $('input[name="salesOrderClosingPartialShipmentStatusRad"][value="NO"]').change(function(ev){
            $("#salesOrderClosing\\.customerPurchaseOrder\\.partialShipmentStatus").val("NO");
        });
        
        $('input[name="salesOrderClosingOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#salesOrderClosing\\.orderStatus").val(value);
        });
                
        $('input[name="salesOrderClosingOrderStatusRad"][value="SALES_ORDER"]').change(function(ev){
            var value="SALES_ORDER";
            $("#salesOrderClosing\\.orderStatus").val(value);
        });
        
        $('#salesOrderClosingOrderStatusRadSALES_ORDER').prop('checked',true);
        $("#salesOrderClosing\\.orderStatus").val("SALES_ORDER");
        
        //Set Default View
        $("#btnUnConfirmSalesOrderClosing").css("display", "none");
        $("#btnUnConfirmSalesOrderClosingSalesQuotation").css("display", "none");
        $("#btnUnConfirmSalesOrderClosingItemDetailDelivery").css("display", "none");
        $("#btnConfirmSalesOrderClosingSalesQuotationDetailSort").css("display", "none");
        $("#btnConfirmSalesOrderClosingItemDetailDelivery").css("display", "none");
        $("#btnConfirmSalesOrderClosingSalesQuotation").css("display", "none");
        $('#salesOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-payment-item-delivery-so-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-item-delivery-detail-so-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmSalesOrderClosing").click(function(ev) {
            flagIsConfirmedSOClosing=true;
            flagIsConfirmedSOClosingSalesQuotation=false;
            $("#btnUnConfirmSalesOrderClosing").css("display", "block");
            $("#btnConfirmSalesOrderClosing").css("display", "none");   
            $('#headerSalesOrderClosingInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#btnConfirmSalesOrderClosingSalesQuotation').show();
            $('#salesOrderClosingSalesQuotationInputGrid').unblock();
            loadSalesOrderClosingSalesQuotation();           
        });
                
        $("#btnUnConfirmSalesOrderClosing").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#salesOrderClosingSalesQuotationInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){ 
                    $("#btnUnConfirmSalesOrderClosing").css("display", "none");
                    $("#btnConfirmSalesOrderClosing").css("display", "block");
                    $("#btnConfirmSalesOrderClosingSalesQuotation").css("display", "none");
                    $('#headerSalesOrderClosingInput').unblock();
                    $('#salesOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    flagIsConfirmedSOClosing=false;
                    flagIsConfirmedSOClosingSalesQuotation=false;
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
                                flagIsConfirmedSOClosing=false;
                                $("#salesOrderClosingSalesQuotationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmSalesOrderClosing").css("display", "none");
                                $("#btnConfirmSalesOrderClosing").css("display", "block");
                                $('#headerSalesOrderClosingInput').unblock();
                                $("#btnConfirmSalesOrderClosingSalesQuotation").css("display", "none");
                                $('#salesOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                clearSalesOrderClosingTransactionAmount();
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
        
        $("#btnConfirmSalesOrderClosingSalesQuotation").click(function(ev) {
            if(flagIsConfirmedSOClosing){
                
                if(salesOrderClosingSalesQuotation_lastSel !== -1) {
                    $('#salesOrderClosingSalesQuotationInput_grid').jqGrid("saveRow",salesOrderClosingSalesQuotation_lastSel); 
                }

                var ids = jQuery("#salesOrderClosingSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#salesOrderClosingSalesQuotationInput_grid").jqGrid('getRowData',ids[i]); 

                    if(data.salesOrderClosingSalesQuotationCode===""){
                        alertMessage("Sales Quotation Can't Empty!");
                        return;
                    }
                }
            
                $("#btnUnConfirmSalesOrderClosing").css("display", "none");
                $("#btnUnConfirmSalesOrderClosingSalesQuotation").css("display", "block");
                $("#btnConfirmSalesOrderClosingSalesQuotationDetailSort").css("display", "block");
                $("#btnConfirmSalesOrderClosingItemDetailDelivery").css("display", "block");
                $("#btnConfirmSalesOrderClosingSalesQuotation").css("display", "none");   
                $('#salesOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-so-closing').unblock();
                flagIsConfirmedSOClosingSalesQuotation=true;
                loadSalesOrderClosingItemDetailRevise();
                loadSalesOrderClosingAdditionalFee();
                loadSalesOrderClosingPaymentTerm();
            }
        });
        
        $("#btnUnConfirmSalesOrderClosingSalesQuotation").click(function(ev) {
            $("#salesOrderClosingItemDetailInput_grid").jqGrid('destroyGroupHeader');
            $("#salesOrderClosingItemDetailInput_grid").jqGrid('clearGridData');
            $("#salesOrderClosingAdditionalFeeInput_grid").jqGrid('clearGridData');
            $("#salesOrderClosingPaymentTermInput_grid").jqGrid('clearGridData');
            $("#salesOrderClosingItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmSalesOrderClosing").css("display", "block");
            $("#btnUnConfirmSalesOrderClosingSalesQuotation").css("display", "none");
            $("#btnConfirmSalesOrderClosingSalesQuotationDetailSort").css("display", "none");
            $("#btnConfirmSalesOrderClosingItemDetailDelivery").css("display", "none");
            $("#btnConfirmSalesOrderClosingSalesQuotation").css("display", "block");
            $('#salesOrderClosingSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery-so-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedSOClosingSalesQuotation=false;
            clearSalesOrderClosingTransactionAmount();
        });
        
        $("#btnConfirmSalesOrderClosingItemDetailDelivery").click(function(ev) {
            if(flagIsConfirmedSOClosing){
                
                if(salesOrderClosingItemDelivery_lastSel !== -1) {
                    $('#salesOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",salesOrderClosingItemDelivery_lastSel); 
                }
                
                var idq = jQuery("#salesOrderClosingPaymentTermInput_grid").jqGrid('getDataIDs');
                if(idq.length===0){
                    alertMessage("Grid Payment Term Minimal 1(one) row!");
                    return;
                }
                
                var ids = jQuery("#salesOrderClosingSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                $("#btnConfirmSalesOrderClosingItemDetailDelivery").css("display", "none");   
                $("#btnUnConfirmSalesOrderClosingItemDetailDelivery").css("display", "block");   
                $("#btnUnConfirmSalesOrderClosingSalesQuotation").css("display", "none");   
                $('#salesOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-so-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-item-delivery-detail-so-closing').unblock();
                loadSalesOrderClosingItemDeliveryDate();
                flagIsConfirmedSOClosingItemDelivery=true;
                
            }
        });
        
        $("#btnUnConfirmSalesOrderClosingItemDetailDelivery").click(function(ev) {
            $("#salesOrderClosingItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmSalesOrderClosingItemDetailDelivery").css("display", "none");
            $("#btnConfirmSalesOrderClosingItemDetailDelivery").css("display", "block");
            $("#btnUnConfirmSalesOrderClosingSalesQuotation").show(); 
            $('#salesOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#id-tbl-additional-payment-item-delivery-so-closing').unblock();
            $('#id-tbl-additional-item-delivery-detail-so-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedSOClosingItemDelivery=false;
        });
        
        $.subscribe("salesOrderClosingSalesQuotationInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderClosingSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderClosingSalesQuotation_lastSel) {

                $('#salesOrderClosingSalesQuotationInput_grid').jqGrid("saveRow",salesOrderClosingSalesQuotation_lastSel); 
                $('#salesOrderClosingSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderClosingSalesQuotation_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderClosingSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderClosingItemDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderClosingItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderClosingItemDetail_lastSel) {

                $('#salesOrderClosingItemDetailInput_grid').jqGrid("saveRow",salesOrderClosingItemDetail_lastSel); 
                $('#salesOrderClosingItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderClosingItemDetail_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderClosingItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderClosingAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderClosingAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderClosingAdditionalFee_lastSel) {

                $('#salesOrderClosingAdditionalFeeInput_grid').jqGrid("saveRow",salesOrderClosingAdditionalFee_lastSel); 
                $('#salesOrderClosingAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderClosingAdditionalFee_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderClosingAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderClosingPaymentTermInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderClosingPaymentTermInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesOrderClosingPaymentTerm_lastSel) {

                $('#salesOrderClosingPaymentTermInput_grid').jqGrid("saveRow",salesOrderClosingPaymentTerm_lastSel); 
                $('#salesOrderClosingPaymentTermInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderClosingPaymentTerm_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderClosingPaymentTermInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("salesOrderClosingItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesOrderClosingItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==salesOrderClosingItemDelivery_lastSel) {

                $('#salesOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",salesOrderClosingItemDelivery_lastSel); 
                $('#salesOrderClosingItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesOrderClosingItemDelivery_lastSel=selectedRowID;

            }
            else{
                $('#salesOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnSalesOrderClosingCopyFromDetail').click(function(ev) {
            
            $("#salesOrderClosingItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(salesOrderClosingItemDetail_lastSel !== -1) {
                $('#salesOrderClosingItemDetailInput_grid').jqGrid("saveRow",salesOrderClosingItemDetail_lastSel); 
            }
            
            var ids = jQuery("#salesOrderClosingItemDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#salesOrderClosingItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    salesOrderClosingItemDeliveryDelete                 : "delete",
                    salesOrderClosingItemDeliverySearchItem             : "...",
                    salesOrderClosingItemDeliveryItemCode               : data.salesOrderClosingItemDetailItem,
                    salesOrderClosingItemDeliverySortNo                 : data.salesOrderClosingItemDetailSortNo,
                    salesOrderClosingItemDeliveryQuantity               : data.salesOrderClosingItemDetailQuantity,
                    salesOrderClosingItemDeliverySearchQuotation        : "...",
                    salesOrderClosingItemDeliverySalesQuotationCode     : data.salesOrderClosingItemDetailQuotationNo,
                    salesOrderClosingItemDeliveryItemFinishGoodsCode    : data.salesOrderClosingItemDetailItemFinishGoodsCode,   
                    salesOrderClosingItemDeliveryItemFinishGoodsRemark  : data.salesOrderClosingItemDetailItemFinishGoodsRemark
                };
                salesOrderClosingItemDeliveryLastRowId++;
                $("#salesOrderClosingItemDeliveryInput_grid").jqGrid("addRowData", salesOrderClosingItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#salesOrderClosingItemDeliveryInput_grid").jqGrid('setRowData',salesOrderClosingItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnSalesOrderClosingSave').click(function(ev) {
            
            if(!flagIsConfirmedSOClosingSalesQuotation){
                return;
            }
            formatDateSOClosing();
            unFormatNumericSOClosing();
            
            var url = "sales/customer-sales-order-closing-save";
            var params = $("#frmSalesOrderClosingInput").serialize();
           
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateSOClosing();
                    formatNumericSOClosing();
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
                                        var params = "";
                                        var url = "sales/customer-sales-order-closing-input";
                                        pageLoad(url, params, "#tabmnuSALES_ORDER_CLOSING");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/customer-sales-order-closing";
                                        pageLoad(url, params, "#tabmnuSALES_ORDER_CLOSING");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnSalesOrderClosingCancel').click(function(ev) {
            var url = "sales/customer-sales-order-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuSALES_ORDER_CLOSING"); 
        });
        
        $('#btnSalesOrderClosingDeliveryDateSet').click(function(ev) {
            if(salesOrderClosingItemDelivery_lastSel !== -1) {
                $('#salesOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",salesOrderClosingItemDelivery_lastSel); 
            }
            
            var deliveryDate=$("#salesOrderClosingDeliveryDateSet").val();
            var ids = jQuery("#salesOrderClosingItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#salesOrderClosingItemDeliveryInput_grid").jqGrid("setCell",ids[i], "salesOrderClosingItemDeliveryDeliveryDate",deliveryDate);
                $("#salesOrderClosingItemDeliveryInput_grid").jqGrid("setCell",ids[i], "salesOrderClosingItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
 });
 
    function formatDateSOClosing(){
        var transactionDateSplit=dtpSalesOrderClosingTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpSalesOrderClosingTransactionDate.val(transactionDate);
    }

    function unFormatNumericSOClosing(){
        var retention =removeCommas(txtSalesOrderClosingRetention.val());
        txtSalesOrderClosingRetention.val(retention);
        
        var totalTransactionAmount =removeCommas(txtSalesOrderClosingTotalTransactionAmount.val());
        txtSalesOrderClosingTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtSalesOrderClosingDiscountAmount.val());
        txtSalesOrderClosingDiscountAmount.val(discountAmount);
        var taxBaseAmount =removeCommas(txtSalesOrderClosingTaxBaseAmount.val());
        txtSalesOrderClosingTaxBaseAmount.val(taxBaseAmount);
        var vatPercent =removeCommas(txtSalesOrderClosingVATPercent.val());
        txtSalesOrderClosingVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtSalesOrderClosingVATAmount.val());
        txtSalesOrderClosingVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtSalesOrderClosingGrandTotalAmount.val());
        txtSalesOrderClosingGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericSOClosing(){
        
        var retention =parseFloat(txtSalesOrderClosingRetention.val());
        txtSalesOrderClosingRetention.val(formatNumber(retention,2));
        
        var totalTransactionAmount =parseFloat(txtSalesOrderClosingTotalTransactionAmount.val());
        txtSalesOrderClosingTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtSalesOrderClosingDiscountPercent.val());
        txtSalesOrderClosingDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtSalesOrderClosingDiscountAmount.val());
        txtSalesOrderClosingDiscountAmount.val(formatNumber(discountAmount,2));
        var taxBaseAmount =parseFloat(txtSalesOrderClosingTaxBaseAmount.val());
        txtSalesOrderClosingTaxBaseAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtSalesOrderClosingVATPercent.val());
        txtSalesOrderClosingVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtSalesOrderClosingVATAmount.val());
        txtSalesOrderClosingVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtSalesOrderClosingGrandTotalAmount.val());
        txtSalesOrderClosingGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }    
    
    function clearSalesOrderClosingTransactionAmount(){
        txtSalesOrderClosingTotalTransactionAmount.val("0.00");        
        txtSalesOrderClosingDiscountPercent.val("0.00");
        txtSalesOrderClosingDiscountAmount.val("0.00");
        txtSalesOrderClosingTotalAdditionalFee.val("0.00");
        txtSalesOrderClosingTaxBaseAmount.val("0.00");
        txtSalesOrderClosingVATPercent.val("0.00");
        txtSalesOrderClosingVATAmount.val("0.00");
        txtSalesOrderClosingGrandTotalAmount.val("0.00");
    }
    
    function calculateSalesOrderClosingAdditionalFee() {
        var selectedRowID = $("#salesOrderClosingAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var qty = $("#" + selectedRowID + "_salesOrderClosingAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_salesOrderClosingAdditionalFeePrice").val();
        
        var subTotal = (parseFloat(qty) * parseFloat(price));
        
        $("#salesOrderClosingAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "salesOrderClosingAdditionalFeeTotal", subTotal);

        calculateSalesOrderClosingTotalAdditional();
    }
    
    function calculateSalesOrderClosingTotalAdditional() {
        var totalAmount =0;
        var ids = jQuery("#salesOrderClosingAdditionalFeeInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#salesOrderClosingAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.salesOrderClosingAdditionalFeeTotal);
        }   
        
        txtSalesOrderClosingTotalAdditionalFee.val(formatNumber(totalAmount,2));
        calculateSalesOrderClosingHeader();

    }
    
    function calculateSalesOrderClosingHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var additionalFeeAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#salesOrderClosingItemDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#salesOrderClosingItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.salesOrderClosingItemDetailTotal);
        }   
        txtSalesOrderClosingTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtSalesOrderClosingTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtSalesOrderClosingDiscountPercent.val()));        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtSalesOrderClosingDiscountAmount.val()===""){
            discAmount=0;
        }
        
        additionalFeeAmount=parseFloat(removeCommas(txtSalesOrderClosingTotalAdditionalFee.val()));  
        
        subTotal = (totalTransaction-discAmount)+additionalFeeAmount;
        
        if(txtSalesOrderClosingVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtSalesOrderClosingVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtSalesOrderClosingDiscountAmount.val(formatNumber(discAmount,2));
        txtSalesOrderClosingTaxBaseAmount.val(formatNumber(subTotal,2));
        txtSalesOrderClosingVATAmount.val(formatNumber(vatAmount,2));        
        txtSalesOrderClosingGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onchangeSalesOrderClosingItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#salesOrderClosingItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_salesOrderClosingItemDeliveryDeliveryDate").val();
        
        $("#salesOrderClosingItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "salesOrderClosingItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    
    function loadSalesOrderClosingSalesQuotation() {
        var enumSalesOrderClosingActivity=$("#enumSalesOrderClosingActivity").val();
        if(enumSalesOrderClosingActivity==="NEW"){
            return;
        }                
        
        var url = "sales/customer-sales-order-sales-quotation-data";
        var params = "salesOrder.code="+$("#salesOrderClosing\\.customerSalesOrderCode").val();
        
        salesOrderClosingSalesQuotationLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderSalesQuotation.length; i++) {
                salesOrderClosingSalesQuotationLastRowId++;
                
                $("#salesOrderClosingSalesQuotationInput_grid").jqGrid("addRowData", salesOrderClosingSalesQuotationLastRowId, data.listCustomerSalesOrderSalesQuotation[i]);
                $("#salesOrderClosingSalesQuotationInput_grid").jqGrid('setRowData',salesOrderClosingSalesQuotationLastRowId,{
                    salesOrderClosingSalesQuotationCode             : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationCode,
                    salesOrderClosingSalesQuotationTransactionDate  : formatDateRemoveT(data.listCustomerSalesOrderSalesQuotation[i].salesQuotationTransactionDate,true),
                    salesOrderClosingSalesQuotationCustomerCode     : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationCustomerCode,
                    salesOrderClosingSalesQuotationCustomerName     : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationCustomerName,
                    salesOrderClosingSalesQuotationEndUserCode      : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationEndUserCode,
                    salesOrderClosingSalesQuotationEndUserName      : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationEndUserName,
                    salesOrderClosingSalesQuotationRfqCode          : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationRfqNo,
                    salesOrderClosingSalesQuotationProjectCode      : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationProject,
                    salesOrderClosingSalesQuotationSubject          : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationSubject,
                    salesOrderClosingSalesQuotationAttn             : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationAttn,
                    salesOrderClosingSalesQuotationRefNo            : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationRefNo,
                    salesOrderClosingSalesQuotationRemark           : data.listCustomerSalesOrderSalesQuotation[i].salesQuotationRemark
                });
            }
        });
        closeLoading();
    }
    
    function loadSalesOrderClosingItemDetailRevise() {
        loadGridItemSOClosing();
        var arrSalesQuotationNo=new Array();
        var totalTransaction=0;
        var ids = jQuery("#salesOrderClosingSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#salesOrderClosingSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNo.push(data.salesOrderClosingSalesQuotationCode);
        }
        
        var url = "sales/customer-sales-order-item-detail-data-array-data";
        var params = "arrSalesQuotationSoNo="+arrSalesQuotationNo;   
            params += "&salesOrder.code="+$("#salesOrderClosing\\.customerSalesOrderCode").val();
            
        salesOrderClosingItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerSalesOrderItemDetail.length; i++) {
                salesOrderClosingItemDetailLastRowId++;
                
                $("#salesOrderClosingItemDetailInput_grid").jqGrid("addRowData", salesOrderClosingItemDetailLastRowId, data.listCustomerSalesOrderItemDetail[i]);
                $("#salesOrderClosingItemDetailInput_grid").jqGrid('setRowData',salesOrderClosingItemDetailLastRowId,{
                    salesOrderClosingItemDetailQuotationNoDetailCode    : data.listCustomerSalesOrderItemDetail[i].salesQuotationDetailCode,
                    salesOrderClosingItemDetailQuotationNo              : data.listCustomerSalesOrderItemDetail[i].salesQuotationCode,
                    salesOrderClosingItemDetailItemFinishGoodsCode      : data.listCustomerSalesOrderItemDetail[i].itemFinishGoodsCode,
                    salesOrderClosingItemDetailItemFinishGoodsRemark    : data.listCustomerSalesOrderItemDetail[i].itemFinishGoodsRemark,
                    salesOrderClosingItemDetailSortNo                   : data.listCustomerSalesOrderItemDetail[i].customerPurchaseOrderSortNo,
                    salesOrderClosingItemDetailValveTypeCode            : data.listCustomerSalesOrderItemDetail[i].valveTypeCode,
                    salesOrderClosingItemDetailValveTypeName            : data.listCustomerSalesOrderItemDetail[i].valveTypeName,
                    salesOrderClosingItemDetailItemAlias                : data.listCustomerSalesOrderItemDetail[i].itemAlias,
                    salesOrderClosingItemDetailValveTag                 : data.listCustomerSalesOrderItemDetail[i].valveTag,
                    salesOrderClosingItemDetailDataSheet                : data.listCustomerSalesOrderItemDetail[i].dataSheet,
                    salesOrderClosingItemDetailDescription              : data.listCustomerSalesOrderItemDetail[i].description,
                                      
                    // 24 valve Type Component Quotation
                    salesOrderClosingItemDetailBodyConstQuotation   : data.listCustomerSalesOrderItemDetail[i].bodyConstruction,
                    salesOrderClosingItemDetailTypeDesignQuotation  : data.listCustomerSalesOrderItemDetail[i].typeDesign,
                    salesOrderClosingItemDetailSeatDesignQuotation  : data.listCustomerSalesOrderItemDetail[i].seatDesign,
                    salesOrderClosingItemDetailSizeQuotation        : data.listCustomerSalesOrderItemDetail[i].size,
                    salesOrderClosingItemDetailRatingQuotation      : data.listCustomerSalesOrderItemDetail[i].rating,
                    salesOrderClosingItemDetailBoreQuotation        : data.listCustomerSalesOrderItemDetail[i].bore,
                    
                    salesOrderClosingItemDetailEndConQuotation      : data.listCustomerSalesOrderItemDetail[i].endCon,
                    salesOrderClosingItemDetailBodyQuotation        : data.listCustomerSalesOrderItemDetail[i].body,
                    salesOrderClosingItemDetailBallQuotation        : data.listCustomerSalesOrderItemDetail[i].ball,
                    salesOrderClosingItemDetailSeatQuotation        : data.listCustomerSalesOrderItemDetail[i].seat,
                    salesOrderClosingItemDetailSeatInsertQuotation  : data.listCustomerSalesOrderItemDetail[i].seatInsert,
                    salesOrderClosingItemDetailStemQuotation        : data.listCustomerSalesOrderItemDetail[i].stem,
                    
                    salesOrderClosingItemDetailSealQuotation        : data.listCustomerSalesOrderItemDetail[i].seal,
                    salesOrderClosingItemDetailBoltQuotation        : data.listCustomerSalesOrderItemDetail[i].bolting,
                    salesOrderClosingItemDetailDiscQuotation        : data.listCustomerSalesOrderItemDetail[i].disc,
                    salesOrderClosingItemDetailPlatesQuotation      : data.listCustomerSalesOrderItemDetail[i].plates,
                    salesOrderClosingItemDetailShaftQuotation       : data.listCustomerSalesOrderItemDetail[i].shaft,
                    salesOrderClosingItemDetailSpringQuotation      : data.listCustomerSalesOrderItemDetail[i].spring,
                    
                    salesOrderClosingItemDetailArmPinQuotation      : data.listCustomerSalesOrderItemDetail[i].armPin,
                    salesOrderClosingItemDetailBackSeatQuotation    : data.listCustomerSalesOrderItemDetail[i].backSeat,
                    salesOrderClosingItemDetailArmQuotation         : data.listCustomerSalesOrderItemDetail[i].arm,
                    salesOrderClosingItemDetailHingePinQuotation    : data.listCustomerSalesOrderItemDetail[i].hingePin,
                    salesOrderClosingItemDetailStopPinQuotation     : data.listCustomerSalesOrderItemDetail[i].stopPin,
                    salesOrderClosingItemDetailOperatorQuotation    : data.listCustomerSalesOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    salesOrderClosingItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerSalesOrderItemDetail[i].itemBodyConstructionCode,
                    salesOrderClosingItemDetailItemFinishGoodsBodyConstName     : data.listCustomerSalesOrderItemDetail[i].itemBodyConstructionName,
                    salesOrderClosingItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerSalesOrderItemDetail[i].itemTypeDesignCode,
                    salesOrderClosingItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerSalesOrderItemDetail[i].itemTypeDesignName,
                    salesOrderClosingItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerSalesOrderItemDetail[i].itemSeatDesignCode,
                    salesOrderClosingItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerSalesOrderItemDetail[i].itemSeatDesignName,
                    salesOrderClosingItemDetailItemFinishGoodsSizeCode          : data.listCustomerSalesOrderItemDetail[i].itemSizeCode,
                    salesOrderClosingItemDetailItemFinishGoodsSizeName          : data.listCustomerSalesOrderItemDetail[i].itemSizeName,
                    salesOrderClosingItemDetailItemFinishGoodsRatingCode        : data.listCustomerSalesOrderItemDetail[i].itemRatingCode,
                    salesOrderClosingItemDetailItemFinishGoodsRatingName        : data.listCustomerSalesOrderItemDetail[i].itemRatingName,
                    salesOrderClosingItemDetailItemFinishGoodsBoreCode          : data.listCustomerSalesOrderItemDetail[i].itemBoreCode,
                    salesOrderClosingItemDetailItemFinishGoodsBoreName          : data.listCustomerSalesOrderItemDetail[i].itemBoreName,
                    
                    salesOrderClosingItemDetailItemFinishGoodsEndConCode        : data.listCustomerSalesOrderItemDetail[i].itemEndConCode,
                    salesOrderClosingItemDetailItemFinishGoodsEndConName        : data.listCustomerSalesOrderItemDetail[i].itemEndConName,
                    salesOrderClosingItemDetailItemFinishGoodsBodyCode          : data.listCustomerSalesOrderItemDetail[i].itemBodyCode,
                    salesOrderClosingItemDetailItemFinishGoodsBodyName          : data.listCustomerSalesOrderItemDetail[i].itemBodyName,
                    salesOrderClosingItemDetailItemFinishGoodsBallCode          : data.listCustomerSalesOrderItemDetail[i].itemBallCode,
                    salesOrderClosingItemDetailItemFinishGoodsBallName          : data.listCustomerSalesOrderItemDetail[i].itemBallName,
                    salesOrderClosingItemDetailItemFinishGoodsSeatCode          : data.listCustomerSalesOrderItemDetail[i].itemSeatCode,
                    salesOrderClosingItemDetailItemFinishGoodsSeatName          : data.listCustomerSalesOrderItemDetail[i].itemSeatName,
                    salesOrderClosingItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerSalesOrderItemDetail[i].itemSeatInsertCode,
                    salesOrderClosingItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerSalesOrderItemDetail[i].itemSeatInsertName,
                    salesOrderClosingItemDetailItemFinishGoodsStemCode          : data.listCustomerSalesOrderItemDetail[i].itemStemCode,
                    salesOrderClosingItemDetailItemFinishGoodsStemName          : data.listCustomerSalesOrderItemDetail[i].itemStemName,
                    
                    salesOrderClosingItemDetailItemFinishGoodsSealCode          : data.listCustomerSalesOrderItemDetail[i].itemSealCode,
                    salesOrderClosingItemDetailItemFinishGoodsSealName          : data.listCustomerSalesOrderItemDetail[i].itemSealName,
                    salesOrderClosingItemDetailItemFinishGoodsBoltCode          : data.listCustomerSalesOrderItemDetail[i].itemBoltCode,
                    salesOrderClosingItemDetailItemFinishGoodsBoltName          : data.listCustomerSalesOrderItemDetail[i].itemBoltName,
                    salesOrderClosingItemDetailItemFinishGoodsDiscCode          : data.listCustomerSalesOrderItemDetail[i].itemDiscCode,
                    salesOrderClosingItemDetailItemFinishGoodsDiscName          : data.listCustomerSalesOrderItemDetail[i].itemDiscName,
                    salesOrderClosingItemDetailItemFinishGoodsPlatesCode        : data.listCustomerSalesOrderItemDetail[i].itemPlatesCode,
                    salesOrderClosingItemDetailItemFinishGoodsPlatesName        : data.listCustomerSalesOrderItemDetail[i].itemPlatesName,
                    salesOrderClosingItemDetailItemFinishGoodsShaftCode         : data.listCustomerSalesOrderItemDetail[i].itemShaftCode,
                    salesOrderClosingItemDetailItemFinishGoodsShaftName         : data.listCustomerSalesOrderItemDetail[i].itemShaftName,
                    salesOrderClosingItemDetailItemFinishGoodsSpringCode        : data.listCustomerSalesOrderItemDetail[i].itemSpringCode,
                    salesOrderClosingItemDetailItemFinishGoodsSpringName        : data.listCustomerSalesOrderItemDetail[i].itemSpringName,
                    
                    salesOrderClosingItemDetailItemFinishGoodsArmPinCode        : data.listCustomerSalesOrderItemDetail[i].itemArmPinCode, 
                    salesOrderClosingItemDetailItemFinishGoodsArmPinName        : data.listCustomerSalesOrderItemDetail[i].itemArmPinName, 
                    salesOrderClosingItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerSalesOrderItemDetail[i].itemBackSeatCode,
                    salesOrderClosingItemDetailItemFinishGoodsBackSeatName      : data.listCustomerSalesOrderItemDetail[i].itemBackSeatName,
                    salesOrderClosingItemDetailItemFinishGoodsArmCode           : data.listCustomerSalesOrderItemDetail[i].itemArmCode,
                    salesOrderClosingItemDetailItemFinishGoodsArmName           : data.listCustomerSalesOrderItemDetail[i].itemArmName,
                    salesOrderClosingItemDetailItemFinishGoodsHingePinCode      : data.listCustomerSalesOrderItemDetail[i].itemHingePinCode,
                    salesOrderClosingItemDetailItemFinishGoodsHingePinName      : data.listCustomerSalesOrderItemDetail[i].itemHingePinName,
                    salesOrderClosingItemDetailItemFinishGoodsStopPinCode       : data.listCustomerSalesOrderItemDetail[i].itemStopPinCode,
                    salesOrderClosingItemDetailItemFinishGoodsStopPinName       : data.listCustomerSalesOrderItemDetail[i].itemStopPinName,
                    salesOrderClosingItemDetailItemFinishGoodsOperatorCode      : data.listCustomerSalesOrderItemDetail[i].itemOperatorCode,
                    salesOrderClosingItemDetailItemFinishGoodsOperatorName      : data.listCustomerSalesOrderItemDetail[i].itemOperatorName,
                    
                    salesOrderClosingItemDetailNote                 : data.listCustomerSalesOrderItemDetail[i].note,
                    salesOrderClosingItemDetailQuantity             : data.listCustomerSalesOrderItemDetail[i].quantity,
                    salesOrderClosingItemDetailPrice                : data.listCustomerSalesOrderItemDetail[i].unitPrice,
                    salesOrderClosingItemDetailTotal                : data.listCustomerSalesOrderItemDetail[i].totalAmount
                });
                calculateSalesOrderClosingHeader();
            }
        });
        closeLoading();
    }
    
    function loadSalesOrderClosingAdditionalFee() {     
        var url = "sales/customer-sales-order-additional-fee-data";
        var params = "salesOrder.code="+$("#salesOrderClosing\\.customerSalesOrderCode").val();   
        
        salesOrderClosingAdditionalFeeLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderAdditionalFee.length; i++) {
                salesOrderClosingAdditionalFeeLastRowId++;
                
                $("#salesOrderClosingAdditionalFeeInput_grid").jqGrid("addRowData", salesOrderClosingAdditionalFeeLastRowId, data.listCustomerSalesOrderAdditionalFee[i]);
                $("#salesOrderClosingAdditionalFeeInput_grid").jqGrid('setRowData',salesOrderClosingAdditionalFeeLastRowId,{
                    salesOrderClosingAdditionalFeeRemark             : data.listCustomerSalesOrderAdditionalFee[i].remark,
                    salesOrderClosingAdditionalFeeQuantity           : data.listCustomerSalesOrderAdditionalFee[i].quantity,
                    salesOrderClosingAdditionalFeeUnitOfMeasureCode  : data.listCustomerSalesOrderAdditionalFee[i].unitOfMeasureCode,
                    salesOrderClosingAdditionalFeeAdditionalFeeCode  : data.listCustomerSalesOrderAdditionalFee[i].additionalFeeCode,
                    salesOrderClosingAdditionalFeeAdditionalFeeName  : data.listCustomerSalesOrderAdditionalFee[i].additionalFeeName,
                    salesOrderClosingAdditionalFeeChartOfAccountCode : data.listCustomerSalesOrderAdditionalFee[i].coaCode,
                    salesOrderClosingAdditionalFeeChartOfAccountName : data.listCustomerSalesOrderAdditionalFee[i].coaName,
                    salesOrderClosingAdditionalFeePrice              : data.listCustomerSalesOrderAdditionalFee[i].price,
                    salesOrderClosingAdditionalFeeTotal              : data.listCustomerSalesOrderAdditionalFee[i].total
                });
            }
            calculateSalesOrderClosingTotalAdditional();
        });
        closeLoading();
    }
    
    function loadSalesOrderClosingPaymentTerm() {    
        var url = "sales/customer-sales-order-payment-term-data";
        var params = "salesOrder.code="+$("#salesOrderClosing\\.customerSalesOrderCode").val();   
        
        salesOrderClosingPaymentTermLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderPaymentTerm.length; i++) {
                salesOrderClosingPaymentTermLastRowId++;
                
                $("#salesOrderClosingPaymentTermInput_grid").jqGrid("addRowData", salesOrderClosingPaymentTermLastRowId, data.listCustomerSalesOrderPaymentTerm[i]);
                $("#salesOrderClosingPaymentTermInput_grid").jqGrid('setRowData',salesOrderClosingPaymentTermLastRowId,{
                    salesOrderClosingPaymentTermSortNO             : data.listCustomerSalesOrderPaymentTerm[i].sortNo,
                    salesOrderClosingPaymentTermPaymentTermCode    : data.listCustomerSalesOrderPaymentTerm[i].paymentTermCode,
                    salesOrderClosingPaymentTermPaymentTermName    : data.listCustomerSalesOrderPaymentTerm[i].paymentTermName,
                    salesOrderClosingPaymentTermPercent            : data.listCustomerSalesOrderPaymentTerm[i].percentage,
                    salesOrderClosingPaymentTermRemark             : data.listCustomerSalesOrderPaymentTerm[i].remark
                });
            }
        });
        closeLoading();
    }
    
    function loadSalesOrderClosingItemDeliveryDate() {   
        var url = "sales/customer-sales-order-item-delivery-data";
        var params = "salesOrder.code="+$("#salesOrderClosing\\.customerSalesOrderCode").val();   
        
        salesOrderClosingItemDeliveryLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerSalesOrderItemDeliveryDate.length; i++) {
                salesOrderClosingItemDeliveryLastRowId++;
                
                $("#salesOrderClosingItemDeliveryInput_grid").jqGrid("addRowData", salesOrderClosingItemDeliveryLastRowId, data.listCustomerSalesOrderItemDeliveryDate[i]);
                $("#salesOrderClosingItemDeliveryInput_grid").jqGrid('setRowData',salesOrderClosingItemDeliveryLastRowId,{
                    salesOrderClosingItemDeliverySalesQuotationCode       : data.listCustomerSalesOrderItemDeliveryDate[i].salesQuotationCode,
                    salesOrderClosingItemDeliverySalesQuotationRefNo      : data.listCustomerSalesOrderItemDeliveryDate[i].refNo,
                    salesOrderClosingItemDeliveryItemFinishGoodsCode      : data.listCustomerSalesOrderItemDeliveryDate[i].itemFinishGoodsCode,
                    salesOrderClosingItemDeliveryItemFinishGoodsRemark    : data.listCustomerSalesOrderItemDeliveryDate[i].itemFinishGoodsRemark,
                    salesOrderClosingItemDeliverySortNo                   : data.listCustomerSalesOrderItemDeliveryDate[i].customerPurchaseOrderSortNo,
                    salesOrderClosingItemDeliveryQuantity                 : data.listCustomerSalesOrderItemDeliveryDate[i].quantity,
                    salesOrderClosingItemDeliveryDeliveryDate             : formatDateRemoveT(data.listCustomerSalesOrderItemDeliveryDate[i].deliveryDate,false)
                });
            }
        });
        closeLoading();
    }
    
    function sortNoDelivery(itemCode){
         $('#salesOrderClosingItemDetailInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel); 
         var ids = jQuery("#salesOrderClosingItemDetailInput_grid").jqGrid('getDataIDs');
         var temp="";
        for(var i=0;i<ids.length;i++){
                var Detail = $("#salesOrderClosingItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                if (itemCode===Detail.salesOrderClosingItemDetailItem){
                    temp=Detail.salesOrderClosingItemDetailSortNo;
                }
               
        }
        
         $('#salesOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",salesOrderClosingItemDelivery_lastSel); 
         var idt = jQuery("#salesOrderClosingItemDeliveryInput_grid").jqGrid('getDataIDs');
         for(var i=0;i<idt.length;i++){
             var Details = $("#salesOrderClosingItemDeliveryInput_grid").jqGrid('getRowData',idt[i]); 
                if (itemCode===Details.salesOrderClosingItemDeliveryItemCode){
                    $("#salesOrderClosingItemDeliveryInput_grid").jqGrid("setCell",idt[i], "salesOrderClosingItemDeliverySortNo",temp);

                }
         }
    }
    
    function setSalesOrderClosingPartialShipmentStatusStatus(){
        switch($("#salesOrderClosing\\.customerPurchaseOrder\\.partialShipmentStatus").val()){
            case "YES":
                $('input[name="salesOrderClosingPartialShipmentStatusRad"][value="YES"]').prop('checked',true);
                $('input[name="salesOrderClosingPartialShipmentStatusRad"][value="NO"]').prop('disabled',true);
                break;
            case "NO":
                $('input[name="salesOrderClosingPartialShipmentStatusRad"][value="NO"]').prop('checked',true);
                $('input[name="salesOrderClosingPartialShipmentStatusRad"][value="YES"]').prop('disabled',true);
                break;
        } 
    }
</script>

<s:url id="remoteurlSalesOrderClosingSalesQuotationInput" action="" />
<s:url id="remoteurlSalesOrderClosingAdditionalFeeInput" action="" />
<s:url id="remoteurlSalesOrderClosingPaymentTermInput" action="" />
<s:url id="remoteurlSalesOrderClosingItemDeliveryInput" action="" />
<b>SALES ORDER CLOSING</b><span id="msgSalesOrderClosingActivity"></span>
<hr>
<br class="spacer" />

<div id="salesOrderClosingInput" class="content ui-widget">
    <s:form id="frmSalesOrderClosingInput">
        <table cellpadding="2" cellspacing="2" id="headerSalesOrderClosingInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" style="width:180px"><B>SOD No *</B></td>
                            <td>
                                <s:textfield id="salesOrderClosing.code" name="salesOrderClosing.code" key="salesOrderClosing.code" readonly="true" size="30"></s:textfield>
                                <s:textfield id="salesOrderClosing.customerSalesOrderCode" name="salesOrderClosing.customerSalesOrderCode" key="salesOrderClosing.customerSalesOrderCode" readonly="true" size="25" disabled="true" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ref SOD No *</B></td>
                            <td>
                            <s:textfield id="salesOrderClosing.custSONo" name="salesOrderClosing.custSONo" key="salesOrderClosing.custSONo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                                <s:textfield id="salesOrderClosing.refCUSTSOCode" name="salesOrderClosing.refCUSTSOCode" key="salesOrderClosing.refCUSTSOCode" readonly="true" size="30"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="salesOrderClosing.revision" name="salesOrderClosing.revision" key="salesOrderClosing.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="salesOrderClosing.branch.code" name="salesOrderClosing.branch.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                            </div>
                                <s:textfield id="salesOrderClosing.branch.name" name="salesOrderClosing.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="salesOrderClosing.transactionDate" name="salesOrderClosing.transactionDate" readonly="true" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" disabled="true"></sj:datepicker>
                                <sj:datepicker id="salesOrderClosingTransactionDate" name="salesOrderClosingTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right"><B>Order Status * </B></td>
                            <td colspan="2">
                                <s:radio id="salesOrderClosingOrderStatusRad" name="salesOrderClosingOrderStatusRad" label="salesOrderClosingOrderStatusRad" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio>
                                <s:textfield id="salesOrderClosing.orderStatus" name="salesOrderClosing.orderStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="salesOrderClosing.purchaseOrderType" name="salesOrderClosing.purchaseOrderType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order*</B></td>
                            <td colspan="3"><s:textfield id="salesOrderClosing.customerPurchaseOrder.code" name="salesOrderClosing.customerPurchaseOrder.code" size="27" title=" " required="true" cssClass="required" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order No*</B></td>
                            <td colspan="3"><s:textfield id="salesOrderClosing.customerPurchaseOrder.customerPurchaseOrderNo" name="salesOrderClosing.customerPurchaseOrder.customerPurchaseOrderNo" size="27" title=" " required="true" readonly="true" cssClass="required"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="salesOrderClosing.customer.code" name="salesOrderClosing.customer.code" size="22" title=" " required="true" cssClass="required"  readonly="true"></s:textfield>
                            </div>
                                <s:textfield id="salesOrderClosing.customer.name" name="salesOrderClosing.customer.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>End User *</B></td>
                            <td colspan="2">
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="salesOrderClosing.endUser.code" name="salesOrderClosing.endUser.code" size="22" title=" " required="true" cssClass="required"  readonly="true"></s:textfield>
                            </div>
                                <s:textfield id="salesOrderClosing.endUser.name" name="salesOrderClosing.endUser.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Partial Shipment * </B></td>
                            <td colspan="2">
                                <s:radio id="salesOrderClosingPartialShipmentStatusRad" name="salesOrderClosingPartialShipmentStatusRad" label="salesOrderClosingPartialShipmentStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="salesOrderClosing.customerPurchaseOrder.partialShipmentStatus" name="salesOrderClosing.customerPurchaseOrder.partialShipmentStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Retention</td>
                            <td>
                                <s:textfield id="salesOrderClosing.customerPurchaseOrder.retentionPercent" name="salesOrderClosing.customerPurchaseOrder.retentionPercent" size="5" cssStyle="text-align:right" readonly="true"></s:textfield>%
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>Currency *</B></td>
                            <td colspan="3">
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="salesOrderClosing.currency.code" name="salesOrderClosing.currency.code" title=" " required="true" cssClass="required" size="22" readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="salesOrderClosing.currency.name" name="salesOrderClosing.currency.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sales Person *</B></td>
                            <td colspan="2">
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="salesOrderClosing.salesPerson.code" name="salesOrderClosing.salesPerson.code" title=" " required="true" cssClass="required" size="22"  readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="salesOrderClosing.salesPerson.name" name="salesOrderClosing.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Project</td>
                            <td colspan="2">
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="salesOrderClosing.project.code" name="salesOrderClosing.project.code" title=" " size="22"  readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="salesOrderClosing.project.name" name="salesOrderClosing.project.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3"><s:textfield id="salesOrderClosing.refNo" name="salesOrderClosing.refNo" size="27" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="salesOrderClosing.remark" name="salesOrderClosing.remark"  cols="70" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr> 
                    </table>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="salesOrderClosingDateFirstSession" name="salesOrderClosingDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="salesOrderClosingDateLastSession" name="salesOrderClosingDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumSalesOrderClosingActivity" name="enumSalesOrderClosingActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="salesOrderClosing.createdBy" name="salesOrderClosing.createdBy" key="salesOrderClosing.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="salesOrderClosing.createdDate" name="salesOrderClosing.createdDate" disabled="true" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="salesOrderClosing.createdDateTemp" name="salesOrderClosing.createdDateTemp" size="20" cssStyle="display:none" disabled="true"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmSalesOrderClosing" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmSalesOrderClosing" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <div id="salesOrderClosingSalesQuotationInputGrid">
            <sjg:grid
                id="salesOrderClosingSalesQuotationInput_grid"
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
                width="$('#tabmnuSalesOrderClosingDetail').width()"
                editurl="%{remoteurlSalesOrderClosingSalesQuotationInput}"
                onSelectRowTopics="salesOrderClosingSalesQuotationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationCode" index="salesOrderClosingSalesQuotationCode" 
                    title="SLS-QUO No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationTransactionDate" index="salesOrderClosingSalesQuotationTransactionDate" key="salesOrderClosingSalesQuotationTransactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationCustomerCode" index="salesOrderClosingSalesQuotationCustomerCode" 
                    title="Customer Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationCustomerName" index="salesOrderClosingSalesQuotationCustomerName" 
                    title="Customer Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationEndUserCode" index="salesOrderClosingSalesQuotationEndUserCode" 
                    title="End User Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationEndUserName" index="salesOrderClosingSalesQuotationEndUserName" 
                    title="End User Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "salesOrderClosingSalesQuotationRfqCode" index = "salesOrderClosingSalesQuotationRfqCode" key = "salesOrderClosingSalesQuotationRfqCode" 
                    title = "RFQ No" width = "80" edittype="text" 
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationProjectCode" index="salesOrderClosingSalesQuotationProjectCode" 
                    title="Project" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationSubject" index="salesOrderClosingSalesQuotationSubject" 
                    title="Subject" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationAttn" index="salesOrderClosingSalesQuotationAttn" 
                    title="Attn" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationRefNo" index="salesOrderClosingSalesQuotationRefNo" key="salesOrderClosingSalesQuotationRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="salesOrderClosingSalesQuotationRemark" index="salesOrderClosingSalesQuotationRemark" key="salesOrderClosingSalesQuotationRemark" 
                    title="Remark" width="150" sortable="true"
                />
            </sjg:grid >
        </div>                
        <table>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmSalesOrderClosingSalesQuotation" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmSalesOrderClosingSalesQuotation" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <div id="id-tbl-additional-payment-item-delivery-so-closing">
            <div>
                <sjg:grid
                    id="salesOrderClosingItemDetailInput_grid"
                    caption="Item"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listCustomerSalesOrderItemDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnucustomerpurchaseOrder').width()"
                    editurl="%{remoteurlSalesOrderClosingSalesQuotationInput}"
                    onSelectRowTopics="salesOrderClosingItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetail" index="salesOrderClosingItemDetail" key="salesOrderClosingItemDetail" 
                        title="" width="50" sortable="true" editable="true" hidden="true"
                    />         
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailQuotationNoDetailCode" index="salesOrderClosingItemDetailQuotationNoDetailCode" key="salesOrderClosingItemDetailQuotationNoDetailCode" 
                        title="Quotation No" width="150" sortable="true" hidden="false"
                    />                   
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailQuotationNo" index="salesOrderClosingItemDetailQuotationNo" key="salesOrderClosingItemDetailQuotationNo" 
                        title="Quotation No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailSortNo" index="salesOrderClosingItemDetailSortNo" 
                        title="Sort No" width="80" sortable="true" editable="false" edittype="text"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsCode" index="salesOrderClosingItemDetailItemFinishGoodsCode" key="salesOrderClosingItemDetailItemFinishGoodsCode" 
                        title="Item Finish Goods Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsRemark" index="salesOrderClosingItemDetailItemFinishGoodsRemark" key="salesOrderClosingItemDetailItemFinishGoodsRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailValveTypeCode" index="salesOrderClosingItemDetailValveTypeCode" key="salesOrderClosingItemDetailValveTypeCode" 
                        title="Valve Type Code (QUO)" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailValveTypeName" index="salesOrderClosingItemDetailValveTypeName" key="salesOrderClosingItemDetailValveTypeName" 
                        title="Valve Type Name (QUO)" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemAlias" index="salesOrderClosingItemDetailItemAlias" 
                        title="Item Alias" width="100" sortable="true" edittype="text"
                    /> 
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailValveTag" index="salesOrderClosingItemDetailValveTag" 
                        title="Valve Tag" width="100" sortable="true" edittype="text"
                    />  
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailDataSheet" index="salesOrderClosingItemDetailDataSheet" 
                        title="Data Sheet" width="100" sortable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailDescription" index="salesOrderClosingItemDetailDescription" 
                        title="Description" width="100" sortable="true" edittype="text"
                    />
                    <!--Body Const 01-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailBodyConstQuotation" index="salesOrderClosingItemDetailBodyConstQuotation" 
                        title="QUO (01)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBodyConstCode" index="salesOrderClosingItemDetailItemFinishGoodsBodyConstCode" 
                        title="IFG (01)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBodyConstName" index="salesOrderClosingItemDetailItemFinishGoodsBodyConstName" 
                        title="IFG (01)" width="100" sortable="true"
                    />
                    <!--Type Design 02-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailTypeDesignQuotation" index="salesOrderClosingItemDetailTypeDesignQuotation" 
                        title="QUO (02)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsTypeDesignCode" index="salesOrderClosingItemDetailItemFinishGoodsTypeDesignCode" 
                        title="IFG (02)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsTypeDesignName" index="salesOrderClosingItemDetailItemFinishGoodsTypeDesignName" 
                        title="IFG (02)" width="100" sortable="true"
                    />
                    <!--Seat Design 03-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailSeatDesignQuotation" index="salesOrderClosingItemDetailSeatDesignQuotation" 
                        title="QUO (03)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSeatDesignCode" index="salesOrderClosingItemDetailItemFinishGoodsSeatDesignCode" 
                        title="IFG (03)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSeatDesignName" index="salesOrderClosingItemDetailItemFinishGoodsSeatDesignName" 
                        title="IFG (03)" width="100" sortable="true"
                    />
                    <!--Size 04-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailSizeQuotation" index="salesOrderClosingItemDetailSizeQuotation" 
                        title="QUO (04)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSizeCode" index="salesOrderClosingItemDetailItemFinishGoodsSizeCode" 
                        title="IFG (04)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSizeName" index="salesOrderClosingItemDetailItemFinishGoodsSizeName" 
                        title="IFG (04)" width="100" sortable="true"
                    />
                    <!--Rating 05-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailRatingQuotation" index="salesOrderClosingItemDetailRatingQuotation" 
                        title="QUO (05)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsRatingCode" index="salesOrderClosingItemDetailItemFinishGoodsRatingCode" 
                        title="IFG (05)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsRatingName" index="salesOrderClosingItemDetailItemFinishGoodsRatingName" 
                        title="IFG (05)" width="100" sortable="true"
                    />
                    <!--Bore 06-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailBoreQuotation" index="salesOrderClosingItemDetailBoreQuotation" 
                        title="QUO (06)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBoreCode" index="salesOrderClosingItemDetailItemFinishGoodsBoreCode" 
                        title="IFG (06)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBoreName" index="salesOrderClosingItemDetailItemFinishGoodsBoreName" 
                        title="IFG (06)" width="100" sortable="true"
                    />
                    <!--EndCon 07-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailEndConQuotation" index="salesOrderClosingItemDetailEndConQuotation" 
                        title="QUO (07)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsEndConCode" index="salesOrderClosingItemDetailItemFinishGoodsEndConCode" 
                        title="IFG (07)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsEndConName" index="salesOrderClosingItemDetailItemFinishGoodsEndConName" 
                        title="IFG (07)" width="100" sortable="true"
                    />
                    <!--Body 08-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailBodyQuotation" index="salesOrderClosingItemDetailBodyQuotation" 
                        title="QUO (08)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBodyCode" index="salesOrderClosingItemDetailItemFinishGoodsBodyCode" 
                        title="IFG (08)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBodyName" index="salesOrderClosingItemDetailItemFinishGoodsBodyName" 
                        title="IFG (08)" width="100" sortable="true"
                    />
                    <!--Ball 09-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailBallQuotation" index="salesOrderClosingItemDetailBallQuotation" 
                        title="QUO (09)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBallCode" index="salesOrderClosingItemDetailItemFinishGoodsBallCode" 
                        title="IFG (09)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBallName" index="salesOrderClosingItemDetailItemFinishGoodsBallName" 
                        title="IFG (09)" width="100" sortable="true"
                    />
                    <!--Seat 10-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailSeatQuotation" index="salesOrderClosingItemDetailSeatQuotation" 
                        title="QUO (10)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSeatCode" index="salesOrderClosingItemDetailItemFinishGoodsSeatCode" 
                        title="IFG (10)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSeatName" index="salesOrderClosingItemDetailItemFinishGoodsSeatName" 
                        title="IFG (10)" width="100" sortable="true"
                    />
                    <!--SeatInsert 11-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailSeatInsertQuotation" index="salesOrderClosingItemDetailSeatInsertQuotation" 
                        title="QUO (11)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSeatInsertCode" index="salesOrderClosingItemDetailItemFinishGoodsSeatInsertCode" 
                        title="IFG (11)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSeatInsertName" index="salesOrderClosingItemDetailItemFinishGoodsSeatInsertName" 
                        title="IFG (11)" width="100" sortable="true"
                    />
                    <!--Stem 12-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailStemQuotation" index="salesOrderClosingItemDetailStemQuotation" 
                        title="QUO (12)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsStemCode" index="salesOrderClosingItemDetailItemFinishGoodsStemCode" 
                        title="IFG (12)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsStemName" index="salesOrderClosingItemDetailItemFinishGoodsStemName" 
                        title="IFG (12)" width="100" sortable="true"
                    />
                    <!--Seal 13-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailSealQuotation" index="salesOrderClosingItemDetailSealQuotation" 
                        title="QUO (13)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSealCode" index="salesOrderClosingItemDetailItemFinishGoodsSealCode" 
                        title="IFG (13)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSealName" index="salesOrderClosingItemDetailItemFinishGoodsSealName" 
                        title="IFG (13)" width="100" sortable="true"
                    />
                    <!--Bolt 14-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailBoltQuotation" index="salesOrderClosingItemDetailBoltQuotation" 
                        title="QUO (14)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBoltCode" index="salesOrderClosingItemDetailItemFinishGoodsBoltCode" 
                        title="IFG (14)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBoltName" index="salesOrderClosingItemDetailItemFinishGoodsBoltName" 
                        title="IFG (14)" width="100" sortable="true"
                    />
                    <!--Disc 15-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailDiscQuotation" index="salesOrderClosingItemDetailDiscQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsDiscCode" index="salesOrderClosingItemDetailItemFinishGoodsDiscCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsDiscName" index="salesOrderClosingItemDetailItemFinishGoodsDiscName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Plates 16-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailPlatesQuotation" index="salesOrderClosingItemDetailPlatesQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsPlatesCode" index="salesOrderClosingItemDetailItemFinishGoodsPlatesCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsPlatesName" index="salesOrderClosingItemDetailItemFinishGoodsPlatesName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Shaft 17-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailShaftQuotation" index="salesOrderClosingItemDetailShaftQuotation" 
                        title="QUO (17)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsShaftCode" index="salesOrderClosingItemDetailItemFinishGoodsShaftCode" 
                        title="IFG (17)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsShaftName" index="salesOrderClosingItemDetailItemFinishGoodsShaftName" 
                        title="IFG (17)" width="100" sortable="true"
                    />
                    <!--Spring 18-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailSpringQuotation" index="salesOrderClosingItemDetailSpringQuotation" 
                        title="QUO (18)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSpringCode" index="salesOrderClosingItemDetailItemFinishGoodsSpringCode" 
                        title="IFG (18)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsSpringName" index="salesOrderClosingItemDetailItemFinishGoodsSpringName" 
                        title="IFG (18)" width="100" sortable="true"
                    />
                    <!--ArmPin 19-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailArmPinQuotation" index="salesOrderClosingItemDetailArmPinQuotation" 
                        title="QUO (19)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsArmPinCode" index="salesOrderClosingItemDetailItemFinishGoodsArmPinCode" 
                        title="IFG (19)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsArmPinName" index="salesOrderClosingItemDetailItemFinishGoodsArmPinName" 
                        title="IFG (19)" width="100" sortable="true"
                    />
                    <!--BackSeat 20-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailBackSeatQuotation" index="salesOrderClosingItemDetailBackSeatQuotation" 
                        title="QUO (20)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBackSeatCode" index="salesOrderClosingItemDetailItemFinishGoodsBackSeatCode" 
                        title="IFG (20)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsBackSeatName" index="salesOrderClosingItemDetailItemFinishGoodsBackSeatName" 
                        title="IFG (20)" width="100" sortable="true"
                    />
                    <!--Arm 21-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailArmQuotation" index="salesOrderClosingItemDetailArmQuotation" 
                        title="QUO (21)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsArmCode" index="salesOrderClosingItemDetailItemFinishGoodsArmCode" 
                        title="IFG (21)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsArmName" index="salesOrderClosingItemDetailItemFinishGoodsArmName" 
                        title="IFG (21)" width="100" sortable="true"
                    />
                    <!--HingePin 22-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailHingePinQuotation" index="salesOrderClosingItemDetailHingePinQuotation" 
                        title="QUO (22)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsHingePinCode" index="salesOrderClosingItemDetailItemFinishGoodsHingePinCode" 
                        title="IFG (22)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsHingePinName" index="salesOrderClosingItemDetailItemFinishGoodsHingePinName" 
                        title="IFG (22)" width="100" sortable="true"
                    />
                    <!--StopPin 23-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailStopPinQuotation" index="salesOrderClosingItemDetailStopPinQuotation" 
                        title="QUO (23)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsStopPinCode" index="salesOrderClosingItemDetailItemFinishGoodsStopPinCode" 
                        title="IFG (23)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsStopPinName" index="salesOrderClosingItemDetailItemFinishGoodsStopPinName" 
                        title="IFG (23)" width="100" sortable="true"
                    />
                    <!--Operator 99-->
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailOperatorQuotation" index="salesOrderClosingItemDetailOperatorQuotation" 
                        title="QUO (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsOperatorCode" index="salesOrderClosingItemDetailItemFinishGoodsOperatorCode" 
                        title="IFG (99)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailItemFinishGoodsOperatorName" index="salesOrderClosingItemDetailItemFinishGoodsOperatorName" 
                        title="IFG (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailNote" index="salesOrderClosingItemDetailNote" title="Note" width="100" sortable="true" editable="false"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailQuantity" index="salesOrderClosingItemDetailQuantity" key="salesOrderClosingItemDetailQuantity" title="Qty" 
                        width="150" align="right" editable="false" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                        formatter="number" editrules="{ double: true }"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailPrice" index="salesOrderClosingItemDetailPrice" key="salesOrderClosingItemDetailPrice" title="Unit Price" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="salesOrderClosingItemDetailTotal" index="salesOrderClosingItemDetailTotal" key="salesOrderClosingItemDetailTotal" title="Total" 
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
                                id="salesOrderClosingAdditionalFeeInput_grid"
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
                                width="$('#tabmnuSalesOrderClosingAdditionalFee').width()"
                                editurl="%{remoteurlSalesOrderClosingAdditionalFeeInput}"
                                onSelectRowTopics="salesOrderClosingAdditionalFeeInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFee" index="salesOrderClosingAdditionalFee" key="salesOrderClosingAdditionalFee" 
                                    title="" width="50" sortable="true" editable="true" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeRemark" index="salesOrderClosingAdditionalFeeRemark" key="salesOrderClosingAdditionalFeeRemark" 
                                    title="Remark" width="150" sortable="true" editable="false"
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeQuantity" index="salesOrderClosingAdditionalFeeQuantity" key="salesOrderClosingAdditionalFeeQuantity" title="Quantity" 
                                    width="80" align="right" editable="false" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateSalesOrderClosingAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeUnitOfMeasureCode" index="salesOrderClosingAdditionalFeeUnitOfMeasureCode" 
                                    title="Unit" width="100" sortable="true" editable="false" edittype="text" 
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeAdditionalFeeCode" index="salesOrderClosingAdditionalFeeAdditionalFeeCode" 
                                    title="Additional Fee Code" width="100" sortable="true" editable="false" edittype="text"
                                /> 
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeAdditionalFeeName" index="salesOrderClosingAdditionalFeeAdditionalFeeName" 
                                    title="Additional Fee Name" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeChartOfAccountCode" index="salesOrderClosingAdditionalFeeChartOfAccountCode" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" 
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeChartOfAccountName" index="salesOrderClosingAdditionalFeeChartOfAccountName" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeePrice" index="salesOrderClosingAdditionalFeePrice" key="salesOrderClosingAdditionalFeePrice" title="Price" 
                                    width="150" align="right" editable="false" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateSalesOrderClosingAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="salesOrderClosingAdditionalFeeTotal" index="salesOrderClosingAdditionalFeeTotal" key="salesOrderClosingAdditionalFeeTotal" title="Total" 
                                    width="150" align="right" edittype="text"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                            </sjg:grid >
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
                                            id="salesOrderClosingPaymentTermInput_grid"
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
                                            editurl="%{remoteurlSalesOrderClosingPaymentTermInput}"
                                            onSelectRowTopics="salesOrderClosingPaymentTermInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="salesOrderClosingPaymentTerm" index="salesOrderClosingPaymentTerm" 
                                                title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                            />  
                                            <sjg:gridColumn
                                                name="salesOrderClosingPaymentTermSortNO" index="salesOrderClosingPaymentTermSortNO" key="salesOrderClosingPaymentTermSortNO" title="Term No" 
                                                width="80" align="right" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingPaymentTermPaymentTermCode" index="salesOrderClosingPaymentTermPaymentTermCode" 
                                                title="Payment Term Code" width="100" sortable="true" editable="false" edittype="text"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingPaymentTermSearchPaymentTerm" index="salesOrderClosingPaymentTermSearchPaymentTerm" title="" width="25" align="centre"
                                                editable="false" dataType="html" edittype="button"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingPaymentTermPaymentTermName" index="salesOrderClosingPaymentTermPaymentTermName" 
                                                title="Payment Term" width="100" sortable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingPaymentTermPercent" index="salesOrderClosingPaymentTermPercent" key="salesOrderClosingPaymentTermPercent" title="Percent" 
                                                width="80" align="right" editable="false" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingPaymentTermRemark" index="salesOrderClosingPaymentTermRemark" 
                                                title="Note" width="200" sortable="false" edittype="text" editable="false"
                                            />
                                        </sjg:grid >
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table valign="top">
                                <tr>
                                    <td width="120px" align="right"><B>Total Transaction</B></td>
                                    <td width="120px">
                                        <s:textfield id="salesOrderClosing.totalTransactionAmount" name="salesOrderClosing.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Disc
                                        <s:textfield id="salesOrderClosing.discountPercent" name="salesOrderClosing.discountPercent" readonly="true" onkeyup="calculateSalesOrderClosingHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                    <s:textfield id="salesOrderClosing.discountAmount" name="salesOrderClosing.discountAmount" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Additional</td>
                                    <td>
                                    <s:textfield id="salesOrderClosing.totalAdditionalFeeAmount" name="salesOrderClosing.totalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" disabled="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><b>Sub Total(Tax Base)</b></td>
                                    <td>
                                        <s:textfield id="salesOrderClosing.taxBaseAmount" name="salesOrderClosing.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">VAT
                                        <s:textfield id="salesOrderClosing.vatPercent" name="salesOrderClosing.vatPercent" readonly="true" onkeyup="calculateSalesOrderClosingHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                        <s:textfield id="salesOrderClosing.vatAmount" name="salesOrderClosing.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Grand Total</B></td>
                                    <td>
                                        <s:textfield id="salesOrderClosing.grandTotalAmount" name="salesOrderClosing.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
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
                        <sj:a href="#" id="btnConfirmSalesOrderClosingItemDetailDelivery" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmSalesOrderClosingItemDetailDelivery" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>                
            <div id="id-tbl-additional-item-delivery-detail-so-closing">
                <table>
                    <tr>
                        <td align="right">
                            <sj:datepicker id="salesOrderClosingDeliveryDateSet" name="salesOrderClosingDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today" cssStyle="display:none"></sj:datepicker>
                            <%--<sj:a href="#" id="btnSalesOrderClosingDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;--%>
                            <%--<sj:a href="#" id="btnSalesOrderClosingCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>--%>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="salesOrderClosingItemDeliveryInput_grid"
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
                                            editurl="%{remoteurlSalesOrderClosingItemDeliveryInput}"
                                            onSelectRowTopics="salesOrderClosingItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="salesOrderClosingItemDelivery" index="salesOrderClosingItemDelivery" key="salesOrderClosingItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name = "salesOrderClosingItemDeliveryItemFinishGoodsCode" index = "salesOrderClosingItemDeliveryItemFinishGoodsCode" key = "salesOrderClosingItemDeliveryItemFinishGoodsCode" 
                                                title = "Item Finish Goods Code" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "salesOrderClosingItemDeliveryItemFinishGoodsRemark" index = "salesOrderClosingItemDeliveryItemFinishGoodsRemark" key = "salesOrderClosingItemDeliveryItemFinishGoodsRemark" 
                                                title = "IFG Remark" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingItemDeliverySortNo" index="salesOrderClosingItemDeliverySortNo" title="Sort No" width="80" sortable="true"
                                            />  
                                            <sjg:gridColumn
                                                name="salesOrderClosingItemDeliveryQuantity" index="salesOrderClosingItemDeliveryQuantity" key="salesOrderClosingItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="false" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingItemDeliveryDeliveryDate" index="salesOrderClosingItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="false" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangeSalesOrderClosingItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="salesOrderClosingItemDeliveryDeliveryDateTemp" index="salesOrderClosingItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                            <sjg:gridColumn
                                                name = "salesOrderClosingItemDeliverySalesQuotationCode" index = "salesOrderClosingItemDeliverySalesQuotationCode" key = "salesOrderClosingItemDeliverySalesQuotationCode" 
                                                title = "Quotation No" width = "100"
                                            />
                                            <sjg:gridColumn
                                                name = "salesOrderClosingItemDeliverySalesQuotationRefNo" index = "salesOrderClosingItemDeliverySalesQuotationRefNo" key = "salesOrderClosingItemDeliverySalesQuotationRefNo" 
                                                title = "Ref No" width = "100" 
                                            />
                                        </sjg:grid >
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
                    <sj:a href="#" id="btnSalesOrderClosingSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnSalesOrderClosingCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    