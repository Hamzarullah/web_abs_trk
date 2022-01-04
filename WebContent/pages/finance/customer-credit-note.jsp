
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #customerCreditNoteDetail_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
               
        $.subscribe("customerCreditNote_grid_onSelect", function(event, data){
            var selectedRowID = $("#customerCreditNote_grid").jqGrid("getGridParam", "selrow"); 
            var customerCreditNote = $("#customerCreditNote_grid").jqGrid("getRowData", selectedRowID);
            
            $("#customerCreditNoteDetail_grid").jqGrid("setGridParam",{url:"sales/customer-credit-note-detail-data?customerCreditNote.code="+ customerCreditNote.code});
            $("#customerCreditNoteDetail_grid").jqGrid("setCaption", "CUSTOMER CREDIT NOTE DETAIL : " + customerCreditNote.code);
            $("#customerCreditNoteDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnCustomerCreditNoteNew').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "sales/customer-credit-note-input";
                var params = "";

                pageLoad(url, params, "#tabmnuCUSTOMER_CREDIT_NOTE");

            });
                    
        });
        
        $('#btnCustomerCreditNoteUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#customerCreditNote_grid").jqGrid('getGridParam','selrow');
                var customerCreditNote = $("#customerCreditNote_grid").jqGrid('getRowData', selectedRowId);
                
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                

                var url = "finance/finance-document-existing";
                var params = "financeDocument.documentNo=" + customerCreditNote.code;

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
                    
                    var url = "finance/customer-credit-note-input";
                    var params = "customerCreditNoteUpdateMode=true";
                        params+="&customerCreditNote.code=" + customerCreditNote.code;
                        pageLoad(url, params, "#tabmnuCUSTOMER_CREDIT_NOTE");
                });

            });      
        });

        $('#btnCustomerCreditNoteDelete').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var deleteRowId = $("#customerCreditNote_grid").jqGrid('getGridParam','selrow');
                var customerCreditNote = $("#customerCreditNote_grid").jqGrid('getRowData', deleteRowId);

                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url = "finance/finance-document-existing";
                var params = "financeDocument.documentNo=" + customerCreditNote.code;

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
                    
                    var url = "finance/customer-credit-note-delete";
                    var params = "customerCreditNote.code=" + customerCreditNote.code;

                    var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>CCN No: '+customerCreditNote.code+'<br/><br/>' +    
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
                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridCCN();
                                        reloadDetailGridCCN();
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
               
            ev.preventDefault();
        });

        $('#btnCustomerCreditNoteRefresh').click(function(ev) {
            var url = "sales/customer-credit-note";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_CREDIT_NOTE");
            ev.preventDefault();   
        });
        
        
        $('#btnCustomerCreditNote_search').click(function(ev) {
            formatDateCCN();
            $("#customerCreditNote_grid").jqGrid("clearGridData");
            $("#customerCreditNote_grid").jqGrid("setGridParam",{url:"sales/customer-credit-note-data?" + $("#frmCustomerCreditNoteSearchInput").serialize()});
            $("#customerCreditNote_grid").trigger("reloadGrid");
            $("#customerCreditNoteDetail_grid").jqGrid("clearGridData");
            $("#customerCreditNoteDetail_grid").jqGrid("setCaption", "CUSTOMER CREDIT NOTE DETAIL");
            formatDateCCN();
            ev.preventDefault();
           
        });
        $("#btnCustomerCreditNotePrint").click(function(ev) {
            var selectRowId = $("#customerCreditNote_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            else{
            var customerCreditNote = $("#customerCreditNote_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/sales/customer-credit-note-print-out-pdf?";
            var params ="code=" + customerCreditNote.code;
        
            window.open(url+params,'customerCreditNote','width=500,height=500');}
            ev.preventDefault();
        });
    });//EOF Ready
    
    function formatDateCCN(){
        var firstDate=$("#customerCreditNoteSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#customerCreditNoteSearchFirstDate").val(firstDateValue);

        var lastDate=$("#customerCreditNoteSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#customerCreditNoteSearchLastDate").val(lastDateValue);
    }
    
    function reloadGridCCN() {
        $("#customerCreditNote_grid").trigger("reloadGrid");
      
    };

    function reloadDetailGridCCN() {
        $("#customerCreditNoteDetail_grid").trigger("reloadGrid");  
        $("#customerCreditNoteDetail_grid").jqGrid("clearGridData");
        $("#customerCreditNoteDetail_grid").jqGrid("setCaption", "CUSTOMER CREDIT NOTE DETAIL");
    };
    
