<%-- 
    Document   : giro-payment-inquiry-input
    Created on : Dec 10, 2019, 1:15:12 PM
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
        txtGiroPaymentInquiryReasonCode = $("#giroPaymentInquiry\\.reason\\.code"),
        txtGiroPaymentInquiryReasonName = $("#giroPaymentInquiry\\.reason\\.name");
        
    $("#btngiroPaymentInquirySave").click(function(ev) {
           formatDateGiroPayment();
            var url = "finance/giro-payment-inquiry-save";
            
            var params = $("#frmGiroPaymentInquiryInput").serialize();
            
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
                    
                    var url = "finance/giro-payment-inquiry";
                    var params = "";
                    pageLoad(url, params, "#tabmnuGIRO_PAYMENT_INQUIRY"); 
            });
        });
    
    $('#giroPaymentInquiry_btnReasonCode').click(function(ev) {
            window.open("./pages/search/search-reason.jsp?iddoc=giroPaymentInquiry&idsubdoc=reason","Search", "scrollbars=1, width=600, height=500");
        });
    
    $("#btngiroPaymentInquiryCancel").click(function(ev) {
            var url = "finance/giro-payment-inquiry";
            var params = "";
            
            pageLoad(url, params, "#tabmnuGIRO_PAYMENT_INQUIRY"); 
            
        });
        
        function formatDateGiroPayment(){
        var transactionDate=$("#giroPaymentInquiry\\.transactionDate").val();
        var transactionDateValues= transactionDate.split('/');
        var transactionDateValue =transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2];
        $("#giroPaymentInquiry\\.transactionDate").val(transactionDateValue);

        var dueDate=$("#giroPaymentInquiry\\.dueDate").val();
        var dueDateValues= dueDate.split('/');
        var dueDateValue = dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2];
        $("#giroPaymentInquiry\\.dueDate").val(dueDateValue);
    }
        
</script>

<b>GIRO PAYMENT INQUIRY</b>
<hr>
<br class="spacer"/>

<div id="giroPaymentInput" class="content ui-widget">
    <s:form id="frmGiroPaymentInquiryInput">
        <table cellpadding="2" cellspacing="2" >
            <tr valign="top">
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right">Giro Payment No</td>
                            <td><s:textfield id="giroPaymentInquiry.code" name="giroPaymentInquiry.code" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Transaction Date</td>
                            <td><sj:datepicker id="giroPaymentInquiry.transactionDate" name="giroPaymentInquiry.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" disabled="true" readonly="true"></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right">Branch</td>
                            <td>
                                <s:textfield id="giroPaymentInquiry.branch.Code" name="giroPaymentInquiry.branch.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroPaymentInquiry.branch.Name" name="giroPaymentInquiry.branch.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Giro No</td>
                            <td><s:textfield id="giroPaymentInquiry.giroNo" name="giroPaymentInquiry.giroNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Bank</td>
                            <td>
                                <s:textfield id="giroPaymentInquiry.bank.Code" name="giroPaymentInquiry.bank.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroPaymentInquiry.bank.Name" name="giroPaymentInquiry.bank.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Payment To</td>
                            <td><s:textfield id="giroPaymentInquiry.paymentTo" name="giroPaymentInquiry.paymentTo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Currency</td>
                            <td>
                                <s:textfield id="giroPaymentInquiry.currency.Code" name="giroPaymentInquiry.currency.Code" size="15" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="giroPaymentInquiry.currency.Name" name="giroPaymentInquiry.currency.Name" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Amount</td>
                            <td>
                                <s:textfield id="giroPaymentInquiry.Amount" name="giroPaymentInquiry.Amount" size="25" style="text-align: right" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Due Date</td>
                            <td><sj:datepicker id="giroPaymentInquiry.dueDate" name="giroPaymentInquiry.dueDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" disabled="true" readonly="true"></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right">RefNo</td>
                            <td><s:textfield id="giroPaymentInquiry.refNo" name="giroPaymentInquiry.refNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Description</td>
                            <td colspan="3"><s:textarea id="giroPaymentInquiry.description" name="giroPaymentInquiry.description"  cols="72" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><B>Inquiry Reason</B></td>
                            <td colspan="2">
                                 <script type = "text/javascript">
                                              
                                txtGiroPaymentInquiryReasonCode.change(function(ev) {
                                
                                if(txtGiroPaymentInquiryReasonCode.val()===""){
                                    txtGiroPaymentInquiryReasonName.val("");
                                    return;
                                }
                                
                                var url = "master/reason-get";
                                var params = "reason.code=" + txtGiroPaymentInquiryReasonCode.val();
                                    params+= "&reason.activeStatus=TRUE";
                                    
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.reasonTemp){
                                        txtGiroPaymentInquiryReasonCode.val(data.reasonTemp.code);
                                        txtGiroPaymentInquiryReasonName.val(data.reasonTemp.name);
                                    }
                                    else{
                                        alertMessage("Reason Not Found",txtGiroPaymentInquiryReasonCode);
                                        txtGiroPaymentInquiryReasonCode.val("");
                                        txtGiroPaymentInquiryReasonName.val("");
                                    }
                                });
                            });
                        </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="giroPaymentInquiry.reason.code" name="giroPaymentInquiry.reason.code" size="20" title="*" required="true" readonly="true" cssClass="required"></s:textfield>
                                    
                                </div>
                                    <s:textfield id="giroPaymentInquiry.reason.name" name="giroPaymentInquiry.reason.name" cssStyle="width:30%" readonly="true"></s:textfield>
                            </td>
                        </tr
                        
                        <tr>
                            <td align="right">Inquiry Remark</td>
                            <td><s:textfield id="giroPaymentInquiry.inquiryRemark" name="giroPaymentInquiry.inquiryRemark" size="25" readonly="true" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
                        </tr>
                        <tr height="50">
                            <td>
                                <%--<sj:a href="#" id="btngiroPaymentInquirySave" button="true">Save</sj:a>--%>
                                <sj:a href="#" id="btngiroPaymentInquiryCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>
