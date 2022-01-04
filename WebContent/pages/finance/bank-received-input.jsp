
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #bankReceivedDetailDocumentInput_grid_pager_center{
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
    
    var bankReceivedDetaillastRowId=0,bankReceivedSubDetaillastRowId=0,bankReceivedDetail_lastSel = -1,bankReceivedSubDetail_lastSel=-1,selectedRowId=0;
    var flagBankReceivedIsConfirmed=false;
    var 
        txtBankReceivedCode = $("#bankReceived\\.code"),
        txtBankReceivedBranchCode = $("#bankReceived\\.branch\\.code"),
        txtBankReceivedBranchName = $("#bankReceived\\.branch\\.name"),
        txtBankReceivedDivisionCode = $("#bankReceived\\.division\\.code"),
        txtBankReceivedDivisionName = $("#bankReceived\\.division\\.name"),
        dtpBankReceivedTransactionDate = $("#bankReceived\\.transactionDate"),
        txtBankReceivedBankAccountCode=$("#bankReceived\\.bankAccount\\.code"),
        txtBankReceivedBankAccountName=$("#bankReceived\\.bankAccount\\.name"),
        txtBankReceivedCustomerCode= $("#bankReceived\\.customer\\.code"),
        txtBankReceivedCustomerName= $("#bankReceived\\.customer\\.name"),
        txtBankReceivedBankAccountChartOfAccountCode=$("#bankReceived\\.bankAccount\\.chartOfAccount\\.code"),
        txtBankReceivedBankAccountChartOfAccountName=$("#bankReceived\\.bankAccount\\.chartOfAccount\\.name"),
        txtBankReceivedBBMVoucherNo=$("#bankReceived\\.bankAccount\\.bbmVoucherNo"),
