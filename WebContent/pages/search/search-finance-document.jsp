
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="sjt" uri="/struts-jquery-tree-tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
        <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />        
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
        #dlgSearch_finance_document_grid_pager_center{
            display: none;
        }
    </style>
    
<script type = "text/javascript">
    
    var search_finance_document_type = '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_document_finance_id= '<%= request.getParameter("idfin") %>';
    var id_document_last_row= '<%= request.getParameter("last_row") %>';
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    var id_currency_code = '<%= request.getParameter("idCurrencyCode") %>';
    var rowLast = '<%= request.getParameter("rowLast")%>';
    
    function dlgFinanceDocument_cancelButton(){
        data_search_finance_document = null;
        window.close();
    };
    
    jQuery(document).ready(function(){
        $('#financeDocument\\.financeDocumentID').val(id_document_finance_id);
        switch(id_document_finance_id){
            case "BBM":
                $("#msgCustomerPurchaseOrderActivity").html("Due Date Period").show();
                break;
            case "BBK":
                $("#msgCustomerPurchaseOrderActivity").html("Period").show();
                break;
            case "BKM":
                $("#msgCustomerPurchaseOrderActivity").html("Due Date Period").show();
                break;
            case "BKK":
                $("#msgCustomerPurchaseOrderActivity").html("Period").show();
                break;
        }
        
        if(id_document==="financeRequestDetailDocument"){
           $('#financeDocument\\.currencyCode').val(id_currency_code);
           $('#financeDocument\\.currencyCode').attr("readonly",true);
        }
        
        $("#btn_dlg_FinanceDocumentSearch").click(function(ev) {
            
            formatDate();
            $("#dlgSearch_finance_document_grid").jqGrid("setGridParam",{url:"finance/finance-document-search?"+$("#frmFinanceDocumentSearch").serialize()});
            $("#dlgSearch_finance_document_grid").trigger("reloadGrid");
    
        jQuery("#dlgSearch_finance_document_grid").jqGrid('setGridParam', { gridComplete: function(){
                setHeightGridLoadAs();
                
             }});
             formatDate();
        });
        
        $("#dlgFinanceDocument_okButton").click(function(ev){
            
            cashReceivedDetaillastRowId = rowLast;
            bankReceivedDetaillastRowId = rowLast;
            generalJournalDetaillastRowId = rowLast;
            
            if (search_finance_document_type === "grid" ) {
                var ids = jQuery("#dlgSearch_finance_document_grid").jqGrid('getDataIDs');
                for(var i=0;i < ids.length;i++){

                    var data = $("#dlgSearch_finance_document_grid").jqGrid('getRowData',ids[i]);
                    if($("input:checkbox[id='jqg_dlgSearch_finance_document_grid_"+ids[i]+"']").is(":checked")){
                        var documentAmountForeign = parseFloat(data.grandTotalAmount);
                        var documentPaidAmount = parseFloat(data.paidAmount);
                        var balanceAmountForeign = documentAmountForeign - documentPaidAmount;
                        var exchangeRate = parseFloat(data.exchangeRate);
                        var documentAmountIDR= documentAmountForeign * exchangeRate;
                        var balanceAmountIDR= balanceAmountForeign * exchangeRate;

                        var debitAmountForeign = parseFloat(data.debit);
                        var creditAmountForeign = parseFloat(data.credit);
                        var debitAmountIDR = debitAmountForeign * exchangeRate;
                        var creditAmountIDR = creditAmountForeign * exchangeRate;

                    if(id_document === 'cashReceivedDetailDocument'){    
                        var defRow = {
                                documentBranchCode  : data.branchCode,
                                documentType        : data.documentType,
                                documentNo          : data.documentNo,            
                                currencyCode        : data.currencyCode,  
                                exchangeRate        : data.exchangeRate,
                                amountForeign       : data.grandTotalAmount,  
                                amountIDR           : documentAmountIDR,
                                balanceForeign      : balanceAmountForeign, 
                                balanceIDR          : balanceAmountIDR,
                                budgetTypeCode      : data.budgetTypeCode,
                                budgetTypeName      : data.budgetTypeName,
                                documentRefNo       : data.documentRefNo,
                                debitForeign        : debitAmountForeign,                
                                debitIDR            : debitAmountIDR, 
                                creditForeign       : creditAmountForeign,                
                                creditIDR           : creditAmountIDR,
                                chartOfAccountCode  : data.chartOfAccountCode,
                                chartOfAccountName  : data.chartOfAccountName,
                                transactionStatus   : 'Transaction'
                        };
    //                    console.log('selected row data:'+ JSON.stringify(data));
                        cashReceivedDetaillastRowId++;
                        window.opener.addRowDataMultiSelectedCashRecieved(cashReceivedDetaillastRowId,defRow);
                    }
                    
                    if(id_document === 'bankReceivedDetailDocument'){    
                        var defRow = {
                                documentBranchCode  : data.branchCode,
                                documentType        : data.documentType,
                                documentNo          : data.documentNo,            
                                currencyCode        : data.currencyCode,  
                                exchangeRate        : data.exchangeRate,
                                amountForeign       : data.grandTotalAmount,  
                                amountIDR           : documentAmountIDR,
                                balanceForeign      : balanceAmountForeign, 
                                balanceIDR          : balanceAmountIDR,
                                budgetTypeCode      : data.budgetTypeCode,
                                budgetTypeName      : data.budgetTypeName,
                                documentRefNo       : data.documentRefNo,
                                debitForeign        : debitAmountForeign,                
                                debitIDR            : debitAmountIDR, 
                                creditForeign       : creditAmountForeign,                
                                creditIDR           : creditAmountIDR,
                                chartOfAccountCode  : data.chartOfAccountCode,
                                chartOfAccountName  : data.chartOfAccountName,
                                transactionStatus   : 'Transaction'
                        };
                        bankReceivedDetaillastRowId++;
                        window.opener.addRowDataMultiSelectedBankReceived(bankReceivedDetaillastRowId,defRow);
                        
                    }
                    
                    if(id_document === 'generalJournalDetailDocument'){    
                        var defRow = {
                                documentBranchCode  : data.branchCode,
                                documentType        : data.documentType,
                                documentNo          : data.documentNo,            
                                currencyCode        : data.currencyCode,  
                                exchangeRate        : data.exchangeRate,
                                amountForeign       : data.grandTotalAmount,  
                                amountIDR           : documentAmountIDR,
                                balanceForeign      : balanceAmountForeign, 
                                balanceIDR          : balanceAmountIDR,
                                budgetTypeCode      : data.budgetTypeCode,
                                budgetTypeName      : data.budgetTypeName,
                                documentRefNo       : data.documentRefNo,
                                debitForeign        : debitAmountForeign,                
                                debitIDR            : debitAmountIDR, 
                                creditForeign       : creditAmountForeign,                
                                creditIDR           : creditAmountIDR,
                                chartOfAccountCode  : data.chartOfAccountCode,
                                chartOfAccountName  : data.chartOfAccountName,
                                transactionStatus   : 'Transaction'
                        };
    //                    console.log('selected row data:'+ JSON.stringify(data));
                        generalJournalDetaillastRowId++;
                        window.opener.addRowDataMultiSelectedGeneralJournal(generalJournalDetaillastRowId,defRow);
                        
                    }
                }
            }
        }
        window.close();

    });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#financeDocument\\.periodFirstDate").val(firstDateFormat);
        $("#financeDocument\\.periodLastDate").val(lastDateFormat);
        
    });
    
    function formatDate(){
        
        var periodFirstDateValue=$("#financeDocument\\.periodFirstDate").val().split("/");
        var periodFirstDate=periodFirstDateValue[1]+"/"+periodFirstDateValue[0]+"/"+periodFirstDateValue[2];
        $("#financeDocument\\.periodFirstDate").val(periodFirstDate);
//        $("#financeDocumentTemp\\.periodFirstDateTemp").val(periodFirstDate + " 00:00:00");
        
        var periodLastDateValue=$("#financeDocument\\.periodLastDate").val().split("/");
        var periodLastDate=periodLastDateValue[1]+"/"+periodLastDateValue[0]+"/"+periodLastDateValue[2];
        $("#financeDocument\\.periodLastDate").val(periodLastDate);
//        $("#financeDocumentTemp\\.periodLastDateTemp").val(periodLastDate + " 00:00:00");
        
    }
    
    function setHeightGridLoadAs(){   
           var ids = $("#dlgSearch_finance_document_grid").jqGrid('getDataIDs'); 
            if(parseInt(ids.length) > 20){
                $("#dlgSearch_finance_document_grid").parents(".ui-jqgrid-bdiv").css('height','475px');
            }else{
                $("#dlgSearch_finance_document_grid").parents(".ui-jqgrid-bdiv").css('height','auto');
            }
        
    }
    
    //        Focus Field and Enter to Search data
        $("#financeDocument\\.documentNo").focus();
        $('form').keypress(function (e) {
            if (e.which === 13) {
                $("#btn_dlg_FinanceDocumentSearch").trigger('click');
            }
        });
