
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
    </style>

    <script type = "text/javascript">

        var search_finance_document_type = '<%= request.getParameter("type")%>';
        var id_document = '<%= request.getParameter("iddoc")%>';
        var id_document_finance_id = '<%= request.getParameter("idfin")%>';
        var id_first_date = '<%= request.getParameter("firstDate")%>';
        var id_last_date = '<%= request.getParameter("lastDate")%>';
        var id_currency_code = '<%= request.getParameter("idCurrencyCode")%>';
        var rowLast = '<%= request.getParameter("rowLast")%>';


        function dlgFinanceDocument_cancelButton() {
            data_search_finance_document = null;
            window.close();
        }
        ;

        jQuery(document).ready(function () {

            if (id_document === "financeRequestDetailDocument") {
                $('#financeDocument\\.currencyCode').val(id_currency_code);
                $('#financeDocument\\.currencyCode').attr("readonly", true);
            }

            $('#financeDocument\\.financeDocumentID').val(id_document_finance_id);

            $("#btn_dlg_FinanceDocumentSearch").click(function (ev) {
                formatDate();
                $("#dlgSearch_finance_document_grid").jqGrid("setGridParam", {url: "finance/finance-request-search?" + $("#frmFinanceDocumentSearch").serialize(), page: 1});
                $("#dlgSearch_finance_document_grid").trigger("reloadGrid");
                formatDate();
            });

            $("#btnFinanceDocumentPrint").click(function (ev) {
                formatDate();
                var url = "reports/finance/document-request-print-out-pdf?";
                var params = $("#frmFinanceDocumentSearch").serialize();
                formatDate();
                window.open(url + params, 'financeDocument', 'width=500,height=500');
             
            });

            $("#dlgFinanceDocument_okButton").click(function (ev) {

                financeDocumentDetaillastRowId = rowLast;
                if (search_finance_document_type === "grid") {

                    var ids = jQuery("#dlgSearch_finance_document_grid").jqGrid('getDataIDs');

                    for (var i = 0; i < ids.length; i++) {
                        var exist = false;
                        var data = $("#dlgSearch_finance_document_grid").jqGrid('getRowData', ids[i]);
                        if ($("input:checkbox[id='jqg_dlgSearch_finance_document_grid_" + ids[i] + "']").is(":checked")) {

                            //                        for(var j=0; j<idsOpener.length; j++){
                            //                            var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            //                             Validasi data exist                           
                            //                            if(id_document === 'paymentRequestDetailDocument'){
                            //                                if(data.code === dataExist.promoCustomerCustomerDetailCustomerCode){
                            //                                    exist = true;
                            //                                }
                            //                            }
                            //                        }
                            if (exist) {
                                //                            alert("data was in grid");
                            } else {
                                if (id_document === 'paymentRequestDetailDocument') {

                                    var documentAmountForeign = parseFloat(data.grandTotalAmount);
                                    var documentPaidAmount = parseFloat(data.paidAmount);
                                    var balanceAmountForeign = documentAmountForeign - documentPaidAmount;
                                    var exchangeRate = parseFloat(data.exchangeRate);
                                    var documentAmountIDR = documentAmountForeign * exchangeRate;
                                    var balanceAmountIDR = balanceAmountForeign * exchangeRate;
                                    var debitAmountForeign = parseFloat(data.debit);
                                    var creditAmountForeign = parseFloat(data.credit);
                                    var debitAmountIDR = debitAmountForeign * exchangeRate;
                                    var creditAmountIDR = creditAmountForeign * exchangeRate;

                                    //for vendor invoice and vendor credit note, add the vendor name and vendor invoice number 
                                    if (data.documentType === 'VIN' || data.documentType === 'VCN') {
                                        var vendorName = data.customerVendorName + ', ' + data.vendorInvoiceNo;
                                    } else {
                                        var vendorName = '';
                                    }

                                    var defRow = {
                                        paymentRequestDetailDocumentCodeTemp            : data.code,
                                        paymentRequestDetailDocumentDelete              : "delete",
                                        paymentRequestDetailDocumentBranchCode          : data.branchCode,
                                        paymentRequestDetailDocumentDocumentType        : data.documentType,
                                        paymentRequestDetailDocumentDocumentNo          : data.documentNo,
                                        paymentRequestDetailDocumentCurrencyCode        : data.currencyCode,
                                        paymentRequestDetailDocumentExchangeRate        : data.exchangeRate,
                                        paymentRequestDetailDocumentDueDate             : data.dueDate,
                                        paymentRequestDetailDocumentDocumentDate        : data.transactionDate,
                                        paymentRequestDetailDocumentAmountForeign       : documentAmountForeign,
                                        paymentRequestDetailDocumentAmountIDR           : documentAmountIDR,
                                        paymentRequestDetailDocumentBalanceForeign      : balanceAmountForeign,
                                        paymentRequestDetailDocumentBalanceIDR          : balanceAmountIDR,
                                        paymentRequestDetailDocumentTransactionStatus   : "Transaction",
                                        paymentRequestDetailDocumentDebitForeign        : debitAmountIDR,
                                        paymentRequestDetailDocumentCreditForeign       : creditAmountIDR,
                                        paymentRequestDetailDocumentChartOfAccountCode  : data.chartOfAccountCode,
                                        paymentRequestDetailDocumentChartOfAccountName  : data.chartOfAccountName,
                                        paymentRequestDetailDocumentRemark              : vendorName
                                    };

                                    financeDocumentDetaillastRowId++;
                                    window.opener.addRowDataMultiSelected(financeDocumentDetaillastRowId, defRow);
                                    //                                window.opener.changePaymentRequestDocumentType("Transaction");
                                }
                            }
                        }

                    }

                    window.close();
                }
            });

            var firstDate = id_first_date.split("/");
            var firstDateFormat = firstDate[1] + "/" + firstDate[0] + "/" + firstDate[2];
            var lastDate = id_last_date.split("/");
            var lastDateFormat = lastDate[1] + "/" + lastDate[0] + "/" + lastDate[2];

            $("#financeDocument\\.periodFirstDate").val(firstDateFormat);
            $("#financeDocument\\.periodLastDate").val(lastDateFormat);

        });

        function formatDate() {

            var periodFirstDateValue = $("#financeDocument\\.periodFirstDate").val().split("/");
            var periodFirstDate = periodFirstDateValue[1] + "/" + periodFirstDateValue[0] + "/" + periodFirstDateValue[2];
            $("#financeDocument\\.periodFirstDate").val(periodFirstDate);
            //        $("#financeDocumentTemp\\.periodFirstDateTemp").val(periodFirstDate + " 00:00:00");

            var periodLastDateValue = $("#financeDocument\\.periodLastDate").val().split("/");
            var periodLastDate = periodLastDateValue[1] + "/" + periodLastDateValue[0] + "/" + periodLastDateValue[2];
            $("#financeDocument\\.periodLastDate").val(periodLastDate);
            //        $("#financeDocumentTemp\\.periodLastDateTemp").val(periodLastDate + " 00:00:00");

        }
    </script>
    <body>
        <br class="spacer" />
        <tr>
            <sj:div id="financeDocumentButton" cssClass="ikb-buttonset ikb-buttonset-single">
                <table>
                    <tr>
                        <td  colspan="2"><a href="#" id="btnFinanceDocumentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="../../images/button_printer.png" border="0" /><br/>Print</a></td>
                    </tr>
                </table>
            </sj:div>
        </tr>
        <br class="spacer" />
        <div class="ui-widget">
            <s:form id="frmFinanceDocumentSearch">
                <table cellpadding="2" cellspacing="2" width="100%">
                    <tr>
                        <td align="right" valign="center" width="100px"><b>Period (Due Date)</b></td>
                        <td colspan="2">
                            <sj:datepicker id="financeDocument.periodFirstDate" name="financeDocument.periodFirstDate" showOn="focus" cssStyle="width:30%" displayFormat="dd/mm/yy" changeYear="true" changeMonth="true" ></sj:datepicker>
                            <sj:datepicker id="financeDocumentTemp.periodFirstDateTemp" name="financeDocumentTemp.periodFirstDateTemp" showOn="focus" cssStyle="width:25%;display:none" displayFormat="dd/mm/yy" changeYear="true" changeMonth="true" ></sj:datepicker>
                                <B>Up To *</B>
                                <sj:datepicker id="financeDocument.periodLastDate" name="financeDocument.periodLastDate" showOn="focus" cssStyle="width:30%" displayFormat="dd/mm/yy" changeYear="true" changeMonth="true" ></sj:datepicker>
                                <sj:datepicker id="financeDocumentTemp.periodLastDateTemp" name="financeDocument.periodLastDate" showOn="focus" cssStyle="width:25%;display:none" displayFormat="dd/mm/yy"  changeYear="true" changeMonth="true" ></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Branch Code</td>
                            <td><s:textfield id="financeDocument.branchCode" name="financeDocument.branchCode" label="Branch Code" cssStyle="50%" placeHolder=" Branch"></s:textfield></td>
                            <td align="right">Finance Document ID</td>
                            <td><s:textfield id="financeDocument.financeDocumentID" name="financeDocument.financeDocumentID" label="Finance Document ID" cssStyle="50%" placeHolder="Finance Document ID"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Document No</td>
                            <td><s:textfield id="financeDocument.documentNo" name="financeDocument.documentNo" label="Document No" cssStyle="width:100%" placeHolder=" Document No"></s:textfield></td>
                            <td align="right">Currency</td>
                            <td><s:textfield id="financeDocument.currencyCode" name="financeDocument.currencyCode" label="Currency" cssStyle="width:25%" placeHolder=" Currency"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Document Ref No</td>
                            <td><s:textfield id="financeDocument.documentRefNo" name="financeDocument.documentRefNo" label="Document Ref No" cssStyle="width:100%" placeHolder=" Ref No"></s:textfield></td>
                            <td align="right" width="150px">Customer / Vendor</td>
                            <td>
                            <s:textfield id="financeDocument.customerVendorCode" name="financeDocument.customerVendorCode" cssStyle="width:30%" placeHolder=" Code"></s:textfield>
                            <s:textfield id="financeDocument.customerVendorNo" name="financeDocument.customerVendorNo" cssStyle="width:30%" placeHolder=" No"></s:textfield>
                            <s:textfield id="financeDocument.customerVendorName" name="financeDocument.customerVendorName" cssStyle="width:30%" placeHolder=" Name"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><sj:a href="#" id="btn_dlg_FinanceDocumentSearch" button="true">Search</sj:a></td>
                        </tr>
                    </table>
            </s:form>
        </div>
        <s:url id="remoteurldocumentsearch" action="" />
        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_finance_document_grid"
                dataType="json"
                href="%{remoteurFinanceDocumentSearch}"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listFinanceDocumentTemp"
                rowList="10,50,100,150"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                multiselect = "true"
                editurl="%{remoteurldocumentsearch}"
                width="$('#tabmnufinancedocument').width()"
                onSelectRowTopics="dlgSearch_document_grid_onSelect"

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
                    name="dueDate" index="dueDate" key="dueDate" 
                    title="Due Date" width="120" formatter="date"  
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
                    name="customerVendorNo" index="customerVendorNo" key="customerVendorNo" title="Cust/Sup No" width="100" sortable="true" hidden="true"
                    />
                <sjg:gridColumn
                    name="customerVendorName" index="customerVendorName" key="customerVendorName" title="Cust/Sup Name" width="150" sortable="true"
                    />
                <sjg:gridColumn
                    name="vendorInvoiceNo" index="vendorInvoiceNo" key="vendorInvoiceNo" title="Vendor Invoice No" width="150" sortable="true" hidden="true"
                    />
                <sjg:gridColumn
                    name="budgetTypeCode" index="budgetTypeCode" key="budgetTypeCode" title="BudgetType Code" width="120" sortable="true" hidden="true"
                    />
                <sjg:gridColumn
                    name="budgetTypeName" index="budgetTypeName" key="budgetTypeName" title="BudgetType Name" width="200" sortable="true" hidden="true"
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
