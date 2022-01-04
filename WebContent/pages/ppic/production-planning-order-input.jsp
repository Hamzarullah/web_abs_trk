
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
</style>
<script type="text/javascript">
    var productionPlanningOrderItemDetailLastRowId = 0, productionPlanningOrderItemDetailLastSel = -1;
    var                                    
        txtProductionPlanningOrderCode = $("#productionPlanningOrder\\.code"),
        dtpProductionPlanningOrderTransactionDate = $("#productionPlanningOrder\\.transactionDate"),
        dtpProductionPlanningOrderTargetDate = $("#productionPlanningOrder\\.targetDate"),
        txtProductionPlanningOrderBranchCode = $("#productionPlanningOrder\\.branch\\.code"),
        txtProductionPlanningOrderBranchName = $("#productionPlanningOrder\\.branch\\.name"),
        txtProductionPlanningOrderDocumentCode = $("#productionPlanningOrder\\.documentCode"),
        txtProductionPlanningOrderCustomerCode = $("#productionPlanningOrder\\.customer\\.code"),
        txtProductionPlanningOrderCustomerName = $("#productionPlanningOrder\\.customer\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedPPOOptions=false;
        flagIsConfirmedPPO=false;
        hoverButton();
        
        //Set Default View Update
        if($("#productionPlanningOrderUpdateMode").val() === 'true'){

            var documentType = $("#productionPlanningOrder\\.documentType").val();
            if(documentType === 'SO'){
                $('#productionPlanningOrderDocumentTypeRadSO').prop('checked',true);
            }else if(documentType === 'BO'){
                $('#productionPlanningOrderDocumentTypeRadBO').prop('checked',true);
            }else{
                $('#productionPlanningOrderDocumentTypeRadIM').prop('checked',true);
            }
        }
        
        //Set Default View
        $("#btnConfirmProductionPlanningOrderDocumentType").css("display", "block");
        $("#btnUnConfirmProductionPlanningOrderDocumentType").css("display", "none");
        $("#btnUnConfirmProductionPlanningOrder").css("display", "none");
        $("#btnSearchItemFinishGoodsBom").css("display", "none");
        $('#productionPlanningOrderItemDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $('input[name="productionPlanningOrderDocumentTypeRad"][value="SO"]').change(function(ev){
            $("#productionPlanningOrder\\.documentType").val("SO");
        });
                
        $('input[name="productionPlanningOrderDocumentTypeRad"][value="BO"]').change(function(ev){
            $("#productionPlanningOrder\\.documentType").val("BO");
        });
        
        $('input[name="productionPlanningOrderDocumentTypeRad"][value="IM"]').change(function(ev){
            $("#productionPlanningOrder\\.documentType").val("IM");
        });
        
        $("#btnConfirmProductionPlanningOrderDocumentType").click(function(ev) {
            if($('#productionPlanningOrder\\.documentType').val()===""){
                alert("select option Document Type!");
                return;
            }
            
            flagIsConfirmedPPOOptions=true;
            $('#productionPlanningOrderDocumentTypeRadSO').attr('disabled',true);
            $('#productionPlanningOrderDocumentTypeRadBO').attr('disabled',true);
            $('#productionPlanningOrderDocumentTypeRadIM').attr('disabled',true);
            $("#btnConfirmProductionPlanningOrderDocumentType").css("display", "none");
            $("#btnUnConfirmProductionPlanningOrderDocumentType").css("display", "block");
        });
        
        $("#btnUnConfirmProductionPlanningOrderDocumentType").click(function(ev) {
            flagIsConfirmedPPOOptions=false;
            $('#productionPlanningOrderDocumentTypeRadSO').attr('disabled',false);
            $('#productionPlanningOrderDocumentTypeRadBO').attr('disabled',false);
            $('#productionPlanningOrderDocumentTypeRadIM').attr('disabled',false);
            $("#btnConfirmProductionPlanningOrderDocumentType").css("display", "block");
            $("#btnUnConfirmProductionPlanningOrderDocumentType").css("display", "none");          
            txtProductionPlanningOrderDocumentCode.val("");
            txtProductionPlanningOrderCustomerCode.val("");
            txtProductionPlanningOrderCustomerName.val("");
        });
        
        $("#btnConfirmProductionPlanningOrder").click(function(ev) {
            handlers_input_production_planning_order();
            
            if(txtProductionPlanningOrderBranchCode.val()===''){
                alertMessage("Branch Cant be Empty");
                return;
            }
            
            if(!flagIsConfirmedPPOOptions){
                alert("Confirm Document Type Options!");
                return;
            }
         
            if(txtProductionPlanningOrderDocumentCode.val()===''){
                alertMessage("Document Code Cant be Empty");
                return;
            }
            flagIsConfirmedPPO=true;

            if($("#productionPlanningOrderUpdateMode").val() === 'true'){
                loadUpdateDataProductionPlanningOrderDocumentItemDetail();
            }
            
            $("#btnUnConfirmProductionPlanningOrder").css("display", "block");
            $("#btnConfirmProductionPlanningOrder").css("display", "none");
            $("#btnSearchItemFinishGoodsBom").css("display", "block");
            $('#headerProductionPlanningOrderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#productionPlanningOrderItemDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmProductionPlanningOrder").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');

            var rows = jQuery("#productionPlanningOrderItemDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                $("#btnUnConfirmProductionPlanningOrder").css("display", "none");
                $("#btnSearchItemFinishGoodsBom").css("display", "none");
                $("#btnConfirmProductionPlanningOrder").css("display", "block");
                $('#headerProductionPlanningOrderInput').unblock();
                $('#productionPlanningOrderItemDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                flagIsConfirmedPPO=false;
                return;
            }

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
                            flagIsConfirmedPPO=false;
                            $("#productionPlanningOrderItemDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmProductionPlanningOrder").css("display", "none");
                            $("#btnSearchItemFinishGoodsBom").css("display", "none");
                            $("#btnConfirmProductionPlanningOrder").css("display", "block");
                            $('#headerProductionPlanningOrderInput').unblock();
                            $('#productionPlanningOrderItemDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $('#btnProductionPlanningOrderSave').click(function(ev) {
                        
            if(!flagIsConfirmedPPO){
                alertMessage("Please Confirm!",$("#btnConfirmProductionPlanningOrder"),200);
                return;
            }
            
            //Prepare Save Detail Grid
            if(productionPlanningOrderItemDetailLastSel !== -1) {
                $('#productionPlanningOrderItemDetailInput_grid').jqGrid("saveRow",productionPlanningOrderItemDetailLastSel);
            }
            
            var listProductionPlanningOrderItemDetail = new Array();
            var ids = jQuery("#productionPlanningOrderItemDetailInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){
                var data = $("#productionPlanningOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]);
                
                if(parseFloat(data.productionPlanningOrderItemDetailQuantity) > parseFloat(data.productionPlanningOrderItemDetailOrderQuantity)){
                    alertMessage(data.productionPlanningOrderItemDetailDocumentDetailCode+ " PPO Quantity can't greater than Order Quantity ");
                    return;
                }
                
                if(parseFloat(data.productionPlanningOrderItemDetailBalanceQuantity) === 0 && parseFloat(data.productionPlanningOrderItemDetailProcessedQuantity) === parseFloat(data.productionPlanningOrderItemDetailOrderQuantity)){
                    alertMessage(data.productionPlanningOrderItemDetailDocumentDetailCode+ " Quantity is not sufficient");
                    return;
                }
                
                for(var j=i; j<=ids.length-1; j++){
                    var details = $("#productionPlanningOrderItemDetailInput_grid").jqGrid('getRowData',ids[j+1]);
                    if(data.productionPlanningOrderItemDetailSortNo === details.productionPlanningOrderItemDetailSortNo){
                        alertMessage("Sort No Can't Be The Same!");
                        return;
                    }
                }

                var productionPlanningOrderItemDetail = {
                    itemFinishGoods     : { code : data.productionPlanningOrderItemDetailItemFinishGoodsCode },
                    billOfMaterial      : { code : data.productionPlanningOrderItemDetailBillOfMaterialCode},
                    quantity            : data.productionPlanningOrderItemDetailQuantity,
                    documentSortNo      : data.productionPlanningOrderItemDetailSortNo,
                    documentDetailCode  : data.productionPlanningOrderItemDetailDocumentDetailCode
                };
                
                listProductionPlanningOrderItemDetail[i] = productionPlanningOrderItemDetail;
                
            }
            //END Prepare Save Detail Grid

            formatDateProductionPlanningOrder();
            var url="ppic/production-planning-order-save";
            var params = $("#frmProductionPlanningOrderInput").serialize();
                params += "&listProductionPlanningOrderItemDetailJSON=" + $.toJSON(listProductionPlanningOrderItemDetail); 
                
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateProductionPlanningOrder(); 
                    alert(data.errorMessage);
                    return;
                }
                
                var dynamicDialog= $('<div id="conformBox">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>'+data.message+'<br/>Do You Want Input Other One?</div>');

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
                                var url = "purchasing/production-planning-order";
                                var param = "";
                                pageLoad(url, param, "#tabmnuPRODUCTION_PLANNING_ORDER");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "purchasing/production-planning-order";
                                var params = "";
                                pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER");
                            }
                        }]
                });
            });
            
        });
               
        $('#btnProductionPlanningOrderCancel').click(function(ev) {
            var url = "purchasing/production-planning-order";
            var params = "";
            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER"); 
        });
        
        $('#btnSearchItemFinishGoodsBom').click(function(ev) {
            var ids = jQuery("#productionPlanningOrderItemDetailInput_grid").jqGrid('getDataIDs');
            var docType = $("#productionPlanningOrder\\.documentType").val();
            var docCode = $("#productionPlanningOrder\\.documentCode").val();
            window.open("./pages/search/search-item-finish-goods-ppo.jsp?iddoc=productionPlanningOrderItemDetail&type=grid&rowLast="+ids.length+"&iddocumenttype="+docType+"&iddoccode="+docCode,"Search", "scrollbars=1,width=600, height=500");
        });
        
    // Grid Detail button Function
    
        $.subscribe("ProductionPlanningOrderItemDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#productionPlanningOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==productionPlanningOrderItemDetailLastSel) {
                $('#productionPlanningOrderItemDetailInput_grid').jqGrid("saveRow",productionPlanningOrderItemDetailLastSel); 
                $('#productionPlanningOrderItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                productionPlanningOrderItemDetailLastSel=selectedRowID;
            }
            else{
                $('#productionPlanningOrderItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
    }); //EOF Ready
    
    function setProductionPlanningOrderDocumentType(){
        switch($("#productionPlanningOrder\\.documentType").val()){
            case "SO":
                $('input[name="productionPlanningOrderDocumentRad"][value="YES"]').prop('checked',true);
                break;
            case "BO":
                $('input[name="productionPlanningOrderDocumentRad"][value="NO"]').prop('checked',true);
                break;
            case "IM":
                $('input[name="productionPlanningOrderDocumentRad"][value="IM"]').prop('checked',true);
                break;
        } 
    }
    
    function loadUpdateDataProductionPlanningOrderDocumentItemDetail() {
        
        var url = "ppic/production-planning-order-detail-data";
        var params = "productionPlanningOrder.documentType=" + $('#productionPlanningOrder\\.documentType') .val();
            params += "&productionPlanningOrder.code=" + txtProductionPlanningOrderCode.val();
//        alert(params);
        $.getJSON(url, params, function(data) {
            productionPlanningOrderItemDetailLastRowId = 0;
            
            for (var i=0; i<data.listProductionPlanningOrderItemDetail.length; i++) {
                productionPlanningOrderItemDetailLastRowId++;
                $("#productionPlanningOrderItemDetailInput_grid").jqGrid("addRowData", productionPlanningOrderItemDetailLastRowId, data.listProductionPlanningOrderItemDetail[i]);
                $("#productionPlanningOrderItemDetailInput_grid").jqGrid('setRowData',productionPlanningOrderItemDetailLastRowId,{
                    
                    productionPlanningOrderItemDetailItemDelete                     : "delete",
                    
                    productionPlanningOrderItemDetailDocumentDetailCode             : data.listProductionPlanningOrderItemDetail[i].documentDetailCode,
                    productionPlanningOrderItemDetailSortNo                         : data.listProductionPlanningOrderItemDetail[i].documentSortNo,
                    productionPlanningOrderItemDetailItemFinishGoodsCode            : data.listProductionPlanningOrderItemDetail[i].itemFinishGoodsCode,
                    productionPlanningOrderItemDetailBillOfMaterialCode             : data.listProductionPlanningOrderItemDetail[i].billOfMaterialCode,
                    productionPlanningOrderItemDetailValveTag                       : data.listProductionPlanningOrderItemDetail[i].valveTag,
                    productionPlanningOrderItemDetailDataSheet                      : data.listProductionPlanningOrderItemDetail[i].dataSheet,
                    productionPlanningOrderItemDetailDescription                    : data.listProductionPlanningOrderItemDetail[i].description,
                    
                    productionPlanningOrderItemDetailItemFinishGoodsBodyConstCode   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBodyConstName   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionName,
                    productionPlanningOrderItemDetailItemFinishGoodsTypeDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignCode,
                    productionPlanningOrderItemDetailItemFinishGoodsTypeDesignName  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignName,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatDesignName  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignName,
                    productionPlanningOrderItemDetailItemFinishGoodsSizeCode        : data.listProductionPlanningOrderItemDetail[i].itemSizeCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSizeName        : data.listProductionPlanningOrderItemDetail[i].itemSizeName,
                    productionPlanningOrderItemDetailItemFinishGoodsRatingCode      : data.listProductionPlanningOrderItemDetail[i].itemRatingCode,
                    productionPlanningOrderItemDetailItemFinishGoodsRatingName      : data.listProductionPlanningOrderItemDetail[i].itemRatingName,
                    productionPlanningOrderItemDetailItemFinishGoodsBoreCode        : data.listProductionPlanningOrderItemDetail[i].itemBoreCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBoreName        : data.listProductionPlanningOrderItemDetail[i].itemBoreName,
                    
                    productionPlanningOrderItemDetailItemFinishGoodsEndConCode      : data.listProductionPlanningOrderItemDetail[i].itemEndConCode,
                    productionPlanningOrderItemDetailItemFinishGoodsEndConName      : data.listProductionPlanningOrderItemDetail[i].itemEndConName,
                    productionPlanningOrderItemDetailItemFinishGoodsBodyCode        : data.listProductionPlanningOrderItemDetail[i].itemBodyCode,   
                    productionPlanningOrderItemDetailItemFinishGoodsBodyName        : data.listProductionPlanningOrderItemDetail[i].itemBodyName,   
                    productionPlanningOrderItemDetailItemFinishGoodsBallCode        : data.listProductionPlanningOrderItemDetail[i].itemBallCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBallName        : data.listProductionPlanningOrderItemDetail[i].itemBallName,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatCode        : data.listProductionPlanningOrderItemDetail[i].itemSeatCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatName        : data.listProductionPlanningOrderItemDetail[i].itemSeatName,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatInsertCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatInsertName  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertName,
                    productionPlanningOrderItemDetailItemFinishGoodsStemCode        : data.listProductionPlanningOrderItemDetail[i].itemStemCode,
                    productionPlanningOrderItemDetailItemFinishGoodsStemName        : data.listProductionPlanningOrderItemDetail[i].itemStemName,
                    
                    productionPlanningOrderItemDetailItemFinishGoodsSealCode        : data.listProductionPlanningOrderItemDetail[i].itemSealCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSealName        : data.listProductionPlanningOrderItemDetail[i].itemSealName,
                    productionPlanningOrderItemDetailItemFinishGoodsBoltCode        : data.listProductionPlanningOrderItemDetail[i].itemBoltCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBoltName        : data.listProductionPlanningOrderItemDetail[i].itemBoltName,
                    productionPlanningOrderItemDetailItemFinishGoodsDiscCode        : data.listProductionPlanningOrderItemDetail[i].itemDiscCode,
                    productionPlanningOrderItemDetailItemFinishGoodsDiscName        : data.listProductionPlanningOrderItemDetail[i].itemDiscName,
                    productionPlanningOrderItemDetailItemFinishGoodsPlatesCode      : data.listProductionPlanningOrderItemDetail[i].itemPlatesCode,
                    productionPlanningOrderItemDetailItemFinishGoodsPlatesName      : data.listProductionPlanningOrderItemDetail[i].itemPlatesName,
                    productionPlanningOrderItemDetailItemFinishGoodsShaftCode       : data.listProductionPlanningOrderItemDetail[i].itemShaftCode,
                    productionPlanningOrderItemDetailItemFinishGoodsShaftName       : data.listProductionPlanningOrderItemDetail[i].itemShaftName,
                    productionPlanningOrderItemDetailItemFinishGoodsSpringCode      : data.listProductionPlanningOrderItemDetail[i].itemSpringCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSpringName      : data.listProductionPlanningOrderItemDetail[i].itemSpringName,
                    
                    productionPlanningOrderItemDetailItemFinishGoodsArmPinCode      : data.listProductionPlanningOrderItemDetail[i].itemArmPinCode,
                    productionPlanningOrderItemDetailItemFinishGoodsArmPinName      : data.listProductionPlanningOrderItemDetail[i].itemArmPinName,
                    productionPlanningOrderItemDetailItemFinishGoodsBackSeatCode    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBackSeatName    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatName,
                    productionPlanningOrderItemDetailItemFinishGoodsArmCode         : data.listProductionPlanningOrderItemDetail[i].itemArmCode,
                    productionPlanningOrderItemDetailItemFinishGoodsArmName         : data.listProductionPlanningOrderItemDetail[i].itemArmName,
                    productionPlanningOrderItemDetailItemFinishGoodsHingePinCode    : data.listProductionPlanningOrderItemDetail[i].itemHingePinCode,
                    productionPlanningOrderItemDetailItemFinishGoodsHingePinName    : data.listProductionPlanningOrderItemDetail[i].itemHingePinName,
                    productionPlanningOrderItemDetailItemFinishGoodsStopPinCode     : data.listProductionPlanningOrderItemDetail[i].itemStopPinCode,
                    productionPlanningOrderItemDetailItemFinishGoodsStopPinName     : data.listProductionPlanningOrderItemDetail[i].itemStopPinName,
                    productionPlanningOrderItemDetailItemFinishGoodsOperatorCode    : data.listProductionPlanningOrderItemDetail[i].itemOperatorCode, 
                    productionPlanningOrderItemDetailItemFinishGoodsOperatorName    : data.listProductionPlanningOrderItemDetail[i].itemOperatorName, 
                    
                    productionPlanningOrderItemDetailOrderQuantity                  : data.listProductionPlanningOrderItemDetail[i].orderQuantity,
                    productionPlanningOrderItemDetailProcessedQuantity              : data.listProductionPlanningOrderItemDetail[i].processedQty - data.listProductionPlanningOrderItemDetail[i].quantity,
                    productionPlanningOrderItemDetailBalanceQuantity                : data.listProductionPlanningOrderItemDetail[i].balancedQty + data.listProductionPlanningOrderItemDetail[i].quantity,
                    productionPlanningOrderItemDetailQuantity                       : data.listProductionPlanningOrderItemDetail[i].quantity
                });
            }
        });
    }
    
    function loadDataProductionPlanningOrderItemDetail() {
        
        var url = "ppic/production-planning-order-item-detail-data";
        var params = "productionPlanningOrder.code=" + txtProductionPlanningOrderCode.val();
        
        $.getJSON(url, params, function(data) {
            productionPlanningOrderItemDetailLastRowId = 0;

            for (var i=0; i<data.listProductionPlanningOrderItemDetail.length; i++) {
                productionPlanningOrderItemDetailLastRowId++;
                $("#productionPlanningOrderItemDetailInput_grid").jqGrid("addRowData", productionPlanningOrderItemDetailLastRowId, data.listProductionPlanningOrderItemDetail[i]);
                $("#productionPlanningOrderItemDetailInput_grid").jqGrid('setRowData',productionPlanningOrderItemDetailLastRowId,{
                    productionPlanningOrderItemDetailItemDelete            : "delete",
                    productionPlanningOrderItemDetailItemSearch            : "...",
                    productionPlanningOrderItemDetailItemCode              : data.listProductionPlanningOrderItemDetail[i].itemCode,
                    productionPlanningOrderItemDetailItemMaterialName      : data.listProductionPlanningOrderItemDetail[i].itemName,
                    productionPlanningOrderItemDetailQuantity              : data.listProductionPlanningOrderItemDetail[i].quantity,
                    productionPlanningOrderItemDetailUnitOfMeasureCode     :data.listProductionPlanningOrderItemDetail[i].unitOfMeasureCode,
                    productionPlanningOrderItemDetailUnitOfMeasureName     :data.listProductionPlanningOrderItemDetail[i].unitOfMeasureName,
                    productionPlanningOrderItemDetailRemark                : data.listProductionPlanningOrderItemDetail[i].remark
                });
            }
        });
    }
    
    function addRowDataMultiSelectedPPO(lastRowId,defRow){
        
        var ids = jQuery("#productionPlanningOrderItemDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
            $("#productionPlanningOrderItemDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#productionPlanningOrderItemDetailInput_grid").jqGrid('setRowData',lastRowId,{
                    productionPlanningOrderItemDetailItemDelete                     : defRow.productionPlanningOrderItemDetailItemDelete,
                    
                    productionPlanningOrderItemDetailDocumentDetailCode             : defRow.productionPlanningOrderItemDetailDocumentDetailCode,
                    productionPlanningOrderItemDetailSortNo                         : defRow.productionPlanningOrderItemDetailSortNo,
                    productionPlanningOrderItemDetailBillOfMaterialCode             : defRow.productionPlanningOrderItemDetailBillOfMaterialCode,
                    productionPlanningOrderItemDetailItemFinishGoodsCode            : defRow.productionPlanningOrderItemDetailItemFinishGoodsCode,
                    productionPlanningOrderItemDetailValveTag                       : defRow.productionPlanningOrderItemDetailValveTag,
                    productionPlanningOrderItemDetailDataSheet                      : defRow.productionPlanningOrderItemDetailDataSheet,
                    productionPlanningOrderItemDetailDescription                    : defRow.productionPlanningOrderItemDetailDescription,

                    productionPlanningOrderItemDetailItemFinishGoodsBodyConstCode   : defRow.productionPlanningOrderItemDetailItemFinishGoodsBodyConstCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBodyConstName   : defRow.productionPlanningOrderItemDetailItemFinishGoodsBodyConstName,
                    productionPlanningOrderItemDetailItemFinishGoodsTypeDesignCode  : defRow.productionPlanningOrderItemDetailItemFinishGoodsTypeDesignCode,
                    productionPlanningOrderItemDetailItemFinishGoodsTypeDesignName  : defRow.productionPlanningOrderItemDetailItemFinishGoodsTypeDesignName,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatDesignCode  : defRow.productionPlanningOrderItemDetailItemFinishGoodsSeatDesignCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatDesignName  : defRow.productionPlanningOrderItemDetailItemFinishGoodsSeatDesignName,
                    productionPlanningOrderItemDetailItemFinishGoodsSizeCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsSizeCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSizeName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsSizeName,
                    productionPlanningOrderItemDetailItemFinishGoodsRatingCode      : defRow.productionPlanningOrderItemDetailItemFinishGoodsRatingCode,
                    productionPlanningOrderItemDetailItemFinishGoodsRatingName      : defRow.productionPlanningOrderItemDetailItemFinishGoodsRatingName,
                    productionPlanningOrderItemDetailItemFinishGoodsBoreCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBoreCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBoreName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBoreName,

                    productionPlanningOrderItemDetailItemFinishGoodsEndConCode      : defRow.productionPlanningOrderItemDetailItemFinishGoodsEndConCode,
                    productionPlanningOrderItemDetailItemFinishGoodsEndConName      : defRow.productionPlanningOrderItemDetailItemFinishGoodsEndConName,
                    productionPlanningOrderItemDetailItemFinishGoodsBodyCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBodyCode,   
                    productionPlanningOrderItemDetailItemFinishGoodsBodyName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBodyName,   
                    productionPlanningOrderItemDetailItemFinishGoodsBallCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBallCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBallName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBallName,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsSeatCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsSeatName,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatInsertCode  : defRow.productionPlanningOrderItemDetailItemFinishGoodsSeatInsertCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSeatInsertName  : defRow.productionPlanningOrderItemDetailItemFinishGoodsSeatInsertName,
                    productionPlanningOrderItemDetailItemFinishGoodsStemCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsStemCode,
                    productionPlanningOrderItemDetailItemFinishGoodsStemName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsStemName,

                    productionPlanningOrderItemDetailItemFinishGoodsSealCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsSealCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSealName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsSealName,
                    productionPlanningOrderItemDetailItemFinishGoodsBoltCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBoltCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBoltName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsBoltName,
                    productionPlanningOrderItemDetailItemFinishGoodsDiscCode        : defRow.productionPlanningOrderItemDetailItemFinishGoodsDiscCode,
                    productionPlanningOrderItemDetailItemFinishGoodsDiscName        : defRow.productionPlanningOrderItemDetailItemFinishGoodsDiscName,
                    productionPlanningOrderItemDetailItemFinishGoodsPlatesCode      : defRow.productionPlanningOrderItemDetailItemFinishGoodsPlatesCode,
                    productionPlanningOrderItemDetailItemFinishGoodsPlatesName      : defRow.productionPlanningOrderItemDetailItemFinishGoodsPlatesName,
                    productionPlanningOrderItemDetailItemFinishGoodsShaftCode       : defRow.productionPlanningOrderItemDetailItemFinishGoodsShaftCode,
                    productionPlanningOrderItemDetailItemFinishGoodsShaftName       : defRow.productionPlanningOrderItemDetailItemFinishGoodsShaftName,
                    productionPlanningOrderItemDetailItemFinishGoodsSpringCode      : defRow.productionPlanningOrderItemDetailItemFinishGoodsSpringCode,
                    productionPlanningOrderItemDetailItemFinishGoodsSpringName      : defRow.productionPlanningOrderItemDetailItemFinishGoodsSpringName,

                    productionPlanningOrderItemDetailItemFinishGoodsArmPinCode      : defRow.productionPlanningOrderItemDetailItemFinishGoodsArmPinCode,
                    productionPlanningOrderItemDetailItemFinishGoodsArmPinName      : defRow.productionPlanningOrderItemDetailItemFinishGoodsArmPinName,
                    productionPlanningOrderItemDetailItemFinishGoodsBackSeatCode    : defRow.productionPlanningOrderItemDetailItemFinishGoodsBackSeatCode,
                    productionPlanningOrderItemDetailItemFinishGoodsBackSeatName    : defRow.productionPlanningOrderItemDetailItemFinishGoodsBackSeatName,
                    productionPlanningOrderItemDetailItemFinishGoodsArmCode         : defRow.productionPlanningOrderItemDetailItemFinishGoodsArmCode,
                    productionPlanningOrderItemDetailItemFinishGoodsArmName         : defRow.productionPlanningOrderItemDetailItemFinishGoodsArmName,
                    productionPlanningOrderItemDetailItemFinishGoodsHingePinCode    : defRow.productionPlanningOrderItemDetailItemFinishGoodsHingePinCode,
                    productionPlanningOrderItemDetailItemFinishGoodsHingePinName    : defRow.productionPlanningOrderItemDetailItemFinishGoodsHingePinName,
                    productionPlanningOrderItemDetailItemFinishGoodsStopPinCode     : defRow.productionPlanningOrderItemDetailItemFinishGoodsStopPinCode,
                    productionPlanningOrderItemDetailItemFinishGoodsStopPinName     : defRow.productionPlanningOrderItemDetailItemFinishGoodsStopPinName,
                    productionPlanningOrderItemDetailItemFinishGoodsOperatorCode    : defRow.productionPlanningOrderItemDetailItemFinishGoodsOperatorCode, 
                    productionPlanningOrderItemDetailItemFinishGoodsOperatorName    : defRow.productionPlanningOrderItemDetailItemFinishGoodsOperatorName, 

                    productionPlanningOrderItemDetailOrderQuantity                  : defRow.productionPlanningOrderItemDetailOrderQuantity,
                    productionPlanningOrderItemDetailProcessedQuantity              : defRow.productionPlanningOrderItemDetailProcessedQuantity,
                    productionPlanningOrderItemDetailBalanceQuantity                : defRow.productionPlanningOrderItemDetailBalanceQuantity
            });
            
        setHeightGridProductionPlanningOrderItemDetail();
 }
    
    // function Grid Detail
    function setHeightGridProductionPlanningOrderItemDetail(){
        var ids = jQuery("#productionPlanningOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#productionPlanningOrderItemDetailInput_grid"+" tr").eq(1).height();
            $("#productionPlanningOrderItemDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#productionPlanningOrderItemDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function productionPlanningOrderItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#productionPlanningOrderItemDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#productionPlanningOrderItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridProductionPlanningOrderItemDetail();
    }
    
    function formatDateProductionPlanningOrder(){
        var transactionDate=formatDatePPO(dtpProductionPlanningOrderTransactionDate.val(),false);
        dtpProductionPlanningOrderTransactionDate.val(transactionDate);  
        var targetDate=formatDatePPO(dtpProductionPlanningOrderTargetDate.val(),false);
        dtpProductionPlanningOrderTargetDate.val(targetDate);  
    }
    
    function handlers_input_production_planning_order(){
        
        if(txtProductionPlanningOrderBranchCode.val()===""){
            handlersInput(txtProductionPlanningOrderBranchCode);
        }else{
            unHandlersInput(txtProductionPlanningOrderBranchCode);
        }
     
    }
    
    function formatDatePPO(date, useTime) {
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
</script>
<s:url id="remotedetailurlProductionPlanningOrderItemDetailInput" action="" />

<b>PRODUCTION PLANNING ORDER</b>
<hr>
<br class="spacer" />

<div id="productionPlanningOrderInput" class="content ui-widget">
    <s:form id="frmProductionPlanningOrderInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerProductionPlanningOrderInput">
            <tr>
                <td align="right" width="100px"><b>PPO No *</b></td>
                <td><s:textfield id="productionPlanningOrder.code" name="productionPlanningOrder.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                    
                        $('#productionPlanningOrder_btnBranch').click(function(ev) {
                            window.open("./pages/search/search-branch.jsp?iddoc=productionPlanningOrder&idsubdoc=branch","Search", "width=600, height=500");
                        });
                    
                        txtProductionPlanningOrderBranchCode.change(function(ev) {

                            if(txtProductionPlanningOrderBranchCode.val()===""){
                                txtProductionPlanningOrderBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtProductionPlanningOrderBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtProductionPlanningOrderBranchCode.val(data.branchTemp.code);
                                    txtProductionPlanningOrderBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtProductionPlanningOrderBranchCode);
                                    txtProductionPlanningOrderBranchCode.val("");
                                    txtProductionPlanningOrderBranchName.val("");
                                }
                            });
                        });
                    
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="productionPlanningOrder.branch.code" name="productionPlanningOrder.branch.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                        <sj:a id="productionPlanningOrder_btnBranch" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="productionPlanningOrder.branch.name" name="productionPlanningOrder.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="productionPlanningOrder.transactionDate" name="productionPlanningOrder.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Document Type *</B></td>
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                <s:radio id="productionPlanningOrderDocumentTypeRad" name="productionPlanningOrderDocumentTypeRad" label="Type" list="{'SO','BO','IM'}"></s:radio>
                                <s:textfield id="productionPlanningOrder.documentType" name="productionPlanningOrder.documentType" size="20" style="display:none"></s:textfield>
                            </td>
                            <td width="10px"/>
                            <td>
                                <sj:a href="#" id="btnConfirmProductionPlanningOrderDocumentType" button="true" style="width: 80px">Confirm</sj:a>
                                <sj:a href="#" id="btnUnConfirmProductionPlanningOrderDocumentType" button="true" style="width: 90px">UnConfirm</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right"><B>SO/BO/IM *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        $('#productionPlanningOrder_btnDocument').click(function(ev) {
                            if(!flagIsConfirmedPPOOptions){
                                alert("Confirm Document Type Options!");
                                return;
                            }
                            window.open("./pages/search/search-customer-order-document.jsp?iddoc=productionPlanningOrder&iddoctype="+$('#productionPlanningOrder\\.documentType').val()+"&firstDate="+$("#productionPlanningOrderDateFirstSession").val()+"&lastDate="+$("#productionPlanningOrderDateLastSession").val(),"Search", "width=600, height=500");
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="productionPlanningOrder.documentCode" name="productionPlanningOrder.documentCode" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                        <sj:a id="productionPlanningOrder_btnDocument" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Target Date *</B></td>
                <td>
                    <sj:datepicker id="productionPlanningOrder.targetDate" name="productionPlanningOrder.targetDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Customer *</B></td>
                <td colspan="2">
                    <s:textfield id="productionPlanningOrder.customer.code" name="productionPlanningOrder.customer.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="productionPlanningOrder.customer.name" name="productionPlanningOrder.customer.name" size="30" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="productionPlanningOrder.refNo" name="productionPlanningOrder.refNo" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="productionPlanningOrder.remark" name="productionPlanningOrder.remark" cols="53" rows="3" ></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="productionPlanningOrder.createdBy" name="productionPlanningOrder.createdBy"></s:textfield>
                    <sj:datepicker id="productionPlanningOrderDateFirstSession" name="productionPlanningOrderDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="productionPlanningOrderDateLastSession" name="productionPlanningOrderDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                </td>
            </tr>
        </table>
                
        <table>
            <tr>
                <td></td>
                <td>
                    <sj:a href="#" id="btnConfirmProductionPlanningOrder" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmProductionPlanningOrder" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
                
        <table>
            <tr>
                <td></td>
                <td>
                    <sj:a href="#" id="btnSearchItemFinishGoodsBom" button="true">Search Item Finish Goods</sj:a>
                </td>
            </tr>
        </table>        
              
        <br class="spacer" />
        <br class="spacer" />
                
        <div id="id-production-planning-order-detail">
            <div id="productionPlanningOrderItemDetailInputGrid">
                <sjg:grid
                    id="productionPlanningOrderItemDetailInput_grid"
                    caption="PRODUCTION PLANNING ITEM  DETAIL"
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
                    width="$('#tabmnuProductionPlanningOrderItemDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlProductionPlanningOrderItemDetailInput}"
                    onSelectRowTopics="ProductionPlanningOrderItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="productionPlanningOrderItemDetail" index="productionPlanningOrderItemDetail" key="productionPlanningOrderItemDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderItemDetailItemDelete" index="productionPlanningOrderItemDetailItemDelete" title="" width="50" align="center"
                        editable="true"
                        edittype="button"
                        editoptions="{onClick:'productionPlanningOrderItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />
                    <%--<sjg:gridColumn--%>
                        <!--name="productionPlanningOrderItemDetailItemSearch" index="productionPlanningOrderItemDetailItemSearch" title="" width="25" align="center"-->
                        <!--editable="true" dataType="html" edittype="button"-->
                        <!--editoptions="{onClick:'productionPlanningOrderItemDetailInputGrid_SearchItemMaterial_OnClick()', value:'...'}"-->
                    <!--/>-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailSortNo" index = "productionPlanningOrderItemDetailSortNo" 
                        key = "productionPlanningOrderItemDetailSortNo" title = "Sort No" width = "80"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailDocumentDetailCode" index = "productionPlanningOrderItemDetailDocumentDetailCode" 
                        key = "productionPlanningOrderItemDetailDocumentDetailCode" title = "Document Detail Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsCode" index = "productionPlanningOrderItemDetailItemFinishGoodsCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsCode" title = "Item Finish Goods" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailBillOfMaterialCode" index = "productionPlanningOrderItemDetailBillOfMaterialCode" 
                        key = "productionPlanningOrderItemDetailBillOfMaterialCode" title = "BOM Code" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailValveTag" index = "productionPlanningOrderItemDetailValveTag" 
                        key = "productionPlanningOrderItemDetailValveTag" title = "Valve Tag" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailDataSheet" index = "productionPlanningOrderItemDetailDataSheet" 
                        key = "productionPlanningOrderItemDetailDataSheet" title = "Data Sheet" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailDescription" index = "productionPlanningOrderItemDetailDescription" 
                        key = "productionPlanningOrderItemDetailDescription" title = "Description" width = "120"
                    />
<!------------------------------------>
                    <!--01 Body Cons-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBodyConstCode" index = "productionPlanningOrderItemDetailItemFinishGoodsBodyConstCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBodyConstCode" title = "Body Cons Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBodyConstName" index = "productionPlanningOrderItemDetailItemFinishGoodsBodyConstName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBodyConstName" title = "Body Construction" width = "120"
                    />
                    <!--02 Type Design-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsTypeDesignCode" index = "productionPlanningOrderItemDetailItemFinishGoodsTypeDesignCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsTypeDesignCode" title = "Type Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsTypeDesignName" index = "productionPlanningOrderItemDetailItemFinishGoodsTypeDesignName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsTypeDesignName" title = "Type Design" width = "120"
                    />
                    <!--03 Seat Design-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSeatDesignCode" index = "productionPlanningOrderItemDetailItemFinishGoodsSeatDesignCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSeatDesignCode" title = "Seat Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSeatDesignName" index = "productionPlanningOrderItemDetailItemFinishGoodsSeatDesignName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSeatDesignName" title = "Seat Design" width = "120"
                    />
                    <!--04 Size-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSizeCode" index = "productionPlanningOrderItemDetailItemFinishGoodsSizeCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSizeCode" title = "Size Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSizeName" index = "productionPlanningOrderItemDetailItemFinishGoodsSizeName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSizeName" title = "Size" width = "120"
                    />
                    <!--05 Rating-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsRatingCode" index = "productionPlanningOrderItemDetailItemFinishGoodsRatingCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsRatingCode" title = "Rating Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsRatingName" index = "productionPlanningOrderItemDetailItemFinishGoodsRatingName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsRatingName" title = "Rating" width = "120"
                    />
                    <!--06 Bore-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBoreCode" index = "productionPlanningOrderItemDetailItemFinishGoodsBoreCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBoreCode" title = "Bore Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBoreName" index = "productionPlanningOrderItemDetailItemFinishGoodsBoreName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBoreName" title = "Bore" width = "120"
                    />
                    
                    <!--07 End Con-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsEndConCode" index = "productionPlanningOrderItemDetailItemFinishGoodsEndConCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsEndConCode" title = "End Con Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsEndConName" index = "productionPlanningOrderItemDetailItemFinishGoodsEndConName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsEndConName" title = "End Con" width = "120"
                    />
                    <!--08 Body-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBodyCode" index = "productionPlanningOrderItemDetailItemFinishGoodsBodyCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBodyCode" title = "Body Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBodyName" index = "productionPlanningOrderItemDetailItemFinishGoodsBodyName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBodyName" title = "Body" width = "120"
                    />
                    <!--09 Ball-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBallCode" index = "productionPlanningOrderItemDetailItemFinishGoodsBallCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBallCode" title = "Ball Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBallName" index = "productionPlanningOrderItemDetailItemFinishGoodsBallName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBallName" title = "Ball" width = "120"
                    />
                    <!--10 Seat-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSeatCode" index = "productionPlanningOrderItemDetailItemFinishGoodsSeatCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSeatCode" title = "Seat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSeatName" index = "productionPlanningOrderItemDetailItemFinishGoodsSeatName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSeatName" title = "Seat" width = "120"
                    />
                    <!--11 Seat Insert-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSeatInsertCode" index = "productionPlanningOrderItemDetailItemFinishGoodsSeatInsertCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSeatInsertCode" title = "Seat Insert Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSeatInsertName" index = "productionPlanningOrderItemDetailItemFinishGoodsSeatInsertName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSeatInsertName" title = "Seat Insert" width = "120"
                    />
                    <!--12 Stem-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsStemCode" index = "productionPlanningOrderItemDetailItemFinishGoodsStemCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsStemCode" title = "Stem Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsStemName" index = "productionPlanningOrderItemDetailItemFinishGoodsStemName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsStemName" title = "Stem" width = "120"
                    />
                    
                    <!--13 Seal-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSealCode" index = "productionPlanningOrderItemDetailItemFinishGoodsSealCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSealCode" title = "Seal Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSealName" index = "productionPlanningOrderItemDetailItemFinishGoodsSealName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSealName" title = "Seal" width = "120"
                    />
                    <!--14 Bolt-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBoltCode" index = "productionPlanningOrderItemDetailItemFinishGoodsBoltCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBoltCode" title = "Bolt Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBoltName" index = "productionPlanningOrderItemDetailItemFinishGoodsBoltName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBoltName" title = "Bolt" width = "120"
                    />
                    <!--15 Disc-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsDiscCode" index = "productionPlanningOrderItemDetailItemFinishGoodsDiscCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsDiscCode" title = "Disc Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsDiscName" index = "productionPlanningOrderItemDetailItemFinishGoodsDiscName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsDiscName" title = "Disc" width = "120"
                    />
                    <!--16 Plates-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsPlatesCode" index = "productionPlanningOrderItemDetailItemFinishGoodsPlatesCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsPlatesCode" title = "Plates Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsPlatesName" index = "productionPlanningOrderItemDetailItemFinishGoodsPlatesName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsPlatesName" title = "Plates" width = "120"
                    />
                    <!--17 Shaft-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsShaftCode" index = "productionPlanningOrderItemDetailItemFinishGoodsShaftCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsShaftCode" title = "Shaft Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsShaftName" index = "productionPlanningOrderItemDetailItemFinishGoodsShaftName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsShaftName" title = "Shaft" width = "120"
                    />
                    <!--18 Spring-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSpringCode" index = "productionPlanningOrderItemDetailItemFinishGoodsSpringCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSpringCode" title = "Spring Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsSpringName" index = "productionPlanningOrderItemDetailItemFinishGoodsSpringName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsSpringName" title = "Spring" width = "120"
                    />
                    
                    <!--19 Arm Pin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsArmPinCode" index = "productionPlanningOrderItemDetailItemFinishGoodsArmPinCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsArmPinCode" title = "Arm Pin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsArmPinName" index = "productionPlanningOrderItemDetailItemFinishGoodsArmPinName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsArmPinName" title = "Arm Pin" width = "120"
                    />
                    <!--20 BackSeat-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBackSeatCode" index = "productionPlanningOrderItemDetailItemFinishGoodsBackSeatCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBackSeatCode" title = "BackSeat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsBackSeatName" index = "productionPlanningOrderItemDetailItemFinishGoodsBackSeatName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsBackSeatName" title = "BackSeat" width = "120"
                    />
                    <!--21 Arm-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsArmCode" index = "productionPlanningOrderItemDetailItemFinishGoodsArmCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsArmCode" title = "Arm Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsArmName" index = "productionPlanningOrderItemDetailItemFinishGoodsArmName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsArmName" title = "Arm" width = "120"
                    />
                    <!--22 HingePin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsHingePinCode" index = "productionPlanningOrderItemDetailItemFinishGoodsHingePinCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsHingePinCode" title = "HingePin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsHingePinName" index = "productionPlanningOrderItemDetailItemFinishGoodsHingePinName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsHingePinName" title = "HingePin" width = "120"
                    />
                    <!--23 StopPin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsStopPinCode" index = "productionPlanningOrderItemDetailItemFinishGoodsStopPinCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsStopPinCode" title = "StopPin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsStopPinName" index = "productionPlanningOrderItemDetailItemFinishGoodsStopPinName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsStopPinName" title = "StopPin" width = "120"
                    />
                    <!--24 Operator-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsOperatorCode" index = "productionPlanningOrderItemDetailItemFinishGoodsOperatorCode" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsOperatorCode" title = "Operator Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderItemDetailItemFinishGoodsOperatorName" index = "productionPlanningOrderItemDetailItemFinishGoodsOperatorName" 
                        key = "productionPlanningOrderItemDetailItemFinishGoodsOperatorName" title = "Operator" width = "120"
                    />
                    
                    <sjg:gridColumn
                        name="productionPlanningOrderItemDetailOrderQuantity" index="productionPlanningOrderItemDetailOrderQuantity" key="productionPlanningOrderItemDetailOrderQuantity" title="Order Quantity" 
                        width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderItemDetailProcessedQuantity" index="productionPlanningOrderItemDetailProcessedQuantity" key="productionPlanningOrderItemDetailProcessedQuantity" 
                        title="Processed Quantity" width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderItemDetailBalanceQuantity" index="productionPlanningOrderItemDetailBalanceQuantity" key="productionPlanningOrderItemDetailBalanceQuantity" 
                        title="Balance Quantity" width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderItemDetailQuantity" index="productionPlanningOrderItemDetailQuantity" key="productionPlanningOrderItemDetailQuantity" title="PPO Quantity" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >      
                <br class="spacer" />
            </div>
        </div>
                
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnProductionPlanningOrderSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnProductionPlanningOrderCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="productionPlanningOrderUpdateMode" name="productionPlanningOrderUpdateMode"></s:textfield>
                </td>
            </tr>
        </table>      
                
                  
    </s:form>
</div>
    

