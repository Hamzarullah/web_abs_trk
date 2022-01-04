
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #errmsgMinStock,#errmsgMaxStock{
        color: red;
    }
</style>

<script type="text/javascript">
    var itemFinishGoodsValveTypeComponentLastRowId=0;
    
    var 
        txtItemFinishGoodsCode = $("#itemFinishGoods\\.code"),
        txtItemFinishGoodsName = $("#itemFinishGoods\\.name"),
        txtItemFinishGoodsEndUserCode = $("#itemFinishGoods\\.endUser\\.code"),
        txtItemFinishGoodsEndUserName = $("#itemFinishGoods\\.endUser\\.name"),
        txtItemFinishGoodsValveTypeCode = $("#itemFinishGoods\\.valveType\\.code"),
        txtItemFinishGoodsValveTypeName = $("#itemFinishGoods\\.valveType\\.name"),
        txtItemFinishGoodsItemBodyConstructionCode = $("#itemFinishGoods\\.itemBodyConstruction\\.code"),
        txtItemFinishGoodsItemBodyConstructionName = $("#itemFinishGoods\\.itemBodyConstruction\\.name"),
        txtItemFinishGoodsItemTypeDesignCode = $("#itemFinishGoods\\.itemTypeDesign\\.code"),
        txtItemFinishGoodsItemTypeDesignName = $("#itemFinishGoods\\.itemTypeDesign\\.name"),
        txtItemFinishGoodsItemBallCode = $("#itemFinishGoods\\.itemBall\\.code"),
        txtItemFinishGoodsItemBallName = $("#itemFinishGoods\\.itemBall\\.name"),
        txtItemFinishGoodsItemSizeCode = $("#itemFinishGoods\\.itemSize\\.code"),
        txtItemFinishGoodsItemSizeName = $("#itemFinishGoods\\.itemSize\\.name"),
        txtItemFinishGoodsItemRatingCode = $("#itemFinishGoods\\.itemRating\\.code"),
        txtItemFinishGoodsItemRatingName = $("#itemFinishGoods\\.itemRating\\.name"),
        txtItemFinishGoodsItemBoreCode = $("#itemFinishGoods\\.itemBore\\.code"),
        txtItemFinishGoodsItemBoreName = $("#itemFinishGoods\\.itemBore\\.name"),
        txtItemFinishGoodsItemEndConCode = $("#itemFinishGoods\\.itemEndCon\\.code"),
        txtItemFinishGoodsItemEndConName = $("#itemFinishGoods\\.itemEndCon\\.name"),
        txtItemFinishGoodsItemBodyCode = $("#itemFinishGoods\\.itemBody\\.code"),
        txtItemFinishGoodsItemBodyName = $("#itemFinishGoods\\.itemBody\\.name"),
        txtItemFinishGoodsItemStemCode = $("#itemFinishGoods\\.itemStem\\.code"),
        txtItemFinishGoodsItemStemName = $("#itemFinishGoods\\.itemStem\\.name"),
        txtItemFinishGoodsItemSealCode = $("#itemFinishGoods\\.itemSeal\\.code"),
        txtItemFinishGoodsItemSealName = $("#itemFinishGoods\\.itemSeal\\.name"),
        txtItemFinishGoodsItemSeatCode = $("#itemFinishGoods\\.itemSeat\\.code"),
        txtItemFinishGoodsItemSeatName = $("#itemFinishGoods\\.itemSeat\\.name"),
        txtItemFinishGoodsItemSeatInsertCode = $("#itemFinishGoods\\.itemSeatInsert\\.code"),
        txtItemFinishGoodsItemSeatInsertName = $("#itemFinishGoods\\.itemSeatInsert\\.name"),
        txtItemFinishGoodsItemSeatDesignCode = $("#itemFinishGoods\\.itemSeatDesign\\.code"),
        txtItemFinishGoodsItemSeatDesignName = $("#itemFinishGoods\\.itemSeatDesign\\.name"),
        txtItemFinishGoodsItemBoltCode = $("#itemFinishGoods\\.itemBolt\\.code"),
        txtItemFinishGoodsItemBoltName = $("#itemFinishGoods\\.itemBolt\\.name"),
        txtItemFinishGoodsItemOperatorCode = $("#itemFinishGoods\\.itemOperator\\.code"),
        txtItemFinishGoodsItemOperatorName = $("#itemFinishGoods\\.itemOperator\\.name"),
        txtItemFinishGoodsItemArmPinCode = $("#itemFinishGoods\\.itemArmPin\\.code"),
        txtItemFinishGoodsItemArmPinName = $("#itemFinishGoods\\.itemArmPin\\.name"),
        txtItemFinishGoodsItemDiscCode = $("#itemFinishGoods\\.itemDisc\\.code"),
        txtItemFinishGoodsItemDiscName = $("#itemFinishGoods\\.itemDisc\\.name"),
        txtItemFinishGoodsItemBackseatCode = $("#itemFinishGoods\\.itemBackseat\\.code"),
        txtItemFinishGoodsItemBackseatName = $("#itemFinishGoods\\.itemBackseat\\.name"),
        txtItemFinishGoodsItemSpringCode = $("#itemFinishGoods\\.itemSpring\\.code"),
        txtItemFinishGoodsItemSpringName = $("#itemFinishGoods\\.itemSpring\\.name"),
        txtItemFinishGoodsItemPlatesCode = $("#itemFinishGoods\\.itemPlates\\.code"),
        txtItemFinishGoodsItemPlatesName = $("#itemFinishGoods\\.itemPlates\\.name"),
        txtItemFinishGoodsItemShaftCode = $("#itemFinishGoods\\.itemShaft\\.code"),
        txtItemFinishGoodsItemShaftName = $("#itemFinishGoods\\.itemShaft\\.name"),
        txtItemFinishGoodsItemArmCode = $("#itemFinishGoods\\.itemArm\\.code"),
        txtItemFinishGoodsItemArmName = $("#itemFinishGoods\\.itemArm\\.name"),
        txtItemFinishGoodsItemHingePinCode = $("#itemFinishGoods\\.itemHingePin\\.code"),
        txtItemFinishGoodsItemHingePinName = $("#itemFinishGoods\\.itemHingePin\\.name"),
        txtItemFinishGoodsItemStopPinCode = $("#itemFinishGoods\\.itemStopPin\\.code"),
        txtItemFinishGoodsItemStopPinName = $("#itemFinishGoods\\.itemStopPin\\.name"),
        txtItemFinishGoodsRemark = $("#itemFinishGoods\\.remark"),
        rdbItemFinishGoodsActiveStatus = $("#itemFinishGoods\\.activeStatus"),
        txtItemFinishGoodsInActiveBy = $("#itemFinishGoods\\.inActiveBy"),
        txtItemFinishGoodsInActiveDate = $("#itemFinishGoods\\.inActiveDate"),
        txtItemFinishGoodsCreatedBy = $("#itemFinishGoods\\.createdBy"),
        txtItemFinishGoodsCreatedDate = $("#itemFinishGoods\\.createdDate"),
        
        allFieldsItem=$([])
            .add(txtItemFinishGoodsCode)
            .add(txtItemFinishGoodsName)    
            .add(txtItemFinishGoodsEndUserCode)    
            .add(txtItemFinishGoodsEndUserName)    
            .add(txtItemFinishGoodsValveTypeCode)    
            .add(txtItemFinishGoodsValveTypeName)    
            .add(txtItemFinishGoodsItemTypeDesignCode)    
            .add(txtItemFinishGoodsItemTypeDesignName)    
            .add(txtItemFinishGoodsItemSizeCode)    
            .add(txtItemFinishGoodsItemSizeName)    
            .add(txtItemFinishGoodsItemRatingCode)    
            .add(txtItemFinishGoodsItemRatingName)    
            .add(txtItemFinishGoodsItemBoreCode)    
            .add(txtItemFinishGoodsItemBoreName)    
            .add(txtItemFinishGoodsItemEndConCode)    
            .add(txtItemFinishGoodsItemEndConName)    
            .add(txtItemFinishGoodsItemBodyCode)    
            .add(txtItemFinishGoodsItemBodyName)    
            .add(txtItemFinishGoodsItemStemCode)    
            .add(txtItemFinishGoodsItemStemName)    
            .add(txtItemFinishGoodsItemSealCode)
            .add(txtItemFinishGoodsItemSealName)
            .add(txtItemFinishGoodsItemSeatCode)
            .add(txtItemFinishGoodsItemSeatName)
            .add(txtItemFinishGoodsItemSeatInsertCode)
            .add(txtItemFinishGoodsItemSeatInsertName)
            .add(txtItemFinishGoodsItemSeatDesignCode)
            .add(txtItemFinishGoodsItemSeatDesignName)
            .add(txtItemFinishGoodsItemBoltCode)
            .add(txtItemFinishGoodsItemBoltName)
            .add(txtItemFinishGoodsItemOperatorCode)
            .add(txtItemFinishGoodsItemOperatorName)
            .add(txtItemFinishGoodsItemBodyConstructionCode)
            .add(txtItemFinishGoodsItemBodyConstructionName)
            .add(txtItemFinishGoodsItemArmPinCode)
            .add(txtItemFinishGoodsItemArmPinName)
            .add(txtItemFinishGoodsItemDiscCode)
            .add(txtItemFinishGoodsItemDiscName)
            .add(txtItemFinishGoodsItemBackseatCode)
            .add(txtItemFinishGoodsItemBackseatName)
            .add(txtItemFinishGoodsItemSpringCode)
            .add(txtItemFinishGoodsItemSpringName)
            .add(txtItemFinishGoodsItemPlatesCode)
            .add(txtItemFinishGoodsItemPlatesName)
            .add(txtItemFinishGoodsItemArmCode)
            .add(txtItemFinishGoodsItemArmName)
            .add(txtItemFinishGoodsItemHingePinCode)
            .add(txtItemFinishGoodsItemHingePinName)
            .add(txtItemFinishGoodsItemStopPinCode)
            .add(txtItemFinishGoodsItemStopPinName)
            .add(txtItemFinishGoodsRemark)
            .add(rdbItemFinishGoodsActiveStatus)
            .add(txtItemFinishGoodsInActiveBy)
            .add(txtItemFinishGoodsInActiveDate)
            .add(txtItemFinishGoodsCreatedBy)
            .add(txtItemFinishGoodsCreatedDate)
            .add(txtItemFinishGoodsItemBallCode)
            .add(txtItemFinishGoodsItemBallName);
    
        allFieldsItemFinsihGoodsComponent=$([])
            .add(txtItemFinishGoodsItemBallCode)
            .add(txtItemFinishGoodsItemBallName)
            .add(txtItemFinishGoodsItemTypeDesignCode)    
            .add(txtItemFinishGoodsItemTypeDesignName)    
            .add(txtItemFinishGoodsItemSizeCode)    
            .add(txtItemFinishGoodsItemSizeName)    
            .add(txtItemFinishGoodsItemRatingCode)    
            .add(txtItemFinishGoodsItemRatingName)    
            .add(txtItemFinishGoodsItemBoreCode)    
            .add(txtItemFinishGoodsItemBoreName)    
            .add(txtItemFinishGoodsItemEndConCode)    
            .add(txtItemFinishGoodsItemEndConName)    
            .add(txtItemFinishGoodsItemBodyCode)    
            .add(txtItemFinishGoodsItemBodyName)    
            .add(txtItemFinishGoodsItemStemCode)    
            .add(txtItemFinishGoodsItemStemName)    
            .add(txtItemFinishGoodsItemSealCode)
            .add(txtItemFinishGoodsItemSealName)
            .add(txtItemFinishGoodsItemSeatCode)
            .add(txtItemFinishGoodsItemSeatName)
            .add(txtItemFinishGoodsItemSeatInsertCode)
            .add(txtItemFinishGoodsItemSeatInsertName)
            .add(txtItemFinishGoodsItemSeatDesignCode)
            .add(txtItemFinishGoodsItemSeatDesignName)
            .add(txtItemFinishGoodsItemBoltCode)
            .add(txtItemFinishGoodsItemBoltName)
            .add(txtItemFinishGoodsItemOperatorCode)
            .add(txtItemFinishGoodsItemOperatorName)
            .add(txtItemFinishGoodsItemBodyConstructionCode)
            .add(txtItemFinishGoodsItemBodyConstructionName)
            .add(txtItemFinishGoodsItemArmPinCode)
            .add(txtItemFinishGoodsItemArmPinName)
            .add(txtItemFinishGoodsItemDiscCode)
            .add(txtItemFinishGoodsItemDiscName)
            .add(txtItemFinishGoodsItemBackseatCode)
            .add(txtItemFinishGoodsItemBackseatName)
            .add(txtItemFinishGoodsItemSpringCode)
            .add(txtItemFinishGoodsItemSpringName)
            .add(txtItemFinishGoodsItemPlatesCode)
            .add(txtItemFinishGoodsItemPlatesName)
            .add(txtItemFinishGoodsItemArmCode)
            .add(txtItemFinishGoodsItemArmName)
            .add(txtItemFinishGoodsItemHingePinCode)
            .add(txtItemFinishGoodsItemHingePinName)
            .add(txtItemFinishGoodsItemStopPinCode)
            .add(txtItemFinishGoodsItemStopPinName);
    
               
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("itemFinishGoods");
        
        flagIsConfirmedIfg=false;
        
        $("#btnUnConfirmItemFinishGoods").css("display", "none");
        $('#itemFinishGoodsLookUp').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $('#itemFinishGoods\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
       
        $('#itemFinishGoodsSearchActiveStatusRadActive').prop('checked',true);
        $("#itemFinishGoodsSearchActiveStatus").val("true");
        
        $('#itemFinishGoodsSearchInventoryTypeRadAll').prop('checked',true);
        $("#itemFinishGoodsSearchInventoryType").val("");
                
        $('input[name="itemFinishGoodsSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemFinishGoodsSearchActiveStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
        
        $('input[name="itemFinishGoodsSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemFinishGoodsSearchActiveStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
                
        $('input[name="itemFinishGoodsSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemFinishGoodsSearchActiveStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
        
        $('input[name="itemFinishGoods\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemFinishGoods\\.activeStatus").val(value);
        });
                
        $('input[name="itemFinishGoods\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemFinishGoods\\.activeStatus").val(value);
        });
        
        $("#btnItemFinishGoodsNew").click(function(ev){
            var url="master/item-finish-goods-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_itemFinishGoods();
                allFieldsItem.val('').removeClass('ui-state-error');
                showInput("itemFinishGoods");
                hideInput("itemFinishGoodsSearch");
                $('#itemFinishGoods\\.activeStatusActive').prop('checked',true);
                $("#itemFinishGoods\\.activeStatus").val("true");
                $("#itemFinishGoods\\.code").attr('readonly',true);
                $("#itemFinishGoods\\.code").val("AUTO");
                updateRowId = -1;
                $("#itemFinishGoods\\.activeStatus").val("true");
            });
            ev.preventDefault();
        });
        
         $("#btnConfirmItemFinishGoods").click(function(ev) {
            if(txtItemFinishGoodsEndUserCode.val()===''){
                alertMessage("EndUser Cant be Empty");
                return;
            }
            if(txtItemFinishGoodsValveTypeCode.val()===''){
                alertMessage("Valve Type Cant be Empty");
                return;
            }    
            flagIsConfirmedIfg=true;
            $("#btnUnConfirmItemFinishGoods").css("display", "block");
            $("#btnConfirmItemFinishGoods").css("display", "none");   
            $('#headerItemFinishGoodsInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#itemFinishGoodsLookUp').unblock();  
            loadItemFinishGoodsValveTypeComponent();
        });
        
        $("#btnUnConfirmItemFinishGoods").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#salesQuotationDetailInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    $("#btnUnConfirmItemFinishGoods").css("display", "none");
                    $("#btnConfirmItemFinishGoods").css("display", "block");
                    $('#headerItemFinishGoodsInput').unblock();
                    $('#itemFinishGoodsLookUp').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    flagIsConfirmedIfg=false;
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
                                flagIsConfirmedIfg=false;
                                unConfirmation(flagIsConfirmedIfg);
                                allFieldsItemFinsihGoodsComponent.val('').removeClass('ui-state-error');
                                $('.global-default').show();
                                $("#itemFinishGoodsValveTypeComponent_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmItemFinishGoods").css("display", "none");
                                $("#btnConfirmItemFinishGoods").css("display", "block");
                                $('#headerItemFinishGoodsInput').unblock();
                                $('#itemFinishGoodsLookUp').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $("#btnItemFinishGoodsSave").click(function(ev) {
            if(!$("#frmItemFinishGoodsInput").valid()){
                alert("Empy must be Filled in the Form Input");
                return;
            }
            if(txtItemFinishGoodsCode.val()===""){
                handlersInput(txtItemFinishGoodsCode);
                alertMessage("Item Code Can't Empty!",txtItemFinishGoodsCode);
                return;
            }else{
                unHandlersInput(txtItemFinishGoodsCode);
            }
            if(txtItemFinishGoodsRemark.val()===""){
                handlersInput(txtItemFinishGoodsRemark);
                alertMessage("Remark Can't Empty!",txtItemFinishGoodsRemark);
                return;
            }else{
                unHandlersInput(txtItemFinishGoodsRemark);
            }
                       
            var url = "";
           
            if (updateRowId < 0){
                url = "master/item-finish-goods-save";
            }
            else{
                url = "master/item-finish-goods-update";
            }
            
            var params = $("#frmItemFinishGoodsInput").serialize();
 
        $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                alertMessage(data.message);
                hideInput("itemFinishGoods");
                showInput("itemFinishGoodsSearch");
                allFieldsItem.val('').removeClass('ui-state-error');
                reloadGridItem();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemFinishGoodsUpdate").click(function(ev){
            var url="master/item-finish-good-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_itemFinishGoods();
                updateRowId = $("#itemFinishGoods_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemFinishGoods = $("#itemFinishGoods_grid").jqGrid('getRowData', updateRowId);
                var url = "master/item-finish-goods-get-data";
                var params = "itemFinishGoods.code=" + itemFinishGoods.code;

                txtItemFinishGoodsCode.attr("readonly",true);

                $.post(url, params, function(result) {

                    var data = (result);
                        txtItemFinishGoodsCode.val(data.itemFinishGoodsTemp.code);
                        txtItemFinishGoodsName.val(data.itemFinishGoodsTemp.name);
                        txtItemFinishGoodsEndUserCode.val(data.itemFinishGoodsTemp.customerCode);
                        txtItemFinishGoodsEndUserName.val(data.itemFinishGoodsTemp.customerName);
                        txtItemFinishGoodsValveTypeCode.val(data.itemFinishGoodsTemp.valveTypeCode);
                        txtItemFinishGoodsValveTypeName.val(data.itemFinishGoodsTemp.valveTypeName);
                        txtItemFinishGoodsItemTypeDesignCode.val(data.itemFinishGoodsTemp.itemTypeDesignCode);
                        txtItemFinishGoodsItemTypeDesignName.val(data.itemFinishGoodsTemp.itemTypeDesignName);
                        txtItemFinishGoodsItemSizeCode.val(data.itemFinishGoodsTemp.itemSizeCode);
                        txtItemFinishGoodsItemSizeName.val(data.itemFinishGoodsTemp.itemSizeName);
                        txtItemFinishGoodsItemRatingCode.val(data.itemFinishGoodsTemp.itemRatingCode);
                        txtItemFinishGoodsItemRatingName.val(data.itemFinishGoodsTemp.itemRatingName);
                        txtItemFinishGoodsItemBoreCode.val(data.itemFinishGoodsTemp.itemBoreCode);
                        txtItemFinishGoodsItemBoreName.val(data.itemFinishGoodsTemp.itemBoreName);
                        txtItemFinishGoodsItemEndConCode.val(data.itemFinishGoodsTemp.itemEndConCode);
                        txtItemFinishGoodsItemEndConName.val(data.itemFinishGoodsTemp.itemEndConName);
                        txtItemFinishGoodsItemBallCode.val(data.itemFinishGoodsTemp.itemBallCode);
                        txtItemFinishGoodsItemBallName.val(data.itemFinishGoodsTemp.itemBallName);
                        txtItemFinishGoodsItemBodyCode.val(data.itemFinishGoodsTemp.itemBodyCode);
                        txtItemFinishGoodsItemBodyName.val(data.itemFinishGoodsTemp.itemBodyName);
                        txtItemFinishGoodsItemStemCode.val(data.itemFinishGoodsTemp.itemStemCode);
                        txtItemFinishGoodsItemStemName.val(data.itemFinishGoodsTemp.itemStemName);
                        txtItemFinishGoodsItemSealCode.val(data.itemFinishGoodsTemp.itemSealCode);
                        txtItemFinishGoodsItemSealName.val(data.itemFinishGoodsTemp.itemSealName);
                        txtItemFinishGoodsItemSeatCode.val(data.itemFinishGoodsTemp.itemSeatCode);
                        txtItemFinishGoodsItemSeatName.val(data.itemFinishGoodsTemp.itemSeatName);
                        txtItemFinishGoodsItemSeatInsertCode.val(data.itemFinishGoodsTemp.itemSeatInsertCode);
                        txtItemFinishGoodsItemSeatInsertName.val(data.itemFinishGoodsTemp.itemSeatInsertName);
                        txtItemFinishGoodsItemBoltCode.val(data.itemFinishGoodsTemp.itemBoltCode);
                        txtItemFinishGoodsItemBoltName.val(data.itemFinishGoodsTemp.itemBoltName);
                        txtItemFinishGoodsItemSeatDesignCode.val(data.itemFinishGoodsTemp.itemSeatDesignCode);
                        txtItemFinishGoodsItemSeatDesignName.val(data.itemFinishGoodsTemp.itemSeatDesignName);
                        txtItemFinishGoodsItemOperatorCode.val(data.itemFinishGoodsTemp.itemOperatorCode);
                        txtItemFinishGoodsItemOperatorName.val(data.itemFinishGoodsTemp.itemOperatorName);
                        txtItemFinishGoodsItemBodyConstructionCode.val(data.itemFinishGoodsTemp.itemBodyConstructionCode);
                        txtItemFinishGoodsItemBodyConstructionName.val(data.itemFinishGoodsTemp.itemBodyConstructionName);
                        txtItemFinishGoodsItemArmPinCode.val(data.itemFinishGoodsTemp.itemArmPinCode);
                        txtItemFinishGoodsItemArmPinName.val(data.itemFinishGoodsTemp.itemArmPinName);
                        txtItemFinishGoodsItemDiscCode.val(data.itemFinishGoodsTemp.itemDiscCode);
                        txtItemFinishGoodsItemDiscName.val(data.itemFinishGoodsTemp.itemDiscName);
                        txtItemFinishGoodsItemBackseatCode.val(data.itemFinishGoodsTemp.itemBackseatCode);
                        txtItemFinishGoodsItemBackseatName.val(data.itemFinishGoodsTemp.itemBackseatName);
                        txtItemFinishGoodsItemSpringCode.val(data.itemFinishGoodsTemp.itemSpringCode);
                        txtItemFinishGoodsItemSpringName.val(data.itemFinishGoodsTemp.itemSpringName);
                        txtItemFinishGoodsItemPlatesCode.val(data.itemFinishGoodsTemp.itemPlatesCode);
                        txtItemFinishGoodsItemPlatesName.val(data.itemFinishGoodsTemp.itemPlatesName);
                        txtItemFinishGoodsItemShaftCode.val(data.itemFinishGoodsTemp.itemShaftCode);
                        txtItemFinishGoodsItemShaftName.val(data.itemFinishGoodsTemp.itemShaftName);
                        txtItemFinishGoodsItemArmCode.val(data.itemFinishGoodsTemp.itemArmCode);
                        txtItemFinishGoodsItemArmName.val(data.itemFinishGoodsTemp.itemArmName);
                        txtItemFinishGoodsItemHingePinCode.val(data.itemFinishGoodsTemp.itemHingePinCode);
                        txtItemFinishGoodsItemHingePinName.val(data.itemFinishGoodsTemp.itemHingePinName);
                        txtItemFinishGoodsItemStopPinCode.val(data.itemFinishGoodsTemp.itemStopPinCode);
                        txtItemFinishGoodsItemStopPinName.val(data.itemFinishGoodsTemp.itemStopPinName);
                        txtItemFinishGoodsRemark.val(data.itemFinishGoodsTemp.remark);
                        rdbItemFinishGoodsActiveStatus.val(data.itemFinishGoodsTemp.activeStatus);
                        txtItemFinishGoodsCreatedBy.val(data.itemFinishGoodsTemp.createdBy);
                        txtItemFinishGoodsCreatedDate.val(data.itemFinishGoodsTemp.createdDate);
                        
                        if(data.itemFinishGoodsTemp.activeStatus===true) {
                           $('#itemFinishGoods\\.activeStatusActive').prop('checked',true);
                           $("#itemFinishGoods\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemFinishGoods\\.activeStatusInActive').prop('checked',true);              
                           $("#itemFinishGoods\\.activeStatus").val("false");
                        }
                        
//                        txtItemFinishGoodsItemBallCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemBall').hide();
//                        
//                        txtItemFinishGoodsEndUserCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnEndUser').hide();
//                        
//                        txtItemFinishGoodsItemTypeDesignCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemTypeDesign').hide();
//                        
//                        txtItemFinishGoodsItemSizeCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemSize').hide();
//                        
//                        txtItemFinishGoodsItemRatingCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemRating').hide();
//                        
//                        txtItemFinishGoodsItemBoreCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemBore').hide();
//                        
//                        txtItemFinishGoodsItemEndConCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemEndCon').hide();
//                        
//                        txtItemFinishGoodsItemBodyCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemBody').hide();
//                        
//                        txtItemFinishGoodsItemStemCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemStem').hide();
//                        
//                        txtItemFinishGoodsItemSealCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemSeal').hide();
//                        
//                        txtItemFinishGoodsItemSeatCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemSeat').hide();
//                        
//                        txtItemFinishGoodsItemSeatInsertCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemSeatInsert').hide();
//                        
//                        txtItemFinishGoodsItemBoltCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemBolt').hide();
//                        
//                        txtItemFinishGoodsItemSeatDesignCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemSeatDesign').hide();
//                        
//                        txtItemFinishGoodsItemOperatorCode.attr("readonly", true);
//                        $('#itemFinishGoods_btnItemOperator').hide();

                    showInput("itemFinishGoods");
                    hideInput("itemFinishGoodsSearch");
                });    
            });
            ev.preventDefault();
        });
        
        
        $('#btnItemFinishGoodsDelete').click(function(ev) {
            var url="master/item-finish-goods-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#itemFinishGoods_grid").jqGrid('getGridParam','selrow');
            
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemFinishGoods = $("#itemFinishGoods_grid").jqGrid('getRowData', deleteRowId);
                if (confirm("Are You Sure To Delete (Code : " + itemFinishGoods.code + ")")) {
                    var url = "master/item-finish-goods-delete";
                    var params = "itemFinishGoods.code=" + itemFinishGoods.code;

                    $.post(url, params, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }

                        alertMessage(data.message);
                        reloadGridItem();
                    });
                }
                
            }); 
