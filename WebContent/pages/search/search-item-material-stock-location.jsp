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
    
    var search_serial_no_type= '<%= request.getParameter("type") %>';
    var rowLast = '<%= request.getParameter("rowLast")%>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_warehouse= '<%= request.getParameter("idwarehouse") %>';
    var id_rack= '<%= request.getParameter("idrack") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgItemMaterialStockLocation_okButton").click(function (ev) {
                var search_item_LastRowId = rowLast;

                var ids = jQuery("#dlgSearch_item_stock_location_grid").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var data = $("#dlgSearch_item_stock_location_grid").jqGrid('getRowData', ids[i]);
                    var exist = false;

                    if ($("input:checkbox[id='jqg_dlgSearch_item_stock_location_grid_" + ids[i] + "']").is(":checked")) {
                        var idsOpener = jQuery("#" + id_document + "Input_grid", opener.document).jqGrid('getDataIDs');

                        for (var j = 0; j < idsOpener.length; j++) {

                            var dataExist = $("#" + id_document + "Input_grid", opener.document).jqGrid('getRowData', idsOpener[j]);
                            if (dataExist.adjustmentOutItemDetailSerialNo === data.serialNo) {
                                exist = true;
                            }
                        }
                        
                        if (!exist) {
                            search_item_LastRowId++;
                           
                            var defRow = {};
                            switch (id_document) {
                                case "adjustmentOutSerialNoDetail":
                                    
                                    defRow = {
                                        adjustmentOutSerialNoDetailItemDelete               : "delete",
                                        adjustmentOutSerialNoDetailCode                     : data.code,
                                        adjustmentOutSerialNoDetailTransactionCode          : data.transactionCode,
                                        adjustmentOutSerialNoDetailItemMaterialCode         : data.itemMaterialCode,
                                        adjustmentOutSerialNoDetailItemMaterialName         : data.itemMaterialName,
                                        adjustmentOutSerialNoDetailSerialNo                 : data.serialNo,
                                        adjustmentOutSerialNoDetailCapacity                 : data.capacity,
                                        adjustmentOutSerialNoDetailUsedCapacity             : data.usedCapacity,
                                        adjustmentOutSerialNoDetailBalanceCapacity          : data.balanceCapacity,
                                        adjustmentOutSerialNoDetailRackCode                 : data.rackCode,
                                        adjustmentOutSerialNoDetailRackName                 : data.rackName
                                    };
                                    window.opener.addRowAdjustmentOutSerialNoDetailSerialNoDataMultiSelected(search_item_LastRowId, defRow);

                                    break;
                            }
                        }
                    }

                }
                
                window.close();
            });


        $("#dlgItemMaterialStockLocation_cancelButton").click(function(ev) { 
            data_search_item_stock_location = null;
            window.close();
        });
    
    
        $("#btn_dlg_ItemMaterialStockLocationSearch").click(function(ev) {
            $("#dlgSearch_item_stock_location_grid").jqGrid("setGridParam",{url:"master/item-material-stock-location-search-data?" + $("#frmItemMaterialStockLocationSearch").serialize(), page:1});
            $("#dlgSearch_item_stock_location_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#itemMaterialStockLocation\\.warehouseCode').val(id_warehouse);
        $('#itemMaterialStockLocation\\.rackCode').val(id_rack);
     });
    
</script>
    
<body>
<s:url id="remoteurlItemMaterialStockLocationSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmItemMaterialStockLocationSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Serial No</td>
                    <td><s:textfield id="itemMaterialStockLocation.serialNo" name="itemMaterialStockLocation.serialNo" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Item</td>
                    <td>
                        <s:textfield id="itemMaterialStockLocation.itemMaterialCode" name="itemMaterialStockLocation.itemMaterialCode" label="Code "></s:textfield>
                        <s:textfield id="itemMaterialStockLocation.itemMaterialName" name="itemMaterialStockLocation.itemMaterialName" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Warehouse</td>
                    <td>
                    <s:textfield id="itemMaterialStockLocation.warehouseCode" name="itemMaterialStockLocation.warehouseCode" label="Code " readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Rack</td>
                    <td>
                        <s:textfield id="itemMaterialStockLocation.rackCode" name="itemMaterialStockLocation.rackCode" label="Code " readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ItemMaterialStockLocationSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="serial_noSearchActiveStatus" name="serial_noSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_item_stock_location_grid"
                dataType="json"
                href="%{remoteurlItemMaterialStockLocationSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listItemMaterialStockLocation"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                multiselect="true"
                width="$('#tabmnuserial_no').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="code" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="transactionCode" index="transactionCode" key="transactionCode" title="transactionCode" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="serialNo" index="serialNo" key="serialNo" title="SerialNo" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="ItemCode" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="ItemName" width="300" sortable="true"
                />
                <sjg:gridColumn
                    name="rackCode" index="rackCode" key="rackCode" title="rackCode" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="rackName" index="rackName" key="rackName" title="rackName" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="capacity" index="capacity" key="capacity" title="Capacity" width="80" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="usedCapacity" index="usedCapacity" key="usedCapacity" title="UsedCapacity" width="80" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="balanceCapacity" index="balanceCapacity" key="balanceCapacity" title="BalanceCapacity" width="80" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgItemMaterialStockLocation_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgItemMaterialStockLocation_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>