
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
    
    #requestForQuotationApprovalDetailInput_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
     
     var                                    
        txtRequestForQuotationApprovalCode = $("#requestForQuotationApproval\\.code"),
        txtRequestForQuotationApprovalRFQNo = $("#requestForQuotationApproval\\.rfqNo"),
        txtRequestForQuotationApprovalRevision = $("#requestForQuotationApproval\\.revision"),
        txtRequestForQuotationApprovalRefRFQCode = $("#requestForQuotationApproval\\.refRfqCode"),
        txtRequestForQuotationApprovalTenderNo = $("#requestForQuotationApproval\\.tenderNo"),
        rdbRequestForQuotationApprovalOrderStatus = $("#requestForQuotationApproval\\.orderStatus"),
        txtRequestForQuotationApprovalBranchCode = $("#requestForQuotationApproval\\.branch\\.code"),
        txtRequestForQuotationApprovalBranchName = $("#requestForQuotationApproval\\.branch\\.name"),
        dtpRequestForQuotationApprovalTransactionDate = $("#requestForQuotationApproval\\.transactionDate"),
        dtpRequestForQuotationApprovalRegisteredDate = $("#requestForQuotationApproval\\.registeredDate"),
        rdbRequestForQuotationApprovalReviewedStatus = $("#requestForQuotationApproval\\.reviewedStatus"),
        dtpRequestForQuotationApprovalPreBidMeeting = $("#requestForQuotationApproval\\.preBidMeeting"),
        dtpRequestForQuotationApprovalSendToFactoryDate = $("#requestForQuotationApproval\\.sendToFactoryDate"),
        dtpRequestForQuotationApprovalSubmittedDate = $("#requestForQuotationApproval\\.submittedDateToCustomer"),
        txtRequestForQuotationApprovalScopeOfSupply = $("#requestForQuotationApproval\\.scopeOfSupply"),
        txtRequestForQuotationApprovalCurrencyCode = $("#requestForQuotationApproval\\.currency\\.code"),
        txtRequestForQuotationApprovalCurrencyName = $("#requestForQuotationApproval\\.currency\\.name"),
        txtRequestForQuotationApprovalCustomerCode = $("#requestForQuotationApproval\\.customer\\.code"),
        txtRequestForQuotationApprovalCustomerName = $("#requestForQuotationApproval\\.customer\\.name"),
        txtRequestForQuotationApprovalEndUserCode = $("#requestForQuotationApproval\\.endUser\\.code"),
        txtRequestForQuotationApprovalEndUserName = $("#requestForQuotationApproval\\.endUser\\.name"),
        txtRequestForQuotationApprovalAttn = $("#requestForQuotationApproval\\.attn"),
        txtRequestForQuotationApprovalSalesPersonCode = $("#requestForQuotationApproval\\.salesPerson\\.code"),
        txtRequestForQuotationApprovalSalesPersonName = $("#requestForQuotationApproval\\.salesPerson\\.name"),
        txtRequestForQuotationApprovalProjectCode = $("#requestForQuotationApproval\\.project\\.code"),
        txtRequestForQuotationApprovalProjectName = $("#requestForQuotationApproval\\.project\\.name"),
        txtRequestForQuotationApprovalRefNo = $("#requestForQuotationApproval\\.refNo"),
        txtRequestForQuotationApprovalRemark = $("#requestForQuotationApproval\\.remark");
        dtpRequestForQuotationApprovalCreatedDate = $("#requestForQuotationApproval\\.createdDate");
        txtRequestForQuotationApprovalPreventiveAction = $("#requestForQuotationApproval\\.preventiveAction");
        txtRequestForQuotationApprovalRemark = $("#requestForQuotationApproval\\.approvalRemark");
        rdbRequestForQuotationApprovalStatus  = $("#requestForQuotationApproval\\.approvalStatus");
        txtRequestForQuotationApprovalReasonCode = $("#requestForQuotationApproval\\.approvalReason\\.code");
        txtRequestForQuotationApprovalReasonName = $("#requestForQuotationApproval\\.approvalReason\\.name");

        allFieldsCDP = $([])
            .add(txtRequestForQuotationApprovalCode)
            .add(txtRequestForQuotationApprovalRFQNo)
            .add(txtRequestForQuotationApprovalRevision)
            .add(txtRequestForQuotationApprovalRefRFQCode)
            .add(txtRequestForQuotationApprovalTenderNo)
            .add(rdbRequestForQuotationApprovalOrderStatus)
            .add(txtRequestForQuotationApprovalBranchCode)
            .add(txtRequestForQuotationApprovalBranchName)
            .add(dtpRequestForQuotationApprovalTransactionDate)
            .add(dtpRequestForQuotationApprovalRegisteredDate)
            .add(rdbRequestForQuotationApprovalReviewedStatus)
            .add(dtpRequestForQuotationApprovalPreBidMeeting)
            .add(dtpRequestForQuotationApprovalSendToFactoryDate)
            .add(dtpRequestForQuotationApprovalSubmittedDate)
            .add(txtRequestForQuotationApprovalScopeOfSupply)
            .add(txtRequestForQuotationApprovalCurrencyCode)
            .add(txtRequestForQuotationApprovalCurrencyName)
            .add(txtRequestForQuotationApprovalCustomerCode)
            .add(txtRequestForQuotationApprovalCustomerName)
            .add(txtRequestForQuotationApprovalEndUserCode)
            .add(txtRequestForQuotationApprovalEndUserName)
            .add(txtRequestForQuotationApprovalAttn)
            .add(txtRequestForQuotationApprovalSalesPersonCode)
            .add(txtRequestForQuotationApprovalSalesPersonName)
            .add(txtRequestForQuotationApprovalProjectCode)
            .add(txtRequestForQuotationApprovalProjectName)
            .add(txtRequestForQuotationApprovalRefNo)
            .add(txtRequestForQuotationApprovalRemark)
            .add(txtRequestForQuotationApprovalPreventiveAction)
            .add(rdbRequestForQuotationApprovalStatus)
            .add(txtRequestForQuotationApprovalReasonCode)
            .add(txtRequestForQuotationApprovalReasonName)
            
    
    function alertMessageRFQ(alert_message,txt){
        
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
    
    function formatDate(date) {
        var dateSplit = date.split('/');
        var dateFormat = dateSplit[1] + "/" + dateSplit[0] + "/" + dateSplit[2];
        return dateFormat;
    }
    function formatDateRemoveT(date, useTime) {
        var dateValues = date.split('T');
        var dateValuesTemp = dateValues[0].split('-');
        var dateValue = dateValuesTemp[2] + "/" + dateValuesTemp[1] + "/" + dateValuesTemp[0];
        var dateValuesTemps;

        if (useTime) {
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    function formatDateRequestForQuotationApproval(){
        var transactionDate=formatDate(dtpRequestForQuotationApprovalTransactionDate.val());
        dtpRequestForQuotationApprovalTransactionDate.val(transactionDate);  
        
        var registeredDate=formatDate(dtpRequestForQuotationApprovalRegisteredDate.val());
        dtpRequestForQuotationApprovalRegisteredDate.val(registeredDate);
        
        var preBidMeetingDate=formatDate(dtpRequestForQuotationApprovalPreBidMeeting.val());
        dtpRequestForQuotationApprovalPreBidMeeting.val(preBidMeetingDate);
        
        var sendToFactoryDate=formatDate(dtpRequestForQuotationApprovalSendToFactoryDate.val());
        dtpRequestForQuotationApprovalSendToFactoryDate.val(sendToFactoryDate);
        
        var submittedDate=formatDate(dtpRequestForQuotationApprovalSubmittedDate.val());
        dtpRequestForQuotationApprovalSubmittedDate.val(submittedDate);
        
        var createdDate = formatDate(dtpRequestForQuotationApprovalCreatedDate.val());
        dtpRequestForQuotationApprovalCreatedDate.val(createdDate);
        
    }
    
    $(document).ready(function () {
        hoverButton();
        radioStatusApproval();
        
        
        $('#requestForQuotationApprovalApprovalStatusRadAPPROVED').change(function(ev){
            $("#requestForQuotationApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('#requestForQuotationApprovalApprovalStatusRadDECLINED').change(function(ev){
            $("#requestForQuotationApproval\\.approvalStatus").val("DECLINED");
        });
        
        $('#requestForQuotationApprovalApprovalStatusRadPENDING').change(function(ev){
            $("#requestForQuotationApproval\\.approvalStatus").val("PENDING");
        });
        
         $('input[name="requestForQuotationApprovalApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#requestForQuotationApproval\\.approvalStatus").val(value);
        });
         $('input[name="requestForQuotationApprovalApprovalStatusRad"][value="DECLINED"]').change(function(ev){
            var value="DECLINED";
            $("#requestForQuotationApproval\\.approvalStatus").val(value);
        });
         $('input[name="requestForQuotationApprovalApprovalStatusRad"][value="PENDING"]').change(function(ev){
            var value="PENDING";
            $("#requestForQuotationApproval\\.approvalStatus").val(value);
        });
        
         $('input[name="requestForQuotationApprovalRadOrderStatus"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#requestForQuotationApproval\\.orderStatus").val(value);
        });
                
        $('input[name="requestForQuotationApprovalRadOrderStatus"][value="SALES_ORDER"]').change(function(ev){
            var value="SALES_ORDER";
            $("#requestForQuotationApproval\\.orderStatus").val(value);
        });
        
        $('input[name="requestForQuotationApprovalRadReviewedStatus"][value="YES"]').change(function(ev){
            var value="true";
            $("#requestForQuotationApproval\\.reviewedStatus").val(value);
        });
                
        $('input[name="requestForQuotationApprovalRadReviewedStatus"][value="NO"]').change(function(ev){
            var value="false";
            $("#requestForQuotationApproval\\.reviewedStatus").val(value);
        });
        
//        --Button Save--
         $('#btnRequestForQuotationApprovalSave').click(function(ev) {
             
//            var date1 = dtpRequestForQuotationApprovalTransactionDate.val().split("/");
//            var month1 = date1[1];
//            var year1 = date1[2].split(" ");
//            var date2 = $("#requestForQuotationApprovalTransactionDate").val().split("/");
//            var month2 = date2[1];
//            var year2 = date2[2].split(" ");
//
//            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
//                if($("#requestForQuotationApprovalUpdateMode").val()==="true"){
//                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#requestForQuotationApprovalTransactionDate").val(),dtpRequestForQuotationApprovalTransactionDate);
//                }else{
//                    alertMessage("Transaction Month Must Between Session Period Month!",dtpRequestForQuotationApprovalTransactionDate);
//                }
//                return;
//            }
//
//            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
//                if($("#requestForQuotationApprovalUpdateMode").val()==="true"){
//                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#requestForQuotationApprovalTransactionDate").val(),dtpRequestForQuotationApprovalTransactionDate);
//                }else{
//                    alertMessage("Transaction Year Must Between Session Period Year!",dtpRequestForQuotationApprovalTransactionDate);
//                }
//                return;
//            }
              
            formatDateRequestForQuotationApproval();   
                var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Update Status?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Ref QUO No: '+$("#requestForQuotationApproval\\.code").val()+'<br/><br/>' +    
                    '</div>');
                dynamicDialog.dialog({
                    title           : "Confirmation:",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 400,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "YES",
                                        click : function() {
                                            var url="sales/request-for-quotation-approval-save";
                                            var params = $("#frmRequestForQuotationApprovalInput").serialize();
                                            $.post(url, params, function(data) {
                                                $("#dlgLoading").dialog("close");
                                                if (data.error) {
                                                    formatDateRequestForQuotationApproval(); 
                                                    alert(data.errorMessage);
                                                    return;
                                                }
                                                closeLoading();
                                                var url = "sales/request-for-quotation-approval";
                                                var params = "";
                                                pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION_APPROVAL");
                                            });
                                            $(this).dialog("close");
                                        }
                                    },
                                    {
                                        text : "No",
                                        click : function() {
                                            $(this).dialog("close");                                       
                                        }
                                    }]
                });
        });
        
//       --Button Cancel--
        $('#btnRequestForQuotationApprovalCancel').click(function(ev) {
            var url = "sales/request-for-quotation-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION_APPROVAL"); 
        });
        
        $('#requestForQuotationApproval_btnReason').click(function(ev) {
            window.open("./pages/search/search-reason.jsp?iddoc=requestForQuotationApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
        });

        
        
    });
    
     function radioStatusApproval(){
        if ($("#requestForQuotationApproval\\.orderStatus").val()==="BLANKET_ORDER"){
            $('#requestForQuotationApprovalRadOrderStatusBLANKET_ORDER').prop('checked',true);
            $('#requestForQuotationApprovalRadOrderStatusSALES_ORDER').attr('disabled',true);
        }
        else if ($("#requestForQuotationApproval\\.orderStatus").val()==="SALES_ORDER"){
            $('#requestForQuotationApprovalRadOrderStatusSALES_ORDER').prop('checked',true);
            $('#requestForQuotationApprovalRadOrderStatusBLANKET_ORDER').attr('disabled',true);
        }
        if ( $("#requestForQuotationApproval\\.reviewedStatus").val()==="true"){
            $('#requestForQuotationApprovalRadReviewedStatusYES').prop('checked',true);
            $('#requestForQuotationApprovalRadReviewedStatusNO').attr('disabled',true);
        }
        if ( $("#requestForQuotationApproval\\.reviewedStatus").val()==="false"){
            $('#requestForQuotationApprovalRadReviewedStatusNO').prop('checked',true);
            $('#requestForQuotationApprovalRadReviewedStatusYES').attr('disabled',true);
        }
        if ( $("#requestForQuotationApproval\\.approvalStatus").val()==="PENDING"){
            $('#requestForQuotationApprovalApprovalStatusRadPENDING').prop('checked',true);
        }
        if ( $("#requestForQuotationApproval\\.approvalStatus").val()==="APPROVED"){
            $('#requestForQuotationApprovalApprovalStatusRadAPPROVED').prop('checked',true);
        }
        if ( $("#requestForQuotationApproval\\.approvalStatus").val()==="DECLINED"){
            $('#requestForQuotationApprovalApprovalStatusRadDECLINED').prop('checked',true);
        }
         
    }
