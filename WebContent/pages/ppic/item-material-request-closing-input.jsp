
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.10/lodash.min.js"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
    
<style> 
    .ui-dialog-titlebar-close{
        display: none;
    }
    
    #imrClosingProductionPlanningOrderDetailInput_grid_pager_center,#imrClosingBillOfMaterialDetailInput_grid_pager_center,
    #processedPartClosing_grid_pager_center,#imrClosingItemMaterialRequestClosingBookedInput_grid_pager_center,#imrClosingItemMaterialRequestClosingBookedDetailInput_grid_pager_center,
    #imrClosingItemMaterialRequestClosingInput_grid_pager_center,#imrClosingItemMaterialRequestClosingDetailInput_grid_pager_center,
    #imrClosingItemMaterialRequestClosingDetailInput_grid_pager_center,#imrClosingItemMaterialRequestClosingDetailInput_grid_pager_center{
        display: none;
    }
    
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>
<script type="text/javascript">
    var imrClosingProductionPlanningOrderItemDetailLastRowId = 0,
        imrClosingBillOfMaterialDetailLastRowId = 0,
        processedPartClosingRowId = 0,
        imrClosingMaterialBookedRowId = 0,
        imrClosingItemMaterialRequestClosingBookedDetailRowId = 0,
        imrClosingItemMaterialRequestClosingRowId= 0,
        imrClosingItemMaterialRequestClosingDetailRowId = 0;
    
    var                                    
        txtItemMaterialRequestClosingCode = $("#itemMaterialRequestClosing\\.code"),
        dtpItemMaterialRequestClosingTransactionDate = $("#itemMaterialRequestClosing\\.transactionDate"),
        txtitemMaterialRequestClosingReasonCode = $("#itemMaterialRequestClosing\\.reason\\.code"),
        txtitemMaterialRequestClosingReasonName = $("#itemMaterialRequestClosing\\.reason\\.name");
        
    $(document).ready(function(){
        hoverButton();
        
        $('input[name="itemMaterialRequestClosingClosingStatusRad"][value="OPEN"]').change(function(ev){
            var value="OPEN";
            $("#itemMaterialRequestClosing\\.closingStatus").val(value);
        });
         $('input[name="itemMaterialRequestClosingClosingStatusRad"][value="CLOSED"]').change(function(ev){
            var value="CLOSED";
            $("#itemMaterialRequestClosing\\.closingStatus").val(value);
        });
        
        itemMaterialRequestClosingDocumentType($("#itemMaterialRequestClosing\\.productionPlanningOrder\\.documentType").val());
        loadDataImrProductionPlanningOrderDocumentItemClosingDetail(); 
        processedPartClosing();
        itemBookingClosing();
        itemBookingPartClosing();
        itemRequestClosing();
        itemRequestPartClosing();
        
        $("#btnItemMaterialRequestClosingSave").click(function(ev){
           
            if ($("#itemMaterialRequestClosing\\.closingStatus").val()==="CLOSED"){
                 alertMessage("Please choose one Closing Status");
                 return;
            } 
           
            formatDateIMRClosing();
            let url = "ppic/item-material-request-closing-save";
            var params = $("#frmItemMaterialRequestClosingInput").serialize();
            
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateIMRClosing(); 
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+data.message+'<br/></div>');
                dynamicDialog.dialog({
                    title           : "Confirmation:",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 400,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "OK",
                                        click : function() {
                                            $(this).dialog("close");
                                            var url = "ppic/item-material-request-closing";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuITEM_MATERIAL_REQUEST_CLOSING");
                                        }
                                    }]
                });
            }); 
            
        });
        
        $("#btnItemMaterialRequestClosingCancel").click(function(ev){
           var url = "ppice/item-material-request-closing";
           var params="";
           pageLoad(url,params,"#tabmnuITEM_MATERIAL_REQUEST_CLOSING");
        });
        
    }); //EOF Ready
    
    function itemMaterialRequestClosingDocumentType(doctype){
        if (doctype === 'SO'){
             $('#imrClosingProductionPlanningOrderDocumentTypeRadSO').prop('checked',true);
             $('#imrClosingProductionPlanningOrderDocumentTypeRadBO').prop('disabled',true);
             $('#imrClosingProductionPlanningOrderDocumentTypeRadIM').prop('disabled',true);
        }
        else if (doctype === 'BO'){
            $('#imrClosingProductionPlanningOrderDocumentTypeRadBO').prop('checked',true);
            $('#imrClosingProductionPlanningOrderDocumentTypeRadSO').prop('disabled',true);
            $('#imrClosingProductionPlanningOrderDocumentTypeRadIM').prop('disabled',true);
        } 
        else{
            $('#imrClosingProductionPlanningOrderDocumentTypeRadIM').prop('checked',true);
            $('#imrClosingProductionPlanningOrderDocumentTypeRadSO').prop('disabled',true);
            $('#imrClosingProductionPlanningOrderDocumentTypeRadBO').prop('disabled',true);
        }
    }
    
    function loadDataImrProductionPlanningOrderDocumentItemClosingDetail(){
        var url = "ppic/production-planning-order-detail-data";
        var params = "productionPlanningOrder.code=" + $("#itemMaterialRequestClosing\\.productionPlanningOrder\\.code").val();
            params += "&productionPlanningOrder.documentType=" + $('#itemMaterialRequestClosing\\.productionPlanningOrder\\.documentType') .val();

        $.getJSON(url, params, function(data) {
            imrClosingProductionPlanningOrderItemDetailLastRowId = 0;
            
            for (var i=0; i<data.listProductionPlanningOrderItemDetail.length; i++) {
                imrClosingProductionPlanningOrderItemDetailLastRowId++;
                $("#imrClosingProductionPlanningOrderDetailInput_grid").jqGrid("addRowData", imrClosingProductionPlanningOrderItemDetailLastRowId, data.listProductionPlanningOrderItemDetail[i]);
                $("#imrClosingProductionPlanningOrderDetailInput_grid").jqGrid('setRowData',imrClosingProductionPlanningOrderItemDetailLastRowId,{
                    
                    imrClosingProductionPlanningOrderDetailDocumentDetailCode             : data.listProductionPlanningOrderItemDetail[i].documentDetailCode,
                    imrClosingProductionPlanningOrderDetailSortNo                         : data.listProductionPlanningOrderItemDetail[i].documentSortNo,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsCode            : data.listProductionPlanningOrderItemDetail[i].itemFinishGoodsCode,
                    imrClosingProductionPlanningOrderDetailBillOfMaterialCode             : data.listProductionPlanningOrderItemDetail[i].billOfMaterialCode,
                    imrClosingProductionPlanningOrderDetailValveTag                       : data.listProductionPlanningOrderItemDetail[i].valveTag,
                    imrClosingProductionPlanningOrderDetailDataSheet                      : data.listProductionPlanningOrderItemDetail[i].dataSheet,
                    imrClosingProductionPlanningOrderDetailDescription                    : data.listProductionPlanningOrderItemDetail[i].description,
                    
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstCode   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstName   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignName  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignName  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeCode        : data.listProductionPlanningOrderItemDetail[i].itemSizeCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeName        : data.listProductionPlanningOrderItemDetail[i].itemSizeName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingCode      : data.listProductionPlanningOrderItemDetail[i].itemRatingCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingName      : data.listProductionPlanningOrderItemDetail[i].itemRatingName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreCode        : data.listProductionPlanningOrderItemDetail[i].itemBoreCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreName        : data.listProductionPlanningOrderItemDetail[i].itemBoreName,
                    
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConCode      : data.listProductionPlanningOrderItemDetail[i].itemEndConCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConName      : data.listProductionPlanningOrderItemDetail[i].itemEndConName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyCode        : data.listProductionPlanningOrderItemDetail[i].itemBodyCode,   
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyName        : data.listProductionPlanningOrderItemDetail[i].itemBodyName,   
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBallCode        : data.listProductionPlanningOrderItemDetail[i].itemBallCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBallName        : data.listProductionPlanningOrderItemDetail[i].itemBallName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatCode        : data.listProductionPlanningOrderItemDetail[i].itemSeatCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatName        : data.listProductionPlanningOrderItemDetail[i].itemSeatName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertName  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsStemCode        : data.listProductionPlanningOrderItemDetail[i].itemStemCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsStemName        : data.listProductionPlanningOrderItemDetail[i].itemStemName,
                    
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSealCode        : data.listProductionPlanningOrderItemDetail[i].itemSealCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSealName        : data.listProductionPlanningOrderItemDetail[i].itemSealName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltCode        : data.listProductionPlanningOrderItemDetail[i].itemBoltCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltName        : data.listProductionPlanningOrderItemDetail[i].itemBoltName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscCode        : data.listProductionPlanningOrderItemDetail[i].itemDiscCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscName        : data.listProductionPlanningOrderItemDetail[i].itemDiscName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesCode      : data.listProductionPlanningOrderItemDetail[i].itemPlatesCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesName      : data.listProductionPlanningOrderItemDetail[i].itemPlatesName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftCode       : data.listProductionPlanningOrderItemDetail[i].itemShaftCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftName       : data.listProductionPlanningOrderItemDetail[i].itemShaftName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringCode      : data.listProductionPlanningOrderItemDetail[i].itemSpringCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringName      : data.listProductionPlanningOrderItemDetail[i].itemSpringName,
                    
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinCode      : data.listProductionPlanningOrderItemDetail[i].itemArmPinCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinName      : data.listProductionPlanningOrderItemDetail[i].itemArmPinName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatCode    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatName    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsArmCode         : data.listProductionPlanningOrderItemDetail[i].itemArmCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsArmName         : data.listProductionPlanningOrderItemDetail[i].itemArmName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinCode    : data.listProductionPlanningOrderItemDetail[i].itemHingePinCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinName    : data.listProductionPlanningOrderItemDetail[i].itemHingePinName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinCode     : data.listProductionPlanningOrderItemDetail[i].itemStopPinCode,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinName     : data.listProductionPlanningOrderItemDetail[i].itemStopPinName,
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorCode    : data.listProductionPlanningOrderItemDetail[i].itemOperatorCode, 
                    imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorName    : data.listProductionPlanningOrderItemDetail[i].itemOperatorName, 
                    
                    imrClosingProductionPlanningOrderDetailQuantity                       : data.listProductionPlanningOrderItemDetail[i].quantity
                });
            }
            bomClosingDetail();
        });
    }
    
    function bomClosingDetail(){
       var url = "engineering/bill-of-material-for-imr";
       var params = "docDetailCode=" + $("#itemMaterialRequestClosing\\.productionPlanningOrder\\.code").val();
       
       $.getJSON(url,params,function(data){
           imrClosingBillOfMaterialDetailLastRowId = 0;
           
           for (var i=0; i<data.listBillOfMaterialPartDetail.length; i++) {
                imrClosingBillOfMaterialDetailLastRowId++;
                $("#imrClosingBillOfMaterialDetailInput_grid").jqGrid("addRowData", imrClosingBillOfMaterialDetailLastRowId, data.listBillOfMaterialPartDetail[i]);
                $("#imrClosingBillOfMaterialDetailInput_grid").jqGrid('setRowData',imrClosingBillOfMaterialDetailLastRowId,{
                    
                    imrClosingBillOfMaterialDetailCode                           : data.listBillOfMaterialPartDetail[i].code,
                    imrClosingBillOfMaterialDetailDocumentDetailCode             : data.listBillOfMaterialPartDetail[i].documentDetailCode,
                    imrClosingBillOfMaterialDetailItemFinishGoodsCode            : data.listBillOfMaterialPartDetail[i].itemFinishGoodsCode,
                    imrClosingBillOfMaterialDetailItemFinishGoodsRemark          : data.listBillOfMaterialPartDetail[i].itemFinishGoodsRemark,
                    imrClosingBillOfMaterialDetailItemPpoNo                      : data.listBillOfMaterialPartDetail[i].itemPPONo,
                    imrClosingBillOfMaterialDetailDocumentSortNo                 : data.listBillOfMaterialPartDetail[i].documentSortNo,
                    imrClosingBillOfMaterialDetailPartNo                         : data.listBillOfMaterialPartDetail[i].partNo,
                    imrClosingBillOfMaterialDetailPartCode                       : data.listBillOfMaterialPartDetail[i].partCode,
                    imrClosingBillOfMaterialDetailPartName                       : data.listBillOfMaterialPartDetail[i].partName,
                    imrClosingBillOfMaterialDetailDrawingCode                    : data.listBillOfMaterialPartDetail[i].drawingCode,
                    imrClosingBillOfMaterialDetailDimension                      : data.listBillOfMaterialPartDetail[i].dimension,
                    imrClosingBillOfMaterialDetailRequiredLength                 : data.listBillOfMaterialPartDetail[i].requiredLength,
                    imrClosingBillOfMaterialDetailMaterial                       : data.listBillOfMaterialPartDetail[i].material,
                    imrClosingBillOfMaterialDetailQuantity                       : data.listBillOfMaterialPartDetail[i].quantity,
                    imrClosingBillOfMaterialDetailRequirement                    : data.listBillOfMaterialPartDetail[i].requirement,
                    imrClosingBillOfMaterialDetailProcessedStatus                : data.listBillOfMaterialPartDetail[i].processedStatus,
                    imrClosingBillOfMaterialDetailRemark                         : data.listBillOfMaterialPartDetail[i].remark,
                    imrClosingBillOfMaterialDetailX                              : data.listBillOfMaterialPartDetail[i].x,
                    imrClosingBillOfMaterialDetailRevNo                          : data.listBillOfMaterialPartDetail[i].revNo
                });
            }
       });
       
    }
    
    function processedPartClosing(){
        let url = "ppic/item-material-request-processed-part-data";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestClosingCode.val();
        
        $.post(url, params, function(data){
            for (let j = 0; j<data.listItemMaterialRequestItemProcessedPartDetail.length; j++){
                processedPartClosingRowId++;
                $("#processedPartClosing_grid").jqGrid('addRowData', processedPartClosingRowId, data.listItemMaterialRequestItemProcessedPartDetail[j]);
                $("#processedPartClosing_grid").jqGrid('setRowData', processedPartClosingRowId,{
                    imrClosingProcessedBillOfMaterialDetailCode                    : data.listItemMaterialRequestItemProcessedPartDetail[j].code,
                    imrClosingProcessedBillOfMaterialBOMDetailCode                 : data.listItemMaterialRequestItemProcessedPartDetail[j].bomDetailCode,
                    imrClosingProcessedBillOfMaterialDetailDocumentSortNo          : data.listItemMaterialRequestItemProcessedPartDetail[j].documentSortNo,
                    imrClosingProcessedBillOfMaterialDetailDocumentDetailCode      : data.listItemMaterialRequestItemProcessedPartDetail[j].documentDetailCode,
                    imrClosingProcessedBillOfMaterialDetailItemFinishGoodsCode     : data.listItemMaterialRequestItemProcessedPartDetail[j].itemFinishGoodsCode,
                    imrClosingProcessedBillOfMaterialDetailItemFinishGoodsRemark   : data.listItemMaterialRequestItemProcessedPartDetail[j].itemFinishGoodsRemark,
                    imrClosingProcessedBillOfMaterialDetailItemPpoNo               : data.listItemMaterialRequestItemProcessedPartDetail[j].itemProductionPlanningOrderNo,
                    imrClosingProcessedBillOfMaterialDetailPartNo                  : data.listItemMaterialRequestItemProcessedPartDetail[j].partNo,
                    imrClosingProcessedBillOfMaterialDetailPartCode                : data.listItemMaterialRequestItemProcessedPartDetail[j].partCode,
                    imrClosingProcessedBillOfMaterialDetailPartName                : data.listItemMaterialRequestItemProcessedPartDetail[j].partName,
                    imrClosingProcessedBillOfMaterialDetailDrawingCode             : data.listItemMaterialRequestItemProcessedPartDetail[j].drawingCode,
                    imrClosingProcessedBillOfMaterialDetailDimension               : data.listItemMaterialRequestItemProcessedPartDetail[j].dimension,
                    imrClosingProcessedBillOfMaterialDetailRequiredLength          : data.listItemMaterialRequestItemProcessedPartDetail[j].requiredLength,
                    imrClosingProcessedBillOfMaterialDetailMaterial                : data.listItemMaterialRequestItemProcessedPartDetail[j].material,
                    imrClosingProcessedBillOfMaterialDetailQuantity                : data.listItemMaterialRequestItemProcessedPartDetail[j].quantity,
                    imrClosingProcessedBillOfMaterialDetailRequirement             : data.listItemMaterialRequestItemProcessedPartDetail[j].requirement,
                    imrClosingProcessedBillOfMaterialDetailProcessedStatus         : data.listItemMaterialRequestItemProcessedPartDetail[j].processedStatus,
                    imrClosingProcessedBillOfMaterialDetailRemark                  : data.listItemMaterialRequestItemProcessedPartDetail[j].remark,
                    imrClosingProcessedBillOfMaterialDetailX                       : data.listItemMaterialRequestItemProcessedPartDetail[j].x,
                    imrClosingProcessedBillOfMaterialDetailRevNo                   : data.listItemMaterialRequestItemProcessedPartDetail[j].revNo
                });
            }
        });
    }
    
    function itemBookingClosing(){
        let url = "ppic/item-material-request-booking-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestClosingCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemBookingDetail.length; i++){
               imrClosingMaterialBookedRowId++;
               $("#imrClosingItemMaterialRequestClosingBookedInput_grid").jqGrid('addRowData',imrClosingMaterialBookedRowId, data.listItemMaterialRequestItemBookingDetail[i]);
               $("#imrClosingItemMaterialRequestClosingBookedInput_grid").jqGrid('setRowData',imrClosingMaterialBookedRowId,{
                   imrClosingItemMaterialRequestBookedCodeImrBookCode              : data.listItemMaterialRequestItemBookingDetail[i].code,
                   imrClosingItemMaterialRequestClosingBookedCode                 : data.listItemMaterialRequestItemBookingDetail[i].itemMaterialCode,
                   imrClosingItemMaterialRequestClosingBookedName                 : data.listItemMaterialRequestItemBookingDetail[i].itemMaterialName,
                   imrClosingItemMaterialRequestClosingBookedRemark               : data.listItemMaterialRequestItemBookingDetail[i].remark,
                   imrClosingItemMaterialRequestClosingBookQuantity               : data.listItemMaterialRequestItemBookingDetail[i].bookingQuantity,
                   imrClosingItemMaterialRequestClosingBookedUnitOfMeasureCode    : data.listItemMaterialRequestItemBookingDetail[i].uomCode,
                   imrClosingItemMaterialRequestClosingBookedUnitOfMeasureName    : data.listItemMaterialRequestItemBookingDetail[i].uomName
               });
           }
        });
    }
    
    function itemBookingPartClosing(){
        let url = "ppic/item-material-request-booking-part-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestClosingCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemBookingPartDetail.length; i++){
               imrClosingItemMaterialRequestClosingBookedDetailRowId++;
               $("#imrClosingItemMaterialRequestClosingBookedDetailInput_grid").jqGrid('addRowData',imrClosingItemMaterialRequestClosingBookedDetailRowId, data.listItemMaterialRequestItemBookingPartDetail[i]);
               $("#imrClosingItemMaterialRequestClosingBookedDetailInput_grid").jqGrid('setRowData',imrClosingItemMaterialRequestClosingBookedDetailRowId,{
                   imrClosingItemMaterialRequestClosingBookedDetailCode                   : data.listItemMaterialRequestItemBookingPartDetail[i].code,
                   imrClosingItemMaterialRequestClosingBookedBOMDetailCode                : data.listItemMaterialRequestItemBookingPartDetail[i].bomDetailCode,
                   imrClosingItemMaterialRequestClosingBookedDetailItemMaterialCode       : data.listItemMaterialRequestItemBookingPartDetail[i].itemMaterialRequestBookingDetailCode,
                   imrClosingItemMaterialRequestClosingBookedDetailItemMaterialName       : data.listItemMaterialRequestItemBookingPartDetail[i].itemMaterialName,
                   imrClosingItemMaterialRequestClosingBookedDetailDocumentDetailCode     : data.listItemMaterialRequestItemBookingPartDetail[i].documentDetailCode,
                   imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsCode    : data.listItemMaterialRequestItemBookingPartDetail[i].itemFinishGoodsCode,
                   imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsRemark  : data.listItemMaterialRequestItemBookingPartDetail[i].itemFinishGoodsRemark,
                   imrClosingItemMaterialRequestClosingBookedDetailItemPpoNo              : data.listItemMaterialRequestItemBookingPartDetail[i].itemProductionPlanningOrderNo,
                   imrClosingItemMaterialRequestClosingBookedDetailPartNo                 : data.listItemMaterialRequestItemBookingPartDetail[i].partNo,
                   imrClosingItemMaterialRequestClosingBookedDetailPartCode               : data.listItemMaterialRequestItemBookingPartDetail[i].partCode,
                   imrClosingItemMaterialRequestClosingBookedDetailPartName               : data.listItemMaterialRequestItemBookingPartDetail[i].partName,
                   imrClosingItemMaterialRequestClosingBookedDetailDrawingCode            : data.listItemMaterialRequestItemBookingPartDetail[i].drawingCode,
                   imrClosingItemMaterialRequestClosingBookedDetailDimension              : data.listItemMaterialRequestItemBookingPartDetail[i].dimension,
                   imrClosingItemMaterialRequestClosingBookedDetailRequiredLength         : data.listItemMaterialRequestItemBookingPartDetail[i].requiredLength,
                   imrClosingItemMaterialRequestClosingBookedDetailMaterial               : data.listItemMaterialRequestItemBookingPartDetail[i].material,
                   imrClosingItemMaterialRequestClosingBookedDetailQuantity               : data.listItemMaterialRequestItemBookingPartDetail[i].quantity,
                   imrClosingItemMaterialRequestClosingBookedDetailRequirement            : data.listItemMaterialRequestItemBookingPartDetail[i].requirement,
                   imrClosingItemMaterialRequestClosingBookedDetailProcessedStatus        : data.listItemMaterialRequestItemBookingPartDetail[i].processedStatus,
                   imrClosingItemMaterialRequestClosingBookedDetailRemark                 : data.listItemMaterialRequestItemBookingPartDetail[i].remark,
                   imrClosingItemMaterialRequestClosingBookedDetailX                      : data.listItemMaterialRequestItemBookingPartDetail[i].x,
                   imrClosingItemMaterialRequestClosingBookedDetailRevNo                  : data.listItemMaterialRequestItemBookingPartDetail[i].revNo
               });
           }
        });
    }
    
    function itemRequestClosing(){
        let url = "ppic/item-material-request-request-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestClosingCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemRequestDetail.length; i++){
               imrClosingItemMaterialRequestClosingRowId++;
               $("#imrClosingItemMaterialRequestClosingInput_grid").jqGrid('addRowData',imrClosingItemMaterialRequestClosingRowId, data.listItemMaterialRequestItemRequestDetail[i]);
               $("#imrClosingItemMaterialRequestClosingInput_grid").jqGrid('setRowData',imrClosingItemMaterialRequestClosingRowId,{
                   imrClosingItemMaterialCodeRequestCode             : data.listItemMaterialRequestItemRequestDetail[i].code,
                   imrClosingItemMaterialCodeRequest                 : data.listItemMaterialRequestItemRequestDetail[i].itemMaterialCode,
                   imrClosingItemMaterialNameRequest                 : data.listItemMaterialRequestItemRequestDetail[i].itemMaterialName,
                   imrClosingItemMaterialRemarkRequest               : data.listItemMaterialRequestItemRequestDetail[i].remark,
                   imrClosingItemMaterialPrqQuantityRequest          : data.listItemMaterialRequestItemRequestDetail[i].quantity,
                   imrClosingItemMaterialUnitOfMeasureCodeRequest    : data.listItemMaterialRequestItemRequestDetail[i].uomCode,
                   imrClosingItemMaterialUnitOfMeasureNameRequest    : data.listItemMaterialRequestItemRequestDetail[i].uomName
               });
           }
        });
    }
    
    function itemRequestPartClosing(){
        let url = "ppic/item-material-request-request-part-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestClosingCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemRequestPartDetail.length; i++){
               imrClosingItemMaterialRequestClosingDetailRowId++;
               $("#imrClosingItemMaterialRequestClosingDetailInput_grid").jqGrid('addRowData',imrClosingItemMaterialRequestClosingDetailRowId, data.listItemMaterialRequestItemRequestPartDetail[i]);
               $("#imrClosingItemMaterialRequestClosingDetailInput_grid").jqGrid('setRowData',imrClosingItemMaterialRequestClosingDetailRowId,{
                   imrClosingItemMaterialRequestClosingDetailCode                   : data.listItemMaterialRequestItemRequestPartDetail[i].code,
                   imrClosingItemMaterialRequestClosingDetailBomDetailCode          : data.listItemMaterialRequestItemRequestPartDetail[i].bomDetailCode,
                   imrClosingItemMaterialRequestClosingDetailItemMaterialCode       : data.listItemMaterialRequestItemRequestPartDetail[i].itemMaterialRequestPurchaseRequestDetailCode,
                   imrClosingItemMaterialRequestClosingDetailItemMaterialName       : data.listItemMaterialRequestItemRequestPartDetail[i].itemMaterialName,
                   imrClosingItemMaterialRequestClosingDetailDocumentDetailCode     : data.listItemMaterialRequestItemRequestPartDetail[i].documentDetailCode,
                   imrClosingItemMaterialRequestClosingDetailItemFinishGoodsCode    : data.listItemMaterialRequestItemRequestPartDetail[i].itemFinishGoodsCode,
                   imrClosingItemMaterialRequestClosingDetailItemFinishGoodsRemark  : data.listItemMaterialRequestItemRequestPartDetail[i].itemFinishGoodsRemark,
                   imrClosingItemMaterialRequestClosingDetailItemPpoNo              : data.listItemMaterialRequestItemRequestPartDetail[i].itemProductionPlanningOrderNo,
                   imrClosingItemMaterialRequestClosingDetailPartNo                 : data.listItemMaterialRequestItemRequestPartDetail[i].partNo,
                   imrClosingItemMaterialRequestClosingDetailPartCode               : data.listItemMaterialRequestItemRequestPartDetail[i].partCode,
                   imrClosingItemMaterialRequestClosingDetailPartName               : data.listItemMaterialRequestItemRequestPartDetail[i].partName,
                   imrClosingItemMaterialRequestClosingDetailDrawingCode            : data.listItemMaterialRequestItemRequestPartDetail[i].drawingCode,
                   imrClosingItemMaterialRequestClosingDetailDimension              : data.listItemMaterialRequestItemRequestPartDetail[i].dimension,
                   imrClosingItemMaterialRequestClosingDetailRequiredLength         : data.listItemMaterialRequestItemRequestPartDetail[i].requiredLength,
                   imrClosingItemMaterialRequestClosingDetailMaterial               : data.listItemMaterialRequestItemRequestPartDetail[i].material,
                   imrClosingItemMaterialRequestClosingDetailQuantity               : data.listItemMaterialRequestItemRequestPartDetail[i].quantity,
                   imrClosingItemMaterialRequestClosingDetailRequirement            : data.listItemMaterialRequestItemRequestPartDetail[i].requirement,
                   imrClosingItemMaterialRequestClosingDetailProcessedStatus        : data.listItemMaterialRequestItemRequestPartDetail[i].processedStatus,
                   imrClosingItemMaterialRequestClosingDetailRemark                 : data.listItemMaterialRequestItemRequestPartDetail[i].remark,
                   imrClosingItemMaterialRequestClosingDetailX                      : data.listItemMaterialRequestItemRequestPartDetail[i].x,
                   imrClosingItemMaterialRequestClosingDetailRevNo                  : data.listItemMaterialRequestItemRequestPartDetail[i].revNo
               });
           }
        });
    }
    
    function setHeightGridHeader(){
        var ids = jQuery("#imrClosingItemMaterialRequestClosingBookedInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#imrClosingItemMaterialRequestClosingBookedInput_grid"+" tr").eq(1).height();
            $("#imrClosingItemMaterialRequestClosingBookedInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#imrClosingItemMaterialRequestClosingBookedInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateIMRClosing(){
        var transactionDateSplit=dtpItemMaterialRequestClosingTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpItemMaterialRequestClosingTransactionDate.val(transactionDate);
    }
</script>

<b>ITEM MATERIAL REQUEST APPROVAL</b>
<hr>
<br class="spacer" />

<div id="productionPlanningOrderInput" class="content ui-widget">
    <s:form id="frmItemMaterialRequestClosingInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerItemMaterialRequestClosingInput">
            <tr>
                <td align="right" width="100px"><b>IMR No *</b></td>
                <td><s:textfield id="itemMaterialRequestClosing.code" name="itemMaterialRequestClosing.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequestClosing.transactionDate" name="itemMaterialRequestClosing.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>PPO NO </B></td>
                <td colspan="2">
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="itemMaterialRequestClosing.productionPlanningOrder.code" name="itemMaterialRequestClosing.productionPlanningOrder.code" size="20" readonly = "true"></s:textfield>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right" width="100px">Branch</td>
                <td><s:textfield id="itemMaterialRequestClosing.branch.code" name="itemMaterialRequestClosing.branch.code" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>PPO Date </B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequestClosing.productionPlanningOrder.transactionDate" name="itemMaterialRequestClosing.productionPlanningOrder.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Document Type </B></td>
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                <s:radio id="imrClosingProductionPlanningOrderDocumentTypeRad" name="imrClosingProductionPlanningOrderDocumentTypeRad" label="Type" list="{'SO','BO','IM'}"></s:radio>
                                <s:textfield id="itemMaterialRequestClosing.productionPlanningOrder.documentType" name="itemMaterialRequestClosing.productionPlanningOrder.documentType" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right"><B>SO/BO/IM </B></td>
                <td><s:textfield id="itemMaterialRequestClosing.productionPlanningOrder.documentCode" name="itemMaterialRequestClosing.productionPlanningOrder.documentCode" size="20" readonly="true"></s:textfield></td>
                </td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Target Date </B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequestClosing.productionPlanningOrder.targetDate" name="itemMaterialRequestClosing.productionPlanningOrder.targetDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Customer *</B></td>
                <td colspan="2">
                    <s:textfield id="itemMaterialRequestClosing.productionPlanningOrder.customer.code" name="itemMaterialRequestClosing.productionPlanningOrder.customer.code" size="20" readonly="true"></s:textfield>
                    <s:textfield id="itemMaterialRequestClosing.productionPlanningOrder.customer.name" name="itemMaterialRequestClosing.productionPlanningOrder.customer.name" size="30" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Warehouse *</B></td>
                <td colspan="2">
                    <s:textfield id="itemMaterialRequestClosing.warehouse.code" name="itemMaterialRequestClosing.warehouse.code" size="20" title=" " readonly="true" ></s:textfield>
                    <s:textfield id="itemMaterialRequestClosing.warehouse.name" name="itemMaterialRequestClosing.warehouse.name" size="30" readonly="true" ></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="itemMaterialRequestClosing.refNo" name="itemMaterialRequestClosing.refNo" readonly="true" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="itemMaterialRequestClosing.remark" name="itemMaterialRequestClosing.remark" cols="53" rows="3" readonly="true" ></s:textarea></td>
            </tr>
            <tr>
                <td align="right">Closing Status </td>
                <s:textfield id="itemMaterialRequestClosing.closingStatus" name="itemMaterialRequestClosing.closingStatus" readonly="false" size="15" style="display:none"></s:textfield>
                <td><s:radio id="itemMaterialRequestClosingClosingStatusRad" name="itemMaterialRequestClosingClosingStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
            </tr>
            <tr>
                <td align="right" valign="top">Closing Reason</td>
                <td colspan="2">
                <script type = "text/javascript">
                    $('#itemMaterialRequestClosing_btnReason').click(function(ev) {
                        window.open("./pages/search/search-reason.jsp?iddoc=itemMaterialRequestClosing&idsubdoc=closingReason","Search", "width=600, height=500");
                    });
                    txtitemMaterialRequestClosingReasonCode.change(function(ev) {

                        if(txtitemMaterialRequestClosingReasonCode.val()===""){
                            txtitemMaterialRequestClosingReasonCode.val("");
                            return;
                        }
                        var url = "master/reason-get";
                        var params = "reason.code=" + txtitemMaterialRequestClosingReasonCode.val();
                            params += "&reason.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.reasonTemp){
                                txtitemMaterialRequestClosingReasonCode.val(data.reasonTemp.code);
                                txtitemMaterialRequestClosingReasonName.val(data.reasonTemp.name);
                            }
                            else{
                                alertMessage("Reason Not Found!",txtitemMaterialRequestClosingReasonCode);
                                txtitemMaterialRequestClosingReasonCode.val("");
                                txtitemMaterialRequestClosingReasonName.val("");
                            }
                        });
                    });
                </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="itemMaterialRequestClosing.closingReason.code" name="itemMaterialRequestClosing.closingReason.code" size="25"></s:textfield>
                        <sj:a id="itemMaterialRequestClosing_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="itemMaterialRequestClosing.closingReason.name" name="itemMaterialRequestClosing.closingReason.name" size="30" readonly="true"></s:textfield>
                </td>    
            </tr>
            <tr>
                <td align="right" valign="top">Closing Remark</td>
                <td><s:textarea id="itemMaterialRequestClosing.closingRemark" name="itemMaterialRequestClosing.closingRemark"  cols="50" rows="2" height="20"></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="itemMaterialRequestClosing.createdBy" name="itemMaterialRequestClosing.createdBy"></s:textfield>
                    <sj:datepicker id="itemMaterialRequestClosingDateFirstSession" name="itemMaterialRequestClosingDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="itemMaterialRequestClosingDateLastSession" name="itemMaterialRequestClosingDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnItemMaterialRequestClosingSave" button="true" style="width: 60px">Close</sj:a>
                    <sj:a href="#" id="btnItemMaterialRequestClosingCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>   
        </table>
              
        <br class="spacer" />
        <br class="spacer" />
                
        <div id="id-item-material-request-detail">
            <div id="imrClosingProductionPlanningOrderDetailInputGrid">
                <sjg:grid
                    id="imrClosingProductionPlanningOrderDetailInput_grid"
                    caption="PPO DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="true"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listProductionPlanningOrderItemDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuImrProductionPlanningOrderDetail').width()"
                >
                    <sjg:gridColumn
                        name="imrClosingProductionPlanningOrderDetail" index="imrClosingProductionPlanningOrderDetail" key="imrClosingProductionPlanningOrderDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailSortNo" index = "imrClosingProductionPlanningOrderDetailSortNo" 
                        key = "imrClosingProductionPlanningOrderDetailSortNo" title = "Sort No" width = "80"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailDocumentDetailCode" index = "imrClosingProductionPlanningOrderDetailDocumentDetailCode" 
                        key = "imrClosingProductionPlanningOrderDetailDocumentDetailCode" title = "Document Detail Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailBillOfMaterialCode" index = "imrClosingProductionPlanningOrderDetailBillOfMaterialCode" 
                        key = "imrClosingProductionPlanningOrderDetailBillOfMaterialCode" title = "BOM Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsCode" title = "Item Finish Goods" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailValveTag" index = "imrClosingProductionPlanningOrderDetailValveTag" 
                        key = "imrClosingProductionPlanningOrderDetailValveTag" title = "Valve Tag" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailDataSheet" index = "imrClosingProductionPlanningOrderDetailDataSheet" 
                        key = "imrClosingProductionPlanningOrderDetailDataSheet" title = "Data Sheet" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailDescription" index = "imrClosingProductionPlanningOrderDetailDescription" 
                        key = "imrClosingProductionPlanningOrderDetailDescription" title = "Description" width = "120"
                    />
