<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />


<style>
    #vendorInvoiceGRNDetail_grid_pager_center,
    #vendorInvoiceSDPDetail_grid_pager_center,
    #vendorInvoiceItemDetail_grid_pager_center{
        display: none;
    }
</style>
<script type="text/javascript">
    
    $(document).ready(function(){
        
        hoverButton();
        
        $.subscribe("vendorInvoice_grid_onSelect", function(event, data){
            var selectedRowID = $("#vendorInvoice_grid").jqGrid("getGridParam", "selrow"); 
            var data = $("#vendorInvoice_grid").jqGrid("getRowData", selectedRowID);
            
            $("#vendorInvoiceGRNDetail_grid").jqGrid("setGridParam",{url:"finance/vendor-invoice-grn-data?headerCode=" + data.code});
            $("#vendorInvoiceGRNDetail_grid").jqGrid("setCaption", "GOODS RECEIVED NOTE : " + data.code);
            $("#vendorInvoiceGRNDetail_grid").trigger("reloadGrid");
            
            $("#vendorInvoiceSDPDetail_grid").jqGrid("setGridParam",{url:"finance/vendor-invoice-dp-data?headerCode=" + data.code});
            $("#vendorInvoiceSDPDetail_grid").jqGrid("setCaption", "VENDOR DOWN PAYMENT : " + data.code);
            $("#vendorInvoiceSDPDetail_grid").trigger("reloadGrid");
            
            $("#vendorInvoiceItemDetail_grid").jqGrid("setGridParam",{url:"finance/vendor-invoice-item-detail-data?headerCode=" + data.code});
            $("#vendorInvoiceItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL : " + data.code);
            $("#vendorInvoiceItemDetail_grid").trigger("reloadGrid");
                        
            $("#vendorInvoiceTotalTransactionAmount").val(formatNumberVIN(data.totalTransactionAmount));
            $("#vendorInvoiceDiscountPercent").val(formatNumberVIN(data.discountPercent));
            $("#vendorInvoiceDiscountAmount").val(formatNumberVIN(data.discountAmount));
            $("#vendorInvoiceDiscountChartOfAccountCode").val(data.discountChartOfAccountCode);          
            $("#vendorInvoiceDiscountChartOfAccountName").val(data.discountChartOfAccountName);            
            $("#vendorInvoiceDiscountDescription").val(data.discountDescription); 
            $("#vendorInvoiceDownPaymentAmount").val(formatNumberVIN(data.downPaymentAmount));
            $("#vendorInvoiceSubTotal").val(formatNumberVIN(data.taxBaseAmount));
            $("#vendorInvoiceVatPercent").val(formatNumberVIN(data.vatPercent));
            $("#vendorInvoiceVatAmount").val(formatNumberVIN(data.vatAmount));
            $("#vendorInvoiceOtherFeeAmount").val(formatNumberVIN(data.otherFeeAmount));  
            $("#vendorInvoiceOtherFeeChartOfAccountCode").val(data.otherFeeChartOfAccountCode);            
            $("#vendorInvoiceOtherFeeChartOfAccountName").val(data.otherFeeChartOfAccountName);            
            $("#vendorInvoiceOtherFeeDescription").val(data.otherFeeDescription);  
            $("#vendorInvoiceGrandTotalAmount").val(formatNumberVIN(data.grandTotalAmount));
        });
        
        $("#btnVendorInvoiceNew").click(function(ev){
            
            var urlPeriodClosing="security/data-protection-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var urlAuthority = "finance/vendor-invoice-authority";
                var paramAuthority = "actionAuthority=INSERT";

                $.post(urlAuthority, paramAuthority, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }else{
                        var url = "finance/vendor-invoice-input";
                        var params = "";
                        pageLoad(url, params, "#tabmnuVENDOR_INVOICE");   
                    }
                });
            });         
        });
        
        $('#btnVendorInvoiceUpdate').click(function(ev) {
            var url="security/data-protection-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#vendorInvoice_grid").jqGrid('getGridParam','selrow');
                var vendorInvoice = $("#vendorInvoice_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                    
                    var url = "finance/finance-document-existing";
                    var param_2 = "financeDocument.documentNo=" + vendorInvoice.code;

                    $.post(url,param_2,function(result){
                        var data=(result);
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }

                        if(data.listFinanceDocumentTemp.length>0){
                            var arrFinanceDocument=new Array();
                            for(var i=0;i<data.listFinanceDocumentTemp.length;i++){
                                arrFinanceDocument.push(data.listFinanceDocumentTemp[i].headerCode);
                            }

                            alertMessage("Cannot Update this Transaction since has been Paid!<br/><br/>Document Paid: "+arrFinanceDocument);
                            return;
                        }
                        
                        var url = "finance/finance-document-existing-payment-request";
                        var params = "financeDocument.documentNo=" + vendorInvoice.code;

                        $.post(url,params,function(result){
                            var data=(result);
                            if (data.error) {
                                alertMessage(data.errorMessage);
                                return;
                            }

                            if(data.listFinanceDocumentTemp.length>0){
                                var arrFinanceDocument=new Array();
                                for(var i=0;i<data.listFinanceDocumentTemp.length;i++){
                                    arrFinanceDocument.push(data.listFinanceDocumentTemp[i].headerCode);
                                }

                                alertMessage("Cannot Update this Transaction since has been Created Payment Request!<br/><br/>Document Created: "+arrFinanceDocument);
                                return;
                            }

                            var url = "finance/vendor-invoice-input";
                            var params = "vendorInvoiceUpdateMode=true" + "&vendorInvoice.code=" + vendorInvoice.code;
                            pageLoad(url, params, "#tabmnuVENDOR_INVOICE");
                        });
                    });                    
                
            });
            
            ev.preventDefault();
        });
        
        $('#btnVendorInvoiceDelete').click(function(ev) {
            
            var selectRowId = $("#vendorInvoice_grid").jqGrid('getGridParam','selrow');
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var urlPeriodClosing="security/data-protection-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var vendorInvoice = $("#vendorInvoice_grid").jqGrid("getRowData", selectRowId);
                
                var urlAuthority = "finance/vendor-invoice-authority";
                var paramAuthority = "actionAuthority=DELETE&vendorInvoice.code=" + vendorInvoice.code;
                
                $.post(urlAuthority,paramAuthority,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }else {
                        
                        var dynamicDialog= $(
                            '<div id="conformBoxError">'+
                            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>Are You Sure To Delete?<br/><br/>' +
                            '<span style="float:left; margin:0 7px 20px 0;">'+
                            '</span>VIN No: '+vendorInvoice.code+'<br/><br/>' +    
                            '</div>');
                        dynamicDialog.dialog({
                            title           : "Confirmation",
                            closeOnEscape   : false,
                            modal           : true,
                            width           : 300,
                            resizable       : false,
                            buttons         : 
                                            [{
                                                text : "Yes",
                                                click : function() {
                                                    var url = "finance/vendor-invoice-delete";
                                                    var params = "vendorInvoice.code=" + vendorInvoice.code;

                                                    $.post(url, params, function(data) {
                                                        if (data.error) {
                                                            alertMessage(data.errorMessage);
                                                            return;
                                                        }
                                                        alertMessage(data.message);
                                                        reloadGridVendorInvoice();
                                                        $("#vendorInvoice\\.totalTransactionAmount").val("0.00");
                                                        $("#vendorInvoice\\.discountPercent").val("0.00");
                                                        $("#vendorInvoice\\.discountAmount").val("0.00");
                                                        $("#purchaseOrderDiscountChartOfAccountCode").val("");          
                                                        $("#purchaseOrderDiscountChartOfAccountName").val("");            
                                                        $("#purchaseOrderDiscountChartOfAccountDescription").val(""); 
                                                        $("#vendorInvoice\\.downPaymentAmount").val("0.00");
                                                        $("#vendorInvoice\\.subTotal").val("0.00");
                                                        $("#vendorInvoice\\.vatPercent").val("0.00");
                                                        $("#vendorInvoice\\.vatAmount").val("0.00");
                                                        $("#purchaseOrderOtherFeeAmount").val("0.00");  
                                                        $("#purchaseOrderOtherFeeChartOfAccountCode").val("");            
                                                        $("#purchaseOrderOtherFeeChartOfAccountName").val("");            
                                                        $("#purchaseOrderOtherFeeChartOfAccountDescription").val("");  
                                                        $("#vendorInvoice\\.grandTotalAmount").val("0.00");
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
                        
                    }
                         
                });
                                 
            });
            ev.preventDefault();
        });
        
        $("#btnVendorInvoicePrint").click(function(ev) {
            var selectRowId = $("#vendorInvoice_grid").jqGrid('getGridParam','selrow');
            var vendorInvoice = $("#vendorInvoice_grid").jqGrid('getRowData', selectRowId);
            var grandTotalAmount1 = (Math.floor(vendorInvoice.grandTotalAmount)).toString();
            var arr = vendorInvoice.grandTotalAmount.split('.');
            var grandTotalAmount2 = arr[1];
            var url = "finance/vendor-invoice-print-out-pdf?";
            var params = "vinNo=" + vendorInvoice.code;
            params += "&bankReceivedTemp.terbilang=" + terbilangKoma(grandTotalAmount1,grandTotalAmount2,vendorInvoice.currencyName).trim();  
            window.open(url+params,'vendorInvoice','width=500,height=500');
        });
        
        $('#btnVendorInvoiceRefresh').click(function(ev) {
            var url = "finance/vendor-invoice";
            var params = "";
            pageLoad(url, params, "#tabmnuVENDOR_INVOICE");
        });
        
        
        $('#btnVendorInvoice_search').click(function(ev) {
            clearVendorInvoice();
            formatDateVendorInvoice();
            $("#vendorInvoiceItemDetail_grid").jqGrid("clearGridData");
            $("#vendorInvoiceGRNDetail_grid").jqGrid("clearGridData");
            $("#vendorInvoiceSDPDetail_grid").jqGrid("clearGridData");
            $("#vendorInvoice_grid").jqGrid("clearGridData");
            $("#vendorInvoice_grid").jqGrid("setGridParam",{url:"finance/vendor-invoice-data?" + $("#frmVendorInvoiceSearchInput").serialize()});
            $("#vendorInvoice_grid").trigger("reloadGrid");
            formatDateVendorInvoice();
            ev.preventDefault();
        });
    });
    
    function formatDateVendorInvoice(){
        var firstDate=$("#vendorInvoiceSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#vendorInvoiceSearchFirstDate").val(firstDateValue);

        var lastDate=$("#vendorInvoiceSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#vendorInvoiceSearchLastDate").val(lastDateValue);
        
        var dueFirstDate=$("#vendorInvoiceSearchFirstDueDate").val();
        var dueFirstDateValues= dueFirstDate.split('/');
        var dueFirstDateValue =dueFirstDateValues[1]+"/"+dueFirstDateValues[0]+"/"+dueFirstDateValues[2];
        $("#vendorInvoiceSearchFirstDueDate").val(dueFirstDateValue);
        
        var dueLastDate=$("#vendorInvoiceSearchLastDueDate").val();
        var dueLastDateValues= dueLastDate.split('/');
        var dueLastDateValue =dueLastDateValues[1]+"/"+dueLastDateValues[0]+"/"+dueLastDateValues[2];
        $("#vendorInvoiceSearchLastDueDate").val(dueLastDateValue);
    }
    
    function reloadGridVendorInvoice() {
        $("#vendorInvoice_grid").trigger("reloadGrid");
        $("#vendorInvoiceGRNDetail_grid").trigger("reloadGrid");
        $("#vendorInvoiceSDPDetail_grid").trigger("reloadGrid");
        $("#vendorInvoiceItemDetail_grid").trigger("reloadGrid");
        
        clearVendorInvoice();
    };
    
    function clearVendorInvoice(){
        $("#vendorInvoiceTotalTransactionAmount").val("0.00");
        $("#vendorInvoiceDiscountPercent").val("0.00");
        $("#vendorInvoiceDiscountAmount").val("0.00");
        $("#vendorInvoiceDiscountChartOfAccountCode").val("");          
        $("#vendorInvoiceDiscountChartOfAccountName").val("");            
        $("#vendorInvoiceDiscountDescription").val(""); 
        $("#vendorInvoiceDownPaymentAmount").val("0.00");
        $("#vendorInvoiceSubTotal").val("0.00");
        $("#vendorInvoiceVatPercent").val("0.00");
        $("#vendorInvoiceVatAmount").val("0.00");
        $("#vendorInvoiceOtherFeeAmount").val("0.00");  
        $("#vendorInvoiceOtherFeeChartOfAccountCode").val("");            
        $("#vendorInvoiceOtherFeeChartOfAccountName").val("");            
        $("#vendorInvoiceOtherFeeDescription").val("");  
        $("#vendorInvoiceGrandTotalAmount").val("0.00");
    }
    
   function formatNumberVIN(num) {
        var splitValue=num.split('.');
        var valueFormat;

        if(parseFloat(num) > 0.00){
            var concatValue=parseFloat(splitValue[0]+'.'+splitValue[1]);
            valueFormat=formatNumber(parseFloat(concatValue),2);
//            if(splitValue[0].length>3){
//                var concatValue=parseFloat(splitValue[0]+'.'+splitValue[1]);
//                valueFormat=formatNumber(parseFloat(concatValue),2);
//            }else{
//                valueFormat=splitValue[0]+'.'+splitValue[1];
//            }
        }else{
            var removeMinusValue=splitValue[0].toString().replace('-','');
            var concatValue=parseFloat(removeMinusValue+'.'+splitValue[1]);
            valueFormat="-"+formatNumber(parseFloat(concatValue),2);
            if(parseFloat(num)===0.00){
                valueFormat=valueFormat.replace('-','');
            }
        }
        return valueFormat;
    }
</script>

<s:url id="remoteurlVendorInvoice" action="vendor-invoice-data" />
<b>VENDOR INVOICE</b>
<hr>
<br class="spacer" />
 <sj:div id="vendorInvoiceButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnVendorInvoiceNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnVendorInvoiceUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnVendorInvoiceDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnVendorInvoiceRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnVendorInvoicePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
</sj:div>    
<div id="vendorInvoiceSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmVendorInvoiceSearchInput">
        <table cellpadding="2" cellspacing="2" width="70%">
            <tr>
                <td align="right">Period</td>
                <td>
                    <sj:datepicker id="vendorInvoiceSearchFirstDate" name="vendorInvoiceSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeYear="true" changeMonth="true" ></sj:datepicker>
                    To
                    <sj:datepicker id="vendorInvoiceSearchLastDate" name="vendorInvoiceSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeYear="true" changeMonth="true" ></sj:datepicker>
                </td>
                <td align="right">Due Date</td>
                <td>
                   <sj:datepicker id="vendorInvoiceSearchFirstDueDate" name="vendorInvoiceSearchFirstDueDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeYear="true" changeMonth="true" ></sj:datepicker>
                   To
                   <sj:datepicker id="vendorInvoiceSearchLastDueDate" name="vendorInvoiceSearchLastDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeYear="true" changeMonth="true" ></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right" valign="centre">Po No</td>
                <td>
                    <s:textfield id="vendorInvoiceSearchPurchaseOrderCode" name="vendorInvoiceSearchPurchaseOrderCode" size="34" placeHolder="Purchase Order No"></s:textfield>
                </td>
                <td align="right">Payment Term</td>
                <td>
                   <s:textfield id="vendorInvoiceSearchPaymentTerm" name="vendorInvoiceSearchPaymentTerm" size="20" displayFormat="dd/mm/yy" showOn="focus"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="centre">Code</td>
                <td>
                    <s:textfield id="vendorInvoiceSearchCode" name="vendorInvoiceSearchCode" size="34" placeHolder=" Code"></s:textfield>
                </td>
                <td align="right">Ref No</td>
                <td>
                   <s:textfield id="vendorInvoiceSearchRefno" name="vendorInvoiceSearchRefno" placeHolder=" RefNo" size="20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td>
                    <s:textfield id="vendorInvoiceSearchBranchCode" name="vendorInvoiceSearchBranchCode" placeHolder=" Code" size="15"></s:textfield>&nbsp;&nbsp;
                    <s:textfield id="vendorInvoiceSearchBranchName" name="vendorInvoiceSearchBranchName" placeHolder=" Name" size="16"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Vendor</td>
                <td>
                    <s:textfield id="vendorInvoiceSearchVendorCode" name="vendorInvoiceSearchVendorCode" size="15" placeHolder=" Code"></s:textfield>&nbsp;&nbsp;
                    <s:textfield id="vendorInvoiceSearchVendorName" name="vendorInvoiceSearchVendorName" size="16" placeHolder=" Name"></s:textfield>
                </td>
            </tr>
        </table>
        <br />
        <sj:a href="#" id="btnVendorInvoice_search" button="true">Search</sj:a>
        <br />
<!--        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
        </div>-->
    </s:form>
</div>
<br class="spacer" />  
<div id="vendorInvoiceGrid">
    <sjg:grid
        id="vendorInvoice_grid"
        dataType="json"
        caption="VENDOR INVOICE"
        href="%{remoteurlVendorInvoice}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listVendorInvoiceTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="vendorInvoice_grid_onSelect"
        width="$('#tabmnuVendorInvoice').width()"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="VIN No" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="purchaseOrderCode" index="purchaseOrderCode" key="purchaseOrderCode" title="PO No" width="125" sortable="true"
        />
        <sjg:gridColumn
             name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="120" formatter="date"  
            formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
        />
        <sjg:gridColumn
            name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="180" sortable="true"
        />
        <sjg:gridColumn
            name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="180" sortable="true"
        />
        <sjg:gridColumn
            name="contraBonDate" index="contraBonDate" key="contraBonDate" 
            formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s'}" 
            title="Contra Bon Date" width="125" search="false" sortable="true" align="center" hidden="true"
        />
        <sjg:gridColumn
            name="paymentTermCode" index="paymentTermCode" key="paymentTermCode" title="Payment Term" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="paymentType" index="paymentType" key="paymentType" title="Payment Type" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="dueDate" index="dueDate" key="dueDate" 
            formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s'}" 
            title="Due Date" width="125" search="false" sortable="true" align="center" hidden="true"
        />
        <sjg:gridColumn
            name="branchName" index="branchName" key="branchName" title="Branch" width="250" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" key="currencyName" title="Currency" width="180" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="exchangeRate" index="exchangeRate" key="exchangeRate" title="Exhange Rate" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="totalTransactionAmount" index="totalTransactionAmount" key="totalTransactionAmount" title="Total Transaction" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="discountPercent" index="discountPercent" key="discountPercent" title="Discount Percent" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="discountAmount" index="discountAmount" key="discountAmount" title="Discount Amount" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="discountChartOfAccountCode" title="discountChartOfAccountCode"  width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="discountChartOfAccountName" title="discountChartOfAccountName"   width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="discountDescription" title="discountDescription"  width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="downPaymentAmount" index="downPaymentAmount" key="downPaymentAmount" title="DP Amount" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="pphPercent" title="pphPercent"  width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="pphAmount" index="pphAmount" key="pphAmount"  title="pphAmount"  width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="pphChartOfAccountCode" title="pphChartOfAccountCode" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="pphChartOfAccountName" title="pphChartOfAccountName" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="pphDescription" title="pphDescription" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="taxBaseAmount" index="taxBaseAmount" key="taxBaseAmount" title="taxBaseAmount" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="vatPercent" index="vatPercent" key="vatPercent" title="vatPercent" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="vatPercent" index="vatPercent" key="vatPercent" title="vatPercent" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="vatAmount" index="vatAmount" key="vatAmount" title="vatAmount" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="otherFeeAmount" index="otherFeeAmount" key="otherFeeAmount" title="otherFeeAmount" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="otherFeeChartOfAccountCode" title="otherFeeChartOfAccountCode" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="otherFeeChartOfAccountName" title="otherFeeChartOfAccountName" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="otherFeeDescription" title="otherFeeDescription"  width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="grandTotalAmount" index="grandTotalAmount" key="grandTotalAmount" title="grandTotalAmount" width="150" sortable="true" hidden="true"
            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="vendorInvoiceDate" index="vendorInvoiceDate" key="vendorInvoiceDate" 
            formatter="date" formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}" 
            title="Vendor Invoice Date" width="125" search="false" sortable="true" align="center" hidden="true"
        />
         <sjg:gridColumn
            name="vendorInvoiceNo" index="vendorInvoiceNo" key="vendorInvoiceNo" 
            title="Vendor Invoice No" width="130" sortable="true"  align="left"  hidden="true"
        />
        <sjg:gridColumn
            name="vendorTaxInvoiceDate" index="vendorTaxInvoiceDate" key="vendorTaxInvoiceDate" 
            formatter="date" formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}" 
            title="Vendor Tax Invoice Date" width="125" search="false" sortable="true" align="center"  hidden="true"
        />
        <sjg:gridColumn
            name="vendorTaxInvoiceNo" index="vendorTaxInvoiceNo" key="vendorTaxInvoiceNo" 
            title="Vendor Tax Invoice No" width="130" sortable="true"  align="left" hidden="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="RefNo" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true"
        />
    </sjg:grid >
