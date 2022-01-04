
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

        $('#requestForQuotationApprovalSearchValidStatusRadYES').prop('checked',true);
            $("#requestForQuotationApprovalSearchValidStatus").val("true");
        
        $('input[name="requestForQuotationApprovalSearchValidStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#requestForQuotationApprovalSearchValidStatus").val(value);
        });
        
        $('input[name="requestForQuotationApprovalSearchValidStatusRad"][value="YES"]').change(function(ev){
            var value="TRUE";
            $("#requestForQuotationApprovalSearchValidStatus").val(value);
        });
                
        $('input[name="requestForQuotationApprovalSearchValidStatusRad"][value="NO"]').change(function(ev){
            var value="FALSE";
            $("#requestForQuotationApprovalSearchValidStatus").val(value);
        });
        
        $('#requestForQuotationApprovalSearchApprovalStatusRadPENDING').prop('checked',true);
            $("#requestForQuotationApprovalSearchApprovalStatus").val("PENDING");
            
        $('input[name="requestForQuotationApprovalSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#requestForQuotationApprovalSearchApprovalStatus").val("PENDING");
        });
        
        $('input[name="requestForQuotationApprovalSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#requestForQuotationApprovalSearchApprovalStatus").val("APPROVED");
        });
        
        $('input[name="requestForQuotationApprovalSearchApprovalStatusRad"][value="DECLINED"]').change(function(ev){
            $("#requestForQuotationApprovalSearchApprovalStatus").val("DECLINED");
        });
        
        $('input[name="requestForQuotationApprovalSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#requestForQuotationApprovalSearchApprovalStatus").val("");
        });
        
        $("#btnRequestForQuotationApprovalApproved").click(function (ev) {
            
            var selectedRowID = $("#requestForQuotationApproval_grid").jqGrid("getGridParam", "selrow");
            var requestForQuotationApproval = $("#requestForQuotationApproval_grid").jqGrid('getRowData', selectedRowID);

            if(selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            
            if(requestForQuotationApproval.approvalStatus === 'APPROVED' && requestForQuotationApproval.rfqCode !==""){
                alertMessage("Cannot Process This Document Anymore");
                return;
            }
            
            if(requestForQuotationApproval.approvalStatus === 'DECLINED'){
                alertMessage("Cannot Process This Document Anymore");
                return;
            }
            
            var url = "sales/request-for-quotation-approval-input";
            var param = "requestForQuotationApprovalUpdateMode=true&requestForQuotationApproval.code=" + requestForQuotationApproval.code;
            pageLoad(url, param, "#tabmnuREQUEST_FOR_QUOTATION_APPROVAL");
                    
            ev.preventDefault();    
        });


        $('#btnRequestForQuotationApprovalRefresh').click(function(ev) {
            var url = "sales/request-for-quotation-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION_APPROVAL");            
            ev.preventDefault();   
        });
    
        $("#btnRequestForQuotationApproval_search").click(function(ev) {
            formatDateApprovalRFQ();
            $("#requestForQuotationApproval_grid").jqGrid("clearGridData");
            $("#requestForQuotationApproval_grid").jqGrid("setGridParam",{url:"sales/request-for-quotation-approval-data?" + $("#frmRequestForQuotationApprovalSearchInput").serialize()});
            $("#requestForQuotationApproval_grid").trigger("reloadGrid");
            formatDateApprovalRFQ();
        });
        
    });  
    
    function formatDateApprovalRFQ(){
            var firstDate=$("#requestForQuotationApprovalSearchFirstDate").val();
            var firstDateValues= firstDate.split('/');
            var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
            $("#requestForQuotationApprovalSearchFirstDate").val(firstDateValue);

            var lastDate=$("#requestForQuotationApprovalSearchLastDate").val();
            var lastDateValues= lastDate.split('/');
            var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
            $("#requestForQuotationApprovalSearchLastDate").val(lastDateValue);

        }
