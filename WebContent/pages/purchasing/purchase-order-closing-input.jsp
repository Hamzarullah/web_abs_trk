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
</style>

<script type="text/javascript">
     var purchaseOrderClosingDetaillastSel = -1,
         purchaseOrderClosingDetaillastRowId = 0,
         purchaseOrderClosingPurchaseRequestlastSel = -1,
         purchaseOrderClosingPurchaseRequestRowId = 0,
         purchaseOrderClosingPRNonIMRlastSel = -1,
         purchaseOrderClosingPRNonIMRRowId = 0,
         purchaseOrderClosingDetailRowId = 0,
         purchaseOrderClosingDetaillastsel = -1,
         purchaseOrderClosingDetailAdditionalRowId = 0,
         purchaseOrderClosingDetailAdditionallastsel = -1,
         purchaseOrderClosingDetailItemDeliveryRowId = 0,
         purchaseOrderClosingDetailItemDeliverylastsel = -1;
    
    var 
        rdbPurchaseOrderClosingStatus = $("#purchaseOrderClosing\\.approvalStatus"),
        txtPurchaseOrderClosingReasonCode = $("#purchaseOrderClosing\\.approvalReason\\.code"),
        txtPurchaseOrderClosingReasonName = $("#purchaseOrderClosing\\.approvalReason\\.name"),
        txtPurchaseOrderClosingRemark = $("#purchaseOrderClosing\\.approvalRemark");
        
    $(document).ready(function() {
        hoverButton();
        
        formatNumericPOClosing();
        if($("#enumPurchaseOrderClosingActivity").val() === "UPDATE"){
            loadImportLocal($("#purchaseOrderClosing\\.vendor\\.localImport").val());
            if ($("#purchaseOrderClosing\\.penaltyStatus").val()== true){
                $('#purchaseOrderClosingPenaltyStatusRadYES').prop('checked',true);
                enabledDisabledPenaltyPercentClosing('YES');
            }else{
                $('#purchaseOrderClosingPenaltyStatusRadNO').prop('checked',true);
                enabledDisabledPenaltyPercentClosing('NO');
            }
        }
 
            loadPurchaseRequestDetailClosing();
            loadPurchaseOrderClosingPR();
            loadPODetailClosing();
            loadPOClosingAdditionalFee();
            loadItemDeliveryDateClosing();
            
        $('#btnPurchaseOrderClosingSave').click(function(ev) {
               var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Close Status?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>PO No: '+$("#purchaseOrderClosing\\.code").val()+'<br/><br/>' +    
                    '</div>');
                dynamicDialog.dialog({
                    title           : "Confirmation",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 300,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "Yes",
                                        click : function() {             
                                            unFormatNumericPO();
                                            var url = "purchase/purchase-order-closing-status";
                                            var params = $("#frmPurchaseOrderClosingInput").serialize();
                                            $.post(url, params, function(data) {
                                                if (data.error) {
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                                alertMessage(data.message);

                                                var url = "purchase/purchase-order-closing";
                                                var params = "";
                                                pageLoad(url, params, "#tabmnuPURCHASE_ORDER_CLOSING"); 
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
        
        $('#btnPurchaseOrderClosingCancel').click(function(ev) {
            var url = "purchasing/purchase-order-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER_APPROVAL"); 
        });
    });

    function radioButtonStatusPurchaseOrder(){
        if ($("#purchaseOrderClosing\\.approvalStatus").val()==="APPROVED"){
            $('#purchaseOrderClosingStatusRadAPPROVED').prop('checked',true);
        }
        if ($("#purchaseOrderClosing\\.approvalStatus").val()==="REVIEWING"){
            $('#purchaseOrderClosingStatusRadREJECTED').prop('checked',true);
        }

    }

    function loadImportLocal(localImport){
        if (localImport==='LOCAL'){
             $('#purchaseOrderClosingVendorLocalImportStatusRadLocal').prop('checked',true);
             $('#purchaseOrderClosingVendorLocalImportStatusRadImport').prop('disabled',true);
             $("#purchaseOrderClosing\\.vendor\\.localImport").val("LOCAL");
        }
        else{
            $('#purchaseOrderClosingVendorLocalImportStatusRadImport').prop('checked',true);
            $('#purchaseOrderClosingVendorLocalImportStatusRadLocal').prop('disabled',true);
            $("#purchaseOrderClosing\\.vendor\\.localImport").val("IMPORT");
        }
    }
    
    function enabledDisabledPenaltyPercentClosing(percentType){
        switch(percentType){
            case "YES":   
                $("#purchaseOrderClosing\\.penaltyPercent").attr('readonly',true);
                $('#purchaseOrderClosingPenaltyStatusRadYES').prop('checked',true);
                $("#purchaseOrderClosingPenaltyStatusRadNO").prop('disabled',true);
                $("#purchaseOrderClosing\\.penaltyPercent").focus();
                $("#purchaseOrderClosing\\.maximumPenaltyPercent").attr('readonly',true);
                $("#purchaseOrderClosing\\.maximumPenaltyPercent").val("0.00");
                $("#purchaseOrderClosing\\.penaltyPercent").val("0.00");
                break;
            case "NO":
                $("#purchaseOrderClosing\\.penaltyPercent").attr('readonly',true);
                $('#purchaseOrderClosingPenaltyStatusRadNO').prop('checked',true);
                $("#purchaseOrderClosingPenaltyStatusRadYES").prop('disabled',true);
                $("#purchaseOrderClosing\\.penaltyPercent").focus();
                $("#purchaseOrderClosing\\.maximumPenaltyPercent").attr('readonly',true);
                $("#purchaseOrderClosing\\.maximumPenaltyPercent").val("0.00");
                $("#purchaseOrderClosing\\.penaltyPercent").val("0.00");
                break;
        }
    }
    
    function loadPurchaseRequestDetailClosing(){   
        
        var url = "purchase/purchase-order-purchase-request-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderClosing\\.code").val();   
        
        purchaseOrderClosingPurchaseRequestRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderPurchaseRequestDetail.length; i++) {
                purchaseOrderClosingPurchaseRequestRowId++;
                var purchaseRequestTransactionDate=formatDateRemoveT(data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestTransactionDate, true);
                
                $("#purchaseOrderClosingPurchaseRequestDetailInput_grid").jqGrid("addRowData", purchaseOrderClosingPurchaseRequestRowId, data.listPurchaseOrderPurchaseRequestDetail[i]);
                $("#purchaseOrderClosingPurchaseRequestDetailInput_grid").jqGrid('setRowData',purchaseOrderClosingPurchaseRequestRowId,{
                    purchaseOrderClosingPurchaseRequestDetailCode                      : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestCode,
                    purchaseOrderClosingPurchaseRequestDetailTransactionDate           : purchaseRequestTransactionDate,
                    purchaseOrderClosingPurchaseRequestDetailDocumentType              : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestType,
                    purchaseOrderClosingPurchaseRequestDetailProductionPlanningCode    : data.listPurchaseOrderPurchaseRequestDetail[i].ppoCode,
                    purchaseOrderClosingPurchaseRequestDetailBranchCode                : data.listPurchaseOrderPurchaseRequestDetail[i].branchCode,
                    purchaseOrderClosingPurchaseRequestDetailBranchName                : data.listPurchaseOrderPurchaseRequestDetail[i].branchName,
                    purchaseOrderClosingPurchaseRequestDetailRequestBy                 : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRequestBy,
                    purchaseOrderClosingPurchaseRequestDetailRemark                    : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRemark
  
                });
                
                loadPurchaseOrderClosingPR(data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestCode);
            }
        });
        closeLoading();
    }
    
    function loadPurchaseOrderClosingPR(data){
        var arrPurchaseOrderClosingPRQNo=new Array();
            arrPurchaseOrderClosingPRQNo.push(data);
       
        var url = "purchasing/purchase-request-item-material-request-detail-data";
        var params = "arrPurchaseOrderNo=" + arrPurchaseOrderClosingPRQNo;
        
        purchaseOrderClosingPRNonIMRRowId = 0;
        $.getJSON(url, params, function(data) {
            for (var i=0; i<data.listPurchaseRequestNonItemMaterialRequestDetail.length; i++) {
                purchaseOrderClosingPRNonIMRRowId++;
                $("#purchaseOrderClosingPurchaseRequestItemDetailInput_grid").jqGrid("addRowData", purchaseOrderClosingPRNonIMRRowId, data.listPurchaseRequestNonItemMaterialRequestDetail[i]);
                $("#purchaseOrderClosingPurchaseRequestItemDetailInput_grid").jqGrid('setRowData',purchaseOrderClosingPRNonIMRRowId,{
                    purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestNo                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].headerCode,
                    purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestDetailNo           : data.listPurchaseRequestNonItemMaterialRequestDetail[i].code,
                    purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialCode   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialCode,
                    purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialName   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialName,
                    purchaseOrderClosingPurchaseRequestItemDetailQuantity                          : data.listPurchaseRequestNonItemMaterialRequestDetail[i].quantity,
                    purchaseOrderClosingPurchaseRequestItemDetailUnitOfMeasureCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseOrderClosingPurchaseRequestItemDetailUnitOfMeasureName                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseOrderClosingPurchaseRequestItemDetailPurchaseOrderCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].poCode,
                    purchaseOrderClosingPurchaseRequestItemDetailItemJnVendorCode                  : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialJnVendor,
                    purchaseOrderClosingPurchaseRequestItemDetailVendorCode                        : data.listPurchaseRequestNonItemMaterialRequestDetail[i].vendorCode
                });
            }
            
        }); 
    }
    
    function loadPODetailClosing(){            
        var url = "purchase/purchase-order-detail-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderClosing\\.code").val();   
        
        purchaseOrderClosingDetailRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderDetail.length; i++) {
                purchaseOrderClosingDetailRowId++;
                
                $("#purchaseOrderClosingDetailInput_grid").jqGrid("addRowData", purchaseOrderClosingDetailRowId, data.listPurchaseOrderDetail[i]);
                $("#purchaseOrderClosingDetailInput_grid").jqGrid('setRowData', purchaseOrderClosingDetailRowId,{
                    purchaseOrderClosingDetailPurchaseRequestCode              : data.listPurchaseOrderDetail[i].purchaseRequestCode,
                    purchaseOrderClosingDetailPurchaseRequestHeaderCode        : data.listPurchaseOrderDetail[i].headerCode,
                    purchaseOrderClosingDetailPurchaseRequestDetailCode        : data.listPurchaseOrderDetail[i].code,
                    purchaseOrderClosingDetailItemMaterialCode                 : data.listPurchaseOrderDetail[i].itemMaterialCode,
                    purchaseOrderClosingDetailItemMaterialName                 : data.listPurchaseOrderDetail[i].itemMaterialName,
                    purchaseOrderClosingDetailItemAlias                        : data.listPurchaseOrderDetail[i].itemAlias,
                    purchaseOrderClosingDetailRemark                           : data.listPurchaseOrderDetail[i].remark,
                    purchaseOrderClosingDetailQuantity                         : data.listPurchaseOrderDetail[i].quantity,
                    purchaseOrderClosingDetailBonusQuantity                    : data.listPurchaseOrderDetail[i].bonusQuantity,
                    purchaseOrderClosingDetailUnitOfMeasureCode                : data.listPurchaseOrderDetail[i].unitOfMeasureCode,
                    purchaseOrderClosingDetailUnitOfMeasureName                : data.listPurchaseOrderDetail[i].unitOfMeasureName,
                    purchaseOrderClosingDetailPrice                            : data.listPurchaseOrderDetail[i].price,
                    purchaseOrderClosingDetailDiscPercent                      : data.listPurchaseOrderDetail[i].discountPercent,
                    purchaseOrderClosingDetailDiscAmount                       : data.listPurchaseOrderDetail[i].discountAmount,
                    purchaseOrderClosingDetailNettPrice                        : data.listPurchaseOrderDetail[i].nettPrice,
                    purchaseOrderClosingDetailTotalPrice                       : data.listPurchaseOrderDetail[i].totalAmount
  
                });
            }
        });
        closeLoading();
    }
    
    function loadPOClosingAdditionalFee(){
        var url = "purchase/purchase-order-additional-fee-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderClosing\\.code").val();   
        
        purchaseOrderClosingDetailAdditionalRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderAdditionalFee.length; i++) {
                purchaseOrderClosingDetailAdditionalRowId++;
                
                $("#purchaseOrderClosingAdditionalFeeInput_grid").jqGrid("addRowData", purchaseOrderClosingDetailAdditionalRowId, data.listPurchaseOrderAdditionalFee[i]);
                $("#purchaseOrderClosingAdditionalFeeInput_grid").jqGrid('setRowData',purchaseOrderClosingDetailAdditionalRowId,{
                    purchaseOrderClosingDetailAdditionalFeeCode                    : data.listPurchaseOrderAdditionalFee[i].code,
                    purchaseOrderClosingAdditionalFeeCode                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeCode,
                    purchaseOrderClosingAdditionalFeeName                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeName,
                    purchaseOrderClosingAdditionalFeePurchaseChartOfAccountCode    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountCode,
                    purchaseOrderClosingAdditionalFeePurchaseChartOfAccountName    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountName,
                    purchaseOrderClosingAdditionalFeeRemark                        : data.listPurchaseOrderAdditionalFee[i].remark,
                    purchaseOrderClosingAdditionalFeeQuantity                      : data.listPurchaseOrderAdditionalFee[i].quantity,
                    purchaseOrderClosingAdditionalFeeUnitOfMeasureCode             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureCode,
                    purchaseOrderClosingAdditionalFeeUnitOfMeasureName             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureName,
                    purchaseOrderClosingAdditionalFeePrice                         : data.listPurchaseOrderAdditionalFee[i].price,
                    purchaseOrderClosingAdditionalFeeTotal                         : data.listPurchaseOrderAdditionalFee[i].total
  
                });
            }
        });
        closeLoading();
    }
    
    function loadItemDeliveryDateClosing(){            
        
        var url = "purchase/purchase-order-item-delivery-date-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderClosing\\.code").val();   
        
        purchaseOrderClosingDetailItemDeliveryRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderItemDeliveryDate.length; i++) {
                purchaseOrderClosingDetailItemDeliveryRowId++;
                var deliveryDate=formatDateRemoveT(data.listPurchaseOrderItemDeliveryDate[i].deliveryDate, false);
                $("#purchaseOrderClosingItemDeliveryInput_grid").jqGrid("addRowData", purchaseOrderClosingDetailItemDeliveryRowId, data.listPurchaseOrderItemDeliveryDate[i]);
                $("#purchaseOrderClosingItemDeliveryInput_grid").jqGrid('setRowData',purchaseOrderClosingDetailItemDeliveryRowId,{
                    purchaseOrderClosingItemDeliveryItemMaterialCode               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialCode,
                    purchaseOrderClosingItemDeliveryItemMaterialName               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialName,
                    purchaseOrderClosingItemDeliveryQuantity                       : data.listPurchaseOrderItemDeliveryDate[i].quantity,
                    purchaseOrderClosingItemDeliveryDeliveryDate                   : deliveryDate
  
                });
            }
        });
        closeLoading();
    }
    
    function clearAmountPurchaseOrderClosingHeader(){
        txtPurchaseOrderClosingTotalTransactionAmount.val("0.00");
        txtPurchaseOrderClosingDiscountPercent.val("0.00");
        txtPurchaseOrderClosingDiscountAmount.val("0.00");
        txtPurchaseOrderClosingTaxBaseSubTotalAmount.val("0.00");
        txtPurchaseOrderClosingVATPercent.val("0.00");
        txtPurchaseOrderClosingVATAmount.val("0.00");
        txtPurchaseOrderClosingOtherFeeAmount.val("0.00");
        txtPurchaseOrderClosingGrandTotalAmount.val("0.00");
    }
    
    function validationComma(){

        var totalTransaction = txtPurchaseOrderClosingTotalTransactionAmount.val().replace(/,/g, "");
        var discountAmount = txtPurchaseOrderClosingDiscountAmount.val().replace(/,/g, "");
        var taxBaseSubTotalAmount = txtPurchaseOrderClosingTaxBaseSubTotalAmount.val().replace(/,/g, "");
        var taxAmount = txtPurchaseOrderClosingVATAmount.val().replace(/,/g, "");
        var otherFee = txtPurchaseOrderClosingOtherFeeAmount.val().replace(/,/g, "");
        var grandTotal = txtPurchaseOrderClosingGrandTotalAmount.val().replace(/,/g, "");

        txtPurchaseOrderClosingTotalTransactionAmount.val(totalTransaction);
        txtPurchaseOrderClosingDiscountAmount.val(discountAmount);
        txtPurchaseOrderClosingVATAmount.val(taxAmount);
        txtPurchaseOrderClosingTaxBaseSubTotalAmount.val(taxBaseSubTotalAmount);
        txtPurchaseOrderClosingOtherFeeAmount.val(otherFee);
        txtPurchaseOrderClosingGrandTotalAmount.val(grandTotal);

    }
    
    function formatDate(){
        var transactionDateSplit=dtpPurchaseOrderClosingTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpPurchaseOrderClosingTransactionDate.val(transactionDate);
        
        var deliveryDateStartSplit=dtpPurchaseOrderClosingDeliveryDateStart.val().split('/');
        var deliveryDateStart =deliveryDateStartSplit[1]+"/"+deliveryDateStartSplit[0]+"/"+deliveryDateStartSplit[2];
        dtpPurchaseOrderClosingDeliveryDateStart.val(deliveryDateStart);
        $("#purchaseOrderClosing\\.deliveryDateStartTemp").val(deliveryDateStart);
        
        var deliveryDateEndSplit=dtpPurchaseOrderClosingDeliveryDateEnd.val().split('/');
        var deliveryDateEnd =deliveryDateEndSplit[1]+"/"+deliveryDateEndSplit[0]+"/"+deliveryDateEndSplit[2];
        dtpPurchaseOrderClosingDeliveryDateEnd.val(deliveryDateEnd);
        $("#purchaseOrderClosing\\.deliveryDateEndTemp").val(deliveryDateEnd);
        
    }
    
    function unFormatNumericPO(){ 
        var totalTransactionAmount = removeCommas($("#purchaseOrderClosing\\.totalTransactionAmount").val());
        var discountPercent =removeCommas($("#purchaseOrderClosing\\.discountPercent").val());
        var discountAmount =removeCommas($("#purchaseOrderClosing\\.discountAmount").val());
        var taxBaseSubTotalAmount =removeCommas($("#purchaseOrderClosing\\.taxBaseSubTotalAmount").val());
        var vatPercent = removeCommas($("#purchaseOrderClosing\\.vatPercent").val());
        var vatAmount = removeCommas($("#purchaseOrderClosing\\.vatAmount").val());
        var otherFee = removeCommas($("#purchaseOrderClosing\\.otherFeeAmount").val());
        var grandTotalAmount =removeCommas($("#purchaseOrderClosing\\.grandTotalAmount").val());

        $("#purchaseOrderClosing\\.totalTransactionAmount").val(totalTransactionAmount);
        $("#purchaseOrderClosing\\.discountPercent").val(discountPercent);
        $("#purchaseOrderClosing\\.discountAmount").val(discountAmount);
        $("#purchaseOrderClosing\\.taxBaseSubTotalAmount").val(taxBaseSubTotalAmount);
        $("#purchaseOrderClosing\\.vatPercent").val(vatPercent);
        $("#purchaseOrderClosing\\.vatAmount").val(vatAmount);
        $("#purchaseOrderClosing\\.otherFeeAmount").val(otherFee);
        $("#purchaseOrderClosing\\.grandTotalAmount").val(grandTotalAmount);
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
    
    function formatNumericPOClosing(){
        var totalTransactionAmount =parseFloat($("#purchaseOrderClosing\\.totalTransactionAmount").val());
        $("#purchaseOrderClosing\\.totalTransactionAmount").val(formatNumber(totalTransactionAmount,2));
        var discountAmount =parseFloat($("#purchaseOrderClosing\\.discountAmount").val());
        $("#purchaseOrderClosing\\.discountAmount").val(formatNumber(discountAmount,2));
        var discountPercent =parseFloat($("#purchaseOrderClosing\\.discountPercent").val());
        $("#purchaseOrderClosing\\.discountPercent").val(formatNumber(discountPercent,2));
        var taxBaseAmount =parseFloat($("#purchaseOrderClosing\\.taxBaseSubTotalAmount").val());
        $("#purchaseOrderClosing\\.taxBaseSubTotalAmount").val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat($("#purchaseOrderClosing\\.vatPercent").val());
        $("#purchaseOrderClosing\\.vatPercent").val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat($("#purchaseOrderClosing\\.vatAmount").val());
        $("#purchaseOrderClosing\\.vatAmount").val(formatNumber(vatAmount,2));
        var otherFee =parseFloat($("#purchaseOrderClosing\\.otherFeeAmount").val());
        $("#purchaseOrderClosing\\.otherFeeAmount").val(formatNumber(otherFee,2));
        var grandTotalAmount =parseFloat($("#purchaseOrderClosing\\.grandTotalAmount").val());
        $("#purchaseOrderClosing\\.grandTotalAmount").val(formatNumber(grandTotalAmount,2));
    }  
    
</script>

<b>PURCHASE ORDER</b>
<hr>
<br class="spacer" />

<div id="purchaseOrderClosingInput" class="content ui-widget">
    <s:form id="frmPurchaseOrderClosingInput">
        <table cellpadding="2" cellspacing="2" id="headerPurchaseOrderClosingInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>POD No *</B></td>
                            <td>
                                <s:textfield id="purchaseOrderClosing.code" name="purchaseOrderClosing.code" key="purchaseOrderClosing.code" readonly="true" size="25"></s:textfield>    
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderClosing.branch.code" name="purchaseOrderClosing.branch.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderClosing.branch.name" name="purchaseOrderClosing.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="purchaseOrderClosing.transactionDate" name="purchaseOrderClosing.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" onchange="POTransactionDateOnChange()" readonly = "true" disabled="true"></sj:datepicker>
                                <sj:datepicker id="purchaseOrderClosingTransactionDate" name="purchaseOrderClosingTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Delivery Date</td>
                            <td>
                                <sj:datepicker id="purchaseOrderClosing.deliveryDateStart" name="purchaseOrderClosing.deliveryDateStart" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true" disabled="true" readonly = "true"></sj:datepicker>
                                <s:textfield id="purchaseOrderClosing.deliveryDateStartTemp" name="purchaseOrderClosing.deliveryDateStartTemp" size="20" cssStyle="display:none"></s:textfield> 
                                <B>To *</B>
                                <sj:datepicker id="purchaseOrderClosing.deliveryDateEnd" name="purchaseOrderClosing.deliveryDateEnd" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true" disabled="true" readonly = "true"></sj:datepicker>
                                <s:textfield id="purchaseOrderClosing.deliveryDateEndTemp" name="purchaseOrderClosing.deliveryDateEndTemp" size="20" cssStyle="display:none"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Payment Term *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderClosing.paymentTerm.code" name="purchaseOrderClosing.paymentTerm.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderClosing.paymentTerm.name" name="purchaseOrderClosing.paymentTerm.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Currency *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderClosing.currency.code" name="purchaseOrderClosing.currency.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderClosing.currency.name" name="purchaseOrderClosing.currency.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Vendor *</B></td>
                            <td>
                                <s:textfield  id="purchaseOrderClosing.vendor.code" name="purchaseOrderClosing.vendor.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderClosing.vendor.name" name="purchaseOrderClosing.vendor.name" size="20" readonly="true"></s:textfield>

                            </td>
                        </tr>
                        <tr>
                            <td align="right">Vendor Contact Person </td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderClosing.vendor.defaultContactPerson.code" name="purchaseOrderClosing.vendor.defaultContactPerson.code" size="20" readonly="true" cssStyle="display:none"></s:textfield>
                                <s:textfield id="purchaseOrderClosing.vendor.defaultContactPerson.name" name="purchaseOrderClosing.vendor.defaultContactPerson.name" size="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Local/Import </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderClosingVendorLocalImportStatusRad" name="purchaseOrderClosingVendorLocalImportStatusRad" label="purchaseOrderClosingVendorLocalImportStatusRad" list="{'Local','Import'}"></s:radio>
                                <s:textfield id="purchaseOrderClosing.vendor.localImport" name="purchaseOrderClosing.vendor.localImport" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Status </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderClosingPenaltyStatusRad" name="purchaseOrderClosingPenaltyStatusRad" label="purchaseOrderClosingPenaltyStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="purchaseOrderClosing.penaltyStatus" name="purchaseOrderClosing.penaltyStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrderClosing.penaltyPercent" name="purchaseOrderClosing.penaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Maximum Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrderClosing.maximumPenaltyPercent" name="purchaseOrderClosing.maximumPenaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="purchaseOrderClosing.purchaseOrderClosingType" name="purchaseOrderClosing.purchaseOrderClosingType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td><sj:a href="#" id="btnPurchaseOrderClosingSave" button="true" style="width: 60px">Close</sj:a>
                                <sj:a href="#" id="btnPurchaseOrderClosingCancel" button="true" style="width: 60px">Cancel</sj:a></td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td align = "right"><B>Bill To *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderClosing.billTo.code" name="purchaseOrderClosing.billTo.code" cssClass="required" required="true" title=" " cssStyle="width:78%" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderClosing.billTo.name" name="purchaseOrderClosing.billTo.name" readonly="true" cssStyle="width:25%"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrderClosing.billTo.address" name="purchaseOrderClosing.billTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrderClosing.billTo.contactPerson" name="purchaseOrderClosing.billTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrderClosing.billTo.phone1" name="purchaseOrderClosing.billTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right"><B>Ship To *</B></td>
                        <td colspan="2">
                            <s:textfield id="purchaseOrderClosing.shipTo.code" name="purchaseOrderClosing.shipTo.code" cssClass="required" required="true" title=" " cssStyle="width:78%" readonly="true"></s:textfield>
                            <s:textfield id="purchaseOrderClosing.shipTo.name" name="purchaseOrderClosing.shipTo.name" readonly="true" cssStyle="width:25%"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrderClosing.shipTo.address" name="purchaseOrderClosing.shipTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrderClosing.shipTo.contactPerson" name="purchaseOrderClosing.shipTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrderClosing.shipTo.phone1" name="purchaseOrderClosing.shipTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Ref No</td>
                        <td colspan="3"><s:textfield id="purchaseOrderClosing.refNo" name="purchaseOrderClosing.refNo" size="27" readonly="true"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td colspan="3"><s:textarea id="purchaseOrderClosing.remark" name="purchaseOrderClosing.remark" cols="43" rows="3" height="20" readonly="true"></s:textarea></td>
                    </tr> 
                </table>
            </td>
        </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="purchaseOrderClosingDateFirstSession" name="purchaseOrderClosingDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="purchaseOrderClosingDateLastSession" name="purchaseOrderClosingDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumPurchaseOrderClosingActivity" name="enumPurchaseOrderClosingActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="purchaseOrderClosing.createdBy" name="purchaseOrderClosing.createdBy" key="purchaseOrderClosing.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="purchaseOrderClosing.createdDate" name="purchaseOrderClosing.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="purchaseOrderClosing.createdDateTemp" name="purchaseOrderClosing.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        
        <br class="spacer" />
        <div id="purchaseOrderClosingPurchaseRequestDetailInputGrid">
            <sjg:grid
                id="purchaseOrderClosingPurchaseRequestDetailInput_grid"
                caption="PRQ Detail"
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
                width="1200"
            >
                <sjg:gridColumn
                    name="purchaseOrderClosingPurchaseRequestDetailCode" index="purchaseOrderClosingPurchaseRequestDetailCode" 
                    title="PRQ No *" width="200" sortable="true" 
                />     
                <sjg:gridColumn
                    name="purchaseOrderClosingPurchaseRequestDetailTransactionDate" index="purchaseOrderClosingPurchaseRequestDetailTransactionDate" key="purchaseOrderClosingPurchaseRequestDetailTransactionDate" 
                    title="PRQ Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="purchaseOrderClosingPurchaseRequestDetailDocumentType" index="purchaseOrderClosingPurchaseRequestDetailDocumentType" 
                    title="Document Type" width="70" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderClosingPurchaseRequestDetailProductionPlanningCode" index="purchaseOrderClosingPurchaseRequestDetailProductionPlanningCode" 
                    title="PPO No" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderClosingPurchaseRequestDetailBranchCode" index="purchaseOrderClosingPurchaseRequestDetailBranchCode" 
                    title="Branch Code" width="100" sortable="true" 
                />
                <sjg:gridColumn
                    name="purchaseOrderClosingPurchaseRequestDetailBranchName" index="purchaseOrderClosingPurchaseRequestDetailBranchName" 
                    title="Branch Name" width="200" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderClosingPurchaseRequestDetailRequestBy" index="purchaseOrderClosingPurchaseRequestDetailRequestBy" 
                    title="Request By" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "purchaseOrderClosingPurchaseRequestDetailRemark" index = "purchaseOrderClosingPurchaseRequestDetailRemark" key = "purchaseOrderClosingPurchaseRequestDetailRemark" 
                    title = "Remark" width = "200" 
                />
            </sjg:grid >               
        </div>         
        <br>
        <br>
        
            <div id="purchaseOrderClosingPurchaseRequestItemDetailIMRInputGrid">
                <sjg:grid
                    id="purchaseOrderClosingPurchaseRequestItemDetailInput_grid"
                    caption="PRQ Item Detail "
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseRequestNonItemMaterialRequestDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="1100"
                >                   
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestNo" index="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestNo" key="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestNo" 
                        title="PRQ No" width="200" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestDetailNo" index="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestDetailNo" key="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestDetailNo" 
                        title="PRQ Detail" width="200" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" index="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" key="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" 
                        title="Item Material Code" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialName" index="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialName" key="purchaseOrderClosingPurchaseRequestItemDetailPurchaseRequestItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailQuantity" index="purchaseOrderClosingPurchaseRequestItemDetailQuantity" 
                        title="Quantity" width="100" sortable="true" formatter="number"
                    /> 
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailUnitOfMeasureCode" index="purchaseOrderClosingPurchaseRequestItemDetailUnitOfMeasureCode" 
                        title="UOM" width="80" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailUnitOfMeasureName" index="purchaseOrderClosingPurchaseRequestItemDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true" hidden = "true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailPurchaseOrderCode" index="purchaseOrderClosingPurchaseRequestItemDetailPurchaseOrderCode" 
                        title="POD No" width="150" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailItemJnVendorCode" index="purchaseOrderClosingPurchaseRequestItemDetailItemJnVendorCode" 
                        title="Item Jn Vendor" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingPurchaseRequestItemDetailVendorCode" index="purchaseOrderClosingPurchaseRequestItemDetailVendorCode" 
                        title="Vendor" width="150" sortable="true" hidden="true"
                    />
                </sjg:grid >
            </div>
            <br>
            <br>
            
        <div id="purchaseOrderClosingDetailTable">    
            <div id="purchaseOrderClosingDetail">
                <sjg:grid
                    id="purchaseOrderClosingDetailInput_grid"
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
                    width="$('#tabmnupurchaseOrderClosingDetail').width()"
                    editurl="%{remoteurlPurchaseOrderClosingDetailInput}"
                    onSelectRowTopics="purchaseOrderClosingDetailInput_grid_onSelect"
                >          
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailPurchaseRequestCode" index="purchaseOrderClosingDetailPurchaseRequestCode" key="purchaseOrderClosingDetailPurchaseRequestCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true" editable="true" edittype="text"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailPurchaseRequestHeaderCode" index="purchaseOrderClosingDetailPurchaseRequestHeaderCode" key="purchaseOrderClosingDetailPurchaseRequestHeaderCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailPurchaseRequestDetailCode" index="purchaseOrderClosingDetailPurchaseRequestDetailCode" key="purchaseOrderClosingDetailPurchaseRequestDetailCode" 
                        title="PRQ Detail " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailItemMaterialCode" index="purchaseOrderClosingDetailItemMaterialCode" key="purchaseOrderClosingDetailItemMaterialCode" 
                        title="Item Material Code " width="150" sortable="true" hidden="false"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailItemMaterialName" index="purchaseOrderClosingDetailItemMaterialName" key="purchaseOrderClosingDetailItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailItemAlias" index="purchaseOrderClosingDetailItemAlias" 
                        title="Item Alias" width="80" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailRemark" index="purchaseOrderClosingDetailRemark" key="purchaseOrderClosingDetailRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailQuantity" index="purchaseOrderClosingDetailQuantity" key="purchaseOrderClosingDetailQuantity" 
                        title="POD Quantity" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderClosingDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailBonusQuantity" index="purchaseOrderClosingDetailBonusQuantity" key="purchaseOrderClosingDetailBonusQuantity" 
                        title="Bonus" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailUnitOfMeasureCode" index="purchaseOrderClosingDetailUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailUnitOfMeasureName" index="purchaseOrderClosingDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailPrice" index="purchaseOrderClosingDetailPrice" key="purchaseOrderClosingDetailPrice" 
                        title="Price" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailDiscPercent" index="purchaseOrderClosingDetailDiscPercent" key="purchaseOrderClosingDetailDiscPercent" 
                        title="Discount Percent" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailDiscAmount" index="purchaseOrderClosingDetailDiscAmount" key="purchaseOrderClosingDetailDiscAmount" 
                        title="Discount Amount" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailNettPrice" index="purchaseOrderClosingDetailNettPrice" key="purchaseOrderClosingDetailNettPrice" 
                        title="Nett Price" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingDetailTotalPrice" index="purchaseOrderClosingDetailTotalPrice" key="purchaseOrderClosingDetailTotalPrice" 
                        title="Total" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
            <br>
            <div id="purchaseOrderClosingDetailAddtional">
                <sjg:grid
                    id="purchaseOrderClosingAdditionalFeeInput_grid"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseOrderAdditonalFee"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnupurchaseOrderClosingAdditionalFee').width()"
                    editurl="%{remoteurlPurchaseOrderClosingAdditionalInput}"
                    onSelectRowTopics="purchaseOrderClosingAdditionalFeeInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeeCode" index="purchaseOrderClosingAdditionalFeeCode" key="purchaseOrderClosingAdditionalFeeCode" 
                        title="Additional Cost Code" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeeName" index="purchaseOrderClosingAdditionalFeeName" key="purchaseOrderClosingAdditionalFeeName" 
                        title="Additional Cost Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeePurchaseChartOfAccountCode" index="purchaseOrderClosingAdditionalFeePurchaseChartOfAccountCode" key="purchaseOrderClosingAdditionalFeePurchaseChartOfAccountCode" 
                        title="Chart Of Account Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeePurchaseChartOfAccountName" index="purchaseOrderClosingAdditionalFeePurchaseChartOfAccountName" key="purchaseOrderClosingAdditionalFeePurchaseChartOfAccountName" 
                        title="Chart Of Account Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeeRemark" index="purchaseOrderClosingAdditionalFeeRemark" key="purchaseOrderClosingAdditionalFeeRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeeQuantity" index="purchaseOrderClosingAdditionalFeeQuantity" key="purchaseOrderClosingAdditionalFeeQuantity" 
                        title="Quantity" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeeUnitOfMeasureCode" index="purchaseOrderClosingDetailUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeeUnitOfMeasureName" index="purchaseOrderClosingDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeePrice" index="purchaseOrderClosingAdditionalFeePrice" key="purchaseOrderClosingAdditionalFeePrice" 
                        title="Price" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderClosingAdditionalFeeTotal" index="purchaseOrderClosingAdditionalFeeTotal" key="purchaseOrderClosingAdditionalFeeTotal" 
                        title="Total" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
            <table>
            </table>
            </div> 
            
            <br>
            <br>
            <div id="PurchaseOrderClosingItemDeliveryDate">
                <table>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="purchaseOrderClosingItemDeliveryInput_grid"
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
                                            width="500"
                                            editurl="%{remoteurlPurchaseOrderClosingItemDeliveryInput}"
                                            onSelectRowTopics="purchaseOrderClosingItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="purchaseOrderClosingItemDelivery" index="purchaseOrderClosingItemDelivery" key="purchaseOrderClosingItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name = "purchaseOrderClosingItemDeliveryItemMaterialCode" index = "purchaseOrderClosingItemDeliveryItemMaterialCode" key = "purchaseOrderClosingItemDeliveryItemMaterialCode" 
                                                title = "Item Material Code" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "purchaseOrderClosingItemDeliveryItemMaterialName" index = "purchaseOrderClosingItemDeliveryItemMaterialName" key = "purchaseOrderClosingItemDeliveryItemMaterialName" 
                                                title = "tem Material Name" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderClosingItemDeliveryQuantity" index="purchaseOrderClosingItemDeliveryQuantity" key="purchaseOrderClosingItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="false" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderClosingItemDeliveryDeliveryDate" index="purchaseOrderClosingItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="false" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: false, required:false}" 
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderClosingItemDeliveryDeliveryDateTemp" index="purchaseOrderClosingItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                            /> 
                                        </sjg:grid >
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
                                <s:textfield id="purchaseOrderClosing.totalTransactionAmount" name="purchaseOrderClosing.totalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="left"><B>Discount</B>
                            <s:textfield id="purchaseOrderClosing.discountPercent" name="purchaseOrderClosing.discountPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                %
                            <s:textfield id="purchaseOrderClosing.discountAmount" name="purchaseOrderClosing.discountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td></td>
                            <td align="left"> Descriptions</td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                <s:textfield id="purchaseOrderClosing.discountChartOfAccount.code" name="purchaseOrderClosing.discountChartOfAccount.code" readonly="true" title=" " size = "15"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderClosing.discountChartOfAccount.name" name="purchaseOrderClosing.discountChartOfAccount.name" title=" " size = "20" readonly = "true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderClosing.discountDescription" name="purchaseOrderClosing.discountDescription" title=" " PlaceHolder=" Description Discount" size ="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sub Total (Tax Base)</B>
                                <s:textfield id="purchaseOrderClosing.taxBaseSubTotalAmount" name="purchaseOrderClosing.taxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                            <s:textfield id="purchaseOrderClosing.vatPercent" name="purchaseOrderClosing.vatPercent" cssStyle="text-align:right;" size="8" readonly="true"></s:textfield>
                                %
                            <s:textfield id="purchaseOrderClosing.vatAmount" name="purchaseOrderClosing.vatAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td/>
                        </tr>
                        <tr>
                            <td align="right"><B>Other Fee</B>
                                <s:textfield id="purchaseOrderClosing.otherFeeAmount" name="purchaseOrderClosing.otherFeeAmount" cssStyle="text-align:right;%" readonly="true"></s:textfield>
                            </td>
                            <td/>
                             <td align="left"> Descriptions </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                <s:textfield id="purchaseOrderClosing.otherFeeChartOfAccount.code" name="purchaseOrderClosing.otherFeeChartOfAccount.code" title=" " size = "15" readonly="true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderClosing.otherFeeChartOfAccount.name" name="purchaseOrderClosing.otherFeeChartOfAccount.name" title=" " readonly="true"></s:textfield>
                            </td>
                            <td align="right">
                                <s:textfield id="purchaseOrderClosing.otherFeeDescription" name="purchaseOrderClosing.otherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B>
                                <s:textfield id="purchaseOrderClosing.grandTotalAmount" name="purchaseOrderClosing.grandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                            </td>
                            <td/>
                        </tr>
                    </table>
                </fieldset>            
                </td>
            </tr>       
        </table>
    </div>      
</s:form>
<br class="spacer" />
<br class="spacer" />