
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
    #warehouseTransferInItemDetailViewSource_grid_pager_center,#warehouseTransferInItemDetailViewDestination_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
            
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("warehouseTransferIn_grid_onSelect", function(event, data){
            var selectedRowID = $("#warehouseTransferIn_grid").jqGrid("getGridParam", "selrow"); 
            var warehouseTransferIn = $("#warehouseTransferIn_grid").jqGrid("getRowData", selectedRowID);
            
            $("#warehouseTransferInItemDetailViewSource_grid").jqGrid("setGridParam",{url:"inventory/warehouse-transfer-out-item-detail-data?warehouseTransferOut.code=" + warehouseTransferIn.warehouseTransferOutCode});
            $("#warehouseTransferInItemDetailViewSource_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER IN DETAIL SOURCE: " + warehouseTransferIn.warehouseTransferOutCode);
            $("#warehouseTransferInItemDetailViewSource_grid").trigger("reloadGrid");
            
            $("#warehouseTransferInItemDetailViewDestination_grid").jqGrid("setGridParam",{url:"inventory/warehouse-transfer-in-item-detail-data?warehouseTransferIn.code=" + warehouseTransferIn.code});
            $("#warehouseTransferInItemDetailViewDestination_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER IN DETAIL DESTINATION: " + warehouseTransferIn.code);
            $("#warehouseTransferInItemDetailViewDestination_grid").trigger("reloadGrid");
            
        });
       
       $('#btnWarehouseTransferInNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "inventory/warehouse-transfer-in-input";
                var params = "";
                pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_IN");   

            });          
        });
       
        $('#btnWarehouseTransferInUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#warehouseTransferIn_grid").jqGrid('getGridParam','selrow');
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var warehouseTransferIn = $("#warehouseTransferIn_grid").jqGrid("getRowData", selectRowId);
                    
                var url = "inventory/warehouse-transfer-in-input";
                var params = "warehouseTransferInUpdateMode=true" + "&warehouseTransferIn.code=" + warehouseTransferIn.code;
                pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_IN");

            });
                    
            ev.preventDefault();
        });
        
        $("#btnWarehouseTransferInDelete").click(function(ev){
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#warehouseTransferIn_grid").jqGrid('getGridParam','selrow');
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
        
                var warehouseTransferIn = $("#warehouseTransferIn_grid").jqGrid('getRowData', selectRowId);
                var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>WHTI No: '+warehouseTransferIn.code+'<br/><br/>' +    
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
                                    var url = "inventory/warehouse-transfer-in-delete";
                                    var params = "warehouseTransferIn.code=" + warehouseTransferIn.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridWarehouseTransferIn();
                                        reloadGridWarehouseTransferInItemDetail();
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
        
        $('#btnWarehouseTransferInRefresh').click(function(ev) {
            var url = "inventory/warehouse-transfer-in";
            var params = "";
            
            pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_IN");   
        });
        
        $('#btnWarehouseTransferIn_search').click(function(ev) {
            formatDate();
            $("#warehouseTransferIn_grid").jqGrid("clearGridData");
            $("#warehouseTransferIn_grid").jqGrid("setGridParam",{url:"inventory/warehouse-transfer-in-data?" + $("#frmWarehouseTransferInSearchInput").serialize()});
            $("#warehouseTransferIn_grid").trigger("reloadGrid");
            $("#warehouseTransferInItemDetailList_grid").jqGrid("clearGridData");
            $("#warehouseTransferInItemDetailList_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER IN DETAIL");
            formatDate();
        });
        
        $("#btnWarehouseTransferInPrint").click(function(ev) {
            var selectRowId = $("#warehouseTransferIn_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var warehouseTransferIn = $("#warehouseTransferIn_grid").jqGrid('getRowData', selectRowId);
               
            var url = "inventory/warehouse-transfer-in-print-out-pdf?";
            var params = "wtiNo=" + warehouseTransferIn.code;
              
            window.open(url+params,'warehouseTransferIn','width=500,height=500');
        });
        
        $('#btnWarehouseTransferInRefresh').click(function(ev) {
            var url = "inventory/warehouse-transfer-in";
            var params = "";
            
            pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_IN");   
        });
        
        
    });
    
    function reloadGridWarehouseTransferIn() {
        $("#warehouseTransferIn_grid").trigger("reloadGrid");
    };
    
    function reloadGridWarehouseTransferInItemDetail() {
        $("#warehouseTransferInItemDetailViewSource_grid").jqGrid("clearGridData");
        $("#warehouseTransferInItemDetailViewSource_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER IN DETAIL SOURCE");
        $("#warehouseTransferInItemDetailViewDestination_grid").jqGrid("clearGridData");
        $("#warehouseTransferInItemDetailViewDestination_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER IN DETAIL DESTINATION");
    };
    
    function formatDate(){
        var firstDate=$("#warehouseTransferInSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#warehouseTransferInSearchFirstDate").val(firstDateValue);

        var lastDate=$("#warehouseTransferInSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#warehouseTransferInSearchLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlWarehouseTransferIn" action="warehouse-transfer-in-json" />
<b> WAREHOUSE TRANSFER IN</b>
<hr>
<br class="spacer" />
    <sj:div id="warehouseTransferInButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td>
                <a href="#" id="btnWarehouseTransferInNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <%--<td><a href="#" id="btnWarehouseTransferInUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>--%>
            <td><a href="#" id="btnWarehouseTransferInDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> 
                <a href="#" id="btnWarehouseTransferInRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td>
                <a href="#" id="btnWarehouseTransferInPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>  
    </table>
     </sj:div>
    <br class="spacer" />
        <s:form id="frmWarehouseTransferInSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="warehouseTransferInSearchFirstDate" name="warehouseTransferInSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="warehouseTransferInSearchLastDate" name="warehouseTransferInSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="warehouseTransferInSearchCode" name="warehouseTransferInSearchCode" placeHolder=" WHM No" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><b>RefNo</b></td>
                    <td>
                        <s:textfield id="warehouseMutationReceivingSearchRefNo" name="warehouseMutationReceivingSearchRefNo" placeHolder=" RefNo" size="15"></s:textfield>
                    </td>
                    <td align="right"><b>Remark</b></td>
                    <td>
                        <s:textfield id="warehouseMutationReceivingSearchRemark" name="warehouseMutationReceivingSearchRemark" placeHolder=" Remark" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><b>Warehouse</b></td>
                    <td>
                        <s:textfield id="warehouseTransferInWarehouseSearchCode" name="warehouseTransferInWarehouseSearchCode" placeHolder=" Code" size="15"></s:textfield>
                        <s:textfield id="warehouseTransferInWarehouseSearchName" name="warehouseTransferInWarehouseSearchName" placeHolder=" Name" size="30"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnWarehouseTransferIn_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="warehouseTransferInGrid">
        <sjg:grid
            id="warehouseTransferIn_grid"
            caption="WAREHOUSE TRANSFER IN"
            dataType="json"
            href="%{remoteurlWarehouseTransferIn}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listWarehouseTransferInTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="warehouseTransferIn_grid_onSelect"
            width="1100"
        >
             <sjg:gridColumn
                name="code" index="code" key="code" title="WHTI" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="warehouseTransferOutCode" index="warehouseTransferOutCode" key="warehouseTransferOutCode" title="WHTO" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="sourceWarehouseCode" index="sourceWarehouseCode" key="sourceWarehouseCode" title="Source Code" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="sourceWarehouseName" index="sourceWarehouseName" key="sourceWarehouseName" title="Source Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="destinationWarehouseCode" index="destinationWarehouseCode" key="destinationWarehouseCode" title="Destination Warehouse Code" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="destinationWarehouseName" index="destinationWarehouseName" key="destinationWarehouseName" title="Destination Warehouse Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true" 
            />    
        </sjg:grid>
    </div>
   
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="warehouseTransferInItemDetailViewSourceGrid">
        <sjg:grid
            id="warehouseTransferInItemDetailViewSource_grid"
            caption="WAREHOUSE TRANSFER IN DETAIL SOURCE"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listWarehouseTransferOutItemDetailTemp"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            onSelectRowTopics="warehouseTransferInItemDetailViewSource_grid_onSelect"
            width="1100"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="code" width="140" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Name" width="300" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialInventoryType" index="itemMaterialInventoryType" key="itemMaterialInventoryType" title="Inv Type" width="100" sortable="true" 
                hidden="true"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="cogsIdr" index="cogsIdr" key="cogsIdr" title="cogsIdr" width="80" sortable="true" 
                hidden="true"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Unit" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="RackCode" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="RackName" width="80" sortable="true" 
            />
            
        </sjg:grid >
    </div>
    
    <!-- GRID DETAIL DESTINATION-->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="warehouseTransferInItemDetailViewDestinationGrid">
        <sjg:grid
            id="warehouseTransferInItemDetailViewDestination_grid"
            caption="WAREHOUSE TRANSFER IN DETAIL DESTINATION"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listWarehouseTransferInItemDetailTemp"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            onSelectRowTopics="warehouseTransferInItemDetailViewDestination_grid_onSelect"
            width="1100"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="code" width="140" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Name" width="300" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialInventoryType" index="itemMaterialInventoryType" key="itemMaterialInventoryType" title="Inv Type" width="100" sortable="true" 
                hidden="true"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Unit" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="cogsIdr" index="cogsIdr" key="cogsIdr" title="cogsIdr" width="80" sortable="true" 
                hidden="true"
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="RackCode" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="RackName" width="80" sortable="true" 
            />
        </sjg:grid >
    </div>