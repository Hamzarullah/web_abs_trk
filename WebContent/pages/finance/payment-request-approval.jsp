
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #paymentRequestApprovalDetail_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
    #msgPaymentRequestApprovalFormatTotalAmount{
       color: green;
    }
</style>
<script type="text/javascript">
                     
    $(document).ready(function(){
        
        hoverButton();
        
        $('#paymentRequestApprovalStatusApprovalRadPENDING').prop('checked',true);
        $("#paymentRequestApprovalSearchApprovedStatus").val("PENDING");
        
        $('#paymentRequestApprovalTransactionTypeRadALL').prop('checked',true);
        $("#paymentRequestApprovalSearchTransactionType").val("");
            
        $('input[name="paymentRequestApprovalStatusApprovalRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#paymentRequestApprovalSearchApprovedStatus").val(value);
        });
        $('input[name="paymentRequestApprovalStatusApprovalRad"][value="PENDING"]').change(function(ev){
            var value="PENDING";
            $("#paymentRequestApprovalSearchApprovedStatus").val(value);
        });
        $('input[name="paymentRequestApprovalStatusApprovalRad"][value="REJECTED"]').change(function(ev){
            var value="REJECTED";
            $("#paymentRequestApprovalSearchApprovedStatus").val(value);
        });
        $('input[name="paymentRequestApprovalStatusApprovalRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#paymentRequestApprovalSearchApprovedStatus").val(value);
        });
        
        $('input[name="paymentRequestApprovalTransactionTypeRad"][value="DEPOSIT"]').change(function(ev){
            var value="DEPOSIT";
            $("#paymentRequestApprovalSearchTransactionType").val(value);
        });
        $('input[name="paymentRequestApprovalTransactionTypeRad"][value="REGULAR"]').change(function(ev){
            var value="REGULAR";
            $("#paymentRequestApprovalSearchTransactionType").val(value);
        });
        $('input[name="paymentRequestApprovalTransactionTypeRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#paymentRequestApprovalSearchTransactionType").val(value);
        });
        
        $.subscribe("paymentRequestApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#paymentRequestApproval_grid").jqGrid("getGridParam", "selrow"); 
            var paymentRequestApproval = $("#paymentRequestApproval_grid").jqGrid("getRowData", selectedRowID);
            
            $("#paymentRequestApprovalDetail_grid").jqGrid("setGridParam",{url:"finance/payment-request-detail-data?paymentRequest.code=" + paymentRequestApproval.code});
            $("#paymentRequestApprovalDetail_grid").jqGrid("setCaption", "PAYMENT REQUEST DETAIL : ");
            $("#paymentRequestApprovalDetail_grid").trigger("reloadGrid");
        });

        $('#btnPaymentRequestApprovalRefresh').click(function(ev) {
            var url = "finance/payment-request-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPAYMENT_REQUEST_APPROVAL");
            ev.preventDefault();   
        });
        
        
        $('#btnPaymentRequestApproval_search').click(function(ev) {
            formatDatepaymentRequestApproval();
            $("#paymentRequestApproval_grid").jqGrid("clearGridData");
            $("#paymentRequestApproval_grid").jqGrid("setGridParam",{url:"finance/payment-request-approval-data?" + $("#frmPaymentRequestApprovalSearchInput").serialize()});
            $("#paymentRequestApproval_grid").trigger("reloadGrid");
            $("#paymentRequestApprovalDetail_grid").jqGrid("clearGridData");
            $("#paymentRequestApprovalDetail_grid").jqGrid("setCaption", "Payment Request Detail");
            formatDatepaymentRequestApproval();
            ev.preventDefault();
           
        });
        
        $("#btnPaymentRequestApproval").click(function(ev) {
            var selectedRowID =$("#paymentRequestApproval_grid").jqGrid("getGridParam", "selrow");
            var paymentRequestApproval = $("#paymentRequestApproval_grid").jqGrid("getRowData", selectedRowID);
            
            if (selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            if(paymentRequestApproval.paymentRequestType==="AP" && paymentRequestApproval.approvalStatus!=="PENDING"){
                alertMessage("Cant Prosses This Payment Request Type AP Because Already "+paymentRequestApproval.approvalStatus+" !");
                return;
                
            }
            var urlAuthority = "purchasing/payment-request-authority";
                var paramAuthority = "usedModule=APPROVAL&actionAuthority=UPDATE";
                    paramAuthority += "&paymentRequestApproval.code=" + paymentRequestApproval.code;
                
                $.post(urlAuthority,paramAuthority,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }else {
                        var url = "finance/payment-request-approval-input";
                        var params = "paymentRequestApproval.code="+paymentRequestApproval.code;
                       pageLoad(url, params, "#tabmnuPAYMENT_REQUEST_APPROVAL");
                    }
                    
                });
        });
        $("#btnPaymentRequestApprovalPrint").click(function(ev) {
            var selectRowId = $("#paymentRequestApproval_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var paymentRequestApproval = $("#paymentRequestApproval_grid").jqGrid('getRowData', selectRowId);   
            var url = "reports/finance/payment-request-print-out-pdf?";
            var params ="paymentRequestApproval.code=" + paymentRequestApproval.code;
            window.open(url+params,'paymentRequestApproval','width=500,height=500');
            ev.preventDefault();
        });
        
        
    });//EOF Ready
    
    function reloadGridpaymentRequestApproval() {
        $("#paymentRequestApproval_grid").trigger("reloadGrid");  
    };
    
    function reloadGridpaymentRequestApprovalDetailAfterDelete() {
        $("#paymentRequestApprovalDetail_grid").jqGrid("clearGridData");
        $("#paymentRequestApprovalDetail_grid").jqGrid("setCaption", "PAYMENT REQUEST DETAIL");
    };
        
    function formatDatepaymentRequestApproval(){
        var firstDate=$("#paymentRequestApprovalSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#paymentRequestApprovalSearchFirstDate").val(firstDateValue);

        var lastDate=$("#paymentRequestApprovalSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#paymentRequestApprovalSearchLastDate").val(lastDateValue);
    }
    