</div>
<br class="spacer" />
<div>
    <table valign="top" border="0" width="100%">
        <tr valign="top">
            <td valign="top" width="20%">
                <sjg:grid
                    id="vendorInvoiceGRNDetail_grid"
                    caption="GRN DETAIL"
                    dataType="json"
                    pager="true"
                    navigator="false"
                    navigatorSearch="false"
                    navigatorView="true"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listVendorInvoiceGoodsReceivedNoteTemp"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    onSelectRowTopics="vendorInvoiceGRNDetail_grid_onSelect"
                >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="GRN No" hidden="false" width="150" align="centre"
                />
                <sjg:gridColumn
                    name="transactionDate" index="transactionDate" key="transactionDate" 
                    title="GRN Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
                />
                </sjg:grid >
            </td>
            <td>
            <sjg:grid
                id="vendorInvoiceSDPDetail_grid"
                caption="VDP DETAIL"
                dataType="json"
                pager="true"
                navigator="false"
                navigatorSearch="false"
                navigatorView="true"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listVendorInvoiceVendorDownPaymentTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                onSelectRowTopics="vendorInvoiceDetail_grid_onSelect"
                width="780"
                >
                <sjg:gridColumn         
                    name="code" index="code" key="code" title="VDP-U No" width="150" sortable="true" hidden="false"
                />
                <sjg:gridColumn
                    name="transactionDate" index="transactionDate" key="transactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="exchangeRate" index="exchangeRate" key="exchangeRate" title="ExchangeRate" width="150" sortable="true" 
                    formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
                />
                <sjg:gridColumn
                    name="dpAmount" index="dpAmount" key="dpAmount" title="VDP Amount" width="150" sortable="true" 
                    formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" hidden="true"
                />
                <sjg:gridColumn
                    name="used" index="used" key="used" title="Used" width="150" sortable="true" 
                    formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" hidden="true"
                />
                <sjg:gridColumn
                    name="balance" index="balance" key="balance" title="Balance" width="150" sortable="true" 
                    formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right" hidden="true"
                />
                <sjg:gridColumn
                    name="applied" index="applied" key="applied" title="Applied" width="150" sortable="true" 
                    formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
                />
                </sjg:grid >
            </td>
        </tr>
    </table>
