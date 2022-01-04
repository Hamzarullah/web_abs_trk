
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<s:url id="remoteurlVendorCreditNote" action="vendor-credit-note-json" />
<style>
    #vendorCreditNoteDetail_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
               
        $.subscribe("vendorCreditNote_grid_onSelect", function(event, data){
            var selectedRowID = $("#vendorCreditNote_grid").jqGrid("getGridParam", "selrow"); 
            var vendorCreditNote = $("#vendorCreditNote_grid").jqGrid("getRowData", selectedRowID);
            
            $("#vendorCreditNoteDetail_grid").jqGrid("setGridParam",{url:"finance/vendor-credit-note-detail-data?vendorCreditNote.code=" + vendorCreditNote.code});
            $("#vendorCreditNoteDetail_grid").jqGrid("setCaption", "VENDOR CREDIT NOTE DETAIL : " + vendorCreditNote.code);
            $("#vendorCreditNoteDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnVendorCreditNoteNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "finance/vendor-credit-note-input";
                var params = "";

                pageLoad(url, params, "#tabmnuVENDOR_CREDIT_NOTE"); 
            });
                   
        });
        
        $("#btnVendorCreditNoteUpdate").click(function(ev){
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#vendorCreditNote_grid").jqGrid('getGridParam','selrow');
                var vendorCreditNote = $("#vendorCreditNote_grid").jqGrid('getRowData', selectRowId);
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url = "finance/finance-document-existing";
                var params = "financeDocument.documentNo=" + vendorCreditNote.code;

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
                    
                    var url = "finance/finance-document-existing-payment-request";
                    var params = "financeDocument.documentNo=" + vendorCreditNote.code;

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
                        
                        var url = "purchasing/vendor-credit-note-input";
                        var params = "vendorCreditNoteUpdateMode=true";
                            params+="&vendorCreditNote.code=" + vendorCreditNote.code;

                        pageLoad(url, params, "#tabmnuVENDOR_CREDIT_NOTE");
                    });
                });
            });  
        });
        
        $("#btnVendorCreditNoteDelete").click(function(ev){
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var deleteRowId = $("#vendorCreditNote_grid").jqGrid('getGridParam','selrow');
                var vendorCreditNote = $("#vendorCreditNote_grid").jqGrid('getRowData', deleteRowId);

                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
//                var url = "finance/finance-document-existing";
//                var params = "financeDocument.documentNo=" + vendorCreditNote.code;
//
//                $.post(url,params,function(result){
//                    var data=(result);
//                    if (data.error) {
//                        alertMessage(data.errorMessage);
//                        return;
//                    }
//
//                    if(data.listFinanceDocumentTemp.length>0){
//                        var arrFinanceDocument=new Array();
//                        for(var i=0;i<data.listFinanceDocumentTemp.length;i++){
//                            arrFinanceDocument.push(data.listFinanceDocumentTemp[i].headerCode);
//                        }
//                        
//                        alertMessage("Cannot Delete this Transaction since has been Paid!<br/><br/>Document Paid: "+arrFinanceDocument);
//                        return;
//                    }
                    
//                    var url = "finance/finance-document-existing-payment-request";
//                    var params = "financeDocument.documentNo=" + vendorCreditNote.code;
//
//                    $.post(url,params,function(result){
//                        var data=(result);
//                        if (data.error) {
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        if(data.listFinanceDocumentTemp.length>0){
//                            var arrFinanceDocument=new Array();
//                            for(var i=0;i<data.listFinanceDocumentTemp.length;i++){
//                                arrFinanceDocument.push(data.listFinanceDocumentTemp[i].headerCode);
//                            }
//
//                            alertMessage("Cannot Delete this Transaction since has been Created Payment Request!<br/><br/>Document Created: "+arrFinanceDocument);
//                            return;
//                        }
                        
                        var url = "finance/vendor-credit-note-delete";
                        var params = "vendorCreditNote.code=" + vendorCreditNote.code;

                        var dynamicDialog= $(
                            '<div id="conformBoxError">'+
                            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>Are You Sure To Delete?<br/><br/>' +
                            '<span style="float:left; margin:0 7px 20px 0;">'+
                            '</span>SDN No: '+vendorCreditNote.code+'<br/><br/>' +    
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
                                            reloadGridSDN();
                                            reloadDetailGridSDN();
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
//                    });
//                }); 
            });
        });
        
        $('#btnVendorCreditNoteRefresh').click(function(ev) {
            var url = "finance/vendor-credit-note";
            var params = "";
            pageLoad(url, params, "#tabmnuVENDOR_CREDIT_NOTE"); 
        });
        
        
        $('#btnVendorCreditNote_search').click(function(ev) {
            vendorCreditNoteFormatDate();
            $("#vendorCreditNote_grid").jqGrid("clearGridData");
            $("#vendorCreditNote_grid").jqGrid("setGridParam",{url:"finance/vendor-credit-note-data?" + $("#frmVendorCreditNoteSearchInput").serialize()});
            $("#vendorCreditNote_grid").trigger("reloadGrid");
            $("#vendorCreditNoteDetail_grid").jqGrid("clearGridData");
            $("#vendorCreditNoteDetail_grid").jqGrid("setCaption", "VENDOR CREDIT NOTE DETAIL");
            vendorCreditNoteFormatDate();
        });
        $("#btnVendorCreditNotePrint").click(function(ev) {
            var selectRowId = $("#vendorCreditNote_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var vendorCreditNote = $("#vendorCreditNote_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/finance/vendor-credit-note-print-out-pdf?";
            var params ="code=" + vendorCreditNote.code;
         
            window.open(url+params,'vendorCreditNote','width=500,height=500');
        });
    });
    
    function reloadGridSDN() {
        $("#vendorCreditNote_grid").trigger("reloadGrid");
      
    };
    
    function reloadDetailGridSDN() {
        $("#vendorCreditNoteDetail_grid").trigger("reloadGrid");
        $("#vendorCreditNoteDetail_grid").jqGrid("clearGridData");
        $("#vendorCreditNoteDetail_grid").jqGrid("setCaption", "VENDOR CREDIT NOTE DETAIL");
    };
    
    function vendorCreditNoteFormatDate(){
        var firstDate=$("#vendorCreditNoteSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#vendorCreditNoteSearchFirstDate").val(firstDateValue);

        var lastDate=$("#vendorCreditNoteSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#vendorCreditNoteSearchLastDate").val(lastDateValue);
    }
