
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
    
    #imrApprovalProductionPlanningOrderDetailInput_grid_pager_center,#imrApprovalBillOfMaterialDetailInput_grid_pager_center,
    #processedPartApproval_grid_pager_center,#imrApprovalItemMaterialRequestApprovalBookedInput_grid_pager_center,#imrApprovalItemMaterialRequestApprovalBookedDetailInput_grid_pager_center,
    #imrApprovalItemMaterialRequestApprovalInput_grid_pager_center,#imrApprovalItemMaterialRequestApprovalDetailInput_grid_pager_center,
    #imrApprovalItemMaterialRequestApprovalDetailInput_grid_pager_center,#imrApprovalItemMaterialRequestApprovalDetailInput_grid_pager_center{
        display: none;
    }
    
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>
<script type="text/javascript">
    var imrApprovalProductionPlanningOrderItemDetailLastRowId = 0,
        imrApprovalBillOfMaterialDetailLastRowId = 0,
        processedPartApprovalRowId = 0,
        imrApprovalMaterialBookedRowId = 0,
        imrApprovalItemMaterialRequestApprovalBookedDetailRowId = 0,
        imrApprovalItemMaterialRequestApprovalRowId= 0,
        imrApprovalItemMaterialRequestApprovalDetailRowId = 0;
    
    var                                    
        txtItemMaterialRequestApprovalCode = $("#itemMaterialRequestApproval\\.code"),
        dtpItemMaterialRequestApprovalTransactionDate = $("#itemMaterialRequestApproval\\.transactionDate"),
        txtitemMaterialRequestApprovalReasonCode = $("#itemMaterialRequestApproval\\.reason\\.code"),
        txtitemMaterialRequestApprovalReasonName = $("#itemMaterialRequestApproval\\.reason\\.name");
        
    $(document).ready(function(){
        hoverButton();
        
        $('input[name="itemMaterialRequestApprovalApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#itemMaterialRequestApproval\\.approvalStatus").val(value);
        });
         $('input[name="itemMaterialRequestApprovalApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            var value="REJECTED";
            $("#itemMaterialRequestApproval\\.approvalStatus").val(value);
        });
        
        itemMaterialRequestApprovalDocumentType($("#itemMaterialRequestApproval\\.productionPlanningOrder\\.documentType").val());
        loadDataImrProductionPlanningOrderDocumentItemApprovalDetail(); 
        processedPartApproval();
        itemBookingApproval();
        itemBookingPartApproval();
        itemRequestApproval();
        itemRequestPartApproval();
        
        $("#btnItemMaterialRequestApprovalSave").click(function(ev){
           
            if ($("#itemMaterialRequestApproval\\.approvalStatus").val()==="PENDING"){
                 alertMessage("Please choose one Approval Status");
                 return;
            } 
           
            formatDateIMRApproval();
            let url = "ppic/item-material-request-approval-save";
            var params = $("#frmItemMaterialRequestApprovalInput").serialize();
            
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateIMRApproval(); 
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
                                            var url = "ppic/item-material-request-approval";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuITEM_MATERIAL_REQUEST_APPROVAL");
                                        }
                                    }]
                });
            }); 
            
        });
        
        $("#btnItemMaterialRequestApprovalCancel").click(function(ev){
           var url = "ppice/item-material-request-approval";
           var params="";
           pageLoad(url,params,"#tabmnuITEM_MATERIAL_REQUEST_APPROVAL");
        });
        
    }); //EOF Ready
    
    function itemMaterialRequestApprovalDocumentType(doctype){
        if (doctype === 'SO'){
             $('#imrApprovalProductionPlanningOrderDocumentTypeRadSO').prop('checked',true);
             $('#imrApprovalProductionPlanningOrderDocumentTypeRadBO').prop('disabled',true);
             $('#imrApprovalProductionPlanningOrderDocumentTypeRadIM').prop('disabled',true);
        }
        else if (doctype === 'BO'){
            $('#imrApprovalProductionPlanningOrderDocumentTypeRadBO').prop('checked',true);
            $('#imrApprovalProductionPlanningOrderDocumentTypeRadSO').prop('disabled',true);
            $('#imrApprovalProductionPlanningOrderDocumentTypeRadIM').prop('disabled',true);
        } 
        else{
            $('#imrApprovalProductionPlanningOrderDocumentTypeRadIM').prop('checked',true);
            $('#imrApprovalProductionPlanningOrderDocumentTypeRadSO').prop('disabled',true);
            $('#imrApprovalProductionPlanningOrderDocumentTypeRadBO').prop('disabled',true);
        }
    }
    
    function loadDataImrProductionPlanningOrderDocumentItemApprovalDetail(){
        var url = "ppic/production-planning-order-detail-data";
        var params = "productionPlanningOrder.code=" + $("#itemMaterialRequestApproval\\.productionPlanningOrder\\.code").val();
            params += "&productionPlanningOrder.documentType=" + $('#itemMaterialRequestApproval\\.productionPlanningOrder\\.documentType') .val();

        $.getJSON(url, params, function(data) {
            imrApprovalProductionPlanningOrderItemDetailLastRowId = 0;
            
            for (var i=0; i<data.listProductionPlanningOrderItemDetail.length; i++) {
                imrApprovalProductionPlanningOrderItemDetailLastRowId++;
                $("#imrApprovalProductionPlanningOrderDetailInput_grid").jqGrid("addRowData", imrApprovalProductionPlanningOrderItemDetailLastRowId, data.listProductionPlanningOrderItemDetail[i]);
                $("#imrApprovalProductionPlanningOrderDetailInput_grid").jqGrid('setRowData',imrApprovalProductionPlanningOrderItemDetailLastRowId,{
                    
                    imrApprovalProductionPlanningOrderDetailDocumentDetailCode             : data.listProductionPlanningOrderItemDetail[i].documentDetailCode,
                    imrApprovalProductionPlanningOrderDetailSortNo                         : data.listProductionPlanningOrderItemDetail[i].documentSortNo,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsCode            : data.listProductionPlanningOrderItemDetail[i].itemFinishGoodsCode,
                    imrApprovalProductionPlanningOrderDetailBillOfMaterialCode             : data.listProductionPlanningOrderItemDetail[i].billOfMaterialCode,
                    imrApprovalProductionPlanningOrderDetailValveTag                       : data.listProductionPlanningOrderItemDetail[i].valveTag,
                    imrApprovalProductionPlanningOrderDetailDataSheet                      : data.listProductionPlanningOrderItemDetail[i].dataSheet,
                    imrApprovalProductionPlanningOrderDetailDescription                    : data.listProductionPlanningOrderItemDetail[i].description,
                    
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstCode   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstName   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignName  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignName  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeCode        : data.listProductionPlanningOrderItemDetail[i].itemSizeCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeName        : data.listProductionPlanningOrderItemDetail[i].itemSizeName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingCode      : data.listProductionPlanningOrderItemDetail[i].itemRatingCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingName      : data.listProductionPlanningOrderItemDetail[i].itemRatingName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreCode        : data.listProductionPlanningOrderItemDetail[i].itemBoreCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreName        : data.listProductionPlanningOrderItemDetail[i].itemBoreName,
                    
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConCode      : data.listProductionPlanningOrderItemDetail[i].itemEndConCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConName      : data.listProductionPlanningOrderItemDetail[i].itemEndConName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyCode        : data.listProductionPlanningOrderItemDetail[i].itemBodyCode,   
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyName        : data.listProductionPlanningOrderItemDetail[i].itemBodyName,   
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallCode        : data.listProductionPlanningOrderItemDetail[i].itemBallCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallName        : data.listProductionPlanningOrderItemDetail[i].itemBallName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatCode        : data.listProductionPlanningOrderItemDetail[i].itemSeatCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatName        : data.listProductionPlanningOrderItemDetail[i].itemSeatName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertName  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemCode        : data.listProductionPlanningOrderItemDetail[i].itemStemCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemName        : data.listProductionPlanningOrderItemDetail[i].itemStemName,
                    
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealCode        : data.listProductionPlanningOrderItemDetail[i].itemSealCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealName        : data.listProductionPlanningOrderItemDetail[i].itemSealName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltCode        : data.listProductionPlanningOrderItemDetail[i].itemBoltCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltName        : data.listProductionPlanningOrderItemDetail[i].itemBoltName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscCode        : data.listProductionPlanningOrderItemDetail[i].itemDiscCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscName        : data.listProductionPlanningOrderItemDetail[i].itemDiscName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesCode      : data.listProductionPlanningOrderItemDetail[i].itemPlatesCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesName      : data.listProductionPlanningOrderItemDetail[i].itemPlatesName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftCode       : data.listProductionPlanningOrderItemDetail[i].itemShaftCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftName       : data.listProductionPlanningOrderItemDetail[i].itemShaftName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringCode      : data.listProductionPlanningOrderItemDetail[i].itemSpringCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringName      : data.listProductionPlanningOrderItemDetail[i].itemSpringName,
                    
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinCode      : data.listProductionPlanningOrderItemDetail[i].itemArmPinCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinName      : data.listProductionPlanningOrderItemDetail[i].itemArmPinName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatCode    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatName    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmCode         : data.listProductionPlanningOrderItemDetail[i].itemArmCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmName         : data.listProductionPlanningOrderItemDetail[i].itemArmName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinCode    : data.listProductionPlanningOrderItemDetail[i].itemHingePinCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinName    : data.listProductionPlanningOrderItemDetail[i].itemHingePinName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinCode     : data.listProductionPlanningOrderItemDetail[i].itemStopPinCode,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinName     : data.listProductionPlanningOrderItemDetail[i].itemStopPinName,
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorCode    : data.listProductionPlanningOrderItemDetail[i].itemOperatorCode, 
                    imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorName    : data.listProductionPlanningOrderItemDetail[i].itemOperatorName, 
                    
                    imrApprovalProductionPlanningOrderDetailQuantity                       : data.listProductionPlanningOrderItemDetail[i].quantity
                });
            }
            bomApprovalDetail();
        });
    }
    
    function bomApprovalDetail(){
       var url = "engineering/bill-of-material-for-imr";
       var params = "docDetailCode=" + $("#itemMaterialRequestApproval\\.productionPlanningOrder\\.code").val();
       
       $.getJSON(url,params,function(data){
           imrApprovalBillOfMaterialDetailLastRowId = 0;
           
           for (var i=0; i<data.listBillOfMaterialPartDetail.length; i++) {
                imrApprovalBillOfMaterialDetailLastRowId++;
                $("#imrApprovalBillOfMaterialDetailInput_grid").jqGrid("addRowData", imrApprovalBillOfMaterialDetailLastRowId, data.listBillOfMaterialPartDetail[i]);
                $("#imrApprovalBillOfMaterialDetailInput_grid").jqGrid('setRowData',imrApprovalBillOfMaterialDetailLastRowId,{
                    
                    imrApprovalBillOfMaterialDetailCode                           : data.listBillOfMaterialPartDetail[i].code,
                    imrApprovalBillOfMaterialDetailDocumentDetailCode             : data.listBillOfMaterialPartDetail[i].documentDetailCode,
                    imrApprovalBillOfMaterialDetailItemFinishGoodsCode            : data.listBillOfMaterialPartDetail[i].itemFinishGoodsCode,
                    imrApprovalBillOfMaterialDetailItemFinishGoodsRemark          : data.listBillOfMaterialPartDetail[i].itemFinishGoodsRemark,
                    imrApprovalBillOfMaterialDetailItemPpoNo                      : data.listBillOfMaterialPartDetail[i].itemPPONo,
                    imrApprovalBillOfMaterialDetailDocumentSortNo                 : data.listBillOfMaterialPartDetail[i].documentSortNo,
                    imrApprovalBillOfMaterialDetailPartNo                         : data.listBillOfMaterialPartDetail[i].partNo,
                    imrApprovalBillOfMaterialDetailPartCode                       : data.listBillOfMaterialPartDetail[i].partCode,
                    imrApprovalBillOfMaterialDetailPartName                       : data.listBillOfMaterialPartDetail[i].partName,
                    imrApprovalBillOfMaterialDetailDrawingCode                    : data.listBillOfMaterialPartDetail[i].drawingCode,
                    imrApprovalBillOfMaterialDetailDimension                      : data.listBillOfMaterialPartDetail[i].dimension,
                    imrApprovalBillOfMaterialDetailRequiredLength                 : data.listBillOfMaterialPartDetail[i].requiredLength,
                    imrApprovalBillOfMaterialDetailMaterial                       : data.listBillOfMaterialPartDetail[i].material,
                    imrApprovalBillOfMaterialDetailQuantity                       : data.listBillOfMaterialPartDetail[i].quantity,
                    imrApprovalBillOfMaterialDetailRequirement                    : data.listBillOfMaterialPartDetail[i].requirement,
                    imrApprovalBillOfMaterialDetailProcessedStatus                : data.listBillOfMaterialPartDetail[i].processedStatus,
                    imrApprovalBillOfMaterialDetailRemark                         : data.listBillOfMaterialPartDetail[i].remark,
                    imrApprovalBillOfMaterialDetailX                              : data.listBillOfMaterialPartDetail[i].x,
                    imrApprovalBillOfMaterialDetailRevNo                          : data.listBillOfMaterialPartDetail[i].revNo
                });
            }
       });
       
    }
    
    function processedPartApproval(){
        let url = "ppic/item-material-request-processed-part-data";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestApprovalCode.val();
        
        $.post(url, params, function(data){
            for (let j = 0; j<data.listItemMaterialRequestItemProcessedPartDetail.length; j++){
                processedPartApprovalRowId++;
                $("#processedPartApproval_grid").jqGrid('addRowData', processedPartApprovalRowId, data.listItemMaterialRequestItemProcessedPartDetail[j]);
                $("#processedPartApproval_grid").jqGrid('setRowData', processedPartApprovalRowId,{
                    imrApprovalProcessedBillOfMaterialDetailCode                    : data.listItemMaterialRequestItemProcessedPartDetail[j].code,
                    imrApprovalProcessedBillOfMaterialBOMDetailCode                 : data.listItemMaterialRequestItemProcessedPartDetail[j].bomDetailCode,
                    imrApprovalProcessedBillOfMaterialDetailDocumentSortNo          : data.listItemMaterialRequestItemProcessedPartDetail[j].documentSortNo,
                    imrApprovalProcessedBillOfMaterialDetailDocumentDetailCode      : data.listItemMaterialRequestItemProcessedPartDetail[j].documentDetailCode,
                    imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsCode     : data.listItemMaterialRequestItemProcessedPartDetail[j].itemFinishGoodsCode,
                    imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsRemark   : data.listItemMaterialRequestItemProcessedPartDetail[j].itemFinishGoodsRemark,
                    imrApprovalProcessedBillOfMaterialDetailItemPpoNo               : data.listItemMaterialRequestItemProcessedPartDetail[j].itemProductionPlanningOrderNo,
                    imrApprovalProcessedBillOfMaterialDetailPartNo                  : data.listItemMaterialRequestItemProcessedPartDetail[j].partNo,
                    imrApprovalProcessedBillOfMaterialDetailPartCode                : data.listItemMaterialRequestItemProcessedPartDetail[j].partCode,
                    imrApprovalProcessedBillOfMaterialDetailPartName                : data.listItemMaterialRequestItemProcessedPartDetail[j].partName,
                    imrApprovalProcessedBillOfMaterialDetailDrawingCode             : data.listItemMaterialRequestItemProcessedPartDetail[j].drawingCode,
                    imrApprovalProcessedBillOfMaterialDetailDimension               : data.listItemMaterialRequestItemProcessedPartDetail[j].dimension,
                    imrApprovalProcessedBillOfMaterialDetailRequiredLength          : data.listItemMaterialRequestItemProcessedPartDetail[j].requiredLength,
                    imrApprovalProcessedBillOfMaterialDetailMaterial                : data.listItemMaterialRequestItemProcessedPartDetail[j].material,
                    imrApprovalProcessedBillOfMaterialDetailQuantity                : data.listItemMaterialRequestItemProcessedPartDetail[j].quantity,
                    imrApprovalProcessedBillOfMaterialDetailRequirement             : data.listItemMaterialRequestItemProcessedPartDetail[j].requirement,
                    imrApprovalProcessedBillOfMaterialDetailProcessedStatus         : data.listItemMaterialRequestItemProcessedPartDetail[j].processedStatus,
                    imrApprovalProcessedBillOfMaterialDetailRemark                  : data.listItemMaterialRequestItemProcessedPartDetail[j].remark,
                    imrApprovalProcessedBillOfMaterialDetailX                       : data.listItemMaterialRequestItemProcessedPartDetail[j].x,
                    imrApprovalProcessedBillOfMaterialDetailRevNo                   : data.listItemMaterialRequestItemProcessedPartDetail[j].revNo
                });
            }
        });
    }
    
    function itemBookingApproval(){
        let url = "ppic/item-material-request-booking-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestApprovalCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemBookingDetail.length; i++){
               imrApprovalMaterialBookedRowId++;
               $("#imrApprovalItemMaterialRequestApprovalBookedInput_grid").jqGrid('addRowData',imrApprovalMaterialBookedRowId, data.listItemMaterialRequestItemBookingDetail[i]);
               $("#imrApprovalItemMaterialRequestApprovalBookedInput_grid").jqGrid('setRowData',imrApprovalMaterialBookedRowId,{
                   imrApprovalItemMaterialRequestBookedCodeImrBookCode              : data.listItemMaterialRequestItemBookingDetail[i].code,
                   imrApprovalItemMaterialRequestApprovalBookedCode                 : data.listItemMaterialRequestItemBookingDetail[i].itemMaterialCode,
                   imrApprovalItemMaterialRequestApprovalBookedName                 : data.listItemMaterialRequestItemBookingDetail[i].itemMaterialName,
                   imrApprovalItemMaterialRequestApprovalBookedRemark               : data.listItemMaterialRequestItemBookingDetail[i].remark,
                   imrApprovalItemMaterialRequestApprovalBookQuantity               : data.listItemMaterialRequestItemBookingDetail[i].bookingQuantity,
                   imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureCode    : data.listItemMaterialRequestItemBookingDetail[i].uomCode,
                   imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureName    : data.listItemMaterialRequestItemBookingDetail[i].uomName
               });
           }
        });
    }
    
    function itemBookingPartApproval(){
        let url = "ppic/item-material-request-booking-part-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestApprovalCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemBookingPartDetail.length; i++){
               imrApprovalItemMaterialRequestApprovalBookedDetailRowId++;
               $("#imrApprovalItemMaterialRequestApprovalBookedDetailInput_grid").jqGrid('addRowData',imrApprovalItemMaterialRequestApprovalBookedDetailRowId, data.listItemMaterialRequestItemBookingPartDetail[i]);
               $("#imrApprovalItemMaterialRequestApprovalBookedDetailInput_grid").jqGrid('setRowData',imrApprovalItemMaterialRequestApprovalBookedDetailRowId,{
                   imrApprovalItemMaterialRequestApprovalBookedDetailCode                   : data.listItemMaterialRequestItemBookingPartDetail[i].code,
                   imrApprovalItemMaterialRequestApprovalBookedBOMDetailCode                : data.listItemMaterialRequestItemBookingPartDetail[i].bomDetailCode,
                   imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialCode       : data.listItemMaterialRequestItemBookingPartDetail[i].itemMaterialRequestBookingDetailCode,
                   imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialName       : data.listItemMaterialRequestItemBookingPartDetail[i].itemMaterialName,
                   imrApprovalItemMaterialRequestApprovalBookedDetailDocumentDetailCode     : data.listItemMaterialRequestItemBookingPartDetail[i].documentDetailCode,
                   imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsCode    : data.listItemMaterialRequestItemBookingPartDetail[i].itemFinishGoodsCode,
                   imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsRemark  : data.listItemMaterialRequestItemBookingPartDetail[i].itemFinishGoodsRemark,
                   imrApprovalItemMaterialRequestApprovalBookedDetailItemPpoNo              : data.listItemMaterialRequestItemBookingPartDetail[i].itemProductionPlanningOrderNo,
                   imrApprovalItemMaterialRequestApprovalBookedDetailPartNo                 : data.listItemMaterialRequestItemBookingPartDetail[i].partNo,
                   imrApprovalItemMaterialRequestApprovalBookedDetailPartCode               : data.listItemMaterialRequestItemBookingPartDetail[i].partCode,
                   imrApprovalItemMaterialRequestApprovalBookedDetailPartName               : data.listItemMaterialRequestItemBookingPartDetail[i].partName,
                   imrApprovalItemMaterialRequestApprovalBookedDetailDrawingCode            : data.listItemMaterialRequestItemBookingPartDetail[i].drawingCode,
                   imrApprovalItemMaterialRequestApprovalBookedDetailDimension              : data.listItemMaterialRequestItemBookingPartDetail[i].dimension,
                   imrApprovalItemMaterialRequestApprovalBookedDetailRequiredLength         : data.listItemMaterialRequestItemBookingPartDetail[i].requiredLength,
                   imrApprovalItemMaterialRequestApprovalBookedDetailMaterial               : data.listItemMaterialRequestItemBookingPartDetail[i].material,
                   imrApprovalItemMaterialRequestApprovalBookedDetailQuantity               : data.listItemMaterialRequestItemBookingPartDetail[i].quantity,
                   imrApprovalItemMaterialRequestApprovalBookedDetailRequirement            : data.listItemMaterialRequestItemBookingPartDetail[i].requirement,
                   imrApprovalItemMaterialRequestApprovalBookedDetailProcessedStatus        : data.listItemMaterialRequestItemBookingPartDetail[i].processedStatus,
                   imrApprovalItemMaterialRequestApprovalBookedDetailRemark                 : data.listItemMaterialRequestItemBookingPartDetail[i].remark,
                   imrApprovalItemMaterialRequestApprovalBookedDetailX                      : data.listItemMaterialRequestItemBookingPartDetail[i].x,
                   imrApprovalItemMaterialRequestApprovalBookedDetailRevNo                  : data.listItemMaterialRequestItemBookingPartDetail[i].revNo
               });
           }
        });
    }
    
    function itemRequestApproval(){
        let url = "ppic/item-material-request-request-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestApprovalCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemRequestDetail.length; i++){
               imrApprovalItemMaterialRequestApprovalRowId++;
               $("#imrApprovalItemMaterialRequestApprovalInput_grid").jqGrid('addRowData',imrApprovalItemMaterialRequestApprovalRowId, data.listItemMaterialRequestItemRequestDetail[i]);
               $("#imrApprovalItemMaterialRequestApprovalInput_grid").jqGrid('setRowData',imrApprovalItemMaterialRequestApprovalRowId,{
                   imrApprovalItemMaterialCodeRequestCode             : data.listItemMaterialRequestItemRequestDetail[i].code,
                   imrApprovalItemMaterialCodeRequest                 : data.listItemMaterialRequestItemRequestDetail[i].itemMaterialCode,
                   imrApprovalItemMaterialNameRequest                 : data.listItemMaterialRequestItemRequestDetail[i].itemMaterialName,
                   imrApprovalItemMaterialRemarkRequest               : data.listItemMaterialRequestItemRequestDetail[i].remark,
                   imrApprovalItemMaterialPrqQuantityRequest          : data.listItemMaterialRequestItemRequestDetail[i].quantity,
                   imrApprovalItemMaterialUnitOfMeasureCodeRequest    : data.listItemMaterialRequestItemRequestDetail[i].uomCode,
                   imrApprovalItemMaterialUnitOfMeasureNameRequest    : data.listItemMaterialRequestItemRequestDetail[i].uomName
               });
           }
        });
    }
    
    function itemRequestPartApproval(){
        let url = "ppic/item-material-request-request-part-detail";
        let params = "itemMaterialRequest.code=" +txtItemMaterialRequestApprovalCode.val();
        
        $.post(url, params, function(data){
           for(let i=0; i<data.listItemMaterialRequestItemRequestPartDetail.length; i++){
               imrApprovalItemMaterialRequestApprovalDetailRowId++;
               $("#imrApprovalItemMaterialRequestApprovalDetailInput_grid").jqGrid('addRowData',imrApprovalItemMaterialRequestApprovalDetailRowId, data.listItemMaterialRequestItemRequestPartDetail[i]);
               $("#imrApprovalItemMaterialRequestApprovalDetailInput_grid").jqGrid('setRowData',imrApprovalItemMaterialRequestApprovalDetailRowId,{
                   imrApprovalItemMaterialRequestApprovalDetailCode                   : data.listItemMaterialRequestItemRequestPartDetail[i].code,
                   imrApprovalItemMaterialRequestApprovalDetailBomDetailCode          : data.listItemMaterialRequestItemRequestPartDetail[i].bomDetailCode,
                   imrApprovalItemMaterialRequestApprovalDetailItemMaterialCode       : data.listItemMaterialRequestItemRequestPartDetail[i].itemMaterialRequestPurchaseRequestDetailCode,
                   imrApprovalItemMaterialRequestApprovalDetailItemMaterialName       : data.listItemMaterialRequestItemRequestPartDetail[i].itemMaterialName,
                   imrApprovalItemMaterialRequestApprovalDetailDocumentDetailCode     : data.listItemMaterialRequestItemRequestPartDetail[i].documentDetailCode,
                   imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsCode    : data.listItemMaterialRequestItemRequestPartDetail[i].itemFinishGoodsCode,
                   imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsRemark  : data.listItemMaterialRequestItemRequestPartDetail[i].itemFinishGoodsRemark,
                   imrApprovalItemMaterialRequestApprovalDetailItemPpoNo              : data.listItemMaterialRequestItemRequestPartDetail[i].itemProductionPlanningOrderNo,
                   imrApprovalItemMaterialRequestApprovalDetailPartNo                 : data.listItemMaterialRequestItemRequestPartDetail[i].partNo,
                   imrApprovalItemMaterialRequestApprovalDetailPartCode               : data.listItemMaterialRequestItemRequestPartDetail[i].partCode,
                   imrApprovalItemMaterialRequestApprovalDetailPartName               : data.listItemMaterialRequestItemRequestPartDetail[i].partName,
                   imrApprovalItemMaterialRequestApprovalDetailDrawingCode            : data.listItemMaterialRequestItemRequestPartDetail[i].drawingCode,
                   imrApprovalItemMaterialRequestApprovalDetailDimension              : data.listItemMaterialRequestItemRequestPartDetail[i].dimension,
                   imrApprovalItemMaterialRequestApprovalDetailRequiredLength         : data.listItemMaterialRequestItemRequestPartDetail[i].requiredLength,
                   imrApprovalItemMaterialRequestApprovalDetailMaterial               : data.listItemMaterialRequestItemRequestPartDetail[i].material,
                   imrApprovalItemMaterialRequestApprovalDetailQuantity               : data.listItemMaterialRequestItemRequestPartDetail[i].quantity,
                   imrApprovalItemMaterialRequestApprovalDetailRequirement            : data.listItemMaterialRequestItemRequestPartDetail[i].requirement,
                   imrApprovalItemMaterialRequestApprovalDetailProcessedStatus        : data.listItemMaterialRequestItemRequestPartDetail[i].processedStatus,
                   imrApprovalItemMaterialRequestApprovalDetailRemark                 : data.listItemMaterialRequestItemRequestPartDetail[i].remark,
                   imrApprovalItemMaterialRequestApprovalDetailX                      : data.listItemMaterialRequestItemRequestPartDetail[i].x,
                   imrApprovalItemMaterialRequestApprovalDetailRevNo                  : data.listItemMaterialRequestItemRequestPartDetail[i].revNo
               });
           }
        });
    }
    
    function setHeightGridHeader(){
        var ids = jQuery("#imrApprovalItemMaterialRequestApprovalBookedInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#imrApprovalItemMaterialRequestApprovalBookedInput_grid"+" tr").eq(1).height();
            $("#imrApprovalItemMaterialRequestApprovalBookedInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#imrApprovalItemMaterialRequestApprovalBookedInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateIMRApproval(){
        var transactionDateSplit=dtpItemMaterialRequestApprovalTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpItemMaterialRequestApprovalTransactionDate.val(transactionDate);
    }
</script>

<b>ITEM MATERIAL REQUEST APPROVAL</b>
<hr>
<br class="spacer" />

<div id="productionPlanningOrderInput" class="content ui-widget">
    <s:form id="frmItemMaterialRequestApprovalInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerItemMaterialRequestApprovalInput">
            <tr>
                <td align="right" width="100px"><b>IMR No *</b></td>
                <td><s:textfield id="itemMaterialRequestApproval.code" name="itemMaterialRequestApproval.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequestApproval.transactionDate" name="itemMaterialRequestApproval.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>PPO NO </B></td>
                <td colspan="2">
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="itemMaterialRequestApproval.productionPlanningOrder.code" name="itemMaterialRequestApproval.productionPlanningOrder.code" size="20" readonly = "true"></s:textfield>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right" width="100px">Branch</td>
                <td><s:textfield id="itemMaterialRequestApproval.branch.code" name="itemMaterialRequestApproval.branch.code" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>PPO Date </B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequestApproval.productionPlanningOrder.transactionDate" name="itemMaterialRequestApproval.productionPlanningOrder.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Document Type </B></td>
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                <s:radio id="imrApprovalProductionPlanningOrderDocumentTypeRad" name="imrApprovalProductionPlanningOrderDocumentTypeRad" label="Type" list="{'SO','BO','IM'}"></s:radio>
                                <s:textfield id="itemMaterialRequestApproval.productionPlanningOrder.documentType" name="itemMaterialRequestApproval.productionPlanningOrder.documentType" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right"><B>SO/BO/IM </B></td>
                <td><s:textfield id="itemMaterialRequestApproval.productionPlanningOrder.documentCode" name="itemMaterialRequestApproval.productionPlanningOrder.documentCode" size="20" readonly="true"></s:textfield></td>
                </td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Target Date </B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequestApproval.productionPlanningOrder.targetDate" name="itemMaterialRequestApproval.productionPlanningOrder.targetDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Customer *</B></td>
                <td colspan="2">
                    <s:textfield id="itemMaterialRequestApproval.productionPlanningOrder.customer.code" name="itemMaterialRequestApproval.productionPlanningOrder.customer.code" size="20" readonly="true"></s:textfield>
                    <s:textfield id="itemMaterialRequestApproval.productionPlanningOrder.customer.name" name="itemMaterialRequestApproval.productionPlanningOrder.customer.name" size="30" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Warehouse *</B></td>
                <td colspan="2">
                    <s:textfield id="itemMaterialRequestApproval.warehouse.code" name="itemMaterialRequestApproval.warehouse.code" size="20" title=" " readonly="true" ></s:textfield>
                    <s:textfield id="itemMaterialRequestApproval.warehouse.name" name="itemMaterialRequestApproval.warehouse.name" size="30" readonly="true" ></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="itemMaterialRequestApproval.refNo" name="itemMaterialRequestApproval.refNo" readonly="true" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="itemMaterialRequestApproval.remark" name="itemMaterialRequestApproval.remark" cols="53" rows="3" readonly="true" ></s:textarea></td>
            </tr>
            <tr>
                <td align="right">Approval Status </td>
                <s:textfield id="itemMaterialRequestApproval.approvalStatus" name="itemMaterialRequestApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                <td><s:radio id="itemMaterialRequestApprovalApprovalStatusRad" name="itemMaterialRequestApprovalApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
            </tr>
            <tr>
                <td align="right" valign="top">Approval Reason</td>
                <td colspan="2">
                <script type = "text/javascript">
                    $('#itemMaterialRequestApproval_btnReason').click(function(ev) {
                        window.open("./pages/search/search-reason.jsp?iddoc=itemMaterialRequestApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
                    });
                    txtitemMaterialRequestApprovalReasonCode.change(function(ev) {

                        if(txtitemMaterialRequestApprovalReasonCode.val()===""){
                            txtitemMaterialRequestApprovalReasonCode.val("");
                            return;
                        }
                        var url = "master/reason-get";
                        var params = "reason.code=" + txtitemMaterialRequestApprovalReasonCode.val();
                            params += "&reason.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.reasonTemp){
                                txtitemMaterialRequestApprovalReasonCode.val(data.reasonTemp.code);
                                txtitemMaterialRequestApprovalReasonName.val(data.reasonTemp.name);
                            }
                            else{
                                alertMessage("Reason Not Found!",txtitemMaterialRequestApprovalReasonCode);
                                txtitemMaterialRequestApprovalReasonCode.val("");
                                txtitemMaterialRequestApprovalReasonName.val("");
                            }
                        });
                    });
                </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="itemMaterialRequestApproval.approvalReason.code" name="itemMaterialRequestApproval.approvalReason.code" size="25"></s:textfield>
                        <sj:a id="itemMaterialRequestApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="itemMaterialRequestApproval.approvalReason.name" name="itemMaterialRequestApproval.approvalReason.name" size="30" readonly="true"></s:textfield>
                </td>    
            </tr>
            <tr>
                <td align="right" valign="top">Approval Remark</td>
                <td><s:textarea id="itemMaterialRequestApproval.approvalRemark" name="itemMaterialRequestApproval.approvalRemark"  cols="50" rows="2" height="20"></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="itemMaterialRequestApproval.createdBy" name="itemMaterialRequestApproval.createdBy"></s:textfield>
                    <sj:datepicker id="itemMaterialRequestApprovalDateFirstSession" name="itemMaterialRequestApprovalDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="itemMaterialRequestApprovalDateLastSession" name="itemMaterialRequestApprovalDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnItemMaterialRequestApprovalSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnItemMaterialRequestApprovalCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>   
        </table>
              
        <br class="spacer" />
        <br class="spacer" />
                
        <div id="id-item-material-request-detail">
            <div id="imrApprovalProductionPlanningOrderDetailInputGrid">
                <sjg:grid
                    id="imrApprovalProductionPlanningOrderDetailInput_grid"
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
                        name="imrApprovalProductionPlanningOrderDetail" index="imrApprovalProductionPlanningOrderDetail" key="imrApprovalProductionPlanningOrderDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailSortNo" index = "imrApprovalProductionPlanningOrderDetailSortNo" 
                        key = "imrApprovalProductionPlanningOrderDetailSortNo" title = "Sort No" width = "80"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailDocumentDetailCode" index = "imrApprovalProductionPlanningOrderDetailDocumentDetailCode" 
                        key = "imrApprovalProductionPlanningOrderDetailDocumentDetailCode" title = "Document Detail Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailBillOfMaterialCode" index = "imrApprovalProductionPlanningOrderDetailBillOfMaterialCode" 
                        key = "imrApprovalProductionPlanningOrderDetailBillOfMaterialCode" title = "BOM Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsCode" title = "Item Finish Goods" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailValveTag" index = "imrApprovalProductionPlanningOrderDetailValveTag" 
                        key = "imrApprovalProductionPlanningOrderDetailValveTag" title = "Valve Tag" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailDataSheet" index = "imrApprovalProductionPlanningOrderDetailDataSheet" 
                        key = "imrApprovalProductionPlanningOrderDetailDataSheet" title = "Data Sheet" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailDescription" index = "imrApprovalProductionPlanningOrderDetailDescription" 
                        key = "imrApprovalProductionPlanningOrderDetailDescription" title = "Description" width = "120"
                    />