</script>
<s:url id="remotedetailurlRequestForQuotationApprovalDetailInput" action="" />
<b>REQUEST FOR QUOTATION APPROVAL</b>
<hr>
<br class="spacer" />
<div id="requestForQuotationApprovalInput" class="content ui-widget">
        <s:form id="frmRequestForQuotationApprovalInput">
            <table cellpadding="2" cellspacing="2">
                <tr valign="top">
                    <td>
                        <table>
                            <tr>
                                <td align="right" hidden = "true">Rfq No
                                <s:textfield id="requestForQuotationApproval.rfqNo" name="requestForQuotationApproval.rfqNo" key="requestForQuotationApproval.rfqNo" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>RFQ No *</B></td>
                                <td><s:textfield id="requestForQuotationApproval.code" name="requestForQuotationApproval.code" key="requestForQuotationApproval.code" readonly="true" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" hidden = "true">Revision
                                <s:textfield id="requestForQuotationApproval.revision" name="requestForQuotationApproval.revision" key="requestForQuotationApproval.revision" size="25"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right">Ref RFQ No </td>
                                <td><s:textfield id="requestForQuotationApproval.refRfqCode" name="requestForQuotationApproval.refRfqCode" key="requestForQuotationApproval.refRfqCode" readonly="true" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Tender No *</B></td>
                                <td><s:textfield id="requestForQuotationApproval.tenderNo" name="requestForQuotationApproval.tenderNo" key="requestForQuotationApproval.tenderNo" readonly="true" required="true" cssClass="required" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Order Status *</B>
                                <s:textfield id="requestForQuotationApproval.orderStatus" name="requestForQuotationApproval.orderStatus" readonly="true" size="20" style="display:none"></s:textfield></td>
                                <td><s:radio id="requestForQuotationApprovalRadOrderStatus" name="requestForQuotationApprovalRadOrderStatus" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Branch *</B></td>
                                <td colspan="2">
                                <s:textfield id="requestForQuotationApproval.branch.code" name="requestForQuotationApproval.branch.code" size="20" readonly="true"></s:textfield>
                                <s:textfield id="requestForQuotationApproval.branch.name" name="requestForQuotationApproval.branch.name" size="25" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationApproval.transactionDate" name="requestForQuotationApproval.transactionDate" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" disabled="true"></sj:datepicker>
                                    <sj:datepicker id="requestForQuotationApprovalTransactionDate" name="requestForQuotationApprovalTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" cssStyle="display:none"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Registered Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationApproval.registeredDate" name="requestForQuotationApproval.registeredDate" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" disabled="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Reviewed Status *</B>
                                <s:textfield id="requestForQuotationApproval.reviewedStatus" name="requestForQuotationApproval.reviewedStatus" readonly="true" size="20" style="display:none"></s:textfield></td>
                                <td><s:radio id="requestForQuotationApprovalRadReviewedStatus" name="requestForQuotationApprovalRadReviewedStatus" list="{'YES','NO'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right">Pre Bid Meeting </td>
                                <td>
                                    <sj:datepicker id="requestForQuotationApproval.preBidMeeting" name="requestForQuotationApproval.preBidMeeting" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" disabled="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Send to Factory Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationApproval.sendToFactoryDate" name="requestForQuotationApproval.sendToFactoryDate" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" disabled="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Submitted Date to Customer *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationApproval.submittedDateToCustomer" name="requestForQuotationApproval.submittedDateToCustomer" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" disabled="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Scope of Supply</td>
                                <td colspan="3">
                                    <s:textarea id="requestForQuotationApproval.scopeOfSupply" name="requestForQuotationApproval.scopeOfSupply" readonly="true" cols="47" rows="2" height="20"></s:textarea>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>Currency *</B></td>
                                <td>
                                    <s:textfield id="requestForQuotationApproval.currency.code" name="requestForQuotationApproval.currency.code" readonly="true" size="20" ></s:textfield>
                                    <s:textfield id="requestForQuotationApproval.currency.name" name="requestForQuotationApproval.currency.name" size="25" readonly="true" ></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Customer *</B></td>
                                <td>
                                    <s:textfield id="requestForQuotationApproval.customer.code" name="requestForQuotationApproval.customer.code" size="20" readonly="true" ></s:textfield>
                                        <s:textfield id="requestForQuotationApproval.customer.name" name="requestForQuotationApproval.customer.name" size="25" readonly="true" ></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>End User *</B></td>
                                <td colspan="2">
                                    <s:textfield id="requestForQuotationApproval.endUser.code" name="requestForQuotationApproval.endUser.code" size="20" readonly="true" ></s:textfield>
                                        <s:textfield id="requestForQuotationApproval.endUser.name" name="requestForQuotationApproval.endUser.name" size="25" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Attn </td>
                                <td><s:textfield id="requestForQuotationApproval.attn" name="requestForQuotationApproval.attn" size="27" readonly="true" ></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Sales Person *</B></td>
                                <td colspan="2">
                                <s:textfield id="requestForQuotationApproval.salesPerson.code" name="requestForQuotationApproval.salesPerson.code" size="20" readonly="true"></s:textfield>
                                <s:textfield id="requestForQuotationApproval.salesPerson.name" name="requestForQuotationApproval.salesPerson.name" size="25" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px">Project </td>
                                <td colspan="2">
                                <s:textfield id="requestForQuotationApproval.project.code" name="requestForQuotationApproval.project.code" size="20" readonly="true"></s:textfield>
                                <s:textfield id="requestForQuotationApproval.project.name" name="requestForQuotationApproval.project.name" size="25" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="requestForQuotationApproval.refNo" name="requestForQuotationApproval.refNo" size="25" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Subject </td>
                                <td><s:textfield id="requestForQuotationApproval.subject" name="requestForQuotationApproval.subject" size="25" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" hidden="true">Valid Status 
                                <s:textfield id="requestForQuotationApproval.validStatus" name="requestForQuotationApproval.validStatus" readonly="true" size="20" value = "YES" style="display:none"></s:textfield>
                                <s:radio id="requestForQuotationApprovalValidStatusRad" name="requestForQuotationApprovalValidStatusRad" list="{'YES','NO'}"></s:radio></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td><s:textarea id="requestForQuotationApproval.remark" name="requestForQuotationApproval.remark"  cols="50" rows="2" height="20" readonly="true"></s:textarea></td>                  
                                <s:textfield id="requestForQuotationApproval.createdBy" name="requestForQuotationApproval.createdBy" size="52" cssStyle="display:none"></s:textfield>
                                <s:textfield id="requestForQuotationApprovalTemp.createdDateTemp" name="requestForQuotationApprovalTemp.createdDateTemp" size="15" cssStyle="display:none"></s:textfield>
                                <sj:datepicker id="requestForQuotationApproval.createdDate" name="requestForQuotationApproval.createdDate" required="true" cssClass="required" size="25" displayFormat="dd/mm/yy"  timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </tr>
                             <tr>
                                <td align="right">Status </td>
                                <s:textfield id="requestForQuotationApproval.approvalStatus" name="requestForQuotationApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                                <td><s:radio id="requestForQuotationApprovalApprovalStatusRad" name="requestForQuotationApprovalApprovalStatusRad" list="{'PENDING','APPROVED','DECLINED'}"></s:radio></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Reason</td>
                                <td colspan="2">
                                <script type = "text/javascript">

                                    txtRequestForQuotationApprovalReasonCode.change(function(ev) {

                                        if(txtRequestForQuotationApprovalReasonCode.val()===""){
                                            txtRequestForQuotationApprovalReasonCode.val("");
                                            return;
                                        }
                                        var url = "master/reason-get";
                                        var params = "reason.code=" + txtRequestForQuotationApprovalReasonCode.val();
                                            params += "&reason.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.reasonTemp){
                                                txtRequestForQuotationApprovalReasonCode.val(data.reasonTemp.code);
                                                txtRequestForQuotationApprovalReasonName.val(data.reasonTemp.name);
                                            }
                                            else{
                                                alertMessage("Reason Not Found!",txtRequestForQuotationApprovalReasonCode);
                                                txtRequestForQuotationApprovalReasonCode.val("");
                                                txtRequestForQuotationApprovalReasonName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="requestForQuotationApproval.approvalReason.code" name="requestForQuotationApproval.approvalReason.code" size="20"></s:textfield>
                                    <sj:a id="requestForQuotationApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="requestForQuotationApproval.approvalReason.name" name="requestForQuotationApproval.approvalReason.name" size="25" readonly="true"></s:textfield>
                            </td>    
                        </tr>
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td><s:textarea id="requestForQuotationApproval.approvalRemark" name="requestForQuotationApproval.approvalRemark"  cols="50" rows="2" height="20"></s:textarea></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Preventive Action</td>
                                <td><s:textarea id="requestForQuotationApproval.preventiveAction" name="requestForQuotationApproval.preventiveAction"  cols="50" rows="2" height="20"></s:textarea></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>                   
        </s:form>     
        <div>
            <table>
                <tr>
                    <td width="51%"></td>
                    <td>
                        <sj:a href="#" id="btnRequestForQuotationApprovalSave" button="true">Save</sj:a>
                    </td>
                    <td>
                        <sj:a href="#" id="btnRequestForQuotationApprovalCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </div>
    </div>     