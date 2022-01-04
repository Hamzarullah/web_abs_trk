
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #errmsgExchangeRate,#errmsgTotalTransactionAmount{
        color: red;
    }
    #cashReceivedDetailDocumentInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var cashReceivedDetaillastRowId=0,generalJournallastRowId=0,cashReceivedDetail_lastSel = -1,generalJournal_lastSel=-1,selectedRowId=0;
    var flagCashReceivedIsConfirmed=false;
    var 
        txtCashReceivedBranchCode = $("#cashReceived\\.branch\\.code"),
        txtCashReceivedBranchName = $("#cashReceived\\.branch\\.name"),
        txtCashReceivedCode = $("#cashReceived\\.code"),
        dtpCashReceivedTransactionDate = $("#cashReceived\\.transactionDate"),
        txtCashReceivedCashAccountCode= $("#cashReceived\\.cashAccount\\.code"),
        txtCashReceivedCashAccountName= $("#cashReceived\\.cashAccount\\.name"),
        txtCashReceivedCashAccountBKMVoucherNo=$("#cashReceived\\.cashAccount\\.bkmVoucherNo"),
        txtCashReceivedCashAccountChartOfAccountCode=$("#cashReceived\\.cashAccount\\.chartOfAccount\\.code"),
        txtCashReceivedCashAccountChartOfAccountName=$("#cashReceived\\.cashAccount\\.chartOfAccount\\.name"),