<!------------------------------------>
                    <!--01 Body Cons-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" title = "Body Cons Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyConstName" title = "Body Construction" width = "120"
                    />
                    <!--02 Type Design-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" title = "Type Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" title = "Type Design" width = "120"
                    />
                    <!--03 Seat Design-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" title = "Seat Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" title = "Seat Design" width = "120"
                    />
                    <!--04 Size-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeCode" title = "Size Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSizeName" title = "Size" width = "120"
                    />
                    <!--05 Rating-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingCode" title = "Rating Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsRatingName" title = "Rating" width = "120"
                    />
                    <!--06 Bore-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreCode" title = "Bore Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoreName" title = "Bore" width = "120"
                    />
                    
                    <!--07 End Con-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConCode" title = "End Con Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsEndConName" title = "End Con" width = "120"
                    />
                    <!--08 Body-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyCode" title = "Body Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBodyName" title = "Body" width = "120"
                    />
                    <!--09 Ball-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallCode" title = "Ball Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBallName" title = "Ball" width = "120"
                    />
                    <!--10 Seat-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatCode" title = "Seat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatName" title = "Seat" width = "120"
                    />
                    <!--11 Seat Insert-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" title = "Seat Insert Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" title = "Seat Insert" width = "120"
                    />
                    <!--12 Stem-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemCode" title = "Stem Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStemName" title = "Stem" width = "120"
                    />
                    
                    <!--13 Seal-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealCode" title = "Seal Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSealName" title = "Seal" width = "120"
                    />
                    <!--14 Bolt-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltCode" title = "Bolt Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBoltName" title = "Bolt" width = "120"
                    />
                    <!--15 Disc-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscCode" title = "Disc Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsDiscName" title = "Disc" width = "120"
                    />
                    <!--16 Plates-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesCode" title = "Plates Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsPlatesName" title = "Plates" width = "120"
                    />
                    <!--17 Shaft-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftCode" title = "Shaft Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsShaftName" title = "Shaft" width = "120"
                    />
                    <!--18 Spring-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringCode" title = "Spring Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsSpringName" title = "Spring" width = "120"
                    />
                    
                    <!--19 Arm Pin-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinCode" title = "Arm Pin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmPinName" title = "Arm Pin" width = "120"
                    />
                    <!--20 BackSeat-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" title = "BackSeat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsBackSeatName" title = "BackSeat" width = "120"
                    />
                    <!--21 Arm-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmCode" title = "Arm Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsArmName" title = "Arm" width = "120"
                    />
                    <!--22 HingePin-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinCode" title = "HingePin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsHingePinName" title = "HingePin" width = "120"
                    />
                    <!--23 StopPin-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinCode" title = "StopPin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsStopPinName" title = "StopPin" width = "120"
                    />
                    <!--24 Operator-->
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorCode" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorCode" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorCode" title = "Operator Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorName" index = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorName" 
                        key = "imrApprovalProductionPlanningOrderDetailItemFinishGoodsOperatorName" title = "Operator" width = "120"
                    />
                    <sjg:gridColumn
                        name="imrApprovalProductionPlanningOrderDetailQuantity" index="imrApprovalProductionPlanningOrderDetailQuantity" key="imrApprovalProductionPlanningOrderDetailQuantity" title="PPO Quantity" 
                        width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >  
            </div>
                <br class="spacer" />
                <div>
                    <sjg:grid
                        id="imrApprovalBillOfMaterialDetailInput_grid"
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
                            name="imrApprovalBillOfMaterialDetail" index="imrApprovalBillOfMaterialDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailCode" index="imrApprovalBillOfMaterialDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailDocumentSortNo" index="imrApprovalBillOfMaterialDetailDocumentSortNo" key="imrApprovalBillOfMaterialDetailDocumentSortNo" title="Document Sort No" 
                            width="80" hidden="true"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailDocumentDetailCode" index="imrApprovalBillOfMaterialDetailDocumentDetailCode" key="imrApprovalBillOfMaterialDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailItemFinishGoodsCode" index="imrApprovalBillOfMaterialDetailItemFinishGoodsCode" key="imrApprovalBillOfMaterialDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailItemFinishGoodsRemark" index="imrApprovalBillOfMaterialDetailItemFinishGoodsRemark" key="imrApprovalBillOfMaterialDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="200" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailItemPpoNo" index="imrApprovalBillOfMaterialDetailItemPpoNo" key="imrApprovalBillOfMaterialDetailItemPpoNo" title="Item PPO No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailItemMaterialCode" index="imrApprovalBillOfMaterialDetailItemMaterialCode" key="imrApprovalBillOfMaterialDetailItemMaterialCode" title="IMR No" 
                            width="180"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailItemMaterialDate" index="imrApprovalBillOfMaterialDetailItemMaterialDate" key="imrApprovalBillOfMaterialDetailItemMaterialDate" title="IMR Date" 
                            width="180" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailPartNo" index="imrApprovalBillOfMaterialDetailPartNo" key="imrApprovalBillOfMaterialDetailPartNo" title="Part No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailPartCode" index="imrApprovalBillOfMaterialDetailPartCode" key="imrApprovalBillOfMaterialDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailPartName" index="imrApprovalBillOfMaterialDetailPartName" key="imrApprovalBillOfMaterialDetailPartName" title="Part Name" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailDrawingCode" index="imrApprovalBillOfMaterialDetailDrawingCode" key="imrApprovalBillOfMaterialDetailDrawingCode" title="Drawing Code" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailDimension" index="imrApprovalBillOfMaterialDetailDimension" key="imrApprovalBillOfMaterialDetailDimension" title="Dimension" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailRequiredLength" index="imrApprovalBillOfMaterialDetailRequiredLength" key="imrApprovalBillOfMaterialDetailRequiredLength" title="Required Length" 
                            width="80" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailMaterial" index="imrApprovalBillOfMaterialDetailMaterial" key="imrApprovalBillOfMaterialDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailQuantity" index="imrApprovalBillOfMaterialDetailQuantity" key="imrApprovalBillOfMaterialDetailQuantity" title="Quantity BOM" 
                            width="80" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailRequirement" index="imrApprovalBillOfMaterialDetailRequirement" key="imrApprovalBillOfMaterialDetailRequirement" title="Requirement" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name = "imrApprovalBillOfMaterialDetailProcessedStatus" index = "imrApprovalBillOfMaterialDetailProcessedStatus" key = "imrApprovalBillOfMaterialDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailRemark" index="imrApprovalBillOfMaterialDetailRemark" key="imrApprovalBillOfMaterialDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailX" index="imrApprovalBillOfMaterialDetailX" key="imrApprovalBillOfMaterialDetailX" title="X" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalBillOfMaterialDetailRevNo" index="imrApprovalBillOfMaterialDetailRevNo" key="imrApprovalBillOfMaterialDetailRevNo" title="Rev No" 
                            width="80" 
                        />
                    </sjg:grid >
                </div>
            </div>
                <br class="spacer" />
            <div id = "id-item-material-request-detail-process">
                <div>
                    <sjg:grid
                        id="processedPartApproval_grid"
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
                            name="imrApprovalProcessedBillOfMaterialDetail" index="imrApprovalProcessedBillOfMaterialDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailCode" index="imrApprovalProcessedBillOfMaterialDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialBOMDetailCode" index="imrApprovalProcessedBillOfMaterialBOMDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailDocumentSortNo" index="imrApprovalProcessedBillOfMaterialDetailDocumentSortNo" key="imrApprovalProcessedBillOfMaterialDetailDocumentSortNo" title="Doc Sort No" 
                            width="80" hidden="true"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailDocumentDetailCode" index="imrApprovalProcessedBillOfMaterialDetailDocumentDetailCode" key="imrApprovalProcessedBillOfMaterialDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsCode" index="imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsCode" key="imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsRemark" index="imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsRemark" key="imrApprovalProcessedBillOfMaterialDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailItemPpoNo" index="imrApprovalProcessedBillOfMaterialDetailItemPpoNo" key="imrApprovalProcessedBillOfMaterialDetailItemPpoNo" title="Item PPO No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailPartNo" index="imrApprovalProcessedBillOfMaterialDetailPartNo" key="imrApprovalProcessedBillOfMaterialDetailPartNo" title="Part No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailPartCode" index="imrApprovalProcessedBillOfMaterialDetailPartCode" key="imrApprovalProcessedBillOfMaterialDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailPartName" index="imrApprovalProcessedBillOfMaterialDetailPartName" key="imrApprovalProcessedBillOfMaterialDetailPartName" title="Part Name" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailDrawingCode" index="imrApprovalProcessedBillOfMaterialDetailDrawingCode" key="imrApprovalProcessedBillOfMaterialDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailDimension" index="imrApprovalProcessedBillOfMaterialDetailDimension" key="imrApprovalProcessedBillOfMaterialDetailDimension" title="Dimension" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailRequiredLength" index="imrApprovalProcessedBillOfMaterialDetailRequiredLength" key="imrApprovalProcessedBillOfMaterialDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailMaterial" index="imrApprovalProcessedBillOfMaterialDetailMaterial" key="imrApprovalProcessedBillOfMaterialDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailQuantity" index="imrApprovalProcessedBillOfMaterialDetailQuantity" key="imrApprovalProcessedBillOfMaterialDetailQuantity" title="Quantity BOM" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailRequirement" index="imrApprovalProcessedBillOfMaterialDetailRequirement" key="imrApprovalProcessedBillOfMaterialDetailRequirement" title="Requirement" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name = "imrApprovalProcessedBillOfMaterialDetailProcessedStatus" index = "imrApprovalProcessedBillOfMaterialDetailProcessedStatus" key = "imrApprovalProcessedBillOfMaterialDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailRemark" index="imrApprovalProcessedBillOfMaterialDetailRemark" key="imrApprovalProcessedBillOfMaterialDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailX" index="imrApprovalProcessedBillOfMaterialDetailX" key="imrApprovalProcessedBillOfMaterialDetailX" title="X" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalProcessedBillOfMaterialDetailRevNo" index="imrApprovalProcessedBillOfMaterialDetailRevNo" key="imrApprovalProcessedBillOfMaterialDetailRevNo" title="Rev No" 
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
                                                    id="imrApprovalItemMaterialRequestApprovalBookedInput_grid"
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
                                                        name="imrApprovalItemMaterialRequestBookedCodeDetail" index="imrApprovalItemMaterialRequestBookedCodeDetail" key="imrApprovalItemMaterialRequestBookedCodeDetail" 
                                                        title="" width="150" sortable="true" hidden="true" editable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrApprovalItemMaterialRequestBookedCodeImrBookCode" index="imrApprovalItemMaterialRequestBookedCodeImrBookCode" key="imrApprovalItemMaterialRequestBookedCodeImrBookCode" 
                                                        title="" width="150" sortable="true" hidden="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrApprovalItemMaterialRequestApprovalBookedCode" index="imrApprovalItemMaterialRequestApprovalBookedCode" key="imrApprovalItemMaterialRequestApprovalBookedCode" 
                                                        title="Item Material Code" width="150" sortable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrApprovalItemMaterialRequestApprovalBookedName" index="imrApprovalItemMaterialRequestApprovalBookedName" key="imrApprovalItemMaterialRequestApprovalBookedName" 
                                                        title="Item Material Name" width="150" sortable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrApprovalItemMaterialRequestApprovalBookedRemark" index = "imrApprovalItemMaterialRequestApprovalBookedRemark" key = "imrApprovalItemMaterialRequestApprovalBookedRemark" 
                                                        title = "Remark" width = "80" editable="true" edittype="text" 
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrApprovalItemMaterialRequestApprovalBookQuantity" index = "imrApprovalItemMaterialRequestApprovalBookQuantity" key = "imrApprovalItemMaterialRequestApprovalBookQuantity" 
                                                        title = "Book Quantity" width = "80" formatter="number" editrules="{ double: true }"
                                                        formatoptions= "{ thousandsSeparator:','}"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureCode" index = "imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureCode" key = "imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureCode" 
                                                        title = "Unit" width = "80" 
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureName" index = "imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureName" key = "imrApprovalItemMaterialRequestApprovalBookedUnitOfMeasureName" 
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
                        id="imrApprovalItemMaterialRequestApprovalBookedDetailInput_grid"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listItemMaterialRequestApprovalProcessedPart"
                        viewrecords="true"
                        rownumbers="true"
                        width="$('#tabmnuBillOfMaterialDetail').width()"
                        shrinkToFit="false" 
                    >
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetail" index="imrApprovalItemMaterialRequestApprovalBookedDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailCode" index="imrApprovalItemMaterialRequestApprovalBookedDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedBOMDetailCode" index="imrApprovalItemMaterialRequestApprovalBookedBOMDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialCode" index="imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialCode" key="imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialCode" title="Item Material Code" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialName" index="imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialName" key="imrApprovalItemMaterialRequestApprovalBookedDetailItemMaterialName" title="Item Material Name" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailDocumentDetailCode" index="imrApprovalItemMaterialRequestApprovalBookedDetailDocumentDetailCode" key="imrApprovalItemMaterialRequestApprovalBookedDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsCode" index="imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsCode" key="imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsRemark" index="imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsRemark" key="imrApprovalItemMaterialRequestApprovalBookedDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailItemPpoNo" index="imrApprovalItemMaterialRequestApprovalBookedDetailItemPpoNo" key="imrApprovalItemMaterialRequestApprovalBookedDetailItemPpoNo" title="Item PPO No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailPartNo" index="imrApprovalItemMaterialRequestApprovalBookedDetailPartNo" key="imrApprovalItemMaterialRequestApprovalBookedDetailPartNo" title="Part No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailPartCode" index="imrApprovalItemMaterialRequestApprovalBookedDetailPartCode" key="imrApprovalItemMaterialRequestApprovalBookedDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailPartName" index="imrApprovalItemMaterialRequestApprovalBookedDetailPartName" key="imrApprovalItemMaterialRequestApprovalBookedDetailPartName" title="Part Name" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailDrawingCode" index="imrApprovalItemMaterialRequestApprovalBookedDetailDrawingCode" key="imrApprovalItemMaterialRequestApprovalBookedDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailDimension" index="imrApprovalItemMaterialRequestApprovalBookedDetailDimension" key="imrApprovalItemMaterialRequestApprovalBookedDetailDimension" title="Dimension" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailRequiredLength" index="imrApprovalItemMaterialRequestApprovalBookedDetailRequiredLength" key="imrApprovalItemMaterialRequestApprovalBookedDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailMaterial" index="imrApprovalItemMaterialRequestApprovalBookedDetailMaterial" key="imrApprovalItemMaterialRequestApprovalBookedDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailQuantity" index="imrApprovalItemMaterialRequestApprovalBookedDetailQuantity" key="imrApprovalItemMaterialRequestApprovalBookedDetailQuantity" title="Quantity BOM" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailRequirement" index="imrApprovalItemMaterialRequestApprovalBookedDetailRequirement" key="imrApprovalItemMaterialRequestApprovalBookedDetailRequirement" title="Requirement" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name = "imrApprovalItemMaterialRequestApprovalBookedDetailProcessedStatus" index = "imrApprovalItemMaterialRequestApprovalBookedDetailProcessedStatus" key = "imrApprovalItemMaterialRequestApprovalBookedDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailRemark" index="imrApprovalItemMaterialRequestApprovalBookedDetailRemark" key="imrApprovalItemMaterialRequestApprovalBookedDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailX" index="imrApprovalItemMaterialRequestApprovalBookedDetailX" key="imrApprovalItemMaterialRequestApprovalBookedDetailX" title="X" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrApprovalItemMaterialRequestApprovalBookedDetailRevNo" index="imrApprovalItemMaterialRequestApprovalBookedDetailRevNo" key="imrApprovalItemMaterialRequestApprovalBookedDetailRevNo" title="Rev No" 
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
                                    id="imrApprovalItemMaterialRequestApprovalInput_grid"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listItemMaterialRequestApprovalProcessedPart2"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="700"
                                >
                                    <sjg:gridColumn
                                        name="imrApprovalItemMaterialCodeRequestDetail" index="imrApprovalItemMaterialCodeRequestDetail" key="imrApprovalItemMaterialCodeRequestDetail" 
                                        title="" width="150" sortable="true" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrApprovalItemMaterialCodeRequestCode" index="imrApprovalItemMaterialCodeRequestCode" key="imrApprovalItemMaterialCodeRequestCode" 
                                        title="" width="150" sortable="true" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrApprovalItemMaterialCodeRequest" index="imrApprovalItemMaterialCodeRequest" key="imrApprovalItemMaterialCodeRequest" 
                                        title="Item Material Code" width="150" sortable="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrApprovalItemMaterialNameRequest" index="imrApprovalItemMaterialNameRequest" key="imrApprovalItemMaterialNameRequest" 
                                        title="Item Material Name" width="150" sortable="true" 
                                    />
                                    <sjg:gridColumn
                                        name = "imrApprovalItemMaterialRemarkRequest" index = "imrApprovalItemMaterialRemarkRequest" key = "imrApprovalItemMaterialRemarkRequest" 
                                        title = "Remark" width = "80" edittype="text" editable="true"
                                    />
                                    <sjg:gridColumn
                                        name = "imrApprovalItemMaterialPrqQuantityRequest" index = "imrApprovalItemMaterialPrqQuantityRequest" key = "imrApprovalItemMaterialPrqQuantityRequest" 
                                        title = "PRQ Quantity" width = "80"
                                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                    />
                                    <sjg:gridColumn
                                        name = "imrApprovalItemMaterialUnitOfMeasureCodeRequest" index = "imrApprovalItemMaterialUnitOfMeasureCodeRequest" key = "imrApprovalItemMaterialUnitOfMeasureCodeRequest" 
                                        title = "Unit" width = "80" 
                                    />
                                    <sjg:gridColumn
                                        name = "imrApprovalItemMaterialUnitOfMeasureNameRequest" index = "imrApprovalItemMaterialUnitOfMeasureNameRequest" key = "imrApprovalItemMaterialUnitOfMeasureNameRequest" 
                                        title = "Unit" width = "80" hidden="true"
                                    />
                                </sjg:grid >
                            </td>       
                       </tr>
                    </table>
                </div>
                        <div>
                            <sjg:grid
                                id="imrApprovalItemMaterialRequestApprovalDetailInput_grid"
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
                                    name="imrApprovalItemMaterialRequestApprovalDetail" index="imrApprovalItemMaterialRequestApprovalDetail" 
                                    title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailCode" index="imrApprovalItemMaterialRequestApprovalDetailCode" 
                                    title=" " width="50" sortable="true" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailBomDetailCode" index="imrApprovalItemMaterialRequestApprovalDetailBomDetailCode" 
                                    title=" " width="50" sortable="true" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailItemMaterialCode" index="imrApprovalItemMaterialRequestApprovalDetailItemMaterialCode" key="imrApprovalItemMaterialRequestApprovalDetailItemMaterialCode" title="Item Material Code" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailItemMaterialName" index="imrApprovalItemMaterialRequestApprovalDetailItemMaterialName" key="imrApprovalItemMaterialRequestApprovalDetailItemMaterialName" title="Item Material Name" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailDocumentDetailCode" index="imrApprovalItemMaterialRequestApprovalDetailDocumentDetailCode" key="imrApprovalItemMaterialRequestApprovalDetailDocumentDetailCode" title="Document Detail" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsCode" index="imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsCode" key="imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsCode" title="IFG Code" 
                                    width="180" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsRemark" index="imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsRemark" key="imrApprovalItemMaterialRequestApprovalDetailItemFinishGoodsRemark" title="IFG Remark" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailItemPpoNo" index="imrApprovalItemMaterialRequestApprovalDetailItemPpoNo" key="imrApprovalItemMaterialRequestApprovalDetailItemPpoNo" title="Item PPO No" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailPartNo" index="imrApprovalItemMaterialRequestApprovalDetailPartNo" key="imrApprovalItemMaterialRequestApprovalDetailPartNo" title="Part No" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailPartCode" index="imrApprovalItemMaterialRequestApprovalDetailPartCode" key="imrApprovalItemMaterialRequestApprovalDetailPartCode" title="Part Code" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailPartName" index="imrApprovalItemMaterialRequestApprovalDetailPartName" key="imrApprovalItemMaterialRequestApprovalDetailPartName" title="Part Name" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailDrawingCode" index="imrApprovalItemMaterialRequestApprovalDetailDrawingCode" key="imrApprovalItemMaterialRequestApprovalDetailDrawingCode" title="Drawing Code" 
                                    width="80" align="right" sortable="true"
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailDimension" index="imrApprovalItemMaterialRequestApprovalDetailDimension" key="imrApprovalItemMaterialRequestApprovalDetailDimension" title="Dimension" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailRequiredLength" index="imrApprovalItemMaterialRequestApprovalDetailRequiredLength" key="imrApprovalItemMaterialRequestApprovalDetailRequiredLength" title="Required Length" 
                                    width="80" align="right" editable="false"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailMaterial" index="imrApprovalItemMaterialRequestApprovalDetailMaterial" key="imrApprovalItemMaterialRequestApprovalDetailMaterial" title="Material" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailQuantity" index="imrApprovalItemMaterialRequestApprovalDetailQuantity" key="imrApprovalItemMaterialRequestApprovalDetailQuantity" title="Quantity BOM" 
                                    width="80" align="right" editable="false"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailRequirement" index="imrApprovalItemMaterialRequestApprovalDetailRequirement" key="imrApprovalItemMaterialRequestApprovalDetailRequirement" title="Requirement" 
                                    width="80" align="right" sortable="true"
                                />
                                <sjg:gridColumn
                                    name = "imrApprovalItemMaterialRequestApprovalDetailProcessedStatus" index = "imrApprovalItemMaterialRequestApprovalDetailProcessedStatus" key = "imrApprovalItemMaterialRequestApprovalDetailProcessedStatus" title = "Processed Status" width = "100" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailRemark" index="imrApprovalItemMaterialRequestApprovalDetailRemark" key="imrApprovalItemMaterialRequestApprovalDetailRemark" title="Remark" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailX" index="imrApprovalItemMaterialRequestApprovalDetailX" key="imrApprovalItemMaterialRequestApprovalDetailX" title="X" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrApprovalItemMaterialRequestApprovalDetailRevNo" index="imrApprovalItemMaterialRequestApprovalDetailRevNo" key="imrApprovalItemMaterialRequestApprovalDetailRevNo" title="Rev No" 
                                    width="80" 
                                />
                            </sjg:grid>    
                        </div>
                    </div>
                </div>
            </div>
                
    </s:form>
</div>
    

