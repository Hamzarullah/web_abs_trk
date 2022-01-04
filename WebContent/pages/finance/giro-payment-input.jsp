
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #errmsgAmount{
        color: red;
    }
    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    var 
        txtGiroPaymentGiroNo = $("#giroPayment\\.giroNo"),
        txtGiroPaymentBranchCode = $("#giroPayment\\.branch\\.code"),
        txtGiroPaymentBranchName = $("#giroPayment\\.branch\\.name"),
//        txtGiroPaymentCompanyCode = $("#giroPayment\\.company\\.code"),
//        txtGiroPaymentCompanyName = $("#giroPayment\\.company\\.name"),        
        dtpGiroPaymentTransactionDate = $("#giroPayment\\.transactionDate"),
        dtpGiroPaymentDueDate = $("#giroPayment\\.dueDate"),
        txtGiroPaymentBankCode=$("#giroPayment\\.bank\\.code"),
        txtGiroPaymentBankName=$("#giroPayment\\.bank\\.name"),
        txtGiroPaymentPaymentTo = $("#giroPayment\\.paymentTo"),
        txtGiroPaymentGiroStatus = $("#giroPayment\\.giroStatus"),
        txtGiroPaymentCurrencyCode = $("#giroPayment\\.currency\\.code"),
        txtGiroPaymentCurrencyName = $("#giroPayment\\.currency\\.name"),
        txtGiroPaymentAmount = $("#giroPayment\\.amount"),
        txtGiroPaymentRefNo = $("#giroPayment\\.refNo"),
        txtGiroPaymentRemark = $("#giroPayment\\.remark"),
        txtGiroPaymentCreatedBy = $("#giroPayment\\.createdBy"),
        dtpGiroPaymentCreatedDate = $("#giroPayment\\.createdDate");
       
    
            
    $(document).ready(function() {
        
        formatNumericGiroPayment();
        
        $("#giroPayment\\.amount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#giroPayment\\.amount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommas(value); 
            });
        });
        
        $("#giroPayment\\.amount").change(function(e){
            var amount=$("#giroPayment\\.amount").val();
            if(amount===""){
               $("#giroPayment\\.amount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
           
        });
                 
        $('#btnGiroPaymentSave').click(function(ev) {
            handlers_input_giro_payment();
            if(!$("#frmGiroPaymentInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            var giroPaymentAmount = parseFloat(removeCommas($('#giroPayment\\.amount').val()));
           
            if (giroPaymentAmount === 0) {
                alertMessage("Amount Can't Be 0");
                return;
            }
            
            var date1 = dtpGiroPaymentTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#giroPaymentTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#giroPaymentUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#giroPaymentTransactionDate").val(),dtpGiroPaymentTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpGiroPaymentTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#giroPaymentUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#giroPaymentTransactionDate").val(),dtpGiroPaymentTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpGiroPaymentTransactionDate);
                }
                return;
            }
            
//            var date = $("#giroPayment\\.transactionDate").val().split("/");
//            var month = date[1];
//            var year = date[2].split(" ");
//            if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
//                alertMessage("Transaction Month Must Between Session Period Month!",dtpGiroPaymentTransactionDate);
//                return;
//            }
//
//            if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
//                alertMessage("Transaction Year Must Between Session Period Year!",dtpGiroPaymentTransactionDate);
//                return;
//            }
                
            formatDateGiroPayment();
            UnFormatNumericGiroPayment();
            
            var url = "finance/giro-payment-save";
            var params = $("#frmGiroPaymentInput").serialize();
                
            showLoading();
                
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error){
                    formatDateGiroPayment();
                    formatNumericGiroPayment();
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
                                var url = "finance/giro-payment-input";
                                var params = "";
                                pageLoad(url, params, "#tabmnuGIRO_PAYMENT");
                            }
                        },
                        {
                            text : "No",
                            click : function() {

                                $(this).dialog("close");
                                var url = "finance/giro-payment";
                                var params = "";
                                pageLoad(url, params, "#tabmnuGIRO_PAYMENT");

                            }
                        }]
                });

            });
        });
        
        $('#btnGiroPaymentCancel').click(function(ev) {
            var url = "finance/giro-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuGIRO_PAYMENT"); 
        });
        
        $('#giroPayment_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=giroPayment&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

//        $('#giroPayment_btnCompany').click(function(ev) {
//            window.open("./pages/search/search-company.jsp?iddoc=giroPayment&idsubdoc=company","Search", "Scrollbars=1,width=600, height=500");
//        });
            
        $('#giroPayment_btnBank').click(function(ev) {
            window.open("./pages/search/search-bank.jsp?iddoc=giroPayment&idsubdoc=bank","Search", "width=600, height=500");
        });
        
        $('#giroPayment_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=giroPayment&idsubdoc=currency","Search", "width=600, height=500");
        });
        
    });//EOF Ready
    
    function giroPaymentTransactionDateOnChange(){
        if($("#giroPaymentUpdateMode").val()!=="true"){
            $("#giroPaymentTransactionDate").val(dtpGiroPaymentTransactionDate.val());
        }
    }
    
    function formatDateGiroPayment(){
        var transactionDate=$("#giroPayment\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpGiroPaymentTransactionDate.val(transactionDateValue);
        $("#giroPaymentTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var dueDate=$("#giroPayment\\.dueDate").val();
        var dueDateTemp= dueDate.split(' ');
        var dueDateValues= dueDateTemp[0].split('/');
        var dueDateValue = dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2]+" "+dueDateTemp[1];
        dtpGiroPaymentDueDate.val(dueDateValue);
        $("#giroPaymentTemp\\.dueDateTemp").val(dueDateValue);
        
        var createdDate=$("#giroPayment\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpGiroPaymentCreatedDate.val(createdDateValue);
        $("#giroPaymentTemp\\.createdDateTemp").val(createdDateValue);
    }
    
    function formatNumericGiroPayment(){
        var amount =parseFloat(txtGiroPaymentAmount.val());
        txtGiroPaymentAmount.val(formatNumber(amount,2));
    }
    
    function UnFormatNumericGiroPayment(){
        var amount = removeCommas(txtGiroPaymentAmount.val());
        txtGiroPaymentAmount.val(amount);
    }
    
    function handlers_input_giro_payment(){
                        
        if(txtGiroPaymentBranchCode.val()===""){
            handlersInput(txtGiroPaymentBranchCode);
        }else{
            unHandlersInput(txtGiroPaymentBranchCode);
        }
        
//        if(txtGiroPaymentCompanyCode.val()===""){
//            handlersInput(txtGiroPaymentCompanyCode);
//        }else{
//            unHandlersInput(txtGiroPaymentCompanyCode);
//        }
        
        if(dtpGiroPaymentTransactionDate.val()===""){
            handlersInput(dtpGiroPaymentTransactionDate);
        }else{
            unHandlersInput(dtpGiroPaymentTransactionDate);
        }
        
        if(dtpGiroPaymentDueDate.val()===""){
            handlersInput(dtpGiroPaymentDueDate);
        }else{
            unHandlersInput(dtpGiroPaymentDueDate);
        }
        
        if(txtGiroPaymentGiroNo.val()===""){
            handlersInput(txtGiroPaymentGiroNo);
        }else{
            unHandlersInput(txtGiroPaymentGiroNo);
        }
        
        if(txtGiroPaymentBankCode.val()===""){
            handlersInput(txtGiroPaymentBankCode);
        }else{
            unHandlersInput(txtGiroPaymentBankCode);
        }
        
        if(txtGiroPaymentPaymentTo.val()===""){
            handlersInput(txtGiroPaymentPaymentTo);
        }else{
            unHandlersInput(txtGiroPaymentPaymentTo);
        }
        
        if(txtGiroPaymentCurrencyCode.val()===""){
            handlersInput(txtGiroPaymentCurrencyCode);
        }else{
            unHandlersInput(txtGiroPaymentCurrencyCode);
        }
    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
</script>
<b>GIRO PAYMENT</b>
<hr>
<br class="spacer" />

<div id="giroPaymentInput" class="content ui-widget">
    <s:form id="frmGiroPaymentInput">
        <table cellpadding="2" cellspacing="2" id="headerInput">
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">

                        txtGiroPaymentBranchCode.change(function(ev) {

                            if(txtGiroPaymentBranchCode.val()===""){
                                txtGiroPaymentBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtGiroPaymentBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtGiroPaymentBranchCode.val(data.branchTemp.code);
                                    txtGiroPaymentBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtGiroPaymentBranchCode);
                                    txtGiroPaymentBranchCode.val("");
                                    txtGiroPaymentBranchName.val("");
                                }
                            });
                        });

                        if($("#giroPaymentUpdateMode").val()==="true"){
                            txtGiroPaymentBranchCode.attr("readonly",true);
                            $("#giroPayment_btnBranch").hide();
                            $("#ui-icon-search-branch-cash-payment").hide();
                        }else{
                            txtGiroPaymentBranchCode.attr("readonly",false);
                            $("#giroPayment_btnBranch").show();
                            $("#ui-icon-search-branch-cash-payment").show();
                        }
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="giroPayment.branch.code" name="giroPayment.branch.code" required="true" cssClass="required" title=" " size="22"></s:textfield>
                        <sj:a id="giroPayment_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-cash-payment"/></sj:a>
                    </div>
                    <s:textfield id="giroPayment.branch.name" name="giroPayment.branch.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
           
            <tr>
                <td align="right"><B>Code *</B></td>
                <td colspan="3">
                    <s:textfield id="giroPayment.code" name="giroPayment.code" key="giroPayment.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="giroPaymentUpdateMode" name="giroPaymentUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
                <td>
                    <s:textfield id="giroPayment.giroStatus" name="giroPayment.giroStatus" size="20" cssStyle="display:none" value="Pending"></s:textfield>
                </td>
            </tr> 
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="giroPayment.transactionDate" name="giroPayment.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" onchange="giroPaymentTransactionDateOnChange()"></sj:datepicker>
                    <sj:datepicker id="giroPaymentTransactionDate" name="giroPaymentTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="giroPaymentTemp.transactionDateTemp" name="giroPaymentTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="giroPaymentTransactionDateFirstSession" name="giroPaymentTransactionDateFirstSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                    <sj:datepicker id="giroPaymentTransactionDateLastSession" name="giroPaymentTransactionDateLastSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Due Date *</B></td>
                <td>
                    <sj:datepicker id="giroPayment.dueDate" name="giroPayment.dueDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="giroPaymentTemp.dueDateTemp" name="giroPaymentTemp.dueDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Giro No *</B></td>
                <td>
                <s:textfield id="giroPayment.giroNo" name="giroPayment.giroNo" size="22" title=" " required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Bank *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        txtGiroPaymentBankCode.change(function(ev) {
                            
                            if(txtGiroPaymentBankCode.val()===""){
                                txtGiroPaymentBankName.val("");
                                return;
                            }
                            var url = "master/bank-get";
                            var params = "bank.code=" + txtGiroPaymentBankCode.val();
                                params+= "&bank.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.bankTemp){
                                    txtGiroPaymentBankCode.val(data.bankTemp.code);
                                    txtGiroPaymentBankName.val(data.bankTemp.name);
                                }
                                else{
                                    alertMessage("Bank Not Found!",txtGiroPaymentBankCode);
                                    txtGiroPaymentBankCode.val("");
                                    txtGiroPaymentBankName.val("");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                    <s:textfield id="giroPayment.bank.code" name="giroPayment.bank.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                        <sj:a id="giroPayment_btnBank" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="giroPayment.bank.name" name="giroPayment.bank.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Payment To *</B></td>
                <td><s:textfield id="giroPayment.paymentTo" name="giroPayment.paymentTo" size="22" title=" " required="true" cssClass="required"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Currency *</B></td>
                <td colspan="3">
                    <script type = "text/javascript">

                        txtGiroPaymentCurrencyCode.change(function(ev) {

                            if(txtGiroPaymentCurrencyCode.val()===""){
                                txtGiroPaymentCurrencyName.val("");
                                return;
                            }

                            var url = "master/currency-get";
                            var params = "currency.code=" + txtGiroPaymentCurrencyCode.val();
                                params+= "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtGiroPaymentCurrencyCode.val(data.currencyTemp.code);
                                    txtGiroPaymentCurrencyName.val(data.currencyTemp.name);
                                }
                                else{
                                    alertMessage("Currency Not Found",txtGiroPaymentCurrencyCode);
                                    txtGiroPaymentCurrencyCode.val("");
                                    txtGiroPaymentCurrencyName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="giroPayment.currency.code" name="giroPayment.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="giroPayment_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="giroPayment.currency.name" name="giroPayment.currency.name" size="40" readonly="true"></s:textfield>
                    <s:textfield id="giroPaymentCurrencyCodeSession" name="giroPaymentCurrencyCodeSession" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Amount *</B></td>
                <td>
                    <s:textfield id="giroPayment.amount" name="giroPayment.amount" size="20" style="text-align: right"></s:textfield>&nbsp;<span id="errmsgAmount"></span>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="giroPayment.refNo" name="giroPayment.refNo" size="22"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3"><s:textarea id="giroPayment.remark" name="giroPayment.remark"  cols="65" rows="2" height="20"></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="giroPayment.createdBy" name="giroPayment.createdBy" key="giroPayment.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="giroPayment.createdDate" name="giroPayment.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="giroPaymentTemp.createdDateTemp" name="giroPaymentTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table>
    </s:form>        
    <table>
        <tr>
            <td  width="47%"/>
            <td>
                <sj:a href="#" id="btnGiroPaymentSave" button="true" style="width: 60px">Save</sj:a>
                <sj:a href="#" id="btnGiroPaymentCancel" button="true" style="width: 60px">Cancel</sj:a>
            </td>
        </tr>            
    </table>
</div>