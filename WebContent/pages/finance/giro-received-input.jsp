
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
        txtGiroReceivedGiroNo = $("#giroReceived\\.giroNo"),
        txtGiroReceivedBranchCode = $("#giroReceived\\.branch\\.code"),
        txtGiroReceivedBranchName = $("#giroReceived\\.branch\\.name"),
//        txtGiroReceivedCompanyCode = $("#giroReceived\\.company\\.code"),
//        txtGiroReceivedCompanyName = $("#giroReceived\\.company\\.name"),        
        dtpGiroReceivedTransactionDate = $("#giroReceived\\.transactionDate"),
        dtpGiroReceivedDueDate = $("#giroReceived\\.dueDate"),
        txtGiroReceivedBankCode=$("#giroReceived\\.bank\\.code"),
        txtGiroReceivedBankName=$("#giroReceived\\.bank\\.name"),
        txtGiroReceivedReceivedFrom = $("#giroReceived\\.receivedFrom"),
        txtGiroReceivedGiroStatus = $("#giroReceived\\.giroStatus"),
        txtGiroReceivedCurrencyCode = $("#giroReceived\\.currency\\.code"),
        txtGiroReceivedCurrencyName = $("#giroReceived\\.currency\\.name"),
        txtGiroReceivedAmount = $("#giroReceived\\.amount"),
        txtGiroReceivedRefNo = $("#giroReceived\\.refNo"),
        txtGiroReceivedRemark = $("#giroReceived\\.remark"),
        txtGiroReceivedCreatedBy = $("#giroReceived\\.createdBy"),
        dtpGiroReceivedCreatedDate = $("#giroReceived\\.createdDate");
       
    
            
    $(document).ready(function() {
        
        formatNumericGiroReceived();
        
        $("#giroReceived\\.amount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#giroReceived\\.amount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommas(value); 
            });
        });
        
        $("#giroReceived\\.amount").change(function(e){
            var amount=$("#giroReceived\\.amount").val();
            if(amount===""){
               $("#giroReceived\\.amount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
           
        });
                 
        $('#btnGiroReceivedSave').click(function(ev) {
            handlers_input_giro_received();
            if(!$("#frmGiroReceivedInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            var giroReceivedAmount = parseFloat(removeCommas($('#giroReceived\\.amount').val()));
           
            if (giroReceivedAmount === 0) {
                alertMessage("Amount Can't Be 0");
                return;
            }
            
            var date1 = dtpGiroReceivedTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#giroReceivedTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");


            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#giroReceivedUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#giroReceivedTransactionDate").val(),dtpGiroReceivedTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpGiroReceivedTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#giroReceivedUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#giroReceivedTransactionDate").val(),dtpGiroReceivedTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpGiroReceivedTransactionDate);
                }
                return;
            }
            
//            var date = $("#giroReceived\\.transactionDate").val().split("/");
//            var month = date[1];
//            var year = date[2].split(" ");
//            if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
//                alertMessage("Transaction Month Must Between Session Period Month!",dtpGiroReceivedTransactionDate);
//                return;
//            }
//
//            if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
//                alertMessage("Transaction Year Must Between Session Period Year!",dtpGiroReceivedTransactionDate);
//                return;
//            }
                
            formatDateGiroReceived();
            UnFormatNumericGiroReceived();
            
            var url = "finance/giro-received-save";
            var params = $("#frmGiroReceivedInput").serialize();
                
            showLoading();
                
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error){
                    formatDateGiroReceived();
                    formatNumericGiroReceived();
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
                                var url = "finance/giro-received-input";
                                var params = "";
                                pageLoad(url, params, "#tabmnuGIRO_RECEIVED");
                            }
                        },
                        {
                            text : "No",
                            click : function() {

                                $(this).dialog("close");
                                var url = "finance/giro-received";
                                var params = "";
                                pageLoad(url, params, "#tabmnuGIRO_RECEIVED");

                            }
                        }]
                });

            });
        });
        
        $('#btnGiroReceivedCancel').click(function(ev) {
            var url = "finance/giro-received";
            var params = "";
            pageLoad(url, params, "#tabmnuGIRO_RECEIVED"); 
        });
        
        $('#giroReceived_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=giroReceived&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

//        $('#giroReceived_btnCompany').click(function(ev) {
//            window.open("./pages/search/search-company.jsp?iddoc=giroReceived&idsubdoc=company","Search", "Scrollbars=1,width=600, height=500");
//        });
            
        $('#giroReceived_btnBank').click(function(ev) {
            window.open("./pages/search/search-bank.jsp?iddoc=giroReceived&idsubdoc=bank","Search", "width=600, height=500");
        });
        
        $('#giroReceived_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=giroReceived&idsubdoc=currency","Search", "width=600, height=500");
        });
        
    });//EOF Ready
    
    function giroReceivedTransactionDateOnChange(){
        if($("#giroReceivedUpdateMode").val()!=="true"){
            $("#giroReceivedTransactionDate").val(dtpGiroReceivedTransactionDate.val());
        }
    }
    
    function formatDateGiroReceived(){
        var transactionDate=$("#giroReceived\\.transactionDate").val();
        var transactionDateTemp= transactionDate.split(' ');
        var dateValues= transactionDateTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+transactionDateTemp[1];
        dtpGiroReceivedTransactionDate.val(transactionDateValue);
        $("#giroReceivedTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var dueDate=$("#giroReceived\\.dueDate").val();
        var dueDateTemp= dueDate.split(' ');
        var dueDateValues= dueDateTemp[0].split('/');
        var dueDateValue = dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2]+" "+dueDateTemp[1];
        dtpGiroReceivedDueDate.val(dueDateValue);
        $("#giroReceivedTemp\\.dueDateTemp").val(dueDateValue);
        
        var createdDate=$("#giroReceived\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpGiroReceivedCreatedDate.val(createdDateValue);
        $("#giroReceivedTemp\\.createdDateTemp").val(createdDateValue);
    }
    
    function formatNumericGiroReceived(){
        var amount =parseFloat(txtGiroReceivedAmount.val());
        txtGiroReceivedAmount.val(formatNumber(amount,2));
    }
    
    function UnFormatNumericGiroReceived(){
        var amount = removeCommas(txtGiroReceivedAmount.val());
        txtGiroReceivedAmount.val(amount);
    }
    
    function handlers_input_giro_received(){
                        
        if(txtGiroReceivedBranchCode.val()===""){
            handlersInput(txtGiroReceivedBranchCode);
        }else{
            unHandlersInput(txtGiroReceivedBranchCode);
        }
        
//        if(txtGiroReceivedCompanyCode.val()===""){
//            handlersInput(txtGiroReceivedCompanyCode);
//        }else{
//            unHandlersInput(txtGiroReceivedCompanyCode);
//        }
        
        if(dtpGiroReceivedTransactionDate.val()===""){
            handlersInput(dtpGiroReceivedTransactionDate);
        }else{
            unHandlersInput(dtpGiroReceivedTransactionDate);
        }
        
        if(dtpGiroReceivedDueDate.val()===""){
            handlersInput(dtpGiroReceivedDueDate);
        }else{
            unHandlersInput(dtpGiroReceivedDueDate);
        }
        
        if(txtGiroReceivedGiroNo.val()===""){
            handlersInput(txtGiroReceivedGiroNo);
        }else{
            unHandlersInput(txtGiroReceivedGiroNo);
        }
        
        if(txtGiroReceivedBankCode.val()===""){
            handlersInput(txtGiroReceivedBankCode);
        }else{
            unHandlersInput(txtGiroReceivedBankCode);
        }
        
        if(txtGiroReceivedReceivedFrom.val()===""){
            handlersInput(txtGiroReceivedReceivedFrom);
        }else{
            unHandlersInput(txtGiroReceivedReceivedFrom);
        }
        
        if(txtGiroReceivedCurrencyCode.val()===""){
            handlersInput(txtGiroReceivedCurrencyCode);
        }else{
            unHandlersInput(txtGiroReceivedCurrencyCode);
        }
    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
</script>
<b>GIRO RECEIVED</b>
<hr>
<br class="spacer" />

<div id="giroReceivedInput" class="content ui-widget">
    <s:form id="frmGiroReceivedInput">
        <table cellpadding="2" cellspacing="2" id="headerInput">
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">

                        txtGiroReceivedBranchCode.change(function(ev) {

                            if(txtGiroReceivedBranchCode.val()===""){
                                txtGiroReceivedBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtGiroReceivedBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtGiroReceivedBranchCode.val(data.branchTemp.code);
                                    txtGiroReceivedBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtGiroReceivedBranchCode);
                                    txtGiroReceivedBranchCode.val("");
                                    txtGiroReceivedBranchName.val("");
                                }
                            });
                        });

                        if($("#giroReceivedUpdateMode").val()==="true"){
                            txtGiroReceivedBranchCode.attr("readonly",true);
                            $("#giroReceived_btnBranch").hide();
                            $("#ui-icon-search-branch-cash-payment").hide();
                        }else{
                            txtGiroReceivedBranchCode.attr("readonly",false);
                            $("#giroReceived_btnBranch").show();
                            $("#ui-icon-search-branch-cash-payment").show();
                        }
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="giroReceived.branch.code" name="giroReceived.branch.code" required="true" cssClass="required" title=" " size="22"></s:textfield>
                        <sj:a id="giroReceived_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-cash-payment"/></sj:a>
                    </div>
                    <s:textfield id="giroReceived.branch.name" name="giroReceived.branch.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
 
            <tr>
                <td align="right"><B>Code *</B></td>
                <td colspan="3">
                    <s:textfield id="giroReceived.code" name="giroReceived.code" key="giroReceived.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="giroReceivedUpdateMode" name="giroReceivedUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
                <td>
                    <s:textfield id="giroReceived.giroStatus" name="giroReceived.giroStatus" size="20" cssStyle="display:none" value="Pending"></s:textfield>
                </td>
            </tr> 
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="giroReceived.transactionDate" name="giroReceived.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" onchange="giroReceivedTransactionDateOnChange()"></sj:datepicker>
                    <sj:datepicker id="giroReceivedTransactionDate" name="giroReceivedTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="giroReceivedTemp.transactionDateTemp" name="giroReceivedTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="giroReceivedTransactionDateFirstSession" name="giroReceivedTransactionDateFirstSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                    <sj:datepicker id="giroReceivedTransactionDateLastSession" name="giroReceivedTransactionDateLastSession" size="20" showOn="focus" disabled="true" hidden="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Due Date *</B></td>
                <td>
                    <sj:datepicker id="giroReceived.dueDate" name="giroReceived.dueDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="giroReceivedTemp.dueDateTemp" name="giroReceivedTemp.dueDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Giro No *</B></td>
                <td>
                <s:textfield id="giroReceived.giroNo" name="giroReceived.giroNo" size="22" title=" " required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Bank *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        txtGiroReceivedBankCode.change(function(ev) {
                            
                            if(txtGiroReceivedBankCode.val()===""){
                                txtGiroReceivedBankName.val("");
                                return;
                            }
                            var url = "master/bank-get";
                            var params = "bank.code=" + txtGiroReceivedBankCode.val();
                                params+= "&bank.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.bankTemp){
                                    txtGiroReceivedBankCode.val(data.bankTemp.code);
                                    txtGiroReceivedBankName.val(data.bankTemp.name);
                                }
                                else{
                                    alertMessage("Bank Not Found!",txtGiroReceivedBankCode);
                                    txtGiroReceivedBankCode.val("");
                                    txtGiroReceivedBankName.val("");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                    <s:textfield id="giroReceived.bank.code" name="giroReceived.bank.code" size="22" title=" " required="true" cssClass="required"></s:textfield>
                        <sj:a id="giroReceived_btnBank" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="giroReceived.bank.name" name="giroReceived.bank.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Received From *</B></td>
                <td><s:textfield id="giroReceived.receivedFrom" name="giroReceived.receivedFrom" size="22" title=" " required="true" cssClass="required"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Currency *</B></td>
                <td colspan="3">
                    <script type = "text/javascript">

                        txtGiroReceivedCurrencyCode.change(function(ev) {

                            if(txtGiroReceivedCurrencyCode.val()===""){
                                txtGiroReceivedCurrencyName.val("");
                                return;
                            }

                            var url = "master/currency-get";
                            var params = "currency.code=" + txtGiroReceivedCurrencyCode.val();
                                params+= "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtGiroReceivedCurrencyCode.val(data.currencyTemp.code);
                                    txtGiroReceivedCurrencyName.val(data.currencyTemp.name);
                                }
                                else{
                                    alertMessage("Currency Not Found",txtGiroReceivedCurrencyCode);
                                    txtGiroReceivedCurrencyCode.val("");
                                    txtGiroReceivedCurrencyName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="giroReceived.currency.code" name="giroReceived.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="giroReceived_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="giroReceived.currency.name" name="giroReceived.currency.name" size="40" readonly="true"></s:textfield>
                    <s:textfield id="giroReceivedCurrencyCodeSession" name="giroReceivedCurrencyCodeSession" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Amount *</B></td>
                <td>
                    <s:textfield id="giroReceived.amount" name="giroReceived.amount" size="20" style="text-align: right"></s:textfield>&nbsp;<span id="errmsgAmount"></span>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="giroReceived.refNo" name="giroReceived.refNo" size="22"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3"><s:textarea id="giroReceived.remark" name="giroReceived.remark"  cols="65" rows="2" height="20"></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="giroReceived.createdBy" name="giroReceived.createdBy" key="giroReceived.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="giroReceived.createdDate" name="giroReceived.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="giroReceivedTemp.createdDateTemp" name="giroReceivedTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table>
    </s:form>        
    <table>
        <tr>
            <td  width="47%"/>
            <td>
                <sj:a href="#" id="btnGiroReceivedSave" button="true" style="width: 60px">Save</sj:a>
                <sj:a href="#" id="btnGiroReceivedCancel" button="true" style="width: 60px">Cancel</sj:a>
            </td>
        </tr>            
    </table>
</div>