//        txtBankReceivedBankAccountChartOfAccountName=$("#bankReceived\\.bankAccount\\.chartOfAccount\\.name"),
        txtBankReceivedReceivedFrom = $("#bankReceived\\.receivedFrom"),
        txtBankReceivedCurrencyCode = $("#bankReceived\\.currency\\.code"),
        txtBankReceivedCurrencyName = $("#bankReceived\\.currency\\.name"),
        txtBankReceivedExchangeRate = $("#bankReceived\\.exchangeRate"),
        txtBankReceivedTotalTransactionAmountForeign = $("#bankReceived\\.totalTransactionAmount"),
        txtBankReceivedTotalTransactionAmountIDR = $("#bankReceived\\.totalTransactionAmountIDR"),
                
        txtBankReceivedTransferReceivedNo = $("#bankReceived\\.transferReceivedNo"),
        txtBankReceivedTransferBankName = $("#bankReceived\\.transferBankName"),
        txtBankReceivedGiroReceivedCode = $("#bankReceived\\.giroReceived\\.code"),
        dtpBankReceivedTransferReceivedDate = $("#bankReceived\\.transferReceivedDate"),
        txtBankReceivedRefNo = $("#bankReceived\\.refNo"),
        txtBankReceivedRemark = $("#bankReceived\\.remark"),
        dtpBankReceivedCreatedDate = $("#bankReceived\\.createdDate"),
        
        txtBankReceivedCurrencyCodeSession=$("#bankReceivedCurrencyCodeSession"),
        txtBankReceivedTotalBalanceIDR = $("#bankReceivedTotalBalanceIDR"),
                
        txtBankReceivedTotalDebitForeign = $("#bankReceivedTotalDebitForeign"),
        txtBankReceivedTotalDebitIDR = $("#bankReceivedTotalDebitIDR"),
        txtBankReceivedTotalCreditForeign = $("#bankReceivedTotalCreditForeign"),
        txtBankReceivedTotalCreditIDR = $("#bankReceivedTotalCreditIDR"),
        txtBankReceivedTotalBalanceForeign = $("#bankReceivedTotalBalanceForeign"),
        
        txtBankReceivedForexAmount = $("#bankReceivedForexAmount"),
        
        allBankReceivedFields = $([])
            .add(txtBankReceivedCode)
            .add(txtBankReceivedCurrencyCode)
            .add(txtBankReceivedCurrencyName)
            .add(txtBankReceivedExchangeRate)
            .add(txtBankReceivedRefNo)
            .add(txtBankReceivedRemark)
            .add(txtBankReceivedCustomerCode)
            .add(txtBankReceivedCustomerName)
            .add(txtBankReceivedTotalTransactionAmountForeign)
            .add(txtBankReceivedTotalDebitForeign)
            .add(txtBankReceivedTotalDebitIDR)
            .add(txtBankReceivedTotalCreditForeign)
            .add(txtBankReceivedTotalCreditIDR)
            .add(txtBankReceivedTotalBalanceForeign)
            .add(txtBankReceivedTotalBalanceIDR)
            .add(txtBankReceivedForexAmount)
            .add(txtBankReceivedTotalTransactionAmountIDR);

       
    $(document).ready(function() {

        flagBankReceivedIsConfirmed=false;
        bankReceivedLoadExchangeRate();
        onChangeBankReceivedTransactionType();
        formatNumericBBM2();
        validateInputanGiroReceived();
        setBankReceivedTransactionType();
        if($("#bankReceivedUpdateMode").val()==false){
            setCurrency();
        }
        
        $('input[name="bankReceivedTransactionTypeRad"][value="Regular"]').change(function(ev){
            var value="Regular";
            $("#bankReceived\\.transactionType").val(value);
        });
                
        $('input[name="bankReceivedTransactionTypeRad"][value="Deposit"]').change(function(ev){
            var value="Deposit";
            $("#bankReceived\\.transactionType").val(value);
        });
        
        
        $("#bankReceived\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        
        $("#bankReceived\\.exchangeRate").click(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommas(value); 
            });
           
        });
        
        $("#bankReceived\\.exchangeRate").change(function(e){
            var exrate=$("#bankReceived\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#bankReceived\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#bankReceived\\.totalTransactionAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        
        $("#bankReceived\\.totalTransactionAmount").change(function(e){
            var amount=$("#bankReceived\\.totalTransactionAmount").val();
            if(amount===""){
               $("#bankReceived\\.totalTransactionAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
           
        });
                 
        $('#btnBankReceivedSave').click(function(ev) {
            
            if(flagBankReceivedIsConfirmed===false){
                alertMessage("Please Confirm!",$("#btnConfirmBankReceived"));
                return;
            }
            
            $("#btnBankReceivedCalculate").trigger("click");
            if(bankReceivedDetail_lastSel !== -1) {
                    $('#bankReceivedDetailDocumentInput_grid').jqGrid("saveRow",bankReceivedDetail_lastSel); 
                }

                var ids = jQuery("#bankReceivedDetailDocumentInput_grid").jqGrid('getDataIDs'); 
                var totalBalanceForeign = parseFloat(removeCommas(txtBankReceivedTotalBalanceForeign.val()));
                var totalBalanceIDR = parseFloat(removeCommas(txtBankReceivedTotalBalanceIDR.val()));
                var headerCurrency = txtBankReceivedCurrencyCode.val();
                
                // cek isi detail
                if(ids.length===0){
                    alertMessage("Grid Bank Received Detail Is Not Empty");
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
//                    if (totalBalanceIDR !== 0) {
//                        alertMessage("Balance IDR Must be 0");
//                        return;
//                    }
                }
                
                var listBankReceivedDetail = new Array(); 
                                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 
                    var documentNo = data.bankReceivedDetailDocumentDocumentNo;
                    var transactionStatus = data.bankReceivedDetailDocumentTransactionStatus;
                    var documentAccountName = data.bankReceivedDetailDocumentChartOfAccountName;
                    var amountCheck = parseFloat(data.bankReceivedDetailDocumentAmountForeignInput);
                    
                    var debitValue=parseFloat(data.bankReceivedDetailDocumentDebitForeign);
                    var creditValue=parseFloat(data.bankReceivedDetailDocumentCreditForeign);
                    
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
   
                    var automationTransactionStatus = '';
                    if(data.bankReceivedDetailDocumentDocumentNo === " "){
                        automationTransactionStatus = 'Other';
                    }else{
                        automationTransactionStatus = 'Transaction';
                    }
                    var bankReceivedDetail = { 
                        documentNo           : data.bankReceivedDetailDocumentDocumentNo,
                        documentBranchCode   : data.bankReceivedDetailDocumentBranchCode,
                        documentType         : data.bankReceivedDetailDocumentDocumentType,
                        currency             : {code:data.bankReceivedDetailDocumentCurrencyCode},
                        exchangeRate         : data.bankReceivedDetailDocumentExchangeRate,
                        chartOfAccount       : {code:data.bankReceivedDetailDocumentChartOfAccountCode},
                        transactionStatus    : automationTransactionStatus,
                        amount               : data.bankReceivedDetailDocumentAmountForeignInput,
                        amountIDR            : data.bankReceivedDetailDocumentAmountIDRInput,
                        debit                : data.bankReceivedDetailDocumentDebitForeign,
                        debitIDR             : data.bankReceivedDetailDocumentDebitIDR,
                        credit               : data.bankReceivedDetailDocumentCreditForeign,
                        creditIDR            : data.bankReceivedDetailDocumentCreditIDR,
                        branch               : {code:data.bankReceivedDetailBranchCode},
                        remark               : data.bankReceivedDetailDocumentRemark
                    };

                    listBankReceivedDetail[i] = bankReceivedDetail;
                }
                
                formatDateBBM();
                unFormatNumericBBM();
                var forexAmount=txtBankReceivedForexAmount.val();
                 
                var url = "finance/bank-received-save";
                var params = $("#frmBankReceivedInput").serialize();
                    params += "&listBankReceivedDetailJSON=" + $.toJSON(listBankReceivedDetail);
                    params += "&forexAmount=" + forexAmount;
                
                showLoading();
                
                $.post(url, params, function(data) {
                    closeLoading();
                    if (data.error) {
                        formatDateBBM();
                        formatNumericBBM();
                        alertMessage(data.errorMessage);
                        return;
                    }
                    
                    closeLoading();
                    
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
                                    var url = "finance/bank-received-input";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuBANK_RECEIVED");
                                }
                            },
                            {
                                text : "No",
                                click : function() {

                                    $(this).dialog("close");
                                    var url = "finance/bank-received";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuBANK_RECEIVED");
                                }
                            }]
                    });
                });
        });
        $("#btnBankReceivedAddDetail").css("display", "none");
        $("#btnBankReceivedAddDetailOther").css("display", "none");
        
        $("#btnUnConfirmBankReceived").css("display", "none");
        $('#bankReceivedDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#btnConfirmBankReceived").click(function(ev) {
            handlers_input_bank_received();
            if(!$("#frmBankReceivedInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            }

            if($("#bankReceived\\.totalTransactionAmountIDR").val()==0.00){
                alertMessage("Amount Cant be 0.00!!");
                return;
            }
            if(parseFloat(txtBankReceivedExchangeRate.val())<=1 && txtBankReceivedCurrencyCode.val()!=="IDR"){
           
                txtBankReceivedExchangeRate.attr("style","color:red");
                alertMessageNotif("Exchange Rate : "+txtBankReceivedCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtBankReceivedExchangeRate.attr("style","color:black");
            }
           
            
            
            var date1 = dtpBankReceivedTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#bankReceivedTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#bankReceivedUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#bankReceivedTransactionDate").val(),dtpBankReceivedTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpBankReceivedTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#bankReceivedUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#bankReceivedTransactionDate").val(),dtpBankReceivedTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpBankReceivedTransactionDate);
                }
                return;
            }

//            var date = $("#bankReceived\\.transactionDate").val().split("/");
//            var month = date[1];
//            var year = date[2].split(" ");
//            if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
//                alertMessage("Transaction Month Must Between Session Period Month!",dtpBankReceivedTransactionDate);
//                return;
//            }
//
//            if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
//                alertMessage("Transaction Year Must Between Session Period Year!",dtpBankReceivedTransactionDate);
//                return;
//            }    
                    
//            if($("#bankReceivedUpdateMode").val()==="true"){
//                bankReceivedLoadDataDetail();
//            }
            
            flagBankReceivedIsConfirmed=true;
            $("#btnUnConfirmBankReceived").css("display", "block");
            $("#btnConfirmBankReceived").css("display", "none");
            $("#btnBankReceivedAddDetail").css("display", "block");
            $("#btnBankReceivedAddDetailOther").css("display", "block");
            $('#headerInputBankReceived').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
           
            if($("#bankReceivedUpdateMode").val()==="false"){
            $('#bankReceivedDetailDocumentInputGrid').unblock();
            }
            if($("#bankReceived\\.transactionType").val() === "DEPOSIT" || $("#bankReceived\\.transactionType").val() === "Deposit"){
                $('#bankReceivedDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                var defRow = {
                    bankReceivedDetailDocumentDocumentNo            : " ",
                    bankReceivedDetailBranchCode                    : txtBankReceivedBranchCode.val(),
                    bankReceivedDetailDocumentBranchCode            : txtBankReceivedBranchCode.val(),  
                    bankReceivedDetailDocumentBranchCode            : txtBankReceivedBranchCode.val(),                    
                    bankReceivedDetailDocumentCurrencyCode          : txtBankReceivedCurrencyCode.val(),
                    bankReceivedDetailDocumentExchangeRate          : removeCommas(txtBankReceivedExchangeRate.val()),
                    bankReceivedDetailDocumentTransactionStatus     : "Other",
                    bankReceivedDetailDocumentCreditForeign         : removeCommas(txtBankReceivedTotalTransactionAmountForeign.val()),
                    bankReceivedDetailDocumentCreditIDR             : removeCommas(txtBankReceivedTotalTransactionAmountIDR.val()),
                    bankReceivedDetailDocumentChartOfAccountCode    : $("#bankReceivedDetailCOASalesDownPaymentCode").val(),
                    bankReceivedDetailDocumentChartOfAccountName    : $("#bankReceivedDetailCOASalesDownPaymentName").val()
                };
                
                bankReceivedDetaillastRowId++;
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("addRowData", bankReceivedDetaillastRowId, defRow);
                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#bankReceivedDetailDocumentInput_grid").jqGrid('setRowData',bankReceivedDetaillastRowId,{Buttons:be});
                ev.preventDefault();
                $("#btnBankReceivedAddDetail").css("display", "none");
                $("#btnBankReceivedAddDetailOther").css("display", "none");
            }
            if(($("#bankReceived\\.transactionType").val() === "Regular")||($("#bankReceived\\.transactionType").val() === "REGULAR")){
                if ($("#bankReceivedUpdateMode").val()==="true"){
                    $("#btnbankReceivedAddDetail").css("display", "block");
                    $("#btnBankReceivedAddDetailOther").css("display", "block");
                    $('#bankReceivedDetailDocumentInputGrid').unblock();
                    bankReceivedLoadDataDetail();}
                else if ($("#bankReceivedUpdateMode").val()==="false"){
                    $("#btnbankReceivedAddDetail").css("display", "block");
                    $("#btnBankReceivedAddDetailOther").css("display", "block");
                    $('#bankReceivedDetailDocumentInputGrid').unblock();
                }
                $("#btnBankReceivedAddDetail").css("display", "block");
                $("#btnBankReceivedAddDetailOther").css("display", "block");
            }
            
        if(txtBankReceivedCurrencyCode.val()==="IDR"){
            $("#bankReceivedDetailDocumentInput_grid").jqGrid('hideCol',[,"bankReceivedDetailDocumentDebitForeign","bankReceivedDetailDocumentCreditForeign"]);
        }else{
            $("#bankReceivedDetailDocumentInput_grid").jqGrid('showCol',[,"bankReceivedDetailDocumentDebitForeign","bankReceivedDetailDocumentCreditForeign"]);
        }
   
           
        });
        
        $("#btnUnConfirmBankReceived").click(function(ev) {

            var rows = jQuery("#bankReceivedDetailDocumentInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagBankReceivedIsConfirmed=false;       
                $("#btnBankReceivedAddDetail").css("display", "none");
                $("#btnBankReceivedAddDetailOther").css("display", "none");
                $("#btnUnConfirmBankReceived").css("display", "none");
                $("#btnConfirmBankReceived").css("display", "block");
                $('#headerInputBankReceived').unblock();
                $('#bankReceivedDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                            flagBankReceivedIsConfirmed=false;
                            $(this).dialog("close");
                            $("#btnBankReceivedAddDetail").css("display", "none");
                            $("#btnBankReceivedAddDetailOther").css("display", "none");
                            $("#bankReceivedDetailDocumentInput_grid").jqGrid('clearGridData');
                            $("#bankReceivedSubDetailDocumentInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmBankReceived").css("display", "none");
                            $("#btnConfirmBankReceived").css("display", "block");
                            $('#headerInputBankReceived').unblock();
                            $('#bankReceivedDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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

     
        $.subscribe("bankReceivedDetailDocumentInput_grid_onSelect", function() {
            var selectedRowID = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");

//            validateNumberOfBankReceivedGridAmount();

            if(selectedRowID!==bankReceivedDetail_lastSel) {

                $('#bankReceivedDetailDocumentInput_grid').jqGrid("saveRow",bankReceivedDetail_lastSel); 
                $('#bankReceivedDetailDocumentInput_grid').jqGrid("editRow",selectedRowID,true);            

                bankReceivedDetail_lastSel=selectedRowID;

            }else{
                $('#bankReceivedDetailDocumentInput_grid').jqGrid("saveRow",selectedRowID);
            }

            $("#btnbankReceivedDetailDocumentActiveInputanAmountForeignIDR").trigger('click');
        });
     
        $('#btnBankReceivedAddDetail').click(function(ev) {

                if(flagBankReceivedIsConfirmed===false){
                    alertMessage("Please Confirm!",$("#btnConfirmBankReceived"));
                    return;
                }
                
                if($("#bankReceived\\.transactionType").val()=== "REGULAR" ||$("#bankReceived\\.transactionType").val()=== "Regular"){
                
                window.open("./pages/search/search-finance-document.jsp?iddoc=bankReceivedDetailDocument&type=grid&idfin=BBM&firstDate="+$("#bankReceivedTransactionDateFirstSession").val()+"&rowLast="+bankReceivedDetaillastRowId+"&lastDate="+$("#bankReceivedTransactionDateLastSession").val()+"&customerCode="+txtBankReceivedCustomerCode.val()+"&customerName="+txtBankReceivedCustomerName.val(),"Search", "scrollbars=1, width=900, height=600");

                }else{
                    alertMessage("Hanya Boleh Satu Document Untuk Deposit [DP]!");
                }
                
        });
        $('#btnBankReceivedAddDetailOther').click(function(ev) {

            if(!flagBankReceivedIsConfirmed){
                alertMessage("Please Confirm!",$("#btnConfirmBankReceived"));
                return;
            }
            
            if($("#bankReceived\\.transactionType").val()!== "Deposit"){
                var AddRowCount =parseFloat(removeCommas($("#bankReceivedAddRow").val()));
                var currencyHeader = txtBankReceivedCurrencyCode.val();
                var exchangeRateHeader = txtBankReceivedExchangeRate.val();

                for(var i=0; i<AddRowCount; i++){
                    var defRow = {
                        bankReceivedDetailBranchCode                  :txtBankReceivedBranchCode.val(),
                        bankReceivedDetailDocumentDocumentNo          :" ",
                        bankReceivedDetailDocumentChartOfAccountName  :" ",
                        bankReceivedDetailDocumentCurrencyCode        :currencyHeader,
                        bankReceivedDetailDocumentExchangeRate        :exchangeRateHeader,
                        bankReceivedDetailDocumentTransactionStatus   :"Other"
                    };
                    bankReceivedDetaillastRowId++;
                    $("#bankReceivedDetailDocumentInput_grid").jqGrid("addRowData", bankReceivedDetaillastRowId, defRow);

                    be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                    $("#bankReceivedDetailDocumentInput_grid").jqGrid('setRowData',bankReceivedDetaillastRowId,{Buttons:be});
                }

                $("#bankReceivedAddRow").val("1");
            }else{
                alertMessage("Hanya Boleh Satu Document Untuk Deposit [DP]!");
            }
            
        });      
    
        $('#btnbankReceivedDetailDocumentActiveInputanAmountForeignIDR').click(function(ev) {
            var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
            var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);

            var documentNo=data.bankReceivedDetailDocumentDocumentNo;

            var transactionStatus=$("#"+ selectedRowId + "_bankReceivedDetailDocumentTransactionStatus").val();

            switch(transactionStatus){
                case "---Select---":
                    $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountForeignInput").attr("readonly",true);
                    $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountIDRInput").attr("readonly",true);
                    break;
                case "Transaction":
                        if(documentNo!==" "){
                            $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountForeignInput").attr("readonly",false);
                            $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountIDRInput").attr("readonly",false);
                        }else{
                            $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountForeignInput").attr("readonly",true);
                            $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountIDRInput").attr("readonly",true);
                        }
                    break;
                case "Other":
                    $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountForeignInput").attr("readonly",true);
                    $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountForeignInput").attr("readonly",false);
                    $("#"+selectedRowId+"_bankReceivedDetailDocumentAmountIDRInput").attr("readonly",false);
                    break;
            } 
        });
    
        
        $('#btnBankReceivedCancel').click(function(ev) {
            var url = "finance/bank-received";
            var params = "";
            pageLoad(url, params, "#tabmnuBANK_RECEIVED"); 

        });
        $('#bankReceived_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=bankReceived&idsubdoc=customer","Search", "scrollbars=1, width=600, height=500");
        });
        $('#bankReceived_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=bankReceived&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#bankReceived_btnDivision').click(function(ev) {
            window.open("./pages/search/search-division.jsp?iddoc=bankReceived&idsubdoc=division","Search", "Scrollbars=1,width=600, height=500");
        });
        $('#bankReceived_btnBankAccount').click(function(ev) {
            window.open("./pages/search/search-bank-account.jsp?iddoc=bankReceived&idsubdoc=bankAccount","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#bankReceived_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=bankReceived&idsubdoc=currency","Search", "scrollbars=1, width=600, height=500");
        });
    });//EOF Ready
    
    function bankReceivedTransactionDateOnChange(){
        if($("#bankReceivedUpdateMode").val()!=="true"){
            $("#bankReceivedTransactionDate").val(dtpBankReceivedTransactionDate.val());
        }
    }
    
    function setBankReceivedTransactionType(){
        var modeUpdate=$("#bankReceivedUpdateMode").val();
        switch(modeUpdate){
            case "true":
                switch($("#bankReceived\\.transactionType").val()){
                    case "REGULAR":
                        $('input[name="bankReceivedTransactionTypeRad"][value="Regular"]').prop('checked',true);
                        $('#bankReceivedTransactionTypeRadDeposit').attr('disabled', true);
                        break;
                    case "DEPOSIT":
                        $('input[name="bankReceivedTransactionTypeRad"][value="Deposit"]').prop('checked',true);
                        $('#bankReceivedTransactionTypeRadRegular').attr('disabled', true);
                        break;
                } 
            break;
        }
    }
  
    
    function addRowBankReceivedDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#bankReceivedDetailDocumentInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
               
        var data= $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',lastRowId);
        
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("addRowData", lastRowId, defRow);
        $("#bankReceivedDetailDocumentInput_grid").jqGrid('setRowData',lastRowId,{
            bankReceivedDetailDocumentDelete                        :"delete",
            bankReceivedDetailDocumentBranchCode                    : defRow.branchCode,
            bankReceivedDetailDocumentDocumentNo                    : defRow.documentNo,
            bankReceivedDetailDocumentDocumentType                  : defRow.documentType,
            bankReceivedDetailDocumentCurrencyCode                  : defRow.currencyCode,
            bankReceivedDetailDocumentExchangeRate                  : defRow.exchangeRate

        });
        bankReceivedDetaillastRowId++;
        setHeightGridHeader();
        $("#btnBankReceivedCalculate").trigger("click");
    }
    function setHeightGridHeader(){
        var ids = jQuery("#bankReceivedDetailDocumentInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#bankReceivedDetailDocumentInput_grid"+" tr").eq(1).height();
            $("#bankReceivedDetailDocumentInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#bankReceivedDetailDocumentInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    function formatDateBBM(){
        var transactionDate=$("#bankReceived\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpBankReceivedTransactionDate.val(transactionDateValue);
        $("#bankReceivedTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var createdDate=$("#bankReceived\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpBankReceivedCreatedDate.val(createdDateValue);
        $("#bankReceivedTemp\\.createdDateTemp").val(createdDateValue);

        var tanggalTransferDate=$("#bankReceived\\.transferReceivedDate").val().split(' ');
        var tanggalTransferDateTemp=tanggalTransferDate[0].split('/');
        var tanggalTransferDateValue=tanggalTransferDateTemp[1]+"/"+tanggalTransferDateTemp[0]+"/"+tanggalTransferDateTemp[2]+" "+tanggalTransferDate[1];
        dtpBankReceivedTransferReceivedDate.val(tanggalTransferDateValue);
        $("#bankReceivedTemp\\.transferReceivedDateTemp").val(tanggalTransferDateValue);
    }

    function formatNumericBBM2(){
        var exchangerateHeaderFormat =parseFloat(txtBankReceivedExchangeRate.val());
        txtBankReceivedExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));
        
        var totalTransactionAmountFormat =parseFloat(txtBankReceivedTotalTransactionAmountForeign.val());
        txtBankReceivedTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));
                        
    }
    
    function formatNumericBBM(){
        var exchangerateHeaderFormat =parseFloat(txtBankReceivedExchangeRate.val()) ;
        txtBankReceivedExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));

        var totalTransactionAmountFormat =parseFloat(txtBankReceivedTotalTransactionAmountForeign.val()) ;
        txtBankReceivedTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));

        var totalTransactionAmountIDRFormat = parseFloat(txtBankReceivedTotalTransactionAmountIDR.val());
        txtBankReceivedTotalTransactionAmountIDR.val(formatNumber(totalTransactionAmountIDRFormat,2));

        var totalBalanceForeign=parseFloat(txtBankReceivedTotalBalanceForeign.val());
        txtBankReceivedTotalBalanceForeign.val(formatNumber(totalBalanceForeign,2));

        var totalBalanceIDR=parseFloat(txtBankReceivedTotalBalanceIDR.val());
        txtBankReceivedTotalBalanceIDR.val(formatNumber(totalBalanceIDR,2));

        var totalDebitForeign=parseFloat(txtBankReceivedTotalDebitForeign.val());
        txtBankReceivedTotalDebitForeign.val(formatNumber(totalDebitForeign,2));

        var totalDebitIDR=parseFloat(txtBankReceivedTotalDebitIDR.val());
        txtBankReceivedTotalDebitIDR.val(formatNumber(totalDebitIDR,2));

        var totalCreditForeign=parseFloat(txtBankReceivedTotalCreditForeign.val());
        txtBankReceivedTotalCreditForeign.val(formatNumber(totalCreditForeign,2));

        var totalCreditIDR=parseFloat(txtBankReceivedTotalCreditIDR.val());
        txtBankReceivedTotalCreditIDR.val(formatNumber(totalCreditIDR,2));

        var forexAmount= parseFloat(txtBankReceivedForexAmount.val());
        txtBankReceivedForexAmount.val(formatNumber(forexAmount,2));
    }

    function unFormatNumericBBM(){
        var exchangerateHeaderFormat = txtBankReceivedExchangeRate.val().replace(/,/g, "");
        txtBankReceivedExchangeRate.val(exchangerateHeaderFormat);

        var totalTransactionAmountFormat = txtBankReceivedTotalTransactionAmountForeign.val().replace(/,/g, "");
        txtBankReceivedTotalTransactionAmountForeign.val(totalTransactionAmountFormat);

        var totalTransactionAmountIDRFormat = txtBankReceivedTotalTransactionAmountIDR.val().replace(/,/g, "");
        txtBankReceivedTotalTransactionAmountIDR.val(totalTransactionAmountIDRFormat);

        var totalBalanceForeign=txtBankReceivedTotalBalanceForeign.val().replace(/,/g, "");
        txtBankReceivedTotalBalanceForeign.val(totalBalanceForeign);

        var totalBalanceIDR=txtBankReceivedTotalBalanceIDR.val().replace(/,/g, "");
        txtBankReceivedTotalBalanceIDR.val(totalBalanceIDR);

        var totalDebitForeign=txtBankReceivedTotalDebitForeign.val().replace(/,/g, "");
        txtBankReceivedTotalDebitForeign.val(totalDebitForeign);

        var totalDebitIDR=txtBankReceivedTotalDebitIDR.val().replace(/,/g, "");
        txtBankReceivedTotalDebitIDR.val(totalDebitIDR);

        var totalCreditForeign=txtBankReceivedTotalCreditForeign.val().replace(/,/g, "");
        txtBankReceivedTotalCreditForeign.val(totalCreditForeign);

        var totalCreditIDR=txtBankReceivedTotalCreditIDR.val().replace(/,/g, "");
        txtBankReceivedTotalCreditIDR.val(totalCreditIDR);

        var forexAmount= txtBankReceivedForexAmount.val().replace(/,/g, "");
        txtBankReceivedForexAmount.val(forexAmount);
    }
        
    function validateInputanGiroReceived(){
        calculateBankReceivedTotalTransactionAmountIDR();
        var type=$("#frmBankReceivedInput_bankReceived_receivedType").val();
        switch(type){
            case "Giro":
                $("#bankReceived\\.giroReceived\\.code").addClass("required");
                $("#bankReceived\\.giroReceived\\.code").addClass("cssClass");
                $("#bankReceived\\.giroReceived\\.code").css("required",true);
                $("#bankReceived\\.giroReceived\\.code").css("cssClass","required");
                $(".labelGiroCode").show();
                $(".textLookupGiroReceived").show();
                $(".labelReceivedRefNo").text("Giro Ref No");
                $(".labelReceivedDate").text("Giro Date");
                $(".labelReceivedBankName").text("Giro Bank Name");
                txtBankReceivedTotalTransactionAmountForeign.attr("readonly", true);
                $("#bankReceived\\.receivedFrom").attr("readonly",true);
                $("#bankReceived\\.transferReceivedNo").attr("readonly",true);
                $("#bankReceived\\.transferReceivedDate").attr("readonly",true);
                $("#bankReceived\\.transferBankName").attr("readonly",true);
                break;
            case "Transfer":
                $("#bankReceived\\.giroReceived\\.code").removeClass("required");
                $("#bankReceived\\.giroReceived\\.code").removeClass("cssClass");
                $("#bankReceived\\.giroReceived\\.code").css("required",false);
                $(".labelGiroCode").hide();
                $(".textLookupGiroReceived").hide();
                $(".labelReceivedDate").text("Transfer Date");
                $(".labelReceivedRefNo").text("Transfer Ref No");
                $(".labelReceivedBankName").text("Transfer Bank Name");
                txtBankReceivedTotalTransactionAmountForeign.attr("readonly", false);
                $("#bankReceived\\.receivedFrom").attr("readonly",false);
                $("#bankReceived\\.transferReceivedNo").attr("readonly",false);
                $("#bankReceived\\.transferReceivedDate").attr("readonly",false);
                $("#bankReceived\\.transferBankName").attr("readonly",false);
                var transferDate=dtpBankReceivedTransactionDate.val();
                dtpBankReceivedTransferReceivedDate.val(transferDate);
                break;
            case "Other":
                $("#bankReceived\\.giroReceived\\.code").removeClass("required");
                $("#bankReceived\\.giroReceived\\.code").removeClass("cssClass");
                $("#bankReceived\\.giroReceived\\.code").css("required",false);
                $(".labelGiroCode").hide();
                $(".textLookupGiroReceived").hide();
                $(".labelReceivedDate").text("Other Date");
                $(".labelReceivedRefNo").text("Other Ref No");
                $(".labelReceivedBankName").text("Other Bank Name");
                txtBankReceivedTotalTransactionAmountForeign.attr("readonly", false);
                $("#bankReceived\\.receivedFrom").attr("readonly",false);
                $("#bankReceived\\.transferReceivedNo").attr("readonly",false);
                $("#bankReceived\\.transferReceivedDate").attr("readonly",false);
                $("#bankReceived\\.transferBankName").attr("readonly",false);
                var otherDate=dtpBankReceivedTransactionDate.val();
                dtpBankReceivedTransferReceivedDate.val(otherDate);
                break;
        }
    }

    function onChangeBankReceivedType(){
        unHandlersInput(txtBankReceivedGiroReceivedCode);
        unHandlersInput(txtBankReceivedReceivedFrom);
        unHandlersInput(txtBankReceivedTotalTransactionAmountForeign);
        txtBankReceivedGiroReceivedCode.val("");
        txtBankReceivedTransferReceivedNo.val("");
        txtBankReceivedTransferBankName.val("");
        txtBankReceivedTotalTransactionAmountForeign.val("0.00");
        $("#bankReceived\\.receivedFrom").val("");
        validateInputanGiroReceived();
    }
    
    function clearInputanBankReceivedDetailGrid(selectedRowId){
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentBranchCode", " ");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentDocumentType", " ");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentDocumentNo", " ");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountForeign", " ");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountIDR", " ");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentBalanceForeign", " ");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentBalanceIDR", " ");
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentAmountForeignInput").val("0.0000");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountForeignTemp", "0.0000");
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentAmountIDRInput").val("0.0000");
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountIDRTemp", "0.0000");
    }
    
    function resetBankReceivedDetailGridByTransactionStatus(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        var transactionStatus = $("#"+ selectedRowId + "_bankReceivedDetailDocumentTransactionStatus").val();
        var documentNo=data.bankReceivedDetailDocumentDocumentNo;
        
        switch(transactionStatus){
            case "---Select---":
                clearInputanBankReceivedDetailGrid(selectedRowId);
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentExchangeRate", " ");
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentCurrencyCode", " ");
                $("#btnbankReceivedDetailDocumentActiveInputanAmountForeignIDR").trigger('click');
                break;
            case "Transaction":
                if(documentNo===" "){
                    clearInputanBankReceivedDetailGrid(selectedRowId);
                    $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentExchangeRate", txtBankReceivedExchangeRate.val().replace(/,/g, ""));
                    $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentCurrencyCode", txtBankReceivedCurrencyCode.val());
                    $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentBranchCode", txtBankReceivedBranchCode.val());
                }
                $("#btnbankReceivedDetailDocumentActiveInputanAmountForeignIDR").trigger('click');
                break;
            case "Other":
                clearInputanBankReceivedDetailGrid(selectedRowId);
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentExchangeRate", txtBankReceivedExchangeRate.val().replace(/,/g, ""));
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentCurrencyCode", txtBankReceivedCurrencyCode.val());
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentBranchCode", " ");
                $("#btnbankReceivedDetailDocumentActiveInputanAmountForeignIDR").trigger('click');
                break;
        }
       
        
    }
    
    function calculateBankReceivedTotalTransactionAmountIDR(){
        
        var totalTransactionAmount=$("#bankReceived\\.totalTransactionAmount").val().replace(/,/g,"");
        var exchangeRate=$("#bankReceived\\.exchangeRate").val().replace(/,/g,"");
        var totalTransactionAmountIDR=(parseFloat(totalTransactionAmount)* parseFloat(exchangeRate));
        if(totalTransactionAmount===""){
            $("#bankReceived\\.totalTransactionAmountIDR").val("0.00");
        }else{
            $("#bankReceived\\.totalTransactionAmountIDR").val(formatNumber(totalTransactionAmountIDR,2));
        }
    }
    
    
    function calculateBankReceivedAmountIDRToForeign(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var amountForeign = $("#"+ selectedRowId + "_bankReceivedDetailDocumentAmountForeignInput").val();
        
        if(amountForeign===""){
            $("#"+ selectedRowId + "_bankReceivedDetailDocumentAmountForeignInput").val("0.00");
            $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountForeignTemp", "0.00");
        }
        
        var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        var transactionStatus=$("#"+ selectedRowId + "_bankReceivedDetailDocumentTransactionStatus").val();
        
        var currencyCodeHeader=txtBankReceivedCurrencyCode.val();
        var currencyCodeDetail=data.bankReceivedDetailDocumentCurrencyCode;
        var currencyCodeSession=txtBankReceivedCurrencyCodeSession.val();
        var Ex_Rate;
        switch(transactionStatus){
            case "Transaction":
                if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail!==currencyCodeSession){
                    Ex_Rate=data.bankReceivedDetailDocumentExchangeRate;
                }
                if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail===currencyCodeSession){
                    Ex_Rate=txtBankReceivedExchangeRate.val().replace(/,/g, "");
                }
                if(currencyCodeHeader===currencyCodeSession){
                    Ex_Rate=data.bankReceivedDetailDocumentExchangeRate;
                }
                break;
            case "Other":
                Ex_Rate=data.bankReceivedDetailDocumentExchangeRate;
                break;
        }
                        
        var priceIDR =Ex_Rate *amountForeign;
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountForeignTemp", amountForeign);
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentAmountIDRInput").val(priceIDR);  
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountIDRTemp", priceIDR);
        calculateBankReceivedBalance();
    }
    
        
    function calculateBankReceivedAmountForeignToIDR(){
        
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var amountIDR = $("#"+ selectedRowId + "_bankReceivedDetailDocumentAmountIDRInput").val();

        var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        var transactionStatus=$("#"+ selectedRowId + "_bankReceivedDetailDocumentTransactionStatus").val();

        var currencyCodeHeader=txtBankReceivedCurrencyCode.val();
        var currencyCodeDetail=data.bankReceivedDetailDocumentCurrencyCode;
        var currencyCodeSession=txtBankReceivedCurrencyCodeSession.val();
        var Ex_Rate;
        switch(transactionStatus){
            case "Transaction":
                if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail!==currencyCodeSession){
                    Ex_Rate=data.bankReceivedDetailDocumentExchangeRate;
                }
                if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail===currencyCodeSession){
                    Ex_Rate=txtBankReceivedExchangeRate.val().replace(/,/g, "");
                }
                if(currencyCodeHeader===currencyCodeSession){
                    Ex_Rate=data.bankReceivedDetailDocumentExchangeRate;
                }
                break;
            case "Other":
                Ex_Rate=data.bankReceivedDetailDocumentExchangeRate;
                break;
        }
                        
        var priceForeign = amountIDR/Ex_Rate;
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountIDRTemp", amountIDR);
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentAmountForeignInput").val(priceForeign);  
        $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "bankReceivedDetailDocumentAmountForeignTemp", priceForeign);
        calculateBankReceivedBalance();
    }
   
    function calculateBankReceivedBalance(){
        var amountForeign=0;
        var amountIDR=0;
        var ids = jQuery("#bankReceivedDetailDocumentInput_grid").jqGrid('getDataIDs');
           
        for(var i=0;i < ids.length;i++) {
            var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',ids[i]);
            amountForeign +=parseFloat(data.bankReceivedDetailDocumentAmountForeignTemp);
            amountIDR +=parseFloat(data.bankReceivedDetailDocumentAmountIDRTemp);
        }        
        var sumAmountForeign=0- amountForeign;
        var sumAmountForeignLetter;
        if(sumAmountForeign < 0){
           sumAmountForeignLetter="-" + formatNumber(Math.abs(sumAmountForeign),4);
        }else{
            sumAmountForeignLetter=formatNumber(sumAmountForeign,4); 
        }
        
        var sumAmountIDR=0 - amountIDR;
               
        txtBankReceivedTotalBalanceForeign.val(sumAmountForeignLetter);
        txtBankReceivedTotalBalanceIDR.val(formatNumber(sumAmountIDR,4));
        
    }
    
           
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
        
