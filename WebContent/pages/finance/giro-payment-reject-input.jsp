<%-- 
    Document   : giro-payment-reject-input
    Created on : Aug 23, 2019, 9:55:40 AM
    Author     : ulla
--%>

<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script>
     var 
        txtGiroPaymentRejectRemark = $("#giroPaymentRejected\\.rejectedRemark"),
        txtGiroPaymentRejectReasonCode = $("#giroPaymentRejected\\.reason\\.code"),
        txtGiroPaymentRejectReasonName = $("#giroPaymentRejected\\.reason\\.name");
        
    $("#btngiroPaymentRejectSave").click(function(ev) {
        
        if (txtGiroPaymentRejectReasonCode.val()===""){
             alertMessage("Rejected Reason Can't Be Empty !!!");
            return;
        }
        
        if (txtGiroPaymentRejectRemark.val()===""){
             alertMessage("Rejected Remark Can't Be Empty !!!");
            return;
        }
     
        if ($("#giroPaymentRejected\\.reason\\.code").val()===""){
             alertMessage("Rejected Reason Can't Be Empty !!!");
            return;
        }
        
        if ($("#giroPaymentRejected\\.rejectedRemark").val()===""){
             alertMessage("Rejected Remark Can't Be Empty !!!");
            return;
        }
        
           formatDateGiroPayment();
            var url = "finance/giro-payment-reject-save";
            
            var params = $("#frmGiroPaymentRejectInput").serialize();
            
             $.post(url, params, function (data) {
                    if (data.error) {
                        formatDateGiroPayment();
                        alertMessage(data.errorMessage);
                        return;
                    }

                    if(data.errorMessage){
                        formatDateGiroPayment();
                        alertMessage(data.errorMessage);
                        return;
                    }

                    alertMessage(data.message);
                    
                    var url = "finance/giro-payment-reject";
                    var params = "";
                    pageLoad(url, params, "#tabmnuGIRO_PAYMENT_REJECT"); 
            });
        });
    
    $('#giroPaymentReject_btnReasonCode').click(function(ev) {
            window.open("./pages/search/search-reason.jsp?iddoc=giroPaymentRejected&idsubdoc=reason","Search", "scrollbars=1, width=600, height=500");
        });
    
    $("#btngiroPaymentRejectCancel").click(function(ev) {
            var url = "finance/giro-payment-reject";
            var params = "";
            
            pageLoad(url, params, "#tabmnuGIRO_PAYMENT_REJECT"); 
            
        });
        
        function formatDateGiroPayment(){
        var transactionDate=$("#giroPaymentRejected\\.transactionDate").val();
        var transactionDateValues= transactionDate.split('/');
        var transactionDateValue =transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2];
        $("#giroPaymentRejected\\.transactionDate").val(transactionDateValue);

        var dueDate=$("#giroPaymentRejected\\.dueDate").val();
        var dueDateValues= dueDate.split('/');
        var dueDateValue = dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2];
        $("#giroPaymentRejected\\.dueDate").val(dueDateValue);
    }
        
</script>

<b>GIRO PAYMENT REJECT</b>
<hr>
<br class="spacer"/>

<div id="giroPaymentInput" class="content ui-widget">
    <s:form id="frmGiroPaymentRejectInput">
        <table cellpadding="2" cellspacing="2" >
            <tr valign="top">
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right">Giro Payment No</td>
                            <td><s:textfield id="giroPaymentRejected.code" name="giroPaymentRejected.code" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Transaction Date</td>
                            <td><sj:datepicker id="giroPaymentRejected.transactionDate" name="giroPaymentRejected.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" disabled="true" readonly="true"></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right">Branch</td>
                            <td>
                                <s:textfield id="giroPaymentRejected.branch.Code" name="giroPaymentRejected.branch.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroPaymentRejected.branch.Name" name="giroPaymentRejected.branch.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Giro No</td>
                            <td><s:textfield id="giroPaymentRejected.giroNo" name="giroPaymentRejected.giroNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Bank</td>
                            <td>
                                <s:textfield id="giroPaymentRejected.bank.Code" name="giroPaymentRejected.bank.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroPaymentRejected.bank.Name" name="giroPaymentRejected.bank.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Payment To</td>
                            <td><s:textfield id="giroPaymentRejected.paymentTo" name="giroPaymentRejected.paymentTo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Currency</td>
                            <td>
                                <s:textfield id="giroPaymentRejected.currency.Code" name="giroPaymentRejected.currency.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroPaymentRejected.currency.Name" name="giroPaymentRejected.currency.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Amount</td>
                            <td>
                                <s:textfield id="giroPaymentRejected.Amount" name="giroPaymentRejected.Amount" size="25" style="text-align: right" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Due Date</td>
                            <td><sj:datepicker id="giroPaymentRejected.dueDate" name="giroPaymentRejected.dueDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" disabled="true" readonly="true"></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right">RefNo</td>
                            <td><s:textfield id="giroPaymentRejected.refNo" name="giroPaymentRejected.refNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Description</td>
                            <td colspan="3"><s:textarea id="giroPaymentRejected.description" name="giroPaymentRejected.description"  cols="72" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><B>Rejected Reason *</B></td>
                            <td colspan="2">
                                 <script type = "text/javascript">
                                              
                            txtGiroPaymentRejectReasonCode.change(function(ev) {
                                
                                if(txtGiroPaymentRejectReasonCode.val()===""){
                                    txtGiroPaymentRejectReasonName.val("");
                                    return;
                                }
                                
                                var url = "master/reason-get";
                                var params = "reason.code=" + txtGiroPaymentRejectReasonCode.val();
                                    params+= "&reason.activeStatus=TRUE";
                                    
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.reasonTemp){
                                        txtGiroPaymentRejectReasonCode.val(data.reasonTemp.code);
                                        txtGiroPaymentRejectReasonName.val(data.reasonTemp.name);
                                    }
                                    else{
                                        alertMessage("Reason Not Found",txtGiroPaymentRejectReasonCode);
                                        txtGiroPaymentRejectReasonCode.val("");
                                        txtGiroPaymentRejectReasonName.val("");
                                    }
                                });
                            });
                        </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="giroPaymentRejected.reason.code" name="giroPaymentRejected.reason.code" size="20" title="Please Insert Reason Code" required="true" cssClass="required"></s:textfield>
                                    <sj:a id="giroPaymentReject_btnReasonCode" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="giroPaymentRejected.reason.name" name="giroPaymentRejected.reason.name" cssStyle="width:30%" readonly="true"></s:textfield>
                            </td>
                        </tr
                        
                        <tr>
                            <td align="right">Rejected Remark *</td>
                            <td><s:textfield id="giroPaymentRejected.rejectedRemark" name="giroPaymentRejected.rejectedRemark" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
                        </tr>
                        <tr height="50">
                            <td>
                                <sj:a href="#" id="btngiroPaymentRejectSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btngiroPaymentRejectCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>
