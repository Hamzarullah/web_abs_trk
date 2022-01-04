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
   #goodsReceivedNoteConfirmationPurchaseOrderDetailInput_grid_pager_center{
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
    
    var goodsReceivedNoteConfirmationPurchaseOrderDetailInput_lastSel = -1;
    var goodsReceivedNoteConfirmationPurchaseOrderDetailLastRowId = 0;
    var goodsReceivedNoteConfirmationItemDetail_lastSel = -1, goodsReceivedNoteConfirmationItemDetail_lastRowId=0;
    
    var
        txtGoodsReceivedNoteConfirmationCode = $("#goodsReceivedNoteConfirmation\\.code"),
        dtpGoodsReceivedNoteConfirmationTransactionDate = $("#goodsReceivedNoteConfirmation\\.transactionDate"),
        txtGoodsReceivedNoteConfirmationPurchaseOrderCode = $("#goodsReceivedNoteConfirmation\\.purchaseOrder\\.code"),
        txtGoodsReceivedNoteConfirmationExchangeRate = $("#goodsReceivedNoteConfirmation\\.exchangeRate"),
        txtGoodsReceivedNoteConfirmationReceivedBy = $("#goodsReceivedNoteConfirmation\\.receivedBy"),
        txtGoodsReceivedNoteConfirmationVendorDo = $("#goodsReceivedNoteConfirmation\\.vendorDeliveryNoteNo"),
        txtGoodsReceivedNoteConfirmationWarehouseCode = $("#goodsReceivedNoteConfirmation\\.warehouse\\.code"),
        txtGoodsReceivedNoteConfirmationWarehouseName = $("#goodsReceivedNoteConfirmation\\.warehouse\\.name"),
        txtGoodsReceivedNoteConfirmationWarehouseDockInCode = $("#goodsReceivedNoteConfirmation\\.warehouse\\.dockInCode"),
        txtGoodsReceivedNoteConfirmationWarehouseDockInName = $("#goodsReceivedNoteConfirmation\\.warehouse\\.dockInName"),
        txtGoodsReceivedNoteConfirmationExpeditionCode = $("#goodsReceivedNoteConfirmation\\.expedition\\.code"),
        txtGoodsReceivedNoteConfirmationExpeditionName = $("#goodsReceivedNoteConfirmation\\.expedition\\.name");

    $(document).ready(function () {

        hoverButton();
        flagConfirmGoodsReceivedNoteConfirmation = false;
      
        txtGoodsReceivedNoteConfirmationWarehouseDockInName.val($("#rackDockInName").val());
        goodsReceivedNoteConfirmationValidateExchangeRate($("#goodsReceivedNoteConfirmation\\.currency\\.code").val());
        
        goodsReceivedNoteConfirmationSetStatus();
        loadPurchaseOrderDetailGrn();
        autoLoadDataGoodsReceivedNoteConfirmationItemDetailUpdate();
        $('#goodsReceivedNoteConfirmationStatusRadCONFIRMED').change(function(ev){
            $("#goodsReceivedNoteConfirmation\\.confirmationStatus").val("CONFIRMED");
        });

         $('#goodsReceivedNoteConfirmationStatusRadPENDING').change(function(ev){
            $("#goodsReceivedNoteConfirmation\\.confirmationStatus").val("PENDING");
        });
        
        $.subscribe("goodsReceivedNoteConfirmationItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==goodsReceivedNoteConfirmationItemDetail_lastSel) {
                $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('saveRow',goodsReceivedNoteConfirmationItemDetail_lastSel); 
                $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                goodsReceivedNoteConfirmationItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        $("#btnGoodsReceivedNoteConfirmationSave").click(function(ev){
            if (!$("#frmGoodsReceivedNoteConfirmationInput").valid()) {
                ev.preventDefault();
                return;
            }
            
            if (goodsReceivedNoteConfirmationItemDetail_lastSel !== -1) {
                $('#goodsReceivedNoteConfirmationItemDetailInput_grid').jqGrid("saveRow", goodsReceivedNoteConfirmationItemDetail_lastSel);
            }
            
            var ids = jQuery("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getDataIDs');
            var listGoodsReceivedNoteItemDetail = new Array();
            
            if (ids.length === 0) {
                alertMessage("Data Grid GRN Detail Non Serial NoCan't Empty!");
                return;
            }
           
            var ids = jQuery("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var data = $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getRowData', ids[i]);
                
                if(data.goodsReceivedNoteConfirmationItemDetailPurchaseOrderDetailCode === ""){
                    alertMessage("You should fill Purchase Order first");
                    return;
                }
                
                var goodsReceivedNoteConfirmationItemDetail = {
                    itemMaterial                        : {code: data.goodsReceivedNoteConfirmationItemDetailItemMaterialCode},
                    itemAlias                           : data.goodsReceivedNoteConfirmationItemDetailItemAlias,
                    heatNo                              : data.goodsReceivedNoteConfirmationItemDetailHeatNo,
                    batchNo                             : data.goodsReceivedNoteConfirmationItemDetailBatchNo,
                    purchaseRequestCode                 : data.goodsReceivedNoteConfirmationItemDetailPurchaseRequestCode,
                    rack                                : {code: data.goodsReceivedNoteConfirmationItemDetailRackCode},
                    purchaseOrderDetailCode             : data.goodsReceivedNoteConfirmationItemDetailPurchaseOrderDetailCode,
                    price                               : data.goodsReceivedNoteConfirmationItemDetailPrice,
                    quantity                            : data.goodsReceivedNoteConfirmationItemDetailGrnQuantity,
                    discountPercent                     : data.goodsReceivedNoteConfirmationItemDetailDiscountPercent,
                    discountAmount                      : data.goodsReceivedNoteConfirmationItemDetailDiscountAmount,
                    nettPrice                           : data.goodsReceivedNoteConfirmationItemDetailNettPrice,
                    totalAmount                         : data.goodsReceivedNoteConfirmationItemDetailTotalAmount
                    
                };
                listGoodsReceivedNoteItemDetail[i] = goodsReceivedNoteConfirmationItemDetail;
            }
            
            formatDateGoodsReceivedNoteConfirmation();
//            formatNumericGoodsReceivedNoteConfirmation(0);
            var url = "inventory/goods-received-note-confirmation-save";
            var params = $("#frmGoodsReceivedNoteConfirmationInput").serialize();
                params += "&listGoodsReceivedNoteConfirmationItemDetailJSON=" + $.toJSON(listGoodsReceivedNoteItemDetail);
            
            showLoading();
  
            $.post(url, params, function (data) {
                closeLoading();
                if (data.error) {
                    formatDateGoodsReceivedNoteConfirmation();
//                    formatNumericGoodsReceivedNoteConfirmation(1);
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
                                            var url = "inventory/goods-received-note-confirmation-input";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_CONFIRMATION");
                                        }
                                    },
                                    {
                                        text: "No",
                                        click: function () {
                                            $(this).dialog("close");
                                            var url = "inventory/goods-received-note-confirmation";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_CONFIRMATION");
                                        }
                                    }]
                });
            });
        });
        
        $("#btnGoodsReceivedNoteConfirmationCancel").click(function (ev) {
            var params = "";
            var url = "inventory/goods-received-note-confirmation";
            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_CONFIRMATION");
        });
        
    }); //EOF Ready
        
    function goodsReceivedNoteConfirmationItemDetailSearchPurchaseOrder_OnClick(){
      var ids = jQuery("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getDataIDs');
           
            if($("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Item Delivery Date Can't Be Empty!");
                return;
                }
            }
            
            if(goodsReceivedNoteConfirmationItemDetail_lastSel !== -1) {
                $('#goodsReceivedNoteConfirmationItemDetailInput_grid').jqGrid("saveRow",goodsReceivedNoteConfirmationItemDetail_lastSel);  
            }
            
           var listPurchaseOrder = new Array();
           for(var q=0;q < ids.length;q++){ 
                var data = $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getRowData',ids[q]); 
                listPurchaseOrder[q] = [data.goodsReceivedNoteConfirmationItemDetailPurchaseOrderDetailCode];
//                 (listCode);
            }
        window.open("./pages/search/search-purchase-order-array.jsp?iddoc=goodsReceivedNoteConfirmationItemDetail&type=grid","Search", "scrollbars=1,width=600, height=500");
    }    
    
    function autoLoadDataGoodsReceivedNoteConfirmationItemDetailUpdate() {
        $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('clearGridData');
        
        var url = "inventory/goods-received-note-detail-item-detail-data";
        var params = "goodsReceivedNote.Code=" + txtGoodsReceivedNoteConfirmationCode.val();
        params+="&goodsReceivedNote.PurchaseOrderCode="+ txtGoodsReceivedNoteConfirmationPurchaseOrderCode.val();
           
        showLoading();

        $.post(url, params, function (data) {
            
            goodsReceivedNoteConfirmationItemDetail_lastRowId = 0;
            for (var i = 0; i < data.listGoodsReceivedNoteItemDetail.length; i++) {
                
                $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid("addRowData", goodsReceivedNoteConfirmationItemDetail_lastRowId, data.listGoodsReceivedNoteItemDetail[i]);
                $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('setRowData', goodsReceivedNoteConfirmationItemDetail_lastRowId, {
                  
                    goodsReceivedNoteConfirmationItemDetailPurchaseRequestCode      : data.listGoodsReceivedNoteItemDetail[i].purchaseRequestCode,
                    goodsReceivedNoteConfirmationItemDetailPurchaseOrderDetailCode  : data.listGoodsReceivedNoteItemDetail[i].purchaseOrderDetailCode,
                    goodsReceivedNoteConfirmationItemDetailItemMaterialCode         : data.listGoodsReceivedNoteItemDetail[i].itemMaterialCode,
                    goodsReceivedNoteConfirmationItemDetailItemMaterialName         : data.listGoodsReceivedNoteItemDetail[i].itemMaterialName,
                    goodsReceivedNoteConfirmationItemDetailItemAlias                : data.listGoodsReceivedNoteItemDetail[i].itemAlias,
                    goodsReceivedNoteConfirmationItemDetailPODQuantity              : data.listGoodsReceivedNoteItemDetail[i].poQuantity,
                    goodsReceivedNoteConfirmationItemDetailReceivedQuantity         : data.listGoodsReceivedNoteItemDetail[i].receivedQuantity,
                    goodsReceivedNoteConfirmationItemDetailGrnQuantity              : data.listGoodsReceivedNoteItemDetail[i].quantity,
                    goodsReceivedNoteConfirmationItemDetailUnitOfMeasureCode        : data.listGoodsReceivedNoteItemDetail[i].itemMaterialUnitOfMeasureCode,
                    goodsReceivedNoteConfirmationItemDetailPrice                    : data.listGoodsReceivedNoteItemDetail[i].price,
                    goodsReceivedNoteConfirmationItemDetailDiscountPercent          : data.listGoodsReceivedNoteItemDetail[i].discountPercent,
                    goodsReceivedNoteConfirmationItemDetailDiscountAmount           : data.listGoodsReceivedNoteItemDetail[i].discountAmount,
                    goodsReceivedNoteConfirmationItemDetailNettPrice                : data.listGoodsReceivedNoteItemDetail[i].nettPrice,
                    goodsReceivedNoteConfirmationItemDetailTotalAmount              : data.listGoodsReceivedNoteItemDetail[i].totalAmount,
                    goodsReceivedNoteConfirmationItemDetailHeatNo                   : data.listGoodsReceivedNoteItemDetail[i].heatNo,
                    goodsReceivedNoteConfirmationItemDetailBatchNo                  : data.listGoodsReceivedNoteItemDetail[i].batchNo,
                    goodsReceivedNoteConfirmationItemDetailRackCode                 : data.listGoodsReceivedNoteItemDetail[i].rackCode,
                    goodsReceivedNoteConfirmationItemDetailRackName                 : data.listGoodsReceivedNoteItemDetail[i].rackName
                    
                });
                goodsReceivedNoteConfirmationItemDetail_lastRowId++;
            }
           
            closeLoading();
        });
    }
    
    function calculateGRNConfirmDetail() {
        var selectedRowID = $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var data = $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getRowData',selectedRowID);
        var nettPrice = data.goodsReceivedNoteConfirmationItemDetailNettPrice;
        var qty = $("#" + selectedRowID + "_goodsReceivedNoteConfirmationItemDetailGrnQuantity").val();
      
        if(isNaN(qty)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_goodsReceivedNoteConfirmationItemDetailGrnQuantity").val("");
            return;
        }
        
        var totalAmount = (parseFloat(qty) * parseFloat(nettPrice));
        
        $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid("setCell", selectedRowID, "goodsReceivedNoteConfirmationItemDetailTotalAmount", totalAmount);
                
        calculateGrnConfirmHeader();    
    }
    
    function calculateGrnConfirmHeader() {
        var totalTransaction = 0;
        var ids = jQuery("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getDataIDs');
        for(var i=0;i < ids.length;i++) {
            var data = $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.goodsReceivedNoteConfirmationItemDetailTotalAmount);
        }      
        
        var discPercent = $("#goodsReceivedNoteConfirmation\\.discountPercent").val();
        var discAmount =  (parseFloat(discPercent) * parseFloat(totalTransaction.toFixed(2)))/100;
        var subTotalAmount = parseFloat(totalTransaction.toFixed(2)) - parseFloat(discAmount.toFixed(2));
        var vatPercent = $("#goodsReceivedNoteConfirmation\\.vatPercent").val();
        var vatAmount = (subTotalAmount * parseFloat(vatPercent))/100;
        var grandTotal =subTotalAmount + parseFloat(vatAmount.toFixed(2));
        
        $("#goodsReceivedNoteConfirmation\\.totalTransactionAmount").val(totalTransaction.toFixed(2));
        $("#goodsReceivedNoteConfirmation\\.discountAmount").val(discAmount.toFixed(2));
        $("#goodsReceivedNoteConfirmation\\.vatAmount").val(vatAmount.toFixed(2));        
        $("#goodsReceivedNoteConfirmation\\.grandTotalAmount").val(grandTotal.toFixed(2));
    }
    
    function loadPurchaseOrderDetailGrn() {
        $("#goodsReceivedNoteConfirmationPurchaseOrderDetailInput_grid").jqGrid('clearGridData');
        
        var url = "purchasing/purchase-order-detail-by-grn-data";
        var params = "purchaseOrder.code=" + txtGoodsReceivedNoteConfirmationPurchaseOrderCode.val();
           
        showLoading();

        $.post(url, params, function (data) {
            
            goodsReceivedNoteConfirmationPurchaseOrderDetailLastRowId = 0;
            for (var i = 0; i < data.listPurchaseOrderDetail.length; i++) {
                

                $("#goodsReceivedNoteConfirmationPurchaseOrderDetailInput_grid").jqGrid("addRowData", goodsReceivedNoteConfirmationPurchaseOrderDetailLastRowId, data.listPurchaseOrderDetail[i]);
                $("#goodsReceivedNoteConfirmationPurchaseOrderDetailInput_grid").jqGrid('setRowData', goodsReceivedNoteConfirmationPurchaseOrderDetailLastRowId, {
                  
                    goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderDetailCode         : data.listPurchaseOrderDetail[i].code,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderCode               : data.listPurchaseOrderDetail[i].headerCode,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseRequestCode             : data.listPurchaseOrderDetail[i].purchaseRequestCode,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailItemAlias                       : data.listPurchaseOrderDetail[i].itemAlias,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialCode                : data.listPurchaseOrderDetail[i].itemMaterialCode,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialName                : data.listPurchaseOrderDetail[i].itemMaterialName,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailSerialStatus                    : data.listPurchaseOrderDetail[i].itemMaterialSerialStatus,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailQuantity                        : data.listPurchaseOrderDetail[i].quantity,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailReceivedQuantity                : data.listPurchaseOrderDetail[i].grnQuantity,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailBalanceQuantity                 : data.listPurchaseOrderDetail[i].balanceQuantity,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailPrice                           : data.listPurchaseOrderDetail[i].price,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountPercent                 : data.listPurchaseOrderDetail[i].discountPercent,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountAmount                  : data.listPurchaseOrderDetail[i].discountAmount,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailNettPrice                       : data.listPurchaseOrderDetail[i].nettPrice,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailTotalAmount                     : data.listPurchaseOrderDetail[i].totalAmount,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureCode               : data.listPurchaseOrderDetail[i].unitOfMeasureCode,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailRemark                          : data.listPurchaseOrderDetail[i].remark,
                    goodsReceivedNoteConfirmationPurchaseOrderDetailRackCode                        : txtGoodsReceivedNoteConfirmationWarehouseDockInCode.val(),
                    goodsReceivedNoteConfirmationPurchaseOrderDetailRackName                        : txtGoodsReceivedNoteConfirmationWarehouseDockInName.val()
                    
                });
                
                goodsReceivedNoteConfirmationPurchaseOrderDetailLastRowId++;
            }
          
            closeLoading();
        });
    }
    
    function formatDateGoodsReceivedNoteConfirmation() {
        var date = dtpGoodsReceivedNoteConfirmationTransactionDate.val(); 
        var dateTemp = date.toString().split(" ");
        var splitDate = dateTemp[0].toString().split("/");
        var transDate = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2]+" "+dateTemp[1];
        dtpGoodsReceivedNoteConfirmationTransactionDate.val(transDate);        
        $("#goodsReceivedNoteConfirmation\\.transactionDateTemp").val(dtpGoodsReceivedNoteConfirmationTransactionDate.val());
        
        
        var createdDate=$("#goodsReceivedNoteConfirmation\\.createdDate").val();
        $("#goodsReceivedNoteConfirmation\\.createdDateTemp").val(createdDate);
        
    }

    function goodsReceivedNoteConfirmationValidateExchangeRate(currency){
        if(currency==="IDR"){
            txtGoodsReceivedNoteConfirmationExchangeRate.val("1.00");
            txtGoodsReceivedNoteConfirmationExchangeRate.attr('readonly',true);
        }else if(currency===""){
            txtGoodsReceivedNoteConfirmationExchangeRate.val("0.00");
            txtGoodsReceivedNoteConfirmationExchangeRate.attr('readonly',true);
        }else{
            txtGoodsReceivedNoteConfirmationExchangeRate.val("0.00");
            txtGoodsReceivedNoteConfirmationExchangeRate.attr('readonly',false);
        }
    }
    
    function formatNumericGoodsReceivedNoteConfirmation(flag) {
        var rateValue = txtGoodsReceivedNoteConfirmationExchangeRate.val();
        var exchangeRate;
        switch (flag) {
            case 0:
                exchangeRate = removeCommas(rateValue);
                break;
            case 1:
                exchangeRate = formatNumber(parseFloat(rateValue));
                break;
        }
        txtGoodsReceivedNoteConfirmationExchangeRate.val(exchangeRate);
    }
    
    function setRackDataGoodsReceivedNoteConfirmationItemDetail() {
      
            var rowDetail=0;
            var ids = jQuery("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                $("#goodsReceivedNoteConfirmationItemDetailInput_grid").jqGrid('setRowData', rowDetail, {
                  
                    goodsReceivedNoteConfirmationItemDetailRackCode    : txtGoodsReceivedNoteConfirmationWarehouseDockInCode.val(),
                    goodsReceivedNoteConfirmationItemDetailRackName    : txtGoodsReceivedNoteConfirmationWarehouseDockInName.val()
                    
                });
                rowDetail++;
            }
        }
    
    function goodsReceivedNoteConfirmationTransactionDateOnChange() {
        $("#goodsReceivedNoteConfirmationTransactionDateTemp").val(dtpGoodsReceivedNoteConfirmationTransactionDate.val());
    }
    
    function goodsReceivedNoteConfirmationSetStatus(){
        switch($("#goodsReceivedNoteConfirmation\\.confirmationStatus").val()){
            case "CONFIRMED":
                $('input[name="goodsReceivedNoteConfirmationStatusRad"][value="CONFIRMED"]').prop('checked',true);
                break;
            case "PENDING":
                $('input[name="goodsReceivedNoteConfirmationStatusRad"][value="PENDING"]').prop('checked',true);
                break;
        } 
    }
        