//    function validateNumberOfBankReceivedGridAmount(){
//        
//        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
//        
//        $("#"+selectedRowId+"_bankReceivedDetailDocumentDebitForeign").keypress(function(e){
//           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
//               return false;
//           }
//        });
//    }
    

    
    function bankReceivedDetailDocumentInputGrid_SearchAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=bankReceivedDetailDocument&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function bankReceivedDetailDocumentInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        $("#bankReceivedDetailDocumentInput_grid").jqGrid('delRowData',selectDetailRowId);
        
        //calculateHeader();
        
    }
    
    $('#bankReceived_btnGiroReceived').click(function(ev) {
        var type=$("#frmBankReceivedInput_bankReceived_receivedType").val();
        if(type==="Giro"){
            if(txtBankReceivedCurrencyCode.val()===""){
                alertMessage("Pilih Currency!",txtBankReceivedCurrencyCode);
                return;
            }
        }
        
        window.open("./pages/search/search-giro-received.jsp?iddoc=bankReceived&idcurr="+txtBankReceivedCurrencyCode.val()+"&firstDate="+$("#bankReceivedTransactionDateFirstSession").val()+"&lastDate="+$("#bankReceivedTransactionDateLastSession").val(),"Search", "scrollbars=1,width=600, height=500");
    });
    
    $('#btnBankReceivedCalculate').click(function(ev) {
            
        if(bankReceivedDetail_lastSel !== -1) {
            $('#bankReceivedDetailDocumentInput_grid').jqGrid("saveRow",bankReceivedDetail_lastSel); 
        }

        var ids = jQuery("#bankReceivedDetailDocumentInput_grid").jqGrid('getDataIDs'); 

        var exchangeRate=$("#bankReceived\\.exchangeRate").val().replace(/,/g,"");
        
        var DebitForeign=$("#bankReceived\\.totalTransactionAmount").val().replace(/,/g,"");
        var DebitIDR = (parseFloat(DebitForeign)* parseFloat(exchangeRate));
        
        var CreditForeign = 0; 
        var CreditIDR = 0;

        var BalanceForeign = 0;
        var BalanceIDR = 0;

        var nilaiForexHeader = 0;

        DebitForeign = parseFloat(DebitForeign);
        DebitIDR = parseFloat(DebitIDR);

        for(var i=0;i < ids.length;i++){ 
            var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 

            var documentDebitForeign = data.bankReceivedDetailDocumentDebitForeign;
//            var documentDebitIDR = data.bankReceivedDetailDocumentDebitIDR;
            var documentCreditForeign = data.bankReceivedDetailDocumentCreditForeign;
//            var documentCreditIDR = data.bankReceivedDetailDocumentCreditIDR;

            var headerRate = txtBankReceivedExchangeRate.val().replace(/,/g,"");
            var headerCurrency = txtBankReceivedCurrencyCode.val();



            var documentRate = data.bankReceivedDetailDocumentExchangeRate;
            var documentCurrency = data.bankReceivedDetailDocumentCurrencyCode;

            var documentDebitIDR = documentDebitForeign * documentRate;
            $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", ids[i],"bankReceivedDetailDocumentDebitIDR",documentDebitIDR);

            var documentCreditIDR = documentCreditForeign * documentRate;
            $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", ids[i],"bankReceivedDetailDocumentCreditIDR",documentCreditIDR);
            
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

//                        alert("selisih kurs: " + selisihKurs);
//                        alert("nilai dokumen: " + nilaiDokumen);
//                        alert("nilai forex: " + nilaiForex);

                    nilaiForexHeader = parseFloat(nilaiForexHeader) + nilaiForex;
                }
            }

            DebitForeign = (parseFloat(DebitForeign) + parseFloat(documentDebitForeign)).toFixed(2);
            DebitIDR = parseFloat(DebitIDR) + parseFloat(documentDebitIDR);
//                
            CreditForeign = (parseFloat(CreditForeign) + parseFloat(documentCreditForeign)).toFixed(2);
            CreditIDR = parseFloat(CreditIDR) + parseFloat(documentCreditIDR);
        }
        
        var splitDebitForeign=DebitForeign.split('.');
        var DebitForeignFormat;
        if(splitDebitForeign[0].length>3){
            var concatDebitForeign=parseFloat(splitDebitForeign[0]+'.'+splitDebitForeign[1]);
            DebitForeignFormat=formatNumber(concatDebitForeign,2);
        }else{
            DebitForeignFormat=splitDebitForeign[0]+'.'+splitDebitForeign[1];
        }

        txtBankReceivedTotalDebitForeign.val(DebitForeignFormat);
        txtBankReceivedTotalDebitIDR.val(formatNumber(DebitIDR,2));

        
        var splitCreditForeign=CreditForeign.split('.');
        var CreditForeignFormat;
        if(splitCreditForeign[0].length>3){
            var concatCreditForeign=parseFloat(splitCreditForeign[0]+'.'+splitCreditForeign[1]);
            CreditForeignFormat=formatNumber(concatCreditForeign,2);
        }else{
            CreditForeignFormat=splitCreditForeign[0]+'.'+splitCreditForeign[1];
        }

        txtBankReceivedTotalCreditForeign.val(CreditForeignFormat);
        txtBankReceivedTotalCreditIDR.val(formatNumber(parseFloat(CreditIDR.toFixed(2)),2));

        BalanceForeign = (DebitForeign - CreditForeign).toFixed(2);
        BalanceIDR = DebitIDR - CreditIDR;

        
        var splitBalanceForeign=BalanceForeign.split('.');
        var BalanceForeignFormat;
        if(splitBalanceForeign[0].length>3){
            var concatBalanceForeign=parseFloat(splitBalanceForeign[0]+'.'+splitBalanceForeign[1]);
            BalanceForeignFormat=formatNumber(parseFloat(concatBalanceForeign),2);
        }else{
            BalanceForeignFormat=splitBalanceForeign[0]+'.'+splitBalanceForeign[1];
        }

        txtBankReceivedTotalBalanceForeign.val(BalanceForeignFormat);
        txtBankReceivedTotalBalanceIDR.val(formatNumber(BalanceIDR,2));

        txtBankReceivedForexAmount.val(formatNumber(nilaiForexHeader,2));
    });
    
    function calculateBankReceivedAmountIDRToForeignDebit(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.bankReceivedDetailDocumentExchangeRate;
        var DebitForeign = $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitForeign").val();
        if(DebitForeign===""){
            DebitForeign=0.00;
        }
        var DebitIDR = (parseFloat(DebitForeign) * parseFloat(Ex_Rate)).toFixed(2);
        
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitIDR").val(DebitIDR);
        
    }
    
    function validateOnchangeBankReceivedDetailDocumentDebitForeignAmount(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var DebitForeign = $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitForeign").val();
        if(DebitForeign===""){
            $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitForeign").val("0.00");
        }
    }
    
    function validateOnchangeBankReceivedDetailDocumentDebitIdrAmount(){
        
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var DebitIDR = $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitIDR").val();
        if(DebitIDR===""){
            $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitIDR").val("0.00");
        }
    }
    
    function validateOnchangeBankReceivedDetailDocumentCreditForeignAmount(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var CreditForeign = $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditForeign").val();
        if(CreditForeign===""){
            $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditForeign").val("0.00");
        }
    }
    
    function validateOnchangeBankReceivedDetailDocumentCreditIdrAmount(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var CreditIDR = $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditIDR").val();
        if(CreditIDR===""){
            $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditIDR").val("0.00");
        }
    }
    
    function calculateBankReceivedAmountForeignToIDRDebit(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.bankReceivedDetailDocumentExchangeRate;
        var DebitIDR = $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitIDR").val();
        if(DebitIDR===""){
            DebitIDR=0.00;
        }
        
        var DebitForeign = (parseFloat(DebitIDR) / parseFloat(Ex_Rate)).toFixed(2);
        
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentDebitForeign").val(DebitForeign);
        
    }
    
    
    
    
    function calculateBankReceivedAmountIDRToForeignCredit(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.bankReceivedDetailDocumentExchangeRate;
        var CreditForeign = $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditForeign").val();
        if(CreditForeign===""){
            CreditForeign=0;
        }
        
        var CreditIDR = (parseFloat(CreditForeign) * parseFloat(Ex_Rate)).toFixed(2);
        
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditIDR").val(CreditIDR);
        
    }
    
    function calculateBankReceivedAmountForeignToIDRCredit(){
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#bankReceivedDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.bankReceivedDetailDocumentExchangeRate;
        var CreditIDR = $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditIDR").val();
        if(CreditIDR===""){
            CreditIDR=0;
        }
        
        var CreditForeign = (parseFloat(CreditIDR) / parseFloat(Ex_Rate)).toFixed(2);
        
        $("#"+ selectedRowId + "_bankReceivedDetailDocumentCreditForeign").val(CreditForeign);
        
    }
    
    function changeBankReceivedDocumentType(type) {
        
        var selectedRowId = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        $("#" + selectedRowId + "_bankReceivedDetailDocumentTransactionStatus").val(type);
    }
    
    
    function bankReceivedLoadDataDetail() {
        
        var url = "finance/bank-received-detail-data";
        var params = "bankReceived.code=" + txtBankReceivedCode.val();
            
        $.getJSON(url, params, function(data) {
            bankReceivedDetaillastRowId = 0;
                    
            for (var i=0; i<data.listBankReceivedDetailTemp.length; i++) {
                
                var transactionType=data.listBankReceivedDetailTemp[i].transactionStatus;
                var currencyCodeDocument="";
                var exchangeRateDocument="0.00";
                    
                switch(transactionType){
                    case "Transaction":
                        currencyCodeDocument=data.listBankReceivedDetailTemp[i].currencyCode;
                        exchangeRateDocument=data.listBankReceivedDetailTemp[i].exchangeRate;
                        break;
                    case "Other":
                        currencyCodeDocument=txtBankReceivedCurrencyCode.val();
                        exchangeRateDocument=removeCommas(txtBankReceivedExchangeRate.val());
                        break;
                }
                
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("addRowData", bankReceivedDetaillastRowId, data.listBankReceivedDetailTemp[i]);
                $("#bankReceivedDetailDocumentInput_grid").jqGrid('setRowData',bankReceivedDetaillastRowId,{
                    bankReceivedDetailDocumentDocumentNo         : data.listBankReceivedDetailTemp[i].documentNo,
                    bankReceivedDetailDocumentBranchCode         : data.listBankReceivedDetailTemp[i].branchCode,
                    bankReceivedDetailDocumentDocumentType       : data.listBankReceivedDetailTemp[i].documentType,
                    bankReceivedDetailDocumentCurrencyCode       : currencyCodeDocument,
                    bankReceivedDetailDocumentExchangeRate       : exchangeRateDocument,
                    bankReceivedDetailDocumentAmountForeign      : data.listBankReceivedDetailTemp[i].documentAmount,
                    bankReceivedDetailDocumentAmountIDR          : data.listBankReceivedDetailTemp[i].documentAmountIDR,
                    bankReceivedDetailDocumentBalanceForeign     : data.listBankReceivedDetailTemp[i].documentBalanceAmount,
                    bankReceivedDetailDocumentBalanceIDR         : data.listBankReceivedDetailTemp[i].documentBalanceAmountIDR,
                    bankReceivedDetailDocumentTransactionStatus  : data.listBankReceivedDetailTemp[i].transactionStatus,
                    bankReceivedDetailDocumentDebitForeign       : data.listBankReceivedDetailTemp[i].debit,
                    bankReceivedDetailDocumentDebitIDR           : (parseFloat(data.listBankReceivedDetailTemp[i].debit)*exchangeRateDocument),
                    bankReceivedDetailDocumentCreditForeign      : data.listBankReceivedDetailTemp[i].credit,
                    bankReceivedDetailDocumentCreditIDR          : (parseFloat(data.listBankReceivedDetailTemp[i].credit)* exchangeRateDocument),
                    bankReceivedDetailDocumentChartOfAccountCode : data.listBankReceivedDetailTemp[i].chartOfAccountCode,
                    bankReceivedDetailDocumentChartOfAccountName : data.listBankReceivedDetailTemp[i].chartOfAccountName,
                    bankReceivedDetailBranchCode                 : data.listBankReceivedDetailTemp[i].branchCode,
                    bankReceivedDetailDocumentRemark             : data.listBankReceivedDetailTemp[i].remark
                });
            bankReceivedDetaillastRowId++;
            }
        });
    }
    
    function readOnlyGiro(status) {
//        txtBankReceivedGiroReceivedCode.attr("readonly", status);
//        dtpBankReceivedTransferReceivedDate.attr("readonly", status);
//        txtBankReceivedTransferReceivedNo.attr("readonly", status);
//        txtBankReceivedTransferBankName.attr("readonly", status);
//        txtBankReceivedCurrencyCode.attr("readonly", status);
        //txtBankReceivedCurrencyName.attr("readonly", status);
        txtBankReceivedTotalTransactionAmountForeign.attr("readonly", status);
        
//        $('#bankReceived_btnCurrency').removeAttr('id');
    }
        
    function onChangeBankReceivedDetailCOA(){
        var selectedRowID = $("#bankReceivedDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");
            var coaCode = $("#" + selectedRowID + "_bankReceivedDetailDocumentChartOfAccountCode").val();
            var url = "master/chart-of-account-get";
            var params = "chartOfAccount.code=" + coaCode;
                params+= "&chartOfAccount.accountType=S";
                params+= "&chartOfAccount.activeStatus=TRUE";
            
            if(coaCode===""){
                $("#" + selectedRowID + "_bankReceivedDetailDocumentChartOfAccountCode").val("");
                $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"bankReceivedDetailDocumentChartOfAccountName"," ");
                return;
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.chartOfAccountTemp){
                    $("#" + selectedRowID + "_bankReceivedDetailDocumentChartOfAccountCode").val(data.chartOfAccountTemp.code);
                    $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"bankReceivedDetailDocumentChartOfAccountName",data.chartOfAccountTemp.name);
                }
                else{
                    alertMessage("COA Not Found!",$("#" + selectedRowID + "_bankReceivedDetailDocumentChartOfAccountCode"));
                    $("#" + selectedRowID + "_bankReceivedDetailDocumentChartOfAccountCode").val("");
                    $("#bankReceivedDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"bankReceivedDetailDocumentChartOfAccountName"," ");
                }
            });
    }
    
    function calculateBankReceivedTotalTransactionAmountIDR(){
        
        var totalTransactionAmount=removeCommas($("#bankReceived\\.totalTransactionAmount").val());
        var exchangeRate=removeCommas($("#bankReceived\\.exchangeRate").val());
        var totalTransactionAmountIDR=(parseFloat(totalTransactionAmount)* parseFloat(exchangeRate));
        if(totalTransactionAmount===""){
            $("#bankReceived\\.totalTransactionAmountIDR").val("0.00");
        }else{
            $("#bankReceived\\.totalTransactionAmountIDR").val(formatNumber(totalTransactionAmountIDR,2));
        }
        
    }
    
    function bankReceivedLoadExchangeRate(){ 
        if (txtBankReceivedCurrencyCode.val()==="IDR"){
            txtBankReceivedExchangeRate.val("1.00");
            txtBankReceivedExchangeRate.attr("readonly",true);
        }else{
            if($("#bankReceivedUpdateMode").val()==="false"){
                txtBankReceivedExchangeRate.val("0.00");   
            }
            txtBankReceivedExchangeRate.attr("readonly",false);
        }
    }
    
    function onChangeBankReceivedTransactionType(){
        var transactionType=$("#bankReceived\\.transactionType").val();
        switch(transactionType){
            case "Regular":
                $('#bankReceivedTransactionTypeRadRegular').prop('checked',true);
                break;
            case "Deposit":
                $('#bankReceivedTransactionTypeRadDeposit').prop('checked',true);
                break;
        }
    }
    function setCurrency(){

            var url = "master/currency-get";
            var params = "currency.code=IDR";
                params+= "&currency.activeStatus=TRUE";

            $.post(url, params, function(result) {
                var data = (result);
                if (data.currencyTemp){
                    txtBankReceivedCurrencyCode.val(data.currencyTemp.code);
                    txtBankReceivedCurrencyName.val(data.currencyTemp.name);
                    bankReceivedLoadExchangeRate();
                }
                else{
                    alertMessage("Currency Not Found!",txtBankReceivedCurrencyCode);
                    txtBankReceivedCurrencyCode.val("");
                    txtBankReceivedCurrencyName.val("");
                    txtBankReceivedExchangeRate.val("0.00");
                    txtBankReceivedExchangeRate.attr("readonly",true);
                }
            });
    }
    function handlers_input_bank_received(){
                
        if(dtpBankReceivedTransactionDate.val()===""){
            handlersInput(dtpBankReceivedTransactionDate);
        }else{
            unHandlersInput(dtpBankReceivedTransactionDate);
        }
        
        if(txtBankReceivedBranchCode.val()===""){
            handlersInput(txtBankReceivedBranchCode);
        }else{
            unHandlersInput(txtBankReceivedBranchCode);
        }
        
        if(txtBankReceivedDivisionCode.val()===""){
            handlersInput(txtBankReceivedDivisionCode);
        }else{
            unHandlersInput(txtBankReceivedDivisionCode);
        }
        if(txtBankReceivedCustomerCode.val()===""){
            handlersInput(txtBankReceivedCustomerCode);
        }else{
            unHandlersInput(txtBankReceivedCustomerCode);
        }
        if(txtBankReceivedBankAccountCode.val()===""){
            handlersInput(txtBankReceivedBankAccountCode);
        }else{
            unHandlersInput(txtBankReceivedBankAccountCode);
        }
        
        if(txtBankReceivedCurrencyCode.val()===""){
            handlersInput(txtBankReceivedCurrencyCode);
        }else{
            unHandlersInput(txtBankReceivedCurrencyCode);
        }
        
        if(parseFloat(removeCommas(txtBankReceivedExchangeRate.val()))>0){
            unHandlersInput(txtBankReceivedExchangeRate);
        }else{
            handlersInput(txtBankReceivedExchangeRate);
        }
        
//        var type=$("#frmBankReceivedInput_bankReceived_receivedType").val();
//        if(type!=="Giro"){
//            if(parseFloat(removeCommas(txtBankReceivedTotalTransactionAmountForeign.val()))>0){
//                unHandlersInput(txtBankReceivedTotalTransactionAmountForeign);
//            }else{
//                handlersInput(txtBankReceivedTotalTransactionAmountForeign);
//            }
//        }else{
//            unHandlersInput(txtBankReceivedTotalTransactionAmountForeign);
//        }
        
        
        if(txtBankReceivedReceivedFrom.val()===""){
            handlersInput(txtBankReceivedReceivedFrom);
        }else{
            unHandlersInput(txtBankReceivedReceivedFrom);
        }
        
        if(txtBankReceivedGiroReceivedCode.val()===""){
            handlersInput(txtBankReceivedGiroReceivedCode);
        }else{
            unHandlersInput(txtBankReceivedGiroReceivedCode);
        }
//        if(txtBankReceivedTotalDebitForeign.val()==0.00){
//            handlersInput(txtBankReceivedTotalDebitForeign);
//        }else{
//            unHandlersInput(txtBankReceivedTotalDebitForeign);
//        }

        
    }