</script>
<s:url id="remoteurlCustomerCreditNote" action="customer-credit-note-json" />    
    <b>CUSTOMER CREDIT NOTE</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="customerCreditNoteButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCustomerCreditNoteNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCustomerCreditNoteUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCustomerCreditNoteDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCustomerCreditNoteRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCustomerCreditNotePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="CustomerCreditNoteInputSearch" class="content ui-widget">
        <s:form id="frmCustomerCreditNoteSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="customerCreditNoteSearchFirstDate" name="customerCreditNoteSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="customerCreditNoteSearchLastDate" name="customerCreditNoteSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="customerCreditNoteSearchCode" name="customerCreditNoteSearchCode" size="25" placeHolder=" CCN No"></s:textfield>
                    </td>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="customerCreditNoteCustomerSearchCode" name="customerCreditNoteCustomerSearchCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="customerCreditNoteCustomerSearchName" name="customerCreditNoteCustomerSearchName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnCustomerCreditNote_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="CustomerCreditNoteGrid">
        <sjg:grid
            id="customerCreditNote_grid"
            caption="CUSTOMER CREDIT NOTE"
            dataType="json"
            href="%{remoteurlCustomerCreditNote}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerCreditNoteTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucustomercreditnote').width()"
            onSelectRowTopics="customerCreditNote_grid_onSelect"
        >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" title = "Branch" width = "50" sortable = "true" align="center"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="CCN No" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="customerName" index="customerName" key="customerName" title="Customer Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="taxInvoiceNo" index="taxInvoiceNo" key="taxInvoiceNo" title="Tax Invoice No" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="80" sortable="true" align="center"
        />
        <sjg:gridColumn
            name = "exchangeRate" index = "exchangeRate" key = "exchangeRate" title = "Rate" width = "80" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "totalTransactionAmount" index = "totalTransactionAmount" key = "totalTransactionAmount" title = "Total Transaction" width = "130" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "discountPercent" index = "discountPercent" key = "discountPercent" title = "Disc%" width = "130" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "discountAmount" index = "discountAmount" key = "discountAmount" title = "Disc Amount" width = "130" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "vatPercent" index = "vatPercent" key = "vatPercent" title = "VAT %" width = "130" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "vatAmount" index = "vatAmount" key = "vatAmount" title = "VAT Amount" width = "130" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "grandTotalAmount" index = "grandTotalAmount" key = "grandTotalAmount" title = "Grand Total" width = "130" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
        </sjg:grid >
    </div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="customerCreditNoteDetailGrid">
        <sjg:grid
            id="customerCreditNoteDetail_grid"
            caption="CUSTOMER CREDIT NOTE DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerCreditNoteDetailTemp"
            width="$('#tabmnucustomercreditnotedetail').width()"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
        >
            
            <sjg:gridColumn
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "Chart Of Account Code" width = "150"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "Chart Of Account Name" width = "200"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150"
            />
            <sjg:gridColumn
                name = "quantity" id="quantity" index = "quantity" key = "quantity" title = "Quantity" width = "100" formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
            />
             <sjg:gridColumn
                name = "unitOfMeasureCode" id="unitOfMeasureCode" index = "unitOfMeasureCode" key = "unitOfMeasureCode" title = "Unit" width = "100"
            />
            <sjg:gridColumn
                name = "price" id="price" index = "price" key = "price" title = "Price" 
                width = "150" align="right" formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "total" id="total" index = "total" key = "total" title = "Total" 
                width = "200" formatter="number" formatoptions= "{ thousandsSeparator:','}" align="right"
            />
        </sjg:grid >
        <br class="spacer" />
        <br class="spacer" />