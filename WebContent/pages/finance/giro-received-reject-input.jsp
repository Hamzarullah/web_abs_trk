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
            txtGiroReceivedRejectReasonCode = $("#giroReceivedReject\\.reason\\.code"),
            txtGiroReceivedRejectReasonName = $("#giroReceivedReject\\.reason\\.name"),
            txtGiroReceivedRejectAmount = $("#giroReceivedReject\\.Amount");
    
    $(document).ready(function(){
      
        txtGiroReceivedRejectAmount.val(formatNumber(parseFloat(txtGiroReceivedRejectAmount.val()),2));
        
        $("#btngiroReceivedRejectSave").click(function(ev) {
            formatDateGiroReceivedReject();   
            var amount = parseFloat(removeCommas(txtGiroReceivedRejectAmount.val()));
            txtGiroReceivedRejectAmount.val(amount);
            var url = "finance/giro-received-reject-save";

            var params = $("#frmGiroReceivedRejectInput").serialize();

             $.post(url, params, function (data) {
                    if (data.error) {
                        formatDateGiroReceivedReject();
                        alertMessage(data.errorMessage);
                        return;
                    }

                    if(data.errorMessage){
                        formatDateGiroReceivedReject();
                        alertMessage(data.errorMessage);
                        return;
                    }

                    alertMessage(data.message);

                    var url = "finance/giro-received-reject";
                    var params = "";

                    pageLoad(url, params, "#tabmnuGIRO_RECEIVED_REJECT"); 
            });
        });

        $("#btngiroReceivedRejectCancel").click(function(ev) {
                var url = "finance/giro-received-reject";
                var params = "";

                pageLoad(url, params, "#tabmnuGIRO_RECEIVED_REJECT"); 

            });
            
        $('#giroReceivedReject_btnReasonCode').click(function(ev) {
            window.open("./pages/search/search-reason.jsp?iddoc=giroReceivedReject&idsubdoc=reason","Search", "scrollbars=1, width=600, height=500");
        });
    });   
    
    function formatDateGiroReceivedReject(){
        var transactionDate=$("#giroReceivedReject\\.transactionDate").val();
        var transactionDateValues= transactionDate.split('/');
        var transactionDateValue =transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2];
        $("#giroReceivedReject\\.transactionDate").val(transactionDateValue);

        var dueDate=$("#giroReceivedReject\\.dueDate").val();
        var dueDateValues= dueDate.split('/');
        var dueDateValue = dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2];
        $("#giroReceivedReject\\.dueDate").val(dueDateValue);
    }
        
</script>

<b>GIRO RECEIVED REJECT</b>
<hr>
<br class="spacer"/>

<div id="giroPaymentInput" class="content ui-widget">
    <s:form id="frmGiroReceivedRejectInput">
        <table cellpadding="2" cellspacing="2" >
            <tr valign="top">
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right">Giro Received No</td>
                            <td><s:textfield id="giroReceivedReject.code" name="giroReceivedReject.code" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Transaction Date</td>
                            <td>
                                <sj:datepicker id="giroReceivedReject.transactionDate" name="giroReceivedReject.transactionDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Branch</td>
                            <td>
                                <s:textfield id="giroReceivedReject.branch.code" name="giroReceivedReject.branch.code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroReceivedReject.branch.name" name="giroReceivedReject.branch.name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Giro No</td>
                            <td><s:textfield id="giroReceivedReject.giroNo" name="giroReceivedReject.giroNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Bank</td>
                            <td>
                                <s:textfield id="giroReceivedReject.bank.code" name="giroReceivedReject.bank.code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroReceivedReject.bank.name" name="giroReceivedReject.bank.name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Received From</td>
                            <td><s:textfield id="giroReceivedReject.receivedFrom" name="giroReceivedReject.receivedFrom" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Currency</td>
                            <td>
                                <s:textfield id="giroReceivedReject.currency.code" name="giroReceivedReject.currency.code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroReceivedReject.currency.name" name="giroReceivedReject.currency.name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>>
                        <tr>
                            <td align="right">Amount</td>
                            <td>
                                <s:textfield id="giroReceivedReject.Amount" name="giroReceivedReject.Amount" size="25" style="text-align: right" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Giro Due Date</td>
                            <td>
                                <sj:datepicker id="giroReceivedReject.dueDate" name="giroReceivedReject.dueDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">RefNo</td>
                            <td><s:textfield id="giroReceivedReject.refNo" name="giroReceivedReject.refNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Description</td>
                            <td colspan="3"><s:textarea id="giroReceivedReject.description" name="giroReceivedReject.description"  cols="72" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Rejected Reason</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                      
                                txtGiroReceivedRejectReasonCode.change(function(ev) {
                                
                                if(txtGiroReceivedRejectReasonCode.val()===""){
                                    txtGiroReceivedRejectReasonName.val("");
                                    return;
                                }
                                
                                var url = "master/reason-get";
                                var params = "reason.code=" + txtGiroReceivedRejectReasonCode.val();
                                    params+= "&reason.activeStatus=TRUE";
                                    
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.reasonTemp){
                                        txtGiroReceivedRejectReasonCode.val(data.reasonTemp.code);
                                        txtGiroReceivedRejectReasonName.val(data.reasonTemp.name);
                                    }
                                    else{
                                        alertMessage("Reason Not Found",txtGiroReceivedRejectReasonCode);
                                        txtGiroReceivedRejectReasonCode.val("");
                                        txtGiroReceivedRejectReasonName.val("");
                                    }
                                });
                            });
                        </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="giroReceivedReject.reason.code" name="giroReceivedReject.reason.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                                    <sj:a id="giroReceivedReject_btnReasonCode" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="giroReceivedReject.reason.name" name="giroReceivedReject.reason.name" cssStyle="width:30%" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Rejected Remark</td>
                            <td><s:textfield id="giroReceivedReject.rejectedRemark" name="giroReceivedReject.rejectedRemark" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
                        </tr>
                        <tr height="50">
                            <td>
                                <sj:a href="#" id="btngiroReceivedRejectSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btngiroReceivedRejectCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>
