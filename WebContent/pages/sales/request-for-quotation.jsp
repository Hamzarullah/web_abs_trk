
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
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">


    $(document).ready(function () {
        hoverButton();

        $('#requestForQuotationSearchValidStatusRadYES').prop('checked',true);
            $("#requestForQuotationSearchValidStatus").val("true");
        
        $('input[name="requestForQuotationSearchValidStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#requestForQuotationSearchValidStatus").val(value);
        });
        
        $('input[name="requestForQuotationSearchValidStatusRad"][value="YES"]').change(function(ev){
            var value="true";
            $("#requestForQuotationSearchValidStatus").val(value);
        });
                
        $('input[name="requestForQuotationSearchValidStatusRad"][value="NO"]').change(function(ev){
            var value="false";
            $("#requestForQuotationSearchValidStatus").val(value);
        });
        
        $('#requestForQuotationSearchApprovalStatusRadPENDING').prop('checked',true);
            $("#requestForQuotationSearchApprovalStatus").val("PENDING");
            
        $('input[name="requestForQuotationSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#requestForQuotationSearchApprovalStatus").val("PENDING");
        });
        
        $('input[name="requestForQuotationSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#requestForQuotationSearchApprovalStatus").val("APPROVED");
        });
        
        $('input[name="requestForQuotationSearchApprovalStatusRad"][value="DECLINED"]').change(function(ev){
            $("#requestForQuotationSearchApprovalStatus").val("DECLINE");
        });
        
        $('input[name="requestForQuotationSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#requestForQuotationSearchApprovalStatus").val("");
        });
        
        $("#btnRequestForQuotationNew").click(function (ev) {
           
            var url = "sales/request-for-quotation-input";
            var param = "";

            pageLoad(url, param, "#tabmnuREQUEST_FOR_QUOTATION");
            ev.preventDefault();    
        });

        $("#btnRequestForQuotationUpdate").click(function (ev) {
            
            var selectRowId = $("#requestForQuotation_grid").jqGrid('getGridParam','selrow');
            var requestForQuotation = $("#requestForQuotation_grid").jqGrid("getRowData", selectRowId);
            var rfqNo = requestForQuotation.code;
            
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            if(requestForQuotation.validStatus==="NO"){
                alertMessage("Can't Update");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'APPROVED'){
                alertMessage("It's already approved");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'DECLINED'){
                alertMessage("It's already rejected");
                return;
            }
            
            
            var url = "sales/request-for-quotation-check";
            var params = "requestForQuotation.code=" + rfqNo;

            $.post(url, params, function(result) {
                var data = (result);
                
                if (data.requestForQuotationTemp !== null){
                    var rfq = data.requestForQuotationTemp.code;
                    alertMessage("Cannot be updated RFQ" + " (" + rfq + ") " + "It has been used on Sales Quotation !!!");
                    return;
                }
                
                var url="sales/request-for-quotation-authority";
                var params="actionAuthority=UPDATE";
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage(data.errorMessage,"",400);
                        return;
                    }
                    var url = "sales/request-for-quotation-input";
                    var params = "requestForQuotationUpdateMode=true" + "&requestForQuotation.code=" + rfqNo;
                    pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION");

                });
                    
                ev.preventDefault();
        });
       
    });
        
        $("#btnRequestForQuotationClone").click(function (ev) {
            
            var selectRowId = $("#requestForQuotation_grid").jqGrid('getGridParam','selrow');
            var requestForQuotation = $("#requestForQuotation_grid").jqGrid("getRowData", selectRowId);
            var rfqNo = requestForQuotation.code;
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(requestForQuotation.validStatus==="NO"){
                alertMessage("Can't Clone");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'APPROVED'){
                alertMessage("It's already approved");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'DECLINED'){
                alertMessage("It's already rejected");
                return;
            }
                       
            var url="sales/request-for-quotation-authority";
            var params="actionAuthority=INSERT";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage,"",400);
                    return;
                }
                var url = "sales/request-for-quotation-input";
                var params = "requestForQuotationCloneMode=true" + "&requestForQuotation.code=" + rfqNo;
                pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION");

            });
            ev.preventDefault();
    
        });
        
        $("#btnRequestForQuotationRevise").click(function (ev) {
            
            var selectRowId = $("#requestForQuotation_grid").jqGrid('getGridParam','selrow');
            var requestForQuotation = $("#requestForQuotation_grid").jqGrid("getRowData", selectRowId);
            var rfqNo = requestForQuotation.code;
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(requestForQuotation.validStatus==="NO"){
                alertMessage("Can't Revise");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'APPROVED'){
                alertMessage("It's already approved");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'DECLINED'){
                alertMessage("It's already rejected");
                return;
            }
            
            var url="sales/request-for-quotation-authority";
            var params="actionAuthority=INSERT";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage,"",400);
                    return;
                }
                var url = "sales/request-for-quotation-input";
                var params = "requestForQuotationReviseMode=true" + "&requestForQuotation.code=" + rfqNo +"&requestForQuotation.validStatus=TRUE";
                pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION");

            });
            ev.preventDefault();
    
        });
     
        $('#btnRequestForQuotationDelete').click(function(ev) {
            
            var deleteRowId = $("#requestForQuotation_grid").jqGrid('getGridParam','selrow');
            var requestForQuotation = $("#requestForQuotation_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            if(requestForQuotation.validStatus==="NO"){
                alertMessage("Can't Delete");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'APPROVED'){
                alertMessage("It's already approved");
                return;
            }
            
            if(requestForQuotation.approvalStatus === 'DECLINED'){
                alertMessage("It's already rejected");
                return;
            }
                var url = "sales/request-for-quotation-delete";
                var params = "requestForQuotation.code=" + requestForQuotation.code;

                var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Delete?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>SO No: '+requestForQuotation.code+'<br/><br/>' +    
                    '</div>');
                dynamicDialog.dialog({
                    title           : "Message",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 300,
                    resizable       : false,
                    buttons         : [{
                                        text : "Yes",
                                        click : function() {
                                            $.post(url, params, function(data) {
                                                if (data.error) {
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                              $("#requestForQuotation_grid").trigger("reloadGrid");
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
                ev.preventDefault();
            });                           

        $('#btnRequestForQuotationRefresh').click(function(ev) {
            var url = "sales/request-for-quotation";
            var params = "";
            pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION");            
            ev.preventDefault();   
        });
    
        $("#btnRequestForQuotation_search").click(function(ev) {
            formatDateRFQ();
            $("#requestForQuotation_grid").jqGrid("clearGridData");
            $("#requestForQuotation_grid").jqGrid("setGridParam",{url:"sales/request-for-quotation-data?" + $("#frmRequestForQuotationSearchInput").serialize(), page:1});
            $("#requestForQuotation_grid").trigger("reloadGrid");
            formatDateRFQ();
            ev.preventDefault();   
        });
        
    });  
    
    function formatDateRFQ(){
            var firstDate=$("#requestForQuotationSearchFirstDate").val();
            var firstDateValues= firstDate.split('/');
            var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
            $("#requestForQuotationSearchFirstDate").val(firstDateValue);

            var lastDate=$("#requestForQuotationSearchLastDate").val();
            var lastDateValues= lastDate.split('/');
            var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
            $("#requestForQuotationSearchLastDate").val(lastDateValue);

        }
</script>
<s:url id="remoteurlRequestForQuotation" action="request-for-quotation-data" />
<b> REQUEST FOR QUOTATION</b>
<hr>
<br class="spacer" />
    <sj:div id="requestForQuotationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnRequestForQuotationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnRequestForQuotationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnRequestForQuotationRevise" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Revise"/><br/>Revise</a>
            </td>
            <td><a href="#" id="btnRequestForQuotationClone" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Clone"/><br/>Clone</a>
            </td>
            <td><a href="#" id="btnRequestForQuotationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnRequestForQuotationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnRequestForQuotationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>     
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="requestForQuotationApprovalInputSearch" class="content ui-widget">
        <s:form id="frmRequestForQuotationSearchInput">
            <table cellpadding="2" cellspacing="2">
                 <tr>
                    <td align="right"><B>Period *</B></td>
                    <td>
                        <sj:datepicker id="requestForQuotationSearchFirstDate" name="requestForQuotationSearchFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>Up to *</B>
                        <sj:datepicker id="requestForQuotationSearchLastDate" name="requestForQuotationSearchLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                <tr/>    
                <tr>    
                    <td align="right">RFQ No</td>
                    <td>
                        <s:textfield id="requestForQuotationSearchCode" name="requestForQuotationSearchCode" placeHolder=" RFQ No" size="40"></s:textfield>
                    </td>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="requestForQuotationSearchCustomerCode" name="requestForQuotationSearchCustomerCode" placeHolder=" Code" size="20"></s:textfield>
                        <s:textfield id="requestForQuotationSearchCustomerName" name="requestForQuotationSearchCustomerName" placeHolder=" Name" size="20"></s:textfield>
                    </td>
                </tr>                
                <tr>
                    <td align="right">Tender No</td>
                    <td>
                        <s:textfield id="requestForQuotationSearchTenderNo" name="requestForQuotationSearchTenderNo" placeHolder=" Tender No" size="40"></s:textfield>
                    </td>
                    <td align="right"><b>End User</b></td>
                    <td>
                        <s:textfield id="requestForQuotationSearchEndUserCode" name="requestForQuotationSearchEndUserCode" placeHolder=" Code" size="20"></s:textfield>
                        <s:textfield id="requestForQuotationSearchEndUserName" name="requestForQuotationSearchEndUserName" placeHolder=" Name" size="20"></s:textfield> 
                    </td>
                </tr>
                <tr>
                    <td align="right">Project</td>
                    <td>
                        <s:textfield id="requestForQuotationSearchProjectCode" name="requestForQuotationSearchProjectCode" placeHolder =" Project Code" size="40"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="requestForQuotationSearchRefNo" name="requestForQuotationSearchRefNo" placeHolder =" Ref No" size="40"></s:textfield>
                    </td>
                </tr>    
                <tr>
                    <td align="right">Subject</td>
                    <td>
                        <s:textfield id="requestForQuotationSearchSubject" name="requestForQuotationSearchSubject" placeHolder =" Subject" size="40"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="requestForQuotationSearchRemark" name="requestForQuotationSearchRemark" placeHolder =" Remark" size="40"></s:textfield>
                    </td>
                </tr>    
                <tr>
                <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="requestForQuotationSearchApprovalStatusRad" name="requestForQuotationSearchApprovalStatusRad" label="requestForQuotationSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','DECLINED'}"></s:radio>
                        <s:textfield id="requestForQuotationSearchApprovalStatus" name="requestForQuotationSearchApprovalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
                <tr>
                <td align="right"><B>Valid Status</B></td>
                    <td>
                        <s:radio id="requestForQuotationSearchValidStatusRad" name="requestForQuotationSearchValidStatusRad" label="requestForQuotationSearchValidStatusRad" list="{'ALL','YES','NO'}"></s:radio>
                        <s:textfield id="requestForQuotationSearchValidStatus" name="requestForQuotationSearchValidStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnRequestForQuotation_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="requestForQuotationGrid">
        <sjg:grid
            id="requestForQuotation_grid"
            caption="REQUEST FOR QUOTATION"
            dataType="json"
            href="%{remoteurlRequestForQuotation}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listRequestForQuotationTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="requestForQuotation_grid_onSelect"
            width="$('#tabmnuREQUEST_FOR_QUOTATION').width()"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="RFQ No" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="rfqNo" index="rfqNo" key="rfqNo" title="RFQ No" width="150" sortable="true" hidden = "true"
            />
            <sjg:gridColumn
                name="validStatus" index="validStatus" key="validStatus" title="Valid Status" width="50" sortable="true"
            />
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Approval Status" width="60" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s' }"  sortable="true" 
            />
            <sjg:gridColumn
                name="orderStatus" index="orderStatus" key="orderStatus" title="Order Status" width="80" sortable="true"
            />
            <sjg:gridColumn
                name="tenderNo" index="tenderNo" key="tenderNo" title="Tender No" width="130" sortable="true" 
            />
            <sjg:gridColumn
                name="registeredDate" index="registeredDate" key="registeredDate" 
                title="Registered Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
             <sjg:gridColumn
                name="reviewedStatus" index="reviewedStatus" key="reviewedStatus" title="Reviewed Status" width="80" sortable="true"
            />
            <sjg:gridColumn
                name="preBidMeetingDate" index="preBidMeetingDate" key="preBidMeetingDate" 
                title="Pre Bid Meeting" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="sendToFactoryDate" index="sendToFactoryDate" key="sendToFactoryDate" 
                title="Send to Factory Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="submittedDateToCustomer" index="submittedDateToCustomer" key="submittedDateToCustomer" 
                title="Submitted Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="scopeOfSupply" index="scopeOfSupply" key="scopeOfSupply" title="Scope Of Supply" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="50" sortable="true" 
            />
            <sjg:gridColumn
                name="customerName" index="customerName" key="customerName" title="Customer" width="70" sortable="true" 
            />
            <sjg:gridColumn
                name="endUserName" index="endUserName" key="endUserName" title="End User" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="attn" index="attn" key="attn" title="Attn" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="salesPersonName" index="salesPersonName" key="salesPersonName" title="Sales Person" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="projectCode" index="projectCode" key="projectCode" title="Project" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="subject" index="subject" key="subject" title="Subject" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="100" sortable="true" 
            />
            
        </sjg:grid>
    </div>