//            ev.preventDefault();
        });
        
       $("#btnItemFinishGoodsCancel").click(function(ev) {
            allFieldsItem.val('').removeClass('ui-state-error');
            hideInput("itemFinishGoods");
            showInput("itemFinishGoodsSearch");
            $('.global-default').show();
            $("#itemFinishGoodsValveTypeComponent_grid").jqGrid('clearGridData');
            $("#btnUnConfirmItemFinishGoods").css("display", "none");
            $("#btnConfirmItemFinishGoods").css("display", "block");
            $('#headerItemFinishGoodsInput').unblock();
            $('#itemFinishGoodsLookUp').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            ev.preventDefault();
        });
     
//        $('#btnItemFinishGoodsRefresh').click(function(ev) {
//            reloadGridItem();
//        });
        
        $('#btnItemFinishGoodsRefresh').click(function(ev) {
            $('#itemFinishGoodsSearchActiveStatusRadActive').prop('checked',true);
            $("#itemFinishGoodsSearchActiveStatus").val("true");
            $("#itemFinishGoods_grid").jqGrid("clearGridData");
            $("#itemFinishGoods_grid").jqGrid("setGridParam",{url:"master/item-finish-goods-data?"});
            $("#itemFinishGoods_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#btnItemFinishGoods_search').click(function(ev) {
            $("#itemFinishGoods_grid").jqGrid("clearGridData");
            $("#itemFinishGoods_grid").jqGrid("setGridParam",{url:"master/item-finish-goods-data?" + $("#frmItemSearchInput").serialize()});
            $("#itemFinishGoods_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
     
       
    });
    
   function reloadGridItem() {
        $('.global-default').show();
        $("#itemFinishGoodsValveTypeComponent_grid").jqGrid('clearGridData');
        $("#btnUnConfirmItemFinishGoods").css("display", "none");
        $("#btnConfirmItemFinishGoods").css("display", "block");
        $('#headerItemFinishGoodsInput').unblock();
        $('#itemFinishGoodsLookUp').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#itemFinishGoods_grid").jqGrid("clearGridData");
        $("#itemFinishGoods_grid").trigger("reloadGrid");
    };
    
    function unHandlers_input_itemFinishGoods(){
        unHandlersInput(txtItemFinishGoodsEndUserCode);
        unHandlersInput(txtItemFinishGoodsValveTypeCode);
    };
    
     function loadItemFinishGoodsValveTypeComponent() {
       
        var url = "master/valve-type-component-detail-data";
        var params = "valveType.code="+txtItemFinishGoodsValveTypeCode.val();   
        
        itemFinishGoodsValveTypeComponentLastRowId=0;
        showLoading();
        
                
        $('.global-default').hide();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listValveTypeComponentDetailTemp.length; i++) {
                itemFinishGoodsValveTypeComponentLastRowId++;
                
                $("#itemFinishGoodsValveTypeComponent_grid").jqGrid("addRowData", itemFinishGoodsValveTypeComponentLastRowId, data.listValveTypeComponentDetailTemp[i]);
                $("#itemFinishGoodsValveTypeComponent_grid").jqGrid('setRowData',itemFinishGoodsValveTypeComponentLastRowId,{
                    itemFinishGoodsValveTypeCode             : data.listValveTypeComponentDetailTemp[i].valveTypeComponentCode,
                    itemFinishGoodsValveTypeName             : data.listValveTypeComponentDetailTemp[i].valveTypeName
                });
            
                $('.'+data.listValveTypeComponentDetailTemp[i].valveTypeComponentCode).show();
                set(data.listValveTypeComponentDetailTemp[i].valveTypeComponentCode);
            }
            setHeightGridValveTypeComponent();
        });
        closeLoading();
    }
    
    function set(data){
        if(data === "BDYDSG"){
            $("#itemFinishGoods\\.itemBodyConstruction\\.code").addClass("required");
            $("#itemFinishGoods\\.itemBodyConstruction\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemBodyConstruction\\.code").css("required",true);
            $("#itemFinishGoods\\.itemBodyConstruction\\.code").css("cssClass","required");
        }else if(data === "TYPDSG"){
            $("#itemFinishGoods\\.itemTypeDesign\\.code").addClass("required");
            $("#itemFinishGoods\\.itemTypeDesign\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemTypeDesign\\.code").css("required",true);
            $("#itemFinishGoods\\.itemTypeDesign\\.code").css("cssClass","required");
        }else if(data === "STDSG"){
            $("#itemFinishGoods\\.itemSeatDesign\\.code").addClass("required");
            $("#itemFinishGoods\\.itemSeatDesign\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemSeatDesign\\.code").css("required",true);
            $("#itemFinishGoods\\.itemSeatDesign\\.code").css("cssClass","required");
        }else if(data === "SIZE"){
            $("#itemFinishGoods\\.itemSize\\.code").addClass("required");
            $("#itemFinishGoods\\.itemSize\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemSize\\.code").css("required",true);
            $("#itemFinishGoods\\.itemSize\\.code").css("cssClass","required");
        }else if(data === "RTG"){
            $("#itemFinishGoods\\.itemRating\\.code").addClass("required");
            $("#itemFinishGoods\\.itemRating\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemRating\\.code").css("required",true);
            $("#itemFinishGoods\\.itemRating\\.code").css("cssClass","required");
        }else if(data === "BORE"){
            $("#itemFinishGoods\\.itemBore\\.code").addClass("required");
            $("#itemFinishGoods\\.itemBore\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemBore\\.code").css("required",true);
            $("#itemFinishGoods\\.itemBore\\.code").css("cssClass","required");
        }else if(data === "ENDCON"){
            $("#itemFinishGoods\\.itemEndCon\\.code").addClass("required");
            $("#itemFinishGoods\\.itemEndCon\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemEndCon\\.code").css("required",true);
            $("#itemFinishGoods\\.itemEndCon\\.code").css("cssClass","required");
        }else if(data === "BDY"){
            $("#itemFinishGoods\\.itemBody\\.code").addClass("required");
            $("#itemFinishGoods\\.itemBody\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemBody\\.code").css("required",true);
            $("#itemFinishGoods\\.itemBody\\.code").css("cssClass","required");
        }else if(data === "BALL"){
            $("#itemFinishGoods\\.itemBall\\.code").addClass("required");
            $("#itemFinishGoods\\.itemBall\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemBall\\.code").css("required",true);
            $("#itemFinishGoods\\.itemBall\\.code").css("cssClass","required");
        }else if(data === "ST"){
            $("#itemFinishGoods\\.itemSeat\\.code").addClass("required");
            $("#itemFinishGoods\\.itemSeat\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemSeat\\.code").css("required",true);
            $("#itemFinishGoods\\.itemSeat\\.code").css("cssClass","required");
        }else if(data === "STINS"){
            $("#itemFinishGoods\\.itemSeatInsert\\.code").addClass("required");
            $("#itemFinishGoods\\.itemSeatInsert\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemSeatInsert\\.code").css("required",true);
            $("#itemFinishGoods\\.itemSeatInsert\\.code").css("cssClass","required");
        }else if(data === "STM"){
            $("#itemFinishGoods\\.itemStem\\.code").addClass("required");
            $("#itemFinishGoods\\.itemStem\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemStem\\.code").css("required",true);
            $("#itemFinishGoods\\.itemStem\\.code").css("cssClass","required");
        }else if(data === "SEAL"){
            $("#itemFinishGoods\\.itemSeal\\.code").addClass("required");
            $("#itemFinishGoods\\.itemSeal\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemSeal\\.code").css("required",true);
            $("#itemFinishGoods\\.itemSeal\\.code").css("cssClass","required");
        }else if(data === "BLT"){
            $("#itemFinishGoods\\.itemBolt\\.code").addClass("required");
            $("#itemFinishGoods\\.itemBolt\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemBolt\\.code").css("required",true);
            $("#itemFinishGoods\\.itemBolt\\.code").css("cssClass","required");
        }else if(data === "DISC"){
            $("#itemFinishGoods\\.itemDisc\\.code").addClass("required");
            $("#itemFinishGoods\\.itemDisc\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemDisc\\.code").css("required",true);
            $("#itemFinishGoods\\.itemDisc\\.code").css("cssClass","required");
        }else if(data === "PLT"){
            $("#itemFinishGoods\\.itemPlates\\.code").addClass("required");
            $("#itemFinishGoods\\.itemPlates\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemPlates\\.code").css("required",true);
            $("#itemFinishGoods\\.itemPlates\\.code").css("cssClass","required");
        }else if(data === "SHFT"){
            $("#itemFinishGoods\\.itemShaft\\.code").addClass("required");
            $("#itemFinishGoods\\.itemShaft\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemShaft\\.code").css("required",true);
            $("#itemFinishGoods\\.itemShaft\\.code").css("cssClass","required");
        }else if(data === "SPRNG"){
            $("#itemFinishGoods\\.itemSpring\\.code").addClass("required");
            $("#itemFinishGoods\\.itemSpring\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemSpring\\.code").css("required",true);
            $("#itemFinishGoods\\.itemSpring\\.code").css("cssClass","required");
        }else if(data === "ARMPIN"){
            $("#itemFinishGoods\\.itemArmPin\\.code").addClass("required");
            $("#itemFinishGoods\\.itemArmPin\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemArmPin\\.code").css("required",true);
            $("#itemFinishGoods\\.itemArmPin\\.code").css("cssClass","required");
        }else if(data === "BCKST"){
            $("#itemFinishGoods\\.itemBackseat\\.code").addClass("required");
            $("#itemFinishGoods\\.itemBackseat\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemBackseat\\.code").css("required",true);
            $("#itemFinishGoods\\.itemBackseat\\.code").css("cssClass","required");
        }else if(data === "ARM"){
            $("#itemFinishGoods\\.itemArm\\.code").addClass("required");
            $("#itemFinishGoods\\.itemArm\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemArm\\.code").css("required",true);
            $("#itemFinishGoods\\.itemArm\\.code").css("cssClass","required");
        }else if(data === "HNGPIN"){
            $("#itemFinishGoods\\.itemHingePin\\.code").addClass("required");
            $("#itemFinishGoods\\.itemHingePin\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemHingePin\\.code").css("required",true);
            $("#itemFinishGoods\\.itemHingePin\\.code").css("cssClass","required");
        }else if(data === "STPPIN"){
            $("#itemFinishGoods\\.itemStopPin\\.code").addClass("required");
            $("#itemFinishGoods\\.itemStopPin\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemStopPin\\.code").css("required",true);
            $("#itemFinishGoods\\.itemStopPin\\.code").css("cssClass","required");
        }else if(data === "OPR"){
            $("#itemFinishGoods\\.itemOperator\\.code").addClass("required");
            $("#itemFinishGoods\\.itemOperator\\.code").addClass("cssClass");
            $("#itemFinishGoods\\.itemOperator\\.code").css("required",true);
            $("#itemFinishGoods\\.itemOperator\\.code").css("cssClass","required");
        }
    }
    
    function unConfirmation(flagIsConfirmedIfg){
        if(flagIsConfirmedIfg === false){
            
//          Body Construction
            $("#itemFinishGoods\\.itemBodyConstruction\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemBodyConstruction\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemBodyConstruction\\.code").css("required",false);
            
//          Type Design
            $("#itemFinishGoods\\.itemTypeDesign\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemTypeDesign\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemTypeDesign\\.code").css("required",false);
            
//          Seat Design
            $("#itemFinishGoods\\.itemSeatDesign\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemSeatDesign\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemSeatDesign\\.code").css("required",false);
            
//          Size
            $("#itemFinishGoods\\.itemSize\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemSize\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemSize\\.code").css("required",false);
            
//          Rating    
            $("#itemFinishGoods\\.itemRating\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemRating\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemRating\\.code").css("required",false);
            
//          Bore  
            $("#itemFinishGoods\\.itemBore\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemBore\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemBore\\.code").css("required",false);
            
//          EndCon  
            $("#itemFinishGoods\\.itemEndCon\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemEndCon\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemEndCon\\.code").css("required",false);
            
//          Body  
            $("#itemFinishGoods\\.itemBody\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemBody\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemBody\\.code").css("required",false);
            
//          Ball  
            $("#itemFinishGoods\\.itemBall\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemBall\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemBall\\.code").css("required",false);
            
//          Seat  
            $("#itemFinishGoods\\.itemSeat\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemSeat\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemSeat\\.code").css("required",false);
            
//          Seat Insert  
            $("#itemFinishGoods\\.itemSeatInsert\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemSeatInsert\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemSeatInsert\\.code").css("required",false);
            
//          Stem
            $("#itemFinishGoods\\.itemStem\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemStem\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemStem\\.code").css("required",false);
            
//          Seal  
            $("#itemFinishGoods\\.itemSeal\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemSeal\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemSeal\\.code").css("required",false);
            
//          Bolt  
            $("#itemFinishGoods\\.itemBolt\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemBolt\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemBolt\\.code").css("required",false);
            
//          Disc  
            $("#itemFinishGoods\\.itemDisc\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemDisc\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemDisc\\.code").css("required",false);
            
//          Plates  
            $("#itemFinishGoods\\.itemPlates\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemPlates\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemPlates\\.code").css("required",false);
            
//          Shaft  
            $("#itemFinishGoods\\.itemShaft\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemShaft\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemShaft\\.code").css("required",false);
            
//          Spring  
            $("#itemFinishGoods\\.itemSpring\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemSpring\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemSpring\\.code").css("required",false);
            
//          ArmPin  
            $("#itemFinishGoods\\.itemArmPin\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemArmPin\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemArmPin\\.code").css("required",false);
            
//          Backseat  
            $("#itemFinishGoods\\.itemBackseat\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemBackseat\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemBackseat\\.code").css("required",false);
            
//          Arm  
            $("#itemFinishGoods\\.itemArm\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemArm\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemArm\\.code").css("required",false);
            
//          HingePin  
            $("#itemFinishGoods\\.itemHingePin\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemHingePin\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemHingePin\\.code").css("required",false);
            
//          StopPin  
            $("#itemFinishGoods\\.itemStopPin\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemStopPin\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemStopPin\\.code").css("required",false);
            
//          Operator
            $("#itemFinishGoods\\.itemOperator\\.code").removeClass("required");
            $("#itemFinishGoods\\.itemOperator\\.code").removeClass("cssClass");
            $("#itemFinishGoods\\.itemOperator\\.code").css("required",false);
        }
    }
    
    function setHeightGridValveTypeComponent(){
      var ids = jQuery("#itemFinishGoodsValveTypeComponent_grid").jqGrid('getDataIDs'); 
      var x = ids.length;
        if(ids.length >18){
            var rowHeight = $("#itemFinishGoodsValveTypeComponent_grid"+" tr").eq(1).height();
            $("#itemFinishGoodsValveTypeComponent_grid").jqGrid('setGridHeight', rowHeight * 18 , true);
        }else{
            $("#itemFinishGoodsValveTypeComponent_grid").jqGrid('setGridHeight', "100%", true);
        }
    }

