
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-closing{
        display: none;
    }
    
    #requestForQuotationClosingDetailInput_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
     
     var                                    
        txtRequestForQuotationCloseCode = $("#requestForQuotationClosing\\.code"),
        txtRequestForQuotationCloseRFQNo = $("#requestForQuotationClosing\\.rfqNo"),
        txtRequestForQuotationCloseRevision = $("#requestForQuotationClosing\\.revision"),
        txtRequestForQuotationCloseRefRFQCode = $("#requestForQuotationClosing\\.refRfqCode"),
        txtRequestForQuotationCloseTenderNo = $("#requestForQuotationClosing\\.tenderNo"),
        rdbRequestForQuotationCloseOrderStatus = $("#requestForQuotationClosing\\.orderStatus"),
        txtRequestForQuotationCloseBranchCode = $("#requestForQuotationClosing\\.branch\\.code"),
        txtRequestForQuotationCloseBranchName = $("#requestForQuotationClosing\\.branch\\.name"),
        dtpRequestForQuotationCloseTransactionDate = $("#requestForQuotationClosing\\.transactionDate"),
        dtpRequestForQuotationCloseRegisteredDate = $("#requestForQuotationClosing\\.registeredDate"),
        rdbRequestForQuotationCloseReviewedStatus = $("#requestForQuotationClosing\\.reviewedStatus"),
        dtpRequestForQuotationClosePreBidMeeting = $("#requestForQuotationClosing\\.preBidMeeting"),
        dtpRequestForQuotationCloseSendToFactoryDate = $("#requestForQuotationClosing\\.sendToFactoryDate"),
        dtpRequestForQuotationCloseSubmittedDate = $("#requestForQuotationClosing\\.submittedDateToCustomer"),
        txtRequestForQuotationCloseScopeOfSupply = $("#requestForQuotationClosing\\.scopeOfSupply"),
        txtRequestForQuotationCloseCurrencyCode = $("#requestForQuotationClosing\\.currency\\.code"),
        txtRequestForQuotationCloseCurrencyName = $("#requestForQuotationClosing\\.currency\\.name"),
        txtRequestForQuotationCloseCustomerCode = $("#requestForQuotationClosing\\.customer\\.code"),
        txtRequestForQuotationCloseCustomerName = $("#requestForQuotationClosing\\.customer\\.name"),
        txtRequestForQuotationCloseEndUserCode = $("#requestForQuotationClosing\\.endUser\\.code"),
        txtRequestForQuotationCloseEndUserName = $("#requestForQuotationClosing\\.endUser\\.name"),
        txtRequestForQuotationCloseAttn = $("#requestForQuotationClosing\\.attn"),
        txtRequestForQuotationCloseSalesPersonCode = $("#requestForQuotationClosing\\.salesPerson\\.code"),
        txtRequestForQuotationCloseSalesPersonName = $("#requestForQuotationClosing\\.salesPerson\\.name"),
        txtRequestForQuotationCloseProjectCode = $("#requestForQuotationClosing\\.project\\.code"),
        txtRequestForQuotationCloseProjectName = $("#requestForQuotationClosing\\.project\\.name"),
        txtRequestForQuotationCloseRefNo = $("#requestForQuotationClosing\\.refNo"),
        txtRequestForQuotationCloseRemark = $("#requestForQuotationClosing\\.remark");
        dtpRequestForQuotationCloseCreatedDate = $("#requestForQuotationClosing\\.createdDate");
        txtRequestForQuotationCloseRemark = $("#requestForQuotationClosing\\.closingRemark");
        rdbRequestForQuotationCloseStatus  = $("#requestForQuotationClosing\\.closingStatus");

        allFieldsCDP = $([])
            .add(txtRequestForQuotationCloseCode)
            .add(txtRequestForQuotationCloseRFQNo)
            .add(txtRequestForQuotationCloseRevision)
            .add(txtRequestForQuotationCloseRefRFQCode)
            .add(txtRequestForQuotationCloseTenderNo)
            .add(rdbRequestForQuotationCloseOrderStatus)
            .add(txtRequestForQuotationCloseBranchCode)
            .add(txtRequestForQuotationCloseBranchName)
            .add(dtpRequestForQuotationCloseTransactionDate)
            .add(dtpRequestForQuotationCloseRegisteredDate)
            .add(rdbRequestForQuotationCloseReviewedStatus)
            .add(dtpRequestForQuotationClosePreBidMeeting)
            .add(dtpRequestForQuotationCloseSendToFactoryDate)
            .add(dtpRequestForQuotationCloseSubmittedDate)
            .add(txtRequestForQuotationCloseScopeOfSupply)
            .add(txtRequestForQuotationCloseCurrencyCode)
            .add(txtRequestForQuotationCloseCurrencyName)
            .add(txtRequestForQuotationCloseCustomerCode)
            .add(txtRequestForQuotationCloseCustomerName)
            .add(txtRequestForQuotationCloseEndUserCode)
            .add(txtRequestForQuotationCloseEndUserName)
            .add(txtRequestForQuotationCloseAttn)
            .add(txtRequestForQuotationCloseSalesPersonCode)
            .add(txtRequestForQuotationCloseSalesPersonName)
            .add(txtRequestForQuotationCloseProjectCode)
            .add(txtRequestForQuotationCloseProjectName)
            .add(txtRequestForQuotationCloseRefNo)
            .add(txtRequestForQuotationCloseRemark)
            .add(rdbRequestForQuotationCloseStatus)
            
    
    function alertMessageRFQ(alert_message,txt){
        
        var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>'+alert_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>' +
                    '</div>');
            
            dynamicDialog.dialog({
                title : "Attention!",
                closingOnEscape: false,
                modal : true,
                width: 400,
                resizable: false,
                closingText: "hide",
                buttons : 
                    [{
                        text : "OK",
                        click : function() {
                            $(this).dialog("closing");
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
    
    function formatDateRequestForQuotationClose(){
        var transactionDate=formatDate(dtpRequestForQuotationCloseTransactionDate.val());
        dtpRequestForQuotationCloseTransactionDate.val(transactionDate);  
        
        var registeredDate=formatDate(dtpRequestForQuotationCloseRegisteredDate.val());
        dtpRequestForQuotationCloseRegisteredDate.val(registeredDate);
        
        var preBidMeetingDate=formatDate(dtpRequestForQuotationClosePreBidMeeting.val());
        dtpRequestForQuotationClosePreBidMeeting.val(preBidMeetingDate);
        
        var sendToFactoryDate=formatDate(dtpRequestForQuotationCloseSendToFactoryDate.val());
        dtpRequestForQuotationCloseSendToFactoryDate.val(sendToFactoryDate);
        
        var submittedDate=formatDate(dtpRequestForQuotationCloseSubmittedDate.val());
        dtpRequestForQuotationCloseSubmittedDate.val(submittedDate);
        
        var createdDate = formatDate(dtpRequestForQuotationCloseCreatedDate.val());
        dtpRequestForQuotationCloseCreatedDate.val(createdDate);
        
    }
    
    $(document).ready(function () {
        hoverButton();
        radioStatusClose();
        
        
        $("#requestForQuotationClosing\\.closingStatus").val("CLOSED");
        
        $('#requestForQuotationClosingCloseStatusRadOPEN').change(function(ev){
            $("#requestForQuotationClosing\\.closingStatus").val("OPEN");
        });
        
        $('#requestForQuotationClosingCloseStatusRadCLOSED').change(function(ev){
            $("#requestForQuotationClosing\\.closingStatus").val("CLOSED");
        });
        
         $('input[name="requestForQuotationClosingCloseStatusRad"][value="OPEN"]').change(function(ev){
            var value="OPEN";
            $("#requestForQuotationClosing\\.closingStatus").val(value);
        });
         $('input[name="requestForQuotationClosingCloseStatusRad"][value="CLOSED"]').change(function(ev){
            var value="CLOSED";
            $("#requestForQuotationClosing\\.closingStatus").val(value);
        });
        
         $('input[name="requestForQuotationClosingRadOrderStatus"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#requestForQuotationClosing\\.orderStatus").val(value);
        });
                
        $('input[name="requestForQuotationClosingRadOrderStatus"][value="SALES_ORDER"]').change(function(ev){
            var value="SALES_ORDER";
            $("#requestForQuotationClosing\\.orderStatus").val(value);
        });
        
        $('input[name="requestForQuotationClosingRadReviewedStatus"][value="YES"]').change(function(ev){
            var value="true";
            $("#requestForQuotationClosing\\.reviewedStatus").val(value);
        });
                
        $('input[name="requestForQuotationClosingRadReviewedStatus"][value="NO"]').change(function(ev){
            var value="false";
            $("#requestForQuotationClosing\\.reviewedStatus").val(value);
        });
        
//        --Button Save--
         $('#btnRequestForQuotationCloseSave').click(function(ev) {
             if ($("#requestForQuotationClosing\\.closingStatus").val()==="OPEN"){
                 alertMessage("Please choose one Close Status");
                 return;
             }    
              
            formatDateRequestForQuotationClose();   
            var url="sales/request-for-quotation-closing-save";
            var params = $("#frmRequestForQuotationCloseInput").serialize();
            $.post(url, params, function(data) {
                $("#dlgLoading").dialog("closing");
                if (data.error) {
                    formatDateRequestForQuotationClose(); 
                    alert(data.errorMessage);
                    return;
                }
                closingLoading();
                var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+data.message+'<br/></div>');
                dynamicDialog.dialog({
                    title           : "Confirmation:",
                    closingOnEscape   : false,
                    modal           : true,
                    width           : 400,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "OK",
                                        click : function() {
                                            $(this).dialog("closing");
                                            var url = "sales/request-for-quotation-closing";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION_CLOSING");
                                        }
                                    }]
                });
           });
        });
        
//       --Button Cancel--
        $('#btnRequestForQuotationCloseCancel').click(function(ev) {
            var url = "sales/request-for-quotation-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION_CLOSING"); 
        });
        
        $('#requestForQuotationClosing_btnReason').click(function(ev) {
            window.open("./pages/search/search-reason.jsp?iddoc=requestForQuotationClosing&idsubdoc=closingReason","Search", "width=600, height=500");
        });

        
        
    });
    
     function radioStatusClose(){
        if ($("#requestForQuotationClosing\\.orderStatus").val()==="BLANKET_ORDER"){
            $('#requestForQuotationClosingRadOrderStatusBLANKET_ORDER').prop('checked',true);
            $('#requestForQuotationClosingRadOrderStatusSALES_ORDER').attr('disabled',true);
        }
        if ($("#requestForQuotationClosing\\.orderStatus").val()==="SALES_ORDER"){
            $('#requestForQuotationClosingRadOrderStatusSALES_ORDER').prop('checked',true);
            $('#requestForQuotationClosingRadOrderStatusBLANKET_ORDER').attr('disabled',true);
        }
        if ( $("#requestForQuotationClosing\\.reviewedStatus").val()==="true"){
            $('#requestForQuotationClosingRadReviewedStatusYES').prop('checked',true);
            $('#requestForQuotationClosingRadReviewedStatusNO').attr('disabled',true);
        }
        if ( $("#requestForQuotationClosing\\.reviewedStatus").val()==="false"){
            $('#requestForQuotationClosingRadReviewedStatusNO').prop('checked',true);
            $('#requestForQuotationClosingRadReviewedStatusYES').attr('disabled',true);
        }
         
    }
