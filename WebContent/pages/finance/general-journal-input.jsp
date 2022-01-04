
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #generalJournalDetailDocumentInput_grid_pager_center{
        display: none;
    }
    #errmsgExchangeRate{
        color: red;
    }
    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var generalJournalDetaillastRowId=0,generalJournalSubDetaillastRowId=0,generalJournalDetail_lastSel = -1,generalJournalSubDetail_lastSel=-1,selectedRowId=0;
    var flagGeneralJournalIsConfirmed=false;
    var 
        txtGeneralJournalBranchCode = $("#generalJournal\\.branch\\.code"),
        txtGeneralJournalBranchName = $("#generalJournal\\.branch\\.name"),
//        txtGeneralJournalDivisionCode = $("#generalJournal\\.division\\.code"),
//        txtGeneralJournalDivisionName = $("#generalJournal\\.division\\.name"),
        dtpGeneralJournalTransactionDate = $("#generalJournal\\.transactionDate"),
        dtpGeneralJournalTransactionDateTemp = $("#generalJournalTemp\\.transactionDateTemp"),
        txtGeneralJournalCode = $("#generalJournal\\.code"),
        txtGeneralJournalCurrencyCode = $("#generalJournal\\.currency\\.code"),
        txtGeneralJournalCurrencyName = $("#generalJournal\\.currency\\.name"),
        txtGeneralJournalExchangeRate = $("#generalJournal\\.exchangeRate"),
        txtGeneralJournalTotalTransactionAmountForeign=$("#generalJournal\\.totalTransactionAmount"),
        txtGeneralJournalTotalTransactionAmountIDR=$("#generalJournal\\.totalTransactionAmountIDR"),
        txtGeneralJournalRefNo = $("#generalJournal\\.refNo"),
        txtGeneralJournalRemark = $("#generalJournal\\.remark"),
        dtpGeneralJournalCreatedDate=$("#generalJournal\\.createdDate"),
        txtGeneraljournalCurrencyCodeSession=$("#generalJournalCurrencyCodeSession"),
                
        txtGeneralJournalTotalDebitForeign = $("#generalJournalTotalDebitForeign"),
        txtGeneralJournalTotalDebitIDR = $("#generalJournalTotalDebitIDR"),
        txtGeneralJournalTotalCreditForeign = $("#generalJournalTotalCreditForeign"),
        txtGeneralJournalTotalCreditIDR = $("#generalJournalTotalCreditIDR"),
        txtGeneralJournalTotalBalanceForeign = $("#generalJournalTotalBalanceForeign"),
        txtGeneralJournalTotalBalanceIDR = $("#generalJournalTotalBalanceIDR"),
        
        txtGeneralJournalForexAmount = $("#generalJournalForexAmount");

       
    
        
        
    $(document).ready(function() {
        
        flagGeneralJournalIsConfirmed=false;      
        generalJournalLoadExchangeRate();
        
        $("#generalJournal\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        
        
        $("#generalJournal\\.exchangeRate").change(function(e){
            var exrate=$("#generalJournal\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#generalJournal\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
         

        $('#btnGeneralJournalCalculate').click(function(ev) {
            
            if(generalJournalDetail_lastSel !== -1) {
                $('#generalJournalDetailDocumentInput_grid').jqGrid("saveRow",generalJournalDetail_lastSel); 
            }
            
            var ids = jQuery("#generalJournalDetailDocumentInput_grid").jqGrid('getDataIDs'); 
            
            var DebitForeign = 0;
            var DebitIDR = 0;
            
            var CreditForeign = 0;
            var CreditIDR = 0;
            
            var BalanceForeign = 0;
            var BalanceIDR = 0;
            
            var nilaiForexHeader = 0;
            
            CreditForeign = parseFloat(CreditForeign);
            CreditIDR = parseFloat(CreditIDR);
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 
                
             
                var documentDebitForeign = data.generalJournalDetailDocumentDebitForeign;
                var documentCreditForeign = data.generalJournalDetailDocumentCreditForeign;
                
                var headerRate = txtGeneralJournalExchangeRate.val().replace(/,/g,"");
                var headerCurrency = txtGeneralJournalCurrencyCode.val();
                
                var documentRate = data.generalJournalDetailDocumentExchangeRate;
                var documentCurrency = data.generalJournalDetailDocumentCurrencyCode;

                var documentDebitIDR = documentDebitForeign * documentRate;
                $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", ids[i],"generalJournalDetailDocumentDebitIDR",documentDebitIDR);
                
                var documentCreditIDR = documentCreditForeign * documentRate;
                $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", ids[i],"generalJournalDetailDocumentCreditIDR",documentCreditIDR);
                
                
                
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
                DebitIDR = DebitIDR + parseFloat(documentDebitIDR);
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
            txtGeneralJournalTotalDebitForeign.val(DebitForeignFormat);
            txtGeneralJournalTotalDebitIDR.val(formatNumber(DebitIDR,2));
            
            var splitCreditForeign=CreditForeign.split('.');
            var CreditForeignFormat;
            if(splitCreditForeign[0].length>3){
                var concatCreditForeign=parseFloat(splitCreditForeign[0]+'.'+splitCreditForeign[1]);
                CreditForeignFormat=formatNumber(concatCreditForeign,2);
            }else{
                CreditForeignFormat=splitCreditForeign[0]+'.'+splitCreditForeign[1];
            }
            txtGeneralJournalTotalCreditForeign.val(CreditForeignFormat);
            txtGeneralJournalTotalCreditIDR.val(formatNumber(CreditIDR,2));
            
            BalanceForeign = (DebitForeign - CreditForeign).toFixed(2);
            BalanceIDR = (parseFloat(DebitIDR.toFixed(2)) - parseFloat(CreditIDR.toFixed(2)));
            
            
            var splitBalanceForeign=BalanceForeign.split('.');
            var BalanceForeignFormat;
            if(splitBalanceForeign[0].length>3){
                var concatBalanceForeign=parseFloat(splitBalanceForeign[0]+'.'+splitBalanceForeign[1]);
                BalanceForeignFormat=formatNumber(parseFloat(concatBalanceForeign),2);
            }else{
                BalanceForeignFormat=splitBalanceForeign[0]+'.'+splitBalanceForeign[1];
            }
            txtGeneralJournalTotalBalanceForeign.val(BalanceForeignFormat);
            txtGeneralJournalTotalBalanceIDR.val(formatNumber(parseFloat(BalanceIDR.toFixed(2)),2));
            
            txtGeneralJournalForexAmount.val(formatNumber(nilaiForexHeader,2));
        });
        
        $('#btnGeneralJournalSave').click(function(ev) {
            
            
            
            if(flagGeneralJournalIsConfirmed===true){
                if(generalJournalDetail_lastSel !== -1) {
                    $('#generalJournalDetailDocumentInput_grid').jqGrid("saveRow",generalJournalDetail_lastSel); 
                }
                $( "#btnGeneralJournalCalculate" ).trigger( "click" );
                var ids = jQuery("#generalJournalDetailDocumentInput_grid").jqGrid('getDataIDs'); 
                var currencyGJM=txtGeneralJournalCurrencyCode.val();
                var totalBalanceForeign = parseFloat(txtGeneralJournalTotalBalanceForeign.val().replace(/,/g, ""));
                var totalBalanceIDR = parseFloat(txtGeneralJournalTotalBalanceIDR.val().replace(/,/g, ""));
                
                var listGeneralJournalDetail = new Array(); 
                
                // cek isi detail
                if(ids.length===0){
                    alertMessage("Grid Cash Payment Detail Is Not Empty");
                    return;
                }
                
                // cek balance apabila foreign or IDR
                if (currencyGJM !== "IDR") {
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
                
                if(ids.length===0){
                    alertMessage("Grid General Journal Detail Is Not Empty");
                    return;
                }
                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 
                   
//                    var documentAccountName=data.generalJournalDetailDocumentChartOfAccountName;
//                    var amountCheck=parseFloat(data.generalJournalDetailDocumentAmountForeignInput);
  
                    var debitValue=parseFloat(data.generalJournalDetailDocumentDebitForeign);
                    var creditValue=parseFloat(data.generalJournalDetailDocumentCreditForeign);
                    
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


                   var statusTemp=''; 
                   if (data.generalJournalDetailDocumentDocumentNo===""){
                       statusTemp='Other';
                   }
                   else{statusTemp='Transaction';}
                    var generalJournalDetail = { 
                        documentNo           : data.generalJournalDetailDocumentDocumentNo,
                        documentBranchCode   : data.generalJournalDetailDocumentBranchCode,
                        documentType         : data.generalJournalDetailDocumentDocumentType,
                        currency             : {code:data.generalJournalDetailDocumentCurrencyCode},
                        exchangeRate         : data.generalJournalDetailDocumentExchangeRate,
                        chartOfAccount       : {code:data.generalJournalDetailDocumentChartOfAccountCode},
                        transactionStatus    : statusTemp,
                        amount               : data.generalJournalDetailDocumentAmountForeignInput,
                        amountIDR            : data.generalJournalDetailDocumentAmountIDRInput,
                        debit                : data.generalJournalDetailDocumentDebitForeign,
                        debitIDR             : data.generalJournalDetailDocumentDebitIDR,
                        credit               : data.generalJournalDetailDocumentCreditForeign,
                        creditIDR            : data.generalJournalDetailDocumentCreditIDR,
                        remark               : data.generalJournalDetailDocumentRemark
                    };

                    listGeneralJournalDetail[i] = generalJournalDetail;
                }
                    
                formatDateGJM();
                unFormatNumericGJM();
                
                var forexAmount= txtGeneralJournalForexAmount.val();
                
                //list untuk General Journal detail
                var url = "finance/general-journal-save";

                var params = $("#frmGeneralJournalInput").serialize();
                    params += "&listGeneralJournalDetailJSON=" + $.toJSON(listGeneralJournalDetail);
                    params += "&forexAmount=" + forexAmount;
                
                showLoading();
                
                $.post(url, params, function(data) {
                    $("#dlgLoading").dialog("close");
                    if (data.error) {
                        closeLoading();
                        alertMessage(data.errorMessage);
                        formatNumericGJM();
                        formatDateGJM();
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
                                    var url = "finance/general-journal-input";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuGENERAL_JOURNAL");
                                }
                            },
                            {
                                text : "No",
                                click : function() {
                                    $(this).dialog("close");
                                    var url = "finance/general-journal";
                                    var param = "";
                                    pageLoad(url, param, "#tabmnuGENERAL_JOURNAL");
                                }
                            }]
                    });
                });
            }else{
                alertMessage("Please Confirm!",$("#btnConfirmGeneralJournal"));
            }
        });
        $("#btnGeneralJournalSearchDetail").css("display", "none");
        $("#btnUnConfirmGeneralJournal").css("display", "none");
        $("#btnConfirmGeneralJournalSubDetail").css("display", "none");
        $("#btnUnConfirmGeneralJournalSubDetail").css("display", "none");
        $('#generalJournalDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmGeneralJournal").click(function(ev) {
            handlers_input_general_journal();       
            if(!$("#frmGeneralJournalInput").valid()) {
                alertMessage("Field(s) can't Empty!");
                ev.preventDefault();
                return;
            }
            
             if(parseFloat(txtGeneralJournalExchangeRate.val())<=1 && txtGeneralJournalCurrencyCode.val()!=="IDR"){
           
                txtGeneralJournalExchangeRate.attr("style","color:red");
                alertMessageNotif("Exchange Rate : "+txtGeneralJournalCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtGeneralJournalExchangeRate.attr("style","color:black");
            }

            var date1 = dtpGeneralJournalTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#generalJournalTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#generalJournalUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#generalJournalTransactionDate").val(),dtpGeneralJournalTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpGeneralJournalTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#generalJournalUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#generalJournalTransactionDate").val(),dtpGeneralJournalTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpGeneralJournalTransactionDate);
                }
                return;
            }
//            var date = $("#generalJournal\\.transactionDate").val().split("/");
//            var month = date[1];
//            var year = date[2].split(" ");
//            if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
//                alertMessage("Transaction Month Must Between Session Period Month!",dtpGeneralJournalTransactionDate);
//                return;
//            }
//
//            if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
//                alertMessage("Transaction Year Must Between Session Period Year!",dtpGeneralJournalTransactionDate);
//                return;
//            }    
            
            if($("#generalJournalUpdateMode").val()==="true"){
                loadGeneralJournalDetail();
            }

            flagGeneralJournalIsConfirmed=true;
            $("#btnGeneralJournalSearchDetail").css("display", "block");
            $("#btnUnConfirmGeneralJournal").css("display", "block");
            $("#btnConfirmGeneralJournal").css("display", "none");
            $('#headerInputGeneralJournal').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#generalJournalDetailDocumentInputGrid').unblock();
            
        });
        
        $("#btnUnConfirmGeneralJournal").click(function(ev) {
                
                var dynamicDialog= $('<div id="conformBox">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#generalJournalDetailDocumentInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    flagGeneralJournalIsConfirmed=false;    
                     $("#btnGeneralJournalSearchDetail").css("display", "none");
                    $("#btnUnConfirmGeneralJournal").css("display", "none");
                    $("#btnConfirmGeneralJournal").css("display", "block");
                    $('#headerInputGeneralJournal').unblock();
                    $('#generalJournalDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                                flagGeneralJournalIsConfirmed=false;
                                $(this).dialog("close");
                                 $("#btnGeneralJournalSearchDetail").css("display", "none");
                                $("#generalJournalDetailDocumentInput_grid").jqGrid('clearGridData');
                                $("#generalJournalSubDetailDocumentInput_grid").jqGrid('clearGridData');
                                $("#btnConfirmGeneralJournalSubDetail").css("display", "none");
                                $("#btnUnConfirmGeneralJournal").css("display", "none");
                                $("#btnConfirmGeneralJournal").css("display", "block");
                                $('#headerInputGeneralJournal').unblock();
                                $('#generalJournalDetailDocumentInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                txtGeneralJournalTotalBalanceForeign.val("0.00");
                                txtGeneralJournalTotalBalanceIDR.val("0.00");
                                
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
      
        $.subscribe("generalJournalDetailDocumentInput_grid_onSelect", function() {
            var selectedRowID = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");

            validateNumberOfGridAmount();

            if(selectedRowID!==generalJournalDetail_lastSel) {
                $('#generalJournalDetailDocumentInput_grid').jqGrid("saveRow",generalJournalDetail_lastSel); 
                $('#generalJournalDetailDocumentInput_grid').jqGrid("editRow",selectedRowID,true);            

                generalJournalDetail_lastSel=selectedRowID;

            }
            else{
                $('#generalJournalDetailDocumentInput_grid').jqGrid("saveRow",selectedRowID);
            }
            enableAmount(selectedRowID);
        });
    
        $.subscribe("generalJournalSubDetailDocumentInput_grid_onSelect", function() {

            var selectedRowID = $("#generalJournalSubDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==generalJournalSubDetail_lastSel) {

                $('#generalJournalSubDetailDocumentInput_grid').jqGrid("saveRow",generalJournalSubDetail_lastSel); 
                $('#generalJournalSubDetailDocumentInput_grid').jqGrid("editRow",selectedRowID,true);            

                generalJournalSubDetail_lastSel=selectedRowID;

            }
            else
                $('#generalJournalSubDetailDocumentInput_grid').jqGrid("saveRow",selectedRowID);

        });
    
        $('#btnGeneralJournalSearchDetail').click(function(ev) {

                if(flagGeneralJournalIsConfirmed===false){
                    alertMessage("Please Confirm!",$("#btnConfirmGeneralJournal"));
                    return;
                }
               
                
                window.open("./pages/search/search-finance-document.jsp?iddoc=generalJournalDetailDocument&type=grid&idfin=BBM&firstDate="+$("#generalJournalTransactionDateFirstSession").val()+"&rowLast="+generalJournalDetaillastRowId+"&lastDate="+$("#generalJournalTransactionDateLastSession").val(),"Search", "scrollbars=1, width=900, height=600");

               
                
        });
        $('#btnGeneralJournalAddDetail').click(function(ev) {
                if(flagGeneralJournalIsConfirmed===false){
                    alertMessage("Please Confirm!",$("#btnConfirmGeneralJournal"));
                    return;
                }

                var AddRowCount =parseFloat(removeCommas($("#generalJournalAddRow").val()));
                var currencyHeader = txtGeneralJournalCurrencyCode.val();
                var rateHeader = txtGeneralJournalExchangeRate.val().replace(/,/g, "");

                for(var i=0; i<AddRowCount; i++){
                    var defRow = {
                        generalJournalDetailDocumentDocumentNo          :"",
                        generalJournalDetailDocumentChartOfAccountName  :"",
                        generalJournalDetailDocumentCurrencyCode        :currencyHeader,
                        generalJournalDetailDocumentExchangeRate        :rateHeader,
                        generalJournalDetailDocumentTransactionStatus   :"Other"
                    };
                    generalJournalDetaillastRowId++;
                    $("#generalJournalDetailDocumentInput_grid").jqGrid("addRowData", generalJournalDetaillastRowId, defRow);

                    be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                    $("#generalJournalDetailDocumentInput_grid").jqGrid('setRowData',generalJournalDetaillastRowId,{Buttons:be});   
                }
                $("#generalJournalAddRow").val("1");
        });
        
        $('#btngeneralJournalDetailDocumentActiveInputanAmountForeignIDR').click(function(ev) {
            var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
            var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);

            var documentNo=data.generalJournalDetailDocumentDocumentNo;

            var transactionStatus=$("#"+ selectedRowId + "_generalJournalDetailDocumentTransactionStatus").val();

            switch(transactionStatus){
//                case "---Select---":
//                    $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",true);
//                    $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",true);
//                    break;
                case "Transaction":
                        if(documentNo!==" "){
                            $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",false);
                            $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",false);
                        }else{
                            $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",true);
                            $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",true);
                        }
                    break;
                case "Other":
                    $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",true);
                    $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",false);
                    $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",false);
                    break;
            } 
        });

        $('#btnGeneralJournalCancel').click(function(ev) {
            var url = "finance/general-journal";
            var params = "";
            pageLoad(url, params, "#tabmnuGENERAL_JOURNAL"); 
            
        });
        
        $('#generalJournal_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=generalJournal&idsubdoc=branch","Search", "scrollbars=1, width=600, height=500");
        });
           
//        $('#generalJournal_btnDivision').click(function(ev) {
//            window.open("./pages/search/search-division.jsp?iddoc=generalJournal&idsubdoc=division","Search", "scrollbars=1, width=600, height=500");
//        });
               
        $('#generalJournal_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=generalJournal&idsubdoc=currency","Search", "scrollbars=1, width=600, height=500");
        });
        
    });//EOF Ready
    
    function generalJournalTransactionDateOnChange(){
        if($("#generalJournalUpdateMode").val()!=="true"){
            $("#generalJournalTransactionDate").val(dtpGeneralJournalTransactionDate.val());
        }
    }
    
    function enableAmount(selectedRowId,documentNo){
        var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        var transactionStatus=data.generalJournalDetailDocumentTransactionStatusTemp;
        documentNo=data.generalJournalDetailDocumentDocumentNo;
        switch(transactionStatus){
//            case "---Select---":
//                $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",true);
//                $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",true);
//                break;
            case "Transaction":
                    if(documentNo!==" "){
                        $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",false);
                        $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",false);
                    }
                    else{
                        $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",true);
                        $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",true);
                    }
                break;
            case "Other":
                $("#"+selectedRowId+"_generalJournalDetailDocumentAmountForeignInput").attr("readonly",false);
                $("#"+selectedRowId+"_generalJournalDetailDocumentAmountIDRInput").attr("readonly",false);
                break;
        } 
    }
    function clearInputanGeneralJournalGridPerRow(selectedRowId){
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentBranchCode", " ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentDocumentType", " ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentDocumentNo", " ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountForeign", " ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountIDR", " ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentBalanceForeign", " ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentBalanceIDR", " ");
        $("#"+ selectedRowId + "_generalJournalDetailDocumentAmountForeignInput").val("0.00");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountForeignTemp", "0.00");
        $("#"+ selectedRowId + "_generalJournalDetailDocumentAmountIDRInput").val("0.00");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountIDRTemp", "0.00");
    }
    
    function calculateGeneralJournalAmountIDR(){
        
        var amount=$("#generalJournal\\.amount").val();
        var exchangeRate=$("#generalJournal\\.exchangeRate").val();
        var amountIDR=(parseFloat(amount)* parseFloat(exchangeRate));
        
        $("#generalJournal\\.amountIDR").val(formatNumber(amountIDR,2));
        $("#generalJournal\\.totalTransactionForeign").val(amount);
        $("#generalJournal\\.totalTransactionIDR").val(amountIDR);
    }
    
    
    
    function countAmountGeneralJournalIDRFromForeign(){
        var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var amountForeign = $("#"+ selectedRowId + "_generalJournalDetailDocumentAmountForeignInput").val();
        
        if(amountForeign===""){
            $("#"+ selectedRowId + "_generalJournalDetailDocumentAmountForeignInput").val("0.00");
            $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountForeignTemp", "0.00");
        }
        
        var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        var transactionStatus=$("#"+ selectedRowId + "_generalJournalDetailDocumentTransactionStatus").val();
        
        var currencyCodeHeader=txtGeneralJournalCurrencyCode.val();
        var currencyCodeDetail=data.generalJournalDetailDocumentCurrencyCode;
        var currencyCodeSession=txtGeneraljournalCurrencyCodeSession.val();
        var Ex_Rate;
        switch(transactionStatus){
            case "Transaction":
                if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail!==currencyCodeSession){
                    Ex_Rate=data.generalJournalDetailDocumentExchangeRate;
                }
                if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail===currencyCodeSession){
                    Ex_Rate=txtGeneralJournalExchangeRate.val().replace(/,/g, "");
                }
                if(currencyCodeHeader===currencyCodeSession){
                    Ex_Rate=data.generalJournalDetailDocumentExchangeRate;
                }
                break;
            case "Other":
                Ex_Rate=data.generalJournalDetailDocumentExchangeRate;
                break;
        }
                        
        var priceIDR =Ex_Rate *amountForeign;
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountForeignTemp", amountForeign);
        $("#"+ selectedRowId + "_generalJournalDetailDocumentAmountIDRInput").val(priceIDR);  
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountIDRTemp", priceIDR);
        calculateGeneralJournalBalance();
    }
    
        
    function countAmountGeneralJournalForeignFromIDR(){
        
            var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
            var amountIDR = $("#"+ selectedRowId + "_generalJournalDetailDocumentAmountIDRInput").val();
            
            var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
            var transactionStatus=$("#"+ selectedRowId + "_generalJournalDetailDocumentTransactionStatus").val();
        
            var currencyCodeHeader=txtGeneralJournalCurrencyCode.val();
            var currencyCodeDetail=data.generalJournalDetailDocumentCurrencyCode;
            var currencyCodeSession=txtGeneraljournalCurrencyCodeSession.val();
            var Ex_Rate;
            switch(transactionStatus){
                case "Transaction":
                    if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail!==currencyCodeSession){
                        Ex_Rate=data.generalJournalDetailDocumentExchangeRate;
                    }
                    if(currencyCodeHeader!==currencyCodeSession && currencyCodeDetail===currencyCodeSession){
                        Ex_Rate=txtGeneralJournalExchangeRate.val().replace(/,/g, "");
                    }
                    if(currencyCodeHeader===currencyCodeSession){
                        Ex_Rate=data.generalJournalDetailDocumentExchangeRate;
                    }
                    break;
                case "Other":
                    Ex_Rate=data.generalJournalDetailDocumentExchangeRate;
                    break;
            }
                        
            var priceForeign = amountIDR/Ex_Rate;
            $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountIDRTemp", amountIDR);
            $("#"+ selectedRowId + "_generalJournalDetailDocumentAmountForeignInput").val(priceForeign);  
            $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowId, "generalJournalDetailDocumentAmountForeignTemp", priceForeign);
            calculateGeneralJournalBalance();
           }
   
    function calculateGeneralJournalBalance(){
        var amountForeign=0;
        var amountIDR=0;
        var ids = jQuery("#generalJournalDetailDocumentInput_grid").jqGrid('getDataIDs');
           
        for(var i=0;i < ids.length;i++) {
            var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',ids[i]);
            amountForeign +=parseFloat(data.generalJournalDetailDocumentAmountForeignTemp);
            amountIDR +=parseFloat(data.generalJournalDetailDocumentAmountIDRTemp);
        }        
        var sumAmountForeign=0- amountForeign;
        var sumAmountForeignLetter;
        if(sumAmountForeign < 0){
           sumAmountForeignLetter="-" + formatNumber(Math.abs(sumAmountForeign),2);
        }else{
            sumAmountForeignLetter=formatNumber(sumAmountForeign,2); 
        }
        
        var sumAmountIDR=0 - amountIDR;
        var sumAmountIDRLetter;
        if(sumAmountIDR < 0){
           sumAmountIDRLetter="-" + formatNumber(Math.abs(sumAmountIDR),2);
        }else{
            sumAmountIDRLetter=formatNumber(sumAmountIDR,2); 
        }
        txtGeneralJournalTotalBalanceForeign.val(sumAmountForeignLetter);
        txtGeneralJournalTotalBalanceIDR.val(sumAmountIDRLetter);
        
    }
    
    
           
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
        
    function validateNumberOfGridAmount(){
        var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        
        $("#"+selectedRowId+"_generalJournalDetailDocumentDebitForeign").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#"+selectedRowId+"_generalJournalDetailDocumentDebitIDR").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#"+selectedRowId+"_generalJournalDetailDocumentCreditForeign").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#"+selectedRowId+"_generalJournalDetailDocumentCreditIDR").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && e.which !==45 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        

    }
    
    function formatDateGJM(){
        var transactionDate=$("#generalJournal\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpGeneralJournalTransactionDate.val(transactionDateValue);
        $("#generalJournalTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var createdDate=$("#generalJournal\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpGeneralJournalCreatedDate.val(createdDateValue);
        $("#generalJournalTemp\\.createdDateTemp").val(createdDateValue);
        
    }
    
    function formatNumericGJM(){
        var totalBalanceForeign =parseFloat(txtGeneralJournalTotalBalanceForeign.val());
        txtGeneralJournalTotalBalanceForeign.val(formatNumber(totalBalanceForeign,2));
        var totalBalanceIDR = parseFloat(txtGeneralJournalTotalBalanceIDR.val());
        txtGeneralJournalTotalBalanceIDR.val(formatNumber(totalBalanceIDR,2));
        var exchangerateHeaderFormat =parseFloat(txtGeneralJournalExchangeRate.val());
        txtGeneralJournalExchangeRate.val(formatNumber(exchangerateHeaderFormat,2));
        
        var forexAmount=parseFloat(txtGeneralJournalForexAmount.val());
        txtGeneralJournalForexAmount.val(formatNumber(forexAmount,2));
    }
    
    function unFormatNumericGJM(){
        var totalBalanceForeign =removeCommas(txtGeneralJournalTotalBalanceForeign.val());
        txtGeneralJournalTotalBalanceForeign.val(totalBalanceForeign);
        var totalBalanceIDR = removeCommas(txtGeneralJournalTotalBalanceIDR.val());
        txtGeneralJournalTotalBalanceIDR.val(totalBalanceIDR);
        var exchangerateHeaderFormat =removeCommas(txtGeneralJournalExchangeRate.val());
        txtGeneralJournalExchangeRate.val(exchangerateHeaderFormat);
        
        var forexAmount= removeCommas(txtGeneralJournalForexAmount.val());
        txtGeneralJournalForexAmount.val(forexAmount);
    }
    
    
    
    function resetDataselectedRowGeneralJournalDetail(){
        var selectedRowID = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");
        
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentBranchCode"," ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentDocumentType"," ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentDocumentNo"," ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentDocumentRefNo"," ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentCurrencyCode"," ");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentExchangeRate","0.00");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentAmountForeign","0.00");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentAmountIDR","0.00");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentBalanceForeign","0.00");
        $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentBalanceIDR","0.00");
        
        $("#"+ selectedRowID + "_generalJournalDetailDocumentDebitForeign").val("0.00");
        $("#"+ selectedRowID + "_generalJournalDetailDocumentDebitIDR").val("0.00");
        $("#"+ selectedRowID + "_generalJournalDetailDocumentCreditForeign").val("0.00");
        $("#"+ selectedRowID + "_generalJournalDetailDocumentCreditIDR").val("0.00");
    }
    
    function generalJournalDetailDocumentInputGrid_SearchAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=generalJournalDetailDocument&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function generalJournalDetailDocumentInputGrid_SearchDocument_OnClick(){
        window.open("./pages/search/search-finance-document.jsp?iddoc=generalJournalDetailDocument&idfin=GJM&type=grid&iddocac=general-journal-finance-document-search&firstDate="+$("#generalJournalTransactionDateFirstSession").val()+"&lastDate="+$("#generalJournalTransactionDateLastSession").val(),"Search", "scrollbars=1, width=900, height=600");
    }
    
    function generalJournalDetailDocumentInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        $("#generalJournalDetailDocumentInput_grid").jqGrid('delRowData',selectDetailRowId);
        
    }
    
    function generalJournalSubDetailDocumentInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#generalJournalSubDetailDocumentInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        $("#generalJournalSubDetailDocumentInput_grid").jqGrid('delRowData',selectDetailRowId);
        
    }
    
    function countAmountIDRToForeignDebit(){
        var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.generalJournalDetailDocumentExchangeRate;
        var DebitForeign = $("#"+ selectedRowId + "_generalJournalDetailDocumentDebitForeign").val();
        var DebitIDR = DebitForeign * Ex_Rate;
        
        $("#"+ selectedRowId + "_generalJournalDetailDocumentDebitIDR").val(DebitIDR);
        
    }
    
    function countAmountForeignToIDRDebit(){
        var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.generalJournalDetailDocumentExchangeRate;
        var DebitIDR = $("#"+ selectedRowId + "_generalJournalDetailDocumentDebitIDR").val();
        var DebitForeign = DebitIDR / Ex_Rate;
        
        $("#"+ selectedRowId + "_generalJournalDetailDocumentDebitForeign").val(DebitForeign);
        
    }
    
    function countAmountIDRToForeignCredit(){
        var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.generalJournalDetailDocumentExchangeRate;
        var CreditForeign = $("#"+ selectedRowId + "_generalJournalDetailDocumentCreditForeign").val();
        var CreditIDR = CreditForeign * Ex_Rate;

        
        $("#"+ selectedRowId + "_generalJournalDetailDocumentCreditIDR").val(CreditIDR);
        
    }
    
    function countAmountForeignToIDRCredit(){
        var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        var data = $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',selectedRowId);
        
        var Ex_Rate = data.generalJournalDetailDocumentExchangeRate;
        var CreditIDR = $("#"+ selectedRowId + "_generalJournalDetailDocumentCreditIDR").val();
        var CreditForeign = CreditIDR / Ex_Rate;
        
        $("#"+ selectedRowId + "_generalJournalDetailDocumentCreditForeign").val(CreditForeign);
        
    }

    function loadGeneralJournalDetail() {
        
        var url = "finance/general-journal-detail-data";
        var params = "generalJournal.code=" + txtGeneralJournalCode.val();
            
        $.getJSON(url, params, function(data) {
            generalJournalDetaillastRowId = 0;
                    
            for (var i=0; i<data.listGeneralJournalDetailTemp.length; i++) {
                
                var transactionType=data.listGeneralJournalDetailTemp[i].transactionStatus;
                var currencyCodeDocument="";
                var exchangeRateDocument="0.00";
                    
                switch(transactionType){
                    case "Transaction":
                        currencyCodeDocument=data.listGeneralJournalDetailTemp[i].currencyCode;
                        exchangeRateDocument=data.listGeneralJournalDetailTemp[i].exchangeRate;
                        break;
                    case "Other":
                        currencyCodeDocument=txtGeneralJournalCurrencyCode.val();
                        exchangeRateDocument=removeCommas(txtGeneralJournalExchangeRate.val());
                        break;
                }
                
                $("#generalJournalDetailDocumentInput_grid").jqGrid("addRowData", generalJournalDetaillastRowId, data.listGeneralJournalDetailTemp[i]);
                $("#generalJournalDetailDocumentInput_grid").jqGrid('setRowData',generalJournalDetaillastRowId,{
                    generalJournalDetailDocumentDocumentNo          : data.listGeneralJournalDetailTemp[i].documentNo,
                    generalJournalDetailDocumentBranchCode          : data.listGeneralJournalDetailTemp[i].documentBranchCode,
                    generalJournalDetailDocumentDocumentType        : data.listGeneralJournalDetailTemp[i].documentType,
                    generalJournalDetailDocumentCurrencyCode        : currencyCodeDocument,
                    generalJournalDetailDocumentExchangeRate        : exchangeRateDocument,
                    generalJournalDetailDocumentAmountForeign       : data.listGeneralJournalDetailTemp[i].documentAmount,
                    generalJournalDetailDocumentAmountIDR           : data.listGeneralJournalDetailTemp[i].documentAmountIDR,
                    generalJournalDetailDocumentBalanceForeign      : data.listGeneralJournalDetailTemp[i].documentBalanceAmount,
                    generalJournalDetailDocumentBalanceIDR          : data.listGeneralJournalDetailTemp[i].documentBalanceAmountIDR,
                    generalJournalDetailDocumentTransactionStatus   : data.listGeneralJournalDetailTemp[i].transactionStatus,
                    generalJournalDetailDocumentDebitForeign        : data.listGeneralJournalDetailTemp[i].debit,
                    generalJournalDetailDocumentDebitIDR            : (parseFloat(data.listGeneralJournalDetailTemp[i].debit)*exchangeRateDocument),
                    generalJournalDetailDocumentCreditForeign       : data.listGeneralJournalDetailTemp[i].credit,
                    generalJournalDetailDocumentCreditIDR           : (parseFloat(data.listGeneralJournalDetailTemp[i].credit)* exchangeRateDocument),
                    generalJournalDetailDocumentChartOfAccountCode  : data.listGeneralJournalDetailTemp[i].chartOfAccountCode,
                    generalJournalDetailDocumentChartOfAccountName  : data.listGeneralJournalDetailTemp[i].chartOfAccountName,
                    generalJournalDetailDocumentRemark              : data.listGeneralJournalDetailTemp[i].remark
                });
            generalJournalDetaillastRowId++;
            }
        });
    }
    
    function changeGeneralJournalDocumentType(type) {
        
        var selectedRowId = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam","selrow");
        $("#" + selectedRowId + "_generalJournalDetailDocumentTransactionStatus").val(type);
    }
       
    function onChangeGeneralJournalDetailChartOfAccount(){
        var selectedRowID = $("#generalJournalDetailDocumentInput_grid").jqGrid("getGridParam", "selrow");
        var coaCode = $("#" + selectedRowID + "_generalJournalDetailDocumentChartOfAccountCode").val();
        var url = "master/chart-of-account-get";
        var params = "chartOfAccount.code=" + coaCode;
            params+= "&chartOfAccount.accountType=S";
            params+= "&chartOfAccount.activeStatus=TRUE";
            
        if(coaCode===""){
            $("#" + selectedRowID + "_generalJournalDetailDocumentChartOfAccountCode").val("");
            $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentChartOfAccountName"," ");
            return;
        }
            
        $.post(url, params, function(result) {
            var data = (result);
            if (data.chartOfAccountTemp){
                $("#" + selectedRowID + "_generalJournalDetailDocumentChartOfAccountCode").val(data.chartOfAccountTemp.code);
                $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentChartOfAccountName",data.chartOfAccountTemp.name);
            }
            else{
                alertMessage("COA Not Found",$("#" + selectedRowID + "_supplierDebitNoteDetailChartOfAccountCode"));
                $("#" + selectedRowID + "_supplierDebitNoteDetailChartOfAccountCode").val("");
                $("#generalJournalDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"generalJournalDetailDocumentChartOfAccountName"," ");
            }
        });
    }
    
    function generalJournalLoadExchangeRate(){
  
         if($("#generalJournalUpdateMode").val()==="false"){
            if(txtGeneralJournalCurrencyCode.val()==="IDR"){
                txtGeneralJournalCurrencyCode.val("IDR");
                txtGeneralJournalExchangeRate.val("1.00");
                txtGeneralJournalExchangeRate.attr('readonly',true);
            }else{
                txtGeneralJournalExchangeRate.val("0.00");
                txtGeneralJournalExchangeRate.attr('readonly',false);
            }
        }else{
            if(txtGeneralJournalCurrencyCode.val()==="IDR"){
                txtGeneralJournalExchangeRate.val("1.00");
                txtGeneralJournalExchangeRate.attr('readonly',true);
            }else{
                txtGeneralJournalExchangeRate.attr('readonly',false);
            }
        }
    }
    function addRowgeneralJournalDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#generalJournalDetailDocumentInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        var data= $("#generalJournalDetailDocumentInput_grid").jqGrid('getRowData',lastRowId);
        
            $("#generalJournalDetailDocumentInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#generalJournalDetailDocumentInput_grid").jqGrid('setRowData',lastRowId,{
                generalJournalDetailDocumentDelete                        :"delete",
                generalJournalDetailDocumentBranchCode                    : defRow.branchCode,
                generalJournalDetailDocumentDocumentNo                    : defRow.documentNo,
                generalJournalDetailDocumentDocumentType                  : defRow.documentType,
                generalJournalDetailDocumentCurrencyCode                  : defRow.currencyCode,
                generalJournalDetailDocumentExchangeRate                  : defRow.exchangeRate

            });
        setHeightGridHeader();
        generalJournalDetaillastRowId++;
        $("#btnGeneralJournalCalculate").trigger("click");
    }
    function setHeightGridHeader(){
        var ids = jQuery("#generalJournalDetailDocumentInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#generalJournalDetailDocumentInput_grid"+" tr").eq(1).height();
            $("#generalJournalDetailDocumentInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#generalJournalDetailDocumentInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }   
    function handlers_input_general_journal(){
                
        if(dtpGeneralJournalTransactionDate.val()===""){
            handlersInput(dtpGeneralJournalTransactionDate);
        }else{
            unHandlersInput(dtpGeneralJournalTransactionDate);
        }
        
        if(txtGeneralJournalBranchCode.val()===""){
            handlersInput(txtGeneralJournalBranchCode);
        }else{
            unHandlersInput(txtGeneralJournalBranchCode);
        }
        
//        if(txtGeneralJournalDivisionCode.val()===""){
//            handlersInput(txtGeneralJournalDivisionCode);
//        }else{
//            unHandlersInput(txtGeneralJournalDivisionCode);
//        }
        
        if(txtGeneralJournalCurrencyCode.val()===""){
            handlersInput(txtGeneralJournalCurrencyCode);
        }else{
            unHandlersInput(txtGeneralJournalCurrencyCode);
        }
        
        if(parseFloat(removeCommas(txtGeneralJournalExchangeRate.val()))>0){
            unHandlersInput(txtGeneralJournalExchangeRate);
        }else{
            handlersInput(txtGeneralJournalExchangeRate);
        }
        
    }
</script>
<b>GENERAL JOURNAL</b>
<hr>
<br class="spacer" />
<s:url id="remoteurlGeneralJournalDetailDocumentInput" action="general-journal-detail-data" />
<s:url id="remoteurlGeneralJournalSubDetailDocument" action="" />

<div id="generalJournalInput" class="content ui-widget">
        <s:form id="frmGeneralJournalInput">
            <table cellpadding="2" cellspacing="2" id="headerInputGeneralJournal">
                <tr>
                    <td align="right" style="width:120px"><B>Branch *</B></td>
                    <td colspan="2">
                    <script type = "text/javascript">

                        txtGeneralJournalBranchCode.change(function(ev) {

                            if(txtGeneralJournalBranchCode.val()===""){
                                txtGeneralJournalBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtGeneralJournalBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtGeneralJournalBranchCode.val(data.branchTemp.code);
                                    txtGeneralJournalBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtGeneralJournalBranchCode);
                                    txtGeneralJournalBranchCode.val("");
                                    txtGeneralJournalBranchName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="generalJournal.branch.code" name="generalJournal.branch.code" size="22"></s:textfield>
                        <sj:a id="generalJournal_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="generalJournal.branch.name" name="generalJournal.branch.name" size="40" readonly="true" required="true" cssClass="required"></s:textfield>
                        <s:textfield id="generalJournalTemp.createdDateTemp" name="generalJournalTemp.createdDateTemp" cssStyle="display:none"></s:textfield>
                        <sj:datepicker id="generalJournal.createdDate" name="generalJournal.createdDate" required="true" cssClass="required" size="25" displayFormat="dd/mm/yy"  timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" showOn="focus" cssStyle="display:none"></sj:datepicker>
                </tr>
               <tr>
                    <td align="right"><B>GJM No *</B></td>
                    <td colspan="3"><s:textfield id="generalJournal.code" name="generalJournal.code" key="generalJournal.code" readonly="true" size="25"></s:textfield></td>
                    <td><s:textfield id="generalJournalCurrencyCodeSession" name="generalJournalCurrencyCodeSession" size="20" disabled="true" hidden="true"></s:textfield></td>
                    <td><s:textfield id="generalJournalUpdateMode" name="generalJournalUpdateMode" size="20" disabled="true" hidden="true"></s:textfield></td>
                </tr> 
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="generalJournal.transactionDate" name="generalJournal.transactionDate" title=" " required="true" cssClass="required" size="25" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" onchange="generalJournalTransactionDateOnChange()"></sj:datepicker>
                        <sj:datepicker id="generalJournalTransactionDate" name="generalJournalTransactionDate" title=" " required="true" cssClass="required" size="25" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                        <s:textfield id="generalJournalTemp.transactionDateTemp" name="generalJournalTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                    </td>
                    <td>
                        <sj:datepicker id="generalJournalTransactionDateFirstSession" name="generalJournalTransactionDateFirstSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                        <sj:datepicker id="generalJournalTransactionDateLastSession" name="generalJournalTransactionDateLastSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Currency *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            txtGeneralJournalCurrencyCode.change(function(ev) {
                                
                                if(txtGeneralJournalCurrencyCode.val()===""){
                                    txtGeneralJournalCurrencyName.val("");
                                    txtGeneralJournalExchangeRate.val("0.00");
                                    txtGeneralJournalExchangeRate.attr("readonly",true);
                                    return;
                                }
                                var url = "master/currency-get";
                                var params = "currency.code=" + txtGeneralJournalCurrencyCode.val();
                                    params+= "&currency.activeStatus=TRUE";
                                
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.currencyTemp){
                                        txtGeneralJournalCurrencyCode.val(data.currencyTemp.code);
                                        txtGeneralJournalCurrencyName.val(data.currencyTemp.name);
                                        generalJournalLoadExchangeRate();
                                    }
                                    else{
                                        alertMessage("Currency Not Found!",txtGeneralJournalCurrencyCode);
                                        txtGeneralJournalCurrencyCode.val("");
                                        txtGeneralJournalCurrencyName.val("");
                                        txtGeneralJournalExchangeRate.val("0.00");
                                        txtGeneralJournalExchangeRate.attr("readonly",true);
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="generalJournal.currency.code" name="generalJournal.currency.code" size="25" required="true" cssClass="required" title=" "></s:textfield>
                        <sj:a id="generalJournal_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        <s:textfield id="generalJournal.currency.name" name="generalJournal.currency.name" size="45"  readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Exchange Rate *</B></td>
                    <td>
                    <s:textfield id="generalJournal.exchangeRate" name="generalJournal.exchangeRate" size="25" style="text-align: right" readonly="true"></s:textfield>&nbsp;<span id="errmsgExchangeRate"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td colspan="3"><s:textfield id="generalJournal.refNo" name="generalJournal.refNo"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td colspan="3"><s:textarea id="generalJournal.remark" name="generalJournal.remark"  cols="100" rows="2" height="20"></s:textarea></td>
                </tr>
                <tr hidden="false">
                    <td>
                        <s:textfield id="generalJournal.createdBy" name="generalJournal.createdBy" key="generalJournal.createdBy" readonly="true" size="22"></s:textfield>
                        <sj:datepicker id="generalJournal.createdDate" name="generalJournal.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                        <s:textfield id="generalJournalTemp.createdDateTemp" name="generalJournalTemp.createdDateTemp" size="20"></s:textfield>
                    </td>
                </tr>
            </table>
        </s:form>
                <table>
                <tr>
                    <td align="right">
                        <sj:a href="#" id="btnConfirmGeneralJournal" button="true">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmGeneralJournal" button="true">UnConfirm</sj:a>
                    </td>

                </tr>
                </table>
                 <table width="20%">
                    <tr>
                        <td>
                            <sj:a href="#" id="btnGeneralJournalSearchDetail" button="true" style="width: 90%">Finance Document</sj:a> 
                        </td>
                    </tr>
                </table>             
                <div id="generalJournalDetailDocumentInputGrid">
                <sjg:grid
                    id="generalJournalDetailDocumentInput_grid"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listGeneralJournalDetailTemp"
                    rowList="10,20,30"
                    rowNum="10"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnuGeneralJournalDetailDocument').width()"
                    editurl="%{remoteurlGeneralJournalDetailDocumentInput}"
                    onSelectRowTopics="generalJournalDetailDocumentInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name = "generalJournalDetailDocument" index="generalJournalDetailDocument" key="generalJournalDetailDocument" 
                        title="--" width="50"  editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentDelete" index="generalJournalDetailDocumentDelete" title="" width="50" align="centre"
                        editable="true"
                        edittype="button"
                        editoptions="{onClick:'generalJournalDetailDocumentInputGrid_Delete_OnClick()', value:'delete'}"
                    />
                   
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentDocumentType" index="generalJournalDetailDocumentDocumentType" key="generalJournalDetailDocumentDocumentType" title="Type" width="80" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentDocumentNo" index="generalJournalDetailDocumentDocumentNo" 
                        key="generalJournalDetailDocumentDocumentNo" title="Document No" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentDocumentRefNo" index="generalJournalDetailDocumentDocumentRefNo" 
                        key="generalJournalDetailDocumentDocumentRefNo" title="Document RefNo" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailChartOfAccountSearch" index="generalJournalDetailChartOfAccountSearch" title="" width="25" align="centre"
                        editable="true"
                        dataType="html"
                        edittype="button"
                        editoptions="{onClick:'generalJournalDetailDocumentInputGrid_SearchAccount_OnClick()', value:'...'}"
                    /> 
                     <sjg:gridColumn
                        name="generalJournalDetailDocumentChartOfAccountCode" index="generalJournalDetailDocumentChartOfAccountCode" 
                        title="Chart Of Account Code" width="160" sortable="true" editable="true" edittype="text"
                        editoptions="{onChange:'onChangeGeneralJournalDetailChartOfAccount()'}"
                    />     
                     <sjg:gridColumn
                        name="generalJournalDetailDocumentChartOfAccountName" index="generalJournalDetailDocumentChartOfAccountName" 
                        title="Chart Of Account Name" width="160" sortable="true"
                    />  
                    
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentAmountIDR" index = "generalJournalDetailDocumentAmountIDR" key = "generalJournalDetailDocumentAmountIDR" 
                        title = "Doc Amount (IDR)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                   
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentBalanceIDR" index = "generalJournalDetailDocumentBalanceIDR" key = "generalJournalDetailDocumentBalanceIDR" 
                        title = "Doc Balance (IDR)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentTransactionStatus" index = "generalJournalDetailDocumentTransactionStatus" key = "generalJournalDetailDocumentTransactionStatus" title = "Transaction Status" width = "100" 
                        formatter="select" align="center" formoptions="{label:'Please Select'}"
                        editable="true" edittype="select" editoptions="{value:'---Select---:---Select---;Transaction:Transaction;Other:Other',onChange:'refreshCashReceivedInputanGridByOthersTransactionStatus()'}" 
                    />
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentTransactionStatusTemp" 
                        index = "generalJournalDetailDocumentTransactionStatusTemp" 
                        key = "generalJournalDetailDocumentTransactionStatusTemp" title = "" width = "100" hidden="true"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentDebitForeign" index="generalJournalDetailDocumentDebitForeign" key="generalJournalDetailDocumentDebitForeign" title="Debit (Foreign)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateNumberOfGridAmount()',onChange:'countAmountIDRToForeignDebit()',onKeyUp:'countAmountIDRToForeignDebit()'}"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentDebitIDR" index="generalJournalDetailDocumentDebitIDR" key="generalJournalDetailDocumentDebitIDR" title="Debit (IDR)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateNumberOfGridAmount()',onChange:'countAmountForeignToIDRDebit()',onKeyUp:'countAmountForeignToIDRDebit()'}"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentCreditForeign" index="generalJournalDetailDocumentCreditForeign" key="generalJournalDetailDocumentCreditForeign" title="Credit (Foreign)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateNumberOfGridAmount()',onChange:'countAmountIDRToForeignCredit()',onKeyUp:'countAmountIDRToForeignCredit()'}"
                    />
                    <sjg:gridColumn
                        name="generalJournalDetailDocumentCreditIDR" index="generalJournalDetailDocumentCreditIDR" key="generalJournalDetailDocumentCreditIDR" title="Credit (IDR)" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        editoptions="{onKeypress:'validateNumberOfGridAmount()',onChange:'countAmountForeignToIDRCredit()',onKeyUp:'countAmountForeignToIDRCredit()'}"
                    />    
                     <sjg:gridColumn
                        name="generalJournalDetailDocumentBranchCode" index="generalJournalDetailDocumentBranchCode" key="generalJournalDetailDocumentBranchCode" title="Branch" width="80" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentCurrencyCode" index = "generalJournalDetailDocumentCurrencyCode" key = "generalJournalDetailDocumentCurrencyCode" title = "Currency" width = "80" 
                    />
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentExchangeRate" index = "generalJournalDetailDocumentExchangeRate" key = "generalJournalDetailDocumentExchangeRate" 
                        title = "Rate" width = "80" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentAmountForeign" index = "generalJournalDetailDocumentAmountForeign" key = "generalJournalDetailDocumentAmountForeign" 
                        title = "Doc Amount (Foreign)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                     <sjg:gridColumn
                        name = "generalJournalDetailDocumentBalanceForeign" index = "generalJournalDetailDocumentBalanceForeign" key = "generalJournalDetailDocumentBalanceForeign" 
                        title = "Doc Balance (Foreign)" width = "150" align="right"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name = "generalJournalDetailDocumentRemark" index="generalJournalDetailDocumentRemark" key="generalJournalDetailDocumentRemark" title="Remark" width="225"  editable="true" edittype="text"
                    />
                </sjg:grid >                
            </div>
        <table width="13%">
            <tr>
                <td width="50%" align="right">
                    <s:textfield id="generalJournalAddRow" name="bankPaymentAddRow" value="1" style="width: 60%; text-align: right;"></s:textfield>
                </td>
                <td>
                    <sj:a href="#" id="btnGeneralJournalAddDetail" button="true" style="width: 90%">Add</sj:a> 
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnGeneralJournalSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnGeneralJournalCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
            <tr>
                <td width="50%"></td>
                <td height="10px" align="middle" colspan="4">
                    <sj:a href="#" id="btnGeneralJournalCalculate" button="true" style="width: 80px">Calculate</sj:a>
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
                            <td><s:textfield id="generalJournalTotalDebitForeign" name="generalJournalTotalDebitForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                            <td><s:textfield id="generalJournalTotalDebitIDR" name="generalJournalTotalDebitIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        </tr>          
                        <tr>
                            <td style="text-align: right">Total(Credit)</td>
                            <td><s:textfield id="generalJournalTotalCreditForeign" name="generalJournalTotalCreditForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                            <td><s:textfield id="generalJournalTotalCreditIDR" name="generalJournalTotalCreditIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>

                        </tr>
                        <tr>
                            <td style="text-align: right">Balance</td>
                            <td><s:textfield id="generalJournalTotalBalanceForeign" name="generalJournalTotalBalanceForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                            <td><s:textfield id="generalJournalTotalBalanceIDR" name="generalJournalTotalBalanceIDR" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00"></s:textfield></td>
                        </tr>
                        <tr>
                            <td/><td/>
                            <td height="10px" align="right" colspan="2"><lable><B><u>Forex Gain / Loss</u></B></lable></td>
                            <td width="25%"/>
                        </tr>
                        <tr>
                            <td style="text-align: right">Amount</td>
                            <td colspan="2"><s:textfield id="generalJournalForexAmount" name="generalJournalForexAmount" readonly="true" cssStyle="text-align:right" size="25" PlaceHolder="0.00"></s:textfield>IDR</td>
                        </tr>
                    </table>
                </td>
        </table>
    </div> 