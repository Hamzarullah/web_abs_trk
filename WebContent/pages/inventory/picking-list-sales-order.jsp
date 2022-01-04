                                                 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
    #pickingListSalesOrderTradeItemDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("pickingListSalesOrder_grid_onSelect", function(event, data){
            var selectedRowID = $("#pickingListSalesOrder_grid").jqGrid("getGridParam", "selrow"); 
            var pickingListSalesOrder = $("#pickingListSalesOrder_grid").jqGrid("getRowData", selectedRowID);
            
            $("#pickingListSalesOrderTradeItemDetail_grid").jqGrid("setGridParam",{url:"inventory/picking-list-sales-order-trade-item-detail-data?pickingListSalesOrder.code=" + pickingListSalesOrder.code});
            $("#pickingListSalesOrderTradeItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL : " + pickingListSalesOrder.code);
            $("#pickingListSalesOrderTradeItemDetail_grid").trigger("reloadGrid");  
            
            $("#pickingListSalesOrderTradeItemQuantityDetail_grid").jqGrid("setGridParam",{url:"inventory/picking-list-sales-order-trade-item-quantity-detail-data?pickingListSalesOrder.code=" + pickingListSalesOrder.code});
            $("#pickingListSalesOrderTradeItemQuantityDetail_grid").jqGrid("setCaption", "ITEM QUANTITY DETAIL : " + pickingListSalesOrder.code);
            $("#pickingListSalesOrderTradeItemQuantityDetail_grid").trigger("reloadGrid");  
            
        });
        
        $('#btnPickingListSalesOrderNew').click(function(ev) {
            
//            var urlPeriodClosing="finance/period-closing-confirmation";
//            var paramsPeriodClosing="";
//
//            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
//                var data=(result);
//                if (data.error) {
//                    alertMessage(data.errorMessage);
//                    return;
//                }
//                
//                var urlAuthority = "inventory/picking-list-sales-order-authority";
//                var paramAuthority = "usedModule=MAIN&actionAuthority=INSERT";
//                $.post(urlAuthority, paramAuthority, function(data) {
//                    if (data.error) {
//                        alertMessage(data.errorMessage);
//                        return;
//                    }else{
//                        var url = "inventory/picking-list-sales-order-input";
//                        var params = "";
//                        pageLoad(url, params, "#tabmnuPICKING_LIST_SALES_ORDER");
//                    }
//                });
//            });
            
            var url = "inventory/picking-list-sales-order-input";
                        var params = "";
                        pageLoad(url, params, "#tabmnuPICKING_LIST_SALES_ORDER");
        });
                
        $('#btnPickingListSalesOrderDelete').click(function(ev) {
            
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#pickingListSalesOrder_grid").jqGrid('getGridParam','selrow');
                var pickingListSalesOrder = $("#pickingListSalesOrder_grid").jqGrid("getRowData", selectRowId);
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var urlAuthority = "inventory/picking-list-sales-order-authority";
                var paramAuthority = "usedModule=MAIN&actionAuthority=DELETE&headerCode=" + pickingListSalesOrder.code;
                
                $.post(urlAuthority,paramAuthority,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }else {
                        var dynamicDialog= $(
                            '<div id="conformBoxError">'+
                            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>Are You Sure To Delete?<br/><br/>' +
                            '<span style="float:left; margin:0 7px 20px 0;">'+
                            '</span>PLT-SO No: '+pickingListSalesOrder.code+'<br/><br/>' +    
                            '</div>');
                        dynamicDialog.dialog({
                            title           : "Confirmation",
                            closeOnEscape   : false,
                            modal           : true,
                            width           : 300,
                            resizable       : false,
                            buttons         : 
                                            [{
                                                text : "Yes",
                                                click : function() {
                                                    var url = "inventory/picking-list-sales-order-delete";
                                                    var params = "pickingListSalesOrder.code=" + pickingListSalesOrder.code;

                                                    $.post(url, params, function(data) {
                                                        if (data.error) {
                                                            alertMessage(data.errorMessage);
                                                            return;
                                                        }else {
                                                            alertMessage(data.message);
                                                            reloadGridPickingListSalesOrder();
                                                            reloadGridDetailAfterDeleteSO();
                                                        }
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
                    }
                    
                });
                                 
            });
            ev.preventDefault();
        });
        
        $('#btnPickingListSalesOrderRefresh').click(function(ev) {
            var url = "inventory/picking-list-sales-order";
            var params = "";
            pageLoad(url, params, "#tabmnuPICKING_LIST_SALES_ORDER");              
        });
        
        $('#btnPickingListSalesOrder_search').click(function(ev) {
            formatDatePickingListSO();
            $("#pickingListSalesOrderTradeItemDetail_grid").jqGrid("clearGridData");
            $("#pickingListSalesOrderTradeItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL");
            $("#pickingListSalesOrderTradeItemQuantityDetail_grid").jqGrid("clearGridData");
            $("#pickingListSalesOrderTradeItemQuantityDetail_grid").jqGrid("setCaption", "ITEM QUANTITY DETAIL");
            $("#pickingListSalesOrder_grid").jqGrid("clearGridData");
            $("#pickingListSalesOrder_grid").jqGrid("setGridParam",{url:"inventory/picking-list-sales-order-data?" + $("#frmPickingListSalesOrderSearchInput").serialize()});
            $("#pickingListSalesOrder_grid").trigger("reloadGrid");
            formatDatePickingListSO();
            ev.preventDefault();
        });
        
         $("#btnPickingListSalesOrderPrint").click(function(ev) {
            var selectRowId = $("#pickingListSalesOrder_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var pickingListSalesOrder = $("#pickingListSalesOrder_grid").jqGrid('getRowData', selectRowId);
               
            var url = "sales/picking-list-sales-order-print-out-pdf?";
            var params = "psoNo=" + pickingListSalesOrder.code;
              
            window.open(url+params,'pickingListSalesOrder','width=500,height=500');
        });
        
    });
    
    function reloadGridPickingListSalesOrder() {
        $("#pickingListSalesOrder_grid").trigger("reloadGrid");
    };
    
    function reloadGridDetailAfterDeleteSO() {
        $("#pickingListSalesOrderTradeItemDetail_grid").jqGrid("clearGridData");
        $("#pickingListSalesOrderTradeItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL");        
        $("#pickingListSalesOrderTradeItemQuantityDetail_grid").jqGrid("clearGridData");
        $("#pickingListSalesOrderTradeItemQuantityDetail_grid").jqGrid("setCaption", "ITEM QUANTITY DETAIL");        
    };
    
    function formatDatePickingListSO(){
        var firstDate=$("#pickingListSalesOrderSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#pickingListSalesOrderSearchFirstDate").val(firstDateValue);

        var lastDate=$("#pickingListSalesOrderSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#pickingListSalesOrderSearchLastDate").val(lastDateValue);
    }
</script>

<s:url id="remoteurlPickingListSalesOrder" action="picking-list-sales-order-data" />
<s:url id="remoteurlPickingListSalesOrderDetail" action="" />
<b>PICKING LIST SALES ORDER</b>
<hr>
<br class="spacer" />
<sj:div id="pickingListPickingListSalesOrderButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnPickingListSalesOrderNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnPickingListSalesOrderDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnPickingListSalesOrderRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPickingListSalesOrderPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
</sj:div>
<br class="spacer" />
<br class="spacer" />

<div id="pickingListPickingListSalesOrderInputSearch" class="content ui-widget">
    <s:form id="frmPickingListSalesOrderSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Period</td>
                <td>
                    <sj:datepicker id="pickingListSalesOrderSearchFirstDate" name="pickingListSalesOrderSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    To
                    <sj:datepicker id="pickingListSalesOrderSearchLastDate" name="pickingListSalesOrderSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td  align="right">Code</td>
                <td>
                    <s:textfield id="pickingListSalesOrderSearchCode" name="pickingListSalesOrderSearchCode" size="25" placeholder=" PLT-SO No"></s:textfield>
                </td>                    
                <td width="10"/>
            </tr>
            <tr>
                <td  align="right">SO No</td>
                <td>
                    <s:textfield id="pickingListSalesOrderSearchSalesOrderCode" name="pickingListSalesOrderSearchSalesOrderCode" size="25" placeholder=" SO No"></s:textfield>
                </td>                    
                <td width="10"/>
                <td align="right">Ref No</td>
                <td>
                    <s:textfield id="pickingListSalesOrderSearchRefNo" name="pickingListSalesOrderSearchRefNo" size="30"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="pickingListSalesOrderSearchCustomerCode" name="pickingListSalesOrderSearchCustomerCode" size="10" placeholder=" Code"></s:textfield>
                    <s:textfield id="pickingListSalesOrderSearchCustomerName" name="pickingListSalesOrderSearchCustomerName" size="25" placeholder=" Name"></s:textfield>
                </td>
                <td width="10"/>
                <td align="right">Remark</td>
                <td>
                    <s:textfield id="pickingListSalesOrderSearchRemark" name="pickingListSalesOrderSearchRemark" size="30"></s:textfield>
                </td>
            </tr>
        </table>
        <br />
        <sj:a href="#" id="btnPickingListSalesOrder_search" button="true">Search</sj:a>
        <br />
        <br />
    </s:form>
</div>
<br class="spacer" />
                  
<!-- GRID HEADER -->    
<div id="pickingListPickingListSalesOrderGrid">
    <sjg:grid
        id="pickingListSalesOrder_grid"
        caption="PICKING LIST - SALES ORDER"
        dataType="json"
        href="%{remoteurlPickingListSalesOrder}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPickingListSalesOrderTemp"
        rowList="10,20,30"
        rowNum="10"
        sortname="transactionDate"
        sortorder="desc"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuPICKING_LIST_SALES_ORDER').width()"
        onSelectRowTopics="pickingListSalesOrder_grid_onSelect"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="PLT-SO No" width="150" sortable="true" 
        />
        <sjg:gridColumn
            name="salesOrderCode" index="salesOrderCode" key="salesOrderCode" title="SO No" width="150" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  title="Transaction Date" 
            width="150" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="salesOrderCustomerCode" index="salesOrderCustomerCode" key="salesOrderCustomerCode" title="Customer" width="100" sortable="true"  align="center"
        />
        <sjg:gridColumn
            name="salesOrderCustomerName" index="salesOrderCustomerName" key="salesOrderCustomerName" title="Customer Name" width="100" sortable="true"  align="center"
        />
        <sjg:gridColumn
            name="customerAddressCode" index="customerAddressCode" key="customerAddressCode" title="Ship To Code" width="100" sortable="true" 
        />
        <sjg:gridColumn
            name="customerAddressName" index="customerAddressName" key="customerAddressName" title="Ship To Name" width="100" sortable="true" 
        />
        <sjg:gridColumn
            name="customerAddressAddress" index="customerAddressAddress" key="customerAddressAddress" title="Ship To Address" width="100" sortable="true" 
        />
        <sjg:gridColumn
            name="warehouseCode" index="warehouseCode" key="warehouseCode" title="Warehouse Code" width="100" sortable="true" 
        />
        <sjg:gridColumn
            name="warehouseName" index="warehouseName" key="warehouseName" title="Warehouse Name" width="100" sortable="true" 
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="200" sortable="true" 
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true" 
        />
    </sjg:grid >
</div>
<br class="spacer" />
<div id="pickingListSalesOrderTradeItemDetailGrid">
    <sjg:grid
        id="pickingListSalesOrderTradeItemDetail_grid"
        caption="ITEM DETAIL"
        dataType="json"
        pager="true"
        navigator="false"
        navigatorSearch="false"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPickingListSalesOrderTradeItemDetailTemp"
        width="$('#tabmnuPICKING_LIST_SALES_ORDER').width()"
        viewrecords="true"
        rownumbers="true"
        rowNum="10000"
        shrinkToFit="false"
        href="%{remoteurlPickingListSalesOrderDetail}"
        onSelectRowTopics="pickingListSalesOrderDetail_grid_onSelect"
    > 
        <sjg:gridColumn
            name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "false" hidden="true"
        />
        <sjg:gridColumn
            name = "headerCode" index = "headerCode" key = "headerCode" title = "Header Code" width = "100" sortable = "false" hidden="true"
        />
        <sjg:gridColumn
            name = "itemCode" id="itemCode" index = "itemCode" key = "itemCode" title = "Item Code" width = "100" sortable = "false"
        />
        <sjg:gridColumn
            name = "itemName" index = "itemName" key = "itemName" title = "Item Name" width = "200" sortable = "false"
        />
        <sjg:gridColumn
            name="quantity" index="quantity" key="quantity" title="Quantity" width="75" sortable="true" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
        />
    </sjg:grid >
</div>
<br class="spacer" />
<div id="pickingListSalesOrderTradeItemQuantityDetailGrid">
    <sjg:grid
        id="pickingListSalesOrderTradeItemQuantityDetail_grid"
        caption="ITEM QUANTITY DETAIL"
        dataType="json"
        pager="true"
        navigator="false"
        navigatorSearch="false"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPickingListSalesOrderTradeItemQuantityDetailTemp"
        width="$('#tabmnuPICKING_LIST_SALES_ORDER').width()"
        viewrecords="true"
        rownumbers="true"
        rowNum="10000"
        shrinkToFit="false"
    > 
        <sjg:gridColumn
            name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "false" hidden="true"
        />
        <sjg:gridColumn
            name = "headerCode" index = "headerCode" key = "headerCode" title = "Header Code" width = "100" sortable = "false" hidden="true"
        />
        <sjg:gridColumn
            name = "itemCode" index = "itemCode" key = "itemCode" title = "Item Code" width = "100" sortable = "false"
        />
        <sjg:gridColumn
            name = "itemName" index = "itemName" key = "itemName" title = "Item Name" width = "200" sortable = "false"
        />
        <sjg:gridColumn
            name = "itemAlias" index = "itemAlias" key = "itemAlias" title = "Item Alias" width = "200" sortable = "false"
        />
        <sjg:gridColumn
            name="quantity" index="quantity" key="quantity" title="Quantity" width="75" sortable="true" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
        />
        <sjg:gridColumn
            name = "itemUnitOfMeasureCode" index = "itemUnitOfMeasureCode" key = "itemUnitOfMeasureCode" title = "Unit" width = "80" sortable = "false" align="center"
        />
        <sjg:gridColumn
            name = "rackCode" index = "rackCode" key = "rackCode" title = "Rack Code" width = "140" sortable = "false"
        />
        <sjg:gridColumn
            name = "rackName" index = "rackName" key = "rackName" title = "Rack Name" width = "250" sortable = "false"
        />
    </sjg:grid >
</div>