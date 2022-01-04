
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
    #purchaseRequestBySalesOrderDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("purchaseRequestBySalesOrder_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseRequestBySalesOrder_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseRequestBySalesOrder = $("#purchaseRequestBySalesOrder_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseRequestBySalesOrderDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-by-sales-order-detail-data?purchaseRequestBySalesOrder.code="+ purchaseRequestBySalesOrder.code});
            $("#purchaseRequestBySalesOrderDetail_grid").jqGrid("setCaption", "PURCHASE REQUEST BY SALES ORDER DETAIL");
            $("#purchaseRequestBySalesOrderDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnPurchaseRequestBySalesOrderNew").click(function (ev) {
           
            var url = "purchasing/purchase-request-by-sales-order-input";
            var param = "";

            pageLoad(url, param, "#tabmnuPURCHASE_REQUEST");
            ev.preventDefault();    
        });
        
        $("#btnPurchaseRequestBySalesOrderUpdate").click(function (ev) {
            
            var deleteRowId = $("#purchaseRequestBySalesOrder_grid").jqGrid('getGridParam','selrow');
            var purchaseRequestBySalesOrder = $("#purchaseRequestBySalesOrder_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var params = "purchaseRequestBySalesOrderUpdateMode=true" + "&purchaseRequestBySalesOrder.code=" + purchaseRequestBySalesOrder.code;
            pageLoad("purchasing/purchase-request-by-sales-order-input", params, "#tabmnuPURCHASE_REQUEST"); 

            ev.preventDefault();
            
        });
        
        $("#btnPurchaseRequestBySalesOrderDelete").click(function (ev) {
            
            var deleteRowId = $("#purchaseRequestBySalesOrder_grid").jqGrid('getGridParam','selrow');
            var purchaseRequestBySalesOrder = $("#purchaseRequestBySalesOrder_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "purchasing/purchase-request-by-sales-order-delete";
            var params = "purchaseRequestBySalesOrder.code=" + purchaseRequestBySalesOrder.code;
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PRQ No: '+purchaseRequestBySalesOrder.code+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title           : "Message",
                closeOnEscape   : false,
                modal           : true,
                width           : 300,
                resizable       : false,
                buttons         : [{
                                    text : "Yes",
                                    click : function() {
                                        $.post(url, params, function(data) {
                                            if (data.error) {
                                                alertMessage(data.errorMessage,400,"");
                                                return;
                                            }
                                          $("#purchaseRequestBySalesOrder_grid").trigger("reloadGrid");
                                          $("#purchaseRequestBySalesOrderDetail_grid").trigger("reloadGrid");
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
            ev.preventDefault();
            
        });
        
        $("#btnPurchaseRequestBySalesOrderRefresh").click(function (ev) {
            var url = "purchasing/purchase-request-by-sales-order";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_REQUEST");
            ev.preventDefault();
        });
        
        $('#btnPurchaseRequestBySalesOrder_search').click(function(ev) {
            formatDatePRQNonSo();
            $("#purchaseRequestBySalesOrder_grid").jqGrid("clearGridData");
            $("#purchaseRequestBySalesOrder_grid").jqGrid("setGridParam",{url:"purchase-request-by-sales-order-data?" + $("#frmPurchaseRequestBySalesOrderSearchInput").serialize()});
            $("#purchaseRequestBySalesOrder_grid").trigger("reloadGrid");
            formatDatePRQNonSo();
            ev.preventDefault();
        });
    
    }); //EOF READY
    
    function formatDatePRQNonSo(){
        var firstDate=$("#purchaseRequestBySalesOrder\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseRequestBySalesOrder\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseRequestBySalesOrder\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseRequestBySalesOrder\\.transactionLastDate").val(lastDateValue);
    }
    
</script>

<s:url id="remoteurlPurchaseRequestBySalesOrder" action="purchase-request-by-sales-order-data" />
    <b>PURCHASE REQUEST BY SALES ORDER</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseRequestBySalesOrderButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnPurchaseRequestBySalesOrderNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnPurchaseRequestBySalesOrderUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnPurchaseRequestBySalesOrderDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnPurchaseRequestBySalesOrderRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnPurchaseRequestBySalesOrderPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="purchaseRequestBySalesOrderInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseRequestBySalesOrderSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseRequestBySalesOrder.transactionFirstDate" name="purchaseRequestBySalesOrder.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="purchaseRequestBySalesOrder.transactionLastDate" name="purchaseRequestBySalesOrder.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Code</td>
                    <td>
                        <s:textfield id="purchaseRequestBySalesOrder.code" name="purchaseRequestBySalesOrder.code" size="27" placeholder=" PRQ No"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Branch</td>
                    <td>
                        <s:textfield id="purchaseRequestBySalesOrder.branchCode" name="purchaseRequestBySalesOrder.branchCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseRequestBySalesOrder.branchName" name="purchaseRequestBySalesOrder.branchName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseRequestBySalesOrder_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
                  
    <!-- GRID HEADER -->    
    <div id="purchaseRequestBySalesOrderGrid">
        <sjg:grid
            id="purchaseRequestBySalesOrder_grid"
            caption="PURCHASE REQUEST BY SALES ORDER"
            dataType="json"
            href="%{remoteurlPurchaseRequestBySalesOrder}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseRequestBySalesOrder"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupurchaserequestnonsalesorder').width()"
            onSelectRowTopics="purchaseRequestBySalesOrder_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Transaction Date" width="150" search="false" align="center"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="Branch Code" width="150"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="Branch Name" width="150"
            />
            <sjg:gridColumn
                name="requestBy" index="requestBy" key="requestBy" title="Request By" width="150"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="150"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="150"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div id="purchaseRequestBySalesOrderDetailGrid">
        <sjg:grid
            id="purchaseRequestBySalesOrderDetail_grid"
            caption="PURCHASE REQUEST BY SALES ORDER DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseRequestBySalesOrderDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#tabmnupurchaserequestnonsalesorder').width()"
        > 
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="140" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name = "itemCode" id="itemCode" index = "itemCode" key = "itemCode" title = "Item Code" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "itemName" index = "itemName" key = "itemName" title = "Item Name" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "quantity" index = "quantity" key = "quantity" title = "Quantity" formatter="number" width = "150" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="unitOfMeasureName" index="unitOfMeasureName" key="unitOfMeasureName" title="UOM" width="150" sortable="true" 
            />
        </sjg:grid >
    </div>
    
    

