<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #vendorInvoiceGRNDetail_grid_pager_center,
    #vendorInvoiceDPDetail_grid_pager_center,
    #vendorInvoiceItemDetailInput_grid_pager_center{
        display: none;
    }
    
    .bold {
        font-weight: bold;
    }
</style>

<script type="text/javascript">
    
    var vendorInvoiceGRNDetail_lastSel = -1;
    var vendorInvoiceDPDetail_lastSel = -1;
    var vendorInvoiceItemDetailInput_lastSel = -1;
    var vendorInvoiceItemDetailLastRowId = 0;
    var flagIsConfirmed = false;
    
    var 
        txtVendorInvoiceCode = $("#vendorInvoice\\.code"),
        txtVendorInvoiceTransactionDate = $("#vendorInvoice\\.transactionDate"),
        txtVendorInvoiceDuedate = $("#vendorInvoice\\.dueDate"),
        txtVendorInvoiceBranchCode = $("#vendorInvoice\\.branch\\.code"),
        txtVendorInvoiceBranchName = $("#vendorInvoice\\.branch\\.name"),
        txtVendorInvoicePurchaseOrderCode  = $("#vendorInvoice\\.purchaseOrder\\.code"),
        txtVendorInvoiceVendorCode = $("#vendorInvoice\\.purchaseOrder\\.vendor\\.code"),
        txtVendorInvoiceVendorName = $("#vendorInvoice\\.purchaseOrder\\.vendor\\.name"),
        txtVendorInvoiceCurrencyCode = $("#vendorInvoice\\.currency\\.code"),
        txtVendorInvoiceCurrencyName = $("#vendorInvoice\\.currency\\.name"),
        txtVendorInvoicePaymentTermDays = $("#vendorInvoice\\.purchaseOrder\\.paymentTerm\\.days"),
        txtVendorInvoiceCreatedBy = $("#vendorInvoice\\.createdBy"),
        txtVendorInvoiceCreatedDate = $("#vendorInvoice\\.createdDate"),
        txtVendorInvoiceDiscountAmount=$("#vendorInvoice\\.discountAmount"),
        txtVendorInvoiceDiscountChartOfAccountCode=$("#vendorInvoice\\.discountChartOfAccount\\.code"),
        txtVendorInvoiceDiscountChartOfAccountName=$("#vendorInvoice\\.discountChartOfAccount\\.name"),
        txtVendorInvoiceDiscountDescription=$("#vendorInvoice\\.discountDescription"),
        txtVendorInvoiceOtherFeeAmount=$("#vendorInvoice\\.otherFeeAmount"),
        txtVendorInvoiceOtherFeeChartOfAccountCode=$("#vendorInvoice\\.otherFeeChartOfAccount\\.code"),
        txtVendorInvoiceOtherFeeChartOfAccountName=$("#vendorInvoice\\.otherFeeChartOfAccount\\.name"),
        txtVendorInvoiceOtherFeeDescription=$("#vendorInvoice\\.otherFeeDescription"),
        txtVendorInvoiceRefNo = $("#vendorInvoice\\.refNo"),
        txtVendorInvoiceRemark=$("#vendorInvoice\\.remark"),
        txtVendorInvoiceExchangeRate=$("#vendorInvoice\\.exchangeRate"),
        txtVendorInvoiceVendorInvoiceNo = $("#vendorInvoice\\.vendorInvoiceNo"),
        txtVendorInvoiceVendorTaxInvoiceNo = $("#vendorInvoice\\.vendorTaxInvoiceNo"),
        txtVendorInvoiceDiscountType = $("#vendorInvoice\\.discountType"),
        allFieldsVendorInvoice=$([])
            .add(txtVendorInvoiceBranchCode)
            .add(txtVendorInvoiceBranchName)
            .add(txtVendorInvoiceCurrencyCode)
            .add(txtVendorInvoiceCurrencyName)
            .add(txtVendorInvoiceExchangeRate)
            .add(txtVendorInvoiceCreatedBy)
            .add(txtVendorInvoiceCreatedDate)
            .add(txtVendorInvoiceVendorInvoiceNo)
            .add(txtVendorInvoiceVendorTaxInvoiceNo);
        
    $(document).ready(function(){
        hoverButton();
        vendorInvoiceLoadExchangeRate();
        makeBold();
        formatNumericVIN();
        clearVendorInvoiceDetail();
        
        $.subscribe("vendorInvoiceDPDetail_grid_onSelect", function() {
            
            var selectedRowID = $("#vendorInvoiceDPDetail_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==vendorInvoiceDPDetail_lastSel) {

                $('#vendorInvoiceDPDetail_grid').jqGrid("saveRow",vendorInvoiceDPDetail_lastSel); 
                $('#vendorInvoiceDPDetail_grid').jqGrid("editRow",selectedRowID,true);            

                vendorInvoiceDPDetail_lastSel = selectedRowID;
            }
            else{
                $('#vendorInvoiceDPDetail_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("vendorInvoiceItemDetail_grid_onSelect", function(event, data){
            var selectedRowID = $("#vendorInvoiceItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==vendorInvoiceItemDetailInput_lastSel) {
                $("#vendorInvoiceItemDetailInput_grid").jqGrid('saveRow',vendorInvoiceItemDetailInput_lastSel); 
                $("#vendorInvoiceItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                vendorInvoiceItemDetailInput_lastSel=selectedRowID;
            }
            else{
                $("#vendorInvoiceItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        
        $("#vendorInvoice\\.exchangeRate").change(function(e){
            var exrate=$("#vendorInvoice\\.exchangeRate").val();
            if(exrate==="" || parseFloat(exrate)===0){
               $("#vendorInvoice\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 

                return formatNumber(parseFloat(value),2); 
            });
        });
        
        $("#vendorInvoice\\.otherFeeAmount").change(function(e){
            calculationTotal();
            var exrate=$("#vendorInvoice\\.otherFeeAmount").val();
            if(exrate==="" || parseFloat(exrate)===0){
               $("#vendorInvoice\\.otherFeeAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 

                return formatNumberVIN(value); 
            });
        });
        
        $("#vendorInvoice\\.discountAmount").change(function(e){
                calculationTotal();
                var exrate=$("#vendorInvoice\\.discountAmount").val();
                if(exrate==="" || parseFloat(exrate)===0){
                   $("#vendorInvoice\\.discountAmount").val("0.00");
                }
                $(this).val(function(index, value) {
                    value = value.replace(/,/g,''); 
                    return formatNumberVIN(value); 
                });
            
        });
        
        $("#btnVendorInvoiceUnConfirm").css("display", "none");
        $("#btnVendorInvoiceConfirm").css("display", "block");
        $('#vendorInvoiceInput').unblock();
        $('#vendorInvoiceDetailInput').block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $('#vendorInvoice\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });

        
        $("#btnVendorInvoiceConfirm").click(function(){
            
             var date = $("#vendorInvoice\\.transactionDate").val().split("/");
                var month = date[1];
                var year = date[2].split(" ");
                if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
                    alert("Transaction Date Not In Periode Setup");
                    return;
                }
                
                if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
                    alert("Transaction Date Not In Periode Setup");
                    return;
                }
                
            var date1 = txtVendorInvoiceTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val())){
                if($("#vendorInvoiceUpdateMode").val()==="true"){
                    alertEx("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date ",txtVendorInvoiceTransactionDate);
                }else{
                    alertEx("Transaction Month Must Between Session Period Month!",txtVendorInvoiceTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val())){
                if($("#vendorInvoiceUpdateMode").val()==="true"){
                    alertEx("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date ",txtVendorInvoiceTransactionDate);
                }else{
                    alertEx("Transaction Year Must Between Session Period Year!",txtVendorInvoiceTransactionDate);
                }
                return;
            }
            
            if(txtVendorInvoiceBranchCode.val()===""){
                alertMessage("Branch Cant Be Null",txtVendorInvoiceBranchCode);
                return;
            }
            
            if(txtVendorInvoicePurchaseOrderCode.val()===""){
                alertMessage("Purchase Order No Can't Be Null",txtVendorInvoicePurchaseOrderCode);
                return;
            }
         
            if(txtVendorInvoiceCurrencyCode.val()===""){
                alertMessage("Currency No Cant Be Null",txtVendorInvoiceCurrencyCode);
                return;
            }
            
            if(parseFloat(removeCommas(txtVendorInvoiceExchangeRate.val()))<=1 && txtVendorInvoiceCurrencyCode.val()!=="IDR"){
                txtVendorInvoiceExchangeRate.attr('readonly',false);
                txtVendorInvoiceExchangeRate.attr("style","color:red");
                
                alertMessage("Exchange Rate : "+txtVendorInvoiceCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtVendorInvoiceExchangeRate.attr("style","color:black");
            }
            
            if(txtVendorInvoiceVendorInvoiceNo.val()===""){
                alertMessage("INV No From Vendor Can't Be Null",txtVendorInvoiceVendorInvoiceNo);
                return;
            }
            
            if(txtVendorInvoiceVendorTaxInvoiceNo.val()===""){
                alertMessage("Vendor Tax Invoice Can't Be Null",txtVendorInvoiceVendorTaxInvoiceNo);
                return;
            }
            
            $("#btnVendorInvoiceUnConfirm").css("display", "block");
            $("#btnVendorInvoiceConfirm").css("display", "none");
            
            $('#vendorInvoiceInput').block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#vendorInvoiceDetailInput').unblock();
            flagIsConfirmed=true;
            
            if($("#vendorInvoiceUpdateMode").val() === "true"){
                loadGrnByInvoiceVendorUpdate();
                loadDPByInvoiceVendorUpdate();
            }else{
                loadDPByInvoiceVendor();
                loadGrnByInvoiceVendor();
            }
        });
        
        txtVendorInvoiceTransactionDate.change(function(){
            calculationDueDateVIN();
        });
        
        $("#btnVendorInvoiceUnConfirm").click(function(){
            $("#btnVendorInvoiceUnConfirm").css("display", "none");
            $("#btnVendorInvoiceConfirm").css("display", "block");

            $("#vendorInvoiceDPDetail_grid").jqGrid('clearGridData');
            $("#vendorInvoiceGRNDetail_grid").jqGrid('clearGridData');
            $("#vendorInvoiceItemDetailInput_grid").jqGrid('clearGridData');
            
            clearVendorInvoiceDetail();

            $('#vendorInvoiceInput').unblock();
            $('#vendorInvoiceDetailInput').block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
            flagIsConfirmed=false;

        });
        
        $("#btnVendorInvoiceSave").click(function(ev) {
            
            if(flagIsConfirmed===true){
                
                if (vendorInvoiceGRNDetail_lastSel !== -1) {
                    $('#vendorInvoiceGRNDetail_grid').jqGrid("saveRow", vendorInvoiceGRNDetail_lastSel);
                }

                if (vendorInvoiceDPDetail_lastSel !== -1) {
                    $('#vendorInvoiceDPDetail_grid').jqGrid("saveRow", vendorInvoiceDPDetail_lastSel);
                }

                if (vendorInvoiceItemDetailInput_lastSel !== -1) {
                    $('#vendorInvoiceItemDetailInput_grid').jqGrid("saveRow", vendorInvoiceItemDetailInput_lastSel);
                }
                
                unHandlersInput(txtVendorInvoiceDiscountChartOfAccountCode);
                unHandlersInput(txtVendorInvoiceDiscountDescription);
                unHandlersInput(txtVendorInvoiceOtherFeeChartOfAccountCode);
                unHandlersInput(txtVendorInvoiceOtherFeeDescription);
            
                var vendorInvoiceDiscountAlert=
                "*** If Disc Amount Value >0, Disc Account and Disc Description Have to filled!<br/>"
               +"*** If Disc Amount value <=0, Disc Account and Disc Description must be empty!<br/>";
                var vendorInvoiceOtherFeeAlert=
                "*** If Other Fee Amount Value >0, Other Account and Other Description Have to filled!<br/>"
               +"*** If Other Fee Amount value <=0, Other Account and Other Description must be empty!<br/>";
                
                var vendorInvoiceDiscAmount=parseFloat(txtVendorInvoiceDiscountAmount.val());
                var vendorInvoiceDiscChartOfAccountCode=txtVendorInvoiceDiscountChartOfAccountCode.val();
                var vendorInvoiceDiscDescription=txtVendorInvoiceDiscountDescription.val();
            
                if(vendorInvoiceDiscAmount===0 && vendorInvoiceDiscChartOfAccountCode!=="" && vendorInvoiceDiscDescription!==""){
                   alertMessage("Disc Chart Of Account Must be Empty!<br/><br/><br/><br/>"+vendorInvoiceDiscountAlert,txtVendorInvoiceDiscountChartOfAccountCode);
                   handlersInput(txtVendorInvoiceDiscountChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceDiscAmount===0 && vendorInvoiceDiscChartOfAccountCode!=="" && vendorInvoiceDiscDescription===""){
                   alertMessage("Disc Chart Of Account Must be Empty!<br/><br/><br/><br/>"+vendorInvoiceDiscountAlert,txtVendorInvoiceDiscountChartOfAccountCode);
                   handlersInput(txtVendorInvoiceDiscountChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceDiscAmount===0 && vendorInvoiceDiscChartOfAccountCode==="" && vendorInvoiceDiscDescription!==""){
                   alertMessage("Disc Description Must be Empty!<br/><br/><br/><br/>"+vendorInvoiceDiscountAlert,txtVendorInvoiceDiscountDescription);
                   handlersInput(txtVendorInvoiceDiscountDescription);
                   return;
                }
                
                if(vendorInvoiceDiscAmount!==0 && vendorInvoiceDiscChartOfAccountCode==="" && vendorInvoiceDiscDescription===""){
                   alertMessage("Disc Chart Of Account Can't Empty!<br/><br/><br/><br/>"+vendorInvoiceDiscountAlert,txtVendorInvoiceDiscountChartOfAccountCode);
                   handlersInput(txtVendorInvoiceDiscountChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceDiscAmount!==0 && vendorInvoiceDiscChartOfAccountCode==="" && vendorInvoiceDiscDescription!==""){
                   alertMessage("Disc Chart Of Account Can't Empty!<br/><br/><br/><br/>"+vendorInvoiceDiscountAlert,txtVendorInvoiceDiscountChartOfAccountCode);
                   handlersInput(txtVendorInvoiceDiscountChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceDiscAmount!==0 && vendorInvoiceDiscChartOfAccountCode!=="" && vendorInvoiceDiscDescription===""){
                   alertMessage("Description Disc Chart Of Account Can't Empty!<br/><br/><br/><br/>"+vendorInvoiceDiscountAlert,txtVendorInvoiceDiscountDescription);
                   handlersInput(txtVendorInvoiceDiscountDescription);
                   return;
                }
                
                var vendorInvoiceOtherFeeAmount=parseFloat(txtVendorInvoiceOtherFeeAmount.val());
                var vendorInvoiceOtherFeeChartOfAccountCode=txtVendorInvoiceOtherFeeChartOfAccountCode.val();
                var vendorInvoiceOtherFeeDescription=txtVendorInvoiceOtherFeeDescription.val();
            
                if(vendorInvoiceOtherFeeAmount===0 && vendorInvoiceOtherFeeChartOfAccountCode!=="" && vendorInvoiceOtherFeeDescription!==""){
                   alertMessage("Other Fee Chart Of Account Must be Empty!<br/><br/><br/><br/>"+vendorInvoiceOtherFeeAlert,txtVendorInvoiceOtherFeeChartOfAccountCode);
                   handlersInput(txtVendorInvoiceOtherFeeChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceOtherFeeAmount===0 && vendorInvoiceOtherFeeChartOfAccountCode!=="" && vendorInvoiceOtherFeeDescription===""){
                   alertMessage("Other Fee Chart Of Account Must be Empty!<br/><br/><br/><br/>"+vendorInvoiceOtherFeeAlert,txtVendorInvoiceOtherFeeChartOfAccountCode);
                   handlersInput(txtVendorInvoiceOtherFeeChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceOtherFeeAmount===0 && vendorInvoiceOtherFeeChartOfAccountCode==="" && vendorInvoiceOtherFeeDescription!==""){
                   alertMessage("Other Fee Description Must be Empty!<br/><br/><br/><br/>"+vendorInvoiceOtherFeeAlert,txtVendorInvoiceOtherFeeDescription);
                   handlersInput(txtVendorInvoiceOtherFeeDescription);
                   return;
                }
                
                if(vendorInvoiceOtherFeeAmount!==0 && vendorInvoiceOtherFeeChartOfAccountCode==="" && vendorInvoiceOtherFeeDescription===""){
                   alertMessage("Other Fee Chart Of Account Can't Empty!<br/><br/><br/><br/>"+vendorInvoiceOtherFeeAlert,txtVendorInvoiceOtherFeeChartOfAccountCode);
                   handlersInput(txtVendorInvoiceOtherFeeChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceOtherFeeAmount!==0 && vendorInvoiceOtherFeeChartOfAccountCode==="" && vendorInvoiceOtherFeeDescription!==""){
                   alertMessage("Other Fee Chart Of Account Can't Empty!<br/><br/><br/><br/>"+vendorInvoiceOtherFeeAlert,txtVendorInvoiceOtherFeeChartOfAccountCode);
                   handlersInput(txtVendorInvoiceOtherFeeChartOfAccountCode);
                   return;
                }
                
                if(vendorInvoiceOtherFeeAmount!==0 && vendorInvoiceOtherFeeChartOfAccountCode!=="" && vendorInvoiceOtherFeeDescription===""){
                   alertMessage("Description Other Fee Chart Of Account Can't Empty!<br/><br/><br/><br/>"+vendorInvoiceOtherFeeAlert,txtVendorInvoiceOtherFeeDescription);
                   handlersInput(txtVendorInvoiceOtherFeeDescription);
                   return;
                }
            
                var idsGRN = jQuery("#vendorInvoiceGRNDetail_grid").jqGrid('getDataIDs');
                var idsDP = jQuery("#vendorInvoiceDPDetail_grid").jqGrid('getDataIDs');
                var idsItem = jQuery("#vendorInvoiceItemDetailInput_grid").jqGrid('getDataIDs');
                
                if (idsGRN.length === 0) {
                    alertMessage("Data Grid GRN Detail Can't Empty!");
                    return;
                }

                if (idsItem.length === 0) {
                    alertMessage("Data Grid Item Detail Can't Empty!");
                    return;
                }

                var listVendorInvoiceGoodsReceivedNote = new Array();
                for (var i = 0; i < idsGRN.length; i++) {
                    var data = $("#vendorInvoiceGRNDetail_grid").jqGrid('getRowData', idsGRN[i]);

                    var vendorInvoiceGoodsReceivedNote = {
                        goodsReceivedNote : {code: data.grnCode}
                    };
                    listVendorInvoiceGoodsReceivedNote[i] = vendorInvoiceGoodsReceivedNote;
                }

                var listVendorInvoiceVendorDownPayment = new Array();
                var countSdpUsed=0;
                for (var i = 0; i < idsDP.length; i++) {
                    var data = $("#vendorInvoiceDPDetail_grid").jqGrid('getRowData', idsDP[i]);

                    if($("#vendorInvoiceUpdateMode").val() === "false"){
                        if(parseFloat(data.dpApplied) > parseFloat(data.dpBalance)){
                            alertMessage("DP Applied may not be greater than DP balance!");
                            return;
                        }
                    }
                    
                    if(parseFloat(data.dpApplied)>0){
                        var vendorInvoiceVendorDownPayment = {
                            vendorDownPayment : {code: data.dpSDPNo},
                            amount            : data.dpApplied
                        };
                        listVendorInvoiceVendorDownPayment[countSdpUsed] = vendorInvoiceVendorDownPayment;
                        countSdpUsed++;
                    }
                }
                
                var listVendorInvoiceItemDetail = new Array();
//                var listVendorInvoicePostingItemDetail = new Array();
                for (var i = 0; i < idsItem.length; i++) {
                    var data = $("#vendorInvoiceItemDetailInput_grid").jqGrid('getRowData', idsItem[i]);

                    var vendorInvoiceItemDetail = {
                        goodsReceivedNoteDetailCode : data.goodsReceivedNoteDetailCode,
                        itemMaterial                : {code: data.itemMaterialCode},
                        quantity                    : data.quantity,
                        price                       : data.price,
                        discountPercent             : data.discountPercentGrn,
                        discountAmount              : data.discountAmountGrn,
                        nettPrice                   : data.nettPrice,
                        totalAmount                 : data.total,
                        remark                      : data.remark
                    };
                    listVendorInvoiceItemDetail[i] = vendorInvoiceItemDetail;
                }
                
                
                var url="";

                if($("#vendorInvoiceUpdateMode").val() === "true"){
                    url = "finance/vendor-invoice-update";
                }else{
                    url = "finance/vendor-invoice-save";
                }
                
                formatDateVendorInvoice();
                unFormatNumericVIN();

                var params = $("#frmVendorInvoiceInput").serialize()+"&"+$("#frmHeaderAmount").serialize()+"&vendorInvoiceForexGainLoss.amount="+$("#forexGainLossAmount_sin").val();
                params += "&listVendorInvoiceGoodsReceivedNoteJSON=" + $.toJSON(listVendorInvoiceGoodsReceivedNote);
                params += "&listVendorInvoiceVendorDownPaymentJSON=" + $.toJSON(listVendorInvoiceVendorDownPayment);
                params += "&listVendorInvoiceItemDetailJSON=" + $.toJSON(listVendorInvoiceItemDetail);
//                params += "&listVendorInvoicePostingItemDetailJSON=" + $.toJSON(listVendorInvoicePostingItemDetail);

                showLoading();

                $.post(url, params, function (data) {
                    closeLoading();
                    if (data.error) {
                        formatDateVendorInvoice();
                        formatNumericVIN();
                        alertMessage(data.errorMessage);
                        return;
                    }

                    if(data.errorMessage){
                        formatDateVendorInvoice();
                        alertMessage(data.errorMessage);
                        return;
                    }

                    var dynamicDialog = $('<div id="conformBox">' +
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                    '</span>' + data.message + '<br/>Do You Want Input Other Transaction?</div>');

                    dynamicDialog.dialog({
                        title: "Confirmation:",
                        closeOnEscape: false,
                        modal: true,
                        width: 500,
                        resizable: false,
                        buttons:
                                [{
                                        text: "Yes",
                                        click: function () {
                                            $(this).dialog("close");
                                            var url = "finance/vendor-invoice-input";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuVENDOR_INVOICE");
                                        }
                                    },
                                    {
                                        text: "No",
                                        click: function () {
                                            $(this).dialog("close");
                                            var url = "finance/vendor-invoice";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuVENDOR_INVOICE");
                                        }
                                    }]
                    });
                });

                ev.preventDefault();
                
            }else {
                alertMessage("Please Confirm!",$("#btnVendorInvoiceConfirm"));
            }
        });
        
        $("#vendorInvoice\\.otherFeeAmount").keypress(function(e){
           if(e.which!==8 && e.which!==45 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#btnVendorInvoiceCancel").click(function(ev) {
            var url = "finance/vendor-invoice";
            var params = "";
            pageLoad(url, params, "#tabmnuVENDOR_INVOICE"); 
            
        });
        
        $('#vendorInvoice_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=vendorInvoice&idsubdoc=branch","Search", "scrollbars=1, width=550, height=450").focus();
        });

        $('#vendorInvoice_btnVendorInvoice').click(function(ev) {
            window.open("./pages/search/search-purchase-order-by-vendor-invoice.jsp?iddoc=vendorInvoice&idsubdoc=vendorInvoice&firstDate="+$("#vendorInvoiceFirstDate").val()+"&lastDate="+$("#vendorInvoiceLastDate").val(),"Search", "scrollbars=1, width=1400, height=550").focus();
        });
        
        $("#vendorInvoice\\.discountPercent").change(function(){
            calculationTotal();
        });
        $("#vendorInvoice\\.discountAmount").change(function(){
            calculationTotal();
        });

        $("#vendorInvoice\\.otherFeeAmount").change(function(){
            calculationTotal();
        });
    }); //EOF READY
    
    function formatFromLookupPurchaseOrder(){
        var discountPercent=parseFloat($("#vendorInvoice\\.discountPercent").val());
        $("#vendorInvoice\\.discountPercent").val(formatNumber(discountPercent,2));
        
        var discountAmount=parseFloat($("#vendorInvoice\\.discountAmount").val());
        $("#vendorInvoice\\.discountAmount").val(formatNumber(discountAmount,2));
        
        var vendorInvoiceVatPercent = parseFloat($("#vendorInvoice\\.vatPercent").val());
        $("#vendorInvoice\\.vatPercent").val(formatNumber(vendorInvoiceVatPercent,2));
        
        var vendorInvoiceOtherFeeAmount = parseFloat($("#vendorInvoice\\.otherFeeAmount").val());
        $("#vendorInvoice\\.otherFeeAmount").val(formatNumber(vendorInvoiceOtherFeeAmount,2));
    }
    
    function makeBold() {
        document.getElementById("labelVendorInvoiceNo").classList.add('bold');
        document.getElementById("labelVendorTaxInvoiceNo").classList.add('bold');
        
        document.getElementById("labelVendorInvoiceNo").innerHTML = "Invoice No From Vendor *";
        document.getElementById("labelVendorTaxInvoiceNo").innerHTML = "Vendor Tax Invoice *";
    }
    
    function removeBold() {
        document.getElementById("labelVendorInvoiceNo").classList.remove('bold');
        document.getElementById("labelVendorTaxInvoiceNo").classList.remove('bold');
        
        document.getElementById("labelVendorInvoiceNo").innerHTML = "Invoice No From Vendor ";
        document.getElementById("labelVendorTaxInvoiceNo").innerHTML = "Vendor Tax Invoice ";
    }
    function formatDate(date, useTime) {
        var dateValuesTemps;
        if (useTime) {
            var dateValues = date.split(' ');
            var dateValuesTemp = dateValues[0].split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            var dateValuesTemp = date.split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
        
    function formatDateVendorInvoice(){
        
        var transactionDate=formatDate($("#vendorInvoice\\.transactionDate").val(),false);
        $("#vendorInvoice\\.transactionDate").val(transactionDate);
        
        var vendorInvoiceDate=formatDate($("#vendorInvoice\\.vendorInvoiceDate").val(),false);
        $("#vendorInvoice\\.vendorInvoiceDate").val(vendorInvoiceDate);

        var dueDate=formatDate($("#vendorInvoice\\.dueDate").val(),false);
        $("#vendorInvoice\\.dueDate").val(dueDate);

        var vendorTaxInvoiceDate=formatDate($("#vendorInvoice\\.vendorTaxInvoiceDate").val(),false);
        $("#vendorInvoice\\.vendorTaxInvoiceDate").val(vendorTaxInvoiceDate);
         
    }
    
    function vendorInvoiceGRNGrid_ItemDelete_OnClick() {
        var selectDetailRowId = $("#vendorInvoiceGRNDetail_grid").jqGrid('getGridParam', 'selrow');
        
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        $("#vendorInvoiceGRNDetail_grid").jqGrid('delRowData', selectDetailRowId);
        $("#vendorInvoiceItemDetailInput_grid").jqGrid('clearGridData');
        
        var idsGRN = jQuery("#vendorInvoiceGRNDetail_grid").jqGrid('getDataIDs');

        vendorInvoiceItemDetailLastRowId = 0;
        $("#vendorInvoice\\.totalTransactionAmount").val("0.00");
        $("#vendorInvoiceTotalTransactionInventory").val("0.00");
        $("#vendorInvoiceTotalTransactionNonInventory").val("0.00");

        for (var i = 0; i < idsGRN.length; i++) {
            var data = $("#vendorInvoiceGRNDetail_grid").jqGrid('getRowData', idsGRN[i]);

            loadItemDetailByInvoiceVendor(data.grnCode);
        }
        calculationTotal();
    }

    function calculationTotal(){

        /*Calculate Total Down Payment , Discount , Vat , OtherFee , GrandTotal*/
        var totalApplied = 0;
        var discountPercent=0;
        var discAmount = 0;
        var selectedRowID = $("#vendorInvoiceDPDetail_grid").jqGrid("getGridParam", "selrow");

        if (selectedRowID !== -1) {
            $('#vendorInvoiceDPDetail_grid').jqGrid("saveRow", vendorInvoiceDPDetail_lastSel);
        }
        
        var idsSDP = jQuery("#vendorInvoiceDPDetail_grid").jqGrid('getDataIDs');
        for(var i=0;i<idsSDP.length;i++) {
            var dataSDPSub = $("#vendorInvoiceDPDetail_grid").jqGrid('getRowData',idsSDP[i]);                              
            totalApplied += parseFloat(dataSDPSub.dpApplied);
        } 

//        $("#vendorInvoice\\.downPaymentAmount").val(formatNumber(parseFloat(totalApplied.toFixed(2)), 2));
//        var totSDP =$("#vendorInvoice\\.downPaymentAmount").val().replace(/,/g, "");
        
        var totalTransaction = $("#vendorInvoice\\.totalTransactionAmount").val().replace(/,/g, "");
        discountPercent = $("#vendorInvoice\\.discountPercent").val().replace(/,/g, "");
        discAmount = parseFloat(((totalTransaction * discountPercent)/100).toFixed(2));
        $("#vendorInvoice\\.discountAmount").val(formatNumber(discAmount, 2));
        
        var vatPPN = $("#vendorInvoice\\.vatPercent").val().replace(/,/g, "");
        var otherFeeAmount = $("#vendorInvoice\\.otherFeeAmount").val().replace(/,/g, "");  
        
        var totDisc= (parseFloat(discAmount)+parseFloat(totalApplied));
        var totalSub = (parseFloat(totalTransaction)-parseFloat(totDisc));
        var subTotal=0;
        var subTotalFormat=0;
        if(parseFloat(totalSub)<0){
            subTotal=totalSub.toString().replace(/-/,'');
            subTotalFormat='-'+formatNumber(parseFloat(subTotal),2);
        }else{
            subTotalFormat=formatNumber(parseFloat(totalSub),2);
        }
        $("#vendorInvoice\\.subTotalAmount").val(subTotalFormat);
//        
        
        var totVatPPN = (parseFloat(vatPPN)*parseFloat(totalSub))/100;
//        
        var granTotTemp = parseFloat(totalSub)+Number(totVatPPN)+Number(otherFeeAmount) ;
        var granTotal = parseFloat(granTotTemp);

        var granTotalAmount=0;
        var granTotalAmountFormat=0;
        if(parseFloat(granTotal)<0){
            granTotalAmount=granTotal.toString().replace(/-/,'');
            granTotalAmountFormat='-'+formatNumber(parseFloat(granTotalAmount),2);
        }else{
            granTotalAmountFormat=formatNumber(parseFloat(granTotal),2);
        }
        
//        $("#vendorInvoice\\.discountPercent").val(formatNumber(discountPercent, 2));
//        $("#vendorInvoice\\.discountAmount").val(formatNumber(discAmount, 2));
        $("#vendorInvoice\\.downPaymentAmount").val(formatNumber(totalApplied, 2));
        $("#vendorInvoice\\.vatAmount").val(formatNumber(totVatPPN, 2));
        $("#vendorInvoice\\.grandTotalAmount").val(granTotalAmountFormat);


//        /* Calculate Forex Gain Loss */
        calculateForexGainLoss();
    }
           
    function calculateForexGainLoss(){

        var currencyCodeHeader=txtVendorInvoiceCurrencyCode.val();
        var ids = jQuery("#vendorInvoiceDPDetail_grid").jqGrid('getDataIDs');
        var exchangeRateHeader=parseFloat($("#vendorInvoice\\.exchangeRate").val().replace(/,/g,""));

        var selisihKurs=0;
        var forexGainLoss=0;
        var totalForexGainLoss=0;
        var dpforeignIdrUSD=0;

        for(var x=0;x<ids.length;x++){
            var data = $("#vendorInvoiceDPDetail_grid").jqGrid('getRowData',ids[x]);
            var currencyCodeGrid=data.dpCurrencyCode;
            var exchangeRategrid=parseFloat(data.dpExchangeRate);
            var appliedAmount=parseFloat(data.dpApplied);

            if(currencyCodeHeader==="IDR"){
                dpforeignIdrUSD=appliedAmount * exchangeRategrid;
                forexGainLoss=0;
            }else{
                if(currencyCodeGrid==="IDR"){
                    dpforeignIdrUSD=appliedAmount/exchangeRateHeader;
                    forexGainLoss=0;
                }else{
                    dpforeignIdrUSD=appliedAmount;
                    selisihKurs=exchangeRateHeader-exchangeRategrid;
                    forexGainLoss=selisihKurs * parseFloat(dpforeignIdrUSD);
                }
            }

            $("#vendorInvoiceDPDetail_grid").jqGrid("setCell", ids[x],"dpForeign",dpforeignIdrUSD);
            $("#vendorInvoiceDPDetail_grid").jqGrid("setCell", ids[x],"forexGainLoss",forexGainLoss);
            totalForexGainLoss+=forexGainLoss;
        }
        var gainLoss=formatNumber(parseFloat(totalForexGainLoss),2);
        var formatGainLoss=gainLoss.replace(/-,/,"-");
        $("#forexGainLossAmount_sin").val(formatGainLoss);
    }
    
    function formatNumberVIN(num) {
        var splitValue=num.split('.');
        var valueFormat;

        if(parseFloat(num) > 0.00){
            if(splitValue[0].length>3){
                var concatValue=parseFloat(splitValue[0]+'.'+splitValue[1]);
                valueFormat=formatNumber(parseFloat(concatValue),2);
            }else{
                valueFormat=splitValue[0]+'.'+splitValue[1];
            }
        }else{
            var removeMinusValue=splitValue[0].toString().replace('-','');
            var concatValue=parseFloat(removeMinusValue+'.'+splitValue[1]);
            valueFormat="-"+formatNumber(parseFloat(concatValue),2);
            if(parseFloat(num)===0.00){
                valueFormat=valueFormat.replace('-','');
            }
        }
        return valueFormat;
    }
    
    function calculationDueDateVIN(){
        var transactionDate = "vendorInvoice\\.transactionDate";
        var dueDate         = "vendorInvoice\\.dueDate";
        var days            = "vendorInvoice\\.purchaseOrder\\.paymentTerm\\.days";
        dateAdditionalNumber(transactionDate,dueDate,days,false);
    }
    
    function formatNumericVIN(){
        
        var exchangeRate=parseFloat($("#vendorInvoice\\.exchangeRate").val());
        $("#vendorInvoice\\.exchangeRate").val(formatNumber(exchangeRate,2));

        var vendorInvoiceTotalTransactionAmount=parseFloat($("#vendorInvoice\\.totalTransactionAmount").val());
        $("#vendorInvoice\\.totalTransactionAmount").val(formatNumber(vendorInvoiceTotalTransactionAmount,2));

        var vendorInvoiceDiscountPercent =parseFloat($("#vendorInvoice\\.discountPercent").val());
        $("#vendorInvoice\\.discountPercent").val(formatNumber(vendorInvoiceDiscountPercent,2));

        var vendorInvoiceDiscountAmount =($("#vendorInvoice\\.discountAmount").val());
        $("#vendorInvoice\\.discountAmount").val(formatNumberVIN(vendorInvoiceDiscountAmount));
        
        var vendorInvoiceOtherFeeAmount = $("#vendorInvoice\\.otherFeeAmount").val();
        $("#vendorInvoice\\.otherFeeAmount").val(formatNumberVIN(vendorInvoiceOtherFeeAmount));
        
        var vendorInvoiceDownpaymentAmount = parseFloat($("#vendorInvoice\\.downPaymentAmount").val());
        $("#vendorInvoice\\.downPaymentAmount").val(formatNumber(vendorInvoiceDownpaymentAmount,2));

        var subTotal = parseFloat($("#vendorInvoice\\.subTotalAmount").val());
        $("#vendorInvoice\\.subTotalAmount").val(formatNumber(subTotal,2));

        var vendorInvoiceVatPercent = parseFloat($("#vendorInvoice\\.vatPercent").val());
        $("#vendorInvoice\\.vatPercent").val(formatNumber(vendorInvoiceVatPercent,2));

        var vendorInvoiceVatAmount = parseFloat($("#vendorInvoice\\.vatAmount").val());
        $("#vendorInvoice\\.vatAmount").val(formatNumber(vendorInvoiceVatAmount,2));

        var vendorInvoiceGrandTotalAmount = parseFloat($("#vendorInvoice\\.grandTotalAmount").val());
        $("#vendorInvoice\\.grandTotalAmount").val(formatNumber(vendorInvoiceGrandTotalAmount,2));
        
        var forexGainLossAmount_sin = parseFloat($("#forexGainLossAmount_sin").val());
        $("#forexGainLossAmount_sin").val(formatNumber(forexGainLossAmount_sin,2));
                        
    }
    
    function unFormatNumericVIN(){
        
        var exchangeRate=$("#vendorInvoice\\.exchangeRate").val().replace(/,/g, '');
        $("#vendorInvoice\\.exchangeRate").val(exchangeRate);

        var vendorInvoiceTotalTransactionAmount=$("#vendorInvoice\\.totalTransactionAmount").val().replace(/,/g,'');
        $("#vendorInvoice\\.totalTransactionAmount").val(vendorInvoiceTotalTransactionAmount);

        var vendorInvoiceDiscountPercent = $("#vendorInvoice\\.discountPercent").val().replace(/,/g,'');
        $("#vendorInvoice\\.discountPercent").val(vendorInvoiceDiscountPercent );

        var vendorInvoiceDiscountAmount = $("#vendorInvoice\\.discountAmount").val().replace(/,/g,'');
        $("#vendorInvoice\\.discountAmount").val(vendorInvoiceDiscountAmount );
        
        var vendorInvoiceOtherFeeAmount = $("#vendorInvoice\\.otherFeeAmount").val().replace(/,/g,'');
        $("#vendorInvoice\\.otherFeeAmount").val(vendorInvoiceOtherFeeAmount );

        var vendorInvoiceDownpaymentAmount = $("#vendorInvoice\\.downPaymentAmount").val().replace(/,/g,'');
        $("#vendorInvoice\\.downPaymentAmount").val(vendorInvoiceDownpaymentAmount);

        var subTotal = $("#vendorInvoice\\.subTotalAmount").val().replace(/,/g,'');
        $("#vendorInvoice\\.subTotalAmount").val(subTotal);

        var vendorInvoiceVatPercent = $("#vendorInvoice\\.vatPercent").val().replace(/,/g,'');
        $("#vendorInvoice\\.vatPercent").val(vendorInvoiceVatPercent);

        var vendorInvoiceVatAmount = $("#vendorInvoice\\.vatAmount").val().replace(/,/g,'');
        $("#vendorInvoice\\.vatAmount").val(vendorInvoiceVatAmount);

        var vendorInvoiceGrandTotalAmount = $("#vendorInvoice\\.grandTotalAmount").val().replace(/,/g,'');
        $("#vendorInvoice\\.grandTotalAmount").val(vendorInvoiceGrandTotalAmount);
        
        var forexGainLossAmount_sin =$("#forexGainLossAmount_sin").val().replace(/,/g,'');
        $("#forexGainLossAmount_sin").val(forexGainLossAmount_sin);
                
    }
    
    function vendorInvoiceLoadExchangeRate(){
        if($("#vendorInvoiceUpdateMode").val()==="false"){
            if(txtVendorInvoiceCurrencyCode.val()==="IDR"){
                txtVendorInvoiceExchangeRate.val("1.00");
                txtVendorInvoiceExchangeRate.attr('readonly',true);
            }else{
                txtVendorInvoiceExchangeRate.val("0.00");
                txtVendorInvoiceExchangeRate.attr('readonly',false);
            }
        }else{
            if(txtVendorInvoiceCurrencyCode.val()==="IDR"){
                txtVendorInvoiceExchangeRate.val("1.00");
                txtVendorInvoiceExchangeRate.attr('readonly',true);
            }else{
                txtVendorInvoiceExchangeRate.attr('readonly',false);
            }
        }
    }    
    function clearVendorInvoiceDetail(){
        $("#vendorInvoice\\.totalTransactionAmount").val("0.00");
        $("#vendorInvoice\\.subTotalAmount").val("0.00");
        $("#vendorInvoice\\.vatAmount").val("0.00");
        $("#vendorInvoice\\.downPaymentAmount").val("0.00");
        $("#vendorInvoice\\.grandTotalAmount").val("0.00");
        $("#forexGainLossAmount_sin").val("0.00");
    }
    
    
</script>
<s:url id="remoteurlVendorInvoiceDetailInput" action="" />

<b>VENDOR INVOICE</b>
<hr>
<s:textfield cssStyle="display:none" id="vendorInvoiceUpdateMode" name="vendorInvoiceUpdateMode"></s:textfield>
<div id="vendorInvoiceInput" class="content ui-widget">
    <s:form id="frmVendorInvoiceInput">
        <table cellpadding="2" cellspacing="2" >
            <tr valign="top">
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><B>VIN No *</B></td>
                            <td><s:textfield id="vendorInvoice.code" name="vendorInvoice.code" size="30" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="vendorInvoice.transactionDate" name="vendorInvoice.transactionDate" required="true" cssClass="required" showOn="focus" 
                                onchange="calculationDueDateVIN()" displayFormat="dd/mm/yy" timepicker="false" timepickerFormat="hh:mm:ss" size="15" changeYear="true" changeMonth="true" ></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>POD No *</B></td>
                            <td>
                                <script type = "text/javascript">

                                txtVendorInvoicePurchaseOrderCode.change(function(ev) {
                                    
                                    if($("#vendorInvoiceUpdateMode").val() === "true"){
                                        $('#vendorInvoice\\.code').prop("readonly",true);
                                        $("#btnVendorInvoiceConfirm").trigger('click');
                                    }
                                    
                                    if(txtVendorInvoicePurchaseOrderCode.val()===""){
                                        txtVendorInvoicePurchaseOrderCode.val("");
                                        return;
                                    }
                                    
                                    var url = "purchasing/purchase-order-get";
                                    var params = "purchaseOrder.code=" + txtVendorInvoicePurchaseOrderCode.val();
                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.purchaseOrderTemp){
                                            txtVendorInvoicePurchaseOrderCode.val(data.purchaseOrderTemp.code);
                                        }
                                        else{
                                            alertMessage("Purchase Order Not Found!",txtVendorInvoicePurchaseOrderCode);
                                            txtVendorInvoicePurchaseOrderCode.val("");
                                        }
                                    });
                                    });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                    <s:textfield id="vendorInvoice.purchaseOrder.code" name="vendorInvoice.purchaseOrder.code" title="*" required="true" cssClass="required" maxLength="45" size="25" readonly="true"></s:textfield>
                                        <sj:a id="vendorInvoice_btnVendorInvoice" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td>
                                <script type = "text/javascript">

                                txtVendorInvoiceBranchCode.change(function(ev) {

                                        if(txtVendorInvoiceBranchCode.val()===""){
                                            txtVendorInvoiceBranchCode.val("");
                                            txtVendorInvoiceBranchName.val("");
                                            return;
                                        }
                                        var url = "master/branch-get";
                                        var params = "branch.code=" + txtVendorInvoiceBranchCode.val();
                                            params += "&branch.activeStatus="+true;
                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.branchTemp){
                                                txtVendorInvoiceBranchCode.val(data.branchTemp.code);
                                                txtVendorInvoiceBranchName.val(data.branchTemp.name);
                                            }
                                            else{
                                                alertMessage("Branch Not Found!",txtVendorInvoiceBranchCode);
                                                txtVendorInvoiceBranchCode.val("");
                                                txtVendorInvoiceBranchName.val("");
                                            }
                                        });
                                    });

                                </script>
                                <!--<div class="searchbox ui-widget-header">-->
                                    <s:textfield id="vendorInvoice.branch.code" name="vendorInvoice.branch.code" readonly="true" title="*" required="true" cssClass="required" size="5"></s:textfield>
                                    <%--<sj:a id="vendorInvoice_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>--%>
                                <!--</div>&nbsp;-->
                                <s:textfield id="vendorInvoice.branch.name" name="vendorInvoice.branch.name" size="38" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Vendor Code</td>
                            <td>
                                <s:textfield id="vendorInvoice.purchaseOrder.vendor.code" name="vendorInvoice.purchaseOrder.vendor.code" size="15" readonly="true"></s:textfield>
                                <s:textfield id="vendorInvoice.purchaseOrder.vendor.name" name="vendorInvoice.purchaseOrder.vendor.name" size="34" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Contact Person</td>
                            <td>
                                <s:textfield id="vendorInvoice.purchaseOrder.vendor.defaultContactPerson.code" name="vendorInvoice.purchaseOrder.vendor.defaultContactPerson.code" size="15" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="vendorInvoice.purchaseOrder.vendor.defaultContactPerson.name" name="vendorInvoice.purchaseOrder.vendor.defaultContactPerson.name" size="35" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                         <tr>
                            <td align="right">Address</td>
                            <td><s:textarea id="vendorInvoice.purchaseOrder.vendor.address"  name="vendorInvoice.purchaseOrder.vendor.address"  cols="47" rows="3" height="10" readonly="true"></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right">Phone 1</td>
                            <td>
                                <s:textfield id="vendorInvoice.purchaseOrder.vendor.phone1" name="vendorInvoice.purchaseOrder.vendor.phone1" size="19" readonly="true"></s:textfield>
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Phone 2
                                <s:textfield id="vendorInvoice.purchaseOrder.vendor.phone2" name="vendorInvoice.purchaseOrder.vendor.phone2" size="19" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">NPWP</td>
                            <td>
                                <s:textfield id="vendorInvoice.purchaseOrder.vendor.npwp" name="vendorInvoice.purchaseOrder.vendor.npwp" size="50" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        
                    </table>
                </td>
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><B>Currency *</B></td>
                            <td>
                                <s:textfield id="vendorInvoice.currency.code" name="vendorInvoice.currency.code" readonly="true" title="*" required="true" cssClass="required" size="15"></s:textfield>
                                <s:textfield id="vendorInvoice.currency.name" name="vendorInvoice.currency.name" cssStyle="width:40%" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Exchange Rate * </B></td>
                            <td><s:textfield id="vendorInvoice.exchangeRate" name="vendorInvoice.exchangeRate" size="20"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">
                                <div id="labelVendorInvoiceNo">Invoice No From Vendor *</div>
                            </td>
                            <td><s:textfield id="vendorInvoice.vendorInvoiceNo" name="vendorInvoice.vendorInvoiceNo" showOn="focus"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Invoice Date From Vendor</td>
                            <td><sj:datepicker id="vendorInvoice.vendorInvoiceDate" name="vendorInvoice.vendorInvoiceDate" showOn="focus" required="true" cssClass="required" displayFormat="dd/mm/yy" timepicker="false" timepickerFormat="hh:mm:ss" size="20" changeYear="true" changeMonth="true" ></sj:datepicker> </td>
                        </tr>
                        <tr>
                            <td align="right">Payment Term</td>
                            <td>
                                <s:textfield id="vendorInvoice.purchaseOrder.paymentTerm.code" name="vendorInvoice.purchaseOrder.paymentTerm.code" size="10" readonly="true"></s:textfield>
                               <s:textfield id="vendorInvoice.purchaseOrder.paymentTerm.name" name="vendorInvoice.purchaseOrder.paymentTerm.name"  size="17" readonly="true"></s:textfield>
                                <s:textfield id="vendorInvoice.purchaseOrder.paymentTerm.days" name="vendorInvoice.purchaseOrder.paymentTerm.days" size="9" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Due Date</td>
                            <td>
                                <sj:datepicker id="vendorInvoice.dueDate" name="vendorInvoice.dueDate" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="false" timepickerFormat="hh:mm:ss" size="15" changeYear="true" changeMonth="true" ></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <div id="labelVendorTaxInvoiceNo">Vendor Tax Invoice *</div>
                            </td>
                            <td><s:textfield id="vendorInvoice.vendorTaxInvoiceNo"  name="vendorInvoice.vendorTaxInvoiceNo" size="20" showOn="focus"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Vendor Tax Invoice Date</td>
                            <td><sj:datepicker id="vendorInvoice.vendorTaxInvoiceDate" name="vendorInvoice.vendorTaxInvoiceDate" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="false" timepickerFormat="hh:mm:ss" size="20" changeYear="true" changeMonth="true" ></sj:datepicker> </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td><s:textfield id="vendorInvoice.refNo"  name="vendorInvoice.refNo" size="20" ></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Remark</td>
                            <td><s:textarea id="vendorInvoice.remark"  name="vendorInvoice.remark" cols="30" rows="1"></s:textarea></td>
                        </tr>
                        <tr>
                            <td><s:textfield id="vendorInvoice.createdBy"  name="vendorInvoice.createdBy" size="20" style="display:none"></s:textfield></td>
                            <td><s:textfield id="vendorInvoice.createdDate" name="vendorInvoice.createdDate" size="20" style="display:none"></s:textfield></td>
                            <td><sj:datepicker id="vendorInvoiceFirstDate" name="vendorInvoiceFirstDate" required="true" cssClass="required" showOn="focus" style="display:none"></sj:datepicker></td>
                            <td><sj:datepicker id="vendorInvoiceLastDate" name="vendorInvoiceLastDate" required="true" cssClass="required" showOn="focus" style="display:none"></sj:datepicker></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>

<table>
    <tr height="50">
        <td></td>
        <td>
            <sj:a href="#" id="btnVendorInvoiceConfirm" button="true">Confirm</sj:a>
            <sj:a href="#" id="btnVendorInvoiceUnConfirm" button="true">Un Confirm</sj:a>
        </td>
    </tr>
</table>

<s:url id="remotedetailurlVendorInvoiceGRNDetail" action="" />
<s:url id="remotedetailurlVendorInvoiceDPDetail" action="" />
<div id="vendorInvoiceDetailInput">
    <div>
        <table valign="top" border="0" width="100%">
            <tr valign="top">
                <td valign="top" width="20%">
                    <sjg:grid
                        id="vendorInvoiceGRNDetail_grid"
                        caption="GRN DETAIL"
                        dataType="json"
                        pager="true"
                        navigator="false"
                        navigatorSearch="false"
                        navigatorView="true"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listVendorInvoiceGoodsReceivedNote"
                        viewrecords="true"
                        rownumbers="true"
                        editinline="true"
                        editurl="%{remotedetailurlVendorInvoiceGRNDetail}"
                        shrinkToFit="false"
                        onSelectRowTopics="vendorInvoiceGRNDetail_grid_onSelect"
                    >
                        <sjg:gridColumn
                            name="grnDetailDelete" index="grnDetailDelete" title="" width="50" align="center"
                            editable="true"
                            edittype="button"
                            editoptions="{onClick:'vendorInvoiceGRNGrid_ItemDelete_OnClick()', value:'delete'}"
                        />
                        <sjg:gridColumn
                            name="grnCode" index="grnCode" key="grnCode" title="GRN No" hidden="false" width="150" align="centre"
                        />
                        <sjg:gridColumn
                            name="grnDate" index="grnDate" key="grnDate" 
                            title="GRN Date" width="130" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}" sortable="true" 
                        />
                    </sjg:grid >
                </td>
                <td>
                    <div> 
                    <sjg:grid
                        id="vendorInvoiceDPDetail_grid"
                        caption="VDP DETAIL"
                        dataType="json"
                        pager="true"
                        navigator="false"
                        navigatorSearch="false"
                        navigatorView="true"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listVendorInvoiceDPDetailTemp"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        editinline="true"
                        editurl="%{remotedetailurlVendorInvoiceDPDetail}"
                        onSelectRowTopics="vendorInvoiceDPDetail_grid_onSelect"
                        width="731"
                    >
                        <sjg:gridColumn         
                            name="dpSDPNo" index="dpSDPNo" key="dpSDPNo" title="VDP No" width="150" sortable="true" hidden="false"
                        />
                        <sjg:gridColumn
                            name="dpDate" index="dpDate" key="dpDate" 
                            title="Transaction Date" width="120" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}" sortable="true" 
                        />
                        <sjg:gridColumn         
                            name="dpCurrencyCode" index="dpCurrencyCode" key="dpCurrencyCode" title="Currency" width="80" sortable="true" hidden="false"
                        />
                        <sjg:gridColumn
                            name="dpExchangeRate" index="dpExchangeRate" key="dpExchangeRate" title="ExchangeRate" width="100" sortable="true" 
                            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
                        />
                        <sjg:gridColumn
                            name="dpAmount" index="dpAmount" key="dpAmount" title="Amount" width="150" sortable="true" 
                            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
                        />
                        <sjg:gridColumn
                            name="dpUsed" index="dpUsed" key="dpUsed" title="Used" width="150" sortable="true" 
                            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
                        /><sjg:gridColumn
                            name="dpBalance" index="dpBalance" key="dpBalance" title="Balance" width="150" sortable="true" 
                            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
                        />
                        <sjg:gridColumn
                            name="dpApplied" index="dpApplied" key="dpApplied" title="Applied" width="150" sortable="true" 
                            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" editable="true"
                            edittype="text" editoptions="{onChange:'calculationTotal()'}"
                        />
                        <sjg:gridColumn
                            name="dpForeign" index="dpForeign" key="dpForeign" title="dpForeign" width="150" sortable="true" 
                            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" hidden="true"
                        />
                        <sjg:gridColumn
                            name="forexGainLoss" index="forexGainLoss" key="forexGainLoss" title="forexGainLoss" width="150" sortable="true" 
                            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" hidden="true"
                        />
                    </sjg:grid >
                     </div>
                </td>
            </tr>
        </table>
    </div>
    <br class="spacer" />
    <div>
        <sjg:grid
            id="vendorInvoiceItemDetailInput_grid"
            caption="ITEM DETAIL"
            dataType="local"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listVendorInvoiceItemDetail"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            editinline="true"
            editurl="%{remoteurlVendorInvoiceDetailInput}"
            onSelectRowTopics="vendorInvoiceItemDetail_grid_onSelect"
            width="$('#tabmnuVendorInvoice').width()"
        >
            <sjg:gridColumn
                name="goodsReceivedNoteDetailCode" index="goodsReceivedNoteDetailCode" title="GRN Detail Code" width="150"
            />
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" title="Item" hidden="true" width="150"
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" title="Item" width="150"
            />
            <sjg:gridColumn
                name="inventoryType" index="inventoryType" title="Inventory Type" width="150"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Quantity" 
                formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
            />
            <sjg:gridColumn
                name="price" index="price" key="price" title="Price" 
                formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
            />
            <sjg:gridColumn
                name="discountPercentGrn" index="discountPercentGrn" key="discountPercentGrn" title="Discount (Percent)" 
                formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="discountAmountGrn" index="discountAmountGrn" key="discountAmountGrn" title="Discount (Amount)" 
                formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="nettPrice" index="nettPrice" key="nettPrice" title="Nett Price" 
                formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
            />
            <sjg:gridColumn
                name="total" index="total" key="total" title="Total" 
                formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="150" editable="true"
            />
        </sjg:grid >                  
    </div>
</div>
<br class="spacer" />
<table>
    <tr>
        <td>
            <sj:a href="#" id="btnVendorInvoiceSave" button="true">Save</sj:a>
            <sj:a href="#" id="btnVendorInvoiceCancel" button="true">Cancel</sj:a>
        </td>
    </tr>
</table>

            <s:form id="frmHeaderAmount">
                <br class="spacer" />
                    <td style="margin-left: 10px;">
                        <table style="width: 100%;margin-left: 255px;">
                            <tr><td height="10px" /></tr>
                      <tr>
                        <td style="width: 100%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td align="right"><B>Total Transaction</B>
                                        <s:textfield id="vendorInvoice.totalTransactionAmount" name="vendorInvoice.totalTransactionAmount" cssClass="field-low"  readonly="true" cssStyle="text-align:right" size="25" ></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Discount</B>
                                    <s:textfield id="vendorInvoice.discountPercent" name="vendorInvoice.discountPercent" cssClass="field-min" cssStyle="text-align:right;" size="5"></s:textfield>
                                            %
                                    <s:textfield id="vendorInvoice.discountAmount" name="vendorInvoice.discountAmount" cssClass="field-low" cssStyle="text-align:right" size="25" readonly="true"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Discount Account</B>
                                   
                                        <script type = "text/javascript">
                                        $('#vendorInvoice_btnDiscountAccount').click(function(ev) {
                                                window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorInvoice&idsubdoc=discountChartOfAccount","Search", "width=600, height=500");
                                        });

                                        txtVendorInvoiceDiscountChartOfAccountCode.change(function(ev) {

                                            if(txtVendorInvoiceDiscountChartOfAccountCode.val()===""){
                                                txtVendorInvoiceDiscountChartOfAccountName.val("");
                                                return;
                                            }
                                            var url = "master/chart-of-account-get";
                                            var params = "chartOfAccount.code=" + txtVendorInvoiceDiscountChartOfAccountCode.val();
                                                params += "&chartOfAccount.activeStatus=true";
                                                params += "&chartOfAccount.AccountType=S";

                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.chartOfAccountTemp){
                                                    txtVendorInvoiceDiscountChartOfAccountCode.val(data.chartOfAccountTemp.code);
                                                    txtVendorInvoiceDiscountChartOfAccountName.val(data.chartOfAccountTemp.name);
                                                }
                                                else{
                                                    alertMessage("Chart Of Account Not Found!",txtVendorInvoiceDiscountChartOfAccountCode);
                                                    txtVendorInvoiceDiscountChartOfAccountCode.val("");
                                                    txtVendorInvoiceDiscountChartOfAccountName.val("");
                                                }
                                            });
                                        });
                                        </script>
                                        <div class="searchbox ui-widget-header">
                                            <s:textfield id="vendorInvoice.discountChartOfAccount.code" name="vendorInvoice.discountChartOfAccount.code" title=" " size="20"></s:textfield>
                                            <sj:a id="vendorInvoice_btnDiscountAccount" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                     </td>  
                                    <td>
                                            <s:textfield id="vendorInvoice.discountChartOfAccount.name" name="vendorInvoice.discountChartOfAccount.name" cssClass="field-medium"  readonly="true" size="20"></s:textfield>
                                            <s:textfield id="vendorInvoice.discountDescription" name="vendorInvoice.discountDescription" title=" " PlaceHolder=" Description Discount" size="20"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                <td align="right">Down Payment
                                    <s:textfield id="vendorInvoice.downPaymentAmount" name="vendorInvoice.downPaymentAmount" size="25" cssStyle="text-align:right" readonly="true" value="0.00"></s:textfield>
                                </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Sub Total (Tax Base)</B>
                                        <s:textfield id="vendorInvoice.subTotalAmount" name="vendorInvoice.subTotalAmount" cssClass="field-low"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>VAT</B>
                                        <s:textfield id="vendorInvoice.vatPercent" name="vendorInvoice.vatPercent" cssClass="field-min" cssStyle="text-align:right;" size="5"></s:textfield>
                                            %
                                        <s:textfield id="vendorInvoice.vatAmount" name="vendorInvoice.vatAmount"  cssClass="field-low" readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Other Fee</B>
                                        <s:textfield id="vendorInvoice.otherFeeAmount" name="vendorInvoice.otherFeeAmount" cssClass="field-low" cssStyle="text-align:right" size="25"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><B>Other Account</B>
                                        <script type = "text/javascript">
                                            $('#vendorInvoice_btnOtherFeeAccount').click(function(ev) {
                                                window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorInvoice&idsubdoc=otherFeeChartOfAccount","Search", "width=600, height=500");
                                            });

                                            txtVendorInvoiceOtherFeeChartOfAccountCode.change(function(ev) {
                                                
                                                if(txtVendorInvoiceOtherFeeChartOfAccountCode.val()===""){
                                                    txtVendorInvoiceOtherFeeChartOfAccountCode.val("");
                                                    txtVendorInvoiceOtherFeeChartOfAccountName.val("");
                                                    return;
                                                }
                                                
                                                var url = "master/chart-of-account-get-data";
                                                var params = "chartOfAccount.code=" + txtVendorInvoiceOtherFeeChartOfAccountCode.val();
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.chartOfAccountTemp){
                                                        txtVendorInvoiceOtherFeeChartOfAccountCode.val(data.chartOfAccountTemp.code);
                                                        txtVendorInvoiceOtherFeeChartOfAccountName.val(data.chartOfAccountTemp.name);
                                                    }
                                                    else{
                                                        txtVendorInvoiceOtherFeeChartOfAccountCode.val("");
                                                        txtVendorInvoiceOtherFeeChartOfAccountName.val("");
                                                        alertEx("OtherFeeAccount Not Found");
                                                    }
                                                });
                                            });
                                        </script>
                                        <div class="searchbox ui-widget-header">
                                            <s:textfield id="vendorInvoice.otherFeeChartOfAccount.code" name="vendorInvoice.otherFeeChartOfAccount.code" title="Please Select Invoice Destination!" size="20"></s:textfield>
                                        <sj:a id="vendorInvoice_btnOtherFeeAccount" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                                    </td>  
                                    <td>    
                                        <s:textfield id="vendorInvoice.otherFeeChartOfAccount.name" name="vendorInvoice.otherFeeChartOfAccount.name" cssClass="field-medium"  readonly="true" size="20"></s:textfield>
                                        <s:textfield id="vendorInvoice.otherFeeDescription" name="vendorInvoice.otherFeeDescription" cssClass="field-medium" PlaceHolder=" Description Other Fee" size="20"></s:textfield>
                                    </td>
                                </tr>
                                <tr>
                                <td align="right">Grand Total
                                    <s:textfield id="vendorInvoice.grandTotalAmount" name="vendorInvoice.grandTotalAmount" readonly="true" size="25" cssStyle="text-align:right;"></s:textfield>
                                    <s:textfield id="forexGainLossAmount_sin" name="forexGainLossAmount_sin" size="25" readonly="true" cssStyle="text-align:right;display:none" value="0.00"></s:textfield>
                                </td>
                                </tr>
                            </table>
            </s:form>   
            </div>
<script>
    
    function loadGrnByInvoiceVendor(){
        
        $("#vendorInvoiceGRNDetail_grid").jqGrid('clearGridData');
        $("#vendorInvoiceItemDetailInput_grid").jqGrid('clearGridData');

        var url = "inventory/goods-received-note-po-by-vendor-invoice-data";
        var params = "purchaseOrderSearchCode="+$("#vendorInvoice\\.purchaseOrder\\.code").val();

        showLoading();
        
        $.post(url, params, function (data) {
            closeLoading();
            var vendorInvoiceGRNDetailLastRowId = 0;
            for (var i = 0; i < data.listGoodsReceivedNote.length; i++) {
                var transactionDate=formatDateRemoveT(data.listGoodsReceivedNote[i].transactionDate, false);
                $("#vendorInvoiceGRNDetail_grid").jqGrid("addRowData", vendorInvoiceGRNDetailLastRowId, data.listGoodsReceivedNote[i]);
                $("#vendorInvoiceGRNDetail_grid").jqGrid('setRowData', vendorInvoiceGRNDetailLastRowId, {
                    grnCode             : data.listGoodsReceivedNote[i].code,
                    grnDate             : transactionDate
                });
                
                loadItemDetailByInvoiceVendor(data.listGoodsReceivedNote[i].code);
                vendorInvoiceGRNDetailLastRowId++;
            }
        });
    
    }
    
    function loadGrnByInvoiceVendorUpdate(){
        
        $("#vendorInvoiceGRNDetail_grid").jqGrid('clearGridData');
        $("#vendorInvoiceItemDetailInput_grid").jqGrid('clearGridData');

        var url = "inventory/goods-received-note-po-non-cash-by-vendor-invoice-data-update";
        var params = "purchaseOrderSearchCode="+$("#vendorInvoice\\.purchaseOrder\\.code").val();
            params += "&vinNo="+$("#vendorInvoice\\.code").val();
          
        showLoading();
        $.post(url, params, function (data) {
            closeLoading();
            var vendorInvoiceGRNDetailLastRowId = 0;
            for (var i = 0; i < data.listGoodsReceivedNote.length; i++) {
                var transactionDate=formatDateRemoveT(data.listGoodsReceivedNote[i].transactionDate, false);
                $("#vendorInvoiceGRNDetail_grid").jqGrid("addRowData", vendorInvoiceGRNDetailLastRowId, data.listGoodsReceivedNote[i]);
                $("#vendorInvoiceGRNDetail_grid").jqGrid('setRowData', vendorInvoiceGRNDetailLastRowId, {
                    grnCode             : data.listGoodsReceivedNote[i].code,
                    grnDate             : transactionDate
                });
                
                loadItemDetailByInvoiceVendor(data.listGoodsReceivedNote[i].code);
                vendorInvoiceGRNDetailLastRowId++;
            }
        });
    
    }
    
    function loadDPByInvoiceVendor(){
        
        $("#vendorInvoiceDPDetail_grid").jqGrid('clearGridData');

        var url = "finance/vendor-down-payment-by-vendor-invoice-data";
        var params = "vendorDownPaymentVendorSearchCode="+$("#vendorInvoice\\.purchaseOrder\\.vendor\\.code").val();

        showLoading();
        $.post(url, params, function (data) {
            closeLoading();
            var vendorInvoiceDPDetailLastRowId = 0;
            
            for (var i = 0; i < data.listVendorDownPaymentTemp.length; i++) {
                var transactionDate=formatDateRemoveT(data.listVendorDownPaymentTemp[i].transactionDate, false);
                $("#vendorInvoiceDPDetail_grid").jqGrid("addRowData", vendorInvoiceDPDetailLastRowId, data.listVendorDownPaymentTemp[i]);
                $("#vendorInvoiceDPDetail_grid").jqGrid('setRowData', vendorInvoiceDPDetailLastRowId, {
                    dpSDPNo                 : data.listVendorDownPaymentTemp[i].vdpNo,
                    dpDate                  : transactionDate,
                    dpCurrencyCode          : data.listVendorDownPaymentTemp[i].currencyCode,
                    dpExchangeRate          : data.listVendorDownPaymentTemp[i].exchangeRate,
                    dpAmount                : data.listVendorDownPaymentTemp[i].totalTransactionAmount,
                    dpUsed                  : data.listVendorDownPaymentTemp[i].usedAmount,
                    dpBalance               : data.listVendorDownPaymentTemp[i].balance,
                    dpApplied               : data.listVendorDownPaymentTemp[i].appliedAmount
                });
                vendorInvoiceDPDetailLastRowId++;
            }
        });
    }
    
    function loadDPByInvoiceVendorUpdate(){
        
        $("#vendorInvoiceDPDetail_grid").jqGrid('clearGridData');

        var url = "finance/vendor-invoice-dp-data";
        var params = "headerCode="+$("#vendorInvoice\\.code").val();

        showLoading();
        $.post(url, params, function (data) {
            closeLoading();
            var vendorInvoiceDPDetailLastRowId = 0;
            for (var i = 0; i < data.listVendorInvoiceVendorDownPaymentTemp.length; i++) {
                 var transactionDate=formatDateRemoveT(data.listVendorInvoiceVendorDownPaymentTemp[i].transactionDate, false);
                $("#vendorInvoiceDPDetail_grid").jqGrid("addRowData", vendorInvoiceDPDetailLastRowId, data.listVendorInvoiceVendorDownPaymentTemp[i]);
                $("#vendorInvoiceDPDetail_grid").jqGrid('setRowData', vendorInvoiceDPDetailLastRowId, {
                    dpSDPNo                 : data.listVendorInvoiceVendorDownPaymentTemp[i].code,
                    dpDate                  : transactionDate,
                    dpCurrencyCode          : data.listVendorInvoiceVendorDownPaymentTemp[i].currencyCode,
                    dpExchangeRate          : data.listVendorInvoiceVendorDownPaymentTemp[i].exchangeRate,
                    dpAmount                : data.listVendorInvoiceVendorDownPaymentTemp[i].totalTransactionAmount,
                    dpUsed                  : data.listVendorInvoiceVendorDownPaymentTemp[i].usedAmount,
                    dpBalance               : data.listVendorInvoiceVendorDownPaymentTemp[i].balance,
                    dpApplied               : data.listVendorInvoiceVendorDownPaymentTemp[i].applied
                });
                vendorInvoiceDPDetailLastRowId++;
            }
        });
    }
    
    function loadItemDetailByInvoiceVendor(prm){
        var url = "inventory/goods-received-note-detail-po-by-vendor-invoice-data";
        var params = "goodsReceivedNote.code="+ prm;

        showLoading();
        $.post(url, params, function (data) {
            closeLoading();
            for (var i = 0; i < data.listGoodsReceivedNoteItemDetail.length; i++) {
                
                var itemTotal = parseFloat($("#vendorInvoice\\.totalTransactionAmount").val().replace(/,/g, ""));
                
                $("#vendorInvoiceItemDetailInput_grid").jqGrid("addRowData", vendorInvoiceItemDetailLastRowId, data.listGoodsReceivedNoteItemDetail[i]);
                $("#vendorInvoiceItemDetailInput_grid").jqGrid('setRowData', vendorInvoiceItemDetailLastRowId, {
                    goodsReceivedNoteDetailCode : data.listGoodsReceivedNoteItemDetail[i].code,
                    itemMaterialCode            : data.listGoodsReceivedNoteItemDetail[i].itemMaterialCode,
                    itemMaterialName            : data.listGoodsReceivedNoteItemDetail[i].itemMaterialName,
                    inventoryType               : data.listGoodsReceivedNoteItemDetail[i].inventoryType,
                    quantity                    : data.listGoodsReceivedNoteItemDetail[i].quantity,
                    price                       : data.listGoodsReceivedNoteItemDetail[i].price,
                    discountPercentGrn          : data.listGoodsReceivedNoteItemDetail[i].discountPercent,
                    discountAmountGrn           : data.listGoodsReceivedNoteItemDetail[i].discountAmount,
                    nettPrice                   : data.listGoodsReceivedNoteItemDetail[i].nettPrice,
                    total                       : data.listGoodsReceivedNoteItemDetail[i].total,
                    discountChartOfAccountCode  : data.listGoodsReceivedNoteItemDetail[i].discountChartOfAccountCode,
                    discountChartOfAccountName  : data.listGoodsReceivedNoteItemDetail[i].discountChartOfAccountName,
                    discountDescription         : data.listGoodsReceivedNoteItemDetail[i].discountDescription,
                    vatPercent                  : data.listGoodsReceivedNoteItemDetail[i].vatPercent,
                    vatAmount                   : data.listGoodsReceivedNoteItemDetail[i].vatAmount,
                    otherFeeAmount              : data.listGoodsReceivedNoteItemDetail[i].otherFeeAmount,
                    otherFeeChartOfAccountCode  : data.listGoodsReceivedNoteItemDetail[i].otherFeeChartOfAccountCode,
                    otherFeeChartOfAccountName  : data.listGoodsReceivedNoteItemDetail[i].otherFeeChartOfAccountName,
                    otherFeeDescription         : data.listGoodsReceivedNoteItemDetail[i].otherFeeDescription,
                    unitOfMeasureCode           : data.listGoodsReceivedNoteItemDetail[i].unitOfMeasureCode,
                    itemBrandName               : data.listGoodsReceivedNoteItemDetail[i].itemBrandName,
                    remark                      : data.listGoodsReceivedNoteItemDetail[i].remark
                });
                
                itemTotal += parseFloat(data.listGoodsReceivedNoteItemDetail[i].total);
                $("#vendorInvoice\\.totalTransactionAmount").val(formatNumber(itemTotal, 2));
                
                if (data.listGoodsReceivedNoteItemDetail[i].inventoryType === "Inventory") {
                    totalInventory += parseFloat(data.listGoodsReceivedNoteItemDetail[i].total);
                    $("#vendorInvoiceTotalTransactionInventory").val(formatNumber(totalInventory, 2));
                }else if (data.listGoodsReceivedNoteItemDetail[i].inventoryType === "Non Inventory") {
                    totalNonInventory += parseFloat(data.listGoodsReceivedNoteItemDetail[i].total);
                    $("#vendorInvoiceTotalTransactionNonInventory").val(formatNumber(totalNonInventory, 2));
                }
                
                
                vendorInvoiceItemDetailLastRowId++;
                
                calculationTotal();
            }
            
        });
    
    }
    
</script>