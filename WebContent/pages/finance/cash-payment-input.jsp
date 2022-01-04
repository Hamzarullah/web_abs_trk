
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #cashPaymentDetailDocumentInput_grid_pager_center{
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
    
    var cashPaymentDetaillastRowId=0,cashPaymentSubDetaillastRowId=0,cashPaymentDetail_lastSel = -1,cashPaymentSubDetail_lastSel=-1,selectedRowId=0;
    var cashPaymentFlagConfirmed=false;
    var 
        txtCashPaymentCode = $("#cashPayment\\.code"),
        dtpCashPaymentTransactionDate = $("#cashPayment\\.transactionDate"),
        txtCashPaymentBranchCode = $("#cashPayment\\.branch\\.code"),
        txtCashPaymentBranchName = $("#cashPayment\\.branch\\.name"),
        txtCashPaymentCashAccountCode=$("#cashPayment\\.cashAccount\\.code"),
        txtCashPaymentCashAccountName=$("#cashPayment\\.cashAccount\\.name"),
        txtCashPaymentBBKVoucherNo=$("#cashPayment\\.cashAccount\\.bbkVoucherNo"),
        txtCashPaymentCashAccountChartOfAccountCode=$("#cashPayment\\.cashAccount\\.chartOfAccount\\.code"),
        txtCashPaymentCashAccountChartOfAccountName=$("#cashPayment\\.cashAccount\\.chartOfAccount\\.name"),
        
        txtCashPaymentVendorDepositTypeCode=$("#cashPayment\\.vendorDepositType\\.code"),
        txtCashPaymentVendorDepositTypeName=$("#cashPayment\\.vendorDepositType\\.name"),
        txtCashPaymentVendorDepositTypeChartOfAccountCode=$("#cashPayment\\.vendorDepositType\\.chartOfAccountCode"),
        txtCashPaymentVendorDepositTypeChartOfAccountName=$("#cashPayment\\.vendorDepositType\\.chartOfAccountName"),
        
        txtCashPaymentTransactionType = $("#cashPayment\\.transactionType"),
        txtCashPaymentPaymentTo = $("#cashPayment\\.paymentTo"),
        txtCashPaymentCurrencyCode = $("#cashPayment\\.currency\\.code"),
        txtCashPaymentCurrencyName = $("#cashPayment\\.currency\\.name"),
        txtCashPaymentExchangeRate = $("#cashPayment\\.exchangeRate"),
        txtCashPaymentTotalTransactionAmountForeign = $("#cashPayment\\.totalTransactionAmount"),
        txtCashPaymentTotalTransactionAmountIDR = $("#cashPayment\\.totalTransactionAmountIDR"),
        txtCashPaymentRefNo = $("#cashPayment\\.refNo"),
        txtCashPaymentRemark = $("#cashPayment\\.remark"),
        dtpCashPaymentCreatedDate = $("#cashPayment\\.createdDate"),
        
        txtCashPaymentCurrencyCodeSession=$("#cashPaymentCurrencyCodeSession"),
        txtCashPaymentTotalBalanceIDR = $("#cashPaymentTotalBalanceIDR"),
                
        txtCashPaymentTotalDebitForeign = $("#cashPaymentTotalDebitForeign"),
        txtCashPaymentTotalDebitIDR = $("#cashPaymentTotalDebitIDR"),
        txtCashPaymentTotalCreditForeign = $("#cashPaymentTotalCreditForeign"),
        txtCashPaymentTotalCreditIDR = $("#cashPaymentTotalCreditIDR"),
        txtCashPaymentTotalBalanceForeign = $("#cashPaymentTotalBalanceForeign"),
        
        txtCashPaymentForexAmount = $("#cashPaymentForexAmount"),
        
        allCashPaymentFields = $([])
            .add(txtCashPaymentCode)
            .add(txtCashPaymentCurrencyCode)
            .add(txtCashPaymentCurrencyName)
            .add(txtCashPaymentExchangeRate)
            .add(txtCashPaymentRefNo)
            .add(txtCashPaymentRemark)
            .add(txtCashPaymentTotalTransactionAmountForeign)
            .add(txtCashPaymentTotalTransactionAmountIDR)
            .add(txtCashPaymentTotalDebitForeign)
            .add(txtCashPaymentTotalDebitIDR)
            .add(txtCashPaymentTotalCreditForeign)
            .add(txtCashPaymentTotalCreditIDR)
            .add(txtCashPaymentTotalBalanceForeign)
            .add(txtCashPaymentTotalBalanceIDR)
            .add(txtCashPaymentForexAmount)
            .add(txtCashPaymentTotalTransactionAmountIDR);

       
    $(document).ready(function() {

        cashPaymentFlagConfirmed=false;
        cashPaymentValidateCurrencyExchangeRate();
        cashPaymentOnChangeTransactionType();
        cashPaymentFormatNumeric2();
        
        $("#btnUnConfirmCashPayment").css("display", "none");
        $("#btnCashPaymentAddDetail").css("display", "none");
        $('#cashPaymentPaymentRequestInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#cashPaymentPaymentRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $.subscribe("cashPaymentDetailDocumentInput_grid_onSelect", function() {
            var selectedRowID = $("#cashPaymentPaymentRequestInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==cashPaymentDetail_lastSel) {

                $('#cashPaymentPaymentRequestInput_grid').jqGrid("saveRow",cashPaymentDetail_lastSel); 
                $('#cashPaymentPaymentRequestInput_grid').jqGrid("editRow",selectedRowID,true);            

                cashPaymentDetail_lastSel=selectedRowID;

            }else{
                $('#cashPaymentPaymentRequestInput_grid').jqGrid("saveRow",selectedRowID);
            }

        });
        
         $.subscribe("cashPaymentPaymentRequestDetailDocumentInput_grid_onSelect", function() {
            var selectedRowID = $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==cashPaymentSubDetail_lastSel) {

                $('#cashPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",cashPaymentSubDetail_lastSel); 
                $('#cashPaymentPaymentRequestDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                cashPaymentSubDetail_lastSel=selectedRowID;

            }else{
                $('#cashPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }

        });
        
        $('input[name="cashPaymentTransactionTypeRad"][value="Regular"]').change(function(ev){
            var value="REGULAR";
            $("#cashPayment\\.transactionType").val(value);
            
            $('#cashPayment\\.vendorDepositType\\.code').attr('readonly',true);
            $('#cashPayment_btnVendorDepositType').hide();
            $('#cashPayment\\.vendorDepositType\\.code').val("");
            $('#cashPayment\\.vendorDepositType\\.chartOfAccountCode').val("");
            $('#cashPayment\\.vendorDepositType\\.chartOfAccountName').val("");
            $('#cashPayment\\.vendorDepositType\\.name').val("");
        });
                
        $('input[name="cashPaymentTransactionTypeRad"][value="Deposit"]').change(function(ev){
            var value="DEPOSIT";
            $("#cashPayment\\.transactionType").val(value);
            
            $('#cashPayment\\.vendorDepositType\\.code').attr('readonly',false);
            $('#cashPayment_btnVendorDepositType').show();
        });
        
        if($("#cashPaymentUpdateMode").val()==="true"){
            $('#cashPaymentTransactionTypeRadRegular').attr('disabled',true);
            $('#cashPaymentTransactionTypeRadDeposit').attr('disabled',true);
        }
        
        $("#cashPayment\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#cashPayment\\.exchangeRate").change(function(e){
            var exrate=$("#cashPayment\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#cashPayment\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
           
        $('#btnCashPaymentSave').click(function(ev) {
            
            if(cashPaymentFlagConfirmed===false){
                alertMessage("Please Confirm!",$("#btnConfirmCashPayment"));
                return;
            }
            
            $("#btnCashPaymentCalculate").trigger("click");
            
                if(cashPaymentDetail_lastSel !== -1) {
                    $('#cashPaymentPaymentRequestInput_grid').jqGrid("saveRow",cashPaymentDetail_lastSel); 
                }
            
                if(cashPaymentSubDetail_lastSel !== -1) {
                    $('#cashPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",cashPaymentSubDetail_lastSel); 
                }

                var ids = jQuery("#cashPaymentPaymentRequestInput_grid").jqGrid('getDataIDs'); 
                var idsSub = jQuery("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('getDataIDs'); 
                var totalBalanceForeign = parseFloat(removeCommas(txtCashPaymentTotalBalanceForeign.val()));
                var totalBalanceIDR = parseFloat(removeCommas(txtCashPaymentTotalBalanceIDR.val()));
                var headerCurrency = txtCashPaymentCurrencyCode.val();
                
                // cek isi detail
                if(ids.length===0){
                    alertMessage("Grid Cash Payment Detail Is Not Empty");
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
                
                var listCashPaymentPaymentRequestDetail = new Array(); 
                                
                for(var i=0;i < idsSub.length;i++){ 
                    var data = $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('getRowData',idsSub[i]); 
                    
                    var debitValue=parseFloat(data.cashPaymentDetailDocumentDebitForeign);
                    var creditValue=parseFloat(data.cashPaymentDetailDocumentCreditForeign);
                    var departmentCode = data.cashPaymentPaymentRequestDetailDepartmentCode;
                    
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
                    
                    //validate department wajib diisi
                    if(departmentCode === ""){
                        alertMessage("Department Code Must Be Filled!");
                        return; 
                    }
                    
                    var cashPaymentPaymentRequestDetail = { 
                        branch                 : {code:data.cashPaymentPaymentRequestDetailBranchCode},
                        paymentRequest         : {code:data.cashPaymentPaymentRequestDetailHeaderCode},
                        documentNo             : data.cashPaymentPaymentRequestDetailDocumentNo,
                        documentType           : data.cashPaymentPaymentRequestDetailDocumentType,
                        documentBranchCode     : data.cashPaymentPaymentRequestDetailDocumentBranchCode,
                        currency               : {code:data.cashPaymentPaymentRequestDetailCurrencyCode},
                        exchangeRate           : data.cashPaymentPaymentRequestDetailExchangeRate,
                        transactionStatus      : data.cashPaymentPaymentRequestDetailTransactionStatus,
                        chartOfAccount         : {code:data.cashPaymentPaymentRequestDetailChartOfAccountCode},
                        department             : {code:data.cashPaymentPaymentRequestDetailDepartmentCode},
                        credit                 : data.cashPaymentPaymentRequestDetailCreditAmount,
                        creditIDR              : data.cashPaymentPaymentRequestDetailCreditAmountIDR,
                        debit                  : data.cashPaymentPaymentRequestDetailDebitAmount,
                        debitIDR               : data.cashPaymentPaymentRequestDetailDebitAmountIDR,
                        remark                 : data.cashPaymentPaymentRequestDetailRemark
                    };

                    listCashPaymentPaymentRequestDetail[i] = cashPaymentPaymentRequestDetail;
                }
                
                cashPaymentFormatDate();
                cashPaymentUnFormatNumeric();
                var forexAmount=txtCashPaymentForexAmount.val();
                 
                var url = "finance/cash-payment-save";
                var params = $("#frmCashPaymentInput").serialize();
                    params += "&listCashPaymentDetailJSON=" + $.toJSON(listCashPaymentPaymentRequestDetail);
                    params += "&forexAmount=" + forexAmount;
                
                showLoading();
//                alert(params);
//                return;
                $.post(url, params, function(data) {
                    closeLoading();
                    if (data.error) {
                        cashPaymentFormatDate();
                        cashPaymentFormatNumeric();
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
                                    var url = "finance/cash-payment-input";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuCASH_PAYMENT");
                                }
                            },
                            {
                                text : "No",
                                click : function() {
                                    $(this).dialog("close");
                                    var url = "finance/cash-payment";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuCASH_PAYMENT");
                                }
                            }]
                    });
                });
        });

        $("#btnConfirmCashPayment").click(function(ev) {
            cash_payment_handlers_input();
            
            if(!$("#frmCashPaymentInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            if($("#cashPayment\\.transactionType").val() === "DEPOSIT" || $("#cashPayment\\.transactionType").val() === "Deposit"){
                if($("#cashPayment\\.vendorDepositType\\.chartOfAccountCode").val() === ""){
                    alertMessage("Please Set Vendor Deposit Type - Branch Chart Of Account");
                    return;
                }
            }
            
            if(parseFloat(removeCommas(txtCashPaymentExchangeRate.val()))<=0){
                alertMessage("Invalid Exchange Rate Value!",txtCashPaymentExchangeRate);
                return;
            }
            
            var date1 = dtpCashPaymentTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#cashPaymentTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#cashPaymentUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#cashPaymentTransactionDate").val(),dtpCashPaymentTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpCashPaymentTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#cashPaymentUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#cashPaymentTransactionDate").val(),dtpCashPaymentTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpCashPaymentTransactionDate);
                }
                return;
            }
            
            if($("#cashPaymentUpdateMode").val()==="true"){
                cashPaymentPaymentRequestData();
                cashPaymentLoadDataDetail();
            }
            
//            var date = $("#cashPayment\\.transactionDate").val().split("/");
//            var month = date[1];
//            var year = date[2].split(" ");
//            if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
//                alertMessage("Transaction Month Must Between Session Period Month!",dtpCashPaymentTransactionDate);
//                return;
//            }
//
//            if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
//                alertMessage("Transaction Year Must Between Session Period Year!",dtpCashPaymentTransactionDate);
//                return;
//            }    
                        
            cashPaymentFlagConfirmed=true;
            $("#btnUnConfirmCashPayment").css("display", "block");
            $("#btnConfirmCashPayment").css("display", "none");
            $("#btnCashPaymentAddDetail").css("display", "block");
            $('#headerInputCashPayment').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#cashPaymentPaymentRequestInputGrid').unblock();
            $('#cashPaymentPaymentRequestDetailInputGrid').unblock();
            
        });
        
        $("#btnUnConfirmCashPayment").click(function(ev) {
            
            var rows = jQuery("#cashPaymentPaymentRequestInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                cashPaymentFlagConfirmed=false;        
                $("#btnUnConfirmCashPayment").css("display", "none");
                $("#btnConfirmCashPayment").css("display", "block");
                $("#btnCashPaymentAddDetail").css("display", "none");
                $('#headerInputCashPayment').unblock();
                $('#cashPaymentPaymentRequestInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#cashPaymentPaymentRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                            cashPaymentFlagConfirmed=false;
                            $("#cashPaymentPaymentRequestInput_grid").jqGrid('clearGridData');
                            $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmCashPayment").css("display", "none");
                            $("#btnConfirmCashPayment").css("display", "block");
                            $("#btnCashPaymentAddDetail").css("display", "none");
                            $('#headerInputCashPayment').unblock();
                            $('#cashPaymentPaymentRequestInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                            $('#cashPaymentPaymentRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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

        $('#btnCashPaymentAddDetail').click(function(ev) {

            if(!cashPaymentFlagConfirmed){
                alertMessage("Please Confirm!",$("#btnConfirmCashPayment"));
                return;
            }
            
            var ids = jQuery("#cashPaymentPaymentRequestInput_grid").jqGrid('getDataIDs');
            var vendorDepositCode = txtCashPaymentVendorDepositTypeCode.val();
            window.open("./pages/search/search-payment-request-by-cash-payment.jsp?iddoc=cashPaymentPaymentRequest&rowLast="+ids.length+"&type=grid&idtransaction="+txtCashPaymentTransactionType.val()+"&vendorDepositCode="+vendorDepositCode,"Search", "Scrollbars=1,width=600, height=500");
        });
    
        $('#btnCashPaymentCancel').click(function(ev) {
            var url = "finance/cash-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuCASH_PAYMENT"); 

        });
        
        $('#cashPayment_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=cashPayment&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#cashPayment_btnCashAccount').click(function(ev) {
            window.open("./pages/search/search-cash-account.jsp?iddoc=cashPayment&idsubdoc=cashAccount","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#cashPayment_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=cashPayment&idsubdoc=currency","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#btnCashPaymentCalculate').click(function(ev) {

            if(cashPaymentDetail_lastSel !== -1) {
                $('#cashPaymentPaymentRequestInput_grid').jqGrid("saveRow",cashPaymentDetail_lastSel); 
            }

            if(cashPaymentSubDetail_lastSel !== -1) {
                $('#cashPaymentPaymentRequestDetailInput_grid').jqGrid("saveRow",cashPaymentSubDetail_lastSel); 
            }

            var idsSub = jQuery("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('getDataIDs'); 
            var exchangeRate=$("#cashPayment\\.exchangeRate").val().replace(/,/g,"");

            var DebitForeign = 0;
            var DebitIDR = 0;

            var CreditForeign = $("#cashPayment\\.totalTransactionAmount").val().replace(/,/g,"");
            var CreditIDR = (parseFloat(CreditForeign)* parseFloat(exchangeRate));

            var BalanceForeign = 0;
            var BalanceIDR = 0;

            var nilaiForexHeader = 0;

            CreditForeign = parseFloat(CreditForeign);
            CreditIDR = parseFloat(CreditIDR);

            for(var i=0;i < idsSub.length;i++){ 
                var data = $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('getRowData',idsSub[i]); 

                var documentDebitForeign = data.cashPaymentPaymentRequestDetailDebitAmount;
                var documentDebitIDR = data.cashPaymentPaymentRequestDetailDebitAmountIDR;
                var documentCreditForeign = data.cashPaymentPaymentRequestDetailCreditAmount;
                var documentCreditIDR = data.cashPaymentPaymentRequestDetailCreditAmountIDR;

                var headerRate = txtCashPaymentExchangeRate.val().replace(/,/g,"");
                var headerCurrency = txtCashPaymentCurrencyCode.val();

                var documentRate = data.cashPaymentPaymentRequestDetailExchangeRate;
                var documentCurrency = data.cashPaymentPaymentRequestDetailCurrencyCode;

//                var documentDebitIDR = documentDebitForeign * documentRate;
//                $("#cashPaymentDetailDocumentInput_grid").jqGrid("setCell", idsSub[i],"cashPaymentDetailDocumentDebitIDR",documentDebitIDR);
//
//                var documentCreditIDR = documentCreditForeign * documentRate;
//                $("#cashPaymentDetailDocumentInput_grid").jqGrid("setCell", idsSub[i],"cashPaymentDetailDocumentCreditIDR",documentCreditIDR);

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
            txtCashPaymentTotalDebitForeign.val(formatNumber(parseFloat(DebitForeign),2));
            txtCashPaymentTotalDebitIDR.val(formatNumber(parseFloat(DebitIDR),2));


//            var splitCreditForeign=CreditForeign.split('.');
//            var CreditForeignFormat;
//            if(splitCreditForeign[0].length>3){
//                var concatCreditForeign=parseFloat(splitCreditForeign[0]+'.'+splitCreditForeign[1]);
//                CreditForeignFormat=formatNumber(concatCreditForeign,2);
//            }else{
//                CreditForeignFormat=splitCreditForeign[0]+'.'+splitCreditForeign[1];
//            }
            txtCashPaymentTotalCreditForeign.val(formatNumber(parseFloat(CreditForeign),2));
            txtCashPaymentTotalCreditIDR.val(formatNumber(parseFloat(CreditIDR),2));

            BalanceForeign = (DebitForeign - CreditForeign).toFixed(2);
            BalanceIDR = DebitIDR - CreditIDR;


//            var splitBalanceForeign=BalanceForeign.split('.');
//            var BalanceForeignFormat;
//            if(splitBalanceForeign[0].length>3){
//                var concatBalanceForeign=parseFloat(splitBalanceForeign[0]+'.'+splitBalanceForeign[1]);
//                BalanceForeignFormat=formatNumber(concatBalanceForeign,2);
//            }else{
//                BalanceForeignFormat=splitBalanceForeign[0]+'.'+splitBalanceForeign[1];
//            }
            txtCashPaymentTotalBalanceForeign.val(formatNumber(parseFloat(BalanceForeign),2));
            txtCashPaymentTotalBalanceIDR.val(formatNumber(parseFloat(BalanceIDR.toFixed(2)),2));

            txtCashPaymentForexAmount.val(formatNumber(nilaiForexHeader,2));
        });
    });//EOF Ready
    //ok
    function cashPaymentTransactionDateOnChange(){
        if($("#cashPaymentUpdateMode").val()!=="true"){
            $("#cashPaymentTransactionDate").val(dtpCashPaymentTransactionDate.val());
        }
    }
    //ok
    function setCashPaymentTransactionType(){
        switch($("#cashPayment\\.transactionType").val()){
            case "Regular":
                $('input[name="cashPaymentTransactionTypeRad"][value="Regular"]').prop('checked',true);
                $('#cashPaymentTransactionTypeRadDown\\ Payment').attr('disabled', true);
                break;
            case "Down Payment":
                $('input[name="cashPaymentTransactionTypeRad"][value="Down Payment"]').prop('checked',true);
                $('#cashPaymentTransactionTypeRadRegular').attr('disabled', true);
                break;
        }
//        var modeUpdate=$("#cashPaymentUpdateMode").val();
//        switch(modeUpdate){
//            case "true":
//                switch($("#cashPayment\\.transactionType").val()){
//                    case "Regular":
//                        $('input[name="cashPaymentTransactionTypeRad"][value="Regular"]').prop('checked',true);
//                        $('#cashPaymentTransactionTypeRadDown\\ Payment').attr('disabled', true);
//                        break;
//                    case "Down Payment":
//                        $('input[name="cashPaymentTransactionTypeRad"][value="Down Payment"]').prop('checked',true);
//                        $('#cashPaymentTransactionTypeRadRegular').attr('disabled', true);
//                        break;
//                } 
//            break;
//        }
    }
    //ok
    function cashPaymentFormatNumeric2(){
        var exchangerateHeaderFormat =parseFloat(txtCashPaymentExchangeRate.val());
        txtCashPaymentExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));
        
        var totalTransactionAmountFormat =parseFloat(txtCashPaymentTotalTransactionAmountForeign.val());
        txtCashPaymentTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));
        
        var totalTransactionAmountIDRFormat =parseFloat(txtCashPaymentTotalTransactionAmountIDR.val());
        txtCashPaymentTotalTransactionAmountIDR.val(formatNumber(totalTransactionAmountIDRFormat,2));
                        
    }
    //ok
    function cashPaymentFormatDate(){
        var transactionDate=$("#cashPayment\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpCashPaymentTransactionDate.val(transactionDateValue);
        $("#cashPaymentTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var createdDate=$("#cashPayment\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpCashPaymentCreatedDate.val(createdDateValue);
        $("#cashPaymentTemp\\.createdDateTemp").val(createdDateValue);
    }
    //ok
    function cashPaymentFormatNumeric(){
        var exchangerateHeaderFormat =parseFloat(txtCashPaymentExchangeRate.val()) ;
        txtCashPaymentExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));

        var totalTransactionAmountFormat =parseFloat(txtCashPaymentTotalTransactionAmountForeign.val()) ;
        txtCashPaymentTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));

        var totalTransactionAmountIDRFormat = parseFloat(txtCashPaymentTotalTransactionAmountIDR.val());
        txtCashPaymentTotalTransactionAmountIDR.val(formatNumber(totalTransactionAmountIDRFormat,2));

        var totalBalanceForeign=parseFloat(txtCashPaymentTotalBalanceForeign.val());
        txtCashPaymentTotalBalanceForeign.val(formatNumber(totalBalanceForeign,2));

        var totalBalanceIDR=parseFloat(txtCashPaymentTotalBalanceIDR.val());
        txtCashPaymentTotalBalanceIDR.val(formatNumber(totalBalanceIDR,2));

        var totalDebitForeign=parseFloat(txtCashPaymentTotalDebitForeign.val());
        txtCashPaymentTotalDebitForeign.val(formatNumber(totalDebitForeign,2));

        var totalDebitIDR=parseFloat(txtCashPaymentTotalDebitIDR.val());
        txtCashPaymentTotalDebitIDR.val(formatNumber(totalDebitIDR,2));

        var totalCreditForeign=parseFloat(txtCashPaymentTotalCreditForeign.val());
        txtCashPaymentTotalCreditForeign.val(formatNumber(totalCreditForeign,2));

        var totalCreditIDR=parseFloat(txtCashPaymentTotalCreditIDR.val());
        txtCashPaymentTotalCreditIDR.val(formatNumber(totalCreditIDR,2));

        var forexAmount= parseFloat(txtCashPaymentForexAmount.val());
        txtCashPaymentForexAmount.val(formatNumber(forexAmount,2));
    }
    //ok
    function cashPaymentUnFormatNumeric(){
        var exchangerateHeaderFormat = txtCashPaymentExchangeRate.val().replace(/,/g, "");
        txtCashPaymentExchangeRate.val(exchangerateHeaderFormat);

        var totalTransactionAmountFormat = txtCashPaymentTotalTransactionAmountForeign.val().replace(/,/g, "");
        txtCashPaymentTotalTransactionAmountForeign.val(totalTransactionAmountFormat);

        var totalTransactionAmountIDRFormat = txtCashPaymentTotalTransactionAmountIDR.val().replace(/,/g, "");
        txtCashPaymentTotalTransactionAmountIDR.val(totalTransactionAmountIDRFormat);

        var totalBalanceForeign=txtCashPaymentTotalBalanceForeign.val().replace(/,/g, "");
        txtCashPaymentTotalBalanceForeign.val(totalBalanceForeign);

        var totalBalanceIDR=txtCashPaymentTotalBalanceIDR.val().replace(/,/g, "");
        txtCashPaymentTotalBalanceIDR.val(totalBalanceIDR);

        var totalDebitForeign=txtCashPaymentTotalDebitForeign.val().replace(/,/g, "");
        txtCashPaymentTotalDebitForeign.val(totalDebitForeign);

        var totalDebitIDR=txtCashPaymentTotalDebitIDR.val().replace(/,/g, "");
        txtCashPaymentTotalDebitIDR.val(totalDebitIDR);

        var totalCreditForeign=txtCashPaymentTotalCreditForeign.val().replace(/,/g, "");
        txtCashPaymentTotalCreditForeign.val(totalCreditForeign);

        var totalCreditIDR=txtCashPaymentTotalCreditIDR.val().replace(/,/g, "");
        txtCashPaymentTotalCreditIDR.val(totalCreditIDR);

        var forexAmount= txtCashPaymentForexAmount.val().replace(/,/g, "");
        txtCashPaymentForexAmount.val(forexAmount);
    }
    //ok
    function cashPaymentCalculateTotalTransactionAmountForeign(){
        var totalTransactionAmount = 0;
            var ids = jQuery("#cashPaymentPaymentRequestInput_grid").jqGrid('getDataIDs');
            for(var i=0; i<ids.length; i++){
                var data= $("#cashPaymentPaymentRequestInput_grid").jqGrid('getRowData',ids[i]);
                totalTransactionAmount = totalTransactionAmount + parseFloat(data.cashPaymentPaymentRequestTotalTransactionAmount);
            }
            $("#cashPayment\\.totalTransactionAmount").val(formatNumber(totalTransactionAmount,2));
            cashPaymentCalculateTotalTransactionAmountIDR();
    }
    //ok
    function cashPaymentCalculateTotalTransactionAmountIDR(){
        cashPaymentValidateCurrencyExchangeRate();
        var totalTransactionAmount=parseFloat(removeCommas(txtCashPaymentTotalTransactionAmountForeign.val()));
        var exchangeRate=parseFloat(removeCommas(txtCashPaymentExchangeRate.val()));
        if(txtCashPaymentExchangeRate.val()===""){
            exchangeRate=0;
        }
        if(txtCashPaymentTotalTransactionAmountForeign.val()===""){
            totalTransactionAmount=0;
        }
        var totalTransactionAmountIDR=(totalTransactionAmount* exchangeRate);
        $("#cashPayment\\.totalTransactionAmountIDR").val(formatNumber(totalTransactionAmountIDR,2));
    }
    //ok
    function cashPaymentCalculateBalance(){
        var amountForeign=0;
        var amountIDR=0;
        var ids = jQuery("#cashPaymentDetailDocumentInput_grid").jqGrid('getDataIDs');
           
        for(var i=0;i < ids.length;i++) {
            var data = $("#cashPaymentDetailDocumentInput_grid").jqGrid('getRowData',ids[i]);
            amountForeign +=parseFloat(data.cashPaymentDetailDocumentAmountForeignTemp);
            amountIDR +=parseFloat(data.cashPaymentDetailDocumentAmountIDRTemp);
        }        
        var sumAmountForeign=0- amountForeign;
        var sumAmountForeignLetter;
        if(sumAmountForeign < 0){
           sumAmountForeignLetter="-" + formatNumber(Math.abs(sumAmountForeign),4);
        }else{
            sumAmountForeignLetter=formatNumber(sumAmountForeign,4); 
        }
        
        var sumAmountIDR=0 - amountIDR;
               
        txtCashPaymentTotalBalanceForeign.val(sumAmountForeignLetter);
        txtCashPaymentTotalBalanceIDR.val(formatNumber(sumAmountIDR,4));
        
    }
    //ok
    function cashPaymentPaymentRequestInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#cashPaymentPaymentRequestInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        $("#cashPaymentPaymentRequestInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridHeader();
        cashPaymentCalculateTotalTransactionAmountForeign();
        addRowPaymentDetail();
    }
    //update
    function cashPaymentLoadDataDetail() {
        
        var url = "finance/cash-payment-detail-data";
        var params = "cashPayment.code=" + txtCashPaymentCode.val();
            
        $.getJSON(url, params, function(data) {
            cashPaymentDetaillastRowId = 0;
                    
            for (var i=0; i<data.listCashPaymentDetailTemp.length; i++) {
                
                var transactionType=data.listCashPaymentDetailTemp[i].transactionStatus;
                var currencyCodeDocument="";
                var exchangeRateDocument="0.00";
                var balancedForeign=0.00;
                var balancedIDR=0.00;
                
                switch(transactionType){
                    case "Transaction":
                        currencyCodeDocument=data.listCashPaymentDetailTemp[i].currencyCode;
                        exchangeRateDocument=data.listCashPaymentDetailTemp[i].exchangeRate;
                        balancedForeign+=parseFloat(data.listCashPaymentDetailTemp[i].documentBalanceAmount)+(parseFloat(data.listCashPaymentDetailTemp[i].debit) + parseFloat(data.listCashPaymentDetailTemp[i].credit));
                        balancedIDR+=parseFloat(data.listCashPaymentDetailTemp[i].documentBalanceAmountIDR)+((parseFloat(data.listCashPaymentDetailTemp[i].debit)*exchangeRateDocument) + (parseFloat(data.listCashPaymentDetailTemp[i].credit)* exchangeRateDocument));
                        break;
                    case "Other":
                        currencyCodeDocument=txtCashPaymentCurrencyCode.val();
                        exchangeRateDocument=removeCommas(txtCashPaymentExchangeRate.val());
                        break;
                }
                
                $("#cashPaymentDetailDocumentInput_grid").jqGrid("addRowData", cashPaymentDetaillastRowId, data.listCashPaymentDetailTemp[i]);
                $("#cashPaymentDetailDocumentInput_grid").jqGrid('setRowData',cashPaymentDetaillastRowId,{
                    cashPaymentDetailDocumentDocumentNo         : data.listCashPaymentDetailTemp[i].documentNo,
                    cashPaymentDetailDocumentBranchCode         : data.listCashPaymentDetailTemp[i].documentBranchCode,
                    cashPaymentDetailDocumentDocumentType       : data.listCashPaymentDetailTemp[i].documentType,
                    cashPaymentDetailDocumentCurrencyCode       : currencyCodeDocument,
                    cashPaymentDetailDocumentExchangeRate       : exchangeRateDocument,
                    cashPaymentDetailDocumentAmountForeign      : data.listCashPaymentDetailTemp[i].documentAmount,
                    cashPaymentDetailDocumentAmountIDR          : data.listCashPaymentDetailTemp[i].documentAmountIDR,
                    
//                    cashPaymentDetailDocumentBalanceForeign     : data.listCashPaymentDetailTemp[i].documentBalanceAmount,
//                    cashPaymentDetailDocumentBalanceIDR         : data.listCashPaymentDetailTemp[i].documentBalanceAmountIDR,
                    cashPaymentDetailDocumentBalanceForeign     : balancedForeign,
                    cashPaymentDetailDocumentBalanceIDR         : balancedIDR,
                    
                    cashPaymentDetailDocumentTransactionStatus  : data.listCashPaymentDetailTemp[i].transactionStatus,
                    cashPaymentDetailDocumentDebitForeign       : data.listCashPaymentDetailTemp[i].debit,
                    cashPaymentDetailDocumentDebitIDR           : (parseFloat(data.listCashPaymentDetailTemp[i].debit)*exchangeRateDocument),
                    cashPaymentDetailDocumentCreditForeign      : data.listCashPaymentDetailTemp[i].credit,
                    cashPaymentDetailDocumentCreditIDR          : (parseFloat(data.listCashPaymentDetailTemp[i].credit)* exchangeRateDocument),
                    cashPaymentDetailDocumentChartOfAccountCode : data.listCashPaymentDetailTemp[i].chartOfAccountCode,
                    cashPaymentDetailDocumentChartOfAccountName : data.listCashPaymentDetailTemp[i].chartOfAccountName,
                    cashPaymentDetailDocumentRemark             : data.listCashPaymentDetailTemp[i].remark
                });
            cashPaymentDetaillastRowId++;
            }
        });
    }
    //update
    function cashPaymentPaymentRequestData() {
        
        var url = "finance/payment-request-cash-bank-payment-data";
        var params = "transactionTypeDocumentNo="+txtCashPaymentCode.val();
            params+= "&transactionCashBankType=CASH";
            
        $.getJSON(url, params, function(data) {
            cashPaymentDetaillastRowId = 0;
            var count=0;
            var dataLength=parseFloat(data.listPaymentRequestTemp.length);
            for (var i=0; i<data.listPaymentRequestTemp.length; i++) {
                
                var transactionDate=formatDateRemoveT(data.listPaymentRequestTemp[i].transactionDate, true);
                
                $("#cashPaymentPaymentRequestInput_grid").jqGrid("addRowData", cashPaymentDetaillastRowId, data.listPaymentRequestTemp[i]);
                $("#cashPaymentPaymentRequestInput_grid").jqGrid('setRowData',cashPaymentDetaillastRowId,{
                    cashPaymentPaymentRequestDelete                 : "delete",
                    cashPaymentPaymentRequestCodeTemp               : data.listPaymentRequestTemp[i].code,
                    cashPaymentPaymentRequestBranchCode             : data.listPaymentRequestTemp[i].branchCode,
                    cashPaymentPaymentRequestCode                   : data.listPaymentRequestTemp[i].code,
                    cashPaymentPaymentRequestTransactionDate        : transactionDate,
                    cashPaymentPaymentRequestCurrencyCode           : data.listPaymentRequestTemp[i].currencyCode,
                    cashPaymentPaymentRequestTotalTransactionAmount : data.listPaymentRequestTemp[i].totalTransactionAmount,
                    cashPaymentPaymentRequestTransactionType        : data.listPaymentRequestTemp[i].transactionType,
                    cashPaymentPaymentRequestRefNo                  : data.listPaymentRequestTemp[i].refNo,
                    cashPaymentPaymentRequestRemark                 : data.listPaymentRequestTemp[i].remark
                });
                cashPaymentDetaillastRowId++;
                count+=1;
            }
            
            if(count===dataLength){
                addRowPaymentDetail();
                cashPaymentCalculateTotalTransactionAmountForeign();
            }
            
        });
        
    }
    //ok
    function cashPaymentValidateCurrencyExchangeRate(){ 
        if (txtCashPaymentCurrencyCode.val()==="IDR"){
            txtCashPaymentExchangeRate.val("1.00");
            txtCashPaymentExchangeRate.attr("readonly",true);
        }else{
//            if($("#cashPaymentUpdateMode").val()==="false"){
//                txtCashPaymentExchangeRate.val("0.00");   
//            }
            txtCashPaymentExchangeRate.attr("readonly",false);
        }
    }
    //ok
    function cashPaymentOnChangeTransactionType(){
        var transactionType=$("#cashPayment\\.transactionType").val();
        switch(transactionType){
            case "Regular":
                $('#cashPaymentTransactionTypeRadRegular').prop('checked',true);
                $('#cashPayment\\.vendorDepositType\\.code').attr('readonly',true);
                $('#cashPayment_btnVendorDepositType').hide();
                break;
            case "Down Payment":
                $('#cashPaymentTransactionTypeRadDown\\ Payment').prop('checked',true);
                $('#cashPayment\\.vendorDepositType\\.code').attr('readonly',false);
                $('#cashPayment_btnVendorDepositType').show();
                break;
        }
        
        setCashPaymentTransactionType();
    }
    //ok
    function cashPaymentFormatAmount(){
        var totalTransactionAmount=parseFloat(txtCashPaymentTotalTransactionAmountForeign.val());
        txtCashPaymentTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmount,2));
    }

    function changeCashPaymentDocumentType(type) {
        var selectedRowId = $("#cashPaymentPaymentRequestInput_grid").jqGrid("getGridParam","selrow");
        $("#" + selectedRowId + "_cashPaymentPaymentRequestTransactionStatus").val(type);
    }
    
    function cash_payment_handlers_input(){
                
        if(dtpCashPaymentTransactionDate.val()===""){
            handlersInput(dtpCashPaymentTransactionDate);
        }else{
            unHandlersInput(dtpCashPaymentTransactionDate);
        }
        
        if(txtCashPaymentBranchCode.val()===""){
            handlersInput(txtCashPaymentBranchCode);
        }else{
            unHandlersInput(txtCashPaymentBranchCode);
        }
        
//        if(txtCashPaymentCompanyCode.val()===""){
//            handlersInput(txtCashPaymentCompanyCode);
//        }else{
//            unHandlersInput(txtCashPaymentCompanyCode);
//        }
        
        if(txtCashPaymentCashAccountCode.val()===""){
            handlersInput(txtCashPaymentCashAccountCode);
        }else{
            unHandlersInput(txtCashPaymentCashAccountCode);
        }
        
//        if(txtCashPaymentPaymentRequestCode.val()===""){
//            handlersInput(txtCashPaymentPaymentRequestCode);
//        }else{
//            unHandlersInput(txtCashPaymentPaymentRequestCode);
//        }
        
        if(txtCashPaymentCurrencyCode.val()===""){
            handlersInput(txtCashPaymentCurrencyCode);
        }else{
            unHandlersInput(txtCashPaymentCurrencyCode);
        }
        
    }
    //ok
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#cashPaymentPaymentRequestInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        var data= $("#cashPaymentPaymentRequestInput_grid").jqGrid('getRowData',lastRowId);
        
            $("#cashPaymentPaymentRequestInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#cashPaymentPaymentRequestInput_grid").jqGrid('setRowData',lastRowId,{
                cashPaymentPaymentRequestCodeTemp               : defRow.cashPaymentPaymentRequestCodeTemp,
                cashPaymentPaymentRequestBranchCode             : defRow.cashPaymentPaymentRequestBranchCode,
                cashPaymentPaymentRequestCode                   : defRow.cashPaymentPaymentRequestCode,
                cashPaymentPaymentRequestTransactionDate        : defRow.cashPaymentPaymentRequestTransactionDate,
                cashPaymentPaymentRequestCurrencyCode           : defRow.cashPaymentPaymentRequestCurrencyCode,
                cashPaymentPaymentRequestTotalTransactionAmount : defRow.cashPaymentPaymentRequestTotalTransactionAmount,
                cashPaymentPaymentRequestTransactionType        : defRow.cashPaymentPaymentRequestTransactionType, 
                cashPaymentPaymentRequestRefNo                  : defRow.cashPaymentPaymentRequestRefNo, 
                cashPaymentPaymentRequestRemark                 : defRow.cashPaymentPaymentRequestRemark
            });
            
        setHeightGridHeader();
    }
    //ok
    function addRowPaymentDetail(){
        
        var ids = jQuery("#cashPaymentPaymentRequestInput_grid").jqGrid('getDataIDs');
        if(ids.length<0){
            return;
        }
        var codeString = "";
        var codeStringTemp = "";
        for(var i=0; i<ids.length; i++){
        var data= $("#cashPaymentPaymentRequestInput_grid").jqGrid('getRowData',ids[i]);
            if(i == 0){
                escape(codeStringTemp = "'"+data.cashPaymentPaymentRequestCode+"'");
            }else{
                escape(codeStringTemp = ",'"+data.cashPaymentPaymentRequestCode+"'");
            }
            codeString += codeStringTemp;
        }
            
        var url = "finance/payment-request-data-payment-detail";
        var params = "paymentRequestSearchCode="+codeString;
            
        $.getJSON(url, params, function(data) {
            cashPaymentSubDetaillastRowId = 0;
            $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid("clearGridData");
            
            var chartOfAccountCode="";
            var chartOfAccountName="";
            
            for(var j=0; j<data.listPaymentRequestDetailTemp.length; j++){
                
                if($("#cashPayment\\.transactionType").val() === "DEPOSIT" || $("#cashPayment\\.transactionType").val() === "Deposit"){
                    chartOfAccountCode = txtCashPaymentVendorDepositTypeChartOfAccountCode.val();
                    chartOfAccountName = txtCashPaymentVendorDepositTypeChartOfAccountName.val();
                }else{
                    chartOfAccountCode = data.listPaymentRequestDetailTemp[j].chartOfAccountCode;
                    chartOfAccountName = data.listPaymentRequestDetailTemp[j].chartOfAccountName;
                }
                
                $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid("addRowData", cashPaymentSubDetaillastRowId, data.listPaymentRequestDetailTemp[j]);
                $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('setRowData',cashPaymentSubDetaillastRowId,{
                    cashPaymentPaymentRequestDetailCode                         : data.listPaymentRequestDetailTemp[j].code,
                    cashPaymentPaymentRequestDetailHeaderCode                   : data.listPaymentRequestDetailTemp[j].headerCode,
                    cashPaymentPaymentRequestDetailBranchCode                   : data.listPaymentRequestDetailTemp[j].branchCode,
                    cashPaymentPaymentRequestDetailDocumentNo                   : data.listPaymentRequestDetailTemp[j].documentNo,
                    cashPaymentPaymentRequestDetailDocumentType                 : data.listPaymentRequestDetailTemp[j].documentType,
                    cashPaymentPaymentRequestDetailDocumentBranchCode           : data.listPaymentRequestDetailTemp[j].documentBranchCode,
                    cashPaymentPaymentRequestDetailTransactionStatus            : data.listPaymentRequestDetailTemp[j].transactionStatus,
                    cashPaymentPaymentRequestDetailChartOfAccountCode           : chartOfAccountCode,
                    cashPaymentPaymentRequestDetailChartOfAccountName           : chartOfAccountName,
                    cashPaymentPaymentRequestDetailDepartmentSearch             : "...",
                    cashPaymentPaymentRequestDetailDepartmentCode               : data.listPaymentRequestDetailTemp[j].departmentCode,    
                    cashPaymentPaymentRequestDetailDepartmentName               : data.listPaymentRequestDetailTemp[j].departmentName,    
                    cashPaymentPaymentRequestDetailCurrencyCode                 : data.listPaymentRequestDetailTemp[j].currencyCode,
                    cashPaymentPaymentRequestDetailExchangeRate                 : data.listPaymentRequestDetailTemp[j].exchangeRate,
                    cashPaymentPaymentRequestDetailTotalTransactionAmount       : "0.00",
                    cashPaymentPaymentRequestDetailTotalTransactionAmountIDR    : "0.00",
                    cashPaymentPaymentRequestDetailBalanceAmount                : "0.00",
                    cashPaymentPaymentRequestDetailBalanceAmountIDR             : "0.00",
                    cashPaymentPaymentRequestDetailDebitAmount                  : data.listPaymentRequestDetailTemp[j].debit,
                    cashPaymentPaymentRequestDetailDebitAmountIDR               : data.listPaymentRequestDetailTemp[j].debitIDR,
                    cashPaymentPaymentRequestDetailCreditAmount                 : data.listPaymentRequestDetailTemp[j].credit,
                    cashPaymentPaymentRequestDetailCreditAmountIDR              : data.listPaymentRequestDetailTemp[j].creditIDR,
                    cashPaymentPaymentRequestDetailRemark                       : data.listPaymentRequestDetailTemp[j].remark
                });
            cashPaymentSubDetaillastRowId++;
            }
        });
        setHeightGridDetail();
    }
    //ok
    function setHeightGridHeader(){
        var ids = jQuery("#cashPaymentPaymentRequestInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#cashPaymentPaymentRequestInput_grid"+" tr").eq(1).height();
            $("#cashPaymentPaymentRequestInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#cashPaymentPaymentRequestInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    //ok
    function setHeightGridDetail(){
        var ids = jQuery("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#cashPaymentPaymentRequestDetailInput_grid"+" tr").eq(1).height();
            $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    
    function cashPaymentPaymentRequestDetailInputGrid_SearchDepartment_OnClick(){
        window.open("./pages/search/search-department.jsp?iddoc=cashPaymentPaymentRequestDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function onChangeCashPaymentPaymentRequestDetailDepartment(){
        var selectedRowID = $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid("getGridParam", "selrow");
            var dsCode = $("#" + selectedRowID + "_cashPaymentPaymentRequestDetailDepartmentCode").val();
            var url = "master/department-get";
            var params = "department.code=" + dsCode;
                params+= "&department.activeStatus=TRUE";
            
            if(dsCode===""){
                $("#" + selectedRowID + "_cashPaymentPaymentRequestDetailDepartmentCode").val("");
                $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid("setCell", selectedRowID,"cashPaymentPaymentRequestDetailDepartmentName"," ");
                return;
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.departmentTemp){
                    $("#" + selectedRowID + "_cashPaymentPaymentRequestDetailDepartmentCode").val(data.departmentTemp.code);
                    $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid("setCell", selectedRowID,"cashPaymentPaymentRequestDetailDepartmentName",data.departmentTemp.name);
                }
                else{
                    alertMessage("Department Not Found!",$("#" + selectedRowID + "_cashPaymentPaymentRequestDetailDepartmentCode"));
                    $("#" + selectedRowID + "_cashPaymentPaymentRequestDetailDepartmentCode").val("");
                    $("#cashPaymentPaymentRequestDetailInput_grid").jqGrid("setCell", selectedRowID,"cashPaymentPaymentRequestDetailDepartmentName"," ");
                }
            });
    }
    
</script>

<s:url id="remoteurlCashPaymentDetailDocumentInput" action="" />
<b>CASH PAYMENT</b>
<hr>
<br class="spacer" />
<div id="cashPaymentInput" class="content ui-widget">
<s:form id="frmCashPaymentInput">
    <table cellpadding="2" cellspacing="2" id="headerInputCashPayment" width="100%">
        <tr>
            <td align="right" style="width:120px"><B>Branch *</B></td>
            <td colspan="2">
            <script type = "text/javascript">

                txtCashPaymentBranchCode.change(function(ev) {

                    if(txtCashPaymentBranchCode.val()===""){
                        txtCashPaymentBranchName.val("");
                        return;
                    }
                    var url = "master/branch-get";
                    var params = "branch.code=" + txtCashPaymentBranchCode.val();
                        params += "&branch.activeStatus=TRUE";

                    $.post(url, params, function(result) {
                        var data = (result);
                        if (data.branchTemp){
                            txtCashPaymentBranchCode.val(data.branchTemp.code);
                            txtCashPaymentBranchName.val(data.branchTemp.name);
                        }
                        else{
                            alertMessage("Branch Not Found!",txtCashPaymentBranchCode);
                            txtCashPaymentBranchCode.val("");
                            txtCashPaymentBranchName.val("");
                        }
                    });
                });
            </script>
            <div class="searchbox ui-widget-header" hidden="true">
                <s:textfield id="cashPayment.branch.code" name="cashPayment.branch.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                <sj:a id="cashPayment_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
            </div>
                <s:textfield id="cashPayment.branch.name" name="cashPayment.branch.name" size="40" readonly="true"></s:textfield>
        </tr>
        <tr>
            <td align="right"><B>Code *</B></td>
            <td colspan="3">
                <s:textfield id="cashPayment.code" name="cashPayment.code" key="cashPayment.code" readonly="true" size="22"></s:textfield>
                <s:textfield id="cashPaymentCurrencyCodeSession" name="cashPaymentCurrencyCodeSession" size="20" hidden="true"></s:textfield>
                <s:textfield id="cashPaymentUpdateMode" name="cashPaymentUpdateMode" size="20" hidden="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Transaction Date *</B></td>
            <td>
                <sj:datepicker id="cashPayment.transactionDate" name="cashPayment.transactionDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" onchange="cashPaymentTransactionDateOnChange()" changeYear="true" changeMonth="true" ></sj:datepicker>
                <sj:datepicker id="cashPaymentTransactionDate" name="cashPaymentTransactionDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" cssStyle="display:none" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="cashPaymentTemp.transactionDateTemp" name="cashPaymentTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
            </td>
            <td>
                <sj:datepicker id="cashPaymentTransactionDateFirstSession" name="cashPaymentTransactionDateFirstSession" size="20" showOn="focus" disabled="true" hidden="true" changeYear="true" changeMonth="true" ></sj:datepicker>
                <sj:datepicker id="cashPaymentTransactionDateLastSession" name="cashPaymentTransactionDateLastSession" size="20" showOn="focus" disabled="true" hidden="true" changeYear="true" changeMonth="true" ></sj:datepicker>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Cash Account *</B></td>
            <td colspan="3">
                <script type = "text/javascript">
                    txtCashPaymentCashAccountCode.change(function(ev) {
                        
                        if(txtCashPaymentCashAccountCode.val()===""){
                            txtCashPaymentCashAccountName.val("");
                            txtCashPaymentBBKVoucherNo.val("");
                            txtCashPaymentCashAccountChartOfAccountCode.val("");
                            txtCashPaymentCashAccountChartOfAccountName.val("");
                            return;
                        }
                        
                        var url = "master/cash-account-get-data-user";
                        var params = "cashAccount.code=" + txtCashPaymentCashAccountCode.val();
                            params+= "&cashAccount.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);

                            if (data.cashAccountTemp){
                                txtCashPaymentCashAccountCode.val(data.cashAccountTemp.code);
                                txtCashPaymentCashAccountName.val(data.cashAccountTemp.name);
                                txtCashPaymentBBKVoucherNo.val(data.cashAccountTemp.bkkVoucherNo);
                                txtCashPaymentCashAccountChartOfAccountCode.val(data.cashAccountTemp.chartOfAccountCode);
                                txtCashPaymentCashAccountChartOfAccountName.val(data.cashAccountTemp.chartOfAccountName);
                            }
                            else{
                                alertMessage("Cash Account Not Found!",txtCashPaymentCashAccountCode);
                                txtCashPaymentCashAccountCode.val("");
                                txtCashPaymentCashAccountName.val("");
                                txtCashPaymentBBKVoucherNo.val("");
                                txtCashPaymentCashAccountChartOfAccountCode.val("");
                                txtCashPaymentCashAccountChartOfAccountName.val("");
                            }
                        });
                    });
                    if($("#cashPaymentUpdateMode").val()==="true"){
                        txtCashPaymentCashAccountCode.attr("readonly",true);
                        $("#cashPayment_btnCashAccount").hide();
                        $("#ui-icon-search-cash-account-cash-payment").hide();
                    }else{
                        txtCashPaymentCashAccountCode.attr("readonly",false);
                        $("#cashPayment_btnCashAccount").show();
                        $("#ui-icon-search-cash-account-cash-payment").show();
                    }
                </script>
                <div class="searchbox ui-widget-header">
                <s:textfield id="cashPayment.cashAccount.code" name="cashPayment.cashAccount.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="cashPayment_btnCashAccount" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-cash-account-cash-payment"/></sj:a>
                </div>
                    <s:textfield id="cashPayment.cashAccount.name" name="cashPayment.cashAccount.name" size="40" readonly="true"></s:textfield>
                    <s:textfield id="cashPayment.cashAccount.bkkVoucherNo" name="cashPayment.cashAccount.bkkVoucherNo" size="15" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td/>
            <td colspan="2">
                <s:textfield id="cashPayment.cashAccount.chartOfAccount.code" name="cashPayment.cashAccount.chartOfAccount.code" size="22" readonly="true"></s:textfield>
                <s:textfield id="cashPayment.cashAccount.chartOfAccount.name" name="cashPayment.cashAccount.chartOfAccount.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Type *</B></td>
            <td>
                <s:textfield id="cashPayment.transactionType" name="cashPayment.transactionType" cssStyle="display:none"></s:textfield>
                <s:radio id="cashPaymentTransactionTypeRad" name="cashPaymentTransactionTypeRad" label="type" list="{'Regular','Deposit'}" value='"Regular"'/>
            </td> 
        </tr>
        <tr>
            <td align="right"><B>Deposit Type *</B></td>
            <td colspan="3">
                <script type = "text/javascript">
                    $('#cashPayment_btnVendorDepositType').click(function(ev) {
                        if(txtCashPaymentBranchCode.val === ""){
                            alertMessage("Branch Can't Be Empty !");
                            return;
                        }
                        window.open("./pages/search/search-vendor-deposit-type.jsp?iddoc=cashPayment&idsubdoc=vendorDepositType&branchCode="+txtCashPaymentBranchCode.val(),"Search", "scrollbars=1, width=600, height=500");
                    });

                    txtCashPaymentVendorDepositTypeCode.change(function(ev) {

                        if(txtCashPaymentBranchCode.val === ""){
                            alertMessage("Branch Can't Be Empty !");
                            return;
                        }

                        if(txtCashPaymentVendorDepositTypeCode.val()===""){
                            txtCashPaymentVendorDepositTypeName.val("");
                            txtCashPaymentVendorDepositTypeChartOfAccountCode.val("");
                            txtCashPaymentVendorDepositTypeChartOfAccountName.val("");
                            return;
                        }

                        var url = "master/vendor-deposit-type-get";
                        var params = "vendorDepositType.code=" + txtCashPaymentVendorDepositTypeCode.val();
                            params+= "&vendorDepositType.branchCode="+txtCashPaymentBranchCode.val();

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.vendorDepositTypeTemp){
                                txtCashPaymentVendorDepositTypeCode.val(data.vendorDepositTypeTemp.code);
                                txtCashPaymentVendorDepositTypeName.val(data.vendorDepositTypeTemp.name);
                                txtCashPaymentVendorDepositTypeChartOfAccountCode.val(data.vendorDepositTypeTemp.chartOfAccountCode);
                                txtCashPaymentVendorDepositTypeChartOfAccountName.val(data.vendorDepositTypeTemp.chartOfAccountName);
                            }
                            else{
                                alertMessage("Deposit Type Not Found!",txtCashPaymentVendorDepositTypeCode);
                                txtCashPaymentVendorDepositTypeCode.val("");
                                txtCashPaymentVendorDepositTypeName.val("");
                                txtCashPaymentVendorDepositTypeChartOfAccountCode.val("");
                                txtCashPaymentVendorDepositTypeChartOfAccountName.val("");
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                <s:textfield id="cashPayment.vendorDepositType.code" name="cashPayment.vendorDepositType.code" title=" " size="22"></s:textfield>
                    <sj:a id="cashPayment_btnVendorDepositType" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-vendor-deposit-type-bank-payment"/></sj:a>
                </div>
                    <s:textfield id="cashPayment.vendorDepositType.chartOfAccountCode" name="cashPayment.vendorDepositType.chartOfAccountCode" size="40" readonly="true"></s:textfield>
                    <s:textfield id="cashPayment.vendorDepositType.chartOfAccountName" name="cashPayment.vendorDepositType.chartOfAccountName" size="40" readonly="true" cssStyle="display:none"></s:textfield>
                    <s:textfield id="cashPayment.vendorDepositType.name" name="cashPayment.vendorDepositType.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Currency *</B></td>
            <td colspan="2">
                <script type = "text/javascript">
                    txtCashPaymentCurrencyCode.change(function(ev) {

                        if(txtCashPaymentCurrencyCode.val()===""){
                            txtCashPaymentCurrencyName.val("");
                            txtCashPaymentExchangeRate.val("0.00");
                            txtCashPaymentExchangeRate.attr("readonly",false);
                            return;
                        }

                        var url = "master/currency-get";
                        var params = "currency.code=" + txtCashPaymentCurrencyCode.val();
                            params+= "&currency.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.currencyTemp){
                                txtCashPaymentCurrencyCode.val(data.currencyTemp.code);
                                txtCashPaymentCurrencyName.val(data.currencyTemp.name);
                                cashPaymentValidateCurrencyExchangeRate();
                            }
                            else{
                                alertMessage("Currency Not Found!",txtCashPaymentCurrencyCode);
                                txtCashPaymentCurrencyCode.val("");
                                txtCashPaymentCurrencyName.val("");
                                txtCashPaymentExchangeRate.val("0.00");
                                txtCashPaymentExchangeRate.attr("readonly",false);
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                    <s:textfield id="cashPayment.currency.code" name="cashPayment.currency.code" title=" " size="22"></s:textfield>
                    <sj:a id="cashPayment_btnCurrency" cssClass="cashPayment_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-currency-cash-payment"/></sj:a>
                </div>
                    <s:textfield id="cashPayment.currency.name" name="cashPayment.currency.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Exchange Rate *</B></td>
            <td><s:textfield id="cashPayment.exchangeRate" name="cashPayment.exchangeRate" size="22" style="text-align: right" readonly="true" onkeyup="cashPaymentCalculateTotalTransactionAmountIDR()"></s:textfield><b>IDR</b> &nbsp;<span class="errMsgNumric" id="errmsgExchangeRate"></span></td>
        </tr>
        <tr>
            <td align="right"><B>Amount *</B></td>
            <td>
            <s:textfield id="cashPayment.totalTransactionAmount" name="cashPayment.totalTransactionAmount" size="22" style="text-align: right" readonly="true" value="0.00"></s:textfield>
                <s:textfield id="cashPayment.totalTransactionAmountIDR" name="cashPayment.totalTransactionAmountIDR" size="22" cssStyle="text-align:right" readonly="true" value="0.00"></s:textfield>(Credit)&nbsp;<span id="errmsgTotalTransactionAmount"></span>
            </td>
        </tr>
        <tr>
           <td align="right"><B>To *</B></td>
           <td colspan="2"><s:textfield id="cashPayment.paymentTo" name="cashPayment.paymentTo" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
       </tr>
        <tr>
            <td align="right">Ref No</td>
            <td colspan="3"><s:textfield id="cashPayment.refNo" name="cashPayment.refNo" size="27"></s:textfield></td>
        </tr>
        <tr>
            <td align="right" valign="top">Remark</td>
            <td colspan="3"><s:textarea id="cashPayment.remark" name="cashPayment.remark"  cols="72" rows="2" height="20"></s:textarea></td>
        </tr> 
        <tr hidden="true">
            <td>
                <s:textfield id="cashPayment.createdBy" name="cashPayment.createdBy" key="cashPayment.createdBy" readonly="true" size="22"></s:textfield>
                <sj:datepicker id="cashPayment.createdDate" name="cashPayment.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="cashPaymentTemp.createdDateTemp" name="cashPaymentTemp.createdDateTemp" size="20"></s:textfield>
                <s:textfield id="cashPaymentDetailCOAPurchaseDownPaymentCode" name="cashPaymentDetailCOAPurchaseDownPaymentCode" size="20"></s:textfield>
                <s:textfield id="cashPaymentDetailCOAPurchaseDownPaymentName" name="cashPaymentDetailCOAPurchaseDownPaymentName" size="20"></s:textfield>
            </td>
        </tr>
    </table>
</s:form>
<table>
    <tr>
        <td align="right">
            <sj:a href="#" id="btnConfirmCashPayment" button="true">Confirm</sj:a>
            <sj:a href="#" id="btnUnConfirmCashPayment" button="true">UnConfirm</sj:a>
        </td>
    </tr>
</table>
             
    <table width="20%">
        <tr>
            <td>
                <sj:a href="#" id="btnCashPaymentAddDetail" button="true" style="width: 90%">Payment Request</sj:a> 
            </td>
        </tr>
    </table>       
    <div id="cashPaymentPaymentRequestInputGrid">
        <sjg:grid
            id="cashPaymentPaymentRequestInput_grid"
            dataType="local"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCashPaymentPaymentRequestTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucashpayment').width()"
            editinline="true"
            editurl="%{remoteurlCashPaymentDetailDocumentInput}"
            onSelectRowTopics="cashPaymentDetailDocumentInput_grid_onSelect"
        >
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDelete" index="cashPaymentPaymentRequestDelete" title="" width="50" align="centre"
                editable="true"
                edittype="button"
                editoptions="{onClick:'cashPaymentPaymentRequestInputGrid_Delete_OnClick()', value:'delete'}"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestCodeTemp" index="cashPaymentPaymentRequestCodeTemp" key="cashPaymentPaymentRequestCodeTemp" 
                title="code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestBranchCode" index="cashPaymentPaymentRequestBranchCode" key="cashPaymentPaymentRequestBranchCode" 
                title="Branch" width="80" sortable="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestCode" index="cashPaymentPaymentRequestCode" key="cashPaymentPaymentRequestCode" 
                title="PYM-RQ NO" width="160" sortable="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestTransactionDate" index="cashPaymentPaymentRequestTransactionDate" key="cashPaymentPaymentRequestTransactionDate" 
                formatter="date" formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}" title="Transaction Date" width="150" sortable="true"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestCurrencyCode" index = "cashPaymentPaymentRequestCurrencyCode" key = "cashPaymentPaymentRequestCurrencyCode" 
                title = "Currency" width = "60" 
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestTotalTransactionAmount" index = "cashPaymentPaymentRequestTotalTransactionAmount" key = "cashPaymentPaymentRequestTotalTransactionAmount" 
                title = "Total Transaction" width = "80" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestTransactionType" index = "cashPaymentPaymentRequestTransactionType" key = "cashPaymentPaymentRequestTransactionType" 
                title = "Type" width = "100"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestRefNo" index="cashPaymentPaymentRequestRefNo" key="cashPaymentPaymentRequestRefNo" 
                title="Ref No" width="50" 
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestRemark" index="cashPaymentPaymentRequestRemark" key="cashPaymentPaymentRequestRemark" 
                title="Remark" width="50" 
            />
        </sjg:grid >                
    </div>
    <br class="spacer" />
    <br class="spacer" />
    <div id="cashPaymentPaymentRequestDetailInputGrid">
        <sjg:grid
            id="cashPaymentPaymentRequestDetailInput_grid"
            dataType="local"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCashPaymentTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucashpayment').width()" 
            onSelectRowTopics="cashPaymentPaymentRequestDetailDocumentInput_grid_onSelect"
        >
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailCode" index="cashPaymentPaymentRequestDetailCode" key="cashPaymentPaymentRequestDetailCode" 
                title="code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailHeaderCode" index="cashPaymentPaymentRequestDetailHeaderCode" key="cashPaymentPaymentRequestDetailHeaderCode" 
                title="header code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailBranchCode" index="cashPaymentPaymentRequestDetailBranchCode" key="cashPaymentPaymentRequestDetailBranchCode" 
                title="branch code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailDocumentNo" index="cashPaymentPaymentRequestDetailDocumentNo" key="cashPaymentPaymentRequestDetailDocumentNo" 
                title="Document No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailDocumentType" index="cashPaymentPaymentRequestDetailDocumentType" key="cashPaymentPaymentRequestDetailDocumentType" 
                title="Document Type" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailDocumentBranchCode" index="cashPaymentPaymentRequestDetailDocumentBranchCode" key="cashPaymentPaymentRequestDetailDocumentBranchCode" 
                title="Document Branch Code" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailTransactionStatus" index="cashPaymentPaymentRequestDetailTransactionStatus" key="cashPaymentPaymentRequestDetailTransactionStatus" 
                title="Transaction Status" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailChartOfAccountCode" index="cashPaymentPaymentRequestDetailChartOfAccountCode" key="cashPaymentPaymentRequestDetailChartOfAccountCode" 
                title="Chart Of Account Code" width="120" sortable="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailChartOfAccountName" index="cashPaymentPaymentRequestDetailChartOfAccountName" key="cashPaymentPaymentRequestDetailChartOfAccountName" 
                title="Chart Of Account Name" width="120" sortable="true"
            />
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailDepartmentSearch" index="cashPaymentPaymentRequestDetailDepartmentSearch" title="" width="25" align="centre" hidden="true"
                editable="true"
                dataType="html"
                edittype="button"
                editoptions="{onClick:'cashPaymentPaymentRequestDetailInputGrid_SearchDepartment_OnClick()', value:'...'}"
            /> 
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailDepartmentCode" index="cashPaymentPaymentRequestDetailDepartmentCode" 
                title="Department Code" width="120" sortable="true" edittype="text"  
                editoptions="{onChange:'onChangeCashPaymentPaymentRequestDetailDepartment()'}"
            />     
            <sjg:gridColumn
                name="cashPaymentPaymentRequestDetailDepartmentName" index="cashPaymentPaymentRequestDetailDepartmentName" 
                title="Department Name" width="150" sortable="true"
            />  
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailCurrencyCode" index = "cashPaymentPaymentRequestDetailCurrencyCode" key = "cashPaymentPaymentRequestDetailCurrencyCode" 
                title = "Currency" width = "60" 
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailExchangeRate" index = "cashPaymentPaymentRequestDetailExchangeRate" key = "cashPaymentPaymentRequestDetailExchangeRate" 
                title = "Exchange Rate" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailTotalTransactionAmount" index = "cashPaymentPaymentRequestDetailTotalTransactionAmount" key = "cashPaymentPaymentRequestDetailTotalTransactionAmount" 
                title = "Amount (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailTotalTransactionAmountIDR" index = "cashPaymentPaymentRequestDetailTotalTransactionAmountIDR" key = "cashPaymentPaymentRequestDetailTotalTransactionAmountIDR" 
                title = "Amount (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailBalanceAmount" index = "cashPaymentPaymentRequestDetailBalanceAmount" key = "cashPaymentPaymentRequestDetailBalanceAmount" 
                title = "Balance (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailBalanceAmountIDR" index = "cashPaymentPaymentRequestDetailBalanceAmountIDR" key = "cashPaymentPaymentRequestDetailBalanceAmountIDR" 
                title = "Balance (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailDebitAmount" index = "cashPaymentPaymentRequestDetailDebitAmount" key = "cashPaymentPaymentRequestDetailDebitAmount" 
                title = "Debit (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailDebitAmountIDR" index = "cashPaymentPaymentRequestDetailDebitAmountIDR" key = "cashPaymentPaymentRequestDetailDebitAmountIDR" 
                title = "Debit (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailCreditAmount" index = "cashPaymentPaymentRequestDetailCreditAmount" key = "cashPaymentPaymentRequestDetailCreditAmount" 
                title = "Credit (Foreign)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailCreditAmountIDR" index = "cashPaymentPaymentRequestDetailCreditAmountIDR" key = "cashPaymentPaymentRequestDetailCreditAmountIDR" 
                title = "Credit (IDR)" width = "80" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "cashPaymentPaymentRequestDetailRemark" index="cashPaymentPaymentRequestDetailRemark" key="cashPaymentPaymentRequestDetailRemark" 
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
                            <sj:a href="#" id="btnCashPaymentSave" button="true" style="width: 60px">Save</sj:a>
                        </td>
                        <td>
                            <sj:a href="#" id="btnCashPaymentCancel" button="true" style="width: 60px">Cancel</sj:a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="50%"></td>
            <td height="10px" align="middle" colspan="4">
                <sj:a href="#" id="btnCashPaymentCalculate" button="true" style="width: 80px">Calculate</sj:a>
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
                        <td><s:textfield id="cashPaymentTotalDebitForeign" name="cashPaymentTotalDebitForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="cashPaymentTotalDebitIDR" name="cashPaymentTotalDebitIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Total(Credit)</td>
                        <td><s:textfield id="cashPaymentTotalCreditForeign" name="cashPaymentTotalCreditForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="cashPaymentTotalCreditIDR" name="cashPaymentTotalCreditIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Balance</td>
                        <td><s:textfield id="cashPaymentTotalBalanceForeign" name="cashPaymentTotalBalanceForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="cashPaymentTotalBalanceIDR" name="cashPaymentTotalBalanceIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td/><td/>
                        <td height="10px" align="right" colspan="2"><lable><B><u>Forex Gain / Loss</u></B></lable></td>
                        <td width="25%"/>
                    </tr>
                    <tr>
                        <td style="text-align: right">Amount</td>
                        <td colspan="2"><s:textfield id="cashPaymentForexAmount" name="cashPaymentForexAmount" readonly="true" cssStyle="text-align:right" size="25" PlaceHolder="0.00"></s:textfield><B>IDR</B></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>