
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
</style>

<script type="text/javascript">


    $(document).ready(function () {
        hoverButton();

        $('#requestForQuotationClosingSearchValidStatusRadYES').prop('checked',true);
            $("#requestForQuotationClosingSearchValidStatus").val("true");
        
        $('input[name="requestForQuotationClosingSearchValidStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#requestForQuotationClosingSearchValidStatus").val(value);
        });
        
        $('input[name="requestForQuotationClosingSearchValidStatusRad"][value="YES"]').change(function(ev){
            var value="true";
            $("#requestForQuotationClosingSearchValidStatus").val(value);
        });
                
        $('input[name="requestForQuotationClosingSearchValidStatusRad"][value="NO"]').change(function(ev){
            var value="false";
            $("#requestForQuotationClosingSearchValidStatus").val(value);
        });
        
        $('#requestForQuotationClosingSearchClosingStatusRadOPEN').prop('checked',true);
            $("#requestForQuotationClosingSearchClosingStatus").val("OPEN");
            
        $('input[name="requestForQuotationClosingSearchClosingStatusRad"][value="OPEN"]').change(function(ev){
            $("#requestForQuotationClosingSearchClosingStatus").val("OPEN");
        });
        
        $('input[name="requestForQuotationClosingSearchClosingStatusRad"][value="CLOSED"]').change(function(ev){
            $("#requestForQuotationClosingSearchClosingStatus").val("CLOSED");
        });
        
        $('input[name="requestForQuotationClosingSearchClosingStatusRad"][value="ALL"]').change(function(ev){
            $("#requestForQuotationClosingSearchClosingStatus").val("");
        });
        
        $("#btnRequestForQuotationClosingClosed").click(function (ev) {
            
            var selectedRowID = $("#requestForQuotationClosing_grid").jqGrid("getGridParam", "selrow");
            var requestForQuotationClosing = $("#requestForQuotationClosing_grid").jqGrid('getRowData', selectedRowID);

            if(selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            
            if(requestForQuotationClosing.closingStatus === 'CLOSED'){
                alertMessage("It's already closed");
                return;
            }
            
            var url = "sales/request-for-quotation-closing-input";
            var param = "requestForQuotationClosingUpdateMode=true&requestForQuotationClosing.code=" + requestForQuotationClosing.code;
            pageLoad(url, param, "#tabmnuREQUEST_FOR_QUOTATION_CLOSING");
                    
            ev.preventDefault();    
        });


        $('#btnRequestForQuotationClosingRefresh').click(function(ev) {
            var url = "sales/request-for-quotation-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuREQUEST_FOR_QUOTATION_CLOSING");            
            ev.preventDefault();   
        });
    
        $("#btnRequestForQuotationClosing_search").click(function(ev) {
            formatDateClosingRFQ();
            $("#requestForQuotationClosing_grid").jqGrid("clearGridData");
            $("#requestForQuotationClosing_grid").jqGrid("setGridParam",{url:"sales/request-for-quotation-closing-data?" + $("#frmRequestForQuotationClosingSearchInput").serialize()});
            $("#requestForQuotationClosing_grid").trigger("reloadGrid");
            formatDateClosingRFQ();
        });
        
    });  
    
    function formatDateClosingRFQ(){
            var firstDate=$("#requestForQuotationClosingSearchFirstDate").val();
            var firstDateValues= firstDate.split('/');
            var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
            $("#requestForQuotationClosingSearchFirstDate").val(firstDateValue);

            var lastDate=$("#requestForQuotationClosingSearchLastDate").val();
            var lastDateValues= lastDate.split('/');
            var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
            $("#requestForQuotationClosingSearchLastDate").val(lastDateValue);

        }
