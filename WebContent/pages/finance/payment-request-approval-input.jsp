
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.mousewheel-3.0.4.pack.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.fancybox-1.3.4.pack.js" />"></script>
<link href="css/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css" />
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #paymentRequestApprovalDetailDocumentInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var paymentRequestApprovalDetaillastRowId=0,paymentRequestApprovalDetail_lastSel = -1;
    var 
        txtPaymentRequestApprovalCode = $("#paymentRequestApproval\\.code"),
        txtPaymentRequestApprovalBranchCode = $("#paymentRequestApproval\\.branch\\.code"),
        txtPaymentRequestApprovalBranchName = $("#paymentRequestApproval\\.branch\\.name"),
        txtPaymentRequestApprovalDivisionCode = $("#paymentRequestApproval\\.division\\.code"),
        txtPaymentRequestApprovalDivisionName = $("#paymentRequestApproval\\.division\\.name"),
        txtPaymentRequestApprovalDepartmentCode = $("#paymentRequestApproval\\.division\\.department\\.code"),
        txtPaymentRequestApprovalDepartmentName = $("#paymentRequestApproval\\.division\\.department\\.Name"),
        dtpPaymentRequestApprovalTransactionDate = $("#paymentRequestApproval\\.transactionDate"),
        txtPaymentRequestApprovalPaymentTo = $("#paymentRequestApproval\\.paymentTo"),
        txtPaymentRequestApprovalCurrencyCode = $("#paymentRequestApproval\\.currency\\.code"),
        txtPaymentRequestApprovalCurrencyName = $("#paymentRequestApproval\\.currency\\.name"),
        txtPaymentRequestApprovalTotalTransactionAmountForeign = $("#paymentRequestApproval\\.totalTransactionAmount"),
        txtPaymentRequestApprovalApprovalReasonCode = $("#paymentRequestApproval\\.approvalReason\\.code"),
        txtPaymentRequestApprovalApprovalReasonName = $("#paymentRequestApproval\\.approvalReason\\.name"),
        txtPaymentRequestApprovalRefNo = $("#paymentRequestApproval\\.refNo"),
        txtPaymentRequestApprovalRemark = $("#paymentRequestApproval\\.remark"),
        dtpPaymentRequestApprovalUpdatedDate = $("#paymentRequestApproval\\.updatedDate"),
        dtpPaymentRequestApprovalCreatedDate = $("#paymentRequestApproval\\.createdDate"),
                
        txtPaymentRequestApprovalTotalDebitForeign = $("#paymentRequestApprovalTotalDebitForeign"),
        txtPaymentRequestApprovalTotalCreditForeign = $("#paymentRequestApprovalTotalCreditForeign"),
        txtPaymentRequestApprovalTotalBalanceForeign = $("#paymentRequestApprovalTotalBalanceForeign"),

        allFieldsPurchaseRequest=$([])
            .add(txtPaymentRequestApprovalApprovalReasonCode)
            .add(txtPaymentRequestApprovalApprovalReasonName);
               
    $(document).ready(function() {
        hoverButton();
        
        $("#frmPaymentRequestApprovalInput").validate({
           errorClass: "my-error-class",
           validClass: "my-valid-class"
        });
        formatNumericPaymentRequestApproval();
        paymentRequestApprovalSetStatus();
        paymentRequestApprovalSetTransactionType();
        $("#frmPaymentRequestApprovalInput_paymentRequestApproval_paymentType").attr('readonly',true);
        
        $('input[name="paymentRequestApprovalStatusRad"][value="PENDING"]').change(function(ev){
            var value="PENDING";
            $("#paymentRequestApproval\\.approvalStatus").val(value);
        });
        
        $('input[name="paymentRequestApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#paymentRequestApproval\\.approvalStatus").val(value);
        });
        
        $('input[name="paymentRequestApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            var value="REJECTED";
            $("#paymentRequestApproval\\.approvalStatus").val(value);
        });
        
        $('#btnPaymentRequestApprovalSave').click(function(ev) {
                        
//            if(!$("#frmPaymentRequestApprovalInput").valid()) {
//                ev.preventDefault();
//                return;
//            }
            if (txtPaymentRequestApprovalApprovalReasonCode.val()==="" && $("#paymentRequestApproval\\.approvalStatus").val() === "PENDING" || $("#paymentRequestApproval\\.approvalStatus").val() === "REJECTED"){
                alertMessage("Reason Can't be Null");return;

            }
            if ($("#paymentRequestApproval\\.transactionType").val()===""){
                alertMessage("Type Can't be Null");return;

            }
            
            if ($("#paymentRequestApproval\\.paymentType").val() === "BANK" && $("#paymentRequestApproval\\.approvalStatus").val() === "PENDING"){
                alertMessage("Request Type Bank can't be Pending"); return;
            }
          
         
//            $("#btnPaymentRequestApprovalCalculate").trigger("click");
//                if(paymentRequestApprovalDetail_lastSel !== -1) {
//                    $('#paymentRequestApprovalDetailDocumentInput_grid').jqGrid("saveRow",paymentRequestApprovalDetail_lastSel); 
//                }

                var ids = jQuery("#paymentRequestApprovalDetailDocumentInput_grid").jqGrid('getDataIDs'); 
                var totalBalanceForeign = parseFloat(removeCommas(txtPaymentRequestApprovalTotalBalanceForeign.val()));
                var headerCurrency = txtPaymentRequestApprovalCurrencyCode.val();
                
                // cek isi detail
                if(ids.length===0){
                    alertMessage("Grid Payment Request Detail Is Not Empty");
                    return;
                }
                
                // cek balance apabila foreign or IDR
                if (headerCurrency !== "IDR") {
                    if (totalBalanceForeign !== 0) {
                        alertMessage("Balance Foreign Must be 0");
                        return;
                    }
                }
                                                
                for(var i=0;i < ids.length;i++){ 
                    var data = $("#paymentRequestApprovalDetailDocumentInput_grid").jqGrid('getRowData',ids[i]); 
                    var documentNo = data.paymentRequestApprovalDetailDocumentDocumentNo;
                    var transactionStatus = data.paymentRequestApprovalDetailDocumentTransactionStatus;
                    var documentAccountName = data.paymentRequestApprovalDetailDocumentBudgetTypeName;
                    var debitValue=parseFloat(data.paymentRequestApprovalDetailDocumentDebitForeign);
                    var creditValue=parseFloat(data.paymentRequestApprovalDetailDocumentCreditForeign);
                    
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
                                    alertMessage("The Following Required Field have been empty: BudgetType");
                                    return;
                                }
                                break;
                            case "Other":
                                if(documentAccountName===" "){
                                    alertMessage("The Following Required Field have been empty: BudgetType");
                                    return;
                                }
                            break;
                        }
                    }
                    
                }
                
                formatDatePaymentRequestApproval();
                unFormatNumericPaymentRequestApproval();
                               
                var url = "finance/payment-request-approval-save";
                var params = $("#frmPaymentRequestApprovalInput").serialize();
                
                showLoading();
                
                $.post(url, params, function(data) {
                   closeLoading();
                    if (data.error) {
                        formatDatePaymentRequestApproval();
                        formatNumericPaymentRequestApproval();
                        alertMessage(data.errorMessage);
                        return;
                    }

                    var dynamicDialog= $('<div id="conformBox">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>'+data.message+'</div>');

                    dynamicDialog.dialog({
                        title           : "Confirmation:",
                        closeOnEscape   : false,
                        modal           : true,
                        width           : 500,
                        resizable       : false,
                        buttons         : 
                                        [{
                                            text : "OK",
                                            click : function() {

                                                $(this).dialog("close");
                                                var url = "finance/payment-request-approval";
                                                var param = "";
                                                pageLoad(url, param, "#tabmnuPAYMENT_REQUEST_APPROVAL");
                                            }
                                        }]
                    });
                });
        });
                
        $('#btnPaymentRequestApprovalCancel').click(function(ev) {
            var url = "finance/payment-request-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPAYMENT_REQUEST_APPROVAL"); 
        });
        
        $('#paymentRequestApproval_btnApprovalReason').click(function(ev) {
            window.open("./pages/search/search-reason.jsp?iddoc=paymentRequestApproval&idsubdoc=approvalReason&modulecode=paymentRequestApproval","Search", "Scrollbars=1,width=600, height=500");
        });
        
    });//EOF Ready
    
    function formatDatePaymentRequestApproval(){
        var transactionDate0=$("#paymentRequestApproval\\.transactionDate").val().split(' ');
        var transactionDate1= transactionDate0[0].split('/');
        var transactionDate = transactionDate1[1]+"/"+transactionDate1[0]+"/"+transactionDate1[2]+" "+transactionDate0[1];
        dtpPaymentRequestApprovalTransactionDate.val(transactionDate);
        $("#paymentRequestApprovalTemp\\.transactionDateTemp").val(transactionDate);
        
        
        var updatedDate0=$("#paymentRequestApproval\\.updatedDate").val().split(' ');
        var updatedDate1= updatedDate0[0].split('/');
        var updatedDate = updatedDate1[1]+"/"+updatedDate1[0]+"/"+updatedDate1[2]+" "+updatedDate0[1];
        dtpPaymentRequestApprovalUpdatedDate.val(updatedDate);
        $("#paymentRequestApprovalTemp\\.updatedDateTemp").val(updatedDate);
       
        var createdDate0=$("#paymentRequestApproval\\.createdDate").val().split(' ');        
        var createdDate1= createdDate0[0].split('/');
        var createdDate = createdDate1[1]+"/"+createdDate1[0]+"/"+createdDate1[2]+" "+createdDate0[1];
        dtpPaymentRequestApprovalCreatedDate.val(createdDate);
        $("#paymentRequestApprovalTemp\\.createdDateTemp").val(createdDate);
//        
//        var releasedDate0=$("#paymentRequestApproval\\.releasedDate").val().split(' ');        
//        var releasedDate1= releasedDate0[0].split('/');
//        var releasedDate = releasedDate1[1]+"/"+releasedDate1[0]+"/"+releasedDate1[2]+" "+releasedDate0[1];
//        $("#paymentRequestApproval\\.releasedDate").val(releasedDate);
//        $("#paymentRequestApprovalTemp\\.releasedDateTemp").val(releasedDate);
        
    }

    function formatNumericPaymentRequestApproval(){
        var totalTransactionAmountFormat =parseFloat(txtPaymentRequestApprovalTotalTransactionAmountForeign.val()) ;
        txtPaymentRequestApprovalTotalTransactionAmountForeign.val(formatNumber(totalTransactionAmountFormat,2));
        
        var totalDebitForeign =parseFloat(txtPaymentRequestApprovalTotalDebitForeign.val()) ;
        txtPaymentRequestApprovalTotalDebitForeign.val(formatNumber(totalDebitForeign,2));
        
        var totalCreditForeign =parseFloat(txtPaymentRequestApprovalTotalCreditForeign.val()) ;
        txtPaymentRequestApprovalTotalCreditForeign.val(formatNumber(totalCreditForeign,2));
        
        var totalBalanceForeign =parseFloat(txtPaymentRequestApprovalTotalBalanceForeign.val()) ;
        txtPaymentRequestApprovalTotalBalanceForeign.val(formatNumber(totalBalanceForeign,2));
    }

    function unFormatNumericPaymentRequestApproval(){
        var totalTransactionAmountFormat = txtPaymentRequestApprovalTotalTransactionAmountForeign.val().replace(/,/g, "");
        txtPaymentRequestApprovalTotalTransactionAmountForeign.val(totalTransactionAmountFormat);
        
        var totalDebitForeign = txtPaymentRequestApprovalTotalDebitForeign.val().replace(/,/g, "");
        txtPaymentRequestApprovalTotalDebitForeign.val(totalDebitForeign);
        
        var totalCreditForeign = txtPaymentRequestApprovalTotalCreditForeign.val().replace(/,/g, "");
        txtPaymentRequestApprovalTotalCreditForeign.val(totalCreditForeign);
        
        var totalBalanceForeign = txtPaymentRequestApprovalTotalBalanceForeign.val().replace(/,/g, "");
        txtPaymentRequestApprovalTotalBalanceForeign.val(totalBalanceForeign);
    }
        
    function paymentRequestApprovalLoadDataDetail() {
        
        var url = "finance/payment-request-detail-data";
        var params = "paymentRequest.code=" + txtPaymentRequestApprovalCode.val();
            
        $.getJSON(url, params, function(data) {
            paymentRequestApprovalDetaillastRowId = 0;
                    
            for (var i=0; i<data.listPaymentRequestDetailTemp.length; i++) {
                
                var transactionType=data.listPaymentRequestDetailTemp[i].transactionStatus;
                var currencyCodeDocument="";
                                    
                switch(transactionType){
                    case "Transaction":
                        currencyCodeDocument=data.listPaymentRequestDetailTemp[i].currencyCode;
                        break;
                    case "Other":
                        currencyCodeDocument=txtPaymentRequestApprovalCurrencyCode.val();
                        break;
                }
                
                $("#paymentRequestApprovalDetailDocumentInput_grid").jqGrid("addRowData", paymentRequestApprovalDetaillastRowId, data.listPaymentRequestDetailTemp[i]);
                $("#paymentRequestApprovalDetailDocumentInput_grid").jqGrid('setRowData',paymentRequestApprovalDetaillastRowId,{
                    paymentRequestApprovalDetailDocumentDocumentNo         : data.listPaymentRequestDetailTemp[i].documentNo,
                    paymentRequestApprovalDetailDocumentBranchCode         : data.listPaymentRequestDetailTemp[i].documentBranchCode,
                    paymentRequestApprovalDetailDocumentDocumentType       : data.listPaymentRequestDetailTemp[i].documentType,
                    paymentRequestApprovalDetailDocumentCurrencyCode       : currencyCodeDocument,
                    paymentRequestApprovalDetailDocumentExchangeRate       : data.listPaymentRequestDetailTemp[i].exchangeRate,
                    paymentRequestApprovalDetailDocumentAmountForeign      : data.listPaymentRequestDetailTemp[i].documentAmount,
                    paymentRequestApprovalDetailDocumentBalanceForeign     : data.listPaymentRequestDetailTemp[i].documentBalanceAmount,
                    paymentRequestApprovalDetailDocumentTransactionStatus  : data.listPaymentRequestDetailTemp[i].transactionStatus,
                    paymentRequestApprovalDetailDocumentDebitForeign       : data.listPaymentRequestDetailTemp[i].debit,
                    paymentRequestApprovalDetailDocumentCreditForeign      : data.listPaymentRequestDetailTemp[i].credit,
                    paymentRequestApprovalDetailDocumentBudgetTypeCode     : data.listPaymentRequestDetailTemp[i].budgetTypeCode,
                    paymentRequestApprovalDetailDocumentBudgetTypeName     : data.listPaymentRequestDetailTemp[i].budgetTypeName,
                    paymentRequestApprovalDetailDocumentRemark             : data.listPaymentRequestDetailTemp[i].remark
                    
                    
                });
            paymentRequestApprovalDetaillastRowId++;
            }
        });
    }
            
    function paymentRequestApprovalSetStatus(){
        switch($("#paymentRequestApproval\\.approvalStatus").val()){
            case "REJECTED":
                $('input[name="paymentRequestApprovalStatusRad"][value="REJECTED"]').prop('checked',true);
                $("#paymentRequestApproval\\.approvalReason\\.code").addClass("required");
                $("#paymentRequestApproval\\.approvalReason\\.code").addClass("cssClass");
                $("#paymentRequestApproval\\.approvalReason\\.code").css("required",false);
                break;
            case "APPROVED":
                $('input[name="paymentRequestApprovalStatusRad"][value="APPROVED"]').prop('checked',true);
                $("#paymentRequestApproval\\.approvalReason\\.code").removeClass("required");
                $("#paymentRequestApproval\\.approvalReason\\.code").removeClass("cssClass");
                $("#paymentRequestApproval\\.approvalReason\\.code").css("required",false);
                break;
            case "PENDING":
                $('input[name="paymentRequestApprovalStatusRad"][value="PENDING"]').prop('checked',true);
                $("#paymentRequestApproval\\.approvalReason\\.code").addClass("required");
                $("#paymentRequestApproval\\.approvalReason\\.code").addClass("cssClass");
                $("#paymentRequestApproval\\.approvalReason\\.code").css("required",false);
                break;
        } 
    }
    
    function paymentRequestApprovalSetTransactionType(){
        switch($("#paymentRequestApproval\\.transactionType").val()){
            case "REGULAR":
                $('#paymentRequestApprovalTransactionTypeRadREGULAR').prop('checked',true);
                $('#paymentRequestApprovalTransactionTypeRadDEPOSIT').attr('disabled', true);
                break;
            case "DEPOSIT":
                $('#paymentRequestApprovalTransactionTypeRadDEPOSIT').prop('checked',true);
                $('#paymentRequestApprovalTransactionTypeRadREGULAR').attr('disabled', true);
                break;
        } 
    }
