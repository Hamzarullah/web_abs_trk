<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #warehouseTransferInItemDetailSourceInput_grid_pager_center,#warehouseTransferInItemDetailDestinationInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
    #errmsgAddRow{
        color: red;
    }
</style>

<script type="text/javascript">
    
    var warehouseTransferInItemDetail_lastSel = -1, warehouseTransferInItemDetail_lastRowId=0;
    var warehouseTransferInItemDetailSource_lastSel = -1, warehouseTransferInItemDetailSource_lastRowId=0;
    var warehouseTransferInItemDetailDestination_lastSel = -1, warehouseTransferInItemDetailDestination_lastRowId=0;
    
    var txtWarehouseTransferInCode = $("#warehouseTransferIn\\.code"),
        dtpWarehouseTransferInTransactionDate = $("#warehouseTransferIn\\.transactionDate"),
        txtWarehouseTransferInWTOCode = $("#warehouseTransferIn\\.warehouseTransferOut\\.code"),
        txtWarehouseTransferInWHMRequestCode = $("#warehouseTransferIn\\.warehouseTransferRequest\\.code"),
        txtWarehouseTransferInBranchCode = $("#warehouseTransferIn\\.warehouseTransferRequest\\.branch\\.code"),
        txtWarehouseTransferInBranchName = $("#warehouseTransferIn\\.warehouseTransferRequest\\.branch\\.name"),
        dtpWarehouseTransferInWHMRequestTransactionDate = $("#warehouseTransferIn\\.warehouseTransferRequest\\.transactionDate"),
        txtWarehouseTransferInSourceWarehouseCode = $("#warehouseTransferIn\\.sourceWarehouse\\.code"),
        txtWarehouseTransferInSourceWarehouseName = $("#warehouseTransferIn\\.sourceWarehouse\\.name"),
        txtWarehouseTransferInDestinationWarehouseCode = $("#warehouseTransferIn\\.destinationWarehouse\\.code"),
        txtWarehouseTransferInDestinationWarehouseName = $("#warehouseTransferIn\\.destinationWarehouse\\.name"),
        txtWarehouseTransferInRefNo = $("#warehouseTransferIn\\.refNo"),
        txtWarehouseTransferInRemark = $("#warehouseTransferIn\\.remark"),
        txtWarehouseTransferInCreatedBy = $("#warehouseTransferIn\\.createdBy"),
        dtpWarehouseTransferInCreatedDate = $("#warehouseTransferIn\\.createdDate");
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function formatDateRemoveT(date, useTime) {
        var dateValues = date.split('T');
        var dateValuesTemp = dateValues[0].split('-');
        var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[2] + "/" + dateValuesTemp[0];
        var dateValuesTemps;

        if (useTime) {
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    function formatDateGlobal(date, useTime) {
        var dateValuesTemps;

        if (useTime) {
            var dateValues = date.split(' ');
            var dateValuesTemp = dateValues[0].split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            var dateValuesTemp = date.split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    $(document).ready(function(){       
        
        $("#btnUnConfirmWarehouseTransferOutDetail").css("display", "none");        
        $("#warehouseTransferInItemDetailSourceInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#warehouseTransferInItemDetailDestinationInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $.subscribe("warehouseTransferInItemDetailSourceInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==warehouseTransferInItemDetailSource_lastSel) {
                $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('saveRow',warehouseTransferInItemDetailSource_lastSel); 
                $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('editRow',selectedRowID,true); 
                warehouseTransferInItemDetailSource_lastSel=selectedRowID;
            }
            else{
                $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        $.subscribe("warehouseTransferInItemDetailDestinationInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==warehouseTransferInItemDetailDestination_lastSel) {
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('saveRow',warehouseTransferInItemDetailDestination_lastSel); 
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('editRow',selectedRowID,true); 
                warehouseTransferInItemDetailDestination_lastSel=selectedRowID;
            }
            else{
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        $("#btnWarehouseTransferInSave").click(function(ev) {
 
            
            if(warehouseTransferInItemDetailDestination_lastSel !== -1) {
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('saveRow',warehouseTransferInItemDetailDestination_lastSel); 
            }
            
            var listWarehouseTransferInItemDetail = new Array(); 
            
            var idsSource = jQuery("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('getDataIDs'); 
            var idsDestination = jQuery("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < idsDestination.length;i++){ 
                
            var data = $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('getRowData',idsDestination[i]); 
            var dataSource = $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('getRowData',idsSource[i]);
            var qtySource = parseFloat(dataSource.warehouseTransferInItemDetailSourceQuantity);
            var qtyDestinastion = parseFloat(data.warehouseTransferInItemDetailDestinationQuantity); 
        //    alert("qtySource" + qtySource);
                //    alert("qtyDestinastion" + qtyDestinastion);
            if(qtyDestinastion>qtySource){
                    alertMessage("Quantity Destination Can't Be More Than Quantity Source!");
                    return false;
            }
            
            if(qtyDestinastion<qtySource){
                    alertMessage("Quantity Destination Can't Be Less Than Quantity Source!");
                    return;
            }
               
            var warehouseTransferInItemDetail = {
                itemMaterial            : { code            : data.warehouseTransferInItemDetailDestinationItemMaterialCode,
                                            inventoryType   : data.warehouseTransferInItemDetailDestinationItemMaterialInventoryType
                                          },
                quantity                : data.warehouseTransferInItemDetailDestinationQuantity,
                cogsIdr                 : data.warehouseTransferInItemDetailDestinationCOGSIDR,
                totalAmount             : data.warehouseTransferInItemDetailDestinationTotalAmount,
                rack                    : { code : data.warehouseTransferInItemDetailDestinationRackCode },
                remark                  : data.warehouseTransferInItemDetailDestinationRemark

            };
                listWarehouseTransferInItemDetail[i] = warehouseTransferInItemDetail;
            }
            
            formatDateWHTIn();
            
            var url = "inventory/warehouse-transfer-in-save";
            var params = $("#frmWarehouseTransferInInput").serialize();
                params+= "&listWarehouseTransferInItemDetailJSON=" + $.toJSON(listWarehouseTransferInItemDetail);
                
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateWHTIn();
                    return;
                }

                alertMessage(data.message);
                
                params = "";
                var url = "inventory/warehouse-transfer-in";
                pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_IN");

            });
        });
        
        $("#btnWarehouseTransferInCancel").click(function(ev){
            var params = "";
            var url = "inventory/warehouse-transfer-in";
            pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_IN");
        });
                
        $('#warehouseTransferIn_btnWarehouseTransferOut').click(function(ev) {
            var firstDate = $("#warehouseTransferInTransactionDateFirstSession").val();
            var lastDate = $("#warehouseTransferInTransactionDateLastSession").val();
            var params = "iddoc=warehouseTransferIn&idsubdoc=warehouseTransferOut&firstDate="+firstDate+"&lastDate="+lastDate;
            
            window.open("./pages/search/search-warehouse-transfer-out.jsp?"+params,"Search", "Scrollbars=1,width=600, height=500");
        });
        
        $("#btnConfirmWarehouseTransferOutDetail").click(function(ev) {
            if(txtWarehouseTransferInSourceWarehouseCode.val() === txtWarehouseTransferInDestinationWarehouseCode.val()){
                alert("SourceWarehouse sama dengan DestinationWarehouse");
                return; 
            }
            $("#div-header-trf-in").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#warehouseTransferInItemDetailSourceInputGrid").unblock();
            $("#warehouseTransferInItemDetailDestinationInputGrid").unblock();
            $("#btnConfirmWarehouseTransferOutDetail").css("display", "none");
            $("#btnUnConfirmWarehouseTransferOutDetail").css("display", "block");
            //generateWarehouseTransferIn();
            generateDataWarehouseTransferOutSource();
        });
        
        $("#btnUnConfirmWarehouseTransferOutDetail").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm This Item Detail?</div>');

            dynamicDialog.dialog({
                    title : "Confirmation:",
                    closeOnEscape: false,
                    modal : true,
                    width: 500,
                    resizable: false,
                    buttons : 
                        [{
                            text : "Yes",
                            click : function() {
                                $(this).dialog("close");
                                $("#div-header-trf-in").unblock();
                                //$("#warehouseTransferInItemDetailInput_grid").jqGrid("clearGridData");
                                $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('clearGridData');
                                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmWarehouseTransferOutDetail").css("display", "none");
                                $("#btnConfirmWarehouseTransferOutDetail").css("display", "block");
                                //$("#warehouseTransferInItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#warehouseTransferInItemDetailSourceInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $("#warehouseTransferInItemDetailDestinationInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
    
    function handlers_input_warehouse_transfer_request(){
        if(dtpWarehouseTransferInTransactionDate.val()===""){
            handlersInput(dtpWarehouseTransferInTransactionDate);
        }else{
            unHandlersInput(dtpWarehouseTransferInTransactionDate);
        }
    }
    
    function formatDateWHTIn(){
        var transactionDateValue=dtpWarehouseTransferInTransactionDate.val();
        var transactionDateValuesTemp=transactionDateValue.split(' ');
        var transactionDateValues=transactionDateValuesTemp[0].split('/');
        var transactionDate = transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2]+" "+transactionDateValuesTemp[1];
        dtpWarehouseTransferInTransactionDate.val(transactionDate);
    
        var createdDateValue=dtpWarehouseTransferInCreatedDate.val();
        var createdDateValuesTemp=createdDateValue.split(' ');
        var createdDateValues=createdDateValuesTemp[0].split('/');
        var createdDate = createdDateValues[1]+"/"+createdDateValues[0]+"/"+createdDateValues[2]+" "+createdDateValuesTemp[1];
        dtpWarehouseTransferInCreatedDate.val(createdDate);
    }
    
    function warehouseTransferInItemDetailDestinationInputGrid_SearchRack_OnClick(){
        window.open("./pages/search/search-rack.jsp?iddoc=warehouseTransferInItemDetailDestination&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function onChangeWarehouseTransferInItemDetailDestinationRack(){
        var selectedRowID = $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("getGridParam", "selrow");
        var itemRackCode = $("#" + selectedRowID + "_warehouseTransferInItemDetailDestinationRackCode").val();
        
        if(itemRackCode.trim()===""){
            $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("setCell", selectedRowID,"_warehouseTransferInItemDetailDestinationRackName"," ");
            return;
        }       
        var url = "master/rack-get";
        var params = "rack.code="+itemRackCode;
            params+="&rack.activeStatus=TRUE";
            
        $.post(url, params, function(result) {
            var data = (result);
            if (data.rack){
                $("#" + selectedRowID + "_warehouseTransferInItemDetailDestinationRackCode").val(data.rack.code);
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("setCell", selectedRowID,"warehouseTransferInItemDetailDestinationRackName",data.rack.name);
            }
            else{
                alertMessage("Rack Not Found!",$("#" + selectedRowID + "_warehouseTransferInItemDetailSourceRackCode"));
                $("#" + selectedRowID + "_warehouseTransferInItemDetailDestinationRackCode").val("");
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("setCell", selectedRowID,"warehouseTransferInItemDetailDestinationRackName"," ");
            }
        });
    }
    
    function formatDateGlobalPickingList(date, useTime) {
        var dateValuesTemps;

        if (useTime) {
            var dateValues = date.split(' ');
            var dateValuesTemp = dateValues[0].split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            var dateValuesTemp = date.split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    function generateDataWarehouseTransferOutSource(){
                
        var url = "master/warehouse-transfer-out-item-detail-data";
        var params= "warehouseTransferOut.code=" + $("#warehouseTransferIn\\.warehouseTransferOut\\.code").val();

        $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid("clearGridData");

        showLoading();
        $.post(url, params, function(data) {
            closeLoading();
            if (data.error) {
                $("#btnUnConfirmWarehouseTransferOutDetail").css("display", "none");
                $("#btnConfirmWarehouseTransferOutDetail").css("display", "block");
                alertMessage(data.errorMessage);
                return;
            }
            
            warehouseTransferInItemDetailSource_lastRowId = 0;
            
            for (var i=0; i<data.listWarehouseTransferOutItemDetailTemp.length; i++) {

                if(data.listWarehouseTransferOutItemDetailTemp[i].quantity>0){
                    warehouseTransferInItemDetailSource_lastRowId++;
                    
                    $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid("addRowData", warehouseTransferInItemDetailSource_lastRowId, data.listWarehouseTransferOutItemDetailTemp[i]);
                    $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('setRowData',warehouseTransferInItemDetailSource_lastRowId,{
                        warehouseTransferInItemDetailSourceItemMaterialCode                 : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialCode,
                        warehouseTransferInItemDetailSourceItemMaterialName                 : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialName,
                        warehouseTransferInItemDetailSourceItemMaterialInventoryType        : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialInventoryType,
                        warehouseTransferInItemDetailSourceItemMateriaUnitOfMeasureCode     : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialUnitOfMeasureCode,
                        warehouseTransferInItemDetailSourceCOGSIDR                          : data.listWarehouseTransferOutItemDetailTemp[i].cogsIdr,
                        warehouseTransferInItemDetailSourceQuantity                         : data.listWarehouseTransferOutItemDetailTemp[i].quantity,
                        warehouseTransferInItemDetailSourceRackCode                         : data.listWarehouseTransferOutItemDetailTemp[i].rackCode,
                        warehouseTransferInItemDetailSourceRackName                         : data.listWarehouseTransferOutItemDetailTemp[i].rackName,
                        warehouseTransferInItemDetailsourceDestinationRackCode              : data.listWarehouseTransferOutItemDetailTemp[i].destinationRackCode,
                        warehouseTransferInItemDetailsourceDestinationRackName              : data.listWarehouseTransferOutItemDetailTemp[i].destinationRackName,
                        warehouseTransferInItemDetailSourceReasonCode                       : data.listWarehouseTransferOutItemDetailTemp[i].reasonCode,
                        warehouseTransferInItemDetailSourceReasonName                       : data.listWarehouseTransferOutItemDetailTemp[i].reasonName,
                        warehouseTransferInItemDetailSourceRemark                           : data.listWarehouseTransferOutItemDetailTemp[i].remark
                    });
                }
            }
        }).done(function() {
         generateDataWarehouseTransferOutDestination();
        });
        
    }
    
    function generateDataWarehouseTransferOutDestination(){
           
        if(warehouseTransferInItemDetailDestination_lastSel !== -1) {
            $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('saveRow',warehouseTransferInItemDetailDestination_lastSel); 
        }
        
        var idsSource = jQuery("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('getDataIDs');
        
        warehouseTransferInItemDetailDestination_lastRowId=0;
        for(var i=0;i < idsSource.length;i++){ 
            var data = $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('getRowData',idsSource[i]); 
                
            $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("addRowData", warehouseTransferInItemDetailDestination_lastRowId, data);
            $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('setRowData',warehouseTransferInItemDetailDestination_lastRowId,{
                warehouseTransferInItemDetailDestinationItemMaterialCode              : data.warehouseTransferInItemDetailSourceItemMaterialCode,
                warehouseTransferInItemDetailDestinationItemMaterialName              : data.warehouseTransferInItemDetailSourceItemMaterialName,
                warehouseTransferInItemDetailDestinationItemMaterialInventoryType     : data.warehouseTransferInItemDetailSourceItemMaterialInventoryType,
                warehouseTransferInItemDetailDestinationReasonCode                    : data.warehouseTransferInItemDetailSourceReasonCode,
                warehouseTransferInItemDetailDestinationReasonName                    : data.warehouseTransferInItemDetailSourceReasonName,
                warehouseTransferInItemDetailDestinationQuantity                      : data.warehouseTransferInItemDetailSourceQuantity,
                warehouseTransferInItemDetailDestinationCOGSIDR                       : data.warehouseTransferInItemDetailSourceCOGSIDR,
                warehouseTransferInItemDetailDestinationTotalAmount                   : (parseFloat(data.warehouseTransferInItemDetailSourceQuantity) * parseFloat(data.warehouseTransferInItemDetailSourceCOGSIDR)),
                warehouseTransferInItemDetailDestinationUnitOfMeasureCode             : data.warehouseTransferInItemDetailSourceItemMateriaUnitOfMeasureCode,
                warehouseTransferInItemDetailDestinationRemark                        : data.warehouseTransferInItemDetailSourceRemark,
                warehouseTransferInItemDetailDestinationRackCode                      : data.warehouseTransferInItemDetailsourceDestinationRackCode,                 
                warehouseTransferInItemDetailDestinationRackName                      : data.warehouseTransferInItemDetailsourceDestinationRackName
            });
            warehouseTransferInItemDetailDestination_lastRowId++;
        }
    }
    
    function warehouseTransferOutDetailInputGrid_ItemDelete_OnClick(){
        var selectedRowID = $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("getGridParam", "selrow");
        if (selectedRowID === null) {
            alertMessage("Please Select Row");
            return;
        }          
        $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('delRowData',selectedRowID);
    }
    
    function warehouseTransferRequestDetailInputGrid_SearchItem_OnClick(){
        window.open("./pages/search/search-item.jsp?iddoc=warehouseTransferInItemDetailDestination&idsubdoc=Item&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function onChangeAdjustmentInItemDetailItem(){
        var selectedRowID = $("#adjustmentInItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var itemCode = $("#" + selectedRowID + "_adjustmentInItemDetailItemCode").val();
        
        if(itemCode===""){
            clearRowSelectedAdjustmentInItemDetail();
            return;
        }
        
        var ids = jQuery("#adjustmentInItemDetailInput_grid").jqGrid('getDataIDs'); 
        
        var url = "master/item-get";
        var params = "item.code="+itemCode;
            params+="&item.activeStatus=TRUE";
            
        $.post(url, params, function(result) {
            var data = (result);
            if (data.item){
                $("#" + selectedRowID + "_adjustmentInItemDetailItemCode").val(data.item.code);
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemName",data.item.name);
//                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemStockSerialNoStatus",data.itemTemp.serialNoStatus.toString());
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailUnitOfMeasureCode",data.item.defaultUnitOfMeasure.code);
            }else{
                alertMessage("Item Not Found!",$("#" + selectedRowID + "_adjustmentInItemDetailItemCode"));
                $("#" + selectedRowID + "_adjustmentInItemDetailItemCode").val("");
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemName"," ");
//                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemStockSerialNoStatus"," ");
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailUnitOfMeasureCode"," ");
            }
        });
    }
    
    function warehouseTransferInCalculateDetail() {
        var selectedRowID = $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("getGridParam", "selrow");
        var data=$("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('getRowData',selectedRowID);
                        
        var qty = $("#" + selectedRowID + "_warehouseTransferInItemDetailDestinationQuantity").val();
        var cogsIdr = data.warehouseTransferInItemDetailDestinationCOGSIDR;
        var totalAmount = (parseFloat(qty) * parseFloat(cogsIdr));

        $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("setCell", selectedRowID, "warehouseTransferInItemDetailDestinationTotalAmount", totalAmount);

        $("#"+selectedRowID+"_warehouseTransferInItemDetailDestinationQuantity").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
    }
</script>

<b>WAREHOUSE TRANSFER IN </b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlWarehouseTransferInItemDetailDestinationInput" action="" />

<div id="warehouseTransferInInput" class="content ui-widget">
    <s:form id="frmWarehouseTransferInInput">
        <div id="div-header-trf-in">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right" style="width:150px"><B>WHTI No</B></td>
                    <td>
                        <s:textfield id="warehouseTransferIn.code" name="warehouseTransferIn.code" size="30" readonly="true" ></s:textfield>
                        <s:textfield id="warehouseTransferInUpdateMode" name="warehouseTransferInUpdateMode" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="warehouseTransferIn.transactionDate" name="warehouseTransferIn.transactionDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" readonly="true"></sj:datepicker>
                        <sj:datepicker id="warehouseTransferInTransactionDate" name="warehouseTransferInTransactionDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" cssStyle="display:none"></sj:datepicker>
                        <sj:datepicker id="warehouseTransferInTransactionDateFirstSession" name="warehouseTransferInTransactionDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                        <sj:datepicker id="warehouseTransferInTransactionDateLastSession" name="warehouseTransferInTransactionDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>WHTO No *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">

                            txtWarehouseTransferInWTOCode.change(function(ev) {

                                if(txtWarehouseTransferInWTOCode.val()===""){
                                    return;
                                }
                                var url = "inventory/warehouse-transfer-out";
                                var params = "warehouseTransferOut.code=" + txtWarehouseTransferInWTOCode.val();

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.warehouseTransferOut){
                                        txtWarehouseTransferInWTOCode.val(data.warehouseTransferOut.code);
                                    }
                                    else{
                                        alertMessage("Warehouse Transfer Out Not Found!",txtWarehouseTransferInWTOCode.val());
                                        txtWarehouseTransferInWTOCode.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header" hidden="true">
                            <s:textfield id="warehouseTransferIn.warehouseTransferOut.code" name="warehouseTransferIn.warehouseTransferOut.code" required="true" cssClass="required" title=" " size="25"></s:textfield>
                            <sj:a id="warehouseTransferIn_btnWarehouseTransferOut" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-warehouse-transfer-request"/></sj:a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right">Branch</td>
                    <td colspan="2">
                        <s:textfield id="warehouseTransferIn.warehouseTransferOut.branch.code" name="warehouseTransferIn.warehouseTransferOut.branch.code" required="true" cssClass="required" readonly="true" size="20"></s:textfield>
                        <s:textfield id="warehouseTransferIn.warehouseTransferOut.branch.name" name="warehouseTransferIn.warehouseTransferOut.branch.name" cssStyle="width:55%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">WHTO Date</td>
                    <td>
                        <sj:datepicker disabled="true" id="warehouseTransferIn.warehouseTransferOut.transactionDate" name="warehouseTransferIn.warehouseTransferOut.transactionDate"  readonly="true" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Source Warehouse</td>
                    <td colspan="2">
                        <s:textfield id="warehouseTransferIn.sourceWarehouse.code" name="warehouseTransferIn.sourceWarehouse.code" readonly="true" size="20" title=" " required="true" cssClass="required" ></s:textfield>
                        <s:textfield id="warehouseTransferIn.sourceWarehouse.name" name="warehouseTransferIn.sourceWarehouse.name" cssStyle="width:49%" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Destination Warehouse</td>
                    <td colspan="2">
                        <s:textfield id="warehouseTransferIn.destinationWarehouse.code" name="warehouseTransferIn.destinationWarehouse.code" readonly="true" size="20" title=" " required="true" cssClass="required" ></s:textfield>
                        <s:textfield id="warehouseTransferIn.destinationWarehouse.name" name="warehouseTransferIn.destinationWarehouse.name" cssStyle="width:49%" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td><s:textfield id="warehouseTransferIn.refNo" name="warehouseTransferIn.refNo" size="30" ></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td><s:textarea id="warehouseTransferIn.remark" name="warehouseTransferIn.remark"  rows="3" cols="70"></s:textarea> </td>
                </tr>
                <tr hidden="true">
                    <td>
                        <s:textfield id="warehouseTransferIn.createdBy" name="warehouseTransferIn.createdBy" key="warehouseTransferIn.createdBy" readonly="true" size="22"></s:textfield>
                        <sj:datepicker id="warehouseTransferIn.createdDate" name="warehouseTransferIn.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                        <s:textfield id="warehouseTransferInTemp.createdDateTemp" name="warehouseTransferInTemp.createdDateTemp" size="20"></s:textfield>
                    </td>
                </tr>
            </table>
            </div>
                    
            <br class="spacer" />
                    
            <table>
                <tr>
                    <td colspan="2">
                        <sj:a href="#" id="btnConfirmWarehouseTransferOutDetail" button="true">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmWarehouseTransferOutDetail" button="true">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>
                
            <br class="spacer" />
            <br class="spacer" />

            <div id="warehouseTransferInItemDetailSourceInputGrid">
                <sjg:grid
                    id="warehouseTransferInItemDetailSourceInput_grid"
                    caption="WAREHOUSE MUTATION ITEM DETAIL SOURCE"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listWarehouseTransferInItemDetailSourceTemp"
                    rowList="10,20,30"
                    rowNum="10000"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuWarehouseTransferIn').width()"
                    onSelectRowTopics="warehouseTransferInItemDetailSourceInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceItemMaterialCode" index = "warehouseTransferInItemDetailSourceItemMaterialCode" key = "warehouseTransferInItemDetailSourceItemMaterialCode" 
                        title = "Item Code *" width = "150" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceItemMaterialName" index = "warehouseTransferInItemDetailSourceItemMaterialName" key = "warehouseTransferInItemDetailSourceItemMaterialName" 
                        title = "Item Name" width = "250"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceItemMaterialInventoryType" index = "warehouseTransferInItemDetailSourceItemMaterialInventoryType" key = "warehouseTransferInItemDetailSourceItemMaterialInventoryType" 
                        title = "InventoryType" width = "100" hidden="false"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceReasonCode" index = "warehouseTransferInItemDetailSourceReasonCode" key = "warehouseTransferInItemDetailSourceReasonCode" 
                        title = "Reason Code" width = "150" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceReasonName" index = "warehouseTransferInItemDetailSourceReasonName" key = "warehouseTransferInItemDetailSourceReasonName" 
                        title = "Reason Name" width = "250"
                    />
                    <sjg:gridColumn
                        name="warehouseTransferInItemDetailSourceQuantity" index="warehouseTransferInItemDetailSourceQuantity" key="warehouseTransferInItemDetailSourceQuantity" 
                        title="Quantity *" width="80" align="right" edittype="text" editable="false"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="warehouseTransferInItemDetailSourceCOGSIDR" index="warehouseTransferInItemDetailSourceCOGSIDR" key="warehouseTransferInItemDetailSourceCOGSIDR" 
                        title="Cogs Idr" width="80" align="right" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceItemMateriaUnitOfMeasureCode" index="warehouseTransferInItemDetailSourceItemMateriaUnitOfMeasureCode" key="warehouseTransferInItemDetailSourceItemMateriaUnitOfMeasureCode" title="Unit" width="100" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceRemark" index="warehouseTransferInItemDetailSourceRemark" key="warehouseTransferInItemDetailSourceRemark" title="Remark" width="250" edittype="text" editable="false"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceRackCode" index="warehouseTransferInItemDetailSourceRackCode" key="warehouseTransferInItemDetailSourceRackCode" title="Rack Code" width="150" edittype="text"
                        editoptions="{onChange:'onChangeWarehouseTransferInItemDetailSourceRack()'}" editable="false"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailSourceRackName" index="warehouseTransferInItemDetailSourceRackName" key="warehouseTransferInItemDetailSourceRackName" title="Rack Name" width="150" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailsourceDestinationRackCode" index="warehouseTransferInItemDetailsourceDestinationRackCode" key="warehouseTransferInItemDetailsourceDestinationRackCode" title="Rack  dest Code" width="150" edittype="text" hidden="true"
                        editoptions="{onChange:'onChangeWarehouseTransferInItemDetailSourceRack()'}" editable="false"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailsourceDestinationRackName" index="warehouseTransferInItemDetailsourceDestinationRackName" key="warehouseTransferInItemDetailsourceDestinationRackName" title="Rack dest Name" width="150" edittype="text" hidden="true"
                    />
                </sjg:grid >
                
            </div>
                
            <br class="spacer" />
                
            <div id="warehouseTransferInItemDetailDestinationInputGrid">
                <sjg:grid
                    id="warehouseTransferInItemDetailDestinationInput_grid"
                    caption="WAREHOUSE MUTATION ITEM DETAIL DESTINATION"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listWarehouseTransferInItemDetailDestinationTemp"
                    rowList="10,20,30"
                    rowNum="10000"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuWarehouseTransferIn').width()"
                    editinline="true"
                    editurl="%{remotedetailurlWarehouseTransferInItemDetailDestinationInput}"
                    onSelectRowTopics="warehouseTransferInItemDetailDestinationInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestination" index = "warehouseTransferInItemDetailDestination" key = "warehouseTransferInItemDetailDestination" 
                        title = "" width = "150" edittype="text" editable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationCode" index = "warehouseTransferInItemDetailDestinationCode" key = "warehouseTransferInItemDetailDestinationCode" 
                        title = "Code" width = "150" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationItemMaterialCode" index = "warehouseTransferInItemDetailDestinationItemMaterialCode" key = "warehouseTransferInItemDetailDestinationItemMaterialCode" 
                        title = "Item Code *" width = "150" edittype="text"
                        editoptions="{onChange:'onChangeAdjustmentInItemDetailItem()'}" 
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationItemMaterialName" index = "warehouseTransferInItemDetailDestinationItemMaterialName" key = "warehouseTransferInItemDetailDestinationItemMaterialName" 
                        title = "Item Name" width = "250"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationItemMaterialInventoryType" index = "warehouseTransferInItemDetailDestinationItemMaterialInventoryType" key = "warehouseTransferInItemDetailDestinationItemMaterialInventoryType" 
                        title = "InventoryType" width = "100" hidden="false"
                    />
                    <sjg:gridColumn
                        name="warehouseTransferInItemDetailDestinationQuantity" index="warehouseTransferInItemDetailDestinationQuantity" key="warehouseTransferInItemDetailDestinationQuantity" 
                        title="Quantity *" width="80" align="right" edittype="text" 
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onClick:'this.setSelectionRange(0, this.value.length)',onKeyUp:'warehouseTransferInCalculateDetail()'}"
                    />
                    <sjg:gridColumn
                        name="warehouseTransferInItemDetailDestinationCOGSIDR" index="warehouseTransferInItemDetailDestinationCOGSIDR" key="warehouseTransferInItemDetailDestinationCOGSIDR" 
                        title="Cogs Idr" width="80" align="right" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:4}"
                    />
                    <sjg:gridColumn
                        name="warehouseTransferInItemDetailDestinationTotalAmount" index="warehouseTransferInItemDetailDestinationTotalAmount" key="warehouseTransferInItemDetailDestinationTotalAmount" 
                        title="TotalAmount" width="80" align="right" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:4}"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationUnitOfMeasureCode" index="warehouseTransferInItemDetailDestinationUnitOfMeasureCode" 
                        key="warehouseTransferInItemDetailDestinationUnitOfMeasureCode" title="Unit" width="100" 
                        edittype="text" editable="false"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationRackCode" index="warehouseTransferInItemDetailDestinationRackCode" key="warehouseTransferInItemDetailDestinationRackCode" title="Rack Code" 
                        width="150" edittype="text"
                        editoptions="{onChange:'onChangeWarehouseTransferInItemDetailDestinationRack()'}"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationRackName" index="warehouseTransferInItemDetailDestinationRackName" key="warehouseTransferInItemDetailDestinationRackName" title="Rack Name" width="150" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "warehouseTransferInItemDetailDestinationRemark" index="warehouseTransferInItemDetailDestinationRemark" key="warehouseTransferInItemDetailDestinationRemark" title="Remark" width="250" edittype="text" 
                    />
                </sjg:grid >
                
            </div>
                        
        <br class="spacer" />
        
        <table width="100%">
            <tr>
                <td>      
                    <sj:a href="#" id="btnWarehouseTransferInSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnWarehouseTransferInCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        
    </s:form>
</div>
<script>
    
    if(txtWarehouseTransferInCode.val() !== "AUTO"){
        autoLoadDataWarehouseTransferIn();
        autoLoadDataWarehouseTransferInSource();
        generateDataWarehouseTransferInDestination();
    }
    
    function autoLoadDataWarehouseTransferInSource(){
        var url = "inventory/warehouse-transfer-out-receiving-supervisor-item-detail-source-data";
        var params = "warehouseTransferIn.code=" + txtWarehouseTransferInCode.val();

        showLoading();

        $.post(url, params, function(data) {
           warehouseTransferInItemDetailSource_lastRowId=0;
            for (var i=0; i<data.listWarehouseTransferInItemDetailSourceTemp.length; i++) {
                
                var itemDate=formatDateRemoveT(data.listWarehouseTransferInItemDetailSourceTemp[i].itemDate, false);
                var productionDate=formatDateRemoveT(data.listWarehouseTransferInItemDetailSourceTemp[i].productionDate, false);
                var expiredDate=formatDateRemoveT(data.listWarehouseTransferInItemDetailSourceTemp[i].expiredDate, false);
                
                var quantity = String(data.listWarehouseTransferInItemDetailSourceTemp[i].quantity).replace(/,/g, "");
                var cogs = String(data.listWarehouseTransferInItemDetailSourceTemp[i].cogsIdr).replace(/,/g, "");
                
                $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid("addRowData", warehouseTransferInItemDetailSource_lastRowId, data.listWarehouseTransferInItemDetailSourceTemp[i]);
                $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('setRowData',warehouseTransferInItemDetailSource_lastRowId,{
                    warehouseTransferInItemDetailSourceItemMaterialCode              : data.listWarehouseTransferInItemDetailSourceTemp[i].itemCode,
                    warehouseTransferInItemDetailSourceItemMaterialName              : data.listWarehouseTransferInItemDetailSourceTemp[i].itemName,
                    warehouseTransferInItemDetailSourceItemMaterialInventoryType     : data.listWarehouseTransferInItemDetailSourceTemp[i].inventoryType,
                    warehouseTransferInItemDetailSourceReasonCode            : data.listWarehouseTransferInItemDetailSourceTemp[i].reasonCode,
                    warehouseTransferInItemDetailSourceReasonName            : data.listWarehouseTransferInItemDetailSourceTemp[i].reasonName,
                    warehouseTransferInItemDetailSourceQuantity              : quantity,
                    warehouseTransferInItemDetailSourceCOGSIDR               : cogs,
                    warehouseTransferInItemDetailSourceItemMateriaUnitOfMeasureCode     : data.listWarehouseTransferInItemDetailSourceTemp[i].unitOfMeasureCode,
                    warehouseTransferInItemDetailSourceRemark                : data.listWarehouseTransferInItemDetailSourceTemp[i].remark,
                    warehouseTransferInItemDetailSourceInTransactionNo       : data.listWarehouseTransferInItemDetailSourceTemp[i].inTransactionNo,
                    warehouseTransferInItemDetailSourceInDocumentType        : data.listWarehouseTransferInItemDetailSourceTemp[i].inDocumentType,
                    warehouseTransferInItemDetailSourceLotNo                 : data.listWarehouseTransferInItemDetailSourceTemp[i].lotNo,
                    warehouseTransferInItemDetailSourceBatchNo               : data.listWarehouseTransferInItemDetailSourceTemp[i].batchNo,
                    warehouseTransferInItemDetailSourceProductionDate        : productionDate,
                    warehouseTransferInItemDetailSourceExpiredDate           : expiredDate,
                    warehouseTransferInItemDetailSourceRackCode              : data.listWarehouseTransferInItemDetailSourceTemp[i].rackCode,
                    warehouseTransferInItemDetailSourceRackName              : data.listWarehouseTransferInItemDetailSourceTemp[i].rackName,                    
                    warehouseTransferInItemDetailSourceItemDate              : itemDate,
                    warehouseTransferInItemDetailSourceItemBrandCode         : data.listWarehouseTransferInItemDetailSourceTemp[i].itemBrandCode,
                    warehouseTransferInItemDetailSourceItemBrandName         : data.listWarehouseTransferInItemDetailSourceTemp[i].itemBrandName                    
                });
                warehouseTransferInItemDetailSource_lastRowId++;
            }
            closeLoading();
        }); 
    }
    
    function generateDataWarehouseTransferInDestination(){
           
        if(warehouseTransferInItemDetailSource_lastSel !== -1) {
            $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('saveRow',warehouseTransferInItemDetailSource_lastSel); 
        }
        
        var idsSource = jQuery("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('getDataIDs');
        
        warehouseTransferInItemDetailDestination_lastRowId=0;
        for(var i=0;i < idsSource.length;i++){ 
            var data = $("#warehouseTransferInItemDetailSourceInput_grid").jqGrid('getRowData',idsSource[i]); 
                
            $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("addRowData", warehouseTransferInItemDetailDestination_lastRowId, data);
            $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('setRowData',warehouseTransferInItemDetailDestination_lastRowId,{
                warehouseTransferInItemDetailDestinationItemMaterialCode              : data.warehouseTransferInItemDetailSourceItemMaterialCode,
                warehouseTransferInItemDetailDestinationItemMaterialName              : data.warehouseTransferInItemDetailSourceItemMaterialName,
                warehouseTransferInItemDetailDestinationItemMaterialInventoryType     : data.warehouseTransferInItemDetailSourceItemMaterialInventoryType,
                warehouseTransferInItemDetailDestinationReasonCode            : data.warehouseTransferInItemDetailSourceReasonCode,
                warehouseTransferInItemDetailDestinationReasonName            : data.warehouseTransferInItemDetailSourceReasonName,
                warehouseTransferInItemDetailDestinationQuantity              : data.warehouseTransferInItemDetailSourceQuantity,
                warehouseTransferInItemDetailDestinationCOGSIDR               : data.warehouseTransferInItemDetailSourceCOGSIDR,
                warehouseTransferInItemDetailDestinationUnitOfMeasureCode     : data.warehouseTransferInItemDetailSourceItemMateriaUnitOfMeasureCode,
                warehouseTransferInItemDetailDestinationRemark                : data.warehouseTransferInItemDetailSourceRemark,
                warehouseTransferInItemDetailDestinationInTransactionNo       : data.warehouseTransferInItemDetailSourceInTransactionNo,
                warehouseTransferInItemDetailDestinationInDocumentType        : data.warehouseTransferInItemDetailSourceInDocumentType,
                warehouseTransferInItemDetailDestinationLotNo                 : data.warehouseTransferInItemDetailSourceLotNo,
                warehouseTransferInItemDetailDestinationBatchNo               : data.warehouseTransferInItemDetailSourceBatchNo,
                warehouseTransferInItemDetailDestinationProductionDate        : data.warehouseTransferInItemDetailSourceProductionDate,
                warehouseTransferInItemDetailDestinationExpiredDate           : data.warehouseTransferInItemDetailSourceExpiredDate,
                warehouseTransferInItemDetailDestinationRackCode              : $("#defaultRackCode").val(),                 
                warehouseTransferInItemDetailDestinationRackName              : $("#defaultRackName").val(),                
                warehouseTransferInItemDetailDestinationItemDate               : data.warehouseTransferInItemDetailSourceItemDate,
                warehouseTransferInItemDetailDestinationItemBrandCode          : data.warehouseTransferInItemDetailSourceItemBrandCode,
                warehouseTransferInItemDetailDestinationItemBrandName          : data.warehouseTransferInItemDetailSourceItemBrandName
            });
            warehouseTransferInItemDetailDestination_lastRowId++;
        }
    }
    
    function autoLoadDataWarehouseTransferInDestination(){
        var url = "inventory/warehouse-transfer-out-receiving-supervisor-item-detail-destination-data";
        var params = "warehouseTransferIn.code=" + txtWarehouseTransferInCode.val();

        showLoading();

        $.post(url, params, function(data) {
           warehouseTransferInItemDetailDestination_lastRowId=0;
            for (var i=0; i<data.listWarehouseTransferInItemDetailDestinationTemp.length; i++) {
                
                var itemDate=formatDateRemoveT(data.listWarehouseTransferInItemDetailDestinationTemp[i].itemDate, false);
                var productionDate=formatDateRemoveT(data.listWarehouseTransferInItemDetailDestinationTemp[i].productionDate, false);
                var expiredDate=formatDateRemoveT(data.listWarehouseTransferInItemDetailDestinationTemp[i].expiredDate, false);
                
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid("addRowData", warehouseTransferInItemDetailDestination_lastRowId, data.listWarehouseTransferInItemDetailDestinationTemp[i]);
                $("#warehouseTransferInItemDetailDestinationInput_grid").jqGrid('setRowData',warehouseTransferInItemDetailDestination_lastRowId,{
                    warehouseTransferInItemDetailDestinationCode                          : data.listWarehouseTransferInItemDetailDestinationTemp[i].code,
                    warehouseTransferInItemDetailDestinationItemMaterialCode              : data.listWarehouseTransferInItemDetailDestinationTemp[i].itemMaterialCode,
                    warehouseTransferInItemDetailDestinationItemMaterialName              : data.listWarehouseTransferInItemDetailDestinationTemp[i].itemMaterialName,
                    warehouseTransferInItemDetailDestinationItemMaterialInventoryType     : data.listWarehouseTransferInItemDetailDestinationTemp[i].itemMaterialInventoryType,
                    warehouseTransferInItemDetailDestinationReasonCode                    : data.listWarehouseTransferInItemDetailDestinationTemp[i].reasonCode,
                    warehouseTransferInItemDetailDestinationReasonName                    : data.listWarehouseTransferInItemDetailDestinationTemp[i].reasonName,
                    warehouseTransferInItemDetailDestinationQuantity                      : data.listWarehouseTransferInItemDetailDestinationTemp[i].quantity,
                    warehouseTransferInItemDetailDestinationCOGSIDR                       : data.listWarehouseTransferInItemDetailDestinationTemp[i].cogsIdr,
                    warehouseTransferInItemDetailDestinationUnitOfMeasureCode             : data.listWarehouseTransferInItemDetailDestinationTemp[i].unitOfMeasureCode,
                    warehouseTransferInItemDetailDestinationRemark                        : data.listWarehouseTransferInItemDetailDestinationTemp[i].remark,
                    warehouseTransferInItemDetailDestinationInTransactionNo               : data.listWarehouseTransferInItemDetailDestinationTemp[i].inTransactionNo,
                    warehouseTransferInItemDetailDestinationInDocumentType                : data.listWarehouseTransferInItemDetailDestinationTemp[i].inDocumentType,
                    warehouseTransferInItemDetailDestinationLotNo                         : data.listWarehouseTransferInItemDetailDestinationTemp[i].lotNo,
                    warehouseTransferInItemDetailDestinationBatchNo                       : data.listWarehouseTransferInItemDetailDestinationTemp[i].batchNo,
                    warehouseTransferInItemDetailDestinationProductionDate                : productionDate,
                    warehouseTransferInItemDetailDestinationExpiredDate                   : expiredDate,
                    warehouseTransferInItemDetailDestinationRackCode                      : data.listWarehouseTransferInItemDetailDestinationTemp[i].rackCode,                    
                    warehouseTransferInItemDetailDestinationRackName                      : data.listWarehouseTransferInItemDetailDestinationTemp[i].rackName,                    
                    warehouseTransferInItemDetailDestinationItemDate                      : itemDate,
                    warehouseTransferInItemDetailDestinationItemBrandCode                 : data.listWarehouseTransferInItemDetailDestinationTemp[i].itemBrandCode,
                    warehouseTransferInItemDetailDestinationItemBrandName                 : data.listWarehouseTransferInItemDetailDestinationTemp[i].itemBrandName
                });
                warehouseTransferInItemDetailDestination_lastRowId++;
            }
            closeLoading();
        }); 
    }
</script>
