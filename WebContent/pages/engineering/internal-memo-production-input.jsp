
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
    #internalMemoProductionDetailInput_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var internalMemoProductionDetailLastSel = -1, internalMemoProductionDetailLastRowId = 0,internalMemoProductionDetail_lastSel=-1;
    var internalMemoProductionDetailStatuSel=0;
    var                                    
        txtInternalMemoProductionCode = $("#internalMemoProduction\\.code"),
        txtInternalMemoProductionBranchCode = $("#internalMemoProduction\\.branch\\.code"),
        txtInternalMemoProductionBranchName = $("#internalMemoProduction\\.branch\\.name"),
        dtpInternalMemoProductionTransactionDate = $("#internalMemoProduction\\.transactionDate"),
        txtInternalMemoProductionProjectCode = $("#internalMemoProduction\\.project\\.code"),
        txtInternalMemoProductionProjectName = $("#internalMemoProduction\\.project\\.name"),
        txtInternalMemoProductionSubject = $("#internalMemoProduction\\.subject"),
        txtInternalMemoProductionTo = $("#internalMemoProduction\\.im_To"),
        txtInternalMemoProductionAttention = $("#internalMemoProduction\\.attention"),
        txtInternalMemoProductionCustomerCode = $("#internalMemoProduction\\.customer\\.code"),
        txtInternalMemoProductionCustomerName = $("#internalMemoProduction\\.customer\\.name"),
        txtInternalMemoProductionValveTypeCode = $("#internalMemoProduction\\.valveType\\.code"),
        txtInternalMemoProductionValveTypeName = $("#internalMemoProduction\\.valveType\\.name"),
        txtInternalMemoProductionSalesPersonCode = $("#internalMemoProduction\\.salesPerson\\.code"),
        txtInternalMemoProductionSalesPersonName = $("#internalMemoProduction\\.salesPerson\\.name"),
        txtInternalMemoProductionItemDetailCode = $("#internalMemoProduction\\.itemFinishGood\\.code"),
        txtInternalMemoProductionItemDetailName = $("#internalMemoProduction\\.itemFinishGood\\.name"),
        txtInternalMemoProductionRefNo = $("#internalMemoProduction\\.refNo"),
        txtInternalMemoProductionRemark = $("#internalMemoProduction\\.remark"),
        txtInternalMemoProductionCreatedBy = $("#internalMemoProduction\\.createdBy"),
        txtInternalMemoProductionCreatedDate = $("#internalMemoProduction\\.createdDate"),
        txtCountAddDetail = $("#btnInternalMemoProductionCountDetail");
       
       
    $(document).ready(function() {
        
        hoverButton();
        flagIsConfirmIM=false;
        $("#btnConfirmInternalMemoProduction").css("display", "block");
        $("#btnUnConfirmInternalMemoProduction").css("display", "none");
        $("#btn-for-detail").css("display", "none");
        $('#internalMemoProductionDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#internalMemoProduction_Input').unblock();
        
        $.subscribe("internalMemoProductionDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#internalMemoProductionDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==internalMemoProductionDetailLastSel) {
                $('#internalMemoProductionDetailInput_grid').jqGrid("saveRow",internalMemoProductionDetailLastSel); 
                $('#internalMemoProductionDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                internalMemoProductionDetailLastSel=selectedRowID;
            }
            else{
                $('#internalMemoProductionDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $("#btnConfirmInternalMemoProduction").click(function(ev) {
            handlers_input_internal_memo();
             if(txtInternalMemoProductionBranchCode.val()==="") {
                    alertMessage("Branch Can't Empty!");
                    ev.preventDefault();
                    return;
                }
             if(txtInternalMemoProductionValveTypeCode.val()==="") {
                    alertMessage("Valve Type Can't Empty!");
                    ev.preventDefault();
                    return;
                }   
             if(txtInternalMemoProductionCustomerCode.val()==="") {
                    alertMessage("Customer Can't Empty!");
                    ev.preventDefault();
                    return;
                }
             if(txtInternalMemoProductionSalesPersonCode.val()==="") {
                    alertMessage("Sales Person Can't Empty!");
                    ev.preventDefault();
                    return;
                }
                
//                var date1 = dtpInternalMemoProductionTransactionDate.val().split("/");
//                var month1 = date1[1];
//                var year1 = date1[2].split(" ");
//                var date2 = $("#internalMemoProductionTransactionDate").val().split("/");
//                var month2 = date2[1];
//                var year2 = date2[2].split(" ");
//
//                if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
//                    if($("#internalMemoProductionUpdateMode").val()==="true"){
//                        alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#internalMemoProductionTransactionDate").val(),dtpInternalMemoProductionTransactionDate);
//                    }else{
//                        alertMessage("Transaction Month Must Between Session Period Month!",dtpInternalMemoProductionTransactionDate);
//                    }
//                    return;
//                }
//
//                if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
//                    if($("#internalMemoProductionUpdateMode").val()==="true"){
//                        alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#internalMemoProductionTransactionDate").val(),dtpInternalMemoProductionTransactionDate);
//                    }else{
//                        alertMessage("Transaction Year Must Between Session Period Year!",dtpInternalMemoProductionTransactionDate);
//                    }
//                    return;
//                }
                
                flagIsConfirmIM=true;
                if($("#internalMemoProductionUpdateMode").val()==="true"){ 
                    loadDataInternalMemoProductionDetail();
                }
                
                $("#btnInternalMemoProductionCountDetail").val(parseFloat("1"));
                $("#btnUnConfirmInternalMemoProduction").css("display", "block");
                $("#btn-for-detail").css("display", "block");
                $("#btnConfirmInternalMemoProduction").css("display", "none");
                $("#btnInternalMemoProductionAddDetail").css("display", "block");
                $("#btnInternalMemoProductionCountDetail").css("display", "block");
                $('#internalMemoProduction_Input').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#internalMemoProductionDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmInternalMemoProduction").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                var rows = jQuery("#internalMemoProductionDetailInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    flagIsConfirmIM=false;
                    $("#btnUnConfirmInternalMemoProduction").css("display", "none");
                    $("#btn-for-detail").css("display", "none");
                    $("#btnConfirmInternalMemoProduction").css("display", "block");
                    $('#internalMemoProduction_Input').unblock();
                    $('#internalMemoProductionDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                                    flagIsConfirmIM=false;
                                    $("#btnUnConfirmInternalMemoProduction").css("display", "none");
                                    $("#btn-for-detail").css("display", "none");
                                    $("#btnConfirmInternalMemoProduction").css("display", "block");
                                    $('#internalMemoProduction_Input').unblock();
                                    $('#internalMemoProductionDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                    $("#internalMemoProductionDetailInput_grid").jqGrid('clearGridData');
                                    setHeightGridInternalMemoProductionDetail();
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
        
        $('#btnInternalMemoProductionSave').click(function(ev) {
             if(flagIsConfirmIM===false){
                alertMessage("Please Confirm!",$("#btnConfirmInternalMemoProduction"));
                return;
            }
           if(internalMemoProductionDetailLastSel !== -1) {
                $('#internalMemoProductionDetailInput_grid').jqGrid("saveRow",internalMemoProductionDetailLastSel);
            }
             var listInternalMemoProductionDetail = new Array();
             var ids = jQuery("#internalMemoProductionDetailInput_grid").jqGrid('getDataIDs');
             
            if(ids.length===0){
                alertMessage("Data Detail Can't Empty!");
                return;
            }
            for(var i=0;i < ids.length;i++){
                var data = $("#internalMemoProductionDetailInput_grid").jqGrid('getRowData',ids[i]);

                if(data.internalMemoProductionDetailItemFinishGoodsCode === ""){
                    alertMessage("Item Detail Can't Empty! ");
                    return;
                }
                
                if(parseFloat(data.internalMemoProductionDetailQuantity)===0){
                    alertMessage("Quantity Detail Must Greater Than 0 ");
                    return;
                }
                
                if(parseFloat(data.internalMemoProductionDetailSortNo)===0){
                    alertMessage("Sort No Can't be 0 ");
                    return;
                }

                var internalMemoProductionDetail = {
                    itemFinishGood        : { code : data.internalMemoProductionDetailItemFinishGoodsCode },
                    internalMemoSortNo    : data.internalMemoProductionDetailSortNo,
                    valveTag              : data.internalMemoProductionDetailValveTag,
                    dataSheet             : data.internalMemoProductionDetailDataSheet,
                    description           : data.internalMemoProductionDetailDescription,
                    quantity              : data.internalMemoProductionDetailQuantity
                };
                listInternalMemoProductionDetail[i] = internalMemoProductionDetail;
            }
            formatDateIM();
             var url="engineering/internal-memo-production-save";
            var params = $("#frmInternalMemoProductionInput").serialize();
                params += "&listInternalMemoProductionDetailJSON=" + $.toJSON(listInternalMemoProductionDetail);
                
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateIM();
                    alertMessage(data.errorMessage);
                    return;
                }

                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');

                dynamicDialog.dialog({
                    title : "Confirmation:",
                    closeOnEscape: false,
                    modal : true,
                    width: 400,
                    resizable: false,
                    buttons : 
                        [{
                           text : "Yes",
                           click : function() {
                           $(this).dialog("close");
                           var url = "engineering/internal-memo-production-input";
                           var params = "";
                           pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION");
                        }
                        },
                        {
                           text : "No",
                           click : function() {
                               $(this).dialog("close");
                               var url = "engineering/internal-memo-production";
                               var params = "";
                               pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION");

                           }
                        }]
               });
            });
            ev.preventDefault();
        });
        
        $('#btnInternalMemoProductionCancel').click(function(ev) {
            var url = "engineering/internal-memo-production";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION"); 
        });
        
        $('#btnIMSearchItemFinishGoods').click(function(ev) {
            var ids = jQuery("#internalMemoProductionDetailInput_grid").jqGrid('getDataIDs');
            var customer=txtInternalMemoProductionCustomerCode.val();
            window.open("./pages/search/search-item-finish-good.jsp?iddoc=internalMemoProductionFinishGood&type=grid&rowLast="+ids.length+"&idcustomer="+customer,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnInternalMemoProductionDetailSort').click(function(ev) {
            if($("#internalMemoProductionDetailInput_grid").jqGrid('getDataIDs').length===0){
                alertMessage("Grid Internal Memo Production Can't Be Empty!");
                return;
            }
            
            if(internalMemoProductionDetailLastSel !== -1) {
                $('#internalMemoProductionDetailInput_grid').jqGrid("saveRow",internalMemoProductionDetailLastSel);  
            }
            
            var ids = jQuery("#internalMemoProductionDetailInput_grid").jqGrid('getDataIDs');
            var listInternalMemoProductionDetail = new Array();
            
            for(var k=0;k<ids.length;k++){
            var data = $("#internalMemoProductionDetailInput_grid").jqGrid('getRowData',ids[k]);    
            var internalMemoProductionDetail = { 
                    itemFinishGoods             : {code:data.internalMemoProductionDetailItemFinishGoodsCode},
                    sort                        : data.internalMemoProductionDetailSortNo,
                    itemFinishGoodsRemark       : data.internalMemoProductionDetailItemFinishGoodsRemark,
                    
                    valveTag                    : data.internalMemoProductionDetailValveTag,
                    dataSheet                   : data.internalMemoProductionDetailDataSheet,
                    description                 : data.internalMemoProductionDetailDescription,
                    
                    typeDesign                  : data.internalMemoProductionDetailTypeDesign,
                    size                        : data.internalMemoProductionDetailSize,
                    rating                      : data.internalMemoProductionDetailRating,
                    bore                        : data.internalMemoProductionDetailBore,
                    endCon                      : data.internalMemoProductionDetailEndCon,
                    body                        : data.internalMemoProductionDetailBody,
                    stem                        : data.internalMemoProductionDetailStem,
                    seal                        : data.internalMemoProductionDetailSeal,
                    seat                        : data.internalMemoProductionDetailSeat,
                    seatInsert                  : data.internalMemoProductionDetailSeatInsert,
                    bolting                     : data.internalMemoProductionDetailBolting,
                    seatDesign                  : data.internalMemoProductionDetailSeatDesign,
                    operator                    : data.internalMemoProductionDetailOperator,
                    note                        : data.internalMemoProductionDetailNote,
                    quantity                    : data.internalMemoProductionDetailQuantity
                    
                };
                listInternalMemoProductionDetail[k] = internalMemoProductionDetail;
            }
            
             var result = Enumerable.From(listInternalMemoProductionDetail)
                            .OrderBy('$.sort')
                            .Select()
                            .ToArray();
            
            $("#internalMemoProductionDetailInput_grid").jqGrid('clearGridData');
            internalMemoProductionDetailLastSel = 0;
                for(var i = 0; i < result.length; i++){
                    internalMemoProductionDetailLastSel ++;
                    $("#internalMemoProductionDetailInput_grid").jqGrid("addRowData",internalMemoProductionDetailLastSel, result[i]);
                    $("#internalMemoProductionDetailInput_grid").jqGrid('setRowData',internalMemoProductionDetailLastSel,{
                        
                    internalMemoProductionDetailItemFinishGoodsCode              : result[i].itemFinishGoods.code,
                    internalMemoProductionDetailSortNo                           : result[i].sort,
                    internalMemoProductionDetailItemFinishGoodsRemark            : result[i].itemFinishGoodsRemark,
                    
                    internalMemoProductionDetailValveTag                         : result[i].valveTag,
                    internalMemoProductionDetailDataSheet                        : result[i].dataSheet,
                    internalMemoProductionDetailDescription                      : result[i].description,
                    
                    internalMemoProductionDetailTypeDesign                       : result[i].typeDesign,
                    internalMemoProductionDetailSize                             : result[i].size,
                    internalMemoProductionDetailRating                           : result[i].rating,
                    internalMemoProductionDetailBore                             : result[i].bore,
                    internalMemoProductionDetailEndCon                           : result[i].endCon,
                    internalMemoProductionDetailBody                             : result[i].body,
                    internalMemoProductionDetailStem                             : result[i].stem,
                    internalMemoProductionDetailSeal                             : result[i].seal,
                    internalMemoProductionDetailSeat                             : result[i].seat,
                    internalMemoProductionDetailSeatInsert                       : result[i].seatInsert,
                    internalMemoProductionDetailBolting                          : result[i].bolting,
                    internalMemoProductionDetailSeatDesign                       : result[i].seatDesign,
                    internalMemoProductionDetailOperator                         : result[i].operator,
                    internalMemoProductionDetailNote                             : result[i].note,
                    internalMemoProductionDetailQuantity                         : result[i].quantity
               });    
            }
        }); 
        
    });
    
    function loadDataInternalMemoProductionDetail() {
       
        var url = "engineering/internal-memo-production-detail-data";
        var params = "internalMemoProduction.code=" + txtInternalMemoProductionCode.val();
       
            $.getJSON(url, params, function(data) {
                internalMemoProductionDetailLastRowId = 0;
                
                for (var i=0; i<data.listInternalMemoProductionDetailTemp.length; i++) {
                    internalMemoProductionDetailLastRowId++;
                    $("#internalMemoProductionDetailInput_grid").jqGrid("addRowData", internalMemoProductionDetailLastRowId, data.listInternalMemoProductionDetailTemp[i]);
                    $("#internalMemoProductionDetailInput_grid").jqGrid('setRowData',internalMemoProductionDetailLastRowId,{
                        internalMemoProductionDetailDelete                            : "delete",
                        internalMemoProductionDetailDataSheet                         : data.listInternalMemoProductionDetailTemp[i].dataSheet,
                        internalMemoProductionDetailDescription                       : data.listInternalMemoProductionDetailTemp[i].description,
                        internalMemoProductionDetailItemFinishGoodsCode               : data.listInternalMemoProductionDetailTemp[i].itemFinishGoodsCode,
                        internalMemoProductionDetailSortNo                            : data.listInternalMemoProductionDetailTemp[i].internalMemoSortNo,
                        internalMemoProductionDetailItemFinishGoodsRemark             : data.listInternalMemoProductionDetailTemp[i].itemFinishGoodsRemark,
                        internalMemoProductionDetailValveTag                          : data.listInternalMemoProductionDetailTemp[i].valveTag,
                        internalMemoProductionDetailBodyConstruction                  : data.listInternalMemoProductionDetailTemp[i].itemBodyConstructionName,
                        internalMemoProductionDetailTypeDesign                        : data.listInternalMemoProductionDetailTemp[i].itemTypeDesignName,
                        internalMemoProductionDetailSeatDesign                        : data.listInternalMemoProductionDetailTemp[i].itemSeatDesignName,
                        internalMemoProductionDetailSize                              : data.listInternalMemoProductionDetailTemp[i].itemSizeName,
                        internalMemoProductionDetailRating                            : data.listInternalMemoProductionDetailTemp[i].itemRatingName,
                        internalMemoProductionDetailBore                              : data.listInternalMemoProductionDetailTemp[i].itemBoreName,
                        internalMemoProductionDetailEndCon                            : data.listInternalMemoProductionDetailTemp[i].itemEndConName,
                        internalMemoProductionDetailBody                              : data.listInternalMemoProductionDetailTemp[i].itemBodyName,
                        internalMemoProductionDetailBall                              : data.listInternalMemoProductionDetailTemp[i].itemBallName,
                        internalMemoProductionDetailSeat                              : data.listInternalMemoProductionDetailTemp[i].itemSeatName,
                        internalMemoProductionDetailSeatInsert                        : data.listInternalMemoProductionDetailTemp[i].itemSeatInsertName,
                        internalMemoProductionDetailStem                              : data.listInternalMemoProductionDetailTemp[i].itemStemName,
                        internalMemoProductionDetailSeal                              : data.listInternalMemoProductionDetailTemp[i].itemSealName,
                        internalMemoProductionDetailBolting                           : data.listInternalMemoProductionDetailTemp[i].itemBoltName,
                        internalMemoProductionDetailDisc                              : data.listInternalMemoProductionDetailTemp[i].itemDiscName,
                        internalMemoProductionDetailPlates                            : data.listInternalMemoProductionDetailTemp[i].itemPlatesName,
                        internalMemoProductionDetailShaft                             : data.listInternalMemoProductionDetailTemp[i].itemShaftName,
                        internalMemoProductionDetailSpring                            : data.listInternalMemoProductionDetailTemp[i].itemSpringName,
                        internalMemoProductionDetailArmPin                            : data.listInternalMemoProductionDetailTemp[i].itemArmPinName,
                        internalMemoProductionDetailBackseat                          : data.listInternalMemoProductionDetailTemp[i].itemBackseatName,
                        internalMemoProductionDetailArm                               : data.listInternalMemoProductionDetailTemp[i].itemArmName,
                        internalMemoProductionDetailHingePin                          : data.listInternalMemoProductionDetailTemp[i].itemHingePinName,
                        internalMemoProductionDetailStopPin                           : data.listInternalMemoProductionDetailTemp[i].itemStopPinName,
                        internalMemoProductionDetailOperator                          : data.listInternalMemoProductionDetailTemp[i].itemOperatorName,
                        internalMemoProductionDetailQuantity                          : data.listInternalMemoProductionDetailTemp[i].quantity
                    });
                }
                
//                setHeightGridPR();
            }); 
    }
    
    function handlers_input_internal_memo(){
        if(txtInternalMemoProductionBranchCode.val()===""){
            handlersInput(txtInternalMemoProductionBranchCode);
        }else{
            unHandlersInput(txtInternalMemoProductionBranchCode);
        }
        if(txtInternalMemoProductionCustomerCode.val()===""){
            handlersInput(txtInternalMemoProductionCustomerCode);
        }else{
            unHandlersInput(txtInternalMemoProductionCustomerCode);
        }
        if(txtInternalMemoProductionSalesPersonCode.val()===""){
            handlersInput(txtInternalMemoProductionSalesPersonCode);
        }else{
            unHandlersInput(txtInternalMemoProductionSalesPersonCode);
        }
        if(txtInternalMemoProductionValveTypeCode.val()===""){
            handlersInput(txtInternalMemoProductionValveTypeCode);
        }else{
            unHandlersInput(txtInternalMemoProductionValveTypeCode);
        }
    }
    
    function internalMemoProductionTransactionDateOnChange(){
        if($("#internalMemoProductionUpdateMode").val()==="false"){
            var internalMemoProductionTransactionDateSplit=$("#internalMemoProduction\\.transactionDate").val().split('/');
            var internalMemoProductionTransactionDate=internalMemoProductionTransactionDateSplit[1]+"/"+internalMemoProductionTransactionDateSplit[0]+"/"+internalMemoProductionTransactionDateSplit[2];
            $("#internalMemoProductionTransactionDate").val(internalMemoProductionTransactionDate);
        }
    }
    
    function internalMemoProductionDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#internalMemoProductionDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#internalMemoProductionDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridInternalMemoProductionDetail();
    }
    
    function setHeightGridInternalMemoProductionDetail(){
        var ids = jQuery("#internalMemoProductionDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#internalMemoProductionDetailInput_grid"+" tr").eq(1).height();
            $("#internalMemoProductionDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#internalMemoProductionDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
     function formatDateIM(){
        var date = dtpInternalMemoProductionTransactionDate.val(); 
        var dateTemp = date.toString().split(" ");
        var splitDate = dateTemp[0].toString().split("/");
        var transDate = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2]+" "+dateTemp[1];
        dtpInternalMemoProductionTransactionDate.val(transDate);        
        $("#internalMemoProductionTemp\\.transactionDateTemp").val(dtpInternalMemoProductionTransactionDate.val());
    }
    
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#internalMemoProductionDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
            $("#internalMemoProductionDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#internalMemoProductionDetailInput_grid").jqGrid('setRowData',lastRowId,{
                    internalMemoProductionDetailDelete                            : defRow.internalMemoProductionDetailDelete,
                    internalMemoProductionDetailItemFinishGoodsCode                : defRow.internalMemoProductionDetailItemFinishGoodsCode,
                    internalMemoProductionDetailItemFinishGoodsRemark              : defRow.internalMemoProductionDetailItemFinishGoodsRemark,
                    internalMemoProductionDetailValveTag                          : defRow.internalMemoProductionDetailValveTag,
                    internalMemoProductionDetailBodyConstruction                  : defRow.internalMemoProductionDetailBodyConstruction,
                    internalMemoProductionDetailTypeDesign                        : defRow.internalMemoProductionDetailTypeDesign,
                    internalMemoProductionDetailSeatDesign                        : defRow.internalMemoProductionDetailSeatDesign,
                    internalMemoProductionDetailSize                              : defRow.internalMemoProductionDetailSize,
                    internalMemoProductionDetailRating                            : defRow.internalMemoProductionDetailRating,
                    internalMemoProductionDetailBore                              : defRow.internalMemoProductionDetailBore,
                    internalMemoProductionDetailEndCon                            : defRow.internalMemoProductionDetailEndCon,
                    internalMemoProductionDetailBody                              : defRow.internalMemoProductionDetailBody,
                    internalMemoProductionDetailBall                              : defRow.internalMemoProductionDetailBall,
                    internalMemoProductionDetailSeat                              : defRow.internalMemoProductionDetailSeat,
                    internalMemoProductionDetailSeatInsert                        : defRow.internalMemoProductionDetailSeatInsert,
                    internalMemoProductionDetailStem                              : defRow.internalMemoProductionDetailStem,
                    internalMemoProductionDetailSeal                              : defRow.internalMemoProductionDetailSeal,
                    internalMemoProductionDetailBolting                           : defRow.internalMemoProductionDetailBolting,
                    internalMemoProductionDetailDisc                              : defRow.internalMemoProductionDetailDisc,
                    internalMemoProductionDetailPlates                            : defRow.internalMemoProductionDetailPlates,
                    internalMemoProductionDetailShaft                             : defRow.internalMemoProductionDetailShaft,
                    internalMemoProductionDetailSpring                            : defRow.internalMemoProductionDetailSpring,
                    internalMemoProductionDetailArmPin                            : defRow.internalMemoProductionDetailArmPin,
                    internalMemoProductionDetailBackseat                          : defRow.internalMemoProductionDetailBackseat,
                    internalMemoProductionDetailArm                               : defRow.internalMemoProductionDetailArm,
                    internalMemoProductionDetailHingePin                          : defRow.internalMemoProductionDetailHingePin,
                    internalMemoProductionDetailStopPin                           : defRow.internalMemoProductionDetailStopPin,
                    internalMemoProductionDetailOperator                          : defRow.internalMemoProductionDetailOperator
            });
            
        setHeightGridInternalMemoProductionDetail();
 }
    
 function avoidSpcCharIMP(){
        
    var selectedRowID = $("#internalMemoProductionDetailInput_grid").jqGrid("getGridParam", "selrow");
    if(selectedRowID === "" || selectedRowID === null){
        selectedRowID = $("#internalMemoProductionDetailInput_grid").jqGrid("getGridParam", "selrow");
    }
    if(selectedRowID === "" || selectedRowID === null){
        selectedRowID = internalMemoProductionDetailLastRowId;
    }

    let str = $("#" + selectedRowID + "_internalMemoProductionDetailSortNo").val();

    if(/^[a-zA-Z0-9- ]*$/.test(str) === false){
        alert('Your Sort Number contains illegal characters.');
        var rep = str.replace(/[^a-zA-Z ]/g,"");
        $("#" + selectedRowID + "_internalMemoProductionDetailSortNo").val(rep);
    }

    if (isNaN(str)){
        alert('Your Sort Number contains characters.');
        $("#" + selectedRowID + "_internalMemoProductionDetailSortNo").val("");
    }
}

</script>
<s:url id="remoteurlInternalMemoProductionDetailInput" action="" />
<b>INTERNAL MEMO PRODUCTION</b>
<hr>
<br class="spacer" />
<div id="internalMemoProductionInput" class="content ui-widget">
        <s:form id="frmInternalMemoProductionInput">
            <table cellpadding="2" cellspacing="2" id="internalMemoProduction_Input">
                <tr valign="top">
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>IM No *</B></td>
                                <td><s:textfield id="internalMemoProduction.code" name="internalMemoProduction.code" key="internalMemoProduction.code" readonly="true" size="25"></s:textfield></td>
                                <td><s:textfield id="internalMemoProductionUpdateMode" name="internalMemoProductionUpdateMode" size="20" cssStyle="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Branch *</B></td>
                                <td colspan="2">
                                <script type = "text/javascript">

                                $('#internalMemoProduction_btnBranch').click(function(ev) {
                                    window.open("./pages/search/search-branch.jsp?iddoc=internalMemoProduction&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
                                });
                                    txtInternalMemoProductionBranchCode.change(function(ev) {

                                        if(txtInternalMemoProductionBranchCode.val()===""){
                                            txtInternalMemoProductionBranchName.val("");
                                            return;
                                        }
                                        var url = "master/branch-get";
                                        var params = "branch.code=" + txtInternalMemoProductionBranchCode.val();
                                            params += "&branch.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.branchTemp){
                                                txtInternalMemoProductionBranchCode.val(data.branchTemp.code);
                                                txtInternalMemoProductionBranchName.val(data.branchTemp.name);
                                            }
                                            else{
                                                alertMessage("Branch Not Found!",txtInternalMemoProductionBranchCode);
                                                txtInternalMemoProductionBranchCode.val("");
                                                txtInternalMemoProductionBranchName.val("");
                                            }
                                        });
                                    });
                                    
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="internalMemoProduction.branch.code" name="internalMemoProduction.branch.code" size="22"></s:textfield>
                                    <sj:a id="internalMemoProduction_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="internalMemoProduction.branch.name" name="internalMemoProduction.branch.name" size="40" readonly="true"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="internalMemoProduction.transactionDate" name="internalMemoProduction.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" changeMonth="true" changeYear="true" onchange="internalMemoProductionTransactionDateOnChange()"></sj:datepicker>
                                    <sj:datepicker id="internalMemoProductionTransactionDate" name="internalMemoProductionTransactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px">Project </td>
                                <td colspan="2">
                                <script type = "text/javascript">
                                    $('#internalMemoProduction_btnProject').click(function(ev) {
                                        window.open("./pages/search/search-project.jsp?iddoc=internalMemoProduction&idsubdoc=project","Search", "width=600, height=500");
                                    });
                                    
                                    txtInternalMemoProductionProjectCode.change(function(ev) {

                                        if(txtInternalMemoProductionProjectCode.val()===""){
                                            txtInternalMemoProductionProjectCode.val("");
                                            txtInternalMemoProductionProjectName.val("");
                                            return;
                                        }
                                        var url = "master/project-get";
                                        var params = "project.code=" + txtInternalMemoProductionProjectCode.val();
                                            params += "&project.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.projectTemp){
                                                txtInternalMemoProductionProjectCode.val(data.projectTemp.code);
                                                txtInternalMemoProductionProjectName.val(data.projectTemp.name);
                                            }
                                            else{
                                                alertMessage("Project Not Found!",txtInternalMemoProductionProjectCode);
                                                txtInternalMemoProductionProjectCode.val("");
                                                txtInternalMemoProductionProjectName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="internalMemoProduction.project.code" name="internalMemoProduction.project.code" size="22"></s:textfield>
                                    <sj:a id="internalMemoProduction_btnProject" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="internalMemoProduction.project.name" name="internalMemoProduction.project.name" size="40" readonly="true"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right">Subject </td>
                                <td><s:textfield id="internalMemoProduction.subject" name="internalMemoProduction.subject" size="27"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">To </td>
                                <td><s:textfield id="internalMemoProduction.im_To" name="internalMemoProduction.im_To" size="27"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Attn </td>
                                <td><s:textfield id="internalMemoProduction.attention" name="internalMemoProduction.attention" size="27"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Valve Type * </B> </td>
                                <td colspan="2">
                                    <script type = "text/javascript">

                                            $('#internalMemoProduction_btnValveType').click(function(ev) {
                                                window.open("./pages/search/search-valve-type.jsp?iddoc=internalMemoProduction&idsubdoc=valveType","Search", "width=600, height=500");
                                            });     

                                            txtInternalMemoProductionValveTypeCode.change(function(ev) {
                                            if(txtInternalMemoProductionValveTypeCode.val()===""){
                                                txtInternalMemoProductionValveTypeCode.val("");
                                                txtInternalMemoProductionValveTypeName.val("");
                                                return;
                                            }

                                            var url = "master/valve-type-get";
                                            var params = "valveType.code=" + txtInternalMemoProductionValveTypeCode.val();
                                                params += "&valveType.activeStatus="+true;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.valveTypeTemp){
                                                    txtInternalMemoProductionValveTypeCode.val(data.valveTypeTemp.code);
                                                    txtInternalMemoProductionValveTypeName.val(data.valveTypeTemp.name);
                                                }else{ 
                                                    alertMessage("Valve Type Not Found!",txtInternalMemoProductionValveTypeCode);
                                                    txtInternalMemoProductionValveTypeCode.val("");
                                                    txtInternalMemoProductionValveTypeName.val("");
                                                }
                                            });
                                        });

                                    </script>
                                        <div class="searchbox ui-widget-header">
                                        <s:textfield id="internalMemoProduction.valveType.code" name="internalMemoProduction.valveType.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                                            <sj:a id="internalMemoProduction_btnValveType" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                    <s:textfield id="internalMemoProduction.valveType.name" name="internalMemoProduction.valveType.name" size="30" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                      </table>
                    </td>
                     <td>
                        <table>
                            <tr>
                                <td align="right"><B>Customer *</B></td>
                                <td>
                                    <script type = "text/javascript"> 
                                        
                                            $('#internalMemoProduction_btnCustomer').click(function(ev) {
                                                window.open("./pages/search/search-customer.jsp?iddoc=internalMemoProduction&idsubdoc=customer","Search", "width=600, height=500");
                                            });
    
                                            txtInternalMemoProductionCustomerCode.change(function(ev) {
                                            if(txtInternalMemoProductionCustomerCode.val()===""){
                                                txtInternalMemoProductionCustomerCode.val("");
                                                txtInternalMemoProductionCustomerName.val("");
                                                return;
                                            }
                                            var url = "master/customer-get";
                                            var params = "customer.code=" + txtInternalMemoProductionCustomerCode.val();
                                            params += "&customer.activeStatus=TRUE";
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.customerTemp){
                                                    txtInternalMemoProductionCustomerCode.val(data.customerTemp.code);
                                                    txtInternalMemoProductionCustomerName.val(data.customerTemp.name);
                                                }else{
                                                    alertMessage("Customer Not Found!",txtInternalMemoProductionCustomerCode);
                                                    txtInternalMemoProductionCustomerCode.val("");
                                                    txtInternalMemoProductionCustomerName.val("");
                                                }
                                            });
                                        });
                                    </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="internalMemoProduction.customer.code" name="internalMemoProduction.customer.code" size="22"></s:textfield>
                                        <sj:a id="internalMemoProduction_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                        <s:textfield id="internalMemoProduction.customer.name" name="internalMemoProduction.customer.name" size="40" readonly="true" ></s:textfield> 
                                </td>
                            </tr>   
                            <tr>
                                <td align="right" style="width:120px"><B>Sales Person *</B></td>
                                <td colspan="2">
                                <script type = "text/javascript">

                                    $('#internalMemoProduction_btnSalesPerson').click(function(ev) {
                                         window.open("./pages/search/search-sales-person.jsp?iddoc=internalMemoProduction&idsubdoc=salesPerson","Search", "width=600, height=500");
                                    });
                                    txtInternalMemoProductionSalesPersonCode.change(function(ev) {

                                        if(txtInternalMemoProductionSalesPersonCode.val()===""){
                                            txtInternalMemoProductionSalesPersonCode.val("");
                                            txtInternalMemoProductionSalesPersonName.val("");
                                            return;
                                        }
                                        var url = "master/sales-person-get";
                                        var params = "salesPerson.code=" + txtInternalMemoProductionSalesPersonCode.val();
                                            params += "&salesPerson.activeStatus=TRUE";

                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.salesPersonTemp){
                                                txtInternalMemoProductionSalesPersonCode.val(data.salesPersonTemp.code);
                                                txtInternalMemoProductionSalesPersonName.val(data.salesPersonTemp.name);
                                            }
                                            else{
                                                alertMessage("Sales Person Not Found!",txtInternalMemoProductionSalesPersonCode);
                                                txtInternalMemoProductionSalesPersonCode.val("");
                                                txtInternalMemoProductionSalesPersonName.val("");
                                            }
                                        });
                                    });
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="internalMemoProduction.salesPerson.code" name="internalMemoProduction.salesPerson.code" size="22"></s:textfield>
                                    <sj:a id="internalMemoProduction_btnSalesPerson" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="internalMemoProduction.salesPerson.name" name="internalMemoProduction.salesPerson.name" size="40" readonly="true"></s:textfield>
                            </tr>
                            
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="internalMemoProduction.refNo" name="internalMemoProduction.refNo" size="27"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td><s:textarea id="internalMemoProduction.remark" name="internalMemoProduction.remark"  cols="50" rows="2" height="20"></s:textarea></td>                  
                            </tr> 
                            <tr hidden="true">
                                <td/>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProduction.createdBy"  name="internalMemoProduction.createdBy" size="20"></s:textfield>
                                    <sj:datepicker id="internalMemoProduction.createdDate" name="internalMemoProduction.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr hidden="true">
                                <td>
                                    <s:textfield id="internalMemoProductionTemp.createdDateTemp" name="internalMemoProduction.createdDateTemp" size="22"></s:textfield>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </s:form>
    <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmInternalMemoProduction" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmInternalMemoProduction" button="true">Unconfirm</sj:a>
                </td>
            </tr>
    </table>
    <table id="btn-for-detail">
            <tr>
                <td>
                    <sj:a href="#" id="btnIMSearchItemFinishGoods" button="true" style="width: 200px">Search Finish Goods</sj:a>
                </td>
                <td width="82"/>
                <td>
                    <sj:a href="#" id="btnInternalMemoProductionDetailSort" button="true" style="width: 70px">Sort No</sj:a>
                </td>
            </tr>
    </table>
    
    <div id="internalMemoProductionDetailInputGrid">
            <sjg:grid
                id="internalMemoProductionDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listInternalMemoProductionDetail"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuInternalMemoProductionDetail').width()"
                editurl="%{remoteurlInternalMemoProductionDetailInput}"
                onSelectRowTopics="internalMemoProductionDetailInput_grid_onSelect"
                >
                <sjg:gridColumn
                    name="internalMemoProductionDetail" index="internalMemoProductionDetail" key="internalMemoProductionDetail" title=""
                    width="200" sortable="true" editable="true" edittype="text" hidden="true"
                /> 
                <sjg:gridColumn
                    name="internalMemoProductionDetailDelete" index="internalMemoProductionDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'internalMemoProductionDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />    
                <sjg:gridColumn
                    name="internalMemoProductionDetailItemFinishGoodsCode" index="internalMemoProductionDetailItemFinishGoodsCode" key="internalMemoProductionDetailItemFinishGoodsCode" 
                    title="IFG Code" width="200" sortable="true" editable="false"
                />     
                <sjg:gridColumn
                    name="internalMemoProductionDetailSortNo" index="internalMemoProductionDetailSortNo" 
                    title="Sort No" width="80" sortable="true" editable="true" edittype="text" formatter="integer"
                    editoptions="{onKeyUp:'avoidSpcCharIMP()'}"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailItemFinishGoodsRemark" index="internalMemoProductionDetailItemFinishGoodsRemark" key="internalMemoProductionDetailItemFinishGoodsRemark" 
                    title="IFG Remark" width="200" sortable="true" editable="false"
                />     
                <sjg:gridColumn
                    name="internalMemoProductionDetailValveTag" index="internalMemoProductionDetailValveTag" key="internalMemoProductionDetailValveTag" 
                    title="Valve Tag" width="150" sortable="true" editable="true" edittype="text"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailDataSheet" index="internalMemoProductionDetailDataSheet" key="internalMemoProductionDetailDataSheet" 
                    title="Data Sheet" width="150" sortable="true" editable="true" edittype="text"
                /> 
                <sjg:gridColumn
                    name="internalMemoProductionDetailDescription" index="internalMemoProductionDetailDescription" key="internalMemoProductionDetailDescription" 
                    title="Description" width="150" sortable="true" editable="true" edittype="text"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailTypeDesign" index="internalMemoProductionDetailTypeDesign" key="internalMemoProductionDetailTypeDesign" 
                    title="Type Design" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailSize" index="internalMemoProductionDetailSize" key="internalMemoProductionDetailSize" 
                    title="Size" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailRating" index="internalMemoProductionDetailRating" key="internalMemoProductionDetailRating" 
                    title="Rating" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailBore" index="internalMemoProductionDetailBore" key="internalMemoProductionDetailBore" 
                    title="Bore" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailEndCon" index="internalMemoProductionDetailEndCon" key="internalMemoProductionDetailEndCon" 
                    title="End Con" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailBody" index="internalMemoProductionDetailBody" key="internalMemoProductionDetailBody" 
                    title="Body" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailStem" index="internalMemoProductionDetailStem" key="internalMemoProductionDetailStem" 
                    title="Stem" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailSeal" index="internalMemoProductionDetailSeal" key="internalMemoProductionDetailSeal" 
                    title="Seal" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailSeat" index="internalMemoProductionDetailSeat" key="internalMemoProductionDetailSeat" 
                    title="Seat" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailSeatInsert" index="internalMemoProductionDetailSeatInsert" key="internalMemoProductionDetailSeatInsert" 
                    title="Seat Insert" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailBolting" index="internalMemoProductionDetailBolting" key="internalMemoProductionDetailBolting" 
                    title="Bolt" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailSeatDesign" index="internalMemoProductionDetailSeatDesign" key="internalMemoProductionDetailSeatDesign" 
                    title="Seat Design" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailOperator" index="internalMemoProductionDetailOperator" key="internalMemoProductionDetailOperator" 
                    title="Operator" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailNote" index="internalMemoProductionDetailNote" key="internalMemoProductionDetailNote" 
                    title="Note" width="150" sortable="true" editable="false" hidden="true"
                />
                <sjg:gridColumn
                    name="internalMemoProductionDetailQuantity" index="internalMemoProductionDetailQuantity" key="internalMemoProductionDetailQuantity" title="Quantity" 
                    width="100" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }"
                />
            </sjg:grid >
        </div>
    </div>
        <table width="100%">
            <tr>
                <td width="20%" valign="top">
                    <table  width="100%">
                        <tr>
                            <td>
                                <sj:a href="#" id="btnInternalMemoProductionSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btnInternalMemoProductionCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
        </table>
                            
       
      