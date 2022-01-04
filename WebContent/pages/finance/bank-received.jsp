
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #bankReceivedDetail_grid_pager_center{
        display: none;
    }
    #msgBankReceivedBankAccountFormatTotalAmount{
        color: green;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                     
    $(document).ready(function(){
        
        hoverButton();
        
        $("#msgBankReceivedBankAccountFormatTotalAmount").html(numberWithCommaBankReceived($("#bankReceivedSearchLastTotalAmount").val()));
        
        $("#bankReceivedSearchFirstTotalAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });

        $("#bankReceivedSearchFirstTotalAmount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgBankReceivedBankAccountFormatTotalAmount").html(numberWithCommaBankReceived(value).toString());
                return value;
            });
        });
        $("#bankReceivedSearchFirstTotalAmount").focus(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgBankReceivedBankAccountFormatTotalAmount").html(numberWithCommaBankReceived(value).toString());
                return value;
            });
        });
        $("#bankReceivedSearchFirstTotalAmount").focusout(function(e){
           $("#msgBankReceivedBankAccountFormatTotalAmount").html("");
        });
        
        $("#bankReceivedSearchFirstTotalAmount").change(function(e){
            if($("#bankReceivedSearchFirstTotalAmount").val()===""){
                $("#bankReceivedSearchFirstTotalAmount").val("0");
            }
            $("#msgBankReceivedBankAccountFormatTotalAmount").html("");
        });
        
        $("#bankReceivedSearchLastTotalAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        $("#bankReceivedSearchLastTotalAmount").focus(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgBankReceivedBankAccountFormatTotalAmount").html(numberWithCommaBankReceived(value).toString());
                return value;
            });
        });
        $("#bankReceivedSearchLastTotalAmount").focusout(function(e){
           $("#msgBankReceivedBankAccountFormatTotalAmount").html("");
        });
        $("#bankReceivedSearchLastTotalAmount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                $("#msgBankReceivedBankAccountFormatTotalAmount").html(numberWithCommaBankReceived(value).toString());
                return value;
            });
        });
        
        $("#bankReceivedSearchLastTotalAmount").change(function(e){
            if($("#bankReceivedSearchLastTotalAmount").val()===""){
                $("#bankReceivedSearchLastTotalAmount").val("0");
            }
            $("#msgBankReceivedBankAccountFormatTotalAmount").html("");
        });
        
        $.subscribe("bankReceived_grid_onSelect", function(event, data){
            var selectedRowID = $("#bankReceived_grid").jqGrid("getGridParam", "selrow"); 
            var bankReceived = $("#bankReceived_grid").jqGrid("getRowData", selectedRowID);
            
            $("#bankReceivedDetail_grid").jqGrid("setGridParam",{url:"finance/bank-received-detail-data?bankReceived.code=" + bankReceived.code});
            $("#bankReceivedDetail_grid").jqGrid("setCaption", "BANK RECEIVED DETAIL : "+bankReceived.code);
            $("#bankReceivedDetail_grid").trigger("reloadGrid");
        });
        
      
        $('#btnBankReceivedNew').click(function(ev) {
//            var url="finance/period-closing-confirmation";
//            var params="";
//
//            $.post(url,params,function(result){
//                var data=(result);
//                if (data.error) {
//                    alertMessage(data.errorMessage);
//                    return;
//                }

                var url = "finance/bank-received-input";
                var params = "";
                pageLoad(url, params, "#tabmnuBANK_RECEIVED"); 

//            });       
        });
        
        $('#btnBankReceivedUpdate').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#bankReceived_grid").jqGrid('getGridParam','selrow');
                var bankReceived = $("#bankReceived_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url = "finance/finance-document-existing";
                var params = "financeDocument.documentNo=" + bankReceived.code;
                
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
                    
                    var url = "finance/bank-received-input";
                    var params = "bankReceivedUpdateMode=true" + "&bankReceived.code=" + bankReceived.code;
                    pageLoad(url, params, "#tabmnuBANK_RECEIVED");
                });
            });
            
            ev.preventDefault();
        });
        
        $('#btnBankReceivedDelete').click(function(ev) {            
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#bankReceived_grid").jqGrid('getGridParam','selrow');
                var bankReceived = $("#bankReceived_grid").jqGrid('getRowData', selectedRowId);
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url = "finance/finance-document-existing";
                var params = "financeDocument.documentNo=" + bankReceived.code;
                
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
                        '</span>BBM No: '+bankReceived.code+'<br/><br/>' +    
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
                                    var url = "finance/bank-received-delete";
                                    var params = "bankReceived.code=" + bankReceived.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridBankReceived();
                                        reloadGridBankReceivedDetailAfterDelete();
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
                
                
                
                
//                var url = "finance/bank-received-authority-delete";
//                var params ="actionAuthority=DELETE";
//
//                $.post(url, params, function(data) {
//                    if (data.error) {
//                        alertMessage("Cannot Delete this Transaction!<br/>"+data.errorMessage);
//                        return;
//                    }
//                    
//                    
//                });
            });    
            ev.preventDefault();
        });

        $('#btnBankReceivedRefresh').click(function(ev) {
            var url = "finance/bank-received";
            var params = "";
            pageLoad(url, params, "#tabmnuBANK_RECEIVED");
            ev.preventDefault();   
        });
        
        
        $('#btnBankReceived_search').click(function(ev) {
            formatDateBankReceived();
            $("#bankReceived_grid").jqGrid("clearGridData");
            $("#bankReceived_grid").jqGrid("setGridParam",{url:"finance/bank-received-data?" + $("#frmBankReceivedSearchInput").serialize()});
            $("#bankReceived_grid").trigger("reloadGrid");
            $("#bankReceivedDetail_grid").jqGrid("clearGridData");
            $("#bankReceivedDetail_grid").jqGrid("setCaption", "Bank Payment Detail");
            formatDateBankReceived();
            ev.preventDefault();
           
        });
        
        $("#btnBankReceivedPrint").click(function(ev) {
            var selectRowId = $("#bankReceived_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var bankReceived = $("#bankReceived_grid").jqGrid('getRowData', selectRowId);
            var grandTotalAmount1 = (Math.floor(bankReceived.totalTransactionAmount)).toString();
            var arr = bankReceived.totalTransactionAmount.split('.');
            var grandTotalAmount2 = arr[1];
            
            var url = "finance/bank-received-print-out-pdf?";
            var params ="brNo=" + bankReceived.code;
            params += "&bankReceivedTemp.terbilang=" + terbilangKoma(grandTotalAmount1,grandTotalAmount2,bankReceived.currencyName);
            window.open(url+params,'bankReceived','width=500,height=500');
            ev.preventDefault();
        });
        
        
    });//EOF Ready
    
    function numberWithCommaBankReceived(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function reloadGridBankReceived() {
        $("#bankReceived_grid").trigger("reloadGrid");  
    };
    
    function reloadGridBankReceivedDetailAfterDelete() {
        $("#bankReceivedDetail_grid").jqGrid("clearGridData");
        $("#bankReceivedDetail_grid").jqGrid("setCaption", "BANK RECEIVED DETAIL");
    };
        
    function formatDateBankReceived(){
        var firstDate=$("#bankReceivedSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#bankReceivedSearchFirstDate").val(firstDateValue);

        var lastDate=$("#bankReceivedSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#bankReceivedSearchLastDate").val(lastDateValue);
    }
    
</script>
   
<s:url id="remoteurlBankReceived" action="bank-received-json" />

    <b>BANK RECEIVED</b>
    <hr>
    <br class="spacer" />

    <sj:div id="BankReceivedButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnBankReceivedNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnBankReceivedUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnBankReceivedDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnBankReceivedRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnBankReceivedPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
    </sj:div> 
    <br class="spacer" />
    <br class="spacer" />

    <div id="BankReceivedInputSearch" class="content ui-widget">
        <s:form id="frmBankReceivedSearchInput">
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="bankReceivedSearchFirstDate" name="bankReceivedSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="bankReceivedSearchLastDate" name="bankReceivedSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="bankReceivedSearchCode" name="bankReceivedSearchCode" size="22" PlaceHolder=" BBMNo"></s:textfield>
                    </td>
                    <td align="right">Received From</td>
                    <td>
                        <s:textfield id="bankReceivedSearchReceivedFrom" name="bankReceivedSearchReceivedFrom" size="22"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="bankReceivedSearchRemark" name="bankReceivedSearchRemark" size="34"></s:textfield>
                    </td>
                    <td align="right">Bank Account</td>
                    <td>
                        <s:textfield id="bankReceivedBankAccountSearchCode" name="bankReceivedBankAccountSearchCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="bankReceivedBankAccountSearchName" name="bankReceivedBankAccountSearchName" cssStyle="width:40%" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Total Amount</td>
                    <td colspan="4">
                        <s:textfield id="bankReceivedSearchFirstTotalAmount" name="bankReceivedSearchFirstTotalAmount" size="15" cssStyle="text-align:right" placeholder=" 0.00"></s:textfield>
                        <B>To *</B>
                        <s:textfield id="bankReceivedSearchLastTotalAmount" name="bankReceivedSearchLastTotalAmount" size="15" cssStyle="text-align:right" placeholder=" 0.00"></s:textfield>
                        <span id="msgBankReceivedBankAccountFormatTotalAmount"></span>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnBankReceived_search" button="true">Search</sj:a>
            <br class="spacer" />
             
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="BankReceivedGrid">
        <sjg:grid
            id="bankReceived_grid"
            caption="BANK RECEIVED"
            dataType="json"
            href="%{remoteurlBankReceived}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankReceivedTemp"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubankreceived').width()"
            onSelectRowTopics="bankReceived_grid_onSelect"
        >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch" width = "100" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="bankAccountCode" index="bankAccountCode" key="bankAccountCode" title="Bank Account" width="100" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="bankAccountName" index="bankAccountName" key="bankAccountName" title="Bank Account" width="100" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="receivedFrom" index="receivedFrom" key="receivedFrom" title="ReceivedFrom" width="90" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" key="currencyName" title="Currency" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name = "totalTransactionAmount" index = "totalTransactionAmount" key ="totalTransactionAmount" title = "Total Amount" width = "100" sortable = "false" 
            formatter="number" align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="transferBankName" index="transferBankName" key="transferBankName" title="Bank Name" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
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
            name="receivedType" index="receivedType" key="receivedType" title="ReceivedType" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="giroReceivedCode" index="giroReceivedCode" key="giroReceivedCode" title="Giro No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="transferReceivedNo" index="transferReceivedNo" key="transferReceivedNo" title="Received No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="transferReceivedDate" index="transferReceivedDate" key="transferReceivedDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Received Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="transactionType" index="transactionType" key="transactionType" title="transactionType" width="130" sortable="true"  align="left" hidden="true"
        />
        </sjg:grid >
    </div>
                       
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="bankReceivedDetailGrid">
        <sjg:grid
            id="bankReceivedDetail_grid"
            caption="BANK RECEIVED DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBankReceivedDetailTemp"
            width="$('#tabmnubankreceived').width()"
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
                name = "currencyCode" id="currencyCode" index = "currencyCode" key = "currencyCode" title = "Currency" width = "80" sortable = "true"  align="center"
            />
            <sjg:gridColumn
                name = "exchangeRate" id="exchangeRate" index = "exchangeRate" key = "exchangeRate" 
                title = "Rate" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "transactionStatus" id="transactionStatus" index = "transactionStatus" key = "transactionStatus" title = "TransactionStatus" width = "150" sortable = "true" align="center" 
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
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "Budget Type Code" width = "150" sortable = "true" align="center"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "Budget Type Name" width = "150" sortable = "true" align="center"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
        </sjg:grid >
        <br class="spacer" />
    </div> 