</script>

<b>PAYMENT REQUEST APPROVAL</b>
<hr>
<div id="paymentRequestApprovalInput" class="content ui-widget">
<s:form id="frmPaymentRequestApprovalInput">
    <table cellpadding="2" cellspacing="2" id="headerInputPaymentRequestApproval" width="100%">
        <tr>
            <td valign="top">
                <table width="100%">
                    <tr>
                        <td align="right" style="width:150px">Payment Request No</td>
                        <td>
                            <s:textfield id="paymentRequestApproval.code" name="paymentRequestApproval.code" key="paymentRequestApproval.code" size="22" readonly="true"></s:textfield>
                        </td>
                        <script>
                            txtPaymentRequestApprovalCode.after(function(ev) {
                                paymentRequestApprovalLoadDataDetail();
                            });
                        </script>
                    </tr> 
                    <tr>
                        <td align="right">Branch</td>
                        <td colspan="2">
                            <s:textfield id="paymentRequestApproval.branch.code" name="paymentRequestApproval.branch.code" size="15" readonly="true"></s:textfield>
                            <s:textfield id="paymentRequestApproval.branch.name" name="paymentRequestApproval.branch.name" size="30" readonly="true"></s:textfield>
                    </tr>
                    <tr>
                        <td align="right">Transaction Date</td>
                        <td>
                            <sj:datepicker id="paymentRequestApproval.transactionDate" name="paymentRequestApproval.transactionDate" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" disabled="true" readonly="true" changeYear="true" changeMonth="true" ></sj:datepicker>
                            <sj:datepicker id="paymentRequestApproval.transactionDate" name="paymentRequestApproval.transactionDate" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" readonly="true" style="Display:none"  changeYear="true" changeMonth="true" ></sj:datepicker>
                            <sj:datepicker id="paymentRequestApproval.transactionDate" name="paymentRequestApproval.transactionDate" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" displayFormat="dd/mm/yy" timepickerFormat="hh:mm:ss" style="Display:none"  changeYear="true" changeMonth="true" ></sj:datepicker>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Item Division</td>
                        <td colspan="2">
                            <s:textfield id="paymentRequestApproval.itemDivision.code" name="paymentRequestApproval.itemDivision.code" size="15" readonly="true"></s:textfield>
                            <s:textfield id="paymentRequestApproval.itemDivision.name" name="paymentRequestApproval.itemDivision.name" size="30" readonly="true"></s:textfield>
                    </tr>
                    <tr>
                        <td align="right">Payment To</td>
                        <td>
                            <s:textfield id="paymentRequestApproval.paymentTo" name="paymentRequestApproval.paymentTo" size="27" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Type</td>
                        <td>
                            <s:textfield id="paymentRequestApproval.transactionType" name="paymentRequestApproval.transactionType" cssStyle="display:none" readonly="true"></s:textfield>
                            <s:radio id="paymentRequestApprovalTransactionTypeRad" name="paymentRequestApprovalTransactionTypeRad" label="type" list="{'REGULAR','DEPOSIT'}"/>
                        </td> 
                    </tr>
                 
                </table>
            </td>
            <td valign="top">
                <table width="100%">
                    <tr>
                        <td align="right">Currency</td>
                        <td colspan="2">
                            <s:textfield id="paymentRequestApproval.currency.code" name="paymentRequestApproval.currency.code" size="22" readonly="true"></s:textfield>
                            <s:textfield id="paymentRequestApproval.currency.name" name="paymentRequestApproval.currency.name" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Amount</td>
                        <td>
                            <s:textfield id="paymentRequestApproval.totalTransactionAmount" name="paymentRequestApproval.totalTransactionAmount" size="22" readonly="true" style="text-align: right"></s:textfield>(Credit)
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Ref No.</td>
                        <td>
                           <s:textfield id="paymentRequestApproval.refNo" name="paymentRequestApproval.refNo" size="27" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td>
                            <s:textarea id="paymentRequestApproval.remark" name="paymentRequestApproval.remark"  cols="72" rows="2" height="20" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Status</td>
                        <td>
                            <s:textfield id="paymentRequestApproval.approvalStatus" name="paymentRequestApproval.approvalStatus" key="paymentRequestApproval.approvalStatus" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                            <s:radio id="paymentRequestApprovalStatusRad" name="paymentRequestApprovalStatusRad" list="{'PENDING','APPROVED','REJECTED'}"></s:radio>
                        </td>  
                    </tr>
                    <tr>
                        <td align="right"><b>Reason*</b></td>
                        <td colspan="2">
                            <script type = "text/javascript">
                                txtPaymentRequestApprovalApprovalReasonCode.change(function(ev) {

                                    if(txtPaymentRequestApprovalApprovalReasonCode.val()===""){
                                        txtPaymentRequestApprovalApprovalReasonName.val("");
                                        return;
                                    }

                                    var url = "master/reason-get";
                                    var params = "reason.code=" + txtPaymentRequestApprovalApprovalReasonCode.val();
                                        params+= "&reason.activeStatus=TRUE";
                                        params+="&moduleParams=005_FIN_PAYMENT_REQUEST_APPROVAL"

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.reasonTemp){
                                            txtPaymentRequestApprovalApprovalReasonCode.val(data.reasonTemp.code);
                                            txtPaymentRequestApprovalApprovalReasonName.val(data.reasonTemp.name);
                                        }
                                        else{
                                            alertMessage("Reason Not Found!",txtPaymentRequestApprovalApprovalReasonCode);
                                            txtPaymentRequestApprovalApprovalReasonCode.val("");
                                            txtPaymentRequestApprovalApprovalReasonName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="paymentRequestApproval.approvalReason.code" name="paymentRequestApproval.approvalReason.code" title="*" required="true" cssClass="required" size="22"></s:textfield>
                                <sj:a id="paymentRequestApproval_btnApprovalReason" cssClass="paymentRequestApproval_btnApprovalReason" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-currency-payment-request"/></sj:a>
                            </div>
                                <s:textfield id="paymentRequestApproval.approvalReason.name" name="paymentRequestApproval.approvalReason.name" size="40" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Approval Remark</td>
                        <td>
                            <s:textarea id="paymentRequestApproval.approvalRemark" name="paymentRequestApproval.approvalRemark"  cols="72" rows="2" height="20"></s:textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>          
        <tr hidden="true">
            <td>
                <s:textfield id="paymentRequestApproval.updatedBy" name="paymentRequestApproval.updatedBy" key="paymentRequestApproval.createdBy" readonly="true" size="22"></s:textfield>
                <sj:datepicker id="paymentRequestApproval.updatedDate" name="paymentRequestApproval.updatedDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="paymentRequestApprovalTemp.updatedDateTemp" name="paymentRequestApprovalTemp.updatedDateTemp" size="20"></s:textfield>
                <s:textfield id="paymentRequestApproval.createdBy" name="paymentRequestApproval.createdBy" key="paymentRequestApproval.createdBy" readonly="true" size="22"></s:textfield>
                <sj:datepicker id="paymentRequestApproval.createdDate" name="paymentRequestApproval.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="paymentRequestApprovalTemp.createdDateTemp" name="paymentRequestApprovalTemp.createdDateTemp" size="20"></s:textfield>
            </td>
        </tr>
        <tr hidden="true">
            <td>
                <s:textfield id="paymentRequestApprovalModuleCode" name="paymentRequestApprovalModuleCode" key="paymentRequestApprovalModuleCode" readonly="true" size="22"></s:textfield>
                <s:textfield id="paymentRequestApproval.releasedStatus" name="paymentRequestApproval.releasedStatus" key="paymentRequestApproval.releasedStatus" readonly="true" size="22"></s:textfield>
                <sj:datepicker id="paymentRequestApproval.releasedDate" name="paymentRequestApproval.releasedDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeYear="true" changeMonth="true" ></sj:datepicker>
                <s:textfield id="paymentRequestApprovalTemp.releasedDateTemp" name="paymentRequestApprovalTemp.releasedDateTemp" size="20"></s:textfield>
                <s:textfield id="paymentRequestApproval.releasedReason.code" name="paymentRequestApproval.releasedReason.code" key="paymentRequestApproval.releasedReasonCode" readonly="true" size="22"></s:textfield>
                <s:textfield id="paymentRequestApproval.releasedRemark" name="paymentRequestApproval.releasedRemark" key="paymentRequestApproval.releasedRemark" readonly="true" size="22"></s:textfield>
                <s:textfield id="paymentRequestApproval.releasedBy" name="paymentRequestApproval.releasedBy" key="paymentRequestApproval.releasedBy" readonly="true" size="22"></s:textfield>
            </td>
        </tr>
    </table>
                        
    <div id="paymentRequestApprovalDetailDocumentInputGrid">
        <sjg:grid
            id="paymentRequestApprovalDetailDocumentInput_grid"
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
            width="$('#tabmnuPAYMENT_REQUEST_APPROVAL').width()"
        >
            <sjg:gridColumn
                name="paymentRequestApprovalDetailDocument" index="paymentRequestApprovalDetailDocument" title="" width="10" align="centre"
                editable="true" edittype="text" hidden="true"
            />
            <sjg:gridColumn
                name="paymentRequestApprovalDetailDocumentBranchCode" index="paymentRequestApprovalDetailDocumentBranchCode" key="paymentRequestApprovalDetailDocumentBranchCode" title="Branch" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="paymentRequestApprovalDetailDocumentDocumentType" index="paymentRequestApprovalDetailDocumentDocumentType" key="paymentRequestApprovalDetailDocumentDocumentType" title="Type" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="paymentRequestApprovalDetailDocumentDocumentNo" index="paymentRequestApprovalDetailDocumentDocumentNo" 
                key="paymentRequestApprovalDetailDocumentDocumentNo" title="Document No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="paymentRequestApprovalDetailDocumentDocumentRefNo" index="paymentRequestApprovalDetailDocumentDocumentRefNo" 
                key="paymentRequestApprovalDetailDocumentDocumentRefNo" title="Document RefNo" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name = "paymentRequestApprovalDetailDocumentCurrencyCode" index = "paymentRequestApprovalDetailDocumentCurrencyCode" key = "paymentRequestApprovalDetailDocumentCurrencyCode" title = "Currency" width = "60" 
            />
             <sjg:gridColumn
                name = "paymentRequestApprovalDetailDocumentExchangeRate" index = "paymentRequestApprovalDetailDocumentExchangeRate" key = "paymentRequestApprovalDetailDocumentExchangeRate" title = "Exchange Rate" width = "60" 
            />
            <sjg:gridColumn
                name = "paymentRequestApprovalDetailDocumentAmountForeign" index = "paymentRequestApprovalDetailDocumentAmountForeign" key = "paymentRequestApprovalDetailDocumentAmountForeign" 
                title = "Doc Amount (Foreign)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestApprovalDetailDocumentBalanceForeign" index = "paymentRequestApprovalDetailDocumentBalanceForeign" key = "paymentRequestApprovalDetailDocumentBalanceForeign" 
                title = "Doc Balance (Foreign)" width = "150" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestApprovalDetailDocumentTransactionStatus" index = "paymentRequestApprovalDetailDocumentTransactionStatus" key = "paymentRequestApprovalDetailDocumentTransactionStatus" title = "Transaction Status" width = "100" 
                formatter="select" align="center" formoptions="{label:'Please Select'}"
                editable="true" edittype="select" editoptions="{value:'---Select---:---Select---;Transaction:Transaction;Other:Other'}" 
            />
            <sjg:gridColumn
                name="paymentRequestApprovalDetailDocumentDebitForeign" index="paymentRequestApprovalDetailDocumentDebitForeign" key="paymentRequestApprovalDetailDocumentDebitForeign" title="Debit (Foreign)" 
                width="150" align="right" editable="false" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="paymentRequestApprovalDetailDocumentCreditForeign" index="paymentRequestApprovalDetailDocumentCreditForeign" key="paymentRequestApprovalDetailDocumentCreditForeign" title="Credit (Foreign)" 
                width="150" align="right" editable="false" edittype="text" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestApprovalDetailDocumentRemark" index="paymentRequestApprovalDetailDocumentRemark" key="paymentRequestApprovalDetailDocumentRemark" title="Remark" width="225"  editable="false" edittype="text"
            />
        </sjg:grid >                
    </div>
    <br class="spacer" />
    <table width="100%">        
        <tr>
            <td width="70%">
                <sj:a href="#" id="btnPaymentRequestApprovalSave" button="true" style="width: 60px">Save</sj:a>
                
                <sj:a href="#" id="btnPaymentRequestApprovalCancel" button="true" style="width: 60px">Cancel</sj:a>
            </td>
<!--            <td align="middle">
                <sj:a href="#" id="btnPaymentRequestApprovalCalculate" button="true" style="width: 80px">Calculate</sj:a>
            </td>-->
        </tr>
        <tr>
            <td/>
            <td>
                <table width="100%">
<!--                    <tr>
                        <td width="22%"/>
                        <td height="10px" align="left"><label>Foreign</label></td>
                    </tr>-->
                    <tr>
                        <td style="text-align: right">Total(Debit)</td>
                        <td><s:textfield id="paymentRequestApprovalTotalDebitForeign" name="paymentRequestApprovalTotalDebitForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00" disabled="true"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Total(Credit)</td>
                        <td><s:textfield id="paymentRequestApprovalTotalCreditForeign" name="paymentRequestApprovalTotalCreditForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00" disabled="true"></s:textfield></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Balance</td>
                        <td><s:textfield id="paymentRequestApprovalTotalBalanceForeign" name="paymentRequestApprovalTotalBalanceForeign" size="25" cssStyle="text-align:right" readonly="true" PlaceHolder="0.00" disabled="true"></s:textfield></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </s:form>
</div>