</script>
    
    <b>VENDOR CREDIT NOTE</b>
    <hr>
    <br class="spacer" />
    <sj:div id="vendorCreditNoteButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnVendorCreditNoteNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnVendorCreditNoteUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnVendorCreditNoteDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnVendorCreditNoteRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnVendorCreditNotePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>  
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="VendorCreditNoteInputSearch" class="content ui-widget">
        <s:form id="frmVendorCreditNoteSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="vendorCreditNoteSearchFirstDate" name="vendorCreditNoteSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="vendorCreditNoteSearchLastDate" name="vendorCreditNoteSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="vendorCreditNoteSearchCode" name="vendorCreditNoteSearchCode" size="25" placeHolder=" VCN No"></s:textfield>
                    </td>
                    <td width="10px"/>
                    <td align="right">Vendor</td>
                    <td>
                        <s:textfield id="vendorCreditNoteVendorSearchCode" name="vendorCreditNoteVendorSearchCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="vendorCreditNoteVendorSearchName" name="vendorCreditNoteVendorSearchName" size="25" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnVendorCreditNote_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="VendorCreditNoteGrid">
        <sjg:grid
            id="vendorCreditNote_grid"
            caption="VENDOR CREDIT NOTE"
            dataType="json"
            href="%{remoteurlVendorCreditNote}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listVendorCreditNoteTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuvendorcreditnote').width()"
            onSelectRowTopics="vendorCreditNote_grid_onSelect"
        >
            <sjg:gridColumn
                name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" title = "Branch" width = "50" sortable = "true" align="center" hidden="true"
            />
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true" 
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" title="Transaction Date" width="130" 
                formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true" align="center"
            />
            <sjg:gridColumn
                name = "exchangeRate" index = "exchangeRate" key = "exchangeRate" title = "Rate" width = "100" sortable = "false"
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="100" sortable="true" align="center"
            />
            <sjg:gridColumn
                name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name = "totalTransactionAmount" index = "totalTransactionAmount" key = "totalTransactionAmount" title = "Total Transaction" width = "130" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "discountAmount" index = "discountAmount" key = "discountAmount" title = "Disc Amount" width = "130" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "subTotal" index = "subTotal" key = "subTotal" title = "Sub Total" width = "100" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "vatAmount" index = "vatAmount" key = "vatAmount" title = "Vat Amount" width = "130" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "grandTotalAmount" index = "grandTotalAmount" key = "grandTotalAmount" title = "Grand Total Amount" width = "130" sortable = "false" 
                formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="taxInvoiceNo" index="taxInvoiceNo" key="taxInvoiceNo" title="Tax Invoice No" width="130" sortable="true"  align="left"
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

    <div id="vendorCreditNoteDetailGrid">
        <sjg:grid
            id="vendorCreditNoteDetail_grid"
            caption="VENDOR CREDIT NOTE DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listVendorCreditNoteDetailTemp"
            width="$('#tabmnuvendorcreditnotedetail').width()"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "true"  align="right" hidden="true"
            />
            <sjg:gridColumn
                name = "headerCode" id="headerCode" index = "headerCode" key = "headerCode" title = "HeaderCode" width = "100" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "200" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "Chart Of Account Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "Chart Of Account Name" width = "200" sortable = "true"
            />
            <sjg:gridColumn
                name = "quantity" id="quantity" index = "quantity" key = "quantity" 
                title = "Quantity" width = "80" sortable = "true" align="right" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:4}"
            />
             <sjg:gridColumn
                name = "unitOfMeasureCode" id="unitOfMeasureCode" index = "unitOfMeasureCode" key = "unitOfMeasureCode" title = "Unit" width = "100" sortable = "true"
            />
            <sjg:gridColumn
                name = "price" id="price" index = "price" key = "price" 
                title = "Price" width = "150" sortable = "true" align="right" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "total" id="total" index = "total" key = "total" 
                title = "Total" width = "200" sortable = "true" align="right" 
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
        </sjg:grid >
        <br class="spacer" />
        <br class="spacer" />
    

