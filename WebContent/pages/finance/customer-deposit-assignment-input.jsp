<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    
    var 
        txtCustomerDepositAssignmentCustomerCode = $("#customerDepositAssignment\\.customer\\.code"),
        txtCustomerDepositAssignmentCustomerName = $("#customerDepositAssignment\\.customer\\.name"),
        txtCustomerDepositAssignmentCustomerDepositNo = $("#customerDepositAssignment\\.depositNo"),
        txtCustomerDepositAssignmentCustomerRemark = $("#customerDepositAssignment\\.remark"),

        allFieldsPurchaseRequestApproval=$([])
            .add(txtCustomerDepositAssignmentCustomerCode)
            .add(txtCustomerDepositAssignmentCustomerName);
    
    $(document).ready(function(){
        formatNumericBBM2();
        txtCustomerDepositAssignmentCustomerCode.val($("#customerDepositAssignment\\.customerCode").val());
        txtCustomerDepositAssignmentCustomerName.val($("#customerDepositAssignment\\.customerName").val());
    });
    
    $("#btnCustomerDepositAssignmentSave").click(function(ev) {
    
//            formatDateCustomerDepositAssignment();
           
            var url = "finance/customer-deposit-assignment-save";
            
            var params = "customerDepositAssignment.depositNo="+$("#customerDepositAssignment\\.depositNo").val();
            params += "&customerDepositAssignment.customerCode="+$("#customerDepositAssignment\\.customer\\.code").val();
            params += "&customerDepositAssignment.transType="+$("#customerDepositAssignment\\.transType").val();
            
             $.post(url, params, function (data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
//                        formatDateCustomerDepositAssignment();
                        return;
                    }

                    if(data.errorMessage){
                        alertMessage(data.errorMessage);
//                        formatDateCustomerDepositAssignment();
                        return;
                    }

                    alertMessage(data.message);
                    
                    var url = "finance/customer-deposit-assignment";
                    var params = "";

                    pageLoad(url, params, "#tabmnuCUSTOMER_DEPOSIT_ASSIGNMENT"); 
            });
        });
        
        $('#customerDepositAssignment_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerDepositAssignment&idsubdoc=customer","Search", "scrollbars=1, width=600, height=500");
        });
        
        $("#btnCustomerDepositAssignmentCancel").click(function(ev) {
            var url = "finance/customer-deposit-assignment";
            var params = "";
            
            pageLoad(url, params, "#tabmnuCUSTOMER_DEPOSIT_ASSIGNMENT"); 
            
        });
        
        function formatDateCustomerDepositAssignment(){
            var contraBonDate=formatDate($("#customerDepositAssignment\\.contraBonDate").val(),false);
            $("#customerDepositAssignment\\.contraBonDate").val(contraBonDate);

            var supplierInvoiceDate=formatDate($("#customerDepositAssignment\\.supplierInvoiceDate").val(),false);
            $("#customerDepositAssignment\\.supplierInvoiceDate").val(supplierInvoiceDate);

             var taxInvoiceDate=formatDate($("#customerDepositAssignment\\.taxInvoiceDate").val(),false);
            $("#customerDepositAssignment\\.taxInvoiceDate").val(taxInvoiceDate);
        }
        function formatNumericBBM2(){
            var grandTotalAmountFormat =parseFloat($("#customerDepositAssignment\\.grandTotalAmount").val());
            $("#customerDepositAssignment\\.grandTotalAmount").val(formatNumber(grandTotalAmountFormat,2));
        }
        
</script>

<b>CUSTOMER DEPOSIT ASSIGNMENT</b>
<hr>
<br class="spacer" />
<div id="customerDepositAssignmentInput" class="content ui-widget">
    <s:form id="frmCustomerDepositAssignmentInput">
        <table cellpadding="2" cellspacing="2" >
            <tr valign="top">
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right">Deposit No</td>
                            <td><s:textfield id="customerDepositAssignment.depositNo" name="customerDepositAssignment.depositNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Transaksi Date</td>
                            <td><s:textfield id="customerDepositAssignment.transactionDate" name="customerDepositAssignment.transactionDate" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">GrandTotal Amount</td>
                            <td>
                                <s:textfield id="customerDepositAssignment.grandTotalAmount" name="customerDepositAssignment.grandTotalAmount" size="25" style="text-align: right" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="customerDepositAssignment.remark" name="customerDepositAssignment.remark"  cols="72" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Trans Type</td>
                            <td colspan="3"><s:textfield id="customerDepositAssignment.transType" name="customerDepositAssignment.transType"  cols="72" rows="2" height="20" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtCustomerDepositAssignmentCustomerCode.change(function(ev) {
                                        if(txtCustomerDepositAssignmentCustomerCode.val()===""){
                                            txtCustomerDepositAssignmentCustomerName.val("");
                                            return;
                                        }
                                        var url = "master/customer-get";
                                        var params = "customer.code=" + txtCustomerDepositAssignmentCustomerCode.val();
                                            params+= "&customer.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.customerTemp){
                                                txtCustomerDepositAssignmentCustomerCode.val(data.customerTemp.code);
                                                txtCustomerDepositAssignmentCustomerName.val(data.customerTemp.name);
                                            }
                                            else{
                                                alertMessage("Customer Not Found!",txtCustomerDepositAssignmentCustomerCode);
                                                txtCustomerDepositAssignmentCustomerCode.val("");
                                                txtCustomerDepositAssignmentCustomerName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="customerDepositAssignment.customer.code" name="customerDepositAssignment.customer.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                    <s:textfield id="customerDepositAssignment.customerCode" name="customerDepositAssignment.customerCode" title=" " required="true" cssClass="required" size="22" hidden="true" disabled="true"></s:textfield>
                                    <sj:a id="customerDepositAssignment_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="customerDepositAssignment.customer.name" name="customerDepositAssignment.customer.name" size="40" readonly="true"></s:textfield>
                                    <s:textfield id="customerDepositAssignment.customerName" name="customerDepositAssignment.customerName" title=" " required="true" cssClass="required" size="22" hidden="true" disabled="true"></s:textfield>
                            </td>
                        </tr>    
                        <tr height="50">
                            <td></td>
                            <td>
                                <sj:a href="#" id="btnCustomerDepositAssignmentSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btnCustomerDepositAssignmentCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>

