
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #cashReceivedDetail_grid_pager_center{
        display: none;
    }
    #msgCashReceivedCashAccountFormatTotalAmount{
        color: green;
    }
</style>

<s:url id="remoteurlCashReceived" action="cash-received-json" />
<script type="text/javascript">  
    
    $(document).ready(function(){
        
        hoverButton();
        
        $("#msgCashReceivedCashAccountFormatTotalAmount").html(numberWithCommaCashReceived($("#cashReceivedSearchLastTotalAmount").val()));
        
        $("#cashReceivedSearchFirstTotalAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });

        $("#cashReceivedSearchFirstTotalAmount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgCashReceivedCashAccountFormatTotalAmount").html(numberWithCommaCashReceived(value).toString());
                return value;
            });
        });
        $("#cashReceivedSearchFirstTotalAmount").focus(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgCashReceivedCashAccountFormatTotalAmount").html(numberWithCommaCashReceived(value).toString());
                return value;
            });
        });
        $("#cashReceivedSearchFirstTotalAmount").focusout(function(e){
           $("#msgCashReceivedCashAccountFormatTotalAmount").html("");
        });
        
        $("#cashReceivedSearchFirstTotalAmount").change(function(e){
            if($("#cashReceivedSearchFirstTotalAmount").val()===""){
                $("#cashReceivedSearchFirstTotalAmount").val("0");
            }
            $("#msgCashReceivedCashAccountFormatTotalAmount").html("");
        });
        
        $("#cashReceivedSearchLastTotalAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        $("#cashReceivedSearchLastTotalAmount").focus(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgCashReceivedCashAccountFormatTotalAmount").html(numberWithCommaCashReceived(value).toString());
                return value;
            });
        });
        $("#cashReceivedSearchLastTotalAmount").focusout(function(e){
           $("#msgCashReceivedCashAccountFormatTotalAmount").html("");
        });
        $("#cashReceivedSearchLastTotalAmount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgCashReceivedCashAccountFormatTotalAmount").html(numberWithCommaCashReceived(value).toString());
                return value;
            });
        });
        
        $("#cashReceivedSearchLastTotalAmount").change(function(e){
            if($("#cashReceivedSearchLastTotalAmount").val()===""){
                $("#cashReceivedSearchLastTotalAmount").val("0");
            }
            $("#msgCashReceivedCashAccountFormatTotalAmount").html("");
        });
        
        $.subscribe("cashReceived_grid_onSelect", function(event, data){
            var selectedRowID = $("#CashReceived_grid").jqGrid("getGridParam", "selrow"); 
            var cashReceived = $("#CashReceived_grid").jqGrid("getRowData", selectedRowID);
            
            $("#cashReceivedDetail_grid").jqGrid("setGridParam",{url:"finance/cash-received-detail-data?cashReceived.code=" + cashReceived.code});
            $("#cashReceivedDetail_grid").jqGrid("setCaption", "CASH RECEIVED DETAIL : " + cashReceived.code);
            $("#cashReceivedDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnCashReceivedNew').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "finance/cash-received-input";
                var params = "";
                pageLoad(url, params, "#tabmnuCASH_RECEIVED");

            });
                    
        });
        
        $('#btnCashReceivedUpdate').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectRowId = $("#CashReceived_grid").jqGrid('getGridParam','selrow');
                var cashReceived = $("#CashReceived_grid").jqGrid("getRowData", selectRowId);
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var url = "finance/finance-document-existing";
                var params = "financeDocument.documentNo=" + cashReceived.code;
                
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
                        
                        alertMessage("Cannot Update this Transaction since has been Paid!<br/><br/>Document Paid: "+arrFinanceDocument);
                        return;
                    }
                    
                    var url = "finance/cash-received-input";
                    var params = "cashReceivedUpdateMode=true" + "&cashReceived.code=" + cashReceived.code;
                    pageLoad(url, params, "#tabmnuCASH_RECEIVED");
                });
            });              
        });
        
        $('#btnCashReceivedDelete').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#CashReceived_grid").jqGrid('getGridParam','selrow');
                var cashReceived = $("#CashReceived_grid").jqGrid('getRowData', selectedRowId);
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url = "finance/finance-document-existing";
                var params = "financeDocument.documentNo=" + cashReceived.code;
                
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
                        
                        alertMessage("Cannot Delete this Transaction since has been Paid!<br/><br/>Document Paid: "+arrFinanceDocument);
                        return;
                    }
                    
                    var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>BKM No: '+cashReceived.code+'<br/><br/>' +    
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
                                    var url = "finance/cash-received-delete";
                                    var params = "cashReceived.code=" + cashReceived.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridCashReceived();
                                        reloadGridCashReceivedDetailAfterDelete();
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
                
                
                
