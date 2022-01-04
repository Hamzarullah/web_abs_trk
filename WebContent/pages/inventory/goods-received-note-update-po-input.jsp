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
   #goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid_pager_center,#goodsReceivedNoteUpdatePoItemDetailInput_grid_pager_center{
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
    
    var goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_lastSel = -1;
    var goodsReceivedNoteUpdatePoPurchaseOrderDetailLastRowId = 0;
    var goodsReceivedNoteUpdatePoItemDetail_lastSel = -1, goodsReceivedNoteUpdatePoItemDetail_lastRowId=0;
    
    var
        txtGoodsReceivedNoteUpdatePoCode = $("#goodsReceivedNoteUpdatePo\\.code"),
        dtpGoodsReceivedNoteUpdatePoTransactionDate = $("#goodsReceivedNoteUpdatePo\\.transactionDate"),
        txtGoodsReceivedNoteUpdatePoPurchaseOrderCode = $("#goodsReceivedNoteUpdatePo\\.purchaseOrder\\.code"),
        txtGoodsReceivedNoteUpdatePoExchangeRate = $("#goodsReceivedNoteUpdatePo\\.exchangeRate"),
        txtGoodsReceivedNoteUpdatePoReceivedBy = $("#goodsReceivedNoteUpdatePo\\.receivedBy"),
        txtGoodsReceivedNoteUpdatePoVendorDo = $("#goodsReceivedNoteUpdatePo\\.vendorDeliveryNoteNo"),
        txtGoodsReceivedNoteUpdatePoWarehouseCode = $("#goodsReceivedNoteUpdatePo\\.warehouse\\.code"),
        txtGoodsReceivedNoteUpdatePoWarehouseName = $("#goodsReceivedNoteUpdatePo\\.warehouse\\.name"),
        txtGoodsReceivedNoteUpdatePoWarehouseDockInCode = $("#goodsReceivedNoteUpdatePo\\.warehouse\\.dockInCode"),
        txtGoodsReceivedNoteUpdatePoWarehouseDockInName = $("#goodsReceivedNoteUpdatePo\\.warehouse\\.dockInName"),
        txtGoodsReceivedNoteUpdatePoExpeditionCode = $("#goodsReceivedNoteUpdatePo\\.expedition\\.code"),
        txtGoodsReceivedNoteUpdatePoExpeditionName = $("#goodsReceivedNoteUpdatePo\\.expedition\\.name");

    $(document).ready(function () {

        hoverButton();
        flagConfirmGoodsReceivedNoteUpdatePo = false;

        goodsReceivedNoteUpdatePoValidateExchangeRate($("#goodsReceivedNoteUpdatePo\\.currency\\.code").val());
        txtGoodsReceivedNoteUpdatePoWarehouseDockInName.val($("#rackDockInName").val());
        
         $.subscribe("goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid_onSelect", function () {
            var selectedRowID = $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");
            if (selectedRowID !== goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_lastSel) {
                $('#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid').jqGrid("saveRow", goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_lastSel);
                $('#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid').jqGrid("editRow", selectedRowID, true);
                goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_lastSel = selectedRowID;
            } else {
                $('#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid').jqGrid("saveRow", selectedRowID);
            }
        });
        
        $.subscribe("goodsReceivedNoteUpdatePoItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==goodsReceivedNoteUpdatePoItemDetail_lastSel) {
                $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('saveRow',goodsReceivedNoteUpdatePoItemDetail_lastSel); 
                $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                goodsReceivedNoteUpdatePoItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
         
        loadPurchaseOrderDetailGrn();
        autoLoadDataGoodsReceivedNoteUpdatePoItemDetailUpdate();
        
        $("#btnGoodsReceivedNoteUpdatePoSave").click(function(ev){
            if (!$("#frmGoodsReceivedNoteUpdatePoInput").valid()) {
                ev.preventDefault();
                return;
            }
            
            if (goodsReceivedNoteUpdatePoItemDetail_lastSel !== -1) {
                $('#goodsReceivedNoteUpdatePoItemDetailInput_grid').jqGrid("saveRow", goodsReceivedNoteUpdatePoItemDetail_lastSel);
            }
            
            var ids = jQuery("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getDataIDs');
            var  listGoodsReceivedNoteUpdatePoItemDetail = new Array();
            
            if (ids.length === 0) {
                alertMessage("Data Grid GRN Detail Non Serial NoCan't Empty!");
                return;
            }
           
            var ids = jQuery("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var data = $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getRowData', ids[i]);
                var goodsReceivedNoteUpdatePoItemDetail = {
                    itemMaterial                        : {code: data.goodsReceivedNoteUpdatePoItemDetailItemMaterialCode},
                    itemAlias                           : data.goodsReceivedNoteUpdatePoItemDetailItemAlias,
                    heatNo                              : data.goodsReceivedNoteUpdatePoItemDetailHeatNo,
                    rack                                : {code: data.goodsReceivedNoteUpdatePoItemDetailRackCode},
                    purchaseOrderDetailCode             : data.goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode,
                    price                               : data.goodsReceivedNoteUpdatePoItemDetailPrice,
                    quantity                            : data.goodsReceivedNoteUpdatePoItemDetailGrnQuantity,
                    discountPercent                     : data.goodsReceivedNoteUpdatePoItemDetailDiscountPercent,
                    discountAmount                      : data.goodsReceivedNoteUpdatePoItemDetailDiscountAmount,
                    nettPrice                           : data.goodsReceivedNoteUpdatePoItemDetailNettPrice,
                    totalAmount                         : data.goodsReceivedNoteUpdatePoItemDetailTotalAmount
                };
                 listGoodsReceivedNoteUpdatePoItemDetail[i] = goodsReceivedNoteUpdatePoItemDetail;
                 
                 for(var z=i+1; z<ids.length; z++){
                    var dataThen = $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getRowData', ids[z]);
                    
                    if(data.goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode === dataThen.goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode){
                        alert("PO Detail Must Be DIFFERENT");
                        return;
                    }
                }
            }
            
            var url = "inventory/goods-received-note-update-po-save";
            var params = $("#frmGoodsReceivedNoteUpdatePoInput").serialize();
                params += "& listGoodsReceivedNoteUpdatePoItemDetailJSON=" + $.toJSON( listGoodsReceivedNoteUpdatePoItemDetail);
            
            showLoading();
  
            $.post(url, params, function (data) {
                closeLoading();
                if (data.error) {
//                    formatNumericGoodsReceivedNoteUpdatePo(1);
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
                                            var url = "inventory/goods-received-note-update-po-input";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_UPDATE_PO");
                                        }
                                    },
                                    {
                                        text: "No",
                                        click: function () {
                                            $(this).dialog("close");
                                            var url = "inventory/goods-received-note-update-po";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_UPDATE_PO");
                                        }
                                    }]
                });
            });
        });
        
        $("#btnGoodsReceivedNoteUpdatePoCancel").click(function (ev) {
            var params = "";
            var url = "inventory/goods-received-note";
            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_UPDATE_PO");
        });
        
    }); //EOF Ready
        
    function goodsReceivedNoteUpdatePoItemDetailSearchPurchaseOrder_OnClick(){
      var ids = jQuery("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getDataIDs');
           
            if($("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;
                }
            }
            
            if(goodsReceivedNoteUpdatePoItemDetail_lastSel !== -1) {
                $('#goodsReceivedNoteUpdatePoItemDetailInput_grid').jqGrid("saveRow",goodsReceivedNoteUpdatePoItemDetail_lastSel);  
            }
            
           var listPurchaseOrder = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getRowData',ids[q]); 
                listPurchaseOrder[q] = [data.goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode];
//                 (listCode);
            }
        window.open("./pages/search/search-purchase-order-array.jsp?iddoc=goodsReceivedNoteUpdatePoItemDetail&type=grid","Search", "scrollbars=1,width=600, height=500");
    }    
    
    function autoLoadDataGoodsReceivedNoteUpdatePoItemDetailUpdate() {
        $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('clearGridData');
        
        var url = "inventory/goods-received-note-detail-item-detail-data";
        var params = "goodsReceivedNote.Code=" + txtGoodsReceivedNoteUpdatePoCode.val();
           
        showLoading();

        $.post(url, params, function (data) {
            
            goodsReceivedNoteUpdatePoItemDetail_lastRowId = 0;
            for (var i = 0; i < data. listGoodsReceivedNoteItemDetail.length; i++) {
                
                $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid("addRowData", goodsReceivedNoteUpdatePoItemDetail_lastRowId, data. listGoodsReceivedNoteItemDetail[i]);
                $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('setRowData', goodsReceivedNoteUpdatePoItemDetail_lastRowId, {
                  
                    goodsReceivedNoteUpdatePoItemDetailPurchaseRequestCode      : data. listGoodsReceivedNoteItemDetail[i].purchaseRequestCode,
                    goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode  : data. listGoodsReceivedNoteItemDetail[i].purchaseOrderDetailCode,
                    goodsReceivedNoteUpdatePoItemDetailItemMaterialCode         : data. listGoodsReceivedNoteItemDetail[i].itemMaterialCode,
                    goodsReceivedNoteUpdatePoItemDetailItemMaterialName         : data. listGoodsReceivedNoteItemDetail[i].itemMaterialName,
                    goodsReceivedNoteUpdatePoItemDetailItemAlias                : data. listGoodsReceivedNoteItemDetail[i].itemAlias,
                    goodsReceivedNoteUpdatePoItemDetailPODQuantity              : data. listGoodsReceivedNoteItemDetail[i].poQuantity,
                    goodsReceivedNoteUpdatePoItemDetailReceivedQuantity         : data. listGoodsReceivedNoteItemDetail[i].receivedQuantity,
                    goodsReceivedNoteUpdatePoItemDetailGrnQuantity              : data. listGoodsReceivedNoteItemDetail[i].quantity,
                    goodsReceivedNoteUpdatePoItemDetailUnitOfMeasureCode        : data. listGoodsReceivedNoteItemDetail[i].itemMaterialUnitOfMeasureCode,
                    goodsReceivedNoteUpdatePoItemDetailPrice                    : data. listGoodsReceivedNoteItemDetail[i].price,
                    goodsReceivedNoteUpdatePoItemDetailDiscountPercent          : data. listGoodsReceivedNoteItemDetail[i].discountPercent,
                    goodsReceivedNoteUpdatePoItemDetailDiscountAmount           : data. listGoodsReceivedNoteItemDetail[i].discountAmount,
                    goodsReceivedNoteUpdatePoItemDetailNettPrice                : data. listGoodsReceivedNoteItemDetail[i].nettPrice,
                    goodsReceivedNoteUpdatePoItemDetailTotalAmount              : data. listGoodsReceivedNoteItemDetail[i].totalAmount,
                    goodsReceivedNoteUpdatePoItemDetailHeatNo                   : data. listGoodsReceivedNoteItemDetail[i].heatNo,
                    goodsReceivedNoteUpdatePoItemDetailRackCode                 : data. listGoodsReceivedNoteItemDetail[i].rackCode,
                    goodsReceivedNoteUpdatePoItemDetailRackName                 : data. listGoodsReceivedNoteItemDetail[i].rackName
                    
                });
                goodsReceivedNoteUpdatePoItemDetail_lastRowId++;
            }
            closeLoading();
        });
    }
    
    function calculateGrnDetail() {
        var selectedRowID = $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid("getGridParam", "selrow");
        var data = $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid('getRowData',selectedRowID);
        var nettPrice = data.goodsReceivedNoteUpdatePoPurchaseOrderDetailNettPrice;
        var qty = ($("#" + selectedRowID + "_goodsReceivedNoteUpdatePoPurchaseOrderDetailGrnQuantity").val()!=="") ? parseFloat($("#" + selectedRowID + "_goodsReceivedNoteUpdatePoPurchaseOrderDetailGrnQuantity").val()):0.00;
        
        if(isNaN(qty)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_goodsReceivedNoteUpdatePoPurchaseOrderDetailGrnQuantity").val("");
            return;
        }
        
        var totalAmount = (parseFloat(qty) * parseFloat(nettPrice));
            
        $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid("setCell", selectedRowID, "goodsReceivedNoteUpdatePoPurchaseOrderDetailTotalAmount", totalAmount);
                
        calculateGrnHeader();    
    }
    
    function calculateGrnHeader() {
        var totalTransaction = 0;
        var ids = jQuery("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid('getDataIDs');
        for(var i=0;i < ids.length;i++) {
            var data = $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.goodsReceivedNoteUpdatePoPurchaseOrderDetailTotalAmount);
        }      
        
        var discPercent = $("#goodsReceivedNoteUpdatePo\\.discountPercent").val();
        var discAmount =  (parseFloat(discPercent) * parseFloat(totalTransaction.toFixed(2)))/100;
        var subTotalAmount = parseFloat(totalTransaction.toFixed(2)) - parseFloat(discAmount.toFixed(2));
        var vatPercent = $("#goodsReceivedNoteUpdatePo\\.vatPercent").val();
        var vatAmount = (subTotalAmount * parseFloat(vatPercent))/100;
        var grandTotal =subTotalAmount + parseFloat(vatAmount.toFixed(2));
        
        $("#goodsReceivedNoteUpdatePo\\.totalTransactionAmount").val(totalTransaction.toFixed(2));
        $("#goodsReceivedNoteUpdatePo\\.discountAmount").val(discAmount.toFixed(2));
        $("#goodsReceivedNoteUpdatePo\\.vatAmount").val(vatAmount.toFixed(2));        
        $("#goodsReceivedNoteUpdatePo\\.grandTotalAmount").val(grandTotal.toFixed(2));
    }
    
    function loadPurchaseOrderDetailGrn() {
        $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid('clearGridData');
        
        var url = "purchasing/purchase-order-detail-by-grn-data";
        var params = "purchaseOrder.code=" + txtGoodsReceivedNoteUpdatePoPurchaseOrderCode.val();
           
        showLoading();

        $.post(url, params, function (data) {
            
            goodsReceivedNoteUpdatePoPurchaseOrderDetailLastRowId = 0;
            for (var i = 0; i < data.listPurchaseOrderDetail.length; i++) {
                

                $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid("addRowData", goodsReceivedNoteUpdatePoPurchaseOrderDetailLastRowId, data.listPurchaseOrderDetail[i]);
                $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid").jqGrid('setRowData', goodsReceivedNoteUpdatePoPurchaseOrderDetailLastRowId, {
                  
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderDetailCode         : data.listPurchaseOrderDetail[i].code,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderCode               : data.listPurchaseOrderDetail[i].headerCode,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseRequestCode             : data.listPurchaseOrderDetail[i].purchaseRequestCode,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailItemAlias                       : data.listPurchaseOrderDetail[i].itemAlias,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialCode                : data.listPurchaseOrderDetail[i].itemMaterialCode,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialName                : data.listPurchaseOrderDetail[i].itemMaterialName,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailQuantity                        : data.listPurchaseOrderDetail[i].quantity,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailReceivedQuantity                : data.listPurchaseOrderDetail[i].grnQuantity,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailBalanceQuantity                 : data.listPurchaseOrderDetail[i].balanceQuantity,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailPrice                           : data.listPurchaseOrderDetail[i].price,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountPercent                 : data.listPurchaseOrderDetail[i].discountPercent,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountAmount                  : data.listPurchaseOrderDetail[i].discountAmount,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailNettPrice                       : data.listPurchaseOrderDetail[i].nettPrice,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailTotalAmount                     : data.listPurchaseOrderDetail[i].totalAmount,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureCode               : data.listPurchaseOrderDetail[i].unitOfMeasureCode,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailRemark                          : data.listPurchaseOrderDetail[i].remark,
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailRackCode                        : txtGoodsReceivedNoteUpdatePoWarehouseDockInCode.val(),
                    goodsReceivedNoteUpdatePoPurchaseOrderDetailRackName                        : txtGoodsReceivedNoteUpdatePoWarehouseDockInName.val()
                    
                });
                
                goodsReceivedNoteUpdatePoPurchaseOrderDetailLastRowId++;
            }
          
            closeLoading();
        });
    }
    
    function formatDateGoodsReceivedNoteUpdatePo() {
        var date = dtpGoodsReceivedNoteUpdatePoTransactionDate.val(); 
        var dateTemp = date.toString().split(" ");
        var splitDate = dateTemp[0].toString().split("/");
        var transDate = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2]+" "+dateTemp[1];
        dtpGoodsReceivedNoteUpdatePoTransactionDate.val(transDate);        
        $("#goodsReceivedNoteUpdatePo\\.transactionDateTemp").val(dtpGoodsReceivedNoteUpdatePoTransactionDate.val());
        
        
        var createdDate=$("#goodsReceivedNoteUpdatePo\\.createdDate").val();
        $("#goodsReceivedNoteUpdatePo\\.createdDateTemp").val(createdDate);
        
    }

    function goodsReceivedNoteUpdatePoValidateExchangeRate(currency){
        if(currency==="IDR"){
            txtGoodsReceivedNoteUpdatePoExchangeRate.val("1.00");
            txtGoodsReceivedNoteUpdatePoExchangeRate.attr('readonly',true);
        }else if(currency===""){
            txtGoodsReceivedNoteUpdatePoExchangeRate.val("0.00");
            txtGoodsReceivedNoteUpdatePoExchangeRate.attr('readonly',true);
        }else{
            txtGoodsReceivedNoteUpdatePoExchangeRate.val("0.00");
            txtGoodsReceivedNoteUpdatePoExchangeRate.attr('readonly',false);
        }
    }
    
    function formatNumericGoodsReceivedNoteUpdatePo(flag) {
        var rateValue = txtGoodsReceivedNoteUpdatePoExchangeRate.val();
        var exchangeRate;
        switch (flag) {
            case 0:
                exchangeRate = removeCommas(rateValue);
                break;
            case 1:
                exchangeRate = formatNumber(parseFloat(rateValue));
                break;
        }
        txtGoodsReceivedNoteUpdatePoExchangeRate.val(exchangeRate);
    }

    function goodsReceivedNoteUpdatePoItemDetailInputGrid_Delete_OnClick() {
        var selectDetailRowId = $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getGridParam', 'selrow');
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('delRowData', selectDetailRowId);
    }
    
    function goodsReceivedNoteUpdatePoSerialNoInputGrid_Delete_OnClick() {
        var selectDetailRowId = $("#goodsReceivedNoteUpdatePoSerialNolInput_grid").jqGrid('getGridParam', 'selrow');
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        $("#goodsReceivedNoteUpdatePoSerialNolInput_grid").jqGrid('delRowData', selectDetailRowId);
    }
    
    function setRackDataGoodsReceivedNoteUpdatePoItemDetail() {
      
            var rowDetail=0;
            var ids = jQuery("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                $("#goodsReceivedNoteUpdatePoItemDetailInput_grid").jqGrid('setRowData', rowDetail, {
                  
                    goodsReceivedNoteUpdatePoItemDetailRackCode    : txtGoodsReceivedNoteUpdatePoWarehouseDockInCode.val(),
                    goodsReceivedNoteUpdatePoItemDetailRackName    : txtGoodsReceivedNoteUpdatePoWarehouseDockInName.val()
                    
                });
                rowDetail++;
            }
        }
    
    function goodsReceivedNoteUpdatePoTransactionDateOnChange() {
        $("#goodsReceivedNoteUpdatePoTransactionDateTemp").val(dtpGoodsReceivedNoteUpdatePoTransactionDate.val());
    }
        