//        txtCashReceivedCashAccountChartOfAccountCode=$("#cashReceived\\.cashAccount\\.chartOfAccount\\.code"),
//        txtCashReceivedCashAccountChartOfAccountName=$("#cashReceived\\.cashAccount\\.chartOfAccount\\.name"),
        txtCashReceivedReceivedFrom= $("#cashReceived\\.receivedFrom"),
        txtCashReceivedCurrencyCode = $("#cashReceived\\.currency\\.code"),
        txtCashReceivedCurrencyName = $("#cashReceived\\.currency\\.name"),
        txtCashReceivedExchangeRate = $("#cashReceived\\.exchangeRate"),
        txtCashReceivedCustomerCode= $("#cashReceived\\.customer\\.code"),
        txtCashReceivedCustomerName= $("#cashReceived\\.customer\\.name"),
        txtCashReceivedTotalTransactionAmountForeign = $("#cashReceived\\.totalTransactionAmount"),
        txtCashReceivedTotalTransactionAmountIDR = $("#cashReceived\\.totalTransactionAmountIDR"),
        txtCashReceivedRefNo = $("#cashReceived\\.refNo"),
        txtCashReceivedRemark = $("#cashReceived\\.remark"),
        txtCashReceivedCreatedBy = $("#cashReceived\\.createdBy"),
        dtpCashReceivedCreatedDate = $("#cashReceived\\.createdDate"),
        
        txtCashReceivedCurrencyCodeSession=$("#cashReceivedCurrencyCodeSession"),
        txtCashReceivedTotalTransactionForeign=$("#cashReceivedTotalTransactionForeign"),
        txtCashReceivedTotalTransactionIDR=$("#cashReceivedTotalTransactionIDR"),
        
        txtCashReceivedTotalDebitForeign = $("#cashReceivedTotalDebitForeign"),
        txtCashReceivedTotalDebitIDR = $("#cashReceivedTotalDebitIDR"),
        txtCashReceivedTotalCreditForeign = $("#cashReceivedTotalCreditForeign"),
        txtCashReceivedTotalCreditIDR = $("#cashReceivedTotalCreditIDR"),
        txtCashReceivedTotalBalanceForeign = $("#cashReceivedTotalBalanceForeign"),
        txtCashReceivedTotalBalanceIDR = $("#cashReceivedTotalBalanceIDR"),
        
        txtCashReceivedForexAmount = $("#cashReceivedForexAmount");
        
    $(document).ready(function() {
        cashReceivedLoadExchangeRate();
        calculateCashReceivedTotalTransactionAmountIDR();
        formatNumericBKM2();
        onChangeCashReceivedTransactionType();
        flagCashReceivedIsConfirmed=false;
        
        setCashReceivedTransactionType();
         if($("#cashReceivedUpdateMode").val()==false){
            setCurrency();
        }        
        $('input[name="cashReceivedTransactionTypeRad"][value="Regular"]').change(function(ev){
            var value="Regular";
            $("#cashReceived\\.transactionType").val(value);
        });
                
        $('input[name="cashReceivedTransactionTypeRad"][value="Deposit"]').change(function(ev){
            var value="Deposit";
            $("#cashReceived\\.transactionType").val(value);
        });
        
        $("#cashReceived\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#cashReceived\\.exchangeRate").change(function(e){
            var exrate=$("#cashReceived\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#cashReceived\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#cashReceived\\.totalTransactionAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        
        $("#cashReceived\\.totalTransactionAmount").change(function(e){
            var amount=$("#cashReceived\\.totalTransactionAmount").val();
            if(amount===""){
               $("#cashReceived\\.totalTransactionAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                txtCashReceivedTotalTransactionForeign.val(formatNumber(parseFloat(value),2));
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        
        $.subscribe("cashReceivedDetailDocumentInput_grid_onSelect", function() {

            var selectedRowID = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==cashReceivedDetail_lastSel) {

                $('#cashReceivedDetailDocumentInput_grid').jqGrid("saveRow",cashReceivedDetail_lastSel); 
                $('#cashReceivedDetailDocumentInput_grid').jqGrid("editRow",selectedRowID,true);            

                cashReceivedDetail_lastSel=selectedRowID;

            }
            else
                $('#cashReceivedDetailDocumentInput_grid').jqGrid("saveRow",selectedRowID);

        });
        
        $('#btnCashReceivedSave').click(function(ev) {
            
            if(flagCashReceivedIsConfirmed===false){
                alertMessage("Please Confirm",$("#btnConfirmCashReceived"));
                return;
            }
            
            $( "#btnCashReceivedCalculate" ).trigger( "click" );
            
            if(cashReceivedDetail_lastSel !== -1) {
                $('#cashReceivedDetailDocumentInput_grid').jqGrid("saveRow",cashReceivedDetail_lastSel); 
            }

            var ids = jQuery("#cashReceivedDetailDocumentInput_grid").jqGrid('getDataIDs'); 
            var totalBalanceForeign = parseFloat(txtCashReceivedTotalBalanceForeign.val().replace(/,/g, ""));
            var totalBalanceIDR = parseFloat(txtCashReceivedTotalBalanceIDR.val().replace(/,/g, ""));
            var headerCurrency = txtCashReceivedCurrencyCode.val();

            // cek isi detail
            if(ids.length===0){
                alertMessage("Grid Cash Received Detail Is Not Empty");
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

            var listCashReceivedDetail = new Array(); 

            for(var i=0;i < ids.length;i++){ 
                var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 
                var documentNo = data.cashReceivedDetailDocumentDocumentNo;
                var transactionStatus = data.cashReceivedDetailDocumentTransactionStatus;
                var documentAccountName = data.cashReceivedDetailDocumentChartOfAccountName;
                var amountCheck = parseFloat(data.cashReceivedDetailDocumentAmountForeignInput);

                
                var debitValue=parseFloat(data.cashReceivedDetailDocumentDebitForeign);
                var creditValue=parseFloat(data.cashReceivedDetailDocumentCreditForeign);

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
                
                //cek transaction status
//                if(transactionStatus==="---Select---"){
//                    alertMessage("Please Select Transaction Status!");
//                    return;
//                }
//                else{
//                    switch(transactionStatus){
//                        case "Transaction":
//                            if(documentNo===" "){
//                                alertMessage("The Following Required Field have been empty: Document No");
//                                return;
//                            }
//                            if(documentAccountName===" "){
//                                alertMessage("The Following Required Field have been empty: Account");
//                                return;
//                            }
//                            break;
//                        case "Other":
//                            if(documentAccountName===" "){
//                                alertMessage("The Following Required Field have been empty: Account");
//                                return;
//                            }
//                        break;
//                    }
//
//                    if(Math.abs(amountCheck)===0){
//                        alertMessage("The Following Required Field have been Empty: Amount");
//                        return;
//                    }
//                }
//
//                if(documentNo !==" "){
//                    for(var j=0;j<ids.length;j++){
//                        if(j!==i){
//                            var dataCheck = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',ids[j]);
//                            if(dataCheck.cashReceivedDetailDocumentDocumentNo===documentNo){
//                                if(dataCheck.cashReceivedDetailDocumentTransactionStatus===transactionStatus){
//                                    alertMessage("You Have Invalid Transaction Status For Document : " + documentNo);
//                                    return;
//                                }
//                            }
//                        }
//                    }
//                }
                var dataTransactionStatus = '';
                if(data.cashReceivedDetailDocumentDocumentNo===" "){
                    dataTransactionStatus = 'Other';
                }else{
                    dataTransactionStatus = 'Transaction';
                }
                var cashReceivedDetail = { 
                    documentNo           : data.cashReceivedDetailDocumentDocumentNo,
                    documentBranchCode   : data.cashReceivedDetailDocumentBranchCode,
                    documentType         : data.cashReceivedDetailDocumentDocumentType,
                    currency             : {code:data.cashReceivedDetailDocumentCurrencyCode},
                    branch               : {code:data.cashReceivedDetailDocumentBranchCode},
                    exchangeRate         : data.cashReceivedDetailDocumentExchangeRate,
                    chartOfAccount       : {code:data.cashReceivedDetailDocumentChartOfAccountCode},
                    transactionStatus    : dataTransactionStatus,
                    amount               : data.cashReceivedDetailDocumentAmountForeignInput,
                    amountIDR            : data.cashReceivedDetailDocumentAmountIDRInput,
                    debit                : data.cashReceivedDetailDocumentDebitForeign,
                    debitIDR             : data.cashReceivedDetailDocumentDebitIDR,
                    credit               : data.cashReceivedDetailDocumentCreditForeign,
                    creditIDR            : data.cashReceivedDetailDocumentCreditIDR,
                    remark               : data.cashReceivedDetailDocumentRemark
                };

                listCashReceivedDetail[i] = cashReceivedDetail;
            }
            
            formatDateBKM();
            UnFormatNumericBKM();
            
            var forexAmount= txtCashReceivedForexAmount.val();
            
            var url = "finance/cash-received-save";
            var params = $("#frmCashReceivedInput").serialize();
                params += "&listCashReceivedDetailJSON=" + $.toJSON(listCashReceivedDetail);
                params += "&forexAmount=" + forexAmount;
            
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateBKM();
                    formatNumericBKM();
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
                                var url = "finance/cash-received-input";
                                var param = "";
                                pageLoad(url, param, "#tabmnuCASH_RECEIVED");
                            }
                        },
                        {
                            text : "No",
                            click : function() {

                                $(this).dialog("close");
                                var url = "finance/cash-received";
                                var param = "";
                                pageLoad(url, param, "#tabmnuCASH_RECEIVED");
                            }
                        }]
                });
            });
        });
        
        $("#btnCashReceivedAddDetail").css("display", "none");
        $("#btnCashReceivedAddDetailOther").css("display", "none");
        $("#btnUnConfirmCashReceived").css("display", "none");
        $('#cashReceivedDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});       
        $('#btnCashReceivedAddDetail').click(function(ev) {

                if(flagCashReceivedIsConfirmed===false){
                    alertMessage("Please Confirm!",$("#btnConfirmCashReceived"));
                    return;
                }
                
                if($("#cashReceived\\.transactionType").val()=== "REGULAR" ||$("#cashReceived\\.transactionType").val()=== "Regular"){
                
                window.open("./pages/search/search-finance-document.jsp?iddoc=cashReceivedDetailDocument&type=grid&idfin=BBM&firstDate="+$("#cashReceivedTransactionDateFirstSession").val()+"&rowLast="+cashReceivedDetaillastRowId+"&lastDate="+$("#cashReceivedTransactionDateLastSession").val()+"&customerCode="+txtCashReceivedCustomerCode.val()+"&customerName="+txtCashReceivedCustomerName.val(),"Search", "scrollbars=1, width=900, height=600");

                }else{
                    alertMessage("Hanya Boleh Satu Document Untuk Deposit [DP]!");
                }
                
        });
        $('#btnCashReceivedAddDetailOther').click(function(ev) {
            
            if(!flagCashReceivedIsConfirmed){
                alertMessage("Please Confirm",$("#btnConfirmCashReceived"));
                return;
            }
            
            if($("#cashReceived\\.transactionType").val()!== "DEPOSIT" || $("#cashReceived\\.transactionType").val()!== "Deposit"){
                var AddRowCount =parseFloat(removeCommas($("#cashReceivedAddRow").val()));
                for(var i=0; i<AddRowCount; i++){
                    var defRow = {
                        cashReceivedDetailDocumentBranchCode         : txtCashReceivedBranchCode.val(),
                        cashReceivedDetailDocumentDocumentNo         :" ",
                        cashReceivedDetailDocumentTransactionStatus  :"Other",
                        cashReceivedDetailDocumentChartOfAccountName :" ",
                        cashReceivedDetailDocumentCurrencyCode       :txtCashReceivedCurrencyCode.val(),
                        cashReceivedDetailDocumentExchangeRate       :removeCommas(txtCashReceivedExchangeRate.val())
                    };
                    cashReceivedDetaillastRowId++;
                    $("#cashReceivedDetailDocumentInput_grid").jqGrid("addRowData", cashReceivedDetaillastRowId, defRow);

                    be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                    $("#cashReceivedDetailDocumentInput_grid").jqGrid('setRowData',cashReceivedDetaillastRowId,{Buttons:be});
                }
               
                $("#cashReceivedAddRow").val("1");
           }else{
              alertMessage("Hanya Boleh Satu Document Untuk Deposit [DP]!");
           }
        });
        $("#btnConfirmCashReceived").click(function(ev) {
        
            handlers_input_cash_received();

            if(!$("#frmCashReceivedInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            if(parseFloat(removeCommas(txtCashReceivedTotalTransactionAmountForeign.val()))<=0){
                alertMessage("Invalid Total Transaction Value!",txtCashReceivedTotalTransactionAmountForeign);
                return;
            }
            if(parseFloat(txtCashReceivedExchangeRate.val())<=1 && txtCashReceivedCurrencyCode.val()!=="IDR"){
           
                txtCashReceivedExchangeRate.attr("style","color:red");
                alertMessageNotif("Exchange Rate : "+txtCashReceivedCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtCashReceivedExchangeRate.attr("style","color:black");
            }
            

            var date1 = dtpCashReceivedTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#cashReceivedTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#cashReceivedUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#cashReceivedTransactionDate").val(),dtpCashReceivedTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpCashReceivedTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#cashReceivedUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#cashReceivedTransactionDate").val(),dtpCashReceivedTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpCashReceivedTransactionDate);
                }
                return;
            }
//            var date = $("#cashReceived\\.transactionDate").val().split("/");
//            var month = date[1];
//            var year = date[2].split(" ");
//            if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
//                alertMessage("Transaction Month Must Between Session Period Month!",dtpCashReceivedTransactionDate);
//                return;
//            }
//
//            if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
//                alertMessage("Transaction Year Must Between Session Period Year!",dtpCashReceivedTransactionDate);
//                return;
//            }    
                    
//            if(){
//                cashReceivedLoadDataDetail();
//            }

            flagCashReceivedIsConfirmed=true;
            $("#btnCashReceivedAddDetail").css("display", "block");
            $("#btnCashReceivedAddDetailOther").css("display", "block");
            $("#btnUnConfirmCashReceived").css("display", "block");
            $("#btnConfirmCashReceived").css("display", "none");
            $('#cashReceivedHeaderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
          
            if($("#cashReceived\\.transactionType").val() === "DEPOSIT" || $("#cashReceived\\.transactionType").val() === "Deposit"){
                var defRow = {
                    cashReceivedDetailDocumentDocumentNo            : " ",
                    cashReceivedDetailDocumentBranchCode            : txtCashReceivedBranchCode.val(),
                    cashReceivedDetailDocumentCurrencyCode          : txtCashReceivedCurrencyCode.val(),
                    cashReceivedDetailDocumentExchangeRate          : removeCommas(txtCashReceivedExchangeRate.val()),
                    cashReceivedDetailDocumentTransactionStatus     : "Other",
                    cashReceivedDetailDocumentCreditForeign         : removeCommas(txtCashReceivedTotalTransactionAmountForeign.val()),
                    cashReceivedDetailDocumentCreditIDR             : removeCommas(txtCashReceivedTotalTransactionAmountIDR.val()),
                    cashReceivedDetailDocumentChartOfAccountCode    : $("#cashReceivedDetailCOASalesDownPaymentCode").val(),
                    cashReceivedDetailDocumentChartOfAccountName    : $("#cashReceivedDetailCOASalesDownPaymentName").val()
                };
                
                cashReceivedDetaillastRowId++;
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("addRowData", cashReceivedDetaillastRowId, defRow);
                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#cashReceivedDetailDocumentInput_grid").jqGrid('setRowData',cashReceivedDetaillastRowId,{Buttons:be});
                ev.preventDefault();
                $("#btnCashReceivedAddDetail").css("display", "none");
                $("#btnCashReceivedAddDetailOther").css("display", "none");
            }
            
            if(($("#cashReceived\\.transactionType").val() === "Regular")||($("#cashReceived\\.transactionType").val() === "REGULAR")){
                if ($("#cashReceivedUpdateMode").val()==="true"){
                    $("#btnCashReceivedAddDetail").css("display", "block");
                    $("#btnCashReceivedAddDetailOther").css("display", "block");
                    $('#cashReceivedDetailDocumentInputGrid').unblock();
                    cashReceivedLoadDataDetail();}
                else if ($("#cashReceivedUpdateMode").val()==="false"){
                    $("#btnCashReceivedAddDetail").css("display", "block");
                    $("#btnCashReceivedAddDetailOther").css("display", "block");
                    $('#cashReceivedDetailDocumentInputGrid').unblock();   
                }
                $("#btnCashReceivedAddDetail").css("display", "block");
                $("#btnCashReceivedAddDetailOther").css("display", "block");
            }
            if(txtCashReceivedCurrencyCode.val()==="IDR"){
                $("#cashReceivedDetailDocumentInput_grid").jqGrid('hideCol',[,"cashReceivedDetailDocumentDebitForeign","cashReceivedDetailDocumentCreditForeign"]);
            }else{
                $("#cashReceivedDetailDocumentInput_grid").jqGrid('showCol',[,"cashReceivedDetailDocumentDebitForeign","cashReceivedDetailDocumentCreditForeign"]);
            }
        });
        
        $("#btnUnConfirmCashReceived").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                '</span>Are You Sure to UnConfirm this Detail?</div>');

            var rows = jQuery("#cashReceivedDetailDocumentInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagCashReceivedIsConfirmed=false;
                $("#btnCashReceivedAddDetail").css("display", "none");
                $("#btnCashReceivedAddDetailOther").css("display", "none");
                $("#btnUnConfirmCashReceived").css("display", "none");
                $("#btnConfirmCashReceived").css("display", "block");
                $('#cashReceivedHeaderInput').unblock();
                $('#cashReceivedDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                            flagCashReceivedIsConfirmed=false;
                            $("#btnCashReceivedAddDetail").css("display", "none");
                            $("#btnCashReceivedAddDetailOther").css("display", "none");
                            $("#cashReceivedDetailDocumentInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmCashReceived").css("display", "none");
                            $("#btnConfirmCashReceived").css("display", "block");
                            $('#cashReceivedHeaderInput').unblock();
                            $('#cashReceivedDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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

        
        
        $('#btnCashReceivedCancel').click(function(ev) {     
            var url = "finance/cash-received";
            var params = "";
            pageLoad(url, params, "#tabmnuCASH_RECEIVED"); 
        });
        
        $('#btnCashReceivedCalculate').click(function(ev) {
            
            if(cashReceivedDetail_lastSel !== -1) {
                $('#cashReceivedDetailDocumentInput_grid').jqGrid("saveRow",cashReceivedDetail_lastSel); 
            }
            
            var ids = jQuery("#cashReceivedDetailDocumentInput_grid").jqGrid('getDataIDs'); 
            
            var exchangeRate=$("#cashReceived\\.exchangeRate").val().replace(/,/g,"");
            
            var DebitForeign=$("#cashReceived\\.totalTransactionAmount").val().replace(/,/g,"");
            var DebitIDR = (parseFloat(DebitForeign)* parseFloat(exchangeRate));
            
            var CreditForeign = 0; 
            var CreditIDR = 0;
            
            var BalanceForeign = 0;
            var BalanceIDR = 0;
            
            var nilaiForexHeader = 0;
            
            DebitForeign = parseFloat(DebitForeign);
            DebitIDR = parseFloat(DebitIDR);
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 
                
                var documentDebitForeign = data.cashReceivedDetailDocumentDebitForeign;
//                var documentDebitIDR = data.cashReceivedDetailDocumentDebitIDR;
                var documentCreditForeign = data.cashReceivedDetailDocumentCreditForeign;
//                var documentCreditIDR = data.cashReceivedDetailDocumentCreditIDR;
                
                var headerRate = txtCashReceivedExchangeRate.val().replace(/,/g,"");
                var headerCurrency = txtCashReceivedCurrencyCode.val();

                var documentRate = data.cashReceivedDetailDocumentExchangeRate;
                var documentCurrency = data.cashReceivedDetailDocumentCurrencyCode;
                
                ///
                var documentDebitIDR = documentDebitForeign * documentRate;
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", ids[i],"cashReceivedDetailDocumentDebitIDR",documentDebitIDR);
                
                var documentCreditIDR = documentCreditForeign * documentRate;
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", ids[i],"cashReceivedDetailDocumentCreditIDR",documentCreditIDR);
                
                var selisihKurs = 0;
                var nilaiDokumen = 0;
                var nilaiForex = 0;
                
                if (headerCurrency !== "IDR")
                {
                    if (documentCurrency === headerCurrency)
                    {
                        selisihKurs = parseFloat(headerRate) - parseFloat(documentRate);
                        nilaiDokumen = parseFloat(documentCreditForeign) - parseFloat(documentDebitForeign);
                        
                        nilaiForex = selisihKurs * nilaiDokumen;
                        
                        nilaiForexHeader = parseFloat(nilaiForexHeader) + nilaiForex;
                    }
                }
                
                DebitForeign =(parseFloat(DebitForeign) + parseFloat(documentDebitForeign)).toFixed(2);
                DebitIDR = (parseFloat(DebitIDR) + parseFloat(documentDebitIDR)).toFixed(2);

                CreditForeign =(parseFloat(CreditForeign) + parseFloat(documentCreditForeign)).toFixed(2);
                CreditIDR = (parseFloat(CreditIDR) + parseFloat(documentCreditIDR)).toFixed(2);
            }
            
            var splitDebitForeign=DebitForeign.split('.');
            var DebitForeignFormat;
            if(splitDebitForeign[0].length>3){
                var concatDebitForeign=parseFloat(splitDebitForeign[0]+'.'+splitDebitForeign[1]);
                DebitForeignFormat=formatNumber(concatDebitForeign,2);
            }else{
                DebitForeignFormat=splitDebitForeign[0]+'.'+splitDebitForeign[1];
            }
            txtCashReceivedTotalDebitForeign.val(DebitForeignFormat);
            txtCashReceivedTotalDebitIDR.val(formatNumber(parseFloat(DebitIDR),2));
            
            var splitCreditForeign=CreditForeign.split('.');
            var CreditForeignFormat;
            if(splitCreditForeign[0].length>3){
                var concatCreditForeign=parseFloat(splitCreditForeign[0]+'.'+splitCreditForeign[1]);
                CreditForeignFormat=formatNumber(concatCreditForeign,2);
            }else{
                CreditForeignFormat=splitCreditForeign[0]+'.'+splitCreditForeign[1];
            }
            txtCashReceivedTotalCreditForeign.val(CreditForeignFormat);
            txtCashReceivedTotalCreditIDR.val(formatNumber(parseFloat(CreditIDR),2));
            
            
            
            BalanceForeign = (DebitForeign - CreditForeign).toFixed(2);
            BalanceIDR = DebitIDR - CreditIDR;
            
            var splitBalanceForeign=BalanceForeign.split('.');
            var BalanceForeignFormat;
            
                        
            if(parseFloat(BalanceForeign)>0){
                if(splitBalanceForeign[0].length>3){
                    var concatBalanceForeign=parseFloat(splitBalanceForeign[0]+'.'+splitBalanceForeign[1]);
                    BalanceForeignFormat=formatNumber(parseFloat(concatBalanceForeign),2);
                }else{
                    BalanceForeignFormat=splitBalanceForeign[0]+'.'+splitBalanceForeign[1];
                }
            }else{
                var removeMinusBalanceForeign=splitBalanceForeign[0].toString().replace('-','');
                
                if(removeMinusBalanceForeign.length>3){
                    var concatBalanceForeign=parseFloat(removeMinusBalanceForeign+'.'+splitBalanceForeign[1]);
                    BalanceForeignFormat="-"+formatNumber(parseFloat(concatBalanceForeign),2);
                }else{
                    
                    BalanceForeignFormat="-"+removeMinusBalanceForeign+'.'+splitBalanceForeign[1];
                }
                if(parseFloat(BalanceForeign)===0){
                    BalanceForeignFormat=BalanceForeignFormat.replace('-','');
                }
            }
            
            
           
            txtCashReceivedTotalBalanceForeign.val(BalanceForeignFormat);
            txtCashReceivedTotalBalanceIDR.val(formatNumber(parseFloat(BalanceIDR.toFixed(2)),2));
            
            txtCashReceivedForexAmount.val(formatNumber(nilaiForexHeader,2));
        });
        
        $('#cashReceived_btnCashAccount').click(function(ev) {
            window.open("./pages/search/search-cash-account.jsp?iddoc=cashReceived&idsubdoc=cashAccount","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#cashReceived_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=cashReceived&idsubdoc=currency","Search", "scrollbars=1, width=600, height=500");
        });
        $('#cashReceived_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=cashReceived&idsubdoc=customer","Search", "scrollbars=1, width=600, height=500");
        });
    });
    function addRowCashReceivedDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#cashReceivedDetailDocumentInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        var data= $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',lastRowId);
        
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("addRowData", lastRowId, defRow);
        $("#cashReceivedDetailDocumentInput_grid").jqGrid('setRowData',lastRowId,{
            cashReceivedDetailDocumentDelete                        :"delete",
            cashReceivedDetailDocumentBranchCode                    : defRow.branchCode,
            cashReceivedDetailDocumentDocumentNo                    : defRow.documentNo,
            cashReceivedDetailDocumentDocumentType                  : defRow.documentType,
            cashReceivedDetailDocumentCurrencyCode                  : defRow.currencyCode,
            cashReceivedDetailDocumentExchangeRate                  : defRow.exchangeRate

        });
        cashReceivedDetaillastRowId++;
        setHeightGridHeader();
        $("#btnCashReceivedCalculate").trigger("click");
    }
    function setHeightGridHeader(){
        var ids = jQuery("#cashReceivedDetailDocumentInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#cashReceivedDetailDocumentInput_grid"+" tr").eq(1).height();
            $("#cashReceivedDetailDocumentInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#cashReceivedDetailDocumentInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    function setCurrency(){

            var url = "master/currency-get";
            var params = "currency.code=IDR";
                params+= "&currency.activeStatus=TRUE";

            $.post(url, params, function(result) {
                var data = (result);
                if (data.currencyTemp){
                    txtCashReceivedCurrencyCode.val(data.currencyTemp.code);
                    txtCashReceivedCurrencyName.val(data.currencyTemp.name);
                    cashReceivedLoadExchangeRate();
                }
                else{
                    alertMessage("Currency Not Found!",txtCashReceivedCurrencyCode);
                    txtCashReceivedCurrencyCode.val("");
                    txtCashReceivedCurrencyName.val("");
                    txtCashReceivedExchangeRate.val("0.00");
                    txtCashReceivedExchangeRate.attr("readonly",true);
                }
            });
    }
    function cashReceivedTransactionDateOnChange(){
        if($("#cashReceivedUpdateMode").val()!=="true"){
            $("#cashReceivedTransactionDate").val(dtpCashReceivedTransactionDate.val());
        }
    }
    
    function setCashReceivedTransactionType(){
        var modeUpdate=$("#cashReceivedUpdateMode").val();
        switch(modeUpdate){
            case "true":
                switch($("#cashReceived\\.transactionType").val()){
                    case "REGULAR":
                        $('input[name="cashReceivedTransactionTypeRad"][value="Regular"]').prop('checked',true);
                        $('#cashReceivedTransactionTypeRadDeposit').attr('disabled', true);
                        break;
                    case "DEPOSIT":
                        $('input[name="cashReceivedTransactionTypeRad"][value="Deposit"]').prop('checked',true);
                        $('#cashReceivedTransactionTypeRadRegular').attr('disabled', true);
                        break;
                } 
            break;
        }
    }
    
    function calculateCashReceivedTotalTransactionAmountIDR(){
        var totalTransactionAmountForeign=removeCommas(txtCashReceivedTotalTransactionAmountForeign.val());
        var exchangeRate=removeCommas(txtCashReceivedExchangeRate.val());
        var totalTransactionAmountIDR=(parseFloat(totalTransactionAmountForeign)* parseFloat(exchangeRate));

        txtCashReceivedTotalTransactionAmountIDR.val(formatNumber(parseFloat(totalTransactionAmountIDR.toFixed(2)),2));
                
        if(totalTransactionAmountForeign==="" || exchangeRate===""){
            txtCashReceivedTotalTransactionAmountIDR.val("0.00");
        }
    }
    
    function countCasPaymentAmountIDRToForeignDebit(){
        var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
                
        var Ex_Rate = data.cashReceivedDetailDocumentExchangeRate;
        var DebitForeign = $("#"+ selectedRowId + "_cashReceivedDetailDocumentDebitForeign").val();
        if(DebitForeign===""){
            DebitForeign=0;
        }
        
        var DebitIDR=(parseFloat(DebitForeign) * parseFloat(Ex_Rate)).toFixed(2);
        
        $("#"+ selectedRowId + "_cashReceivedDetailDocumentDebitIDR").val(DebitIDR);
        
    }
    
    function countCashReceivedAmountForeignToIDRDebit(){
        var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.cashReceivedDetailDocumentExchangeRate;
        var DebitIDR = $("#"+ selectedRowId + "_cashReceivedDetailDocumentDebitIDR").val();
        
        if(DebitIDR===""){
            DebitIDR=0;
        }
        
        var DebitForeign = parseFloat(DebitIDR) / parseFloat(Ex_Rate);
        
        $("#"+ selectedRowId + "_cashReceivedDetailDocumentDebitForeign").val(DebitForeign);
        
    }
    
    function countPaymentAmountIDRToForeignCredit(){
        var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.cashReceivedDetailDocumentExchangeRate;
        var CreditForeign = $("#"+ selectedRowId + "_cashReceivedDetailDocumentCreditForeign").val();
        if(CreditForeign===""){
            CreditForeign=0;
        }
        
        var CreditIDR = (parseFloat(CreditForeign) * parseFloat(Ex_Rate)).toFixed(2);
        
        $("#"+ selectedRowId + "_cashReceivedDetailDocumentCreditIDR").val(CreditIDR);
        
    }
    
    function countPaymentAmountForeignToIDRCredit(){
        var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.cashReceivedDetailDocumentExchangeRate;
        var CreditIDR = $("#"+ selectedRowId + "_cashReceivedDetailDocumentCreditIDR").val();
        if(CreditIDR===""){
            CreditIDR=0;
        }
        var CreditForeign = parseFloat(CreditIDR) / parseFloat(Ex_Rate);
        
        $("#"+ selectedRowId + "_cashReceivedDetailDocumentCreditForeign").val(CreditForeign);
        
    }
    
        
    function countCashReceivedAmountForeignToIDR(){
        
            var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
            var amountIDR = $("#"+ selectedRowId + "_cashReceivedDetailDocumentAmountIDRInput").val();
            
            var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
            var transactionStatus=$("#"+ selectedRowId + "_cashReceivedDetailDocumentTransactionStatus").val();
        
            var currencyCodeHeader=txtCashReceivedCurrencyCode.val();
            var currencyCodeDetail=data.cashReceivedDetailDocumentCurrencyCode;
            var currencyCodeSession=txtCashReceivedCurrencyCodeSession.val();
            var Ex_Rate;
            switch(transactionStatus){
                case "Transaction":
                    if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail!==currencyCodeSession){
                        Ex_Rate=data.cashReceivedDetailDocumentExchangeRate;
                    }
                    if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail===currencyCodeSession){
                        Ex_Rate=txtCashReceivedExchangeRate.val().replace(/,/g, "");
                    }
                    if(currencyCodeHeader===currencyCodeSession){
                        Ex_Rate=data.cashReceivedDetailDocumentExchangeRate;
                    }
                    break;
                case "Other":
                    Ex_Rate=data.cashReceivedDetailDocumentExchangeRate;
                    break;
            }
                        
            var priceForeign = amountIDR/Ex_Rate;
            $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentAmountIDRTemp", amountIDR);
            $("#"+ selectedRowId + "_cashReceivedDetailDocumentAmountForeignInput").val(priceForeign);  
            $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentAmountForeignTemp", priceForeign);
            calculateCashReceivedBalance();
           }
   
    function calculateCashReceivedBalance(){
        var amountForeign=0;
        var amountIDR=0;
        var totalPaymentForeign=parseFloat(txtCashReceivedTotalTransactionAmountForeign.val().replace(/,/g,""));
        var totalPaymentIDR=parseFloat(txtCashReceivedTotalTransactionAmountIDR.val().replace(/,/g,""));
        var ids = jQuery("#cashReceivedDetailDocumentInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',ids[i]);
            amountForeign +=parseFloat(data.cashReceivedDetailDocumentAmountForeignTemp);
            amountIDR +=parseFloat(data.cashReceivedDetailDocumentAmountIDRTemp);
        }        
        var sumAmountForeign=totalPaymentForeign- amountForeign;
        var sumAmountForeignLetter;
        if(sumAmountForeign < 0){
           sumAmountForeignLetter="-" + formatNumber(Math.abs(sumAmountForeign),2);
        }else{
            sumAmountForeignLetter=formatNumber(sumAmountForeign,2); 
        }
        
        var sumAmountIDR=totalPaymentIDR - amountIDR;
        var sumAmountIDRLetter;
        if(sumAmountIDR < 0){
           sumAmountIDRLetter="-" + formatNumber(Math.abs(sumAmountIDR),2);
        }else{
            sumAmountIDRLetter=formatNumber(sumAmountIDR,2); 
        }
       
        txtCashReceivedTotalBalanceForeign.val(sumAmountForeignLetter);
        txtCashReceivedTotalBalanceIDR.val(sumAmountIDRLetter);
        
    }

    function validateCashReceivedDetailNumberOfGridAmount(){
        
        var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        
        $("#"+selectedRowId+"_cashReceivedDetailDocumentDebitForeign").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#"+selectedRowId+"_cashReceivedDetailDocumentDebitIDR").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#"+selectedRowId+"_cashReceivedDetailDocumentCreditForeign").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#"+selectedRowId+"_cashReceivedDetailDocumentCreditIDR").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
    }
    
    function onChangeCashPamentDetailCharOfAccount(){
        var selectedRowID = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");
        var chartOfAccountCode = $("#" + selectedRowID + "_cashReceivedDetailDocumentChartOfAccountCode").val();
        var url = "master/chart-of-account-get";
        var params = "chartOfAccount.code=" + chartOfAccountCode;
            params+= "&chartOfAccount.accountType=S";
            params+= "&chartOfAccount.activeStatus=TRUE";
            
        if(chartOfAccountCode===""){
            $("#" + selectedRowID + "_cashReceivedDetailDocumentChartOfAccountCode").val("");
            $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"cashReceivedDetailDocumentChartOfAccountName"," ");
            return;
        }
            
        $.post(url, params, function(result) {
            var data = (result);
            if (data.chartOfAccountTemp){
                $("#" + selectedRowID + "_cashReceivedDetailDocumentChartOfAccountCode").val(data.chartOfAccountTemp.code);
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"cashReceivedDetailDocumentChartOfAccountName",data.chartOfAccountTemp.name);
            }
            else{
                alertMessage("COA Not Found",$("#" + selectedRowID + "_cashReceivedDetailDocumentChartOfAccountCode"));
                $("#" + selectedRowID + "_cashReceivedDetailDocumentChartOfAccountCode").val("");
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"cashReceivedDetailDocumentChartOfAccountName"," ");
            }
        });
    }
    
    
    $('#cashReceived_btnBranch').click(function(ev) {
        window.open("./pages/search/search-branch.jsp?iddoc=cashReceived&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
    });
        
    function cashReceivedDetailDocumentInputGrid_SearchAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=cashReceivedDetailDocument&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function generalJournalDocumentInputGrid_SearchAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=generalJournalDocument&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function cashReceivedDetailDocumentInputGrid_SearchDocument_OnClick(){
        window.open("./pages/search/search-finance-document.jsp?iddoc=cashReceivedDetailDocument&idfin=BKM&type=grid&firstDate="+$("#cashReceivedTransactionDateFirstSession").val()+"&lastDate="+$("#cashReceivedTransactionDateLastSession").val(),"Search", "scrollbars=1, width=900, height=600");
    }
    
    function cashReceivedDetailDocumentInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row");
            return;
        }
        
        $("#cashReceivedDetailDocumentInput_grid").jqGrid('delRowData',selectDetailRowId);

    }
        
    function changeCashReceivedDocumentType(type) {
        
        var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        $("#" + selectedRowId + "_cashReceivedDetailDocumentTransactionStatus").val(type);
    }
    
    function cashReceivedLoadDataDetail() {
        
        var url = "finance/cash-received-detail-data";
        var params = "cashReceived.code=" + txtCashReceivedCode.val();
            
        $.getJSON(url, params, function(data) {
            cashReceivedDetaillastRowId = 0;
                    
            for (var i=0; i<data.listCashReceivedDetailTemp.length; i++) {
                
                var transactionType=data.listCashReceivedDetailTemp[i].transactionStatus;
                var currencyCodeDocument="";
                var exchangeRateDocument="0.00";
                    
                switch(transactionType){
                    case "Transaction":
                        currencyCodeDocument=data.listCashReceivedDetailTemp[i].currencyCode;
                        exchangeRateDocument=data.listCashReceivedDetailTemp[i].exchangeRate;
                        break;
                    case "Other":
                        currencyCodeDocument=txtCashReceivedCurrencyCode.val();
                        exchangeRateDocument=removeCommas(txtCashReceivedExchangeRate.val());
                        break;
                }
                
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("addRowData", cashReceivedDetaillastRowId, data.listCashReceivedDetailTemp[i]);
                $("#cashReceivedDetailDocumentInput_grid").jqGrid('setRowData',cashReceivedDetaillastRowId,{
                    cashReceivedDetailDocumentDocumentNo         : data.listCashReceivedDetailTemp[i].documentNo,
                    cashReceivedDetailDocumentBranchCode         : data.listCashReceivedDetailTemp[i].documentBranchCode,
                    cashReceivedDetailDocumentDocumentType       : data.listCashReceivedDetailTemp[i].documentType,
//                    cashReceivedDetailBranchCode                 : data.listCashReceivedDetailTemp[i].branchCode,
                    cashReceivedDetailDocumentCurrencyCode       : currencyCodeDocument,
                    cashReceivedDetailDocumentExchangeRate       : exchangeRateDocument,
                    cashReceivedDetailDocumentAmountForeign      : data.listCashReceivedDetailTemp[i].documentAmount,
                    cashReceivedDetailDocumentAmountIDR          : data.listCashReceivedDetailTemp[i].documentAmountIDR,
                    cashReceivedDetailDocumentBalanceForeign     : data.listCashReceivedDetailTemp[i].documentBalanceAmount,
                    cashReceivedDetailDocumentBalanceIDR         : data.listCashReceivedDetailTemp[i].documentBalanceAmountIDR,
                    cashReceivedDetailDocumentTransactionStatus  : data.listCashReceivedDetailTemp[i].transactionStatus,
                    cashReceivedDetailDocumentDebitForeign       : data.listCashReceivedDetailTemp[i].debit,
                    cashReceivedDetailDocumentDebitIDR           : (parseFloat(data.listCashReceivedDetailTemp[i].debit)*exchangeRateDocument),
                    cashReceivedDetailDocumentCreditForeign      : data.listCashReceivedDetailTemp[i].credit,
                    cashReceivedDetailDocumentCreditIDR          : (parseFloat(data.listCashReceivedDetailTemp[i].credit)* exchangeRateDocument),
                    cashReceivedDetailDocumentChartOfAccountCode : data.listCashReceivedDetailTemp[i].chartOfAccountCode,
                    cashReceivedDetailDocumentChartOfAccountName : data.listCashReceivedDetailTemp[i].chartOfAccountName,
                    cashReceivedDetailDocumentRemark             : data.listCashReceivedDetailTemp[i].remark
                });
            cashReceivedDetaillastRowId++;
            }
        });
    }
     
    function clearCashReceivedInputanGridPerRow(selectedRowId){

        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentBranchCode", " ");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentDocumentType", " ");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentDocumentNo", " ");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentAmountForeign", " ");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentAmountIDR", " ");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentBalanceForeign", " ");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentBalanceIDR", " ");
        $("#"+ selectedRowId + "_cashReceivedDetailDocumentAmountForeignInput").val("0.0000");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentAmountForeignTemp", "0.0000");
        $("#"+ selectedRowId + "_cashReceivedDetailDocumentAmountIDRInput").val("0.0000");
        $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentAmountIDRTemp", "0.0000");
    }
    
    function refreshCashReceivedInputanGridByOthersTransactionStatus(){
        var selectedRowId = $("#cashReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#cashReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        var transactionStatus = $("#"+ selectedRowId + "_cashReceivedDetailDocumentTransactionStatus").val();
        var documentNo=data.cashReceivedDetailDocumentDocumentNo;
        
        switch(transactionStatus){
            case "---Select---":
                clearCashReceivedInputanGridPerRow(selectedRowId);
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentExchangeRate", " ");
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentCurrencyCode", " ");
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentBranchCode", txtCashReceivedBranchCode.val());
                $("#btncashReceivedDetailDocumentActiveInputanAmountForeignIDR").trigger('click');
                break;
            case "Transaction":
                if(documentNo===" "){
                    clearCashReceivedInputanGridPerRow(selectedRowId);
                    $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentExchangeRate", txtCashReceivedExchangeRate.val().replace(/,/g, ""));
                    $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentCurrencyCode", txtCashReceivedCurrencyCode.val());
                    $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentBranchCode", txtCashReceivedBranchCode.val());
                }
                $("#btncashReceivedDetailDocumentActiveInputanAmountForeignIDR").trigger('click');
                break;
            case "Other":
                clearCashReceivedInputanGridPerRow(selectedRowId);
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentExchangeRate", txtCashReceivedExchangeRate.val().replace(/,/g, ""));
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentCurrencyCode", txtCashReceivedCurrencyCode.val());
                $("#cashReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "cashReceivedDetailDocumentBranchCode", txtCashReceivedBranchCode.val());
                $("#btncashReceivedDetailDocumentActiveInputanAmountForeignIDR").trigger('click');
                break;
        }
       
        
    }
    
    function formatDateBKM(){
        var transactionDate=$("#cashReceived\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpCashReceivedTransactionDate.val(transactionDateValue);
        $("#cashReceivedTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var createdDate=$("#cashReceived\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpCashReceivedCreatedDate.val(createdDateValue);
        $("#cashReceivedTemp\\.createdDateTemp").val(createdDateValue);
    }
    
    function formatNumericBKM(){
        var exchangerateHeaderFormat =parseFloat(txtCashReceivedExchangeRate.val());
        txtCashReceivedExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));
        
        var totalTransactionAmountFormat =parseFloat(txtCashReceivedTotalTransactionAmountForeign.val());
        txtCashReceivedTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));
        
        var totalTransactionAmountIDRFormat =parseFloat(txtCashReceivedTotalTransactionAmountIDR.val());
        txtCashReceivedTotalTransactionAmountIDR.val(formatNumber(totalTransactionAmountIDRFormat,2));
                
        var cashReceivedTotalDebitForeign=parseFloat($("#cashReceivedTotalDebitForeign").val());
        $("#cashReceivedTotalDebitForeign").val(formatNumber(cashReceivedTotalDebitForeign,2));
        
        var cashReceivedTotalDebitIDR=parseFloat($("#cashReceivedTotalDebitIDR").val());
        $("#cashReceivedTotalDebitIDR").val(formatNumber(cashReceivedTotalDebitIDR,2));
        
        var cashReceivedTotalCreditForeign=parseFloat($("#cashReceivedTotalCreditForeign").val());
        $("#cashReceivedTotalCreditForeign").val(formatNumber(cashReceivedTotalCreditForeign,2));
        
        var cashReceivedTotalCreditIDR=parseFloat($("#cashReceivedTotalCreditIDR").val());
        $("#cashReceivedTotalCreditIDR").val(formatNumber(cashReceivedTotalCreditIDR,2));
        
        var cashReceivedTotalBalanceForeign=parseFloat($("#cashReceivedTotalBalanceForeign").val());
        $("#cashReceivedTotalBalanceForeign").val(formatNumber(cashReceivedTotalBalanceForeign,2));
        
        var cashReceivedTotalBalanceIDR=parseFloat($("#cashReceivedTotalBalanceIDR").val());
        $("#cashReceivedTotalBalanceIDR").val(formatNumber(cashReceivedTotalBalanceIDR,2));
        
        var forexAmount= parseFloat(txtCashReceivedForexAmount.val().replace(/,/g, ""));
        txtCashReceivedForexAmount.val(formatNumber(forexAmount,2));
        
    }
    function formatNumericBKM2(){
        var exchangerateHeaderFormat =parseFloat(txtCashReceivedExchangeRate.val());
        txtCashReceivedExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));
        
        var totalTransactionAmountFormat =parseFloat(txtCashReceivedTotalTransactionAmountForeign.val());
        txtCashReceivedTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));
                        
    }
    
    function UnFormatNumericBKM(){
        var exchangerateHeaderFormat = txtCashReceivedExchangeRate.val().replace(/,/g, "");
        txtCashReceivedExchangeRate.val(exchangerateHeaderFormat);
        var totalTransactionAmountFormat = txtCashReceivedTotalTransactionAmountForeign.val().replace(/,/g, "");
        txtCashReceivedTotalTransactionAmountForeign.val(totalTransactionAmountFormat);
        var totalTransactionAmountIDRFormat = txtCashReceivedTotalTransactionAmountIDR.val().replace(/,/g, "");
        txtCashReceivedTotalTransactionAmountIDR.val(totalTransactionAmountIDRFormat);
        
        var cashReceivedTotalDebitForeign=$("#cashReceivedTotalDebitForeign").val().replace(/,/g, "");
        $("#cashReceivedTotalDebitForeign").val(cashReceivedTotalDebitForeign);
        
        var cashReceivedTotalDebitIDR=$("#cashReceivedTotalDebitIDR").val().replace(/,/g, "");
        $("#cashReceivedTotalDebitIDR").val(cashReceivedTotalDebitIDR);
        
        var cashReceivedTotalCreditForeign=$("#cashReceivedTotalCreditForeign").val().replace(/,/g, "");
        $("#cashReceivedTotalCreditForeign").val(cashReceivedTotalCreditForeign);
        
        var cashReceivedTotalCreditIDR=$("#cashReceivedTotalCreditIDR").val().replace(/,/g, "");
        $("#cashReceivedTotalCreditIDR").val(cashReceivedTotalCreditIDR);
        
        var cashReceivedTotalBalanceForeign=$("#cashReceivedTotalBalanceForeign").val().replace(/,/g, "");
        $("#cashReceivedTotalBalanceForeign").val(cashReceivedTotalBalanceForeign);
        
        var cashReceivedTotalBalanceIDR=$("#cashReceivedTotalBalanceIDR").val().replace(/,/g, "");
        $("#cashReceivedTotalBalanceIDR").val(cashReceivedTotalBalanceIDR);
        
        var forexAmount= txtCashReceivedForexAmount.val().replace(/,/g, "");
        txtCashReceivedForexAmount.val(forexAmount);
    }
    
    function cashReceivedLoadExchangeRate(){
        if($("#cashReceivedUpdateMode").val()==="false"){
            if(txtCashReceivedCurrencyCode.val()==="IDR"){
                txtCashReceivedExchangeRate.val("1.00");
                txtCashReceivedExchangeRate.attr('readonly',true);
            }else{
                txtCashReceivedExchangeRate.val("0.00");
                txtCashReceivedExchangeRate.attr('readonly',false);
            }
        }else{
            if(txtCashReceivedCurrencyCode.val()==="IDR"){
                txtCashReceivedExchangeRate.val("1.00");
                txtCashReceivedExchangeRate.attr('readonly',true);
            }else{
                txtCashReceivedExchangeRate.attr('readonly',false);
            }
        }
    }
    
    function onChangeCashReceivedTransactionType(){
        var transactionType=$("#cashReceived\\.transactionType").val();
        switch(transactionType){
            case "Regular":
                $('#cashReceivedTransactionTypeRadRegular').prop('checked',true);
                break;
            case "Deposit":
                $('#cashReceivedTransactionTypeRadDeposit').prop('checked',true);
                break;
        }
    }
    
    function handlers_input_cash_received(){
                
        if(dtpCashReceivedTransactionDate.val()===""){
            handlersInput(dtpCashReceivedTransactionDate);
        }else{
            unHandlersInput(dtpCashReceivedTransactionDate);
        }
        
        if(txtCashReceivedBranchCode.val()===""){
            handlersInput(txtCashReceivedBranchCode);
        }else{
            unHandlersInput(txtCashReceivedBranchCode);
        }
       
        
        if(txtCashReceivedCashAccountCode.val()===""){
            handlersInput(txtCashReceivedCashAccountCode);
        }else{
            unHandlersInput(txtCashReceivedCashAccountCode);
        }
        
        if(txtCashReceivedReceivedFrom.val()===""){
            handlersInput(txtCashReceivedReceivedFrom);
        }else{
            unHandlersInput(txtCashReceivedReceivedFrom);
        }
        if(txtCashReceivedCustomerCode.val()===""){
            handlersInput(txtCashReceivedCustomerCode);
        }else{
            unHandlersInput(txtCashReceivedCustomerCode);
        }
        if(txtCashReceivedCurrencyCode.val()===""){
            handlersInput(txtCashReceivedCurrencyCode);
        }else{
            unHandlersInput(txtCashReceivedCurrencyCode);
        }
        
        if(parseFloat(removeCommas(txtCashReceivedExchangeRate.val()))>0){
            unHandlersInput(txtCashReceivedExchangeRate);
        }else{
            handlersInput(txtCashReceivedExchangeRate);
        }
    }
    
