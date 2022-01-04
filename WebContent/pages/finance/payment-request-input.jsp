
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #paymentRequestDetailDocumentInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var paymentRequestDetaillastRowId=0,paymentRequestDetail_lastSel = -1;
    var paymentRequestFlagConfirmed=false;
    var 
        txtPaymentRequestCode = $("#paymentRequest\\.code"),
        txtPaymentRequestBranchCode = $("#paymentRequest\\.branch\\.code"),
        txtPaymentRequestBranchName = $("#paymentRequest\\.branch\\.name"),
        dtpPaymentRequestTransactionDate = $("#paymentRequest\\.transactionDate"),
        dtpPaymentRequestScheduleDate = $("#paymentRequest\\.scheduleDate"),
        txtPaymentRequestPaymentTo = $("#paymentRequest\\.paymentTo"),
        txtPaymentRequestCurrencyCode = $("#paymentRequest\\.currency\\.code"),
        txtPaymentRequestCurrencyName = $("#paymentRequest\\.currency\\.name"),
        txtPaymentRequestExchangeRate = $("#paymentRequest\\.exchangeRate"),
        txtPaymentRequestTotalTransactionAmountForeign = $("#paymentRequest\\.totalTransactionAmount"),
        txtPaymentRequestRefNo = $("#paymentRequest\\.refNo"),
        txtPaymentRequestRemark = $("#paymentRequest\\.remark"),
        dtpPaymentRequestCreatedDate = $("#paymentRequest\\.createdDate"),               
        txtPaymentRequestTotalDebitForeign = $("#paymentRequestTotalDebitForeign"),
        txtPaymentRequestTotalCreditForeign = $("#paymentRequestTotalCreditForeign"),
        txtPaymentRequestTotalBalanceForeign = $("#paymentRequestTotalBalanceForeign"),
        
        txtPaymentRequestVendorDepositTypeCode=$("#paymentRequest\\.vendorDepositType\\.code"),
        txtPaymentRequestVendorDepositTypeName=$("#paymentRequest\\.vendorDepositType\\.name"),
        txtPaymentRequestVendorDepositTypeChartOfAccountCode=$("#paymentRequest\\.vendorDepositType\\.chartOfAccountCode"),
        txtPaymentRequestVendorDepositTypeChartOfAccountName=$("#paymentRequest\\.vendorDepositType\\.chartOfAccountName"),

        txtPaymentRequestCashPaymentCashAccountCode = $("#paymentRequest\\.cashAccount\\.code"),
        txtPaymentRequestCashPaymentCashAccountName = $("#paymentRequest\\.cashAccount\\.name"),
        txtPaymentRequestCashPaymentEmployeeCode = $("#paymentRequest\\.employee\\.code"),
        txtPaymentRequestCashPaymentEmployeeName = $("#paymentRequest\\.employee\\.name"),
        txtPaymentRequestCashPaymentCurrencyCode = $("#paymentRequest\\.currencyCashPayment\\.code"),
        txtPaymentRequestCashPaymentCurrencyName = $("#paymentRequest\\.currencyCashPayment\\.name"),
        txtPaymentRequestCashPaymentExchangeRate = $("#paymentRequest\\.cashPaymentExchangeRate");
        
    $(document).ready(function() {

        paymentRequestFlagConfirmed=false;
        paymentRequestOnChangeTransactionType();
        paymentRequestFormatNumeric2();
        setPaymentRequestTransactionType();

        $('#paymentRequestInputCashPayment').hide();
 
        if($("#paymentRequestUpdateMode").val()==="false"){
            setCurrency();
        }
        $("#paymentRequest\\.totalTransactionAmount").attr("autocomplete", "off");
        $("#paymentRequest\\.transactionDate").attr("autocomplete", "off");
        
        $('input[name="paymentRequestTransactionTypeRad"][value="REGULAR"]').change(function(ev){
            var value="REGULAR";
            $("#paymentRequest\\.transactionType").val(value);
            
            $('#paymentRequest\\.vendorDepositType\\.code').attr('readonly',true);
            $('#paymentRequest_btnVendorDepositType').hide();
            $('#paymentRequest\\.vendorDepositType\\.code').val("");
            $('#paymentRequest\\.vendorDepositType\\.chartOfAccountCode').val("");
            $('#paymentRequest\\.vendorDepositType\\.chartOfAccountName').val("");
            $('#paymentRequest\\.vendorDepositType\\.name').val("");
        });
                
        $('input[name="paymentRequestTransactionTypeRad"][value="DEPOSIT"]').change(function(ev){
            var value="DEPOSIT";
            $("#paymentRequest\\.transactionType").val(value);
            
            $('#paymentRequest\\.vendorDepositType\\.code').attr('readonly',false);
            $('#paymentRequest_btnVendorDepositType').show();
        });
                
        $("#paymentRequest\\.totalTransactionAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#paymentRequest\\.totalTransactionAmount").change(function(e){
            var amount=$("#paymentRequest\\.totalTransactionAmount").val();
            if(amount===""){
               $("#paymentRequest\\.totalTransactionAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
        });
                 
        $('#btnPaymentRequestSave').click(function(ev) {
            
            //Check Spcial karakter allowed(dot,comma,underscore,dash).
            //regexSpecialCharacter di declare di panel.jsp
            var refno=txtPaymentRequestRefNo.val();
            var remark=txtPaymentRequestRemark.val();
              
            if(refno!==""){
                if(!refno.match(regexSpecialCharacter)){
                    refno = escape(refno);
//                     alertMessage("Refno : Save Failed, Special character is not allowed"+notAllowedCharacter,$("#paymentRequest\\.refNo"));
//                     return;
                }
            }
            
            if(remark!==""){
                if(!remark.match(regexSpecialCharacter)){
                    remark = escape(remark);
//                    alertMessage("Remark : Save Failed, Special character is not allowed"+notAllowedCharacter,$("#paymentRequest\\.remark"));
//                    return;
                }
            }
//            alert(refno+" - "+remark);
//            return;
            $("#btnPaymentRequestCalculate").trigger("click");
            if(paymentRequestDetail_lastSel !== -1) {
                $('#paymentRequestDetailDocumentInput_grid').jqGrid("saveRow",paymentRequestDetail_lastSel); 
            }

            var ids = jQuery("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs'); 
            var totalBalanceForeign = parseFloat(removeCommas(txtPaymentRequestTotalBalanceForeign.val()));
                            
            // cek isi detail
            if(ids.length===0){
                alertMessage("Grid Payment Request Detail Is Not Empty");
                return;
            }
            
            // cek balance apabila foreign or IDR
            if (totalBalanceForeign !== 0) {
                alertMessage("Balance Foreign Must be 0");
                return;
            }
            
            var listPaymentRequestDetail = new Array(); 
            var documentForApprovedStatus = "true";
            var totalOtherAmount = 0;

            for(var i=0;i < ids.length;i++){
                var data = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 
                var documentNo = data.paymentRequestDetailDocumentDocumentNo;
                var transactionStatus = data.paymentRequestDetailDocumentTransactionStatus;
                var documentAccountName = data.paymentRequestDetailDocumentChartOfAccountName;

                var debitValue=parseFloat(data.paymentRequestDetailDocumentDebitForeign);
                var creditValue=parseFloat(data.paymentRequestDetailDocumentCreditForeign);
                var departmentCode = data.paymentRequestDetailDocumentDepartmentCode;
                
                //validate department wajib diisi
                if(departmentCode === ""){
                    alertMessage("Department Code Must Be Filled!");
                    return; 
                }
                
                if(debitValue<0){
                    alertMessage("Symbol Minus Not Recommended In Debit Column!");
                    return;
                }
                
                if(data.paymentRequestDetailDocumentChartOfAccountCode===""){
                    alertMessage("Chart Of Account Cannot Be Empty!");
                    return;
                }
                
                if(data.paymentRequestDetailDocumentDepartmentCode===""){
                    alertMessage("Department Cannot Be Empty!");
                    return;
                }

                if(creditValue<0){
                    alertMessage("Symbol Minus Not Recommended In Credit Column!");
                    return;
                }

                if(debitValue===0 && creditValue===0){
                    alertMessage("Debit and Credit Cannot be Filled All With 0 Value!");
                    return;
                }                   

                if(debitValue>0 && creditValue>0){
                    alertMessage("Debit and Credit Cannot be Filled All!");
                    return;
                }                   

                //cek transaction status
                if(transactionStatus==="---Select---"){
                    alertMessage("Please Select Transaction Status");
                    return;
                }
                else{
                    switch(transactionStatus){
                        case "Transaction":
                            if(documentNo===" "){
                                alertMessage("The Following Required Field have been empty: Document No");
                                return;
                            }
                            if(documentAccountName===" "){
                                alertMessage("The Following Required Field have been empty: Chart Of Account");
                                return;
                            }
                            break;
                        case "Other":
                            if(documentAccountName===" "){
                                alertMessage("The Following Required Field have been empty: Chart Of Account");
                                return;
                            }
                            
                            documentForApprovedStatus = "false"; 
                        break;
                    }
                }

//                if(documentNo !==" "){
//                    for(var j=0;j<ids.length;j++){
//                        if(j!==i){
//                            var dataCheck = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getRowData',ids[j]);
//                            if(dataCheck.paymentRequestDetailDocumentDocumentNo===documentNo){
//                                if(dataCheck.paymentRequestDetailDocumentTransactionStatus===transactionStatus){
//                                    alertMessage("You Have Invalid Transaction Status For Document : " + documentNo);
//                                    return;
//                                }
//                            }
//                        }
//                    }
//                }

                var paymentRequestDetail = { 
                    chartOfAccount       : {code:data.paymentRequestDetailDocumentChartOfAccountCode},
                    debit                : data.paymentRequestDetailDocumentDebitForeign,
                    credit               : data.paymentRequestDetailDocumentCreditForeign,
                    documentBranchCode   : data.paymentRequestDetailDocumentBranchCode,
                    documentNo           : data.paymentRequestDetailDocumentDocumentNo,
                    documentDate         : data.paymentRequestDetailDocumentDocumentDate,
                    dueDate              : data.paymentRequestDetailDocumentDueDate,
                    documentType         : data.paymentRequestDetailDocumentDocumentType,
                    transactionStatus    : data.paymentRequestDetailDocumentTransactionStatus,
                    currency             : {code:data.paymentRequestDetailDocumentCurrencyCode},
                    department           : {code:data.paymentRequestDetailDocumentDepartmentCode},
                    exchangeRate         : data.paymentRequestDetailDocumentExchangeRate,
                    remark               : escape(data.paymentRequestDetailDocumentRemark)
                };
 
                listPaymentRequestDetail[i] = paymentRequestDetail;
                
                if(transactionStatus === "Other"){
                    totalOtherAmount += parseFloat(data.paymentRequestDetailDocumentDebitForeign);
                }
            }
            
            paymentRequestFormatDate();
            paymentRequestUnFormatNumeric();
            
            var url = "finance/payment-request-save";
            var params = $("#frmPaymentRequestInput").serialize();
                params += "&listPaymentRequestDetailJSON=" + $.toJSON(listPaymentRequestDetail);
                params += "&documentForApprovedStatus=" + documentForApprovedStatus;
                params += "&totalPaymentRequestAmount=" + totalOtherAmount;

            showLoading();
                
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    paymentRequestFormatDate();
                    paymentRequestFormatNumeric();
                    alertMessage(data.errorMessage);
                    return;
                }
                switch($("#paymentRequestUpdateMode").val()){
                case "true":
                        alertMessage("UPDATED DATA SUCCESS PAYMENT REQUEST No: "+txtPaymentRequestCode.val()+" ");
                        var url = "finance/payment-request";
                        var params = "";
                        pageLoad(url, params, "#tabmnuPAYMENT_REQUEST");
                    break;
                case "false":
                    var dynamicDialog= $('<div id="conformBox">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');

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
                                    var url = "finance/payment-request-input";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuPAYMENT_REQUEST");
                                }
                            },
                            {
                                text : "No",
                                click : function() {
                                    $(this).dialog("close");
                                    var url = "finance/payment-request";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuPAYMENT_REQUEST");
                                }
                            }]
                    });
                    break;
                }
            });
        });

        $("#btnUnConfirmPaymentRequest").css("display", "none");
        $("#btnSearchDocFinancePaymentRequest").css("display", "none");
        $('#paymentRequestDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
       
        $("#btnConfirmPaymentRequest").click(function(ev) {
            
            if (txtPaymentRequestBranchCode.val()===""){
                alertMessage("Branch can't be null", txtPaymentRequestBranchCode);
                return;
            }
                       
            if (txtPaymentRequestPaymentTo.val()===""){
                alertMessage("Payment To can't be null", txtPaymentRequestPaymentTo);
                return;
            }
            
            if (txtPaymentRequestCurrencyCode.val()===""){
                alertMessage("Currency can't be null", txtPaymentRequestCurrencyCode);
                return;
            }
            
            if (txtPaymentRequestTotalTransactionAmountForeign.val()==="0.00"){
                alertMessage("Amount Must More Than 0", txtPaymentRequestTotalTransactionAmountForeign);
                return;
            }
           
//            finance_request_handlers_input();
            if(!$("#frmPaymentRequestInput").valid()) {
//                alertMessage("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            if($("#paymentRequest\\.transactionType").val() === "DEPOSIT" || $("#paymentRequest\\.transactionType").val() === "Deposit"){
                if($("#paymentRequest\\.vendorDepositType\\.chartOfAccountCode").val() === ""){
                    alertMessage("Please Set Vendor Deposit Type - Branch Chart Of Account");
                    return;
                }
            }
            
            var date1 = dtpPaymentRequestTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#paymentRequestTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#paymentRequestUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#paymentRequestTransactionDate").val());
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!");
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#paymentRequestUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#paymentRequestTransactionDate").val());
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!");
                }
                return;
            }
            
            //button confirm/unconfirm (main)
            paymentRequestFlagConfirmed=true;
            $("#btnUnConfirmPaymentRequest").css("display", "block");
            $("#btnConfirmPaymentRequest").css("display", "none");
            $('#PaymentRequestHeaderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#paymentRequestDetailDocumentInputGrid').unblock();
            
            if($("#paymentRequestUpdateMode").val()==="false"){
                
                if($("#paymentRequest\\.transactionType").val() === "REGULAR"){
                    
                    $("#btnSearchDocFinancePaymentRequest").css("display", "block");
                    $("#paymentRequestAddRowValidation").show();
                    
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentDebitForeign', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentCreditForeign', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentRemark', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('showCol',["paymentRequestDetailChartOfAccountSearch"]); 
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentChartOfAccountCode', { editable: true });
//                    $("#btnSearchDocFinancePaymentRequest").css("display", "none");
                }
                
                if($("#paymentRequest\\.transactionType").val() === "DEPOSIT"){
                    
                    $("#btnSearchDocFinancePaymentRequest").css("display", "none");
                    $("#paymentRequestAddRowValidation").hide();
                    

                    var AddRowCount =parseFloat(removeCommas($("#paymentRequestAddRow").val()));
                    var currencyHeader = txtPaymentRequestCurrencyCode.val();
                    var exchangeRateHeader = txtPaymentRequestExchangeRate.val();
                    
                        var defRow = {
                            paymentRequestDetailDocumentDocumentNo          : " ",
                            paymentRequestDetailDocumentCurrencyCode        : currencyHeader,
                            paymentRequestDetailDocumentExchangeRate        : exchangeRateHeader,
                            paymentRequestDetailDocumentTransactionStatus   : "Other",
                            paymentRequestDetailDocumentDebitForeign        : removeCommas(txtPaymentRequestTotalTransactionAmountForeign.val()),
                            paymentRequestDetailDocumentChartOfAccountCode  : $("#paymentRequest\\.vendorDepositType\\.chartOfAccountCode").val(),
                            paymentRequestDetailDocumentChartOfAccountName  : $("#paymentRequest\\.vendorDepositType\\.chartOfAccountName").val()
                        };

                        $("#paymentRequestDetailDocumentInput_grid").jqGrid("addRowData", paymentRequestDetaillastRowId, defRow);
                        be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                        $("#paymentRequestDetailDocumentInput_grid").jqGrid('setRowData',paymentRequestDetaillastRowId,{Buttons:be});
                    
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentDebitForeign', { editable: false });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentCreditForeign', { editable: false });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentRemark', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('hideCol',["paymentRequestDetailChartOfAccountSearch"]); 
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentChartOfAccountCode', { editable: false });
                    $("#btnSearchDocFinancePaymentRequest").css("display", "none");
                }
                    
            }else{
                
                paymentRequestLoadDataDetail();
                
                if($("#paymentRequest\\.transactionType").val() === "REGULAR"){
                    
                    $("#btnSearchDocFinancePaymentRequest").css("display", "block");
                    $("#paymentRequestAddRowValidation").show();
                    
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentDebitForeign', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentCreditForeign', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentRemark', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('showCol',["paymentRequestDetailChartOfAccountSearch"]); 
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentChartOfAccountCode', { editable: true });
                    
                }
                
                if($("#paymentRequest\\.transactionType").val() === "DEPOSIT"){
                    
                    $("#btnSearchDocFinancePaymentRequest").css("display", "none");
                    $("#paymentRequestAddRowValidation").hide();
                    
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentDebitForeign', { editable: false });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentCreditForeign', { editable: false });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentRemark', { editable: true });
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('hideCol',["paymentRequestDetailChartOfAccountSearch"]); 
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentChartOfAccountCode', { editable: false });
                    $("#btnSearchDocFinancePaymentRequest").css("display", "none");
                }
            }
            
        });
        
        $("#btnUnConfirmPaymentRequest").click(function(ev) {

            var rows = jQuery("#paymentRequestDetailDocumentInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                paymentRequestFlagConfirmed=false; 
                $("#paymentRequestDetailDocumentInput_grid").jqGrid('clearGridData');
                $("#btnUnConfirmPaymentRequest").css("display", "none");
                $("#btnSearchDocFinancePaymentRequest").css("display", "none");
                $("#btnConfirmPaymentRequest").css("display", "block");
                $('#PaymentRequestHeaderInput').unblock();
                $('#paymentRequestInputCashPayment').hide();
                txtPaymentRequestCashPaymentCashAccountCode.val("");
                txtPaymentRequestCashPaymentCashAccountName.val("");
                txtPaymentRequestCashPaymentEmployeeCode.val("");
                txtPaymentRequestCashPaymentEmployeeName.val("");
                txtPaymentRequestCashPaymentCurrencyCode.val("");
                txtPaymentRequestCashPaymentCurrencyName.val("");
                txtPaymentRequestCashPaymentExchangeRate.val("1.00");
                $('#paymentRequestDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                return;
                
//                if($("#paymentRequest\\.transactionType").val() === "DEPOSIT"){
//                    paymentRequestFlagConfirmed=false;
//                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('clearGridData');
//                    $("#btnUnConfirmPaymentRequest").css("display", "none");
//                    $("#btnSearchDocFinancePaymentRequest").css("display", "none");
//                    $("#btnConfirmPaymentRequest").css("display", "block");
//                    $('#PaymentRequestHeaderInput').unblock();
//                    $('#paymentRequestDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
//
//                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentDebitForeign', { editable: true });
//                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentCreditForeign', { editable: true });
//                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentRemark', { editable: true });
//                    $("#paymentRequestDetailDocumentInput_grid").jqGrid('setColProp', 'paymentRequestDetailDocumentChartOfAccountCode', { editable: true });
//                    $("#paymentRequestAddRowValidation").show();
//                    return;
//                }
            }
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');
                            
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
                            paymentRequestFlagConfirmed=false;
                            $("#paymentRequestDetailDocumentInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmPaymentRequest").css("display", "none");
                            $("#btnSearchDocFinancePaymentRequest").css("display", "none");
                            $("#btnConfirmPaymentRequest").css("display", "block");
                            $('#PaymentRequestHeaderInput').unblock();
                            $('#paymentRequestInputCashPayment').hide();
                            txtPaymentRequestCashPaymentCashAccountCode.val("");
                            txtPaymentRequestCashPaymentCashAccountName.val("");
                            txtPaymentRequestCashPaymentEmployeeCode.val("");
                            txtPaymentRequestCashPaymentEmployeeName.val("");
                            txtPaymentRequestCashPaymentCurrencyCode.val("");
                            txtPaymentRequestCashPaymentCurrencyName.val("");
                            txtPaymentRequestCashPaymentExchangeRate.val("1.00");
                            $('#paymentRequestDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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

        $.subscribe("paymentRequestDetailDocumentInput_grid_onSelect", function() {
            var selectedRowID = $("#paymentRequestDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==paymentRequestDetail_lastSel) {

                $('#paymentRequestDetailDocumentInput_grid').jqGrid("saveRow",paymentRequestDetail_lastSel); 
                $('#paymentRequestDetailDocumentInput_grid').jqGrid("editRow",selectedRowID,true);            

                paymentRequestDetail_lastSel=selectedRowID;

            }else{
                $('#paymentRequestDetailDocumentInput_grid').jqGrid("saveRow",selectedRowID);
            }

        });

        $('#btnPaymentRequestAddDetail').click(function(ev) {

            if(!paymentRequestFlagConfirmed){
                alertMessage("Please Confirm!",$("#btnConfirmPaymentRequest"));
                return;
            }
            if($("#paymentRequest\\.transactionType").val()!== "DEPOSIT"){
                $('#paymentRequestDetailDocumentInputGrid').unblock();
                    var AddRowCount =parseFloat(removeCommas($("#paymentRequestAddRow").val()));
                    for(var i=0; i<AddRowCount; i++){
                      var defRow = {
                            paymentRequestDetailDocumentDocumentNo          : " ",
                            paymentRequestDetailDocumentCurrencyCode        : txtPaymentRequestCurrencyCode.val(),
                            paymentRequestDetailDocumentTransactionStatus   : "Other",
                            paymentRequestDetailDocumentExchangeRate        : 1
                        };
                        
                        paymentRequestDetaillastRowId++;
                        $("#paymentRequestDetailDocumentInput_grid").jqGrid("addRowData", paymentRequestDetaillastRowId, defRow);
                        
                        var be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                        $("#paymentRequestDetailDocumentInput_grid").jqGrid('setRowData',paymentRequestDetaillastRowId,{Buttons:be});

                    }
                    $("#paymentRequestAddRow").val("1");
            }else{
                alertMessage("Hanya Boleh Satu Document Untuk Deposit [DP]!");
            }
        });   
        
        $('#btnPaymentRequestCancel').click(function(ev) {
            var url = "finance/payment-request";
            var params = "";
            pageLoad(url, params, "#tabmnuPAYMENT_REQUEST"); 

        });
        
        $('#paymentRequest_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=paymentRequest&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#paymentRequest_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=paymentRequest&idsubdoc=currency","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#btnPaymentRequestCalculate').click(function(ev) {
            
            if(paymentRequestDetail_lastSel !== -1) {
                $('#paymentRequestDetailDocumentInput_grid').jqGrid("saveRow",paymentRequestDetail_lastSel); 
            }
            
            // cek quantity debit/credit tidak boleh lebih dari doc Balance (Foreign)
            var selectedRowID = $("#paymentRequestDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");
            var idsSource = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs');
            
            for (var i = 0; i < idsSource.length; i++) {
                var data = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getRowData', idsSource[i]);
                
                if(data.paymentRequestDetailDocumentTransactionStatus === "Transaction"){
                    if( parseFloat(data.paymentRequestDetailDocumentDebitForeign) > parseFloat(data.paymentRequestDetailDocumentBalanceForeign)){
                        alertMessage("Debit Can't be Greather than document balance amount");
                        return;
                    }

                    if( parseFloat(data.paymentRequestDetailDocumentCreditForeign) > parseFloat(data.paymentRequestDetailDocumentBalanceForeign)){
                        alertMessage("Credit Can't be Greather than document balance amount");
                        return;
                    }
                }
            }

            var ids = jQuery("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs'); 


            var DebitForeign = 0;

            var CreditForeign = $("#paymentRequest\\.totalTransactionAmount").val().replace(/,/g,"");

            var BalanceForeign = 0;

            CreditForeign = parseFloat(CreditForeign);

            for(var i=0;i < ids.length;i++){ 
                var data = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 

                var documentDebitForeign = data.paymentRequestDetailDocumentDebitForeign;
                var documentCreditForeign = data.paymentRequestDetailDocumentCreditForeign;
                DebitForeign = (parseFloat(DebitForeign) + parseFloat(documentDebitForeign)).toFixed(2);

                CreditForeign = (parseFloat(CreditForeign) + parseFloat(documentCreditForeign)).toFixed(2);         
            }

            var splitDebitForeign=DebitForeign.split('.');
            var DebitForeignFormat;
            if(splitDebitForeign[0].length>3){
                var concatDebitForeign=parseFloat(splitDebitForeign[0]+'.'+splitDebitForeign[1]);
                DebitForeignFormat=formatNumber(concatDebitForeign,2);
            }else{
                DebitForeignFormat=splitDebitForeign[0]+'.'+splitDebitForeign[1];
            }
            txtPaymentRequestTotalDebitForeign.val(DebitForeignFormat);

            var splitCreditForeign=CreditForeign.split('.');
            var CreditForeignFormat;
            if(splitCreditForeign[0].length>3){
                var concatCreditForeign=parseFloat(splitCreditForeign[0]+'.'+splitCreditForeign[1]);
                CreditForeignFormat=formatNumber(concatCreditForeign,2);
            }else{
                CreditForeignFormat=splitCreditForeign[0]+'.'+splitCreditForeign[1];
            }
            txtPaymentRequestTotalCreditForeign.val(CreditForeignFormat);
            
            BalanceForeign = (DebitForeign - CreditForeign).toFixed(2);

            var splitBalanceForeign=BalanceForeign.split('.');
            var BalanceForeignFormat;
            if(splitBalanceForeign[0].length>3){
                var concatBalanceForeign=parseFloat(splitBalanceForeign[0]+'.'+splitBalanceForeign[1]);
                BalanceForeignFormat=formatNumber(concatBalanceForeign,2);
            }else{
                BalanceForeignFormat=splitBalanceForeign[0]+'.'+splitBalanceForeign[1];
            }
            txtPaymentRequestTotalBalanceForeign.val(BalanceForeignFormat);
            
        });
    });//EOF Ready
    
    function paymentRequestTransactionDateOnChange(){
        if($("#paymentRequestUpdateMode").val()!=="true"){
            $("#paymentRequestTransactionDate").val(dtpPaymentRequestTransactionDate.val());
        }
    }
    function paymentRequestScheduleDateOnChange(){
        if($("#paymentRequestUpdateMode").val()!=="true"){
            $("#paymentRequestScheduleDate").val(dtpPaymentRequestScheduleDate.val());
        }
    }
   
    function setCurrency(){

            var url = "master/currency-get";
            var params = "currency.code=IDR";
                params+= "&currency.activeStatus=TRUE";

            $.post(url, params, function(result) {
                var data = (result);
                if (data.currencyTemp){
                    txtPaymentRequestCurrencyCode.val(data.currencyTemp.code);
                    txtPaymentRequestCurrencyName.val(data.currencyTemp.name);
                    txtPaymentRequestExchangeRate.val(1);
                   
                }
                else{
                    alertMessage("Currency Not Found!",txtPaymentRequestCurrencyCode);
                    txtPaymentRequestCurrencyCode.val("");
                    txtPaymentRequestCurrencyName.val("");
                    txtPaymentRequestExchangeRate.val(0);
                }
            });
    }
    
    function setPaymentRequestTransactionType(){
        var modeUpdate=$("#paymentRequestUpdateMode").val();
        switch(modeUpdate){
            case "true":
                switch($("#paymentRequest\\.transactionType").val()){
                    case "REGULAR":
                        $('input[name="paymentRequestTransactionTypeRad"][value="REGULAR"]').prop('checked',true);
                        $('#paymentRequestTransactionTypeRadDEPOSIT').attr('disabled', true);
                        break;
                    case "DEPOSIT":
                        $('input[name="paymentRequestTransactionTypeRad"][value="DEPOSIT"]').prop('checked',true);
                        $('#paymentRequestTransactionTypeRadREGULAR').attr('disabled', true);
                        break;
                } 
            break;
        }
    }
    
    function paymentRequestFormatNumeric2(){        
        var totalTransactionAmountFormat =parseFloat(txtPaymentRequestTotalTransactionAmountForeign.val());
        txtPaymentRequestTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));
    }
    
    function paymentRequestFormatDate(){
        var transactionDate=formatDate(dtpPaymentRequestTransactionDate.val(),false);
        var transactionDateTimePart=" "+$("#paymentRequestTransactionDate").val().split(' ')[1];
        
        var scheduleDate=formatDate(dtpPaymentRequestScheduleDate.val(),false);
        var scheduleDateTimePart=" "+$("#paymentRequestScheduleDate").val().split(' ')[1];
        
        var createdDate=formatDate(dtpPaymentRequestCreatedDate.val(),true);
                
        dtpPaymentRequestTransactionDate.val(transactionDate);
        $("#paymentRequestTemp\\.transactionDateTemp").val(transactionDate + transactionDateTimePart);
                
        dtpPaymentRequestScheduleDate.val(scheduleDate);
        $("#paymentRequestTemp\\.scheduleDateTemp").val(scheduleDate + scheduleDateTimePart);
        
        dtpPaymentRequestCreatedDate.val(createdDate);
        $("#paymentRequestTemp\\.createdDateTemp").val(createdDate);
                
    }

    function paymentRequestFormatNumeric(){
        
        var totalTransactionAmountFormat =parseFloat(txtPaymentRequestTotalTransactionAmountForeign.val()) ;
        txtPaymentRequestTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));

        var totalBalanceForeign=parseFloat(txtPaymentRequestTotalBalanceForeign.val());
        txtPaymentRequestTotalBalanceForeign.val(formatNumber(totalBalanceForeign,2));

        var totalDebitForeign=parseFloat(txtPaymentRequestTotalDebitForeign.val());
        txtPaymentRequestTotalDebitForeign.val(formatNumber(totalDebitForeign,2));

        var totalCreditForeign=parseFloat(txtPaymentRequestTotalCreditForeign.val());
        txtPaymentRequestTotalCreditForeign.val(formatNumber(totalCreditForeign,2));
    }

    function paymentRequestUnFormatNumeric(){

        var totalTransactionAmountFormat = txtPaymentRequestTotalTransactionAmountForeign.val().replace(/,/g, "");
        txtPaymentRequestTotalTransactionAmountForeign.val(totalTransactionAmountFormat);

        var totalBalanceForeign=txtPaymentRequestTotalBalanceForeign.val().replace(/,/g, "");
        txtPaymentRequestTotalBalanceForeign.val(totalBalanceForeign);

        var totalDebitForeign=txtPaymentRequestTotalDebitForeign.val().replace(/,/g, "");
        txtPaymentRequestTotalDebitForeign.val(totalDebitForeign);

        var totalCreditForeign=txtPaymentRequestTotalCreditForeign.val().replace(/,/g, "");
        txtPaymentRequestTotalCreditForeign.val(totalCreditForeign);
    }
    
    function paymentRequestFormatAmount(){
        var totalTransactionAmount=parseFloat(txtPaymentRequestTotalTransactionAmountForeign.val());
        txtPaymentRequestTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmount,2));
    }
       
    function paymentRequestCalculateBalance(){
        var amountForeign=0;
        var ids = jQuery("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs');
           
        for(var i=0;i < ids.length;i++) {
            var data = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getRowData',ids[i]);
            amountForeign +=parseFloat(data.paymentRequestDetailDocumentAmountForeignTemp);
        }        
        var sumAmountForeign=0- amountForeign;
        var sumAmountForeignLetter;
        if(sumAmountForeign < 0){
           sumAmountForeignLetter="-" + formatNumber(Math.abs(sumAmountForeign),4);
        }else{
            sumAmountForeignLetter=formatNumber(sumAmountForeign,4); 
        }
                      
        txtPaymentRequestTotalBalanceForeign.val(sumAmountForeignLetter);
        
    }

    function paymentRequestDetailClearInputanGrid(selectedRowId){
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentBranchCode", " ");
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentDocumentType", " ");
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentDocumentNo", " ");
//        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentExchangeRate", "0.00");
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentAmountForeign", "0.00");
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentAmountIDR", "0.00");
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentBalanceForeign", "0.00");
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentBalanceIDR", "0.00");
        $("#"+ selectedRowId + "_paymentRequestDetailDocumentAmountForeignInput").val("0.0000");
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentAmountForeignTemp", "0.0000");
        $("#"+ selectedRowId + "_paymentRequestDetailDocumentAmountIDRInput").val("0.0000");
    }
    
    function paymentRequestDetailResetGridByTransactionStatus(){
        var selectedRowId = $("#paymentRequestDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        var transactionStatus = $("#"+ selectedRowId + "_paymentRequestDetailDocumentTransactionStatus").val();
        var documentNo=data.paymentRequestDetailDocumentDocumentNo;
        
        switch(transactionStatus){
            case "---Select---":
                paymentRequestDetailClearInputanGrid(selectedRowId);
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentCurrencyCode", " ");
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentExchangeRate", "0");
                break;
            case "Transaction":
                if(documentNo===" "){
                    paymentRequestDetailClearInputanGrid(selectedRowId);
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentCurrencyCode", " ");
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentExchangeRate", "0");
                }
                break;
            case "Other":
                paymentRequestDetailClearInputanGrid(selectedRowId);
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentCurrencyCode", txtPaymentRequestCurrencyCode.val());
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentExchangeRate", txtPaymentRequestExchangeRate.val());
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "paymentRequestDetailDocumentBranchCode", " ");
                break;
        }
       
    }  
    
    $("#btnSearchDocFinancePaymentRequest").click(function(){
//        if(paymentRequestDetail_lastSel !== -1) {
//            $('#paymentRequestDetailDocumentInput_grid').jqGrid("saveRow",paymentRequestDetail_lastSel); 
//        }
//        var ids = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs');
//        alert(ids.length);
        window.open("./pages/search/search-finance-request.jsp?iddoc=paymentRequestDetailDocument&rowLast="+paymentRequestDetaillastRowId+"&type=grid&idfin=&firstDate="+$("#paymentRequestTransactionDateFirstSession").val()+"&lastDate="+$("#paymentRequestTransactionDateLastSession").val()+"&idCurrencyCode="+txtPaymentRequestCurrencyCode.val(),"Search", "scrollbars=1,width=900, height=600");
    });
    
    function paymentRequestDetailDocumentInputGrid_SearchChartOfAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=paymentRequestDetailDocument&type=grid&pyqStat=TRUE","Search", "scrollbars=1, width=600, height=500");
    }
    function paymentRequestDetailInputGrid_SearchDepartment_OnClick(){
        window.open("./pages/search/search-department.jsp?iddoc=paymentRequestDetailDocument&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function onChangePaymentRequestDetailDepartment(){
        var selectedRowID = $("#paymentRequestDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");
            var dsCode = $("#" + selectedRowID + "_paymentRequestDetailDocumentDepartmentCode").val();
            var url = "master/department-get";
            var params = "department.code=" + dsCode;
                params+= "&department.activeStatus=TRUE";
            
            if(dsCode===""){
                $("#" + selectedRowID + "_paymentRequestDetailDocumentDepartmentCode").val("");
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"paymentRequestDetailDocumentDepartmentName"," ");
                return;
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.departmentTemp){
                    $("#" + selectedRowID + "_paymentRequestDetailDocumentDepartmentCode").val(data.departmentTemp.code);
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"paymentRequestDetailDocumentDepartmentName",data.departmentTemp.name);
                }
                else{
                    alertMessage("Department Not Found!",$("#" + selectedRowID + "_paymentRequestDetailDocumentDepartmentCode"));
                    $("#" + selectedRowID + "_paymentRequestDetailDocumentDepartmentCode").val("");
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"paymentRequestDetailDocumentDepartmentName"," ");
                }
            });
    }
    
    function paymentRequestDetailDocumentInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getGridParam','selrow');
        
