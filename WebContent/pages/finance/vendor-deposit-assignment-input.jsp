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
        txtVendorDepositAssignmentVendorCode = $("#vendorDepositAssignment\\.vendor\\.code"),
        txtVendorDepositAssignmentVendorName = $("#vendorDepositAssignment\\.vendor\\.name"),
        txtVendorDepositAssignmentVendorDepositNo = $("#vendorDepositAssignment\\.depositNo"),
        txtVendorDepositAssignmentVendorRemark = $("#vendorDepositAssignment\\.remark"),

        allFieldsPurchaseRequestApproval=$([])
            .add(txtVendorDepositAssignmentVendorCode)
            .add(txtVendorDepositAssignmentVendorName);
    
    $(document).ready(function(){
        formatNumericBBM2();
        txtVendorDepositAssignmentVendorCode.val($("#vendorDepositAssignment\\.vendorCode").val());
        txtVendorDepositAssignmentVendorName.val($("#vendorDepositAssignment\\.vendorName").val());
    });
    
    $("#btnVendorDepositAssignmentSave").click(function(ev) {
    
//            formatDateVendorDepositAssignment();
           
            var url = "finance/vendor-deposit-assignment-save";
            
            var params = "vendorDepositAssignment.depositNo="+$("#vendorDepositAssignment\\.depositNo").val();
            params += "&vendorDepositAssignment.vendorCode="+$("#vendorDepositAssignment\\.vendor\\.code").val();
            params += "&vendorDepositAssignment.transType="+$("#vendorDepositAssignment\\.transType").val();
            
             $.post(url, params, function (data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
//                        formatDateVendorDepositAssignment();
                        return;
                    }

                    if(data.errorMessage){
                        alertMessage(data.errorMessage);
//                        formatDateVendorDepositAssignment();
                        return;
                    }

                    alertMessage(data.message);
                    
                    var url = "finance/vendor-deposit-assignment";
                    var params = "";

                    pageLoad(url, params, "#tabmnuVENDOR_DEPOSIT_ASSIGNMENT"); 
            });
        });
        
        $('#vendorDepositAssignment_btnVendor').click(function(ev) {
            window.open("./pages/search/search-vendor.jsp?iddoc=vendorDepositAssignment&idsubdoc=vendor","Search", "scrollbars=1, width=600, height=500");
        });
        
        $("#btnVendorDepositAssignmentCancel").click(function(ev) {
            var url = "finance/vendor-deposit-assignment";
            var params = "";
            
            pageLoad(url, params, "#tabmnuVENDOR_DEPOSIT_ASSIGNMENT"); 
            
        });
        
        function formatDateVendorDepositAssignment(){
            var contraBonDate=formatDate($("#vendorDepositAssignment\\.contraBonDate").val(),false);
            $("#vendorDepositAssignment\\.contraBonDate").val(contraBonDate);

            var supplierInvoiceDate=formatDate($("#vendorDepositAssignment\\.supplierInvoiceDate").val(),false);
            $("#vendorDepositAssignment\\.supplierInvoiceDate").val(supplierInvoiceDate);

             var taxInvoiceDate=formatDate($("#vendorDepositAssignment\\.taxInvoiceDate").val(),false);
            $("#vendorDepositAssignment\\.taxInvoiceDate").val(taxInvoiceDate);
        }
        function formatNumericBBM2(){
            var grandTotalAmountFormat =parseFloat($("#vendorDepositAssignment\\.grandTotalAmount").val());
            $("#vendorDepositAssignment\\.grandTotalAmount").val(formatNumber(grandTotalAmountFormat,2));
        }
        
</script>

<b>VENDOR DEPOSIT ASSIGNMENT</b>
<hr>
<br class="spacer" />
<div id="vendorDepositAssignmentInput" class="content ui-widget">
    <s:form id="frmVendorDepositAssignmentInput">
        <table cellpadding="2" cellspacing="2" >
            <tr valign="top">
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right">Deposit No</td>
                            <td><s:textfield id="vendorDepositAssignment.depositNo" name="vendorDepositAssignment.depositNo" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Transaksi Date</td>
                            <td><s:textfield id="vendorDepositAssignment.transactionDate" name="vendorDepositAssignment.transactionDate" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">GrandTotal Amount</td>
                            <td>
                                <s:textfield id="vendorDepositAssignment.grandTotalAmount" name="vendorDepositAssignment.grandTotalAmount" size="25" style="text-align: right" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3"><s:textarea id="vendorDepositAssignment.remark" name="vendorDepositAssignment.remark"  cols="72" rows="2" height="20" readonly="true"></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Trans Type</td>
                            <td colspan="3"><s:textfield id="vendorDepositAssignment.transType" name="vendorDepositAssignment.transType"  cols="72" rows="2" height="20" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Vendor *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    txtVendorDepositAssignmentVendorCode.change(function(ev) {
                                        if(txtVendorDepositAssignmentVendorCode.val()===""){
                                            txtVendorDepositAssignmentVendorName.val("");
                                            return;
                                        }
                                        var url = "master/vendor-get";
                                        var params = "vendor.code=" + txtVendorDepositAssignmentVendorCode.val();
                                            params+= "&vendor.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.vendorTemp){
                                                txtVendorDepositAssignmentVendorCode.val(data.vendorTemp.code);
                                                txtVendorDepositAssignmentVendorName.val(data.vendorTemp.name);
                                            }
                                            else{
                                                alertMessage("Vendor Not Found!",txtVendorDepositAssignmentVendorCode);
                                                txtVendorDepositAssignmentVendorCode.val("");
                                                txtVendorDepositAssignmentVendorName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div colspan="3" class="searchbox ui-widget-header">
                                    <s:textfield id="vendorDepositAssignment.vendor.code" name="vendorDepositAssignment.vendor.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                    <s:textfield id="vendorDepositAssignment.vendorCode" name="vendorDepositAssignment.vendorCode" title=" " required="true" cssClass="required" size="22" hidden="true" disabled="true"></s:textfield>
                                    <sj:a id="vendorDepositAssignment_btnVendor" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <s:textfield id="vendorDepositAssignment.vendor.name" name="vendorDepositAssignment.vendor.name" size="40" readonly="true"></s:textfield>
                                    <s:textfield id="vendorDepositAssignment.vendorName" name="vendorDepositAssignment.vendorName" title=" " required="true" cssClass="required" size="22" hidden="true" disabled="true"></s:textfield>
                            </td>
                        </tr>    
                        <tr height="50">
                            <td></td>
                            <td>
                                <sj:a href="#" id="btnVendorDepositAssignmentSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btnVendorDepositAssignmentCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>

