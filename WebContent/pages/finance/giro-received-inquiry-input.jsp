<%-- 
    Document   : giro-received-inquiry-input
    Created on : Jan 15, 2020, 2:56:21 PM
    Author     : Rayis
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
        txtGiroReceivedInquiryReasonCode = $("#giroReceivedInquiry\\.reason\\.code"),
        txtGiroReceivedInquiryReasonName = $("#giroReceivedInquiry\\.reason\\.name"),
        txtGiroReceivedInquiryAmount = $("#giroReceivedInquiry\\.Amount");
    $(document).ready(function(){    
        txtGiroReceivedInquiryAmount.val(formatNumber(parseFloat(txtGiroReceivedInquiryAmount.val()),2));
        
        $("#btngiroReceivedInquirySave").click(function(ev) {
               formatDateGiroReceived();
                var url = "finance/giro-received-inquiry-save";

                var params = $("#frmGiroReceivedInquiryInput").serialize();

                 $.post(url, params, function (data) {
                        if (data.error) {
                            formatDateGiroReceived();
                            alertMessage(data.errorMessage);
                            return;
                        }

                        if(data.errorMessage){
                            formatDateGiroReceived();
                            alertMessage(data.errorMessage);
                            return;
                        }

                        alertMessage(data.message);

                        var url = "finance/giro-received-inquiry";
                        var params = "";
                        pageLoad(url, params, "#tabmnuGIRO_RECEIVED_INQUIRY"); 
                });
            });

        $('#giroReceivedInquiry_btnReasonCode').click(function(ev) {
                window.open("./pages/search/search-reason.jsp?iddoc=giroReceivedInquiry&idsubdoc=reason","Search", "scrollbars=1, width=600, height=500");
            });

        $("#btngiroReceivedInquiryCancel").click(function(ev) {
                var url = "finance/giro-received-inquiry";
                var params = "";

                pageLoad(url, params, "#tabmnuGIRO_RECEIVED_INQUIRY"); 

            });
    }); //EOF Ready
        
        function formatDateGiroReceived(){
        var transactionDate=$("#giroReceivedInquiry\\.transactionDate").val();
        var transactionDateValues= transactionDate.split('/');
        var transactionDateValue =transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2];
        $("#giroReceivedInquiry\\.transactionDate").val(transactionDateValue);

        var dueDate=$("#giroReceivedInquiry\\.dueDate").val();
        var dueDateValues= dueDate.split('/');
        var dueDateValue = dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2];
        $("#giroReceivedInquiry\\.dueDate").val(dueDateValue);
    }
        
</script>

<b>GIRO RECEIVED INQUIRY</b>
<hr>
<br class="spacer"/>

<div id="giroReceivedInput" class="content ui-widget">
    <s:form id="frmGiroReceivedInquiryInput">
        <table cellpadding="2" cellspacing="2" >
            <tr valign="top">
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right">Giro Received No</td>
                            <td><s:textfield id="giroReceivedInquiry.code" name="giroReceivedInquiry.code" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Transaction Date</td>
                            <td>
                                <sj:datepicker id="giroReceivedInquiry.transactionDate" name="giroReceivedInquiry.transactionDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Branch</td>
                            <td>
                                <s:textfield id="giroReceivedInquiry.branch.Code" name="giroReceivedInquiry.branch.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroReceivedInquiry.branch.Name" name="giroReceivedInquiry.branch.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Giro No</td>
                            <td><s:textfield id="giroReceivedInquiry.giroNo" name="giroReceivedInquiry.giroNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Bank</td>
                            <td>
                                <s:textfield id="giroReceivedInquiry.bank.Code" name="giroReceivedInquiry.bank.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroReceivedInquiry.bank.Name" name="giroReceivedInquiry.bank.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Received From </td>
                            <td><s:textfield id="giroReceivedInquiry.receivedFrom" name="giroReceivedInquiry.receivedFrom" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Currency</td>
                            <td>
                                <s:textfield id="giroReceivedInquiry.currency.Code" name="giroReceivedInquiry.currency.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroReceivedInquiry.currency.Name" name="giroReceivedInquiry.currency.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Amount</td>
                            <td>
                                <s:textfield id="giroReceivedInquiry.Amount" name="giroReceivedInquiry.Amount" size="25" style="text-align: right" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Due Date</td>
                            <td>
                                <sj:datepicker id="giroReceivedInquiry.dueDate" name="giroReceivedInquiry.dueDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">RefNo</td>
                            <td><s:textfield id="giroReceivedInquiry.refNo" name="giroReceivedInquiry.refNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Description</td>
                            <td colspan="3"><s:textarea id="giroReceivedInquiry.description" name="giroReceivedInquiry.description"  cols="72" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><B>Inquiry Reason</B></td>
                            <td colspan="2">
                                 <script type = "text/javascript">
                                              
                                txtGiroReceivedInquiryReasonCode.change(function(ev) {
                                
                                if(txtGiroReceivedInquiryReasonCode.val()===""){
                                    txtGiroReceivedInquiryReasonName.val("");
                                    return;
                                }
                                
                                var url = "master/reason-get";
                                var params = "reason.code=" + txtGiroReceivedInquiryReasonCode.val();
                                    params+= "&reason.activeStatus=TRUE";
                                    
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.reasonTemp){
                                        txtGiroReceivedInquiryReasonCode.val(data.reasonTemp.code);
                                        txtGiroReceivedInquiryReasonName.val(data.reasonTemp.name);
                                    }
                                    else{
                                        alertMessage("Reason Not Found",txtGiroReceivedInquiryReasonCode);
                                        txtGiroReceivedInquiryReasonCode.val("");
                                        txtGiroReceivedInquiryReasonName.val("");
                                    }
                                });
                            });
                        </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="giroReceivedInquiry.reason.code" name="giroReceivedInquiry.reason.code" size="20" title="*" required="true" cssClass="required" readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="giroReceivedInquiry.reason.name" name="giroReceivedInquiry.reason.name" cssStyle="width:30%" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right">Inquiry Remark</td>
                            <td><s:textfield id="giroReceivedInquiry.rejectedRemark" name="giroReceivedInquiry.rejectedRemark" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr height="50">
                            <td>
                                <%--<sj:a href="#" id="btngiroReceivedInquirySave" button="true">Save</sj:a>--%>
                                <sj:a href="#" id="btngiroReceivedInquiryCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>