</script>
<b>GOODS RECEIVED NOTE</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlGoodsReceivedNoteUpdatePoPurchaseOrderDetailInput" action="" />
<s:url id="remotedetailurlGoodsReceivedNoteUpdatePoNoItemDetailInput" action="" />
<div id="goodsReceivedNoteUpdatePoInput" class="content ui-widget">
    <s:form id="frmGoodsReceivedNoteUpdatePoInput">
        <div id="div-header-goods-received-note">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                                <td align="right"><B>GRN No *</B></td>
                                <td>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.code" name="goodsReceivedNoteUpdatePo.code" size="25" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                </td>
                            </tr>  
                            <tr>
                                <td align="right"><B>POD No *</B></td>
                                <td>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="goodsReceivedNoteUpdatePo.purchaseOrder.code" name="goodsReceivedNoteUpdatePo.purchaseOrder.code" size="25" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                    </div>
                                </td>
                            </tr>  
                            <tr>
                                <td align="right">POD Date</td>
                                <td>
                                    <sj:datepicker id="goodsReceivedNoteUpdatePo.purchaseOrder.transactionDate" name="goodsReceivedNoteUpdatePo.purchaseOrder.transactionDate" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" readonly="true" disabled="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><b>Branch *</b></td>
                                <td>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.branch.code" name="goodsReceivedNoteUpdatePo.branch.code" readonly="true" required="true" cssClass="required" title="*"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.branch.name" name="goodsReceivedNoteUpdatePo.branch.name" readonly="true" size="33"></s:textfield>
                                </td>
                            </tr>
                             <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="goodsReceivedNoteUpdatePo.transactionDate" name="goodsReceivedNoteUpdatePo.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" onchange="goodsReceivedNoteUpdatePoTransactionDateOnChange()" disabled="true" readonly="true"></sj:datepicker>
                                    <sj:datepicker id="goodsReceivedNoteUpdatePoTransactionDateTemp" name="goodsReceivedNoteUpdatePoTransactionDateTemp" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right"><b>Vendor *</b></td>
                                <td>
                                <s:textfield id="goodsReceivedNoteUpdatePo.vendor.code" name="goodsReceivedNoteUpdatePo.vendor.code" readonly="true"></s:textfield>
                                <s:textfield id="goodsReceivedNoteUpdatePo.vendor.name" name="goodsReceivedNoteUpdatePo.vendor.name" size="33" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Contact Person</td>
                                <td>
                                <s:textfield id="goodsReceivedNoteUpdatePo.vendor.defaultContactPerson.name" name="goodsReceivedNoteUpdatePo.vendor.defaultContactPerson.name" size="33" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Address</td>
                                <td><s:textarea id="goodsReceivedNoteUpdatePo.vendor.address" name="goodsReceivedNoteUpdatePo.vendor.address" rows="3" cols="52" readonly="true"></s:textarea></td>
                            </tr>
                            <tr>
                                <td align="right">Phone 1</td>
                                <td><s:textfield id="goodsReceivedNoteUpdatePo.vendor.phone1" name="goodsReceivedNoteUpdatePo.vendor.phone1" readonly="true"></s:textfield> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    Phone 2
                                <s:textfield id="goodsReceivedNoteUpdatePo.vendor.phone2" name="goodsReceivedNoteUpdatePo.vendor.phone2" readonly="true"></s:textfield></td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" align="right">
                        <table>
                            <tr>
                                <td align="right"><B>Currency *</B></td>
                                <td colspan="2">
                                    <s:textfield id="goodsReceivedNoteUpdatePo.currency.code" name="goodsReceivedNoteUpdatePo.currency.code" readonly="true" size="20"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.currency.name" name="goodsReceivedNoteUpdatePo.currency.name" size="35" readonly="true"></s:textfield>
                               </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Exchange Rate *</B></td>
                                <td colspan="2">
                                    <s:textfield id="goodsReceivedNoteUpdatePo.exchangeRate" name="goodsReceivedNoteUpdatePo.exchangeRate" size="20" style="text-align: right" readonly="true"></s:textfield><b>IDR</b>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Received By</td>
                                <td><s:textfield id="goodsReceivedNoteUpdatePo.receivedBy" name="goodsReceivedNoteUpdatePo.receivedBy" size="56" readonly="true"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Vendor Do No *</B></td>
                                <td><s:textfield id="goodsReceivedNoteUpdatePo.vendorDeliveryNoteNo" name="goodsReceivedNoteUpdatePo.vendorDeliveryNoteNo" size="56" title="*" required="true" cssClass="required" readonly="true"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right">Police No </td>
                                <td><s:textfield id="goodsReceivedNoteUpdatePo.policeNo" name="goodsReceivedNoteUpdatePo.policeNo" size="56" readonly="true"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right">Container No</td>
                                <td><s:textfield id="goodsReceivedNoteUpdatePo.containerNo" name="goodsReceivedNoteUpdatePo.containerNo" size="56" readonly="true"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right"><b>Warehouse *</b></td>
                                <td>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.warehouse.code" name="goodsReceivedNoteUpdatePo.warehouse.code" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.warehouse.name" name="goodsReceivedNoteUpdatePo.warehouse.name" cssStyle="width:49%" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Dock In</td>
                                <td><s:textfield id="goodsReceivedNoteUpdatePo.warehouse.dockInCode" name="goodsReceivedNoteUpdatePo.warehouse.dockInCode" readonly="true"></s:textfield> 
                                <s:textfield id="goodsReceivedNoteUpdatePo.warehouse.dockInName" name="goodsReceivedNoteUpdatePo.warehouse.dockInName" cssStyle="width:49%" readonly="true"></s:textfield></td>
                                <s:textfield id="rackDockInName" name="rackDockInName" cssStyle="width:49%" readonly="true" hidden="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Expedition</td>
                                <td>
                                    
                                    <s:textfield id="goodsReceivedNoteUpdatePo.expedition.code" name="goodsReceivedNoteUpdatePo.expedition.code" readonly="true"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.expedition.name" name="goodsReceivedNoteUpdatePo.expedition.name" cssStyle="width:49%" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="goodsReceivedNoteUpdatePo.refNo" name="goodsReceivedNoteUpdatePo.refNo" size="56" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Remark</td>
                                <td><s:textarea id="goodsReceivedNoteUpdatePo.remark" name="goodsReceivedNoteUpdatePo.remark" rows="2" cols="52" readonly="true"></s:textarea></td>
                            </tr>
                            <tr hidden="true">
                                <td colspan="2">
                                    <s:textfield disabled="true" id="goodsReceivedNoteUpdatePo.warehouse.rack.code" name="goodsReceivedNoteUpdatePo.warehouse.rack.code" readonly="true"></s:textfield>
                                    <s:textfield disabled="true" id="goodsReceivedNoteUpdatePo.warehouse.rack.name" name="goodsReceivedNoteUpdatePo.warehouse.rack.name" readonly="true"></s:textfield>
                                    <sj:datepicker id="goodsReceivedNoteUpdatePoTransactionDateFirstSession" name="goodsReceivedNoteUpdatePoTransactionDateFirstSession" size="15" showOn="focus" ></sj:datepicker>
                                    <sj:datepicker id="goodsReceivedNoteUpdatePoTransactionDateLastSession" name="goodsReceivedNoteUpdatePoTransactionDateLastSession" size="15" showOn="focus" ></sj:datepicker>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.createdBy" name="goodsReceivedNoteUpdatePo.createdBy" key="customerPurchaseOrder.createdBy" readonly="true" size="22"></s:textfield>
                                    <sj:datepicker id="goodsReceivedNoteUpdatePo.createdDate" name="goodsReceivedNoteUpdatePo.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.createdDateTemp" name="goodsReceivedNoteUpdatePo.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.transactionDateTemp" name="goodsReceivedNoteUpdatePo.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>     
       
        <br class="spacer" />
        <div id="goodsReceivedNoteUpdatePoPurchaseOrderDetailInputGrid">
            <sjg:grid                        
                id="goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid"
                caption="Purchase Order Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel=" listGoodsReceivedNoteItemDetail"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnugoodsreceivednotebyypurchaseorder').width()"
                onSelectRowTopics="goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetail" index="goodsReceivedNoteUpdatePoPurchaseOrderDetail" key="goodsReceivedNoteUpdatePoPurchaseOrderDetail" 
                    title="" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderCode" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderCode" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderCode" 
                    title="PO Code" width="150" hidden="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseRequestCode" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseRequestCode" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseRequestCode" 
                    title="Pr Code" width="100" hidden="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderDetailCode" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderDetailCode" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderDetailCode" 
                    title="Po detail Code" width="180" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialCode" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialCode" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialCode" 
                    title="Item Material Code" width="100"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialName" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialName" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemMaterialName" 
                    title="Item Material Name" width="250" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemAlias" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemAlias" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailItemAlias" 
                    title="Item Alias" width="250"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailQuantity" id="goodsReceivedNoteUpdatePoPurchaseOrderDetailQuantity" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailQuantity" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailQuantity" 
                    title="POD Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailReceivedQuantity" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailReceivedQuantity" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailReceivedQuantity" 
                    title="Received Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailBalanceQuantity" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailBalanceQuantity" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailBalanceQuantity" 
                    title="Balance Quantity" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailGrnQuantity" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailReceivedQuantity" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailReceivedQuantity" 
                    title="Received Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailPrice" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailPrice" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailPrice" 
                    title="Price" width="120" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountPercent" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountPercent" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountPercent" 
                    title="Discount Percent" width="120" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountAmount" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountAmount" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailDiscountAmount" 
                    title="Discount Amount" width="120" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailNettPrice" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailNettPrice" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailNettPrice" 
                    title="Nett Price" width="120" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoPurchaseOrderDetailTotalAmount" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailTotalAmount" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailTotalAmount" 
                    title="Total Amount" width="120" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteUpdatePoPurchaseOrderDetailRemark" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailRemark" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailRemark" title="Remark" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureCode" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureCode" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureCode" title="UOM" width="80" 
                    edittype="text" sortable="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureName" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureName" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureName" title="UOM" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteUpdatePoPurchaseOrderDetailRackCode" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailRackCode" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailRackCode" title="Rack Code" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteUpdatePoPurchaseOrderDetailRackName" index="goodsReceivedNoteUpdatePoPurchaseOrderDetailRackName" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailRackName" title="Rack Name" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
            </sjg:grid >

        <br class="spacer" />
         
            <sjg:grid                        
                id="goodsReceivedNoteUpdatePoItemDetailInput_grid"
                caption="GRN Item Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel=" listGoodsReceivedNoteItemDetail"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnugoodsreceivednotebyypurchaseorder').width()"
                editurl="%{remotedetailurlGoodsReceivedNoteUpdatePoNoItemDetailInput}"
                onSelectRowTopics="goodsReceivedNoteUpdatePoItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetail" index="goodsReceivedNoteUpdatePoItemDetail" key="goodsReceivedNoteUpdatePoItemDetail" 
                    title="" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailPurchaseRequestCode" index="goodsReceivedNoteUpdatePoItemDetailPurchaseRequestCode" key="goodsReceivedNoteUpdatePoItemDetailPurchaseRequestCode" 
                    title="PurchaseRequestCode" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailDelete" index="goodsReceivedNoteUpdatePoItemDetailDelete" 
                    title="" width="50" editable="true" edittype="button"
                    editoptions="{onClick:'goodsReceivedNoteUpdatePoItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailItemMaterialCode" index="goodsReceivedNoteUpdatePoItemDetailItemMaterialCode" key="goodsReceivedNoteUpdatePoItemDetailItemMaterialCode" 
                    title="Item Material Code" width="100"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailItemMaterialName" index="goodsReceivedNoteUpdatePoItemDetailItemMaterialName" key="goodsReceivedNoteUpdatePoItemDetailItemMaterialName" 
                    title="Item Material Name" width="300" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailSearchPurchaseOrder" index="goodsReceivedNoteUpdatePoItemDetailSearchPurchaseOrder" title="" width="25" align="centre"
                    editable="true"
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'goodsReceivedNoteUpdatePoItemDetailSearchPurchaseOrder_OnClick()', value:'...'}"
                /> 
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode" index="goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode" key="goodsReceivedNoteUpdatePoItemDetailPurchaseOrderDetailCode" 
                    title="Po detail Code" width="200" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailItemAlias" index="goodsReceivedNoteUpdatePoItemDetailItemAlias" key="goodsReceivedNoteUpdatePoItemDetailItemAlias" 
                    title="Item Alias" width="250"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailPODQuantity" id="goodsReceivedNoteUpdatePoItemDetailPODQuantity" index="goodsReceivedNoteUpdatePoItemDetailPODQuantity" key="goodsReceivedNoteUpdatePoItemDetailPODQuantity" 
                    title="POD Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                 <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailReceivedQuantity" index="goodsReceivedNoteUpdatePoItemDetailReceivedQuantity" key="goodsReceivedNoteUpdatePoItemDetailReceivedQuantity" 
                    title="Received Qty" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                 <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailBalanceQuantity" index="goodsReceivedNoteUpdatePoItemDetailBalanceQuantity" key="goodsReceivedNoteUpdatePoItemDetailBalanceQuantity" 
                    title="Received Qty" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailGrnQuantity" index="goodsReceivedNoteUpdatePoItemDetailGrnQuantity" key="goodsReceivedNoteUpdatePoItemDetailGrnQuantity" 
                    title="GRN Quantity" width="100" sortable="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailPrice" index="goodsReceivedNoteUpdatePoItemDetailPrice" key="goodsReceivedNoteUpdatePoItemDetailPrice" 
                    title="Price" width="100" sortable="true" editable="false" edittype="text"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailDiscountPercent" index="goodsReceivedNoteUpdatePoItemDetailDiscountPercent" key="goodsReceivedNoteUpdatePoItemDetailDiscountPercent" 
                    title="Discount Percent" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailDiscountAmount" index="goodsReceivedNoteUpdatePoItemDetailDiscountAmount" key="goodsReceivedNoteUpdatePoItemDetailDiscountAmount" 
                    title="Discount Amount" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailNettPrice" index="goodsReceivedNoteUpdatePoItemDetailNettPrice" key="goodsReceivedNoteUpdatePoItemDetailNettPrice" 
                    title="Nett Price" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailTotalAmount" index="goodsReceivedNoteUpdatePoItemDetailTotalAmount" key="goodsReceivedNoteUpdatePoItemDetailTotalAmount" 
                    title="Total Amount" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailUnitOfMeasureCode" index="goodsReceivedNoteUpdatePoItemDetailUnitOfMeasureCode" key="goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureCode" title="Unit" width="100" 
                    edittype="text" sortable="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteUpdatePoItemDetailHeatNo" index="goodsReceivedNoteUpdatePoItemDetailHeatNo" key="goodsReceivedNoteUpdatePoItemDetailHeatNo" title="Heat No" width="150" editable="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteUpdatePoItemDetailRackCode" index="goodsReceivedNoteUpdatePoItemDetailRackCode" key="goodsReceivedNoteUpdatePoItemDetailRackCode" title="Rack Code" width="125" 
                    edittype="text"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteUpdatePoItemDetailRackName" index="goodsReceivedNoteUpdatePoItemDetailRackName" key="goodsReceivedNoteUpdatePoItemDetailRackName" title="Rack Name" width="150" 
                    edittype="text"
                />
            </sjg:grid >
        </div>
        <br class="spacer" />
