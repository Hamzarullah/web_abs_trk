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
     var purchaseOrderApprovalDetaillastSel = -1,
         purchaseOrderApprovalDetaillastRowId = 0,
         purchaseOrderApprovalPurchaseRequestlastSel = -1,
         purchaseOrderApprovalPurchaseRequestRowId = 0,
         purchaseOrderApprovalPRNonIMRlastSel = -1,
         purchaseOrderApprovalPRNonIMRRowId = 0,
         purchaseOrderApprovalDetailRowId = 0,
         purchaseOrderApprovalDetaillastsel = -1,
         purchaseOrderApprovalDetailAdditionalRowId = 0,
         purchaseOrderApprovalDetailAdditionallastsel = -1,
         purchaseOrderApprovalDetailItemDeliveryRowId = 0,
         purchaseOrderApprovalDetailItemDeliverylastsel = -1;
    
    var 
        rdbPurchaseOrderApprovalStatus = $("#purchaseOrderApproval\\.approvalStatus"),
        txtPurchaseOrderApprovalReasonCode = $("#purchaseOrderApproval\\.approvalReason\\.code"),
        txtPurchaseOrderApprovalReasonName = $("#purchaseOrderApproval\\.approvalReason\\.name"),
        txtPurchaseOrderApprovalRemark = $("#purchaseOrderApproval\\.approvalRemark");
        
    $(document).ready(function() {
        hoverButton();
        
        formatNumericPOApproval();
        if($("#enumPurchaseOrderApprovalActivity").val() === "UPDATE"){
            loadImportLocalApproval($("#purchaseOrderApproval\\.vendor\\.localImport").val());
            if ($("#purchaseOrderApproval\\.penaltyStatus").val()== true){
                $('#purchaseOrderApprovalPenaltyStatusRadYES').prop('checked',true);
                enabledDisabledPenaltyPercentApproval('YES');
            }else{
                $('#purchaseOrderApprovalPenaltyStatusRadNO').prop('checked',true);
                enabledDisabledPenaltyPercentApproval('NO');
            }
        }
        
        $('#purchaseOrderApprovalStatusRadAPPROVED').change(function(ev){
            $("#purchaseOrderApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('#purchaseOrderApprovalStatusRadREJECTED').change(function(ev){
            $("#purchaseOrderApproval\\.approvalStatus").val("REJECTED");
        });
            loadPurchaseRequestDetailApproval();
            loadPurchaseOrderApprovalPR();
            loadPODetailApproval();
            loadPOApprovalAdditionalFee();
            loadItemDeliveryDateApproval();
            
        $('#btnPurchaseOrderApprovalSave').click(function(ev) {
               var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Update Status?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>PO No: '+$("#purchaseOrderApproval\\.code").val()+'<br/><br/>' +    
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
                                            var url = "purchase/purchase-order-approval-status";
                                            var params = $("#frmPurchaseOrderApprovalInput").serialize();
                                            $.post(url, params, function(data) {
                                                if (data.error) {
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                                alertMessage(data.message);

                                                var url = "purchase/purchase-order-approval";
                                                var params = "";
                                                pageLoad(url, params, "#tabmnuPURCHASE_ORDER_APPROVAL"); 
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
        
        $('#btnPurchaseOrderApprovalCancel').click(function(ev) {
            var url = "purchasing/purchase-order-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER_APPROVAL"); 
        });
    });

    function radioButtonStatusPurchaseOrder(){
        if ($("#purchaseOrderApproval\\.approvalStatus").val()==="APPROVED"){
            $('#purchaseOrderApprovalStatusRadAPPROVED').prop('checked',true);
        }
        if ($("#purchaseOrderApproval\\.approvalStatus").val()==="REVIEWING"){
            $('#purchaseOrderApprovalStatusRadREJECTED').prop('checked',true);
        }

    }

    function loadImportLocalApproval(localImport){
        if (localImport==='LOCAL'){
             $('#purchaseOrderApprovalVendorLocalImportStatusRadLocal').prop('checked',true);
             $('#purchaseOrderApprovalVendorLocalImportStatusRadImport').prop('disabled',true);
             $("#purchaseOrderApproval\\.vendor\\.localImport").val("LOCAL");
        }
        else{
            $('#purchaseOrderApprovalVendorLocalImportStatusRadImport').prop('checked',true);
            $('#purchaseOrderApprovalVendorLocalImportStatusRadLocal').prop('disabled',true);
            $("#purchaseOrderApproval\\.vendor\\.localImport").val("IMPORT");
        }
    }
    
    function enabledDisabledPenaltyPercentApproval(percentType){
        switch(percentType){
            case "YES":   
                $("#purchaseOrderApproval\\.penaltyPercent").attr('readonly',true);
                $('#purchaseOrderApprovalPenaltyStatusRadYES').prop('checked',true);
                $("#purchaseOrderApprovalPenaltyStatusRadNO").prop('disabled',true);
                $("#purchaseOrderApproval\\.penaltyPercent").focus();
                $("#purchaseOrderApproval\\.maximumPenaltyPercent").attr('readonly',true);
                $("#purchaseOrderApproval\\.maximumPenaltyPercent").val("0.00");
                $("#purchaseOrderApproval\\.penaltyPercent").val("0.00");
                break;
            case "NO":
                $("#purchaseOrderApproval\\.penaltyPercent").attr('readonly',true);
                $('#purchaseOrderApprovalPenaltyStatusRadNO').prop('checked',true);
                $("#purchaseOrderApprovalPenaltyStatusRadYES").prop('disabled',true);
                $("#purchaseOrderApproval\\.penaltyPercent").focus();
                $("#purchaseOrderApproval\\.maximumPenaltyPercent").attr('readonly',true);
                $("#purchaseOrderApproval\\.maximumPenaltyPercent").val("0.00");
                $("#purchaseOrderApproval\\.penaltyPercent").val("0.00");
                break;
        }
    }
    
    function loadPurchaseRequestDetailApproval(){   
        
        var url = "purchase/purchase-order-purchase-request-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderApproval\\.code").val();   
        
        purchaseOrderApprovalPurchaseRequestRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderPurchaseRequestDetail.length; i++) {
                purchaseOrderApprovalPurchaseRequestRowId++;
                var purchaseRequestTransactionDate=formatDateRemoveT(data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestTransactionDate, true);
                
                $("#purchaseOrderApprovalPurchaseRequestDetailInput_grid").jqGrid("addRowData", purchaseOrderApprovalPurchaseRequestRowId, data.listPurchaseOrderPurchaseRequestDetail[i]);
                $("#purchaseOrderApprovalPurchaseRequestDetailInput_grid").jqGrid('setRowData',purchaseOrderApprovalPurchaseRequestRowId,{
                    purchaseOrderApprovalPurchaseRequestDetailCode                      : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestCode,
                    purchaseOrderApprovalPurchaseRequestDetailTransactionDate           : purchaseRequestTransactionDate,
                    purchaseOrderApprovalPurchaseRequestDetailDocumentType              : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestType,
                    purchaseOrderApprovalPurchaseRequestDetailProductionPlanningCode    : data.listPurchaseOrderPurchaseRequestDetail[i].ppoCode,
                    purchaseOrderApprovalPurchaseRequestDetailBranchCode                : data.listPurchaseOrderPurchaseRequestDetail[i].branchCode,
                    purchaseOrderApprovalPurchaseRequestDetailBranchName                : data.listPurchaseOrderPurchaseRequestDetail[i].branchName,
                    purchaseOrderApprovalPurchaseRequestDetailRequestBy                 : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRequestBy,
                    purchaseOrderApprovalPurchaseRequestDetailRemark                    : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRemark
  
                });
                
                loadPurchaseOrderApprovalPR(data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestCode);
            }
        });
        closeLoading();
    }
    
    function loadPurchaseOrderApprovalPR(data){
        var arrPurchaseOrderApprovalPRQNo=new Array();
            arrPurchaseOrderApprovalPRQNo.push(data);
       
        var url = "purchasing/purchase-request-item-material-request-detail-data";
        var params = "arrPurchaseOrderNo=" + arrPurchaseOrderApprovalPRQNo;
        
        purchaseOrderApprovalPRNonIMRRowId = 0;
        $.getJSON(url, params, function(data) {
            for (var i=0; i<data.listPurchaseRequestNonItemMaterialRequestDetail.length; i++) {
                purchaseOrderApprovalPRNonIMRRowId++;
                $("#purchaseOrderApprovalPurchaseRequestItemDetailInput_grid").jqGrid("addRowData", purchaseOrderApprovalPRNonIMRRowId, data.listPurchaseRequestNonItemMaterialRequestDetail[i]);
                $("#purchaseOrderApprovalPurchaseRequestItemDetailInput_grid").jqGrid('setRowData',purchaseOrderApprovalPRNonIMRRowId,{
                    purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestNo                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].headerCode,
                    purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestDetailNo           : data.listPurchaseRequestNonItemMaterialRequestDetail[i].code,
                    purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialCode   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialCode,
                    purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialName   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialName,
                    purchaseOrderApprovalPurchaseRequestItemDetailQuantity                          : data.listPurchaseRequestNonItemMaterialRequestDetail[i].quantity,
                    purchaseOrderApprovalPurchaseRequestItemDetailUnitOfMeasureCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseOrderApprovalPurchaseRequestItemDetailUnitOfMeasureName                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseOrderApprovalPurchaseRequestItemDetailPurchaseOrderCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].poCode,
                    purchaseOrderApprovalPurchaseRequestItemDetailItemJnVendorCode                  : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialJnVendor,
                    purchaseOrderApprovalPurchaseRequestItemDetailVendorCode                        : data.listPurchaseRequestNonItemMaterialRequestDetail[i].vendorCode
                });
            }
            
        }); 
    }
    
    function loadPODetailApproval(){            
        var url = "purchase/purchase-order-detail-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderApproval\\.code").val();   
        
        purchaseOrderApprovalDetailRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderDetail.length; i++) {
                purchaseOrderApprovalDetailRowId++;
                
                $("#purchaseOrderApprovalDetailInput_grid").jqGrid("addRowData", purchaseOrderApprovalDetailRowId, data.listPurchaseOrderDetail[i]);
                $("#purchaseOrderApprovalDetailInput_grid").jqGrid('setRowData', purchaseOrderApprovalDetailRowId,{
                    purchaseOrderApprovalDetailPurchaseRequestCode              : data.listPurchaseOrderDetail[i].purchaseRequestCode,
                    purchaseOrderApprovalDetailPurchaseRequestHeaderCode        : data.listPurchaseOrderDetail[i].headerCode,
                    purchaseOrderApprovalDetailPurchaseRequestDetailCode        : data.listPurchaseOrderDetail[i].code,
                    purchaseOrderApprovalDetailItemMaterialCode                 : data.listPurchaseOrderDetail[i].itemMaterialCode,
                    purchaseOrderApprovalDetailItemMaterialName                 : data.listPurchaseOrderDetail[i].itemMaterialName,
                    purchaseOrderApprovalDetailItemAlias                        : data.listPurchaseOrderDetail[i].itemAlias,
                    purchaseOrderApprovalDetailRemark                           : data.listPurchaseOrderDetail[i].remark,
                    purchaseOrderApprovalDetailQuantity                         : data.listPurchaseOrderDetail[i].quantity,
                    purchaseOrderApprovalDetailBonusQuantity                    : data.listPurchaseOrderDetail[i].bonusQuantity,
                    purchaseOrderApprovalDetailUnitOfMeasureCode                : data.listPurchaseOrderDetail[i].unitOfMeasureCode,
                    purchaseOrderApprovalDetailUnitOfMeasureName                : data.listPurchaseOrderDetail[i].unitOfMeasureName,
                    purchaseOrderApprovalDetailPrice                            : data.listPurchaseOrderDetail[i].price,
                    purchaseOrderApprovalDetailDiscPercent                      : data.listPurchaseOrderDetail[i].discountPercent,
                    purchaseOrderApprovalDetailDiscAmount                       : data.listPurchaseOrderDetail[i].discountAmount,
                    purchaseOrderApprovalDetailNettPrice                        : data.listPurchaseOrderDetail[i].nettPrice,
                    purchaseOrderApprovalDetailTotalPrice                       : data.listPurchaseOrderDetail[i].totalAmount
  
                });
            }
        });
        closeLoading();
    }
    
    function loadPOApprovalAdditionalFee(){
        var url = "purchase/purchase-order-additional-fee-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderApproval\\.code").val();   
        
        purchaseOrderApprovalDetailAdditionalRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderAdditionalFee.length; i++) {
                purchaseOrderApprovalDetailAdditionalRowId++;
                
                $("#purchaseOrderApprovalAdditionalFeeInput_grid").jqGrid("addRowData", purchaseOrderApprovalDetailAdditionalRowId, data.listPurchaseOrderAdditionalFee[i]);
                $("#purchaseOrderApprovalAdditionalFeeInput_grid").jqGrid('setRowData',purchaseOrderApprovalDetailAdditionalRowId,{
                    purchaseOrderApprovalDetailAdditionalFeeCode                    : data.listPurchaseOrderAdditionalFee[i].code,
                    purchaseOrderApprovalAdditionalFeeCode                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeCode,
                    purchaseOrderApprovalAdditionalFeeName                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeName,
                    purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountCode    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountCode,
                    purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountName    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountName,
                    purchaseOrderApprovalAdditionalFeeRemark                        : data.listPurchaseOrderAdditionalFee[i].remark,
                    purchaseOrderApprovalAdditionalFeeQuantity                      : data.listPurchaseOrderAdditionalFee[i].quantity,
                    purchaseOrderApprovalAdditionalFeeUnitOfMeasureCode             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureCode,
                    purchaseOrderApprovalAdditionalFeeUnitOfMeasureName             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureName,
                    purchaseOrderApprovalAdditionalFeePrice                         : data.listPurchaseOrderAdditionalFee[i].price,
                    purchaseOrderApprovalAdditionalFeeTotal                         : data.listPurchaseOrderAdditionalFee[i].total
  
                });
            }
        });
        closeLoading();
    }
    
    function loadItemDeliveryDateApproval(){
         if($("#enumPurchaseOrderApprovalActivity").val()==="NEW"){
            return;
        }                
        
        var url = "purchase/purchase-order-item-delivery-date-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderApproval\\.code").val();   
        
        purchaseOrderApprovalDetailItemDeliveryRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderItemDeliveryDate.length; i++) {
                purchaseOrderApprovalDetailItemDeliveryRowId++;
                var deliveryDate=formatDateRemoveT(data.listPurchaseOrderItemDeliveryDate[i].deliveryDate, false);
                $("#purchaseOrderApprovalItemDeliveryInput_grid").jqGrid("addRowData", purchaseOrderApprovalDetailItemDeliveryRowId, data.listPurchaseOrderItemDeliveryDate[i]);
                $("#purchaseOrderApprovalItemDeliveryInput_grid").jqGrid('setRowData',purchaseOrderApprovalDetailItemDeliveryRowId,{
                    purchaseOrderApprovalItemDeliveryItemMaterialCode               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialCode,
                    purchaseOrderApprovalItemDeliveryItemMaterialName               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialName,
                    purchaseOrderApprovalItemDeliveryQuantity                       : data.listPurchaseOrderItemDeliveryDate[i].quantity,
                    purchaseOrderApprovalItemDeliveryDeliveryDate                   : deliveryDate
  
                });
            }
        });
        closeLoading();
    }
    
    function clearAmountPurchaseOrderApprovalHeader(){
        txtPurchaseOrderApprovalTotalTransactionAmount.val("0.00");
        txtPurchaseOrderApprovalDiscountPercent.val("0.00");
        txtPurchaseOrderApprovalDiscountAmount.val("0.00");
        txtPurchaseOrderApprovalTaxBaseSubTotalAmount.val("0.00");
        txtPurchaseOrderApprovalVATPercent.val("0.00");
        txtPurchaseOrderApprovalVATAmount.val("0.00");
        txtPurchaseOrderApprovalOtherFeeAmount.val("0.00");
        txtPurchaseOrderApprovalGrandTotalAmount.val("0.00");
    }
    
    function validationComma(){

        var totalTransaction = txtPurchaseOrderApprovalTotalTransactionAmount.val().replace(/,/g, "");
        var discountAmount = txtPurchaseOrderApprovalDiscountAmount.val().replace(/,/g, "");
        var taxBaseSubTotalAmount = txtPurchaseOrderApprovalTaxBaseSubTotalAmount.val().replace(/,/g, "");
        var taxAmount = txtPurchaseOrderApprovalVATAmount.val().replace(/,/g, "");
        var otherFee = txtPurchaseOrderApprovalOtherFeeAmount.val().replace(/,/g, "");
        var grandTotal = txtPurchaseOrderApprovalGrandTotalAmount.val().replace(/,/g, "");

        txtPurchaseOrderApprovalTotalTransactionAmount.val(totalTransaction);
        txtPurchaseOrderApprovalDiscountAmount.val(discountAmount);
        txtPurchaseOrderApprovalVATAmount.val(taxAmount);
        txtPurchaseOrderApprovalTaxBaseSubTotalAmount.val(taxBaseSubTotalAmount);
        txtPurchaseOrderApprovalOtherFeeAmount.val(otherFee);
        txtPurchaseOrderApprovalGrandTotalAmount.val(grandTotal);

    }
    
    function unFormatNumericPO(){ 
        var totalTransactionAmount = removeCommas($("#purchaseOrderApproval\\.totalTransactionAmount").val());
        var discountPercent =removeCommas($("#purchaseOrderApproval\\.discountPercent").val());
        var discountAmount =removeCommas($("#purchaseOrderApproval\\.discountAmount").val());
        var taxBaseSubTotalAmount =removeCommas($("#purchaseOrderApproval\\.taxBaseSubTotalAmount").val());
        var vatPercent = removeCommas($("#purchaseOrderApproval\\.vatPercent").val());
        var vatAmount = removeCommas($("#purchaseOrderApproval\\.vatAmount").val());
        var otherFee = removeCommas($("#purchaseOrderApproval\\.otherFeeAmount").val());
        var grandTotalAmount =removeCommas($("#purchaseOrderApproval\\.grandTotalAmount").val());

        $("#purchaseOrderApproval\\.totalTransactionAmount").val(totalTransactionAmount);
        $("#purchaseOrderApproval\\.discountPercent").val(discountPercent);
        $("#purchaseOrderApproval\\.discountAmount").val(discountAmount);
        $("#purchaseOrderApproval\\.taxBaseSubTotalAmount").val(taxBaseSubTotalAmount);
        $("#purchaseOrderApproval\\.vatPercent").val(vatPercent);
        $("#purchaseOrderApproval\\.vatAmount").val(vatAmount);
        $("#purchaseOrderApproval\\.otherFeeAmount").val(otherFee);
        $("#purchaseOrderApproval\\.grandTotalAmount").val(grandTotalAmount);
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
    
    function formatNumericPOApproval(){
        var totalTransactionAmount =parseFloat($("#purchaseOrderApproval\\.totalTransactionAmount").val());
        $("#purchaseOrderApproval\\.totalTransactionAmount").val(formatNumber(totalTransactionAmount,2));
        var discountAmount =parseFloat($("#purchaseOrderApproval\\.discountAmount").val());
        $("#purchaseOrderApproval\\.discountAmount").val(formatNumber(discountAmount,2));
        var discountPercent =parseFloat($("#purchaseOrderApproval\\.discountPercent").val());
        $("#purchaseOrderApproval\\.discountPercent").val(formatNumber(discountPercent,2));
        var taxBaseAmount =parseFloat($("#purchaseOrderApproval\\.taxBaseSubTotalAmount").val());
        $("#purchaseOrderApproval\\.taxBaseSubTotalAmount").val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat($("#purchaseOrderApproval\\.vatPercent").val());
        $("#purchaseOrderApproval\\.vatPercent").val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat($("#purchaseOrderApproval\\.vatAmount").val());
        $("#purchaseOrderApproval\\.vatAmount").val(formatNumber(vatAmount,2));
        var otherFee =parseFloat($("#purchaseOrderApproval\\.otherFeeAmount").val());
        $("#purchaseOrderApproval\\.otherFeeAmount").val(formatNumber(otherFee,2));
        var grandTotalAmount =parseFloat($("#purchaseOrderApproval\\.grandTotalAmount").val());
        $("#purchaseOrderApproval\\.grandTotalAmount").val(formatNumber(grandTotalAmount,2));
    }  
    
</script>

<b>PURCHASE ORDER</b>
<hr>
<br class="spacer" />

<div id="purchaseOrderApprovalInput" class="content ui-widget">
    <s:form id="frmPurchaseOrderApprovalInput">
        <table cellpadding="2" cellspacing="2" id="headerPurchaseOrderApprovalInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>POD No *</B></td>
                            <td>
                                <s:textfield id="purchaseOrderApproval.code" name="purchaseOrderApproval.code" key="purchaseOrderApproval.code" readonly="true" size="25"></s:textfield>    
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderApproval.branch.code" name="purchaseOrderApproval.branch.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderApproval.branch.name" name="purchaseOrderApproval.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="purchaseOrderApproval.transactionDate" name="purchaseOrderApproval.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" onchange="POTransactionDateOnChange()" readonly = "true" disabled="true"></sj:datepicker>
                                <sj:datepicker id="purchaseOrderApprovalTransactionDate" name="purchaseOrderApprovalTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Delivery Date</td>
                            <td>
                                <sj:datepicker id="purchaseOrderApproval.deliveryDateStart" name="purchaseOrderApproval.deliveryDateStart" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true" disabled="true" readonly = "true"></sj:datepicker>
                                <s:textfield id="purchaseOrderApproval.deliveryDateStartTemp" name="purchaseOrderApproval.deliveryDateStartTemp" size="20" cssStyle="display:none"></s:textfield> 
                                <B>To *</B>
                                <sj:datepicker id="purchaseOrderApproval.deliveryDateEnd" name="purchaseOrderApproval.deliveryDateEnd" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true" disabled="true" readonly = "true"></sj:datepicker>
                                <s:textfield id="purchaseOrderApproval.deliveryDateEndTemp" name="purchaseOrderApproval.deliveryDateEndTemp" size="20" cssStyle="display:none"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Payment Term *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderApproval.paymentTerm.code" name="purchaseOrderApproval.paymentTerm.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderApproval.paymentTerm.name" name="purchaseOrderApproval.paymentTerm.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Currency *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderApproval.currency.code" name="purchaseOrderApproval.currency.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderApproval.currency.name" name="purchaseOrderApproval.currency.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Vendor *</B></td>
                            <td>
                                <s:textfield  id="purchaseOrderApproval.vendor.code" name="purchaseOrderApproval.vendor.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderApproval.vendor.name" name="purchaseOrderApproval.vendor.name" size="20" readonly="true"></s:textfield>

                            </td>
                        </tr>
                        <tr>
                            <td align="right">Vendor Contact Person </td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderApproval.vendor.defaultContactPerson.code" name="purchaseOrderApproval.vendor.defaultContactPerson.code" size="20" readonly="true" cssStyle="display:none"></s:textfield>
                                <s:textfield id="purchaseOrderApproval.vendor.defaultContactPerson.name" name="purchaseOrderApproval.vendor.defaultContactPerson.name" size="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Local/Import </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderApprovalVendorLocalImportStatusRad" name="purchaseOrderApprovalVendorLocalImportStatusRad" label="purchaseOrderApprovalVendorLocalImportStatusRad" list="{'Local','Import'}"></s:radio>
                                <s:textfield id="purchaseOrderApproval.vendor.localImport" name="purchaseOrderApproval.vendor.localImport" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Status </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderApprovalPenaltyStatusRad" name="purchaseOrderApprovalPenaltyStatusRad" label="purchaseOrderApprovalPenaltyStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="purchaseOrderApproval.penaltyStatus" name="purchaseOrderApproval.penaltyStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrderApproval.penaltyPercent" name="purchaseOrderApproval.penaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Maximum Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrderApproval.maximumPenaltyPercent" name="purchaseOrderApproval.maximumPenaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="purchaseOrderApproval.purchaseOrderApprovalType" name="purchaseOrderApproval.purchaseOrderApprovalType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Purchase Order Status</B></td>
                            <s:textfield id="purchaseOrderApproval.approvalStatus" name="purchaseOrderApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                            <td><s:radio id="purchaseOrderApprovalStatusRad" name="purchaseOrderApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Purchase Order Reason</td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                $('#purchaseOrderApproval_btnReason').click(function(ev) {
                                    window.open("./pages/search/search-reason.jsp?iddoc=purchaseOrderApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
                                });

                                txtPurchaseOrderApprovalReasonCode.change(function(ev) {

                                    if(txtPurchaseOrderApprovalReasonCode.val()===""){
                                        txtPurchaseOrderApprovalReasonCode.val("");
                                        txtPurchaseOrderApprovalReasonName.val("");
                                               return;
                                            }
                                    var url = "master/reason-get";
                                    var params = "reason.code=" + txtPurchaseOrderApprovalReasonCode.val();
                                        params += "&reason.activeStatus=TRUE";
                                        alert(params);
                                        return;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                        if (data.reasonTemp){
                                            txtPurchaseOrderApprovalReasonCode.val(data.reasonTemp.code);
                                            txtPurchaseOrderApprovalReasonName.val(data.reasonTemp.name);
                                                }
                                                else{
                                            alertMessage("Reason Not Found!",txtPurchaseOrderApprovalReasonCode);
                                            txtPurchaseOrderApprovalReasonCode.val("");
                                            txtPurchaseOrderApprovalReasonName.val("");
                                                }
                                            });
                                        });
                                        </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="purchaseOrderApproval.approvalReason.code" name="purchaseOrderApproval.approvalReason.code" size="15"></s:textfield>
                                    <sj:a id="purchaseOrderApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="purchaseOrderApproval.approvalReason.name" name="purchaseOrderApproval.approvalReason.name" size="25" readonly="true"></s:textfield>
                            </td>    
                        </tr>
                        <tr>
                            <td align="right" valign="top">Purchase Order Remark</td>
                            <td colspan="3">
                                <s:textarea id="purchaseOrderApproval.approvalRemark" name="purchaseOrderApproval.approvalRemark"  cols="40" rows="2" height="30" readonly="false"></s:textarea>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                <table>
                    <tr>
                        <td align = "right"><B>Bill To *</B></td>
                        <td colspan="2">
                            <s:textfield id="purchaseOrderApproval.billTo.code" name="purchaseOrderApproval.billTo.code" cssClass="required" required="true" title=" " cssStyle="width:78%" readonly="true"></s:textfield>
                            <s:textfield id="purchaseOrderApproval.billTo.name" name="purchaseOrderApproval.billTo.name" readonly="true" cssStyle="width:25%"></s:textfield>
                    </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrderApproval.billTo.address" name="purchaseOrderApproval.billTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrderApproval.billTo.contactPerson" name="purchaseOrderApproval.billTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrderApproval.billTo.phone1" name="purchaseOrderApproval.billTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right"><B>Ship To *</B></td>
                        <td colspan="2">
                            <s:textfield id="purchaseOrderApproval.shipTo.code" name="purchaseOrderApproval.shipTo.code" cssClass="required" required="true" title=" " cssStyle="width:78%" readonly="true"></s:textfield>
                            <s:textfield id="purchaseOrderApproval.shipTo.name" name="purchaseOrderApproval.shipTo.name" readonly="true" cssStyle="width:25%"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrderApproval.shipTo.address" name="purchaseOrderApproval.shipTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrderApproval.shipTo.contactPerson" name="purchaseOrderApproval.shipTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrderApproval.shipTo.phone1" name="purchaseOrderApproval.shipTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Ref No</td>
                        <td colspan="3"><s:textfield id="purchaseOrderApproval.refNo" name="purchaseOrderApproval.refNo" size="27" readonly="true"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td colspan="3"><s:textarea id="purchaseOrderApproval.remark" name="purchaseOrderApproval.remark" cols="43" rows="3" height="20" readonly="true"></s:textarea></td>
                    </tr> 
                </table>
            </td>
        </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="purchaseOrderApprovalDateFirstSession" name="purchaseOrderApprovalDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="purchaseOrderApprovalDateLastSession" name="purchaseOrderApprovalDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumPurchaseOrderApprovalActivity" name="enumPurchaseOrderApprovalActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="purchaseOrderApproval.createdBy" name="purchaseOrderApproval.createdBy" key="purchaseOrderApproval.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="purchaseOrderApproval.createdDate" name="purchaseOrderApproval.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="purchaseOrderApproval.createdDateTemp" name="purchaseOrderApproval.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        
        <br class="spacer" />
        <div id="purchaseOrderApprovalPurchaseRequestDetailInputGrid">
            <sjg:grid
                id="purchaseOrderApprovalPurchaseRequestDetailInput_grid"
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
                    name="purchaseOrderApprovalPurchaseRequestDetailCode" index="purchaseOrderApprovalPurchaseRequestDetailCode" 
                    title="PRQ No *" width="200" sortable="true" 
                />     
                <sjg:gridColumn
                    name="purchaseOrderApprovalPurchaseRequestDetailTransactionDate" index="purchaseOrderApprovalPurchaseRequestDetailTransactionDate" key="purchaseOrderApprovalPurchaseRequestDetailTransactionDate" 
                    title="PRQ Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="purchaseOrderApprovalPurchaseRequestDetailDocumentType" index="purchaseOrderApprovalPurchaseRequestDetailDocumentType" 
                    title="Document Type" width="70" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderApprovalPurchaseRequestDetailProductionPlanningCode" index="purchaseOrderApprovalPurchaseRequestDetailProductionPlanningCode" 
                    title="PPO No" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderApprovalPurchaseRequestDetailBranchCode" index="purchaseOrderApprovalPurchaseRequestDetailBranchCode" 
                    title="Branch Code" width="100" sortable="true" 
                />
                <sjg:gridColumn
                    name="purchaseOrderApprovalPurchaseRequestDetailBranchName" index="purchaseOrderApprovalPurchaseRequestDetailBranchName" 
                    title="Branch Name" width="200" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderApprovalPurchaseRequestDetailRequestBy" index="purchaseOrderApprovalPurchaseRequestDetailRequestBy" 
                    title="Request By" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "purchaseOrderApprovalPurchaseRequestDetailRemark" index = "purchaseOrderApprovalPurchaseRequestDetailRemark" key = "purchaseOrderApprovalPurchaseRequestDetailRemark" 
                    title = "Remark" width = "200" 
                />
            </sjg:grid >               
        </div>         
        <br>
        <br>
        
            <div id="purchaseOrderApprovalPurchaseRequestItemDetailIMRInputGrid">
                <sjg:grid
                    id="purchaseOrderApprovalPurchaseRequestItemDetailInput_grid"
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
                        name="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestNo" index="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestNo" key="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestNo" 
                        title="PRQ No" width="200" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestDetailNo" index="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestDetailNo" key="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestDetailNo" 
                        title="PRQ Detail" width="200" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" index="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" key="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" 
                        title="Item Material Code" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialName" index="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialName" key="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseRequestItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailQuantity" index="purchaseOrderApprovalPurchaseRequestItemDetailQuantity" 
                        title="Quantity" width="100" sortable="true" formatter="number"
                    /> 
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailUnitOfMeasureCode" index="purchaseOrderApprovalPurchaseRequestItemDetailUnitOfMeasureCode" 
                        title="UOM" width="80" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailUnitOfMeasureName" index="purchaseOrderApprovalPurchaseRequestItemDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true" hidden = "true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseOrderCode" index="purchaseOrderApprovalPurchaseRequestItemDetailPurchaseOrderCode" 
                        title="POD No" width="150" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailItemJnVendorCode" index="purchaseOrderApprovalPurchaseRequestItemDetailItemJnVendorCode" 
                        title="Item Jn Vendor" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalPurchaseRequestItemDetailVendorCode" index="purchaseOrderApprovalPurchaseRequestItemDetailVendorCode" 
                        title="Vendor" width="150" sortable="true" hidden="true"
                    />
                </sjg:grid >
            </div>
            <br>
            <br>
            
        <div id="purchaseOrderApprovalDetailTable">    
            <div id="purchaseOrderApprovalDetail">
                <sjg:grid
                    id="purchaseOrderApprovalDetailInput_grid"
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
                    width="$('#tabmnupurchaseOrderApprovalDetail').width()"
                    editurl="%{remoteurlPurchaseOrderApprovalDetailInput}"
                    onSelectRowTopics="purchaseOrderApprovalDetailInput_grid_onSelect"
                >          
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailPurchaseRequestCode" index="purchaseOrderApprovalDetailPurchaseRequestCode" key="purchaseOrderApprovalDetailPurchaseRequestCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true" editable="true" edittype="text"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailPurchaseRequestHeaderCode" index="purchaseOrderApprovalDetailPurchaseRequestHeaderCode" key="purchaseOrderApprovalDetailPurchaseRequestHeaderCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailPurchaseRequestDetailCode" index="purchaseOrderApprovalDetailPurchaseRequestDetailCode" key="purchaseOrderApprovalDetailPurchaseRequestDetailCode" 
                        title="PRQ Detail " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailItemMaterialCode" index="purchaseOrderApprovalDetailItemMaterialCode" key="purchaseOrderApprovalDetailItemMaterialCode" 
                        title="Item Material Code " width="150" sortable="true" hidden="false"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailItemMaterialName" index="purchaseOrderApprovalDetailItemMaterialName" key="purchaseOrderApprovalDetailItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailItemAlias" index="purchaseOrderApprovalDetailItemAlias" 
                        title="Item Alias" width="80" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailRemark" index="purchaseOrderApprovalDetailRemark" key="purchaseOrderApprovalDetailRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailQuantity" index="purchaseOrderApprovalDetailQuantity" key="purchaseOrderApprovalDetailQuantity" 
                        title="POD Quantity" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderApprovalDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailBonusQuantity" index="purchaseOrderApprovalDetailBonusQuantity" key="purchaseOrderApprovalDetailBonusQuantity" 
                        title="Bonus" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailUnitOfMeasureCode" index="purchaseOrderApprovalDetailUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailUnitOfMeasureName" index="purchaseOrderApprovalDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailPrice" index="purchaseOrderApprovalDetailPrice" key="purchaseOrderApprovalDetailPrice" 
                        title="Price" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailDiscPercent" index="purchaseOrderApprovalDetailDiscPercent" key="purchaseOrderApprovalDetailDiscPercent" 
                        title="Discount Percent" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailDiscAmount" index="purchaseOrderApprovalDetailDiscAmount" key="purchaseOrderApprovalDetailDiscAmount" 
                        title="Discount Amount" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailNettPrice" index="purchaseOrderApprovalDetailNettPrice" key="purchaseOrderApprovalDetailNettPrice" 
                        title="Nett Price" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalDetailTotalPrice" index="purchaseOrderApprovalDetailTotalPrice" key="purchaseOrderApprovalDetailTotalPrice" 
                        title="Total" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
            <br>
            <div id="purchaseOrderApprovalDetailAddtional">
                <sjg:grid
                    id="purchaseOrderApprovalAdditionalFeeInput_grid"
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
                    width="$('#tabmnupurchaseOrderApprovalAdditionalFee').width()"
                    editurl="%{remoteurlPurchaseOrderApprovalAdditionalInput}"
                    onSelectRowTopics="purchaseOrderApprovalAdditionalFeeInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeeCode" index="purchaseOrderApprovalAdditionalFeeCode" key="purchaseOrderApprovalAdditionalFeeCode" 
                        title="Additional Cost Code" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeeName" index="purchaseOrderApprovalAdditionalFeeName" key="purchaseOrderApprovalAdditionalFeeName" 
                        title="Additional Cost Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountCode" index="purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountCode" key="purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountCode" 
                        title="Chart Of Account Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountName" index="purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountName" key="purchaseOrderApprovalAdditionalFeePurchaseChartOfAccountName" 
                        title="Chart Of Account Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeeRemark" index="purchaseOrderApprovalAdditionalFeeRemark" key="purchaseOrderApprovalAdditionalFeeRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeeQuantity" index="purchaseOrderApprovalAdditionalFeeQuantity" key="purchaseOrderApprovalAdditionalFeeQuantity" 
                        title="Quantity" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeeUnitOfMeasureCode" index="purchaseOrderApprovalDetailUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeeUnitOfMeasureName" index="purchaseOrderApprovalDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeePrice" index="purchaseOrderApprovalAdditionalFeePrice" key="purchaseOrderApprovalAdditionalFeePrice" 
                        title="Price" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderApprovalAdditionalFeeTotal" index="purchaseOrderApprovalAdditionalFeeTotal" key="purchaseOrderApprovalAdditionalFeeTotal" 
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
            <div id="PurchaseOrderApprovalItemDeliveryDate">
                <table>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <sjg:grid
                                            id="purchaseOrderApprovalItemDeliveryInput_grid"
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
                                            editurl="%{remoteurlPurchaseOrderApprovalItemDeliveryInput}"
                                            onSelectRowTopics="purchaseOrderApprovalItemDeliveryInput_grid_onSelect"
                                        >
                                            <sjg:gridColumn
                                                name="purchaseOrderApprovalItemDelivery" index="purchaseOrderApprovalItemDelivery" key="purchaseOrderApprovalItemDelivery" 
                                                title="" width="50" sortable="true" editable="true" hidden="true"
                                            />
                                            <sjg:gridColumn
                                                name = "purchaseOrderApprovalItemDeliveryItemMaterialCode" index = "purchaseOrderApprovalItemDeliveryItemMaterialCode" key = "purchaseOrderApprovalItemDeliveryItemMaterialCode" 
                                                title = "Item Material Code" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name = "purchaseOrderApprovalItemDeliveryItemMaterialName" index = "purchaseOrderApprovalItemDeliveryItemMaterialName" key = "purchaseOrderApprovalItemDeliveryItemMaterialName" 
                                                title = "tem Material Name" width = "100" editable="false" edittype="text" 
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderApprovalItemDeliveryQuantity" index="purchaseOrderApprovalItemDeliveryQuantity" key="purchaseOrderApprovalItemDeliveryQuantity" title="Quantity" 
                                                width="100" align="right" editable="false" edittype="text" 
                                                formatter="number" editrules="{ double: true }"
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderApprovalItemDeliveryDeliveryDate" index="purchaseOrderApprovalItemDeliveryDeliveryDate" title="Delivery Date" 
                                                sortable="false" 
                                                editable="false" align="center"
                                                formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                                width="100" editrules="{date: false, required:false}" 
                                            />
                                            <sjg:gridColumn
                                                name="purchaseOrderApprovalItemDeliveryDeliveryDateTemp" index="purchaseOrderApprovalItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
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
                                <s:textfield id="purchaseOrderApproval.totalTransactionAmount" name="purchaseOrderApproval.totalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="left"><B>Discount</B>
                            <s:textfield id="purchaseOrderApproval.discountPercent" name="purchaseOrderApproval.discountPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                %
                            <s:textfield id="purchaseOrderApproval.discountAmount" name="purchaseOrderApproval.discountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td></td>
                            <td align="left"> Descriptions</td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                <s:textfield id="purchaseOrderApproval.discountChartOfAccount.code" name="purchaseOrderApproval.discountChartOfAccount.code" readonly="true" title=" " size = "15"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderApproval.discountChartOfAccount.name" name="purchaseOrderApproval.discountChartOfAccount.name" title=" " size = "20" readonly = "true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderApproval.discountDescription" name="purchaseOrderApproval.discountDescription" title=" " PlaceHolder=" Description Discount" size ="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sub Total (Tax Base)</B>
                                <s:textfield id="purchaseOrderApproval.taxBaseSubTotalAmount" name="purchaseOrderApproval.taxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                            <s:textfield id="purchaseOrderApproval.vatPercent" name="purchaseOrderApproval.vatPercent" cssStyle="text-align:right;" size="8" readonly="true"></s:textfield>
                                %
                            <s:textfield id="purchaseOrderApproval.vatAmount" name="purchaseOrderApproval.vatAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td/>
                        </tr>
                        <tr>
                            <td align="right"><B>Other Fee</B>
                                <s:textfield id="purchaseOrderApproval.otherFeeAmount" name="purchaseOrderApproval.otherFeeAmount" cssStyle="text-align:right;%" readonly="true"></s:textfield>
                            </td>
                            <td/>
                             <td align="left"> Descriptions </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                <s:textfield id="purchaseOrderApproval.otherFeeChartOfAccount.code" name="purchaseOrderApproval.otherFeeChartOfAccount.code" title=" " size = "15" readonly="true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderApproval.otherFeeChartOfAccount.name" name="purchaseOrderApproval.otherFeeChartOfAccount.name" title=" " readonly="true"></s:textfield>
                            </td>
                            <td align="right">
                                <s:textfield id="purchaseOrderApproval.otherFeeDescription" name="purchaseOrderApproval.otherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B>
                                <s:textfield id="purchaseOrderApproval.grandTotalAmount" name="purchaseOrderApproval.grandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
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
                <td><sj:a href="#" id="btnPurchaseOrderApprovalSave" button="true" style="width: 60px">Save</sj:a></td>
                <td> <sj:a href="#" id="btnPurchaseOrderApprovalCancel" button="true" style="width: 60px">Cancel</sj:a></td>
                </tr>
        </table>
</s:form>
<br class="spacer" />
<br class="spacer" />