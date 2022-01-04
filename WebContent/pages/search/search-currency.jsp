<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

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
        overflow: scroll;
    }
</style>
    
<script type = "text/javascript">
    
    var search_currency_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgCurrency_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_currency_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Currency!");
                return;
            }

            var data_search_currency = $("#dlgSearch_currency_grid").jqGrid('getRowData', selectedRowId);

            if (search_currency_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"CurrencyCode",opener.document).val(data_search_currency.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CurrencyName", data_search_currency.name);           
            }
            else {
               $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_currency.code);
               $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_currency.name);
            }
            
            switch(id_document){
                case "adjustmentInApproval":
                    window.opener.adjustmentInApprovalValidateExchangeRate();
                    break;
                case "customerDownPayment":
                    window.opener.customerDownPaymentLoadExchangeRate();
                    break;
                case "cashReceived":
                    window.opener.cashReceivedSetDefault();
                    break;
                case "bankReceived":
                    window.opener.bankReceivedLoadExchangeRate();
                    break;
                case "bankPayment":
                    window.opener.bankPaymentValidateCurrencyExchangeRate();
                    break;
                case "cashPayment":
                    window.opener.cashPaymentValidateCurrencyExchangeRate();
                    break;
                case "vendorDownPayment":
                    window.opener.vendorDownPaymentSetDefault();
                    break;
            }

            window.close();
        });
        
        
        
        $("#dlgCurrency_cancelButton").click(function(ev) { 
            data_search_currency = null;
            window.close();
        });
    
    
        $("#btn_dlg_CurrencySearch").click(function(ev) {
            $("#dlgSearch_currency_grid").jqGrid("setGridParam",{url:"master/currency-data?" + $("#frmCurrencySearch").serialize(), page:1});
            $("#dlgSearch_currency_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlCurrencySearch" action="" />
        <div class="ui-widget">
            <s:form id="frmCurrencySearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="currencySearchCode" name="currencySearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="currencySearchName" name="currencySearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_CurrencySearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="currencySearchActiveStatus" name="currencySearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_currency_grid"
                dataType="json"
                href="%{remoteurlCurrencySearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listCurrencyTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnucurrency').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgCurrency_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgCurrency_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>