//        if (selectDetailRowId === null) {
//            alertMessage("Please Select Row!");
//            return;
//        }
        
        $("#paymentRequestDetailDocumentInput_grid").jqGrid('delRowData',selectDetailRowId);
    }

    function paymentRequestLoadDataDetail() {
        
        var url = "finance/payment-request-detail-data-update";
        var params = "paymentRequest.code=" + txtPaymentRequestCode.val();
            
        $.getJSON(url, params, function(data) {
            paymentRequestDetaillastRowId = 0;
            
            for (var i=0; i<data.listPaymentRequestDetailTemp.length; i++) {
                
                var transactionType=data.listPaymentRequestDetailTemp[i].transactionStatus;
                var currencyCodeDocument="";
                var exchangeRateDocument="0.00";
                
                switch(transactionType){
                    case "Transaction":
                        currencyCodeDocument=data.listPaymentRequestDetailTemp[i].currencyCode;
                        exchangeRateDocument=data.listPaymentRequestDetailTemp[i].exchangeRate;
                        break;
                    case "Other":
                        currencyCodeDocument=txtPaymentRequestCurrencyCode.val();
                        exchangeRateDocument=data.listPaymentRequestDetailTemp[i].exchangeRate;
                        break;
                }
                
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("addRowData", paymentRequestDetaillastRowId, data.listPaymentRequestDetailTemp[i]);
                $("#paymentRequestDetailDocumentInput_grid").jqGrid('setRowData',paymentRequestDetaillastRowId,{
                    paymentRequestDetailDocumentDocumentNo         : data.listPaymentRequestDetailTemp[i].documentNo,
                    paymentRequestDetailDocumentBranchCode         : data.listPaymentRequestDetailTemp[i].documentBranchCode,
                    paymentRequestDetailDocumentDocumentType       : data.listPaymentRequestDetailTemp[i].documentType,
                    paymentRequestDetailDocumentCurrencyCode       : currencyCodeDocument,
                    paymentRequestDetailDocumentExchangeRate       : exchangeRateDocument,
                    paymentRequestDetailDocumentAmountForeign      : data.listPaymentRequestDetailTemp[i].documentAmount,
                    paymentRequestDetailDocumentAmountIDR          : data.listPaymentRequestDetailTemp[i].documentAmountIDR,
                    paymentRequestDetailDocumentBalanceForeign     : data.listPaymentRequestDetailTemp[i].documentBalanceAmount,
                    paymentRequestDetailDocumentBalanceIDR         : data.listPaymentRequestDetailTemp[i].documentBalanceAmountIDR,
                    paymentRequestDetailDocumentTransactionStatus  : data.listPaymentRequestDetailTemp[i].transactionStatus,
                    paymentRequestDetailDocumentDebitForeign       : data.listPaymentRequestDetailTemp[i].debit,
                    paymentRequestDetailDocumentDueDate            : data.listPaymentRequestDetailTemp[i].dueDate,
                    paymentRequestDetailDocumentCreditForeign      : data.listPaymentRequestDetailTemp[i].credit,
                    paymentRequestDetailDocumentChartOfAccountCode : data.listPaymentRequestDetailTemp[i].chartOfAccountCode,
                    paymentRequestDetailDocumentChartOfAccountName : data.listPaymentRequestDetailTemp[i].chartOfAccountName,
                    paymentRequestDetailDocumentDepartmentCode     : data.listPaymentRequestDetailTemp[i].departmentCode,
                    paymentRequestDetailDocumentDepartmentName     : data.listPaymentRequestDetailTemp[i].departmentName,
                    paymentRequestDetailDocumentRemark             : data.listPaymentRequestDetailTemp[i].remark
                });
            paymentRequestDetaillastRowId++;
            }
        });
    }
    
    function addRowDataMultiSelected(lastRowId,defRow){ 

        var ids = $("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        var currencyCodeDocument = txtPaymentRequestCurrencyCode.val();
        var exchangeRateDocument = txtPaymentRequestExchangeRate.val();
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
        //  alert(comp);
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
            }
        }
        paymentRequestDetaillastRowId = lastRowId;