</script>

<s:url id="remoteurlItemFinishGoods" action="item-finish-goods-data" />
<b>ITEM FINISH GOODS</b>
<hr>
<br class="spacer" />
<sj:div id="itemFinishGoodsButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemFinishGoodsNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemFinishGoodsUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemFinishGoodsDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemFinishGoodsRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemFinishGoodsPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>   
    
<div id="itemFinishGoodsSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmItemFinishGoodsSearchInput">
        <table cellpadding="2" cellspacing="2" width="100%">
            <tr>
                <td align="right" width="80px">Item Finish Good</td>
                <td width="300px">
                    <s:textfield id="itemFinishGoodsSearchCode" name="itemFinishGoodsSearchCode" size="15" PlaceHolder=" Code"></s:textfield>
                    <s:textfield id="itemFinishGoodsSearchName" name="itemFinishGoodsSearchName" cssStyle="width:60%" PlaceHolder=" Name"></s:textfield>
                </td>
                <td align="right">Status</td>                
                <td>
                    <s:textfield id="itemFinishGoodsSearchActiveStatus" name="itemFinishGoodsSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:radio id="itemFinishGoodsSearchActiveStatusRad" name="itemFinishGoodsSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br />
        <sj:a href="#" id="btnItemFinishGoods_search" button="true">Search</sj:a>
        <br />
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
        </div>
    </s:form>
    <br class="spacer" />