//                var url = "finance/cash-received-authority-delete";
//                var params ="actionAuthority=DELETE";

//                $.post(url, params, function(data) {
//                    if (data.error) {
//                        alertMessage("Cannot Delete this Transaction!<br/>"+data.errorMessage);
//                        return;
//                    }

//                    var dynamicDialog= $(
//                                    '<div id="conformBoxError">'+
//                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                                    '</span>Are You Sure To Delete?<br/><br/>' +
//                                    '<span style="float:left; margin:0 7px 20px 0;">'+
//                                    '</span>BKM No: '+cashReceived.code+'<br/><br/>' +    
//                                    '</div>');
//                        dynamicDialog.dialog({
//                            title : "Confirmation",
//                            closeOnEscape: false,
//                            modal : true,
//                            width: 300,
//                            resizable: false,
//                            buttons : 
//                                [{
//                                    text : "Yes",
//                                    click : function() {
//                                        var url = "finance/cash-received-delete";
//                                        var params = "cashReceived.code=" + cashReceived.code;
//                                        
//                                        $.post(url, params, function(data) {
//                                            if (data.error) {
//                                                alertMessage(data.errorMessage);
//                                                return;
//                                            }
//                                            reloadGridCashReceived();
//                                            reloadGridCashReceivedDetailAfterDelete();
//                                        });  
//                                        $(this).dialog("close");
//                                    }
//                                },
//                                {
//                                    text : "No",
//                                    click : function() {
//                                        $(this).dialog("close");                                       
//                                    }
//                                }]
//                        });
//                }); 
            });
        });

        $('#btnCashReceivedRefresh').click(function(ev) {
            var url = "finance/cash-received";
            var params = "";
            pageLoad(url, params, "#tabmnuCASH_RECEIVED");
            ev.preventDefault();   
        });
        
        
        $('#btnCashReceived_search').click(function(ev) {
            formatDateCashReceived();
            $("#CashReceived_grid").jqGrid("clearGridData");
            $("#CashReceived_grid").jqGrid("setGridParam",{url:"finance/cash-received-data?" + $("#frmCashReceivedSearchInput").serialize()});
            $("#CashReceived_grid").trigger("reloadGrid");
            $("#cashReceivedDetail_grid").jqGrid("clearGridData");
            $("#cashReceivedDetail_grid").jqGrid("setCaption", "CASH RECEIVED DETAIL");
            ev.preventDefault();
            formatDateCashReceived();
        });
        $("#btnCashReceivedPrint").click(function(ev) {
            var selectRowId = $("#CashReceived_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var cashReceived = $("#CashReceived_grid").jqGrid('getRowData', selectRowId);
            var url = "reports/finance/cash-received-print-out-pdf?";
            
            var grandTotalAmount1 = (Math.floor(cashReceived.totalTransactionAmount)).toString();
            var arr = cashReceived.totalTransactionAmount.split('.');
            var grandTotalAmount2 = arr[1];
               
            var params ="crNo=" + cashReceived.code;
            params += "&cashReceivedTemp.terbilang=" + terbilangKoma(grandTotalAmount1,grandTotalAmount2,cashReceived.currencyName);
         
            window.open(url+params,'cashReceived','width=500,height=500');
        });
    });
    
    function reloadGridCashReceived() {
        $("#CashReceived_grid").trigger("reloadGrid");
      
    };
    
    function reloadGridCashReceivedDetailAfterDelete() {
        $("#cashReceivedDetail_grid").jqGrid("clearGridData");
        $("#cashReceivedDetail_grid").jqGrid("setCaption", "CASH RECEIVED DETAIL");
    };
    
    function numberWithCommaCashReceived(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function formatDateCashReceived(){
        var firstDate=$("#cashReceivedSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#cashReceivedSearchFirstDate").val(firstDateValue);

        var lastDate=$("#cashReceivedSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#cashReceivedSearchLastDate").val(lastDateValue);
    }
</script>
    
    <b>CASH RECEIVED</b>
    <hr>
    <br class="spacer" />

    <sj:div id="CashReceivedButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCashReceivedNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCashReceivedUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCashReceivedDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCashReceivedRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCashReceivedPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
     </table>
    </sj:div>    
    <br class="spacer" />
    <br class="spacer" />

    <div id="CashReceivedInputSearch" class="content ui-widget">
        <s:form id="frmCashReceivedSearchInput">
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="cashReceivedSearchFirstDate" name="cashReceivedSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *<B/>
                        <sj:datepicker id="cashReceivedSearchLastDate" name="cashReceivedSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td> 
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="cashReceivedSearchCode" name="cashReceivedSearchCode" size="25" PlaceHolder=" BKMNo"></s:textfield>
                    </td>
                    <td align="right">Received From</td>
                    <td>
                        <s:textfield id="cashReceivedSearchReceivedFrom" name="cashReceivedSearchReceivedFrom" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="cashReceivedSearchRemark" name="cashReceivedSearchRemark" size="34"></s:textfield>
                    </td>
                    <td align="right">Cash Account</td>
                    <td>
                        <s:textfield id="cashReceivedCashAccountSearchCode" name="cashReceivedCashAccountSearchCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="cashReceivedCashAccountSearchName" name="cashReceivedCashAccountSearchName" cssStyle="width:40%" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Total Amount</td>
                    <td colspan="4">
                        <s:textfield id="cashReceivedSearchFirstTotalAmount" name="cashReceivedSearchFirstTotalAmount" size="15" cssStyle="text-align:right" placeholder=" 0.00"></s:textfield>
                        <B>To *</B>
                        <s:textfield id="cashReceivedSearchLastTotalAmount" name="cashReceivedSearchLastTotalAmount" size="15" cssStyle="text-align:right" placeholder=" 0.00"></s:textfield>
                        <span id="msgCashReceivedCashAccountFormatTotalAmount"></span>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnCashReceived_search" button="true">Search</sj:a>
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="CashReceivedGrid">
        <sjg:grid
            id="CashReceived_grid"
            caption="CASH RECEIVED"
            dataType="json"
            href="%{remoteurlCashReceived}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCashReceivedTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucashreceived').width()"
            onSelectRowTopics="cashReceived_grid_onSelect"
        >
            <sjg:gridColumn
                name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" title = "Branch" width = "50" sortable = "true" hidden="true" align="center"
            />
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true" 
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="120" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                align="center"
            />
            <sjg:gridColumn
                name="cashAccountCode" index="cashAccountCode" key="cashAccountCode" title="Cash Account" width="100" sortable="true" align="left"
            />
            <sjg:gridColumn
                name="cashAccountName" index="cashAccountName" key="cashAccountName" title="Cash Account Name" width="125" sortable="true" align="left"
            />
            <sjg:gridColumn
                name="receivedFrom" index="receivedFrom" key="receivedFrom" title="ReceivedFrom" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
            />
            <sjg:gridColumn
                name = "totalTransactionAmount" index = "totalTransactionAmount" key = "totalTransactionAmount" title = "Total Amount" width = "100" sortable = "false" 
                formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="150" sortable="true"  align="left"
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="80" sortable="true" align="center"
            />
            <sjg:gridColumn
                name="currencyName" index="currencyName" key="currencyName" title="Currency Name" width="100" sortable="true" align="center"
            />
            <sjg:gridColumn
                name = "exchangeRate" index = "exchangeRate" key = "exchangeRate" title = "Exchange Rate" width = "100" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="transactionType" index="transactionType" key="transactionType" title="Type" width="100" sortable="true" align="left"
            />
        </sjg:grid >
    </div>
    
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="cashReceivedDetailGrid">
        <sjg:grid
            id="cashReceivedDetail_grid"
            caption="CASH RECEIVED DETAIL"
            dataType="json"
            pager="true"
            navigator="true"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCashReceivedDetailTemp"
            width="$('#tabmnucashreceiveddetail').width()"
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
                name = "documentType" id="documentType" index = "documentType" key = "documentType" title = "Type" width = "60" sortable = "true"  align="center"
            />
           
            <sjg:gridColumn
                name = "transactionStatus" id="transactionStatus" index = "transactionStatus" key = "transactionStatus" title = "TransactionStatus" width = "150" sortable = "true" align="center" 
            />
            <sjg:gridColumn
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "Chart Of Account Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "Chart Of Account Name" width = "300" sortable = "true"
            />
            <sjg:gridColumn
                name = "debitIDR" id="debitIDR" index = "debitIDR" key = "debitIDR" 
                title = "Debit IDR" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            
            <sjg:gridColumn
                name = "creditIDR" id="creditIDR" index = "creditIDR" key = "creditIDR" 
                title = "Credit IDR" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
          
             <sjg:gridColumn
                name = "currencyCode" id="currencyCode" index = "currencyCode" key = "currencyCode" title = "Currency" width = "80" sortable = "true"  align="center"
            />
            <sjg:gridColumn
                name = "exchangeRate" id="exchangeRate" index = "exchangeRate" key = "exchangeRate" 
                title = "Exchange Rate" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
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
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    <br class="spacer" />
    