</script>
<s:url id="remotedetailurlRequestForQuotationCloseDetailInput" action="" />
<b>REQUEST FOR QUOTATION CLOSED</b>
<hr>
<br class="spacer" />
<div id="requestForQuotationClosingInput" class="content ui-widget">
        <s:form id="frmRequestForQuotationCloseInput">
            <table cellpadding="2" cellspacing="2">
                <tr valign="top">
                    <td>
                        <table>
                            <tr>
                                <td align="right" hidden = "true">Rfq No
                                <s:textfield id="requestForQuotationClosing.rfqNo" name="requestForQuotationClosing.rfqNo" key="requestForQuotationClosing.rfqNo" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>RFQ No *</B></td>
                                <td><s:textfield id="requestForQuotationClosing.code" name="requestForQuotationClosing.code" key="requestForQuotationClosing.code" readonly="true" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" hidden = "true">Revision
                                <s:textfield id="requestForQuotationClosing.revision" name="requestForQuotationClosing.revision" key="requestForQuotationClosing.revision" size="25"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right">Ref RFQ No </td>
                                <td><s:textfield id="requestForQuotationClosing.refRfqCode" name="requestForQuotationClosing.refRfqCode" key="requestForQuotationClosing.refRfqCode" readonly="true" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Tender No *</B></td>
                                <td><s:textfield id="requestForQuotationClosing.tenderNo" name="requestForQuotationClosing.tenderNo" key="requestForQuotationClosing.tenderNo" readonly="true" required="true" cssClass="required" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Order Status *</B>
                                <s:textfield id="requestForQuotationClosing.orderStatus" name="requestForQuotationClosing.orderStatus" readonly="true" size="20" style="display:none"></s:textfield></td>
                                <td><s:radio id="requestForQuotationClosingRadOrderStatus" name="requestForQuotationClosingRadOrderStatus" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Branch *</B></td>
                                <td colspan="2">
                                <s:textfield id="requestForQuotationClosing.branch.code" name="requestForQuotationClosing.branch.code" size="22" readonly="true"></s:textfield>
                                <s:textfield id="requestForQuotationClosing.branch.name" name="requestForQuotationClosing.branch.name" size="40" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationClosing.transactionDate" name="requestForQuotationClosing.transactionDate" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Registered Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationClosing.registeredDate" name="requestForQuotationClosing.registeredDate" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Reviewed Status *</B>
                                <s:textfield id="requestForQuotationClosing.reviewedStatus" name="requestForQuotationClosing.reviewedStatus" readonly="true" size="20" style="display:none"></s:textfield></td>
                                <td><s:radio id="requestForQuotationClosingRadReviewedStatus" name="requestForQuotationClosingRadReviewedStatus" list="{'YES','NO'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right">Pre Bid Meeting </td>
                                <td>
                                    <sj:datepicker id="requestForQuotationClosing.preBidMeeting" name="requestForQuotationClosing.preBidMeeting" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Send to Factory Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationClosing.sendToFactoryDate" name="requestForQuotationClosing.sendToFactoryDate" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Submitted Date to Customer *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotationClosing.submittedDateToCustomer" name="requestForQuotationClosing.submittedDateToCustomer" readonly="true" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Scope of Supply</td>
                                <td colspan="3">
                                    <s:textarea id="requestForQuotationClosing.scopeOfSupply" name="requestForQuotationClosing.scopeOfSupply" readonly="true" cols="47" rows="2" height="20"></s:textarea>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>Currency *</B></td>
                                <td>
                                    <s:textfield id="requestForQuotationClosing.currency.code" name="requestForQuotationClosing.currency.code" readonly="true"  ></s:textfield>
                                        <s:textfield id="requestForQuotationClosing.currency.name" name="requestForQuotationClosing.currency.name" size="50" readonly="true" ></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Customer *</B></td>
                                <td>
                                    <s:textfield id="requestForQuotationClosing.customer.code" name="requestForQuotationClosing.customer.code" readonly="true" ></s:textfield>
                                        <s:textfield id="requestForQuotationClosing.customer.name" name="requestForQuotationClosing.customer.name" size="50" readonly="true" ></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>End User *</B></td>
                                <td colspan="2">
                                    <s:textfield id="requestForQuotationClosing.endUser.code" name="requestForQuotationClosing.endUser.code" size="20" readonly="true" ></s:textfield>
                                        <s:textfield id="requestForQuotationClosing.endUser.name" name="requestForQuotationClosing.endUser.name" size="50" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Attn </td>
                                <td><s:textfield id="requestForQuotationClosing.attn" name="requestForQuotationClosing.attn" size="27" readonly="true" ></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Sales Person *</B></td>
                                <td colspan="2">
                                <s:textfield id="requestForQuotationClosing.salesPerson.code" name="requestForQuotationClosing.salesPerson.code" size="22" readonly="true"></s:textfield>
                                <s:textfield id="requestForQuotationClosing.salesPerson.name" name="requestForQuotationClosing.salesPerson.name" size="40" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Project *</B></td>
                                <td colspan="2">
                                <s:textfield id="requestForQuotationClosing.project.code" name="requestForQuotationClosing.project.code" size="22" readonly="true"></s:textfield>
                                <s:textfield id="requestForQuotationClosing.project.name" name="requestForQuotationClosing.project.name" size="40" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="requestForQuotationClosing.refNo" name="requestForQuotationClosing.refNo" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Subject </td>
                                <td><s:textfield id="requestForQuotationClosing.subject" name="requestForQuotationClosing.subject" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" hidden="true">Valid Status 
                                <s:textfield id="requestForQuotationClosing.validStatus" name="requestForQuotationClosing.validStatus" readonly="true" size="20" value = "YES" style="display:none"></s:textfield>
                                <s:radio id="requestForQuotationClosingValidStatusRad" name="requestForQuotationClosingValidStatusRad" list="{'YES','NO'}"></s:radio></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td><s:textarea id="requestForQuotationClosing.remark" name="requestForQuotationClosing.remark"  cols="50" rows="2" height="20" readonly="true"></s:textarea></td>                  
                                <s:textfield id="requestForQuotationClosing.createdBy" name="requestForQuotationClosing.createdBy" size="52" cssStyle="display:none"></s:textfield>
                                <s:textfield id="requestForQuotationClosingTemp.createdDateTemp" name="requestForQuotationClosingTemp.createdDateTemp" size="15" cssStyle="display:none"></s:textfield>
                                <sj:datepicker id="requestForQuotationClosing.createdDate" name="requestForQuotationClosing.createdDate" required="true" cssClass="required" size="25" displayFormat="dd/mm/yy"  timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </tr>
                             <tr>
                                <td align="right" hidden="true">Close Status 
                                <s:textfield id="requestForQuotationClosing.closingStatus" name="requestForQuotationClosing.closingStatus" readonly="false" size="15" style="display:none"></s:textfield>
                                <s:radio id="requestForQuotationClosingCloseStatusRad" name="requestForQuotationClosingCloseStatusRad" list="{'OPEN','CLOSED'}"></s:radio></td>
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
                        <sj:a href="#" id="btnRequestForQuotationCloseSave" button="true">Save</sj:a>
                    </td>
                    <td>
                        <sj:a href="#" id="btnRequestForQuotationCloseCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </div>
    </div>     