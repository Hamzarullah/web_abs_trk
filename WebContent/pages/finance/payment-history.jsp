
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #paymentHistoryDetail_grid_pager_center{
        display: none;
    }
    #msgCashAccountFormatTotalAmount{
        color: green;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                     
    $(document).ready(function(){
        
        hoverButton();
        
        $('#paymentHistorySearchTempRadINV').prop('checked',true);
        $("#paymentHistorySearchTemp\\.transactionType").val("INV");
        
        $('input[name="paymentHistorySearchTempRad"][value="INV"]').change(function(ev){
            $("#paymentHistorySearchTemp\\.transactionType").val("INV");
        });
        
        $('input[name="paymentHistorySearchTempRad"][value="VIN"]').change(function(ev){
            $("#paymentHistorySearchTemp\\.transactionType").val("VIN");
        });
        
        $('input[name="paymentHistorySearchTempRad"][value="CDN"]').change(function(ev){
            $("#paymentHistorySearchTemp\\.transactionType").val("CDN");
        });
        
        $('input[name="paymentHistorySearchTempRad"][value="CCN"]').change(function(ev){
            $("#paymentHistorySearchTemp\\.transactionType").val("CCN");
        });
        
        $('input[name="paymentHistorySearchTempRad"][value="VDN"]').change(function(ev){
            $("#paymentHistorySearchTemp\\.transactionType").val("VDN");
        });
        
        $('input[name="paymentHistorySearchTempRad"][value="VCN"]').change(function(ev){
            $("#paymentHistorySearchTemp\\.transactionType").val("VCN");
        });
        
        $.subscribe("paymentHistory_grid_onSelect", function(event, data){
            var selectedRowID = $("#paymentHistory_grid").jqGrid("getGridParam", "selrow"); 
            var paymentHistory = $("#paymentHistory_grid").jqGrid("getRowData", selectedRowID);
            
            $("#paymentHistoryDetail_grid").jqGrid("setGridParam",{url:"finance/payment-history-detail-data?paymentHistoryDocumentNo=" + paymentHistory.documentNo + "&paymentHistoryDocumentType=" + paymentHistory.transactionType});
            $("#paymentHistoryDetail_grid").jqGrid("setCaption", "PAYMENT HISTORY DETAIL : " + paymentHistory.documentNo);
            $("#paymentHistoryDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnPaymentHistoryRefresh').click(function(ev) {
            var url = "finance/payment-history";
            var params = "";
            pageLoad(url, params, "#tabmnuPAYMENT_HISTORY");
            ev.preventDefault();   
        });
        
        $('#btnPaymentHistory_search').click(function(ev) {
            formatDatePaymentHistory();
            $("#paymentHistory_grid").jqGrid("clearGridData");
            $("#paymentHistory_grid").jqGrid("setGridParam",{url:"finance/payment-history-data?" + $("#frmPaymentHistorySearchInput").serialize()});
            $("#paymentHistory_grid").trigger("reloadGrid");
            $("#paymentHistoryDetail_grid").jqGrid("clearGridData");
            $("#paymentHistoryDetail_grid").jqGrid("setCaption", "PAYMENT HISTORY DETAIL");
            formatDatePaymentHistory();
            ev.preventDefault();
           
        });
        
    });//EOF Ready
    
    function reloadGridPaymentHistory() {
        $("#paymentHistory_grid").trigger("reloadGrid");  
    };
    
    function reloadGridPaymentHistoryDetailAfterDelete() {
        $("#paymentHistoryDetail_grid").jqGrid("clearGridData");
        $("#paymentHistoryDetail_grid").jqGrid("setCaption", "PAYMENT HISTORY DETAIL");
    };
        
    function formatDatePaymentHistory(){
        var firstDate=$("#paymentHistoryFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#paymentHistoryFirstDate").val(firstDateValue);

        var lastDate=$("#paymentHistoryLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#paymentHistoryLastDate").val(lastDateValue);
    }
    
</script>
   
<s:url id="remoteurlPaymentHistory" action="payment-history-data" />

    <b>PAYMENT HISTORY</b>
    <hr>
    <br class="spacer" />
    <sj:div id="PaymentHistoryButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <!--<a href="#" id="btnPaymentHistoryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" /></a>-->
        <!--<a href="#" id="btnPaymentHistoryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" /></a>-->
        <!--<a href="#" id="btnPaymentHistoryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" /></a>-->
        <a href="#" id="btnPaymentHistoryRefresh" class="ikb-button ui-state-default ui-corner-left ui-corner-right"><img src="images/button_refresh.png" border="0" /></a>
        <!--<a href="#" id="btnPaymentHistoryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" /></a>-->
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="PaymentHistoryInputSearch" class="content ui-widget">
        <s:form id="frmPaymentHistorySearchInput">
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="paymentHistoryFirstDate" name="paymentHistoryFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="paymentHistoryLastDate" name="paymentHistoryLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Document No</td>
                    <td>
                        <s:textfield id="paymentHistorySearchTemp.documentNo" name="paymentHistorySearchTemp.documentNo" size="22" PlaceHolder="Document No"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="paymentHistorySearchTemp.documentRefNo" name="paymentHistorySearchTemp.documentRefNo" size="34"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Customer / Vendor Code</td>
                    <td>
                        <s:textfield id="paymentHistorySearchTemp.documentCustomerVendorCode" name="paymentHistorySearchTemp.documentCustomerVendorCode" size="22" ></s:textfield>
                    </td>
                    <td align="right">Customer / Vendor Name</td>
                    <td>
                        <s:textfield id="paymentHistorySearchTemp.documentCustomerVendorName" name="paymentHistorySearchTemp.documentCustomerVendorName" size="34"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Document Type</td>
                    <td>
                        <s:radio id="paymentHistorySearchTempRad" name="paymentHistorySearchTempRad" list="{'INV','VIN','CDN','CCN','VDN','VCN'}"></s:radio>
                        <s:textfield id="paymentHistorySearchTemp.transactionType" name="paymentHistorySearchTemp.transactionType" size="22" readonly="true" cssStyle="display:none"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnPaymentHistory_search" button="true">Search</sj:a>
            <br class="spacer" />
             
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="PaymentHistoryGrid">
        <sjg:grid
            id="paymentHistory_grid"
            caption="PAYMENT HISTORY"
            dataType="json"
            href="%{remoteurlPaymentHistory}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPaymentHistoryTemp"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucashpayment').width()"
            onSelectRowTopics="paymentHistory_grid_onSelect"
        >
        <sjg:gridColumn
            name = "transactionType" id="transactionType" index = "transactionType" key = "transactionType" 
            title = "Type" width = "100" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch" width = "100" sortable = "true" align="center"
        />
        <sjg:gridColumn
            name="documentNo" index="documentNo" key="documentNo" title="Document No" width="120" sortable="true" 
        />
        <sjg:gridColumn
            name="documentRefNo" index="documentRefNo" key="documentRefNo" title="Ref No" width="70" sortable="true" 
        />
        <sjg:gridColumn
            name="documentTransactionDate" index="documentTransactionDate" key="documentTransactionDate" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="documentCustomerVendorCode" index="documentCustomerVendorCode" key="documentCustomerVendorCode" title="Customer / Vendor Code" width="80" sortable="true"
        />
        <sjg:gridColumn
            name="documentCustomerVendorName" index="documentCustomerVendorName" key="documentCustomerVendorName" title="Customer / Vendor Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="documentCurrencyCode" index="documentCurrencyCode" key="documentCurrencyCode" title="Currency" width="60" sortable="true"
        />
        <sjg:gridColumn
            name = "documentExchangeRate" index = "documentExchangeRate" key = "documentExchangeRate" title = "Exchange Rate" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "documentTotalTransactionAmount" index = "documentTotalTransactionAmount" key = "documentTotalTransactionAmount" title = "Document Amount" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "documentDownPaymentAmount" index = "documentDownPaymentAmount" key = "documentDownPaymentAmount" title = "Down Payment Amount" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "documentNettAmount" index = "documentNettAmount" key = "documentNettAmount" title = "Nett Amount" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "documentPaidAmount" index = "documentPaidAmount" key = "documentPaidAmount" title = "Paid Amount" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "documentBalanceAmount" index = "documentBalanceAmount" key = "documentBalanceAmount" title = "Balance Amount" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        </sjg:grid >
    </div>
                       
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="paymentHistoryDetailGrid">
        <sjg:grid
            id="paymentHistoryDetail_grid"
            caption="PAYMENT HISTORY DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPaymentHistoryDetailTemp"
            width="$('#tabmnucashpayment').width()"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name = "voucherNo" id="voucherNo" index = "voucherNo" key = "voucherNo" title = "Voucher No" width = "100" sortable = "true"  
            />
            <sjg:gridColumn
                name = "refNo" id="refNo" index = "refNo" key = "refNo" title = "Ref No" width = "100" sortable = "true"  
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
            />
            <sjg:gridColumn
                name = "paymentReceivedType" id="paymentReceivedType" index = "paymentReceivedType" key = "paymentReceivedType" title = "Payment Type" width = "100" sortable = "true"  
            />
            <sjg:gridColumn
                name = "bankCashAccountName" id="bankCashAccountName" index = "bankCashAccountName" key = "bankCashAccountName" title = "Bank / Cash Account" width = "80" sortable = "true"  align="center"
            />
            <sjg:gridColumn
                name = "currencyCode" id="currencyCode" index = "currencyCode" key = "currencyCode" title = "Currency" width = "80" sortable = "true"  align="center"
            />
            <sjg:gridColumn
                name = "exchangeRate" id="exchangeRate" index = "exchangeRate" key = "exchangeRate" 
                title = "Rate" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "amount" id="amount" index = "amount" key = "amount" 
                title = "Paid Amount" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "COA Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "COA Name" width = "200" sortable = "true"
            />
        </sjg:grid >
        <br class="spacer" />
    </div> 