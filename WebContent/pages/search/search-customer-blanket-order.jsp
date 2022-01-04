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
      
    var search_customerBlanketOrder_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgCustomerBlanketOrder_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_customercustomerBlanketOrder_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row BOD!");
                return;
            }
                
            var data_search_customerBlanketOrder = $("#dlgSearch_customercustomerBlanketOrder_grid").jqGrid('getRowData', selectedRowId);

            if (search_customerBlanketOrder_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"CustomerBlanketOrderCode",opener.document).val(data_search_customerBlanketOrder.code);
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_customerBlanketOrder.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.customerPurchaseOrder\\.code",opener.document).val(data_search_customerBlanketOrder.customerPurchaseOrderCode);
                $("#"+id_document+"\\.currency\\.code",opener.document).val(data_search_customerBlanketOrder.currencyCode);
                $("#"+id_document+"\\.currency\\.name",opener.document).val(data_search_customerBlanketOrder.currencyName);
                $("#"+id_document+"\\.project\\.code",opener.document).val(data_search_customerBlanketOrder.projectCode);
                $("#"+id_document+"\\.project\\.name",opener.document).val(data_search_customerBlanketOrder.projectName);
                $("#"+id_document+"\\.customer\\.code",opener.document).val(data_search_customerBlanketOrder.customerCode);
                $("#"+id_document+"\\.customer\\.name",opener.document).val(data_search_customerBlanketOrder.customerName);
                $("#"+id_document+"\\.endUser\\.code",opener.document).val(data_search_customerBlanketOrder.endUserCode);
                $("#"+id_document+"\\.endUser\\.name",opener.document).val(data_search_customerBlanketOrder.endUserName);
                $("#"+id_document+"\\.salesPerson\\.code",opener.document).val(data_search_customerBlanketOrder.salesPersonCode);
                $("#"+id_document+"\\.salesPerson\\.name",opener.document).val(data_search_customerBlanketOrder.salesPersonName);
                
            }
            window.close();
        });

        $("#dlgCustomerBlanketOrder_cancelButton").click(function(ev) { 
            data_search_customerBlanketOrder = null;
            window.close();
        });
    
        $("#btn_dlg_CustomerBlanketOrderSearch").click(function(ev) {
            formatDate();
            $("#dlgSearch_customercustomerBlanketOrder_grid").jqGrid("setGridParam",{url:"sales/blanket-order-search-data?" + $("#frmCustomerBlanketOrderSearch").serialize(), page:1});
            $("#dlgSearch_customercustomerBlanketOrder_grid").trigger("reloadGrid");
            formatDate();
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#blanketOrderSearchFirstDate").val(firstDateFormat);
        $("#blanketOrderSearchLastDate").val(lastDateFormat);
        
     });
     
     function formatDate(){
        var firstDate=$("#blanketOrderSearchFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#blanketOrderSearchFirstDate").val(firstDateFormat);
    
        var lastDate=$("#blanketOrderSearchLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#blanketOrderSearchLastDate").val(lastDateFormat);
    }
    
</script>
<body>
<s:url id="remoteurlCustomerBlanketOrderSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmCustomerBlanketOrderSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *<B/></td>
                <td>
                    <sj:datepicker id="blanketOrderSearchFirstDate" name="blanketOrderSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    To
                    <sj:datepicker id="blanketOrderSearchLastDate" name="blanketOrderSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="blanketOrder.customerPurchaseOrderCode" name="blanketOrder.customerPurchaseOrderCode" PlaceHolder=" BOD No"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="blanketOrder.customerCode" name="blanketOrder.customerCode" size="25" PlaceHolder=" Code"></s:textfield>
                    <s:textfield id="blanketOrder.customerName" name="blanketOrder.customerName" size="40" PlaceHolder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerBlanketOrderSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_customercustomerBlanketOrder_grid"
            dataType="json"
            href="%{remoteurlCustomerBlanketOrderSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCustomerBlanketOrder"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucustomerBlanketOrder').width()"
        >
            <sjg:gridColumn
                name="code" index="code" 
                title="BOD No" width="120" sortable="true" edittype="text" hidden="true"
            />     
            <sjg:gridColumn
                name="customerPurchaseOrderCode" index="customerPurchaseOrderCode" 
                title="POC No" width="120" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" 
                title="Customer Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" 
                title="Customer Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="salesPersonCode" index="salesPersonCode" 
                title="SalesPerson Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="endUserCode" index="endUserCode" 
                title="EndUserCode" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="endUserName" index="endUserName" 
                title="EndUserName" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesPersonName" index="salesPersonName" 
                title="SalesPerson Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" 
                title="CurrencyCode" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="currencyName" index="currencyName" 
                title="CurrencyName" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="projectCode" index="projectCode" 
                title="Project" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="projectName" index="projectName" 
                title="Project" width="100" sortable="true"
            />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgCustomerBlanketOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgCustomerBlanketOrder_cancelButton" button="true">Cancel</sj:a>
</body>
</html>