</script>

<b>CASH RECEIVED</b>
<hr>
<br class="spacer" />

<s:url id="remoteurlCashReceivedDetailDocumentInput" action="" />

<div id="cashReceivedInput" class="content ui-widget">
        <s:form id="frmCashReceivedInput">
            <table id="cashReceivedHeaderInput" cellpadding="2" cellspacing="2" width="100%">
              
                <tr>
                    <td align="right"><B>Code *</B></td>
                    <td colspan="2">
                        <s:textfield id="cashReceived.code" name="cashReceived.code" key="cashReceived.code" readonly="true" size="22"></s:textfield>
                        <s:textfield id="cashReceivedUpdateMode" name="cashReceivedUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td colspan="4">
                        <sj:datepicker id="cashReceived.transactionDate" name="cashReceived.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" onchange="cashReceivedTransactionDateOnChange()"></sj:datepicker>
                        <sj:datepicker id="cashReceivedTransactionDate" name="cashReceivedTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                        <s:textfield id="cashReceivedTemp.transactionDateTemp" name="cashReceivedTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                        <sj:datepicker id="cashReceivedTransactionDateFirstSession" name="cashReceivedTransactionDateFirstSession" size="20" showOn="focus" cssStyle="display:none"></sj:datepicker>
                        <sj:datepicker id="cashReceivedTransactionDateLastSession" name="cashReceivedTransactionDateLastSession" size="20" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    </td>
                </tr>
                 <tr>
                    <td align="right" style="width:120px"><B>Branch *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">

                            txtCashReceivedBranchCode.change(function(ev) {

                                if(txtCashReceivedBranchCode.val()===""){
                                    txtCashReceivedBranchName.val("");
                                    return;
                                }
                                var url = "master/branch-get";
                                var params = "branch.code=" + txtCashReceivedBranchCode.val();
                                    params += "&branch.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.branchTemp){
                                        txtCashReceivedBranchCode.val(data.branchTemp.code);
                                        txtCashReceivedBranchName.val(data.branchTemp.name);
                                    }
                                    else{
                                        alertMessage("Branch Not Found!",txtCashReceivedBranchCode);
                                        txtCashReceivedBranchCode.val("");
                                        txtCashReceivedBranchName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header" hidden="true">
                            <s:textfield id="cashReceived.branch.code" name="cashReceived.branch.code" required="true" cssClass="required" title=" " size="22"></s:textfield>
                            <sj:a id="cashReceived_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-cash-received"/></sj:a>
                        </div>
                        <s:textfield id="cashReceived.branch.name" name="cashReceived.branch.name" size="40" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Cash Account *</B></td>
                    <td colspan="3">
                        <script type = "text/javascript">
                            txtCashReceivedCashAccountCode.change(function(ev) {
                                
                                if(txtCashReceivedCashAccountCode.val()===""){
                                    txtCashReceivedCashAccountName.val("");
                                    txtCashReceivedCashAccountBKMVoucherNo.val("");
                                    txtCashReceivedCashAccountChartOfAccountCode.val("");
                                    txtCashReceivedCashAccountChartOfAccountName.val("");
                                    return;
                                }
                                
                                var url = "master/cash-account-get";
                                var params = "cashAccount.code=" + txtCashReceivedCashAccountCode.val();
                                    params+= "&cashAccount.activeStatus=TRUE";
                                
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    
                                    if (data.cashAccountTemp){
                                        txtCashReceivedCashAccountCode.val(data.cashAccountTemp.code);
                                        txtCashReceivedCashAccountName.val(data.cashAccountTemp.name);
                                        txtCashReceivedCashAccountBKMVoucherNo.val(data.cashAccountTemp.bkmVoucherNo);
                                        txtCashReceivedCashAccountChartOfAccountCode.val(data.cashAccountTemp.chartOfAccountCode);
                                        txtCashReceivedCashAccountChartOfAccountName.val(data.cashAccountTemp.chartOfAccountName);
                                    }
                                    else{
                                        alertMessage("Cash Account Not Found!",txtCashReceivedCashAccountCode);
                                        txtCashReceivedCashAccountCode.val("");
                                        txtCashReceivedCashAccountName.val("");
                                        txtCashReceivedCashAccountBKMVoucherNo.val("");
                                        txtCashReceivedCashAccountChartOfAccountCode.val("");
                                        txtCashReceivedCashAccountChartOfAccountName.val("");
                                    }
                                });
                            });
                            if($("#cashReceivedUpdateMode").val()==="true"){
                                txtCashReceivedCashAccountCode.attr("readonly",true);
                                $("#cashReceived_btnCashAccount").hide();
                                $("#ui-icon-search-cash-account-cash-received").hide();
                            }else{
                                txtCashReceivedCashAccountCode.attr("readonly",false);
                                $("#cashReceived_btnCashAccount").show();
                                $("#ui-icon-search-cash-account-cash-received").show();
                            }
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="cashReceived.cashAccount.code" name="cashReceived.cashAccount.code" required="true" cssClass="required" title=" " size="22"></s:textfield>
                            <sj:a id="cashReceived_btnCashAccount" href="#" openDialog="" >&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-cash-account-cash-received"/></sj:a>
                        </div>
                        <s:textfield id="cashReceived.cashAccount.name" name="cashReceived.cashAccount.name" size="40" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Voucher No. </B></td>
                    <td colspan="2">
                        <s:textfield id="cashReceived.cashAccount.bkmVoucherNo" name="cashReceived.cashAccount.bkmVoucherNo" size="22" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Account No. </B></td>
                    <td colspan="2">
                        <s:textfield id="cashReceived.cashAccount.chartOfAccount.code" name="cashReceived.cashAccount.chartOfAccount.code" size="22" readonly="true"></s:textfield>
                        <s:textfield id="cashReceived.cashAccount.chartOfAccount.name" name="cashReceived.cashAccount.chartOfAccount.name" size="40" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Currency *</B></td>
                    <td colspan="3">
                        <script type = "text/javascript">
                                              
                            txtCashReceivedCurrencyCode.change(function(ev) {
                                
                                if(txtCashReceivedCurrencyCode.val()===""){
                                    txtCashReceivedCurrencyName.val("");
                                    txtCashReceivedExchangeRate.val("0.00");
                                    txtCashReceivedExchangeRate.attr('readonly',true);
                                    return;
                                }
                                
                                var url = "master/currency-get";
                                var params = "currency.code=" + txtCashReceivedCurrencyCode.val();
                                    params+= "&currency.activeStatus=TRUE";
                                    
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.currencyTemp){
                                        txtCashReceivedCurrencyCode.val(data.currencyTemp.code);
                                        txtCashReceivedCurrencyName.val(data.currencyTemp.name);
                                        cashReceivedLoadExchangeRate();
                                    }
                                    else{
                                        alertMessage("Currency Not Found",txtCashReceivedCurrencyCode);
                                        txtCashReceivedCurrencyCode.val("");
                                        txtCashReceivedCurrencyName.val("");
                                        txtCashReceivedExchangeRate.val("0.00");
                                        txtCashReceivedExchangeRate.attr("readonly",true);
                                        calculateCashReceivedTotalTransactionAmountIDR();
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="cashReceived.currency.code" name="cashReceived.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="cashReceived_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        <s:textfield id="cashReceived.currency.name" name="cashReceived.currency.name" size="40" readonly="true"></s:textfield>
                        <s:textfield id="cashReceivedCurrencyCodeSession" name="cashReceivedCurrencyCodeSession" size="20" cssStyle="display:none"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Type *</B></td>
                    <td>
                        <s:textfield id="cashReceived.transactionType" name="cashReceived.transactionType" cssStyle="display:none"></s:textfield>
                        <s:radio id="cashReceivedTransactionTypeRad" name="cashReceivedTransactionTypeRad" label="type" list="{'Regular','Deposit'}" value='"Regular"'/>
                    </td> 
                </tr>
                <tr>
                    <td align="right"><B>from *<B/></td>
                    <td><s:textfield id="cashReceived.receivedFrom" name="cashReceived.receivedFrom" title=" " required="true" cssClass="required" size="27"></s:textfield></td>
                </tr>
               
                <tr>
                    <td align="right"><B>Exchange Rate *</B></td>
                    <td colspan="2"><s:textfield id="cashReceived.exchangeRate" name="cashReceived.exchangeRate" size="20" cssStyle="text-align:right" onkeyup="calculateCashReceivedTotalTransactionAmountIDR()" required="true" cssClass="required" readonly="true"></s:textfield><B>IDR</B>&nbsp;<span id="errmsgExchangeRate"></span></td>
                </tr>
                <tr>
                    <td align="right"><B>Amount *</B></td>
                    <td colspan="2">
                        <s:textfield id="cashReceived.totalTransactionAmount" name="cashReceived.totalTransactionAmount" size="20" cssStyle="text-align:right"  onkeyup="calculateCashReceivedTotalTransactionAmountIDR()"></s:textfield>
                        <s:textfield id="cashReceived.totalTransactionAmountIDR" name="cashReceived.totalTransactionAmountIDR" size="30" cssStyle="text-align:right" readonly="true" required="true" cssClass="required" value="0.00"></s:textfield>(Debit)&nbsp;<span id="errmsgTotalTransactionAmount"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td colspan="3"><s:textfield id="cashReceived.refNo" name="cashReceived.refNo"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td colspan="2"><s:textarea id="cashReceived.remark" name="cashReceived.remark"  cssStyle="width:40%" rows="2" height="20"></s:textarea></td>
                </tr>
                <tr hidden="true">
                    <td>
                        <s:textfield id="cashReceived.createdBy" name="cashReceived.createdBy" key="cashReceived.createdBy" readonly="true" size="22"></s:textfield>
                        <sj:datepicker id="cashReceived.createdDate" name="cashReceived.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                        <s:textfield id="cashReceivedTemp.createdDateTemp" name="cashReceivedTemp.createdDateTemp" size="20"></s:textfield>
                        <s:textfield id="cashReceivedDetailCOASalesDownPaymentCode" name="cashReceivedDetailCOASalesDownPaymentCode" size="20"></s:textfield>
                        <s:textfield id="cashReceivedDetailCOASalesDownPaymentName" name="cashReceivedDetailCOASalesDownPaymentName" size="20"></s:textfield>
                    </td>
                </tr>
            </table>
        </s:form>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmCashReceived" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCashReceived" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <table width="20%">
            <tr>
                <td>
                    <sj:a href="#" id="btnCashReceivedAddDetail" button="true" style="width: 90%">Finance Document</sj:a> 
                </td>
            </tr>
        </table>                 
                <div id="cashReceivedDetailDocumentInputGrid">
                <sjg:grid
                    id="cashReceivedDetailDocumentInput_grid"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listCashReceivedDetailTemp"
                    rowList="10,20,30"
                    rowNum="10"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnuCashReceivedDetailDocument').width()"
                    editurl="%{remoteurlCashReceivedDetailDocumentInput}"
                    onSelectRowTopics="cashReceivedDetailDocumentInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name = "cashReceivedDetailDocumentTemp" index="cashReceivedDetailDocumentTemp" key="cashReceivedDetailDocumentTemp" 
                        width="50"  editable="true"  hidden="true" title=""
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentDelete" index="cashReceivedDetailDocumentDelete" title="" width="50" align="centre"
                        editable="true"
                        edittype="button"
                        editoptions="{onClick:'cashReceivedDetailDocumentInputGrid_Delete_OnClick()', value:'delete'}"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentDocumentType" index="cashReceivedDetailDocumentDocumentType" key="cashReceivedDetailDocumentDocumentType" title="Type" width="80" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentDocumentNo" index="cashReceivedDetailDocumentDocumentNo" 
                        key="cashReceivedDetailDocumentDocumentNo" title="Document No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentDocumentRefNo" index="cashReceivedDetailDocumentDocumentRefNo" 
                        key="cashReceivedDetailDocumentDocumentRefNo" title="Document RefNo" width="150" sortable="true" hidden="true"
                    />
                    
                   
                    <sjg:gridColumn
                        name = "cashReceivedDetailDocumentAmountIDR" index = "cashReceivedDetailDocumentAmountIDR" key = "cashReceivedDetailDocumentAmountIDR" 
                        title = "Doc Amount (IDR)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    
                    <sjg:gridColumn
                        name = "cashReceivedDetailDocumentBalanceIDR" index = "cashReceivedDetailDocumentBalanceIDR" key = "cashReceivedDetailDocumentBalanceIDR" 
                        title = "Doc Balance (IDR)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                   
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentTransactionStatus" index="cashReceivedDetailDocumentTransactionStatus" 
                        title="Transaction Status" width="150" sortable="true"
                    /> 
                    <sjg:gridColumn
                        name = "cashReceivedDetailDocumentTransactionStatusTemp" 
                        index = "cashReceivedDetailDocumentTransactionStatusTemp" 
                        key = "cashReceivedDetailDocumentTransactionStatusTemp" title = "" width = "100" hidden="true"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentDebitForeign" index="cashReceivedDetailDocumentDebitForeign" key="cashReceivedDetailDocumentDebitForeign" title="Debit (Foreign)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateCashReceivedDetailNumberOfGridAmount()',onChange:'countCasPaymentAmountIDRToForeignDebit()',onKeyUp:'countCasPaymentAmountIDRToForeignDebit()'}"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentDebitIDR" index="cashReceivedDetailDocumentDebitIDR" key="cashReceivedDetailDocumentDebitIDR" title="Debit (IDR)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateCashReceivedDetailNumberOfGridAmount()',onChange:'countCashReceivedAmountForeignToIDRDebit()',onKeyUp:'countCashReceivedAmountForeignToIDRDebit()'}"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentCreditForeign" index="cashReceivedDetailDocumentCreditForeign" key="cashReceivedDetailDocumentCreditForeign" title="Credit (Foreign)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateCashReceivedDetailNumberOfGridAmount()',onChange:'countPaymentAmountIDRToForeignCredit()',onKeyUp:'countPaymentAmountIDRToForeignCredit()'}"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentCreditIDR" index="cashReceivedDetailDocumentCreditIDR" key="cashReceivedDetailDocumentCreditIDR" title="Credit (IDR)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateCashReceivedDetailNumberOfGridAmount()',onChange:'countPaymentAmountForeignToIDRCredit()',onKeyUp:'countPaymentAmountForeignToIDRCredit()'}"
                    />
                    <sjg:gridColumn
                        name="cashReceivedDetailChartOfAccountSearch" index="cashReceivedDetailChartOfAccountSearch" title="" width="25" align="centre"
                        editable="true"
                        dataType="html"
                        edittype="button"
                        editoptions="{onClick:'cashReceivedDetailDocumentInputGrid_SearchAccount_OnClick()', value:'...'}"
                    /> 
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentChartOfAccountCode" index="cashReceivedDetailDocumentChartOfAccountCode" 
                        title="Chart Of Account Code" width="150" sortable="true" editable="true" edittype="text"
                        editoptions="{onChange:'onChangeCashPamentDetailCharOfAccount()'}"
                    />     
                    <sjg:gridColumn
                        name="cashReceivedDetailDocumentChartOfAccountName" index="cashReceivedDetailDocumentChartOfAccountName" 
                        title="Chart Of Account Name" width="200" sortable="true"
                    /> 
                     <sjg:gridColumn
                        name="cashReceivedDetailDocumentBranchCode" index="cashReceivedDetailDocumentBranchCode" key="cashReceivedDetailDocumentBranchCode" title="Branch" width="80" sortable="true"
                    />
                     <sjg:gridColumn
                        name = "cashReceivedDetailDocumentCurrencyCode" index = "cashReceivedDetailDocumentCurrencyCode" key = "cashReceivedDetailDocumentCurrencyCode" title = "Currency" width = "60" 
                    />
                    <sjg:gridColumn
                        name = "cashReceivedDetailDocumentExchangeRate" index = "cashReceivedDetailDocumentExchangeRate" key = "cashReceivedDetailDocumentExchangeRate" 
                        title = "Rate" width = "80" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name = "cashReceivedDetailDocumentBalanceForeign" index = "cashReceivedDetailDocumentBalanceForeign" key = "cashReceivedDetailDocumentBalanceForeign" 
                        title = "Doc Balance (Foreign)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                     <sjg:gridColumn
                        name = "cashReceivedDetailDocumentAmountForeign" index = "cashReceivedDetailDocumentAmountForeign" key = "cashReceivedDetailDocumentAmountForeign" 
                        title = "Doc Amount (Foreign)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name = "cashReceivedDetailDocumentRemark" index="cashReceivedDetailDocumentRemark" key="cashReceivedDetailDocumentRemark" title="Remark" width="225"  editable="true" edittype="text"
                    />
                </sjg:grid >                
            </div>
        <table width="13%">
            <tr>
                <td width="60px" align="right">
                    <s:textfield id="cashReceivedAddRow" name="cashReceivedAddRow" value="1" style="width: 60%; text-align: right;"></s:textfield>
                </td>
                <td>
                    <sj:a href="#" id="btnCashReceivedAddDetailOther" button="true" style="width: 60px">Add</sj:a> 
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td>
                    <sj:a href="#" id="btnCashReceivedSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnCashReceivedCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
                <td>
                    <table width="100%">
                        <tr>
                            <td width="20%"/>
                            <td align="middle">
                                <sj:a href="#" id="btnCashReceivedCalculate" button="true" style="width: 80px">Calculate</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="100%"/>
                <td>
                    <table width="100%" >
                        <tr>
                            <td/><td/>
                            <td height="10px" align="right" colspan="2">
                                <lable><B><u>Transaction Summary</u></B></lable>
                            </td>
                            <td width="25%"/>
                        </tr>
                        <tr>
                            <td width="22%"/>
                            <td height="10px" align="left" width="20%"><label>Foreign</label></td>
                            <td height="10px" align="left" ><label>Local</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Total(Debit)</td>
                            <td><s:textfield id="cashReceivedTotalDebitForeign" name="cashReceivedTotalDebitForeign" size="25" cssStyle="text-align:right" readonly="true" placeHolder="0.00"></s:textfield></td>
                            <td><s:textfield id="cashReceivedTotalDebitIDR" name="cashReceivedTotalDebitIDR" size="25" cssStyle="text-align:right" readonly="true" placeHolder="0.00"></s:textfield></td>
                        </tr>     
                        <tr>
                            <td style="text-align: right">Total(Credit)</td>
                            <td><s:textfield id="cashReceivedTotalCreditForeign" name="cashReceivedTotalCreditForeign" size="25" cssStyle="text-align:right" readonly="true" placeHolder="0.00"></s:textfield></td>
                            <td><s:textfield id="cashReceivedTotalCreditIDR" name="cashReceivedTotalCreditIDR" size="25" cssStyle="text-align:right" readonly="true" placeHolder="0.00"></s:textfield></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Balance</td>
                            <td><s:textfield id="cashReceivedTotalBalanceForeign" name="cashReceivedTotalBalanceForeign" size="25" cssStyle="text-align:right" readonly="true" placeHolder="0.00"></s:textfield></td>
                            <td><s:textfield id="cashReceivedTotalBalanceIDR" name="cashReceivedTotalBalanceIDR" size="25" cssStyle="text-align:right" readonly="true" placeHolder="0.00"></s:textfield></td>
                        </tr>
                        <tr>
                            <td/><td/>
                            <td height="10px" align="right" colspan="2"><lable><B><u>Forex Gain / Loss</u></B></lable></td>
                            <td width="25%"/>
                        </tr>
                        <tr>
                            <td style="text-align: right">Amount</td>
                            <td colspan="2"><s:textfield id="cashReceivedForexAmount" name="cashReceivedForexAmount" readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield><B>IDR</B></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div> 