<!------------------------------------>
                    <!--01 Body Cons-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" title = "Body Cons Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyConstName" title = "Body Construction" width = "120"
                    />
                    <!--02 Type Design-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" title = "Type Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" title = "Type Design" width = "120"
                    />
                    <!--03 Seat Design-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" title = "Seat Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" title = "Seat Design" width = "120"
                    />
                    <!--04 Size-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeCode" title = "Size Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSizeName" title = "Size" width = "120"
                    />
                    <!--05 Rating-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingCode" title = "Rating Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsRatingName" title = "Rating" width = "120"
                    />
                    <!--06 Bore-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreCode" title = "Bore Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoreName" title = "Bore" width = "120"
                    />
                    
                    <!--07 End Con-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConCode" title = "End Con Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsEndConName" title = "End Con" width = "120"
                    />
                    <!--08 Body-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyCode" title = "Body Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBodyName" title = "Body" width = "120"
                    />
                    <!--09 Ball-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBallCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBallCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBallCode" title = "Ball Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBallName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBallName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBallName" title = "Ball" width = "120"
                    />
                    <!--10 Seat-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatCode" title = "Seat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatName" title = "Seat" width = "120"
                    />
                    <!--11 Seat Insert-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" title = "Seat Insert Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" title = "Seat Insert" width = "120"
                    />
                    <!--12 Stem-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStemCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStemCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStemCode" title = "Stem Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStemName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStemName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStemName" title = "Stem" width = "120"
                    />
                    
                    <!--13 Seal-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSealCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSealCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSealCode" title = "Seal Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSealName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSealName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSealName" title = "Seal" width = "120"
                    />
                    <!--14 Bolt-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltCode" title = "Bolt Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBoltName" title = "Bolt" width = "120"
                    />
                    <!--15 Disc-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscCode" title = "Disc Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsDiscName" title = "Disc" width = "120"
                    />
                    <!--16 Plates-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesCode" title = "Plates Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsPlatesName" title = "Plates" width = "120"
                    />
                    <!--17 Shaft-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftCode" title = "Shaft Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsShaftName" title = "Shaft" width = "120"
                    />
                    <!--18 Spring-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringCode" title = "Spring Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsSpringName" title = "Spring" width = "120"
                    />
                    
                    <!--19 Arm Pin-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinCode" title = "Arm Pin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmPinName" title = "Arm Pin" width = "120"
                    />
                    <!--20 BackSeat-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" title = "BackSeat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsBackSeatName" title = "BackSeat" width = "120"
                    />
                    <!--21 Arm-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmCode" title = "Arm Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsArmName" title = "Arm" width = "120"
                    />
                    <!--22 HingePin-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinCode" title = "HingePin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsHingePinName" title = "HingePin" width = "120"
                    />
                    <!--23 StopPin-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinCode" title = "StopPin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsStopPinName" title = "StopPin" width = "120"
                    />
                    <!--24 Operator-->
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorCode" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorCode" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorCode" title = "Operator Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorName" index = "imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorName" 
                        key = "imrClosingProductionPlanningOrderDetailItemFinishGoodsOperatorName" title = "Operator" width = "120"
                    />
                    <sjg:gridColumn
                        name="imrClosingProductionPlanningOrderDetailQuantity" index="imrClosingProductionPlanningOrderDetailQuantity" key="imrClosingProductionPlanningOrderDetailQuantity" title="PPO Quantity" 
                        width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >  
            </div>
                <br class="spacer" />
                <div>
                    <sjg:grid
                        id="imrClosingBillOfMaterialDetailInput_grid"
                        caption="Bill Of Material"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listBillOfMaterialPartDetail"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        width="$('#tabmnuImrBillOfMaterialDetail').width()"
                    >
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetail" index="imrClosingBillOfMaterialDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailCode" index="imrClosingBillOfMaterialDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailDocumentSortNo" index="imrClosingBillOfMaterialDetailDocumentSortNo" key="imrClosingBillOfMaterialDetailDocumentSortNo" title="Document Sort No" 
                            width="80" hidden="true"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailDocumentDetailCode" index="imrClosingBillOfMaterialDetailDocumentDetailCode" key="imrClosingBillOfMaterialDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailItemFinishGoodsCode" index="imrClosingBillOfMaterialDetailItemFinishGoodsCode" key="imrClosingBillOfMaterialDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailItemFinishGoodsRemark" index="imrClosingBillOfMaterialDetailItemFinishGoodsRemark" key="imrClosingBillOfMaterialDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="200" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailItemPpoNo" index="imrClosingBillOfMaterialDetailItemPpoNo" key="imrClosingBillOfMaterialDetailItemPpoNo" title="Item PPO No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailItemMaterialCode" index="imrClosingBillOfMaterialDetailItemMaterialCode" key="imrClosingBillOfMaterialDetailItemMaterialCode" title="IMR No" 
                            width="180"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailItemMaterialDate" index="imrClosingBillOfMaterialDetailItemMaterialDate" key="imrClosingBillOfMaterialDetailItemMaterialDate" title="IMR Date" 
                            width="180" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailPartNo" index="imrClosingBillOfMaterialDetailPartNo" key="imrClosingBillOfMaterialDetailPartNo" title="Part No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailPartCode" index="imrClosingBillOfMaterialDetailPartCode" key="imrClosingBillOfMaterialDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailPartName" index="imrClosingBillOfMaterialDetailPartName" key="imrClosingBillOfMaterialDetailPartName" title="Part Name" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailDrawingCode" index="imrClosingBillOfMaterialDetailDrawingCode" key="imrClosingBillOfMaterialDetailDrawingCode" title="Drawing Code" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailDimension" index="imrClosingBillOfMaterialDetailDimension" key="imrClosingBillOfMaterialDetailDimension" title="Dimension" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailRequiredLength" index="imrClosingBillOfMaterialDetailRequiredLength" key="imrClosingBillOfMaterialDetailRequiredLength" title="Required Length" 
                            width="80" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailMaterial" index="imrClosingBillOfMaterialDetailMaterial" key="imrClosingBillOfMaterialDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailQuantity" index="imrClosingBillOfMaterialDetailQuantity" key="imrClosingBillOfMaterialDetailQuantity" title="Quantity BOM" 
                            width="80" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailRequirement" index="imrClosingBillOfMaterialDetailRequirement" key="imrClosingBillOfMaterialDetailRequirement" title="Requirement" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name = "imrClosingBillOfMaterialDetailProcessedStatus" index = "imrClosingBillOfMaterialDetailProcessedStatus" key = "imrClosingBillOfMaterialDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailRemark" index="imrClosingBillOfMaterialDetailRemark" key="imrClosingBillOfMaterialDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailX" index="imrClosingBillOfMaterialDetailX" key="imrClosingBillOfMaterialDetailX" title="X" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingBillOfMaterialDetailRevNo" index="imrClosingBillOfMaterialDetailRevNo" key="imrClosingBillOfMaterialDetailRevNo" title="Rev No" 
                            width="80" 
                        />
                    </sjg:grid >
                </div>
            </div>
                <br class="spacer" />
            <div id = "id-item-material-request-detail-process">
                <div>
                    <sjg:grid
                        id="processedPartClosing_grid"
                        caption="Procssed Part"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listItemMaterialRequestItemProcessedPartDetail"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false" 
                        width="$('#tabmnuBillOfMaterialDetail').width()"
                    >
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetail" index="imrClosingProcessedBillOfMaterialDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailCode" index="imrClosingProcessedBillOfMaterialDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialBOMDetailCode" index="imrClosingProcessedBillOfMaterialBOMDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailDocumentSortNo" index="imrClosingProcessedBillOfMaterialDetailDocumentSortNo" key="imrClosingProcessedBillOfMaterialDetailDocumentSortNo" title="Doc Sort No" 
                            width="80" hidden="true"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailDocumentDetailCode" index="imrClosingProcessedBillOfMaterialDetailDocumentDetailCode" key="imrClosingProcessedBillOfMaterialDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailItemFinishGoodsCode" index="imrClosingProcessedBillOfMaterialDetailItemFinishGoodsCode" key="imrClosingProcessedBillOfMaterialDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailItemFinishGoodsRemark" index="imrClosingProcessedBillOfMaterialDetailItemFinishGoodsRemark" key="imrClosingProcessedBillOfMaterialDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailItemPpoNo" index="imrClosingProcessedBillOfMaterialDetailItemPpoNo" key="imrClosingProcessedBillOfMaterialDetailItemPpoNo" title="Item PPO No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailPartNo" index="imrClosingProcessedBillOfMaterialDetailPartNo" key="imrClosingProcessedBillOfMaterialDetailPartNo" title="Part No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailPartCode" index="imrClosingProcessedBillOfMaterialDetailPartCode" key="imrClosingProcessedBillOfMaterialDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailPartName" index="imrClosingProcessedBillOfMaterialDetailPartName" key="imrClosingProcessedBillOfMaterialDetailPartName" title="Part Name" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailDrawingCode" index="imrClosingProcessedBillOfMaterialDetailDrawingCode" key="imrClosingProcessedBillOfMaterialDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailDimension" index="imrClosingProcessedBillOfMaterialDetailDimension" key="imrClosingProcessedBillOfMaterialDetailDimension" title="Dimension" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailRequiredLength" index="imrClosingProcessedBillOfMaterialDetailRequiredLength" key="imrClosingProcessedBillOfMaterialDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailMaterial" index="imrClosingProcessedBillOfMaterialDetailMaterial" key="imrClosingProcessedBillOfMaterialDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailQuantity" index="imrClosingProcessedBillOfMaterialDetailQuantity" key="imrClosingProcessedBillOfMaterialDetailQuantity" title="Quantity BOM" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailRequirement" index="imrClosingProcessedBillOfMaterialDetailRequirement" key="imrClosingProcessedBillOfMaterialDetailRequirement" title="Requirement" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name = "imrClosingProcessedBillOfMaterialDetailProcessedStatus" index = "imrClosingProcessedBillOfMaterialDetailProcessedStatus" key = "imrClosingProcessedBillOfMaterialDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailRemark" index="imrClosingProcessedBillOfMaterialDetailRemark" key="imrClosingProcessedBillOfMaterialDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailX" index="imrClosingProcessedBillOfMaterialDetailX" key="imrClosingProcessedBillOfMaterialDetailX" title="X" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingProcessedBillOfMaterialDetailRevNo" index="imrClosingProcessedBillOfMaterialDetailRevNo" key="imrClosingProcessedBillOfMaterialDetailRevNo" title="Rev No" 
                            width="80" 
                        />
                    </sjg:grid >
                    <br class="spacer" />
                    <div>
                        <table width="100%">
                            
                            <tr>
                                <td width="200px">
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <sjg:grid
                                                    id="imrClosingItemMaterialRequestClosingBookedInput_grid"
                                                    caption="Item Material Booking"
                                                    dataType="json"                    
                                                    pager="true"
                                                    navigator="false"
                                                    navigatorView="false"
                                                    navigatorRefresh="false"
                                                    navigatorDelete="false"
                                                    navigatorAdd="false"
                                                    navigatorEdit="false"
                                                    gridModel="listItemMaterialRequestItemRequestDetail"
                                                    viewrecords="true"
                                                    rownumbers="true"
                                                    shrinkToFit="false"
                                                    width="700"
                                                >
                                                    <sjg:gridColumn
                                                        name="imrClosingItemMaterialRequestBookedCodeDetail" index="imrClosingItemMaterialRequestBookedCodeDetail" key="imrClosingItemMaterialRequestBookedCodeDetail" 
                                                        title="" width="150" sortable="true" hidden="true" editable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrClosingItemMaterialRequestBookedCodeImrBookCode" index="imrClosingItemMaterialRequestBookedCodeImrBookCode" key="imrClosingItemMaterialRequestBookedCodeImrBookCode" 
                                                        title="" width="150" sortable="true" hidden="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrClosingItemMaterialRequestClosingBookedCode" index="imrClosingItemMaterialRequestClosingBookedCode" key="imrClosingItemMaterialRequestClosingBookedCode" 
                                                        title="Item Material Code" width="150" sortable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrClosingItemMaterialRequestClosingBookedName" index="imrClosingItemMaterialRequestClosingBookedName" key="imrClosingItemMaterialRequestClosingBookedName" 
                                                        title="Item Material Name" width="150" sortable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrClosingItemMaterialRequestClosingBookedRemark" index = "imrClosingItemMaterialRequestClosingBookedRemark" key = "imrClosingItemMaterialRequestClosingBookedRemark" 
                                                        title = "Remark" width = "80" editable="true" edittype="text" 
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrClosingItemMaterialRequestClosingBookQuantity" index = "imrClosingItemMaterialRequestClosingBookQuantity" key = "imrClosingItemMaterialRequestClosingBookQuantity" 
                                                        title = "Book Quantity" width = "80" formatter="number" editrules="{ double: true }"
                                                        formatoptions= "{ thousandsSeparator:','}"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrClosingItemMaterialRequestClosingBookedUnitOfMeasureCode" index = "imrClosingItemMaterialRequestClosingBookedUnitOfMeasureCode" key = "imrClosingItemMaterialRequestClosingBookedUnitOfMeasureCode" 
                                                        title = "Unit" width = "80" 
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrClosingItemMaterialRequestClosingBookedUnitOfMeasureName" index = "imrClosingItemMaterialRequestClosingBookedUnitOfMeasureName" key = "imrClosingItemMaterialRequestClosingBookedUnitOfMeasureName" 
                                                        title = "Unit" width = "80" hidden="true"
                                                    />
                                                </sjg:grid >
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div>
                    <sjg:grid
                        id="imrClosingItemMaterialRequestClosingBookedDetailInput_grid"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listItemMaterialRequestClosingProcessedPart"
                        viewrecords="true"
                        rownumbers="true"
                        width="$('#tabmnuBillOfMaterialDetail').width()"
                        shrinkToFit="false" 
                    >
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetail" index="imrClosingItemMaterialRequestClosingBookedDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailCode" index="imrClosingItemMaterialRequestClosingBookedDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedBOMDetailCode" index="imrClosingItemMaterialRequestClosingBookedBOMDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailItemMaterialCode" index="imrClosingItemMaterialRequestClosingBookedDetailItemMaterialCode" key="imrClosingItemMaterialRequestClosingBookedDetailItemMaterialCode" title="Item Material Code" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailItemMaterialName" index="imrClosingItemMaterialRequestClosingBookedDetailItemMaterialName" key="imrClosingItemMaterialRequestClosingBookedDetailItemMaterialName" title="Item Material Name" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailDocumentDetailCode" index="imrClosingItemMaterialRequestClosingBookedDetailDocumentDetailCode" key="imrClosingItemMaterialRequestClosingBookedDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsCode" index="imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsCode" key="imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsRemark" index="imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsRemark" key="imrClosingItemMaterialRequestClosingBookedDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailItemPpoNo" index="imrClosingItemMaterialRequestClosingBookedDetailItemPpoNo" key="imrClosingItemMaterialRequestClosingBookedDetailItemPpoNo" title="Item PPO No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailPartNo" index="imrClosingItemMaterialRequestClosingBookedDetailPartNo" key="imrClosingItemMaterialRequestClosingBookedDetailPartNo" title="Part No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailPartCode" index="imrClosingItemMaterialRequestClosingBookedDetailPartCode" key="imrClosingItemMaterialRequestClosingBookedDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailPartName" index="imrClosingItemMaterialRequestClosingBookedDetailPartName" key="imrClosingItemMaterialRequestClosingBookedDetailPartName" title="Part Name" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailDrawingCode" index="imrClosingItemMaterialRequestClosingBookedDetailDrawingCode" key="imrClosingItemMaterialRequestClosingBookedDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailDimension" index="imrClosingItemMaterialRequestClosingBookedDetailDimension" key="imrClosingItemMaterialRequestClosingBookedDetailDimension" title="Dimension" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailRequiredLength" index="imrClosingItemMaterialRequestClosingBookedDetailRequiredLength" key="imrClosingItemMaterialRequestClosingBookedDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailMaterial" index="imrClosingItemMaterialRequestClosingBookedDetailMaterial" key="imrClosingItemMaterialRequestClosingBookedDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailQuantity" index="imrClosingItemMaterialRequestClosingBookedDetailQuantity" key="imrClosingItemMaterialRequestClosingBookedDetailQuantity" title="Quantity BOM" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailRequirement" index="imrClosingItemMaterialRequestClosingBookedDetailRequirement" key="imrClosingItemMaterialRequestClosingBookedDetailRequirement" title="Requirement" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name = "imrClosingItemMaterialRequestClosingBookedDetailProcessedStatus" index = "imrClosingItemMaterialRequestClosingBookedDetailProcessedStatus" key = "imrClosingItemMaterialRequestClosingBookedDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailRemark" index="imrClosingItemMaterialRequestClosingBookedDetailRemark" key="imrClosingItemMaterialRequestClosingBookedDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailX" index="imrClosingItemMaterialRequestClosingBookedDetailX" key="imrClosingItemMaterialRequestClosingBookedDetailX" title="X" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrClosingItemMaterialRequestClosingBookedDetailRevNo" index="imrClosingItemMaterialRequestClosingBookedDetailRevNo" key="imrClosingItemMaterialRequestClosingBookedDetailRevNo" title="Rev No" 
                            width="80" 
                        />
                    </sjg:grid >    
                </div>
                <br class="spacer" />
                <div>
                    <table>  
                        <tr>
                            <td width="200px" valign="top">
                                <sjg:grid
                                    id="imrClosingItemMaterialRequestClosingInput_grid"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listItemMaterialRequestClosingProcessedPart2"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="700"
                                >
                                    <sjg:gridColumn
                                        name="imrClosingItemMaterialCodeRequestDetail" index="imrClosingItemMaterialCodeRequestDetail" key="imrClosingItemMaterialCodeRequestDetail" 
                                        title="" width="150" sortable="true" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrClosingItemMaterialCodeRequestCode" index="imrClosingItemMaterialCodeRequestCode" key="imrClosingItemMaterialCodeRequestCode" 
                                        title="" width="150" sortable="true" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrClosingItemMaterialCodeRequest" index="imrClosingItemMaterialCodeRequest" key="imrClosingItemMaterialCodeRequest" 
                                        title="Item Material Code" width="150" sortable="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrClosingItemMaterialNameRequest" index="imrClosingItemMaterialNameRequest" key="imrClosingItemMaterialNameRequest" 
                                        title="Item Material Name" width="150" sortable="true" 
                                    />
                                    <sjg:gridColumn
                                        name = "imrClosingItemMaterialRemarkRequest" index = "imrClosingItemMaterialRemarkRequest" key = "imrClosingItemMaterialRemarkRequest" 
                                        title = "Remark" width = "80" edittype="text" editable="true"
                                    />
                                    <sjg:gridColumn
                                        name = "imrClosingItemMaterialPrqQuantityRequest" index = "imrClosingItemMaterialPrqQuantityRequest" key = "imrClosingItemMaterialPrqQuantityRequest" 
                                        title = "PRQ Quantity" width = "80"
                                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                    />
                                    <sjg:gridColumn
                                        name = "imrClosingItemMaterialUnitOfMeasureCodeRequest" index = "imrClosingItemMaterialUnitOfMeasureCodeRequest" key = "imrClosingItemMaterialUnitOfMeasureCodeRequest" 
                                        title = "Unit" width = "80" 
                                    />
                                    <sjg:gridColumn
                                        name = "imrClosingItemMaterialUnitOfMeasureNameRequest" index = "imrClosingItemMaterialUnitOfMeasureNameRequest" key = "imrClosingItemMaterialUnitOfMeasureNameRequest" 
                                        title = "Unit" width = "80" hidden="true"
                                    />
                                </sjg:grid >
                            </td>       
                       </tr>
                    </table>
                </div>
                        <div>
                            <sjg:grid
                                id="imrClosingItemMaterialRequestClosingDetailInput_grid"
                                dataType="local"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listItemMaterialRequestItemRequestPartDetail"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false" 
                                width="$('#tabmnuBillOfMaterialDetail').width()"
                            >
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetail" index="imrClosingItemMaterialRequestClosingDetail" 
                                    title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailCode" index="imrClosingItemMaterialRequestClosingDetailCode" 
                                    title=" " width="50" sortable="true" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailBomDetailCode" index="imrClosingItemMaterialRequestClosingDetailBomDetailCode" 
                                    title=" " width="50" sortable="true" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailItemMaterialCode" index="imrClosingItemMaterialRequestClosingDetailItemMaterialCode" key="imrClosingItemMaterialRequestClosingDetailItemMaterialCode" title="Item Material Code" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailItemMaterialName" index="imrClosingItemMaterialRequestClosingDetailItemMaterialName" key="imrClosingItemMaterialRequestClosingDetailItemMaterialName" title="Item Material Name" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailDocumentDetailCode" index="imrClosingItemMaterialRequestClosingDetailDocumentDetailCode" key="imrClosingItemMaterialRequestClosingDetailDocumentDetailCode" title="Document Detail" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailItemFinishGoodsCode" index="imrClosingItemMaterialRequestClosingDetailItemFinishGoodsCode" key="imrClosingItemMaterialRequestClosingDetailItemFinishGoodsCode" title="IFG Code" 
                                    width="180" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailItemFinishGoodsRemark" index="imrClosingItemMaterialRequestClosingDetailItemFinishGoodsRemark" key="imrClosingItemMaterialRequestClosingDetailItemFinishGoodsRemark" title="IFG Remark" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailItemPpoNo" index="imrClosingItemMaterialRequestClosingDetailItemPpoNo" key="imrClosingItemMaterialRequestClosingDetailItemPpoNo" title="Item PPO No" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailPartNo" index="imrClosingItemMaterialRequestClosingDetailPartNo" key="imrClosingItemMaterialRequestClosingDetailPartNo" title="Part No" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailPartCode" index="imrClosingItemMaterialRequestClosingDetailPartCode" key="imrClosingItemMaterialRequestClosingDetailPartCode" title="Part Code" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailPartName" index="imrClosingItemMaterialRequestClosingDetailPartName" key="imrClosingItemMaterialRequestClosingDetailPartName" title="Part Name" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailDrawingCode" index="imrClosingItemMaterialRequestClosingDetailDrawingCode" key="imrClosingItemMaterialRequestClosingDetailDrawingCode" title="Drawing Code" 
                                    width="80" align="right" sortable="true"
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailDimension" index="imrClosingItemMaterialRequestClosingDetailDimension" key="imrClosingItemMaterialRequestClosingDetailDimension" title="Dimension" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailRequiredLength" index="imrClosingItemMaterialRequestClosingDetailRequiredLength" key="imrClosingItemMaterialRequestClosingDetailRequiredLength" title="Required Length" 
                                    width="80" align="right" editable="false"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailMaterial" index="imrClosingItemMaterialRequestClosingDetailMaterial" key="imrClosingItemMaterialRequestClosingDetailMaterial" title="Material" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailQuantity" index="imrClosingItemMaterialRequestClosingDetailQuantity" key="imrClosingItemMaterialRequestClosingDetailQuantity" title="Quantity BOM" 
                                    width="80" align="right" editable="false"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailRequirement" index="imrClosingItemMaterialRequestClosingDetailRequirement" key="imrClosingItemMaterialRequestClosingDetailRequirement" title="Requirement" 
                                    width="80" align="right" sortable="true"
                                />
                                <sjg:gridColumn
                                    name = "imrClosingItemMaterialRequestClosingDetailProcessedStatus" index = "imrClosingItemMaterialRequestClosingDetailProcessedStatus" key = "imrClosingItemMaterialRequestClosingDetailProcessedStatus" title = "Processed Status" width = "100" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailRemark" index="imrClosingItemMaterialRequestClosingDetailRemark" key="imrClosingItemMaterialRequestClosingDetailRemark" title="Remark" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailX" index="imrClosingItemMaterialRequestClosingDetailX" key="imrClosingItemMaterialRequestClosingDetailX" title="X" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrClosingItemMaterialRequestClosingDetailRevNo" index="imrClosingItemMaterialRequestClosingDetailRevNo" key="imrClosingItemMaterialRequestClosingDetailRevNo" title="Rev No" 
                                    width="80" 
                                />
                            </sjg:grid>    
                        </div>
                    </div>
                </div>
            </div>
                
    </s:form>
</div>
    

