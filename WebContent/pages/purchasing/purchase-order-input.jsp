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
    .ui-dialog-titlebar-close{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
    .ui-jqgrid tr.jqgrow td {
        white-space: normal !important;
        height:auto;
        vertical-align:text-top;
        padding:2px;
        word-break:break-all;  
    }
</style>

<script type="text/javascript">
     var purchaseOrderPurchaseRequestlastSel = -1,
         purchaseOrderPurchaseRequestRowId = 0,
         purchaseOrderPurchaseRequestDetailRowId = 0,
         purchaseOrderDetailRowId = 0,
         purchaseOrderDetaillastsel = -1,
         purchaseOrderDetailAdditionalRowId = 0,
         purchaseOrderDetailAdditionallastsel = -1,
         purchaseOrderDetailItemDeliveryRowId = 0,
         purchaseOrderDetailItemDeliverylastsel = -1;
         
     var flagHeader=false,
         flagDetail=false,
         flagIsConfirmPO=false;
         flagIsConfirmPOD=false;
    
    var 
        txtPurchaseOrderCode = $("#purchaseOrder\\.code"),
        dtpPurchaseOrderTransactionDate = $("#purchaseOrder\\.transactionDate"),
        dtpPurchaseOrderDeliveryDateStart = $("#purchaseOrder\\.deliveryDateStart"),
        dtpPurchaseOrderDeliveryDateEnd = $("#purchaseOrder\\.deliveryDateEnd"),
        txtPurchaseOrderBranchCode = $("#purchaseOrder\\.branch\\.code"),
        txtPurchaseOrderBranchName = $("#purchaseOrder\\.branch\\.name"),
        txtPurchaseOrderPaymentTermCode = $("#purchaseOrder\\.paymentTerm\\.code"),
        txtPurchaseOrderPaymentTermName = $("#purchaseOrder\\.paymentTerm\\.name"),
        txtPurchaseOrderCurrencyCode = $("#purchaseOrder\\.currency\\.code"),
        txtPurchaseOrderCurrencyName = $("#purchaseOrder\\.currency\\.name"),
        txtPurchaseOrderVendorCode = $("#purchaseOrder\\.vendor\\.code"),
        txtPurchaseOrderVendorName = $("#purchaseOrder\\.vendor\\.name"),
        txtPurchaseOrderVendorContactPersonCode = $("#purchaseOrder\\.vendor\\.defaultContactPerson\\.code"),
        txtPurchaseOrderVendorContactPersonName = $("#purchaseOrder\\.vendor\\.defaultContactPerson\\.name"),
        txtPurchaseOrderBillToCode = $("#purchaseOrder\\.billTo\\.code"),
        txtPurchaseOrderBillToName = $("#purchaseOrder\\.billTo\\.name"),
        txtPurchaseOrderShipToCode = $("#purchaseOrder\\.shipTo\\.code"),
        txtPurchaseOrderShipToName = $("#purchaseOrder\\.shipTo\\.name"),
        txtPurchaseOrderTotalTransactionAmount = $("#purchaseOrder\\.totalTransactionAmount"),
        txtPurchaseOrderDiscountPercent = $("#purchaseOrder\\.discountPercent"),
        txtPurchaseOrderDiscountAmount = $("#purchaseOrder\\.discountAmount"),
        txtPurchaseOrderDiscountAccountCode = $("#purchaseOrder\\.discountChartOfAccount\\.code"),
        txtPurchaseOrderDiscountAccountName = $("#purchaseOrder\\.discountChartOfAccount\\.name"),
        txtPurchaseOrderTaxBaseSubTotalAmount = $("#purchaseOrder\\.taxBaseSubTotalAmount"),
        txtPurchaseOrderVATPercent = $("#purchaseOrder\\.vatPercent"),
        txtPurchaseOrderVATAmount = $("#purchaseOrder\\.vatAmount"),
        txtPurchaseOrderOtherFeeAmount = $("#purchaseOrder\\.otherFeeAmount"),
        txtPurchaseOrderOtherFeeAccountCode = $("#purchaseOrder\\.otherFeeChartOfAccount\\.code"),
        txtPurchaseOrderOtherFeeAccountName = $("#purchaseOrder\\.otherFeeChartOfAccount\\.name"),
        txtPurchaseOrderGrandTotalAmount = $("#purchaseOrder\\.grandTotalAmount");
        
    $(document).ready(function() {
        hoverButton();
        
        formatNumericPO();
        $("#msgPurchaseOrderActivity").html(" - <i>" + $("#enumPurchaseOrderActivity").val()+"<i>").show();
        
        if($("#enumPurchaseOrderActivity").val() === "UPDATE"){
            
            loadImportLocal($("#purchaseOrder\\.vendor\\.localImport").val());
            
            if ($("#purchaseOrder\\.penaltyStatus").val()== "true"){
                $('#purchaseOrderPenaltyStatusRadYES').prop('checked',true);
                enabledDisabledPenaltyPercent('YES');
            }else{
                $('#purchaseOrderPenaltyStatusRadNO').prop('checked',true);
                enabledDisabledPenaltyPercent('NO');
            }
            
        }else{
            $('#purchaseOrderPenaltyStatusRadYES').prop('checked',true);
            $("#purchaseOrder\\.penaltyStatus").val("true");
        }
        
        $('input[name="purchaseOrderPenaltyStatusRad"][value="YES"]').change(function(ev){
            var value="true";
            $("#purchaseOrder\\.penaltyStatus").val(value);
        });
        
        $('input[name="purchaseOrderPenaltyStatusRad"][value="NO"]').change(function(ev){
            var value="false";
            $("#purchaseOrder\\.penaltyStatus").val(value);
        });
        
        $('input[name="purchaseOrderPenaltyStatusRad"][value="YES"]').change(function(ev){
            enabledDisabledPenaltyPercent("YES");
        });
                
        $('input[name="purchaseOrderPenaltyStatusRad"][value="NO"]').change(function(ev){
            enabledDisabledPenaltyPercent("NO");
        });
        
        $.subscribe("purchaseOrderDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#purchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==purchaseOrderDetaillastsel) {
                $('#purchaseOrderDetailInput_grid').jqGrid("saveRow",purchaseOrderDetaillastsel); 
                $('#purchaseOrderDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                purchaseOrderDetaillastsel=selectedRowID;
            }
            else{
                $('#purchaseOrderDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("purchaseOrderAdditionalFeeInput_grid_onSelect", function() {
            
            var selectedRowID = $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==purchaseOrderDetailAdditionallastsel) {
                $('#purchaseOrderAdditionalFeeInput_grid').jqGrid("saveRow",purchaseOrderDetailAdditionallastsel); 
                $('#purchaseOrderAdditionalFeeInput_grid').jqGrid("editRow",selectedRowID,true);            
                purchaseOrderDetailAdditionallastsel=selectedRowID;
            }
            else{
                $('#purchaseOrderAdditionalFeeInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("purchaseOrderItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#purchaseOrderItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==purchaseOrderDetailItemDeliverylastsel) {
                $('#purchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderDetailItemDeliverylastsel); 
                $('#purchaseOrderItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            
                purchaseOrderDetailItemDeliverylastsel=selectedRowID;
            }
            else{
                $('#purchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $("#btnUnConfirmPurchaseOrder").css("display", "none");
        $("#btnPOPRQDetail").css("display", "none");
        $("#btnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
        $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
        $("#btnAdditionalFeeDetail").css("display", "none");
        $("#btnPOItemDetail").css("display", "none");
        $("#btnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
        $("#btnUnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
        $("#btnConfirmPurchaseOrderDetail").css("display", "none");
        $("#btnUnConfirmPurchaseOrderDetail").css("display", "none");
        $('#purchaseOrderPurchaseRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#purchaseOrderPurchasetRequestItemDetail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#purchaseOrderDetailTable').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#PurchaseOrderItemDeliveryDate').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmPurchaseOrder").click(function(ev) {
            handlers_input_purchase_order();
            if(txtPurchaseOrderBranchCode.val()===""){
                alertMessage("Branch Can't Empty");
                return;
            }
            if(txtPurchaseOrderPaymentTermCode.val()===""){
                alertMessage("Payment Term Can't Empty");
                return;
            }
            if(txtPurchaseOrderCurrencyCode.val()===""){
                alertMessage("Currency Can't Empty");
                return;
            }
            if(txtPurchaseOrderVendorCode.val()===""){
                alertMessage("Vendor Can't Empty");
                return;
            }
            if(txtPurchaseOrderBillToCode.val()===""){
                alertMessage("Bill To Can't Empty");
                return;
            } 
            if(txtPurchaseOrderShipToCode.val()===""){
                alertMessage("Ship To Can't Empty");
                return;
            }   

            flagHeader=true;
            
            var penaltyPercent = removeCommas($("#purchaseOrder\\.penaltyPercent").val());
            var maximumPenPercent = removeCommas($("#purchaseOrder\\.maximumPenaltyPercent").val());
            
            if($("#purchaseOrder\\.penaltyStatus").val() === "true"){
                if(parseFloat(penaltyPercent) === 0 && parseFloat(maximumPenPercent) === 0){
                    alertEx("Penalty Can't Be Zero");
                    return;
                }
            }
            
            if (parseFloat(penaltyPercent) > parseFloat(maximumPenPercent)){
                alertEx("Penalty Percent Must Less Than Maximum Penalty Percent");
                return;
            }

            var transactionDate=$("#purchaseOrder\\.transactionDate").val();
            var dateFirstSession=new Date($("#purchaseOrderTransactionDateTempFirstSession").val());
            var dateLastSession=new Date($("#purchaseOrderTransactionDateTempLastSession").val());
            var dateValues= transactionDate.split('/'); 
            var tahun = dateValues[2].split(' '); 
            var transactionDateValue =new Date(dateValues[1]+"/"+dateValues[0]+"/"+tahun[0]);

            if( transactionDateValue < dateFirstSession || transactionDateValue > dateLastSession){
                alertEx("Transaction date must between sesion period");
                return;
            }
            var date = $("#purchaseOrder\\.transactionDate").val().split("/");
            var month = date[1];
            var year = date[2].split(" ");
            if(parseFloat(month) != parseFloat($("#panel_periodMonth").val())){
                alertEx("Transaction Date Not In Periode Setup");
                return;
            }

            if(parseFloat(year) != parseFloat($("#panel_periodYear").val())){
                alertEx("Transaction Date Not In Periode Setup");
                return;
            }
            var date1 = dtpPurchaseOrderTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#purchaseOrderTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#purchaseOrderUpdateMode").val()==="true"){
                    alertEx("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#purchaseOrderTransactionDate").val(),dtpPurchaseOrderTransactionDate);
                }else{
                    alertEx("Transaction Month Must Between Session Period Month!",dtpPurchaseOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#purchaseOrderUpdateMode").val()==="true"){
                    alertEx("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#purchaseOrderTransactionDate").val(),dtpPurchaseOrderTransactionDate);
                }else{
                    alertEx("Transaction Year Must Between Session Period Year!",dtpPurchaseOrderTransactionDate);
                }
                return;
            }
            
            var deliveryDateStartValue=dtpPurchaseOrderDeliveryDateStart.val().split(' ')[0];
            var deliveryDateStartValues= deliveryDateStartValue.split('/');
            var deliveryDateStart =new Date(deliveryDateStartValues[1]+"/"+deliveryDateStartValues[0]+"/"+deliveryDateStartValues[2]);
            var deliveryDateEndValue=dtpPurchaseOrderDeliveryDateEnd.val().split(' ')[0];
            var deliveryDateEndValues= deliveryDateEndValue.split('/');
            var deliveryDateEnd =new Date(deliveryDateEndValues[1]+"/"+deliveryDateEndValues[0]+"/"+deliveryDateEndValues[2]);
            
            if(deliveryDateEnd < deliveryDateStart){
                alertMessage("Delivery Date Start Can't Greater Than Delivery Date End!");
                return;
            }
            
            $("#btnUnConfirmPurchaseOrder").css("display", "block");
            $("#btnPOPRQDetail").css("display", "block");
            $("#btnConfirmPurchaseOrder").css("display", "none");
            $("#btnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "block");
            $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
            $('#headerPurchaseOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#purchaseOrderPurchaseRequestDetailInputGrid').unblock();
            loadPurchaseRequestDetail();
        });
        
        $("#btnUnConfirmPurchaseOrder").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');
            var rows = jQuery("#purchaseOrderPurchaseRequestDetailInputGrid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagHeader=false;
                $("#btnUnConfirmPurchaseOrder").css("display", "none");
                $("#btnConfirmPurchaseOrder").css("display", "block");
                $("#btnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
                $("#btnPOPRQDetail").css("display", "none");
                $('#headerPurchaseOrderInput').unblock();
                $('#purchaseOrderPurchaseRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('clearGridData');
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
                                flagHeader=false;
                                $("#btnUnConfirmPurchaseOrder").css("display", "none");
                                $("#btnConfirmPurchaseOrder").css("display", "block");
                                $("#btnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
                                $("#btnPOPRQDetail").css("display", "none");
                                $('#headerPurchaseOrderInput').unblock();
                                $('#purchaseOrderPurchaseRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('clearGridData');
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

        $("#btnConfirmPurchaseOrderPurchaseRequestDetail").click(function(ev) {
            if(flagHeader===false){
                alertMessage("Please Confirm Header First !");
                return;
            }
            var ids = jQuery("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getDataIDs');
                if(ids.length===0){
                    alertEx("Data detail can not empty..!!! ");
                    $("#dlgLoading").dialog("close");
                    return;
                }
                
            $("#btnUnConfirmPurchaseOrder").css("display", "none");
            $("#btnPOPRQDetail").css("display", "none");
            $("#btnConfirmPurchaseOrder").css("display", "none");
            $("#btnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
            $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "block");
            $("#btnConfirmPurchaseOrderPurchaseRequest").css("display", "block");
            $('#purchaseOrderPurchaseRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#purchaseOrderPurchasetRequestItemDetail').unblock();
            
            loadPoJnPrItemDetail();
            
            flagDetail=true;
        }); 
        
        $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');
            var rows = jQuery("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagDetail=false;
                $("#btnUnConfirmPurchaseOrder").css("display", "block");
                $("#btnPOPRQDetail").css("display", "block");
                $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
                $("#btnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
                $("#btnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "block");
                $('#purchaseOrderPurchaseRequestDetailInputGrid').unblock();
                $('#purchaseOrderPurchasetRequestItemDetail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('clearGridData');
                $("#purchaseOrderPurchaseRequestItemDetailNonIMRInput_grid").jqGrid('clearGridData');
                $("#purchaseOrderSubItemInput_grid").jqGrid('clearGridData');
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
                                flagDetail=false;
                                $("#btnUnConfirmPurchaseOrder").css("display", "block");
                                $("#btnPOPRQDetail").css("display", "block");
                                $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
                                $("#btnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
                                $("#btnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "block");
                                $('#purchaseOrderPurchaseRequestDetailInputGrid').unblock();
                                $('#purchaseOrderPurchasetRequestItemDetail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('clearGridData');
                                $("#purchaseOrderPurchaseRequestItemDetailNonIMRInput_grid").jqGrid('clearGridData');
                                $("#purchaseOrderSubItemInput_grid").jqGrid('clearGridData');
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
        
        $("#btnConfirmPurchaseOrderPurchaseRequest").click(function(ev) {
            if($("#enumPurchaseOrderActivity").val() === "UPDATE"){
               loadPODetail();
               loadPOAdditionalFee();
            }else{
               copyItemToPOD();
            }    
            
            $("#btnPOItemDetail").css("display", "block");
            $("#btnAdditionalFeeDetail").css("display", "block");
            $("#btnUnConfirmPurchaseOrderPurchaseRequest").css("display", "block");
            $("#btnConfirmPurchaseOrderDetail").css("display", "block");
            $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "none");
            $("#btnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
            $('#purchaseOrderPurchasetRequestItemDetail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#purchaseOrderDetailTable').unblock();
            
        }); 
        
        $("#btnUnConfirmPurchaseOrderPurchaseRequest").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');
            var rows = jQuery("#purchaseOrderSubItemInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagDetail=false;
                $("#btnPOItemDetail").css("display", "none");
                $("#btnAdditionalFeeDetail").css("display", "none");
                $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "block");
                $("#btnConfirmPurchaseOrderPurchaseRequest").css("display", "block");
                $("#btnUnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
                $("#btnConfirmPurchaseOrderDetail").css("display", "none");
                $('#purchaseOrderPurchasetRequestItemDetail').unblock();
                $('#purchaseOrderDetailTable').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#purchaseOrderDetailInput_grid").jqGrid('clearGridData');
                $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('clearGridData');
                clearAmountPurchaseOrderHeader();
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
                                flagDetail=false;
                                $("#btnPOItemDetail").css("display", "none");
                                $("#btnAdditionalFeeDetail").css("display", "none");
                                $("#btnUnConfirmPurchaseOrderPurchaseRequestDetail").css("display", "block");
                                $("#btnConfirmPurchaseOrderPurchaseRequest").css("display", "block");
                                $("#btnUnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
                                $("#btnConfirmPurchaseOrderDetail").css("display", "none");
                                $('#purchaseOrderPurchasetRequestItemDetail').unblock();
                                $('#purchaseOrderDetailTable').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#purchaseOrderDetailInput_grid").jqGrid('clearGridData');
                                $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('clearGridData');
                                clearAmountPurchaseOrderHeader();
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
        
        $("#btnConfirmPurchaseOrderDetail").click(function(ev) {
            
            var ids = jQuery("#purchaseOrderDetailInput_grid").jqGrid('getDataIDs');
            if(ids.length===0){
                alertEx("Data detail can not empty..!!! ");
                    $("#dlgLoading").dialog("close");
                return;
            }
            
            var ids = jQuery("#purchaseOrderDetailInput_grid").jqGrid('getDataIDs');
            for(var i=0;i < ids.length;i++) {
                var data = $("#purchaseOrderDetailInput_grid").jqGrid('getRowData',ids[i]);
                
                if(parseFloat(data.purchaseOrderDetailDiscPercent).toFixed(2) > 100 && parseFloat(data.purchaseOrderDetailDiscPercent).toFixed(2) < 0){
                    alertMessage("Percent Can't greater than 100%!",400);
                    return;
                }
                
                if(parseFloat(data.purchaseOrderDetailDiscAmount).toFixed(2) < 0){
                    alertMessage("Amount Can't less than 0!",400);
                    return;
                }
                
                if(parseFloat(data.purchaseOrderDetailNettPrice).toFixed(2) < 0){
                    alertMessage("Nett Price Can't less than 0!",400);
                    return;
                }
                
                if(parseFloat(data.purchaseOrderDetailTotalPrice).toFixed(2) < 0){
                    alertMessage("Total Price Can't less than 0!",400);
                    return;
                }
            }
            
                
            if(purchaseOrderDetaillastsel !== -1) {
                $('#purchaseOrderDetailInput_grid').jqGrid("saveRow",purchaseOrderDetaillastsel); 
            }
                
            if(purchaseOrderDetailAdditionallastsel !== -1) {
                $('#purchaseOrderAdditionalFeeInput_grid').jqGrid("saveRow",purchaseOrderDetailAdditionallastsel); 
            }
                
            if(purchaseOrderDetailItemDeliverylastsel !== -1) {
                $('#purchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderDetailItemDeliverylastsel); 
            }
            
            flagIsConfirmPOD=true;    
            $("#btnPOItemDetail").css("display", "none");
            $("#btnAdditionalFeeDetail").css("display", "none");
            $("#btnUnConfirmPurchaseOrderPurchaseRequest").css("display", "none");
            $("#btnUnConfirmPurchaseOrderDetail").css("display", "block");
            $("#btnConfirmPurchaseOrderDetail").css("display", "none");
            $('#purchaseOrderDetailTable').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#PurchaseOrderItemDeliveryDate').unblock();
            loadItemDeliveryDate();
            
        }); 
        
        $("#btnUnConfirmPurchaseOrderDetail").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');
            var rows = jQuery("#purchaseOrderSubItemInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagIsConfirmPOD=false;
                $("#btnPOItemDetail").css("display", "block");
                $("#btnAdditionalFeeDetail").css("display", "block");
                $("#btnUnConfirmPurchaseOrderPurchaseRequest").css("display", "block");
                $("#btnConfirmPurchaseOrderDetail").css("display", "block");
                $("#btnUnConfirmPurchaseOrderDetail").css("display", "none");
                $('#purchaseOrderDetailTable').unblock();
                $('#PurchaseOrderItemDeliveryDate').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid('clearGridData');
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
                                flagIsConfirmPOD=false;
                                $("#btnPOItemDetail").css("display", "block");
                                $("#btnAdditionalFeeDetail").css("display", "block");
                                $("#btnUnConfirmPurchaseOrderPurchaseRequest").css("display", "block");
                                $("#btnConfirmPurchaseOrderDetail").css("display", "block");
                                $("#btnUnConfirmPurchaseOrderDetail").css("display", "none");
                                $('#purchaseOrderDetailTable').unblock();
                                $('#PurchaseOrderItemDeliveryDate').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#purchaseOrderItemDeliveryInput_grid").jqGrid('clearGridData');
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
        
        $('#btnPurchaseOrderCopyFromDetail').click(function(ev) {
            
            $("#purchaseOrderItemDeliveryInput_grid").jqGrid('clearGridData');
            
            if(purchaseOrderDetaillastsel !== -1) {
                $('#purchaseOrderDetailInput_grid').jqGrid("saveRow",purchaseOrderDetaillastsel); 
            }
            
            var ids = jQuery("#purchaseOrderDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#purchaseOrderDetailInput_grid").jqGrid('getRowData',ids[i]);
                var defRow = {
                    purchaseOrderItemDeliveryDelete                         : "delete",
                    purchaseOrderItemDeliverySearchItemMaterial             : "...",
                    purchaseOrderItemDeliveryItemMaterialCode               : data.purchaseOrderDetailItemMaterialCode,
                    purchaseOrderItemDeliveryItemMaterialName               : data.purchaseOrderDetailItemMaterialName,
                    purchaseOrderItemDeliveryQuantity                       : data.purchaseOrderDetailQuantity
                };
                purchaseOrderDetailItemDeliveryRowId++;
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid("addRowData", purchaseOrderDetailItemDeliveryRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid('setRowData',purchaseOrderDetailItemDeliveryRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnPurchaseOrderDeliveryDateSet').click(function(ev) {
            if(purchaseOrderDetailItemDeliverylastsel !== -1) {
                $('#purchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderDetailItemDeliverylastsel); 
            }
            
            var deliveryDate=$("#purchaseOrderDeliveryDateSet").val();
            var ids = jQuery("#purchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs');
            for(var i=0;i< ids.length;i++){
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "purchaseOrderItemDeliveryDeliveryDate",deliveryDate);
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid("setCell",ids[i], "purchaseOrderItemDeliveryDeliveryDateTemp",deliveryDate);
            }
        });
        
        $('#btnPurchaseOrderSave').click(function(ev) {
            
                if(purchaseOrderDetailItemDeliverylastsel !== -1) {
                    $('#purchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderDetailItemDeliverylastsel); 
                }
            
                var listPurchaseOrderPurchaseRequestDetail = new Array();
                var ids = jQuery("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getDataIDs');

                if(ids.length===0){
                    alertEx("Data detail can not empty..!!! ");
                    $("#dlgLoading").dialog("close");
                    validationComma();
                    return;
                }
               
                for(var i=0;i < ids.length;i++){
                    var data = $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getRowData',ids[i]);
                    
                    var purchaseOrderPurchaseRequestDetail = {
                        branch                      : { code : data.purchaseOrderPurchaseRequestDetailBranchCode },
                        purchaseRequestCode         : data.purchaseOrderPurchaseRequestDetailCode,
                        purchaseRequestType         : data.purchaseOrderPurchaseRequestDetailDocumentType
                    };
                    listPurchaseOrderPurchaseRequestDetail[i] = purchaseOrderPurchaseRequestDetail;
                }
                
                var listPurchaseOrderDetail = new Array();
                var idj = jQuery("#purchaseOrderDetailInput_grid").jqGrid('getDataIDs');

                if(idj.length===0){
                    alertEx("Data detail can not empty..!!! ");
                    $("#dlgLoading").dialog("close");
                    validationComma();
                    return;
                }
               
                for(var j=0;j<idj.length;j++){
                    var data = $("#purchaseOrderDetailInput_grid").jqGrid('getRowData',idj[j]);
                    
                    var purchaseOrderDetail = {
                        purchaseRequestCode             :  data.purchaseOrderDetailPurchaseRequestCode,
                        purchaseRequestDetailCode       :  data.purchaseOrderDetailPurchaseRequestDetailCode,
                        itemMaterial                    : { code : data.purchaseOrderDetailItemMaterialCode},
                        itemAlias                       : data.purchaseOrderDetailItemAlias,
                        remark                          : data.purchaseOrderDetailRemark,
                        quantity                        : data.purchaseOrderDetailQuantity,
                        price                           : data.purchaseOrderDetailPrice,
                        discountPercent                 : data.purchaseOrderDetailDiscPercent,
                        discountAmount                  : data.purchaseOrderDetailDiscAmount,
                        nettPrice                       : data.purchaseOrderDetailNettPrice,
                        totalAmount                     : data.purchaseOrderDetailTotalPrice
                    };
                    listPurchaseOrderDetail[j] = purchaseOrderDetail;
                }
                
                var listPurchaseOrderAdditionalFee = new Array();
                var idl = jQuery("#purchaseOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
                
                for(var l=0;l < idl.length;l++){
                    var data = $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('getRowData',idl[l]);
                    
                    var purchaseOrderAdditionalFee ={
                        additionalFee           : {code : data.purchaseOrderAdditionalFeeCode},
                        unitOfMeasure           : {code : data.purchaseOrderAdditionalFeeUnitOfMeasureCode},
                        remark                  : data.purchaseOrderAdditionalFeeRemark,
                        quantity                : data.purchaseOrderAdditionalFeeQuantity,
                        price                   : data.purchaseOrderAdditionalFeePrice,
                        total                   : data.purchaseOrderAdditionalFeeTotal
                    };
                    listPurchaseOrderAdditionalFee[l] = purchaseOrderAdditionalFee;
                }
                
                var listPurchaseOrderItemDeliveryDate = new Array();
                var idm = jQuery("#purchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs');

                if(idm.length===0){
                    alertEx("Data detail can not empty..!!! ");
                    $("#dlgLoading").dialog("close");
                    validationComma();
                    return;
                }
                
                for(var m=0;m < idm.length;m++){
                    var data = $("#purchaseOrderItemDeliveryInput_grid").jqGrid('getRowData',idm[m]);
                    
                    var deliveryDate = data.purchaseOrderItemDeliveryDeliveryDate.split('/');
                    var deliveryDateNew = deliveryDate[1]+"/"+deliveryDate[0]+"/"+deliveryDate[2];
                    
                    var purchaseOrderItemDeliveryDate ={
                        itemMaterial            : {code : data.purchaseOrderItemDeliveryItemMaterialCode},
                        quantity                : data.purchaseOrderItemDeliveryQuantity,
                        deliveryDate            : deliveryDateNew
                    };
                    listPurchaseOrderItemDeliveryDate[m] = purchaseOrderItemDeliveryDate;
                }
                
                formatDatePurchaseOrder();
                unFormatNumericPO();
                validationComma();
                
                var url="purchasing/purchase-order-save";
                var params = $("#frmPurchaseOrderInput").serialize();
                params += "&listPurchaseOrderPurchaseRequestDetailJSON=" + $.toJSON(listPurchaseOrderPurchaseRequestDetail);
                params += "&listPurchaseOrderDetailJSON=" + $.toJSON(listPurchaseOrderDetail);
                params += "&listPurchaseOrderAdditionalFeeJSON=" + $.toJSON(listPurchaseOrderAdditionalFee);
                params += "&listPurchaseOrderItemDeliveryDateJSON=" + $.toJSON(listPurchaseOrderItemDeliveryDate);
                
                $.post(url, params, function(data) {
                    closeLoading();
                    if (data.error) {
                        formatDatePurchaseOrder();
                        unFormatNumericPO();
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
                                            var params = "enumPurchaseOrderActivity=NEW";
                                            var url = "purchasing/purchase-order-input";
                                            pageLoad(url, params, "#tabmnuPURCHASE_ORDER");
                                        }
                                    },
                                    {
                                        text : "No",
                                        click : function() {
                                            $(this).dialog("close");
                                            params = "";
                                            var url = "purchasing/purchase-order";
                                            pageLoad(url, params, "#tabmnuPURCHASE_ORDER");
                                        }
                                    }]
                        });
                });
            
        });
        
        $('#btnPurchaseOrderCancel').click(function(ev) {
            var url = "purchasing/purchase-order";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER"); 
        });
        
        $('#btnPurchaseOrderItemDelieryAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#purchaseOrderItemDeliveryAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    purchaseOrderItemDeliveryDelete                 : "delete",
                    purchaseOrderItemDeliverySearchItemMaterial     : "..."
                };
                purchaseOrderDetailItemDeliveryRowId++;
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid("addRowData", purchaseOrderDetailItemDeliveryRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid('setRowData',purchaseOrderDetailItemDeliveryRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#purchaseOrder_btnBillTo').click(function(ev) {
            window.open("./pages/search/search-purchase-destination.jsp?iddoc=purchaseOrder&idsubdoc=billTo&billTo=TRUE","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#purchaseOrder_btnShipTo').click(function(ev) {
            window.open("./pages/search/search-purchase-destination.jsp?iddoc=purchaseOrder&idsubdoc=shipTo&shipTo=TRUE","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#purchaseOrder_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=purchaseOrder&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#purchaseOrder_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=purchaseOrder&idsubdoc=currency","Search", "width=600, height=500");
        });

        $('#purchaseOrder_btnVendor').click(function(ev) {
            window.open("./pages/search/search-vendor.jsp?iddoc=purchaseOrder&idsubdoc=vendor","Search", "width=600, height=500");
        });
        
        $('#purchaseOrder_btnDiscountCOA').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=purchaseOrder&idsubdoc=discountChartOfAccount","Search", "scrollbars=1,width=600, height=500");
        });

        $('#purchaseOrder_btnOtherFeeCOA').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=purchaseOrder&idsubdoc=otherFeeChartOfAccount","Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnPOPRQDetail').click(function(ev) {
            window.open("./pages/search/search-purchase-request.jsp?iddoc=purchaseOrderPurchaseRequestDetail&type=grid&rowLast="+purchaseOrderPurchaseRequestRowId+"&firstDate="+$("#purchaseOrderDateFirstSession").val()+"&lastDate="+$("#purchaseOrderDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnPOItemDetail').click(function(ev) {
            let vendor = txtPurchaseOrderVendorCode.val();
            window.open("./pages/search/search-item-material-vendor.jsp?iddoc=purchaseOrderDetail&type=grid&vendorCode="+vendor+"&rowLast="+purchaseOrderDetailRowId,"Search", "width=600, height=500");   
        });
        
        $("#btnAdditionalFeeDetail").click(function(){
            window.open("./pages/search/search-additional-fee-purchase.jsp?iddoc=purchaseOrderAdditionalFee&type=grid","Search", "width=600, height=500");
        });

    });
        
    function loadImportLocal(localImport){
        if (localImport==='LOCAL'){
             $('#purchaseOrderVendorLocalImportStatusRadLocal').prop('checked',true);
             $('#purchaseOrderVendorLocalImportStatusRadImport').prop('disabled',true);
             $("#purchaseOrder\\.vendor\\.localImport").val("LOCAL");
        }
        else{
            $('#purchaseOrderVendorLocalImportStatusRadImport').prop('checked',true);
            $('#purchaseOrderVendorLocalImportStatusRadLocal').prop('disabled',true);
            $("#purchaseOrder\\.vendor\\.localImport").val("IMPORT");
        }
    }
    
    function enabledDisabledPenaltyPercent(percentType){
        switch(percentType){
            case "YES":   
                $("#purchaseOrder\\.penaltyPercent").attr('readonly',false);
                $("#purchaseOrder\\.penaltyPercent").focus();
                $("#purchaseOrder\\.maximumPenaltyPercent").attr('readonly',false);
                
                $('#purchaseOrderPenaltyStatusRadYES').prop('checked',true);
//                $("#purchaseOrderPenaltyStatusRadNO").prop('disabled',true);
                
                var maximumPenaltyPercent = $("#purchaseOrder\\.maximumPenaltyPercent").val();
                maximumPenaltyPercent = parseFloat(maximumPenaltyPercent);
                var penaltyPercent = $("#purchaseOrder\\.penaltyPercent").val();
                penaltyPercent = parseFloat(penaltyPercent);
                
                $("#purchaseOrder\\.maximumPenaltyPercent").val(formatNumber(maximumPenaltyPercent,2));
                $("#purchaseOrder\\.penaltyPercent").val(formatNumber(penaltyPercent,2));

                break;
            case "NO":
                $("#purchaseOrder\\.penaltyPercent").attr('readonly',true);
                $("#purchaseOrder\\.maximumPenaltyPercent").attr('readonly',true);
                
                $('#purchaseOrderPenaltyStatusRadNO').prop('checked',true);
//                $("#purchaseOrderPenaltyStatusRadYES").prop('disabled',true);
                
                $("#purchaseOrder\\.maximumPenaltyPercent").val("0.00");
                $("#purchaseOrder\\.penaltyPercent").val("0.00");
                break;
        }
    }
    
    function loadPurchaseRequestDetail(){
        if($("#enumPurchaseOrderActivity").val()==="NEW"){
            return;
        }                
        
        var url = "purchase/purchase-order-purchase-request-data";
        var params = "purchaseOrder.code="+$("#purchaseOrder\\.code").val();   
        
        purchaseOrderPurchaseRequestRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderPurchaseRequestDetail.length; i++) {
                purchaseOrderPurchaseRequestRowId++;
                var purchaseRequestTransactionDate=formatDateRemoveT(data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestTransactionDate, true);
                
                $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid("addRowData", purchaseOrderPurchaseRequestRowId, data.listPurchaseOrderPurchaseRequestDetail[i]);
                $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('setRowData',purchaseOrderPurchaseRequestRowId,{
                    purchaseOrderPurchaseRequestDetailDelete                    : "delete",
                    purchaseOrderPurchaseRequestDetailCode                      : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestCode,
                    purchaseOrderPurchaseRequestDetailTransactionDate           : purchaseRequestTransactionDate,
                    purchaseOrderPurchaseRequestDetailDocumentType              : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestType,
                    purchaseOrderPurchaseRequestDetailProductionPlanningCode    : data.listPurchaseOrderPurchaseRequestDetail[i].ppoCode,
                    purchaseOrderPurchaseRequestDetailBranchCode                : data.listPurchaseOrderPurchaseRequestDetail[i].branchCode,
                    purchaseOrderPurchaseRequestDetailBranchName                : data.listPurchaseOrderPurchaseRequestDetail[i].branchName,
                    purchaseOrderPurchaseRequestDetailRequestBy                 : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRequestBy,
                    purchaseOrderPurchaseRequestDetailRemark                    : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRemark
  
                });
            }
        });
        closeLoading();
    }
    
    function addRowDataMultiSelectedPoJnPr(lastRowId,defRow){
        purchaseOrderPurchaseRequestRowId = lastRowId;
        
        $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
        $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('setRowData',lastRowId,{
            purchaseOrderPurchaseRequestDetailDelete                        : defRow.purchaseOrderPurchaseRequestDetailDelete,
            purchaseOrderPurchaseRequestDetailCode                          : defRow.purchaseOrderPurchaseRequestDetailCode,
            purchaseOrderPurchaseRequestDetailTransactionDate               : defRow.purchaseOrderPurchaseRequestDetailTransactionDate,
            purchaseOrderPurchaseRequestDetailDocumentType                  : defRow.purchaseOrderPurchaseRequestDetailDocumentType,
            purchaseOrderPurchaseRequestDetailProductionPlanningCode        : defRow.purchaseOrderPurchaseRequestDetailProductionPlanningCode,
            purchaseOrderPurchaseRequestDetailBranchCode                    : defRow.purchaseOrderPurchaseRequestDetailBranchCode,
            purchaseOrderPurchaseRequestDetailBranchName                    : defRow.purchaseOrderPurchaseRequestDetailBranchName,
            purchaseOrderPurchaseRequestDetailRequestBy                     : defRow.purchaseOrderPurchaseRequestDetailRequestBy,
            purchaseOrderPurchaseRequestDetailRefNo                         : defRow.purchaseOrderPurchaseRequestDetailRefNo,
            purchaseOrderPurchaseRequestDetailRemark                        : defRow.purchaseOrderPurchaseRequestDetailRemark
        });
        setHeightGridPurchaseOrder();
    }
    
    function addRowDataMultiSelectedItemPoDetail(lastRowId,defRow){
        
        purchaseOrderDetailRowId = lastRowId;
        
            $("#purchaseOrderDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#purchaseOrderDetailInput_grid").jqGrid('setRowData',lastRowId,{
                purchaseOrderDetailDelete_grid                    : defRow.purchaseOrderDetailDelete_grid,
                purchaseOrderDetailItemMaterialCode               : defRow.purchaseOrderDetailItemMaterialCode,
                purchaseOrderDetailItemMaterialName               : defRow.purchaseOrderDetailItemMaterialName,
                purchaseOrderDetailUnitOfMeasureCode              : defRow.purchaseOrderDetailUnitOfMeasureCode,
                purchaseOrderDetailUnitOfMeasureName              : defRow.purchaseOrderDetailUnitOfMeasureName
                
            });
            
    }
    
    function addRowDataMultiSelectedAdditionalFeePurchase(lastRowId,defRow){
        
        purchaseOrderDetailAdditionalRowId = lastRowId;
        
            $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('setRowData',lastRowId,{
                imrItemMaterialRequestBookedDelete             : defRow.imrItemMaterialRequestBookedDelete,
                imrItemMaterialRequestBookedCode               : defRow.imrItemMaterialRequestBookedCode,
                imrItemMaterialRequestBookedName               : defRow.imrItemMaterialRequestBookedName,
                imrItemMaterialRequestBookedOnHandStock        : defRow.imrItemMaterialRequestBookedOnHandStock,
                imrItemMaterialRequestBookedQuantity           : defRow.imrItemMaterialRequestBookedQuantity,
                imrItemMaterialRequestBookedAvailable          : (defRow.imrItemMaterialRequestBookedOnHandStock - defRow.imrItemMaterialRequestBookedQuantity),
                imrItemMaterialRequestBookedUnitOfMeasureCode  : defRow.imrItemMaterialRequestBookedUnitOfMeasureCode,
                imrItemMaterialRequestBookedUnitOfMeasureName  : defRow.imrItemMaterialRequestBookedUnitOfMeasureName
                
            });
            
    }
    
    // function Grid Detail
    function setHeightGridPurchaseOrder(){
        var ids = jQuery("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#purchaseOrderPurchaseRequestDetailInput_grid"+" tr").eq(1).height();
            $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function loadPoJnPrItemDetail(){
        var arrPurchaseOrderNo=new Array();
        var ids = jQuery("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getDataIDs'); 
        for(var x=0;x<ids.length;x++){
            var data = $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getRowData',ids[x]);
            arrPurchaseOrderNo.push(data.purchaseOrderPurchaseRequestDetailCode);
        }
        
        var url = "purchasing/purchase-request-item-material-request-detail-data"; 
        var params = "arrPurchaseOrderNo=" + arrPurchaseOrderNo;
        
        purchaseOrderPurchaseRequestDetailRowId = 0;
        $.getJSON(url, params, function(data) {
            for (var i=0; i<data.listPurchaseRequestNonItemMaterialRequestDetail.length; i++) {
                purchaseOrderPurchaseRequestDetailRowId++;
                $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid("addRowData", purchaseOrderPurchaseRequestDetailRowId, data.listPurchaseRequestNonItemMaterialRequestDetail[i]);
                $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('setRowData',purchaseOrderPurchaseRequestDetailRowId,{
                    purchaseOrderPurchaseRequestItemDetailPurchaseRequestNo                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].headerCode,
                    purchaseOrderPurchaseRequestItemDetailPurchaseRequestDetailNo           : data.listPurchaseRequestNonItemMaterialRequestDetail[i].code,
                    purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialCode   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialCode,
                    purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialName   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialName,
                    purchaseOrderPurchaseRequestItemDetailQuantity                          : data.listPurchaseRequestNonItemMaterialRequestDetail[i].quantity,
                    purchaseOrderPurchaseRequestItemDetailUnitOfMeasureCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseOrderPurchaseRequestItemDetailUnitOfMeasureName                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseOrderPurchaseRequestItemDetailPurchaseOrderCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].poCode,
                    purchaseOrderPurchaseRequestItemDetailItemJnVendorCode                  : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialJnVendor,
                    purchaseOrderPurchaseRequestItemDetailVendorCode                        : data.listPurchaseRequestNonItemMaterialRequestDetail[i].vendorCode
                });
            }
        });
    }
    
    function copyItemToPOD(){
        var ids = jQuery("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('getDataIDs'); 
        for(var i=0; i<ids.length; i++){
            var data = $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            if(data.purchaseOrderPurchaseRequestItemDetailPurchaseOrderCode !== ""){
                continue;
            }else if(data.purchaseOrderPurchaseRequestItemDetailVendorCode === "" || data.purchaseOrderPurchaseRequestItemDetailVendorCode !== txtPurchaseOrderVendorCode.val()){
                continue;
            }else{
                var defRow = {
                    purchaseOrderDetailPurchaseRequestCode       : data.purchaseOrderPurchaseRequestItemDetailPurchaseRequestNo,
                    purchaseOrderDetailPurchaseRequestDetailCode : data.purchaseOrderPurchaseRequestItemDetailPurchaseRequestDetailNo,
                    purchaseOrderDetailItemMaterialCode          : data.purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialCode,
                    purchaseOrderDetailItemMaterialName          : data.purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialName,
                    purchaseOrderDetailItemAlias                 : data.purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialName,
                    purchaseOrderDetailUnitOfMeasureCode         : data.purchaseOrderPurchaseRequestItemDetailUnitOfMeasureCode,
                    purchaseOrderDetailUnitOfMeasureName         : data.purchaseOrderPurchaseRequestItemDetailUnitOfMeasureName,
                    purchaseOrderDetailQuantity                  : data.purchaseOrderPurchaseRequestItemDetailQuantity
                };
                
                purchaseOrderDetailRowId++;
                $("#purchaseOrderDetailInput_grid").jqGrid("addRowData", purchaseOrderDetailRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#purchaseOrderDetailInput_grid").jqGrid('setRowData',purchaseOrderDetailRowId,{Buttons:be});
            }
        }   
    }
    
    function loadPODetail(){
        if($("#enumPurchaseOrderActivity").val()==="NEW"){
            return;
        }                
        
        var arrayCodeDetail = new Array();
        var ids = $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('getDataIDs');
        for(var i=0; i<ids.length; i++){
            var data = $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('getRowData', ids[i]);
            arrayCodeDetail.push(data.purchaseOrderPurchaseRequestItemDetailPurchaseRequestDetailNo);
        }
        
        var url = "purchase/purchase-order-detail-data";
        var params = "purchaseOrder.code="+$("#purchaseOrder\\.code").val();
            params += "&arrayCodeDetail=" +arrayCodeDetail;
        
        purchaseOrderDetailRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderDetail.length; i++) {
                purchaseOrderDetailRowId++;
                
                $("#purchaseOrderDetailInput_grid").jqGrid("addRowData", purchaseOrderDetailRowId, data.listPurchaseOrderDetail[i]);
                $("#purchaseOrderDetailInput_grid").jqGrid('setRowData', purchaseOrderDetailRowId,{
                    purchaseOrderDetailDetailCode                       : data.listPurchaseOrderDetail[i].code,
                    purchaseOrderDetailPurchaseRequestCode              : data.listPurchaseOrderDetail[i].purchaseRequestCode,
                    purchaseOrderDetailPurchaseRequestDetailCode        : data.listPurchaseOrderDetail[i].purchaseRequestDetailCode,
                    purchaseOrderDetailItemMaterialCode                 : data.listPurchaseOrderDetail[i].itemMaterialCode,
                    purchaseOrderDetailItemMaterialName                 : data.listPurchaseOrderDetail[i].itemMaterialName,
                    purchaseOrderDetailItemAlias                        : data.listPurchaseOrderDetail[i].itemAlias,
                    purchaseOrderDetailRemark                           : data.listPurchaseOrderDetail[i].remark,
                    purchaseOrderDetailQuantity                         : data.listPurchaseOrderDetail[i].quantity,
                    purchaseOrderDetailUnitOfMeasureCode                : data.listPurchaseOrderDetail[i].unitOfMeasureCode,
                    purchaseOrderDetailUnitOfMeasureName                : data.listPurchaseOrderDetail[i].unitOfMeasureName,
                    purchaseOrderDetailPrice                            : data.listPurchaseOrderDetail[i].price,
                    purchaseOrderDetailDiscPercent                      : data.listPurchaseOrderDetail[i].discountPercent,
                    purchaseOrderDetailDiscAmount                       : data.listPurchaseOrderDetail[i].discountAmount,
                    purchaseOrderDetailNettPrice                        : data.listPurchaseOrderDetail[i].nettPrice,
                    purchaseOrderDetailTotalPrice                       : data.listPurchaseOrderDetail[i].totalAmount
  
                });
            }
        });
        closeLoading();
    }
    
    function loadPOAdditionalFee(){
        if($("#enumPurchaseOrderActivity").val()==="NEW"){
            return;
        }                
        
        var url = "purchase/purchase-order-additional-fee-data";
        var params = "purchaseOrder.code="+$("#purchaseOrder\\.code").val();   
        
        purchaseOrderDetailAdditionalRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderAdditionalFee.length; i++) {
                purchaseOrderDetailAdditionalRowId++;
                
                $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("addRowData", purchaseOrderDetailAdditionalRowId, data.listPurchaseOrderAdditionalFee[i]);
                $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('setRowData',purchaseOrderDetailAdditionalRowId,{
                    purchaseOrderAdditionalFeeDelete                        : "delete",
                    purchaseOrderDetailAdditionalFeeCode                    : data.listPurchaseOrderAdditionalFee[i].code,
                    purchaseOrderAdditionalFeeCode                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeCode,
                    purchaseOrderAdditionalFeeName                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeName,
                    purchaseOrderAdditionalFeePurchaseChartOfAccountCode    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountCode,
                    purchaseOrderAdditionalFeePurchaseChartOfAccountName    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountName,
                    purchaseOrderAdditionalFeeRemark                        : data.listPurchaseOrderAdditionalFee[i].remark,
                    purchaseOrderAdditionalFeeQuantity                      : data.listPurchaseOrderAdditionalFee[i].quantity,
                    purchaseOrderAdditionalFeeUnitOfMeasureSearch           : "...",
                    purchaseOrderAdditionalFeeUnitOfMeasureCode             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureCode,
                    purchaseOrderAdditionalFeeUnitOfMeasureName             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureName,
                    purchaseOrderAdditionalFeePrice                         : data.listPurchaseOrderAdditionalFee[i].price,
                    purchaseOrderAdditionalFeeTotal                         : data.listPurchaseOrderAdditionalFee[i].total
  
                });
            }
        });
        closeLoading();
    }
    
    function loadItemDeliveryDate(){
         if($("#enumPurchaseOrderActivity").val()==="NEW"){
            return;
        }                
        
        var url = "purchase/purchase-order-item-delivery-date-data";
        var params = "purchaseOrder.code="+$("#purchaseOrder\\.code").val();   
        
        purchaseOrderDetailItemDeliveryRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderItemDeliveryDate.length; i++) {
                purchaseOrderDetailItemDeliveryRowId++;
                var deliveryDate=formatDateRemoveT(data.listPurchaseOrderItemDeliveryDate[i].deliveryDate, false);
                
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid("addRowData", purchaseOrderDetailItemDeliveryRowId, data.listPurchaseOrderItemDeliveryDate[i]);
                $("#purchaseOrderItemDeliveryInput_grid").jqGrid('setRowData',purchaseOrderDetailItemDeliveryRowId,{
                    purchaseOrderItemDeliveryDelete                         : "delete",
                    purchaseOrderItemDeliverySearchItemMaterial             : "...",
                    purchaseOrderItemDeliveryItemMaterialCode               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialCode,
                    purchaseOrderItemDeliveryItemMaterialName               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialName,
                    purchaseOrderItemDeliveryQuantity                       : data.listPurchaseOrderItemDeliveryDate[i].quantity,
                    purchaseOrderItemDeliveryDeliveryDate                   : deliveryDate
                });
            }
        });
        closeLoading();
    }

    function calculatePurchaseOrderDetailPercent() {
        
        var selectedRowID = $("#purchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#purchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = purchaseOrderDetailRowId;
        }
        
        let str = $("#" + selectedRowID + "_purchaseOrderDetailQuantity").val(); 
        let str2 = $("#" + selectedRowID + "_purchaseOrderDetailPrice").val(); 
        let str3 = $("#" + selectedRowID + "_purchaseOrderDetailDiscPercent").val();  
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderDetailQuantity").val("");
            return;
        }
        
        if (isNaN(str2)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderDetailPrice").val("");
            return;
        }
        
        if (isNaN(str3)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderDetailDiscPercent").val("");
            return;
        }
        
        var qty = $("#" + selectedRowID + "_purchaseOrderDetailQuantity").val();
        var price = $("#" + selectedRowID + "_purchaseOrderDetailPrice").val();
        var discPercent = $("#" + selectedRowID + "_purchaseOrderDetailDiscPercent").val();
        if (discPercent === 0){
            var nettAmount = parseFloat(qty) * parseFloat(price);
        }else{
            var discAmount = (parseFloat(price)*parseFloat(discPercent)/100); 

            var nettAmount = parseFloat(price) - parseFloat(discAmount);
            var amount = (parseFloat(qty) * parseFloat(nettAmount));
            
            $("#" + selectedRowID + "_purchaseOrderDetailDiscAmount").val(discAmount);
            $("#" + selectedRowID + "_purchaseOrderDetailDiscPercent").val(discPercent);
        }
        
        $("#purchaseOrderDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderDetailNettPrice", nettAmount);
        $("#purchaseOrderDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderDetailTotalPrice", amount);

        calculateHeader();
    }   
    function calculatePurchaseOrderDetailAmount() {
        var selectedRowID = $("#purchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#purchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = purchaseOrderDetailRowId;
        }
        
        let str = $("#" + selectedRowID + "_purchaseOrderDetailQuantity").val(); 
        let str2 = $("#" + selectedRowID + "_purchaseOrderDetailPrice").val(); 
        let str3 = $("#" + selectedRowID + "_purchaseOrderDetailDiscAmount").val(); 
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderDetailQuantity").val("");
            return;
        }
        
        if (isNaN(str2)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderDetailPrice").val("");
            return;
        }
        
        if (isNaN(str3)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderDetailDiscAmount").val("");
            return;
        }
        
        var qty = $("#" + selectedRowID + "_purchaseOrderDetailQuantity").val();
        var price = $("#" + selectedRowID + "_purchaseOrderDetailPrice").val();
        var discAmount = $("#" + selectedRowID + "_purchaseOrderDetailDiscAmount").val();
        
        if(discAmount === 0){
            var nettAmount = parseFloat(qty) * parseFloat(price);
        }else{
            
            var nettAmount = parseFloat(price) - parseFloat(discAmount);
            var amount = (parseFloat(qty) * parseFloat(nettAmount));
            var discPercent=(parseFloat(discAmount)/parseFloat(price))*100;
            
            $("#" + selectedRowID + "_purchaseOrderDetailDiscAmount").val(discAmount);
            $("#" + selectedRowID + "_purchaseOrderDetailDiscPercent").val(discPercent);
        }
        $("#purchaseOrderDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderDetailNettPrice", nettAmount);
        $("#purchaseOrderDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderDetailTotalPrice", amount);

        calculateHeader();
    }   

    function calculationAdditional(){
        var selectedRowID = $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = purchaseOrderDetailAdditionalRowId;
        }
        var qty = $("#" + selectedRowID + "_purchaseOrderAdditionalFeeQuantity").val();
        var price = $("#" + selectedRowID + "_purchaseOrderAdditionalFeePrice").val();
        
        var totalAmount = parseFloat(qty) * parseFloat(price);
        $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderAdditionalFeeTotal", totalAmount);
        
        calculateHeader();
    }

    function calculateHeader() {
        var totalTransactionPOD = 0;
        var totalTransactionAdditional = 0;
        var ids = jQuery("#purchaseOrderDetailInput_grid").jqGrid('getDataIDs');
            for(var i=0;i < ids.length;i++) {
                var data = $("#purchaseOrderDetailInput_grid").jqGrid('getRowData',ids[i]);
                totalTransactionPOD += parseFloat(data.purchaseOrderDetailTotalPrice);
            }

        var idj = jQuery("#purchaseOrderAdditionalFeeInput_grid").jqGrid('getDataIDs');
            for(var j=0;j < idj.length;j++) {
                var data_add = $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('getRowData',idj[j]);
                totalTransactionAdditional += parseFloat(data_add.purchaseOrderAdditionalFeeTotal);
            }

        var totalTransaction = totalTransactionPOD + totalTransactionAdditional;
            txtPurchaseOrderTotalTransactionAmount.val(formatNumber(totalTransaction, 2));

        var amount = txtPurchaseOrderTotalTransactionAmount.val().replace(/,/g, "");
        var disc = (amount*txtPurchaseOrderDiscountPercent.val())/100;
        var otherFeeAmount=removeCommas(txtPurchaseOrderOtherFeeAmount.val());
        var totalAmount = (amount-disc);
        var tax = (totalAmount*txtPurchaseOrderVATPercent.val())/100;
        var grandTotal =(parseFloat(totalAmount)+parseFloat(tax)+ parseFloat(otherFeeAmount));

        txtPurchaseOrderTaxBaseSubTotalAmount.val(formatNumber(totalAmount,2));
        txtPurchaseOrderDiscountAmount.val(formatNumber(disc,2));
        txtPurchaseOrderVATAmount.val(formatNumber(tax,2));           
        txtPurchaseOrderGrandTotalAmount.val(formatNumber(grandTotal,2));
    }

    $("#purchaseOrder\\.vatPercent").keyup(function (e){
        calculateHeader();  
    });
    $("#purchaseOrder\\.discountPercent").keyup(function (e){
        calculateHeader();  
    });
    $("#purchaseOrder\\.otherFeeAmount").keyup(function (e){
        calculateHeader();
    });
    
    function clearAmountPurchaseOrderHeader(){
        txtPurchaseOrderTotalTransactionAmount.val("0.00");
        txtPurchaseOrderDiscountPercent.val("0.00");
        txtPurchaseOrderDiscountAmount.val("0.00");
        txtPurchaseOrderTaxBaseSubTotalAmount.val("0.00");
        txtPurchaseOrderVATPercent.val("0.00");
        txtPurchaseOrderVATAmount.val("0.00");
        txtPurchaseOrderOtherFeeAmount.val("0.00");
        txtPurchaseOrderGrandTotalAmount.val("0.00");
    }
    
    function purchaseOrderAdditionalFeeUnitOfMeasureSearchInputGrid_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=purchaseOrderAdditionalFee&type=grid","Search", "width=600, height=500");
    }
    
    function changeUnitOfMeasure(){
        var selectedRowID = $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("getGridParam", "selrow");
        var uomCode = $("#" + selectedRowID + "_purchaseOrderAdditionalFeeUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + uomCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";
        $.post(url, params, function(result){
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"purchaseOrderAdditionalFeeUnitOfMeasureCode",data.unitOfMeasureTemp.code);
                $("#purchaseOrderAdditionalFeeInput_grid").jqGrid("setCell", selectedRowID,"purchaseOrderAdditionalFeeUnitOfMeasureName",data.unitOfMeasureTemp.name);
            }
            else{
                $("#" + selectedRowID + "_purchaseOrderAdditionalFeeUnitOfMeasureCode").val("");
                $("#" + selectedRowID + "_purchaseOrderAdditionalFeeUnitOfMeasureName").val("");
                alert("Unit Of Measure Not Found","");
            }
        });
            
    }
    
    function purchaseOrderPurchaseRequestDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('getGridParam','selrow');
        var purchaseRequestCode = $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid("getRowData", selectDetailRowId);
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        var idi = jQuery("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('getDataIDs'); 
        for(var i=0;i < idi.length ;i++){
            var data = $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('getRowData',idi[i]);
            if (data.purchaseOrderPurchaseRequestItemDetailPurchaseRequestNo === purchaseRequestCode.purchaseOrderPurchaseRequestDetailCode){
                $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
                $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('delRowData',idi[i]);
            }
        }
        
        $("#purchaseOrderPurchaseRequestDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function purchaseOrderPurchaseRequestItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        $("#purchaseOrderPurchaseRequestItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function purchaseOrderDetailDelete_Grid_Delete_OnClick(){
        var selectedDetailRowId = $("#purchaseOrderDetailInput_grid").jqGrid("getGridParam", 'selrow');
        
        if(selectedDetailRowId === null){
            alertMessage("Please Select Row");
            return;
        }
        
         $("#purchaseOrderDetailInput_grid").jqGrid('delRowData', selectedDetailRowId);
         calculateHeader();
    }
    
    function purchaseOrderAdditionalFeeInput_grid_Delete_OnClick(){
        var selectDetailRowId = $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        $("#purchaseOrderAdditionalFeeInput_grid").jqGrid('delRowData',selectDetailRowId);   
        calculateHeader();
    }
    
    function purchaseOrderItemDeliveryInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#purchaseOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        $("#purchaseOrderItemDeliveryInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function purchaseOrderItemDeliveryInputGrid_SearchItemMaterial_OnClick(){   
        if($("#purchaseOrderItemDeliveryInput_grid").jqGrid('getDataIDs').length===0){
            {alertMessage("Grid Item Delivery Date Can't Be Empty!");
            return;}

        }

        if(purchaseOrderDetailItemDeliverylastsel !== -1) {
            $('#purchaseOrderItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderDetailItemDeliverylastsel);  
        }
            
        window.open("./pages/search/search-po-item-delivery.jsp?iddoc=purchaseOrderItemDelivery&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function validationComma(){

        var totalTransaction = txtPurchaseOrderTotalTransactionAmount.val().replace(/,/g, "");
        var discountPercent = txtPurchaseOrderDiscountPercent.val().replace(/,/g, "");
        var discountAmount = txtPurchaseOrderDiscountAmount.val().replace(/,/g, "");
        var taxBaseSubTotalAmount = txtPurchaseOrderTaxBaseSubTotalAmount.val().replace(/,/g, "");
        var VATAmount = txtPurchaseOrderVATAmount.val().replace(/,/g, "");
        var otherFee = txtPurchaseOrderOtherFeeAmount.val().replace(/,/g, "");
        var grandTotal = txtPurchaseOrderGrandTotalAmount.val().replace(/,/g, "");

        txtPurchaseOrderTotalTransactionAmount.val(totalTransaction);
        txtPurchaseOrderDiscountPercent.val(discountPercent);
        txtPurchaseOrderDiscountAmount.val(discountAmount);
        txtPurchaseOrderTaxBaseSubTotalAmount.val(taxBaseSubTotalAmount);
        txtPurchaseOrderVATAmount.val(VATAmount);
        txtPurchaseOrderOtherFeeAmount.val(otherFee);
        txtPurchaseOrderGrandTotalAmount.val(grandTotal);

    }
    
    function formatDatePurchaseOrder(){
        
        var transactionDateSplit=dtpPurchaseOrderTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpPurchaseOrderTransactionDate.val(transactionDate);
        
        var tDateSplit = $("#purchaseOrderTransactionDate").val().split('/');
        var tDate =tDateSplit[1]+"/"+tDateSplit[0]+"/"+tDateSplit[2];
        $("#purchaseOrderTransactionDate").val(tDate);
        
        var deliveryDateStartSplit=dtpPurchaseOrderDeliveryDateStart.val().split('/');
        var deliveryDateStart =deliveryDateStartSplit[1]+"/"+deliveryDateStartSplit[0]+"/"+deliveryDateStartSplit[2];
        dtpPurchaseOrderDeliveryDateStart.val(deliveryDateStart);
        $("#purchaseOrder\\.deliveryDateStartTemp").val(deliveryDateStart);
        
        var deliveryDateEndSplit=dtpPurchaseOrderDeliveryDateEnd.val().split('/');
        var deliveryDateEnd =deliveryDateEndSplit[1]+"/"+deliveryDateEndSplit[0]+"/"+deliveryDateEndSplit[2];
        dtpPurchaseOrderDeliveryDateEnd.val(deliveryDateEnd);
        $("#purchaseOrder\\.deliveryDateEndTemp").val(deliveryDateEnd);
        
        var createdDateSplit=$("#purchaseOrder\\.createdDate").val().split('/');
        var createdDate =createdDateSplit[1]+"/"+createdDateSplit[0]+"/"+createdDateSplit[2];
        $("#purchaseOrder\\.createdDate").val(createdDate);
        
        var deliveryDateSetSplit=$("#purchaseOrderDeliveryDateSet").val().split('/');
        var deliveryDateSet =deliveryDateSetSplit[1]+"/"+deliveryDateSetSplit[0]+"/"+deliveryDateSetSplit[2];
        $("#purchaseOrderDeliveryDateSet").val(deliveryDateSet);
        
    }
    
    function unFormatNumericPO(){ 
        var totalTransactionAmount = removeCommas(txtPurchaseOrderTotalTransactionAmount.val());
        var discountPercent =removeCommas(txtPurchaseOrderDiscountPercent.val());
        var discountAmount =removeCommas(txtPurchaseOrderDiscountAmount.val());
        var taxBaseSubTotalAmount =removeCommas(txtPurchaseOrderTaxBaseSubTotalAmount.val());
        var vatPercent = removeCommas(txtPurchaseOrderVATPercent.val());
        var vatAmount = removeCommas(txtPurchaseOrderVATAmount.val());
        var otherFee = removeCommas(txtPurchaseOrderOtherFeeAmount.val());
        var grandTotalAmount =removeCommas(txtPurchaseOrderGrandTotalAmount.val());
        
        var pinaltyPercent =removeCommas($("#purchaseOrder\\.penaltyPercent").val());
        var maximumPinaltyPercent =removeCommas($("#purchaseOrder\\.maximumPenaltyPercent").val());

        txtPurchaseOrderTotalTransactionAmount.val(totalTransactionAmount);
        txtPurchaseOrderDiscountPercent.val(discountPercent);
        txtPurchaseOrderDiscountAmount.val(discountAmount);
        txtPurchaseOrderTaxBaseSubTotalAmount.val(taxBaseSubTotalAmount);
        txtPurchaseOrderVATPercent.val(vatPercent);
        txtPurchaseOrderVATAmount.val(vatAmount);
        txtPurchaseOrderOtherFeeAmount.val(otherFee);
        txtPurchaseOrderGrandTotalAmount.val(grandTotalAmount);
        
        $("#purchaseOrder\\.penaltyPercent").val(pinaltyPercent);
        $("#purchaseOrder\\.maximumPenaltyPercent").val(maximumPinaltyPercent);
    }
    
    function onchangePurchaseOrderItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#purchaseOrderItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_purchaseOrderItemDeliveryDeliveryDate").val();
        
        $("#purchaseOrderItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "purchaseOrderItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    function alertEx(alert_message){
        var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>'+alert_message+'<span style="float:left; margin:0 20px 20px 0;">'+
                        '</span>' +
                            '<table>' +
                                '<tr>' +
                                    '<td></td>'+
                                '</tr>' +
                            '</table>' +
                    '</div>');
            //Open Dialog
            dynamicDialog.dialog({
                title : "Attention:",
                closeOnEscape: false,
                modal : true,
                width: 250,
                resizable: false,
                closeText: "hide",
                buttons : 
                    [{
                        text : "OK",
                        click : function() {
                            $(this).dialog("close");
                        },
                        keyPress: function (){
                            $(this).dialog("close");
                        }
                    }]
            });
    }
    
    function POTransactionDateOnChange(){
        if($("#enumPurchaseOrderActivity").val()!=="UPDATE"){
            $("#purchaseOrderTransactionDate").val(dtpPurchaseOrderTransactionDate.val());
        }
    }
    
    function formatNumericPO(){
        
        var totalTransactionAmount =parseFloat(txtPurchaseOrderTotalTransactionAmount.val());
        txtPurchaseOrderTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountAmount =parseFloat(txtPurchaseOrderDiscountAmount.val());
        txtPurchaseOrderDiscountAmount.val(formatNumber(discountAmount,2));
        var discountPercent =parseFloat(txtPurchaseOrderDiscountPercent.val());
        txtPurchaseOrderDiscountPercent.val(formatNumber(discountPercent,2));
        var taxBaseAmount =parseFloat(txtPurchaseOrderTaxBaseSubTotalAmount.val());
        txtPurchaseOrderTaxBaseSubTotalAmount.val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat(txtPurchaseOrderVATPercent.val());
        txtPurchaseOrderVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtPurchaseOrderVATAmount.val());
        txtPurchaseOrderVATAmount.val(formatNumber(vatAmount,2));
        var otherFee =parseFloat(txtPurchaseOrderOtherFeeAmount.val());
        txtPurchaseOrderOtherFeeAmount.val(formatNumber(otherFee,2));
        var grandTotalAmount =parseFloat(txtPurchaseOrderGrandTotalAmount.val());
        txtPurchaseOrderGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }  
    
    function handlers_input_purchase_order(){
        if(txtPurchaseOrderBranchCode.val()===""){
            handlersInput(txtPurchaseOrderBranchCode);
        }else{
            unHandlersInput(txtPurchaseOrderBranchCode);
        }
        if(txtPurchaseOrderPaymentTermCode.val()===""){
            handlersInput(txtPurchaseOrderPaymentTermCode);
        }else{
            unHandlersInput(txtPurchaseOrderPaymentTermCode);
        }
        if(txtPurchaseOrderCurrencyCode.val()===""){
            handlersInput(txtPurchaseOrderCurrencyCode);
        }else{
            unHandlersInput(txtPurchaseOrderCurrencyCode);
        }
        if(txtPurchaseOrderVendorCode.val()===""){
            handlersInput(txtPurchaseOrderVendorCode);
        }else{
            unHandlersInput(txtPurchaseOrderVendorCode);
        }
        if(txtPurchaseOrderBillToCode.val()===""){
            handlersInput(txtPurchaseOrderBillToCode);
        }else{
            unHandlersInput(txtPurchaseOrderBillToCode);
        }
        if(txtPurchaseOrderShipToCode.val()===""){
            handlersInput(txtPurchaseOrderShipToCode);
        }else{
            unHandlersInput(txtPurchaseOrderShipToCode);
        }
    }
        
</script>

<s:url id="remoteurlPurchaseOrderPurchaseRequestDetailInput" action="" />
<s:url id="remoteurlPurchaseOrderPurchaseRequestItemDetailInput" action="" />
<s:url id="remoteurlPurchaseOrderDetailInput" action="" />
<s:url id="remoteurlPurchaseOrderAdditionalInput" action="" />
<s:url id="remoteurlPurchaseOrderItemDeliveryInput" action="" />
<b>PURCHASE ORDER</b><span id="msgPurchaseOrderActivity"></span>
<hr>
<br class="spacer" />

<div id="purchaseOrderInput" class="content ui-widget">
    <s:form id="frmPurchaseOrderInput">
        <table cellpadding="2" cellspacing="2" id="headerPurchaseOrderInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>POD No *</B></td>
                            <td>
                                <s:textfield id="purchaseOrder.code" name="purchaseOrder.code" key="purchaseOrder.code" readonly="true" size="25"></s:textfield>    
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                txtPurchaseOrderBranchCode.change(function(ev) {

                                    if(txtPurchaseOrderBranchCode.val()===""){
                                        txtPurchaseOrderBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get";
                                    var params = "branch.code=" + txtPurchaseOrderBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtPurchaseOrderBranchCode.val(data.branchTemp.code);
                                            txtPurchaseOrderBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtPurchaseOrderBranchCode);
                                            txtPurchaseOrderBranchCode.val("");
                                            txtPurchaseOrderBranchName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="purchaseOrder.branch.code" name="purchaseOrder.branch.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="purchaseOrder_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="purchaseOrder.branch.name" name="purchaseOrder.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="purchaseOrder.transactionDate" name="purchaseOrder.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" onchange="POTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                                <sj:datepicker id="purchaseOrderTransactionDate" name="purchaseOrderTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:nones"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Delivery Date</td>
                            <td>
                                <sj:datepicker id="purchaseOrder.deliveryDateStart" name="purchaseOrder.deliveryDateStart" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true"></sj:datepicker>
                                <s:textfield id="purchaseOrder.deliveryDateStartTemp" name="purchaseOrder.deliveryDateStartTemp" size="20" cssStyle="display:none"></s:textfield> 
                                <B>To *</B>
                                <sj:datepicker id="purchaseOrder.deliveryDateEnd" name="purchaseOrder.deliveryDateEnd" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true"></sj:datepicker>
                                <s:textfield id="purchaseOrder.deliveryDateEndTemp" name="purchaseOrder.deliveryDateEndTemp" size="20" cssStyle="display:none"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Currency *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                txtPurchaseOrderCurrencyCode.change(function(ev) {

                                    if(txtPurchaseOrderCurrencyCode.val()===""){
                                        txtPurchaseOrderCurrencyName.val("");
                                        return;
                                    }
                                    var url = "master/currency-get";
                                    var params = "currency.code=" + txtPurchaseOrderCurrencyCode.val();
                                        params += "&currency.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.currencyTemp){
                                            txtPurchaseOrderCurrencyCode.val(data.currencyTemp.code);
                                            txtPurchaseOrderCurrencyName.val(data.currencyTemp.name);
                                        }
                                        else{
                                            alertMessage("Currency Not Found!",txtPurchaseOrderCurrencyCode);
                                            txtPurchaseOrderCurrencyCode.val("");
                                            txtPurchaseOrderCurrencyName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="purchaseOrder.currency.code" name="purchaseOrder.currency.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="purchaseOrder_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-currency-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="purchaseOrder.currency.name" name="purchaseOrder.currency.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Vendor *</B></td>
                            <td>
                                <script type = "text/javascript">
                                    txtPurchaseOrderVendorCode.change(function (ev) {

                                        if (txtPurchaseOrderVendorCode.val() === "") {
                                            txtPurchaseOrderVendorName.val("");
                                            $("#purchaseOrder\\.paymentTerm\\.code").val("");
                                            $("#purchaseOrder\\.paymentTerm\\.name").val("");
                                            return;
                                        }
                                        var url = "master/vendor-get-data";
                                        var params = "vendor.code=" + txtPurchaseOrderVendorCode.val();
                                        params += "&vendor.activeStatus=" + true;

                                        $.post(url, params, function (result) {
                                            var data = (result);
                                            if (data.vendorTemp) {
                                                txtPurchaseOrderVendorCode.val(data.vendorTemp.code);
                                                txtPurchaseOrderVendorName.val(data.vendorTemp.name);
                                                $("#purchaseOrder\\.paymentTerm\\.code").val(data.vendorTemp.paymentTermCode);
                                                $("#purchaseOrder\\.paymentTerm\\.name").val(data.vendorTemp.paymentTermName);
                                                loadImportLocal(data.vendorTemp.localImport);
                                                var status = data.vendorTemp.penaltyStatus;
                                                if(status === true){
                                                    status = "YES";
                                                }else{
                                                    status = "NO";
                                                }
                                                enabledDisabledPenaltyPercent(status);
                                            } else {
                                                alertMessage("Vendor Not Found!", txtPurchaseOrderVendorCode);
                                                txtPurchaseOrderVendorCode.val("");
                                                txtPurchaseOrderVendorName.val("");
                                                txtPurchaseOrderPaymentTermCode.val("");
                                                txtPurchaseOrderPaymentTermName.val("");
                                            }
                                            
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header">
                                <s:textfield  id="purchaseOrder.vendor.code" name="purchaseOrder.vendor.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="purchaseOrder_btnVendor" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                                <s:textfield id="purchaseOrder.vendor.name" name="purchaseOrder.vendor.name" size="20" readonly="true"></s:textfield>

                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Payment Term *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                $('#purchaseOrder_btnPaymentTerm').click(function(ev) {
                                    if($("#purchaseOrder\\.vendor\\.code").val() === ""){
                                        txtPurchaseOrderPaymentTermCode.val("");
                                        txtPurchaseOrderPaymentTermName.val("");
                                        alertMessage("Vendor Code Cannot Be Empty!");
                                        return;
                                    }else{
                                        window.open("./pages/search/search-payment-term-by-vendor.jsp?iddoc=purchaseOrder&idsubdoc=paymentTerm&idvendor="+$("#purchaseOrder\\.vendor\\.code").val(),"Search", "width=600, height=500");
                                    }
                                });

                                txtPurchaseOrderPaymentTermCode.change(function(ev) {
                                    
                                    if($("#purchaseOrder\\.vendor\\.code").val() === ""){
                                        txtPurchaseOrderPaymentTermCode.val("");
                                        txtPurchaseOrderPaymentTermName.val("");
                                        alertMessage("Vendor Code Cannot Be Empty!");
                                        return;
                                    }else{
                                        if(txtPurchaseOrderPaymentTermCode.val()===""){
                                            txtPurchaseOrderPaymentTermName.val("");
                                            return;
                                        }
                                        var url = "master/payment-term-get-by-vendor";
                                        var params = "code=" + txtPurchaseOrderPaymentTermCode.val();
                                            params += "&vendorCode="+$("#purchaseOrder\\.vendor\\.code").val();

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.paymentTermTemp){
                                                txtPurchaseOrderPaymentTermCode.val(data.paymentTermTemp.paymentTermCode);
                                                txtPurchaseOrderPaymentTermName.val(data.paymentTermTemp.paymentTermName);
                                            }
                                            else{
                                                alertMessage("Payment Term Not Found!",txtPurchaseOrderPaymentTermCode);
                                                txtPurchaseOrderPaymentTermCode.val("");
                                                txtPurchaseOrderPaymentTermName.val("");
                                            }
                                        });
                                    }
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="purchaseOrder.paymentTerm.code" name="purchaseOrder.paymentTerm.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                                <sj:a id="purchaseOrder_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="purchaseOrder.paymentTerm.name" name="purchaseOrder.paymentTerm.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right">Vendor Contact Person </td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrder.vendor.defaultContactPerson.code" name="purchaseOrder.vendor.defaultContactPerson.code" size="20" readonly="true" cssStyle="display:none"></s:textfield>
                                <s:textfield id="purchaseOrder.vendor.defaultContactPerson.name" name="purchaseOrder.vendor.defaultContactPerson.name" size="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Local/Import </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderVendorLocalImportStatusRad" name="purchaseOrderVendorLocalImportStatusRad" label="purchaseOrderVendorLocalImportStatusRad" list="{'Local','Import'}"></s:radio>
                                <s:textfield id="purchaseOrder.vendor.localImport" name="purchaseOrder.vendor.localImport" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Status </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderPenaltyStatusRad" name="purchaseOrderPenaltyStatusRad" label="purchaseOrderPenaltyStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="purchaseOrder.penaltyStatus" name="purchaseOrder.penaltyStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrder.penaltyPercent" name="purchaseOrder.penaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Maximum Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrder.maximumPenaltyPercent" name="purchaseOrder.maximumPenaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="purchaseOrder.purchaseOrderType" name="purchaseOrder.purchaseOrderType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td align = "right"><B>Bill To *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">

                                txtPurchaseOrderBillToCode.change(function(ev) {

                                if(txtPurchaseOrderBillToCode.val()===""){
                                   txtPurchaseOrderBillToName.val("");
                                   return;
                                }
                                var url = "master/purchase-destination-get-bill-and-ship";
                                var params = "code=" + txtPurchaseOrderBillToCode.val();
                                    params += "&activeStatus=TRUE";
                                    params += "&statusBillShip=BillTo";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.purchaseDestinationTemp){
                                        txtPurchaseOrderBillToCode.val(data.purchaseDestinationTemp.code);
                                        txtPurchaseOrderBillToName.val(data.purchaseDestinationTemp.name);
                                        $("#purchaseOrder\\.billTo\\.address").val(data.purchaseDestinationTemp.address);
                                        $("#purchaseOrder\\.billTo\\.contactPerson").val(data.purchaseDestinationTemp.contactPerson);
                                        $("#purchaseOrder\\.billTo\\.phone1").val(data.purchaseDestinationTemp.phone1);
                                    }
                                    else{
                                        alertMessage("Bill To Not Found!",txtPurchaseOrderBillToCode);
                                        txtPurchaseOrderBillToCode.val("");
                                        txtPurchaseOrderBillToName.val("");
                                        $("#purchaseOrder\\.billTo\\.address").val("");
                                        $("#purchaseOrder\\.billTo\\.contactPerson").val("");
                                        $("#purchaseOrder\\.billTo\\.phone1").val("");
                                    }
                                });
                            });
                            </script>
                                <div class="searchbox ui-widget-header">
                                <s:textfield id="purchaseOrder.billTo.code" name="purchaseOrder.billTo.code" cssClass="required" required="true" title=" " size= "20"></s:textfield>
                                <sj:a id="purchaseOrder_btnBillTo" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                                <s:textfield id="purchaseOrder.billTo.name" name="purchaseOrder.billTo.name" readonly="true" size= "15"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrder.billTo.address" name="purchaseOrder.billTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrder.billTo.contactPerson" name="purchaseOrder.billTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrder.billTo.phone1" name="purchaseOrder.billTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right"><B>Ship To *</B></td>
                        <td colspan="2">
                            <script type = "text/javascript">
                            txtPurchaseOrderShipToCode.change(function(ev) {

                                if(txtPurchaseOrderShipToCode.val()===""){
                                    txtPurchaseOrderShipToName.val("");
                                    return;
                                }
                                var url = "master/purchase-destination-get-bill-and-ship";
                                var params = "code=" + txtPurchaseOrderShipToCode.val();
                                    params += "&activeStatus=TRUE";
                                    params += "&statusBillShip=ShipTo";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.purchaseDestinationTemp){
                                        txtPurchaseOrderShipToCode.val(data.purchaseDestinationTemp.code);
                                        txtPurchaseOrderShipToName.val(data.purchaseDestinationTemp.name);
                                        $("#purchaseOrder\\.shipTo\\.address").val(data.purchaseDestinationTemp.address);
                                        $("#purchaseOrder\\.shipTo\\.contactPerson").val(data.purchaseDestinationTemp.contactPerson);
                                        $("#purchaseOrder\\.shipTo\\.phone1").val(data.purchaseDestinationTemp.phone1);
                                    }
                                    else{
                                        alertMessage("Ship To Not Found!",txtPurchaseOrderShipToCode);
                                        txtPurchaseOrderShipToCode.val("");
                                        txtPurchaseOrderShipToName.val("");
                                        $("#purchaseOrder\\.shipTo\\.address").val("");
                                        $("#purchaseOrder\\.shipTo\\.contactPerson").val("");
                                        $("#purchaseOrder\\.shipTo\\.phone1").val("");
                                    }
                                });
                            });
                            </script>
                            <div class="searchbox ui-widget-header">
                            <s:textfield id="purchaseOrder.shipTo.code" name="purchaseOrder.shipTo.code" cssClass="required" required="true" title=" " size= "20"></s:textfield>
                            <sj:a id="purchaseOrder_btnShipTo" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                            <s:textfield id="purchaseOrder.shipTo.name" name="purchaseOrder.shipTo.name" readonly="true" size= "15"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrder.shipTo.address" name="purchaseOrder.shipTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrder.shipTo.contactPerson" name="purchaseOrder.shipTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrder.shipTo.phone1" name="purchaseOrder.shipTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Ref No</td>
                        <td colspan="3"><s:textfield id="purchaseOrder.refNo" name="purchaseOrder.refNo" size="27"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td colspan="3"><s:textarea id="purchaseOrder.remark" name="purchaseOrder.remark"  cols="43" rows="3" height="20"></s:textarea></td>
                    </tr> 
                </table>
            </td>
        </tr>
            <tr hidden="true">
                <td>
                <sj:datepicker id="purchaseOrderDateFirstSession" name="purchaseOrderDateFirstSession" size="15" showOn="focus" style="display:none" disabled="true"></sj:datepicker>
                    <sj:datepicker id="purchaseOrderDateLastSession" name="purchaseOrderDateLastSession" size="15" showOn="focus" style="display:none" disabled="true"></sj:datepicker>
                    <s:textfield id="enumPurchaseOrderActivity" name="enumPurchaseOrderActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="purchaseOrder.createdBy" name="purchaseOrder.createdBy" key="purchaseOrder.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="purchaseOrder.createdDate" name="purchaseOrder.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="purchaseOrder.createdDateTemp" name="purchaseOrder.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmPurchaseOrder" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmPurchaseOrder" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnPOPRQDetail" button="true" style="width: 200px">Search Purchase Request</sj:a>
                </td>
            </tr>
        </table>    
        <br class="spacer" />
        <div id="purchaseOrderPurchaseRequestDetailInputGrid">
            <sjg:grid
                id="purchaseOrderPurchaseRequestDetailInput_grid"
                caption="Document Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listPurchaseOrderPurchaseRequestDetail"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="1200"
                editurl="%{remoteurlPurchaseOrderPurchaseRequestDetailInput}"
                onSelectRowTopics="purchaseOrderPurchaseRequestDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailDelete" index="purchaseOrderPurchaseRequestDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'purchaseOrderPurchaseRequestDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailCode" index="purchaseOrderPurchaseRequestDetailCode" 
                    title="PRQ No *" width="200" sortable="true" edittype="text"
                />     
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailTransactionDate" index="purchaseOrderPurchaseRequestDetailTransactionDate" key="purchaseOrderPurchaseRequestDetailTransactionDate" 
                    title="PRQ Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailDocumentType" index="purchaseOrderPurchaseRequestDetailDocumentType" 
                    title="Document Type" width="70" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailProductionPlanningCode" index="purchaseOrderPurchaseRequestDetailProductionPlanningCode" 
                    title="PPO No" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailBranchCode" index="purchaseOrderPurchaseRequestDetailBranchCode" 
                    title="Branch Code" width="80" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailBranchName" index="purchaseOrderPurchaseRequestDetailBranchName" 
                    title="Branch Name" width="200" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailRequestBy" index="purchaseOrderPurchaseRequestDetailRequestBy" 
                    title="Request By" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderPurchaseRequestDetailRefNo" index="purchaseOrderPurchaseRequestDetailRefNo" 
                    title="Ref No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name = "purchaseOrderPurchaseRequestDetailRemark" index = "purchaseOrderPurchaseRequestDetailRemark" key = "purchaseOrderPurchaseRequestDetailRemark" 
                    title = "Remark" width = "200" edittype="text" 
                />
            </sjg:grid >               
        </div>         
        <table>    
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmPurchaseOrderPurchaseRequestDetail" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmPurchaseOrderPurchaseRequestDetail" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <div id="purchaseOrderPurchasetRequestItemDetail">
            <div id="purchaseOrderPurchaseRequestItemDetailIMRInputGrid">
                <sjg:grid
                    id="purchaseOrderPurchaseRequestItemDetailInput_grid"
                    caption="PRQ Item Detail "
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseOrderJnPurchaseRequestDetailTemp"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="700"
                    editurl="%{remoteurlPurchaseOrderPurchaseRequestItemDetailInput}"
                    onSelectRowTopics="purchaseOrderPurchaseRequestItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailDelete_grid" index="purchaseOrderPurchaseRequestItemDetailDelete_grid" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'purchaseOrderPurchaseRequestItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />                      
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailPurchaseRequestNo" index="purchaseOrderPurchaseRequestItemDetailPurchaseRequestNo" key="purchaseOrderPurchaseRequestItemDetailPurchaseRequestNo" 
                        title="PRQ No" width="200" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailPurchaseRequestDetailNo" index="purchaseOrderPurchaseRequestItemDetailPurchaseRequestDetailNo" key="purchaseOrderPurchaseRequestItemDetailPurchaseRequestDetailNo" 
                        title="PRQ Detail" width="200" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" index="purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" key="purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" 
                        title="Item Material Code" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialName" index="purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialName" key="purchaseOrderPurchaseRequestItemDetailPurchaseRequestItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailQuantity" index="purchaseOrderPurchaseRequestItemDetailQuantity" 
                        title="Quantity" width="100" sortable="true" formatter="number"
                    /> 
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailUnitOfMeasureCode" index="purchaseOrderPurchaseRequestItemDetailUnitOfMeasureCode" 
                        title="UOM" width="80" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailUnitOfMeasureName" index="purchaseOrderPurchaseRequestItemDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true" hidden = "true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailPurchaseOrderCode" index="purchaseOrderPurchaseRequestItemDetailPurchaseOrderCode" 
                        title="POD No" width="150" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailItemJnVendorCode" index="purchaseOrderPurchaseRequestItemDetailItemJnVendorCode" 
                        title="Item Jn Vendor" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderPurchaseRequestItemDetailVendorCode" index="purchaseOrderPurchaseRequestItemDetailVendorCode" 
                        title="Vendor" width="150" sortable="true" hidden="true"
                    />
                </sjg:grid >
            </div>
        </div>    
            <table>    
                <tr>
                    <td align="left">
                        <sj:a href="#" id="btnConfirmPurchaseOrderPurchaseRequest" button="true" style="width: 70px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmPurchaseOrderPurchaseRequest" button="true" style="width: 90px">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>
            <br>
        <div id="purchaseOrderDetailTable">
            <table>
                <tr>
                    <td>
                        <sj:a href="#" id="btnPOItemDetail" button="true" style="width: 200px">Search Item</sj:a>
                    </td>
                </tr>
            </table>    
            <br>    
            <div id="purchaseOrderDetail">
                <sjg:grid
                    id="purchaseOrderDetailInput_grid"
                    caption="Purchase Order Detail"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseOrderDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnupurchaseOrderDetail').width()"
                    editurl="%{remoteurlPurchaseOrderDetailInput}"
                    onSelectRowTopics="purchaseOrderDetailInput_grid_onSelect"
                >      
                    <sjg:gridColumn
                        name="purchaseOrderDetail" index="purchaseOrderDetail" key="purchaseOrderDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailDelete_grid" index="purchaseOrderDetailDelete_grid" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'purchaseOrderDetailDelete_Grid_Delete_OnClick()', value:'delete'}"
                    />   
                    <sjg:gridColumn
                        name="purchaseOrderDetailPurchaseRequestCode" index="purchaseOrderDetailPurchaseRequestCode" key="purchaseOrderDetailPurchaseRequestCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true"
                    />                    
                    <sjg:gridColumn
                        name="purchaseOrderDetailPurchaseRequestDetailCode" index="purchaseOrderDetailPurchaseRequestDetailCode" key="purchaseOrderDetailPurchaseRequestDetailCode" 
                        title="PRQ Detail " width="150" sortable="true" hidden="true"
                    />                    
                    <sjg:gridColumn
                        name="purchaseOrderDetailDetailCode" index="purchaseOrderDetailDetailCode" key="purchaseOrderDetailDetailCode" 
                        title="Detail Code " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderDetailItemMaterialCode" index="purchaseOrderDetailItemMaterialCode" key="purchaseOrderDetailItemMaterialCode" 
                        title="Item Material Code " width="150" sortable="true" hidden="false"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderDetailItemMaterialName" index="purchaseOrderDetailItemMaterialName" key="purchaseOrderDetailItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailItemAlias" index="purchaseOrderDetailItemAlias" 
                        title="Item Alias" width="80" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailRemark" index="purchaseOrderDetailRemark" key="purchaseOrderDetailRemark" 
                        title="Remark" width="150" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailQuantity" index="purchaseOrderDetailQuantity" key="purchaseOrderDetailQuantity" 
                        title="POD Quantity" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailUnitOfMeasureCode" index="purchaseOrderDetailUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailUnitOfMeasureName" index="purchaseOrderDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true" editable="false" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailPrice" index="purchaseOrderDetailPrice" key="purchaseOrderDetailPrice" 
                        title="Price" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailDiscPercent" index="purchaseOrderDetailDiscPercent" key="purchaseOrderDetailDiscPercent" 
                        title="Discount Percent" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailDiscAmount" index="purchaseOrderDetailDiscAmount" key="purchaseOrderDetailDiscAmount" 
                        title="Discount Amount" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderDetailAmount()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailNettPrice" index="purchaseOrderDetailNettPrice" key="purchaseOrderDetailNettPrice" 
                        title="Nett Price" width="150" sortable="true" editable="false" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderDetailTotalPrice" index="purchaseOrderDetailTotalPrice" key="purchaseOrderDetailTotalPrice" 
                        title="Total" width="150" sortable="true" editable="false" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
            <br>
            <table>
                <tr>
                    <td>
                        <sj:a href="#" id="btnAdditionalFeeDetail" button="true" style="width: 200px">Search Additional</sj:a>
                    </td>
                </tr>
            </table>    
            <br>
            <div id="purchaseOrderDetailAddtional">
                <sjg:grid
                    id="purchaseOrderAdditionalFeeInput_grid"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseOrderAdditionalFee"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnupurchaseOrderAdditionalFee').width()"
                    editurl="%{remoteurlPurchaseOrderAdditionalInput}"
                    onSelectRowTopics="purchaseOrderAdditionalFeeInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="purchaseOrderDetailAdditionalFeeCode" index="purchaseOrderDetailAdditionalFeeCode" key="purchaseOrderDetailAdditionalFeeCode" 
                        title="" width="150" sortable="true" hidden="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeDelete" index="purchaseOrderAdditionalFeeDelete" title="" width="50" align="centre"
                        editable="true"
                        edittype="button"
                        editoptions="{onClick:'purchaseOrderAdditionalFeeInput_grid_Delete_OnClick()', value:'delete'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeCode" index="purchaseOrderAdditionalFeeCode" key="purchaseOrderAdditionalFeeCode" 
                        title="Additional Cost Code" width="150" sortable="true"
                    />  
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeName" index="purchaseOrderAdditionalFeeName" key="purchaseOrderAdditionalFeeName" 
                        title="Additional Cost Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeePurchaseChartOfAccountCode" index="purchaseOrderAdditionalFeePurchaseChartOfAccountCode" key="purchaseOrderAdditionalFeePurchaseChartOfAccountCode" 
                        title="Chart Of Account Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeePurchaseChartOfAccountName" index="purchaseOrderAdditionalFeePurchaseChartOfAccountName" key="purchaseOrderAdditionalFeePurchaseChartOfAccountName" 
                        title="Chart Of Account Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeRemark" index="purchaseOrderAdditionalFeeRemark" key="purchaseOrderAdditionalFeeRemark" 
                        title="Remark" width="150" sortable="true" editable="true" edittype="text" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeQuantity" index="purchaseOrderAdditionalFeeQuantity" key="purchaseOrderAdditionalFeeQuantity" 
                        title="Quantity" width="150" sortable="true" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculationAdditional()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeUnitOfMeasureSearch" index="purchaseOrderAdditionalFeeUnitOfMeasureSearch" title="" width="25" align="centre"
                        editable="true" 
                        dataType="html"
                        edittype="button"
                        editoptions="{onClick:'purchaseOrderAdditionalFeeUnitOfMeasureSearchInputGrid_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeUnitOfMeasureCode" index="purchaseOrderDetailUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" editable="true" edittype="text" 
                        editoptions = "{onChange:'changeUnitOfMeasure()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeUnitOfMeasureName" index="purchaseOrderDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeePrice" index="purchaseOrderAdditionalFeePrice" key="purchaseOrderAdditionalFeePrice" 
                        title="Price" width="150" sortable="true" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculationAdditional()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderAdditionalFeeTotal" index="purchaseOrderAdditionalFeeTotal" key="purchaseOrderAdditionalFeeTotal" 
                        title="Total" width="150" sortable="true" editable="false" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
            </div> 
            <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnConfirmPurchaseOrderDetail" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmPurchaseOrderDetail" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
            </table>
            <br>
            <br>
            <div id="PurchaseOrderItemDeliveryDate">
                <table>
                    <tr>
                        <td align="right">Delivery Date
                        <sj:datepicker id="purchaseOrderDeliveryDateSet" name="purchaseOrderDeliveryDateSet" title=" " displayFormat="dd/mm/yy" size="12" showOn="focus" value="today"></sj:datepicker>
                            <sj:a href="#" id="btnPurchaseOrderDeliveryDateSet" button="true" style="width: 40px">>></sj:a>&nbsp;&nbsp;
                            <sj:a href="#" id="btnPurchaseOrderCopyFromDetail" button="true" style="width: 120px">Copy From Detail</sj:a>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="purchaseOrderItemDeliveryInput_grid"
                                            caption="Item Delivery Date"
                                            dataType="local"                    
                                            pager="true"
                                            navigator="false"
                                            navigatorView="false"
                                            navigatorRefresh="false"
                                            navigatorDelete="false"
                                            navigatorAdd="false"
                                            navigatorEdit="false"
                                            gridModel="listPurchaseOrderItemDeliveryDate"
                                            viewrecords="true"
                                            rownumbers="true"
                                            shrinkToFit="false"
                                            editinline="true"
                                            width="600"
                                            editurl="%{remoteurlPurchaseOrderItemDeliveryInput}"
                                            onSelectRowTopics="purchaseOrderItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="purchaseOrderItemDelivery" index="purchaseOrderItemDelivery" key="purchaseOrderItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderItemDeliveryDelete" index="purchaseOrderItemDeliveryDelete" title="" width="50" align="centre"
                                                editable="true"
                                                edittype="button"
                                                editoptions="{onClick:'purchaseOrderItemDeliveryInputGrid_Delete_OnClick()', value:'delete'}"
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderItemDeliverySearchItemMaterial" index="purchaseOrderItemDeliverySearchItemMaterial" title="" width="25" align="centre"
                                                editable="true"
                                                dataType="html"
                                                edittype="button"
                                                editoptions="{onClick:'purchaseOrderItemDeliveryInputGrid_SearchItemMaterial_OnClick()', value:'...'}"
                                            /> 
                                            <sjg:gridColumn
                                                name = "purchaseOrderItemDeliveryItemMaterialCode" index = "purchaseOrderItemDeliveryItemMaterialCode" key = "purchaseOrderItemDeliveryItemMaterialCode" 
                                                title = "Item Material Code" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "purchaseOrderItemDeliveryItemMaterialName" index = "purchaseOrderItemDeliveryItemMaterialName" key = "purchaseOrderItemDeliveryItemMaterialName" 
                                                title = "Item Material Name" width = "100" editable="true" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderItemDeliveryQuantity" index="purchaseOrderItemDeliveryQuantity" key="purchaseOrderItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="true" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderItemDeliveryDeliveryDate" index="purchaseOrderItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="true" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: true, required:false}" 
                                                editoptions="{onChange:'onchangePurchaseOrderItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderItemDeliveryDeliveryDateTemp" index="purchaseOrderItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                        </sjg:grid >
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <s:textfield id="purchaseOrderItemDeliveryAddRow" name="purchaseOrderItemDeliveryAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                        <sj:a href="#" id="btnPurchaseOrderItemDelieryAdd" button="true" style="width:60px">Add</sj:a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
        <br class="spacer" />
        <table style="width: 100%;">  
            <tr>
                <td valign="top">
                </td>
                <td width="700px" >
                <fieldset> 
                    <table align="right">
                        <tr>
                            <td align="right"><B>Total Transaction</B>
                                <s:textfield id="purchaseOrder.totalTransactionAmount" name="purchaseOrder.totalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="left"><B>Discount</B>
                                <s:textfield id="purchaseOrder.discountPercent" name="purchaseOrder.discountPercent" cssStyle="text-align:right;" size="8"></s:textfield>
                                %
                            <s:textfield id="purchaseOrder.discountAmount" name="purchaseOrder.discountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td></td>
                            <td align="left"> Descriptions</td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                    <script type = "text/javascript">

                                    txtPurchaseOrderDiscountAccountCode.change(function (ev) {

                                        if (txtPurchaseOrderDiscountAccountCode.val() === "") {
                                            txtPurchaseOrderDiscountAccountName.val("");
                                            return;
                                        }
                                        var url = "master/chart-of-account-get";
                                        var params = "chartOfAccount.code=" + txtPurchaseOrderDiscountAccountCode.val();
                                        params += "&chartOfAccount.activeStatus=true";
                                        params += "&chartOfAccount.AccountType=S";

                                        $.post(url, params, function (result) {
                                            var data = (result);
                                            if (data.chartOfAccountTemp) {
                                                txtPurchaseOrderDiscountAccountCode.val(data.chartOfAccountTemp.code);
                                                txtPurchaseOrderDiscountAccountName.val(data.chartOfAccountTemp.name);
                                            } else {
                                                alertMessage("Chart Of Account Not Found!", txtPurchaseOrderDiscountAccountCode);
                                                txtPurchaseOrderDiscountAccountCode.val("");
                                                txtPurchaseOrderDiscountAccountName.val("");
                                            }
                                        });
                                    });
                                  </script>
                                <div class="searchbox ui-widget-header">
                                <s:textfield id="purchaseOrder.discountChartOfAccount.code" name="purchaseOrder.discountChartOfAccount.code" title=" " size = "15"></s:textfield>
                                <sj:a id="purchaseOrder_btnDiscountCOA" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrder.discountChartOfAccount.name" name="purchaseOrder.discountChartOfAccount.name" title=" " size = "20" readonly = "true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrder.discountDescription" name="purchaseOrder.discountDescription" title=" " PlaceHolder=" Description Discount" size ="20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sub Total (Tax Base)</B>
                                <s:textfield id="purchaseOrder.taxBaseSubTotalAmount" name="purchaseOrder.taxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                                <s:textfield id="purchaseOrder.vatPercent" name="purchaseOrder.vatPercent" cssStyle="text-align:right;" size="8"></s:textfield>
                                %
                            <s:textfield id="purchaseOrder.vatAmount" name="purchaseOrder.vatAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td/>
                        </tr>
                        <tr>
                            <td align="right"><B>Other Fee</B>
                                <s:textfield id="purchaseOrder.otherFeeAmount" name="purchaseOrder.otherFeeAmount" cssStyle="text-align:right;%"></s:textfield>
                            </td>
                            <td/>
                             <td align="left"> Descriptions </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                         <script type = "text/javascript">

                                        txtPurchaseOrderOtherFeeAccountCode.change(function (ev) {

                                            if (txtPurchaseOrderOtherFeeAccountCode.val() === "") {
                                                txtPurchaseOrderOtherFeeChartOfAccountName.val("");
                                                return;
                                            }
                                            var url = "master/chart-of-account-get";
                                            var params = "chartOfAccount.code=" + txtPurchaseOrderOtherFeeAccountCode.val();
                                            params += "&chartOfAccount.activeStatus=true";
                                            params += "&chartOfAccount.AccountType=S";

                                            $.post(url, params, function (result) {
                                                var data = (result);
                                                if (data.chartOfAccountTemp) {
                                                    txtPurchaseOrderOtherFeeAccountCode.val(data.chartOfAccountTemp.code);
                                                    txtPurchaseOrderOtherFeeAccountName.val(data.chartOfAccountTemp.name);
                                                } else {
                                                    alertMessage("Chart Of Account Not Found!", txtPurchaseOrderOtherFeeAccountCode);
                                                    txtPurchaseOrderOtherFeeAccountCode.val("");
                                                    txtPurchaseOrderOtherFeeAccountName.val("");
                                                }
                                            });
                                        });
                                    </script>
                                <div class="searchbox ui-widget-header">
                                <s:textfield id="purchaseOrder.otherFeeChartOfAccount.code" name="purchaseOrder.otherFeeChartOfAccount.code" title=" " size = "15"></s:textfield>
                                <sj:a id="purchaseOrder_btnOtherFeeCOA" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrder.otherFeeChartOfAccount.name" name="purchaseOrder.otherFeeChartOfAccount.name" title=" " readonly="true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrder.otherFeeDescription" name="purchaseOrder.otherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B>
                                <s:textfield id="purchaseOrder.grandTotalAmount" name="purchaseOrder.grandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                            </td>
                            <td/>
                        </tr>
                    </table>
                </fieldset>            
                </td>
            </tr>       
        </table>
    </div>                             
        <table>
            <tr></tr>
            <tr>
                <td><sj:a href="#" id="btnPurchaseOrderSave" button="true" style="width: 60px">Save</sj:a></td>
                <td> <sj:a href="#" id="btnPurchaseOrderCancel" button="true" style="width: 60px">Cancel</sj:a></td>
                </tr>
        </table>
</s:form>
<br class="spacer" />
<br class="spacer" />