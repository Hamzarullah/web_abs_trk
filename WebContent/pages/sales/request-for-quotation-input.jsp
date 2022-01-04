
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
    
    #requestForQuotationDetailInput_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
     
     var                                    
        txtRequestForQuotationCode = $("#requestForQuotation\\.code"),
        txtRequestForQuotationRFQNo = $("#requestForQuotation\\.rfqNo"),
        txtRequestForQuotationRevision = $("#requestForQuotation\\.revision"),
        txtRequestForQuotationRefRFQCode = $("#requestForQuotation\\.refRfqCode"),
        txtRequestForQuotationTenderNo = $("#requestForQuotation\\.tenderNo"),
        rdbRequestForQuotationOrderStatus = $("#requestForQuotation\\.orderStatus"),
        txtRequestForQuotationBranchCode = $("#requestForQuotation\\.branch\\.code"),
        txtRequestForQuotationBranchName = $("#requestForQuotation\\.branch\\.name"),
        dtpRequestForQuotationTransactionDate = $("#requestForQuotation\\.transactionDate"),
        dtpRequestForQuotationRegisteredDate = $("#requestForQuotation\\.registeredDate"),
        rdbRequestForQuotationReviewedStatus = $("#requestForQuotation\\.reviewedStatus"),
        dtpRequestForQuotationPreBidMeeting = $("#requestForQuotation\\.preBidMeeting"),
        dtpRequestForQuotationSendToFactoryDate = $("#requestForQuotation\\.sendToFactoryDate"),
        dtpRequestForQuotationSubmittedDate = $("#requestForQuotation\\.submittedDateToCustomer"),
        txtRequestForQuotationScopeOfSupply = $("#requestForQuotation\\.scopeOfSupply"),
        txtRequestForQuotationCurrencyCode = $("#requestForQuotation\\.currency\\.code"),
        txtRequestForQuotationCurrencyName = $("#requestForQuotation\\.currency\\.name"),
        txtRequestForQuotationCustomerCode = $("#requestForQuotation\\.customer\\.code"),
        txtRequestForQuotationCustomerName = $("#requestForQuotation\\.customer\\.name"),
        txtRequestForQuotationEndUserCode = $("#requestForQuotation\\.endUser\\.code"),
        txtRequestForQuotationEndUserName = $("#requestForQuotation\\.endUser\\.name"),
        txtRequestForQuotationAttn = $("#requestForQuotation\\.attn"),
        txtRequestForQuotationSalesPersonCode = $("#requestForQuotation\\.salesPerson\\.code"),
        txtRequestForQuotationSalesPersonName = $("#requestForQuotation\\.salesPerson\\.name"),
        txtRequestForQuotationProjectCode = $("#requestForQuotation\\.project\\.code"),
        txtRequestForQuotationProjectName = $("#requestForQuotation\\.project\\.name"),
        txtRequestForQuotationRefNo = $("#requestForQuotation\\.refNo"),
        txtRequestForQuotationRemark = $("#requestForQuotation\\.remark");
        dtpRequestForQuotationCreatedDate = $("#requestForQuotation\\.createdDate");

        allFieldsCDP = $([])
            .add(txtRequestForQuotationCode)
            .add(txtRequestForQuotationRFQNo)
            .add(txtRequestForQuotationRevision)
            .add(txtRequestForQuotationRefRFQCode)
            .add(txtRequestForQuotationTenderNo)
            .add(rdbRequestForQuotationOrderStatus)
            .add(txtRequestForQuotationBranchCode)
            .add(txtRequestForQuotationBranchName)
            .add(dtpRequestForQuotationTransactionDate)
            .add(dtpRequestForQuotationRegisteredDate)
            .add(rdbRequestForQuotationReviewedStatus)
            .add(dtpRequestForQuotationPreBidMeeting)
            .add(dtpRequestForQuotationSendToFactoryDate)
            .add(dtpRequestForQuotationSubmittedDate)
            .add(txtRequestForQuotationScopeOfSupply)
            .add(txtRequestForQuotationCurrencyCode)
            .add(txtRequestForQuotationCurrencyName)
            .add(txtRequestForQuotationCustomerCode)
            .add(txtRequestForQuotationCustomerName)
            .add(txtRequestForQuotationEndUserCode)
            .add(txtRequestForQuotationEndUserName)
            .add(txtRequestForQuotationAttn)
            .add(txtRequestForQuotationSalesPersonCode)
            .add(txtRequestForQuotationSalesPersonName)
            .add(txtRequestForQuotationProjectCode)
            .add(txtRequestForQuotationProjectName)
            .add(txtRequestForQuotationRefNo)
            .add(txtRequestForQuotationRemark)
            .add(dtpRequestForQuotationCreatedDate);
    
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
    
    function formatDateRequestForQuotation(){
        var transactionDate=formatDate(dtpRequestForQuotationTransactionDate.val());
        dtpRequestForQuotationTransactionDate.val(transactionDate);  
        
        var registeredDate=formatDate(dtpRequestForQuotationRegisteredDate.val());
        dtpRequestForQuotationRegisteredDate.val(registeredDate);
        
        if(dtpRequestForQuotationPreBidMeeting.val()!==""){
            var preBidMeetingDate=formatDate(dtpRequestForQuotationPreBidMeeting.val());
            dtpRequestForQuotationPreBidMeeting.val(preBidMeetingDate);
        }else{
            dtpRequestForQuotationPreBidMeeting.val("01/01/1900");
        }
        
        
        var sendToFactoryDate=formatDate(dtpRequestForQuotationSendToFactoryDate.val());
        dtpRequestForQuotationSendToFactoryDate.val(sendToFactoryDate);
        
        var submittedDate=formatDate(dtpRequestForQuotationSubmittedDate.val());
        dtpRequestForQuotationSubmittedDate.val(submittedDate);
        
        var createdDate = formatDate(dtpRequestForQuotationCreatedDate.val());
        dtpRequestForQuotationCreatedDate.val(createdDate);
        
    }
    
    $(document).ready(function () {
        hoverButton();
        
        $('input[name="requestForQuotationRadOrderStatus"][value="BLANKET_ORDER"]').change(function(ev){
            var value="BLANKET_ORDER";
            $("#requestForQuotation\\.orderStatus").val(value);
        });
                
        $('input[name="requestForQuotationRadOrderStatus"][value="SALES_ORDER"]').change(function(ev){
            var value="SALES_ORDER";
            $("#requestForQuotation\\.orderStatus").val(value);
        });
        
        $('input[name="requestForQuotationRadReviewedStatus"][value="YES"]').change(function(ev){
            var value="true";
            $("#requestForQuotation\\.reviewedStatus").val(value);
        });
                
        $('input[name="requestForQuotationRadReviewedStatus"][value="NO"]').change(function(ev){
            var value="false";
            $("#requestForQuotation\\.reviewedStatus").val(value);
        });
        
        $('input[name="requestForQuotation\\.validStatus"][value="YES"]').change(function(ev){
            var value="true";
            $("#requestForQuotation\\.validStatus").val(value);
        });
                
        $('input[name="requestForQuotation\\.validStatus"][value="NO"]').change(function(ev){
            var value="false";
            $("#requestForQuotation\\.validStatus").val(value);
        });
        
        if ($("#requestForQuotationUpdateMode").val()==="true"){
            orderStatus();
        }else if ($("#requestForQuotationCloneMode").val()==="true"){
            orderStatus();
        }else if ($("#requestForQuotationReviseMode").val()==="true"){
            orderStatus();
        }else{
        $('#requestForQuotationRadOrderStatusSALES_ORDER').prop('checked',true);
        $("#requestForQuotation\\.orderStatus").val("SALES_ORDER");
        $('#requestForQuotationRadReviewedStatusYES').prop('checked',true);
        $("#requestForQuotation\\.reviewedStatus").val("false");
        $("#requestForQuotation\\.preBidMeeting").val('');
        }
        //        --Button Save--
         $('#btnRequestForQuotationSave').click(function(ev) {
            
            if(txtRequestForQuotationTenderNo.val()===""){
                alertMessageRFQ("Tender Number Cannot Empty!",txtRequestForQuotationTenderNo);
                return;
            }
            if(txtRequestForQuotationCustomerName.val()===""){
                alertMessageRFQ("Customer Cannot Empty!",txtRequestForQuotationCustomerName);
                return;
            }
            if(txtRequestForQuotationCurrencyName.val()===""){
                alertMessageRFQ("Currency Cannot Empty!",txtRequestForQuotationCurrencyName);
                return;
            }
            if(txtRequestForQuotationScopeOfSupply.val()===""){
                alertMessageRFQ("ScopeOfSupply Cannot Empty!",txtRequestForQuotationScopeOfSupply);
                return;
            }
            if(txtRequestForQuotationEndUserName.val()===""){
                alertMessageRFQ("End User Cannot Empty!",txtRequestForQuotationEndUserName);
                return;
            }
            if(txtRequestForQuotationAttn.val()===""){
                alertMessageRFQ("Attn Cannot Empty!",txtRequestForQuotationAttn);
                return;
            }
            if(txtRequestForQuotationSalesPersonName.val()===""){
                alertMessageRFQ("Sales Person Cannot Empty!",txtRequestForQuotationSalesPersonName);
                return;
            }
            
            var date1 = dtpRequestForQuotationTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#requestForQuotationTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#requestForQuotationUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#requestForQuotationTransactionDate").val(),dtpRequestForQuotationTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpRequestForQuotationTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#requestForQuotationUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#requestForQuotationTransactionDate").val(),dtpRequestForQuotationTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpRequestForQuotationTransactionDate);
                }
                return;
            }
                    
//              --Revise--
                if($("#requestForQuotationReviseMode").val()==="true"){
                        
                    formatDateRequestForQuotation();   
                    var url="sales/request-for-quotation-save-revise";
                    var params = $("#frmRequestForQuotationInput").serialize();
                    $.post(url, params, function(data) {
                        $("#dlgLoading").dialog("close");
                        if (data.error) {
                            formatDateRequestForQuotation(); 
                            alert(data.errorMessage);
                            return;
                        }
                        closeLoading();
                        var dynamicDialog= $('<div id="conformBox">'+
                                            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                            '</span>'+data.message+'<br/>Do You Want Input Other One?</div>');

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
                                        var url = "sales/request-for-quotation-input";
                                        var param = "";
                                        pageLoad(url, param, "#tabmnuREQUEST_FOR_QUOTATION");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        var url = "sales/request-for-quotation";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION");
                                    }
                                }]
                        });
                    });
                }
                else if($("#requestForQuotationUpdateMode").val()==="true"){
                    formatDateRequestForQuotation();   
                    var url="sales/request-for-quotation-update";
                    var params = $("#frmRequestForQuotationInput").serialize();
                    $.post(url, params, function(data) {
                        $("#dlgLoading").dialog("close");
                        if (data.error) {
                            formatDateRequestForQuotation(); 
                            alert(data.errorMessage);
                            return;
                        }
                        
                        closeLoading();
                        var dynamicDialog= $('<div id="conformBox">'+
                                            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                            '</span>'+data.message+'<br/>Do You Want Input Other One?</div>');

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
                                        var url = "sales/request-for-quotation-input";
                                        var param = "";
                                        pageLoad(url, param, "#tabmnuREQUEST_FOR_QUOTATION");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        var url = "sales/request-for-quotation";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION");
                                    }
                                }]
                        });
                    });
                }else{
                    formatDateRequestForQuotation();   
                    var url="sales/request-for-quotation-save";
                    var params = $("#frmRequestForQuotationInput").serialize();
                    $.post(url, params, function(data) {
                        $("#dlgLoading").dialog("close");
                        if (data.error) {
                            formatDateRequestForQuotation(); 
                            alert(data.errorMessage);
                            return;
                        }
                        if(data.errorMessage){
                        alertMessage(data.errorMessage);
                        return;
                        }
                        closeLoading();
                        var dynamicDialog= $('<div id="conformBox">'+
                                            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                            '</span>'+data.message+'<br/>Do You Want Input Other One?</div>');

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
                                        var url = "sales/request-for-quotation-input";
                                        var param = "";
                                        pageLoad(url, param, "#tabmnuREQUEST_FOR_QUOTATION");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        var url = "sales/request-for-quotation";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION");
                                    }
                                }]
                        });
                    });
                }
        });
        
