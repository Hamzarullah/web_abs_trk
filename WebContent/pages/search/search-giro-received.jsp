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
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_currency= '<%= request.getParameter("idcurr") %>';
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    
    jQuery(document).ready(function(){  
        
         $("#giroReceivedCurrencySearchCode").val(id_currency);
        
        $("#dlgGiroReceived_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_giroReceived_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row GiroReceived");
                return;
            }

            var data_search_giroReceived = $("#dlgSearch_giroReceived_grid").jqGrid('getRowData', selectedRowId);
            
            var amount = numberWithCommas(data_search_giroReceived.amount); // add commas back in

            $("#"+id_document+"\\.giroReceived\\.code",opener.document).val(data_search_giroReceived.code);
            $("#"+id_document+"\\.transferReceivedDate",opener.document).val(data_search_giroReceived.transactionDate);
            $("#"+id_document+"\\.transferReceivedNo",opener.document).val(data_search_giroReceived.giroNo);
            $("#"+id_document+"\\.transferBankName",opener.document).val(data_search_giroReceived.bankName);
            $("#"+id_document+"\\.receivedFrom",opener.document).val(data_search_giroReceived.receivedFrom);
            $("#"+id_document+"\\.totalTransactionAmount",opener.document).val(amount);
            window.opener.calculateBankReceivedTotalTransactionAmountIDR();
            window.close();
        });


        $("#dlgGiroReceived_cancelButton").click(function(ev) { 
            data_search_giroReceived = null;
            window.close();
        });
    
    
        $("#btn_dlg_GiroReceivedSearch").click(function(ev) {
            formatDate();
            $("#dlgSearch_giroReceived_grid").jqGrid("setGridParam",{url:"finance/giro-received-data?" + $("#frmGiroReceivedSearch").serialize(), page:1});
            $("#dlgSearch_giroReceived_grid").trigger("reloadGrid");
            formatDate();
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#giroReceivedSearchFirstDate").val(firstDateFormat);
        $("#giroReceivedSearchLastDate").val(lastDateFormat);
     });
     
    function numberWithCommas(x) {
        var parts = x.toString().split(".");

        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    } 
    
    function formatDate(){
        var firstDate=$("#giroReceivedSearchFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=$("#giroReceivedSearchLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];

        $("#giroReceivedSearchFirstDate").val(firstDateFormat);
        $("#giroReceivedSearchLastDate").val(lastDateFormat);
    }
    
</script>
    
    <body
        <div class="ui-widget">
            <s:form id="frmGiroReceivedSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right" valign="center" ><b>Period</b></td>
                    <td colspan="4">
                        <sj:datepicker id="giroReceivedSearchFirstDate" name="giroReceivedSearchFirstDate" displayFormat="dd/mm/yy" showOn="focus" size="15" title="Format DD/MM/YYYY"></sj:datepicker>
                        <B>Up To</B>
                        <sj:datepicker id="giroReceivedSearchLastDate" name="giroReceivedSearchLastDate" displayFormat="dd/mm/yy" showOn="focus" size="15" title="Format DD/MM/YYYY"></sj:datepicker>
                        <s:textfield id="giroReceivedSearchGiroStatus" name="giroReceivedSearchGiroStatus" size="10" value="Pending" cssStyle="Display:none"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="giroReceivedSearchCode" name="giroReceivedSearchCode" label="Code" placeHolder=" Code"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Giro No</td>
                    <td>
                        <s:textfield id="giroReceivedSearchGiroNo" name="giroReceivedSearchGiroNo" label="Code" placeHolder=" Giro No"></s:textfield>
                    </td>
                    <td width="20px"/>
                    <td align="right">Bank</td>
                    <td>
                        <s:textfield id="giroReceivedBankSearchCode" name="giroReceivedBankSearchCode" label="Code" placeHolder=" Code" size="15"></s:textfield>
                        <s:textfield id="giroReceivedBankSearchName" name="giroReceivedBankSearchName" label="Code" placeHolder=" Name" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_GiroReceivedSearch" button="true">Search</sj:a></td>
                </tr>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_giroReceived_grid"
                dataType="json"
                href="%{remoteurlGiroReceivedSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listGiroReceivedTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnugiroReceived').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Giro Code" width="120" sortable="true"
                />
                <sjg:gridColumn
                    name="transactionDate" index="transactionDate" key="transactionDate" 
                    title="Transaction Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="receivedFrom" index="receivedFrom" key="receivedFrom" title="Received From" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="giroNo" index="giroNo" key="giroNo" title="Giro No" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="80" sortable="true"
                />
                <sjg:gridColumn
                    name="currencyName" index="currencyName" key="currencyName" title="Currency Name" width="80" sortable="true"
                />
                <sjg:gridColumn
                    name="bankCode" index="bankCode" key="bankCode" title="Bank Code" width="80" sortable="true"
                />
                <sjg:gridColumn
                    name="bankName" index="bankName" key="bankName" title="Bank Name" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="amount" index="amount" key="amount" title="Amount" width="100" sortable="true"
                    formatter="number"
                    align="right"
                    formatoptions= "{ thousandsSeparator:','}"
                />
                
            </sjg:grid >

        </div>
        <br/>
        <br/>

                <sj:a href="#" id="dlgGiroReceived_okButton" button="true">Ok</sj:a>
                <sj:a href="#" id="dlgGiroReceived_cancelButton" button="true">Cancel</sj:a>

        </body>
</html>