</div>
<br class="spacer" />  
<div id="vendorInvoiceItemDetailtGrid">
    <sjg:grid
        id="vendorInvoiceItemDetail_grid"
        dataType="json"
        caption="ITEM DETAIL"
        href="%{remoteurlVendorInvoiceItemDetail}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listVendorInvoiceItemDetailTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="vendorInvoiceItemDetail_grid_onSelect"
        width="$('#tabmnuVendorInvoice').width()"
    >
        <sjg:gridColumn
            name="goodsReceivedNoteDetailCode" index="goodsReceivedNoteDetailCode" key="goodsReceivedNoteDetailCode" title="GRN Detail Code" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Material Code" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Material Name" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="quantity" index="quantity" key="quantity" title="Quantity" width="100" sortable="true"
            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="price" index="price" key="price" title="Price" width="100" sortable="true"
            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="discountAmount" index="discountAmount" key="discountAmount" title="Disc Amount" width="100" sortable="true"
            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="discountPercent" index="discountPercent" key="discountPercent" title="Disc Percent" width="100" sortable="true"
            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="nettPrice" index="nettPrice" key="nettPrice" title="Nett Price" width="100" sortable="true"
            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="total" index="total" key="total" title="Total" width="100" sortable="true"
            formatter="number"  formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="UOM" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="itemBrandName" index="itemBrandName" key="itemBrandName" title="Brand" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="250" sortable="true"
        />
    </sjg:grid >