//       --Button Cancel--
        $('#btnRequestForQuotationCancel').click(function(ev) {
            var url = "sales/request-for-quotation";
            var params = "";
            pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION"); 
        });
        
         $('#requestForQuotation_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=requestForQuotation&idsubdoc=branch","Search", "width=600, height=500");
        });
         $('#requestForQuotation_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=requestForQuotation&idsubdoc=currency","Search", "width=600, height=500");
        });
         $('#requestForQuotation_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer-rfq.jsp?iddoc=requestForQuotation&idsubdoc=customer","Search", "width=600, height=500");
        });
         $('#requestForQuotation_btnEndUser').click(function(ev) {
            window.open("./pages/search/search-customer-end-user.jsp?iddoc=requestForQuotation&idsubdoc=endUser","Search", "width=600, height=500");
        });
         $('#requestForQuotation_btnSalesPerson').click(function(ev) {
            window.open("./pages/search/search-sales-person.jsp?iddoc=requestForQuotation&idsubdoc=salesPerson","Search", "width=600, height=500");
        });
         $('#requestForQuotation_btnProject').click(function(ev) {
            window.open("./pages/search/search-project.jsp?iddoc=requestForQuotation&idsubdoc=project","Search", "width=600, height=500");
        });
        
    });
    
    function orderStatus(){
        if ( $("#requestForQuotation\\.orderStatus").val()==="BLANKET_ORDER"){
            $('#requestForQuotationRadOrderStatusBLANKET_ORDER').prop('checked',true);
        }
        if ( $("#requestForQuotation\\.orderStatus").val()==="SALES_ORDER"){
            $('#requestForQuotationRadOrderStatusSALES_ORDER').prop('checked',true);
        }
        if ( $("#requestForQuotation\\.reviewedStatus").val()==="true"){
            $('#requestForQuotationRadReviewedStatusYES').prop('checked',true);
        }
        if ( $("#requestForQuotation\\.reviewedStatus").val()==="false"){
            $('#requestForQuotationRadReviewedStatusNO').prop('checked',true);
        }  
    }
    
    function requestForQuotationTransactionDateOnChange(){
        if($("#requestForQuotationUpdateMode").val()!=="true"){
            $("#requestForQuotationTransactionDate").val(dtpRequestForQuotationTransactionDate.val());
        }
        if($("#requestForQuotationCloneMode").val()!=="true"){
            $("#requestForQuotationTransactionDate").val(dtpRequestForQuotationTransactionDate.val());
        }
        if($("#requestForQuotationReviseMode").val()!=="true"){
            $("#requestForQuotationTransactionDate").val(dtpRequestForQuotationTransactionDate.val());
        }
    }