//        alert(lastRowId);
        $("#paymentRequestDetailDocumentInput_grid").jqGrid("addRowData",lastRowId,defRow);
        $("#paymentRequestDetailDocumentInput_grid").jqGrid('setRowData',lastRowId,{
                paymentRequestDetailDocumentDocumentNo         : defRow.paymentRequestDetailDocumentDocumentNo,
                paymentRequestDetailDocumentBranchCode         : defRow.paymentRequestDetailDocumentBranchCode,
                paymentRequestDetailDocumentDocumentType       : defRow.paymentRequestDetailDocumentDocumentType,
                paymentRequestDetailDocumentDocumentDate       : defRow.paymentRequestDetailDocumentDocumentDate,
                paymentRequestDetailDocumentCurrencyCode       : defRow.paymentRequestDetailDocumentCurrencyCode,
                paymentRequestDetailDocumentExchangeRate       : defRow.paymentRequestDetailDocumentExchangeRate,
                paymentRequestDetailDocumentAmountForeign      : defRow.paymentRequestDetailDocumentAmountForeign,
                paymentRequestDetailDocumentAmountIDR          : defRow.paymentRequestDetailDocumentAmountIDR,
                paymentRequestDetailDocumentBalanceForeign     : defRow.paymentRequestDetailDocumentBalanceForeign,
                paymentRequestDetailDocumentBalanceIDR         : defRow.paymentRequestDetailDocumentBalanceIDR,
                paymentRequestDetailDocumentDebitForeign       : defRow.paymentRequestDetailDocumentDebitForeign,
                paymentRequestDetailDocumentCreditForeign      : defRow.paymentRequestDetailDocumentCreditForeign,
                paymentRequestDetailDocumentDueDate            : defRow.paymentRequestDetailDocumentDueDate,
                paymentRequestDetailDocumentChartOfAccountCode : defRow.paymentRequestDetailDocumentChartOfAccountCode,
                paymentRequestDetailDocumentChartOfAccountName : defRow.paymentRequestDetailDocumentChartOfAccountName,
                paymentRequestDetailDocumentRemark             : defRow.paymentRequestDetailDocumentRemark
        });

        setHeightGridDetail();
    }
    
 function setHeightGridDetail(){
        var ids = jQuery("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#paymentRequestDetailDocumentInput_grid"+" tr").eq(1).height();
            $("#paymentRequestDetailDocumentInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#paymentRequestDetailDocumentInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    
    function paymentRequestDetailOnChangeChartOfAccount(){
        
        var selectedRowID = $("#paymentRequestDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");
            var coaCode = $("#" + selectedRowID + "_paymentRequestDetailDocumentChartOfAccountCode").val();
            var url = "master/chart-of-account-get";
            var params = "chartOfAccount.code=" + coaCode;
                params+= "&searchChartOfAccountStatus=TRUE";
            
            if(coaCode===""){
                $("#" + selectedRowID + "_paymentRequestDetailDocumentChartOfAccountCode").val("");
                $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"paymentRequestDetailDocumentChartOfAccountName"," ");
                return;
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.chartOfAccountTemp){
                    $("#" + selectedRowID + "_paymentRequestDetailDocumentChartOfAccountCode").val(data.chartOfAccountTemp.code);
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"paymentRequestDetailDocumentChartOfAccountName",data.chartOfAccountTemp.name);
                }
                else{
                    alertMessage("Budget Type Not Found!",$("#" + selectedRowID + "_paymentRequestDetailDocumentChartOfAccountCode"));
                    $("#" + selectedRowID + "_paymentRequestDetailDocumentChartOfAccountCode").val("");
                    $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"paymentRequestDetailDocumentChartOfAccountName"," ");
                }
            });
    }
            
    function paymentRequestOnChangeTransactionType(){
        var transactionType=$("#paymentRequest\\.transactionType").val();
        switch(transactionType){
            case "REGULAR":
                $('#paymentRequestTransactionTypeRadREGULAR').prop('checked',true);
                $('#paymentRequest\\.vendorDepositType\\.code').attr('readonly',true);
                $('#paymentRequest_btnVendorDepositType').hide();
                break;
            case "DEPOSIT":
                $('#paymentRequestTransactionTypeRadDEPOSIT').prop('checked',true);
                $('#paymentRequest\\.vendorDepositType\\.code').attr('readonly',false);
                $('#paymentRequest_btnVendorDepositType').show();
                break;
        }
    }
    
    function changePaymentRequestDocumentType(type) {
        
       var ids = jQuery("#paymentRequestDetailDocumentInput_grid").jqGrid('getDataIDs'); 
    //   alert(ids);
        for(var i=0; i< ids.length;i++) {
   
            $("#paymentRequestDetailDocumentInput_grid").jqGrid("setCell", ids[i], "paymentRequestDetailDocumentTransactionStatus", type);

        } 
    }
    
    function paymentRequestLoadExchangeRate(){ 
        
        if (txtPaymentRequestCashPaymentCurrencyCode.val()==="IDR"){
            txtPaymentRequestCashPaymentExchangeRate.val("1.00");
            txtPaymentRequestCashPaymentExchangeRate.attr("readonly",true);
        }else{
            txtPaymentRequestCashPaymentExchangeRate.attr("readonly",false);
        }
    }
    
    function unHandlers_input_payment_request(){
        unHandlersInput(txtPaymentRequestCashPaymentCashAccountCode);
    }

    function handlers_payment_request(){
        if(txtPaymentRequestCashPaymentCashAccountCode.val()===""){
            handlersInput(txtPaymentRequestCashPaymentCashAccountCode);
        }else{
            unHandlersInput(txtPaymentRequestCashPaymentCashAccountCode);
        }

    }

