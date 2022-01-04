
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #bankPaymentDetail_grid_pager_center{
        display: none;
    }
    #msgBankAccountFormatTotalAmount{
        color: green;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                     
    $(document).ready(function(){
        
        hoverButton();
        
        $.subscribe("bankPayment_grid_onSelect", function(event, data){
            var selectedRowID = $("#bankPayment_grid").jqGrid("getGridParam", "selrow"); 
            var bankPayment = $("#bankPayment_grid").jqGrid("getRowData", selectedRowID);
            
            $("#bankPaymentRequest_grid").jqGrid("setGridParam",{url:"finance/bank-payment-payment-request-data?bankPayment.code=" + bankPayment.code});
            $("#bankPaymentRequest_grid").jqGrid("setCaption", "BANK PAYMENT PAYMENT REQUEST : " + bankPayment.code);
            $("#bankPaymentRequest_grid").trigger("reloadGrid");
            $("#bankPaymentDetail_grid").jqGrid("setGridParam",{url:"finance/bank-payment-detail-data?bankPayment.code=" + bankPayment.code});
            $("#bankPaymentDetail_grid").jqGrid("setCaption", "BANK PAYMENT DETAIL : " + bankPayment.code);
            $("#bankPaymentDetail_grid").trigger("reloadGrid");
        });
        
      
        $('#btnBankPaymentNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "finance/bank-payment-input";
                var params = "";
                pageLoad(url, params, "#tabmnuBANK_PAYMENT"); 

            });       
        });
        
        $('#btnBankPaymentUpdate').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#bankPayment_grid").jqGrid('getGridParam','selrow');
                var bankPayment = $("#bankPayment_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="finance/bank-payment-confirmation";
                var params="bankPayment.code="+bankPayment.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "finance/finance-document-existing";
                    var param_2 = "financeDocument.documentNo=" + bankPayment.code;

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
                        var params = "financeDocument.documentNo=" + bankPayment.code;

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

                            var url = "finance/bank-payment-input";
                            var params = "bankPaymentUpdateMode=true" + "&bankPayment.code=" + bankPayment.code;
                            pageLoad(url, params, "#tabmnuBANK_PAYMENT");
                        });
                    });                    
                });
            });
            
            ev.preventDefault();
        });
        
        $('#btnBankPaymentDelete').click(function(ev) {
                        
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#bankPayment_grid").jqGrid('getGridParam','selrow');
                var bankPayment = $("#bankPayment_grid").jqGrid('getRowData', selectedRowId);
                
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
            
                var url="finance/bank-payment-confirmation";
                var params="bankPayment.code="+bankPayment.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Delete this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "finance/finance-document-existing";
                    var params_2 = "financeDocument.documentNo=" + bankPayment.code;

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
                        var params = "financeDocument.documentNo=" + bankPayment.code;

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
                                '</span>BBK No: '+bankPayment.code+'<br/><br/>' +    
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
                                            var url = "finance/bank-payment-delete";
                                            var params_3 = "bankPayment.code=" + bankPayment.code;

                                            $.post(url, params_3, function(data) {
                                                if (data.error) {
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                                reloadGridBankPayment();
                                                reloadGridBankPaymentDetailAfterDelete();
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
//                        '</span>BBK No: '+bankPayment.code+'<br/><br/>' +    
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
//                                    var url = "finance/bank-payment-delete";
//                                    var params = "bankPayment.code=" + bankPayment.code;
//
//                                    $.post(url, params, function(data) {
//                                        if (data.error) {
//                                            alertMessage(data.errorMessage);
//                                            return;
//                                        }
//                                        reloadGridBankPayment();
//                                        reloadGridBankPaymentDetailAfterDelete();
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

        $('#btnBankPaymentRefresh').click(function(ev) {
            var url = "finance/bank-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuBANK_PAYMENT");
            ev.preventDefault();   
        });
        
        
        $('#btnBankPayment_search').click(function(ev) {
            formatDateBankPayment();
            $("#bankPayment_grid").jqGrid("clearGridData");
            $("#bankPayment_grid").jqGrid("setGridParam",{url:"finance/bank-payment-data?" + $("#frmBankPaymentSearchInput").serialize()});
            $("#bankPayment_grid").trigger("reloadGrid");
            $("#bankPaymentRequest_grid").jqGrid("clearGridData");
            $("#bankPaymentRequest_grid").jqGrid("setCaption", "BANK PAYMENT PAYMENT REQUEST");
            $("#bankPaymentDetail_grid").jqGrid("clearGridData");
            $("#bankPaymentDetail_grid").jqGrid("setCaption", "BANK PAYMENT DETAIL");
            formatDateBankPayment();
            ev.preventDefault();
           
        });
        
        $("#btnBankPaymentPrint").click(function(ev) {
            var selectRowId = $("#bankPayment_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var bankPayment = $("#bankPayment_grid").jqGrid('getRowData', selectRowId);   
            var url = "finance/bank-payment-print-out-pdf?";
            var params ="bpNo=" + bankPayment.code;
            window.open(url+params,'bankPayment','width=500,height=500');
            ev.preventDefault();
        });
        
    });//EOF Ready
    
    function reloadGridBankPayment() {
        $("#bankPayment_grid").trigger("reloadGrid");  
    };
    
    function reloadGridBankPaymentDetailAfterDelete() {
        $("#bankPaymentRequest_grid").jqGrid("clearGridData");
        $("#bankPaymentRequest_grid").jqGrid("setCaption", "BANK PAYMENT PAYMENT REQUEST");
        $("#bankPaymentDetail_grid").jqGrid("clearGridData");
        $("#bankPaymentDetail_grid").jqGrid("setCaption", "BANK PAYMENT DETAIL");
    };
        
    function formatDateBankPayment(){
        var firstDate=$("#bankPaymentSearchTemp\\.firstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#bankPaymentSearchTemp\\.firstDate").val(firstDateValue);

        var lastDate=$("#bankPaymentSearchTemp\\.lastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#bankPaymentSearchTemp\\.lastDate").val(lastDateValue);
    }
    
</script>
   
<s:url id="remoteurlBankPayment" action="bank-payment-data" />

    <b>BANK PAYMENT</b>
    <hr>
    <br class="spacer" />
    <sj:div id="BankPaymentButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnBankPaymentNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnBankPaymentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnBankPaymentDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnBankPaymentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnBankPaymentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="BankPaymentInputSearch" class="content ui-widget">
        <s:form id="frmBankPaymentSearchInput">
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="bankPaymentSearchTemp.firstDate" name="bankPaymentSearchTemp.firstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="bankPaymentSearchTemp.lastDate" name="bankPaymentSearchTemp.lastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="bankPaymentSearchTemp.code" name="bankPaymentSearchTemp.code" size="22" PlaceHolder=" BBKNo"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="bankPaymentSearchTemp.refNo" name="bankPaymentSearchTemp.refNo" size="34"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="bankPaymentSearchTemp.remark" name="bankPaymentSearchTemp.remark" size="34"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnBankPayment_search" button="true">Search</sj:a>
            <br class="spacer" />
             
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="BankPaymentGrid">
        <sjg:grid
            id="bankPayment_grid"
            caption="BANK PAYMENT"
            dataType="json"
            href="%{remoteurlBankPayment}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankPaymentTemp"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubankpayment').width()"
            onSelectRowTopics="bankPayment_grid_onSelect"
        >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch" width = "100" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="BP No" width="120" sortable="true" 
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

    <div id="bankPaymentRequestGrid">
        <sjg:grid
            id="bankPaymentRequest_grid"
            caption="BANK PAYMENT PAYMENT REQUEST"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankPaymentDetailPaymentRequestTemp"
            width="$('#tabmnubankpayment').width()"
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

    <div id="bankPaymentDetailGrid">
        <sjg:grid
            id="bankPaymentDetail_grid"
            caption="BANK PAYMENT DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankPaymentDetailTemp"
            width="$('#tabmnubankpayment').width()"
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