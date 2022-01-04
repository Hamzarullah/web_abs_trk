
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #cashPaymentDetail_grid_pager_center{
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
        
        $.subscribe("cashPayment_grid_onSelect", function(event, data){
            var selectedRowID = $("#cashPayment_grid").jqGrid("getGridParam", "selrow"); 
            var cashPayment = $("#cashPayment_grid").jqGrid("getRowData", selectedRowID);
            
            $("#cashPaymentRequest_grid").jqGrid("setGridParam",{url:"finance/cash-payment-payment-request-data?cashPayment.code=" + cashPayment.code});
            $("#cashPaymentRequest_grid").jqGrid("setCaption", "CASH PAYMENT PAYMENT REQUEST : " + cashPayment.code);
            $("#cashPaymentRequest_grid").trigger("reloadGrid");
            $("#cashPaymentDetail_grid").jqGrid("setGridParam",{url:"finance/cash-payment-detail-data?cashPayment.code=" + cashPayment.code});
            $("#cashPaymentDetail_grid").jqGrid("setCaption", "CASH PAYMENT DETAIL : " + cashPayment.code);
            $("#cashPaymentDetail_grid").trigger("reloadGrid");
        });
        
      
        $('#btnCashPaymentNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "finance/cash-payment-input";
                var params = "";
                pageLoad(url, params, "#tabmnuCASH_PAYMENT"); 

            });       
        });
        
        $('#btnCashPaymentUpdate').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#cashPayment_grid").jqGrid('getGridParam','selrow');
                var cashPayment = $("#cashPayment_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="finance/cash-payment-confirmation";
                var params="cashPayment.code="+cashPayment.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "finance/finance-document-existing";
                    var param_2 = "financeDocument.documentNo=" + cashPayment.code;

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
                        var params = "financeDocument.documentNo=" + cashPayment.code;

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

                            var url = "finance/cash-payment-input";
                            var params = "cashPaymentUpdateMode=true" + "&cashPayment.code=" + cashPayment.code;
                            pageLoad(url, params, "#tabmnuCASH_PAYMENT");
                        });
                    });                    
                });
            });
            
            ev.preventDefault();
        });
        
        $('#btnCashPaymentDelete').click(function(ev) {
                        
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#cashPayment_grid").jqGrid('getGridParam','selrow');
                var cashPayment = $("#cashPayment_grid").jqGrid('getRowData', selectedRowId);
                
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
            
                var url="finance/cash-payment-confirmation";
                var params="cashPayment.code="+cashPayment.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Delete this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "finance/finance-document-existing";
                    var params_2 = "financeDocument.documentNo=" + cashPayment.code;

                    $.post(url,params_2,function(result){
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

                            alertMessage("Cannot Delete this Transaction since has been Paid!<br/><br/>Document Paid: "+arrFinanceDocument);
                            return;
                        }
                        
                        var url = "finance/finance-document-existing-payment-request";
                        var params = "financeDocument.documentNo=" + cashPayment.code;

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

                                alertMessage("Cannot Delete this Transaction since has been Created Payment Request!<br/><br/>Document Created: "+arrFinanceDocument);
                                return;
                            }

                            var dynamicDialog= $(
                                '<div id="conformBoxError">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                '</span>Are You Sure To Delete?<br/><br/>' +
                                '<span style="float:left; margin:0 7px 20px 0;">'+
                                '</span>BBK No: '+cashPayment.code+'<br/><br/>' +    
                                '</div>');
                            dynamicDialog.dialog({
                                title : "Confirmation",
                                closeOnEscape: false,
                                modal : true,
                                width: 300,
                                resizable: false,
                                buttons : 
                                    [{
                                        text : "Yes",
                                        click : function() {
                                            var url = "finance/cash-payment-delete";
                                            var params_3 = "cashPayment.code=" + cashPayment.code;

                                            $.post(url, params_3, function(data) {
                                                if (data.error) {
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                                reloadGridCashPayment();
                                                reloadGridCashPaymentDetailAfterDelete();
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
                    });
                    
//                    var dynamicDialog= $(
//                        '<div id="conformBoxError">'+
//                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                        '</span>Are You Sure To Delete?<br/><br/>' +
//                        '<span style="float:left; margin:0 7px 20px 0;">'+
//                        '</span>BBK No: '+cashPayment.code+'<br/><br/>' +    
//                        '</div>');
//                    dynamicDialog.dialog({
//                        title : "Confirmation",
//                        closeOnEscape: false,
//                        modal : true,
//                        width: 300,
//                        resizable: false,
//                        buttons : 
//                            [{
//                                text : "Yes",
//                                click : function() {
//                                    var url = "finance/cash-payment-delete";
//                                    var params = "cashPayment.code=" + cashPayment.code;
//
//                                    $.post(url, params, function(data) {
//                                        if (data.error) {
//                                            alertMessage(data.errorMessage);
//                                            return;
//                                        }
//                                        reloadGridCashPayment();
//                                        reloadGridCashPaymentDetailAfterDelete();
//                                    });  
//                                    $(this).dialog("close");
//                                }
//                            },
//                            {
//                                text : "No",
//                                click : function() {
//                                    $(this).dialog("close");                                       
//                                }
//                            }]
//                    });
                    
                });
            });    
            ev.preventDefault();
        });

        $('#btnCashPaymentRefresh').click(function(ev) {
            var url = "finance/cash-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuCASH_PAYMENT");
            ev.preventDefault();   
        });
        
        
        $('#btnCashPayment_search').click(function(ev) {
            formatDateCashPayment();
            $("#cashPayment_grid").jqGrid("clearGridData");
            $("#cashPayment_grid").jqGrid("setGridParam",{url:"finance/cash-payment-data?" + $("#frmCashPaymentSearchInput").serialize()});
            $("#cashPayment_grid").trigger("reloadGrid");
            $("#cashPaymentRequest_grid").jqGrid("clearGridData");
            $("#cashPaymentRequest_grid").jqGrid("setCaption", "CASH PAYMENT PAYMENT REQUEST");
            $("#cashPaymentDetail_grid").jqGrid("clearGridData");
            $("#cashPaymentDetail_grid").jqGrid("setCaption", "CASH PAYMENT DETAIL");
            formatDateCashPayment();
            ev.preventDefault();
           
        });
        
        $("#btnCashPaymentPrint").click(function(ev) {
            var selectRowId = $("#cashPayment_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var cashPayment = $("#cashPayment_grid").jqGrid('getRowData', selectRowId);   
            var url = "finance/cash-payment-print-out-pdf?";
//            var grandTotalAmount1 = (Math.floor(cashPayment.paymentRequestTotalTransactionAmount)).toString();
//            var arr = cashPayment.paymentRequestTotalTransactionAmount.split('.');
//            var grandTotalAmount2 = arr[1];
            var params ="cpNo=" + cashPayment.code;
//             params += "&cashReceivedTemp.terbilang=" + terbilangKoma(grandTotalAmount1,grandTotalAmount2,cashPayment.currencyName);
            window.open(url+params,'cashPayment','width=500,height=500');
            ev.preventDefault();
        });
        
    });//EOF Ready
    
    function reloadGridCashPayment() {
        $("#cashPayment_grid").trigger("reloadGrid");  
    };
    
    function reloadGridCashPaymentDetailAfterDelete() {
        $("#cashPaymentRequest_grid").jqGrid("clearGridData");
        $("#cashPaymentRequest_grid").jqGrid("setCaption", "CASH PAYMENT PAYMENT REQUEST");
        $("#cashPaymentDetail_grid").jqGrid("clearGridData");
        $("#cashPaymentDetail_grid").jqGrid("setCaption", "CASH PAYMENT DETAIL");
    };
        
    function formatDateCashPayment(){
        var firstDate=$("#cashPaymentSearchTemp\\.firstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#cashPaymentSearchTemp\\.firstDate").val(firstDateValue);

        var lastDate=$("#cashPaymentSearchTemp\\.lastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#cashPaymentSearchTemp\\.lastDate").val(lastDateValue);
    }
    