</script>
<s:url id="remoteurlRequestForQuotationClosing" action="request-for-quotation-closing-data" />
<b> REQUEST FOR QUOTATION CLOSING</b>
<hr>
<br class="spacer" />
    <sj:div id="requestForQuotationClosingButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td> <a href="#" id="btnRequestForQuotationClosingRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
        </tr>     
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="requestForQuotationClosingClosingInputSearch" class="content ui-widget">
        <s:form id="frmRequestForQuotationClosingSearchInput">
            <table cellpadding="2" cellspacing="2">
                 <tr>
                    <td align="right">RFQ No</td>
                    <td>
                        <s:textfield id="requestForQuotationClosingSearchCode" name="requestForQuotationClosingSearchCode" placeHolder=" RFQ No" size="20"></s:textfield>
                        Tender No
                        <s:textfield id="requestForQuotationClosingSearchTenderNo" name="requestForQuotationClosingSearchTenderNo" placeHolder=" Tender No" size="20"></s:textfield>
                        Project
                        <s:textfield id="requestForQuotationClosingSearchProjectCode" name="requestForQuotationClosingSearchProjectCode" placeHolder ="Project" size="20"></s:textfield>
                        Subject
                        <s:textfield id="requestForQuotationClosingSearchSubject" name="requestForQuotationClosingSearchSubject" placeHolder ="Subject" size="20"></s:textfield>
                        <b>End User Code</b>
                        <s:textfield id="requestForQuotationClosingSearchEndUserCode" name="requestForQuotationClosingSearchEndUserCode" placeHolder=" Code" size="20"></s:textfield>
                        <b>End User Name</b>
                        <s:textfield id="requestForQuotationClosingSearchEndUserName" name="requestForQuotationClosingSearchEndUserName" placeHolder=" Name" size="20"></s:textfield> 
                    </td>
                </tr>                
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="requestForQuotationClosingSearchFirstDate" name="requestForQuotationClosingSearchFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>Up to *</B>
                        <sj:datepicker id="requestForQuotationClosingSearchLastDate" name="requestForQuotationClosingSearchLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <b>Customer Code</b>
                        <s:textfield id="requestForQuotationClosingSearchCustomerCode" name="requestForQuotationClosingSearchCustomerCode" placeHolder=" Code" size="20"></s:textfield>
                        <b>Customer Name</b>
                        <s:textfield id="requestForQuotationClosingSearchCustomerName" name="requestForQuotationClosingSearchCustomerName" placeHolder=" Name" size="20"></s:textfield>
                    </td>
                </tr>
                <tr>
                <td align="right"><B>Closing Status</B></td>
                    <td>
                        <s:radio id="requestForQuotationClosingSearchClosingStatusRad" name="requestForQuotationClosingSearchClosingStatusRad" label="requestForQuotationClosingSearchClosingStatusRad" list="{'ALL','OPEN','CLOSED'}"></s:radio>
                        <s:textfield id="requestForQuotationClosingSearchClosingStatus" name="requestForQuotationClosingSearchClosingStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
                <tr>
                <td align="right"><B>Valid Status</B></td>
                    <td>
                        <s:radio id="requestForQuotationClosingSearchValidStatusRad" name="requestForQuotationClosingSearchValidStatusRad" label="requestForQuotationClosingSearchValidStatusRad" list="{'YES','NO','ALL'}"></s:radio>
                        <s:textfield id="requestForQuotationClosingSearchValidStatus" name="requestForQuotationClosingSearchValidStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnRequestForQuotationClosing_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="requestForQuotationClosingGrid">
        <sjg:grid
            id="requestForQuotationClosing_grid"
            caption="REQUEST FOR QUOTATION"
            dataType="json"
            href="%{remoteurlRequestForQuotationClosing}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listRequestForQuotationClosingTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="requestForQuotationClosing_grid_onSelect"
            width="$('#tabmnuREQUEST_FOR_QUOTATION_CLOSING').width()"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="RFQ No" width="200" sortable="true" 
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
                name="closingStatus" index="closingStatus" key="closingStatus" title="Closing Status" width="50" sortable="true"
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
                name="customerName" index="customerName" key="customerName" title="Customer Name" width="70" sortable="true" 
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
            
        </sjg:grid>
    </div>
    <br class="spacer" />
<div>
    <sj:a href="#" id="btnRequestForQuotationClosingClosed" button="true" style="width: 90px">Closing</sj:a>
</div>