</script>

<s:url id="remoteurlBankReceivedDetailDocumentInput" action="" />
<b>BANK RECEIVED</b>
<hr>
<br class="spacer" />
<div id="bankReceivedInput" class="content ui-widget">
<s:form id="frmBankReceivedInput">
    <table cellpadding="2" cellspacing="2" id="headerInputBankReceived" width="100%">
       
        <tr>
            <td align="right"><B>Code *</B></td>
            <td colspan="3">
                <s:textfield id="bankReceived.code" name="bankReceived.code" key="bankReceived.code" readonly="true" size="22"></s:textfield>
                <s:textfield id="bankReceivedCurrencyCodeSession" name="bankReceivedCurrencyCodeSession" size="20" hidden="true"></s:textfield>
                <s:textfield id="bankReceivedUpdateMode" name="bankReceivedUpdateMode" size="20" hidden="true"></s:textfield>
            </td>
        </tr> 
        <tr>
            <td align="right"><B>Transaction Date *</B></td>
            <td>
            <sj:datepicker id="bankReceived.transactionDate" name="bankReceived.transactionDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" onchange="bankReceivedTransactionDateOnChange()"></sj:datepicker>
            <sj:datepicker id="bankReceivedTransactionDate" name="bankReceivedTransactionDate" title=" " required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                <s:textfield id="bankReceivedTemp.transactionDateTemp" name="bankReceivedTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
            </td>
            <td>
                <sj:datepicker id="bankReceivedTransactionDateFirstSession" name="bankReceivedTransactionDateFirstSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                <sj:datepicker id="bankReceivedTransactionDateLastSession" name="bankReceivedTransactionDateLastSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
            </td>
        </tr>
        
        <tr>
            <td align="right" style="width:120px"><B>Branch *</B></td>
            <td colspan="2">
            <script type = "text/javascript">

                txtBankReceivedBranchCode.change(function(ev) {

                    if(txtBankReceivedBranchCode.val()===""){
                        txtBankReceivedBranchName.val("");
                        return;
                    }
                    var url = "master/branch-get";
                    var params = "branch.code=" + txtBankReceivedBranchCode.val();
                        params += "&branch.activeStatus=TRUE";

                    $.post(url, params, function(result) {
                        var data = (result);
                        if (data.branchTemp){
                            txtBankReceivedBranchCode.val(data.branchTemp.code);
                            txtBankReceivedBranchName.val(data.branchTemp.name);
                        }
                        else{
                            alertMessage("Branch Not Found!",txtBankReceivedBranchCode);
                            txtBankReceivedBranchCode.val("");
                            txtBankReceivedBranchName.val("");
                        }
                    });
                });
            </script>
            <div class="searchbox ui-widget-header" hidden="true">
                <s:textfield id="bankReceived.branch.code" name="bankReceived.branch.code" size="22"></s:textfield>
                <sj:a id="bankReceived_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
            </div>
                <s:textfield id="bankReceived.branch.name" name="bankReceived.branch.name" size="40" readonly="true"></s:textfield>
                <s:textfield id="bankReceivedUpdateMode" name="bankReceivedUpdateMode" size="20" style="display:none"></s:textfield>
                <s:textfield id="bankReceivedTemp.createdDateTemp" name="bankReceivedTemp.createdDateTemp" cssStyle="display:none"></s:textfield>
                <sj:datepicker id="bankReceived.createdDate" name="bankReceived.createdDate" required="true" cssClass="required" size="25" displayFormat="dd/mm/yy"  timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" showOn="focus" cssStyle="display:none"></sj:datepicker>
        </tr>
        <tr>
            <td align="right"><B>Bank Account *</B></td>
            <td colspan="3">
                <script type = "text/javascript">
                    txtBankReceivedBankAccountCode.change(function(ev) {
                        
                        if(txtBankReceivedBankAccountCode.val()===""){
                            txtBankReceivedBankAccountName.val("");
                            txtBankReceivedBBMVoucherNo.val("");
                            txtBankReceivedBankAccountChartOfAccountCode.val("");
                            txtBankReceivedBankAccountChartOfAccountName.val("");
                            return;
                        }
                        
                        var url = "master/bank-account-get";
                        var params = "bankAccount.code=" + txtBankReceivedBankAccountCode.val();
                            params+= "&bankAccount.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);

                            if (data.bankAccountTemp){
                                txtBankReceivedBankAccountCode.val(data.bankAccountTemp.code);
                                txtBankReceivedBankAccountName.val(data.bankAccountTemp.name);
                                txtBankReceivedBBMVoucherNo.val(data.bankAccountTemp.bBMVoucherNo);
                                txtBankReceivedBankAccountChartOfAccountCode.val(data.bankAccountTemp.chartOfAccountCode);
                                txtBankReceivedBankAccountChartOfAccountName.val(data.bankAccountTemp.chartOfAccountName);
                            }
                            else{
                                alertMessage("Bank Account Not Found!",txtBankReceivedBankAccountCode);
                                txtBankReceivedBankAccountCode.val("");
                                txtBankReceivedBankAccountName.val("");
                                txtBankReceivedBBMVoucherNo.val("");
                                txtBankReceivedBankAccountChartOfAccountCode.val("");
                                txtBankReceivedBankAccountChartOfAccountName.val("");
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                <s:textfield id="bankReceived.bankAccount.code" name="bankReceived.bankAccount.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="bankReceived_btnBankAccount" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-bank-account-bank-received"/></sj:a>
                </div>
                    <s:textfield id="bankReceived.bankAccount.name" name="bankReceived.bankAccount.name" size="40" readonly="true"></s:textfield>
                    <s:textfield id="bankReceived.bankAccount.bbmVoucherNo" name="bankReceived.bankAccount.bbmVoucherNo" size="22" readonly="true"></s:textfield>    
        </td>
        </tr>
        
        <tr>
             <td align="right"><B>Account No</B></td>
            <td colspan="2">
                <s:textfield id="bankReceived.bankAccount.chartOfAccount.code" name="bankReceived.bankAccount.chartOfAccount.code" size="22" readonly="true"></s:textfield>
                <s:textfield id="bankReceived.bankAccount.chartOfAccount.name" name="bankReceived.bankAccount.chartOfAccount.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
       
        <tr>
            <td align="right"><B>Type *</B></td>
            <td>
                <s:textfield id="bankReceived.transactionType" name="bankReceived.transactionType" cssStyle="display:none"></s:textfield>
                <s:radio id="bankReceivedTransactionTypeRad" name="bankReceivedTransactionTypeRad" label="type" list="{'Regular','Deposit'}" value='"Regular"'/>
            </td> 
        </tr>
        <tr>
            <td align="right"><B>Currency *</B></td>
            <td colspan="2">
                <script type = "text/javascript">
                    txtBankReceivedCurrencyCode.change(function(ev) {

                        if(txtBankReceivedCurrencyCode.val()===""){
                            txtBankReceivedCurrencyName.val("");
                            return;
                        }

                        var url = "master/currency-get";
                        var params = "currency.code=" + txtBankReceivedCurrencyCode.val();
                            params+= "&currency.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.currencyTemp){
                                txtBankReceivedCurrencyCode.val(data.currencyTemp.code);
                                txtBankReceivedCurrencyName.val(data.currencyTemp.name);
                                bankReceivedLoadExchangeRate();
                            }
                            else{
                                alertMessage("Currency Not Found!",txtBankReceivedCurrencyCode);
                                txtBankReceivedCurrencyCode.val("");
                                txtBankReceivedCurrencyName.val("");
                                txtBankReceivedExchangeRate.val("0.00");
                                txtBankReceivedExchangeRate.attr("readonly",true);
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                    <s:textfield id="bankReceived.currency.code" name="bankReceived.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="bankReceived_btnCurrency" cssClass="bankReceived_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                </div>
                    <s:textfield id="bankReceived.currency.name" name="bankReceived.currency.name" size="40" readonly="true"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Exchange Rate *</B></td>
            <td><s:textfield id="bankReceived.exchangeRate" name="bankReceived.exchangeRate" size="22" style="text-align: right" readonly="true" onkeyup="calculateBankReceivedTotalTransactionAmountIDR()"></s:textfield><b>IDR</b> &nbsp;<span class="errMsgNumric" id="errmsgExchangeRate"></span></td>
        </tr>
        <tr>
            <td align="right"><B>Received Type *</B></td>
            <td>
                <s:select label="Select Received Type" 
                    headerKey="-1" 
                    list="{'Giro','Transfer','Other'}" 
                    name="bankReceived.receivedType" onchange="onChangeBankReceivedType()" style="width: 115px"/>
            </td>
        </tr>               
        <tr>
            <td align="right" class="labelGiroCode"><B>Giro Code *</B></td>
            <td class="textLookupGiroReceived">
                <script type = "text/javascript">
                    txtBankReceivedGiroReceivedCode.change(function(ev) {
                        var url = "master/giroReceived-get";
                        var params = "giroReceived.code=" + txtBankReceivedGiroReceivedCode.val();
                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.giroReceived){
                                txtBankReceivedGiroReceivedCode.val(data.giroReceived.code);
//                                        txtBankReceivedGiroReceivedTransactionDate.val(data.giroReceived.transactionDate);
//                                        txtBankReceivedGiroReceivedGiroNo.val(data.giroReceived.giroNo);
//                                        txtBankReceivedGiroReceivedBankName.val(data.giroReceived.bank.name);
                            }
                            else{
                                txtBankReceivedGiroReceivedCode.val("");
//                                        txtBankReceivedGiroReceivedTransactionDate.val("");
//                                        txtBankReceivedGiroReceivedGiroNo.val("");
//                                        txtBankReceivedGiroReceivedBankName.val("");
                                alert("Giro Not Found");
                            }
                        });
                    });
                </script>
                <div class="searchbox ui-widget-header">
                    <s:textfield id="bankReceived.giroReceived.code" name="bankReceived.giroReceived.code" title=" " size="22"></s:textfield>
                    <sj:a id="bankReceived_btnGiroReceived" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                </div>
            </td>
        </tr>
         <tr>
            <td align="right"><B>From *</B></td>
            <td colspan="2"><s:textfield id="bankReceived.receivedFrom" name="bankReceived.receivedFrom" size="27" title=" " required="true" cssClass="required"></s:textfield></td>
        </tr>
        <tr>
            <td align="right"><B>Amount *</B></td>
            <td>
                <s:textfield id="bankReceived.totalTransactionAmount" name="bankReceived.totalTransactionAmount" size="22" style="text-align: right" onkeyup="calculateBankReceivedTotalTransactionAmountIDR()"></s:textfield>
                <s:textfield id="bankReceived.totalTransactionAmountIDR" name="bankReceived.totalTransactionAmountIDR" size="22" cssStyle="text-align:right" readonly="true" required="true" cssClass="required" value="0.00"></s:textfield>(Debit)&nbsp;<span id="errmsgTotalTransactionAmount"></span>
            </td>
        </tr>
        <tr>
            <td align="right"><label id="labelReceivedRefNo" class="labelReceivedRefNo"/></td>
            <td>
                <s:textfield id="bankReceived.transferReceivedNo" name="bankReceived.transferReceivedNo" size="27"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><label id="labelReceivedDate" class="labelReceivedDate"/></td>
            <td>
                <sj:datepicker id="bankReceived.transferReceivedDate" name="bankReceived.transferReceivedDate" size="25" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss"></sj:datepicker>
                <s:textfield id="bankReceivedTemp.transferReceivedDateTemp" name="bankReceivedTemp.transferReceivedDateTemp" size="20" cssStyle="display:none"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><label id="labelReceivedBankName" class="labelReceivedBankName"/></td>
            <td>
                <s:textfield id="bankReceived.transferBankName" name="bankReceived.transferBankName" size="27"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right">Ref No</td>
            <td colspan="3"><s:textfield id="bankReceived.refNo" name="bankReceived.refNo" size="27"></s:textfield></td>
        </tr>
        <tr>
            <td align="right" valign="top">Remark</td>
            <td colspan="3"><s:textarea id="bankReceived.remark" name="bankReceived.remark"  cols="72" rows="2" height="20"></s:textarea></td>
        </tr> 
        <tr hidden="true">
            <td>
                <s:textfield id="bankReceived.createdBy" name="bankReceived.createdBy" key="bankReceived.createdBy" readonly="true" size="22"></s:textfield>
                <sj:datepicker id="bankReceived.createdDate" name="bankReceived.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                <s:textfield id="bankReceivedTemp.createdDateTemp" name="bankReceivedTemp.createdDateTemp" size="20"></s:textfield>
                <s:textfield id="bankReceivedDetailCOASalesDownPaymentCode" name="bankReceivedDetailCOASalesDownPaymentCode" size="20"></s:textfield>
                <s:textfield id="bankReceivedDetailCOASalesDownPaymentName" name="bankReceivedDetailCOASalesDownPaymentName" size="20"></s:textfield>
            </td>
        </tr>
    </table>
</s:form>
<table>
    <tr>
        <td align="right">
            <sj:a href="#" id="btnConfirmBankReceived" button="true">Confirm</sj:a>
            <sj:a href="#" id="btnUnConfirmBankReceived" button="true">UnConfirm</sj:a>
        </td>
    </tr>
</table>
 <table width="20%">
    <tr>
        <td>
            <sj:a href="#" id="btnBankReceivedAddDetail" button="true" style="width: 90%">Finance Document</sj:a> 
        </td>
    </tr>
</table>                    
    <div id="bankReceivedDetailDocumentInputGrid">
        <sjg:grid
            id="bankReceivedDetailDocumentInput_grid"
            dataType="local"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankReceivedDetailTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            editinline="true"
            width="$('#tabmnubankreceived').width()"
            editurl="%{remoteurlBankReceivedDetailDocumentInput}"
            onSelectRowTopics="bankReceivedDetailDocumentInput_grid_onSelect"
        >
            <sjg:gridColumn
                name="bankReceivedDetailDocument" index="bankReceivedDetailDocument" title="" width="10" align="centre"
                editable="true" edittype="text" hidden="true"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentDelete" index="bankReceivedDetailDocumentDelete" title="" width="50" align="centre"
                editable="true"
                edittype="button"
                editoptions="{onClick:'bankReceivedDetailDocumentInputGrid_Delete_OnClick()', value:'delete'}"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentDocumentType" index="bankReceivedDetailDocumentDocumentType" key="bankReceivedDetailDocumentDocumentType" title="Type" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentDocumentNo" index="bankReceivedDetailDocumentDocumentNo" 
                key="bankReceivedDetailDocumentDocumentNo" title="Document No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentDocumentRefNo" index="bankReceivedDetailDocumentDocumentRefNo" 
                key="bankReceivedDetailDocumentDocumentRefNo" title="Document RefNo" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name = "bankReceivedDetailDocumentAmountIDR" index = "bankReceivedDetailDocumentAmountIDR" key = "bankReceivedDetailDocumentAmountIDR" 
                title = "Doc Amount (IDR)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
           
            <sjg:gridColumn
                name = "bankReceivedDetailDocumentBalanceIDR" index = "bankReceivedDetailDocumentBalanceIDR" key = "bankReceivedDetailDocumentBalanceIDR" 
                title = "Doc Balance (IDR)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
           
            <sjg:gridColumn
                name="bankReceivedDetailDocumentTransactionStatus" index="bankReceivedDetailDocumentTransactionStatus" 
                title="Transaction Status" width="150" sortable="true"
            /> 
            <sjg:gridColumn
                name = "bankReceivedDetailDocumentTransactionStatusTemp" 
                index = "bankReceivedDetailDocumentTransactionStatusTemp" 
                key = "bankReceivedDetailDocumentTransactionStatusTemp" title = "" width = "100" hidden="true"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentDebitForeign" index="bankReceivedDetailDocumentDebitForeign" key="bankReceivedDetailDocumentDebitForeign" title="Debit (Foreign)" 
                width="150" align="right" editable="true" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                editoptions="{onChange:'validateOnchangeBankReceivedDetailDocumentDebitForeignAmount()',onKeyUp:'calculateBankReceivedAmountIDRToForeignDebit()'}"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentDebitIDR" index="bankReceivedDetailDocumentDebitIDR" key="bankReceivedDetailDocumentDebitIDR" title="Debit (IDR)" 
                width="150" align="right" editable="true" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                editoptions="{onChange:'validateOnchangeBankReceivedDetailDocumentDebitIdrAmount()',onKeyUp:'calculateBankReceivedAmountForeignToIDRDebit()'}"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentCreditForeign" index="bankReceivedDetailDocumentCreditForeign" key="bankReceivedDetailDocumentCreditForeign" title="Credit (Foreign)" 
                width="150" align="right" editable="true" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                editoptions="{onChange:'validateOnchangeBankReceivedDetailDocumentCreditForeignAmount()',onKeyUp:'calculateBankReceivedAmountIDRToForeignCredit()'}"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentCreditIDR" index="bankReceivedDetailDocumentCreditIDR" key="bankReceivedDetailDocumentCreditIDR" title="Credit (IDR)" 
                width="150" align="right" editable="true" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                editoptions="{onChange:'validateOnchangeBankReceivedDetailDocumentCreditIdrAmount()',onKeyUp:'calculateBankReceivedAmountForeignToIDRCredit()'}"
            />
            <sjg:gridColumn
                name="bankReceivedDetailChartOfAccountSearch" index="bankReceivedDetailChartOfAccountSearch" title="" width="25" align="centre"
                editable="true"
                dataType="html"
                edittype="button"
                editoptions="{onClick:'bankReceivedDetailDocumentInputGrid_SearchAccount_OnClick()', value:'...'}"
            /> 
            <sjg:gridColumn
                name="bankReceivedDetailDocumentChartOfAccountCode" index="bankReceivedDetailDocumentChartOfAccountCode" 
                title="Chart Of Account Code" width="150" sortable="true" editable="true" edittype="text"
                editoptions="{onChange:'onChangeBankReceivedDetailCOA()'}"
            />     
            <sjg:gridColumn
                name="bankReceivedDetailDocumentChartOfAccountName" index="bankReceivedDetailDocumentChartOfAccountName" 
                title="Chart Of Account Name" width="175" sortable="true"
            />  
            <sjg:gridColumn
                name="bankReceivedDetailBranchCode" index="bankReceivedDetailBranchCode" key="bankReceivedDetailBranchCode" 
                title="Branch" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="bankReceivedDetailDocumentBranchCode" index="bankReceivedDetailDocumentBranchCode" key="bankReceivedDetailDocumentBranchCode" title="Branch" width="80" sortable="true" hidden="true"
            />
             <sjg:gridColumn
                name = "bankReceivedDetailDocumentCurrencyCode" index = "bankReceivedDetailDocumentCurrencyCode" key = "bankReceivedDetailDocumentCurrencyCode" title = "Currency" width = "60" 
            />
            <sjg:gridColumn
                name = "bankReceivedDetailDocumentExchangeRate" index = "bankReceivedDetailDocumentExchangeRate" key = "bankReceivedDetailDocumentExchangeRate" 
                title = "Rate" width = "80" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankReceivedDetailDocumentAmountForeign" index = "bankReceivedDetailDocumentAmountForeign" key = "bankReceivedDetailDocumentAmountForeign" 
                title = "Doc Amount (Foreign)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
             <sjg:gridColumn
                name = "bankReceivedDetailDocumentBalanceForeign" index = "bankReceivedDetailDocumentBalanceForeign" key = "bankReceivedDetailDocumentBalanceForeign" 
                title = "Doc Balance (Foreign)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "bankReceivedDetailDocumentRemark" index="bankReceivedDetailDocumentRemark" key="bankReceivedDetailDocumentRemark" title="Remark" width="225"  editable="true" edittype="text"
            />
        </sjg:grid >                
    </div>
     <table width="13%">
        <tr>
            <td width="60px" align="right">
                <s:textfield id="bankReceivedAddRow" name="bankReceivedAddRow" value="1" style="width: 60%; text-align: right;"></s:textfield>
            </td>
            <td>
                <sj:a href="#" id="btnBankReceivedAddDetailOther" button="true" style="width: 60px">Add</sj:a> 
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td colspan="2">
                <sj:a href="#" id="btnBankReceivedSave" button="true" style="width: 60px">Save</sj:a>
                <sj:a href="#" id="btnBankReceivedCancel" button="true" style="width: 60px">Cancel</sj:a>

            </td>
        </tr>
        <tr>
            <td width="50%"></td>
            <td height="10px" align="middle" colspan="4">
                <sj:a href="#" id="btnBankReceivedCalculate" button="true" style="width: 80px">Calculate</sj:a>
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
                        <td><s:textfield id="bankReceivedTotalDebitForeign" name="bankReceivedTotalDebitForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="bankReceivedTotalDebitIDR" name="bankReceivedTotalDebitIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Total(Credit)</td>
                        <td><s:textfield id="bankReceivedTotalCreditForeign" name="bankReceivedTotalCreditForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="bankReceivedTotalCreditIDR" name="bankReceivedTotalCreditIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Balance</td>
                        <td><s:textfield id="bankReceivedTotalBalanceForeign" name="bankReceivedTotalBalanceForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        <td><s:textfield id="bankReceivedTotalBalanceIDR" name="bankReceivedTotalBalanceIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                    </tr>
                    <tr>
                        <td/><td/>
                        <td height="10px" align="right" colspan="2"><lable><B><u>Forex Gain / Loss</u></B></lable></td>
                        <td width="25%"/>
                    </tr>
                    <tr>
                        <td style="text-align: right">Amount</td>
                        <td colspan="2"><s:textfield id="bankReceivedForexAmount" name="bankReceivedForexAmount" readonly="true" cssStyle="text-align:right" size="25" PlaceHolder="0.00"></s:textfield><B>IDR</B></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