</div>
<table align="right">
    <tr>
    <td align="right" valign="top">
        <fieldset>
        <table width="100%">
        <tr>
            <td align="right"><B>Total Transaction</B></td>
            <td>
                <s:textfield id="vendorInvoiceTotalTransactionAmount" name="vendorInvoiceTotalTransactionAmount" size="20" readonly="true" cssStyle="text-align:right" value="0.00"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Discount</B>
                <s:textfield id="vendorInvoiceDiscountPercent" name="vendorInvoiceDiscountPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                    %
             </td>
            <td>
                <s:textfield id="vendorInvoiceDiscountAmount" name="vendorInvoiceDiscountAmount" size="20" readonly="true" cssStyle="text-align:right" value="0.00"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Discount Account</B>
              <td>    
                <s:textfield id="vendorInvoiceDiscountChartOfAccountCode" name="vendorInvoiceDiscountChartOfAccountCode" cssClass="field-low" readonly="true" PlaceHolder=" Discount Coa Code" cssStyle="text-align:right"></s:textfield>
              </td>
            <td>
                <s:textfield id="vendorInvoiceDiscountChartOfAccountName" name="vendorInvoiceDiscountChartOfAccountName" cssClass="field-medium"  readonly="true" PlaceHolder=" Discount Coa Name" size="20"></s:textfield>
            </td>
            <td>
                <s:textfield id="vendorInvoiceDiscountDescription" name="vendorInvoiceDiscountDescription" cssClass="field-medium" readonly="true" PlaceHolder=" Description Discount" size="20"></s:textfield>
            </td> 
        </tr>
        <tr>
            <td align="right"><b>Down Payment</b></td>
            <td colspan="2">
                <s:textfield id="vendorInvoiceDownPaymentAmount" name="vendorInvoiceDownPaymentAmount" size="20" cssStyle="text-align:right" readonly="true" value="0.00"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Sub Total (Tax Base)</B></td>
            <td>
                <s:textfield id="vendorInvoiceSubTotal" name="vendorInvoiceSubTotal" size="20" readonly="true" cssStyle="text-align:right" value="0.00"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>VAT</B>
            <s:textfield id="vendorInvoiceVatPercent" name="vendorInvoiceVatPercent" size="5" readonly="true" cssStyle="text-align:right" value="0.00"></s:textfield>
                %
            </td>
            <td>
                <s:textfield id="vendorInvoiceVatAmount" name="vendorInvoiceVatAmount" size="20" readonly="true" cssStyle="text-align:right" value="0.00"></s:textfield>
            </td>
        </tr>
        <tr>
            <td align="right"><B>Other Fee Amount</B></td>
            <td>    
                <s:textfield id="vendorInvoiceOtherFeeAmount" name="vendorInvoiceOtherFeeAmount" placeHolder="0.00" readonly="true" cssStyle="text-align:right;"></s:textfield>
            <td/>
            </tr>
            <tr>
            <td align="right"><B>Other Fee Account</B>
              <td>    
                <s:textfield id="vendorInvoiceOtherFeeChartOfAccountCode" name="vendorInvoiceOtherFeeChartOfAccountCode" cssClass="field-low" readonly="true" PlaceHolder=" Other Fee Coa Code" cssStyle="text-align:right"></s:textfield>
              </td>
            <td>
                <s:textfield id="vendorInvoiceOtherFeeChartOfAccountName" name="vendorInvoiceOtherFeeChartOfAccountName" cssClass="field-medium"  readonly="true" PlaceHolder=" Other Fee Coa Name" size="20"></s:textfield>
            </td>
            <td>
                <s:textfield id="vendorInvoiceOtherFeeDescription" name="vendorInvoiceOtherFeeDescription" cssClass="field-medium" readonly="true" PlaceHolder=" Description Other Fee" size="20"></s:textfield>
            </td> 
        </tr>
        <tr>
            <td align="right"><B>Grand Total</B></td>
            <td>
                <s:textfield id="vendorInvoiceGrandTotalAmount" name="vendorInvoiceGrandTotalAmount" size="20" readonly="true" cssStyle="text-align:right" value="0.00"></s:textfield>
            </td>
        </tr>
                </table>  
        </fieldset>
    </td>
    </tr>
</table>