</script>
<s:url id="remotedetailurlRequestForQuotationDetailInput" action="" />
<b>REQUEST FOR QUOTATION</b>
<hr>
<br class="spacer" />
<div id="requestForQuotationInput" class="content ui-widget">
        <s:form id="frmRequestForQuotationInput">
            <table cellpadding="2" cellspacing="2">
                <tr valign="top">
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>RFQ No *</B></td>
                                <td><s:textfield id="requestForQuotation.code" name="requestForQuotation.code" key="requestForQuotation.code" readonly="true" size="25"></s:textfield></td>
                                <td><s:textfield id="requestForQuotationUpdateMode" name="requestForQuotationUpdateMode" size="20" cssStyle="display:none"></s:textfield></td>
                                <td><s:textfield id="requestForQuotationCloneMode" name="requestForQuotationCloneMode" size="20" cssStyle="display:none"></s:textfield></td>
                                <td><s:textfield id="requestForQuotationReviseMode" name="requestForQuotationReviseMode" size="20" cssStyle="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" hidden="true"> Rfq No
                                <s:textfield id="requestForQuotation.rfqNo" name="requestForQuotation.rfqNo" key="requestForQuotation.rfqNo" size="25"></s:textfield>
                                <s:textfield id="requestForQuotationUpdateMode" name="requestForQuotationUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                                <s:textfield id="requestForQuotationCloneMode" name="requestForQuotationCloneMode" size="20" cssStyle="display:none"></s:textfield>
                                <s:textfield id="requestForQuotationReviseMode" name="requestForQuotationReviseMode" size="20" cssStyle="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" hidden="true"> Revision
                                <s:textfield id="requestForQuotation.revision" name="requestForQuotation.revision" key="requestForQuotation.revision" size="25"></s:textfield>
                                <s:textfield id="requestForQuotationUpdateMode" name="requestForQuotationUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                                <s:textfield id="requestForQuotationCloneMode" name="requestForQuotationCloneMode" size="20" cssStyle="display:none"></s:textfield>
                                <s:textfield id="requestForQuotationReviseMode" name="requestForQuotationReviseMode" size="20" cssStyle="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Ref RFQ No </td>
                                <td><s:textfield id="requestForQuotation.refRfqCode" name="requestForQuotation.refRfqCode" key="requestForQuotation.refRfqCode" readonly="true" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Tender No *</B></td>
                                <td><s:textfield id="requestForQuotation.tenderNo" name="requestForQuotation.tenderNo" key="requestForQuotation.tenderNo" required="true" cssClass="required" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Order Status *</B>
                                <s:textfield id="requestForQuotation.orderStatus" name="requestForQuotation.orderStatus" readonly="false" size="20" style="display:none"></s:textfield></td>
                                <td><s:radio id="requestForQuotationRadOrderStatus" name="requestForQuotationRadOrderStatus" list="{'BLANKET_ORDER','SALES_ORDER'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right" style="width:180px"><B>Branch *</B></td>
                                <td colspan="2">
                                <script type = "text/javascript">

                                    txtRequestForQuotationBranchCode.change(function(ev) {

                                        if(txtRequestForQuotationBranchCode.val()===""){
                                            txtRequestForQuotationBranchName.val("");
                                            return;
                                        }
                                        var url = "master/branch-get";
                                        var params = "branch.code=" + txtRequestForQuotationBranchCode.val();
                                            params += "&branch.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.branchTemp){
                                                txtRequestForQuotationBranchCode.val(data.branchTemp.code);
                                                txtRequestForQuotationBranchName.val(data.branchTemp.name);
                                            }
                                            else{
                                                alertMessage("Branch Not Found!",txtRequestForQuotationBranchCode);
                                                txtRequestForQuotationBranchCode.val("");
                                                txtRequestForQuotationBranchName.val("");
                                            }
                                        });
                                    });
                                    if($("#requestForQuotationUpdateMode").val()==="true"){
                                            txtRequestForQuotationBranchCode.after(function(ev) {
                                              var url = "master/branch-get";
                                              var params = "branch.code=" + txtRequestForQuotationBranchCode.val();
                                              params += "&branch.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.branchTemp){
                                                        txtRequestForQuotationBranchCode.val(data.branchTemp.code);
                                                        txtRequestForQuotationBranchName.val(data.branchTemp.name);
                                                    }
                                                });
                                            });
                                        }else if($("#requestForQuotationCloneMode").val()==="true"){
                                            txtRequestForQuotationBranchCode.after(function(ev) {
                                              var url = "master/branch-get";
                                              var params = "branch.code=" + txtRequestForQuotationBranchCode.val();
                                              params += "&branch.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.branchTemp){
                                                        txtRequestForQuotationBranchCode.val(data.branchTemp.code);
                                                        txtRequestForQuotationBranchName.val(data.branchTemp.name);
                                                    }
                                                });
                                            });
                                        }else{
                                            txtRequestForQuotationBranchCode.after(function(ev) {
                                              var url = "master/branch-get";
                                              var params = "branch.code=" + txtRequestForQuotationBranchCode.val();
                                              params += "&branch.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.branchTemp){
                                                        txtRequestForQuotationBranchCode.val(data.branchTemp.code);
                                                        txtRequestForQuotationBranchName.val(data.branchTemp.name);
                                                    }
                                                });
                                            });
                                        }
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="requestForQuotation.branch.code" name="requestForQuotation.branch.code" size="20"></s:textfield>
                                    <sj:a id="requestForQuotation_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="requestForQuotation.branch.name" name="requestForQuotation.branch.name" size="25" readonly="true"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotation.transactionDate" name="requestForQuotation.transactionDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" onchange="requestForQuotationTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                                    <sj:datepicker id="requestForQuotationTransactionDate" name="requestForQuotationTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" cssStyle="display:none"></sj:datepicker>
                                    <s:textfield id="requestForQuotationTemp.transactionDateTemp" name="requestForQuotationTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Registered Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotation.registeredDate" name="requestForQuotation.registeredDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Reviewed Status *</B>
                                <s:textfield id="requestForQuotation.reviewedStatus" name="requestForQuotation.reviewedStatus" readonly="false" size="20" style="display:none"></s:textfield></td>
                                <td><s:radio id="requestForQuotationRadReviewedStatus" name="requestForQuotationRadReviewedStatus" list="{'YES','NO'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right">Pre Bid Meeting </td>
                                <td>
                                    <sj:datepicker id="requestForQuotation.preBidMeeting" name="requestForQuotation.preBidMeeting" displayFormat="dd/mm/yy" size="25" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Send to Factory Date *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotation.sendToFactoryDate" name="requestForQuotation.sendToFactoryDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Submitted Date to Customer *</B></td>
                                <td>
                                    <sj:datepicker id="requestForQuotation.submittedDateToCustomer" name="requestForQuotation.submittedDateToCustomer" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top"><B>Scope of Supply *</td>
                                <td colspan="3">
                                    <s:textarea id="requestForQuotation.scopeOfSupply" name="requestForQuotation.scopeOfSupply" cols="50" rows="2" height="20"></s:textarea>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>Currency *</B></td>
                                <td>
                                    <script type = "text/javascript"> 
                                            txtRequestForQuotationCurrencyCode.change(function(ev) {
                                            if(txtRequestForQuotationCurrencyCode.val()===""){
                                                txtRequestForQuotationCurrencyCode.val("");
                                                txtRequestForQuotationCurrencyName.val("");
                                                return;
                                            }
                                            var url = "master/currency-get";
                                            var params = "currency.code=" + txtRequestForQuotationCurrencyCode.val();
                                            params += "&currency.activeStatus=TRUE";
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.currencyTemp){
                                                    txtRequestForQuotationCurrencyCode.val(data.currencyTemp.code);
                                                    txtRequestForQuotationCurrencyName.val(data.currencyTemp.name);
                                                    getExchangeRateBICDP();
                                                }else{
                                                    alertMessage("Currency Not Found!",txtRequestForQuotationCurrencyCode);
                                                    txtRequestForQuotationCurrencyCode.val("");
                                                    txtRequestForQuotationCurrencyName.val("");
                                                }
                                            });
                                        });
                                        if($("#requestForQuotationUpdateMode").val()==="true"){
                                            txtRequestForQuotationCurrencyCode.after(function(ev) {
                                                var url = "master/currency-get";
                                                var params = "currency.code=" + txtRequestForQuotationCurrencyCode.val();
                                                params += "&currency.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.currencyTemp){
                                                        txtRequestForQuotationCurrencyCode.val(data.currencyTemp.code);
                                                        txtRequestForQuotationCurrencyName.val(data.currencyTemp.name);
                                                    }
                                                });
                                                if($("#requestForQuotation\\.preBidMeeting").val()==="01/01/1900"){
                                                    $("#requestForQuotation\\.preBidMeeting").val("");
                                                }
                                            });
                                        }else if($("#requestForQuotationCloneMode").val()==="true"){
                                            txtRequestForQuotationCurrencyCode.after(function(ev) {
                                                var url = "master/currency-get";
                                                var params = "currency.code=" + txtRequestForQuotationCurrencyCode.val();
                                                params += "&currency.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.currencyTemp){
                                                        txtRequestForQuotationCurrencyCode.val(data.currencyTemp.code);
                                                        txtRequestForQuotationCurrencyName.val(data.currencyTemp.name);
                                                    }
                                                });
                                                if($("#requestForQuotation\\.preBidMeeting").val()==="01/01/1900"){
                                                    $("#requestForQuotation\\.preBidMeeting").val("");
                                                }
                                            });
                                        }else{
                                            txtRequestForQuotationCurrencyCode.after(function(ev) {
                                                var url = "master/currency-get";
                                                var params = "currency.code=" + txtRequestForQuotationCurrencyCode.val();
                                                params += "&currency.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.currencyTemp){
                                                        txtRequestForQuotationCurrencyCode.val(data.currencyTemp.code);
                                                        txtRequestForQuotationCurrencyName.val(data.currencyTemp.name);
                                                    }
                                                });
                                                if($("#requestForQuotation\\.preBidMeeting").val()==="01/01/1900"){
                                                    $("#requestForQuotation\\.preBidMeeting").val("");
                                                }
                                            });
                                        }
                                    </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="requestForQuotation.currency.code" name="requestForQuotation.currency.code" size="20"></s:textfield>
                                        <sj:a id="requestForQuotation_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                        <s:textfield id="requestForQuotation.currency.name" name="requestForQuotation.currency.name" size="25" readonly="true" ></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Customer *</B></td>
                                <td>
                                    <script type = "text/javascript"> 
                                            txtRequestForQuotationCustomerCode.change(function(ev) {
                                            if(txtRequestForQuotationCustomerCode.val()===""){
                                                txtRequestForQuotationCustomerCode.val("");
                                                txtRequestForQuotationCustomerName.val("");
                                                return;
                                            }
                                            var url = "master/customer-get";
                                            var params = "customer.code=" + txtRequestForQuotationCustomerCode.val();
                                            params += "&customer.activeStatus=TRUE";
                                            params += "&customer.customerStatus=TRUE";
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.customerTemp){
                                                    txtRequestForQuotationCustomerCode.val(data.customerTemp.code);
                                                    txtRequestForQuotationCustomerName.val(data.customerTemp.name);
                                                }else{
                                                    alertMessage("Customer Not Found!",txtRequestForQuotationCustomerCode);
                                                    txtRequestForQuotationCustomerCode.val("");
                                                    txtRequestForQuotationCustomerName.val("");
                                                }
                                            });
                                        });
                                        if($("#requestForQuotationUpdateMode").val()==="true"){
                                            txtRequestForQuotationCustomerCode.after(function(ev) {
                                                var url = "master/customer-get";
                                                var params = "customer.code=" + txtRequestForQuotationCustomerCode.val();
                                                params += "&customer.activeStatus=TRUE";
                                                params += "&customer.customerStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.customerTemp){
                                                        txtRequestForQuotationCustomerCode.val(data.customerTemp.code);
                                                        txtRequestForQuotationCustomerName.val(data.customerTemp.name);
                                                    }
                                                });
                                            });
                                        }else if($("#requestForQuotationCloneMode").val()==="true"){
                                            txtRequestForQuotationCustomerCode.after(function(ev) {
                                                var url = "master/customer-get";
                                                var params = "customer.code=" + txtRequestForQuotationCustomerCode.val();
                                                params += "&customer.activeStatus=TRUE";
                                                params += "&customer.customerStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.customerTemp){
                                                        txtRequestForQuotationCustomerCode.val(data.customerTemp.code);
                                                        txtRequestForQuotationCustomerName.val(data.customerTemp.name);
                                                    }
                                                });
                                            });
                                        }else{
                                            txtRequestForQuotationCustomerCode.after(function(ev) {
                                                var url = "master/customer-get";
                                                var params = "customer.code=" + txtRequestForQuotationCustomerCode.val();
                                                params += "&customer.activeStatus=TRUE";
                                                params += "&customer.customerStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.customerTemp){
                                                        txtRequestForQuotationCustomerCode.val(data.customerTemp.code);
                                                        txtRequestForQuotationCustomerName.val(data.customerTemp.name);
                                                    }
                                                });
                                            });
                                        }
                                    </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="requestForQuotation.customer.code" name="requestForQuotation.customer.code" size="20"></s:textfield>
                                        <sj:a id="requestForQuotation_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                        <s:textfield id="requestForQuotation.customer.name" name="requestForQuotation.customer.name" size="25" readonly="true" ></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>End User *</B></td>
                                <td colspan="2">
                                    <script type = "text/javascript">
                                        txtRequestForQuotationEndUserCode.change(function(ev) {
                                            if(txtRequestForQuotationEndUserCode.val()===""){
                                                txtRequestForQuotationEndUserCode.val("");
                                                txtRequestForQuotationEndUserName.val("");
                                                return;
                                            }
                                            var url = "master/customer-get";
                                            var params = "customer.code=" + txtRequestForQuotationEndUserCode.val();
                                            params += "&customer.activeStatus=TRUE";
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.customerTemp){
                                                    txtRequestForQuotationEndUserCode.val(data.customerTemp.code);
                                                    txtRequestForQuotationEndUserName.val(data.customerTemp.name);
                                                }
                                                else{
                                                    alertMessage("End User Not Found!",txtRequestForQuotationEndUserCode);
                                                    txtRequestForQuotationEndUserCode.val("");
                                                    txtRequestForQuotationEndUserName.val("");
                                                }
                                            });
                                        });
                                        if($("#requestForQuotationUpdateMode").val()==="true"){
                                            txtRequestForQuotationEndUserCode.after(function(ev) {
                                                var url = "master/customer-get";
                                                var params = "customer.code=" + txtRequestForQuotationEndUserCode.val();
                                                params += "&customer.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.customerTemp){
                                                        txtRequestForQuotationEndUserCode.val(data.customerTemp.code);
                                                        txtRequestForQuotationEndUserName.val(data.customerTemp.name);
                                                    }
                                                });
                                            });
                                        }else if($("#requestForQuotationCloneMode").val()==="true"){
                                            txtRequestForQuotationEndUserCode.after(function(ev) {
                                                var url = "master/customer-get";
                                                var params = "customer.code=" + txtRequestForQuotationEndUserCode.val();
                                                params += "&customer.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.customerTemp){
                                                        txtRequestForQuotationEndUserCode.val(data.customerTemp.code);
                                                        txtRequestForQuotationEndUserName.val(data.customerTemp.name);
                                                    }
                                                });
                                            });
                                        }else{
                                            txtRequestForQuotationEndUserCode.after(function(ev) {
                                                var url = "master/customer-get";
                                                var params = "customer.code=" + txtRequestForQuotationEndUserCode.val();
                                                params += "&customer.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.customerTemp){
                                                        txtRequestForQuotationEndUserCode.val(data.customerTemp.code);
                                                        txtRequestForQuotationEndUserName.val(data.customerTemp.name);
                                                    }
                                                });
                                            });
                                        }
                                    </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="requestForQuotation.endUser.code" name="requestForQuotation.endUser.code" size="20"></s:textfield>
                                    <sj:a id="requestForQuotation_btnEndUser" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                                        <s:textfield id="requestForQuotation.endUser.name" name="requestForQuotation.endUser.name" size="25" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Attn *</td>
                                <td><s:textfield id="requestForQuotation.attn" name="requestForQuotation.attn" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Sales Person *</B></td>
                                <td colspan="2">
                                <script type = "text/javascript">

                                    txtRequestForQuotationSalesPersonCode.change(function(ev) {

                                        if(txtRequestForQuotationSalesPersonCode.val()===""){
                                            txtRequestForQuotationSalesPersonCode.val("");
                                            txtRequestForQuotationSalesPersonName.val("");
                                            return;
                                        }
                                        var url = "master/sales-person-get";
                                        var params = "salesPerson.code=" + txtRequestForQuotationSalesPersonCode.val();
                                            params += "&salesPerson.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.salesPersonTemp){
                                                txtRequestForQuotationSalesPersonCode.val(data.salesPersonTemp.code);
                                                txtRequestForQuotationSalesPersonName.val(data.salesPersonTemp.name);
                                            }
                                            else{
                                                alertMessage("Sales Person Not Found!",txtRequestForQuotationSalesPersonCode);
                                                txtRequestForQuotationSalesPersonCode.val("");
                                                txtRequestForQuotationSalesPersonName.val("");
                                            }
                                        });
                                    });
                                    if($("#requestForQuotationUpdateMode").val()==="true"){
                                            txtRequestForQuotationSalesPersonCode.after(function(ev) {
                                              var url = "master/sales-person-get";
                                              var params = "salesPerson.code=" + txtRequestForQuotationSalesPersonCode.val();
                                              params += "&salesPerson.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.salesPersonTemp){
                                                        txtRequestForQuotationSalesPersonCode.val(data.salesPersonTemp.code);
                                                        txtRequestForQuotationSalesPersonName.val(data.salesPersonTemp.name);
                                                    }
                                                });
                                            });
                                        }else if($("#requestForQuotationCloneMode").val()==="true"){
                                            txtRequestForQuotationSalesPersonCode.after(function(ev) {
                                              var url = "master/sales-person-get";
                                              var params = "salesPerson.code=" + txtRequestForQuotationSalesPersonCode.val();
                                              params += "&salesPerson.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.salesPersonTemp){
                                                        txtRequestForQuotationSalesPersonCode.val(data.salesPersonTemp.code);
                                                        txtRequestForQuotationSalesPersonName.val(data.salesPersonTemp.name);
                                                    }
                                                });
                                            });
                                        }else{
                                             txtRequestForQuotationSalesPersonCode.after(function(ev) {
                                              var url = "master/sales-person-get";
                                              var params = "salesPerson.code=" + txtRequestForQuotationSalesPersonCode.val();
                                              params += "&salesPerson.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.salesPersonTemp){
                                                        txtRequestForQuotationSalesPersonCode.val(data.salesPersonTemp.code);
                                                        txtRequestForQuotationSalesPersonName.val(data.salesPersonTemp.name);
                                                    }
                                                });
                                            });
                                        }
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="requestForQuotation.salesPerson.code" name="requestForQuotation.salesPerson.code" size="20"></s:textfield>
                                    <sj:a id="requestForQuotation_btnSalesPerson" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="requestForQuotation.salesPerson.name" name="requestForQuotation.salesPerson.name" size="25" readonly="true"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px">Project </td>
                                <td colspan="2">
                                <script type = "text/javascript">

                                    txtRequestForQuotationProjectCode.change(function(ev) {

                                        if(txtRequestForQuotationProjectCode.val()===""){
                                            txtRequestForQuotationProjectCode.val("");
                                            txtRequestForQuotationProjectName.val("");
                                            return;
                                        }
                                        var url = "master/project-get";
                                        var params = "project.code=" + txtRequestForQuotationProjectCode.val();
                                            params += "&project.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.projectTemp){
                                                txtRequestForQuotationProjectCode.val(data.projectTemp.code);
                                                txtRequestForQuotationProjectName.val(data.projectTemp.name);
                                            }
                                            else{
                                                alertMessage("Project Not Found!",txtRequestForQuotationProjectCode);
                                                txtRequestForQuotationProjectCode.val("");
                                                txtRequestForQuotationProjectName.val("");
                                            }
                                        });
                                    });
                                    if($("#requestForQuotationUpdateMode").val()==="true"){
                                            txtRequestForQuotationProjectCode.after(function(ev) {
                                              var url = "master/project-get";
                                              var params = "project.code=" + txtRequestForQuotationProjectCode.val();
                                              params += "&project.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.projectTemp){
                                                        txtRequestForQuotationProjectCode.val(data.projectTemp.code);
                                                        txtRequestForQuotationProjectName.val(data.projectTemp.name);
                                                    }
                                                });
                                            });
                                        }else if($("#requestForQuotationCloneMode").val()==="true"){
                                            txtRequestForQuotationProjectCode.after(function(ev) {
                                              var url = "master/project-get";
                                              var params = "project.code=" + txtRequestForQuotationProjectCode.val();
                                              params += "&project.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.projectTemp){
                                                        txtRequestForQuotationProjectCode.val(data.projectTemp.code);
                                                        txtRequestForQuotationProjectName.val(data.projectTemp.name);
                                                    }
                                                });
                                            });
                                        }else{
                                            txtRequestForQuotationProjectCode.after(function(ev) {
                                              var url = "master/project-get";
                                              var params = "project.code=" + txtRequestForQuotationProjectCode.val();
                                              params += "&project.activeStatus=TRUE";
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                                    if (data.projectTemp){
                                                        txtRequestForQuotationProjectCode.val(data.projectTemp.code);
                                                        txtRequestForQuotationProjectName.val(data.projectTemp.name);
                                                    }
                                                });
                                            });
                                        }
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="requestForQuotation.project.code" name="requestForQuotation.project.code" size="20"></s:textfield>
                                    <sj:a id="requestForQuotation_btnProject" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="requestForQuotation.project.name" name="requestForQuotation.project.name" size="25" readonly="true"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="requestForQuotation.refNo" name="requestForQuotation.refNo" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Subject </td>
                                <td><s:textfield id="requestForQuotation.subject" name="requestForQuotation.subject" size="25"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" hidden="true">Valid Status 
                                <s:textfield id="requestForQuotation.validStatus" name="requestForQuotation.validStatus" readonly="false" size="20" value = "YES" style="display:none"></s:textfield>
                                <s:radio id="requestForQuotationValidStatusRad" name="requestForQuotationValidStatusRad" list="{'YES','NO'}"></s:radio></td>
                            </tr>
                            <tr>
                                <td align="right" hidden="true">Approval Status 
                                <s:textfield id="requestForQuotation.approvalStatus" name="requestForQuotation.approvalStatus" readonly="false" size="20" value = "PENDING" style="display:none"></s:textfield>
                                <s:radio id="requestForQuotationApprovalStatusRad" name="requestForQuotationApprovalStatusRad" list="{'PENDING','APPROVED','DECLINED'}"></s:radio></td>
                            </tr>
                            <tr>
                                <td align="right" hidden="true">Closing Status 
                                <s:textfield id="requestForQuotation.closingStatus" name="requestForQuotation.closingStatus" readonly="false" size="20" value = "OPEN" style="display:none"></s:textfield>
                                <s:radio id="requestForQuotationClosingStatusRad" name="requestForQuotationClosingStatusRad" list="{'OPEN','CLOSED'}"></s:radio></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td><s:textarea id="requestForQuotation.remark" name="requestForQuotation.remark"  cols="50" rows="2" height="20"></s:textarea></td>                  
                                <s:textfield id="requestForQuotation.createdBy" name="requestForQuotation.createdBy" size="52" cssStyle="display:none"></s:textfield>
                                <s:textfield id="requestForQuotationTemp.createdDateTemp" name="requestForQuotationTemp.createdDateTemp" size="15" cssStyle="display:none"></s:textfield>
                                <sj:datepicker id="requestForQuotation.createdDate" name="requestForQuotation.createdDate" required="true" cssClass="required" size="25" displayFormat="dd/mm/yy"  timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </tr> 
                        </table>
                    </td>
                </tr>
            </table>                   
        </s:form>     
        <div>
            <table>
                <tr>
                    <td width="180px"></td>
                    <td>
                        <sj:a href="#" id="btnRequestForQuotationSave" button="true">Save</sj:a>
                    </td>
                    <td>
                        <sj:a href="#" id="btnRequestForQuotationCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </div>
    </div>     