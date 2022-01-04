
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #bankPaymentDetailDocumentInput_grid_pager_center{
        display: none;
    }
/*    #errmsgExchangeRate,#errmsgTotalTransactionAmount{
        color: red;
    }*/
        
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var bankPaymentDetaillastRowId=0,bankPaymentSubDetaillastRowId=0,bankPaymentDetail_lastSel = -1,bankPaymentSubDetail_lastSel=-1,selectedRowId=0;
    var bankPaymentFlagConfirmed=false;
    var 
        txtBankPaymentCode = $("#bankPayment\\.code"),
        dtpBankPaymentTransactionDate = $("#bankPayment\\.transactionDate"),
        txtBankPaymentBranchCode = $("#bankPayment\\.branch\\.code"),
        txtBankPaymentBranchName = $("#bankPayment\\.branch\\.name"),
        txtBankPaymentBankAccountCode=$("#bankPayment\\.bankAccount\\.code"),
        txtBankPaymentBankAccountName=$("#bankPayment\\.bankAccount\\.name"),
        txtBankPaymentBBKVoucherNo=$("#bankPayment\\.bankAccount\\.bbkVoucherNo"),
        txtBankPaymentBankAccountChartOfAccountCode=$("#bankPayment\\.bankAccount\\.chartOfAccount\\.code"),
        txtBankPaymentBankAccountChartOfAccountName=$("#bankPayment\\.bankAccount\\.chartOfAccount\\.name"),
        txtBankPaymentTransactionType = $("#bankPayment\\.transactionType"),
        txtBankPaymentPaymentTo = $("#bankPayment\\.paymentTo"),
        txtBankPaymentCurrencyCode = $("#bankPayment\\.currency\\.code"),
        txtBankPaymentCurrencyName = $("#bankPayment\\.currency\\.name"),
        txtBankPaymentExchangeRate = $("#bankPayment\\.exchangeRate"),
        txtBankPaymentTotalTransactionAmountForeign = $("#bankPayment\\.totalTransactionAmount"),
        txtBankPaymentTotalTransactionAmountIDR = $("#bankPayment\\.totalTransactionAmountIDR"),
        txtBankPaymentPaymentType = $("#bankPayment\\.paymentType"),
        txtBankPaymentGiroPaymentNo = $("#bankPayment\\.giroPayment\\.code"),
        txtBankPaymentGiroPaymentBankCode = $("#bankPayment\\.giroPayment\\.bank\\.code"),
        txtBankPaymentGiroPaymentBankName = $("#bankPayment\\.giroPayment\\.bank\\.name"),
        txtBankPaymentGiroPaymentDueDate = $("#bankPayment\\.giroPayment\\.dueDate"),
        txtBankPaymentTransferPaymentNo = $("#bankPayment\\.transferPaymentNo"),
        txtBankPaymentTransferBankName = $("#bankPayment\\.transferBankName"),        
        dtpBankPaymentTransferPaymentDate = $("#bankPayment\\.transferPaymentDate"),
        txtBankPaymentRefNo = $("#bankPayment\\.refNo"),
        txtBankPaymentRemark = $("#bankPayment\\.remark"),
        dtpBankPaymentCreatedDate = $("#bankPayment\\.createdDate"),
        
        txtBankPaymentCurrencyCodeSession=$("#bankPaymentCurrencyCodeSession"),
        txtBankPaymentTotalBalanceIDR = $("#bankPaymentTotalBalanceIDR"),
                
        txtBankPaymentTotalDebitForeign = $("#bankPaymentTotalDebitForeign"),
        txtBankPaymentTotalDebitIDR = $("#bankPaymentTotalDebitIDR"),
        txtBankPaymentTotalCreditForeign = $("#bankPaymentTotalCreditForeign"),
        txtBankPaymentTotalCreditIDR = $("#bankPaymentTotalCreditIDR"),
        txtBankPaymentTotalBalanceForeign = $("#bankPaymentTotalBalanceForeign"),
        
        txtBankPaymentForexAmount = $("#bankPaymentForexAmount"),
        
        allBankPaymentFields = $([])
            .add(txtBankPaymentCode)
            .add(txtBankPaymentCurrencyCode)
            .add(txtBankPaymentCurrencyName)
            .add(txtBankPaymentExchangeRate)
            .add(txtBankPaymentRefNo)
            .add(txtBankPaymentRemark)
            .add(txtBankPaymentTotalTransactionAmountForeign)
            .add(txtBankPaymentTotalTransactionAmountIDR)
            .add(txtBankPaymentTotalDebitForeign)
            .add(txtBankPaymentTotalDebitIDR)
            .add(txtBankPaymentTotalCreditForeign)
            .add(txtBankPaymentTotalCreditIDR)
            .add(txtBankPaymentTotalBalanceForeign)
            .add(txtBankPaymentTotalBalanceIDR)
            .add(txtBankPaymentForexAmount)
            .add(txtBankPaymentTotalTransactionAmountIDR);

       
    $(document).ready(function() {

        bankPaymentFlagConfirmed=false;
        bankPaymentValidateCurrencyExchangeRate();
        bankPaymentOnChangeTransactionType();
        bankPaymentFormatNumeric2();
        bankPaymentValidateGiroPayment();
        
        $("#btnUnConfirmBankPayment").css("display", "none");
        $("#btnBankPaymentAddDetail").css("display", "none");
        $('#bankPaymentPaymentRequestInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#bankPaymentPaymentRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $.subscribe("bankPaymentDetailDocumentInput_grid_onSelect", function() {
            var selectedRowID = $("#bankPaymentPaymentRequestInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==bankPaymentDetail_lastSel) {

                $('#bankPaymentPaymentRequestInput_grid').jqGrid("saveRow",bankPaymentDetail_lastSel); 
                $('#bankPaymentPaymentRequestInput_grid').jqGrid("editRow",selectedRowID,true);            

                bankPaymentDetail_lastSel=selectedRowID;

            }else{
                $('#bankPaymentPaymentRequestInput_grid').jqGrid("saveRow",selectedRowID);
            }

        });
        
        $.subscribe("bankPaymentPaymentRequestDetailDocumentInput_grid_onSelect", function() {
            var selectedRowID = $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==bankPaymentSubDetail_lastSel) {

                $('#bankPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",bankPaymentSubDetail_lastSel); 
                $('#bankPaymentPaymentRequestDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                bankPaymentSubDetail_lastSel=selectedRowID;

            }else{
                $('#bankPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }

        });

        $('input[name="bankPaymentTransactionTypeRad"][value="Regular"]').change(function(ev){
            var value="Regular";
            $("#bankPayment\\.transactionType").val(value);
        });
                
        $('input[name="bankPaymentTransactionTypeRad"][value="Deposit"]').change(function(ev){
            var value="Deposit";
            $("#bankPayment\\.transactionType").val(value);
        });
        
        $("#bankPayment\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#bankPayment\\.exchangeRate").change(function(e){
            var exrate=$("#bankPayment\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#bankPayment\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
           
        $('#btnBankPaymentSave').click(function(ev) {
            
            if(bankPaymentFlagConfirmed===false){
                alertMessage("Please Confirm!",$("#btnConfirmBankPayment"));
                return;
            }
            
            $("#btnBankPaymentCalculate").trigger("click");
            
                if(bankPaymentDetail_lastSel !== -1) {
                    $('#bankPaymentPaymentRequestInput_grid').jqGrid("saveRow",bankPaymentDetail_lastSel); 
                }
            
                if(bankPaymentSubDetail_lastSel !== -1) {
                    $('#bankPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",bankPaymentSubDetail_lastSel); 
                }

                var ids = jQuery("#bankPaymentPaymentRequestInput_grid").jqGrid('getDataIDs'); 
                var idsSub = jQuery("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('getDataIDs'); 
                var totalBalanceForeign = parseFloat(removeCommas(txtBankPaymentTotalBalanceForeign.val()));
                var totalBalanceIDR = parseFloat(removeCommas(txtBankPaymentTotalBalanceIDR.val()));
                var headerCurrency = txtBankPaymentCurrencyCode.val();
                
                // cek isi detail
                if(ids.length===0){
                    alertMessage("Grid Bank Payment Detail Is Not Empty");
                    $("#dlgLoading").dialog("close");
                    return;
                }
                
                // cek balance apabila foreign or IDR
                if (headerCurrency !== "IDR") {
                    if (totalBalanceForeign !== 0) {
                        alertMessage("Balance Foreign Must be 0");
                        return;
                    }
                }
                else {
                    if (totalBalanceIDR !== 0) {
                        alertMessage("Balance IDR Must be 0");
                        return;
                    }
                }
                
                //cek giro amount = detail amount
                if($("#frmBankPaymentInput_bankPayment_paymentType").val() == "Giro"){
                    var amount = 0;
                    var amountGiroForeign = parseFloat(removeCommas(txtBankPaymentTotalTransactionAmountForeign.val()));
                    var amountGiroIDR = parseFloat(removeCommas(txtBankPaymentTotalTransactionAmountIDR.val()));
                    for(var u=0; u<ids.length; u++){
                        var data = $("#bankPaymentPaymentRequestInput_grid").jqGrid('getRowData',ids[u]); 
                        amount = amount + parseFloat(data.bankPaymentPaymentRequestTotalTransactionAmount);
                    }
                    if(!(amount == amountGiroForeign || amount == amountGiroIDR)){
                        alert("Detail Cant Less Or More Than Giro Amount");
                        return;
                    }
                }
                
                var listBankPaymentPaymentRequestDetail = new Array(); 
                                
                for(var i=0;i < idsSub.length;i++){ 
                    var data = $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('getRowData',idsSub[i]); 
                    
                    var debitValue=parseFloat(data.bankPaymentDetailDocumentDebitForeign);
                    var creditValue=parseFloat(data.bankPaymentDetailDocumentCreditForeign);
                    
                    if(debitValue<0){
                        alertMessage("Symbol Minus Not Recommended In Debit Column!");
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
                    
                    var bankPaymentPaymentRequestDetail = { 
                        branch                 : {code:data.bankPaymentPaymentRequestDetailBranchCode},
                        paymentRequest         : {code:data.bankPaymentPaymentRequestDetailHeaderCode},
                        documentNo             : data.bankPaymentPaymentRequestDetailDocumentNo,
                        documentType           : data.bankPaymentPaymentRequestDetailDocumentType,
                        documentBranchCode     : data.bankPaymentPaymentRequestDetailDocumentBranchCode,
                        currency               : {code:data.bankPaymentPaymentRequestDetailCurrencyCode},
                        exchangeRate           : data.bankPaymentPaymentRequestDetailExchangeRate,
                        transactionStatus      : data.bankPaymentPaymentRequestDetailTransactionStatus,
                        chartOfAccount         : {code:data.bankPaymentPaymentRequestDetailChartOfAccountCode},
                        department             : {code:data.bankPaymentPaymentRequestDetailDepartmentCode},
                        credit                 : data.bankPaymentPaymentRequestDetailCreditAmount,
                        creditIDR              : data.bankPaymentPaymentRequestDetailCreditAmountIDR,
                        debit                  : data.bankPaymentPaymentRequestDetailDebitAmount,
                        debitIDR               : data.bankPaymentPaymentRequestDetailDebitAmountIDR,
                        remark                 : data.bankPaymentPaymentRequestDetailRemark
                    };

                    listBankPaymentPaymentRequestDetail[i] = bankPaymentPaymentRequestDetail;
                }
                
                bankPaymentFormatDate();
                bankPaymentUnFormatNumeric();
                var forexAmount=txtBankPaymentForexAmount.val();
                 
                var url = "finance/bank-payment-save";
                var params = $("#frmBankPaymentInput").serialize();
                    params += "&listBankPaymentDetailJSON=" + $.toJSON(listBankPaymentPaymentRequestDetail);
                    params += "&forexAmount=" + forexAmount;
                
                showLoading();
//                alert(params);
//                return;
                $.post(url, params, function(data) {
                    closeLoading();
                    if (data.error) {
                        bankPaymentFormatDate();
                        bankPaymentFormatNumeric();
                        alertMessage(data.errorMessage);
                        return;
                    }
                    
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
                                    var url = "finance/bank-payment-input";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuBANK_PAYMENT");
                                }
                            },
                            {
                                text : "No",
                                click : function() {
                                    $(this).dialog("close");
                                    var url = "finance/bank-payment";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuBANK_PAYMENT");
                                }
                            }]
                    });
                });
        });

        $("#btnConfirmBankPayment").click(function(ev) {
            bank_payment_handlers_input();
            
            if(!$("#frmBankPaymentInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            if(parseFloat(removeCommas(txtBankPaymentExchangeRate.val()))<=0){
                alertMessage("Invalid Exchange Rate Value!",txtBankPaymentExchangeRate);
                return;
            }
            
            var date1 = dtpBankPaymentTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#bankPaymentTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#bankPaymentUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#bankPaymentTransactionDate").val(),dtpBankPaymentTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpBankPaymentTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#bankPaymentUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#bankPaymentTransactionDate").val(),dtpBankPaymentTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpBankPaymentTransactionDate);
                }
                return;
            }
            
            bankPaymentFlagConfirmed=true;
            $("#btnUnConfirmBankPayment").css("display", "block");
            $("#btnConfirmBankPayment").css("display", "none");
            $("#btnBankPaymentAddDetail").css("display", "block");
            $('#headerInputBankPayment').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#bankPaymentPaymentRequestInputGrid').unblock();
            $('#bankPaymentPaymentRequestDetailInputGrid').unblock();
            
            if($("#bankPayment\\.transactionType").val() === "DEPOSIT" || $("#bankPayment\\.transactionType").val() === "Deposit"){
                $('#bankPaymentPaymentRequestInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#bankPaymentPaymentRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                var defRow = {
                    bankPaymentDetailDocumentDocumentNo            : " ",
                    bankPaymentDetailBranchCode                    : txtBankPaymentBranchCode.val(),
                    bankPaymentDetailDocumentBranchCode            : txtBankPaymentBranchCode.val(),                    
                    bankPaymentDetailDocumentCurrencyCode          : txtBankPaymentCurrencyCode.val(),
                    bankPaymentDetailDocumentExchangeRate          : removeCommas(txtBankPaymentExchangeRate.val()),
                    bankPaymentDetailDocumentTransactionStatus     : "Other",
                    bankPaymentDetailDocumentCreditForeign         : removeCommas(txtBankPaymentTotalTransactionAmountForeign.val()),
                    bankPaymentDetailDocumentCreditIDR             : removeCommas(txtBankPaymentTotalTransactionAmountIDR.val()),
                    bankPaymentDetailDocumentChartOfAccountCode    : $("#bankPaymentDetailCOASalesDownPaymentCode").val(),
                    bankPaymentDetailDocumentChartOfAccountName    : $("#bankPaymentDetailCOASalesDownPaymentName").val()
                };
                
                bankPaymentDetaillastRowId++;
                $("#bankPaymentDetailDocumentInput_grid").jqGrid("addRowData", bankPaymentDetaillastRowId, defRow);
                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#bankPaymentDetailDocumentInput_grid").jqGrid('setRowData',bankPaymentDetaillastRowId,{Buttons:be});
                ev.preventDefault();
                $("#btnBankPaymentAddDetail").css("display", "none");
                $("#btnBankPaymentAddDetailOther").css("display", "none");
            }
            if(($("#bankPayment\\.transactionType").val() === "Regular")||($("#bankPayment\\.transactionType").val() === "REGULAR")){
                if ($("#bankPaymentUpdateMode").val()==="true"){
                    $("#btnBankPaymentAddDetail").css("display", "block");
                    $("#btnBankPaymentAddDetailOther").css("display", "block");
                    $('#bankPaymentPaymentRequestInputGrid').unblock();
                    bankPaymentLoadDataDetail();}
                else if ($("#bankPaymentUpdateMode").val()==="false"){
                    $("#btnBankPaymentAddDetail").css("display", "block");
                    $("#btnBankPaymentAddDetailOther").css("display", "block");
                    $('#bankPaymentPaymentRequestInputGrid').unblock();
                }
                $("#btnBankPaymentAddDetail").css("display", "block");
                $("#btnBankPaymentAddDetailOther").css("display", "block");
            }
            
            if(txtBankPaymentCurrencyCode.val()==="IDR"){
                $("#bankPaymentDetailDocumentInput_grid").jqGrid('hideCol',[,"bankPaymentDetailDocumentDebitForeign","bankPaymentDetailDocumentCreditForeign"]);
            }else{
                $("#bankPaymentDetailDocumentInput_grid").jqGrid('showCol',[,"bankPaymentDetailDocumentDebitForeign","bankPaymentDetailDocumentCreditForeign"]);
            }
            
        });
        
        $("#btnUnConfirmBankPayment").click(function(ev) {
            
            var rows = jQuery("#bankPaymentPaymentRequestInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                bankPaymentFlagConfirmed=false;        
                $("#btnUnConfirmBankPayment").css("display", "none");
                $("#btnConfirmBankPayment").css("display", "block");
                $("#btnBankPaymentAddDetail").css("display", "none");
                $('#headerInputBankPayment').unblock();
                $('#bankPaymentPaymentRequestInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#bankPaymentPaymentRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                return;
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
                            bankPaymentFlagConfirmed=false;
                            $("#bankPaymentPaymentRequestInput_grid").jqGrid('clearGridData');
                            $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmBankPayment").css("display", "none");
                            $("#btnConfirmBankPayment").css("display", "block");
                            $("#btnBankPaymentAddDetail").css("display", "none");
                            $('#headerInputBankPayment').unblock();
                            $('#bankPaymentPaymentRequestInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                            $('#bankPaymentPaymentRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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

        $('#btnBankPaymentAddDetail').click(function(ev) {

            if(!bankPaymentFlagConfirmed){
                alertMessage("Please Confirm!",$("#btnConfirmBankPayment"));
                return;
            }
            
            var firstDate = $("#bankPaymentTransactionDateFirstSession").val();
            var lastDate = $("#bankPaymentTransactionDateLastSession").val();    
            window.open("./pages/search/search-payment-request-by-bank-payment.jsp?iddoc=bankPaymentPaymentRequest&idsubdoc=branch&idtransaction="+txtBankPaymentTransactionType.val()+"&firstDate="+firstDate+"&lastDate="+lastDate+"&idcurrency="+txtBankPaymentCurrencyCode.val()+"&rowLast="+bankPaymentDetaillastRowId+"&type=grid","Search", "Scrollbars=1,width=600, height=500");
        });
    
        $('#btnBankPaymentCancel').click(function(ev) {
            var url = "finance/bank-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuBANK_PAYMENT"); 

        });
        
        $('#bankPayment_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=bankPayment&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#bankPayment_btnBankAccount').click(function(ev) {
            window.open("./pages/search/search-bank-account.jsp?iddoc=bankPayment&idsubdoc=bankAccount","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#bankPayment_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=bankPayment&idsubdoc=currency","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#bankPayment_btnGiroPayment').click(function(ev) {
            var currencyCode=$("#bankPayment\\.currency\\.code").val();
            if(currencyCode===""){
                alertMessage("Please Select Currency!",$("#bankPayment\\.currency\\.code"));
                return;
            }
            window.open("./pages/search/search-giro-payment.jsp?iddoc=bankPayment&idcurr="+txtBankPaymentCurrencyCode.val()+"&firstDate="+$("#bankPaymentTransactionDateFirstSession").val()+"&lastDate="+$("#bankPaymentTransactionDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
        });

        $('#btnBankPaymentCalculate').click(function(ev) {

            if(bankPaymentDetail_lastSel !== -1) {
                $('#bankPaymentPaymentRequestInput_grid').jqGrid("saveRow",bankPaymentDetail_lastSel); 
            }

            if(bankPaymentSubDetail_lastSel !== -1) {
                $('#bankPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",bankPaymentSubDetail_lastSel); 
            }

            var idsSub = jQuery("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('getDataIDs'); 
            var exchangeRate=$("#bankPayment\\.exchangeRate").val().replace(/,/g,"");

            var DebitForeign = 0;
            var DebitIDR = 0;

            var CreditForeign = $("#bankPayment\\.totalTransactionAmount").val().replace(/,/g,"");
            var CreditIDR = (parseFloat(CreditForeign)* parseFloat(exchangeRate));

            var BalanceForeign = 0;
            var BalanceIDR = 0;

            var nilaiForexHeader = 0;

            CreditForeign = parseFloat(CreditForeign);
            CreditIDR = parseFloat(CreditIDR);

            for(var i=0;i < idsSub.length;i++){ 
                var data = $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('getRowData',idsSub[i]); 

                var documentDebitForeign = data.bankPaymentPaymentRequestDetailDebitAmount;
                var documentDebitIDR = data.bankPaymentPaymentRequestDetailDebitAmountIDR;
                var documentCreditForeign = data.bankPaymentPaymentRequestDetailCreditAmount;
                var documentCreditIDR = data.bankPaymentPaymentRequestDetailCreditAmountIDR;

                var headerRate = txtBankPaymentExchangeRate.val().replace(/,/g,"");
                var headerCurrency = txtBankPaymentCurrencyCode.val();

                var documentRate = data.bankPaymentPaymentRequestDetailExchangeRate;
                var documentCurrency = data.bankPaymentPaymentRequestDetailCurrencyCode;

//                var documentDebitIDR = documentDebitForeign * documentRate;
//                $("#bankPaymentDetailDocumentInput_grid").jqGrid("setCell", idsSub[i],"bankPaymentDetailDocumentDebitIDR",documentDebitIDR);
//
//                var documentCreditIDR = documentCreditForeign * documentRate;
//                $("#bankPaymentDetailDocumentInput_grid").jqGrid("setCell", idsSub[i],"bankPaymentDetailDocumentCreditIDR",documentCreditIDR);

                var selisihKurs = 0;
                var nilaiDokumen = 0;
                var nilaiForex = 0;

                if (headerCurrency !== "IDR")
                {
                    if (documentCurrency === headerCurrency)
                    {
                        selisihKurs = parseFloat(documentRate) - parseFloat(headerRate);
                        nilaiDokumen = parseFloat(documentDebitForeign) - parseFloat(documentCreditForeign);

                        nilaiForex = selisihKurs * nilaiDokumen;
                        nilaiForexHeader = parseFloat(nilaiForexHeader) + nilaiForex;
                    }
                }


                DebitForeign = (parseFloat(DebitForeign) + parseFloat(documentDebitForeign)).toFixed(2);
                DebitIDR = (parseFloat(DebitIDR) + parseFloat(documentDebitIDR)).toFixed(2);

                CreditForeign = (parseFloat(CreditForeign) + parseFloat(documentCreditForeign)).toFixed(2);
                CreditIDR = (parseFloat(CreditIDR) + parseFloat(documentCreditIDR)).toFixed(2);            
            }

//            var splitDebitForeign=DebitForeign.split('.');
//            var DebitForeignFormat;
//            if(splitDebitForeign[0].length>3){
//                var concatDebitForeign=parseFloat(splitDebitForeign[0]+'.'+splitDebitForeign[1]);
//                DebitForeignFormat=formatNumber(concatDebitForeign,2);
//            }else{
//                DebitForeignFormat=splitDebitForeign[0]+'.'+splitDebitForeign[1];
//            }
            txtBankPaymentTotalDebitForeign.val(formatNumber(parseFloat(DebitForeign),2));
            txtBankPaymentTotalDebitIDR.val(formatNumber(parseFloat(DebitIDR),2));


//            var splitCreditForeign=CreditForeign.split('.');
//            var CreditForeignFormat;
//            if(splitCreditForeign[0].length>3){
//                var concatCreditForeign=parseFloat(splitCreditForeign[0]+'.'+splitCreditForeign[1]);
//                CreditForeignFormat=formatNumber(concatCreditForeign,2);
//            }else{
//                CreditForeignFormat=splitCreditForeign[0]+'.'+splitCreditForeign[1];
//            }
            txtBankPaymentTotalCreditForeign.val(formatNumber(parseFloat(CreditForeign),2));
            txtBankPaymentTotalCreditIDR.val(formatNumber(parseFloat(CreditIDR),2));

            BalanceForeign = (DebitForeign - CreditForeign).toFixed(2);
            BalanceIDR = (DebitIDR - CreditIDR).toFixed(2);


//            var splitBalanceForeign=BalanceForeign.split('.');
//            var BalanceForeignFormat;
//            if(splitBalanceForeign[0].length>3){
//                var concatBalanceForeign=parseFloat(splitBalanceForeign[0]+'.'+splitBalanceForeign[1]);
//                BalanceForeignFormat=formatNumber(concatBalanceForeign,2);
//            }else{
//                BalanceForeignFormat=splitBalanceForeign[0]+'.'+splitBalanceForeign[1];
//            }
            txtBankPaymentTotalBalanceForeign.val(formatNumber(parseFloat(BalanceForeign),2));
            txtBankPaymentTotalBalanceIDR.val(formatNumber(parseFloat(BalanceIDR),2));

            txtBankPaymentForexAmount.val(formatNumber(nilaiForexHeader,2));
        });
    });//EOF Ready
    //ok
    function bankPaymentTransactionDateOnChange(){
        if($("#bankPaymentUpdateMode").val()!=="true"){
            $("#bankPaymentTransactionDate").val(dtpBankPaymentTransactionDate.val());
        }
    }
    //ok
    function setBankPaymentTransactionType(){
        switch($("#bankPayment\\.transactionType").val()){
            case "Regular":
                $('input[name="bankPaymentTransactionTypeRad"][value="Regular"]').prop('checked',true);
                $('#bankPaymentTransactionTypeRadDown\\ Payment').attr('disabled', true);
                break;
            case "Down Payment":
                $('input[name="bankPaymentTransactionTypeRad"][value="Down Payment"]').prop('checked',true);
                $('#bankPaymentTransactionTypeRadRegular').attr('disabled', true);
                break;
        }
//        var modeUpdate=$("#bankPaymentUpdateMode").val();
//        switch(modeUpdate){
//            case "true":
//                switch($("#bankPayment\\.transactionType").val()){
//                    case "Regular":
//                        $('input[name="bankPaymentTransactionTypeRad"][value="Regular"]').prop('checked',true);
//                        $('#bankPaymentTransactionTypeRadDown\\ Payment').attr('disabled', true);
//                        break;
//                    case "Down Payment":
//                        $('input[name="bankPaymentTransactionTypeRad"][value="Down Payment"]').prop('checked',true);
//                        $('#bankPaymentTransactionTypeRadRegular').attr('disabled', true);
//                        break;
//                } 
//            break;
//        }
    }
    //ok
    function bankPaymentFormatNumeric2(){
        var exchangerateHeaderFormat =parseFloat(txtBankPaymentExchangeRate.val());
        txtBankPaymentExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));
        
        var totalTransactionAmountFormat =parseFloat(txtBankPaymentTotalTransactionAmountForeign.val());
        txtBankPaymentTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));
        
        var totalTransactionAmountIDRFormat =parseFloat(txtBankPaymentTotalTransactionAmountIDR.val());
        txtBankPaymentTotalTransactionAmountIDR.val(formatNumber(totalTransactionAmountIDRFormat,2));
                        
    }
    //ok
    function bankPaymentFormatDate(){
        var transactionDate=$("#bankPayment\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpBankPaymentTransactionDate.val(transactionDateValue);
        $("#bankPaymentTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var createdDate=$("#bankPayment\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpBankPaymentCreatedDate.val(createdDateValue);
        $("#bankPaymentTemp\\.createdDateTemp").val(createdDateValue);

        var tanggalTransferDate=$("#bankPayment\\.transferPaymentDate").val().split(' ');
        var tanggalTransferDateTemp=tanggalTransferDate[0].split('/');
        var tanggalTransferDateValue=tanggalTransferDateTemp[1]+"/"+tanggalTransferDateTemp[0]+"/"+tanggalTransferDateTemp[2]+" "+tanggalTransferDate[1];
        dtpBankPaymentTransferPaymentDate.val(tanggalTransferDateValue);
        $("#bankPaymentTemp\\.transferPaymentDateTemp").val(tanggalTransferDateValue);
    }
    //ok
    function bankPaymentFormatNumeric(){
        var exchangerateHeaderFormat =parseFloat(txtBankPaymentExchangeRate.val()) ;
        txtBankPaymentExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));

        var totalTransactionAmountFormat =parseFloat(txtBankPaymentTotalTransactionAmountForeign.val()) ;
        txtBankPaymentTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));

        var totalTransactionAmountIDRFormat = parseFloat(txtBankPaymentTotalTransactionAmountIDR.val());
        txtBankPaymentTotalTransactionAmountIDR.val(formatNumber(totalTransactionAmountIDRFormat,2));

        var totalBalanceForeign=parseFloat(txtBankPaymentTotalBalanceForeign.val());
        txtBankPaymentTotalBalanceForeign.val(formatNumber(totalBalanceForeign,2));

        var totalBalanceIDR=parseFloat(txtBankPaymentTotalBalanceIDR.val());
        txtBankPaymentTotalBalanceIDR.val(formatNumber(totalBalanceIDR,2));

        var totalDebitForeign=parseFloat(txtBankPaymentTotalDebitForeign.val());
        txtBankPaymentTotalDebitForeign.val(formatNumber(totalDebitForeign,2));

        var totalDebitIDR=parseFloat(txtBankPaymentTotalDebitIDR.val());
        txtBankPaymentTotalDebitIDR.val(formatNumber(totalDebitIDR,2));

        var totalCreditForeign=parseFloat(txtBankPaymentTotalCreditForeign.val());
        txtBankPaymentTotalCreditForeign.val(formatNumber(totalCreditForeign,2));

        var totalCreditIDR=parseFloat(txtBankPaymentTotalCreditIDR.val());
        txtBankPaymentTotalCreditIDR.val(formatNumber(totalCreditIDR,2));

        var forexAmount= parseFloat(txtBankPaymentForexAmount.val());
        txtBankPaymentForexAmount.val(formatNumber(forexAmount,2));
    }
    //ok
    function bankPaymentUnFormatNumeric(){
        var exchangerateHeaderFormat = txtBankPaymentExchangeRate.val().replace(/,/g, "");
        txtBankPaymentExchangeRate.val(exchangerateHeaderFormat);

        var totalTransactionAmountFormat = txtBankPaymentTotalTransactionAmountForeign.val().replace(/,/g, "");
        txtBankPaymentTotalTransactionAmountForeign.val(totalTransactionAmountFormat);

        var totalTransactionAmountIDRFormat = txtBankPaymentTotalTransactionAmountIDR.val().replace(/,/g, "");
        txtBankPaymentTotalTransactionAmountIDR.val(totalTransactionAmountIDRFormat);

        var totalBalanceForeign=txtBankPaymentTotalBalanceForeign.val().replace(/,/g, "");
        txtBankPaymentTotalBalanceForeign.val(totalBalanceForeign);

        var totalBalanceIDR=txtBankPaymentTotalBalanceIDR.val().replace(/,/g, "");
        txtBankPaymentTotalBalanceIDR.val(totalBalanceIDR);

        var totalDebitForeign=txtBankPaymentTotalDebitForeign.val().replace(/,/g, "");
        txtBankPaymentTotalDebitForeign.val(totalDebitForeign);

        var totalDebitIDR=txtBankPaymentTotalDebitIDR.val().replace(/,/g, "");
        txtBankPaymentTotalDebitIDR.val(totalDebitIDR);

        var totalCreditForeign=txtBankPaymentTotalCreditForeign.val().replace(/,/g, "");
        txtBankPaymentTotalCreditForeign.val(totalCreditForeign);

        var totalCreditIDR=txtBankPaymentTotalCreditIDR.val().replace(/,/g, "");
        txtBankPaymentTotalCreditIDR.val(totalCreditIDR);

        var forexAmount= txtBankPaymentForexAmount.val().replace(/,/g, "");
        txtBankPaymentForexAmount.val(forexAmount);
    }
    //ok
    function bankPaymentCalculateTotalTransactionAmountForeign(){
        var type = $("#frmBankPaymentInput_bankPayment_paymentType").val();
        if(type == "Giro"){
            //nothing
        }else{
            var totalTransactionAmount = 0;
                var ids = jQuery("#bankPaymentPaymentRequestInput_grid").jqGrid('getDataIDs');
                for(var i=0; i<ids.length; i++){
                    var data= $("#bankPaymentPaymentRequestInput_grid").jqGrid('getRowData',ids[i]);
                    totalTransactionAmount = totalTransactionAmount + parseFloat(data.bankPaymentPaymentRequestTotalTransactionAmount);
                }
                $("#bankPayment\\.totalTransactionAmount").val(formatNumber(totalTransactionAmount,2));
                bankPaymentCalculateTotalTransactionAmountIDR();
        }
    }
    //ok
    function bankPaymentCalculateTotalTransactionAmountIDR(){
        bankPaymentValidateCurrencyExchangeRate();
        var totalTransactionAmount=parseFloat(removeCommas(txtBankPaymentTotalTransactionAmountForeign.val()));
        var exchangeRate=parseFloat(removeCommas(txtBankPaymentExchangeRate.val()));
        if(txtBankPaymentExchangeRate.val()===""){
            exchangeRate=0;
        }
        if(txtBankPaymentTotalTransactionAmountForeign.val()===""){
            totalTransactionAmount=0;
        }
        var totalTransactionAmountIDR=(totalTransactionAmount* exchangeRate);
        $("#bankPayment\\.totalTransactionAmountIDR").val(formatNumber(totalTransactionAmountIDR,2));
    }
    //ok
    function bankPaymentCalculateBalance(){
        var amountForeign=0;
        var amountIDR=0;
        var ids = jQuery("#bankPaymentDetailDocumentInput_grid").jqGrid('getDataIDs');
           
        for(var i=0;i < ids.length;i++) {
            var data = $("#bankPaymentDetailDocumentInput_grid").jqGrid('getRowData',ids[i]);
            amountForeign +=parseFloat(data.bankPaymentDetailDocumentAmountForeignTemp);
            amountIDR +=parseFloat(data.bankPaymentDetailDocumentAmountIDRTemp);
        }        
        var sumAmountForeign=0- amountForeign;
        var sumAmountForeignLetter;
        if(sumAmountForeign < 0){
           sumAmountForeignLetter="-" + formatNumber(Math.abs(sumAmountForeign),4);
        }else{
            sumAmountForeignLetter=formatNumber(sumAmountForeign,4); 
        }
        
        var sumAmountIDR=0 - amountIDR;
               
        txtBankPaymentTotalBalanceForeign.val(sumAmountForeignLetter);
        txtBankPaymentTotalBalanceIDR.val(formatNumber(sumAmountIDR,4));
        
    }
    //ok
    function bankPaymentPaymentRequestInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#bankPaymentPaymentRequestInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        $("#bankPaymentPaymentRequestInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridHeader();
        bankPaymentCalculateTotalTransactionAmountForeign();
        addRowPaymentDetail();
    }
    //update
    function bankPaymentLoadDataDetail() {
        
        var url = "finance/bank-payment-detail-data";
        var params = "bankPayment.code=" + txtBankPaymentCode.val();
            
        $.getJSON(url, params, function(data) {
            bankPaymentDetaillastRowId = 0;
                    
            for (var i=0; i<data.listBankPaymentDetailTemp.length; i++) {
                
                var transactionType=data.listBankPaymentDetailTemp[i].transactionStatus;
                var currencyCodeDocument="";
                var exchangeRateDocument="0.00";
                var balancedForeign=0.00;
                var balancedIDR=0.00;
                
                switch(transactionType){
                    case "Transaction":
                        currencyCodeDocument=data.listBankPaymentDetailTemp[i].currencyCode;
                        exchangeRateDocument=data.listBankPaymentDetailTemp[i].exchangeRate;
                        balancedForeign+=parseFloat(data.listBankPaymentDetailTemp[i].documentBalanceAmount)+(parseFloat(data.listBankPaymentDetailTemp[i].debit) + parseFloat(data.listBankPaymentDetailTemp[i].credit));
                        balancedIDR+=parseFloat(data.listBankPaymentDetailTemp[i].documentBalanceAmountIDR)+((parseFloat(data.listBankPaymentDetailTemp[i].debit)*exchangeRateDocument) + (parseFloat(data.listBankPaymentDetailTemp[i].credit)* exchangeRateDocument));
                        break;
                    case "Other":
                        currencyCodeDocument=txtBankPaymentCurrencyCode.val();
                        exchangeRateDocument=removeCommas(txtBankPaymentExchangeRate.val());
                        break;
                }
                
                $("#bankPaymentDetailDocumentInput_grid").jqGrid("addRowData", bankPaymentDetaillastRowId, data.listBankPaymentDetailTemp[i]);
                $("#bankPaymentDetailDocumentInput_grid").jqGrid('setRowData',bankPaymentDetaillastRowId,{
                    bankPaymentDetailDocumentDocumentNo         : data.listBankPaymentDetailTemp[i].documentNo,
                    bankPaymentDetailDocumentBranchCode         : data.listBankPaymentDetailTemp[i].documentBranchCode,
                    bankPaymentDetailDocumentDocumentType       : data.listBankPaymentDetailTemp[i].documentType,
                    bankPaymentDetailDocumentCurrencyCode       : currencyCodeDocument,
                    bankPaymentDetailDocumentExchangeRate       : exchangeRateDocument,
                    bankPaymentDetailDocumentAmountForeign      : data.listBankPaymentDetailTemp[i].documentAmount,
                    bankPaymentDetailDocumentAmountIDR          : data.listBankPaymentDetailTemp[i].documentAmountIDR,
                    
//                    bankPaymentDetailDocumentBalanceForeign     : data.listBankPaymentDetailTemp[i].documentBalanceAmount,
//                    bankPaymentDetailDocumentBalanceIDR         : data.listBankPaymentDetailTemp[i].documentBalanceAmountIDR,
                    bankPaymentDetailDocumentBalanceForeign     : balancedForeign,
                    bankPaymentDetailDocumentBalanceIDR         : balancedIDR,
                    
                    bankPaymentDetailDocumentTransactionStatus  : data.listBankPaymentDetailTemp[i].transactionStatus,
                    bankPaymentDetailDocumentDebitForeign       : data.listBankPaymentDetailTemp[i].debit,
                    bankPaymentDetailDocumentDebitIDR           : (parseFloat(data.listBankPaymentDetailTemp[i].debit)*exchangeRateDocument),
                    bankPaymentDetailDocumentCreditForeign      : data.listBankPaymentDetailTemp[i].credit,
                    bankPaymentDetailDocumentCreditIDR          : (parseFloat(data.listBankPaymentDetailTemp[i].credit)* exchangeRateDocument),
                    bankPaymentDetailDocumentChartOfAccountCode : data.listBankPaymentDetailTemp[i].chartOfAccountCode,
                    bankPaymentDetailDocumentChartOfAccountName : data.listBankPaymentDetailTemp[i].chartOfAccountName,
                    bankPaymentDetailDocumentRemark             : data.listBankPaymentDetailTemp[i].remark
                });
            bankPaymentDetaillastRowId++;
            }
        });
    }
    //update
    function bankPaymentPaymentRequestLoadDataDetail() {
        
        var url = "finance/payment-request-bank-payment-detail-data";
        var params = "paymentRequest.code=";
            
        $.getJSON(url, params, function(data) {
            bankPaymentDetaillastRowId = 0;
                    
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
                        currencyCodeDocument=txtBankPaymentCurrencyCode.val();
                        exchangeRateDocument=removeCommas(txtBankPaymentExchangeRate.val());
                        break;
                }
                
                var debitForeign="0.00";
                var debitIdr="0.00";
                var creditForeign="0.00";
                var creditIdr="0.00";
                if(txtBankPaymentCurrencyCode.val()==="IDR"){
                    debitForeign=parseFloat(data.listPaymentRequestDetailTemp[i].debit)/exchangeRateDocument;
                    debitIdr=data.listPaymentRequestDetailTemp[i].debit;
                    creditForeign=parseFloat(data.listPaymentRequestDetailTemp[i].credit)/ exchangeRateDocument;
                    creditIdr=data.listPaymentRequestDetailTemp[i].credit;
                }else{
                    debitForeign=data.listPaymentRequestDetailTemp[i].debit;
                    debitIdr=parseFloat(data.listPaymentRequestDetailTemp[i].debit)*exchangeRateDocument;
                    creditForeign=data.listPaymentRequestDetailTemp[i].credit;
                    creditIdr=parseFloat(data.listPaymentRequestDetailTemp[i].credit)* exchangeRateDocument;
                }
                
                $("#bankPaymentDetailDocumentInput_grid").jqGrid("addRowData", bankPaymentDetaillastRowId, data.listPaymentRequestDetailTemp[i]);
                $("#bankPaymentDetailDocumentInput_grid").jqGrid('setRowData',bankPaymentDetaillastRowId,{
                    bankPaymentDetailDocumentDocumentNo         : data.listPaymentRequestDetailTemp[i].documentNo,
                    bankPaymentDetailDocumentBranchCode         : data.listPaymentRequestDetailTemp[i].documentBranchCode,
                    bankPaymentDetailDocumentDocumentType       : data.listPaymentRequestDetailTemp[i].documentType,
                    bankPaymentDetailDocumentCurrencyCode       : currencyCodeDocument,
                    bankPaymentDetailDocumentExchangeRate       : exchangeRateDocument,
                    bankPaymentDetailDocumentAmountForeign      : data.listPaymentRequestDetailTemp[i].documentAmount,
                    bankPaymentDetailDocumentAmountIDR          : data.listPaymentRequestDetailTemp[i].documentAmountIDR,
                    bankPaymentDetailDocumentBalanceForeign     : data.listPaymentRequestDetailTemp[i].documentBalanceAmount,
                    bankPaymentDetailDocumentBalanceIDR         : data.listPaymentRequestDetailTemp[i].documentBalanceAmountIDR,
                    bankPaymentDetailDocumentTransactionStatus  : data.listPaymentRequestDetailTemp[i].transactionStatus,
                    
                    bankPaymentDetailDocumentDebitForeign       : debitForeign,//data.listPaymentRequestDetailTemp[i].debit,
                    bankPaymentDetailDocumentDebitIDR           : debitIdr,//(parseFloat(data.listPaymentRequestDetailTemp[i].debit)*exchangeRateDocument),
                    bankPaymentDetailDocumentCreditForeign      : creditForeign,//data.listPaymentRequestDetailTemp[i].credit,
                    bankPaymentDetailDocumentCreditIDR          : creditIdr,//(parseFloat(data.listPaymentRequestDetailTemp[i].credit)* exchangeRateDocument),
                    
                    bankPaymentDetailDocumentChartOfAccountCode : data.listPaymentRequestDetailTemp[i].chartOfAccountCode,
                    bankPaymentDetailDocumentChartOfAccountName : data.listPaymentRequestDetailTemp[i].chartOfAccountName,
                    bankPaymentDetailDocumentRemark             : data.listPaymentRequestDetailTemp[i].remark
                });
            bankPaymentDetaillastRowId++;
            }
        });
    }
    //ok
    function bankPaymentValidateCurrencyExchangeRate(){ 
        
        if (txtBankPaymentCurrencyCode.val()==="IDR"){
            txtBankPaymentExchangeRate.val("1.00");
            txtBankPaymentExchangeRate.attr("readonly",true);
        }else{
            if($("#bankPaymentUpdateMode").val()==="false"){
                txtBankPaymentExchangeRate.val("0.00");   
            }
            txtBankPaymentExchangeRate.attr("readonly",false);
        }
        
    }
    //ok
    function bankPaymentOnChangeTransactionType(){
        var transactionType=$("#bankPayment\\.transactionType").val();
        switch(transactionType){
            case "Regular":
                $('#bankPaymentTransactionTypeRadRegular').prop('checked',true);
                break;
            case "Down Payment":
                $('#bankPaymentTransactionTypeRadDown\\ Payment').prop('checked',true);
                break;
        }
        
        setBankPaymentTransactionType();
    }
    //ok
    function bankPaymentFormatAmount(){
        var totalTransactionAmount=parseFloat(txtBankPaymentTotalTransactionAmountForeign.val());
        txtBankPaymentTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmount,2));
    }
    //ok
    function bankPaymentValidateGiroPayment(){
        bankPaymentCalculateTotalTransactionAmountIDR();
        var type=$("#frmBankPaymentInput_bankPayment_paymentType").val();
        switch(type){
            case "Giro":
//                $("#bankPayment\\.currency\\.code").removeClass("required");
//                $("#bankPayment\\.currency\\.code").removeClass("cssClass");
//                $("#bankPayment\\.currency\\.code").css("required",false);
//                $("#bankPayment\\.currency\\.code").attr("readonly",true);
//                $("#bankPayment_btnCurrency").hide();
//                $("#ui-icon-search-currency-bank-payment").hide();
                $("#bankPayment\\.giroPayment\\.code").addClass("required");
                $("#bankPayment\\.giroPayment\\.code").addClass("cssClass");
                $("#bankPayment\\.giroPayment\\.code").css("required",true);
                $("#bankPayment\\.giroPayment\\.code").css("cssClass","required");
                $(".labelGiroPaymentCode").show();
                $(".textLookupGiroPayment").show();
                $(".labelPaymentRefNo").text("Giro Ref No");
                $(".labelPaymentDate").text("Giro Date");
                $(".labelPaymentBankName").text("Giro Bank Name");
//                txtBankPaymentTotalTransactionAmountForeign.attr("readonly", true);
                $("#bankPayment\\.paymentTo").attr("readonly",true);
                $("#bankPayment\\.transferPaymentNo").attr("readonly",true);
                $("#bankPayment\\.transferPaymentDate").attr("readonly",true);
                $("#bankPayment\\.transferPaymentDate").attr("disabled",true);
                $("#bankPayment\\.transferBankName").attr("readonly",true);
                break;
            case "Transfer":
//                $("#bankPayment\\.currency\\.code").addClass("required");
//                $("#bankPayment\\.currency\\.code").addClass("cssClass");
//                $("#bankPayment\\.currency\\.code").css("required",true);
//                $("#bankPayment\\.currency\\.code").attr("readonly",false);
//                $("#bankPayment_btnCurrency").show();
                $("#ui-icon-search-currency-bank-payment").show();
                $("#bankPayment\\.giroPayment\\.code").removeClass("required");
                $("#bankPayment\\.giroPayment\\.code").removeClass("cssClass");
                $("#bankPayment\\.giroPayment\\.code").css("required",false);
                $(".labelGiroPaymentCode").hide();
                $(".textLookupGiroPayment").hide();
                $(".labelPaymentDate").text("Transfer Date *");
                $(".labelPaymentRefNo").text("Transfer Ref No *");
                $(".labelPaymentBankName").text("Transfer Bank Name *");
//                txtBankPaymentTotalTransactionAmountForeign.attr("readonly", false);
                $("#bankPayment\\.paymentTo").attr("readonly",false);
                $("#bankPayment\\.transferPaymentNo").attr("readonly",false);
                $("#bankPayment\\.transferPaymentDate").attr("readonly",false);
                $("#bankPayment\\.transferPaymentDate").attr("disabled",false);
                $("#bankPayment\\.transferBankName").attr("readonly",false);
                var transferDate=dtpBankPaymentTransactionDate.val();
                dtpBankPaymentTransferPaymentDate.val(transferDate);
                break;
            case "Other":
                $("#bankPayment\\.currency\\.code").addClass("required");
                $("#bankPayment\\.currency\\.code").addClass("cssClass");
                $("#bankPayment\\.currency\\.code").css("required",true);
                $("#bankPayment\\.currency\\.code").attr("readonly",false);
                $("#bankPayment_btnCurrency").show();
                $("#ui-icon-search-currency-bank-payment").show();
                $("#bankPayment\\.giroPayment\\.code").removeClass("required");
                $("#bankPayment\\.giroPayment\\.code").removeClass("cssClass");
                $("#bankPayment\\.giroPayment\\.code").css("required",false);
                $(".labelGiroPaymentCode").hide();
                $(".textLookupGiroPayment").hide();
                $(".labelPaymentDate").text("Other Date *");
                $(".labelPaymentRefNo").text("Other Ref No *");
                $(".labelPaymentBankName").text("Other Bank Name *");
//                txtBankPaymentTotalTransactionAmountForeign.attr("readonly", false);
                $("#bankPayment\\.paymentTo").attr("readonly",false);
                $("#bankPayment\\.transferPaymentNo").attr("readonly",false);
                $("#bankPayment\\.transferPaymentDate").attr("readonly",false);
                $("#bankPayment\\.transferPaymentDate").attr("disabled",false);
                $("#bankPayment\\.transferBankName").attr("readonly",false);
                var otherDate=dtpBankPaymentTransactionDate.val();
                dtpBankPaymentTransferPaymentDate.val(otherDate);
                break;
        }
    }

    function changeBankPaymentDocumentType(type) {
        var selectedRowId = $("#bankPaymentPaymentRequestInput_grid").jqGrid("getGridParam","selrow");
        $("#" + selectedRowId + "_bankPaymentPaymentRequestTransactionStatus").val(type);
    }
    
    function changeBankPaymentType(paymentType){
        $("#frmBankPaymentInput_bankPayment_paymentType").val(paymentType);
    }

    function bankPaymentOnChangePaymentType(){
        unHandlersInput(txtBankPaymentGiroPaymentNo);
        unHandlersInput(txtBankPaymentPaymentTo);
        txtBankPaymentGiroPaymentNo.val("");
        txtBankPaymentTransferPaymentNo.val("");
        txtBankPaymentTransferBankName.val("");
        txtBankPaymentTotalTransactionAmountForeign.val("0.00");
        txtBankPaymentPaymentTo.val("");
        bankPaymentValidateGiroPayment();
    }
    
    function bank_payment_handlers_input(){
                
        if(dtpBankPaymentTransactionDate.val()===""){
            handlersInput(dtpBankPaymentTransactionDate);
        }else{
            unHandlersInput(dtpBankPaymentTransactionDate);
        }
        
        if(txtBankPaymentBranchCode.val()===""){
            handlersInput(txtBankPaymentBranchCode);
        }else{
            unHandlersInput(txtBankPaymentBranchCode);
        }
        
//        if(txtBankPaymentCompanyCode.val()===""){
//            handlersInput(txtBankPaymentCompanyCode);
//        }else{
//            unHandlersInput(txtBankPaymentCompanyCode);
//        }
        
        if(txtBankPaymentBankAccountCode.val()===""){
            handlersInput(txtBankPaymentBankAccountCode);
        }else{
            unHandlersInput(txtBankPaymentBankAccountCode);
        }
        
//        if(txtBankPaymentPaymentRequestCode.val()===""){
//            handlersInput(txtBankPaymentPaymentRequestCode);
//        }else{
//            unHandlersInput(txtBankPaymentPaymentRequestCode);
//        }
        
        if(txtBankPaymentCurrencyCode.val()===""){
            handlersInput(txtBankPaymentCurrencyCode);
        }else{
            unHandlersInput(txtBankPaymentCurrencyCode);
        }
        
        var type=$("#frmBankPaymentInput_bankPayment_paymentType").val();
        if(type==="Giro"){
            if(txtBankPaymentGiroPaymentNo.val()===""){
                handlersInput(txtBankPaymentGiroPaymentNo);
            }else{
                unHandlersInput(txtBankPaymentGiroPaymentNo);
            }
            unHandlersInput(txtBankPaymentPaymentTo);
        }else{
            if(txtBankPaymentPaymentTo.val()===""){
                handlersInput(txtBankPaymentPaymentTo);
            }else{
                unHandlersInput(txtBankPaymentPaymentTo);
            }

            unHandlersInput(txtBankPaymentGiroPaymentNo);
        }
       
    }
    //ok
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#bankPaymentPaymentRequestInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        var data= $("#bankPaymentPaymentRequestInput_grid").jqGrid('getRowData',lastRowId);
        
            $("#bankPaymentPaymentRequestInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#bankPaymentPaymentRequestInput_grid").jqGrid('setRowData',lastRowId,{
                bankPaymentPaymentRequestCodeTemp                : defRow.bankPaymentPaymentRequestCodeTemp,
                bankPaymentPaymentRequestBranchCode              : defRow.bankPaymentPaymentRequestBranchCode,
                bankPaymentPaymentRequestCode                    : defRow.bankPaymentPaymentRequestCode,
                bankPaymentPaymentRequestTransactionDate         : defRow.bankPaymentPaymentRequestTransactionDate,
                bankPaymentPaymentRequestCurrencyCode            : defRow.bankPaymentPaymentRequestCurrencyCode,
                bankPaymentPaymentRequestTotalTransactionAmount  : defRow.bankPaymentPaymentRequestTotalTransactionAmount,
                bankPaymentPaymentRequestTransactionType         : defRow.bankPaymentPaymentRequestTransactionType, 
                bankPaymentPaymentRequestRefNo                   : defRow.bankPaymentPaymentRequestRefNo, 
                bankPaymentPaymentRequestRemark                  : defRow.bankPaymentPaymentRequestRemark
            });
            
        setHeightGridHeader();
    }
    //ok
    function addRowPaymentDetail(){
        
        var ids = jQuery("#bankPaymentPaymentRequestInput_grid").jqGrid('getDataIDs');
        if(ids.length<0){
            return;
        }
        var codeString = "";
        var codeStringTemp = "";
        for(var i=0; i<ids.length; i++){
        var data= $("#bankPaymentPaymentRequestInput_grid").jqGrid('getRowData',ids[i]);
            if(i == 0){
                escape(codeStringTemp = "'"+data.bankPaymentPaymentRequestCode+"'");
            }else{
                escape(codeStringTemp = ",'"+data.bankPaymentPaymentRequestCode+"'");
            }
            codeString += codeStringTemp;
        }
            
        var url = "finance/payment-request-data-payment-detail";
        var params = "paymentRequestSearchCode="+codeString;
            
        $.getJSON(url, params, function(data) {
            bankPaymentSubDetaillastRowId = 0;
            $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid("clearGridData");
            for(var j=0; j<data.listPaymentRequestDetailTemp.length; j++){
                $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid("addRowData", bankPaymentSubDetaillastRowId, data.listPaymentRequestDetailTemp[j]);
                $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('setRowData',bankPaymentSubDetaillastRowId,{
                    bankPaymentPaymentRequestDetailCode                         : data.listPaymentRequestDetailTemp[j].code,
                    bankPaymentPaymentRequestDetailHeaderCode                   : data.listPaymentRequestDetailTemp[j].headerCode,
                    bankPaymentPaymentRequestDetailBranchCode                   : data.listPaymentRequestDetailTemp[j].branchCode,
                    bankPaymentPaymentRequestDetailDocumentNo                   : data.listPaymentRequestDetailTemp[j].documentNo,
                    bankPaymentPaymentRequestDetailDocumentType                 : data.listPaymentRequestDetailTemp[j].documentType,
                    bankPaymentPaymentRequestDetailDocumentBranchCode           : data.listPaymentRequestDetailTemp[j].documentBranchCode,
                    bankPaymentPaymentRequestDetailTransactionStatus            : data.listPaymentRequestDetailTemp[j].transactionStatus,
                    bankPaymentPaymentRequestDetailChartOfAccountCode           : data.listPaymentRequestDetailTemp[j].chartOfAccountCode,
                    bankPaymentPaymentRequestDetailChartOfAccountName           : data.listPaymentRequestDetailTemp[j].chartOfAccountName,
                    bankPaymentPaymentRequestDetailDepartmentSearch             : "...",
                    bankPaymentPaymentRequestDetailDepartmentCode               : data.listPaymentRequestDetailTemp[j].departmentCode,
                    bankPaymentPaymentRequestDetailDepartmentName               : data.listPaymentRequestDetailTemp[j].departmentName,
                    bankPaymentPaymentRequestDetailCurrencyCode                 : data.listPaymentRequestDetailTemp[j].currencyCode,
                    bankPaymentPaymentRequestDetailExchangeRate                 : data.listPaymentRequestDetailTemp[j].exchangeRate,
                    bankPaymentPaymentRequestDetailTotalTransactionAmount       : "0.00",
                    bankPaymentPaymentRequestDetailTotalTransactionAmountIDR    : "0.00",
                    bankPaymentPaymentRequestDetailBalanceAmount                : "0.00",
                    bankPaymentPaymentRequestDetailBalanceAmountIDR             : "0.00",
                    bankPaymentPaymentRequestDetailDebitAmount                  : data.listPaymentRequestDetailTemp[j].debit,
                    bankPaymentPaymentRequestDetailDebitAmountIDR               : data.listPaymentRequestDetailTemp[j].debitIDR,
                    bankPaymentPaymentRequestDetailCreditAmount                 : data.listPaymentRequestDetailTemp[j].credit,
                    bankPaymentPaymentRequestDetailCreditAmountIDR              : data.listPaymentRequestDetailTemp[j].creditIDR,
                    bankPaymentPaymentRequestDetailRemark                       : data.listPaymentRequestDetailTemp[j].remark
                });
            bankPaymentSubDetaillastRowId++;
            }
        });
        setHeightGridDetail();
    }
    //ok
    function setHeightGridHeader(){
        var ids = jQuery("#bankPaymentPaymentRequestInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#bankPaymentPaymentRequestInput_grid"+" tr").eq(1).height();
            $("#bankPaymentPaymentRequestInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#bankPaymentPaymentRequestInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    //ok
    function setHeightGridDetail(){
        var ids = jQuery("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#bankPaymentPaymentRequestDetailInput_grid"+" tr").eq(1).height();
            $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#bankPaymentPaymentRequestDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    
</script>

<s:url id="remoteurlBankPaymentDetailDocumentInput" action="" />
<b>BANK PAYMENT</b>
<hr>
<br class="spacer" />
<div id="bankPaymentInput" class="content ui-widget">
<s:form id="frmBankPaymentInput">
    <table cellpadding="2" cellspacing="2" id="headerInputBankPayment" width="100%">
        <tr>
            <td align="right" style="width:120px"><B>Branch *</B></td>
            <td colspan="2">
            <script type = "text/javascript">

                txtBankPaymentBranchCode.change(function(ev) {

                    if(txtBankPaymentBranchCode.val()===""){
                        txtBankPaymentBranchName.val("");
                        return;
                    }
                    var url = "master/branch-get";
                    var params = "branch.code=" + txtBankPaymentBranchCode.val();
                        params += "&branch.activeStatus=TRUE";

                    $.post(url, params, function(result) {
                        var data = (result);
                        if (data.branchTemp){
                            txtBankPaymentBranchCode.val(data.branchTemp.code);
                            txtBankPaymentBranchName.val(data.branchTemp.name);
                        }
                        else{
                            alertMessage("Branch Not Found!",txtBankPaymentBranchCode);
                            txtBankPaymentBranchCode.val("");
                            txtBankPaymentBranchName.val("");
                        }
                    });
                });
            </script>
            <div class="searchbox ui-widget-header" hidden="true">
                <s:textfield id="bankPayment.branch.code" name="bankPayment.branch.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                <sj:a id="bankPayment_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
            </div>
                <s:textfield id="bankPayment.branch.name" name="bankPayment.branch.name" size="40" readonly="true"></s:textfield>
        </tr>
        <tr>
            <td align="right"><B>Code *</B></td>
            <td colspan="3">
                <s:textfield id="bankPayment.code" name="bankPayment.code" key="bankPayment.code" readonly="true" size="22"></s:textfield>
                <s:textfield id="bankPaymentCurrencyCodeSession" name="bankPaymentCurrencyCodeSession" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="bankPaymentUpdateMode" name="bankPaymentUpdateMode" size="20" hidden="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Transaction Date *</B></td>
            <td>
                <sj:datepicker id="bankPayment.transactionDate" name="bankPayment.transactionDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" onchange="bankPaymentTransactionDateOnChange()"></sj:datepicker>
                <sj:datepicker id="bankPaymentTransactionDate" name="bankPaymentTransactionDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                <s:textfield id="bankPaymentTemp.transactionDateTemp" name="bankPaymentTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
            </td>
            <td>
                <sj:datepicker id="bankPaymentTransactionDateFirstSession" name="bankPaymentTransactionDateFirstSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                <sj:datepicker id="bankPaymentTransactionDateLastSession" name="bankPaymentTransactionDateLastSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Bank Account *</B></td>
            <td colspan="3">
                <script type = "text/javascript">
                    txtBankPaymentBankAccountCode.change(function(ev) {
                        
                        if(txtBankPaymentBankAccountCode.val()===""){
                            txtBankPaymentBankAccountName.val("");
                            txtBankPaymentBBKVoucherNo.val("");
                            txtBankPaymentBankAccountChartOfAccountCode.val("");
                            txtBankPaymentBankAccountChartOfAccountName.val("");
                            return;
                        }
                        
                        var url = "master/bank-account-get";
                        var params = "bankAccount.code=" + txtBankPaymentBankAccountCode.val();
                            params+= "&bankAccount.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);

                            if (data.bankAccountTemp){
                                txtBankPaymentBankAccountCode.val(data.bankAccountTemp.code);
                                txtBankPaymentBankAccountName.val(data.bankAccountTemp.name);
                                txtBankPaymentBBKVoucherNo.val(data.bankAccountTemp.bbkVoucherNo);
                                txtBankPaymentBankAccountChartOfAccountCode.val(data.bankAccountTemp.chartOfAccountCode);
                                txtBankPaymentBankAccountChartOfAccountName.val(data.bankAccountTemp.chartOfAccountName);
                            }
                            else{
                                alertMessage("Bank Account Not Found!",txtBankPaymentBankAccountCode);
                                txtBankPaymentBankAccountCode.val("");
                                txtBankPaymentBankAccountName.val("");
                                txtBankPaymentBBKVoucherNo.val("");
                                txtBankPaymentBankAccountChartOfAccountCode.val("");
                                txtBankPaymentBankAccountChartOfAccountName.val("");
                            }
                        });
                    });
                    if($("#bankPaymentUpdateMode").val()==="true"){
                        txtBankPaymentBankAccountCode.attr("readonly",true);
                        $("#bankPayment_btnBankAccount").hide();
                        $("#ui-icon-search-bank-account-bank-payment").hide();
                    }else{
                        txtBankPaymentBankAccountCode.attr("readonly",false);
                        $("#bankPayment_btnBankAccount").show();
                        $("#ui-icon-search-bank-account-bank-payment").show();
                    }
                </script>
                <div class="searchbox ui-widget-header">
                <s:textfield id="bankPayment.bankAccount.code" name="bankPayment.bankAccount.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="bankPayment_btnBankAccount" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-bank-account-bank-payment"/></sj:a>
                </div>
                    <s:textfield id="bankPayment.bankAccount.name" name="bankPayment.bankAccount.name" size="40" readonly="true"></s:textfield>
                    <s:textfield id="bankPayment.bankAccount.bbkVoucherNo" name="bankPayment.bankAccount.bbkVoucherNo" size="15" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td/>
            <td colspan="2">
                <s:textfield id="bankPayment.bankAccount.chartOfAccount.code" name="bankPayment.bankAccount.chartOfAccount.code" size="22" readonly="true"></s:textfield>
                <s:textfield id="bankPayment.bankAccount.chartOfAccount.name" name="bankPayment.bankAccount.chartOfAccount.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Type *</B></td>
            <td>
                <s:textfield id="bankPayment.transactionType" name="bankPayment.transactionType" cssStyle="display:none"></s:textfield>
                <s:radio id="bankPaymentTransactionTypeRad" name="bankPaymentTransactionTypeRad" label="type" list="{'Regular','Deposit'}" value='"Regular"'/>
            </td> 
        </tr>
        <tr>
            <td align="right"><B>Currency *</B></td>
            <td colspan="2">
                <script type = "text/javascript">
                    txtBankPaymentCurrencyCode.change(function(ev) {

                        if(txtBankPaymentCurrencyCode.val()===""){
                            txtBankPaymentCurrencyName.val("");
                            txtBankPaymentExchangeRate.val("0.00");
                            txtBankPaymentExchangeRate.attr("readonly",false);
                            return;
                        }

                        var url = "master/currency-get";
                        var params = "currency.code=" + txtBankPaymentCurrencyCode.val();
                            params+= "&currency.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.currencyTemp){
                                txtBankPaymentCurrencyCode.val(data.currencyTemp.code);
                                txtBankPaymentCurrencyName.val(data.currencyTemp.name);
                                bankPaymentValidateCurrencyExchangeRate();
                            }
                            else{
                                alertMessage("Currency Not Found!",txtBankPaymentCurrencyCode);
                                txtBankPaymentCurrencyCode.val("");
                                txtBankPaymentCurrencyName.val("");
                                txtBankPaymentExchangeRate.val("0.00");
                                txtBankPaymentExchangeRate.attr("readonly",false);
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                    <s:textfield id="bankPayment.currency.code" name="bankPayment.currency.code" title=" " size="22"></s:textfield>
                    <sj:a id="bankPayment_btnCurrency" cssClass="bankPayment_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-currency-bank-payment"/></sj:a>
                </div>
                    <s:textfield id="bankPayment.currency.name" name="bankPayment.currency.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Exchange Rate *</B></td>
            <td><s:textfield id="bankPayment.exchangeRate" name="bankPayment.exchangeRate" size="22" style="text-align: right" readonly="true" onchange="bankPaymentCalculateTotalTransactionAmountIDR()"></s:textfield><b>IDR</b> &nbsp;<span class="errMsgNumric" id="errmsgExchangeRate"></span></td>
        </tr>
        <tr>
            <td align="right"><B>Amount *</B></td>
            <td>
            <s:textfield id="bankPayment.totalTransactionAmount" name="bankPayment.totalTransactionAmount" size="22" style="text-align: right" readonly="true" value="0.00"></s:textfield>
                <s:textfield id="bankPayment.totalTransactionAmountIDR" name="bankPayment.totalTransactionAmountIDR" size="22" cssStyle="text-align:right" readonly="true" value="0.00"></s:textfield>(Credit)&nbsp;<span id="errmsgTotalTransactionAmount"></span>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Payment Type *</B></td>
            <td>
                <s:select label="Select Payment Type" 
                    headerValue="Transfer"
                    list="{'Transfer','Giro','Other'}" 
                    name="bankPayment.paymentType" onchange="bankPaymentOnChangePaymentType()" style="width: 115px"/>
            </td>
        </tr>               
            <tr>
                <td align="right" class="labelGiroPaymentCode"><B>Giro Code *</B></td>
                <td class="textLookupGiroPayment">
                    <script type = "text/javascript">
                        txtBankPaymentGiroPaymentNo.change(function(ev) {
                            if(txtBankPaymentGiroPaymentNo.val()===""){
                                txtBankPaymentGiroPaymentNo.val("");
                                txtBankPaymentTransferBankName.val("");
                                txtBankPaymentGiroPaymentDueDate.val("01/01/1900 00:00:00");
                                return;
                            }
                            var url = "master/giro-payment-get-data";
                            var params = "giroPayment.code=" + txtBankPaymentGiroPaymentNo.val();
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.giroPaymentTemp){
                                    txtBankPaymentGiroPaymentNo.val(data.giroPaymentTemp.code);
                                    var giroDate1=data.giroPaymentTemp.dueDate.toString().split('T');
                                    var giroDateValue2=giroDate1[0].split('-');
                                    var giroDate=giroDateValue2[2]+"/"+giroDateValue2[1]+"/"+giroDateValue2[0]+" "+giroDate1[1];
                                    txtBankPaymentGiroPaymentDueDate.val(giroDate);
                                    txtBankPaymentTransferBankName.val(data.giroPaymentTemp.bankName);
                                }
                                else{
                                    alertMessage("Giro Payment Not Found!",txtBankPaymentGiroPaymentNo);
                                    txtBankPaymentGiroPaymentNo.val("");
                                    txtBankPaymentTransferBankName.val("");
                                    txtBankPaymentGiroPaymentDueDate.val("01/01/1900 00:00:00");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="bankPayment.giroPayment.code" name="bankPayment.giroPayment.code" title=" " size="22"></s:textfield>
                        <sj:a id="bankPayment_btnGiroPayment" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right"><label id="labelPaymentRefNo" class="labelPaymentRefNo"/></td>
                <td>
                    <s:textfield id="bankPayment.transferPaymentNo" name="bankPayment.transferPaymentNo" size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><label id="labelPaymentDate" class="labelPaymentDate"/></td>
                <td>
                    <sj:datepicker id="bankPayment.transferPaymentDate" name="bankPayment.transferPaymentDate" size="25" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="bankPaymentTemp.transferPaymentDateTemp" name="bankPaymentTemp.transferPaymentDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><label id="labelPaymentBankName" class="labelPaymentBankName"/></td>
                <td>
                    <s:textfield id="bankPayment.transferBankName" name="bankPayment.transferBankName" size="27"></s:textfield>
                </td>
            </tr>
        <tr>
           <td align="right"><B>To *</B></td>
           <td colspan="2"><s:textfield id="bankPayment.paymentTo" name="bankPayment.paymentTo" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
       </tr>
        <tr>
            <td align="right">Ref No</td>
            <td colspan="3"><s:textfield id="bankPayment.refNo" name="bankPayment.refNo" size="27"></s:textfield></td>
        </tr>
        <tr>
            <td align="right" valign="top">Remark</td>
            <td colspan="3"><s:textarea id="bankPayment.remark" name="bankPayment.remark"  cols="72" rows="2" height="20"></s:textarea></td>
        </tr> 
        <tr hidden="true">
            <td>
                <s:textfield id="bankPayment.createdBy" name="bankPayment.createdBy" key="bankPayment.createdBy" readonly="true" size="22"></s:textfield>
                <sj:datepicker id="bankPayment.createdDate" name="bankPayment.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                <s:textfield id="bankPaymentTemp.createdDateTemp" name="bankPaymentTemp.createdDateTemp" size="20"></s:textfield>
                <s:textfield id="bankPaymentDetailCOAPurchaseDownPaymentCode" name="bankPaymentDetailCOAPurchaseDownPaymentCode" size="20"></s:textfield>
                <s:textfield id="bankPaymentDetailCOAPurchaseDownPaymentName" name="bankPaymentDetailCOAPurchaseDownPaymentName" size="20"></s:textfield>
            </td>
        </tr>
    </table>
</s:form>
<table>
    <tr>
        <td align="right">
            <sj:a href="#" id="btnConfirmBankPayment" button="true">Confirm</sj:a>
            <sj:a href="#" id="btnUnConfirmBankPayment" button="true">UnConfirm</sj:a>
        </td>
    </tr>
</table>
             
    <table width="20%">
        <tr>
            <td>
                <sj:a href="#" id="btnBankPaymentAddDetail" button="true" style="width: 90%">Payment Request</sj:a> 
            </td>
        </tr>
    </table>       
    <div id="bankPaymentPaymentRequestInputGrid">
        <sjg:grid
            id="bankPaymentPaymentRequestInput_grid"
            dataType="local"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankPaymentPaymentRequestTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubankpayment').width()"
            editinline="true"
            editurl="%{remoteurlBankPaymentDetailDocumentInput}"
            onSelectRowTopics="bankPaymentDetailDocumentInput_grid_onSelect"
        >
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDelete" index="bankPaymentPaymentRequestDelete" title="" width="50" align="centre"
                editable="true"
                edittype="button"
                editoptions="{onClick:'bankPaymentPaymentRequestInputGrid_Delete_OnClick()', value:'delete'}"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestCodeTemp" index="bankPaymentPaymentRequestCodeTemp" key="bankPaymentPaymentRequestCodeTemp" 
                title="code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestBranchCode" index="bankPaymentPaymentRequestBranchCode" key="bankPaymentPaymentRequestBranchCode" 
                title="Branch" width="80" sortable="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestCode" index="bankPaymentPaymentRequestCode" key="bankPaymentPaymentRequestCode" 
                title="PYM-RQ NO" width="160" sortable="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestTransactionDate" index="bankPaymentPaymentRequestTransactionDate" key="bankPaymentPaymentRequestTransactionDate" 
                formatter="date" formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}" title="Transaction Date" width="150" sortable="true"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestCurrencyCode" index = "bankPaymentPaymentRequestCurrencyCode" key = "bankPaymentPaymentRequestCurrencyCode" 
                title = "Currency" width = "60" 
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestTotalTransactionAmount" index = "bankPaymentPaymentRequestTotalTransactionAmount" key = "bankPaymentPaymentRequestTotalTransactionAmount" 
                title = "Total Transaction" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestTransactionType" index = "bankPaymentPaymentRequestTransactionType" key = "bankPaymentPaymentRequestTransactionType" 
                title = "Type" width = "100"
            />            
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestRefNo" index="bankPaymentPaymentRequestRefNo" key="bankPaymentPaymentRequestRefNo" 
                title="Ref No" width="50" 
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestRemark" index="bankPaymentPaymentRequestRemark" key="bankPaymentPaymentRequestRemark" 
                title="Remark" width="50" 
            />
        </sjg:grid >                
    </div>
    <br class="spacer" />
    <br class="spacer" />
    <div id="bankPaymentPaymentRequestDetailInputGrid">
        <sjg:grid
            id="bankPaymentPaymentRequestDetailInput_grid"
            dataType="local"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankPaymentTemp"
            rowList="10,20,30"
            rowNum="10"
            editinline="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubankpayment').width()"
            onSelectRowTopics="bankPaymentPaymentRequestDetailDocumentInput_grid_onSelect"
        >
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailCode" index="bankPaymentPaymentRequestDetailCode" key="bankPaymentPaymentRequestDetailCode" 
                title="code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailHeaderCode" index="bankPaymentPaymentRequestDetailHeaderCode" key="bankPaymentPaymentRequestDetailHeaderCode" 
                title="header code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailBranchCode" index="bankPaymentPaymentRequestDetailBranchCode" key="bankPaymentPaymentRequestDetailBranchCode" 
                title="branch code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailDocumentNo" index="bankPaymentPaymentRequestDetailDocumentNo" key="bankPaymentPaymentRequestDetailDocumentNo" 
                title="Document No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailDocumentType" index="bankPaymentPaymentRequestDetailDocumentType" key="bankPaymentPaymentRequestDetailDocumentType" 
                title="Document Type" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailDocumentBranchCode" index="bankPaymentPaymentRequestDetailDocumentBranchCode" key="bankPaymentPaymentRequestDetailDocumentBranchCode" 
                title="Document Branch Code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailTransactionStatus" index="bankPaymentPaymentRequestDetailTransactionStatus" key="bankPaymentPaymentRequestDetailTransactionStatus" 
                title="Transaction Status" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailChartOfAccountCode" index="bankPaymentPaymentRequestDetailChartOfAccountCode" key="bankPaymentPaymentRequestDetailChartOfAccountCode" 
                title="Chart Of Account Code" width="120" sortable="true"
            />
            <sjg:gridColumn
                name="bankPaymentPaymentRequestDetailChartOfAccountName" index="bankPaymentPaymentRequestDetailChartOfAccountName" key="bankPaymentPaymentRequestDetailChartOfAccountName" 
                title="Chart Of Account Name" width="120" sortable="true"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailCurrencyCode" index = "bankPaymentPaymentRequestDetailCurrencyCode" key = "bankPaymentPaymentRequestDetailCurrencyCode" 
                title = "Currency" width = "60" 
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailExchangeRate" index = "bankPaymentPaymentRequestDetailExchangeRate" key = "bankPaymentPaymentRequestDetailExchangeRate" 
                title = "Exchange Rate" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailTotalTransactionAmount" index = "bankPaymentPaymentRequestDetailTotalTransactionAmount" key = "bankPaymentPaymentRequestDetailTotalTransactionAmount" 
                title = "Amount (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailTotalTransactionAmountIDR" index = "bankPaymentPaymentRequestDetailTotalTransactionAmountIDR" key = "bankPaymentPaymentRequestDetailTotalTransactionAmountIDR" 
                title = "Amount (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailBalanceAmount" index = "bankPaymentPaymentRequestDetailBalanceAmount" key = "bankPaymentPaymentRequestDetailBalanceAmount" 
                title = "Balance (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailBalanceAmountIDR" index = "bankPaymentPaymentRequestDetailBalanceAmountIDR" key = "bankPaymentPaymentRequestDetailBalanceAmountIDR" 
                title = "Balance (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailDebitAmount" index = "bankPaymentPaymentRequestDetailDebitAmount" key = "bankPaymentPaymentRequestDetailDebitAmount" 
                title = "Debit (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailDebitAmountIDR" index = "bankPaymentPaymentRequestDetailDebitAmountIDR" key = "bankPaymentPaymentRequestDetailDebitAmountIDR" 
                title = "Debit (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailCreditAmount" index = "bankPaymentPaymentRequestDetailCreditAmount" key = "bankPaymentPaymentRequestDetailCreditAmount" 
                title = "Credit (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailCreditAmountIDR" index = "bankPaymentPaymentRequestDetailCreditAmountIDR" key = "bankPaymentPaymentRequestDetailCreditAmountIDR" 
                title = "Credit (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankPaymentPaymentRequestDetailRemark" index="bankPaymentPaymentRequestDetailRemark" key="bankPaymentPaymentRequestDetailRemark" 
                title="Remark" width="225"
            />
        </sjg:grid >                
    </div>
    <table width="100%">
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td width="10px">
                            <sj:a href="#" id="btnBankPaymentSave" button="true" style="width: 60px">Save</sj:a>
                        </td>
                        <td>
                            <sj:a href="#" id="btnBankPaymentCancel" button="true" style="width: 60px">Cancel</sj:a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="50%"></td>
            <td height="10px" align="middle" colspan="4">
                <sj:a href="#" id="btnBankPaymentCalculate" button="true" style="width: 80px">Calculate</sj:a>
            </td>
        </tr>
        <tr>
            <td/>
            <td>
                <table width="100%">
                    <tr>
                        <td/><td/>
                        <td height="10px" align="right" colspan="2">
                            <lable><B><u>Transaction Summary</u></B></lable>
                        </td>
                        <td width="25%"/>
                    </tr>
                    <tr>
                        <td width="22%"/>
                        <td height="10px" align="left" ><label>Foreign</label></td>
                        <td height="10px" align="left" ><label>Local</label></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Total(Debit)</td>
                        <td><s:textfield id="bankPaymentTotalDebitForeign" name="bankPaymentTotalDebitForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="bankPaymentTotalDebitIDR" name="bankPaymentTotalDebitIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Total(Credit)</td>
                        <td><s:textfield id="bankPaymentTotalCreditForeign" name="bankPaymentTotalCreditForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="bankPaymentTotalCreditIDR" name="bankPaymentTotalCreditIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Balance</td>
                        <td><s:textfield id="bankPaymentTotalBalanceForeign" name="bankPaymentTotalBalanceForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="bankPaymentTotalBalanceIDR" name="bankPaymentTotalBalanceIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td/><td/>
                        <td height="10px" align="right" colspan="2"><lable><B><u>Forex Gain / Loss</u></B></lable></td>
                        <td width="25%"/>
                    </tr>
                    <tr>
                        <td style="text-align: right">Amount</td>
                        <td colspan="2"><s:textfield id="bankPaymentForexAmount" name="bankPaymentForexAmount" readonly="true" cssStyle="text-align:right" size="25" PlaceHolder="0.00"></s:textfield><B>IDR</B></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>