</div>
    
<div id="itemFinishGoodsGrid">
    <sjg:grid
        id="itemFinishGoods_grid"
        dataType="json"
        href="%{remoteurlItemFinishGoods}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemFinishGoodsTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuitemFinishGoods').width()"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="250" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemBodyConstructionName" index="itemBodyConstructionName" title="Body Construction" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemTypeDesignName" index="itemTypeDesignName" title="Type Design" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemSeatDesignName" index="itemSeatDesignName" title="Seat Design" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemSizeName" index="itemSizeName" title="Size" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemRatingName" index="itemRatingName" title="Rating" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemBoreName" index="itemBoreName" title="Bore" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemEndConName" index="itemEndConName" title="End Con" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemBodyName" index="itemBodyName" title="Body" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemBallName" index="itemBallName" title="Ball" width="200" sortable="true"
        />
         <sjg:gridColumn
            name="itemSeatName" index="itemSeatName" title="Seat" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemSeatInsertName" index="itemSeatInsertName" title="Seat Insert" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemStemName" index="itemStemName" title="Stem" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemSealName" index="itemSealName" title="Seal" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemOperatorName" index="itemOperatorName" title="Operator" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemDiscName" index="itemDiscName" title="Disc" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemPlatesName" index="itemPlatesName" title="Plates" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemShaftName" index="itemShaftName" title="Shaft" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemSpringName" index="itemSpringName" title="Spring" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemArmPinName" index="itemArmPinName" title="Arm Pin" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemBackseatName" index="itemBackseatName" title="Backseat" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemArmName" index="itemArmName" title="Arm" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemHingePinName" index="itemHingePinName" title="Hinge Pin" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemStopPinName" index="itemStopPinName" title="Stop Pin" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid >
</div>
   
<div id="itemFinishGoodsInput" class="content ui-widget">
    <s:form id="frmItemFinishGoodsInput">
        <table cellpadding="2" cellspacing="2" id="headerItemFinishGoodsInput">
            <tr>
                <td align="right"><B>Code *</B></td>
                 <td><s:textfield id="itemFinishGoods.code" name="itemFinishGoods.code" size="25" title="*" required="true" cssClass="required" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>End User *</B></td>
                <td>
                    <script type = "text/javascript">
                            $('#itemFinishGoods_btnEndUser').click(function(ev) {
                                window.open("./pages/search/search-customer-end-user.jsp?iddoc=itemFinishGoods&idsubdoc=endUser","Search", "width=600, height=500");
                            });

                            txtItemFinishGoodsEndUserCode.change(function(ev) {
                            if(txtItemFinishGoodsEndUserCode.val()===""){
                                txtItemFinishGoodsEndUserCode.val("");
                                txtItemFinishGoodsEndUserName.val("");
                                return;
                            }
                             var url = "master/customer-get-end-user";
                             var params = "customer.code=" + txtItemFinishGoodsEndUserCode.val();
                                 params += "&customer.activeStatus=TRUE";
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.customerTemp){
                                    txtItemFinishGoodsEndUserCode.val(data.customerTemp.code);
                                    txtItemFinishGoodsEndUserName.val(data.customerTemp.name);
                                }else{ 
                                    alertMessage("End User Not Found!",txtItemFinishGoodsEndUserCode);
                                    txtItemFinishGoodsEndUserCode.val("");
                                    txtItemFinishGoodsEndUserName.val("");
                                }

                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="itemFinishGoods.endUser.code" name="itemFinishGoods.endUser.code" title="*" required="true" cssClass="required" size="20"></s:textfield>
                            <sj:a id="itemFinishGoods_btnEndUser" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="itemFinishGoods.endUser.name" name="itemFinishGoods.endUser.name" size="30" readonly="true"></s:textfield> 

                </td>
            </tr>
            <tr>
                <td align="right"><B>Valve Type </B></td>
                <td>
                    <script type = "text/javascript">
                            
                            $('#itemFinishGoods_btnValveType').click(function(ev) {
                                window.open("./pages/search/search-valve-type.jsp?iddoc=itemFinishGoods&idsubdoc=valveType","Search", "width=600, height=500");
                            });     
                        
                    txtItemFinishGoodsValveTypeCode.change(function(ev) {
                            if(txtItemFinishGoodsValveTypeCode.val()===""){
                                txtItemFinishGoodsValveTypeCode.val("");
                                txtItemFinishGoodsValveTypeName.val("");
                                return;
                            }

                            var url = "master/valve-type-get";
                            var params = "valveType.code=" + txtItemFinishGoodsValveTypeCode.val();
                                params += "&valveType.activeStatus="+true;
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.valveTypeTemp){
                                    txtItemFinishGoodsValveTypeCode.val(data.valveTypeTemp.code);
                                    txtItemFinishGoodsValveTypeName.val(data.valveTypeTemp.name);
                                }else{ 
                                    alertMessage("Valve Type Not Found!",txtItemFinishGoodsValveTypeCode);
                                    txtItemFinishGoodsValveTypeCode.val("");
                                    txtItemFinishGoodsValveTypeName.val("");
                                }
                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="itemFinishGoods.valveType.code" name="itemFinishGoods.valveType.code" title=" " required="true" cssClass="required" size="20"></s:textfield>
                            <sj:a id="itemFinishGoods_btnValveType" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="itemFinishGoods.valveType.name" name="itemFinishGoods.valveType.name" size="30" readonly="true"></s:textfield> 
                </td>
            </tr>
        </table>
                <br class="spacer" />
        <table>
            <tr>
                <td></td>
                <td align="left">
                    <sj:a href="#" id="btnConfirmItemFinishGoods" button="true" style="width: 70px">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmItemFinishGoods" button="true" style="width: 90px">Unconfirm</sj:a>
                </td>
            </tr>
        </table>    
        <br class="spacer" />
        <div id="itemFinishGoodsLookUp">
            <table>
                <tr>
                    <td valign="top" hidden="true">
                        <sjg:grid
                            id="itemFinishGoodsValveTypeComponent_grid"
                            dataType="json"
                            caption="Valve Type Component"
                            href="%{remoteurlValveTypeComponent}"
                            pager="true"
                            navigator="false"
                            navigatorView="false"
                            navigatorRefresh="false"
                            navigatorDelete="false"
                            navigatorAdd="false"
                            navigatorEdit="false"
                            gridModel="listValveTypeComponentDetailTemp"
                            rowNum="10000"
                            viewrecords="true"
                            rownumbers="true"
                            shrinkToFit="false"
                        >
                        <sjg:gridColumn
                            name="itemFinishGoodsValveTypeCode" index="itemFinishGoodsValveTypeCode" key="itemFinishGoodsValveTypeCode" title="Code" width="100" sortable="true"
                        />
                        <sjg:gridColumn
                            name="itemFinishGoodsValveTypeName" index="itemFinishGoodsValveTypeName" title="Name" width="300" sortable="true"
                        />
                        </sjg:grid>
                    </td>
                    <td>
                        <table>
                            <tr class="BDYDSG global-default">
                                <td align="right"><B>Body Construction </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemBodyConstruction').click(function(ev) {
                                                window.open("./pages/search/search-item-body-construction.jsp?iddoc=itemFinishGoods&idsubdoc=itemBodyConstruction","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemBodyConstructionCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemBodyConstructionCode.val()===""){
                                                txtItemFinishGoodsItemBodyConstructionCode.val("");
                                                txtItemFinishGoodsItemBodyConstructionName.val("");
                                                return;
                                            }

                                            var url = "master/item-body-construction-get";
                                            var params = "itemBodyConstruction.code=" + txtItemFinishGoodsItemBodyConstructionCode.val();
                                                params += "&itemBodyConstruction.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemTypeDesignTemp){
                                                    txtItemFinishGoodsItemBodyConstructionCode.val(data.itemTypeDesignTemp.code);
                                                    txtItemFinishGoodsItemBodyConstructionName.val(data.itemTypeDesignTemp.name);
                                                }else{ 
                                                    alertMessage("Item Body Construction Not Found!",txtItemFinishGoodsItemBodyConstructionCode);
                                                    txtItemFinishGoodsItemBodyConstructionCode.val("");
                                                    txtItemFinishGoodsItemBodyConstructionName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemBodyConstruction.code" name="itemFinishGoods.itemBodyConstruction.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemBodyConstruction" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemBodyConstruction.name" name="itemFinishGoods.itemBodyConstruction.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="TYPDSG global-default">
                                <td align="right"><B>Item Type Design </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemTypeDesign').click(function(ev) {
                                                window.open("./pages/search/search-item-type-design.jsp?iddoc=itemFinishGoods&idsubdoc=itemTypeDesign","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemTypeDesignCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemTypeDesignCode.val()===""){
                                                txtItemFinishGoodsItemTypeDesignCode.val("");
                                                txtItemFinishGoodsItemTypeDesignName.val("");
                                                return;
                                            }

                                            var url = "master/item-type-design-get";
                                            var params = "itemTypeDesign.code=" + txtItemFinishGoodsItemTypeDesignCode.val();
                                                params += "&itemTypeDesign.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemTypeDesignTemp){
                                                    txtItemFinishGoodsItemTypeDesignCode.val(data.itemTypeDesignTemp.code);
                                                    txtItemFinishGoodsItemTypeDesignName.val(data.itemTypeDesignTemp.name);
                                                }else{ 
                                                    alertMessage("Item Type Design Not Found!",txtItemFinishGoodsItemTypeDesignCode);
                                                    txtItemFinishGoodsItemTypeDesignCode.val("");
                                                    txtItemFinishGoodsItemTypeDesignName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemTypeDesign.code" name="itemFinishGoods.itemTypeDesign.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemTypeDesign" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemTypeDesign.name" name="itemFinishGoods.itemTypeDesign.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="STDSG global-default">
                                <td align="right"><B>Item Seat Design </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemSeatDesign').click(function(ev) {
                                                window.open("./pages/search/search-item-seat-design.jsp?iddoc=itemFinishGoods&idsubdoc=itemSeatDesign","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemSeatDesignCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemSeatDesignCode.val()===""){
                                                txtItemFinishGoodsItemSeatDesignCode.val("");
                                                txtItemFinishGoodsItemSeatDesignName.val("");
                                                return;
                                            }

                                            var url = "master/item-seat-design-get";
                                            var params = "itemSeatDesign.code=" + txtItemFinishGoodsItemSeatDesignCode.val();
                                                params += "&itemSeatDesign.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemSeatDesignTemp){
                                                    txtItemFinishGoodsItemSeatDesignCode.val(data.itemSeatDesignTemp.code);
                                                    txtItemFinishGoodsItemSeatDesignName.val(data.itemSeatDesignTemp.name);
                                                }else{ 
                                                    alertMessage("Item Seat Design Not Found!",txtItemFinishGoodsItemSeatDesignCode);
                                                     txtItemFinishGoodsItemSeatDesignCode.val("");
                                                     txtItemFinishGoodsItemSeatDesignName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemSeatDesign.code" name="itemFinishGoods.itemSeatDesign.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemSeatDesign" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemSeatDesign.name" name="itemFinishGoods.itemSeatDesign.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="SIZE global-default">
                                <td align="right"><B>Item Size </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemSize').click(function(ev) {
                                                window.open("./pages/search/search-item-size.jsp?iddoc=itemFinishGoods&idsubdoc=itemSize","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemSizeCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemSizeCode.val()===""){
                                                txtItemFinishGoodsItemSizeCode.val("");
                                                txtItemFinishGoodsItemSizeName.val("");
                                                return;
                                            }

                                            var url = "master/item-size-get";
                                            var params = "itemSize.code=" + txtItemFinishGoodsItemSizeCode.val();
                                                params += "&itemSize.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemSizeTemp){
                                                    txtItemFinishGoodsItemTypeDesignCode.val(data.itemSizeTemp.code);
                                                    txtItemFinishGoodsItemTypeDesignName.val(data.itemSizeTemp.name);
                                                }else{ 
                                                    alertMessage("Item Size Not Found!",txtItemFinishGoodsItemSizeCode);
                                                    txtItemFinishGoodsItemSizeCode.val("");
                                                    txtItemFinishGoodsItemSizeName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemSize.code" name="itemFinishGoods.itemSize.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemSize" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemSize.name" name="itemFinishGoods.itemSize.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="RTG global-default">
                                <td align="right"><B>Item Rating </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemRating').click(function(ev) {
                                                window.open("./pages/search/search-item-rating.jsp?iddoc=itemFinishGoods&idsubdoc=itemRating","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemRatingCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemRatingCode.val()===""){
                                                txtItemFinishGoodsItemRatingCode.val("");
                                                txtItemFinishGoodsItemRatingName.val("");
                                                return;
                                            }

                                            var url = "master/item-rating-get";
                                            var params = "itemRating.code=" + txtItemFinishGoodsItemRatingCode.val();
                                                params += "&itemRating.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemRatingTemp){
                                                    txtItemFinishGoodsItemRatingCode.val(data.itemRatingTemp.code);
                                                    txtItemFinishGoodsItemRatingName.val(data.itemRatingTemp.name);
                                                }else{ 
                                                    alertMessage("Item Rating Not Found!",txtItemFinishGoodsItemRatingCode);
                                                    txtItemFinishGoodsItemRatingCode.val("");
                                                    txtItemFinishGoodsItemRatingName.val("");
                                                }
                                            });
                                        });

                                    </script> 
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemRating.code" name="itemFinishGoods.itemRating.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemRating" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemRating.name" name="itemFinishGoods.itemRating.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="BORE global-default">
                                <td align="right"><B>Item Bore </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemBore').click(function(ev) {
                                                window.open("./pages/search/search-item-bore.jsp?iddoc=itemFinishGoods&idsubdoc=itemBore","Search", "width=600, height=500");
                                            });     

                                            txtItemFinishGoodsItemBoreCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemBoreCode.val()===""){
                                                txtItemFinishGoodsItemBoreCode.val("");
                                                txtItemFinishGoodsItemBoreName.val("");
                                                return;
                                            }

                                            var url = "master/item-bore-get";
                                            var params = "itemBore.code=" + txtItemFinishGoodsItemBoreCode.val();
                                                params += "&itemBore.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemBoreTemp){
                                                    txtItemFinishGoodsItemBoreCode.val(data.itemBoreTemp.code);
                                                    txtItemFinishGoodsItemBoreName.val(data.itemBoreTemp.name);
                                                }else{ 
                                                    alertMessage("Item Bore Not Found!",txtItemFinishGoodsItemBoreCode);
                                                    txtItemFinishGoodsItemBoreCode.val("");
                                                    txtItemFinishGoodsItemBoreName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemBore.code" name="itemFinishGoods.itemBore.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemBore" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemBore.name" name="itemFinishGoods.itemBore.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="ENDCON global-default">
                                <td align="right"><B>Item End Con </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemEndCon').click(function(ev) {
                                                window.open("./pages/search/search-item-end-con.jsp?iddoc=itemFinishGoods&idsubdoc=itemEndCon","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemEndConCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemEndConCode.val()===""){
                                                txtItemFinishGoodsItemEndConCode.val("");
                                                txtItemFinishGoodsItemEndConName.val("");
                                                return;
                                            }

                                            var url = "master/item-end-con-get";
                                            var params = "itemEndCon.code=" + txtItemFinishGoodsItemEndConCode.val();
                                                params += "&itemEndCon.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemEndConTemp){
                                                    txtItemFinishGoodsItemEndConCode.val(data.itemEndConTemp.code);
                                                    txtItemFinishGoodsItemRatingName.val(data.itemEndConTemp.name);
                                                }else{ 
                                                    alertMessage("Item End Con Not Found!",txtItemFinishGoodsItemEndConCode);
                                                    txtItemFinishGoodsItemEndConCode.val("");
                                                    txtItemFinishGoodsItemEndConName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemEndCon.code" name="itemFinishGoods.itemEndCon.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemEndCon" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemEndCon.name" name="itemFinishGoods.itemEndCon.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="BDY global-default">
                                <td align="right"><B>Item Body </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemBody').click(function(ev) {
                                                window.open("./pages/search/search-item-body.jsp?iddoc=itemFinishGoods&idsubdoc=itemBody","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemBodyCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemBodyCode.val()===""){
                                                txtItemFinishGoodsItemBodyCode.val("");
                                                txtItemFinishGoodsItemBodyName.val("");
                                                return;
                                            }

                                            var url = "master/item-body-get";
                                            var params = "itemBody.code=" + txtItemFinishGoodsItemBodyCode.val();
                                                params += "&itemBody.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemBodyTemp){
                                                    txtItemFinishGoodsItemBodyCode.val(data.itemBodyTemp.code);
                                                    txtItemFinishGoodsItemBodyName.val(data.itemBodyTemp.name);
                                                }else{ 
                                                    alertMessage("Item Body Not Found!",txtItemFinishGoodsItemBodyCode);
                                                    txtItemFinishGoodsItemBodyCode.val("");
                                                    txtItemFinishGoodsItemBodyName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemBody.code" name="itemFinishGoods.itemBody.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemBody" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemBody.name" name="itemFinishGoods.itemBody.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="BALL global-default">
                                <td align="right"><B>Item Ball </B></td>
                                <td>
                                    <script type = "text/javascript">

                                    $('#itemFinishGoods_btnItemBall').click(function(ev) {
                                        window.open("./pages/search/search-item-ball.jsp?iddoc=itemFinishGoods&idsubdoc=itemBall","Search", "width=600, height=500");
                                    });     

                                        txtItemFinishGoodsItemBallCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemBallCode.val()===""){
                                                txtItemFinishGoodsItemBallCode.val("");
                                                txtItemFinishGoodsItemBallName.val("");
                                                return;
                                            }

                                            var url = "master/item-ball-get";
                                            var params = "itemBall.code=" + txtItemFinishGoodsItemBallCode.val();
                                                params += "&itemBall.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemBallTemp){
                                                    txtItemFinishGoodsItemBallCode.val(data.itemBallTemp.code);
                                                    txtItemFinishGoodsItemBallName.val(data.itemBallTemp.name);
                                                }else{ 
                                                    alertMessage("Item Ball Not Found!",txtItemFinishGoodsItemBallCode);
                                                    txtItemFinishGoodsItemBallCode.val("");
                                                    txtItemFinishGoodsItemBallName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemBall.code" name="itemFinishGoods.itemBall.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemBall" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemBall.name" name="itemFinishGoods.itemBall.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="ST global-default">
                                <td align="right"><B>Item Seat </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemSeat').click(function(ev) {
                                                window.open("./pages/search/search-item-seat.jsp?iddoc=itemFinishGoods&idsubdoc=itemSeat","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemSeatCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemSeatCode.val()===""){
                                                txtItemFinishGoodsItemSeatCode.val("");
                                                txtItemFinishGoodsItemSeatName.val("");
                                                return;
                                            }

                                            var url = "master/item-seat-get";
                                            var params = "itemSeat.code=" + txtItemFinishGoodsItemSeatCode.val();
                                                params += "&itemSeat.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemSeatTemp){
                                                    txtItemFinishGoodsItemSeatCode.val(data.itemSeatTemp.code);
                                                    txtItemFinishGoodsItemSeatName.val(data.itemSeatTemp.name);
                                                }else{ 
                                                    alertMessage("Item Seal Not Found!",txtItemFinishGoodsItemSeatCode);
                                                     txtItemFinishGoodsItemSeatCode.val("");
                                                     txtItemFinishGoodsItemSeatName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemSeat.code" name="itemFinishGoods.itemSeat.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemSeat" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemSeat.name" name="itemFinishGoods.itemSeat.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="STINS global-default">
                                <td align="right"><B>Item Seat Insert </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemSeatInsert').click(function(ev) {
                                                window.open("./pages/search/search-item-seat-insert.jsp?iddoc=itemFinishGoods&idsubdoc=itemSeatInsert","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemSeatInsertCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemSeatInsertCode.val()===""){
                                                txtItemFinishGoodsItemSeatInsertCode.val("");
                                                txtItemFinishGoodsItemSeatInsertName.val("");
                                                return;
                                            }

                                            var url = "master/item-seat-insert-get";
                                            var params = "itemSeatInsert.code=" + txtItemFinishGoodsItemSeatInsertCode.val();
                                                params += "&itemSeatInsert.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemSeatInsertTemp){
                                                    txtItemFinishGoodsItemSeatInsertCode.val(data.itemSeatInsertTemp.code);
                                                    txtItemFinishGoodsItemSeatInsertName.val(data.itemSeatInsertTemp.name);
                                                }else{ 
                                                    alertMessage("Item Seat Insert Not Found!",txtItemFinishGoodsItemSeatInsertCode);
                                                     txtItemFinishGoodsItemSeatInsertCode.val("");
                                                     txtItemFinishGoodsItemSeatInsertName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemSeatInsert.code" name="itemFinishGoods.itemSeatInsert.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemSeatInsert" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemSeatInsert.name" name="itemFinishGoods.itemSeatInsert.name" size="45" readonly="true"></s:textfield> 
                                </td>
                           </tr>
                            <tr class="STM global-default">
                                <td align="right"><B>Item Stem </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemStem').click(function(ev) {
                                                window.open("./pages/search/search-item-stem.jsp?iddoc=itemFinishGoods&idsubdoc=itemStem","Search", "width=600, height=500");
                                            });     

                                            txtItemFinishGoodsItemStemCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemStemCode.val()===""){
                                                txtItemFinishGoodsItemStemCode.val("");
                                                txtItemFinishGoodsItemStemName.val("");
                                                return;
                                            }

                                            var url = "master/item-stem-get";
                                            var params = "itemStem.code=" + txtItemFinishGoodsItemStemCode.val();
                                                params += "&itemStem.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemStemTemp){
                                                    txtItemFinishGoodsItemStemCode.val(data.itemStemTemp.code);
                                                    txtItemFinishGoodsItemStemName.val(data.itemStemTemp.name);
                                                }else{ 
                                                    alertMessage("Item Stem Not Found!",txtItemFinishGoodsItemStemCode);
                                                    txtItemFinishGoodsItemStemCode.val("");
                                                    txtItemFinishGoodsItemStemName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemStem.code" name="itemFinishGoods.itemStem.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemStem" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemStem.name" name="itemFinishGoods.itemStem.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="SEAL global-default">
                                <td align="right"><B>Item Seal </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemSeal').click(function(ev) {
                                                window.open("./pages/search/search-item-seal.jsp?iddoc=itemFinishGoods&idsubdoc=itemSeal","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemSealCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemSealCode.val()===""){
                                                txtItemFinishGoodsItemSealCode.val("");
                                                txtItemFinishGoodsItemSealName.val("");
                                                return;
                                            }

                                            var url = "master/item-seal-get";
                                            var params = "itemSeal.code=" + txtItemFinishGoodsItemSealCode.val();
                                                params += "&itemSeal.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemSealTemp){
                                                    txtItemFinishGoodsItemSealCode.val(data.itemSealTemp.code);
                                                    txtItemFinishGoodsItemSealName.val(data.itemSealTemp.name);
                                                }else{ 
                                                    alertMessage("Item Seal Not Found!",txtItemFinishGoodsItemSealCode);
                                                     txtItemFinishGoodsItemSealCode.val("");
                                                     txtItemFinishGoodsItemSealName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemSeal.code" name="itemFinishGoods.itemSeal.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemSeal" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemSeal.name" name="itemFinishGoods.itemSeal.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="BLT global-default">
                                <td align="right"><B>Item Bolt </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemBolt').click(function(ev) {
                                                window.open("./pages/search/search-item-bolt.jsp?iddoc=itemFinishGoods&idsubdoc=itemBolt","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemBoltCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemBoltCode.val()===""){
                                                txtItemFinishGoodsItemBoltCode.val("");
                                                txtItemFinishGoodsItemBoltName.val("");
                                                return;
                                            }

                                            var url = "master/item-bolt-get";
                                            var params = "itemBolt.code=" + txtItemFinishGoodsItemBoltCode.val();
                                                params += "&itemBolt.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemBoltTemp){
                                                    txtItemFinishGoodsItemBoltCode.val(data.itemBoltTemp.code);
                                                    txtItemFinishGoodsItemBoltName.val(data.itemBoltTemp.name);
                                                }else{ 
                                                    alertMessage("Item Bolt Not Found!",txtItemFinishGoodsItemBoltCode);
                                                    txtItemFinishGoodsItemBoltCode.val("");
                                                    txtItemFinishGoodsItemBoltName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemBolt.code" name="itemFinishGoods.itemBolt.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemBolt" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemBolt.name" name="itemFinishGoods.itemBolt.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="OPR global-default">
                                <td align="right"><B>Item Operator </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemOperator').click(function(ev) {
                                                window.open("./pages/search/search-item-operator.jsp?iddoc=itemFinishGoods&idsubdoc=itemOperator","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemOperatorCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemOperatorCode.val()===""){
                                                txtItemFinishGoodsItemOperatorCode.val("");
                                                txtItemFinishGoodsItemOperatorName.val("");
                                                return;
                                            }

                                            var url = "master/item-operator-get";
                                            var params = "itemOperator.code=" + txtItemFinishGoodsItemOperatorCode.val();
                                                params += "&itemOperator.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemStemTemp){
                                                    txtItemFinishGoodsItemOperatorCode.val(data.itemStemTemp.code);
                                                    txtItemFinishGoodsItemOperatorName.val(data.itemStemTemp.name);
                                                }else{ 
                                                    alertMessage("Item Operator Not Found!",txtItemFinishGoodsItemOperatorCode);
                                                        txtItemFinishGoodsItemOperatorCode.val("");
                                                        txtItemFinishGoodsItemOperatorName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemOperator.code" name="itemFinishGoods.itemOperator.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemOperator" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemOperator.name" name="itemFinishGoods.itemOperator.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="DISC global-default">
                                <td align="right"><B>Item Disc </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemDisc').click(function(ev) {
                                                window.open("./pages/search/search-item-disc.jsp?iddoc=itemFinishGoods&idsubdoc=itemDisc","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemDiscCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemDiscCode.val()===""){
                                                txtItemFinishGoodsItemDiscCode.val("");
                                                txtItemFinishGoodsItemDiscName.val("");
                                                return;
                                            }

                                            var url = "master/item-disc-get";
                                            var params = "itemDisc.code=" + txtItemFinishGoodsItemDiscCode.val();
                                                params += "&itemDisc.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemDiscTemp){
                                                    txtItemFinishGoodsItemDiscCode.val(data.itemDiscTemp.code);
                                                    txtItemFinishGoodsItemDiscName.val(data.itemDiscTemp.name);
                                                }else{ 
                                                    alertMessage("Item Disc Not Found!",txtItemFinishGoodsItemDiscCode);
                                                        txtItemFinishGoodsItemDiscCode.val("");
                                                        txtItemFinishGoodsItemDiscName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemDisc.code" name="itemFinishGoods.itemDisc.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemDisc" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemDisc.name" name="itemFinishGoods.itemDisc.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="PLT global-default">
                                <td align="right"><B>Item Plates </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemPlates').click(function(ev) {
                                                window.open("./pages/search/search-item-plates.jsp?iddoc=itemFinishGoods&idsubdoc=itemPlates","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemPlatesCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemPlatesCode.val()===""){
                                                txtItemFinishGoodsItemPlatesCode.val("");
                                                txtItemFinishGoodsItemPlatesName.val("");
                                                return;
                                            }

                                            var url = "master/item-plates-get";
                                            var params = "itemPlates.code=" + txtItemFinishGoodsItemPlatesCode.val();
                                                params += "&itemPlates.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemPlatesTemp){
                                                    txtItemFinishGoodsItemPlatesCode.val(data.itemPlatesTemp.code);
                                                    txtItemFinishGoodsItemPlatesName.val(data.itemPlatesTemp.name);
                                                }else{ 
                                                    alertMessage("Item Plates Not Found!",txtItemFinishGoodsItemPlatesCode);
                                                        txtItemFinishGoodsItemPlatesCode.val("");
                                                        txtItemFinishGoodsItemPlatesName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemPlates.code" name="itemFinishGoods.itemPlates.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemPlates" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemPlates.name" name="itemFinishGoods.itemPlates.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="SHFT global-default">
                                <td align="right"><B>Item Shaft </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemShaft').click(function(ev) {
                                                window.open("./pages/search/search-item-shaft.jsp?iddoc=itemFinishGoods&idsubdoc=itemShaft","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemShaftCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemShaftCode.val()===""){
                                                txtItemFinishGoodsItemShaftCode.val("");
                                                txtItemFinishGoodsItemShaftName.val("");
                                                return;
                                            }

                                            var url = "master/item-shaft-get";
                                            var params = "itemShaft.code=" + txtItemFinishGoodsItemShaftCode.val();
                                                params += "&itemShaft.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemShaftTemp){
                                                    txtItemFinishGoodsItemShaftCode.val(data.itemShaftTemp.code);
                                                    txtItemFinishGoodsItemShaftName.val(data.itemShaftTemp.name);
                                                }else{ 
                                                    alertMessage("Item Shaft Not Found!",txtItemFinishGoodsItemShaftCode);
                                                        txtItemFinishGoodsItemShaftCode.val("");
                                                        txtItemFinishGoodsItemShaftName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemShaft.code" name="itemFinishGoods.itemShaft.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemShaft" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemShaft.name" name="itemFinishGoods.itemShaft.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="SPRNG global-default">
                                <td align="right"><B>Item Spring </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemSpring').click(function(ev) {
                                                window.open("./pages/search/search-item-spring.jsp?iddoc=itemFinishGoods&idsubdoc=itemSpring","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemSpringCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemSpringCode.val()===""){
                                                txtItemFinishGoodsItemSpringCode.val("");
                                                txtItemFinishGoodsItemSpringName.val("");
                                                return;
                                            }

                                            var url = "master/item-spring-get";
                                            var params = "itemSpring.code=" + txtItemFinishGoodsItemSpringCode.val();
                                                params += "&itemSpring.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemSpringTemp){
                                                    txtItemFinishGoodsItemSpringCode.val(data.itemSpringTemp.code);
                                                    txtItemFinishGoodsItemSpringName.val(data.itemSpringTemp.name);
                                                }else{ 
                                                    alertMessage("Item Spring Not Found!",txtItemFinishGoodsItemSpringCode);
                                                        txtItemFinishGoodsItemSpringCode.val("");
                                                        txtItemFinishGoodsItemSpringName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemSpring.code" name="itemFinishGoods.itemSpring.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemSpring" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemSpring.name" name="itemFinishGoods.itemSpring.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="ARMPIN global-default">
                                <td align="right"><B>Item Arm Pin </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemArmPin').click(function(ev) {
                                                window.open("./pages/search/search-item-arm-pin.jsp?iddoc=itemFinishGoods&idsubdoc=itemArmPin","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemArmPinCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemArmPinCode.val()===""){
                                                txtItemFinishGoodsItemArmPinCode.val("");
                                                txtItemFinishGoodsItemArmPinName.val("");
                                                return;
                                            }

                                            var url = "master/item-arm-pin-get";
                                            var params = "itemArmPin.code=" + txtItemFinishGoodsItemArmPinCode.val();
                                                params += "&itemArmPin.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemArmPinTemp){
                                                    txtItemFinishGoodsItemArmPinCode.val(data.itemArmPinTemp.code);
                                                    txtItemFinishGoodsItemArmPinName.val(data.itemArmPinTemp.name);
                                                }else{ 
                                                    alertMessage("Item Arm Pin Not Found!",txtItemFinishGoodsItemArmPinCode);
                                                        txtItemFinishGoodsItemArmPinCode.val("");
                                                        txtItemFinishGoodsItemArmPinName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemArmPin.code" name="itemFinishGoods.itemArmPin.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemArmPin" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemArmPin.name" name="itemFinishGoods.itemArmPin.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="BCKST global-default">
                                <td align="right"><B>Item Backseat </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemBackseaat').click(function(ev) {
                                                window.open("./pages/search/search-item-backseat.jsp?iddoc=itemFinishGoods&idsubdoc=itemBackseat","Search", "width=600, height=500");
                                            });     

                                    txtItemFinishGoodsItemBackseatCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemBackseatCode.val()===""){
                                                txtItemFinishGoodsItemBackseatCode.val("");
                                                txtItemFinishGoodsItemBackseatName.val("");
                                                return;
                                            }

                                            var url = "master/item-backseat-get";
                                            var params = "itemBackseat.code=" + txtItemFinishGoodsItemBackseatCode.val();
                                                params += "&itemBackseat.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemBackseatTemp){
                                                    txtItemFinishGoodsItemBackseatCode.val(data.itemBackseatTemp.code);
                                                    txtItemFinishGoodsItemBackseatName.val(data.itemBackseatTemp.name);
                                                }else{ 
                                                    alertMessage("Item Back Seat Not Found!",txtItemFinishGoodsItemBackseatCode);
                                                        txtItemFinishGoodsItemBackseatCode.val("");
                                                        txtItemFinishGoodsItemBackseatName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemBackseat.code" name="itemFinishGoods.itemBackseat.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemBackseaat" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemBackseat.name" name="itemFinishGoods.itemBackseat.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="ARM global-default">
                                <td align="right"><B>Item Arm </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemArm').click(function(ev) {
                                                window.open("./pages/search/search-item-arm.jsp?iddoc=itemFinishGoods&idsubdoc=itemArm","Search", "width=600, height=500");
                                            });     

                                        txtItemFinishGoodsItemArmCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemArmCode.val()===""){
                                                txtItemFinishGoodsItemArmCode.val("");
                                                txtItemFinishGoodsItemArmName.val("");
                                                return;
                                            }

                                            var url = "master/item-arm-get";
                                            var params = "itemArm.code=" + txtItemFinishGoodsItemArmCode.val();
                                                params += "&itemArm.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemArmTemp){
                                                    txtItemFinishGoodsItemArmCode.val(data.itemArmTemp.code);
                                                    txtItemFinishGoodsItemArmName.val(data.itemArmTemp.name);
                                                }else{ 
                                                    alertMessage("Item Arm Not Found!",txtItemFinishGoodsItemArmCode);
                                                        txtItemFinishGoodsItemArmCode.val("");
                                                        txtItemFinishGoodsItemArmName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemArm.code" name="itemFinishGoods.itemArm.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemArm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemArm.name" name="itemFinishGoods.itemArm.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="HNGPIN global-default">
                                <td align="right"><B>Item Hinge Pin </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemHingePin').click(function(ev) {
                                                window.open("./pages/search/search-item-hinge-pin.jsp?iddoc=itemFinishGoods&idsubdoc=itemHingePin","Search", "width=600, height=500");
                                            });     

                                        txtItemFinishGoodsItemHingePinCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemHingePinCode.val()===""){
                                                txtItemFinishGoodsItemHingePinCode.val("");
                                                txtItemFinishGoodsItemHingePinName.val("");
                                                return;
                                            }

                                            var url = "master/item-hinge-pin-get";
                                            var params = "itemHingePin.code=" + txtItemFinishGoodsItemHingePinCode.val();
                                                params += "&itemHingePin.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemHingePinTemp){
                                                    txtItemFinishGoodsItemHingePinCode.val(data.itemHingePinTemp.code);
                                                    txtItemFinishGoodsItemHingePinName.val(data.itemHingePinTemp.name);
                                                }else{ 
                                                    alertMessage("Item Hinge Pin Not Found!",txtItemFinishGoodsItemHingePinCode);
                                                        txtItemFinishGoodsItemHingePinCode.val("");
                                                        txtItemFinishGoodsItemHingePinName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemHingePin.code" name="itemFinishGoods.itemHingePin.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemHingePin" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemHingePin.name" name="itemFinishGoods.itemHingePin.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr class="STPPIN global-default">
                                <td align="right"><B>Item Stop Pin </B></td>
                                <td>
                                    <script type = "text/javascript">

                                            $('#itemFinishGoods_btnItemStopPin').click(function(ev) {
                                                window.open("./pages/search/search-item-stop-pin.jsp?iddoc=itemFinishGoods&idsubdoc=itemStopPin","Search", "width=600, height=500");
                                            });     

                                        txtItemFinishGoodsItemStopPinCode.change(function(ev) {
                                            if(txtItemFinishGoodsItemStopPinCode.val()===""){
                                                txtItemFinishGoodsItemStopPinCode.val("");
                                                txtItemFinishGoodsItemStopPinName.val("");
                                                return;
                                            }

                                            var url = "master/item-backseat-get";
                                            var params = "itemStopPin.code=" + txtItemFinishGoodsItemStopPinCode.val();
                                                params += "&itemStopPin.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.itemStopPinTemp){
                                                    txtItemFinishGoodsItemStopPinCode.val(data.itemStopPinTemp.code);
                                                    txtItemFinishGoodsItemStopPinName.val(data.itemStopPinTemp.name);
                                                }else{ 
                                                    alertMessage("Item Stop Pin Not Found!",txtItemFinishGoodsItemStopPinCode);
                                                        txtItemFinishGoodsItemStopPinCode.val("");
                                                        txtItemFinishGoodsItemStopPinName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="itemFinishGoods.itemStopPin.code" name="itemFinishGoods.itemStopPin.code" title=" " size="20"></s:textfield>
                                            <sj:a id="itemFinishGoods_btnItemStopPin" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="itemFinishGoods.itemStopPin.name" name="itemFinishGoods.itemStopPin.name" size="45" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Active Status *</B>
                                <s:textfield id="itemFinishGoods.activeStatus" name="itemFinishGoods.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                                <td><s:radio id="itemFinishGoods.activeStatus" name="itemFinishGoods.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right" valign="top"><B>Remark * </B></td>
                                <td><s:textarea id="itemFinishGoods.remark" name="itemFinishGoods.remark"  cols="50" rows="2" height="20"></s:textarea></td>        
                            </tr>
                            <tr>
                                <td><s:textfield id="itemFinishGoods.createdBy"  name="itemFinishGoods.createdBy" size="20" style="display:none"></s:textfield></td>
                                <td><s:textfield id="itemFinishGoods.createdDate" name="itemFinishGoods.createdDate" size="20" style="display:none"></s:textfield></td>
                            </tr>
                        </table>
                    </td>
                </tr>  
        </table>
    </div>
    <table>                        
        <tr>
            <td align="right">
            </td>
            <td>
                <sj:a href="#" id="btnItemFinishGoodsSave" button="true">Save</sj:a>
                <sj:a href="#" id="btnItemFinishGoodsCancel" button="true">Cancel</sj:a>            
            </td>
        </tr>  
    </table>            
    </s:form>
</div>
    
    

    
    
    
    