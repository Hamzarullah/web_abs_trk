
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
/*    #pickingListSalesOrderTradeItemDetailInput_grid_pager_center,#pickingListSalesOrderBonusItemDetailInput_grid_pager_center,#pickingListSalesOrderTradeItemQuantityDetailInput_grid_pager_center,#pickingListSalesOrderTradeItemQuantityDetailInput_grid_pager_center,#pickingListSalesOrderBonusItemQuantityDetailInput_grid_pager_center{
        display: none;
    } */
</style>

<script type="text/javascript">
    
    var pickingListSalesOrderTradeItemDetailLastSel = -1, 
        pickingListSalesOrderTradeItemDetailLastRowId = 0;
    var pickingListSalesOrderTradeItemQuantityDetailLastSel = -1, 
        pickingListSalesOrderTradeItemQuantityDetailLastRowId = 0;
    var 
        txtPickingListSalesOrderCode = $("#pickingListSalesOrder\\.code"),
        dtpPickingListSalesOrderTransactionDate = $("#pickingListSalesOrder\\.transactionDate"),
        txtPickingListSalesOrderBranchCode = $("#pickingListSalesOrder\\.branch\\.code"),
        txtPickingListSalesOrderBranchName = $("#pickingListSalesOrder\\.branch\\.name"),
        txtPickingListSalesOrderSalesOrderCode = $("#pickingListSalesOrder\\.salesOrder\\.code"),
        dtpPickingListSalesOrderSalesOrderDeliveryDate = $("#pickingListSalesOrder\\.salesOrder\\.deliveryDate"),
        txtPickingListSalesOrderSalesOrderCurrencyCode = $("#pickingListSalesOrder\\.currency\\.code"),
        txtPickingListSalesOrderSalesOrderCurrencyName = $("#pickingListSalesOrder\\.currency\\.name"),
        txtPickingListSalesOrderSalesOrderCustomerCode = $("#pickingListSalesOrder\\.salesOrder\\.customer\\.code"),
        txtPickingListSalesOrderSalesOrderCustomerName = $("#pickingListSalesOrder\\.salesOrder\\.customer\\.name"),
        txtPickingListSalesOrderCustomerAddressCode = $("#pickingListSalesOrder\\.customerAddress\\.code"),
        txtPickingListSalesOrderCustomerAddressAddress = $("#pickingListSalesOrder\\.salesOrder\\.customer\\.address"),
        txtPickingListSalesOrderCustomerAddressCityCode = $("#pickingListSalesOrder\\.salesOrder\\.customer\\.cityCode"),
        txtPickingListSalesOrderCustomerAddressCityName = $("#pickingListSalesOrder\\.city\\.name"),
        txtPickingListSalesOrderCustomerAddressContactPerson = $("#pickingListSalesOrder\\.salesOrder\\.customer\\.defaultContactPersonCode"),
        txtPickingListSalesOrderSalesPersonCode = $("#pickingListSalesOrder\\.salesOrder\\.salesPerson\\.code"),
        txtPickingListSalesOrderSalesPersonName = $("#pickingListSalesOrder\\.salesOrder\\.salesPerson\\.name"),
        txtPickingListSalesOrderWarehouseCode = $("#pickingListSalesOrder\\.warehouse\\.code"),
        txtPickingListSalesOrderWarehouseName = $("#pickingListSalesOrder\\.warehouse\\.name"),
        txtPickingListSalesOrderRefNo = $("#pickingListSalesOrder\\.refNo"),
        txtPickingListSalesOrderRemark = $("#pickingListSalesOrder\\.remark");
    
    $(document).ready(function() {
        hoverButton();
        
        flagIsConfirmPickingListSO=false;
        
        $("#btnUnConfirmPickingListSalesOrder").css("display", "none");
        $("#btnConfirmPickingListSalesOrder").css("display", "block");
        $('#pickingListSalesOrderTradeItemQuantityDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $.subscribe("pickingListSalesOrderTradeItemDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==pickingListSalesOrderTradeItemDetailLastSel) {
                $('#pickingListSalesOrderTradeItemDetailInput_grid').jqGrid("saveRow",pickingListSalesOrderTradeItemDetailLastSel); 
                $('#pickingListSalesOrderTradeItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                pickingListSalesOrderTradeItemDetailLastSel=selectedRowID;
            }
            else{
                $('#pickingListSalesOrderTradeItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnPickingListSalesOrderSave').click(function(ev) {
            
            var listPickingListSalesOrderTradeItemDetail = new Array();
            var listPickingListSalesOrderTradeItemQuantityDetail = new Array();
            
           
            var ids = jQuery("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid('getDataIDs');
            var idu = jQuery("#pickingListSalesOrderTradeItemQuantityDetailInput_grid").jqGrid('getDataIDs');
            
            if(ids.length===0){
                alertMessage("Data Detail So Item Detail Can't Empty!");
                return;
            }     
            
            if(idu.length===0){
                alertMessage("Data Detail Dln Can't Empty!");
                return;
            }    
            
            for(var j=0; j < ids.length; j++){
                var datas = $("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid('getRowData',ids[j]);
                
                var pickingListSalesOrderTradeItemDetail = {
                    item        : { code : datas.pickingListSalesOrderTradeItemDetailItemCode },
                    quantity    : datas.pickingListSalesOrderTradeItemDetailQuantity
                };
                listPickingListSalesOrderTradeItemDetail[j] = pickingListSalesOrderTradeItemDetail;
            }
                   
            for(var k=0; k < idu.length; k++){
                var data = $("#pickingListSalesOrderTradeItemQuantityDetailInput_grid").jqGrid('getRowData',idu[k]);
                
                var pickingListSalesOrderTradeItemQuantityDetail = {
                    item        : { code : data.pickingListSalesOrderTradeItemQuantityDetailItemCode },
                    rack        : { code : data.pickingListSalesOrderTradeItemQuantityDetailRackCode },
                    itemAlias   : data.pickingListSalesOrderTradeItemQuantityDetailItemAlias,
                    quantity    : data.pickingListSalesOrderTradeItemQuantityDetailQuantity
                };
                listPickingListSalesOrderTradeItemQuantityDetail[k] = pickingListSalesOrderTradeItemQuantityDetail;
            }
            
            formatDatePickingListSO();
                        
            var url="inventory/picking-list-sales-order-save";
            var params = $("#frmPickingListSalesOrderInput").serialize();
                params += "&listPickingListSalesOrderTradeItemDetailJSON=" + $.toJSON(listPickingListSalesOrderTradeItemDetail);
                params += "&listPickingListSalesOrderTradeItemQuantityDetailJSON=" + $.toJSON(listPickingListSalesOrderTradeItemQuantityDetail);

            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDatePickingListSO();
                    return;
                }
                
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');
                dynamicDialog.dialog({
                    title           : "Confirmation:",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 400,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "Yes",
                                        click : function() {
                                            $(this).dialog("close");
                                            var url = "inventory/picking-list-sales-order-input";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuPICKING_LIST_SALES_ORDER");
                                        }
                                    },
                                    {
                                        text : "No",
                                        click : function() {
                                            $(this).dialog("close");
                                            var url = "inventory/picking-list-sales-order";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuPICKING_LIST_SALES_ORDER");

                                        }
                                    }]
                });
            });
            ev.preventDefault();
        });

        $('#btnPickingListSalesOrderCancel').click(function(ev) {
            var url = "inventory/picking-list-sales-order";
            var params = "";
            pageLoad(url, params, "#tabmnuPICKING_LIST_SALES_ORDER"); 
        });           
        
        $("#btnConfirmPickingListSalesOrder").click(function(ev) {
            if(!$("#frmPickingListSalesOrderInput").valid()) {
                return;
            }
            
            var date1 = dtpPickingListSalesOrderTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#pickingListSalesOrderTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#pickingListSalesOrderUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#pickingListSalesOrderTransactionDate").val(),dtpPickingListSalesOrderTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpPickingListSalesOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#pickingListSalesOrderUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#pickingListSalesOrderTransactionDate").val(),dtpPickingListSalesOrderTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpPickingListSalesOrderTransactionDate);
                }
                return;
            }
            
            if(pickingListSalesOrderTradeItemDetailLastSel !== -1) {
                $('#pickingListSalesOrderTradeItemDetailInput_grid').jqGrid("saveRow",pickingListSalesOrderTradeItemDetailLastSel);
            }
            
            if(txtPickingListSalesOrderCustomerAddressCode.val()===""){
                alertMessage("Please Select One Address!");
                return;
            }
            
            var listInventoryActualStockTemp=new Array();
            var warehouseCode=txtPickingListSalesOrderWarehouseCode.val();    
            var x=-1;    
            var ids = jQuery("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid('getDataIDs');
            for(var i=0;i < ids.length;i++){                
                var data = $("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                    if(parseFloat(data.pickingListSalesOrderTradeItemDetailQuantity)>parseFloat(data.pickingListSalesOrderTradeItemDetailBalanceQuantity)){
                        alertMessage("Item : " + data.pickingListSalesOrderTradeItemDetailItemCode + "</br>PLT-SO Quantity is greater than Balance Quantity!");
                        return;
                    }
                    if(parseFloat(data.pickingListSalesOrderTradeItemDetailQuantity)<=parseFloat(data.pickingListSalesOrderTradeItemDetailBalanceQuantity)){
                        x++;
                        var inventoryActualStockTemp = {
                            warehouseCode   : warehouseCode,
                            itemCode        : data.pickingListSalesOrderTradeItemDetailItemCode,
                            bookedStock     : data.pickingListSalesOrderTradeItemDetailQuantity
                        };
                        listInventoryActualStockTemp[x]=inventoryActualStockTemp;
                    }
            }
            
            var url = "master/item-current-stock-picking-list-so-item-data";
            var params= "listInventoryActualStockTempJSON=" + $.toJSON(listInventoryActualStockTemp);

            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    flagIsConfirmPickingListSO=false;
                    alertMessage("Item Stock, pada Warehouse "+ warehouseCode +"= tidak ada !!!");
                    return;
                }else {
                    pickingListSalesOrderTradeItemQuantityDetailLastRowId = 0;
                    for (var i=0; i<data.listIvtActualStock.length; i++) {

                        if(data.listIvtActualStock[i].quantity>0){
                            
                            pickingListSalesOrderTradeItemQuantityDetailLastRowId++;

                            $("#pickingListSalesOrderTradeItemQuantityDetailInput_grid").jqGrid("addRowData", pickingListSalesOrderTradeItemQuantityDetailLastRowId, data.listIvtActualStock[i]);
                            $("#pickingListSalesOrderTradeItemQuantityDetailInput_grid").jqGrid('setRowData',pickingListSalesOrderTradeItemQuantityDetailLastRowId,{
                                pickingListSalesOrderTradeItemQuantityDetailItemCode               : data.listIvtActualStock[i].itemCode,
                                pickingListSalesOrderTradeItemQuantityDetailItemName               : data.listIvtActualStock[i].itemName,
                                pickingListSalesOrderTradeItemQuantityDetailItemAlias              : data.listIvtActualStock[i].itemAlias,
                                pickingListSalesOrderTradeItemQuantityDetailQuantity               : data.listIvtActualStock[i].quantity,
                                pickingListSalesOrderTradeItemQuantityDetailItemUnitOfMeasureCode  : data.listIvtActualStock[i].unitOfMeasureCode,
                                pickingListSalesOrderTradeItemQuantityDetailRackCode               : data.listIvtActualStock[i].rackCode,
                                pickingListSalesOrderTradeItemQuantityDetailRackName               : data.listIvtActualStock[i].rackName
                            });
                        }

                    }
                }
            });
                flagIsConfirmPickingListSO=true;
                $("#btnUnConfirmPickingListSalesOrder").css("display", "block");
                $("#btnConfirmPickingListSalesOrder").css("display", "none");
                $('#pickingListSalesOrderHeaderDivInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#pickingListSalesOrderTradeItemDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#pickingListSalesOrderTradeItemQuantityDetailInputGrid').unblock();
        });
            
        $("#btnUnConfirmPickingListSalesOrder").click(function(ev) {
            
            $("#pickingListSalesOrderTradeItemQuantityDetailInput_grid").jqGrid('clearGridData');
           
            flagIsConfirmPickingListSO=false;
            $('#pickingListSalesOrderHeaderDivInput').unblock();
            $('#pickingListSalesOrderTradeItemDetailInputGrid').unblock();
            $('#pickingListSalesOrderTradeItemQuantityDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#btnUnConfirmPickingListSalesOrder").css("display", "none");
            $("#btnConfirmPickingListSalesOrder").css("display", "block");
        });
        
        $('#pickingListSalesOrder_btnSalesOrder').click(function(ev) {
            window.open("./pages/search/search-sales-order-for-picking-list.jsp?iddoc=pickingListSalesOrder&idsubdoc=salesOrder&firstDate=" + $("#pickingListSalesOrderTransactionDateFirstSession").val() + "&lastDate=" + $("#pickingListSalesOrderTransactionDateLastSession").val(), "Search", "Scrollbars=1,width=900, height=500");
        });
        
        $('#pickingListSalesOrder_btnWarehouse').click(function(ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=pickingListSalesOrder&idsubdoc=warehouse","Search", "scrollbars=1,width=600, height=500");
        });
    }); // EOF Ready
    
    function formatDatePickingListSO(){
        var transactionDate=formatDate(dtpPickingListSalesOrderTransactionDate.val(),false);
        var transactionDateTimePart=" "+$("#pickingListSalesOrderTransactionDate").val().split(' ')[1];
        
        dtpPickingListSalesOrderTransactionDate.val(transactionDate);
        $("#pickingListSalesOrderTemp\\.transactionDateTemp").val(transactionDate + transactionDateTimePart);
                
    }
    
    function loadDataPickingListSalesOrderDetail(salesOrderCode) {
        $("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid('clearGridData');
        var url = "sales/sales-order-detail-picking-list-data";
        var params = "salesOrder.code=" + salesOrderCode;
        
        $.getJSON(url, params, function(data) {
            pickingListSalesOrderTradeItemDetailLastRowId = 0;
            
            for (var i=0; i<data.listSalesOrderDetailTemp.length; i++) {
                pickingListSalesOrderTradeItemDetailLastRowId++;
                                
                $("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid("addRowData", pickingListSalesOrderTradeItemDetailLastRowId, data.listSalesOrderDetailTemp[i]);
                $("#pickingListSalesOrderTradeItemDetailInput_grid").jqGrid('setRowData',pickingListSalesOrderTradeItemDetailLastRowId,{
                    pickingListSalesOrderTradeItemDetailCustomerAddressCode     : data.listSalesOrderDetailTemp[i].customerAddressCode,
                    pickingListSalesOrderTradeItemDetailCustomerAddressAddress  : data.listSalesOrderDetailTemp[i].customerAddressAddress,
                    pickingListSalesOrderTradeItemDetailCustomerAddressCityName : data.listSalesOrderDetailTemp[i].cityName,
                    pickingListSalesOrderTradeItemDetailItemCode                : data.listSalesOrderDetailTemp[i].itemCode,
                    pickingListSalesOrderTradeItemDetailItemName                : data.listSalesOrderDetailTemp[i].itemName,
                    pickingListSalesOrderTradeItemDetailItemAlias               : data.listSalesOrderDetailTemp[i].itemAlias,
                    pickingListSalesOrderTradeItemDetailSalesOrderQuantity      : data.listSalesOrderDetailTemp[i].quantity,
                    pickingListSalesOrderTradeItemDetailProcessedQuantity       : 0,
                    pickingListSalesOrderTradeItemDetailBalanceQuantity         : data.listSalesOrderDetailTemp[i].quantity - 0,
                    pickingListSalesOrderTradeItemDetailItemUnitOfMeasureCode   : data.listSalesOrderDetailTemp[i].unitOfMeasureCode
                });
            }
        });
    }

</script>
<s:url id="remotedetailurlPickingListSalesOrderTradeItemDetailInput" action="" />
<b>PICKING LIST - SALES ORDER</b>
<hr>
<br class="spacer" />
<div id="pickingListSalesOrderInput" class="content ui-widget">
    <s:form id="frmPickingListSalesOrderInput">
        <div class="pickingListSalesOrderHeaderDivInput" id="pickingListSalesOrderHeaderDivInput">
                <table cellpadding="2" cellspacing="2" id="pickingListSalesOrderHeaderInput" width="100%">
                    <tr>
                        <td align="right" style="width:120px"><B>PLT-SO No *</B></td>
                        <td>
                            <s:textfield id="pickingListSalesOrder.code" name="pickingListSalesOrder.code" key="pickingListSalesOrder.code" label="SO No *" readonly="true" size="20"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Transaction Date *</B></td>
                        <td>
                            <sj:datepicker id="pickingListSalesOrder.transactionDate" name="pickingListSalesOrder.transactionDate" size="20" displayFormat="dd/mm/yy"  title="*" required="true" cssClass="required" showOn="focus"  onchange="pickingListSalesOrderTransactionDateOnChange()"></sj:datepicker>
                            <sj:datepicker id="pickingListSalesOrderTransactionDate" name="pickingListSalesOrderTransactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title="*" showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:15%;Display:none"></sj:datepicker>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>SO No *</B></td>
                        <td>
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="pickingListSalesOrder.salesOrder.code" name="pickingListSalesOrder.salesOrder.code" cssClass="required" required="true" title="*" size="20" readonly="true"></s:textfield>
                                <sj:a id="pickingListSalesOrder_btnSalesOrder" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-purchase-order"/></sj:a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Branch</td>
                        <td>
                            <s:textfield id="pickingListSalesOrder.currency.code" name="pickingListSalesOrder.currency.code" readonly="true" cssStyle="display:none"></s:textfield>
                            <s:textfield id="pickingListSalesOrder.currency.name" name="pickingListSalesOrder.currency.name" readonly="true" cssStyle="display:none"></s:textfield>
                            <s:textfield id="pickingListSalesOrder.branch.code" name="pickingListSalesOrder.branch.code" readonly="true" title="*" size="15"></s:textfield>
                            <s:textfield id="pickingListSalesOrder.branch.name" name="pickingListSalesOrder.branch.name" readonly="true" cssStyle="width:20%"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Delivery Date</td>
                        <td>
                        <sj:datepicker id="pickingListSalesOrder.salesOrder.deliveryDate" name="pickingListSalesOrder.salesOrder.deliveryDate" title="*" displayFormat="dd/mm/yy" showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Sales Person</td>
                        <td colspan="2">
                            <s:textfield id="pickingListSalesOrder.salesOrder.salesPerson.code" name="pickingListSalesOrder.salesOrder.salesPerson.code" readonly="true"  title="*" size="15"></s:textfield>
                            <s:textfield id="pickingListSalesOrder.salesOrder.salesPerson.name" name="pickingListSalesOrder.salesOrder.salesPerson.name" readonly="true" cssStyle="width:20%"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Customer</td>
                        <td colspan="2">
                            <s:textfield id="pickingListSalesOrder.salesOrder.customer.code" name="pickingListSalesOrder.salesOrder.customer.code" readonly="true"  title="*" size="15"></s:textfield>
                            <s:textfield id="pickingListSalesOrder.salesOrder.customer.name" name="pickingListSalesOrder.salesOrder.customer.name" readonly="true" cssStyle="width:20%"></s:textfield>
                        </td>
                    </tr>          
                    <tr>
                        <td align="right" width="100px">Ship To </td>
                        <td colspan="2">
                            <s:textfield id="pickingListSalesOrder.customerAddress.code" name="pickingListSalesOrder.customerAddress.code"  title="*" size="15" readonly="true"></s:textfield>                                
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Address</td>
                        <td>
                            <s:textarea id="pickingListSalesOrder.salesOrder.customer.address" name="pickingListSalesOrder.salesOrder.customer.address" cols="45" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">City</td>
                        <td>
                            <s:textfield id="pickingListSalesOrder.salesOrder.customer.cityCode" name="pickingListSalesOrder.salesOrder.customer.cityCode" readonly="true"  title="*" size="15"></s:textfield>
                            <s:textfield id="pickingListSalesOrder.salesOrder.city.name" name="pickingListSalesOrder.salesOrder.city.name" readonly="true" cssStyle="width:20%"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="pickingListSalesOrder.salesOrder.customer.defaultContactPersonCode" name="pickingListSalesOrder.salesOrder.customer.defaultContactPersonCode" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right"><B>Warehouse *</B></td>
                        <td colspan="2">
                            <script type = "text/javascript">

                            txtPickingListSalesOrderWarehouseCode.change(function(ev) {

                                if(txtPickingListSalesOrderWarehouseCode.val()===""){
                                    txtPickingListSalesOrderWarehouseName.val("");
                                    return;
                                }
                                var url = "master/warehouse-get";
                                var params = "warehouse.code=" + txtPickingListSalesOrderWarehouseCode.val();
                                    params += "&warehouse.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.warehouseTemp){
                                        txtPickingListSalesOrderWarehouseCode.val(data.warehouseTemp.code);
                                        txtPickingListSalesOrderWarehouseName.val(data.warehouseTemp.name);
                                    }
                                    else{
                                        alertMessage("Warehouse Not Found!",txtPickingListSalesOrderWarehouseCode);
                                        txtPickingListSalesOrderWarehouseCode.val("");
                                        txtPickingListSalesOrderWarehouseName.val("");
                                    }
                                });
                            });
                            </script>
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="pickingListSalesOrder.warehouse.code" name="pickingListSalesOrder.warehouse.code" cssClass="required" required="true" title="*" size="15"></s:textfield>
                                <sj:a id="pickingListSalesOrder_btnWarehouse" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="pickingListSalesOrder.warehouse.name" name="pickingListSalesOrder.warehouse.name" readonly="true" cssStyle="width:20%"></s:textfield>
                        </td>
                    </tr>      
                    <tr>
                        <td align="right">Ref No</td>
                        <td><s:textfield id="pickingListSalesOrder.refNo" name="pickingListSalesOrder.refNo" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td>
                            <s:textarea id="pickingListSalesOrder.remark" name="pickingListSalesOrder.remark" cols="45" rows="3"></s:textarea>
                        </td>
                    </tr> 
                    <tr hidden="true">
                        <td/>
                        <td>
                            <sj:datepicker id="pickingListSalesOrderTransactionDateFirstSession" name="pickingListSalesOrderTransactionDateFirstSession" size="15" showOn="focus"></sj:datepicker>
                            <sj:datepicker id="pickingListSalesOrderTransactionDateLastSession" name="pickingListSalesOrderTransactionDateLastSession" size="15" showOn="focus"></sj:datepicker>
                            <s:textfield id="pickingListSalesOrderUpdateMode" name="pickingListSalesOrderUpdateMode"></s:textfield>
                            <s:textfield id="pickingListSalesOrderTemp.transactionDateTemp" name="pickingListSalesOrderTemp.transactionDateTemp"></s:textfield>
                        </td>
                    </tr>
                </table>
        </div>
        <div id="pickingListSalesOrderTradeItemDetailInputGrid">
            <sjg:grid
                id="pickingListSalesOrderTradeItemDetailInput_grid"
                caption="ITEM DETAIL"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="true"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listPickingListSalesOrderDetailTemp"
                viewrecords="true"
                rownumbers="true"
                rowNum="10000"
                shrinkToFit="false"
                width="$('#tabmnuPICKING_LIST_SALES_ORDER').width()"
                editinline="true"
                editurl="%{remotedetailurlPickingListSalesOrderTradeItemDetailInput}"
                onSelectRowTopics="pickingListSalesOrderTradeItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetail" index="pickingListSalesOrderTradeItemDetail" key="pickingListSalesOrderTradeItemDetail" title=" " hidden="true"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailCustomerAddressCode" index = "pickingListSalesOrderTradeItemDetailCustomerAddressCode" key = "pickingListSalesOrderTradeItemDetailCustomerAddressCode" title = "Address Code" width = "100"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailCustomerAddressAddress" index = "pickingListSalesOrderTradeItemDetailCustomerAddressAddress" key = "pickingListSalesOrderTradeItemDetailCustomerAddressAddress" title = "Address" width = "200"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailCustomerAddressCityName" index = "pickingListSalesOrderTradeItemDetailCustomerAddressCityName" key = "pickingListSalesOrderTradeItemDetailCustomerAddressCityName" title = "City" width = "125"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailItemCode" index = "pickingListSalesOrderTradeItemDetailItemCode" key = "pickingListSalesOrderTradeItemDetailItemCode" title = "Item" width = "100"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailItemName" index = "pickingListSalesOrderTradeItemDetailItemName" key = "pickingListSalesOrderTradeItemDetailItemName" title = "Item" width = "200"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailItemAlias" index = "pickingListSalesOrderTradeItemDetailItemAlias" key = "pickingListSalesOrderTradeItemDetailItemAlias" title = "Item Alias" width = "200"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailSalesOrderQuantity" index="pickingListSalesOrderTradeItemDetailSalesOrderQuantity" key="pickingListSalesOrderTradeItemDetailSalesOrderQuantity" 
                    title="SO Quantity" width="75" align="right"
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailProcessedQuantity" index="pickingListSalesOrderTradeItemDetailProcessedQuantity" key="pickingListSalesOrderTradeItemDetailProcessedQuantity"
                    title="Processed Quantity" width="75" align="right"
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailBalanceQuantity" index="pickingListSalesOrderTradeItemDetailBalanceQuantity" key="pickingListSalesOrderTradeItemDetailBalanceQuantity" 
                    title="Balance Quantity" width="75" align="right"
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailQuantity" index="pickingListSalesOrderTradeItemDetailQuantity" key="pickingListSalesOrderTradeItemDetailQuantity" 
                    title="PLT-SO Quantity" width="75" align="right" edittype="text" editable="true"
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemDetailItemUnitOfMeasureCode" index = "pickingListSalesOrderTradeItemDetailItemUnitOfMeasureCode" key = "pickingListSalesOrderTradeItemDetailItemUnitOfMeasureCode" 
                    title = "UOM" width = "50"
                />
            </sjg:grid > 
        </div>
        <div>
            <table>
                <tr>
                    <td width="50%">
                        <sj:a href="#" id="btnConfirmPickingListSalesOrder" button="true" style="width: 90px">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmPickingListSalesOrder" button="true" style="width: 100px">UnConfirm</sj:a>
                    </td>
                </tr>
            </table>
        </div>
        <div id="pickingListSalesOrderTradeItemQuantityDetailInputGrid">
            <sjg:grid
                id="pickingListSalesOrderTradeItemQuantityDetailInput_grid"
                caption="ITEM DETAIL"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="true"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listPickingListSalesOrderTradeItemQuantityDetailTemp"
                viewrecords="true"
                rownumbers="true"
                rowNum="10000"
                shrinkToFit="false"
                width="$('#tabmnuPICKING_LIST_SALES_ORDER').width()"
            >
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemQuantityDetailItemCode" index = "pickingListSalesOrderTradeItemQuantityDetailItemCode" key = "pickingListSalesOrderTradeItemQuantityDetailItemCode" title = "Item Code" width = "100"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemQuantityDetailItemName" index = "pickingListSalesOrderTradeItemQuantityDetailItemName" key = "pickingListSalesOrderTradeItemQuantityDetailItemName" title = "Item Name" width = "200"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemQuantityDetailItemAlias" index = "pickingListSalesOrderTradeItemQuantityDetailItemAlias" key = "pickingListSalesOrderTradeItemQuantityDetailItemAlias" title = "Item Alias" width = "200"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemQuantityDetailQuantity" index="pickingListSalesOrderTradeItemQuantityDetailQuantity" key="pickingListSalesOrderTradeItemQuantityDetailQuantity" 
                    title="Quantity" width="75" sortable="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemQuantityDetailItemUnitOfMeasureCode" index = "pickingListSalesOrderTradeItemQuantityDetailItemUnitOfMeasureCode" key = "pickingListSalesOrderTradeItemQuantityDetailItemUnitOfMeasureCode" 
                    title = "UOM" width = "50"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemQuantityDetailRackCode" index = "pickingListSalesOrderTradeItemQuantityDetailRackCode" key = "pickingListSalesOrderTradeItemQuantityDetailRackCode" 
                    title = "Rack Code" width = "100"
                />
                <sjg:gridColumn
                    name = "pickingListSalesOrderTradeItemQuantityDetailRackName" index = "pickingListSalesOrderTradeItemQuantityDetailRackName" key = "pickingListSalesOrderTradeItemQuantityDetailRackName" 
                    title = "Rack Name" width = "200"
                />
            </sjg:grid >
        </div>
        <div>
            <table width="100%">
                <tr>
                    <td>
                        <sj:a href="#" id="btnPickingListSalesOrderSave" button="true" style="width: 60px">Save</sj:a>
                        <sj:a href="#" id="btnPickingListSalesOrderCancel" button="true" style="width: 60px">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </div>
    </s:form>
</div>
