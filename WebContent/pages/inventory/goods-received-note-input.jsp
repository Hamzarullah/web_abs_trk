<%-- 
    Document   : goods-received-note-local-input
    Created on : Jun 28, 2020, 11:32:04 PM
    Author     : Rayis
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="../../js/jquery.layout.js"></script>
<script type="text/javascript" src="../../js/jquery_ready.js"></script>
<script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
<script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
   #goodsReceivedNotePurchaseOrderDetailInput_grid_pager_center,#goodsReceivedNoteItemDetailInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
    
    var goodsReceivedNotePurchaseOrderDetailInput_lastSel = -1;
    var goodsReceivedNotePurchaseOrderDetailLastRowId = 0;
    var goodsReceivedNoteItemDetail_lastSel = -1, goodsReceivedNoteItemDetail_lastRowId=0;
    
    var
        txtGoodsReceivedNoteCode = $("#goodsReceivedNote\\.code"),
        dtpGoodsReceivedNoteTransactionDate = $("#goodsReceivedNote\\.transactionDate"),
        txtGoodsReceivedNotePurchaseOrderCode = $("#goodsReceivedNote\\.purchaseOrder\\.code"),
        txtGoodsReceivedNoteExchangeRate = $("#goodsReceivedNote\\.exchangeRate"),
        txtGoodsReceivedNoteReceivedBy = $("#goodsReceivedNote\\.receivedBy"),
        txtGoodsReceivedNoteVendorDo = $("#goodsReceivedNote\\.vendorDeliveryNoteNo"),
        txtGoodsReceivedNoteWarehouseCode = $("#goodsReceivedNote\\.warehouse\\.code"),
        txtGoodsReceivedNoteWarehouseName = $("#goodsReceivedNote\\.warehouse\\.name"),
        txtGoodsReceivedNoteWarehouseDockInCode = $("#goodsReceivedNote\\.warehouse\\.dockInCode"),
        txtGoodsReceivedNoteWarehouseDockInName = $("#goodsReceivedNote\\.warehouse\\.dockInName"),
        txtGoodsReceivedNoteExpeditionCode = $("#goodsReceivedNote\\.expedition\\.code"),
        txtGoodsReceivedNoteExpeditionName = $("#goodsReceivedNote\\.expedition\\.name");

    $(document).ready(function () {

        hoverButton();
        flagConfirmGoodsReceivedNote = false;
        
        if($("#enumGoodsReceivedNoteActivity").val() === "UPDATE"){
            goodsReceivedNoteValidateExchangeRate($("#goodsReceivedNote\\.currency\\.code").val());
            txtGoodsReceivedNoteWarehouseDockInName.val($("#rackDockInName").val());
        }
        
         $.subscribe("goodsReceivedNotePurchaseOrderDetailInput_grid_onSelect", function () {
            var selectedRowID = $("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");
            if (selectedRowID !== goodsReceivedNotePurchaseOrderDetailInput_lastSel) {
                $('#goodsReceivedNotePurchaseOrderDetailInput_grid').jqGrid("saveRow", goodsReceivedNotePurchaseOrderDetailInput_lastSel);
                $('#goodsReceivedNotePurchaseOrderDetailInput_grid').jqGrid("editRow", selectedRowID, true);
                goodsReceivedNotePurchaseOrderDetailInput_lastSel = selectedRowID;
            } else {
                $('#goodsReceivedNotePurchaseOrderDetailInput_grid').jqGrid("saveRow", selectedRowID);
            }
        });
        
        $.subscribe("goodsReceivedNoteItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==goodsReceivedNoteItemDetail_lastSel) {
                $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('saveRow',goodsReceivedNoteItemDetail_lastSel); 
                $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                goodsReceivedNoteItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        $("#btnUnConfirmGoodsReceivedNote").css("display", "none");
        $("#btnConfirmGoodsReceivedNote").css("display", "block");
        $("#btnSearchItemMaterial").css("display", "none");
        $('#div-header-goods-received-note').unblock();
        $('#goodsReceivedNotePurchaseOrderDetailInputGrid').block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmGoodsReceivedNote").click(function (ev) {
        
            if (!$("#frmGoodsReceivedNoteInput").valid()) {
                ev.preventDefault();
            }
            
            if (txtGoodsReceivedNotePurchaseOrderCode.val() === "") {
                alertMessage("PO No Cannot be Empty!",txtGoodsReceivedNotePurchaseOrderCode);
                return;
            }
            
            if (txtGoodsReceivedNoteVendorDo.val() === "") {
                alertMessage("Vendor DO Cannot be Empty!",txtGoodsReceivedNoteVendorDo);
                return;
            }
            
            if (txtGoodsReceivedNoteWarehouseCode.val() === "") {
                alertMessage("Warehouse Cannot be Empty!",txtGoodsReceivedNoteWarehouseCode);
                return;
            }
            
            if ($("#goodsReceivedNote\\.receivedBy").val() === "") {
                alertMessage("Received By Cannot be Empty!",$("#goodsReceivedNote\\.receivedBy"));
                return;
            }
            
            var transactionDate=$("#goodsReceivedNote\\.transactionDate").val();
            var dateFirstSession=new Date($("#goodsReceivedNoteTransactionDateFirstSession").val());
            var dateLastSession=new Date($("#goodsReceivedNoteTransactionDateLastSession").val());
            var dateValues= transactionDate.split('/'); 
            var tahun = dateValues[2].split(' '); 
            var transactionDateValue =new Date(dateValues[1]+"/"+dateValues[0]+"/"+tahun[0]);

            if( transactionDateValue < dateFirstSession || transactionDateValue > dateLastSession){
                alert("Transaction date must between sesion period");
                return;
            }
            var date = $("#goodsReceivedNote\\.transactionDate").val().split("/");
            var month = date[1];
            var year = date[2].split(" ");
            if(parseFloat(month) != parseFloat($("#panel_periodMonth").val())){
                alert("Transaction Date Not In Periode Setup");
                return;
            }

            if(parseFloat(year) != parseFloat($("#panel_periodYear").val())){
                alert("Transaction Date Not In Periode Setup");
                return;
            }
                
            var date1 = dtpGoodsReceivedNoteTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#goodsReceivedNoteTransactionDateTemp").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
             
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#enumGoodsReceivedNoteActivity").val()==="true"){
                    alertEx("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#goodsReceivedNoteTransactionDateTemp").val(),dtpGoodsReceivedNoteTransactionDate);
                }else{
                    alertEx("Transaction Month Must Between Session Period Month!",dtpGoodsReceivedNoteTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#enumGoodsReceivedNoteActivity").val()==="true"){
                    alertEx("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#purchaseOrderTransactionDateTemp").val(),dtpGoodsReceivedNoteTransactionDate);
                }else{
                    alertEx("Transaction Year Must Between Session Period Year!",dtpGoodsReceivedNoteTransactionDate);
                }
                return;
            }
            
            flagConfirmGoodsReceivedNote=true;
            
            $("#btnConfirmGoodsReceivedNote").css("display", "none");
            $("#btnUnConfirmGoodsReceivedNote").css("display", "block");
            $("#btnSearchItemMaterial").css("display", "block");
            $('#div-header-goods-received-note').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#goodsReceivedNotePurchaseOrderDetailInputGrid').unblock();
            
            
            
            if($("#enumGoodsReceivedNoteActivity").val() === "UPDATE"){
                autoLoadDataGoodsReceivedNoteItemDetailUpdate();
            }else{
                loadPurchaseOrderDetailGrn();
            }
            
        });
        
        $("#btnUnConfirmGoodsReceivedNote").click(function (ev) {
            var dynamicDialog = $('<div id="conformBox">' +
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
            var rows = jQuery("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid('getGridParam', 'records');
            if (rows < 1) {
                flagConfirmGoodsReceivedNote = false;
                $("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid('clearGridData');
                $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('clearGridData');
                $("#goodsReceivedNoteSerialNolInput_grid").jqGrid('clearGridData');
                $("#btnUnConfirmGoodsReceivedNote").css("display", "none");
                $("#btnConfirmGoodsReceivedNote").css("display", "block");
                $("#btnSearchItemMaterial").css("display", "none");
                $('#div-header-goods-received-note').unblock();
                $('#goodsReceivedNotePurchaseOrderDetailInputGrid').block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
                return;
            }

            dynamicDialog.dialog({
                title           : "Confirmation:",
                closeOnEscape   : false,
                modal           : true,
                width           : 500,
                resizable       : false,
                buttons         :
                                [{
                                    text: "Yes",
                                    click: function () {
                                        $(this).dialog("close");
                                        flagConfirmGoodsReceivedNote = false;
                                        $("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid('clearGridData');
                                        $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('clearGridData');
                                        $("#goodsReceivedNoteSerialNolInput_grid").jqGrid('clearGridData');
                                        $("#btnUnConfirmGoodsReceivedNote").css("display", "none");
                                        $("#btnConfirmGoodsReceivedNote").css("display", "block");
                                        $("#btnSearchItemMaterial").css("display", "none");
                                        $('#div-header-goods-received-note').unblock();
                                        $('#goodsReceivedNotePurchaseOrderDetailInputGrid').block({message: null, overlayCSS: {backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $('#btnCopyItemMaterial').click(function(ev){
           $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('clearGridData');
            
            if(goodsReceivedNotePurchaseOrderDetailInput_lastSel !== -1) {
                $('#goodsReceivedNotePurchaseOrderDetailInput_grid').jqGrid("saveRow",goodsReceivedNotePurchaseOrderDetailInput_lastSel); 
            }
            
            var ids = jQuery("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid('getRowData',ids[i]);
                if($("input:checkbox[id='jqg_goodsReceivedNotePurchaseOrderDetailInput_grid_"+ids[i]+"']").is(":checked")){
                    var defRow = {
                        goodsReceivedNoteItemDetailDelete                           : "delete",
                        goodsReceivedNoteItemDetailPurchaseOrderDetailCode          : data.goodsReceivedNotePurchaseOrderDetailPurchaseOrderDetailCode,
                        goodsReceivedNoteItemDetailPurchaseRequestCode              : data.goodsReceivedNotePurchaseOrderDetailPurchaseRequestCode,
                        goodsReceivedNoteItemDetailItemMaterialCode                 : data.goodsReceivedNotePurchaseOrderDetailItemMaterialCode,
                        goodsReceivedNoteItemDetailItemMaterialName                 : data.goodsReceivedNotePurchaseOrderDetailItemMaterialName,
                        goodsReceivedNoteItemDetailItemAlias                        : data.goodsReceivedNotePurchaseOrderDetailItemAlias,
                        goodsReceivedNoteItemDetailPODQuantity                      : data.goodsReceivedNotePurchaseOrderDetailQuantity,
                        goodsReceivedNoteItemDetailReceivedQuantity                 : data.goodsReceivedNotePurchaseOrderDetailReceivedQuantity,
                        goodsReceivedNoteItemDetailPrice                            : data.goodsReceivedNotePurchaseOrderDetailPrice,
                        goodsReceivedNoteItemDetailUnitOfMeasureCode                : data.goodsReceivedNotePurchaseOrderDetailUnitOfMeasureCode,
                        goodsReceivedNoteItemDetailRackCode                         : txtGoodsReceivedNoteWarehouseDockInCode.val(),
                        goodsReceivedNoteItemDetailRackName                         : txtGoodsReceivedNoteWarehouseDockInName.val(),
                        goodsReceivedNoteItemDetailDiscountPercent                  : data.goodsReceivedNotePurchaseOrderDetailDiscountPercent,
                        goodsReceivedNoteItemDetailDiscountAmount                   : data.goodsReceivedNotePurchaseOrderDetailDiscountAmount,
                        goodsReceivedNoteItemDetailNettPrice                        : data.goodsReceivedNotePurchaseOrderDetailNettPrice,
                        goodsReceivedNoteItemDetailTotalAmount                      : data.goodsReceivedNotePurchaseOrderDetailTotalAmount,
                        goodsReceivedNoteItemDetailRemark                           : data.goodsReceivedNotePurchaseOrderDetailRemark
                        
                    };
                    goodsReceivedNoteItemDetail_lastRowId++;
                    $("#goodsReceivedNoteItemDetailInput_grid").jqGrid("addRowData", goodsReceivedNoteItemDetail_lastRowId, defRow);

                    be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                    $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('setRowData',goodsReceivedNoteItemDetail_lastRowId,{Buttons:be});
                    ev.preventDefault();
                }
            }  
        });
        
        $("#btnGoodsReceivedNoteSave").click(function(ev){
            if (!$("#frmGoodsReceivedNoteInput").valid()) {
                ev.preventDefault();
                return;
            }
            
            if (goodsReceivedNoteItemDetail_lastSel !== -1) {
                $('#goodsReceivedNoteItemDetailInput_grid').jqGrid("saveRow", goodsReceivedNoteItemDetail_lastSel);
            }
            
            var ids = jQuery("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getDataIDs');
            var listGoodsReceivedNoteItemDetail = new Array();
            
            if (ids.length === 0) {
                alertMessage("Data Grid GRN Detail Non Serial NoCan't Empty!");
                return;
            }
           
            var ids = jQuery("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var data = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getRowData', ids[i]);
                
                if(parseFloat(data.goodsReceivedNoteItemDetailGrnQuantity) <= 0){
                    alert("Quantity Must be Greater Than 0");
                    return;
                }
                var goodsReceivedNoteItemDetail = {
                    itemMaterial                        : {code: data.goodsReceivedNoteItemDetailItemMaterialCode},
                    itemAlias                           : data.goodsReceivedNoteItemDetailItemAlias,
                    heatNo                              : data.goodsReceivedNoteItemDetailHeatNo,
                    rack                                : {code: data.goodsReceivedNoteItemDetailRackCode},
                    purchaseOrderDetailCode             : data.goodsReceivedNoteItemDetailPurchaseOrderDetailCode,
                    price                               : data.goodsReceivedNoteItemDetailPrice,
                    quantity                            : data.goodsReceivedNoteItemDetailGrnQuantity,
                    discountPercent                     : data.goodsReceivedNoteItemDetailDiscountPercent,
                    discountAmount                      : data.goodsReceivedNoteItemDetailDiscountAmount,
                    nettPrice                           : data.goodsReceivedNoteItemDetailNettPrice,
                    totalAmount                         : data.goodsReceivedNoteItemDetailTotalAmount,
                    remark                              : data.goodsReceivedNoteItemDetailRemark
                };
                listGoodsReceivedNoteItemDetail[i] = goodsReceivedNoteItemDetail;
                
                for(var z=i+1; z<ids.length; z++){
                    var dataThen = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getRowData', ids[z]);
                    
                    if(data.goodsReceivedNoteItemDetailPurchaseOrderDetailCode === dataThen.goodsReceivedNoteItemDetailPurchaseOrderDetailCode){
                        alert("PO Detail Must Be DIFFERENT");
                        return;
                    }
                }
            }
            
            formatDateGoodsReceivedNote();
//            formatNumericGoodsReceivedNote(0);
            var url = "inventory/goods-received-note-save";
            var params = $("#frmGoodsReceivedNoteInput").serialize();
                params += "&listGoodsReceivedNoteItemDetailJSON=" + $.toJSON(listGoodsReceivedNoteItemDetail);
            
            showLoading();
  
            $.post(url, params, function (data) {
                closeLoading();
                if (data.error) {
                    formatDateGoodsReceivedNote();
//                    formatNumericGoodsReceivedNote(1);
                    alertMessage(data.errorMessage);
                    return;
                }

                var dynamicDialog = $('<div id="conformBox">' +
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                    '</span>' + data.message + '<br/>Do You Want Input Other Transaction?</div>');

                dynamicDialog.dialog({
                    title           : "Confirmation",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 400,
                    resizable       : false,
                    buttons         :
                                    [{
                                        text: "Yes",
                                        click: function () {
                                            $(this).dialog("close");
                                            var url = "inventory/goods-received-note-input";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE");
                                        }
                                    },
                                    {
                                        text: "No",
                                        click: function () {
                                            $(this).dialog("close");
                                            var url = "inventory/goods-received-note";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE");
                                        }
                                    }]
                });
            });
        });
        
        $("#btnGoodsReceivedNoteCancel").click(function (ev) {
            var params = "";
            var url = "inventory/goods-received-note";
            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE");
        });
        
        $('#btnSearchItemMaterial').click(function(ev) {
            var ids = jQuery("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getDataIDs');
            let vendor=$("#goodsReceivedNote\\.vendor\\.code").val();
            window.open("./pages/search/search-item-material-jn-vendor.jsp?iddoc=goodsReceivedNote&type=grid&rowLast="+ids.length+"&vendorCode="+vendor,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#goodsReceivedNote_btnPurchaseOrder').click(function (ev) {
            window.open("./pages/search/search-purchase-order-by-grn.jsp?iddoc=goodsReceivedNote&firstDate=" + $("#goodsReceivedNoteTransactionDateFirstSession").val() + "&lastDate=" + $("#goodsReceivedNoteTransactionDateLastSession").val() + "&idTranStatus=NON CASH&idInvType=Inventory&idItemDivision=INVENTORY", "Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#goodsReceivedNote_btnWarehouse').click(function (ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=goodsReceivedNote&idsubdoc=warehouse", "Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#goodsReceivedNote_btnExpedition').click(function (ev) {
            window.open("./pages/search/search-expedition.jsp?iddoc=goodsReceivedNote&idsubdoc=expedition", "Search", "scrollbars=1, width=600, height=500");
        });
    }); //EOF Ready
    
    function addRowDataMultiSelectedItemGrn(lastRowId,defRow){

        lastRowId++;

        $("#goodsReceivedNoteItemDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
        $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('setRowData',lastRowId,{
                goodsReceivedNoteItemDetailDelete                      : defRow.goodsReceivedNoteItemDetailDelete,
                goodsReceivedNoteItemDetailItemMaterialCode            : defRow.goodsReceivedNoteItemDetailItemMaterialCode,
                goodsReceivedNoteItemDetailItemMaterialName            : defRow.goodsReceivedNoteItemDetailItemMaterialName,
                goodsReceivedNoteItemDetailRackCode                    : txtGoodsReceivedNoteWarehouseDockInCode.val(),
                goodsReceivedNoteItemDetailRackName                    : txtGoodsReceivedNoteWarehouseDockInName.val()
        });
    }
        
    function goodsReceivedNoteItemDetailSearchPurchaseOrder_OnClick(){
      var ids = jQuery("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getDataIDs');
           
            if($("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;
                }
            }
            
            if(goodsReceivedNoteItemDetail_lastSel !== -1) {
                $('#goodsReceivedNoteItemDetailInput_grid').jqGrid("saveRow",goodsReceivedNoteItemDetail_lastSel);  
            }
            
           var listPurchaseOrder = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getRowData',ids[q]); 
                listPurchaseOrder[q] = [data.goodsReceivedNoteItemDetailPurchaseOrderDetailCode];
//                 (listCode);
            }
        window.open("./pages/search/search-purchase-order-array.jsp?iddoc=goodsReceivedNoteItemDetail&type=grid","Search", "scrollbars=1,width=600, height=500");
    }    
    
    function autoLoadDataGoodsReceivedNoteItemDetailUpdate(){
        $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('clearGridData');
        
        var url = "inventory/goods-received-note-detail-item-detail-data";
        var params = "goodsReceivedNote.Code=" + txtGoodsReceivedNoteCode.val();
           
        showLoading();

        $.post(url, params, function (data) {
            
            goodsReceivedNoteItemDetail_lastRowId = 0;
            for (var i = 0; i < data.listGoodsReceivedNoteItemDetail.length; i++) {
                
                $("#goodsReceivedNoteItemDetailInput_grid").jqGrid("addRowData", goodsReceivedNoteItemDetail_lastRowId, data.listGoodsReceivedNoteItemDetail[i]);
                $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('setRowData', goodsReceivedNoteItemDetail_lastRowId, {
                  
                    goodsReceivedNoteItemDetailPurchaseRequestCode      : data.listGoodsReceivedNoteItemDetail[i].purchaseRequestCode,
                    goodsReceivedNoteItemDetailPurchaseOrderDetailCode  : data.listGoodsReceivedNoteItemDetail[i].purchaseOrderDetailCode,
                    goodsReceivedNoteItemDetailItemMaterialCode         : data.listGoodsReceivedNoteItemDetail[i].itemMaterialCode,
                    goodsReceivedNoteItemDetailItemMaterialName         : data.listGoodsReceivedNoteItemDetail[i].itemMaterialName,
                    goodsReceivedNoteItemDetailItemAlias                : data.listGoodsReceivedNoteItemDetail[i].itemAlias,
                    goodsReceivedNoteItemDetailPODQuantity              : data.listGoodsReceivedNoteItemDetail[i].poQuantity,
                    goodsReceivedNoteItemDetailReceivedQuantity         : data.listGoodsReceivedNoteItemDetail[i].receivedQuantity,
                    goodsReceivedNoteItemDetailGrnQuantity              : data.listGoodsReceivedNoteItemDetail[i].quantity,
                    goodsReceivedNoteItemDetailUnitOfMeasureCode        : data.listGoodsReceivedNoteItemDetail[i].itemMaterialUnitOfMeasureCode,
                    goodsReceivedNoteItemDetailPrice                    : data.listGoodsReceivedNoteItemDetail[i].price,
                    goodsReceivedNoteItemDetailHeatNo                   : data.listGoodsReceivedNoteItemDetail[i].heatNo,
                    goodsReceivedNoteItemDetailRackCode                 : data.listGoodsReceivedNoteItemDetail[i].rackCode,
                    goodsReceivedNoteItemDetailRackName                 : data.listGoodsReceivedNoteItemDetail[i].rackName,
                    goodsReceivedNoteItemDetailDiscountPercent          : data.listGoodsReceivedNoteItemDetail[i].discountPercent,
                    goodsReceivedNoteItemDetailDiscountAmount           : data.listGoodsReceivedNoteItemDetail[i].discountAmount,
                    goodsReceivedNoteItemDetailNettPrice                : data.listGoodsReceivedNoteItemDetail[i].nettPrice,
                    goodsReceivedNoteItemDetailTotalAmount              : data.listGoodsReceivedNoteItemDetail[i].totalAmount
                    
                });
                goodsReceivedNoteItemDetail_lastRowId++;
            }
            closeLoading();
        });
    }
    
    function calculateDetailGrn(){
        var selectedRowId = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid("getGridParam","selrow");
        
        if(selectedRowId === "" ||selectedRowId === null){
            selectedRowId = goodsReceivedNoteItemDetail_lastRowId;
        }
        
        let quantity = $("#"+selectedRowId+"_goodsReceivedNoteItemDetailGrnQuantity").val();
        let grn = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid("getRowData", selectedRowId);
        
        if(isNaN(quantity)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowId + "_goodsReceivedNoteItemDetailGrnQuantity").val("");
            return;
        }
        
        let totalAmount = parseFloat(quantity)*parseFloat(grn.goodsReceivedNoteItemDetailNettPrice);
        $("#goodsReceivedNoteItemDetailInput_grid").jqGrid("setCell",selectedRowId,"goodsReceivedNoteItemDetailTotalAmount",totalAmount);
        calculateGrnHeader();
    }
    
    function calculateGrnHeader() {
        var totalTransaction = 0;
        var ids = jQuery("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getDataIDs');
        for(var i=0;i < ids.length;i++) {
            var data = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.goodsReceivedNoteItemDetailTotalAmount);
        }      
        
        var discPercent = $("#goodsReceivedNote\\.discountPercent").val();
        var discAmount =  (parseFloat(discPercent) * parseFloat(totalTransaction.toFixed(2)))/100;
        var subTotalAmount = parseFloat(totalTransaction.toFixed(2)) - parseFloat(discAmount.toFixed(2));
        var vatPercent = $("#goodsReceivedNote\\.vatPercent").val();
        var vatAmount = (subTotalAmount * parseFloat(vatPercent))/100;
        var grandTotal =subTotalAmount + parseFloat(vatAmount.toFixed(2));
        
        $("#goodsReceivedNote\\.totalTransactionAmount").val(totalTransaction.toFixed(2));
        $("#goodsReceivedNote\\.discountAmount").val(discAmount.toFixed(2));
        $("#goodsReceivedNote\\.vatAmount").val(vatAmount.toFixed(2));        
        $("#goodsReceivedNote\\.grandTotalAmount").val(grandTotal.toFixed(2));
    }
    
    function loadPurchaseOrderDetailGrn() {
        $("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid('clearGridData');
        
        var url = "purchasing/purchase-order-detail-by-grn-data";
        var params = "purchaseOrder.code=" + txtGoodsReceivedNotePurchaseOrderCode.val();
           
        showLoading();

        $.post(url, params, function (data) {
            
            goodsReceivedNotePurchaseOrderDetailLastRowId = 0;
            for (var i = 0; i < data.listPurchaseOrderDetail.length; i++) {
                

                $("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid("addRowData", goodsReceivedNotePurchaseOrderDetailLastRowId, data.listPurchaseOrderDetail[i]);
                $("#goodsReceivedNotePurchaseOrderDetailInput_grid").jqGrid('setRowData', goodsReceivedNotePurchaseOrderDetailLastRowId, {
                  
                    goodsReceivedNotePurchaseOrderDetailPurchaseOrderDetailCode         : data.listPurchaseOrderDetail[i].code,
                    goodsReceivedNotePurchaseOrderDetailPurchaseOrderCode               : data.listPurchaseOrderDetail[i].headerCode,
                    goodsReceivedNotePurchaseOrderDetailPurchaseRequestCode             : data.listPurchaseOrderDetail[i].purchaseRequestCode,
                    goodsReceivedNotePurchaseOrderDetailItemAlias                       : data.listPurchaseOrderDetail[i].itemAlias,
                    goodsReceivedNotePurchaseOrderDetailItemMaterialCode                : data.listPurchaseOrderDetail[i].itemMaterialCode,
                    goodsReceivedNotePurchaseOrderDetailItemMaterialName                : data.listPurchaseOrderDetail[i].itemMaterialName,
                    goodsReceivedNotePurchaseOrderDetailQuantity                        : data.listPurchaseOrderDetail[i].quantity,
                    goodsReceivedNotePurchaseOrderDetailReceivedQuantity                : data.listPurchaseOrderDetail[i].grnQuantity,
                    goodsReceivedNotePurchaseOrderDetailBalanceQuantity                 : data.listPurchaseOrderDetail[i].balanceQuantity,
                    goodsReceivedNotePurchaseOrderDetailPrice                           : data.listPurchaseOrderDetail[i].price,
                    goodsReceivedNotePurchaseOrderDetailDiscountPercent                 : data.listPurchaseOrderDetail[i].discountPercent,
                    goodsReceivedNotePurchaseOrderDetailDiscountAmount                  : data.listPurchaseOrderDetail[i].discountAmount,
                    goodsReceivedNotePurchaseOrderDetailNettPrice                       : data.listPurchaseOrderDetail[i].nettPrice,
                    goodsReceivedNotePurchaseOrderDetailTotalAmount                     : data.listPurchaseOrderDetail[i].totalAmount,
                    goodsReceivedNotePurchaseOrderDetailUnitOfMeasureCode               : data.listPurchaseOrderDetail[i].unitOfMeasureCode,
                    goodsReceivedNotePurchaseOrderDetailRemark                          : data.listPurchaseOrderDetail[i].remark,
                    goodsReceivedNotePurchaseOrderDetailRackCode                        : txtGoodsReceivedNoteWarehouseDockInCode.val(),
                    goodsReceivedNotePurchaseOrderDetailRackName                        : txtGoodsReceivedNoteWarehouseDockInName.val()
                    
                });
                
                goodsReceivedNotePurchaseOrderDetailLastRowId++;
            }
          
            closeLoading();
        });
    }
    
    function formatDateGoodsReceivedNote() {
        var date = dtpGoodsReceivedNoteTransactionDate.val(); 
        var dateTemp = date.toString().split(" ");
        var splitDate = dateTemp[0].toString().split("/");
        var transDate = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2]+" "+dateTemp[1];
        dtpGoodsReceivedNoteTransactionDate.val(transDate);        
        $("#goodsReceivedNote\\.transactionDateTemp").val(dtpGoodsReceivedNoteTransactionDate.val());
        
        
        var createdDate=$("#goodsReceivedNote\\.createdDate").val();
        $("#goodsReceivedNote\\.createdDateTemp").val(createdDate);
        
    }

    function goodsReceivedNoteValidateExchangeRate(currency){
        if(currency==="IDR"){
            txtGoodsReceivedNoteExchangeRate.val("1.00");
            txtGoodsReceivedNoteExchangeRate.attr('readonly',true);
        }else if(currency===""){
            txtGoodsReceivedNoteExchangeRate.val("0.00");
            txtGoodsReceivedNoteExchangeRate.attr('readonly',true);
        }else{
            txtGoodsReceivedNoteExchangeRate.val("0.00");
            txtGoodsReceivedNoteExchangeRate.attr('readonly',false);
        }
    }
    
    function formatNumericGoodsReceivedNote(flag) {
        var rateValue = txtGoodsReceivedNoteExchangeRate.val();
        var exchangeRate;
        switch (flag) {
            case 0:
                exchangeRate = removeCommas(rateValue);
                break;
            case 1:
                exchangeRate = formatNumber(parseFloat(rateValue));
                break;
        }
        txtGoodsReceivedNoteExchangeRate.val(exchangeRate);
    }

    function goodsReceivedNoteItemDetailInputGrid_Delete_OnClick() {
        var selectDetailRowId = $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getGridParam', 'selrow');
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('delRowData', selectDetailRowId);
    }
    
    function goodsReceivedNoteSerialNoInputGrid_Delete_OnClick() {
        var selectDetailRowId = $("#goodsReceivedNoteSerialNolInput_grid").jqGrid('getGridParam', 'selrow');
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        $("#goodsReceivedNoteSerialNolInput_grid").jqGrid('delRowData', selectDetailRowId);
    }
    
    function setRackDataGoodsReceivedNoteItemDetail() {
      
            var rowDetail=0;
            var ids = jQuery("#goodsReceivedNoteItemDetailInput_grid").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                $("#goodsReceivedNoteItemDetailInput_grid").jqGrid('setRowData', rowDetail, {
                  
                    goodsReceivedNoteItemDetailRackCode    : txtGoodsReceivedNoteWarehouseDockInCode.val(),
                    goodsReceivedNoteItemDetailRackName    : txtGoodsReceivedNoteWarehouseDockInName.val()
                    
                });
                rowDetail++;
            }
        }
    
    function goodsReceivedNoteTransactionDateOnChange() {
        if ($("#goodsReceivedNoteUpdateMode").val() !== "true") {
            $("#goodsReceivedNoteTransactionDateTemp").val(dtpGoodsReceivedNoteTransactionDate.val());
        }
    }
        
</script>
<b>GOODS RECEIVED NOTE</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlGoodsReceivedNotePurchaseOrderDetailInput" action="" />
<s:url id="remotedetailurlGoodsReceivedNoteNoItemDetailInput" action="" />
<div id="goodsReceivedNoteInput" class="content ui-widget">
    <s:form id="frmGoodsReceivedNoteInput">
        <div id="div-header-goods-received-note">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                                <td align="right"><B>GRN No *</B></td>
                                <td>
                                    <s:textfield id="goodsReceivedNote.code" name="goodsReceivedNote.code" size="25" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                </td>
                            </tr>  
                            <tr>
                                <td align="right"><B>POD No *</B></td>
                                <td>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="goodsReceivedNote.purchaseOrder.code" name="goodsReceivedNote.purchaseOrder.code" size="25" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                        <sj:a id="goodsReceivedNote_btnPurchaseOrder" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                </td>
                            </tr>  
                            <tr>
                                <td align="right">POD Date</td>
                                <td>
                                    <sj:datepicker id="goodsReceivedNote.purchaseOrder.transactionDate" name="goodsReceivedNote.purchaseOrder.transactionDate" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" readonly="true" disabled="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><b>Branch *</b></td>
                                <td>
                                    <s:textfield id="goodsReceivedNote.branch.code" name="goodsReceivedNote.branch.code" readonly="true" required="true" cssClass="required" title="*"></s:textfield>
                                    <s:textfield id="goodsReceivedNote.branch.name" name="goodsReceivedNote.branch.name" readonly="true" size="33"></s:textfield>
                                </td>
                            </tr>
                             <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="goodsReceivedNote.transactionDate" name="goodsReceivedNote.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" onchange="goodsReceivedNoteTransactionDateOnChange()"></sj:datepicker>
                                    <sj:datepicker id="goodsReceivedNoteTransactionDateTemp" name="goodsReceivedNoteTransactionDateTemp" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right"><b>Vendor *</b></td>
                                <td>
                                <s:textfield id="goodsReceivedNote.vendor.code" name="goodsReceivedNote.vendor.code" readonly="true"></s:textfield>
                                <s:textfield id="goodsReceivedNote.vendor.name" name="goodsReceivedNote.vendor.name" size="33" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Contact Person</td>
                                <td>
                                <s:textfield id="goodsReceivedNote.vendor.defaultContactPerson.name" name="goodsReceivedNote.vendor.defaultContactPerson.name" size="33" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Address</td>
                                <td><s:textarea id="goodsReceivedNote.vendor.address" name="goodsReceivedNote.vendor.address" rows="3" cols="52" readonly="true"></s:textarea></td>
                            </tr>
                            <tr>
                                <td align="right">Phone 1</td>
                                <td><s:textfield id="goodsReceivedNote.vendor.phone1" name="goodsReceivedNote.vendor.phone1" readonly="true"></s:textfield> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    Phone 2
                                <s:textfield id="goodsReceivedNote.vendor.phone2" name="goodsReceivedNote.vendor.phone2" readonly="true"></s:textfield></td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" align="right">
                        <table>
                            <tr>
                                <td align="right"><B>Currency *</B></td>
                                <td colspan="2">
                                    <s:textfield id="goodsReceivedNote.currency.code" name="goodsReceivedNote.currency.code" readonly="true" size="20"></s:textfield>
                                    <s:textfield id="goodsReceivedNote.currency.name" name="goodsReceivedNote.currency.name" size="35" readonly="true"></s:textfield>
                               </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Exchange Rate *</B></td>
                                <td colspan="2">
                                    <s:textfield id="goodsReceivedNote.exchangeRate" name="goodsReceivedNote.exchangeRate" size="20" style="text-align: right"></s:textfield><b>IDR</b>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Received By</td>
                                <td><s:textfield id="goodsReceivedNote.receivedBy" name="goodsReceivedNote.receivedBy" size="56"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Vendor Do No *</B></td>
                                <td><s:textfield id="goodsReceivedNote.vendorDeliveryNoteNo" name="goodsReceivedNote.vendorDeliveryNoteNo" size="56" title="*" required="true" cssClass="required"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right">Police No </td>
                                <td><s:textfield id="goodsReceivedNote.policeNo" name="goodsReceivedNote.policeNo" size="56" ></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right">Container No</td>
                                <td><s:textfield id="goodsReceivedNote.containerNo" name="goodsReceivedNote.containerNo" size="56"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right"><b>Warehouse *</b></td>
                                <td>
                                    <script type = "text/javascript">

                                        txtGoodsReceivedNoteWarehouseCode.change(function (ev) {

                                            if (txtGoodsReceivedNoteWarehouseCode.val() === "") {
                                                txtGoodsReceivedNoteWarehouseName.val("");
                                                txtGoodsReceivedNoteWarehouseDockInCode.val("");
                                                txtGoodsReceivedNoteWarehouseDockInName.val("");
                                                return;
                                            }
                                            var url = "master/warehouse-get";
                                            var params = "warehouseCode=" + txtGoodsReceivedNoteWarehouseCode.val();
                                                params += "&warehouse.activeStatus=TRUE";

                                            $.post(url, params, function (result) {
                                                var data = (result);

                                                if (data.warehouseTemp) {
                                                    txtGoodsReceivedNoteWarehouseCode.val(data.warehouseTemp.code);
                                                    txtGoodsReceivedNoteWarehouseName.val(data.warehouseTemp.name);
                                                    txtGoodsReceivedNoteWarehouseDockInCode.val(data.warehouseTemp.dockInCode);
                                                    txtGoodsReceivedNoteWarehouseDockInName.val(data.warehouseTemp.dockInName);
                                                } else {
                                                    alertMessage("Warehouse Not Found!", txtGoodsReceivedNoteWarehouseCode);
                                                    txtGoodsReceivedNoteWarehouseCode.val("");
                                                    txtGoodsReceivedNoteWarehouseName.val("");
                                                    txtGoodsReceivedNoteWarehouseDockInCode.val("");
                                                    txtGoodsReceivedNoteWarehouseDockInName.val("");
                                                }
                                            });
                                        });
                                    </script>
                                    <div class="searchbox ui-widget-header">
                                    <s:textfield id="goodsReceivedNote.warehouse.code" name="goodsReceivedNote.warehouse.code" required="true" cssClass="required" title="*"></s:textfield>
                                    <sj:a id="goodsReceivedNote_btnWarehouse" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                    <s:textfield id="goodsReceivedNote.warehouse.name" name="goodsReceivedNote.warehouse.name" cssStyle="width:49%" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Dock In</td>
                                <td><s:textfield id="goodsReceivedNote.warehouse.dockInCode" name="goodsReceivedNote.warehouse.dockInCode" readonly="true"></s:textfield> 
                                <s:textfield id="goodsReceivedNote.warehouse.dockInName" name="goodsReceivedNote.warehouse.dockInName" cssStyle="width:49%" readonly="true"></s:textfield></td>
                                <s:textfield id="rackDockInName" name="rackDockInName" cssStyle="width:49%" readonly="true" hidden="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Expedition</td>
                                <td>
                                    <script type = "text/javascript">

                                        txtGoodsReceivedNoteExpeditionCode.change(function (ev) {

                                            if (txtGoodsReceivedNoteExpeditionCode.val() === "") {
                                                txtGoodsReceivedNoteExpeditionName.val("");
                                                return;
                                            }
                                            var url = "master/expedition-get";
                                            var params = "expedition.code=" + txtGoodsReceivedNoteExpeditionCode.val();
                                                params += "&expedition.activeStatus=TRUE";

                                            $.post(url, params, function (result) {
                                                var data = (result);
                                                if (data.expeditionTemp) {
                                                    txtGoodsReceivedNoteExpeditionCode.val(data.expeditionTemp.code);
                                                    txtGoodsReceivedNoteExpeditionName.val(data.expeditionTemp.name);
                                                } else {
                                                    alertMessage("Expedition Not Found!", txtGoodsReceivedNoteExpeditionCode);
                                                    txtGoodsReceivedNoteExpeditionCode.val("");
                                                    txtGoodsReceivedNoteExpeditionName.val("");
                                                }
                                            });
                                        });
                                    </script>
                                    <div class="searchbox ui-widget-header">
                                    <s:textfield id="goodsReceivedNote.expedition.code" name="goodsReceivedNote.expedition.code"></s:textfield>
                                    <sj:a id="goodsReceivedNote_btnExpedition" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                <s:textfield id="goodsReceivedNote.expedition.name" name="goodsReceivedNote.expedition.name" cssStyle="width:49%" readonly="true"></s:textfield>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="goodsReceivedNote.refNo" name="goodsReceivedNote.refNo" size="56"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Remark</td>
                                <td><s:textarea id="goodsReceivedNote.remark" name="goodsReceivedNote.remark" rows="2" cols="52" ></s:textarea></td>
                            </tr>
                            <tr hidden="true">
                                <td colspan="2">
                                    <s:textfield disabled="true" id="goodsReceivedNote.warehouse.rack.code" name="goodsReceivedNote.warehouse.rack.code" readonly="true"></s:textfield>
                                    <s:textfield disabled="true" id="goodsReceivedNote.warehouse.rack.name" name="goodsReceivedNote.warehouse.rack.name" readonly="true"></s:textfield>
                                    <s:textfield id="enumGoodsReceivedNoteActivity" name="enumGoodsReceivedNoteActivity" size="5" style="display:none"></s:textfield>
                                    <sj:datepicker id="goodsReceivedNoteTransactionDateFirstSession" name="goodsReceivedNoteTransactionDateFirstSession" size="15" showOn="focus" ></sj:datepicker>
                                    <sj:datepicker id="goodsReceivedNoteTransactionDateLastSession" name="goodsReceivedNoteTransactionDateLastSession" size="15" showOn="focus" ></sj:datepicker>
                                    <s:textfield id="goodsReceivedNote.createdBy" name="goodsReceivedNote.createdBy" key="customerPurchaseOrder.createdBy" readonly="true" size="22"></s:textfield>
                                    <sj:datepicker id="goodsReceivedNote.createdDate" name="goodsReceivedNote.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                                    <s:textfield id="goodsReceivedNote.createdDateTemp" name="goodsReceivedNote.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                                    <s:textfield id="goodsReceivedNote.transactionDateTemp" name="goodsReceivedNote.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <table style="width:100%;">
            <tr>
                <td>
                    <sj:a href="#" id="btnConfirmGoodsReceivedNote" button="true" style="width: 90px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmGoodsReceivedNote" button="true" style="width: 90px">UnConfirm</sj:a>
                </td>
            </tr>
        </table>            
       
        <br class="spacer" />
        <div id="goodsReceivedNotePurchaseOrderDetailInputGrid">
            <sjg:grid                        
                id="goodsReceivedNotePurchaseOrderDetailInput_grid"
                caption="Purchase Order Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listGoodsReceivedNoteItemDetail"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                multiselect = "true"
                width="$('#tabmnugoodsreceivednotebyypurchaseorder').width()"
                editurl="%{remotedetailurlGoodsReceivedNotePurchaseOrderDetailInput}"
                onSelectRowTopics="goodsReceivedNotePurchaseOrderDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetail" index="goodsReceivedNotePurchaseOrderDetail" key="goodsReceivedNotePurchaseOrderDetail" 
                    title="" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailPurchaseOrderCode" index="goodsReceivedNotePurchaseOrderDetailPurchaseOrderCode" key="goodsReceivedNotePurchaseOrderDetailPurchaseOrderCode" 
                    title="PO Code" width="150" hidden="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailPurchaseRequestCode" index="goodsReceivedNotePurchaseOrderDetailPurchaseRequestCode" key="goodsReceivedNotePurchaseOrderDetailPurchaseRequestCode" 
                    title="Pr Code" width="100" hidden="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailPurchaseOrderDetailCode" index="goodsReceivedNotePurchaseOrderDetailPurchaseOrderDetailCode" key="goodsReceivedNotePurchaseOrderDetailPurchaseOrderDetailCode" 
                    title="Po detail Code" width="180" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailItemMaterialCode" index="goodsReceivedNotePurchaseOrderDetailItemMaterialCode" key="goodsReceivedNotePurchaseOrderDetailItemMaterialCode" 
                    title="Item Material Code" width="100"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailItemMaterialName" index="goodsReceivedNotePurchaseOrderDetailItemMaterialName" key="goodsReceivedNotePurchaseOrderDetailItemMaterialName" 
                    title="Item Material Name" width="250" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailItemAlias" index="goodsReceivedNotePurchaseOrderDetailItemAlias" key="goodsReceivedNotePurchaseOrderDetailItemAlias" 
                    title="Item Alias" width="250"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailQuantity" id="goodsReceivedNotePurchaseOrderDetailQuantity" index="goodsReceivedNotePurchaseOrderDetailQuantity" key="goodsReceivedNotePurchaseOrderDetailQuantity" 
                    title="POD Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailReceivedQuantity" index="goodsReceivedNotePurchaseOrderDetailReceivedQuantity" key="goodsReceivedNotePurchaseOrderDetailReceivedQuantity" 
                    title="Received Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailBalanceQuantity" index="goodsReceivedNotePurchaseOrderDetailBalanceQuantity" key="goodsReceivedNotePurchaseOrderDetailBalanceQuantity" 
                    title="Balance Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailPrice" index="goodsReceivedNotePurchaseOrderDetailPrice" key="goodsReceivedNotePurchaseOrderDetailPrice" 
                    title="Price" width="120" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNotePurchaseOrderDetailUnitOfMeasureCode" index="goodsReceivedNotePurchaseOrderDetailUnitOfMeasureCode" key="goodsReceivedNotePurchaseOrderDetailUnitOfMeasureCode" title="UOM" width="80" 
                    edittype="text" sortable="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNotePurchaseOrderDetailUnitOfMeasureName" index="goodsReceivedNotePurchaseOrderDetailUnitOfMeasureName" key="goodsReceivedNotePurchaseOrderDetailUnitOfMeasureName" title="UOM" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNotePurchaseOrderDetailRemark" index="goodsReceivedNotePurchaseOrderDetailRemark" key="goodsReceivedNotePurchaseOrderDetailRemark" title="Remark" width="100" 
                    edittype="text" sortable="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNotePurchaseOrderDetailRackCode" index="goodsReceivedNotePurchaseOrderDetailRackCode" key="goodsReceivedNotePurchaseOrderDetailRackCode" title="Rack Code" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNotePurchaseOrderDetailRackName" index="goodsReceivedNotePurchaseOrderDetailRackName" key="goodsReceivedNotePurchaseOrderDetailRackName" title="Rack Name" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailDiscountPercent" id="goodsReceivedNotePurchaseOrderDetailDiscountPercent" index="goodsReceivedNotePurchaseOrderDetailDiscountPercent" key="goodsReceivedNotePurchaseOrderDetailDiscountPercent" 
                    title="Disc Percent" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailDiscountAmount" id="goodsReceivedNotePurchaseOrderDetailDiscountAmount" index="goodsReceivedNotePurchaseOrderDetailDiscountAmount" key="goodsReceivedNotePurchaseOrderDetailDiscountAmount" 
                    title="Disc Amount" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailNettPrice" id="goodsReceivedNotePurchaseOrderDetailNettPrice" index="goodsReceivedNotePurchaseOrderDetailNettPrice" key="goodsReceivedNotePurchaseOrderDetailNettPrice" 
                    title="Nett Price" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNotePurchaseOrderDetailTotalAmount" id="goodsReceivedNotePurchaseOrderDetailTotalAmount" index="goodsReceivedNotePurchaseOrderDetailTotalAmount" key="goodsReceivedNotePurchaseOrderDetailTotalAmount" 
                    title="Total Amount" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
            </sjg:grid >
            <table style="width:100%;">
                <tr>
                    <td>
                        <sj:a href="#" id="btnCopyItemMaterial" button="true" style="width: 90px">Copy Item</sj:a>
                    </td>
                </tr>
            </table>         
        <br class="spacer" />
      
            <table style="width:100%;">
                <tr>
                    <td>
                        <sj:a href="#" id="btnSearchItemMaterial" button="true" style="width: 90px">Search Item</sj:a>
                    </td>
                </tr>
            </table>         
            <sjg:grid                        
                id="goodsReceivedNoteItemDetailInput_grid"
                caption="GRN Item Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listGoodsReceivedNoteItemDetail"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnugoodsreceivednotebyypurchaseorder').width()"
                editurl="%{remotedetailurlGoodsReceivedNoteNoItemDetailInput}"
                onSelectRowTopics="goodsReceivedNoteItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetail" index="goodsReceivedNoteItemDetail" key="goodsReceivedNoteItemDetail" 
                    title="" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailPurchaseRequestCode" index="goodsReceivedNoteItemDetailPurchaseRequestCode" key="goodsReceivedNoteItemDetailPurchaseRequestCode" 
                    title="PurchaseRequestCode" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailDelete" index="goodsReceivedNoteItemDetailDelete" 
                    title="" width="50" editable="true" edittype="button"
                    editoptions="{onClick:'goodsReceivedNoteItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailItemMaterialCode" index="goodsReceivedNoteItemDetailItemMaterialCode" key="goodsReceivedNoteItemDetailItemMaterialCode" 
                    title="Item Material Code" width="100"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailItemMaterialName" index="goodsReceivedNoteItemDetailItemMaterialName" key="goodsReceivedNoteItemDetailItemMaterialName" 
                    title="Item Material Name" width="300" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailSearchPurchaseOrder" index="goodsReceivedNoteItemDetailSearchPurchaseOrder" title="" width="25" align="centre"
                    editable="true"
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'goodsReceivedNoteItemDetailSearchPurchaseOrder_OnClick()', value:'...'}"
                /> 
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailPurchaseOrderDetailCode" index="goodsReceivedNoteItemDetailPurchaseOrderDetailCode" key="goodsReceivedNoteItemDetailPurchaseOrderDetailCode" 
                    title="Po detail Code" width="200" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailItemAlias" index="goodsReceivedNoteItemDetailItemAlias" key="goodsReceivedNoteItemDetailItemAlias" 
                    title="Item Alias" width="250"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailPODQuantity" id="goodsReceivedNoteItemDetailPODQuantity" index="goodsReceivedNoteItemDetailPODQuantity" key="goodsReceivedNoteItemDetailPODQuantity" 
                    title="POD Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                 <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailReceivedQuantity" index="goodsReceivedNoteItemDetailReceivedQuantity" key="goodsReceivedNoteItemDetailReceivedQuantity" 
                    title="Received Qty" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                 <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailBalanceQuantity" index="goodsReceivedNoteItemDetailBalanceQuantity" key="goodsReceivedNoteItemDetailBalanceQuantity" 
                    title="Received Qty" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailGrnQuantity" index="goodsReceivedNoteItemDetailGrnQuantity" key="goodsReceivedNoteItemDetailGrnQuantity" 
                    title="GRN Quantity" width="100" sortable="true" editable="true" edittype="text"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    editoptions = "{onKeyUp:'calculateDetailGrn()'}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailPrice" index="goodsReceivedNoteItemDetailPrice" key="goodsReceivedNoteItemDetailPrice" 
                    title="Price" width="100" sortable="true" editable="false" edittype="text"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailUnitOfMeasureCode" index="goodsReceivedNoteItemDetailUnitOfMeasureCode" key="goodsReceivedNotePurchaseOrderDetailUnitOfMeasureCode" title="Unit" width="100" 
                    edittype="text" sortable="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailHeatNo" index="goodsReceivedNoteItemDetailHeatNo" key="goodsReceivedNoteItemDetailHeatNo" title="Heat No" width="150" editable="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteItemDetailRackCode" index="goodsReceivedNoteItemDetailRackCode" key="goodsReceivedNoteItemDetailRackCode" title="Rack Code" width="125" 
                    edittype="text"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteItemDetailRackName" index="goodsReceivedNoteItemDetailRackName" key="goodsReceivedNoteItemDetailRackName" title="Rack Name" width="150" 
                    edittype="text"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailDiscountPercent" id="goodsReceivedNoteItemDetailDiscountPercent" index="goodsReceivedNoteItemDetailDiscountPercent" key="goodsReceivedNoteItemDetailDiscountPercent" 
                    title="Disc Percent" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailDiscountAmount" id="goodsReceivedNoteItemDetailDiscountAmount" index="goodsReceivedNoteItemDetailDiscountAmount" key="goodsReceivedNoteItemDetailDiscountAmount" 
                    title="Disc Amount" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailNettPrice" index="goodsReceivedNoteItemDetailNettPrice" key="goodsReceivedNoteItemDetailNettPrice" 
                    title="Nett Price" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteItemDetailTotalAmount" id="goodsReceivedNoteItemDetailTotalAmount" index="goodsReceivedNoteItemDetailTotalAmount" key="goodsReceivedNoteItemDetailTotalAmount" 
                    title="Total Amount" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteItemDetailRemark" index="goodsReceivedNoteItemDetailRemark" key="goodsReceivedNoteItemDetailRemark" title="Ramark" width="150" 
                    edittype="text" editable="true"
                />
            </sjg:grid >
        </div>
        <br class="spacer" />
        <div hidden="true">
            <table>
                <tr>
                    <td valign="top">
                    </td>
                    <td width="100%" >
                        <table align="right">
                            <tr>
                                <td align="right"><B>Total Transaction</B>
                                    <s:textfield id="goodsReceivedNote.totalTransactionAmount" name="goodsReceivedNote.totalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="left"><B>Discount</B>
                                    <s:textfield id="goodsReceivedNote.discountPercent" name="goodsReceivedNote.discountPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                    %
                                    <s:textfield id="goodsReceivedNote.discountAmount" name="goodsReceivedNote.discountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td align="right"><B>VAT</B>
                                    <s:textfield id="goodsReceivedNote.vatPercent" name="goodsReceivedNote.vatPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                    %
                                    <s:textfield id="goodsReceivedNote.vatAmount" name="goodsReceivedNote.vatAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                                <td/>
                            </tr>
                            <tr>
                                <td align="right"><B>Grand Total</B>
                                    <s:textfield id="goodsReceivedNote.grandTotalAmount" name="goodsReceivedNote.grandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                                </td>
                                <td/>
                            </tr>
                        </table>
                    </td>
                </tr>            
            </table>
        </div>
        <br class="spacer" />
        <div>
            <table width="100%">
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                            <td><sj:a href="#" id="btnGoodsReceivedNoteSave" button="true" style="width: 60px">Save</sj:a></td>
                            <td><sj:a href="#" id="btnGoodsReceivedNoteCancel" button="true" style="width: 60px">Cancel</sj:a></td>
                            </tr>
                        </table>
                    </td>
                </tr>            
            </table>
        </div> 
    </s:form>
</div>