</script>
   
<s:url id="remoteurlPaymentRequestApproval" action="payment-request-approval-data" />
<b>PAYMENT REQUEST APPROVAL</b>
<hr>
<sj:div id="paymentRequestApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td> <a href="#" id="btnPaymentRequestApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
        </tr>
    </table>
</sj:div>
<br class="spacer" />
<br class="spacer" />

<div id="paymentRequestApprovalInputSearch" class="content ui-widget">
    <s:form id="frmPaymentRequestApprovalSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr> 
                <td align="right">Period</td>
                <td>
                    <sj:datepicker id="paymentRequestApprovalSearchFirstDate" name="paymentRequestApprovalSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    To
                    <sj:datepicker id="paymentRequestApprovalSearchLastDate" name="paymentRequestApprovalSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                 <td align="right">Payment To</td>
                <td>
                    <s:textfield id="paymentRequestSearchPaymentTo" name="paymentRequestApprovalSearchPaymentTo" size="40" placeHolder=" Payment To"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td>
                    <s:textfield id="paymentRequestApprovalSearchCode" name="paymentRequestApprovalSearchCode" size="33" placeHolder=" Request No"></s:textfield>
                </td>
               <td align="right">Ref No</td>
                <td>
                    <s:textfield id="paymentRequestApprovalSearchRefNo" name="paymentRequestApprovalSearchRefNo" size="40" placeHolder=" Ref No"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Remark</td>
                <td>
                    <s:textfield id="paymentRequestApprovalSearchRemark" name="paymentRequestApprovalSearchRemark" size="33" placeHolder=" Remark"></s:textfield>
                </td
            </tr>
            <tr>
                <td align="right">Created By</td>
                <td>
                    <s:textfield id="paymentRequestApprovalSearchCreatedBy" name="paymentRequestApprovalSearchCreatedBy" size="33" placeHolder=" Created By"></s:textfield>
                </td
            </tr>
<!--            <tr>
                <td align="right">Type</td>
                <td>
                    <s:radio id="paymentRequestApprovalTransactionTypeRad" name="paymentRequestApprovalTransactionTypeRad" label="" list="{'DEPOSIT','REGULAR','ALL'}"></s:radio>
                    <s:textfield id="paymentRequestApprovalSearchTransactionType" name="paymentRequestApprovalSearchTransactionType"  size="20" style="Display:none" ></s:textfield>
                </td>
            </tr>-->
            <tr>
                <td align="right">Status</td>
                <td>
                    <s:radio id="paymentRequestApprovalStatusApprovalRad" name="paymentRequestApprovalStatusApprovalRad" label="paymentRequestApprovalStatusApprovalRad" list="{'APPROVED','PENDING','REJECTED','ALL'}"></s:radio>
                    <s:textfield id="paymentRequestApprovalSearchApprovedStatus" name="paymentRequestApprovalSearchApprovedStatus" value="PENDING" size="20" style="Display:none" ></s:textfield>
                </td>
            </tr>
            
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnPaymentRequestApproval_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
                  