<!--        <div>
            <table>
                <tr>
                    <td valign="top">
                    </td>
                    <td width="100%" >
                        <table align="right">
                            <tr>
                                <td align="right"><B>Total Transaction</B>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.totalTransactionAmount" name="goodsReceivedNoteUpdatePo.totalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="left"><B>Discount</B>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.discountPercent" name="goodsReceivedNoteUpdatePo.discountPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                    %
                                    <s:textfield id="goodsReceivedNoteUpdatePo.discountAmount" name="goodsReceivedNoteUpdatePo.discountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td align="right"><B>VAT</B>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.vatPercent" name="goodsReceivedNoteUpdatePo.vatPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                    %
                                    <s:textfield id="goodsReceivedNoteUpdatePo.vatAmount" name="goodsReceivedNoteUpdatePo.vatAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                                <td/>
                            </tr>
                            <tr>
                                <td align="right"><B>Grand Total</B>
                                    <s:textfield id="goodsReceivedNoteUpdatePo.grandTotalAmount" name="goodsReceivedNoteUpdatePo.grandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                                </td>
                                <td/>
                            </tr>
                        </table>
                    </td>
                </tr>            
            </table>
        </div>-->
        <br class="spacer" />
        <div>
            <table width="100%">
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                            <td><sj:a href="#" id="btnGoodsReceivedNoteUpdatePoSave" button="true" style="width: 60px">Save</sj:a></td>
                            <td><sj:a href="#" id="btnGoodsReceivedNoteUpdatePoCancel" button="true" style="width: 60px">Cancel</sj:a></td>
                            </tr>
                        </table>
                    </td>
                </tr>            
            </table>
        </div> 
    </s:form>
</div>