</script>
<b>GOODS RECEIVED NOTE</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlGoodsReceivedNoteConfirmationPurchaseOrderDetailInput" action="" />
<s:url id="remotedetailurlGoodsReceivedNoteConfirmationNoItemDetailInput" action="" />
<s:url id="remotedetailurlGoodsReceivedNoteConfirmationSerialNoInput" action="" />
<div id="goodsReceivedNoteConfirmationInput" class="content ui-widget">
    <s:form id="frmGoodsReceivedNoteConfirmationInput">
        <div id="div-header-goods-received-note">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                                <td align="right"><B>GRN No *</B></td>
                                <td>
                                    <s:textfield id="goodsReceivedNoteConfirmation.code" name="goodsReceivedNoteConfirmation.code" size="25" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                </td>
                            </tr>  
                            <tr>
                                <td align="right"><B>POD No *</B></td>
                                <td>
                                        <s:textfield id="goodsReceivedNoteConfirmation.purchaseOrder.code" name="goodsReceivedNoteConfirmation.purchaseOrder.code" size="25" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                </td>
                            </tr>  
                            <tr>
                                <td align="right">POD Date</td>
                                <td>
                                    <sj:datepicker id="goodsReceivedNoteConfirmation.purchaseOrder.transactionDate" name="goodsReceivedNoteConfirmation.purchaseOrder.transactionDate" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" readonly="true" disabled="true"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><b>Branch *</b></td>
                                <td>
                                    <s:textfield id="goodsReceivedNoteConfirmation.branch.code" name="goodsReceivedNoteConfirmation.branch.code" readonly="true" required="true" cssClass="required" title="*"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteConfirmation.branch.name" name="goodsReceivedNoteConfirmation.branch.name" readonly="true" size="33"></s:textfield>
                                </td>
                            </tr>
                             <tr>
                                <td align="right"><B>Transaction Date*</B></td>
                                <td>
                                    <sj:datepicker id="goodsReceivedNoteConfirmation.transactionDate" name="goodsReceivedNoteConfirmation.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" readonly="true" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" onchange="goodsReceivedNoteConfirmationTransactionDateOnChange()" disabled="true" ></sj:datepicker>
                                    <sj:datepicker id="goodsReceivedNoteConfirmationTransactionDateTemp" name="goodsReceivedNoteConfirmationTransactionDateTemp" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker>
                                    <s:textfield id="goodsReceivedNoteConfirmation.transactionDateTemp" name="goodsReceivedNoteConfirmation.transactionDateTemp" cssStyle="display:none"></s:textfield>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right"><b>Vendor *</b></td>
                                <td>
                                <s:textfield id="goodsReceivedNoteConfirmation.vendor.code" name="goodsReceivedNoteConfirmation.vendor.code" readonly="true"></s:textfield>
                                <s:textfield id="goodsReceivedNoteConfirmation.vendor.name" name="goodsReceivedNoteConfirmation.vendor.name" size="33" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Contact Person</td>
                                <td>
                                <s:textfield id="goodsReceivedNoteConfirmation.vendor.defaultContactPerson.name" name="goodsReceivedNoteConfirmation.vendor.defaultContactPerson.name" size="33" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Address</td>
                                <td><s:textarea id="goodsReceivedNoteConfirmation.vendor.address" name="goodsReceivedNoteConfirmation.vendor.address" rows="3" cols="52" readonly="true"></s:textarea></td>
                            </tr>
                            <tr>
                                <td align="right">Phone 1</td>
                                <td><s:textfield id="goodsReceivedNoteConfirmation.vendor.phone1" name="goodsReceivedNoteConfirmation.vendor.phone1" readonly="true"></s:textfield> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    Phone 2
                                <s:textfield id="goodsReceivedNoteConfirmation.vendor.phone2" name="goodsReceivedNoteConfirmation.vendor.phone2" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Status</B></td>
                                <td><s:radio id="goodsReceivedNoteConfirmationStatusRad" name="goodsReceivedNoteConfirmationStatusRad" list="{'CONFIRMED','PENDING'}"></s:radio></td>
                                <td>
                                <s:textfield id="goodsReceivedNoteConfirmation.confirmationStatus" name="goodsReceivedNoteConfirmation.confirmationStatus" required="true" size="50" style="display:none"></s:textfield>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" align="right">
                        <table>
                            <tr>
                                <td align="right"><B>Currency *</B></td>
                                <td colspan="2">
                                    <s:textfield id="goodsReceivedNoteConfirmation.currency.code" name="goodsReceivedNoteConfirmation.currency.code" readonly="true" size="20"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteConfirmation.currency.name" name="goodsReceivedNoteConfirmation.currency.name" size="35" readonly="true"></s:textfield>
                               </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Exchange Rate *</B></td>
                                <td colspan="2">
                                    <s:textfield id="goodsReceivedNoteConfirmation.exchangeRate" name="goodsReceivedNoteConfirmation.exchangeRate" size="20" style="text-align: right"></s:textfield><b>IDR</b>
                                </td>
                            </tr>
                            <tr hidden="true">
                                <td align="right">Received By</td>
                                <td><s:textfield id="goodsReceivedNoteConfirmation.receivedBy" name="goodsReceivedNoteConfirmation.receivedBy" size="56" readonly="true"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Vendor Do No *</B></td>
                                <td><s:textfield id="goodsReceivedNoteConfirmation.vendorDeliveryNoteNo" name="goodsReceivedNoteConfirmation.vendorDeliveryNoteNo" readonly="true" size="56" title="*" required="true" cssClass="required"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right">Police No </td>
                                <td><s:textfield id="goodsReceivedNoteConfirmation.policeNo" name="goodsReceivedNoteConfirmation.policeNo" size="56" readonly="true"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right">Container No</td>
                                <td><s:textfield id="goodsReceivedNoteConfirmation.containerNo" name="goodsReceivedNoteConfirmation.containerNo" size="56" readonly="true"></s:textfield> </td>
                            </tr>
                            <tr>
                                <td align="right"><b>Warehouse *</b></td>
                                <td>
                                    <s:textfield id="goodsReceivedNoteConfirmation.warehouse.code" name="goodsReceivedNoteConfirmation.warehouse.code" required="true" cssClass="required" title="*" readonly="true"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteConfirmation.warehouse.name" name="goodsReceivedNoteConfirmation.warehouse.name" cssStyle="width:49%" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Dock In</td>
                                <td><s:textfield id="goodsReceivedNoteConfirmation.warehouse.dockInCode" name="goodsReceivedNoteConfirmation.warehouse.dockInCode" readonly="true"></s:textfield> 
                                <s:textfield id="goodsReceivedNoteConfirmation.warehouse.dockInName" name="goodsReceivedNoteConfirmation.warehouse.dockInName" cssStyle="width:49%" readonly="true"></s:textfield></td>
                                <s:textfield id="rackDockInName" name="rackDockInName" cssStyle="width:49%" readonly="true" hidden="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Expedition</td>
                                <td>
                                    <s:textfield id="goodsReceivedNoteConfirmation.expedition.code" name="goodsReceivedNoteConfirmation.expedition.code" readonly="true"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteConfirmation.expedition.name" name="goodsReceivedNoteConfirmation.expedition.name" cssStyle="width:49%" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="goodsReceivedNoteConfirmation.refNo" name="goodsReceivedNoteConfirmation.refNo" size="56" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Remark</td>
                                <td><s:textarea id="goodsReceivedNoteConfirmation.remark" name="goodsReceivedNoteConfirmation.remark" rows="2" cols="52" readonly="true"></s:textarea></td>
                            </tr>
                            <tr hidden="true">
                                <td colspan="2">
                                    <s:textfield disabled="true" id="goodsReceivedNoteConfirmation.warehouse.rack.code" name="goodsReceivedNoteConfirmation.warehouse.rack.code" readonly="true"></s:textfield>
                                    <s:textfield disabled="true" id="goodsReceivedNoteConfirmation.warehouse.rack.name" name="goodsReceivedNoteConfirmation.warehouse.rack.name" readonly="true"></s:textfield>
                                    <s:textfield id="enumGoodsReceivedNoteConfirmationActivity" name="enumGoodsReceivedNoteConfirmationActivity" size="5" style="display:none"></s:textfield>
                                    <sj:datepicker id="goodsReceivedNoteConfirmationTransactionDateFirstSession" name="goodsReceivedNoteConfirmationTransactionDateFirstSession" size="15" showOn="focus" ></sj:datepicker>
                                    <sj:datepicker id="goodsReceivedNoteConfirmationTransactionDateLastSession" name="goodsReceivedNoteConfirmationTransactionDateLastSession" size="15" showOn="focus" ></sj:datepicker>
                                    <s:textfield id="goodsReceivedNoteConfirmation.createdBy" name="goodsReceivedNoteConfirmation.createdBy" key="customerPurchaseOrder.createdBy" readonly="true" size="22"></s:textfield>
                                    <sj:datepicker id="goodsReceivedNoteConfirmation.createdDate" name="goodsReceivedNoteConfirmation.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                                    <s:textfield id="goodsReceivedNoteConfirmation.createdDateTemp" name="goodsReceivedNoteConfirmation.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                                    <s:textfield id="goodsReceivedNoteConfirmation.transactionDateTemp" name="goodsReceivedNoteConfirmation.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        
        <br class="spacer" />
        <div id="goodsReceivedNoteConfirmationPurchaseOrderDetailInputGrid">
            <sjg:grid                        
                id="goodsReceivedNoteConfirmationPurchaseOrderDetailInput_grid"
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
                width="$('#tabmnugoodsreceivednotebyypurchaseorder').width()"
                editurl="%{remotedetailurlGoodsReceivedNoteConfirmationPurchaseOrderDetailInput}"
                onSelectRowTopics="goodsReceivedNoteConfirmationPurchaseOrderDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetail" index="goodsReceivedNoteConfirmationPurchaseOrderDetail" key="goodsReceivedNoteConfirmationPurchaseOrderDetail" 
                    title="" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderCode" index="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderCode" key="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderCode" 
                    title="PO Code" width="100" hidden="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseRequestCode" index="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseRequestCode" key="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseRequestCode" 
                    title="Pr Code" width="100" hidden="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderDetailCode" index="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderDetailCode" key="goodsReceivedNoteConfirmationPurchaseOrderDetailPurchaseOrderDetailCode" 
                    title="PO detail Code" width="180" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialCode" index="goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialCode" key="goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialCode" 
                    title="Item Material Code" width="100"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialName" index="goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialName" key="goodsReceivedNoteConfirmationPurchaseOrderDetailItemMaterialName" 
                    title="Item Material Name" width="250" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailItemAlias" index="goodsReceivedNoteConfirmationPurchaseOrderDetailItemAlias" key="goodsReceivedNoteConfirmationPurchaseOrderDetailItemAlias" 
                    title="Item Alias" width="250"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailQuantity" id="goodsReceivedNoteConfirmationPurchaseOrderDetailQuantity" index="goodsReceivedNoteConfirmationPurchaseOrderDetailQuantity" key="goodsReceivedNoteConfirmationPurchaseOrderDetailQuantity" 
                    title="POD Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailReceivedQuantity" index="goodsReceivedNoteConfirmationPurchaseOrderDetailReceivedQuantity" key="goodsReceivedNoteConfirmationPurchaseOrderDetailReceivedQuantity" 
                    title="Received Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailBalanceQuantity" index="goodsReceivedNoteConfirmationPurchaseOrderDetailBalanceQuantity" key="goodsReceivedNoteConfirmationPurchaseOrderDetailBalanceQuantity" 
                    title="Balance Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailPrice" index="goodsReceivedNoteConfirmationPurchaseOrderDetailPrice" key="goodsReceivedNoteConfirmationPurchaseOrderDetailPrice" 
                    title="Price" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountPercent" index="goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountPercent" key="goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountPercent" 
                    title="Discount Percent" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountAmount" index="goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountAmount" key="goodsReceivedNoteConfirmationPurchaseOrderDetailDiscountAmount" 
                    title="Discount Amount" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailNettPrice" index="goodsReceivedNoteConfirmationPurchaseOrderDetailNettPrice" key="goodsReceivedNoteConfirmationPurchaseOrderDetailNettPrice" 
                    title="Nett Price" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationPurchaseOrderDetailTotalAmount" index="goodsReceivedNoteConfirmationPurchaseOrderDetailTotalAmount" key="goodsReceivedNoteConfirmationPurchaseOrderDetailTotalAmount" 
                    title="Total Amount" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteConfirmationPurchaseOrderDetailRemark" index="goodsReceivedNoteConfirmationPurchaseOrderDetailRemark" key="goodsReceivedNoteConfirmationPurchaseOrderDetailRemark" title="Remark" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureCode" index="goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureCode" key="goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureCode" title="UOM" width="100" 
                    edittype="text" sortable="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureName" index="goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureName" key="goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureName" title="UOM" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteConfirmationPurchaseOrderDetailRackCode" index="goodsReceivedNoteConfirmationPurchaseOrderDetailRackCode" key="goodsReceivedNoteConfirmationPurchaseOrderDetailRackCode" title="Rack Code" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteConfirmationPurchaseOrderDetailRackName" index="goodsReceivedNoteConfirmationPurchaseOrderDetailRackName" key="goodsReceivedNoteConfirmationPurchaseOrderDetailRackName" title="Rack Name" width="100" 
                    edittype="text" sortable="true" hidden="true"
                />
            </sjg:grid >       
        <br class="spacer" />
        
            <sjg:grid                        
                id="goodsReceivedNoteConfirmationItemDetailInput_grid"
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
                editurl="%{remotedetailurlGoodsReceivedNoteConfirmationNoItemDetailInput}"
                onSelectRowTopics="goodsReceivedNoteConfirmationItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetail" index="goodsReceivedNoteConfirmationItemDetail" key="goodsReceivedNoteConfirmationItemDetail" 
                    title="" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailPurchaseRequestCode" index="goodsReceivedNoteConfirmationItemDetailPurchaseRequestCode" key="goodsReceivedNoteConfirmationItemDetailPurchaseRequestCode" 
                    title="PurchaseRequestCode" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailItemMaterialCode" index="goodsReceivedNoteConfirmationItemDetailItemMaterialCode" key="goodsReceivedNoteConfirmationItemDetailItemMaterialCode" 
                    title="Item Material Code" width="100"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailItemMaterialName" index="goodsReceivedNoteConfirmationItemDetailItemMaterialName" key="goodsReceivedNoteConfirmationItemDetailItemMaterialName" 
                    title="Item Material Name" width="300" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailSearchPurchaseOrder" index="goodsReceivedNoteConfirmationItemDetailSearchPurchaseOrder" title="" width="25" align="centre"
                    editable="true"
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'goodsReceivedNoteConfirmationItemDetailSearchPurchaseOrder_OnClick()', value:'...'}"
                /> 
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailPurchaseOrderDetailCode" index="goodsReceivedNoteConfirmationItemDetailPurchaseOrderDetailCode" key="goodsReceivedNoteConfirmationItemDetailPurchaseOrderDetailCode" 
                    title="Po detail Code" width="200" 
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailItemAlias" index="goodsReceivedNoteConfirmationItemDetailItemAlias" key="goodsReceivedNoteConfirmationItemDetailItemAlias" 
                    title="Item Alias" width="250"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailPODQuantity" id="goodsReceivedNoteConfirmationItemDetailPODQuantity" index="goodsReceivedNoteConfirmationItemDetailPODQuantity" key="goodsReceivedNoteConfirmationItemDetailPODQuantity" 
                    title="POD Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailReceivedQuantity" index="goodsReceivedNoteConfirmationItemDetailReceivedQuantity" key="goodsReceivedNoteConfirmationItemDetailReceivedQuantity" 
                    title="Received Qty" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailBalanceQuantity" index="goodsReceivedNoteConfirmationItemDetailBalanceQuantity" key="goodsReceivedNoteConfirmationItemDetailBalanceQuantity" 
                    title="Balance Qty" width="100" sortable="true" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailGrnQuantity" index="goodsReceivedNoteConfirmationItemDetailGrnQuantity" key="goodsReceivedNoteConfirmationItemDetailGrnQuantity" 
                    title="GRN Quantity" width="100" sortable="true" editable="true" edittype="text"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    editoptions="{onKeyUp:'calculateGRNConfirmDetail()'}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailPrice" index="goodsReceivedNoteConfirmationItemDetailPrice" key="goodsReceivedNoteConfirmationItemDetailPrice" 
                    title="Price" width="100" sortable="true" editable="false" edittype="text" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailDiscountPercent" index="goodsReceivedNoteConfirmationItemDetailDiscountPercent" key="goodsReceivedNoteConfirmationItemDetailDiscountPercent" 
                    title="Discount Percent" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailDiscountAmount" index="goodsReceivedNoteConfirmationItemDetailDiscountAmount" key="goodsReceivedNoteConfirmationItemDetailDiscountAmount" 
                    title="Discount Amount" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailNettPrice" index="goodsReceivedNoteConfirmationItemDetailNettPrice" key="goodsReceivedNoteConfirmationItemDetailNettPrice" 
                    title="Nett Price" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailTotalAmount" index="goodsReceivedNoteConfirmationItemDetailTotalAmount" key="goodsReceivedNoteConfirmationItemDetailTotalAmount" 
                    title="Total Amount" width="100" sortable="true" editable="false" edittype="text" hidden="true"
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailUnitOfMeasureCode" index="goodsReceivedNoteConfirmationItemDetailUnitOfMeasureCode" key="goodsReceivedNoteConfirmationPurchaseOrderDetailUnitOfMeasureCode" title="Unit" width="100" 
                    edittype="text" sortable="true"
                />
                <sjg:gridColumn
                    name="goodsReceivedNoteConfirmationItemDetailHeatNo" index="goodsReceivedNoteConfirmationItemDetailHeatNo" key="goodsReceivedNoteConfirmationItemDetailHeatNo" title="Heat No" width="150" 
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteConfirmationItemDetailRackCode" index="goodsReceivedNoteConfirmationItemDetailRackCode" key="goodsReceivedNoteConfirmationItemDetailRackCode" title="Rack Code" width="125" 
                    edittype="text"
                />
                <sjg:gridColumn
                    name = "goodsReceivedNoteConfirmationItemDetailRackName" index="goodsReceivedNoteConfirmationItemDetailRackName" key="goodsReceivedNoteConfirmationItemDetailRackName" title="Rack Name" width="150" 
                    edittype="text"
                />
            </sjg:grid >
        </div>
        <br class="spacer" />
        <br class="spacer" />
        <div>
            <table>
                <tr>
                    <td valign="top">
                    </td>
                    <td width="100%" >
                        <table align="right">
                            <tr>
                                <td align="right"><B>Total Transaction</B>
                                    <s:textfield id="goodsReceivedNoteConfirmation.totalTransactionAmount" name="goodsReceivedNoteConfirmation.totalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="left"><B>Discount</B>
                                    <s:textfield id="goodsReceivedNoteConfirmation.discountPercent" name="goodsReceivedNoteConfirmation.discountPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                    %
                                    <s:textfield id="goodsReceivedNoteConfirmation.discountAmount" name="goodsReceivedNoteConfirmation.discountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td align="right"><B>VAT</B>
                                    <s:textfield id="goodsReceivedNoteConfirmation.vatPercent" name="goodsReceivedNoteConfirmation.vatPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                    %
                                    <s:textfield id="goodsReceivedNoteConfirmation.vatAmount" name="goodsReceivedNoteConfirmation.vatAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                                </td>
                                <td/>
                            </tr>
                            <tr>
                                <td align="right"><B>Grand Total</B>
                                    <s:textfield id="goodsReceivedNoteConfirmation.grandTotalAmount" name="goodsReceivedNoteConfirmation.grandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
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
                            <td><sj:a href="#" id="btnGoodsReceivedNoteConfirmationSave" button="true" style="width: 60px">Save</sj:a></td>
                            <td><sj:a href="#" id="btnGoodsReceivedNoteConfirmationCancel" button="true" style="width: 60px">Cancel</sj:a></td>
                            </tr>
                        </table>
                    </td>
                </tr>            
            </table>
        </div> 
    </s:form>
</div>