</script>
   
<s:url id="remoteurlCashPayment" action="cash-payment-data" />

    <b>CASH PAYMENT</b>
    <hr>
    <br class="spacer" />
    <sj:div id="CashPaymentButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
        <tr>
            <td><a href="#" id="btnCashPaymentNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" /><br/>New</a>
            </td>    
            <td><a href="#" id="btnCashPaymentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" /><br/>Update</a>
            </td>
            <td><a href="#" id="btnCashPaymentDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" /><br/>Delete</a>
            </td>    
            <td><a href="#" id="btnCashPaymentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" /><br/>Refresh</a>
            </td>    
            <td><a href="#" id="btnCashPaymentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" /><br/>Print</a>
            </td>    
        </tr>
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="CashPaymentInputSearch" class="content ui-widget">
        <s:form id="frmCashPaymentSearchInput">
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="cashPaymentSearchTemp.firstDate" name="cashPaymentSearchTemp.firstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="cashPaymentSearchTemp.lastDate" name="cashPaymentSearchTemp.lastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="cashPaymentSearchTemp.code" name="cashPaymentSearchTemp.code" size="22" PlaceHolder=" BKKNo"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="cashPaymentSearchTemp.refNo" name="cashPaymentSearchTemp.refNo" size="34"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="cashPaymentSearchTemp.remark" name="cashPaymentSearchTemp.remark" size="34"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnCashPayment_search" button="true">Search</sj:a>
            <br class="spacer" />
             
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="CashPaymentGrid">
        <sjg:grid
            id="cashPayment_grid"
            caption="CASH PAYMENT"
            dataType="json"
            href="%{remoteurlCashPayment}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCashPaymentTemp"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucashpayment').width()"
            onSelectRowTopics="cashPayment_grid_onSelect"
        >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch" width = "100" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="CP No" width="120" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true" align="center"
        />
        <sjg:gridColumn
            name = "exchangeRate" index = "exchangeRate" key = "exchangeRate" title = "Exchange Rate" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="transactionType" index="transactionType" key="transactionType" title="Payment Type" width="120" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
        </sjg:grid >
    </div>
                       
    <!-- GRID PAYMENT REQUEST -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="cashPaymentRequestGrid">
        <sjg:grid
            id="cashPaymentRequest_grid"
            caption="CASH PAYMENT PAYMENT REQUEST"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCashPaymentDetailPaymentRequestTemp"
            width="$('#tabmnucashpayment').width()"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name = "code" id="code" index = "code" key = "code" title = "PYM-RQ No" width = "100" sortable = "true"
            />
            <sjg:gridColumn
                name="paymentRequestTransactionDate" index="paymentRequestTransactionDate" key="paymentRequestTransactionDate" 
                formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   
                title="Transaction Date" width="130" search="false" sortable="true" align="center"
            />
            <sjg:gridColumn
                name = "paymentRequestCurrencyCode" id="paymentRequestCurrencyCode" index = "paymentRequestCurrencyCode" 
                key = "paymentRequestCurrencyCode" title = "Currency" width = "80" sortable = "true"  align="center"
            />
            <sjg:gridColumn
                name = "paymentRequestTotalTransactionAmount" id="paymentRequestTotalTransactionAmount" index = "paymentRequestTotalTransactionAmount" 
                key = "paymentRequestTotalTransactionAmount" title = "Total Transaction Amount" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "paymentRequestTransactionType" id="paymentRequestTransactionType" index = "paymentRequestTransactionType" key = "paymentRequestTransactionType" 
                title = "Type" width = "150" sortable = "true" align="center" 
            />
            <sjg:gridColumn
                name = "paymentRequestRefNo" id="paymentRequestRefNo" index = "paymentRequestRefNo" key = "paymentRequestRefNo" 
                title = "Ref No" width = "200" sortable = "true"
            />
            <sjg:gridColumn
                name = "paymentRequestRemark" id="paymentRequestRemark" index = "paymentRequestRemark" key = "paymentRequestRemark" 
                title = "Remark" width = "150" sortable = "true"
            />
        </sjg:grid >
                       
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="cashPaymentDetailGrid">
        <sjg:grid
            id="cashPaymentDetail_grid"
            caption="CASH PAYMENT DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCashPaymentDetailTemp"
            width="$('#tabmnucashpayment').width()"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "true" hidden="true" 
            />
            <sjg:gridColumn
                name = "documentNo" id="documentNo" index = "documentNo" key = "documentNo" title = "Document No" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "COA Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "COA Name" width = "200" sortable = "true"
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
                name = "documentAmount" id="documentAmount" index = "documentAmount" key = "documentAmount" 
                title = "Amount (Foreign)" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "documentAmountIDR" id="documentAmountIDR" index = "documentAmountIDR" key = "documentAmountIDR" 
                title = "Amount (IDR)" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "documentBalanceAmount" id="documentBalanceAmount" index = "documentBalanceAmount" key = "documentBalanceAmount" 
                title = "Balance (Foreign)" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "documentBalanceAmountIDR" id="documentBalanceAmountIDR" index = "documentBalanceAmountIDR" key = "documentBalanceAmountIDR" 
                title = "Balance (IDR)" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "debit" id="debit" index = "debit" key = "debit" 
                title = "Debit" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "debitIDR" id="debitIDR" index = "debitIDR" key = "debitIDR" 
                title = "Debit IDR" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "credit" id="credit" index = "credit" key = "credit" 
                title = "Credit" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "creditIDR" id="creditIDR" index = "creditIDR" key = "creditIDR" 
                title = "Credit IDR" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
        </sjg:grid >
        <br class="spacer" />
    </div> 