</script>

<s:url id="remoteurlPaymentRequestDetailDocumentInput" action="" />
<b>PAYMENT REQUEST</b>
<hr>
<br class="spacer" />
<div id="paymentRequestInput" class="content ui-widget">
<s:form id="frmPaymentRequestInput">
    <table cellpadding="2" cellspacing="2" id="PaymentRequestHeaderInput" width="100%">
        <tr>
            <td align="right" style="width:130px"><B>Payment Request No *</B></td>
            <td>
                <s:textfield id="paymentRequest.code" name="paymentRequest.code" key="paymentRequest.code" readonly="true" size="22"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Transaction Date *</B></td>
            <td>
                <sj:datepicker id="paymentRequest.transactionDate" name="paymentRequest.transactionDate" title="*" required="true" cssClass="required" size="22" showOn="focus" displayFormat="dd/mm/yy" onchange="paymentRequestTransactionDateOnChange()" changeYear="true" changeMonth="true" ></sj:datepicker>
                <sj:datepicker id="paymentRequestTransactionDate" name="paymentRequestTransactionDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" cssStyle="display:none" changeYear="true" changeMonth="true" ></sj:datepicker>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Branch *</B></td>
            <td colspan="2">
            <script type = "text/javascript">

                txtPaymentRequestBranchCode.change(function(ev) {

                    if(txtPaymentRequestBranchCode.val()===""){
                        txtPaymentRequestBranchName.val("");
                        return;
                    }
                    var url = "master/branch-get";
                    var params = "branch.code=" + txtPaymentRequestBranchCode.val();
                        params += "&branch.activeStatus=TRUE";

                    $.post(url, params, function(result) {
                        var data = (result);
                        if (data.branchTemp){
                            txtPaymentRequestBranchCode.val(data.branchTemp.code);
                            txtPaymentRequestBranchName.val(data.branchTemp.name);
                        }
                        else{
                            alertMessage("Branch Not Found!",txtPaymentRequestBranchCode);
                            txtPaymentRequestBranchCode.val("");
                            txtPaymentRequestBranchName.val("");
                        }
                    });
                });
                if($("#paymentRequestUpdateMode").val()==="true"){
                    txtPaymentRequestBranchCode.attr("readonly",true);
                    $("#paymentRequest_btnBranch").hide();
                    $("#ui-icon-search-branch-payment-request").hide();
                }else{
                    txtPaymentRequestBranchCode.attr("readonly",false);
                    $("#paymentRequest_btnBranch").show();
                    $("#ui-icon-search-branch-payment-request").show();
                }
            </script>
            <div class="searchbox ui-widget-header" hidden="true">
                <s:textfield id="paymentRequest.branch.code" name="paymentRequest.branch.code" size="22" title="*" required="true" cssClass="required"></s:textfield>
                <sj:a id="paymentRequest_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-payment-request" class="ui-icon ui-icon-search"/></sj:a>
            </div>
                <s:textfield id="paymentRequest.branch.name" name="paymentRequest.branch.name" size="40" readonly="true"></s:textfield>
        </tr>  
        <tr>
            <td align="right"><B>Payment To *</B></td>
            <td>
                <s:textfield id="paymentRequest.paymentTo" name="paymentRequest.paymentTo" required="true" cssClass="required" title="*"  size="27"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Schedule Date *</B></td>
            <td>
                <sj:datepicker id="paymentRequest.scheduleDate" name="paymentRequest.scheduleDate" title="*" required="true" cssClass="required" size="22" showOn="focus" displayFormat="dd/mm/yy" onchange="paymentRequestScheduleDateOnChange()" changeYear="true" changeMonth="true" ></sj:datepicker>
                <sj:datepicker id="paymentRequestScheduleDate" name="paymentRequestScheduleDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" cssStyle="display:none" changeYear="true" changeMonth="true" ></sj:datepicker>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Type *</B></td>
            <td>
                <s:textfield id="paymentRequest.transactionType" name="paymentRequest.transactionType" cssStyle="display:none"></s:textfield>
                <s:radio id="paymentRequestTransactionTypeRad" name="paymentRequestTransactionTypeRad" label="type" list="{'REGULAR','DEPOSIT'}" />
            </td> 
        </tr>
        <tr>
            <td align="right"><B>Deposit Type *</B></td>
            <td colspan="3">
                <script type = "text/javascript">
                    $('#paymentRequest_btnVendorDepositType').click(function(ev) {
                        if(txtPaymentRequestBranchCode.val === ""){
                            alertMessage("Branch Can't Be Empty !");
                            return;
                        }
                        window.open("./pages/search/search-vendor-deposit-type.jsp?iddoc=paymentRequest&idsubdoc=vendorDepositType&branchCode="+txtPaymentRequestBranchCode.val(),"Search", "scrollbars=1, width=600, height=500");
                    });

                    txtPaymentRequestVendorDepositTypeCode.change(function(ev) {

                        if(txtPaymentRequestBranchCode.val === ""){
                            alertMessage("Branch Can't Be Empty !");
                            return;
                        }

                        if(txtPaymentRequestVendorDepositTypeCode.val()===""){
                            txtPaymentRequestVendorDepositTypeName.val("");
                            txtPaymentRequestVendorDepositTypeChartOfAccountCode.val("");
                            txtPaymentRequestVendorDepositTypeChartOfAccountName.val("");
                            return;
                        }

                        var url = "master/vendor-deposit-type-get";
                        var params = "vendorDepositType.code=" + txtPaymentRequestVendorDepositTypeCode.val();
                            params+= "&vendorDepositType.branchCode="+txtPaymentRequestBranchCode.val();

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.vendorDepositTypeTemp){
                                txtPaymentRequestVendorDepositTypeCode.val(data.vendorDepositTypeTemp.code);
                                txtPaymentRequestVendorDepositTypeName.val(data.vendorDepositTypeTemp.name);
                                txtPaymentRequestVendorDepositTypeChartOfAccountCode.val(data.vendorDepositTypeTemp.chartOfAccountCode);
                                txtPaymentRequestVendorDepositTypeChartOfAccountName.val(data.vendorDepositTypeTemp.chartOfAccountName);
                            }
                            else{
                                alertMessage("Deposit Type Not Found!",txtPaymentRequestVendorDepositTypeCode);
                                txtPaymentRequestVendorDepositTypeCode.val("");
                                txtPaymentRequestVendorDepositTypeName.val("");
                                txtPaymentRequestVendorDepositTypeChartOfAccountCode.val("");
                                txtPaymentRequestVendorDepositTypeChartOfAccountName.val("");
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                <s:textfield id="paymentRequest.vendorDepositType.code" name="paymentRequest.vendorDepositType.code" title=" " size="22"></s:textfield>
                    <sj:a id="paymentRequest_btnVendorDepositType" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-vendor-deposit-type-bank-payment"/></sj:a>
                </div>
                    <s:textfield id="paymentRequest.vendorDepositType.chartOfAccountCode" name="paymentRequest.vendorDepositType.chartOfAccountCode" size="40" readonly="true"></s:textfield>
                    <s:textfield id="paymentRequest.vendorDepositType.chartOfAccountName" name="paymentRequest.vendorDepositType.chartOfAccountName" size="40" readonly="true" cssStyle="display:none"></s:textfield>
                    <s:textfield id="paymentRequest.vendorDepositType.name" name="paymentRequest.vendorDepositType.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Currency *</B></td>
            <td colspan="2">
                <script type = "text/javascript">
                    txtPaymentRequestCurrencyCode.change(function(ev) {

                        if(txtPaymentRequestCurrencyCode.val()===""){
                            txtPaymentRequestCurrencyName.val("");
                            return;
                        }

                        var url = "master/currency-get";
                        var params = "currency.code=" + txtPaymentRequestCurrencyCode.val();
                            params+= "&currency.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.currencyTemp){
                                txtPaymentRequestCurrencyCode.val(data.currencyTemp.code);
                                txtPaymentRequestCurrencyName.val(data.currencyTemp.name);
                                
                                
                                url = "master/exchange-rate-by-date-query";
                                params = "currCode=" + txtPaymentRequestCurrencyCode.val();
                                params+= "&exchangeDate="+formatDate(dtpPaymentRequestTransactionDate.val());
                                
                                $.post(url, params, function(result) {
                                    var datas = (result);
                                    if (datas.exchangeRateTemp){
                                        txtPaymentRequestExchangeRate.val(parseFloat(datas.exchangeRateTemp.exchangeRate));
                                    }else{
                                        alertMessage("Excangerate Not Set!",txtPaymentRequestCurrencyCode);
                                    }
                                });
                            }
                            else{
                                alertMessage("Currency Not Found!",txtPaymentRequestCurrencyCode);
                                txtPaymentRequestCurrencyCode.val("");
                                txtPaymentRequestCurrencyName.val("");
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                    <s:textfield id="paymentRequest.currency.code" name="paymentRequest.currency.code" required="true" cssClass="required" title="*" size="22"></s:textfield>
                    <sj:a id="paymentRequest_btnCurrency" cssClass="paymentRequest_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-currency-payment-request"/></sj:a>
                </div>
                    <s:textfield id="paymentRequest.currency.name" name="paymentRequest.currency.name" size="40" readonly="true"></s:textfield>
                    <s:textfield id="paymentRequest.exchangeRate" name="paymentRequest.exchangeRate" size="40" readonly="true" cssStyle="display:nones"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Amount *</B></td>
            <td>
                <s:textfield id="paymentRequest.totalTransactionAmount" name="paymentRequest.totalTransactionAmount" size="22" style="text-align: right"></s:textfield>(Credit)
            </td>
        </tr>
        <tr>
            <td align="right">Ref No</td>
            <td colspan="3"><s:textfield id="paymentRequest.refNo" name="paymentRequest.refNo" size="27"></s:textfield></td>
        </tr>
        <tr>
            <td align="right" valign="top">Remark</td>
            <td colspan="3"><s:textarea id="paymentRequest.remark" name="paymentRequest.remark"  cols="72" rows="2" height="20"></s:textarea></td>
        </tr>
        <tr hidden="true">
            <td>
                <s:textfield id="paymentRequest.approvalBy" name="paymentRequest.approvalBy" size="27"></s:textfield>
                <s:textfield id="paymentRequest.approvalStatus" name="paymentRequest.approvalStatus" size="27"></s:textfield>
                <sj:datepicker id="paymentRequest.approvalDate" name="paymentRequest.approvalDate" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="mm/dd/yy" timepickerFormat="hh:mm:ss" cssStyle="display:none" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="paymentRequest.approvalReason.code" name="paymentRequest.approvalReason.code" size="27"></s:textfield>
                <s:textarea id="paymentRequest.approvalRemark" name="paymentRequest.approvalRemark"  cols="72" rows="2" height="20"></s:textarea>
                <s:textfield id="paymentRequest.paidStatus" name="paymentRequest.paidStatus" size="27"></s:textfield>
                <s:textfield id="paymentRequest.createdBy" name="paymentRequest.createdBy" key="paymentRequest.createdBy" readonly="true" size="22"></s:textfield>
                <sj:datepicker id="paymentRequest.createdDate" name="paymentRequest.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="paymentRequestUpdateMode" name="paymentRequestUpdateMode" size="20"></s:textfield>
                <s:textfield id="paymentRequestTemp.transactionDateTemp" name="paymentRequestTemp.transactionDateTemp" size="20"></s:textfield>
                <s:textfield id="paymentRequestTemp.scheduleDateTemp" name="paymentRequestTemp.scheduleDateTemp" size="20"></s:textfield>
                <s:textfield id="paymentRequestTemp.createdDateTemp" name="paymentRequestTemp.createdDateTemp" size="20"></s:textfield>
                <sj:datepicker id="paymentRequestTransactionDateFirstSession" name="paymentRequestTransactionDateFirstSession" size="20" showOn="focus" disabled="true" changeYear="true" changeMonth="true" ></sj:datepicker>
                <sj:datepicker id="paymentRequestTransactionDateLastSession" name="paymentRequestTransactionDateLastSession" size="20" showOn="focus" disabled="true" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="paymentRequestDetailChartOfAccountPurchaseDownPaymentCode" name="paymentRequestDetailChartOfAccountPurchaseDownPaymentCode" size="20"></s:textfield>
                <s:textfield id="paymentRequestDetailChartOfAccountPurchaseDownPaymentName" name="paymentRequestDetailChartOfAccountPurchaseDownPaymentName" size="20"></s:textfield>
            </td>
        </tr>
    </table>
<%--</s:form>--%>

    <table>
        <tr>
            <td align="right">
                <sj:a href="#" id="btnConfirmPaymentRequest" button="true">Confirm</sj:a>
                <sj:a href="#" id="btnUnConfirmPaymentRequest" button="true">UnConfirm</sj:a>
            </td>
        </tr>
    </table>
    
    <div id="paymentRequestInputCashPayment">
        <br class="spacer" />
        <br class="spacer" />
        <%--<s:form id="frmPaymentRequestInput">--%>
            <table>
                <tr>
                    <td align="right"><B>Cash Account *</B></td>
                    <td colspan="2">
                    <script type = "text/javascript">
                        $('#paymentRequestCashPayment_btnCashAccount').click(function(ev) {
                            window.open("./pages/search/search-cash-account.jsp?iddoc=paymentRequest&idsubdoc=cashAccount","Search", "scrollbars=1,width=600, height=500");
                        });
                        txtPaymentRequestCashPaymentCashAccountCode.change(function(ev) {

                            if(txtPaymentRequestCashPaymentCashAccountCode.val()===""){
                                txtPaymentRequestCashPaymentCashAccountName.val("");
                                return;
                            }
                            var url = "master/cash-account-get";
                            var params = "cashAccount.code=" + txtPaymentRequestCashPaymentCashAccountCode.val();
                                params += "&cashAccount.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cashAccountTemp){
                                    txtPaymentRequestCashPaymentCashAccountCode.val(data.cashAccountTemp.code);
                                    txtPaymentRequestCashPaymentCashAccountName.val(data.cashAccountTemp.name);
                                }
                                else{
                                    alertMessage("Cash Account Not Found!",txtPaymentRequestCashPaymentCashAccountCode);
                                    txtPaymentRequestCashPaymentCashAccountCode.val("");
                                    txtPaymentRequestCashPaymentCashAccountName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="paymentRequest.cashAccount.code" name="paymentRequest.cashAccount.code" size="22" title="*" ></s:textfield>
                        <sj:a id="paymentRequestCashPayment_btnCashAccount" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-payment-request" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="paymentRequest.cashAccount.name" name="paymentRequest.cashAccount.name" size="40" readonly="true"></s:textfield>
                </tr>
                <tr>
                    <td align="right">Employee </td>
                    <td colspan="2">
                    <script type = "text/javascript">
                        $('#paymentRequestCashPayment_btnEmployee').click(function(ev) {
                            window.open("./pages/search/search-employee.jsp?iddoc=paymentRequest&idsubdoc=employee","Search", "scrollbars=1,width=600, height=500");
                        });
                        txtPaymentRequestCashPaymentEmployeeCode.change(function(ev) {

                            if(txtPaymentRequestCashPaymentEmployeeCode.val()===""){
                                txtPaymentRequestCashPaymentEmployeeName.val("");
                                return;
                            }
                            var url = "master/employee-get";
                            var params = "employee.code=" + txtPaymentRequestCashPaymentEmployeeCode.val();
                                params += "&employee.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.employeeTemp){
                                    txtPaymentRequestCashPaymentEmployeeCode.val(data.employeeTemp.code);
                                    txtPaymentRequestCashPaymentEmployeeName.val(data.employeeTemp.name);
                                }
                                else{
                                    alertMessage("Employee Not Found!",txtPaymentRequestCashPaymentEmployeeCode);
                                    txtPaymentRequestCashPaymentEmployeeCode.val("");
                                    txtPaymentRequestCashPaymentEmployeeName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="paymentRequest.employee.code" name="paymentRequest.employee.code" size="22" title="*" ></s:textfield>
                        <sj:a id="paymentRequestCashPayment_btnEmployee" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-payment-request" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="paymentRequest.employee.name" name="paymentRequest.employee.name" size="40" readonly="true"></s:textfield>
                </tr>
                <tr>
                    <td align="right"><B>Currency *</B></td>
                    <td colspan="2">
                    <script type = "text/javascript">
                        $('#paymentRequestCashPayment_btnCurrencyCode').click(function(ev) {
                            window.open("./pages/search/search-currency.jsp?iddoc=paymentRequest&idsubdoc=currencyCashPayment","Search", "scrollbars=1,width=600, height=500");
                        });
                        txtPaymentRequestCashPaymentCurrencyCode.change(function(ev) {

                            if(txtPaymentRequestCashPaymentCurrencyCode.val()===""){
                                txtPaymentRequestCashPaymentCurrencyName.val("");
                                return;
                            }
                            var url = "master/currency-get";
                            var params = "currency.code=" + txtPaymentRequestCashPaymentCurrencyCode.val();
                                params += "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtPaymentRequestCashPaymentCurrencyCode.val(data.currencyTemp.code);
                                    txtPaymentRequestCashPaymentCurrencyName.val(data.currencyTemp.name);
                                    paymentRequestLoadExchangeRate();
                                }
                                else{
                                    alertMessage("Currency Not Found!",txtPaymentRequestCashPaymentCurrencyCode);
                                    txtPaymentRequestCashPaymentCurrencyCode.val("");
                                    txtPaymentRequestCashPaymentCurrencyName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                    <s:textfield id="paymentRequest.currencyCashPayment.code" name="paymentRequest.currencyCashPayment.code" size="22" title="*" readonly="true"></s:textfield>
                        <%--<sj:a id="paymentRequestCashPayment_btnCurrencyCode" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-payment-request" class="ui-icon ui-icon-search"/></sj:a>--%>
                    </div>
                        <s:textfield id="paymentRequest.currencyCashPayment.name" name="paymentRequest.currencyCashPayment.name" size="40" readonly="true"></s:textfield>
                </tr>
                <tr>
                    <td align="right"><B>Exchange Rate *</B></td>
                    <td><s:textfield id="paymentRequest.cashPaymentExchangeRate" name="paymentRequest.cashPaymentExchangeRate" size="22" style="text-align: right" readonly="true" onkeyup="cashPaymentCalculateTotalTransactionAmountIDR()" value="1.00"></s:textfield><b>IDR</b> &nbsp;<span class="errMsgNumric" id="errmsgExchangeRate"></span></td>
                </tr>
            </table>
        </s:form>
        <br class="spacer" />
        <br class="spacer" />
    </div>
    
    
<table>
    <tr>
        <td align="right">
            <br>
            <sj:a href="#" id="btnSearchDocFinancePaymentRequest" button="true">Search DOC</sj:a>
        </td>
    </tr>
</table>
                    
    <div id="paymentRequestDetailDocumentInputGrid">
        <sjg:grid
            id="paymentRequestDetailDocumentInput_grid"
            dataType="local"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPaymentRequestDetailTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            editinline="true"
            width="$('#tabmnubankpayment').width()"
            editurl="%{remoteurlPaymentRequestDetailDocumentInput}"
            onSelectRowTopics="paymentRequestDetailDocumentInput_grid_onSelect"
        >
            <sjg:gridColumn
                name="paymentRequestDetailDocument" index="paymentRequestDetailDocument" title="" width="10" align="centre"
                editable="true" edittype="text" hidden="true"
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDelete" index="paymentRequestDetailDocumentDelete" title="" width="50" align="centre"
                editable="true"
                edittype="button"
                editoptions="{onClick:'paymentRequestDetailDocumentInputGrid_Delete_OnClick()', value:'delete'}"
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDocumentNo" index="paymentRequestDetailDocumentDocumentNo" 
                key="paymentRequestDetailDocumentDocumentNo" title="Document No" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDocumentDate" index="paymentRequestDetailDocumentDocumentDate" 
                key="paymentRequestDetailDocumentDocumentDate" title="Document Date" formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}" 
                width="130" search="false" sortable="true" align="center" hidden="false"
            />
            <sjg:gridColumn
                name="paymentRequestDetailChartOfAccountSearch" index="paymentRequestDetailChartOfAccountSearch" title="" width="25" align="centre"
                editable="true"
                dataType="html"
                edittype="button"
                editoptions="{onClick:'paymentRequestDetailDocumentInputGrid_SearchChartOfAccount_OnClick()', value:'...'}"
            /> 
            <sjg:gridColumn
                name="paymentRequestDetailDocumentChartOfAccountCode" index="paymentRequestDetailDocumentChartOfAccountCode" 
                title="ChartOfAccount Code" width="120" sortable="true" editable="true" edittype="text"
                editoptions="{onChange:'paymentRequestDetailOnChangeChartOfAccount()'}"
            />     
            <sjg:gridColumn
                name="paymentRequestDetailDocumentChartOfAccountName" index="paymentRequestDetailDocumentChartOfAccountName" 
                title="ChartOfAccount Name" width="150" sortable="true"
            /> 
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDepartmentSearch" index="paymentRequestDetailDocumentDepartmentSearch" title="" width="25" align="centre"
                editable="true"
                dataType="html"
                edittype="button"
                editoptions="{onClick:'paymentRequestDetailInputGrid_SearchDepartment_OnClick()', value:'...'}"
            /> 
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDepartmentCode" index="paymentRequestDetailDocumentDepartmentCode" 
                title="Department Code" width="120" sortable="true" edittype="text" editable="true" 
                editoptions="{onChange:'onChangePaymentRequestDetailDepartment()'}"
            />     
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDepartmentName" index="paymentRequestDetailDocumentDepartmentName" 
                title="Department Name" width="150" sortable="true"
            />  
            <sjg:gridColumn
                name="paymentRequestDetailDocumentBranchCode" index="paymentRequestDetailDocumentBranchCode" key="paymentRequestDetailDocumentBranchCode" title="Branch" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDocumentType" index="paymentRequestDetailDocumentDocumentType" key="paymentRequestDetailDocumentDocumentType" title="Type" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDocumentRefNo" index="paymentRequestDetailDocumentDocumentRefNo" 
                key="paymentRequestDetailDocumentDocumentRefNo" title="Document RefNo" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentCurrencyCode" index = "paymentRequestDetailDocumentCurrencyCode" key = "paymentRequestDetailDocumentCurrencyCode" title = "Currency" width = "60" 
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentExchangeRate" index = "paymentRequestDetailDocumentExchangeRate" key = "paymentRequestDetailDocumentExchangeRate" 
                title = "Rate" width = "80" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDueDate" index="paymentRequestDetailDocumentDueDate" key="paymentRequestDetailDocumentDueDate" 
                formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}" 
                title="Due Date" width="130" search="false" sortable="true" align="center"
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentAmountForeign" index = "paymentRequestDetailDocumentAmountForeign" key = "paymentRequestDetailDocumentAmountForeign" 
                title = "Doc Amount (Foreign)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentAmountIDR" index = "paymentRequestDetailDocumentAmountIDR" key = "paymentRequestDetailDocumentAmountIDR" 
                title = "Doc Amount (IDR)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentBalanceForeign" index = "paymentRequestDetailDocumentBalanceForeign" key = "paymentRequestDetailDocumentBalanceForeign" 
                title = "Doc Balance (Foreign)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentBalanceIDR" index = "paymentRequestDetailDocumentBalanceIDR" key = "paymentRequestDetailDocumentBalanceIDR" 
                title = "Doc Balance (IDR)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentTransactionStatus" index = "paymentRequestDetailDocumentTransactionStatus" key = "paymentRequestDetailDocumentTransactionStatus" title = "Transaction Status" width = "120" 
            />
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentTransactionStatusTemp" 
                index = "paymentRequestDetailDocumentTransactionStatusTemp" 
                key = "paymentRequestDetailDocumentTransactionStatusTemp" title = "" width = "100" hidden="true"
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentDebitForeign" index="paymentRequestDetailDocumentDebitForeign" key="paymentRequestDetailDocumentDebitForeign" title="Debit" 
                width="150" align="right" editable="true" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="paymentRequestDetailDocumentCreditForeign" index="paymentRequestDetailDocumentCreditForeign" key="paymentRequestDetailDocumentCreditForeign" title="Credit" 
                width="150" align="right" editable="true" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            
            <sjg:gridColumn
                name = "paymentRequestDetailDocumentRemark" index="paymentRequestDetailDocumentRemark" key="paymentRequestDetailDocumentRemark" title="Remark" width="225"  editable="true" edittype="text"
            />
        </sjg:grid >                
    </div>
    
    <div id="paymentRequestAddRowValidation">
        <table width="13%">
            <tr>
                <td width="60px" align="right">
                    <s:textfield id="paymentRequestAddRow" name="paymentRequestAddRow" value="1" style="width: 60%; text-align: right;"></s:textfield>
                </td>
                <td>
                    <sj:a href="#" id="btnPaymentRequestAddDetail" button="true" style="width: 60px">Add</sj:a> 
                </td>
            </tr>
        </table>
    </div>  
                
    <table width="100%">
        <tr>
            <td width="70%">
                <sj:a href="#" id="btnPaymentRequestSave" button="true" style="width: 60px">Save</sj:a>
                <sj:a href="#" id="btnPaymentRequestCancel" button="true" style="width: 60px">Cancel</sj:a>
            </td>
            <td align="middle">
                <sj:a href="#" id="btnPaymentRequestCalculate" button="true" style="width: 80px">Calculate</sj:a>
            </td>
        </tr>
        <tr>
            <td/>
            <td>
                <table width="100%">
                    <tr>
                        <td width="22%"/>
                        <td height="10px" align="left"><label>Foreign</label></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Total(Debit)</td>
                        <td><s:textfield id="paymentRequestTotalDebitForeign" name="paymentRequestTotalDebitForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Total(Credit)</td>
                        <td><s:textfield id="paymentRequestTotalCreditForeign" name="paymentRequestTotalCreditForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Balance</td>
                        <td><s:textfield id="paymentRequestTotalBalanceForeign" name="paymentRequestTotalBalanceForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br class="spacer" />
</div>
    
    
   
    
   