<div id="paymentRequestApprovalGrid">
    <sjg:grid
        id="paymentRequestApproval_grid"
        caption="PAYMENT REQUEST"
        dataType="json"
        href="%{remoteurlPaymentRequestApproval}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPaymentRequestTemp"
        rowList="10,20,30"
        rowNum="10"
        sortname="transactionDate"
        sortorder="desc"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnupaymentequestapproval').width()"
        onSelectRowTopics="paymentRequestApproval_grid_onSelect"
    > 
        <sjg:gridColumn
            name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Status" width="60" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="FR No" width="170" sortable="true" 
        />
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch" width = "60" sortable = "true" align="center"
        />
        <sjg:gridColumn
            name = "createdBy" id="createdBy" index = "createdBy" key = "createdBy" 
            title = "Created By" width = "60" sortable = "true" align="center"
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="paymentTo" index="paymentTo" key="paymentTo" title="Payment To" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true" align="center"
        />
        <sjg:gridColumn
            name = "totalTransactionAmount" id="totalTransactionAmount" index = "totalTransactionAmount" key = "totalTransactionAmount" 
            title = "Total Amount" width = "100" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="transactionType" index="transactionType" key="transactionType" title="Type" width="60" sortable="true"
        />
       
          
    </sjg:grid >
</div>
                       
<!-- GRID DETAIL -->    
<br class="spacer" />
<table>
    <tr>
        <td>
            <sj:a href="#" id="btnPaymentRequestApproval" button="true" >Approval</sj:a>
        </td>
    </tr>
</table>
<br class="spacer" />

<div id="paymentRequestApprovalDetailGrid">
    <sjg:grid
        id="paymentRequestApprovalDetail_grid"
        caption="PAYMENT REQUEST DETAIL"
        dataType="json"
        pager="true"
        navigator="false"
        navigatorSearch="false"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPaymentRequestDetailTemp"
        width="$('#tabmnupaymentRequestapproval').width()"
        viewrecords="true"
        rownumbers="true"
        rowNum="10000"
        shrinkToFit="false"
    >
        <sjg:gridColumn
            name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "true" hidden="true" 
        />
        <sjg:gridColumn
            name = "documentNo" id="documentNo" index = "documentNo" key = "documentNo" title = "Document No" width = "100" sortable = "true"
        />
        <sjg:gridColumn
            name = "documentBranchCode" id="documentBranchCode" index = "documentBranchCode" key = "documentBranchCode" 
            title = "Document Branch" width = "60" sortable = "true"
        />
        <sjg:gridColumn
            name = "documentType" id="documentType" index = "documentType" key = "documentType" 
            title = "Document Type" width = "50" sortable = "true"
        />
        <sjg:gridColumn
            name = "documentAmount" id="documentAmount" index = "documentAmount" key = "documentAmount" 
            title = "Document Amount" width = "80" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "documentBalanceAmount" id="documentBalanceAmount" index = "documentBalanceAmount" key = "documentBalanceAmount" 
            title = "Document Balance Amount" width = "80" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "currencyCode" id="currencyCode" index = "currencyCode" key = "currencyCode" title = "Currency" width = "60" sortable = "true"  align="center"
        />
        <sjg:gridColumn
            name = "debit" id="debit" index = "debit" key = "debit" 
            title = "Debit" width = "100" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "credit" id="credit" index = "credit" key = "credit" 
            title = "Credit" width = "100" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
       
        <sjg:gridColumn
            name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "200" sortable = "true"
        />
        <sjg:gridColumn
            name = "transactionStatus" id="transactionStatus" index = "transactionStatus" key = "transactionStatus" 
            title = "Transaction Status" width = "100" sortable = "true" align="center" 
        />
    </sjg:grid >
<br class="spacer" />
</div> 