</script>
<s:url id="remoteurlRequestForQuotationApproval" action="request-for-quotation-approval-data" />
<b> REQUEST FOR QUOTATION APPROVAL</b>
<hr>
<br class="spacer" />
    <sj:div id="requestForQuotationApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td> <a href="#" id="btnRequestForQuotationApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
        </tr>     
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="requestForQuotationApprovalApprovalInputSearch" class="content ui-widget">
        <s:form id="frmRequestForQuotationApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period *</B></td>
                    <td>
                        <sj:datepicker id="requestForQuotationApprovalSearchFirstDate" name="requestForQuotationApprovalSearchFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>Up to *</B>
                        <sj:datepicker id="requestForQuotationApprovalSearchLastDate" name="requestForQuotationApprovalSearchLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                <tr/>    
                <tr>    
                    <td align="right">RFQ No</td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchCode" name="requestForQuotationApprovalSearchCode" placeHolder=" RFQ No" size="40"></s:textfield>
                    </td>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchCustomerCode" name="requestForQuotationApprovalSearchCustomerCode" placeHolder=" Code" size="20"></s:textfield>
                        <s:textfield id="requestForQuotationApprovalSearchCustomerName" name="requestForQuotationApprovalSearchCustomerName" placeHolder=" Name" size="20"></s:textfield>
                    </td>
                </tr>                
                <tr>
                    <td align="right">Tender No</td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchTenderNo" name="requestForQuotationApprovalSearchTenderNo" placeHolder=" Tender No" size="40"></s:textfield>
                    </td>
                    <td align="right"><b>End User</b></td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchEndUserCode" name="requestForQuotationApprovalSearchEndUserCode" placeHolder=" Code" size="20"></s:textfield>
                        <s:textfield id="requestForQuotationApprovalSearchEndUserName" name="requestForQuotationApprovalSearchEndUserName" placeHolder=" Name" size="20"></s:textfield> 
                    </td>
                </tr>
                <tr>
                    <td align="right">Project</td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchProjectCode" name="requestForQuotationApprovalSearchProjectCode" placeHolder ="Project" size="40"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchRefNo" name="requestForQuotationApprovalSearchRefNo" placeHolder ="Ref No" size="40"></s:textfield>
                    </td>
                </tr>    
                <tr>
                    <td align="right">Subject</td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchSubject" name="requestForQuotationApprovalSearchSubject" placeHolder ="Subject" size="40"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="requestForQuotationApprovalSearchRemark" name="requestForQuotationApprovalSearchRemark" placeHolder ="Remark" size="40"></s:textfield>
                    </td>
                </tr>    
                <tr>
                <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="requestForQuotationApprovalSearchApprovalStatusRad" name="requestForQuotationApprovalSearchApprovalStatusRad" label="requestForQuotationApprovalSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','DECLINED'}"></s:radio>
                        <s:textfield id="requestForQuotationApprovalSearchApprovalStatus" name="requestForQuotationApprovalSearchApprovalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
                <tr>
                <td align="right"><B>Valid Status</B></td>
                    <td>
                        <s:radio id="requestForQuotationApprovalSearchValidStatusRad" name="requestForQuotationApprovalSearchValidStatusRad" label="requestForQuotationApprovalSearchValidStatusRad" list="{'ALL','YES','NO'}"></s:radio>
                        <s:textfield id="requestForQuotationApprovalSearchValidStatus" name="requestForQuotationApprovalSearchValidStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnRequestForQuotationApproval_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="requestForQuotationApprovalGrid">
        <sjg:grid
            id="requestForQuotationApproval_grid"
            caption="REQUEST FOR QUOTATION"
            dataType="json"
            href="%{remoteurlRequestForQuotationApproval}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listRequestForQuotationApprovalTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="requestForQuotationApproval_grid_onSelect"
            width="$('#tabmnuREQUEST_FOR_QUOTATION_APPROVAL').width()"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="RFQ No" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="rfqNo" index="rfqNo" key="rfqNo" title="RFQ No" width="200" sortable="true" hidden = "true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s' }"  sortable="true" 
            />
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Approval Status" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="tenderNo" index="tenderNo" key="tenderNo" title="Tender No" width="130" sortable="true" 
            />
            <sjg:gridColumn
                name="customerName" index="customerName" key="customerName" title="Customer Name" width="70" sortable="true" 
            />
            <sjg:gridColumn
                name="endUserName" index="endUserName" key="endUserName" title="User Name" width="70" sortable="true" 
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
                name="orderStatus" index="orderStatus" key="orderStatus" title="Order Status" width="80" sortable="true" hidden ="true"
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
                name="attn" index="attn" key="attn" title="Attn" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="salesPersonCode" index="salesPersonCode" key="salesPersonCode" title="Sales Person Code" width="100" sortable="true" 
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
            <sjg:gridColumn
                name="rfqCode" index="rfqCode" key="rfqCode" title="" width="100" sortable="true" hidden="true"
            />
            
        </sjg:grid>
    </div>
    <br class="spacer" />
<div>
    <sj:a href="#" id="btnRequestForQuotationApprovalApproved" button="true" style="width: 90px">Approval</sj:a>
</div>