</script>
<body>
    <div class="ui-widget">
        
        <s:form id="frmFinanceDocumentSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" width="100px"><b><span id="msgCustomerPurchaseOrderActivity"></span></b></td>
                <td colspan="4">
                    <sj:datepicker id="financeDocument.periodFirstDate" name="financeDocument.periodFirstDate" showOn="focus" displayFormat="dd/mm/yy" size="15" changeYear="true" changeMonth="true" ></sj:datepicker>
                    <sj:datepicker id="financeDocumentTemp.periodFirstDateTemp" name="financeDocumentTemp.periodFirstDateTemp" showOn="focus" cssStyle="width:25;display:none" displayFormat="dd/mm/yy" changeYear="true" changeMonth="true" ></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="financeDocument.periodLastDate" name="financeDocument.periodLastDate" showOn="focus" displayFormat="dd/mm/yy" size="15" changeYear="true" changeMonth="true" ></sj:datepicker>
                    <sj:datepicker id="financeDocumentTemp.periodLastDateTemp" name="financeDocument.periodLastDate" showOn="focus" cssStyle="width:25;display:none" displayFormat="dd/mm/yy"  changeYear="true" changeMonth="true" ></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Document No</td>
                <td>
                    <s:textfield id="financeDocument.documentNo" name="financeDocument.documentNo" label="Document No" cssStyle="width:50" placeHolder=" Document No"></s:textfield>
                </td>
                <td align="right">Branch</td>
                <td>
                    <s:textfield id="financeDocument.branchCode" name="financeDocument.branchCode" label="Branch" cssStyle="width:25" placeHolder=" Code"></s:textfield>
                </td>
                <td align="right">Customer / Vendor</td>
                <td>
                    <s:textfield id="financeDocument.customerVendorCode" name="financeDocument.customerVendorCode" cssStyle="width:25" placeHolder=" Code"></s:textfield>
                    <s:textfield id="financeDocument.customerVendorName" name="financeDocument.customerVendorName" cssStyle="width:40" placeHolder=" Name"></s:textfield>
                    <s:textfield id="financeDocument.financeDocumentID" name="financeDocument.financeDocumentID" cssStyle="display:none;"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Document Ref No</td>
                <td>
                    <s:textfield id="financeDocument.documentRefNo" name="financeDocument.documentRefNo" label="Document Ref No" cssStyle="width:80" placeHolder=" Ref No"></s:textfield>
                </td>
                <td align="right">Currency</td>
                <td>
                    <s:textfield id="financeDocument.currencyCode" name="financeDocument.currencyCode" label="Currency" cssStyle="width:25" placeHolder=" Code"></s:textfield>
                </td>
                <td align="right">Customer Ship To</td>
                <td>
                    <s:textfield id="financeDocument.shipToCode" name="financeDocument.shipToCode" label="shipToCode" cssStyle="width:25" placeHolder=" Code"></s:textfield>
                    <s:textfield id="financeDocument.shipToName" name="financeDocument.shipToName" label="shipToName" cssStyle="width:25" placeHolder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Sort By</td>
                <td><select id="financeDocument.sortByFinanceDocument" name="financeDocument.sortByFinanceDocument">
                    <option value="DocumentNo">Document No</option>
                    <option value="TransactionDate">Transaction Date</option>
                    <option value="CustomerVendorCode">Customer Code</option>
                </select>
                </td>
                <td align="right">Order Type</td>
                <td><select id="financeDocument.orderByFinanceDocument" name="financeDocument.orderByFinanceDocument">
                    <option value="ASC">Ascending</option>
                    <option value="DESC">Descending</option>
                </select>
                </td>
                <td align="right">Customer Bill To</td>
                <td>
                    <s:textfield id="financeDocument.billToCode" name="financeDocument.billToCode" label="billToCode" cssStyle="width:25" placeHolder=" Code"></s:textfield>
                    <s:textfield id="financeDocument.billToName" name="financeDocument.billToName" label="billToName" cssStyle="width:25" placeHolder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_FinanceDocumentSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_finance_document_grid"
            dataType="json"
            href="%{remoteurFinanceDocumentSearch}"
            pager="true"
            multiselect="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listFinanceDocumentTemp"
            rowList="20"
            rowNum="10000"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnufinancedocument').width()"
        >
        <sjg:gridColumn
            name="branchCode" index="branchCode" key="branchCode" title="Branch" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="documentNo" index="documentNo" key="documentNo" title="Document No" width="130" sortable="true"
        />
        <sjg:gridColumn
            name="documentType" index="documentType" key="documentType" title="Doc Type" width="80" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="documentRefNo" index="documentRefNo" key="documentRefNo" title="Document Ref No" width="150" sortable="true" hidden="false"
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="120" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            align="center"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" key="currencyName" title="Currency Name" width="80" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="exchangeRate" index="exchangeRate" key="exchangeRate" title="Exchange Rate" width="100" sortable="true"
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="customerVendorCode" index="customerVendorCode" key="customerVendorCode" title="Cust/Sup Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="customerVendorNo" index="customerVendorNo" key="customerVendorNo" title="Cust/Sup No" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="customerVendorName" index="customerVendorName" key="customerVendorName" title="Cust/Sup Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="shipToCode" index="shipToCode" key="shipToCode" title="Customer Ship To Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="shipToName" index="shipToName" key="shipToName" title="Customer Ship To Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="billToCode" index="billToCode" key="billToCode" title="Customer Bill To Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="billToName" index="billToName" key="billToName" title="Customer Bill To Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="budgetTypeCode" index="budgetTypeCode" key="budgetTypeCode" title="BudgetType Code" width="120" sortable="true"
        />
        <sjg:gridColumn
            name="budgetTypeName" index="budgetTypeName" key="budgetTypeName" title="BudgetType Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="grandTotalAmount" index="grandTotalAmount" key="grandTotalAmount" title="Grand Total Amount" width="100" sortable="true" align="right" hidden="true"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="paidAmount" index="paidAmount" key="paidAmount" title="Paid Amount" width="100" sortable="true" align="right" hidden="true"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="balance" index="balance" key="balance" title="Balance" width="100" sortable="true" align="right" 
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="debit" index="debit" key="debit" title="Debit" width="100" sortable="true" align="right" hidden="true"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="credit" index="credit" key="credit" title="Credit" width="100" sortable="true" align="right" hidden="true"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="chartOfAccountCode" index="chartOfAccountCode" key="chartOfAccountCode" title="Account Code" width="120" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="chartOfAccountName" index="chartOfAccountName" key="chartOfAccountName" title="Account Name" width="200" sortable="true" hidden="true"
        />
        </sjg:grid >      
    </div>
    
    <br></br>
    <sj:a href="#" id="dlgFinanceDocument_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgFinanceDocument_cancelButton" onclick="dlgFinanceDocument_cancelButton()" button="true">Cancel</sj:a>
</body>
</html>
