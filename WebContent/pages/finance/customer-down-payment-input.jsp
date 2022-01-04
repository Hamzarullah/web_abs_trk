
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<style>
    #errmsgExchangeRate,#errmsgTotalTransactionAmount,#errmsgVatPercent{
        color: red;
    }
        
    .ui-dialog-titlebar-close{
        display: none;
    }
    input{border-radius: 3px;height:18px}
    textarea{border-radius: 3px;}
    .searchbox{
        border-radius: 3px;
    }
    input[readonly="readonly"] { background:#FFF1A0 }
    textarea[readonly="readonly"] { background:#FFF1A0 }
</style>

<script type="text/javascript">
    var 
        txtCustomerDownPaymentBranchCode = $("#customerDownPayment\\.branch\\.code"),
        txtCustomerDownPaymentBranchName = $("#customerDownPayment\\.branch\\.name"),
        dtpCustomerDownPaymentTransactionDate = $("#customerDownPayment\\.transactionDate"),
        txtCustomerDownPaymentCustomerCode = $("#customerDownPayment\\.customer\\.code"),
        txtCustomerDownPaymentCustomerName = $("#customerDownPayment\\.customer\\.name"),
        txtCustomerDownPaymentCustomerAddress = $("#customerDownPayment\\.customer\\.address"),
        txtCustomerDownPaymentCustomerPhone1 = $("#customerDownPayment\\.customer\\.phone1"),
        txtCustomerDownPaymentCustomerCityName = $("#customerDownPayment\\.customer\\.city\\.name"),
        txtCustomerDownPaymentCustomerCountryName = $("#customerDownPayment\\.customer\\.country\\.name"),
        txtCustomerDownPaymentCustomerContactPerson = $("#customerDownPayment\\.customer\\.contactPerson"),
        txtCustomerDownPaymentCustomerFax = $("#customerDownPayment\\.customer\\.fax"),
        txtCustomerDownPaymentCustomerNameTemp = $("#customerDownPayment\\.customerNameAlias"),
        txtCustomerDownPaymentCustomerAddressTemp = $("#customerDownPayment\\.customerAddressAlias"),
        txtCustomerDownPaymentCustomerFaxTemp = $("#customerDownPayment\\.customerFaxAlias"),
        txtCustomerDownPaymentCustomerPhone1Temp = $("#customerDownPayment\\.customerPhone1Alias"),
        txtCustomerDownPaymentCustomerCityNameTemp = $("#customerDownPayment\\.customerCityAlias"),
        txtCustomerDownPaymentCustomerCountryNameTemp = $("#customerDownPayment\\.customerCountryAlias"),
        txtCustomerDownPaymentCustomerContactPersonTemp = $("#customerDownPayment\\.customerContactPersonAlias"),
        txtCustomerDownPaymentTINNo = $("#customerDownPayment\\.tinNo"),
        txtCustomerDownPaymentCurrencyCode = $("#customerDownPayment\\.currency\\.code"),
        txtCustomerDownPaymentCurrencyName = $("#customerDownPayment\\.currency\\.name"),
        txtCustomerDownPaymentExchangeRate = $("#customerDownPayment\\.exchangeRate"),
        txtCustomerDownPaymentCDPNote = $("#customerDownPayment\\.cdpNote"),
        txtCustomerDownPaymentTotalTransactionAmount = $("#customerDownPayment\\.totalTransactionAmount"),
        txtCustomerDownPaymentVATPercent = $("#customerDownPayment\\.vatPercent"),
        txtCustomerDownPaymentVATAmount = $("#customerDownPayment\\.vatAmount"),
        txtCustomerDownPaymentGrandTotalAmount = $("#customerDownPayment\\.grandTotalAmount"),
        txtCustomerDownPaymentPaymentTermCode = $("#customerDownPayment\\.paymentTerm\\.code"),
        txtCustomerDownPaymentPaymentTermName = $("#customerDownPayment\\.paymentTerm\\.name"),
        txtCustomerDownPaymentBankAccountCode = $("#customerDownPayment\\.bankAccount\\.code"),
        txtCustomerDownPaymentBankAccountName = $("#customerDownPayment\\.bankAccount\\.name"),
        txtCustomerDownPaymentRefno = $("#customerDownPayment\\.refNo"),
        txtCustomerDownPaymentRemark = $("#customerDownPayment\\.remark"),
        
        txtCustomerDownPaymentUsedAmount = $("#customerDownPayment\\.usedAmount"),
        txtCustomerDownPaymentPaidAmount = $("#customerDownPayment\\.paidAmount"),
        txtCustomerDownPaymentSettlementDate = $("#customerDownPayment\\.settlementDate"),
        txtCustomerDownPaymentSettlementDocumentNo = $("#customerDownPayment\\.settlementDocumentNo"),
        txtCustomerDownPaymentCreatedBy = $("#customerDownPayment\\.createdBy"),
        txtCustomerDownPaymentCreatedDate = $("#customerDownPayment\\.createdDate"),
        
        
        allFieldsCDP = $([])
            .add(txtCustomerDownPaymentCustomerCityName)
            .add(txtCustomerDownPaymentCustomerCountryName)
            .add(txtCustomerDownPaymentExchangeRate)
            .add(txtCustomerDownPaymentCustomerCode)
            .add(txtCustomerDownPaymentCustomerName)
            .add(txtCustomerDownPaymentCustomerAddress)
            .add(txtCustomerDownPaymentCustomerPhone1)
            .add(txtCustomerDownPaymentCustomerContactPerson)
            .add(txtCustomerDownPaymentCustomerFax)
            .add(txtCustomerDownPaymentTINNo)
            .add(txtCustomerDownPaymentCDPNote)
            .add(txtCustomerDownPaymentPaymentTermCode)
            .add(txtCustomerDownPaymentPaymentTermName)
            .add(txtCustomerDownPaymentBankAccountCode)
            .add(txtCustomerDownPaymentBankAccountName)
            .add(txtCustomerDownPaymentRefno)
            .add(txtCustomerDownPaymentRemark);

    
    function alertMessageCdp(alert_message,txt){
        
        var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>'+alert_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>' +
                    '</div>');
            
            dynamicDialog.dialog({
                title : "Attention!",
                closeOnEscape: false,
                modal : true,
                width: 400,
                resizable: false,
                closeText: "hide",
                buttons : 
                    [{
                        text : "OK",
                        click : function() {
                            $(this).dialog("close");
                            txt.focus();
                        }
                    }]
            });
    }
    
    function calculateGrandTotal(){
        var totalTransaction=$("#customerDownPayment\\.totalTransactionAmount").val().replace(/,/g,"");
        var exchangeRate=$("#customerDownPayment\\.exchangeRate").val().replace(/,/g,"");
        var varPercent=$("#customerDownPayment\\.vatPercent").val().replace(/,/g,"");
        var vatAmount;
        
        if(totalTransaction===""){
            totalTransaction=0;
            $("#customerDownPayment\\.vatAmount").val("0.00");
            txtCustomerDownPaymentGrandTotalAmount.val("0.00");
        }
        
        if(exchangeRate===""){
            $("#customerDownPayment\\.vatAmount").val("0.00");
            txtCustomerDownPaymentGrandTotalAmount.val("0.00");
            exchangeRate=0;
        }
        
        if(varPercent===""){
            $("#customerDownPayment\\.vatAmount").val("0.00");
            varPercent=0;
        }
        
        
        vatAmount=(parseFloat(totalTransaction) * parseFloat(varPercent))/100;
        
        $("#customerDownPayment\\.vatAmount").val(formatNumber(vatAmount,2));
        
        var grandTotalAmount=parseFloat(totalTransaction) + vatAmount;
        $("#customerDownPayment\\.grandTotalAmount").val(formatNumber(grandTotalAmount,2));
        
        
    }

    function formatDateAndNumericInCdp(){
        var transactionDate=$("#customerDownPayment\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpCustomerDownPaymentTransactionDate.val(transactionDateValue);
        $("#customerDownPaymentTemp\\.transactionDateTemp").val(dtpCustomerDownPaymentTransactionDate.val());        
        
        
        var createdDate=$("#customerDownPayment\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var createdDateValues= createdDateTemp[0].split('/');
        var createdDateValue = createdDateValues[1]+"/"+createdDateValues[0]+"/"+createdDateValues[2]+" "+createdDateTemp[1];
        $("#customerDownPayment\\.createdDate").val(createdDateValue);
        $("#customerDownPaymentTemp\\.createdDateTemp").val(createdDateValue);
        
        var exchangeRate =removeCommas(txtCustomerDownPaymentExchangeRate.val());
        var totalTransaction =removeCommas(txtCustomerDownPaymentTotalTransactionAmount.val());
        var taxAmount =removeCommas(txtCustomerDownPaymentVATAmount.val());
        var grandTotal =removeCommas(txtCustomerDownPaymentGrandTotalAmount.val());
        txtCustomerDownPaymentExchangeRate.val(exchangeRate);
        txtCustomerDownPaymentTotalTransactionAmount.val(totalTransaction);
        txtCustomerDownPaymentVATAmount.val(taxAmount);
        txtCustomerDownPaymentGrandTotalAmount.val(grandTotal);
    }
    
    function numberWithCommasCdp(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    $(document).ready(function() {
        customerDownPaymentValidateCurrencyExchangeRate();
        var vatPercent=parseFloat(txtCustomerDownPaymentVATPercent.val());
        txtCustomerDownPaymentVATPercent.val(formatNumber(vatPercent,2));
        
        $("#SalesOrderDetailGrid").hide();
        
        $("#customerDownPayment\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        
        $("#customerDownPayment\\.exchangeRate").change(function(e){
            var exrate=$("#customerDownPayment\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#customerDownPayment\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#customerDownPayment\\.totalTransactionAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        
        $("#customerDownPayment\\.totalTransactionAmount").change(function(e){
            var amount=$("#customerDownPayment\\.totalTransactionAmount").val();
            if(amount===""){
               $("#customerDownPayment\\.totalTransactionAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#customerDownPayment\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgVatPercent").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

         
        $("#customerDownPayment\\.vatPercent").change(function(e){
            var vatPercent=$("#customerDownPayment\\.vatPercent").val();
            if(vatPercent===""){
               $("#customerDownPayment\\.vatPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
           
        });

        $('#btnCustomerDownPaymentSave').click(function(ev) {
            
            var transactionDateCDP=dtpCustomerDownPaymentTransactionDate.val().split(' ');
            var dateFirstSession=new Date($("#customerDownPaymentTransactionDateFirstSession").val());
            var dateLastSession=new Date($("#customerDownPaymentTransactionDateLastSession").val());
            var dateValues= transactionDateCDP[0].split('/');
            var transactionDateValue =new Date(dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]);
            
            if(transactionDateValue < dateFirstSession || transactionDateValue > dateLastSession){
                alertMessageCdp("Transaction date must between sesion period!",dtpCustomerDownPaymentTransactionDate);
                return;
            }
            
            if(!$("#frmCustomerDownPaymentInput").valid()) {
                alertMessageCdp("Please Check Your Input..!");
                return;
            }
            if(txtCustomerDownPaymentCustomerName.val()===""){
                alertMessageCdp("Customer Cannot Empty!",txtCustomerDownPaymentCustomerCode);
                return;
            }
            if(txtCustomerDownPaymentCurrencyName.val()===""){
                alertMessageCdp("Currency Cannot Empty!",txtCustomerDownPaymentCurrencyCode);
                return;
            }
            if(txtCustomerDownPaymentCDPNote.val()===""){
                alertMessageCdp("CDPNote Cannot Empty!",txtCustomerDownPaymentCDPNote);
                return;
            }
            if(parseFloat(txtCustomerDownPaymentTotalTransactionAmount.val())<0){
                alertMessageCdp("Total Transaction Amount Is Invalid!",txtCustomerDownPaymentTotalTransactionAmount);
                return;
            }
            if(txtCustomerDownPaymentPaymentTermName.val()===""){
                alertMessageCdp("Payment Term Cannot Empty!",txtCustomerDownPaymentPaymentTermCode);
                return;
            }
            if(txtCustomerDownPaymentBankAccountName.val()===""){
                alertMessageCdp("Bank Account Cannot Empty!",txtCustomerDownPaymentBankAccountCode);
                return;
            }
            
//            var transactionDateCDP=$("#customerDownPayment\\.transactionDate").val().split(' ');
//            var transactionDateCDPValues= transactionDateCDP[0].split('/');
//            var transactionDateCDPValue = transactionDateCDPValues[1]+"/"+transactionDateCDPValues[0]+"/"+transactionDateCDPValues[2];

//            var url = "master/exchange-rate-bi-by-date";
//            var params = "exchangeRateBi.transactionDate=" + transactionDateCDPValue;
//            params +="&exchangeRateBi.currency.code="+ txtCustomerDownPaymentCurrencyCode.val();
//            
//            $.getJSON(url, params, function(result) {
//                var data = (result);
//                if (data.listExchangeRateBi[0]){                    
//                    if(txtCustomerDownPaymentCurrencyCode.val()==="IDR"){
//                        $("#customerDownPayment\\.exchangeRate").attr('readonly',true);
//                    }else{
//                        $("#customerDownPayment\\.exchangeRate").attr('readonly',false);
//                    }
//                    var exchangeRate=parseFloat(txtCustomerDownPaymentExchangeRate.val());
//                    if(exchangeRate===0){
//                       alert("Exchange Rate should greater than 0");
//                       txtCustomerDownPaymentExchangeRate.focus();
//                       return;
//                    }
                    formatDateAndNumericInCdp();   
                    var url="finance/customer-down-payment-save";
                    var params = $("#frmCustomerDownPaymentInput").serialize();
                    showLoading();
                    $.post(url, params, function(data) {
                        $("#dlgLoading").dialog("close");
                        if (data.error) {
                            closeLoading();
                            alert(data.errorMessage);
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
                                        var url = "finance/customer-down-payment-input";
                                        var param = "";
                                        pageLoad(url, param, "#tabmnuCUSTOMER_DOWN_PAYMENT");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        var url = "finance/customer-down-payment";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuCUSTOMER_DOWN_PAYMENT");
                                    }
                                }]
                        });
                    });
//                }else{
//                    if(txtCustomerDownPaymentCurrencyCode.val()===""){
//                        txtCustomerDownPaymentCurrencyName.val("");
//                        txtCustomerDownPaymentExchangeRate.val("0.00");
//                        $("#customerDownPayment\\.exchangeRate").attr('readonly',true);
//                        return;
//                    }else{
//                        var dynamicDialog= $(
//                                '<div id="conformBoxError">'+
//                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                                        '</span>Exchange Rate BI '+txtCustomerDownPaymentCurrencyCode.val()+' On Date ' + dtpCustomerDownPaymentTransactionDate.val().substring(0,10)+' Is Not Set!<span style="float:left; margin:0 7px 20px 0;">'+
//                                    '</span>' +
//                                '</div>');
//
//                        dynamicDialog.dialog({
//                            title : "Attention!",
//                            closeOnEscape: false,
//                            modal : true,
//                            width: 400,
//                            resizable: false,
//                            closeText: "hide",
//                            buttons : 
//                                [{
//                                    text : "OK",
//                                    click : function() {
//                                        $(this).dialog("close");
//                                        txtCustomerDownPaymentCurrencyCode.val("");
//                                        txtCustomerDownPaymentCurrencyName.val("");
//                                        txtCustomerDownPaymentExchangeRate.val("0.00");
//                                        $("#customerDownPayment\\.exchangeRate").attr('readonly',true);
//                                        txtCustomerDownPaymentCurrencyCode.focus();
//                                    }
//                                }]
//                        });
//                    }
//                }
//             });
        });


        $('#btnCustomerDownPaymentCancel').click(function(ev) {
            
            var url = "finance/customer-down-payment";
            var params = "";
            
            pageLoad(url, params, "#tabmnuCUSTOMER_DOWN_PAYMENT"); 
            
        });
        
        $('#customerDownPayment_btnPaymentTerm').click(function(ev) {
            window.open("./pages/search/search-payment-term.jsp?iddoc=customerDownPayment&idsubdoc=paymentTerm","Search", "width=600, height=500");
        });
        
        $('#customerDownPayment_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=customerDownPayment&idsubdoc=currency","Search", "width=600, height=500");
        });
                            
        $('#customerDownPayment_btnBankAccount').click(function(ev) {
            window.open("./pages/search/search-bank-account.jsp?iddoc=customerDownPayment&idsubdoc=bankAccount","Search", "width=600, height=500");
        });
        $('#customerDownPayment_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerDownPayment&idsubdoc=customer","Search", "width=600, height=500");
        });

        $('#customerDownPayment_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=customerDownPayment&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
    });
    
    function getExchangeRateBICDP(){
        var transactionDateCDP=$("#customerDownPayment\\.transactionDate").val().split(' ');
        var transactionDateCDPValues= transactionDateCDP[0].split('/');
        var transactionDateCDPValue = transactionDateCDPValues[1]+"/"+transactionDateCDPValues[0]+"/"+transactionDateCDPValues[2];

        var url = "master/exchange-rate-by-date";
        var params = "exchangeRate.transactionDate=" + transactionDateCDPValue;
        params +="&exchangeRate.currency.code="+ txtCustomerDownPaymentCurrencyCode.val();
        alert(params);
        return;
        $.getJSON(url, params, function(result) {
            var data = (result);
            if (data.listExchangeRate[0]){                    
                txtCustomerDownPaymentExchangeRate.val(formatNumber(parseFloat(data.listExchangeRate[0].exchangeRate),2));
                if(txtCustomerDownPaymentCurrencyCode.val()==="IDR"){
                    $("#customerDownPayment\\.exchangeRate").attr('readonly',true);
                }else{
                    $("#customerDownPayment\\.exchangeRate").attr('readonly',false);
                }
            }else{
                if(txtCustomerDownPaymentCurrencyCode.val()!=="IDR"){
                    txtCustomerDownPaymentCurrencyName.val("");
                    txtCustomerDownPaymentExchangeRate.val("0.00");
                    $("#customerDownPayment\\.exchangeRate").attr('readonly',false);
                    return;
                }else{
                    var dynamicDialog= $(
                            '<div id="conformBoxError">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>Exchange Rate BI '+txtCustomerDownPaymentCurrencyCode.val()+' On Date ' + dtpCustomerDownPaymentTransactionDate.val().substring(0,10)+' Is Not Set!<span style="float:left; margin:0 7px 20px 0;">'+
                                '</span>' +
                            '</div>');

                    dynamicDialog.dialog({
                        title : "Attention!",
                        closeOnEscape: false,
                        modal : true,
                        width: 400,
                        resizable: false,
                        closeText: "hide",
                        buttons : 
                            [{
                                text : "OK",
                                click : function() {
                                    $(this).dialog("close");
                                    txtCustomerDownPaymentCurrencyCode.val("");
                                    txtCustomerDownPaymentCurrencyName.val("");
                                    txtCustomerDownPaymentExchangeRate.val("0.00");
                                    $("#customerDownPayment\\.exchangeRate").attr('readonly',true);
                                    txtCustomerDownPaymentCurrencyCode.focus();
                                }
                            }]
                    });
                }
            }
         });
    }
    
    function customerDownPaymentValidateCurrencyExchangeRate(){ 
        if (txtCustomerDownPaymentCurrencyCode.val()==="IDR"){
            txtCustomerDownPaymentExchangeRate.val("1.00");
            txtCustomerDownPaymentExchangeRate.attr("readonly",true);
        }else{
//            if($("#customerDownPaymentUpdateMode").val()==="false"){
//                txtCustomerDownPaymentExchangeRate.val("0.00");   
//            }
            txtCustomerDownPaymentExchangeRate.attr("readonly",false);
        }
    }
    
</script>

<s:url id="remotedetailurlCustomerDownPaymentDetailInput" action="" />
<b>CUSTOMER DOWN PAYMENT</b>
<hr>
<br class="spacer" />
<div id="customerDownPaymentInput" class="content ui-widget">
        <s:form id="frmCustomerDownPaymentInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>CDP No *</B></td>
                    <td><s:textfield id="customerDownPayment.code" name="customerDownPayment.code" key="customerDownPayment.code" readonly="true" size="25"></s:textfield></td>
                    <td><s:textfield id="customerDownPaymentUpdateMode" name="customerDownPaymentUpdateMode" size="20" cssStyle="display:none"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="customerDownPayment.transactionDate" name="customerDownPayment.transactionDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                        <s:textfield id="customerDownPaymentTemp.transactionDateTemp" name="customerDownPaymentTemp.transactionDateTemp" size="15" cssStyle="display:none"></s:textfield>
                        <s:textfield id="customerDownPaymentUpdateMode" name="customerDownPaymentUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                        <sj:datepicker id="customerDownPaymentTransactionDateFirstSession" name="customerDownPaymentTransactionDateFirstSession" size="20" showOn="focus" cssStyle="display:none"></sj:datepicker>
                        <sj:datepicker id="customerDownPaymentTransactionDateLastSession" name="customerDownPaymentTransactionDateLastSession" size="20" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width:120px"><B>Branch *</B></td>
                    <td colspan="2">
                    <script type = "text/javascript">

                        txtCustomerDownPaymentBranchCode.change(function(ev) {

                            if(txtCustomerDownPaymentBranchCode.val()===""){
                                txtCustomerDownPaymentBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtCustomerDownPaymentBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtCustomerDownPaymentBranchCode.val(data.branchTemp.code);
                                    txtCustomerDownPaymentBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtCustomerDownPaymentBranchCode);
                                    txtCustomerDownPaymentBranchCode.val("");
                                    txtCustomerDownPaymentBranchName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="customerDownPayment.branch.code" name="customerDownPayment.branch.code" size="22"></s:textfield>
                        <sj:a id="customerDownPayment_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="customerDownPayment.branch.name" name="customerDownPayment.branch.name" size="40" readonly="true"></s:textfield>
                </tr>
                <!--<tr>
                    <td align="right"><B>Customer Type *</B></td>
                    <td>
                        <%--<s:select label="Select Customer Type"
                            headerKey="-1" 
                            list="{'Regular Customer','One Time Customer'}" 
                            id="customerDownPayment.customerType" name="customerDownPayment.customerType" onchange="changeCustomerType()" style="width: 25%"/>--%> 
                    </td>
                </tr>-->
                <tr>
                    <td align="right"><B>Customer * </B></td>
                    <td>
                        <script type = "text/javascript">
                            txtCustomerDownPaymentCustomerCode.change(function(ev) {
                                if(txtCustomerDownPaymentCustomerCode.val()==="o001"||txtCustomerDownPaymentCustomerCode.val()==="O001"){
                                    $("#customerDownPayment\\.customerType").val('One Time Customer').attr('selected',true);
//                                    changeCustomerType();
                                    return; 
                                }
                                
                                    var url = "master/customer-get";
                                    var params = "customerTemp.code=" + txtCustomerDownPaymentCustomerCode.val();
                                    params += "&customer.ActiveStatus = TRUE";
                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerTemp){
                                            txtCustomerDownPaymentCustomerCode.val(data.customerTemp.code);
                                            txtCustomerDownPaymentCustomerName.val(data.customerTemp.name);
                                            txtCustomerDownPaymentCustomerCityName.val(data.customerTemp.cityName);
                                            txtCustomerDownPaymentCustomerAddress.val(data.customerTemp.address);
                                            txtCustomerDownPaymentCustomerPhone1.val(data.customerTemp.phone1);
                                            txtCustomerDownPaymentCustomerFax.val(data.customerTemp.fax);
                                            txtCustomerDownPaymentCustomerCountryName.val(data.customerTemp.countryName);
                                            txtCustomerDownPaymentCustomerContactPerson.val(data.customerTemp.contactPerson);
                                            }
                                        else{
                                            alertMessageCustomerDownPayment("Customer Not Found!",txtCustomerDownPaymentCustomerCode);
                                            txtCustomerDownPaymentCustomerCode.val("");
                                            txtCustomerDownPaymentCustomerName.val("");
                                            txtCustomerDownPaymentCustomerAddress.val("");
                                            txtCustomerDownPaymentCustomerPhone1.val("");
                                            txtCustomerDownPaymentCustomerFax.val("");
                                            txtCustomerDownPaymentCustomerCityName.val("");
                                            txtCustomerDownPaymentCustomerCountryName.val("");
                                            txtCustomerDownPaymentCustomerContactPerson.val("");                                    
                                            txtCustomerDownPaymentCustomerNameTemp.val("");
                                            txtCustomerDownPaymentCustomerAddressTemp.val("");
                                            txtCustomerDownPaymentCustomerPhone1Temp.val("");
                                            txtCustomerDownPaymentCustomerFaxTemp.val("");
                                            txtCustomerDownPaymentCustomerCityNameTemp.val("");
                                            txtCustomerDownPaymentCustomerCountryNameTemp.val("");
                                            txtCustomerDownPaymentCustomerContactPersonTemp.val("");                                    
                                        }
                                    });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="customerDownPayment.customer.code" name="customerDownPayment.customer.code" size="25" required="true" cssClass="required"></s:textfield>
                            <sj:a id="customerDownPayment_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        <%--<sj:a href="#" id="btnGetDataCustomer" button="true" cssStyle="Display:none">GET</sj:a>--%>
                        &nbsp;&nbsp;
                        <%--<sj:a href="#" id="btnCustomerDownPaymentDuplicatCustomerCode" style="height: 20px;" button="true">Ori Value</sj:a>--%>
                    </td>
                </tr>
                <tr>
                    <td  style="width: 110px" align="right">customer Name *</td>
                    <td colspan="2" >
                    <s:textfield id="customerDownPayment.customer.name" name="customerDownPayment.customer.name" size="53" readonly="true" required="true" ></s:textfield> &nbsp;
                    <%--<s:textfield id="customerDownPayment.customerNameAlias" name="customerDownPayment.customerNameAlias" size="53" readonly="true" cssStyle="display:none"></s:textfield>--%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px" align="right">Address </td>
                    <td valign="top" colspan="2" >
                        <s:textarea id="customerDownPayment.customer.address" name="customerDownPayment.customer.address"  cols="50" rows="1" height="20" readonly="true"></s:textarea>
                        &nbsp;
                        <%--<s:textarea id="customerDownPayment.customerAddressAlias" name="customerDownPayment.customerAddressAlias"  cols="50" rows="1" height="20" readonly="true" required="true" cssClass="required"></s:textarea>--%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px"  align="right">Phone 1 </td>
                    <td colspan="2" >
                        <s:textfield id="customerDownPayment.customer.phone1" name="customerDownPayment.customer.phone1"  size="25" readonly="true"></s:textfield>
                        <%--<s:textfield id="customerDownPayment.customerPhone1Alias" name="customerDownPayment.customerPhone1Alias"  size="25" readonly="true" required="true" cssClass="required"></s:textfield>--%>
                    </td>
                </tr>   
                <tr>
                    <td style="width: 110px"  align="right">Fax </td>
                    <td colspan="2" >
                        <s:textfield id="customerDownPayment.customer.fax" name="customerDownPayment.customer.fax"  size="25" readonly="true"></s:textfield>
                        <%--<s:textfield id="customerDownPayment.customerFaxAlias" name="customerDownPayment.customerFaxAlias"  size="25" readonly="true" required="true" cssClass="required"></s:textfield>--%>
                    </td>
                </tr>   
                <tr>
                    <td style="width: 110px" align="right">City </td>
                    <td colspan="2" >
                        <s:textfield id="customerDownPayment.customer.city.name" name="customerDownPayment.customer.city.name"  size="25" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Contact Person </td>
                    <td colspan="2" >
                        <s:textfield id="customerDownPayment.customer.contactPerson" name="customerDownPayment.customer.contactPerson"  size="25" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Tax Invoice No</td>
                    <td><s:textfield id="customerDownPayment.tinNo" name="customerDownPayment.tinNo" size="27"></s:textfield></td>
                </tr>
                <tr>
            <td align="right"><B>Currency *</B></td>
            <td colspan="2">
                <script type = "text/javascript">
                    txtCustomerDownPaymentCurrencyCode.change(function(ev) {

                        if(txtCustomerDownPaymentCurrencyCode.val()===""){
                            txtCustomerDownPaymentCurrencyName.val("");
                            return;
                        }

                        var url = "master/currency-get";
                        var params = "currency.code=" + txtCustomerDownPaymentCurrencyCode.val();
                            params+= "&currency.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.currencyTemp){
                                txtCustomerDownPaymentCurrencyCode.val(data.currencyTemp.code);
                                txtCustomerDownPaymentCurrencyName.val(data.currencyTemp.name);
                                customerDownPaymentValidateCurrencyExchangeRate();
                            }
                            else{
                                alertMessage("Currency Not Found!",txtCustomerDownPaymentCurrencyCode);
                                txtCustomerDownPaymentCurrencyCode.val("");
                                txtCustomerDownPaymentCurrencyName.val("");
                                txtCustomerDownPaymentExchangeRate.val("0.00");
                                txtCustomerDownPaymentExchangeRate.attr("readonly",true);
                            }
                        });
                    });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="customerDownPayment.currency.code" name="customerDownPayment.currency.code"></s:textfield>
                            <sj:a id="customerDownPayment_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="customerDownPayment.currency.name" name="customerDownPayment.currency.name" size="50" readonly="true" ></s:textfield> 
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Exchange Rate *</B></td>
                    <td><s:textfield id="customerDownPayment.exchangeRate" name="customerDownPayment.exchangeRate" size="27" cssStyle="text-align:right"  readonly="true"></s:textfield>&nbsp;<span id="errmsgExchangeRate"></span></td>
                </tr>
                <tr>
                    <td align="right"><B>CDP Note *</B></td>
                    <td><s:textfield id="customerDownPayment.cdpNote" name="customerDownPayment.cdpNote" size="50" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Total Transaction *</B></td>
                    <td><s:textfield id="customerDownPayment.totalTransactionAmount" name="customerDownPayment.totalTransactionAmount" size="27" cssStyle="text-align:right" onkeyup="calculateGrandTotal()" required="true" cssClass="required"></s:textfield>&nbsp;<span id="errmsgTotalTransactionAmount"></span></td>
                </tr>
                <tr>
                    <td align="right">VAT</td>
                    <td>
                    <s:textfield id="customerDownPayment.vatPercent" name="customerDownPayment.vatPercent" size="5" cssStyle="text-align:right" onkeyup="calculateGrandTotal()"></s:textfield>
                        %
                        <s:textfield id="customerDownPayment.vatAmount" name="customerDownPayment.vatAmount" size="17" cssStyle="text-align:right" readonly="true"></s:textfield>&nbsp;<span id="errmsgVatPercent"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">Grand Total</td>
                    <td><s:textfield id="customerDownPayment.grandTotalAmount" name="customerDownPayment.grandTotalAmount" size="27" cssStyle="text-align:right" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Payment Term *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            txtCustomerDownPaymentPaymentTermCode.change(function(ev) {
                                var url = "master/payment-term-get";
                                var params = "paymentTermTemp.code=" + txtCustomerDownPaymentPaymentTermCode.val();
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.paymentTermTemp){
                                        txtCustomerDownPaymentPaymentTermCode.val(data.paymentTermTemp.code);
                                        txtCustomerDownPaymentPaymentTermName.val(data.paymentTermTemp.name);
                                    }
                                    else{
                                        alertMessageCdp("Payment Term Not Found!",txtCustomerDownPaymentPaymentTermCode);
                                        txtCustomerDownPaymentPaymentTermCode.val("");
                                        txtCustomerDownPaymentPaymentTermName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="customerDownPayment.paymentTerm.code" name="customerDownPayment.paymentTerm.code" size="20"></s:textfield>
                        <sj:a id="customerDownPayment_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                            <s:textfield id="customerDownPayment.paymentTerm.name" name="customerDownPayment.paymentTerm.name" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Bank Account *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            txtCustomerDownPaymentBankAccountCode.change(function(ev) {
                                var url = "master/bank-account-get";
                                var params = "bankAccountTemp.code=" + txtCustomerDownPaymentBankAccountCode.val();
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.bankAccountTemp){
                                        txtCustomerDownPaymentBankAccountCode.val(data.bankAccountTemp.code);
                                        txtCustomerDownPaymentBankAccountName.val(data.bankAccountTemp.name);

                                    }
                                    else{
                                        alertMessageCdp("Bank Account Not Found!",txtCustomerDownPaymentBankAccountCode);
                                        txtCustomerDownPaymentBankAccountCode.val("");
                                        txtCustomerDownPaymentBankAccountName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="customerDownPayment.bankAccount.code" name="customerDownPayment.bankAccount.code" size="20"></s:textfield>
                        <sj:a id="customerDownPayment_btnBankAccount" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                            <s:textfield id="customerDownPayment.bankAccount.name" name="customerDownPayment.bankAccount.name" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td><s:textfield id="customerDownPayment.refNo" name="customerDownPayment.refNo" size="27"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td><s:textarea id="customerDownPayment.remark" name="customerDownPayment.remark"  cols="100" rows="2" height="20"></s:textarea></td>
                    <s:textfield id="customerDownPayment.createdBy" name="customerDownPayment.createdBy" size="52" cssStyle="display:none"></s:textfield>
                    <s:textfield id="customerDownPaymentTemp.createdDateTemp" name="customerDownPaymentTemp.createdDateTemp" size="15" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="customerDownPayment.createdDate" name="customerDownPayment.createdDate" required="true" cssClass="required" size="25" displayFormat="dd/mm/yy"  timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" showOn="focus" cssStyle="display:none"></sj:datepicker>
                </tr> 
            </table>     
        </s:form>     
        <div>
            <table>
                <tr>
                    <td width="51%"></td>
                    <td>
                        <sj:a href="#" id="btnCustomerDownPaymentSave" button="true">Save</sj:a>
                    </td>
                    <td>
                        <sj:a href="#" id="btnCustomerDownPaymentCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </div>
    </div> 
    
   