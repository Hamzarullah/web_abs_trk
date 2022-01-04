
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
    #warehouseTransferOutItemDetailList_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
            
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("warehouseTransferOut_grid_onSelect", function(event, data){
            var selectedRowID = $("#warehouseTransferOut_grid").jqGrid("getGridParam", "selrow"); 
            var warehouseTransferOut = $("#warehouseTransferOut_grid").jqGrid("getRowData", selectedRowID);
            
            $("#warehouseTransferOutItemDetailList_grid").jqGrid("setGridParam",{url:"inventory/warehouse-transfer-out-item-detail-data?warehouseTransferOut.code=" + warehouseTransferOut.code});
            $("#warehouseTransferOutItemDetailList_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER OUT DETAIL : " + warehouseTransferOut.code);
            $("#warehouseTransferOutItemDetailList_grid").trigger("reloadGrid");
            
        });
        
        $('#btnWarehouseTransferOutNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "inventory/warehouse-transfer-out-input";
                var params = "";
                pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_OUT");   

            });          
        });
        
        $('#btnWarehouseTransferOutUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#warehouseTransferOut_grid").jqGrid('getGridParam','selrow');
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var warehouseTransferOut = $("#warehouseTransferOut_grid").jqGrid("getRowData", selectRowId);

                var url="inventory/warehouse-transfer-out-confirmation";
                var params="warehouseTransferOut.code="+warehouseTransferOut.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "inventory/warehouse-transfer-out-input";
                    var params = "warehouseTransferOutUpdateMode=true" + "&warehouseTransferOut.code=" + warehouseTransferOut.code;
                    pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_OUT");
                    
                });
            });
                    
            ev.preventDefault();
        });
        
        $("#btnWarehouseTransferOutDelete").click(function(ev){
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#warehouseTransferOut_grid").jqGrid('getGridParam','selrow');
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
        
                var warehouseTransferOut = $("#warehouseTransferOut_grid").jqGrid('getRowData', selectRowId);
                var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>WHTO No: '+warehouseTransferOut.code+'<br/><br/>' +    
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
                                    var url = "inventory/warehouse-transfer-out-delete";
                                    var params = "warehouseTransferOut.code=" + warehouseTransferOut.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridWarehouseTransferOut();
                                        reloadGridWarehouseTransferOutItemDetail();
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
        
        $('#btnWarehouseTransferOutRefresh').click(function(ev) {
            var url = "inventory/warehouse-transfer-out";
            var params = "";
            
            pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_OUT");   
        });
        
        $('#btnWarehouseTransferOut_search').click(function(ev) {
            formatDate();
            $("#warehouseTransferOut_grid").jqGrid("clearGridData");
            $("#warehouseTransferOut_grid").jqGrid("setGridParam",{url:"inventory/warehouse-transfer-out-data?" + $("#frmWarehouseTransferOutSearchInput").serialize()});
            $("#warehouseTransferOut_grid").trigger("reloadGrid");
            $("#warehouseTransferOutItemDetailList_grid").jqGrid("clearGridData");
            $("#warehouseTransferOutItemDetailList_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER OUT DETAIL");
            formatDate();
        });
        
        $("#btnWarehouseTransferOutPrint").click(function(ev) {
            var selectRowId = $("#warehouseTransferOut_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var warehouseTransferOut = $("#warehouseTransferOut_grid").jqGrid('getRowData', selectRowId);
               
            var url = "inventory/warehouse-transfer-out-print-out-pdf?";
            var params = "wtoNo=" + warehouseTransferOut.code;
              
            window.open(url+params,'warehouseTransferOut','width=500,height=500');
        });
    });
    
    function reloadGridWarehouseTransferOut() {
        $("#warehouseTransferOut_grid").trigger("reloadGrid");
    };
    
    function reloadGridWarehouseTransferOutItemDetail() {
        $("#warehouseTransferOutItemDetailList_grid").jqGrid("clearGridData");
        $("#warehouseTransferOutItemDetailList_grid").jqGrid("setCaption", "WAREHOUSE TRANSFER OUT DETAIL");
    };
    
    function formatDate(){
        var firstDate=$("#warehouseTransferOutSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#warehouseTransferOutSearchFirstDate").val(firstDateValue);

        var lastDate=$("#warehouseTransferOutSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#warehouseTransferOutSearchLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlWarehouseTransferOut" action="warehouse-transfer-out-json" />
<b> WAREHOUSE TRANSFER OUT</b>
<hr>
<br class="spacer" />
    <sj:div id="warehouseTransferOutButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnWarehouseTransferOutNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnWarehouseTransferOutUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnWarehouseTransferOutDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnWarehouseTransferOutRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnWarehouseTransferOutPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>  
    </table>
     </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="warehouseTransferOutInputSearch" class="content ui-widget">
        <s:form id="frmWarehouseTransferOutSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="warehouseTransferOutSearchFirstDate" name="warehouseTransferOutSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="warehouseTransferOutSearchLastDate" name="warehouseTransferOutSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="warehouseTransferOutSearchCode" name="warehouseTransferOutSearchCode" placeHolder=" WHM No" size="30"></s:textfield>
                    </td>
                </tr>
                <%--
                <tr>
                    <td align="right"><b>Warehouse</b></td>
                    <td>
                        <s:textfield id="warehouseTransferOutWarehouseSearchCode" name="warehouseTransferOutWarehouseSearchCode" placeHolder=" Code" size="15"></s:textfield>
                        <s:textfield id="warehouseTransferOutWarehouseSearchName" name="warehouseTransferOutWarehouseSearchName" placeHolder=" Name" size="30"></s:textfield>
                    </td>
                </tr>
                --%>
            </table>
            <br />
            <sj:a href="#" id="btnWarehouseTransferOut_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="warehouseTransferOutGrid">
        <sjg:grid
            id="warehouseTransferOut_grid"
            caption="WAREHOUSE TRANSFER OUT"
            dataType="json"
            href="%{remoteurlWarehouseTransferOut}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listWarehouseTransferOutTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="warehouseTransferOut_grid_onSelect"
            width="1100"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="WTF R No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="sourceWarehouseCode" index="sourceWarehouseCode" key="sourceWarehouseCode" title="Source Warehouse Code" width="130" sortable="true" 
            />
            <sjg:gridColumn
                name="sourceWarehouseName" index="sourceWarehouseName" key="sourceWarehouseName" title="Source Warehouse Name" width="150" sortable="true" 
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

    <div id="warehouseTransferOutItemDetailViewGrid">
        <sjg:grid
            id="warehouseTransferOutItemDetailList_grid"
            caption="WAREHOUSE TRANSFER OUT DETAIL"
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
            onSelectRowTopics="warehouseTransferOutItemDetailList_grid_onSelect"
            width="1100"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="code" width="140" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="reasonCode" index="reasonCode" key="reasonCode" title="Reason Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="reasonName" index="reasonName" key="reasonName" title="Reason Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Unit" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="cogsIdr" index="cogsIdr" key="cogsIdr" title="cogsIdr" width="80" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="RackCode" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="RackName" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true" 
            />
        </sjg:grid >
    </div>