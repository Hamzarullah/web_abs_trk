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
    .ui-dialog-titlebar-close,#blanketOrderClosingSalesQuotationInput_grid_pager_center,
    #blanketOrderClosingItemDetailInput_grid_pager_center,#blanketOrderClosingAdditionalFeeInput_grid_pager_center,
    #blanketOrderClosingPaymentTermInput_grid_pager_center,#blanketOrderClosingItemDeliveryInput_grid_pager_center{
        display: none;
    }
    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var blanketOrderClosingSalesQuotationLastRowId=0,blanketOrderClosingSalesQuotation_lastSel = -1;
    var blanketOrderClosingItemDetailLastRowId=0,blanketOrderClosingItemDetail_lastSel = -1;
    var blanketOrderClosingAdditionalFeeLastRowId=0,blanketOrderClosingAdditionalFee_lastSel = -1;
    var blanketOrderClosingPaymentTermLastRowId=0,blanketOrderClosingPaymentTerm_lastSel = -1;
    var blanketOrderClosingItemDeliveryLastRowId=0,blanketOrderClosingItemDelivery_lastSel = -1;
    var cpoSalesQuotation_lastSel = -1;
    var 
        txtBlanketOrderClosingCode = $("#blanketOrderClosing\\.code"),
        dtpBlanketOrderClosingTransactionDate = $("#blanketOrderClosing\\.transactionDate"),
        txtBlanketOrderClosingRetention= $("#blanketOrderClosing\\.customerPurchaseOrder\\.retentionPercent"),
        txtBlanketOrderClosingRefNo = $("#blanketOrderClosing\\.refNo"),
        txtBlanketOrderClosingRemark = $("#blanketOrderClosing\\.remark"),
        txtBlanketOrderClosingTotalTransactionAmount = $("#blanketOrderClosing\\.totalTransactionAmount"),
        txtBlanketOrderClosingDiscountPercent = $("#blanketOrderClosing\\.discountPercent"),
        txtBlanketOrderClosingDiscountAmount = $("#blanketOrderClosing\\.discountAmount"),
        txtBlanketOrderClosingTotalAdditionalFee= $("#blanketOrderClosing\\.totalAdditionalFeeAmount"),
        txtBlanketOrderClosingTaxBaseAmount= $("#blanketOrderClosing\\.taxBaseAmount"),
        txtBlanketOrderClosingVATPercent = $("#blanketOrderClosing\\.vatPercent"),
        txtBlanketOrderClosingVATAmount = $("#blanketOrderClosing\\.vatAmount"),
        txtBlanketOrderClosingGrandTotalAmount = $("#blanketOrderClosing\\.grandTotalAmount");

        function loadGridItemBOClosing(){
             //function groupingHeader
                $("#blanketOrderClosingItemDetailInput_grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true, 
                    groupHeaders:[
                          {startColumnName: 'blanketOrderClosingItemDetailBodyConstQuotation', numberOfColumns: 3, titleText: 'Body Const'},
                          {startColumnName: 'blanketOrderClosingItemDetailTypeDesignQuotation', numberOfColumns: 3, titleText: 'Type Design'},
                          {startColumnName: 'blanketOrderClosingItemDetailSeatDesignQuotation', numberOfColumns: 3, titleText: 'Seat Design'},
                          {startColumnName: 'blanketOrderClosingItemDetailSizeQuotation', numberOfColumns: 3, titleText: 'Size'},
                          {startColumnName: 'blanketOrderClosingItemDetailRatingQuotation', numberOfColumns: 3, titleText: 'Rating'},
                          {startColumnName: 'blanketOrderClosingItemDetailBoreQuotation', numberOfColumns: 3, titleText: 'Bore'},
                          
                          {startColumnName: 'blanketOrderClosingItemDetailEndConQuotation', numberOfColumns: 3, titleText: 'End Con'},
                          {startColumnName: 'blanketOrderClosingItemDetailBodyQuotation', numberOfColumns: 3, titleText: 'Body'},
                          {startColumnName: 'blanketOrderClosingItemDetailBallQuotation', numberOfColumns: 3, titleText: 'Ball'},
                          {startColumnName: 'blanketOrderClosingItemDetailSeatQuotation', numberOfColumns: 3, titleText: 'Seat'},
                          {startColumnName: 'blanketOrderClosingItemDetailSeatInsertQuotation', numberOfColumns: 3, titleText: 'Seat Insert'},
                          {startColumnName: 'blanketOrderClosingItemDetailStemQuotation', numberOfColumns: 3, titleText: 'Stem'},
                          
                          {startColumnName: 'blanketOrderClosingItemDetailSealQuotation', numberOfColumns: 3, titleText: 'Seal'},
                          {startColumnName: 'blanketOrderClosingItemDetailBoltQuotation', numberOfColumns: 3, titleText: 'Bolt'},
                          {startColumnName: 'blanketOrderClosingItemDetailDiscQuotation', numberOfColumns: 3, titleText: 'Disc'},
                          {startColumnName: 'blanketOrderClosingItemDetailPlatesQuotation', numberOfColumns: 3, titleText: 'Plates'},
                          {startColumnName: 'blanketOrderClosingItemDetailShaftQuotation', numberOfColumns: 3, titleText: 'Shaft'},
                          {startColumnName: 'blanketOrderClosingItemDetailSpringQuotation', numberOfColumns: 3, titleText: 'Spring'},
                          
                          {startColumnName: 'blanketOrderClosingItemDetailArmPinQuotation', numberOfColumns: 3, titleText: 'Arm Pin'},
                          {startColumnName: 'blanketOrderClosingItemDetailBackSeatQuotation', numberOfColumns: 3, titleText: 'Back Seat'},
                          {startColumnName: 'blanketOrderClosingItemDetailArmQuotation', numberOfColumns: 3, titleText: 'Arm'},
                          {startColumnName: 'blanketOrderClosingItemDetailHingePinQuotation', numberOfColumns: 3, titleText: 'Hinge Pin'},
                          {startColumnName: 'blanketOrderClosingItemDetailStopPinQuotation', numberOfColumns: 3, titleText: 'Stop Pin'},
                          {startColumnName: 'blanketOrderClosingItemDetailOperatorQuotation', numberOfColumns: 3, titleText: 'Operator'}
                    ]
                });
        }

    $(document).ready(function() {
        flagIsConfirmedBOClosing=false;
        flagIsConfirmedBOClosingSalesQuotation=false;
        flagIsConfirmedBOClosingItemDelivery=false;
        $("#frmBlanketOrderClosingInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        
       
        
        formatNumericBOClosing();
//        $("#msgBlanketOrderClosingActivity").html(" - <i>" + $("#enumBlanketOrderClosingActivity").val()+"<i>").show();
        setBlanketOrderClosingPartialShipmentStatusStatus();
        
        $('input[name="blanketOrderClosingPartialShipmentStatusRad"][value="YES"]').change(function(ev){
            $("#blanketOrderClosing\\.customerPurchaseOrder\\.partialShipmentStatus").val("YES");
        });
        
        $('input[name="blanketOrderClosingPartialShipmentStatusRad"][value="NO"]').change(function(ev){
            $("#blanketOrderClosing\\.customerPurchaseOrder\\.partialShipmentStatus").val("NO");
        });
        
        $('input[name="blanketOrderClosingOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#blanketOrderClosing\\.orderStatus").val(value);
        });
                
        $('input[name="blanketOrderClosingOrderStatusRad"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#blanketOrderClosing\\.orderStatus").val(value);
        });
        
        $('#blanketOrderClosingOrderStatusRadBLANKET_ORDER').prop('checked',true);
        $("#blanketOrderClosing\\.orderStatus").val("BLANKET_ORDER");
        
        //Set Default View
        $("#btnUnConfirmBlanketOrderClosing").css("display", "none");
        $("#btnUnConfirmBlanketOrderClosingSalesQuotation").css("display", "none");
        $("#btnUnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "none");
        $("#btnConfirmBlanketOrderClosingSalesQuotationDetailSort").css("display", "none");
        $("#btnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "none");
        $("#btnConfirmBlanketOrderClosingSalesQuotation").css("display", "none"); 
        $('#blanketOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-payment-item-delivery-bo-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-tbl-additional-item-delivery-detail-bo-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmBlanketOrderClosing").click(function(ev) {
            
            if(parseFloat(txtBlanketOrderClosingRetention.val())===0.00){
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
                                        flagIsConfirmedBOClosing=true;
                                        flagIsConfirmedBOClosingSalesQuotation=false;
                                        $("#btnUnConfirmBlanketOrderClosing").css("display", "block");
                                        $("#btnConfirmBlanketOrderClosing").css("display", "none");   
                                        $('#headerBlanketOrderClosingInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                        $('#blanketOrderClosingSalesQuotationInputGrid').unblock();
                                        $("#btnConfirmBlanketOrderClosingSalesQuotation").show();   
                                        loadBlanketOrderClosingSalesQuotation();
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
                flagIsConfirmedBOClosing=true;
                flagIsConfirmedBOClosingSalesQuotation=false;
                $("#btnUnConfirmBlanketOrderClosing").css("display", "block");
                $("#btnConfirmBlanketOrderClosing").css("display", "none");   
                $('#headerBlanketOrderClosingInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#blanketOrderClosingSalesQuotationInputGrid').unblock();
                $("#btnConfirmBlanketOrderClosingSalesQuotation").show();   
                loadBlanketOrderClosingSalesQuotation();
            }           
        });
                
        $("#btnUnConfirmBlanketOrderClosing").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){ 
                    $("#btnUnConfirmBlanketOrderClosing").css("display", "none");
                    $("#btnConfirmBlanketOrderClosing").css("display", "block");
                    $("#btnConfirmBlanketOrderClosingSalesQuotation").css("display", "none");
                    $('#headerBlanketOrderClosingInput').unblock();
                    $('#blanketOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    flagIsConfirmedBOClosing=false;
                    flagIsConfirmedBOClosingSalesQuotation=false;
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
                                flagIsConfirmedBOClosing=false;
                                $("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmBlanketOrderClosing").css("display", "none");
                                $("#btnConfirmBlanketOrderClosing").css("display", "block");
                                $("#btnConfirmBlanketOrderClosingSalesQuotation").css("display", "none");
                                $('#headerBlanketOrderClosingInput').unblock();
                                $('#blanketOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                clearBlanketOrderClosingTransactionAmount();
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
        
        $("#btnConfirmBlanketOrderClosingSalesQuotation").click(function(ev) {
            if(flagIsConfirmedBOClosing){
                
                if(blanketOrderClosingSalesQuotation_lastSel !== -1) {
                    $('#blanketOrderClosingSalesQuotationInput_grid').jqGrid("saveRow",blanketOrderClosingSalesQuotation_lastSel); 
                }

                var ids = jQuery("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('getRowData',ids[i]); 

                    if(data.blanketOrderClosingSalesQuotationCode===""){
                        alertMessage("Sales Quotation Can't Empty!");
                        return;
                    }
                }
            
                $("#btnUnConfirmBlanketOrderClosing").css("display", "none");
                $("#btnUnConfirmBlanketOrderClosingSalesQuotation").css("display", "block");
                $("#btnConfirmBlanketOrderClosingSalesQuotationDetailSort").css("display", "block");
                $("#btnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "block");
                $("#btnConfirmBlanketOrderClosingSalesQuotation").css("display", "none");   
                $('#blanketOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-bo-closing').unblock();
                flagIsConfirmedBOClosingSalesQuotation=true;
                loadBlanketOrderClosingItemDetailRevise();
                loadBlanketOrderClosingAdditionalFee();
                loadBlanketOrderClosingPaymentTerm();
            }
        });
        
        $("#btnUnConfirmBlanketOrderClosingSalesQuotation").click(function(ev) {
            $("#blanketOrderClosingItemDetailInput_grid").jqGrid('destroyGroupHeader');
            $("#blanketOrderClosingItemDetailInput_grid").jqGrid('clearGridData');
            $("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid('clearGridData');
            $("#blanketOrderClosingPaymentTermInput_grid").jqGrid('clearGridData');
            $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmBlanketOrderClosing").css("display", "block");
            $("#btnUnConfirmBlanketOrderClosingSalesQuotation").css("display", "none");
            $("#btnConfirmBlanketOrderClosingSalesQuotationDetailSort").css("display", "none");
            $("#btnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "none");
            $("#btnConfirmBlanketOrderClosingSalesQuotation").css("display", "block");
            $('#blanketOrderClosingSalesQuotationInputGrid').unblock();
            $('#id-tbl-additional-payment-item-delivery-bo-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedBOClosingSalesQuotation=false;
            clearBlanketOrderClosingTransactionAmount();
        });
        
        $("#btnConfirmBlanketOrderClosingItemDetailDelivery").click(function(ev) {
            if(flagIsConfirmedBOClosing){
                
                if(blanketOrderClosingItemDelivery_lastSel !== -1) {
                    $('#blanketOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderClosingItemDelivery_lastSel); 
                }
                
                var idq = jQuery("#blanketOrderClosingPaymentTermInput_grid").jqGrid('getDataIDs');
                if(idq.length===0){
                    alertMessage("Grid Payment Term Minimal 1(one) row!");
                    return;
                }
                
                var ids = jQuery("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('getDataIDs'); 
                if(ids.length===0){
                    alertMessage("Grid Sales Quotation Can't Empty!");
                    return;
                }
                
                $("#btnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "none");   
                $("#btnUnConfirmBlanketOrderClosingSalesQuotation").css("display", "none");   
                $("#btnUnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "block");   
                $('#blanketOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-payment-item-delivery-bo-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#id-tbl-additional-item-delivery-detail-bo-closing').unblock();
                loadBlanketOrderClosingItemDeliveryDate();
                flagIsConfirmedBOClosingItemDelivery=true;
                
            }
        });
        
        $("#btnUnConfirmBlanketOrderClosingItemDetailDelivery").click(function(ev) {
            $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('clearGridData');
            $("#btnUnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "none");
            $("#btnConfirmBlanketOrderClosingItemDetailDelivery").css("display", "block");
            $("#btnUnConfirmBlanketOrderClosingSalesQuotation").show();
            $('#blanketOrderClosingSalesQuotationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#id-tbl-additional-payment-item-delivery-bo-closing').unblock();
            $('#id-tbl-additional-item-delivery-detail-bo-closing').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmedBOClosingItemDelivery=false;
        });
        
        $.subscribe("blanketOrderClosingSalesQuotationInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderClosingSalesQuotationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderClosingSalesQuotation_lastSel) {

                $('#blanketOrderClosingSalesQuotationInput_grid').jqGrid("saveRow",blanketOrderClosingSalesQuotation_lastSel); 
                $('#blanketOrderClosingSalesQuotationInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderClosingSalesQuotation_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderClosingSalesQuotationInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderClosingItemDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderClosingItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderClosingItemDetail_lastSel) {

                $('#blanketOrderClosingItemDetailInput_grid').jqGrid("saveRow",blanketOrderClosingItemDetail_lastSel); 
                $('#blanketOrderClosingItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderClosingItemDetail_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderClosingItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderClosingAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderClosingAdditionalFee_lastSel) {

                $('#blanketOrderClosingAdditionalFeeInput_grid').jqGrid("saveRow",blanketOrderClosingAdditionalFee_lastSel); 
                $('#blanketOrderClosingAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderClosingAdditionalFee_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderClosingAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderClosingPaymentTermInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderClosingPaymentTermInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==blanketOrderClosingPaymentTerm_lastSel) {

                $('#blanketOrderClosingPaymentTermInput_grid').jqGrid("saveRow",blanketOrderClosingPaymentTerm_lastSel); 
                $('#blanketOrderClosingPaymentTermInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderClosingPaymentTerm_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderClosingPaymentTermInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("blanketOrderClosingItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==blanketOrderClosingItemDelivery_lastSel) {

                $('#blanketOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderClosingItemDelivery_lastSel); 
                $('#blanketOrderClosingItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            

                blanketOrderClosingItemDelivery_lastSel=selectedRowID;

            }
            else{
                $('#blanketOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnBlanketOrderClosingCopyFromDetail').click(function(ev) {
            
            $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(blanketOrderClosingItemDetail_lastSel !== -1) {
                $('#blanketOrderClosingItemDetailInput_grid').jqGrid("saveRow",blanketOrderClosingItemDetail_lastSel); 
            }
            
            var ids = jQuery("#blanketOrderClosingItemDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#blanketOrderClosingItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    blanketOrderClosingItemDeliveryDelete                 : "delete",
                    blanketOrderClosingItemDeliverySearchItem             : "...",
                    blanketOrderClosingItemDeliveryItemCode               : data.blanketOrderClosingItemDetailItem,
                    blanketOrderClosingItemDeliverySortNo                 : data.blanketOrderClosingItemDetailSortNo,
                    blanketOrderClosingItemDeliveryQuantity               : data.blanketOrderClosingItemDetailQuantity,
                    blanketOrderClosingItemDeliverySearchQuotation        : "...",
                    blanketOrderClosingItemDeliverySalesQuotationCode     : data.blanketOrderClosingItemDetailQuotationNo,
                    blanketOrderClosingItemDeliverySalesQuotationRefNo    : data.blanketOrderClosingItemDetailQuotationRefNo,
                    blanketOrderClosingItemDeliveryItemFinishGoodsCode    : data.blanketOrderClosingItemDetailItemFinishGoodsCode,   
                    blanketOrderClosingItemDeliveryItemFinishGoodsRemark  : data.blanketOrderClosingItemDetailItemFinishGoodsRemark
                };
                blanketOrderClosingItemDeliveryLastRowId++;
                $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid("addRowData", blanketOrderClosingItemDeliveryLastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('setRowData',blanketOrderClosingItemDeliveryLastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnBlanketOrderClosingSave').click(function(ev) {
            
            if(!flagIsConfirmedBOClosingSalesQuotation){
                return;
            }
            formatDateBOClosing();
            unFormatNumericBOClosing();
            
            var url = "sales/blanket-order-closing-save";
            var params = $("#frmBlanketOrderClosingInput").serialize();
           
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateBOClosing();
                    formatNumericBOClosing();
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
                                        var url = "sales/customer-blanket-order-closing-input";
                                        pageLoad(url, params, "#tabmnuBLANKET_ORDER_CLOSING");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/customer-blanket-order-closing";
                                        pageLoad(url, params, "#tabmnuBLANKET_ORDER_CLOSING");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnBlanketOrderClosingCancel').click(function(ev) {
            var url = "sales/customer-blanket-order-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuBLANKET_ORDER_CLOSING"); 
        });
        
        $('#btnBlanketOrderClosingDeliveryDateSet').click(function(ev) {
            if(blanketOrderClosingItemDelivery_lastSel !== -1) {
                $('#blanketOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderClosingItemDelivery_lastSel); 
            }
            
            var deliveryDate=$("#blanketOrderClosingDeliveryDateSet").val();
            var ids = jQuery("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid("setCell",ids[i], "blanketOrderClosingItemDeliveryDeliveryDate",deliveryDate);
                $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid("setCell",ids[i], "blanketOrderClosingItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
 });
 
    function formatDateBOClosing(){
        var transactionDateSplit=dtpBlanketOrderClosingTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpBlanketOrderClosingTransactionDate.val(transactionDate);
    }

    function unFormatNumericBOClosing(){
        var retention =removeCommas(txtBlanketOrderClosingRetention.val());
        txtBlanketOrderClosingRetention.val(retention);
        
        var totalTransactionAmount =removeCommas(txtBlanketOrderClosingTotalTransactionAmount.val());
        txtBlanketOrderClosingTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtBlanketOrderClosingDiscountAmount.val());
        txtBlanketOrderClosingDiscountAmount.val(discountAmount);
        var taxBaseAmount =removeCommas(txtBlanketOrderClosingTaxBaseAmount.val());
        txtBlanketOrderClosingTaxBaseAmount.val(taxBaseAmount);
        var vatPercent =removeCommas(txtBlanketOrderClosingVATPercent.val());
        txtBlanketOrderClosingVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtBlanketOrderClosingVATAmount.val());
        txtBlanketOrderClosingVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtBlanketOrderClosingGrandTotalAmount.val());
        txtBlanketOrderClosingGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericBOClosing(){
        
        var retention =parseFloat(txtBlanketOrderClosingRetention.val());
        txtBlanketOrderClosingRetention.val(formatNumber(retention,2));
        
        var totalTransactionAmount =parseFloat(txtBlanketOrderClosingTotalTransactionAmount.val());
        txtBlanketOrderClosingTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtBlanketOrderClosingDiscountPercent.val());
        txtBlanketOrderClosingDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtBlanketOrderClosingDiscountAmount.val());
        txtBlanketOrderClosingDiscountAmount.val(formatNumber(discountAmount,2));
        var taxBaseAmount =parseFloat(txtBlanketOrderClosingTaxBaseAmount.val());
        txtBlanketOrderClosingTaxBaseAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtBlanketOrderClosingVATPercent.val());
        txtBlanketOrderClosingVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtBlanketOrderClosingVATAmount.val());
        txtBlanketOrderClosingVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtBlanketOrderClosingGrandTotalAmount.val());
        txtBlanketOrderClosingGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }    
    
    function clearBlanketOrderClosingTransactionAmount(){
        txtBlanketOrderClosingTotalTransactionAmount.val("0.00");        
        txtBlanketOrderClosingDiscountPercent.val("0.00");
        txtBlanketOrderClosingDiscountAmount.val("0.00");
        txtBlanketOrderClosingTotalAdditionalFee.val("0.00");
        txtBlanketOrderClosingTaxBaseAmount.val("0.00");
        txtBlanketOrderClosingVATPercent.val("0.00");
        txtBlanketOrderClosingVATAmount.val("0.00");
        txtBlanketOrderClosingGrandTotalAmount.val("0.00");
    }
    
    function calculateBlanketOrderClosingAdditionalFee() {
        var selectedRowID = $("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var qty = $("#" + selectedRowID + "_blanketOrderClosingAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_blanketOrderClosingAdditionalFeePrice").val();
        
        var subTotal = (parseFloat(qty) * parseFloat(price));
        
        $("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "blanketOrderClosingAdditionalFeeTotal", subTotal);

        calculateBlanketOrderClosingTotalAdditional();
    }
    
    function calculateBlanketOrderClosingTotalAdditional() {
        var totalAmount =0;
        var ids = jQuery("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid('getRowData',ids[i]);
            totalAmount += parseFloat(data.blanketOrderClosingAdditionalFeeTotal);
        }   
        
        txtBlanketOrderClosingTotalAdditionalFee.val(formatNumber(totalAmount,2));
        calculateBlanketOrderClosingHeader();

    }
    
    function calculateBlanketOrderClosingHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var additionalFeeAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#blanketOrderClosingItemDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#blanketOrderClosingItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.blanketOrderClosingItemDetailTotal);
        }   
        txtBlanketOrderClosingTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtBlanketOrderClosingTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtBlanketOrderClosingDiscountPercent.val()));        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtBlanketOrderClosingDiscountAmount.val()===""){
            discAmount=0;
        }
        
        additionalFeeAmount=parseFloat(removeCommas(txtBlanketOrderClosingTotalAdditionalFee.val()));  
        
        subTotal = (totalTransaction-discAmount)+additionalFeeAmount;
        
        if(txtBlanketOrderClosingVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtBlanketOrderClosingVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtBlanketOrderClosingDiscountAmount.val(formatNumber(discAmount,2));
        txtBlanketOrderClosingTaxBaseAmount.val(formatNumber(subTotal,2));
        txtBlanketOrderClosingVATAmount.val(formatNumber(vatAmount,2));        
        txtBlanketOrderClosingGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onchangeBlanketOrderClosingItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_blanketOrderClosingItemDeliveryDeliveryDate").val();
        
        $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "blanketOrderClosingItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    
    function loadBlanketOrderClosingSalesQuotation() {
        var enumBlanketOrderClosingActivity=$("#enumBlanketOrderClosingActivity").val();
        if(enumBlanketOrderClosingActivity==="NEW"){
            return;
        }                
        
        var url = "sales/blanket-order-sales-quotation-data";
        var params = "blanketOrder.code="+$("#blanketOrderClosing\\.customerBlanketOrderCode").val();
        
        blanketOrderClosingSalesQuotationLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderSalesQuotation.length; i++) {
                blanketOrderClosingSalesQuotationLastRowId++;
                
                $("#blanketOrderClosingSalesQuotationInput_grid").jqGrid("addRowData", blanketOrderClosingSalesQuotationLastRowId, data.listCustomerBlanketOrderSalesQuotation[i]);
                $("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('setRowData',blanketOrderClosingSalesQuotationLastRowId,{
                    blanketOrderClosingSalesQuotationCode             : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationCode,
                    blanketOrderClosingSalesQuotationTransactionDate  : formatDateRemoveT(data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationTransactionDate,true),
                    blanketOrderClosingSalesQuotationCustomerCode     : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationCustomerCode,
                    blanketOrderClosingSalesQuotationCustomerName     : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationCustomerName,
                    blanketOrderClosingSalesQuotationEndUserCode      : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationEndUserCode,
                    blanketOrderClosingSalesQuotationEndUserName      : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationEndUserName,
                    blanketOrderClosingSalesQuotationRfqCode          : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationRfqCode,
                    blanketOrderClosingSalesQuotationProjectCode      : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationProject,
                    blanketOrderClosingSalesQuotationSubject          : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationSubject,
                    blanketOrderClosingSalesQuotationAttn             : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationAttn,
                    blanketOrderClosingSalesQuotationRefNo            : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationRefNo,
                    blanketOrderClosingSalesQuotationRemark           : data.listCustomerBlanketOrderSalesQuotation[i].salesQuotationRemark
                });
            }
        });
        closeLoading();
    }
    
    function loadBlanketOrderClosingItemDetailRevise() {
        loadGridItemBOClosing();
        var arrSalesQuotationNo=new Array();
        var totalTransaction=0;
        var ids = jQuery("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#blanketOrderClosingSalesQuotationInput_grid").jqGrid('getRowData',ids[x]);
            arrSalesQuotationNo.push(data.blanketOrderClosingSalesQuotationCode);
        }
        
        var url = "sales/blanket-order-item-detail-data-array-data";
        var params = "arrSalesQuotationBoNo="+arrSalesQuotationNo;   
            params += "&blanketOrder.code="+$("#blanketOrderClosing\\.customerBlanketOrderCode").val();
            
        blanketOrderClosingItemDetailLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            for (var i=0; i<data.listCustomerBlanketOrderItemDetail.length; i++) {
                blanketOrderClosingItemDetailLastRowId++;
                
                $("#blanketOrderClosingItemDetailInput_grid").jqGrid("addRowData", blanketOrderClosingItemDetailLastRowId, data.listCustomerBlanketOrderItemDetail[i]);
                $("#blanketOrderClosingItemDetailInput_grid").jqGrid('setRowData',blanketOrderClosingItemDetailLastRowId,{
                    blanketOrderClosingItemDetailQuotationNoDetailCode    : data.listCustomerBlanketOrderItemDetail[i].salesQuotationDetailCode,
                    blanketOrderClosingItemDetailQuotationNo              : data.listCustomerBlanketOrderItemDetail[i].salesQuotationCode,
                    blanketOrderClosingItemDetailQuotationRefNo           : data.listCustomerBlanketOrderItemDetail[i].refNo,
                    blanketOrderClosingItemDetailItemFinishGoodsCode      : data.listCustomerBlanketOrderItemDetail[i].itemFinishGoodsCode,
                    blanketOrderClosingItemDetailItemFinishGoodsRemark    : data.listCustomerBlanketOrderItemDetail[i].itemFinishGoodsRemark,
                    blanketOrderClosingItemDetailSortNo                   : data.listCustomerBlanketOrderItemDetail[i].customerPurchaseOrderSortNo,
                    blanketOrderClosingItemDetailValveTypeCode            : data.listCustomerBlanketOrderItemDetail[i].valveTypeCode,
                    blanketOrderClosingItemDetailValveTypeName            : data.listCustomerBlanketOrderItemDetail[i].valveTypeName,
                    blanketOrderClosingItemDetailItemAlias                : data.listCustomerBlanketOrderItemDetail[i].itemAlias,
                    blanketOrderClosingItemDetailValveTag                 : data.listCustomerBlanketOrderItemDetail[i].valveTag,
                    blanketOrderClosingItemDetailDataSheet                : data.listCustomerBlanketOrderItemDetail[i].dataSheet,
                    blanketOrderClosingItemDetailDescription              : data.listCustomerBlanketOrderItemDetail[i].description,
                                      
                    // 24 valve Type Component Quotation
                    blanketOrderClosingItemDetailBodyConstQuotation   : data.listCustomerBlanketOrderItemDetail[i].bodyConstruction,
                    blanketOrderClosingItemDetailTypeDesignQuotation  : data.listCustomerBlanketOrderItemDetail[i].typeDesign,
                    blanketOrderClosingItemDetailSeatDesignQuotation  : data.listCustomerBlanketOrderItemDetail[i].seatDesign,
                    blanketOrderClosingItemDetailSizeQuotation        : data.listCustomerBlanketOrderItemDetail[i].size,
                    blanketOrderClosingItemDetailRatingQuotation      : data.listCustomerBlanketOrderItemDetail[i].rating,
                    blanketOrderClosingItemDetailBoreQuotation        : data.listCustomerBlanketOrderItemDetail[i].bore,
                    
                    blanketOrderClosingItemDetailEndConQuotation      : data.listCustomerBlanketOrderItemDetail[i].endCon,
                    blanketOrderClosingItemDetailBodyQuotation        : data.listCustomerBlanketOrderItemDetail[i].body,
                    blanketOrderClosingItemDetailBallQuotation        : data.listCustomerBlanketOrderItemDetail[i].ball,
                    blanketOrderClosingItemDetailSeatQuotation        : data.listCustomerBlanketOrderItemDetail[i].seat,
                    blanketOrderClosingItemDetailSeatInsertQuotation  : data.listCustomerBlanketOrderItemDetail[i].seatInsert,
                    blanketOrderClosingItemDetailStemQuotation        : data.listCustomerBlanketOrderItemDetail[i].stem,
                    
                    blanketOrderClosingItemDetailSealQuotation        : data.listCustomerBlanketOrderItemDetail[i].seal,
                    blanketOrderClosingItemDetailBoltQuotation        : data.listCustomerBlanketOrderItemDetail[i].bolting,
                    blanketOrderClosingItemDetailDiscQuotation        : data.listCustomerBlanketOrderItemDetail[i].disc,
                    blanketOrderClosingItemDetailPlatesQuotation      : data.listCustomerBlanketOrderItemDetail[i].plates,
                    blanketOrderClosingItemDetailShaftQuotation       : data.listCustomerBlanketOrderItemDetail[i].shaft,
                    blanketOrderClosingItemDetailSpringQuotation      : data.listCustomerBlanketOrderItemDetail[i].spring,
                    
                    blanketOrderClosingItemDetailArmPinQuotation      : data.listCustomerBlanketOrderItemDetail[i].armPin,
                    blanketOrderClosingItemDetailBackSeatQuotation    : data.listCustomerBlanketOrderItemDetail[i].backSeat,
                    blanketOrderClosingItemDetailArmQuotation         : data.listCustomerBlanketOrderItemDetail[i].arm,
                    blanketOrderClosingItemDetailHingePinQuotation    : data.listCustomerBlanketOrderItemDetail[i].hingePin,
                    blanketOrderClosingItemDetailStopPinQuotation     : data.listCustomerBlanketOrderItemDetail[i].stopPin,
                    blanketOrderClosingItemDetailOperatorQuotation    : data.listCustomerBlanketOrderItemDetail[i].operator,
                    
                    // 24 valve Type Component Finish Goods
                    blanketOrderClosingItemDetailItemFinishGoodsBodyConstCode     : data.listCustomerBlanketOrderItemDetail[i].itemBodyConstructionCode,
                    blanketOrderClosingItemDetailItemFinishGoodsBodyConstName     : data.listCustomerBlanketOrderItemDetail[i].itemBodyConstructionName,
                    blanketOrderClosingItemDetailItemFinishGoodsTypeDesignCode    : data.listCustomerBlanketOrderItemDetail[i].itemTypeDesignCode,
                    blanketOrderClosingItemDetailItemFinishGoodsTypeDesignName    : data.listCustomerBlanketOrderItemDetail[i].itemTypeDesignName,
                    blanketOrderClosingItemDetailItemFinishGoodsSeatDesignCode    : data.listCustomerBlanketOrderItemDetail[i].itemSeatDesignCode,
                    blanketOrderClosingItemDetailItemFinishGoodsSeatDesignName    : data.listCustomerBlanketOrderItemDetail[i].itemSeatDesignName,
                    blanketOrderClosingItemDetailItemFinishGoodsSizeCode          : data.listCustomerBlanketOrderItemDetail[i].itemSizeCode,
                    blanketOrderClosingItemDetailItemFinishGoodsSizeName          : data.listCustomerBlanketOrderItemDetail[i].itemSizeName,
                    blanketOrderClosingItemDetailItemFinishGoodsRatingCode        : data.listCustomerBlanketOrderItemDetail[i].itemRatingCode,
                    blanketOrderClosingItemDetailItemFinishGoodsRatingName        : data.listCustomerBlanketOrderItemDetail[i].itemRatingName,
                    blanketOrderClosingItemDetailItemFinishGoodsBoreCode          : data.listCustomerBlanketOrderItemDetail[i].itemBoreCode,
                    blanketOrderClosingItemDetailItemFinishGoodsBoreName          : data.listCustomerBlanketOrderItemDetail[i].itemBoreName,
                    
                    blanketOrderClosingItemDetailItemFinishGoodsEndConCode        : data.listCustomerBlanketOrderItemDetail[i].itemEndConCode,
                    blanketOrderClosingItemDetailItemFinishGoodsEndConName        : data.listCustomerBlanketOrderItemDetail[i].itemEndConName,
                    blanketOrderClosingItemDetailItemFinishGoodsBodyCode          : data.listCustomerBlanketOrderItemDetail[i].itemBodyCode,
                    blanketOrderClosingItemDetailItemFinishGoodsBodyName          : data.listCustomerBlanketOrderItemDetail[i].itemBodyName,
                    blanketOrderClosingItemDetailItemFinishGoodsBallCode          : data.listCustomerBlanketOrderItemDetail[i].itemBallCode,
                    blanketOrderClosingItemDetailItemFinishGoodsBallName          : data.listCustomerBlanketOrderItemDetail[i].itemBallName,
                    blanketOrderClosingItemDetailItemFinishGoodsSeatCode          : data.listCustomerBlanketOrderItemDetail[i].itemSeatCode,
                    blanketOrderClosingItemDetailItemFinishGoodsSeatName          : data.listCustomerBlanketOrderItemDetail[i].itemSeatName,
                    blanketOrderClosingItemDetailItemFinishGoodsSeatInsertCode    : data.listCustomerBlanketOrderItemDetail[i].itemSeatInsertCode,
                    blanketOrderClosingItemDetailItemFinishGoodsSeatInsertName    : data.listCustomerBlanketOrderItemDetail[i].itemSeatInsertName,
                    blanketOrderClosingItemDetailItemFinishGoodsStemCode          : data.listCustomerBlanketOrderItemDetail[i].itemStemCode,
                    blanketOrderClosingItemDetailItemFinishGoodsStemName          : data.listCustomerBlanketOrderItemDetail[i].itemStemName,
                    
                    blanketOrderClosingItemDetailItemFinishGoodsSealCode          : data.listCustomerBlanketOrderItemDetail[i].itemSealCode,
                    blanketOrderClosingItemDetailItemFinishGoodsSealName          : data.listCustomerBlanketOrderItemDetail[i].itemSealName,
                    blanketOrderClosingItemDetailItemFinishGoodsBoltCode          : data.listCustomerBlanketOrderItemDetail[i].itemBoltCode,
                    blanketOrderClosingItemDetailItemFinishGoodsBoltName          : data.listCustomerBlanketOrderItemDetail[i].itemBoltName,
                    blanketOrderClosingItemDetailItemFinishGoodsDiscCode          : data.listCustomerBlanketOrderItemDetail[i].itemDiscCode,
                    blanketOrderClosingItemDetailItemFinishGoodsDiscName          : data.listCustomerBlanketOrderItemDetail[i].itemDiscName,
                    blanketOrderClosingItemDetailItemFinishGoodsPlatesCode        : data.listCustomerBlanketOrderItemDetail[i].itemPlatesCode,
                    blanketOrderClosingItemDetailItemFinishGoodsPlatesName        : data.listCustomerBlanketOrderItemDetail[i].itemPlatesName,
                    blanketOrderClosingItemDetailItemFinishGoodsShaftCode         : data.listCustomerBlanketOrderItemDetail[i].itemShaftCode,
                    blanketOrderClosingItemDetailItemFinishGoodsShaftName         : data.listCustomerBlanketOrderItemDetail[i].itemShaftName,
                    blanketOrderClosingItemDetailItemFinishGoodsSpringCode        : data.listCustomerBlanketOrderItemDetail[i].itemSpringCode,
                    blanketOrderClosingItemDetailItemFinishGoodsSpringName        : data.listCustomerBlanketOrderItemDetail[i].itemSpringName,
                    
                    blanketOrderClosingItemDetailItemFinishGoodsArmPinCode        : data.listCustomerBlanketOrderItemDetail[i].itemArmPinCode, 
                    blanketOrderClosingItemDetailItemFinishGoodsArmPinName        : data.listCustomerBlanketOrderItemDetail[i].itemArmPinName, 
                    blanketOrderClosingItemDetailItemFinishGoodsBackSeatCode      : data.listCustomerBlanketOrderItemDetail[i].itemBackSeatCode,
                    blanketOrderClosingItemDetailItemFinishGoodsBackSeatName      : data.listCustomerBlanketOrderItemDetail[i].itemBackSeatName,
                    blanketOrderClosingItemDetailItemFinishGoodsArmCode           : data.listCustomerBlanketOrderItemDetail[i].itemArmCode,
                    blanketOrderClosingItemDetailItemFinishGoodsArmName           : data.listCustomerBlanketOrderItemDetail[i].itemArmName,
                    blanketOrderClosingItemDetailItemFinishGoodsHingePinCode      : data.listCustomerBlanketOrderItemDetail[i].itemHingePinCode,
                    blanketOrderClosingItemDetailItemFinishGoodsHingePinName      : data.listCustomerBlanketOrderItemDetail[i].itemHingePinName,
                    blanketOrderClosingItemDetailItemFinishGoodsStopPinCode       : data.listCustomerBlanketOrderItemDetail[i].itemStopPinCode,
                    blanketOrderClosingItemDetailItemFinishGoodsStopPinName       : data.listCustomerBlanketOrderItemDetail[i].itemStopPinName,
                    blanketOrderClosingItemDetailItemFinishGoodsOperatorCode      : data.listCustomerBlanketOrderItemDetail[i].itemOperatorCode,
                    blanketOrderClosingItemDetailItemFinishGoodsOperatorName      : data.listCustomerBlanketOrderItemDetail[i].itemOperatorName,
                    
                    blanketOrderClosingItemDetailNote                 : data.listCustomerBlanketOrderItemDetail[i].note,
                    blanketOrderClosingItemDetailQuantity             : data.listCustomerBlanketOrderItemDetail[i].quantity,
                    blanketOrderClosingItemDetailPrice                : data.listCustomerBlanketOrderItemDetail[i].unitPrice,
                    blanketOrderClosingItemDetailTotal                : data.listCustomerBlanketOrderItemDetail[i].totalAmount
                });
                calculateBlanketOrderClosingHeader();
            }
        });
        closeLoading();
    }
    
    function loadBlanketOrderClosingAdditionalFee() {
        if($("#enumBlanketOrderClosingActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/blanket-order-additional-fee-data";
        var params = "blanketOrder.code="+$("#blanketOrderClosing\\.customerBlanketOrderCode").val();   
        
        blanketOrderClosingAdditionalFeeLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderAdditionalFee.length; i++) {
                blanketOrderClosingAdditionalFeeLastRowId++;
                
                $("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid("addRowData", blanketOrderClosingAdditionalFeeLastRowId, data.listCustomerBlanketOrderAdditionalFee[i]);
                $("#blanketOrderClosingAdditionalFeeInput_grid").jqGrid('setRowData',blanketOrderClosingAdditionalFeeLastRowId,{
                    blanketOrderClosingAdditionalFeeRemark             : data.listCustomerBlanketOrderAdditionalFee[i].remark,
                    blanketOrderClosingAdditionalFeeQuantity           : data.listCustomerBlanketOrderAdditionalFee[i].quantity,
                    blanketOrderClosingAdditionalFeeUnitOfMeasureCode  : data.listCustomerBlanketOrderAdditionalFee[i].unitOfMeasureCode,
                    blanketOrderClosingAdditionalFeeAdditionalFeeCode  : data.listCustomerBlanketOrderAdditionalFee[i].additionalFeeCode,
                    blanketOrderClosingAdditionalFeeAdditionalFeeName  : data.listCustomerBlanketOrderAdditionalFee[i].additionalFeeName,
                    blanketOrderClosingAdditionalFeeChartOfAccountCode : data.listCustomerBlanketOrderAdditionalFee[i].coaCode,
                    blanketOrderClosingAdditionalFeeChartOfAccountName : data.listCustomerBlanketOrderAdditionalFee[i].coaName,
                    blanketOrderClosingAdditionalFeePrice              : data.listCustomerBlanketOrderAdditionalFee[i].price,
                    blanketOrderClosingAdditionalFeeTotal              : data.listCustomerBlanketOrderAdditionalFee[i].total
                });
            }
            calculateBlanketOrderClosingTotalAdditional();
        });
        closeLoading();
    }
    
    function loadBlanketOrderClosingPaymentTerm() {
        if($("#enumBlanketOrderClosingActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/blanket-order-payment-term-data";
        var params = "blanketOrder.code="+$("#blanketOrderClosing\\.customerBlanketOrderCode").val();   
        
        blanketOrderClosingPaymentTermLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderPaymentTerm.length; i++) {
                blanketOrderClosingPaymentTermLastRowId++;
                
                $("#blanketOrderClosingPaymentTermInput_grid").jqGrid("addRowData", blanketOrderClosingPaymentTermLastRowId, data.listCustomerBlanketOrderPaymentTerm[i]);
                $("#blanketOrderClosingPaymentTermInput_grid").jqGrid('setRowData',blanketOrderClosingPaymentTermLastRowId,{
                    blanketOrderClosingPaymentTermSortNO             : data.listCustomerBlanketOrderPaymentTerm[i].sortNo,
                    blanketOrderClosingPaymentTermPaymentTermCode    : data.listCustomerBlanketOrderPaymentTerm[i].paymentTermCode,
                    blanketOrderClosingPaymentTermPaymentTermName    : data.listCustomerBlanketOrderPaymentTerm[i].paymentTermName,
                    blanketOrderClosingPaymentTermPercent            : data.listCustomerBlanketOrderPaymentTerm[i].percentage,
                    blanketOrderClosingPaymentTermRemark             : data.listCustomerBlanketOrderPaymentTerm[i].remark
                });
            }
        });
        closeLoading();
    }
    
    function loadBlanketOrderClosingItemDeliveryDate() {
        if($("#enumBlanketOrderClosingActivity").val()==="NEW"){
            return;
        }        
        var url = "sales/blanket-order-item-delivery-data";
        var params = "blanketOrder.code="+$("#blanketOrderClosing\\.customerBlanketOrderCode").val();   
        
        blanketOrderClosingItemDeliveryLastRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listCustomerBlanketOrderItemDeliveryDate.length; i++) {
                blanketOrderClosingItemDeliveryLastRowId++;
                
                $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid("addRowData", blanketOrderClosingItemDeliveryLastRowId, data.listCustomerBlanketOrderItemDeliveryDate[i]);
                $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('setRowData',blanketOrderClosingItemDeliveryLastRowId,{
                    blanketOrderClosingItemDeliverySalesQuotationCode       : data.listCustomerBlanketOrderItemDeliveryDate[i].salesQuotationCode,
                    blanketOrderClosingItemDeliverySalesQuotationRefNo      : data.listCustomerBlanketOrderItemDeliveryDate[i].refNo,
                    blanketOrderClosingItemDeliveryItemFinishGoodsCode      : data.listCustomerBlanketOrderItemDeliveryDate[i].itemFinishGoodsCode,
                    blanketOrderClosingItemDeliveryItemFinishGoodsRemark    : data.listCustomerBlanketOrderItemDeliveryDate[i].itemFinishGoodsRemark,
                    blanketOrderClosingItemDeliverySortNo                   : data.listCustomerBlanketOrderItemDeliveryDate[i].customerPurchaseOrderSortNo,
                    blanketOrderClosingItemDeliveryQuantity                 : data.listCustomerBlanketOrderItemDeliveryDate[i].quantity,
                    blanketOrderClosingItemDeliveryDeliveryDate             : formatDateRemoveT(data.listCustomerBlanketOrderItemDeliveryDate[i].deliveryDate,false)
                });
            }
        });
        closeLoading();
    }
    
    function sortNoDeliveryBOClosing(itemCode){
         $('#blanketOrderClosingItemDetailInput_grid').jqGrid("saveRow",cpoSalesQuotation_lastSel); 
         var ids = jQuery("#blanketOrderClosingItemDetailInput_grid").jqGrid('getDataIDs');
         var temp="";
        for(var i=0;i<ids.length;i++){
                var Detail = $("#blanketOrderClosingItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                if (itemCode===Detail.blanketOrderClosingItemDetailItem){
                    temp=Detail.blanketOrderClosingItemDetailSortNo;
                }
               
        }
        
         $('#blanketOrderClosingItemDeliveryInput_grid').jqGrid("saveRow",blanketOrderClosingItemDelivery_lastSel); 
         var idt = jQuery("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('getDataIDs');
         for(var i=0;i<idt.length;i++){
             var Details = $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid('getRowData',idt[i]); 
                if (itemCode===Details.blanketOrderClosingItemDeliveryItemCode){
                    $("#blanketOrderClosingItemDeliveryInput_grid").jqGrid("setCell",idt[i], "blanketOrderClosingItemDeliverySortNo",temp);

                }
         }
    }
    
    function setBlanketOrderClosingPartialShipmentStatusStatus(){
        switch($("#blanketOrderClosing\\.customerPurchaseOrder\\.partialShipmentStatus").val()){
            case "YES":
                $('input[name="blanketOrderClosingPartialShipmentStatusRad"][value="YES"]').prop('checked',true);
                $('input[name="blanketOrderClosingPartialShipmentStatusRad"][value="NO"]').prop('disabled',true);
                break;
            case "NO":
                $('input[name="blanketOrderClosingPartialShipmentStatusRad"][value="NO"]').prop('checked',true);
                $('input[name="blanketOrderClosingPartialShipmentStatusRad"][value="YES"]').prop('disabled',true);
                break;
        } 
    }
</script>

<s:url id="remoteurlBlanketOrderClosingSalesQuotationInput" action="" />
<s:url id="remoteurlBlanketOrderClosingAdditionalFeeInput" action="" />
<s:url id="remoteurlBlanketOrderClosingPaymentTermInput" action="" />
<s:url id="remoteurlBlanketOrderClosingItemDeliveryInput" action="" />
<b>BLANKET ORDER CLOSING</b><span id="msgBlanketOrderClosingActivity"></span>
<hr>
<br class="spacer" />

<div id="blanketOrderClosingInput" class="content ui-widget">
    <s:form id="frmBlanketOrderClosingInput">
        <table cellpadding="2" cellspacing="2" id="headerBlanketOrderClosingInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" style="width:180px"><B>CPO-BO No *</B></td>
                            <td>
                                <s:textfield id="blanketOrderClosing.code" name="blanketOrderClosing.code" key="blanketOrderClosing.code" readonly="true" size="30"></s:textfield>
                                <s:textfield id="blanketOrderClosing.customerBlanketOrderCode" name="blanketOrderClosing.customerBlanketOrderCode" key="blanketOrderClosing.customerBlanketOrderCode" readonly="true" size="25" disabled="true" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ref POC No *</B></td>
                            <td>
                            <s:textfield id="blanketOrderClosing.custBONo" name="blanketOrderClosing.custBONo" key="blanketOrderClosing.custBONo" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                                <s:textfield id="blanketOrderClosing.refCUSTBOCode" name="blanketOrderClosing.refCUSTBOCode" key="blanketOrderClosing.refCUSTBOCode" readonly="true" size="30"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="blanketOrderClosing.revision" name="blanketOrderClosing.revision" key="blanketOrderClosing.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="blanketOrderClosing.branch.code" name="blanketOrderClosing.branch.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                            </div>
                                <s:textfield id="blanketOrderClosing.branch.name" name="blanketOrderClosing.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="blanketOrderClosing.transactionDate" name="blanketOrderClosing.transactionDate" readonly="true" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" disabled="true"></sj:datepicker>
                                <sj:datepicker id="blanketOrderClosingTransactionDate" name="blanketOrderClosingTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right"><B>Order Status * </B></td>
                            <td colspan="2">
                                <s:radio id="blanketOrderClosingOrderStatusRad" name="blanketOrderClosingOrderStatusRad" label="blanketOrderClosingOrderStatusRad" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio>
                                <s:textfield id="blanketOrderClosing.orderStatus" name="blanketOrderClosing.orderStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="blanketOrderClosing.purchaseOrderType" name="blanketOrderClosing.purchaseOrderType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order*</B></td>
                            <td colspan="3"><s:textfield id="blanketOrderClosing.customerPurchaseOrder.code" name="blanketOrderClosing.customerPurchaseOrder.code" size="27" title=" " required="true" cssClass="required" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Purchase Order No*</B></td>
                            <td colspan="3"><s:textfield id="blanketOrderClosing.customerPurchaseOrder.customerPurchaseOrderNo" name="blanketOrderClosing.customerPurchaseOrder.customerPurchaseOrderNo" size="27" title=" " required="true" readonly="true" cssClass="required"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="blanketOrderClosing.customer.code" name="blanketOrderClosing.customer.code" size="22" title=" " required="true" cssClass="required"  readonly="true"></s:textfield>
                            </div>
                                <s:textfield id="blanketOrderClosing.customer.name" name="blanketOrderClosing.customer.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>End User *</B></td>
                            <td colspan="2">
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="blanketOrderClosing.endUser.code" name="blanketOrderClosing.endUser.code" size="22" title=" " required="true" cssClass="required"  readonly="true"></s:textfield>
                            </div>
                                <s:textfield id="blanketOrderClosing.endUser.name" name="blanketOrderClosing.endUser.name" size="40" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Partial Shipment * </B></td>
                            <td colspan="2">
                                <s:radio id="blanketOrderClosingPartialShipmentStatusRad" name="blanketOrderClosingPartialShipmentStatusRad" label="blanketOrderClosingPartialShipmentStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="blanketOrderClosing.customerPurchaseOrder.partialShipmentStatus" name="blanketOrderClosing.customerPurchaseOrder.partialShipmentStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Retention</td>
                            <td>
                                <s:textfield id="blanketOrderClosing.customerPurchaseOrder.retentionPercent" name="blanketOrderClosing.customerPurchaseOrder.retentionPercent" size="5" cssStyle="text-align:right" readonly="true"></s:textfield>%
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
                                    <s:textfield id="blanketOrderClosing.currency.code" name="blanketOrderClosing.currency.code" title=" " required="true" cssClass="required" size="22" readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="blanketOrderClosing.currency.name" name="blanketOrderClosing.currency.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sales Person *</B></td>
                            <td colspan="2">
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="blanketOrderClosing.salesPerson.code" name="blanketOrderClosing.salesPerson.code" title=" " required="true" cssClass="required" size="22"  readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="blanketOrderClosing.salesPerson.name" name="blanketOrderClosing.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Project</td>
                            <td colspan="2">
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="blanketOrderClosing.project.code" name="blanketOrderClosing.project.code" title=" " size="22"  readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="blanketOrderClosing.project.name" name="blanketOrderClosing.project.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3"><s:textfield id="blanketOrderClosing.refNo" name="blanketOrderClosing.refNo" size="27" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="blanketOrderClosing.remark" name="blanketOrderClosing.remark"  cols="70" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr> 
                    </table>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="blanketOrderClosingDateFirstSession" name="blanketOrderClosingDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="blanketOrderClosingDateLastSession" name="blanketOrderClosingDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumBlanketOrderClosingActivity" name="enumBlanketOrderClosingActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="blanketOrderClosing.createdBy" name="blanketOrderClosing.createdBy" key="blanketOrderClosing.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="blanketOrderClosing.createdDate" name="blanketOrderClosing.createdDate" disabled="true" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="blanketOrderClosing.createdDateTemp" name="blanketOrderClosing.createdDateTemp" size="20" cssStyle="display:none" disabled="true"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmBlanketOrderClosing" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmBlanketOrderClosing" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <div id="blanketOrderClosingSalesQuotationInputGrid">
            <sjg:grid
                id="blanketOrderClosingSalesQuotationInput_grid"
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
                width="$('#tabmnuBlanketOrderClosingDetail').width()"
                editurl="%{remoteurlBlanketOrderClosingSalesQuotationInput}"
                onSelectRowTopics="blanketOrderClosingSalesQuotationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationCode" index="blanketOrderClosingSalesQuotationCode" 
                    title="SLS-QUO No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationTransactionDate" index="blanketOrderClosingSalesQuotationTransactionDate" key="blanketOrderClosingSalesQuotationTransactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationCustomerCode" index="blanketOrderClosingSalesQuotationCustomerCode" 
                    title="Customer Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationCustomerName" index="blanketOrderClosingSalesQuotationCustomerName" 
                    title="Customer Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationEndUserCode" index="blanketOrderClosingSalesQuotationEndUserCode" 
                    title="End User Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationEndUserName" index="blanketOrderClosingSalesQuotationEndUserName" 
                    title="End User Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "blanketOrderClosingSalesQuotationRfqCode" index = "blanketOrderClosingSalesQuotationRfqCode" key = "blanketOrderClosingSalesQuotationRfqCode" 
                    title = "RFQ No" width = "80" edittype="text" 
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationProjectCode" index="blanketOrderClosingSalesQuotationProjectCode" 
                    title="Project" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationSubject" index="blanketOrderClosingSalesQuotationSubject" 
                    title="Subject" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationAttn" index="blanketOrderClosingSalesQuotationAttn" 
                    title="Attn" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationRefNo" index="blanketOrderClosingSalesQuotationRefNo" key="blanketOrderClosingSalesQuotationRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="blanketOrderClosingSalesQuotationRemark" index="blanketOrderClosingSalesQuotationRemark" key="blanketOrderClosingSalesQuotationRemark" 
                    title="Remark" width="150" sortable="true"
                />
            </sjg:grid >
        </div>                
        <table>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmBlanketOrderClosingSalesQuotation" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmBlanketOrderClosingSalesQuotation" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <div id="id-tbl-additional-payment-item-delivery-bo-closing">
            <div>
                <sjg:grid
                    id="blanketOrderClosingItemDetailInput_grid"
                    caption="Item"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listCustomerBlanketOrderItemDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnucustomerpurchaseOrder').width()"
                    editurl="%{remoteurlBlanketOrderClosingSalesQuotationInput}"
                    onSelectRowTopics="blanketOrderClosingItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetail" index="blanketOrderClosingItemDetail" key="blanketOrderClosingItemDetail" 
                        title="" width="50" sortable="true" editable="true" hidden="true"
                    />         
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailQuotationNoDetailCode" index="blanketOrderClosingItemDetailQuotationNoDetailCode" key="blanketOrderClosingItemDetailQuotationNoDetailCode" 
                        title="Quotation No" width="150" sortable="true" hidden="false"
                    />                   
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailQuotationNo" index="blanketOrderClosingItemDetailQuotationNo" key="blanketOrderClosingItemDetailQuotationNo" 
                        title="Quotation No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailQuotationRefNo" index="blanketOrderClosingItemDetailQuotationRefNo" key="blanketOrderClosingItemDetailQuotationRefNo" 
                        title="Ref No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailSortNo" index="blanketOrderClosingItemDetailSortNo" 
                        title="Sort No" width="80" sortable="true" editable="false" edittype="text"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsCode" index="blanketOrderClosingItemDetailItemFinishGoodsCode" key="blanketOrderClosingItemDetailItemFinishGoodsCode" 
                        title="Item Finish Goods Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsRemark" index="blanketOrderClosingItemDetailItemFinishGoodsRemark" key="blanketOrderClosingItemDetailItemFinishGoodsRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailValveTypeCode" index="blanketOrderClosingItemDetailValveTypeCode" key="blanketOrderClosingItemDetailValveTypeCode" 
                        title="Valve Type Code (QUO)" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailValveTypeName" index="blanketOrderClosingItemDetailValveTypeName" key="blanketOrderClosingItemDetailValveTypeName" 
                        title="Valve Type Name (QUO)" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemAlias" index="blanketOrderClosingItemDetailItemAlias" 
                        title="Item Alias" width="100" sortable="true" edittype="text"
                    /> 
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailValveTag" index="blanketOrderClosingItemDetailValveTag" 
                        title="Valve Tag" width="100" sortable="true" edittype="text"
                    />  
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailDataSheet" index="blanketOrderClosingItemDetailDataSheet" 
                        title="Data Sheet" width="100" sortable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailDescription" index="blanketOrderClosingItemDetailDescription" 
                        title="Description" width="100" sortable="true" edittype="text"
                    />
                    <!--Body Const 01-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailBodyConstQuotation" index="blanketOrderClosingItemDetailBodyConstQuotation" 
                        title="QUO (01)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBodyConstCode" index="blanketOrderClosingItemDetailItemFinishGoodsBodyConstCode" 
                        title="IFG (01)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBodyConstName" index="blanketOrderClosingItemDetailItemFinishGoodsBodyConstName" 
                        title="IFG (01)" width="100" sortable="true"
                    />
                    <!--Type Design 02-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailTypeDesignQuotation" index="blanketOrderClosingItemDetailTypeDesignQuotation" 
                        title="QUO (02)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsTypeDesignCode" index="blanketOrderClosingItemDetailItemFinishGoodsTypeDesignCode" 
                        title="IFG (02)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsTypeDesignName" index="blanketOrderClosingItemDetailItemFinishGoodsTypeDesignName" 
                        title="IFG (02)" width="100" sortable="true"
                    />
                    <!--Seat Design 03-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailSeatDesignQuotation" index="blanketOrderClosingItemDetailSeatDesignQuotation" 
                        title="QUO (03)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSeatDesignCode" index="blanketOrderClosingItemDetailItemFinishGoodsSeatDesignCode" 
                        title="IFG (03)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSeatDesignName" index="blanketOrderClosingItemDetailItemFinishGoodsSeatDesignName" 
                        title="IFG (03)" width="100" sortable="true"
                    />
                    <!--Size 04-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailSizeQuotation" index="blanketOrderClosingItemDetailSizeQuotation" 
                        title="QUO (04)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSizeCode" index="blanketOrderClosingItemDetailItemFinishGoodsSizeCode" 
                        title="IFG (04)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSizeName" index="blanketOrderClosingItemDetailItemFinishGoodsSizeName" 
                        title="IFG (04)" width="100" sortable="true"
                    />
                    <!--Rating 05-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailRatingQuotation" index="blanketOrderClosingItemDetailRatingQuotation" 
                        title="QUO (05)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsRatingCode" index="blanketOrderClosingItemDetailItemFinishGoodsRatingCode" 
                        title="IFG (05)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsRatingName" index="blanketOrderClosingItemDetailItemFinishGoodsRatingName" 
                        title="IFG (05)" width="100" sortable="true"
                    />
                    <!--Bore 06-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailBoreQuotation" index="blanketOrderClosingItemDetailBoreQuotation" 
                        title="QUO (06)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBoreCode" index="blanketOrderClosingItemDetailItemFinishGoodsBoreCode" 
                        title="IFG (06)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBoreName" index="blanketOrderClosingItemDetailItemFinishGoodsBoreName" 
                        title="IFG (06)" width="100" sortable="true"
                    />
                    <!--EndCon 07-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailEndConQuotation" index="blanketOrderClosingItemDetailEndConQuotation" 
                        title="QUO (07)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsEndConCode" index="blanketOrderClosingItemDetailItemFinishGoodsEndConCode" 
                        title="IFG (07)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsEndConName" index="blanketOrderClosingItemDetailItemFinishGoodsEndConName" 
                        title="IFG (07)" width="100" sortable="true"
                    />
                    <!--Body 08-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailBodyQuotation" index="blanketOrderClosingItemDetailBodyQuotation" 
                        title="QUO (08)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBodyCode" index="blanketOrderClosingItemDetailItemFinishGoodsBodyCode" 
                        title="IFG (08)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBodyName" index="blanketOrderClosingItemDetailItemFinishGoodsBodyName" 
                        title="IFG (08)" width="100" sortable="true"
                    />
                    <!--Ball 09-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailBallQuotation" index="blanketOrderClosingItemDetailBallQuotation" 
                        title="QUO (09)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBallCode" index="blanketOrderClosingItemDetailItemFinishGoodsBallCode" 
                        title="IFG (09)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBallName" index="blanketOrderClosingItemDetailItemFinishGoodsBallName" 
                        title="IFG (09)" width="100" sortable="true"
                    />
                    <!--Seat 10-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailSeatQuotation" index="blanketOrderClosingItemDetailSeatQuotation" 
                        title="QUO (10)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSeatCode" index="blanketOrderClosingItemDetailItemFinishGoodsSeatCode" 
                        title="IFG (10)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSeatName" index="blanketOrderClosingItemDetailItemFinishGoodsSeatName" 
                        title="IFG (10)" width="100" sortable="true"
                    />
                    <!--SeatInsert 11-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailSeatInsertQuotation" index="blanketOrderClosingItemDetailSeatInsertQuotation" 
                        title="QUO (11)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSeatInsertCode" index="blanketOrderClosingItemDetailItemFinishGoodsSeatInsertCode" 
                        title="IFG (11)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSeatInsertName" index="blanketOrderClosingItemDetailItemFinishGoodsSeatInsertName" 
                        title="IFG (11)" width="100" sortable="true"
                    />
                    <!--Stem 12-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailStemQuotation" index="blanketOrderClosingItemDetailStemQuotation" 
                        title="QUO (12)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsStemCode" index="blanketOrderClosingItemDetailItemFinishGoodsStemCode" 
                        title="IFG (12)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsStemName" index="blanketOrderClosingItemDetailItemFinishGoodsStemName" 
                        title="IFG (12)" width="100" sortable="true"
                    />
                    <!--Seal 13-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailSealQuotation" index="blanketOrderClosingItemDetailSealQuotation" 
                        title="QUO (13)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSealCode" index="blanketOrderClosingItemDetailItemFinishGoodsSealCode" 
                        title="IFG (13)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSealName" index="blanketOrderClosingItemDetailItemFinishGoodsSealName" 
                        title="IFG (13)" width="100" sortable="true"
                    />
                    <!--Bolt 14-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailBoltQuotation" index="blanketOrderClosingItemDetailBoltQuotation" 
                        title="QUO (14)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBoltCode" index="blanketOrderClosingItemDetailItemFinishGoodsBoltCode" 
                        title="IFG (14)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBoltName" index="blanketOrderClosingItemDetailItemFinishGoodsBoltName" 
                        title="IFG (14)" width="100" sortable="true"
                    />
                    <!--Disc 15-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailDiscQuotation" index="blanketOrderClosingItemDetailDiscQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsDiscCode" index="blanketOrderClosingItemDetailItemFinishGoodsDiscCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsDiscName" index="blanketOrderClosingItemDetailItemFinishGoodsDiscName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Plates 16-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailPlatesQuotation" index="blanketOrderClosingItemDetailPlatesQuotation" 
                        title="QUO (15)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsPlatesCode" index="blanketOrderClosingItemDetailItemFinishGoodsPlatesCode" 
                        title="IFG (15)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsPlatesName" index="blanketOrderClosingItemDetailItemFinishGoodsPlatesName" 
                        title="IFG (15)" width="100" sortable="true"
                    />
                    <!--Shaft 17-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailShaftQuotation" index="blanketOrderClosingItemDetailShaftQuotation" 
                        title="QUO (17)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsShaftCode" index="blanketOrderClosingItemDetailItemFinishGoodsShaftCode" 
                        title="IFG (17)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsShaftName" index="blanketOrderClosingItemDetailItemFinishGoodsShaftName" 
                        title="IFG (17)" width="100" sortable="true"
                    />
                    <!--Spring 18-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailSpringQuotation" index="blanketOrderClosingItemDetailSpringQuotation" 
                        title="QUO (18)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSpringCode" index="blanketOrderClosingItemDetailItemFinishGoodsSpringCode" 
                        title="IFG (18)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsSpringName" index="blanketOrderClosingItemDetailItemFinishGoodsSpringName" 
                        title="IFG (18)" width="100" sortable="true"
                    />
                    <!--ArmPin 19-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailArmPinQuotation" index="blanketOrderClosingItemDetailArmPinQuotation" 
                        title="QUO (19)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsArmPinCode" index="blanketOrderClosingItemDetailItemFinishGoodsArmPinCode" 
                        title="IFG (19)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsArmPinName" index="blanketOrderClosingItemDetailItemFinishGoodsArmPinName" 
                        title="IFG (19)" width="100" sortable="true"
                    />
                    <!--BackSeat 20-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailBackSeatQuotation" index="blanketOrderClosingItemDetailBackSeatQuotation" 
                        title="QUO (20)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBackSeatCode" index="blanketOrderClosingItemDetailItemFinishGoodsBackSeatCode" 
                        title="IFG (20)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsBackSeatName" index="blanketOrderClosingItemDetailItemFinishGoodsBackSeatName" 
                        title="IFG (20)" width="100" sortable="true"
                    />
                    <!--Arm 21-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailArmQuotation" index="blanketOrderClosingItemDetailArmQuotation" 
                        title="QUO (21)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsArmCode" index="blanketOrderClosingItemDetailItemFinishGoodsArmCode" 
                        title="IFG (21)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsArmName" index="blanketOrderClosingItemDetailItemFinishGoodsArmName" 
                        title="IFG (21)" width="100" sortable="true"
                    />
                    <!--HingePin 22-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailHingePinQuotation" index="blanketOrderClosingItemDetailHingePinQuotation" 
                        title="QUO (22)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsHingePinCode" index="blanketOrderClosingItemDetailItemFinishGoodsHingePinCode" 
                        title="IFG (22)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsHingePinName" index="blanketOrderClosingItemDetailItemFinishGoodsHingePinName" 
                        title="IFG (22)" width="100" sortable="true"
                    />
                    <!--StopPin 23-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailStopPinQuotation" index="blanketOrderClosingItemDetailStopPinQuotation" 
                        title="QUO (23)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsStopPinCode" index="blanketOrderClosingItemDetailItemFinishGoodsStopPinCode" 
                        title="IFG (23)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsStopPinName" index="blanketOrderClosingItemDetailItemFinishGoodsStopPinName" 
                        title="IFG (23)" width="100" sortable="true"
                    />
                    <!--Operator 99-->
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailOperatorQuotation" index="blanketOrderClosingItemDetailOperatorQuotation" 
                        title="QUO (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsOperatorCode" index="blanketOrderClosingItemDetailItemFinishGoodsOperatorCode" 
                        title="IFG (99)" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailItemFinishGoodsOperatorName" index="blanketOrderClosingItemDetailItemFinishGoodsOperatorName" 
                        title="IFG (99)" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailNote" index="blanketOrderClosingItemDetailNote" title="Note" width="100" sortable="true" editable="false"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailQuantity" index="blanketOrderClosingItemDetailQuantity" key="blanketOrderClosingItemDetailQuantity" title="Qty" 
                        width="150" align="right" editable="false" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                        formatter="number" editrules="{ double: true }"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailPrice" index="blanketOrderClosingItemDetailPrice" key="blanketOrderClosingItemDetailPrice" title="Unit Price" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="blanketOrderClosingItemDetailTotal" index="blanketOrderClosingItemDetailTotal" key="blanketOrderClosingItemDetailTotal" title="Total" 
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
                                id="blanketOrderClosingAdditionalFeeInput_grid"
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
                                width="$('#tabmnuBlanketOrderClosingAdditionalFee').width()"
                                editurl="%{remoteurlBlanketOrderClosingAdditionalFeeInput}"
                                onSelectRowTopics="blanketOrderClosingAdditionalFeeInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFee" index="blanketOrderClosingAdditionalFee" key="blanketOrderClosingAdditionalFee" 
                                    title="" width="50" sortable="true" editable="true" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeRemark" index="blanketOrderClosingAdditionalFeeRemark" key="blanketOrderClosingAdditionalFeeRemark" 
                                    title="Remark" width="150" sortable="true" editable="false"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeQuantity" index="blanketOrderClosingAdditionalFeeQuantity" key="blanketOrderClosingAdditionalFeeQuantity" title="Quantity" 
                                    width="80" align="right" editable="false" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateBlanketOrderClosingAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeUnitOfMeasureCode" index="blanketOrderClosingAdditionalFeeUnitOfMeasureCode" 
                                    title="Unit" width="100" sortable="true" editable="false" edittype="text" 
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeAdditionalFeeCode" index="blanketOrderClosingAdditionalFeeAdditionalFeeCode" 
                                    title="Additional Fee Code" width="100" sortable="true" editable="false" edittype="text"
                                /> 
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeAdditionalFeeName" index="blanketOrderClosingAdditionalFeeAdditionalFeeName" 
                                    title="Additional Fee Name" width="100" sortable="true" editable="false" edittype="text"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeChartOfAccountCode" index="blanketOrderClosingAdditionalFeeChartOfAccountCode" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" 
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeChartOfAccountName" index="blanketOrderClosingAdditionalFeeChartOfAccountName" 
                                    title="COA" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeePrice" index="blanketOrderClosingAdditionalFeePrice" key="blanketOrderClosingAdditionalFeePrice" title="Price" 
                                    width="150" align="right" editable="false" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                    formatter="number" editrules="{ double: true }"
                                    editoptions="{onKeyUp:'calculateBlanketOrderClosingAdditionalFee()'}"
                                />
                                <sjg:gridColumn
                                    name="blanketOrderClosingAdditionalFeeTotal" index="blanketOrderClosingAdditionalFeeTotal" key="blanketOrderClosingAdditionalFeeTotal" title="Total" 
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
                                            id="blanketOrderClosingPaymentTermInput_grid"
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
                                            editurl="%{remoteurlBlanketOrderClosingPaymentTermInput}"
                                            onSelectRowTopics="blanketOrderClosingPaymentTermInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="blanketOrderClosingPaymentTerm" index="blanketOrderClosingPaymentTerm" 
                                                title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                            />  
                                            <sjg:gridColumn
                                                name="blanketOrderClosingPaymentTermSortNO" index="blanketOrderClosingPaymentTermSortNO" key="blanketOrderClosingPaymentTermSortNO" title="Term No" 
                                                width="80" align="right" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingPaymentTermPaymentTermCode" index="blanketOrderClosingPaymentTermPaymentTermCode" 
                                                title="Payment Term Code" width="100" sortable="true" editable="false" edittype="text"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingPaymentTermSearchPaymentTerm" index="blanketOrderClosingPaymentTermSearchPaymentTerm" title="" width="25" align="centre"
                                                editable="false" dataType="html" edittype="button"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingPaymentTermPaymentTermName" index="blanketOrderClosingPaymentTermPaymentTermName" 
                                                title="Payment Term" width="100" sortable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingPaymentTermPercent" index="blanketOrderClosingPaymentTermPercent" key="blanketOrderClosingPaymentTermPercent" title="Percent" 
                                                width="80" align="right" editable="false" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingPaymentTermRemark" index="blanketOrderClosingPaymentTermRemark" 
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
                                        <s:textfield id="blanketOrderClosing.totalTransactionAmount" name="blanketOrderClosing.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Disc
                                        <s:textfield id="blanketOrderClosing.discountPercent" name="blanketOrderClosing.discountPercent" readonly="true" onkeyup="calculateBlanketOrderClosingHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                    <s:textfield id="blanketOrderClosing.discountAmount" name="blanketOrderClosing.discountAmount" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Additional</td>
                                    <td>
                                    <s:textfield id="blanketOrderClosing.totalAdditionalFeeAmount" name="blanketOrderClosing.totalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" disabled="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><b>Sub Total(Tax Base)</b></td>
                                    <td>
                                        <s:textfield id="blanketOrderClosing.taxBaseAmount" name="blanketOrderClosing.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">VAT
                                        <s:textfield id="blanketOrderClosing.vatPercent" name="blanketOrderClosing.vatPercent" readonly="true" onkeyup="calculateBlanketOrderClosingHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                                    </td>
                                    <td>
                                        <s:textfield id="blanketOrderClosing.vatAmount" name="blanketOrderClosing.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Grand Total</B></td>
                                    <td>
                                        <s:textfield id="blanketOrderClosing.grandTotalAmount" name="blanketOrderClosing.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
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
                        <sj:a href="#" id="btnConfirmBlanketOrderClosingItemDetailDelivery" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmBlanketOrderClosingItemDetailDelivery" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>                
            <div id="id-tbl-additional-item-delivery-detail-bo-closing">
                <table>
                    <tr>
                        <td align="right">
                            <sj:datepicker id="blanketOrderClosingDeliveryDateSet" name="blanketOrderClosingDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today" cssStyle="display:none"></sj:datepicker>
                            <%--<sj:a href="#" id="btnBlanketOrderClosingDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;--%>
                            <%--<sj:a href="#" id="btnBlanketOrderClosingCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>--%>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="blanketOrderClosingItemDeliveryInput_grid"
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
                                            editurl="%{remoteurlBlanketOrderClosingItemDeliveryInput}"
                                            onSelectRowTopics="blanketOrderClosingItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="blanketOrderClosingItemDelivery" index="blanketOrderClosingItemDelivery" key="blanketOrderClosingItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name = "blanketOrderClosingItemDeliveryItemFinishGoodsCode" index = "blanketOrderClosingItemDeliveryItemFinishGoodsCode" key = "blanketOrderClosingItemDeliveryItemFinishGoodsCode" 
                                                title = "Item Finish Goods Code" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "blanketOrderClosingItemDeliveryItemFinishGoodsRemark" index = "blanketOrderClosingItemDeliveryItemFinishGoodsRemark" key = "blanketOrderClosingItemDeliveryItemFinishGoodsRemark" 
                                                title = "IFG Remark" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingItemDeliverySortNo" index="blanketOrderClosingItemDeliverySortNo" title="Sort No" width="80" sortable="true"
                                            />  
                                            <sjg:gridColumn
                                                name="blanketOrderClosingItemDeliveryQuantity" index="blanketOrderClosingItemDeliveryQuantity" key="blanketOrderClosingItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="false" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingItemDeliveryDeliveryDate" index="blanketOrderClosingItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="false" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangeBlanketOrderClosingItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="blanketOrderClosingItemDeliveryDeliveryDateTemp" index="blanketOrderClosingItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                            <sjg:gridColumn
                                                name = "blanketOrderClosingItemDeliverySalesQuotationCode" index = "blanketOrderClosingItemDeliverySalesQuotationCode" key = "blanketOrderClosingItemDeliverySalesQuotationCode" 
                                                title = "Quotation No" width = "100" 
                                            />
                                            <sjg:gridColumn
                                                name = "blanketOrderClosingItemDeliverySalesQuotationRefNo" index = "blanketOrderClosingItemDeliverySalesQuotationRefNo" key = "blanketOrderClosingItemDeliverySalesQuotationRefNo" 
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
                    <sj:a href="#" id="btnBlanketOrderClosingSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnBlanketOrderClosingCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    