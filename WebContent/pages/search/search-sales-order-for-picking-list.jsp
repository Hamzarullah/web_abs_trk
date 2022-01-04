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
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
    </style>
    
<style> 
    html {
        overflow: -moz-scrollbars-vertical;
    }
</style>
<script type = "text/javascript">
    
    var search_salesOrder_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc='<%= request.getParameter("idsubdoc") %>';
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    
    jQuery(document).ready(function(){  
        
       
        $("#btn_dlg_SalesOrderSearch").click(function(ev) {
            formatDate();
            $("#dlgSearch_salesOrderPickingList_grid").jqGrid("setGridParam",{url:"sales/sales-order-search-picking-data?" + $("#frmSalesOrderPickingListSearch").serialize(), page:1});
            $("#dlgSearch_salesOrderPickingList_grid").trigger("reloadGrid");
            formatDate();
            ev.preventDefault();
        });
        
        $("#dlgSalesOrder_okButton").click(function(ev) {
            var selectedRowId = $("#dlgSearch_salesOrderPickingList_grid").jqGrid("getGridParam","selrow");
        
            if(selectedRowId === null){
                alert("Please Select Row SalesOrder!");
                return;
            }

            var data_search_salesOrder = $("#dlgSearch_salesOrderPickingList_grid").jqGrid('getRowData', selectedRowId);

            if (search_salesOrder_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"salesOrder_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_salesOrderCode",opener.document).val(data_search_salesOrder.code);
                $("#"+id_document+"salesOrderInput_grid",opener.document).jqGrid("setCell", selectedRowID, "salesOrderName", data_search_salesOrder.name);            
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_salesOrder.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.transactionDate",opener.document).val(data_search_salesOrder.transactionDate);
                $("#"+id_document+"\\."+id_subdoc+"\\.deliveryDate",opener.document).val(data_search_salesOrder.requestDeliveryDate);               
                $("#"+id_document+"\\.branch\\.code",opener.document).val(data_search_salesOrder.branchCode);
                $("#"+id_document+"\\.branch\\.name",opener.document).val(data_search_salesOrder.branchName);                
                $("#"+id_document+"\\.currency\\.code",opener.document).val(data_search_salesOrder.currencyCode);
                $("#"+id_document+"\\.currency\\.name",opener.document).val(data_search_salesOrder.currencyName);                
                $("#"+id_document+"\\."+id_subdoc+"\\.transactionStatus",opener.document).val(data_search_salesOrder.transactionStatus);
                $("#"+id_document+"\\."+id_subdoc+"\\.salesOrderType\\.code",opener.document).val(data_search_salesOrder.salesOrderTypeCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.code",opener.document).val(data_search_salesOrder.customerCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.name",opener.document).val(data_search_salesOrder.customerName);
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.address",opener.document).val(data_search_salesOrder.customerAddress);  
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.cityCode",opener.document).val(data_search_salesOrder.cityCode);  
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.defaultContactPersonCode",opener.document).val(data_search_salesOrder.defaultContactPersonCode);  
                $("#"+id_document+"\\."+id_subdoc+"\\.city\\.name",opener.document).val(data_search_salesOrder.cityName);  
                $("#"+id_document+"\\."+id_subdoc+"\\.salesPerson\\.code",opener.document).val(data_search_salesOrder.salesPersonCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.salesPerson\\.name",opener.document).val(data_search_salesOrder.salesPersonName);  
                $("#"+id_document+"\\.customerAddress\\.code",opener.document).val(data_search_salesOrder.shipToCode);  
                window.opener.loadDataPickingListSalesOrderDetail(data_search_salesOrder.code);
                
            }
            
            window.close();
        });
        
        $("#dlgSalesOrderPickingList_cancelButton").click(function(ev) {
            data_search_country = null;
            window.close();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#salesOrderFirstDate").val(firstDateFormat);
        $("#salesOrderLastDate").val(lastDateFormat);
        
    });    
    
    function formatDate(){
         var firstDate=$("#salesOrderFirstDate").val().split("/");
         var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
         var lastDate=$("#salesOrderLastDate").val().split("/");
         var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];

         $("#salesOrderFirstDate").val(firstDateFormat);
         $("#salesOrderLastDate").val(lastDateFormat);
    }
</script>
<body>
<s:url id="remoteurlSalesOrderPickingListSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmSalesOrderPickingListSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" width="80px"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="salesOrderFirstDate" name="salesOrderFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="salesOrderLastDate" name="salesOrderLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>    
            </tr>
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="salesOrderSearchCode" name="salesOrderSearchCode" title="Code" placeHolder=" SODNo"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="salesOrderSearchCustomerCode" name="salesOrderSearchCustomerCode" placeHolder=" code" size="15"></s:textfield>
                    <s:textfield id="salesOrderSearchCustomerName" name="salesOrderSearchCustomerName" placeHolder=" name" size="25"></s:textfield>
                </td>        
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_SalesOrderSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_salesOrderPickingList_grid"
            dataType="json"
            href="%{remoteurlSalesOrderPickingListSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listSalesOrderTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuSalesOrder').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="175" sortable="true"
            />
            <sjg:gridColumn
                name="shipToCode" index="shipToCode" key="shipToCode" title="ship To Code" width="175" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="120" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="requestDeliveryDate" index="requestDeliveryDate" key="requestDeliveryDate" 
                title="DeliveryDate" width="100" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" title="Currency" width="75" sortable="true"
            />
            <sjg:gridColumn
                name="currencyName" index="currencyName" title="Currency Name" width="100" sortable="true"
            />
            <sjg:gridColumn
               name="branchCode" index="branchCode" title="Branch" width="75" sortable="true"
            />
            <sjg:gridColumn
               name="branchName" index="branchName" title="Branch Name" width="100" sortable="true"
            />
            <sjg:gridColumn
               name="transactionStatus" index="transactionStatus" title="Transaction Status" width="110" sortable="true"
            />
            <sjg:gridColumn
               name="salesOrderTypeCode" index="salesOrderTypeCode" title="SO Type" width="75" sortable="true"
            />
            <sjg:gridColumn
               name="salesOrderTypeName" index="salesOrderTypeName" title="SO Type Name" width="150" sortable="true"
            />
            <sjg:gridColumn
               name="customerCode" index="customerCode" title="Customer" width="75" sortable="true"
            />
            <sjg:gridColumn
               name="customerName" index="customerName" title="Customer Name" width="200" sortable="true"
            />
            <sjg:gridColumn
               name="customerAddress" index="customerAddress" title="Customer Address" width="300" sortable="true"
            />
            <sjg:gridColumn
               name="salesPersonCode" index="salesPersonCode" title="Sales Person Code" width="200" sortable="true"
            />
            <sjg:gridColumn
               name="salesPersonName" index="salesPersonName" title="Sales Person Name" width="300" sortable="true"
            />
            <sjg:gridColumn
               name="cityCode" index="cityCode" title="City Code" width="200" sortable="true"
            />
            <sjg:gridColumn
               name="cityName" index="cityName" title="City Name" width="300" sortable="true"
            />
            <sjg:gridColumn
               name="defaultContactPersonCode" index="defaultContactPersonCode" title="Contact Person" width="300" sortable="true"
            />
        </sjg:grid >
    </div>
    <br/>
    <sj:a href="#" id="dlgSalesOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgSalesOrderPickingList_cancelButton" button="true">Cancel</sj:a>
    <br/>
</body>
</html>