<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #warehouseTransferOutItemDetailInput_grid_pager_center{
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

    var warehouseTransferOutItemDetail_lastSel = -1, warehouseTransferOutItemDetail_lastRowId = 0;
    var warehouseTransferOutItemDetailDestination_lastSel = -1, warehouseTransferOutItemDetailDestination_lastRowId = 0;

            var txtWarehouseTransferOutCode = $("#warehouseTransferOut\\.code"),
            dtpWarehouseTransferOutTransactionDate = $("#warehouseTransferOut\\.transactionDate"),
            txtWarehouseTransferOutBranchCode = $("#warehouseTransferOut\\.branch\\.code"),
            txtWarehouseTransferOutBranchName = $("#warehouseTransferOut\\.branch\\.name"),
            txtWarehouseTransferOutSourceWarehouseCode = $("#warehouseTransferOut\\.sourceWarehouse\\.code"),
            txtWarehouseTransferOutSourceWarehouseName = $("#warehouseTransferOut\\.sourceWarehouse\\.name"),
            txtWarehouseTransferOutDestinationWarehouseCode = $("#warehouseTransferOut\\.destinationWarehouse\\.code"),
            txtWarehouseTransferOutDestinationWarehouseName = $("#warehouseTransferOut\\.destinationWarehouse\\.name"),
            txtWarehouseTransferOutRefNo = $("#warehouseTransferOut\\.refNo"),
            txtWarehouseTransferOutRemark = $("#warehouseTransferOut\\.remark"),
            txtWarehouseTransferOutCreatedBy = $("#warehouseTransferOut\\.createdBy"),
            dtpWarehouseTransferOutCreatedDate = $("#warehouseTransferOut\\.createdDate");

    function
            numberWithCommas(x) {
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

    $(document).ready(function () {

        $("#warehouseTransferOutAddRow").val("1");
        flagConfirmWarehouseTransferOut = false;
        $("#btnUnConfirmWarehouseTransferOut").css("display", "none");
        $("#btnUnConfirmWarehouseTransferOutDetail").css("display", "none");
        $("#warehouseTransferOutItemDetailInputGrid").block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#warehouseTransferOutItemDetailInputGrid").block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#warehouseTransferOutItemDetailDestinationInputGrid").block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});

        $.subscribe("warehouseTransferOutItemDetailInput_grid_onSelect", function (event, data) {
            var selectedRowID = $("#warehouseTransferOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if (selectedRowID !== warehouseTransferOutItemDetail_lastSel) {
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('saveRow', warehouseTransferOutItemDetail_lastSel);
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('editRow', selectedRowID, true);
                warehouseTransferOutItemDetail_lastSel = selectedRowID;
            }
            else {
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('saveRow', selectedRowID);
            }
        });

        $.subscribe("warehouseTransferOutItemDetailInput_grid_onSelect", function (event, data) {
            var selectedRowID = $("#warehouseTransferOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if (selectedRowID !== warehouseTransferOutItemDetail_lastSel) {
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('saveRow', warehouseTransferOutItemDetail_lastSel);
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('editRow', selectedRowID, true);
                warehouseTransferOutItemDetail_lastSel = selectedRowID;
            }
            else {
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('saveRow', selectedRowID);
            }
        });

        $("#btnConfirmWarehouseTransferOut").click(function (ev) {
            handlers_input_warehouse_transfer_out();
            if (!$("#frmWarehouseTransferOutInput").valid()) {
                alertMessage("Field Can't Empty!");
                ev.preventDefault();
                return;
            }

            var date1 = dtpWarehouseTransferOutTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#warehouseTransferOutTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if (parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())) {
                if ($("#warehouseTransferOutUpdateMode").val() === "true") {
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date " + $("#warehouseTransferOutTransactionDate").val(), dtpWarehouseTransferOutTransactionDate);
                } else {
                    alertMessage("Transaction Month Must Between Session Period Month!", dtpWarehouseTransferOutTransactionDate);
                }
                return;
            }

            if (parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())) {
                if ($("#warehouseTransferOutUpdateMode").val() === "true") {
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date " + $("#warehouseTransferOutTransactionDate").val(), dtpWarehouseTransferOutTransactionDate);
                } else {
                    alertMessage("Transaction Year Must Between Session Period Year!", dtpWarehouseTransferOutTransactionDate);
                }
                return;
            }
            //ini ada
        if (txtWarehouseTransferOutDestinationWarehouseCode.val() == txtWarehouseTransferOutSourceWarehouseCode.val()) {
          alertMessage("Source Warehouse Code Tidak Boleh Sama Dengan Destination Warehouse Code !", txtWarehouseTransferOutDestinationWarehouseCode);
          return;
           }

            flagConfirmWarehouseTransferOut = true;
            $("#div-header-whm-transfer-out").block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#warehouseTransferOutItemDetailInputGrid").unblock();
            $("#btnUnConfirmWarehouseTransferOut").css("display", "block");
            $("#btnConfirmWarehouseTransferOut").css("display", "none");
            if($("#warehouseTransferOutUpdateMode").val()=== "true"){
                autoLoadDataWarehouseTransferOut();
            }
        });

        $("#btnUnConfirmWarehouseTransferOut").click(function (ev) {
            var dynamicDialog = $('<div id="conformBox">' +
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                    '</span>Are You Sure to UnConfirm This Item Detail?</div>');

            dynamicDialog.dialog({
                title: "Confirmation:",
                closeOnEscape: false,
                modal: true,
                width: 500,
                resizable: false,
                buttons:
                        [{
                                text: "Yes",
                                click: function () {
                                    $(this).dialog("close");
                                    flagConfirmWarehouseTransferOut = false;
                                    $("#warehouseTransferOutItemDetailInput_grid").jqGrid('clearGridData');
                                    $("#btnUnConfirmWarehouseTransferOut").css("display", "none");
                                    $("#btnConfirmWarehouseTransferOut").css("display", "block");
                                    $("#div-header-whm-transfer-out").unblock();
                                    $("#warehouseTransferOutItemDetailInputGrid").block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                    $("#warehouseTransferOutItemDetailInputGrid").block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                    $("#warehouseTransferOutItemDetailDestinationInputGrid").block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                }
                            },
                            {
                                text: "No",
                                click: function () {
                                    $(this).dialog("close");
                                }
                            }]
            });
        });

        $("#btnWarehouseTransferOutSave").click(function (ev) {

            if (!flagConfirmWarehouseTransferOut) {
                alertMessage("Please Confirm!", $("#btnConfirmWarehouseTransferOut"));
                return;
            }

            if (warehouseTransferOutItemDetail_lastSel !== -1) {
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('saveRow', warehouseTransferOutItemDetail_lastSel);
            }
            
            var listWarehouseTransferOutItemDetail = new Array();
            var selectedRowID = $("#warehouseTransferOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
            var idsSource = jQuery("#warehouseTransferOutItemDetailInput_grid").jqGrid('getDataIDs');

            for (var i = 0; i < idsSource.length; i++) {
                var data = $("#warehouseTransferOutItemDetailInput_grid").jqGrid('getRowData', idsSource[i]);
                
                if(data.warehouseTransferOutItemDetailReasonCode === ""){
                    alertMessage("Reason Detail Can't Empty ");
                    return;
                }
                if(data.warehouseTransferOutItemDetailQuantity > data.warehouseTransferOutItemDetailActualStock){
                    alertMessage("Item Quantity Can't be Greather than Item Stock");
                    $("#" + selectedRowID + "_warehouseTransferOutItemDetailQuantity").attr("style","border:3px solid red");
                    return;
                }
                
                var warehouseTransferOutItemDetail = {
                    itemMaterial        : {
                                            code         : data.warehouseTransferOutItemDetailItemMaterialCode,
                                            inventoryType: data.warehouseTransferOutItemDetailItemMaterialInventoryType
                                          },
                    quantity            : data.warehouseTransferOutItemDetailQuantity,
                    cogsIdr             : data.warehouseTransferOutItemDetailItemMaterialCogsIdr,
                    totalAmount         : data.warehouseTransferOutItemDetailTotalAmount,
                    remark              : data.warehouseTransferOutItemDetailRemark,
                    reason              : {code: data.warehouseTransferOutItemDetailReasonCode},
                    rack                : {code: data.warehouseTransferOutItemDetailRackCode}
                };
                
                listWarehouseTransferOutItemDetail[i] = warehouseTransferOutItemDetail;
            }
            
            formatDateWHTOut();

            var url = "inventory/warehouse-transfer-out-save";
            var params = $("#frmWarehouseTransferOutInput").serialize();
            params += "&listWarehouseTransferOutItemDetailJSON=" + $.toJSON(listWarehouseTransferOutItemDetail);
 
            showLoading();

            $.post(url, params, function (data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateWHTOut();
                    return;
                }

                var dynamicDialog = $('<div id="conformBox">' +
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                        '</span>' + data.message + '<br/>Do You Want Input Other Transaction?</div>');

                dynamicDialog.dialog({
                    title: "Confirmation:",
                    closeOnEscape: false,
                    modal: true,
                    width: 500,
                    resizable: false,
                    buttons:
                            [{
                                    text: "Yes",
                                    click: function () {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "inventory/warehouse-transfer-out-input";
                                        pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_OUT");
                                    }
                                },
                                {
                                    text: "No",
                                    click: function () {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "inventory/warehouse-transfer-out";
                                        pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_OUT");
                                    }
                                }]
                });
            });
        });

        $("#btnWarehouseTransferOutCancel").click(function (ev) {
            var params = "";
            var url = "inventory/warehouse-transfer-out";
            pageLoad(url, params, "#tabmnuWAREHOUSE_TRANSFER_OUT");
        });
        
        $('#warehouseTransferOut_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=warehouseTransferOut&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $("#warehouseTransferOut_btnSourceWarehouse").click(function (ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=warehouseTransferOut&idsubdoc=sourceWarehouse&idtype=Internal", "Search", "scrollbars=1,width=600, height=500");
        });
        $("#warehouseTransferOut_btnDestinationWarehouse").click(function (ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=warehouseTransferOut&idsubdoc=destinationWarehouse&idtype=Internal", "Search", "scrollbars=1,width=600, height=500");
        });
        
        $("#btnWarehouseTransferOutAddDetail").click(function(ev) {
 
            var AddRowCount =parseFloat($("#warehouseTransferOutAddRow").val().replace(/,/g, ""));     
            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    warehouseTransferOutDetailDelete        :"delete",
                    warehouseTransferOutDetailSearch        :"..."
                };
                warehouseTransferOutItemDetail_lastRowId++;
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid("addRowData", warehouseTransferOutItemDetail_lastRowId, defRow);
            }

            $("#warehouseTransferOutAddRow").val("1");
            
        });
        
    });

    function warehouseTransferOutTransactionDateOnChange() {
        if ($("#warehouseTransferOutUpdateMode").val() !== "true") {
            $("#warehouseTransferOutTransactionDate").val(dtpWarehouseTransferOutTransactionDate.val());
        }
    }

    function handlers_input_warehouse_transfer_out() {
        if (dtpWarehouseTransferOutTransactionDate.val() === "") {
            handlersInput(dtpWarehouseTransferOutTransactionDate);
        } else {
            unHandlersInput(dtpWarehouseTransferOutTransactionDate);
        }
        
        if (txtWarehouseTransferOutSourceWarehouseCode.val() === "") {
            handlersInput(txtWarehouseTransferOutSourceWarehouseCode);
        } else {
            unHandlersInput(txtWarehouseTransferOutSourceWarehouseCode);
        }
    }

    function formatDateWHTOut() {
        var transactionDateValue = dtpWarehouseTransferOutTransactionDate.val();
        var transactionDateValuesTemp = transactionDateValue.split(' ');
        var transactionDateValues = transactionDateValuesTemp[0].split('/');
        var transactionDate = transactionDateValues[1] + "/" + transactionDateValues[0] + "/" + transactionDateValues[2] + " " + transactionDateValuesTemp[1];
        dtpWarehouseTransferOutTransactionDate.val(transactionDate);

        var createdDateValue = dtpWarehouseTransferOutCreatedDate.val();
        var createdDateValuesTemp = createdDateValue.split(' ');
        var createdDateValues = createdDateValuesTemp[0].split('/');
        var createdDate = createdDateValues[1] + "/" + createdDateValues[0] + "/" + createdDateValues[2] + " " + createdDateValuesTemp[1];
        dtpWarehouseTransferOutCreatedDate.val(createdDate);
    }

    function clearWarehouseTransferOutItemDetailCogsData(selectedRowID) {
        $("#warehouseTransferOutItemDetailInput_grid").jqGrid("setCell", selectedRowID, "warehouseTransferOutItemDetailItemMaterialName", " ");
        $("#warehouseTransferOutItemDetailInput_grid").jqGrid("setCell", selectedRowID, "warehouseTransferOutItemDetailItemMaterialInventoryType", " ");
        $("#warehouseTransferOutItemDetailInput_grid").jqGrid("setCell", selectedRowID, "warehouseTransferOutItemDetailItemMaterialUnitOfMeasureCode", " ");
    }

    function warehouseTransferOutDetailInputGrid_ItemDelete_OnClick() {
        var selectedRowID = $("#warehouseTransferOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if (selectedRowID === null) {
            alertMessage("Please Select Row");
            return;
        }
        $("#warehouseTransferOutItemDetailInput_grid").jqGrid('delRowData', selectedRowID);
    }
    
    function warehouseTransferOutDetailInputGrid_SearchItem_OnClick(){
        window.open("./pages/search/search-item-current-stock-by-wht.jsp?iddoc=warehouseTransferOutItemDetail&idwarehouse="+ $("#warehouseTransferOut\\.sourceWarehouse\\.code").val() +"&idsubdoc=Item&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function warehouseTransferOutDetailInputGrid_SearchReason_OnClick(){
        window.open("./pages/search/search-reason.jsp?iddoc=warehouseTransferOutItemDetail&idsubdoc=Reason&type=grid&idivt=Inventory&modulecode=003_IVT_WAREHOUSE_TRANSFER_OUT","Search", "scrollbars=1,width=600, height=500");
    }
    
    function warehouseTransferOutDetailInputGrid_ItemDelete_OnClick(){
        var selectedRowID = $("#warehouseTransferOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if (selectedRowID === null) {
            alertMessage("Please Select Row");
            return;
        }          
        $("#warehouseTransferOutItemDetailInput_grid").jqGrid('delRowData',selectedRowID);
    }
    
    function warehouseTransferOutCalculateDetail() {
        var selectedRowID = $("#warehouseTransferOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var data=$("#warehouseTransferOutItemDetailInput_grid").jqGrid('getRowData',selectedRowID);
                        
        var qty = $("#" + selectedRowID + "_warehouseTransferOutItemDetailQuantity").val();
        var cogsIdr = data.warehouseTransferOutItemDetailItemMaterialCogsIdr;
        var totalAmount = (parseFloat(qty) * parseFloat(cogsIdr));

        $("#warehouseTransferOutItemDetailInput_grid").jqGrid("setCell", selectedRowID, "warehouseTransferOutItemDetailTotalAmount", totalAmount);

        $("#"+selectedRowID+"_warehouseTransferOutItemDetailQuantity").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
    }
</script>

<b>WAREHOUSE TRANSFER OUT</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlWarehouseTransferOutItemDetailCogsInput" action="" />

<div id="warehouseTransferOutInput" class="content ui-widget">
    <s:form id="frmWarehouseTransferOutInput">
        <div id="div-header-whm-transfer-out">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>WHTO No</B></td>
                    <td>
                        <s:textfield id="warehouseTransferOut.code" name="warehouseTransferOut.code" size="30" readonly="true" ></s:textfield>
                        <s:textfield id="warehouseTransferOutUpdateMode" name="warehouseTransferOutUpdateMode" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Transaction Date *</B></td>
                        <td>
                        <sj:datepicker id="warehouseTransferOut.transactionDate" name="warehouseTransferOut.transactionDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" onchange="warehouseTransferOutTransactionDateOnChange()"></sj:datepicker>
                        <sj:datepicker disabled="true" id="warehouseTransferOutTransactionDate" name="warehouseTransferOutTransactionDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" cssStyle="display:none"></sj:datepicker>
                        <sj:datepicker disabled="true" id="warehouseTransferOutTransactionDateFirstSession" name="warehouseTransferOutTransactionDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                        <sj:datepicker disabled="true" id="warehouseTransferOutTransactionDateLastSession" name="warehouseTransferOutTransactionDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Branch *</B></td>
                        <td colspan="2">
                            <script type = "text/javascript">

                                txtWarehouseTransferOutBranchCode.change(function(ev) {

                                    if(txtWarehouseTransferOutBranchCode.val()===""){
                                        txtWarehouseTransferOutBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get-by-user";
                                    var params = "branch.code=" + txtWarehouseTransferOutBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtWarehouseTransferOutBranchCode.val(data.branchTemp.code);
                                            txtWarehouseTransferOutBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtWarehouseTransferOutBranchCode);
                                            txtWarehouseTransferOutBranchCode.val("");
                                            txtWarehouseTransferOutBranchName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="warehouseTransferOut.branch.code" name="warehouseTransferOut.branch.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                                <sj:a id="warehouseTransferOut_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-adjustment-out"/></sj:a>
                            </div>
                            <s:textfield id="warehouseTransferOut.branch.name" name="warehouseTransferOut.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Source Warehouse *</B></td>
                        <td colspan="2">
                            <script type = "text/javascript">

                                txtWarehouseTransferOutSourceWarehouseCode.change(function (ev) {

                                    if (txtWarehouseTransferOutSourceWarehouseCode.val() === "") {
                                        txtWarehouseTransferOutSourceWarehouseName.val("");
                                        return;
                                    }
                                    var url = "master/warehouse-get";
                                    var params = "warehouse.code=" + txtWarehouseTransferOutSourceWarehouseCode.val();
                                    params += "&warehouse.activeStatus=TRUE";
                                    params += "&warehouse.warehouseType=Internal";

                                    $.post(url, params, function (result) {
                                        var data = (result);
                                        if (data.warehouseTemp) {
                                            txtWarehouseTransferOutSourceWarehouseCode.val(data.warehouseTemp.code);
                                            txtWarehouseTransferOutSourceWarehouseName.val(data.warehouseTemp.name);
                                        } else {
                                            alertMessage("Source Warehouse Not Found!", txtWarehouseTransferOutSourceWarehouseCode);
                                            txtWarehouseTransferOutSourceWarehouseCode.val("");
                                            txtWarehouseTransferOutSourceWarehouseName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header">
                            <s:textfield id="warehouseTransferOut.sourceWarehouse.code" name="warehouseTransferOut.sourceWarehouse.code" size="20" required="true" cssClass="required" ></s:textfield>
                            <sj:a id="warehouseTransferOut_btnSourceWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                        <s:textfield id="warehouseTransferOut.sourceWarehouse.name" name="warehouseTransferOut.sourceWarehouse.name" cssStyle="width:49%" readonly="true" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Destination Warehouse *</B></td>
                        <td colspan="2">
                            <script type = "text/javascript">

                                txtWarehouseTransferOutDestinationWarehouseCode.change(function (ev) {

                                    if (txtWarehouseTransferOutDestinationWarehouseCode.val() === "") {
                                        txtWarehouseTransferOutDestinationWarehouseName.val("");
                                        return;
                                    }
                                    var url = "master/warehouse-get";
                                    var params = "warehouse.code=" + txtWarehouseTransferOutDestinationWarehouseCode.val();
                                    params += "&warehouse.activeStatus=TRUE";
                                    params += "&warehouse.warehouseType=Internal";

                                    $.post(url, params, function (result) {
                                        var data = (result);
                                        if (data.warehouseTemp) {
                                            txtWarehouseTransferOutDestinationWarehouseCode.val(data.warehouseTemp.code);
                                            txtWarehouseTransferOutDestinationWarehouseName.val(data.warehouseTemp.name);
                                        } else {
                                            alertMessage("Destination Warehouse Not Found!", txtWarehouseTransferOutDestinationWarehouseCode);
                                            txtWarehouseTransferOutDestinationWarehouseCode.val("");
                                            txtWarehouseTransferOutDestinationWarehouseName.val("");
                                        }
                                    });
                                    
                                });
                            </script>
                            <div class="searchbox ui-widget-header">
                            <s:textfield id="warehouseTransferOut.destinationWarehouse.code" name="warehouseTransferOut.destinationWarehouse.code" size="20" required="true" cssClass="required" ></s:textfield>
                            <sj:a id="warehouseTransferOut_btnDestinationWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                        <s:textfield id="warehouseTransferOut.destinationWarehouse.name" name="warehouseTransferOut.destinationWarehouse.name" cssStyle="width:49%" readonly="true" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Ref No</td>
                        <td><s:textfield id="warehouseTransferOut.refNo" name="warehouseTransferOut.refNo" size="30" ></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td><s:textarea id="warehouseTransferOut.remark" name="warehouseTransferOut.remark"  rows="3" cols="70" ></s:textarea> </td>
                    </tr>
                    <tr hidden="true">
                        <td>
                        <s:textfield id="warehouseTransferOut.createdBy" name="warehouseTransferOut.createdBy" key="warehouseTransferOut.createdBy" readonly="true" size="22"></s:textfield>
                        <sj:datepicker id="warehouseTransferOut.createdDate" name="warehouseTransferOut.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                        <s:textfield id="warehouseTransferOutTemp.createdDateTemp" name="warehouseTransferOutTemp.createdDateTemp" size="20"></s:textfield>
                        </td>
                    </tr>
                </table>
            </div>

            <br class="spacer" />


            <table>
                <tr>
                    <td colspan="2">
                    <sj:a href="#" id="btnConfirmWarehouseTransferOut" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmWarehouseTransferOut" button="true">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>

        <br class="spacer" />

        <div id="warehouseTransferOutItemDetailInputGrid">
            <sjg:grid
                id="warehouseTransferOutItemDetailInput_grid"
                caption="WAREHOUSE TRANSFER OUT ITEM DETAIL SOURCE"
                dataType="local"                    
                pager="false"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listWarehouseTransferOutItemDetailTemp"
                rowList="10,20,30"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuWarehouseTransferOut').width()"
                editinline="true"
                editurl="%{remotedetailurlWarehouseTransferOutItemDetailCogsInput}"
                onSelectRowTopics="warehouseTransferOutItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetail" index = "warehouseTransferOutItemDetail" key = "warehouseTransferOutItemDetail" 
                    title = "" width = "150" edittype="text" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="warehouseTransferOutDetailItemDelete" index="warehouseTransferOutDetailItemDelete" title="" width="50" align="centre"
                    editable="true" edittype="button"
                    editoptions="{onClick:'warehouseTransferOutDetailInputGrid_ItemDelete_OnClick()', value:'delete'}"
                />
                 <sjg:gridColumn
                    name="warehouseTransferOutDetailItemSearch" index="warehouseTransferOutDetailItemSearch" title="" width="25" align="centre"
                    editable="true" dataType="html" edittype="button"  
                    editoptions="{onClick:'warehouseTransferOutDetailInputGrid_SearchItem_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailItemMaterialCode" index = "warehouseTransferOutItemDetailItemMaterialCode" key = "warehouseTransferOutItemDetailItemMaterialCode" 
                    title = "Item Code *" width = "150" edittype="text" editable="true"
                    editoptions="{onChange:'onChangeWarehouseTransferOutDetailItem()'}" 
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailItemMaterialName" index = "warehouseTransferOutItemDetailItemMaterialName" key = "warehouseTransferOutItemDetailItemMaterialName" 
                    title = "Item Name" width = "250"
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailItemMaterialInventoryType" index = "warehouseTransferOutItemDetailItemMaterialInventoryType" key = "warehouseTransferOutItemDetailItemMaterialInventoryType" 
                    title = "InventoryType" width = "100"
                    />
                <sjg:gridColumn
                        name="warehouseTransferOutDetailReasonSearch" index="warehouseTransferOutDetailReasonSearch" title="" width="25" align="center"
                        editable="true" dataType="html" edittype="button"  
                        editoptions="{onClick:'warehouseTransferOutDetailInputGrid_SearchReason_OnClick()', value:'...'}"
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailReasonCode" index = "warehouseTransferOutItemDetailReasonCode" key = "warehouseTransferOutItemDetailReasonCode" 
                    title = "Reason Code" width = "150" edittype="text" editable="true"
                    editoptions="{onChange:'onChangeWarehouseTransferOutDetailReason()'}" 
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailReasonName" index = "warehouseTransferOutItemDetailReasonName" key = "warehouseTransferOutItemDetailReasonName" 
                    title = "Reason Name" width = "250"
                    />
                <sjg:gridColumn
                    name="warehouseTransferOutItemDetailActualStock" index="warehouseTransferOutItemDetailActualStock" key="warehouseTransferOutItemDetailActualStock" 
                    title="ActualStock" width="80" align="right" edittype="text" 
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                <sjg:gridColumn
                    name="warehouseTransferOutItemDetailQuantity" index="warehouseTransferOutItemDetailQuantity" key="warehouseTransferOutItemDetailQuantity" id="warehouseTransferOutItemDetailQuantity"
                    title="Quantity *" width="80" align="right" edittype="text" editable="true"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onClick:'this.setSelectionRange(0, this.value.length)',onKeyUp:'warehouseTransferOutCalculateDetail()'}"
                    />
                <sjg:gridColumn
                    name="warehouseTransferOutItemDetailItemMaterialCogsIdr" index="warehouseTransferOutItemDetailItemMaterialCogsIdr" key="warehouseTransferOutItemDetailItemMaterialCogsIdr" 
                    title="Cogs Idr" width="80" align="right" edittype="text" hidden="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:4}"
                    />
                <sjg:gridColumn
                        name="warehouseTransferOutItemDetailTotalAmount" index="warehouseTransferOutItemDetailTotalAmount" key="warehouseTransferOutItemDetailTotalAmount" 
                        title="TotalAmount" width="80" align="right" edittype="text" editable="false" hidden="true"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:4}"
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailItemMaterialUnitOfMeasureCode" index="warehouseTransferOutItemDetailItemMaterialUnitOfMeasureCode" key="warehouseTransferOutItemDetailItemMaterialUnitOfMeasureCode" title="Unit" width="100" edittype="text"
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailRackCode" index="warehouseTransferOutItemDetailRackCode" key="warehouseTransferOutItemDetailRackCode" title="Rack Code" width="150" edittype="text"
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailRackName" index="warehouseTransferOutItemDetailRackName" key="warehouseTransferOutItemDetailRackName" title="Rack Name" width="150" edittype="text"
                    />
                <sjg:gridColumn
                    name = "warehouseTransferOutItemDetailRemark" index="warehouseTransferOutItemDetailRemark" key="warehouseTransferOutItemDetailRemark" title="Remark" width="250" edittype="text" editable="true"
                />
            </sjg:grid >
        </div>
        
        <table>
            <tr>
                <td>
                    <s:textfield  id="warehouseTransferOutAddRow" name="warehouseTransferOutAddRow"  size="10" value="1" style="text-align: right;"></s:textfield>
                    <sj:a href="#" id="btnWarehouseTransferOutAddDetail" button="true" style="width: 60px">Add</sj:a>
                </td>
            </tr>
        </table>

        <br class="spacer" />
        <br class="spacer" />

        <table width="100%">
            <tr>
                <td>      
                    <sj:a href="#" id="btnWarehouseTransferOutSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnWarehouseTransferOutCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>

    </s:form>
</div>
<script>
    function autoLoadDataWarehouseTransferOut() {
        var url = "inventory/warehouse-transfer-out-item-detail-data";
        var params = "warehouseTransferOut.code=" + txtWarehouseTransferOutCode.val();

        showLoading();

        $.post(url, params, function (data) {
            $("#warehouseTransferOutItemDetailInput_grid").jqGrid("clearGridData");
            warehouseTransferOutItemDetail_lastRowId = 0;
            for (var i = 0; i < data.listWarehouseTransferOutItemDetailTemp.length; i++) {
                                    
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid("addRowData", warehouseTransferOutItemDetail_lastRowId, data.listWarehouseTransferOutItemDetailTemp[i]);
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('setRowData', warehouseTransferOutItemDetail_lastRowId, {
                    warehouseTransferOutDetailItemDelete                        : "delete",
                    warehouseTransferOutDetailItemSearch                        : "...",
                    warehouseTransferOutItemDetailItemMaterialCode              : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialCode,
                    warehouseTransferOutItemDetailItemMaterialName              : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialName,
                    warehouseTransferOutItemDetailItemMaterialInventoryType     : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialInventoryType,
                    warehouseTransferOutDetailReasonSearch                      : "...",
                    warehouseTransferOutItemDetailReasonCode                    : data.listWarehouseTransferOutItemDetailTemp[i].reasonCode,
                    warehouseTransferOutItemDetailReasonName                    : data.listWarehouseTransferOutItemDetailTemp[i].reasonName,
                    warehouseTransferOutItemDetailQuantity                      : data.listWarehouseTransferOutItemDetailTemp[i].quantity,
                    warehouseTransferOutItemDetailItemMaterialCogsIdr           : data.listWarehouseTransferOutItemDetailTemp[i].cogsIdr,
                    warehouseTransferOutItemDetailTotalAmount                   : data.listWarehouseTransferOutItemDetailTemp[i].totalAmount,
                    warehouseTransferOutItemDetailItemMaterialUnitOfMeasureCode : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialUnitOfMeasureCode,
                    warehouseTransferOutItemDetailRackCode                      : data.listWarehouseTransferOutItemDetailTemp[i].rackCode,
                    warehouseTransferOutItemDetailRackName                      : data.listWarehouseTransferOutItemDetailTemp[i].rackName,
                    warehouseTransferOutItemDetailActualStock                   : data.listWarehouseTransferOutItemDetailTemp[i].actualStock,
                    warehouseTransferOutItemDetailRemark                        : data.listWarehouseTransferOutItemDetailTemp[i].remark
                });
                warehouseTransferOutItemDetail_lastRowId++;
            }
            closeLoading();
        });
    }

    function generateDataWarehouseTransferOutSource() {

        if (warehouseTransferOutItemDetail_lastSel !== -1) {
            $('#warehouseTransferOutItemDetailInput_grid').jqGrid("saveRow", warehouseTransferOutItemDetail_lastSel);
        }

        var ids = jQuery("#warehouseTransferOutItemDetailInput_grid").jqGrid('getDataIDs');
        var listInventoryActualStock = new Array();
        var warehouseCode = txtWarehouseTransferOutSourceWarehouseCode.val();
        var transactionCode = txtWarehouseTransferOutCode.val();

        var x = -1;
        for (var i = 0; i < ids.length; i++) {
            var data = $("#warehouseTransferOutItemDetailInput_grid").jqGrid('getRowData', ids[i]);

            if (txtWarehouseTransferOutCode.val() !== "AUTO") {
                x++;
                var inventoryActualStock = {
                    branchCode          : branchCode,
                    transactionCode     : transactionCode,
                    warehouse           : {code: warehouseCode},
                    itemMaterial        : {code: data.warehouseTransferOutItemDetailItemMaterialCode},
                    bookedStock         : data.warehouseTransferOutItemDetailQuantity,
                    reason              : {code: data.warehouseTransferOutItemDetailReasonCode,
                    name                : data.warehouseTransferOutItemDetailReasonName},
                    remark              : data.warehouseTransferOutItemDetailRemark
                };
                listInventoryActualStock[x] = inventoryActualStock;
            } else {
                if (parseFloat(data.warehouseTransferOutItemDetailQuantity) > parseFloat(data.warehouseTransferOutItemDetailQuantityBalance)) {
                    alertMessage("WH PLT Quantity is greater than Balance Quantity!");
                    return;
                }

                if (parseFloat(data.warehouseTransferOutItemDetailQuantity) <= parseFloat(data.warehouseTransferOutItemDetailQuantityBalance)) {
                    x++;
                    var inventoryActualStock = {
                        branchCode          : branchCode,
                        transactionCode     : transactionCode,
                        warehouse           : {code: warehouseCode},
                        itemMaterial        : {code: data.warehouseTransferOutItemDetailItemMaterialCode},
                        bookedStock         : data.warehouseTransferOutItemDetailQuantity,
                        reason              : {code: data.warehouseTransferOutItemDetailReasonCode,
                        name                : data.warehouseTransferOutItemDetailReasonName},
                        remark              : data.warehouseTransferOutItemDetailRemark
                    };
                    listInventoryActualStock[x] = inventoryActualStock;
                }
            }
        }

        var url = "master/item-current-stock-picking-list-whm-item-data";
        var params = "listInventoryActualStockJSON=" + $.toJSON(listInventoryActualStock);

        $("#warehouseTransferOutItemDetailInput_grid").jqGrid("clearGridData");

        showLoading();
        $.post(url, params, function (data) {
            closeLoading();
            if (data.error) {
                $("#btnUnConfirmWarehouseTransferOutDetail").css("display", "none");
                $("#btnConfirmWarehouseTransferOutDetail").css("display", "block");
                alertMessage(data.errorMessage);
                return;
            }

            warehouseTransferOutItemDetail_lastRowId = 0;

            for (var i = 0; i < data.listIvtActualStock.length; i++) {

                if (data.listIvtActualStock[i].quantity > 0) {
                    warehouseTransferOutItemDetail_lastRowId++;

                    var itemDate = formatDateRemoveT(data.listIvtActualStock[i].itemDate, false);
                    var productionDate = formatDateRemoveT(data.listIvtActualStock[i].productionDate, false);
                    var expiredDate = formatDateRemoveT(data.listIvtActualStock[i].expiredDate, false);

                    $("#warehouseTransferOutItemDetailInput_grid").jqGrid("addRowData", warehouseTransferOutItemDetail_lastRowId, data.listIvtActualStock[i]);
                    $("#warehouseTransferOutItemDetailInput_grid").jqGrid('setRowData', warehouseTransferOutItemDetail_lastRowId, {
                        warehouseTransferOutItemDetailItemMaterialCode                  : data.listIvtActualStock[i].itemMaterialCode,
                        warehouseTransferOutItemDetailItemMaterialName                  : data.listIvtActualStock[i].itemMaterialName,
                        warehouseTransferOutItemDetailItemAlias                         : data.listIvtActualStock[i].itemAlias,
                        warehouseTransferOutItemDetailItemMaterialInventoryType         : data.listIvtActualStock[i].itemMaterialInventoryType,
                        warehouseTransferOutItemDetailItemBrandCode                     : data.listIvtActualStock[i].itemBrandCode,
                        warehouseTransferOutItemDetailItemBrandName                     : data.listIvtActualStock[i].itemBrandName,
                        warehouseTransferOutItemDetailLotNo                             : data.listIvtActualStock[i].lotNo,
                        warehouseTransferOutItemDetailBatchNo                           : data.listIvtActualStock[i].batchNo,
                        warehouseTransferOutItemDetailInTransactionNo                   : data.listIvtActualStock[i].inTransactionNo,
                        warehouseTransferOutItemDetailInDocumentType                    : data.listIvtActualStock[i].inDocumentType,
                        warehouseTransferOutItemDetailItemMaterialCogsIdr               : data.listIvtActualStock[i].COGSIDR,
                        warehouseTransferOutItemDetailItemDate                          : itemDate,
                        warehouseTransferOutItemDetailProductionDate                    : productionDate,
                        warehouseTransferOutItemDetailExpiredDate                       : expiredDate,
                        warehouseTransferOutItemDetailExpiredAge                        : data.listIvtActualStock[i].expiredAge,
                        warehouseTransferOutItemDetailQuantity                          : data.listIvtActualStock[i].quantity,
                        warehouseTransferOutItemDetailItemMaterialUnitOfMeasureCode     : data.listIvtActualStock[i].inUnitOfMeasureCode,
                        warehouseTransferOutItemDetailRackCode                          : data.listIvtActualStock[i].rackCode,
                        warehouseTransferOutItemDetailRackName                          : data.listIvtActualStock[i].rackName,
                        warehouseTransferOutItemDetailActualStock                       : data.listIvtActualStock[i].actualStock,
                        warehouseTransferOutItemDetailReasonCode                        : data.listIvtActualStock[i].reasonCode,
                        warehouseTransferOutItemDetailReasonName                        : data.listIvtActualStock[i].reasonName,
                        warehouseTransferOutItemDetailRemark                            : data.listIvtActualStock[i].remark
                    });
                }
            }
        });
    }

    function autoLoadDataWarehouseTransferOutSource() {
        var url = "inventory/warehouse-transfer-out-item-detail-data";
        var params = "warehouseTransferOut.code=" + txtWarehouseTransferOutCode.val();

        showLoading();

        $.post(url, params, function (data) {
            warehouseTransferOutItemDetail_lastRowId = 0;
            for (var i = 0; i < data.listWarehouseTransferOutItemDetailTemp.length; i++) {

                var itemDate = formatDateRemoveT(data.listWarehouseTransferOutItemDetailTemp[i].itemDate, false);
                var productionDate = formatDateRemoveT(data.listWarehouseTransferOutItemDetailTemp[i].productionDate, false);
                var expiredDate = formatDateRemoveT(data.listWarehouseTransferOutItemDetailTemp[i].expiredDate, false);

                var quantity = String(data.listWarehouseTransferOutItemDetailTemp[i].quantity).replace(/,/g, "");
                var cogs = String(data.listWarehouseTransferOutItemDetailTemp[i].cogsIdr).replace(/,/g, "");

                $("#warehouseTransferOutItemDetailInput_grid").jqGrid("addRowData", warehouseTransferOutItemDetail_lastRowId, data.listWarehouseTransferOutItemDetailTemp[i]);
                $("#warehouseTransferOutItemDetailInput_grid").jqGrid('setRowData', warehouseTransferOutItemDetail_lastRowId, {
                    warehouseTransferOutItemDetailItemDelete                        : "delete",
                    warehouseTransferOutItemDetailItemSearch                        : "...",
                    warehouseTransferOutItemDetailItemMaterialCode                  : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialCode,
                    warehouseTransferOutItemDetailItemMaterialName                  : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialName,
                    warehouseTransferOutItemDetailItemMaterialInventoryType         : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialinventoryType,
                    warehouseTransferOutItemDetailReasonSearch                      : "...",
                    warehouseTransferOutItemDetailReasonCode                        : data.listWarehouseTransferOutItemDetailTemp[i].reasonCode,
                    warehouseTransferOutItemDetailReasonName                        : data.listWarehouseTransferOutItemDetailTemp[i].reasonName,
                    warehouseTransferOutItemDetailQuantity                          : quantity,
                    warehouseTransferOutItemDetailItemMaterialCogsIdr               : cogs,
                    warehouseTransferOutItemDetailItemMaterialUnitOfMeasureCode     : data.listWarehouseTransferOutItemDetailTemp[i].itemMaterialUnitOfMeasureCode,
                    warehouseTransferOutItemDetailRemark                            : data.listWarehouseTransferOutItemDetailTemp[i].remark,
                    warehouseTransferOutItemDetailInTransactionNo                   : data.listWarehouseTransferOutItemDetailTemp[i].inTransactionNo,
                    warehouseTransferOutItemDetailInDocumentType                    : data.listWarehouseTransferOutItemDetailTemp[i].inDocumentType,
                    warehouseTransferOutItemDetailLotNo                             : data.listWarehouseTransferOutItemDetailTemp[i].lotNo,
                    warehouseTransferOutItemDetailBatchNo                           : data.listWarehouseTransferOutItemDetailTemp[i].batchNo,
                    warehouseTransferOutItemDetailProductionDate                    : productionDate,
                    warehouseTransferOutItemDetailExpiredDate                       : expiredDate,
                    warehouseTransferOutItemDetailRackCode                          : data.listWarehouseTransferOutItemDetailTemp[i].rackCode,
                    warehouseTransferOutItemDetailRackName                          : data.listWarehouseTransferOutItemDetailTemp[i].rackName,
                    warehouseTransferOutItemDetailActualStock                       : data.listWarehouseTransferOutItemDetailTemp[i].actualStock,
                    warehouseTransferOutItemDetailItemDate                          : itemDate,
                    warehouseTransferOutItemDetailItemBrandCode                     : data.listWarehouseTransferOutItemDetailTemp[i].itemBrandCode,
                    warehouseTransferOutItemDetailItemBrandName                     : data.listWarehouseTransferOutItemDetailTemp[i].itemBrandName
                });
                warehouseTransferOutItemDetail_lastRowId++;
            }
            closeLoading();
        });
    }

</script>
